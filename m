Return-Path: <linux-kernel+bounces-804496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0418B477F5
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 00:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94D241C237B3
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 22:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F50A2D8365;
	Sat,  6 Sep 2025 22:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQRYWLzf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E2B2C15AF
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 22:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757197051; cv=none; b=E6mRvEVuJXf9MKqaD3pHSP2XFKpGen3k2mcCWttMQ219evuuhNSHOpu6XBOqrH2Vb2FRtmxGacM2lX5iA7GPJrWUKmJ4+2LgqzjHAr0JKG3NGtk63kSnCI2AF/E/NfNY9cfj9NnMlT4Oa9Wo99WUylpMHYckDM2OQJMqSI+x4FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757197051; c=relaxed/simple;
	bh=jhgoq70j6joLqIm6PtVIcNMuSzY6X/5MBWdp1IUUcvI=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=AEA52cdrfuCF2RviAs54E1T31qB6nwwlsA1T13mxZLkyJ0m2P018AcPPwLW2kfA7jHHEKEYxqI+JHYjRQx426l28dpI4LXJNTl+t6n/nzSQVVJsj0DiQ66DRrcgpdp8l/3s/QzacNU3mpj0E7C67utd49PaJPoV9GtTlkmvnWnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQRYWLzf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB232C4CEF8;
	Sat,  6 Sep 2025 22:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757197051;
	bh=jhgoq70j6joLqIm6PtVIcNMuSzY6X/5MBWdp1IUUcvI=;
	h=Date:From:To:Cc:Subject:References:From;
	b=iQRYWLzfReKn7HOchhyYgRroRFxFMZdPpaxzDPLHC5W5DO+kIeD881iYOacbGhqnO
	 Qf/4UjYEVVGMSQ7TRUh5zMZ9Kk4vyIG8FC+8VHz1+SQANPbfhxyuHvWNbaEhCL6gco
	 K2jFv+XoamrWRcebZBI6Kw9sANzLv0gYGiHQ4U2BpgAbECWa49gP+pJKtlD8pablH7
	 CxXBfDGKubCiMfTiHsPzIg/Vn8oh94GzZAC0c1LtKWaCB4tbFSzRXlcYJECYesLrru
	 biggGpdZgnqsglH2jxjayEKdqzyrQu1L4IEigd4MuO7LQOGz38uwpLKRk1bUKWISFq
	 /Nw0HwLr032mA==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uv1Ea-00000006Uhh-3Neq;
	Sat, 06 Sep 2025 18:18:12 -0400
Message-ID: <20250906221812.662279697@kernel.org>
User-Agent: quilt/0.68
Date: Sat, 06 Sep 2025 18:17:53 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Luo Gengkun <luogengkun@huaweicloud.com>
Subject: [for-linus][PATCH 2/5] tracing: Fix tracing_marker may trigger page fault during
 preempt_disable
References: <20250906221751.054623340@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Luo Gengkun <luogengkun@huaweicloud.com>

Both tracing_mark_write and tracing_mark_raw_write call
__copy_from_user_inatomic during preempt_disable. But in some case,
__copy_from_user_inatomic may trigger page fault, and will call schedule()
subtly. And if a task is migrated to other cpu, the following warning will
be trigger:
        if (RB_WARN_ON(cpu_buffer,
                       !local_read(&cpu_buffer->committing)))

An example can illustrate this issue:

process flow						CPU
---------------------------------------------------------------------

tracing_mark_raw_write():				cpu:0
   ...
   ring_buffer_lock_reserve():				cpu:0
      ...
      cpu = raw_smp_processor_id()			cpu:0
      cpu_buffer = buffer->buffers[cpu]			cpu:0
      ...
   ...
   __copy_from_user_inatomic():				cpu:0
      ...
      # page fault
      do_mem_abort():					cpu:0
         ...
         # Call schedule
         schedule()					cpu:0
	 ...
   # the task schedule to cpu1
   __buffer_unlock_commit():				cpu:1
      ...
      ring_buffer_unlock_commit():			cpu:1
	 ...
	 cpu = raw_smp_processor_id()			cpu:1
	 cpu_buffer = buffer->buffers[cpu]		cpu:1

As shown above, the process will acquire cpuid twice and the return values
are not the same.

To fix this problem using copy_from_user_nofault instead of
__copy_from_user_inatomic, as the former performs 'access_ok' before
copying.

Link: https://lore.kernel.org/20250819105152.2766363-1-luogengkun@huaweicloud.com
Fixes: 656c7f0d2d2b ("tracing: Replace kmap with copy_from_user() in trace_marker writing")
Signed-off-by: Luo Gengkun <luogengkun@huaweicloud.com>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 1b7db732c0b1..2f1ae6c0ee81 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -7209,7 +7209,7 @@ static ssize_t write_marker_to_buffer(struct trace_array *tr, const char __user
 	entry = ring_buffer_event_data(event);
 	entry->ip = ip;
 
-	len = __copy_from_user_inatomic(&entry->buf, ubuf, cnt);
+	len = copy_from_user_nofault(&entry->buf, ubuf, cnt);
 	if (len) {
 		memcpy(&entry->buf, FAULTED_STR, FAULTED_SIZE);
 		cnt = FAULTED_SIZE;
@@ -7306,7 +7306,7 @@ static ssize_t write_raw_marker_to_buffer(struct trace_array *tr,
 
 	entry = ring_buffer_event_data(event);
 
-	len = __copy_from_user_inatomic(&entry->id, ubuf, cnt);
+	len = copy_from_user_nofault(&entry->id, ubuf, cnt);
 	if (len) {
 		entry->id = -1;
 		memcpy(&entry->buf, FAULTED_STR, FAULTED_SIZE);
-- 
2.50.1



