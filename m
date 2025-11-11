Return-Path: <linux-kernel+bounces-894503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3F8C4B2EA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 03:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9FF0B4E10A9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 02:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C64346A1A;
	Tue, 11 Nov 2025 02:15:58 +0000 (UTC)
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC56157480
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 02:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762827358; cv=none; b=jgSpg7woY8A7Vd89oNijhkVn6tlT0TxRJDT0+3yejfLsxisOVAewcpQQKa/X64S+EckxXOhA3SFawC+u3vR/549+fia+c2YYLjOnuOwTxNhs8ZFYMqSM/PSgveCu2fNa7XZufCptDCrDoxDNPp0OTkGAklX/m9fYMHAqyYAGJD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762827358; c=relaxed/simple;
	bh=RkxtuZOdpozMzVOV3VH4K2+zA3GaMGI7DeLYv83NpkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cYVHVCOi8OWmthRLy6NQuwf62WGvX+g/15OULLnyMnCiv0n/yVZzOYpROW+FfkX4ZpT7581XLligndHo8dYB27fp/Ac1wrET4jrqcNLwKb4UKyeO6DMbMkaXSNW9mCjyGd/m5gQVUz3DcepeSRxzP7LJ5O21ikgyOZt8QtYWCzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from DESKTOP-L0HPE2S (unknown [124.16.141.245])
	by APP-05 (Coremail) with SMTP id zQCowABHTW5OnBJpAlZOAA--.22027S2;
	Tue, 11 Nov 2025 10:15:43 +0800 (CST)
From: Haotian Zhang <vulab@iscas.ac.cn>
To: Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Haotian Zhang <vulab@iscas.ac.cn>
Subject: [PATCH v2] debug: Fix a mixed use of NULL and error pointers
Date: Tue, 11 Nov 2025 10:15:21 +0800
Message-ID: <20251111021521.1906-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20251110075746.1680-1-vulab@iscas.ac.cn>
References: <20251110075746.1680-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABHTW5OnBJpAlZOAA--.22027S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXr18Wry5WFWUZrWDXFWfGrg_yoW5AF1xpw
	1SgasFy3yrtr1fXr4kAa1kCw13Gas3urnrCF9Y93sFyrZ8ZF43KF1rtryq9F1DurWxZFyU
	AryjkF93ur4UAaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvm14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r126r1DMxkIecxEwVAFwVW8JwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
	W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
	1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
	IIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
	x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnU
	UI43ZEXa7VUjAwIDUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBg0DA2kSgPV18QAAsB

The lookup_object_or_alloc() function currently returns either error
pointers (ERR_PTR(-ENOENT)) or NULL on allocation failure. Mixing error
pointers and NULL is confusing and makes the code harder to maintain.
Change lookup_object_or_alloc() to consistently return error pointers
for all error cases by returning ERR_PTR(-ENOMEM) instead of NULL when
allocation fails.

Update all three call sites (__debug_object_init, debug_object_activate,
and debug_object_assert_init) to use IS_ERR() for error checking and
handle -ENOMEM by calling debug_objects_oom().

Fixes: 63a759694eed ("debugobject: Prevent init race with static objects")
Suggested-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
---
Changes in v2:
  -Make error handling consistent across all call sites as suggested
   by Kuan-Wei Chiu
---
 lib/debugobjects.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 7f50c4480a4e..d2d1979e2d12 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -691,7 +691,7 @@ static struct debug_obj *lookup_object_or_alloc(void *addr, struct debug_bucket
 
 	/* Out of memory. Do the cleanup outside of the locked region */
 	debug_objects_enabled = false;
-	return NULL;
+	return ERR_PTR(-ENOMEM);
 }
 
 static void debug_objects_fill_pool(void)
@@ -741,9 +741,10 @@ __debug_object_init(void *addr, const struct debug_obj_descr *descr, int onstack
 	raw_spin_lock_irqsave(&db->lock, flags);
 
 	obj = lookup_object_or_alloc(addr, db, descr, onstack, false);
-	if (unlikely(!obj)) {
+	if (IS_ERR(obj)) {
 		raw_spin_unlock_irqrestore(&db->lock, flags);
-		debug_objects_oom();
+		if (PTR_ERR(obj) == -ENOMEM)
+			debug_objects_oom();
 		return;
 	}
 
@@ -818,11 +819,13 @@ int debug_object_activate(void *addr, const struct debug_obj_descr *descr)
 	raw_spin_lock_irqsave(&db->lock, flags);
 
 	obj = lookup_object_or_alloc(addr, db, descr, false, true);
-	if (unlikely(!obj)) {
-		raw_spin_unlock_irqrestore(&db->lock, flags);
-		debug_objects_oom();
-		return 0;
-	} else if (likely(!IS_ERR(obj))) {
+	if (IS_ERR(obj)) {
+		if (PTR_ERR(obj) == -ENOMEM) {
+			raw_spin_unlock_irqrestore(&db->lock, flags);
+			debug_objects_oom();
+			return 0;
+		}
+	} else {
 		switch (obj->state) {
 		case ODEBUG_STATE_ACTIVE:
 		case ODEBUG_STATE_DESTROYED:
@@ -1007,11 +1010,11 @@ void debug_object_assert_init(void *addr, const struct debug_obj_descr *descr)
 	raw_spin_lock_irqsave(&db->lock, flags);
 	obj = lookup_object_or_alloc(addr, db, descr, false, true);
 	raw_spin_unlock_irqrestore(&db->lock, flags);
-	if (likely(!IS_ERR_OR_NULL(obj)))
+	if (!IS_ERR(obj))
 		return;
 
 	/* If NULL the allocation has hit OOM */
-	if (!obj) {
+	if (PTR_ERR(obj) == -ENOMEM) {
 		debug_objects_oom();
 		return;
 	}
-- 
2.50.1.windows.1


