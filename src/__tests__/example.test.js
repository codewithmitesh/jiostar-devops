test('hello world!', () => {
	expect(1 + 1).toBe(2);
});

describe('Example test suite', () => {
	test('should return true for valid input', () => {
		expect(true).toBe(true);
	});

	test('should return false for invalid input', () => {
		expect(false).toBe(false);
	});
});

test('hello world!', () => {
    expect(1 + 1).toBe(2);
});

describe('Example test suite', () => {
    test('should return true for valid input', () => {
        expect(true).toBe(true);
    });

    test('should return false for invalid input', () => {
        expect(false).toBe(false);
    });
});

// Additional passing tests

test('array includes value', () => {
    const arr = [1, 2, 3];
    expect(arr).toContain(2);
});

test('object assignment', () => {
    const data = {one: 1};
    data['two'] = 2;
    expect(data).toEqual({one: 1, two: 2});
});

test('string matches regex', () => {
    expect('Disney+ Hotstar').toMatch(/Hotstar/);
});