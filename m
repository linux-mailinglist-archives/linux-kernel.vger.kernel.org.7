Return-Path: <linux-kernel+bounces-837339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 695B6BAC130
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 10:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 890B63BFB11
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 08:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F862475CD;
	Tue, 30 Sep 2025 08:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="mrLA/ulE"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C5D2BB17
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 08:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759221346; cv=none; b=ZzwfavKphFFqc73U5s4KtHBOWQxPTgBl7Gaemqw2/FmDWOrd3wOD4g28hFl+fOPftVMd2K6B73IbG+PygsGG0Qq+y9Ri8ZrYONntNVWNPKQc/2LeIrEtDpIHUPvCKXStg24Qw7Lkf2xwq7IDpY3YJfM0cnXWVzS0F7d4/cJAWRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759221346; c=relaxed/simple;
	bh=+8pnnO5kaPmCOeVlOVtFTXcokzPuz0+ArvDwcrkXUaI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n6k9d78PTv3gavO0jo3PxZnhMs4bE5ZzE3EOBsjNarBPBaDuBhCEEzBrvYUZfYJuP2UcVt5BJpMg0tMpw3rwJqd9yRlrW4yHf7mOAKtdk2UvMaMk20RREJUCk4s+eTwyYRmPhCEYUCXijWWFsOSQYOPOJz+0gBTstimAsTndV3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=mrLA/ulE; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=oJ
	NprfTnzFv5j3p9LJM1lYVBmez2CLiJJObfY5Wzdn8=; b=mrLA/ulEE/SybplfoZ
	V2zyco/irOXroNPBHhvIRLEV8CIpqPOkAdN6fZs/FoLTDknPXdjPjRh7qb5xhFb8
	GKZbc9gwWaClSMpafBhxB2Tc72NvFtHKYk+8nm+ODmuVGsYYJmh74oQPbNJvNU3P
	kA+BHDcVnuD9Ulfr3n25ueUr4=
Received: from ubuntu24-z.. (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3fz78ldtoiyG8BA--.62130S2;
	Tue, 30 Sep 2025 16:34:05 +0800 (CST)
From: ranxiaokai627@163.com
To: vbabka@suse.cz,
	akpm@linux-foundation.org,
	cl@gentwo.org,
	rientjes@google.com,
	roman.gushchin@linux.dev,
	harry.yoo@oracle.com,
	ast@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ran.xiaokai@zte.com.cn,
	ranxiaokai627@163.com
Subject: [PATCH] slab: Fix using this_cpu_ptr() in preemptible context
Date: Tue, 30 Sep 2025 08:34:02 +0000
Message-ID: <20250930083402.782927-1-ranxiaokai627@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3fz78ldtoiyG8BA--.62130S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZryDZrWDurW5Wr13GFWrAFb_yoW5Jry3pF
	Z0g34DJrs5Jr1qyw45tr4Igr15uay5W3y8GryIgw1SqFs0vwnrJasrAFy7WF15uFy8Ja1U
	CF4vga4Yqw48WaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRHv3UUUUUU=
X-CM-SenderInfo: xudq5x5drntxqwsxqiywtou0bp/xtbBEgHYTGjbks5yFAAAsO

From: Ran Xiaokai <ran.xiaokai@zte.com.cn>

defer_free() maybe called in preemptible context, this will
trigger the below warning message:

BUG: using smp_processor_id() in preemptible [00000000] code: swapper/0/1
caller is defer_free+0x1b/0x60
Call Trace:
 <TASK>
 dump_stack_lvl+0xac/0xc0
 check_preemption_disabled+0xbe/0xe0
 defer_free+0x1b/0x60
 kfree_nolock+0x1eb/0x2b0
 alloc_slab_obj_exts+0x356/0x390
 __alloc_tagging_slab_alloc_hook+0xa0/0x300
 __kmalloc_cache_noprof+0x1c4/0x5c0
 __set_page_owner+0x10d/0x1c0
 post_alloc_hook+0x84/0xf0
 get_page_from_freelist+0x73b/0x1380
 __alloc_frozen_pages_noprof+0x110/0x2c0
 alloc_pages_mpol+0x44/0x140
 alloc_slab_page+0xac/0x150
 allocate_slab+0x78/0x3a0
 ___slab_alloc+0x76b/0xed0
 __slab_alloc.constprop.0+0x5a/0xb0
 __kmalloc_noprof+0x3dc/0x6d0
 __list_lru_init+0x6c/0x210
 alloc_super+0x3b6/0x470
 sget_fc+0x5f/0x3a0
 get_tree_nodev+0x27/0x90
 vfs_get_tree+0x26/0xc0
 vfs_kern_mount.part.0+0xb6/0x140
 kern_mount+0x24/0x40
 init_pipe_fs+0x4f/0x70
 do_one_initcall+0x62/0x2e0
 kernel_init_freeable+0x25b/0x4b0
 kernel_init+0x1a/0x1c0
 ret_from_fork+0x290/0x2e0
 ret_from_fork_asm+0x11/0x20
</TASK>

Replace this_cpu_ptr with raw_cpu_ptr to eliminate
the above warning message.

Fixes: af92793e52c3 ("slab: Introduce kmalloc_nolock() and kfree_nolock().")
Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
---
 mm/slub.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 1433f5b988f7..67c57f1b5a86 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -6432,7 +6432,7 @@ static void free_deferred_objects(struct irq_work *work)
 
 static void defer_free(struct kmem_cache *s, void *head)
 {
-	struct defer_free *df = this_cpu_ptr(&defer_free_objects);
+	struct defer_free *df = raw_cpu_ptr(&defer_free_objects);
 
 	if (llist_add(head + s->offset, &df->objects))
 		irq_work_queue(&df->work);
@@ -6440,7 +6440,7 @@ static void defer_free(struct kmem_cache *s, void *head)
 
 static void defer_deactivate_slab(struct slab *slab, void *flush_freelist)
 {
-	struct defer_free *df = this_cpu_ptr(&defer_free_objects);
+	struct defer_free *df = raw_cpu_ptr(&defer_free_objects);
 
 	slab->flush_freelist = flush_freelist;
 	if (llist_add(&slab->llnode, &df->slabs))
-- 
2.25.1



