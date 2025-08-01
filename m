Return-Path: <linux-kernel+bounces-753314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8802DB18171
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 14:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A86D9177CAE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 12:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CAE522D78F;
	Fri,  1 Aug 2025 12:02:42 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999DE80B
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 12:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754049762; cv=none; b=lUUPv3rw6iA6BQOaI47yZjiGPuRRZXIujPSVj9ZwuGkQfpGggiDudFI4OhmSeUD6R4j8kfFqxHHC/QyVWOsVXqNiecPPoPeJfGacewlFx6OJnv7KIHyBwu7syYzY3gk35WeXBCSMeLiD6HzPb8+OgDLRlFBqsW6w95uFMudspgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754049762; c=relaxed/simple;
	bh=ZOH5WjKRJ5tUTyd3dy8PGVJZdah/OUl6IABtUIOhEO8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VNHWztx1+sW7H47fzF6265ARKsUGBVktrVs8BymwhvfHrE162ZMI8lJQcuIP576cS5zB26DKOGC5t4WtK+THCmHP3IKW/ZRknFn5vGKpL5Q04LQDjvPgDGX+Am98vbPNxCBYw0RA0S7tkxPqYnvEo/jHJQK9l/UFGTB0bVppueg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E5FAB1516;
	Fri,  1 Aug 2025 05:02:31 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4CEF43F673;
	Fri,  1 Aug 2025 05:02:38 -0700 (PDT)
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: thomas.weissschuh@linutronix.de,
	ryabinin.a.a@gmail.com,
	glider@google.com,
	andreyknvl@gmail.com,
	dvyukov@google.com,
	vincenzo.frascino@arm.com,
	akpm@linux-foundation.org
Cc: kasan-dev@googlegroups.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH v3] kunit: kasan_test: disable fortify string checker on kasan_strings() test
Date: Fri,  1 Aug 2025 13:02:36 +0100
Message-Id: <20250801120236.2962642-1-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to commit 09c6304e38e4 ("kasan: test: fix compatibility with
FORTIFY_SOURCE") the kernel is panicing in kasan_string().

This is due to the `src` and `ptr` not being hidden from the optimizer
which would disable the runtime fortify string checker.

Call trace:
  __fortify_panic+0x10/0x20 (P)
  kasan_strings+0x980/0x9b0
  kunit_try_run_case+0x68/0x190
  kunit_generic_run_threadfn_adapter+0x34/0x68
  kthread+0x1c4/0x228
  ret_from_fork+0x10/0x20
 Code: d503233f a9bf7bfd 910003fd 9424b243 (d4210000)
 ---[ end trace 0000000000000000 ]---
 note: kunit_try_catch[128] exited with irqs disabled
 note: kunit_try_catch[128] exited with preempt_count 1
     # kasan_strings: try faulted: last
** replaying previous printk message **
     # kasan_strings: try faulted: last line seen mm/kasan/kasan_test_c.c:1600
     # kasan_strings: internal error occurred preventing test case from running: -4

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
Patch History
=============
from v2 to v3:
  - rewrite commit message.
  - Using OPTIMIZER_HIDE_VAR() instead of __NO_FORTIFY
  - https://lore.kernel.org/all/20250801092805.2602490-1-yeoreum.yun@arm.com/

from v1 to v2:
  - Using __NO_FORTIFY instead of skipping kasan_strings() when
    CONFIG_FORTIFY_SOURCE is enabled.
  - https://lore.kernel.org/all/aIs4rwZ1o53iTuP%2F@e129823.arm.com/
---
 mm/kasan/kasan_test_c.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/kasan/kasan_test_c.c b/mm/kasan/kasan_test_c.c
index 5f922dd38ffa..a1a0e60645da 100644
--- a/mm/kasan/kasan_test_c.c
+++ b/mm/kasan/kasan_test_c.c
@@ -1578,9 +1578,11 @@ static void kasan_strings(struct kunit *test)

 	ptr = kmalloc(size, GFP_KERNEL | __GFP_ZERO);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
+	OPTIMIZER_HIDE_VAR(ptr);

 	src = kmalloc(KASAN_GRANULE_SIZE, GFP_KERNEL | __GFP_ZERO);
 	strscpy(src, "f0cacc1a0000000", KASAN_GRANULE_SIZE);
+	OPTIMIZER_HIDE_VAR(src);

 	/*
 	 * Make sure that strscpy() does not trigger KASAN if it overreads into
--
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


