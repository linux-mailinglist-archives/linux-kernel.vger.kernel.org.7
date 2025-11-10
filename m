Return-Path: <linux-kernel+bounces-892522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A6AD8C45465
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 08:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D284D4E837B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 07:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329CA2F12D4;
	Mon, 10 Nov 2025 07:58:04 +0000 (UTC)
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7A93F9FB
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 07:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762761483; cv=none; b=LjH4ZqbQ2Y2lNfC1hPNjv1wR26DkJuqO32xytq0LA8XDDaxpdtb+TQ++fJDllmINyYi4f0h0vIgAxPmPciF1LSVlDHKvmJsSpPH+V/X+dkdOXudNTxU6+EnRy/h7q6Jb4K6CwcB0c0JHqyM3CISQF7ec9t63s3s/TZO3ml1Wk+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762761483; c=relaxed/simple;
	bh=BIZi1ebaU0AyjJhULTC7n5R++5NV5jZTZ3241TQiLcE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BwU5thhoV+yL4DVJS2AlDX/9ZKw4VRjyPh5hTPfyV3Xm9dG8NRTd9txB8QFm29DYiJfX5vPemwCorN2rReet5JCGnF1JojFWXw0aogksqwl3VIvINTPU7MU0pUAm1oCKys4nWtS6nOjEdzUmWlFMBVWJMRtUaM3ZlXkPI1tork0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from DESKTOP-L0HPE2S (unknown [124.16.141.245])
	by APP-05 (Coremail) with SMTP id zQCowAAXHG0DmxFp04U1AA--.10577S2;
	Mon, 10 Nov 2025 15:57:55 +0800 (CST)
From: Haotian Zhang <vulab@iscas.ac.cn>
To: Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	Haotian Zhang <vulab@iscas.ac.cn>
Subject: [PATCH] debug: Fix a NULL vs IS_ERR() bug in __debug_object_init()
Date: Mon, 10 Nov 2025 15:57:46 +0800
Message-ID: <20251110075746.1680-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAXHG0DmxFp04U1AA--.10577S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jw1rJr4fGr1xtr48uw4kJFb_yoWkJrcEyF
	WFv3ZrXr4UZFyUGw42kw4xtr109ry3Jr1xZ39aqF1DW343JFyDZFWkX3Z3Ar1fWF45uF1U
	Grn8Zay3WryI9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb2AFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8CwCF
	04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
	18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vI
	r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr
	1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvE
	x4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUfpnQUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAYCA2kRjggzFgAAsQ

The lookup_object_or_alloc() returns error pointers on failure, but the
code only checks for NULL. This leads to dereferencing an invalid error
pointer and causes a kernel crash.

Use IS_ERR_OR_NULL() instead of a NULL check to properly handle both
error pointers and NULL returns.

Fixes: 63a759694eed ("debugobject: Prevent init race with static objects")
Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
---
 lib/debugobjects.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 7f50c4480a4e..9587ef619054 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -741,9 +741,10 @@ __debug_object_init(void *addr, const struct debug_obj_descr *descr, int onstack
 	raw_spin_lock_irqsave(&db->lock, flags);
 
 	obj = lookup_object_or_alloc(addr, db, descr, onstack, false);
-	if (unlikely(!obj)) {
+	if (IS_ERR_OR_NULL(obj)) {
 		raw_spin_unlock_irqrestore(&db->lock, flags);
-		debug_objects_oom();
+		if (!obj)
+			debug_objects_oom();
 		return;
 	}
 
-- 
2.50.1.windows.1


