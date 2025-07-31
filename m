Return-Path: <linux-kernel+bounces-751643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D559B16BCA
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 07:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D6F9582BFE
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 05:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B22242D63;
	Thu, 31 Jul 2025 05:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oWB+T7Up"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8924C241693
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 05:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753941523; cv=none; b=OpsXpNKRSTsfXK+o0/mMzfkOcwzHL7zFBNJflZrL6OCKdcETfbuiTWOl6gS6rIbMOMxcDuXy75BVM4yzQ8Hl0BrcUqii/C5f0QPKp423fesHos1dX5A8i/KwOmZYw/UPKXgsdkaNnR4mlWHXaYeAhdW0seTCsyzsjrIpDRfGQwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753941523; c=relaxed/simple;
	bh=CcKnj+C5na3Kj/xzqScU8VezWe3vzakzzlYiu4pZElg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=YO6I/5aM7iizok2tVdL2OEKNySEv3zKb3vFhVLxMxlG5koTS2okPnRMdVf9r/yRtqcDfK8v6k/aMSMIkqTsi6SsIVa97uMfF2n0BtKcOp5IVwDO0Cz3Cy1CQZwY/Zbo5l14A80bzM2vAy3mNGOxf4/arcyNwyCwQU52bizovVts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oWB+T7Up; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 415F4C4CEF4;
	Thu, 31 Jul 2025 05:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753941523;
	bh=CcKnj+C5na3Kj/xzqScU8VezWe3vzakzzlYiu4pZElg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oWB+T7Upq8aZsaFE7R89mvMWpSiz2HtfHFvMHuFxVlkz917dVd8THdz1CWmigB+54
	 jhFW2rWW1FgmLV2t4+4m51xbqMJxNWbqUEHZSH2ruaI8UhJPlWtsXnK+yxd6P1dnXY
	 babGEkaZskVBGE6RC61bWZruI4BtXp2XDf2CXf3HOCUy5wo+C2Fe9KBqFTMJToek7j
	 fg0h9Qj7djk6glEOa2K0p43wT14P7eZnbK6ss09wBugmERE4oxwRHJ4RYxDSb4lCst
	 peewz+DPG/3iqx79Ps4oraiAIf86Q3IA5f0K7ALyWexK2VBUKxjP5kvPpP54Sa9G5f
	 55YBovBF/K2hA==
Date: Thu, 31 Jul 2025 14:58:39 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon
 <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Waiman Long
 <longman@redhat.com>, Joel Granados <joel.granados@kernel.org>, Anna
 Schumaker <anna.schumaker@oracle.com>, Lance Yang <ioworker0@gmail.com>,
 Kent Overstreet <kent.overstreet@linux.dev>, Yongliang Gao
 <leonylgao@tencent.com>, Steven Rostedt <rostedt@goodmis.org>, Tomasz Figa
 <tfiga@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hung_task: Dump blocker task if it is not hung
Message-Id: <20250731145839.5a27175ebf16e249619fea0d@kernel.org>
In-Reply-To: <reyd4bppb5tfon7gtqaelwknvptdeyhrsh5ijbcj77ezini3yq@ivkgxmiqzk3x>
References: <175391351423.688839.11917911323784986774.stgit@devnote2>
	<reyd4bppb5tfon7gtqaelwknvptdeyhrsh5ijbcj77ezini3yq@ivkgxmiqzk3x>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 31 Jul 2025 11:53:51 +0900
Sergey Senozhatsky <senozhatsky@chromium.org> wrote:

> On (25/07/31 07:11), Masami Hiramatsu (Google) wrote:
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Dump the lock blocker task if it is not hung because if the blocker
> > task is also hung, it should be dumped by the detector. This will
> > de-duplicate the same stackdumps if the blocker task is also blocked
> > by another task (and hung).
> > 
> > Suggested-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > Acked-by: Lance Yang <lance.yang@linux.dev>
> 
> Tested-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> 

Thank you for testing!

> 
> Wrote a simple 3 tasks circular lock test (same that I had in real
> life).  The output looks good:

OK, it works nicely. We'll better to have a similar test (but
with maximum warning message because it can crash the kernel.)

Thank you,

> 
> [   90.985431] [    T140] INFO: task T1:525 blocked for more than 30 seconds.
> [   90.990981] [    T140]       Not tainted 6.16.0-next-20250730-00003-g5865c79d6085-dirty #261
> [   90.996912] [    T140] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [   91.001617] [    T140] task:T1              state:D stack:0     pid:525   tgid:525   ppid:2      task_flags:0x208040 flags:0x00004000
> [   91.007564] [    T140] Call Trace:
> [   91.008767] [    T140]  <TASK>
> [   91.009872] [    T140]  __schedule+0x137f/0x20c0
> [   91.011606] [    T140]  schedule+0xdc/0x280
> [   91.013115] [    T140]  schedule_preempt_disabled+0x10/0x20
> [   91.015200] [    T140]  __mutex_lock+0x721/0x1590
> [   91.016817] [    T140]  ? __mutex_lock+0x500/0x1590
> [   91.018074] [    T140]  mutex_lock+0x81/0x90
> [   91.019169] [    T140]  t1+0x62/0x70
> [   91.020061] [    T140]  kthread+0x583/0x6e0
> [   91.021140] [    T140]  ? drop_caches_sysctl_handler+0x130/0x130
> [   91.022729] [    T140]  ? kthread_blkcg+0xa0/0xa0
> [   91.023921] [    T140]  ret_from_fork+0xc8/0x160
> [   91.025091] [    T140]  ? kthread_blkcg+0xa0/0xa0
> [   91.026309] [    T140]  ret_from_fork_asm+0x11/0x20
> [   91.027577] [    T140]  </TASK>
> [   91.028326] [    T140] INFO: task T1:525 is blocked on a mutex likely owned by task T2:526.
> [   91.030404] [    T140] INFO: task T2:526 blocked for more than 30 seconds.
> [   91.031978] [    T140]       Not tainted 6.16.0-next-20250730-00003-g5865c79d6085-dirty #261
> [   91.034069] [    T140] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [   91.036215] [    T140] task:T2              state:D stack:0     pid:526   tgid:526   ppid:2      task_flags:0x208040 flags:0x00004000
> [   91.039233] [    T140] Call Trace:
> [   91.040084] [    T140]  <TASK>
> [   91.040810] [    T140]  __schedule+0x137f/0x20c0
> [   91.041954] [    T140]  schedule+0xdc/0x280
> [   91.042984] [    T140]  schedule_preempt_disabled+0x10/0x20
> [   91.044329] [    T140]  __mutex_lock+0x721/0x1590
> [   91.045464] [    T140]  ? __mutex_lock+0x500/0x1590
> [   91.046624] [    T140]  mutex_lock+0x81/0x90
> [   91.047632] [    T140]  t2+0x69/0x70
> [   91.048473] [    T140]  kthread+0x583/0x6e0
> [   91.049453] [    T140]  ? drop_pagecache_sb+0x200/0x200
> [   91.050686] [    T140]  ? kthread_blkcg+0xa0/0xa0
> [   91.051808] [    T140]  ret_from_fork+0xc8/0x160
> [   91.052886] [    T140]  ? kthread_blkcg+0xa0/0xa0
> [   91.054036] [    T140]  ret_from_fork_asm+0x11/0x20
> [   91.055205] [    T140]  </TASK>
> [   91.056011] [    T140] INFO: task T2:526 is blocked on a mutex likely owned by task T3:527.
> [   91.058014] [    T140] INFO: task T3:527 blocked for more than 30 seconds.
> [   91.059682] [    T140]       Not tainted 6.16.0-next-20250730-00003-g5865c79d6085-dirty #261
> [   91.061708] [    T140] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [   91.063825] [    T140] task:T3              state:D stack:0     pid:527   tgid:527   ppid:2      task_flags:0x208040 flags:0x00004000
> [   91.066668] [    T140] Call Trace:
> [   91.067462] [    T140]  <TASK>
> [   91.068121] [    T140]  __schedule+0x137f/0x20c0
> [   91.069244] [    T140]  schedule+0xdc/0x280
> [   91.070264] [    T140]  schedule_preempt_disabled+0x10/0x20
> [   91.071723] [    T140]  __mutex_lock+0x721/0x1590
> [   91.072848] [    T140]  ? __mutex_lock+0x500/0x1590
> [   91.074032] [    T140]  mutex_lock+0x81/0x90
> [   91.075054] [    T140]  t3+0x23/0x30
> [   91.075932] [    T140]  kthread+0x583/0x6e0
> [   91.076953] [    T140]  ? t2+0x70/0x70
> [   91.077865] [    T140]  ? kthread_blkcg+0xa0/0xa0
> [   91.078974] [    T140]  ret_from_fork+0xc8/0x160
> [   91.080109] [    T140]  ? kthread_blkcg+0xa0/0xa0
> [   91.081250] [    T140]  ret_from_fork_asm+0x11/0x20
> [   91.082530] [    T140]  </TASK>
> [   91.083248] [    T140] INFO: task T3:527 is blocked on a mutex likely owned by task T1:525.


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

