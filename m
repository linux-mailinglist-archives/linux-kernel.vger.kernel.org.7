Return-Path: <linux-kernel+bounces-585859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B59A79877
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Apr 2025 00:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2529D189132A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 22:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6131C1F7069;
	Wed,  2 Apr 2025 22:57:33 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F521F75A9
	for <linux-kernel@vger.kernel.org>; Wed,  2 Apr 2025 22:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743634651; cv=none; b=GHI/Tswu5tVtVuW0CJzkVJXuatJZ4pxr5dIb/zMWS2lB3rG8m6O+CmnsCmmZ1Eb9fqqvqfLxNTbtBCA5uWV/vJeRV4S003K/d6vGOA+fKp+tPi+4ZV9R/iTRsEBofQ35QTwBLFmz37fyhxaaKe8GX8bXtnWPvYgvQA2R1/1Hhpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743634651; c=relaxed/simple;
	bh=RfagBImddDmbCWhxs+3aphi2n4fkuaf2i+OuyVKUp7c=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=BwyfaL5zu+4gefnZWXwh105iEQ6aNkQ3P0pG+hFCnKBw5wNCHa7MN+faA1oQMycgFAEF1gmkw81S3w/b3cOTMkRRcXdA06UHuwr8LgnK5CdR11pB5V8U5IWI/FZ6bINi34v9uUE+eNvMjx3v+/MLakXVefPgodaganJW3Zh3rtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29438C4CEEF;
	Wed,  2 Apr 2025 22:57:31 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1u072Z-00000006Z20-1uMB;
	Wed, 02 Apr 2025 18:58:35 -0400
Message-ID: <20250402225835.297421996@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 02 Apr 2025 18:57:38 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vincent Donnefort <vdonnefort@google.com>,
 Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@kernel.org>,
 Jann Horn <jannh@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
Subject: [for-linus][PATCH 3/4] tracing: Use vmap_page_range() to map memmap ring buffer
References: <20250402225735.849814084@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The code to map the physical memory retrieved by memmap currently
allocates an array of pages to cover the physical memory and then calls
vmap() to map it to a virtual address. Instead of using this temporary
array of struct page descriptors, simply use vmap_page_range() that can
directly map the contiguous physical memory to a virtual address.

Link: https://lore.kernel.org/all/CAHk-=whUOfVucfJRt7E0AH+GV41ELmS4wJqxHDnui6Giddfkzw@mail.gmail.com/

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Vincent Donnefort <vdonnefort@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Jann Horn <jannh@google.com>
Link: https://lore.kernel.org/20250402144953.754618481@goodmis.org
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index e58b72e61573..f6531cd3176b 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -50,6 +50,7 @@
 #include <linux/irq_work.h>
 #include <linux/workqueue.h>
 #include <linux/sort.h>
+#include <linux/io.h> /* vmap_page_range() */
 
 #include <asm/setup.h> /* COMMAND_LINE_SIZE */
 
@@ -9796,29 +9797,27 @@ static int instance_mkdir(const char *name)
 	return ret;
 }
 
-static u64 map_pages(u64 start, u64 size)
+static u64 map_pages(unsigned long start, unsigned long size)
 {
-	struct page **pages;
-	phys_addr_t page_start;
-	unsigned int page_count;
-	unsigned int i;
-	void *vaddr;
-
-	page_count = DIV_ROUND_UP(size, PAGE_SIZE);
+	unsigned long vmap_start, vmap_end;
+	struct vm_struct *area;
+	int ret;
 
-	page_start = start;
-	pages = kmalloc_array(page_count, sizeof(struct page *), GFP_KERNEL);
-	if (!pages)
+	area = get_vm_area(size, VM_IOREMAP);
+	if (!area)
 		return 0;
 
-	for (i = 0; i < page_count; i++) {
-		phys_addr_t addr = page_start + i * PAGE_SIZE;
-		pages[i] = pfn_to_page(addr >> PAGE_SHIFT);
+	vmap_start = (unsigned long) area->addr;
+	vmap_end = vmap_start + size;
+
+	ret = vmap_page_range(vmap_start, vmap_end,
+			      start, pgprot_nx(PAGE_KERNEL));
+	if (ret < 0) {
+		free_vm_area(area);
+		return 0;
 	}
-	vaddr = vmap(pages, page_count, VM_MAP, PAGE_KERNEL);
-	kfree(pages);
 
-	return (u64)(unsigned long)vaddr;
+	return (u64)vmap_start;
 }
 
 /**
-- 
2.47.2



