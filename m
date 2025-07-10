Return-Path: <linux-kernel+bounces-725873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7945EB004E6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 16:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 800747B3935
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 14:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5B3271A84;
	Thu, 10 Jul 2025 14:16:15 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C1913C3F2
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 14:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752156975; cv=none; b=oTAj8tGxK8l4KnxHnkYV/fUwj+hTZWyfH6dq94h1JKJxq+LGSXG59vNv5gOtJ2vFvZ4O/fHI2HMbxBC+duWM/NYkwkqEazqoRyCb0Y0cPQ7HTIC8+f9NGs+1hPuT1nbc8hhO+ngdm/UAL/rdYO2BjBWx+PSeXdYqhL+kyFjT3u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752156975; c=relaxed/simple;
	bh=c1ifoubkcy4+/WwPHlkZXEaCUsq5M2tanwIhbni9MCc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=HPS67U/XRSei0zWNqlLwmqyHJbl+ApEHnZ++vH8PXq69o8SXTNYqYCw3y07IFQJ7jcP87OBNw/6LwOL1FFySlZPWldWDR7Mwf3JcRuVnAlK9ZpytPmP0h6e3PsQJsGOldwbFOfQZ9zl54qbx2PJORgnmXhmBFiXvJDI4OR4Ao00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 0645514010C;
	Thu, 10 Jul 2025 14:16:04 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id 981AB30;
	Thu, 10 Jul 2025 14:16:03 +0000 (UTC)
Date: Thu, 10 Jul 2025 10:16:03 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: [for-next][PATCH] tracing: ring_buffer: Rewind persistent ring
 buffer on reboot
Message-ID: <20250710101603.02970da4@batman.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: w4ihbhubpm1rhex8rabuesespujtoxqu
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 981AB30
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19PP3n/frLQjfDacq2cq9oJAz+5R7rL0bM=
X-HE-Tag: 1752156963-936725
X-HE-Meta: U2FsdGVkX190/vLj9QY9D5lW5+DNJ5ELhOIDLalhSoy29mWW6f3+6LH5WLGrPOX6zAP9EBPpmlaVi/7yR2V9A2p3AeYe5DiiLUWtHfllMxH7PNDK+Pi/iXLUTvlZFAqLn5fOO5oqbMqzfSglxYKpzfngnsi7Ly6WWlFX3U2+FSCXbVEZPg3pO6R36CWe7D/rVDUlKDNvKTnrrWoFzD3QYlFOmg9OKarxNcfb8LMRsMNlI1/pWRDYh97uQdihxTDALoLFDK2s/txE5ESW5UylQtG7TGfkNSUi1gxDeDOiV1/7tZIHYujDVJ8hn1Ht2u2GiQ+RnR3W6T2rg17ht3Ykg9TE4hgvEpSUhZb+2GrmiyjwaG4L0bHFD0gfIWvwyNTLnDCPNhWgWoEH6UA39kI8bqOq0JXyTQ0/1wHOlH0IUorPM4zVh+M1okWzbNTuC0HyZw/KT6lC0AO5lAl1HSWB1mZMaTy4PFtzZZfbzRmFquM=

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
ring-buffer/for-next

Head SHA1: ca296d32ece38b07113bad64e08add75073a0e2b


Masami Hiramatsu (Google) (1):
      tracing: ring_buffer: Rewind persistent ring buffer on reboot

----
 kernel/trace/ring_buffer.c | 103 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 100 insertions(+), 3 deletions(-)
---------------------------
commit ca296d32ece38b07113bad64e08add75073a0e2b
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Date:   Wed Jun 4 09:10:21 2025 +0900

    tracing: ring_buffer: Rewind persistent ring buffer on reboot
    
    Rewind persistent ring buffer pages which have been read in the previous
    boot. Those pages are highly possible to be lost before writing it to the
    disk if the previous kernel crashed. In this case, the trace data is kept
    on the persistent ring buffer, but it can not be read because its commit
    size has been reset after read.  This skips clearing the commit size of
    each sub-buffer and recover it after reboot.
    
    Note: If you read the previous boot data via trace_pipe, that is not
    accessible in that time. But reboot without clearing (or reusing) the read
    data, the read data is recovered again in the next boot.
    
    Thus, when you read the previous boot data, clear it by `echo > trace`.
    
    Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
    Link: https://lore.kernel.org/174899582116.955054.773265393511190051.stgit@mhiramat.tok.corp.google.com
    Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
    Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 00fc38d70e86..a99ed4716de9 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1358,6 +1358,13 @@ static inline void rb_inc_page(struct buffer_page **bpage)
 	*bpage = list_entry(p, struct buffer_page, list);
 }
 
+static inline void rb_dec_page(struct buffer_page **bpage)
+{
+	struct list_head *p = rb_list_head((*bpage)->list.prev);
+
+	*bpage = list_entry(p, struct buffer_page, list);
+}
+
 static struct buffer_page *
 rb_set_head_page(struct ring_buffer_per_cpu *cpu_buffer)
 {
@@ -1866,10 +1873,11 @@ static int rb_validate_buffer(struct buffer_data_page *dpage, int cpu)
 static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 {
 	struct ring_buffer_cpu_meta *meta = cpu_buffer->ring_meta;
-	struct buffer_page *head_page;
+	struct buffer_page *head_page, *orig_head;
 	unsigned long entry_bytes = 0;
 	unsigned long entries = 0;
 	int ret;
+	u64 ts;
 	int i;
 
 	if (!meta || !meta->head_buffer)
@@ -1885,8 +1893,98 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 	entry_bytes += local_read(&cpu_buffer->reader_page->page->commit);
 	local_set(&cpu_buffer->reader_page->entries, ret);
 
-	head_page = cpu_buffer->head_page;
+	orig_head = head_page = cpu_buffer->head_page;
+	ts = head_page->page->time_stamp;
+
+	/*
+	 * Try to rewind the head so that we can read the pages which already
+	 * read in the previous boot.
+	 */
+	if (head_page == cpu_buffer->tail_page)
+		goto skip_rewind;
+
+	rb_dec_page(&head_page);
+	for (i = 0; i < meta->nr_subbufs + 1; i++, rb_dec_page(&head_page)) {
+
+		/* Rewind until tail (writer) page. */
+		if (head_page == cpu_buffer->tail_page)
+			break;
+
+		/* Ensure the page has older data than head. */
+		if (ts < head_page->page->time_stamp)
+			break;
+
+		ts = head_page->page->time_stamp;
+		/* Ensure the page has correct timestamp and some data. */
+		if (!ts || rb_page_commit(head_page) == 0)
+			break;
 
+		/* Stop rewind if the page is invalid. */
+		ret = rb_validate_buffer(head_page->page, cpu_buffer->cpu);
+		if (ret < 0)
+			break;
+
+		/* Recover the number of entries and update stats. */
+		local_set(&head_page->entries, ret);
+		if (ret)
+			local_inc(&cpu_buffer->pages_touched);
+		entries += ret;
+		entry_bytes += rb_page_commit(head_page);
+	}
+	if (i)
+		pr_info("Ring buffer [%d] rewound %d pages\n", cpu_buffer->cpu, i);
+
+	/* The last rewound page must be skipped. */
+	if (head_page != orig_head)
+		rb_inc_page(&head_page);
+
+	/*
+	 * If the ring buffer was rewound, then inject the reader page
+	 * into the location just before the original head page.
+	 */
+	if (head_page != orig_head) {
+		struct buffer_page *bpage = orig_head;
+
+		rb_dec_page(&bpage);
+		/*
+		 * Insert the reader_page before the original head page.
+		 * Since the list encode RB_PAGE flags, general list
+		 * operations should be avoided.
+		 */
+		cpu_buffer->reader_page->list.next = &orig_head->list;
+		cpu_buffer->reader_page->list.prev = orig_head->list.prev;
+		orig_head->list.prev = &cpu_buffer->reader_page->list;
+		bpage->list.next = &cpu_buffer->reader_page->list;
+
+		/* Make the head_page the reader page */
+		cpu_buffer->reader_page = head_page;
+		bpage = head_page;
+		rb_inc_page(&head_page);
+		head_page->list.prev = bpage->list.prev;
+		rb_dec_page(&bpage);
+		bpage->list.next = &head_page->list;
+		rb_set_list_to_head(&bpage->list);
+		cpu_buffer->pages = &head_page->list;
+
+		cpu_buffer->head_page = head_page;
+		meta->head_buffer = (unsigned long)head_page->page;
+
+		/* Reset all the indexes */
+		bpage = cpu_buffer->reader_page;
+		meta->buffers[0] = rb_meta_subbuf_idx(meta, bpage->page);
+		bpage->id = 0;
+
+		for (i = 1, bpage = head_page; i < meta->nr_subbufs;
+		     i++, rb_inc_page(&bpage)) {
+			meta->buffers[i] = rb_meta_subbuf_idx(meta, bpage->page);
+			bpage->id = i;
+		}
+
+		/* We'll restart verifying from orig_head */
+		head_page = orig_head;
+	}
+
+ skip_rewind:
 	/* If the commit_buffer is the reader page, update the commit page */
 	if (meta->commit_buffer == (unsigned long)cpu_buffer->reader_page->page) {
 		cpu_buffer->commit_page = cpu_buffer->reader_page;
@@ -5342,7 +5440,6 @@ rb_get_reader_page(struct ring_buffer_per_cpu *cpu_buffer)
 	 */
 	local_set(&cpu_buffer->reader_page->write, 0);
 	local_set(&cpu_buffer->reader_page->entries, 0);
-	local_set(&cpu_buffer->reader_page->page->commit, 0);
 	cpu_buffer->reader_page->real_end = 0;
 
  spin:

