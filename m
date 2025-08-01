Return-Path: <linux-kernel+bounces-752958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 334EAB17D09
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 08:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A7B13BF123
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 06:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB071E835B;
	Fri,  1 Aug 2025 06:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="aBFgvr4f"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2446F13DBA0
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 06:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754031133; cv=none; b=k0KvCe+/YVrsKbEUo8hCB5NCx2zxgtknsdiqh5hghN06PnlqzQBOiu2fwvVTOUGROsnyHYV/aiWQTgpjcHDW7CchD+YQlsH6VKoClKEHS59SZwWuYxN2zhgeZBRVjgBxzeOcvX/BH9JLHwNNuatdX6sbOX8zKHcpwn/D0qYSilE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754031133; c=relaxed/simple;
	bh=O16JmJn76vMFWliVd1jXQMuhLLYyzAc17nJ8QpnOqII=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VOhrwqvpdlrqQdQ8QjIYkNXvHAcI+D/ClvKZnlrSB29Qzm7bafgjyTJL7Zdh3nn3hiEl6DaByfFP9MhZDEvtncN6bzOKmCrawy97eP7K6fHb1YllO4spdyrmc6PetOK/w5I1xgLPu3u9fQZqv6nTi87RtztR7HwvN/ED1NdGu84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=aBFgvr4f; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=js
	/8QZDGKgtadLXZ3mlum2mHnTfG3CZHtOq4kKZ2v1A=; b=aBFgvr4fOy4rJTRTRy
	Abzl01VLmPxlgb3nqGr6DppvoCm5+5DSPwh4jdFQcgtPDeLVJnavZd9lVp/FVP++
	oBuXOVeee1pCezqbVmBAGy0djMgldCHfVLwNY9ijOqnvyx1+3QEFIjK8GCOzmnta
	9v1N97pWolZ0idUV6BJRkjAxg=
Received: from mi-work.mioffice.cn (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wBnM9DpY4xoi5QmJQ--.50286S4;
	Fri, 01 Aug 2025 14:51:24 +0800 (CST)
From: yangshiguang1011@163.com
To: vbabka@suse.cz
Cc: akpm@linux-foundation.org,
	cl@gentwo.org,
	rientjes@google.com,
	roman.gushchin@linux.dev,
	harry.yoo@oracle.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	yangshiguang <yangshiguang1011@163.com>
Subject: [PATCH] mm:slub:avoid wake up kswapd in set_track_prepare
Date: Fri,  1 Aug 2025 14:51:21 +0800
Message-ID: <20250801065121.876793-1-yangshiguang1011@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBnM9DpY4xoi5QmJQ--.50286S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7CrWkAry7GFyfAryUAr4DCFg_yoW8tF4rpa
	y7WryftFW8J34YvFWjkr1vkr1Du3ySg3y8GF4fJFyF9F17XrW0gFWDtFyvgayrAF1kua1D
	KryvvFZxWw45JaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U-6pLUUUUU=
X-CM-SenderInfo: 51dqw25klj3ttqjriiqr6rljoofrz/1tbiEAuc5WiMYJUB1wABsk

From: yangshiguang <yangshiguang1011@163.com>

set_track_prepare() can incur lock recursion.
The issue is that it is called from hrtimer_start_range_ns
holding the per_cpu(hrtimer_bases)[n].lock, but when enabled
CONFIG_DEBUG_OBJECTS_TIMERS, may wake up kswapd in set_track_prepare,
and try to hold the per_cpu(hrtimer_bases)[n].lock.

So avoid waking up kswapd.The oops looks something like:

BUG: spinlock recursion on CPU#3, swapper/3/0
 lock: 0xffffff8a4bf29c80, .magic: dead4ead, .owner: swapper/3/0, .owner_cpu: 3
Hardware name: Qualcomm Technologies, Inc. Popsicle based on SM8850 (DT)
Call trace:
spin_bug+0x0
_raw_spin_lock_irqsave+0x80
hrtimer_try_to_cancel+0x94
task_contending+0x10c
enqueue_dl_entity+0x2a4
dl_server_start+0x74
enqueue_task_fair+0x568
enqueue_task+0xac
do_activate_task+0x14c
ttwu_do_activate+0xcc
try_to_wake_up+0x6c8
default_wake_function+0x20
autoremove_wake_function+0x1c
__wake_up+0xac
wakeup_kswapd+0x19c
wake_all_kswapds+0x78
__alloc_pages_slowpath+0x1ac
__alloc_pages_noprof+0x298
stack_depot_save_flags+0x6b0
stack_depot_save+0x14
set_track_prepare+0x5c
___slab_alloc+0xccc
__kmalloc_cache_noprof+0x470
__set_page_owner+0x2bc
post_alloc_hook[jt]+0x1b8
prep_new_page+0x28
get_page_from_freelist+0x1edc
__alloc_pages_noprof+0x13c
alloc_slab_page+0x244
allocate_slab+0x7c
___slab_alloc+0x8e8
kmem_cache_alloc_noprof+0x450
debug_objects_fill_pool+0x22c
debug_object_activate+0x40
enqueue_hrtimer[jt]+0xdc
hrtimer_start_range_ns+0x5f8
...

Signed-off-by: yangshiguang <yangshiguang1011@163.com>
---
 mm/slub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index cf7c6032d5fd..14e3bac0c6ad 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -969,7 +969,7 @@ static noinline depot_stack_handle_t set_track_prepare(void)
 	unsigned int nr_entries;
 
 	nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 3);
-	handle = stack_depot_save(entries, nr_entries, GFP_NOWAIT);
+	handle = stack_depot_save(entries, nr_entries, __GFP_NOWARN);
 
 	return handle;
 }
-- 
2.43.0


