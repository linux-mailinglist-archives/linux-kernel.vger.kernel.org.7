Return-Path: <linux-kernel+bounces-782428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 658AEB32042
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 18:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4919018924F7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245BA267B90;
	Fri, 22 Aug 2025 16:11:44 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDFE25B1D3
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 16:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755879103; cv=none; b=jSzO1lSwjGCY/5YLQHXS+BA12cROMLpjYOEcdw6NmzSPj0UeMI7706p7ONy/pFHbm2e7AocTd0DS2qG1zERW4YqPYNegC/EtQ5SyFy2PKTww/BPZCr4RD2gdBN1Ihcpj0eSQ5Cb6XglC8OUd7IulgaANxioc/PguOH3prgoX4so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755879103; c=relaxed/simple;
	bh=VyZ48+G6VgzVZAypOE6VLo9sOSiHOXzmB0kFglnpo2E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=AbfmZkJQTCXDKrwb69OVvX3Y17HkTaDSZS4KijLQy1Ng3CB1MjHmsnbneEMuc+o0+yk80+lWgiK0KJoeL+hMegz3GwE2ob0KadTLrfofpuReYHR+ST8yOY6bbWh2DA3ESXpbNdFVGOjmRF6LRhr3xEbZuGxpuWwAv5CdLMJXj7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf11.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 88332B79D4;
	Fri, 22 Aug 2025 16:11:33 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id C9B3920031;
	Fri, 22 Aug 2025 16:11:31 +0000 (UTC)
Date: Fri, 22 Aug 2025 12:11:38 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Tengda Wu <wutengda@huaweicloud.com>
Subject: [for-linus][PATCH] ftrace: Fix potential warning in
 trace_printk_seq during ftrace_dump
Message-ID: <20250822121138.5e113885@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C9B3920031
X-Stat-Signature: aey9gru6jmphu1sd1acbu4jxkzbkhi9z
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX198ymj7XOI74WWnU2Q7uO7tJ5j3zr8/57E=
X-HE-Tag: 1755879091-964502
X-HE-Meta: U2FsdGVkX1+53QylZw5BKRHKQ6L8oQCjnrFEZc5hEt1nesc90wyWvOqyXv+6oeUUFSFfgGlH6b+RaDf30zF1dcYqo084fqWTkUDPQt4UG2Mhq+/AvRn3tVQZxq4TrWAdzMyNcQTXgWMILXqgkU7rOE5L3pC4i5aximSPOjmOcIAJAT1NN4J3uxj0HZQSAFkT8ARtOl7OPB+QVRk2xCqEBUtLvTOedbq7kX++qCh9RAhQoIZCulJcagkEW6DOMO5M3C5heYbdxhoMkukM2gZlP/93vq9XWbLhhSR4vWX22m+ApHZWoukdq4qF1jwAvdXP1FKvu81YgfQhHqW/cuoczoDTw+d2nSDMOgU4AViJ5uRWMUyuwj2tlvyTzNEPxXPvk/JgqZbB5BMZwKzPekwd7cJKIJ1lIkQNgTUb32ea4ZqWhzVBOsxGt76m9BdHXFIU/3JOk5kOjwUd8S1SqH4p4iyexSq+xtpluUnPMhcfQuSfmM+O3ydMGgyaWdhvxifOfRsPwf7uKWssFKwGbtUbQJFnUvriWwoDquF1I9NPFCQ=


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace/fixes

Head SHA1: c1e730442be2902ad5f9acc244ffc6e6400b981a


Tengda Wu (1):
      ftrace: Fix potential warning in trace_printk_seq during ftrace_dump

----
 kernel/trace/trace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
---------------------------
commit c1e730442be2902ad5f9acc244ffc6e6400b981a
Author: Tengda Wu <wutengda@huaweicloud.com>
Date:   Fri Aug 22 03:33:43 2025 +0000

    ftrace: Fix potential warning in trace_printk_seq during ftrace_dump
    
    When calling ftrace_dump_one() concurrently with reading trace_pipe,
    a WARN_ON_ONCE() in trace_printk_seq() can be triggered due to a race
    condition.
    
    The issue occurs because:
    
    CPU0 (ftrace_dump)                              CPU1 (reader)
    echo z > /proc/sysrq-trigger
    
    !trace_empty(&iter)
    trace_iterator_reset(&iter) <- len = size = 0
                                                    cat /sys/kernel/tracing/trace_pipe
    trace_find_next_entry_inc(&iter)
      __find_next_entry
        ring_buffer_empty_cpu <- all empty
      return NULL
    
    trace_printk_seq(&iter.seq)
      WARN_ON_ONCE(s->seq.len >= s->seq.size)
    
    In the context between trace_empty() and trace_find_next_entry_inc()
    during ftrace_dump, the ring buffer data was consumed by other readers.
    This caused trace_find_next_entry_inc to return NULL, failing to populate
    `iter.seq`. At this point, due to the prior trace_iterator_reset, both
    `iter.seq.len` and `iter.seq.size` were set to 0. Since they are equal,
    the WARN_ON_ONCE condition is triggered.
    
    Move the trace_printk_seq() into the if block that checks to make sure the
    return value of trace_find_next_entry_inc() is non-NULL in
    ftrace_dump_one(), ensuring the 'iter.seq' is properly populated before
    subsequent operations.
    
    Cc: Masami Hiramatsu <mhiramat@kernel.org>
    Cc: Mark Rutland <mark.rutland@arm.com>
    Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
    Cc: Ingo Molnar <mingo@elte.hu>
    Link: https://lore.kernel.org/20250822033343.3000289-1-wutengda@huaweicloud.com
    Fixes: d769041f8653 ("ring_buffer: implement new locking")
    Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
    Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 8d8935ed416d..1b7db732c0b1 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -10638,10 +10638,10 @@ static void ftrace_dump_one(struct trace_array *tr, enum ftrace_dump_mode dump_m
 			ret = print_trace_line(&iter);
 			if (ret != TRACE_TYPE_NO_CONSUME)
 				trace_consume(&iter);
+
+			trace_printk_seq(&iter.seq);
 		}
 		touch_nmi_watchdog();
-
-		trace_printk_seq(&iter.seq);
 	}
 
 	if (!cnt)

