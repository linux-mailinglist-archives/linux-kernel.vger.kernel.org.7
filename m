Return-Path: <linux-kernel+bounces-887238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6CCC37A44
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 21:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD69F3A6FA6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 20:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21D63451B8;
	Wed,  5 Nov 2025 20:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gH/oNSYW"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4A63002CA
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 20:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762373455; cv=none; b=Z3LAhS+c1wMoRHcKKLWlqbXCDPYCErnb6xVYduu83dcXr9+AT54y+pmA/kucE3NhyzTf/KS6ZBGA6YFeDnkqkvHXmc1e+mLKju1ICIppVDpypS4DPyUrf3Tqo+RQVliUTk/Rpa02IvOgy582TW/J5OQ/yK0BQ7fBJ3QzcUu5Mf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762373455; c=relaxed/simple;
	bh=Wg1ZUHRa6mQGArvDJyCDP1auvATMwZD1XTMQJ6KqkKQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lVgqQCR59+F7R4ZGQvszlFZ6ppTDjQe/mSiOi26dnJJ6hn3StlsbiOZPV2hZVfsWBL0u7hlq6sqLMJdWB8/RnjeCpskHhNGOZF5VykmmtfogAuIXWphD6jbiz0sTSJVmeeZF/eYdEU0Ac8nkUYtNIwUxpZETMJBgTFGjYtysKp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gH/oNSYW; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-429b7ba208eso161299f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 12:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762373451; x=1762978251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4tz3Sv9zd5oJDeAvYEeZCkh1OHGmd/TYYJGBnky/uG0=;
        b=gH/oNSYWp63G7gUggj2DHXBa+udE2Y3DCndpJqG6vnGXdUiec2gbHgbJV2DMKqrhrj
         ZgmcH57qYFGhNWX7H0TDaQnDCNBVnIfebDSgIWiUujC0b1+Y4SakludJKzSMDJFYD5pU
         H3m66+lvBzd3GUwnn12uHBiFXfhVGQV2owxqfYOLsFdZVWXaYdfNlN0JvcHrfEllJJGc
         Bp8rzRTj6ih6GsBMU4wBCxOA+Kd3tF/+WgGEL5GDuayyr/PaFt2KDNS+pWPWIgU8EIdy
         IHB4bSrdp+DLoBbk+CYzLRr5Y8AfwuFqiO3hAws9uGtf0dFZYibaUjMm8JKz2KOjFM79
         OTmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762373451; x=1762978251;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4tz3Sv9zd5oJDeAvYEeZCkh1OHGmd/TYYJGBnky/uG0=;
        b=HiqRkg4AAAI+nlmz23XFO7jP1bkmNTR1SAIzSE1Cxq8xyDVozXDme5/W+hX1kA5d/M
         tTzlBu+Mc6sBKOYcnjht9wI8hmK9Cltl6qhXznm+3HpyusRZkxCdQPO0gSqZO6JpzI46
         PsQr1S98E+TSDG36UhzSPNDoUoJl8uuWTwryBykz/0rkZBkfyo8Dc2j5qBfqYJC30GgY
         XoRN712pcey+JdxIIntpw6BwHB/vv5zZCYB7r3WSQEUPEwPhlk0EQRZWCGlpi6rhDWMA
         qRBKd/8pg1UCsz8OCqjbZO967M2U5ZZO4SR6NZZJuLywCMvbILWzL/AruCzs8KPxR2a8
         77NQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJTLgcd8F15UmeM4iR+qUGTqrEsNJiKe1LO9nvyhZsZnQl7haq/37XIFr8u4Pjro0CI8xrCiRxA7r0EoU=@vger.kernel.org
X-Gm-Message-State: AOJu0YysduTRd8S9Yc7cKJcaBIzQWp11cPE7ZdOf3gFgyT85l6oAfKH9
	h6S2UumJdcj/fHj+fO1VUDy8XqaQvCcoxLWBO6qEIOfDecZFvdvw4MFe
X-Gm-Gg: ASbGncthUqAE6NrUJyjEHhBxVFYryyLjC1oevoXX71/keYQC0BmD5vBUxEd7nUKB8kx
	ZzO+373nGjMVyJioLk3z3eEsIDcQd49P4NQYx4qIAd6XD7E8Z/vBwzI+6pG3PpzvKexxTnGwVwc
	YRChKy+bTNIKs9OXpiYhaF0rpI9wPJDKm/nYXNRQoXoIZzqFs9gwznsJvtxbQCkJIweDOCRcxZI
	L9ODS9sS4YwovdvJn7eOGSGqdzQH3uvmkFiVLcRTeUKNabPT3E3b3FQLYOeWuzfwMYQwsqJR6Zq
	DUlVw97lLLb7VjKOZkPG3HQL9I1BrkA6SDqbYJz0lYZ1BJM96vBuM4JWaIhay5VMpuhF1iIQG5o
	iRTE5utf2RewtYlaqHeJOU3N6vtj8hXVVwM8D/lcbAoF6Cw82jH8e5nHT3R/WpFtbxLc0UMcQce
	/ZeBMcpv6oGUgIfd14X2gWRqQ4IamAoY+jhQna0pPu4wgGg+OeB9QxfolONvhq8bER0JBEapxJ
X-Google-Smtp-Source: AGHT+IE9LZ9DFUoiJc1eTi0Ak9bLzCGWEP5cvCeYN09X3oJ6NShrVBseYC0yFckdmttLgwK5+VMG8A==
X-Received: by 2002:a05:6000:220e:b0:3ee:d165:2edd with SMTP id ffacd0b85a97d-429e32f4852mr3869957f8f.28.1762373451235;
        Wed, 05 Nov 2025 12:10:51 -0800 (PST)
Received: from snowdrop.snailnet.com (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb41102bsm619857f8f.17.2025.11.05.12.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 12:10:50 -0800 (PST)
From: David Laight <david.laight.linux@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Cc: David Laight <david.laight.linux@gmail.com>,
	u.kleine-koenig@baylibre.com,
	Nicolas Pitre <npitre@baylibre.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Li RongQing <lirongqing@baidu.com>,
	Khazhismel Kumykov <khazhy@chromium.org>,
	Jens Axboe <axboe@kernel.dk>,
	x86@kernel.org
Subject: [PATCH v5 next 0/9] Implement mul_u64_u64_div_u64_roundup()
Date: Wed,  5 Nov 2025 20:10:26 +0000
Message-Id: <20251105201035.64043-1-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pwm-stm32.c code wants a 'rounding up' version of mul_u64_u64_div_u64().
This can be done simply by adding 'divisor - 1' to the 128bit product.
Implement mul_u64_add_u64_div_u64(a, b, c, d) = (a * b + c)/d based on the
existing code.
Define mul_u64_u64_div_u64(a, b, d) as mul_u64_add_u64_div_u64(a, b, 0, d) and
mul_u64_u64_div_u64_roundup(a, b, d) as mul_u64_add_u64_div_u64(a, b, d-1, d).

Only x86-64 has an optimsed (asm) version of the function.
That is optimised to avoid the 'add c' when c is known to be zero.
In all other cases the extra code will be noise compared to the software
divide code.

The test module has been updated to test mul_u64_u64_div_u64_roundup() and
also enhanced it to verify the C division code on x86-64 and the 32bit
division code on 64bit.

Changes for v2:
- Rename the 'divisor' parameter from 'c' to 'd'.
- Add an extra patch to use BUG_ON() to trap zero divisors.
- Remove the last patch that ran the C code on x86-64
  (I've a plan to do that differently).

Changes for v3:
- Replace the BUG_ON() (or panic in the original version) for zero
  divisors with a WARN_ONCE() and return zero.
- Remove the 'pre-multiply' check for small products.
  Completely non-trivial on 32bit systems.
- Use mul_u32_u32() and the new add_u64_u32() to stop gcc generating
  pretty much pessimal code for x86 with lots of register spills.
- Replace the 'bit at a time' divide with one that generates 16 bits
  per iteration on 32bit systems and 32 bits per iteration on 64bit.
  Massively faster, the tests run in under 1/3 the time.

Changes for v4:
No significant code changes.
- Rebase on 6.18-rc2
- Don't change the behaviour for overflow (return ~0ull) or divide
  by zero (execute ~0ul/0).
- Merge patches 8 and 9 to avoid bisection issues.
- Fix build of 32bit test cases on non-x86.
- Fix shell script that verifies test cases.

Changes for v5:
- Fix x86-64 asm code to correctly add non-constant 'add' values.
- Fix build on 32bit x86.
- Check for small dividends before divide overflow.

I've left the x86-64 faulting on both overflow and divide by zero.
The patch to add an execption table entry to return ~0 for both
doesn't seem to have been merged.
If merged it would make sense for the C version to return ~0 for both.
Callers can check for a result of ~0 and then check the divisor if
they care about overflow (etc).
(A valid quotent of ~0 is pretty unlikely and marginal changes to the
input values are likely to generate a real overflow.)
The code that faulted on overflow was about to get invalid results
because one of the 64bit inputs would itself wrap very soon.

David Laight (9):
  lib: mul_u64_u64_div_u64() rename parameter 'c' to 'd'
  lib: mul_u64_u64_div_u64() Combine overflow and divide by zero checks
  lib: mul_u64_u64_div_u64() simplify check for a 64bit product
  lib: Add mul_u64_add_u64_div_u64() and mul_u64_u64_div_u64_roundup()
  lib: Add tests for mul_u64_u64_div_u64_roundup()
  lib: test_mul_u64_u64_div_u64: Test both generic and arch versions
  lib: mul_u64_u64_div_u64() optimise multiply on 32bit x86
  lib: mul_u64_u64_div_u64() Optimise the divide code
  lib: test_mul_u64_u64_div_u64: Test the 32bit code on 64bit

 arch/x86/include/asm/div64.h        |  39 ++++--
 include/linux/math64.h              |  59 ++++++++-
 lib/math/div64.c                    | 185 ++++++++++++++++++---------
 lib/math/test_mul_u64_u64_div_u64.c | 191 ++++++++++++++++++++--------
 4 files changed, 354 insertions(+), 120 deletions(-)

-- 
2.39.5


