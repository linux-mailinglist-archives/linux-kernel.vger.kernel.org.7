Return-Path: <linux-kernel+bounces-720095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 668B6AFB6EF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 17:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2753817B6FD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 15:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97CC62E2670;
	Mon,  7 Jul 2025 15:11:50 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9A052F88
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 15:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751901110; cv=none; b=g419iZRilCNVjN7yGC0Q9RpUROpyt5apN6JfC+27VqVBGl+5ddb9XJ/dzTXLR5ECVlCLpcgX9ecf6BDsG/OEFiwAdvDIDLhG94TKq9CgkgrZJc3eHWGnuye9l4uo3k169xXzCixVwX54msczjP1ydPWTbKyazWPYx35eqd+Gftg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751901110; c=relaxed/simple;
	bh=YGQySKMSZlfdjvJLKUGdKVtpld5XdJV9DT3kBGUJXeE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qDWqM3xCL/G9mSHqlm1If6UjkhtYSt2c9xCmxHzjcTPctfaAJ03lfDgSeTHpKSbkhw1RYQgKWojn0XTFin7U6jYSAONDS6mOW+cpY+PIBUlMvOFamQx81qLIJcA67jvVnOLAiwRrvqhm/O5XVdtyRmw/R8BDcYrIupQbp1Cke/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 658301401AD;
	Mon,  7 Jul 2025 15:11:39 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id 2898120018;
	Mon,  7 Jul 2025 15:11:37 +0000 (UTC)
Date: Mon, 7 Jul 2025 11:11:22 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Li,Rongqing" <lirongqing@baidu.com>
Cc: "oleg@redhat.com" <oleg@redhat.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "vschneid@redhat.com"
 <vschneid@redhat.com>, "mgorman@suse.de" <mgorman@suse.de>,
 "bsegall@google.com" <bsegall@google.com>, "dietmar.eggemann@arm.com"
 <dietmar.eggemann@arm.com>, "vincent.guittot@linaro.org"
 <vincent.guittot@linaro.org>, "juri.lelli@redhat.com"
 <juri.lelli@redhat.com>, "peterz@infradead.org" <peterz@infradead.org>,
 "mingo@redhat.com" <mingo@redhat.com>
Subject: Re: divide error in x86 and cputime
Message-ID: <20250707111122.7111ce31@batman.local.home>
In-Reply-To: <78a0d7bb20504c0884d474868eccd858@baidu.com>
References: <78a0d7bb20504c0884d474868eccd858@baidu.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 76twc9mye713furi37rtnucr3ifmsbam
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 2898120018
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/rJAGqviXk2XJWB7qRLaQNr5tiIhBTXN0=
X-HE-Tag: 1751901097-911808
X-HE-Meta: U2FsdGVkX1+dRGOY7UOTen1xp29QdmZLLTZGnP18d7iYgrAER2usWah25Tm/XVC76JchlVwhAtxcNmx/oA/Wma2Y+o/Lt2uNCgz/70zaJnIsjCIvHRZNbCYFWCW5igO4tW+4Nw3LP6yeDbXHh0r/MaPBBER9kvPZpCvmQOIGtArbPqxXtdRswVDEK6yGhHhCWEpoCjPJRjTm3OlhvGfBnprzYDeV0Mvw8D8aldhlVCiWvjmMCjRbexVnduSGI8TeQjBnYw0OuuSVAdDaty4JfTaT+3hYzk/Km38nhh4if6DWDvMgWTwnk9tKEjaYiEB9rHSV/2bqqeLCJPvIdspCtz2FCBxZud4D

On Mon, 7 Jul 2025 08:14:41 +0000
"Li,Rongqing" <lirongqing@baidu.com> wrote:

> Hi:
> 
> I see a divide error on x86 machine, the stack is below:
> 
> 
> [78250815.703847] divide error: 0000 [#1] PREEMPT SMP NOPTI
> [78250815.703852] CPU: 127 PID: 83435 Comm: killall Kdump: loaded Tainted: P           OE K   5.10.0 #1

Did you see this on a 5.10 kernel?

Do you see it on something more recent? Preferably the 6.15 or 6.16.

-- Steve

> [78250815.703853] Hardware name: Inspur SSINSPURMBX-XA3-100D-B356/NF5280A6, BIOS 3.00.21 06/27/2022
> [78250815.703859] RIP: 0010:cputime_adjust+0x55/0xb0
> [78250815.703860] Code: 3b 4c 8b 4d 10 48 89 c6 49 8d 04 38 4c 39 c8 73 38 48 8b 45 00 48 8b 55 08 48 85 c0 74 16 48 85 d2 74 49 48 8d 0c 10 49 f7 e1 <48> f7 f1 49 39 c0 4c 0f 42 c0 4c 89 c8 4c 29 c0 48 39 c7 77 25 48
> [78250815.703861] RSP: 0018:ffffa34c2517bc40 EFLAGS: 00010887
> [78250815.703864] RAX: 69f98da9ba980c00 RBX: ffff976c93d2a5e0 RCX: 0000000709e00900
> [78250815.703864] RDX: 00f5dfffab0fc352 RSI: 0000000000000082 RDI: ff07410dca0bcd5e
> [78250815.703865] RBP: ffffa34c2517bc70 R08: 00f5dfff54f8e5ce R09: fffd213aabd74626
> [78250815.703866] R10: ffffa34c2517bed8 R11: 0000000000000000 R12: ffff976c93d2a5f0
> [78250815.703867] R13: ffffa34c2517bd78 R14: ffffa34c2517bd70 R15: 0000000000001000
> [78250815.703868] FS:  00007f58060f97a0(0000) GS:ffff976afe9c0000(0000) knlGS:0000000000000000
> [78250815.703869] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [78250815.703870] CR2: 00007f580610e000 CR3: 0000017e3b3d2004 CR4: 0000000000770ee0
> [78250815.703870] PKRU: 55555554
> [78250815.703871] Call Trace:
> [78250815.703877]  thread_group_cputime_adjusted+0x4a/0x70
> [78250815.703881]  do_task_stat+0x2ed/0xe00
> [78250815.703885]  ? khugepaged_enter_vma_merge+0x12/0xd0
> [78250815.703888]  proc_single_show+0x51/0xc0
> [78250815.703892]  seq_read_iter+0x185/0x3c0
> [78250815.703895]  seq_read+0x106/0x150
> [78250815.703898]  vfs_read+0x98/0x180
> [78250815.703900]  ksys_read+0x59/0xd0
> [78250815.703904]  do_syscall_64+0x33/0x40
> [78250815.703907]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [78250815.703910] RIP: 0033:0x318aeda360
> 
> 
> It caused by a process with many threads running very long, and utime+stime overflowed 64bit, then cause the below div
> 
> mul_u64_u64_div_u64(0x69f98da9ba980c00, 0xfffd213aabd74626, 0x09e00900);
> 
> I see the comments of mul_u64_u64_div_u64() say:
> 
> Will generate an #DE when the result doesn't fit u64, could fix with an
> __ex_table[] entry when it becomes an issu
> 
> 
> Seem __ex_table[] entry for div does not work ?
> 
> Thanks
> 
> -Li
> 
> 


