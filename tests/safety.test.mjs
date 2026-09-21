import { test, describe, before, after } from 'node:test';
import assert from 'node:assert/strict';
import fs from 'node:fs';
import path from 'node:path';
import os from 'node:os';
import { writeFileSafe, safeMergeJson, isManagedFile } from '../lib/safety.mjs';

describe('Safety & Non-Destructive File Operations', () => {
  let tempDir;

  before(() => {
    tempDir = fs.mkdtempSync(path.join(os.tmpdir(), 'safety-test-'));
  });

  after(() => {
    if (fs.existsSync(tempDir)) {
      fs.rmSync(tempDir, { recursive: true, force: true });
    }
  });

  test('does not overwrite user files without generator signature unless force is true', () => {
    const userFile = path.join(tempDir, 'user-custom-rule.md');
    fs.writeFileSync(userFile, 'My hand-written custom rule content', 'utf8');

    assert.equal(isManagedFile(userFile), false);

    // Attempt overwrite without force
    const res1 = writeFileSafe(userFile, 'New generated content', { force: false });
    assert.equal(res1.status, 'skipped_user_file');
    assert.equal(fs.readFileSync(userFile, 'utf8'), 'My hand-written custom rule content');

    // Attempt overwrite with force
    const res2 = writeFileSafe(userFile, 'New generated content', { force: true });
    assert.equal(res2.status, 'updated');
    assert.equal(fs.readFileSync(userFile, 'utf8'), 'New generated content');
  });

  test('safeMergeJson preserves custom user properties and merges arrays', () => {
    const jsonFile = path.join(tempDir, 'custom-config.json');
    const initialConfig = {
      model: 'custom-model-4',
      plugins: ['plugin-a'],
      instructions: ['custom-instruction.md']
    };
    fs.writeFileSync(jsonFile, JSON.stringify(initialConfig, null, 2), 'utf8');

    safeMergeJson(jsonFile, {
      instructions: ['AGENTS.md', 'custom-instruction.md'],
      newEngineProp: true
    });

    const updated = JSON.parse(fs.readFileSync(jsonFile, 'utf8'));
    assert.equal(updated.model, 'custom-model-4', 'Must preserve existing custom scalar properties');
    assert.deepEqual(updated.plugins, ['plugin-a'], 'Must preserve existing custom arrays');
    assert.ok(updated.instructions.includes('custom-instruction.md'), 'Must keep existing array item');
    assert.ok(updated.instructions.includes('AGENTS.md'), 'Must append new array item without duplicates');
    assert.equal(updated.instructions.filter(i => i === 'custom-instruction.md').length, 1, 'No duplicate array elements');
    assert.equal(updated.newEngineProp, true);
  });
});
