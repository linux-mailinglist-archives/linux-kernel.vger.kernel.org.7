Return-Path: <linux-kernel+bounces-876842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 667E0C1C9FD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 18:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC7FE5640AE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5993546E4;
	Wed, 29 Oct 2025 17:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j5I4vKiJ"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F4F34AAE6
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 17:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761759556; cv=none; b=C7/uQhG1C+ToqIgwqpPwEoz1gM3YulJLCjA8hH1S+JhMB3BnRc3TIKwsDmc0EIzr7dI6hcoI5eyFW2wv7zB8o/vy9SQ3yGZnYsG3ujVLqV5v5lbi2zEuDVEIJDDwf7IyH8qA/F7GiCQ5iyZQjDBL0rgB5to8LcRxwX4oXJI0peI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761759556; c=relaxed/simple;
	bh=cQl71qffH3WUbJRBqLb0nb69Fm4fjMjSzTiZ2s9JKw4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZBkbhEPewMe8nMDPwvX+k3EoELZdndsBkDeA4Fuv2ryOQcrYgLPVBX29wk1xObL8H5Pxr0TFe/e6O50Ps2DhKcNOZj9NBGoJpocjaoh8f7hzAsPdL+EPbSQhMxkHxC9rCzFha5og6m12ltNu8xCSNaVmgE5tEqYjMi9dAmlXxp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j5I4vKiJ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47112edf9f7so999995e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 10:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761759553; x=1762364353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n/XyCqatU7V7E7NAoshQP6Q8+BckwRbuX9ihiuE51L8=;
        b=j5I4vKiJ5Pt3kUXJTK/rwztyfYz13BEC0GsMQULRmiSULMREzi1BL3/m6lQoRsPEuz
         6ULbkfyk/Qc97R5ai+HEal7mQXnDi3pi7HsxG7j+QxQjbiiLsfoJuOaIs4TJTJCumvDF
         lJBPiY7e7hx4XmqKJgP9UBLiS3QxSudEHymIA8GCAP4WWySlffBgz4yeTi2haeYKwLg1
         aVOpK/xiYR7CHZvregy2Ip0KzRm9PKyotv1wv87FWXdr2KFzRk+SZF2Vn5iqv6VlcXid
         DbQTKQvlNwzloQcXkIkzAjfcwTxutWhzEm5Y0YOi6NHkDFWXgt3Oz/kGlNd07/RLH01A
         tSIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761759553; x=1762364353;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n/XyCqatU7V7E7NAoshQP6Q8+BckwRbuX9ihiuE51L8=;
        b=NkWgNjd0VkcfIDTL5aP3yFIGIszDMw2wcozfJtfnaSxwYzTLp2v5hU1joQ37vqPePR
         JF11vbgCJhJDk5eiRza6Apq2H0ExLfeVdRxLfJghwOtC5YYq438s5BrlepYW6koDhnV0
         frQ8uplfoYQgy4u6zNJUpvIpt2BaefXyWOVbn2zrsmakYrPUG8cBNPOtOabFQZjHl4hB
         mKP1pnfNaqdmUtBdhhunWcGTCTXySLHx/UO6UW2baIKLnyZVMVgpJfYeZ1VnNp4xpWxA
         wT2yjkzMnZfRATO9E9vTGdbYamwT4URLmPzaruSpshgioVrzh5nNGGrq56tPOoMSH+KP
         LeKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfzVjNq8ewvKJk85Ngft9yra+th/lEZQ90qULBTZISNVPTOSxiJonpKCovXRuICOSklbHW6pNxeK2usvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzNBG0GzdaCZnKaiPQVEnDn5C/O9pPUiRRV/5bi10279JzkGUG
	yVKIvWfUHQClXbovISyBLEkLsKu4ZGJ2yOE6811b1W1lH/N3tFiACqyp
X-Gm-Gg: ASbGncsKF3toJKeD6NgpAtjOAA0lnUpJQijKEcahA6noo1HKRyifIaSPwSnIboQe1zi
	i/yLzjJIbx7Z2syNZFT+STZ4gme9WKR/ljWFiY853Y2QBp3gCUCO26b1C/Ma4r8Dd9qKphLd/QH
	NOjKK2NQRckDbosiVkeba+5h+fJHd9/TWWIywsEluBLamgJWj6byGN2+WEDnP3AZUruytTnWbzQ
	wWj6dJP8b1bKGIz1jt5gPdoeq6UR8f/W2tCWe2Vmtzzv8HuTryYR4zTdBquWIH7IwoQvQidkcMD
	2RDUFDEFskbYw9tOVZKi66RvDPm6tmglYREVaTewC/9Fth8n+uhcwmHfRb1BmGoG9sR7Ajj6ya9
	EA/ehHC6grii+lAr8ffq6lLzFMwiwVP+lYqnyeHfQG8pQ4seAXdhCLMfSn+CGO6iIVdM4TcH5ak
	ARNs3b6bJPAGsteRDkCXE1PvVe+Fm0lywWyLSv1aEeewXpeDroo6+5z3K9xCKuHS67fE20Lfs=
X-Google-Smtp-Source: AGHT+IEQoOAEFkH34I6wMcM3eXgFLnNlsX3L/0+xSNfM28WZt0VeSPbjrY+6DPLJbWfrwyaB3xE9dQ==
X-Received: by 2002:a05:600c:3f0a:b0:46f:b43a:aee1 with SMTP id 5b1f17b1804b1-4771e1f3e5dmr30872105e9.38.1761759552620;
        Wed, 29 Oct 2025 10:39:12 -0700 (PDT)
Received: from snowdrop.snailnet.com (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771e235ae1sm70646865e9.17.2025.10.29.10.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 10:39:12 -0700 (PDT)
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
	Yu Kuai <yukuai3@huawei.com>,
	Khazhismel Kumykov <khazhy@chromium.org>,
	Jens Axboe <axboe@kernel.dk>,
	x86@kernel.org
Subject: [PATCH v4 next 0/9] Implement mul_u64_u64_div_u64_roundup()
Date: Wed, 29 Oct 2025 17:38:19 +0000
Message-Id: <20251029173828.3682-1-david.laight.linux@gmail.com>
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
 lib/math/div64.c                    | 183 ++++++++++++++++++---------
 lib/math/test_mul_u64_u64_div_u64.c | 190 ++++++++++++++++++++--------
 4 files changed, 352 insertions(+), 119 deletions(-)

-- 
2.39.5


