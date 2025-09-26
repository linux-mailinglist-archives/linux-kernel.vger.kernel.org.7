Return-Path: <linux-kernel+bounces-833740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1EDBA2EA6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 10:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD0AA1BC722A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 08:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B397828B415;
	Fri, 26 Sep 2025 08:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Fyw9lcFo"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D31B26F292
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 08:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758874747; cv=none; b=KqsAKFKGYx9I0r6HLsSd5Up8C1WVY9uY37tPDLXNUsTbBkDBMZSr/OZxb1OUsU/B3X82KKkNn95GIOedTpPZNM6mhDt74RBWTcgn/3MJlNyjKWQZpeGyMfEoh24V8x0RKUtgElrN+fCJw1kkhdz3FIcSbzp1giWkrxYiucqyIS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758874747; c=relaxed/simple;
	bh=JMLqRj9UF65568szQDfne253/4E0k5kSdZh6CrrKw5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZfXdrmBE7hG26CeSL9f4YGKPJmj8jzNKmjjeywZDc7LdqxBzCG86HzotziDqPzzosDvTTbUQdZH3fiWDrjiuMS2br0X8J8cIxREuk3/lFYsICMylmrz73KYmnlpFBBaVt5VJkwwxWywOCUx7yPeL5+PZBQKeuQdWmGUB6SRfdlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Fyw9lcFo; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=eG
	+YgXbmxmL1fdc1WNA6B97Ki+iNg7J8UnqGI9peY8o=; b=Fyw9lcFoNn/oP5HWgt
	wZPn52GNOJeN2Zo9EYZ1zfO6jKHK+/YxWjfOo4XIwnKxzgsNkc5LSU9RYWalE+Nq
	BrgdT5zLXVWAMoAI1B5VMrtVPPITkuUIY/gWe8vNjpojDLrZBRrx4jZxntbwLKuL
	///UJ+PXoOzdEfa0Cbua/VSsY=
Received: from ubuntu24-z.. (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wDXrxOnSdZoMJvNAA--.138S2;
	Fri, 26 Sep 2025 16:07:05 +0800 (CST)
From: ranxiaokai627@163.com
To: vbabka@suse.cz,
	akpm@linux-foundation.org,
	cl@gentwo.org,
	rientjes@google.com,
	roman.gushchin@linux.dev,
	harry.yoo@oracle.com,
	usamaarif642@gmail.com,
	surenb@google.com,
	shakeel.butt@linux.dev,
	hannes@cmpxchg.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ran.xiaokai@zte.com.cn,
	ranxiaokai627@163.com
Subject: [PATCH linux-next] alloc_tag: Fix boot failure due to NULL pointer dereference
Date: Fri, 26 Sep 2025 08:06:59 +0000
Message-ID: <20250926080659.741991-1-ranxiaokai627@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXrxOnSdZoMJvNAA--.138S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uw15Wr15XFW5urWruFyxGrg_yoW8KrW5pF
	WfGr4DCFZ5Jw17Cr4Dtr1kWr1rXayIvFyrGayIqr18ZF4rtwnrXF1Dt3WF9FWDAFW3G3Wq
	yFn5AanIvw4UZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pin2-UUUUUU=
X-CM-SenderInfo: xudq5x5drntxqwsxqiywtou0bp/xtbBEgDUTGjWRrtgLQAAsE

From: Ran Xiaokai <ran.xiaokai@zte.com.cn>

There is a boot failure when both CONFIG_DEBUG_KMEMLEAK and
CONFIG_MEM_ALLOC_PROFILING are enabled.

BUG: kernel NULL pointer dereference, address: 0000000000000000
RIP: 0010:__alloc_tagging_slab_alloc_hook+0x181/0x2f0
Call Trace:
 kmem_cache_alloc_noprof+0x1c8/0x5c0
 __alloc_object+0x2f/0x290
 __create_object+0x22/0x80
 kmemleak_init+0x122/0x190
 mm_core_init+0xb6/0x160
 start_kernel+0x39f/0x920
 x86_64_start_reservations+0x18/0x30
 x86_64_start_kernel+0x104/0x120
 common_startup_64+0x12c/0x138

In kmemleak, mem_pool_alloc() directly calls kmem_cache_alloc_noprof(),
as a result, the alloc_tag structure associated with object_cache is not
defined neither initialized. So current->alloc_tag is NULL,
leading to a null pointer dereference.

Move the checks for SLAB_NO_OBJ_EXT, SLAB_NOLEAKTRACE, and
__GFP_NO_OBJ_EXT to the parent function __alloc_tagging_slab_alloc_hook()
to fix this.

Also this distinguishes the SLAB_NOLEAKTRACE case between the actual memory
allocation failures case, make CODETAG_FLAG_INACCURATE more accurate.

Fixes: b9e2f58ffb84 ("alloc_tag: mark inaccurate allocation counters in /proc/allocinfo output")
Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
---
 mm/slub.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 867a07260acf..09cbe580842c 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2197,15 +2197,6 @@ prepare_slab_obj_exts_hook(struct kmem_cache *s, gfp_t flags, void *p)
 {
 	struct slab *slab;
 
-	if (!p)
-		return NULL;
-
-	if (s->flags & (SLAB_NO_OBJ_EXT | SLAB_NOLEAKTRACE))
-		return NULL;
-
-	if (flags & __GFP_NO_OBJ_EXT)
-		return NULL;
-
 	slab = virt_to_slab(p);
 	if (!slab_obj_exts(slab) &&
 	    alloc_slab_obj_exts(slab, s, flags, false)) {
@@ -2223,6 +2214,15 @@ __alloc_tagging_slab_alloc_hook(struct kmem_cache *s, void *object, gfp_t flags)
 {
 	struct slabobj_ext *obj_exts;
 
+	if (!object)
+		return;
+
+	if (s->flags & (SLAB_NO_OBJ_EXT | SLAB_NOLEAKTRACE))
+		return;
+
+	if (flags & __GFP_NO_OBJ_EXT)
+		return;
+
 	obj_exts = prepare_slab_obj_exts_hook(s, flags, object);
 	/*
 	 * Currently obj_exts is used only for allocation profiling.
-- 
2.25.1


