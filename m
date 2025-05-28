Return-Path: <linux-kernel+bounces-665783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5BEAC6DA6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 18:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F6131C00723
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 16:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A9628C86D;
	Wed, 28 May 2025 16:14:57 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F3D28C00D;
	Wed, 28 May 2025 16:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748448896; cv=none; b=butEojGpSkRpZimjF6FJHhI0ItpAYBSV15K0WrrV7XpQHsPS4cOa9gM9Cf57o4MHmFBJydma1kJP0C/99ZrGDVAzHtuPuBsXI8YwN7N1JVMJNkG5fD97m73fyR22KeF5aACY5zxNxk7a3OShp0SRbVv2pFQxeH6825RyCSgkwQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748448896; c=relaxed/simple;
	bh=gJtjQc4SaK2pmuKjZCqhs8OgW/uNNZKmIHygp1VM68Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=YbjigC9yAg+duk6aQsFB9EGJJKTqQWg4wksLOtHb3aTVTVnM/QruAiwSv5PVbXkW1ZguvOh+fTPoFfsIxmEp48MPzJh5QIIv4aiBqJZALs66dE+dejJp/3ChD04ZMRiJcm1UmoLM67wUjdoB3B5I5OUnAhZ8WQRkl7VsCJVsrOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8476CC4CEE3;
	Wed, 28 May 2025 16:14:55 +0000 (UTC)
Date: Wed, 28 May 2025 12:15:55 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Vincent Donnefort <vdonnefort@google.com>
Subject: [PATCH v2] ring-buffer: Do not trigger WARN_ON() due to a
 commit_overrun
Message-ID: <20250528121555.2066527e@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Steven Rostedt <rostedt@goodmis.org>

When reading a memory mapped buffer the reader page is just swapped out
with the last page written in the write buffer. If the reader page is the
same as the commit buffer (the buffer that is currently being written to)
it was assumed that it should never have missed events. If it does, it
triggers a WARN_ON_ONCE().

But there just happens to be one scenario where this can legitimately
happen. That is on a commit_overrun. A commit overrun is when an interrupt
preempts an event being written to the buffer and then the interrupt adds
so many new events that it fills and wraps the buffer back to the commit.
Any new events would then be dropped and be reported as "missed_events".

In this case, the next page to read is the commit buffer and after the
swap of the reader page, the reader page will be the commit buffer, but
this time there will be missed events and this triggers the following
warning:

 ------------[ cut here ]------------
 WARNING: CPU: 2 PID: 1127 at kernel/trace/ring_buffer.c:7357 ring_buffer_map_get_reader+0x49a/0x780
 Modules linked in: kvm_intel kvm irqbypass
 CPU: 2 UID: 0 PID: 1127 Comm: trace-cmd Not tainted 6.15.0-rc7-test-00004-g478bc2824b45-dirty #564 PREEMPT
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
 RIP: 0010:ring_buffer_map_get_reader+0x49a/0x780
 Code: 00 00 00 48 89 fe 48 c1 ee 03 80 3c 2e 00 0f 85 ec 01 00 00 4d 3b a6 a8 00 00 00 0f 85 8a fd ff ff 48 85 c0 0f 84 55 fe ff ff <0f> 0b e9 4e fe ff ff be 08 00 00 00 4c 89 54 24 58 48 89 54 24 50
 RSP: 0018:ffff888121787dc0 EFLAGS: 00010002
 RAX: 00000000000006a2 RBX: ffff888100062800 RCX: ffffffff8190cb49
 RDX: ffff888126934c00 RSI: 1ffff11020200a15 RDI: ffff8881010050a8
 RBP: dffffc0000000000 R08: 0000000000000000 R09: ffffed1024d26982
 R10: ffff888126934c17 R11: ffff8881010050a8 R12: ffff888126934c00
 R13: ffff8881010050b8 R14: ffff888101005000 R15: ffff888126930008
 FS:  00007f95c8cd7540(0000) GS:ffff8882b576e000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007f95c8de4dc0 CR3: 0000000128452002 CR4: 0000000000172ef0
 Call Trace:
  <TASK>
  ? __pfx_ring_buffer_map_get_reader+0x10/0x10
  tracing_buffers_ioctl+0x283/0x370
  __x64_sys_ioctl+0x134/0x190
  do_syscall_64+0x79/0x1c0
  entry_SYSCALL_64_after_hwframe+0x76/0x7e
 RIP: 0033:0x7f95c8de48db
 Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
 RSP: 002b:00007ffe037ba110 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
 RAX: ffffffffffffffda RBX: 00007ffe037bb2b0 RCX: 00007f95c8de48db
 RDX: 0000000000000000 RSI: 0000000000005220 RDI: 0000000000000006
 RBP: 00007ffe037ba180 R08: 0000000000000000 R09: 0000000000000000
 R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
 R13: 00007ffe037bb6f8 R14: 00007f95c9065000 R15: 00005575c7492c90
  </TASK>
 irq event stamp: 5080
 hardirqs last  enabled at (5079): [<ffffffff83e0adb0>] _raw_spin_unlock_irqrestore+0x50/0x70
 hardirqs last disabled at (5080): [<ffffffff83e0aa83>] _raw_spin_lock_irqsave+0x63/0x70
 softirqs last  enabled at (4182): [<ffffffff81516122>] handle_softirqs+0x552/0x710
 softirqs last disabled at (4159): [<ffffffff815163f7>] __irq_exit_rcu+0x107/0x210
 ---[ end trace 0000000000000000 ]---

The above was triggered by running on a kernel with both lockdep and KASAN
as well as kmemleak enabled and executing the following command:

 # perf record -o perf-test.dat -a -- trace-cmd record --nosplice  -e all -p function hackbench 50

With perf interjecting a lot of interrupts and trace-cmd enabling all
events as well as function tracing, with lockdep, KASAN and kmemleak
enabled, it could cause an interrupt preempting an event being written to
add enough events to wrap the buffer. trace-cmd was modified to have
--nosplice use mmap instead of reading the buffer.

The way to differentiate this case from the normal case of there only
being one page written to where the swap of the reader page received that
one page (which is the commit page), check if the tail page is on the
reader page. The difference between the commit page and the tail page is
that the tail page is where new writes go to, and the commit page holds
the first write that hasn't been committed yet. In the case of an
interrupt preempting the write of an event and filling the buffer, it
would move the tail page but not the commit page.

Have the warning only trigger if the tail page is also on the reader page,
and also print out the number of events dropped by a commit overrun as
that can not yet be safely added to the page so that the reader can see
there were events dropped.

Cc: stable@vger.kernel.org
Fixes: fe832be05a8ee ("ring-buffer: Have mmapped ring buffer keep track of missed events")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v1: https://lore.kernel.org/20250527121140.0e7f0565@gandalf.local.home

- Added to the pr_info() the CPU that overflowed and the timestamp of the
  page that overflowed, to make it easier for user space to know where it
  happened.

- Restructured to have if (missed_events) be the main condition, as the sub
  conditions only did something when missed_events was non-zero.
  (Masami Hiramatsu)

 kernel/trace/ring_buffer.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index ca1a8e706004..683aa57870fe 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -7285,8 +7285,8 @@ int ring_buffer_map_get_reader(struct trace_buffer *buffer, int cpu)
 	/* Check if any events were dropped */
 	missed_events = cpu_buffer->lost_events;
 
-	if (cpu_buffer->reader_page != cpu_buffer->commit_page) {
-		if (missed_events) {
+	if (missed_events) {
+		if (cpu_buffer->reader_page != cpu_buffer->commit_page) {
 			struct buffer_data_page *bpage = reader->page;
 			unsigned int commit;
 			/*
@@ -7307,13 +7307,23 @@ int ring_buffer_map_get_reader(struct trace_buffer *buffer, int cpu)
 				local_add(RB_MISSED_STORED, &bpage->commit);
 			}
 			local_add(RB_MISSED_EVENTS, &bpage->commit);
+		} else if (!WARN_ONCE(cpu_buffer->reader_page == cpu_buffer->tail_page,
+				      "Reader on commit with %ld missed events",
+				      missed_events)) {
+			/*
+			 * There shouldn't be any missed events if the tail_page
+			 * is on the reader page. But if the tail page is not on the
+			 * reader page and the commit_page is, that would mean that
+			 * there's a commit_overrun (an interrupt preempted an
+			 * addition of an event and then filled the buffer
+			 * with new events). In this case it's not an
+			 * error, but it should still be reported.
+			 *
+			 * TODO: Add missed events to the page for user space to know.
+			 */
+			pr_info("Ring buffer [%d] commit overrun lost %ld events at timestamp:%lld\n",
+				cpu, missed_events, cpu_buffer->reader_page->page->time_stamp);
 		}
-	} else {
-		/*
-		 * There really shouldn't be any missed events if the commit
-		 * is on the reader page.
-		 */
-		WARN_ON_ONCE(missed_events);
 	}
 
 	cpu_buffer->lost_events = 0;
-- 
2.47.2


