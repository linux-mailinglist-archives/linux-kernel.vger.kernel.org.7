Return-Path: <linux-kernel+bounces-808916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F90B50680
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 21:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52E751BC6381
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 19:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A318352FE5;
	Tue,  9 Sep 2025 19:38:27 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10C83168E1
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 19:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757446707; cv=none; b=omRokOSlOIbrmORkBMbOkN5YIJwkCesh4LAvD7WetK3mf6jcDPiYdzE4L+6zHKLjNsyQgfd2bErVXIMoaBhO1MOJx5tYCdejIjkALUcR6Mq2HY6DBLFrM0aOYokHkjqmHyTyS9hecIg7qDizhQXM911NsX9mXCU9Z+hQZP2aTTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757446707; c=relaxed/simple;
	bh=EsULeyaq1cZRoZLXJFh4dr2leAD4GLfg9qpo//7vdA8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=goMWHA/86aBG0zG6WrFzfTkKaCrrakplavVoKEcZ36P0Ujx0zq4JdET3py8p+vln/1r+aKuNvP7/NcPi14mCQ8m/rf7Zyi43QN1YS3WYKayLnvgdMO3tJ9SjoS1pfDIhl09yiIx2ua+PuQxPagc0dgDVDlwV3h7tmgZgkdJ9w2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id B3F5486DD9;
	Tue,  9 Sep 2025 19:38:17 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id 2E8D42D;
	Tue,  9 Sep 2025 19:38:16 +0000 (UTC)
Date: Tue, 9 Sep 2025 15:39:04 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Pu Lehui <pulehui@huawei.com>
Subject: [for-linus][PATCH] tracing: Silence warning when chunk allocation
 fails in trace_pid_write
Message-ID: <20250909153904.59c13189@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 2E8D42D
X-Stat-Signature: yf1fm49981d6zx7y5d7q87ixx7noupur
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19VuMrb7RTaYLDP+u/JnzeawuMTXPq7QzI=
X-HE-Tag: 1757446696-994376
X-HE-Meta: U2FsdGVkX18ycscDCkf0J739aBtumraNGfEC7cxNCGFdsaVCpxHzVVpTsRNIuagO2xIoNlCb67+lkAKwechXU8vcVi8X6kPJgvvyQ3DaXDR1K09uBdDg2sCi1X50NZvHABBj2cGnhcjbiyTm70fiJFB49l6O4fGoNzoBafE89oAnITgVXvhnHo5iVuY7yEVOmcrwpnjVikV/iksMVOtYHKmoXEFgKNrghsJ/Bpiw18s18tobh+lVvUj+B+dmVN0Idg50l8+3b1HLM0IOR8MXid6qWsORJZtOj/PtNdlXKJOMHC0pjF4cqmOyi3pU+Wwp+sduk/2NBM0YR6MSqoyteB9O06WwDMDuXiiJi//u0TS0Pj/Occ0ccd6ASkxkmDFS99WPm8chZpeKesoR2kyzyS8VnmnIGKO8kid2ocMuOEV//6Fcw74JEQ3nfeKFxoHT17xvwPxHHg6dyPOxQep17YLGBl2bNaDIea4M+99iUdoB/H6HL4Uql8ylrcI2Jx7+uxIGqbeHQwUz6JSCz3ZXtQ==


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace/fixes

Head SHA1: cd4453c5e983cf1fd5757e9acb915adb1e4602b6


Pu Lehui (1):
      tracing: Silence warning when chunk allocation fails in trace_pid_write

----
 kernel/trace/trace.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)
---------------------------
commit cd4453c5e983cf1fd5757e9acb915adb1e4602b6
Author: Pu Lehui <pulehui@huawei.com>
Date:   Mon Sep 8 02:46:58 2025 +0000

    tracing: Silence warning when chunk allocation fails in trace_pid_write
    
    Syzkaller trigger a fault injection warning:
    
    WARNING: CPU: 1 PID: 12326 at tracepoint_add_func+0xbfc/0xeb0
    Modules linked in:
    CPU: 1 UID: 0 PID: 12326 Comm: syz.6.10325 Tainted: G U 6.14.0-rc5-syzkaller #0
    Tainted: [U]=USER
    Hardware name: Google Compute Engine/Google Compute Engine
    RIP: 0010:tracepoint_add_func+0xbfc/0xeb0 kernel/tracepoint.c:294
    Code: 09 fe ff 90 0f 0b 90 0f b6 74 24 43 31 ff 41 bc ea ff ff ff
    RSP: 0018:ffffc9000414fb48 EFLAGS: 00010283
    RAX: 00000000000012a1 RBX: ffffffff8e240ae0 RCX: ffffc90014b78000
    RDX: 0000000000080000 RSI: ffffffff81bbd78b RDI: 0000000000000001
    RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
    R10: 0000000000000001 R11: 0000000000000001 R12: ffffffffffffffef
    R13: 0000000000000000 R14: dffffc0000000000 R15: ffffffff81c264f0
    FS:  00007f27217f66c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    CR2: 0000001b2e80dff8 CR3: 00000000268f8000 CR4: 00000000003526f0
    DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
    DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
    Call Trace:
     <TASK>
     tracepoint_probe_register_prio+0xc0/0x110 kernel/tracepoint.c:464
     register_trace_prio_sched_switch include/trace/events/sched.h:222 [inline]
     register_pid_events kernel/trace/trace_events.c:2354 [inline]
     event_pid_write.isra.0+0x439/0x7a0 kernel/trace/trace_events.c:2425
     vfs_write+0x24c/0x1150 fs/read_write.c:677
     ksys_write+0x12b/0x250 fs/read_write.c:731
     do_syscall_x64 arch/x86/entry/common.c:52 [inline]
     do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
     entry_SYSCALL_64_after_hwframe+0x77/0x7f
    
    We can reproduce the warning by following the steps below:
    1. echo 8 >> set_event_notrace_pid. Let tr->filtered_pids owns one pid
       and register sched_switch tracepoint.
    2. echo ' ' >> set_event_pid, and perform fault injection during chunk
       allocation of trace_pid_list_alloc. Let pid_list with no pid and
    assign to tr->filtered_pids.
    3. echo ' ' >> set_event_pid. Let pid_list is NULL and assign to
       tr->filtered_pids.
    4. echo 9 >> set_event_pid, will trigger the double register
       sched_switch tracepoint warning.
    
    The reason is that syzkaller injects a fault into the chunk allocation
    in trace_pid_list_alloc, causing a failure in trace_pid_list_set, which
    may trigger double register of the same tracepoint. This only occurs
    when the system is about to crash, but to suppress this warning, let's
    add failure handling logic to trace_pid_list_set.
    
    Link: https://lore.kernel.org/20250908024658.2390398-1-pulehui@huaweicloud.com
    Fixes: 8d6e90983ade ("tracing: Create a sparse bitmask for pid filtering")
    Reported-by: syzbot+161412ccaeff20ce4dde@syzkaller.appspotmail.com
    Closes: https://lore.kernel.org/all/67cb890e.050a0220.d8275.022e.GAE@google.com
    Signed-off-by: Pu Lehui <pulehui@huawei.com>
    Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 2f1ae6c0ee81..b3c94fbaf002 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -834,7 +834,10 @@ int trace_pid_write(struct trace_pid_list *filtered_pids,
 		/* copy the current bits to the new max */
 		ret = trace_pid_list_first(filtered_pids, &pid);
 		while (!ret) {
-			trace_pid_list_set(pid_list, pid);
+			ret = trace_pid_list_set(pid_list, pid);
+			if (ret < 0)
+				goto out;
+
 			ret = trace_pid_list_next(filtered_pids, pid + 1, &pid);
 			nr_pids++;
 		}
@@ -871,6 +874,7 @@ int trace_pid_write(struct trace_pid_list *filtered_pids,
 		trace_parser_clear(&parser);
 		ret = 0;
 	}
+ out:
 	trace_parser_put(&parser);
 
 	if (ret < 0) {

