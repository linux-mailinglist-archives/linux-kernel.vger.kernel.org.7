Return-Path: <linux-kernel+bounces-733727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A440B07846
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 16:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 627EE16EE8B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 14:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C65D261594;
	Wed, 16 Jul 2025 14:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FYg4ahoW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FC3233156
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 14:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752676723; cv=none; b=Rw75FcvYIJEuB8UEEwUE1ZEj3hZjPh3TI7ItcEEtBTOrNa9XkLkVhKBVGHn2wmJ88Zor4dPO9ZAN5dBYoFK0camPP4llZqIBA1D4fGj0qO8ob6zFUC6mgIh/EQQiM2T8b7HtcjevS2iqsCcAleyjJkAW9dtp9ck4Wa+72JFOVJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752676723; c=relaxed/simple;
	bh=oWT4UhuprBU4uzVFD1aAq+uce9GMDclGkVsEh4frCuM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QlXd2PzdUIIPOoy7BQ0k+s/rcmhy23cLl95DGkYuDZheDBjQZYkv3ijTHrQVsFOAogE7BpXZuk7fdTJX9DyUiHSLoTlkuxkctOjwK6KStbq/xn02D+xCLfBgYbDaYrNoddVR0GlJ8L24oGW4CCF8H5UQv8mZT7PDXZRuTGL8G58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FYg4ahoW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752676720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ajHJ2tQ5qM4LcKhMqVWF3mLSk9Qiueaa/5Dboted428=;
	b=FYg4ahoWYiOhw7bATDebMzo+cGkR8WUGSw78OFszcnGPnLsIJpgpuK3UsKNbTjTjvBxynL
	HZPP2g707v7OQgYCHr6mgfOAz59c7R1Pr+O/+YCJ3guO5KXJBPtFYRfOh1+suY5eR0j+Ih
	tJxDpVQ/wQ+cVPI22F4Lfk+bh9oqaJc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-183-OGphlmYKOEqL5iCXAj5I7A-1; Wed,
 16 Jul 2025 10:38:38 -0400
X-MC-Unique: OGphlmYKOEqL5iCXAj5I7A-1
X-Mimecast-MFC-AGG-ID: OGphlmYKOEqL5iCXAj5I7A_1752676718
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C518D195608B;
	Wed, 16 Jul 2025 14:38:37 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.115])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2759419560AB;
	Wed, 16 Jul 2025 14:38:34 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Attila Fazekas <afazekas@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH] tracing/osnoise: Fix crash in timerlat_dump_stack()
Date: Wed, 16 Jul 2025 16:36:01 +0200
Message-ID: <20250716143601.7313-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

We have observed kernel panics when using timerlat with stack saving,
with the following dmesg output:

memcpy: detected buffer overflow: 88 byte write of buffer size 0
WARNING: CPU: 2 PID: 8153 at lib/string_helpers.c:1032 __fortify_report+0x55/0xa0
CPU: 2 UID: 0 PID: 8153 Comm: timerlatu/2 Kdump: loaded Not tainted 6.15.3-200.fc42.x86_64 #1 PREEMPT(lazy)
Call Trace:
 <TASK>
 ? trace_buffer_lock_reserve+0x2a/0x60
 __fortify_panic+0xd/0xf
 __timerlat_dump_stack.cold+0xd/0xd
 timerlat_dump_stack.part.0+0x47/0x80
 timerlat_fd_read+0x36d/0x390
 vfs_read+0xe2/0x390
 ? syscall_exit_to_user_mode+0x1d5/0x210
 ksys_read+0x73/0xe0
 do_syscall_64+0x7b/0x160
 ? exc_page_fault+0x7e/0x1a0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

__timerlat_dump_stack() constructs the ftrace stack entry like this:

struct stack_entry *entry;
...
memcpy(&entry->caller, fstack->calls, size);
entry->size = fstack->nr_entries;

Since commit e7186af7fb26 ("tracing: Add back FORTIFY_SOURCE logic to
kernel_stack event structure"), struct stack_entry marks its caller
field with __counted_by(size). At the time of the memcpy, entry->size
contains garbage from the ringbuffer, which under some circumstances is
zero, triggering a kernel panic by buffer overflow.

Populate the size field before the memcpy so that the out-of-bounds
check knows the correct size. This is analogous to
__ftrace_trace_stack().

Cc: stable@vger.kernel.org
Fixes: e7186af7fb26 ("tracing: Add back FORTIFY_SOURCE logic to kernel_stack event structure")
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 kernel/trace/trace_osnoise.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Note: This has been so far only reproduced on laptops (three different
machines). Not sure what the reason for that is, but it is clearly
a bug.

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 6819b93309ce..fd259da0aa64 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -637,8 +637,8 @@ __timerlat_dump_stack(struct trace_buffer *buffer, struct trace_stack *fstack, u
 
 	entry = ring_buffer_event_data(event);
 
-	memcpy(&entry->caller, fstack->calls, size);
 	entry->size = fstack->nr_entries;
+	memcpy(&entry->caller, fstack->calls, size);
 
 	trace_buffer_unlock_commit_nostack(buffer, event);
 }
-- 
2.47.1


