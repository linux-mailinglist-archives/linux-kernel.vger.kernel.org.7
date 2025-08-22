Return-Path: <linux-kernel+bounces-782624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFDDB322C8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 21:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF959AE6595
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 19:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8A62D0C7D;
	Fri, 22 Aug 2025 19:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nveUS9vv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E89D2D12F5
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 19:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755890683; cv=none; b=eEbbhiecDhB0agrcm2ernGmeJZO0uHrOsi17opeVTMbseYBqGSIWc9faafiCiife2+aydCRo6o5fHPU7h2Mv5zlI6DoUUlozGdxAiLjk0kExri0FmBRegevoCIbmsiiPSprgCwURNTU5qWJKDX3HkXkyvI8xaI+Uik3yP/2plMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755890683; c=relaxed/simple;
	bh=4WNcvAhEnu1kFeqaiL1uIiSb2Zisx3CyAgoWA3IN+7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CxxnivFhDYqJ91LN6ql98OvJGh7N/M4pdtqq5rgtHiu7kjesXahWMndweVvtx3hQX+w26GtU3C8cmqaqGvfd7qGXmDz4BYgw/DuOa7XmuCXX2n8P/CO0i+R0/jaWQb29f48tkrDVBwrIWgr9xFrMoTh+eXm2rHKTsJmineXQBFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nveUS9vv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E266C4CEF1;
	Fri, 22 Aug 2025 19:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755890683;
	bh=4WNcvAhEnu1kFeqaiL1uIiSb2Zisx3CyAgoWA3IN+7M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nveUS9vvswV5WUfmiVKZqCi1TSsCoUPb7YVJCkPSOlwTevi6sFPZoGfbhSjD4lvfK
	 giU6cg6gr8PKh69Fix2QMQQ1AGaWdfm8JHNh0niakPFCErbDB5al1hascyGBmmKjyZ
	 jokxotzX3+sYfiaFd4N/K8EeI0GrtGJBtou0I0CYej29J/z8W9+es3XOHrlwreSJUz
	 dSdHBIACyG4WO/AS127N45RT0TDL5ZMMJ9exjEjnklrQNmtTpcvN/zdgnVtki6uibT
	 msEQ5dn5euRW80apqDbu4lcqcinlQFwNNEyoWI17idvdowtzjR5PW2polMXVNIOyPE
	 5R4YlvgsJ6KKQ==
Date: Fri, 22 Aug 2025 12:24:37 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Liao Yuanhong <liaoyuanhong@vivo.com>,
	Pu Lehui <pulehui@huawei.com>, Tao Chen <chen.dylane@linux.dev>,
	Tengda Wu <wutengda@huaweicloud.com>,
	Ye Weihua <yeweihua4@huawei.com>
Subject: Re: [GIT PULL] tracing: Fixes for v6.17
Message-ID: <20250822192437.GA458494@ax162>
References: <20250822124933.74965607@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822124933.74965607@gandalf.local.home>

Hi Steve,

On Fri, Aug 22, 2025 at 12:49:33PM -0400, Steven Rostedt wrote:
> - Allocate and copy ftrace hash for reader of ftrace filter files
> 
>   When the set_ftrace_filter or set_ftrace_notrace files are open for read,
>   an iterator is created and sets its hash pointer to the associated hash that
>   represents filtering or notrace filtering to it. The issue is that the hash
>   it points to can change while the iteration is happening. All the locking
>   used to access the tracer's hashes are released which means those hashes can
>   change or even be freed. Using the hash pointed to by the iterator can cause
>   UAF bugs or similar.
> 
>   Have the read of these files allocate and copy the corresponding hashes and
>   use that as that will keep them the same while the iterator is open. This
>   also simplifies the code as opening it for write already does an allocate
>   and copy, and now that the read is doing the same, there's no need to check
>   which way it was opened on the release of the file, and the iterator hash
>   can always be freed.
...
> Steven Rostedt (2):
>       ftrace: Also allocate and copy hash for reading of filter files

I just bisected a crash that I see when running LTP's read_all test
(which I have statically compiled at [1]) on /sys:

# bad: [0f4c93f7eb861acab537dbe94441817a270537bf] Add linux-next specific files for 20250822
# good: [3957a5720157264dcc41415fbec7c51c4000fc2d] Merge tag 'cgroup-for-6.17-rc2-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup
git bisect start '0f4c93f7eb861acab537dbe94441817a270537bf' '3957a5720157264dcc41415fbec7c51c4000fc2d'
# bad: [1eca822fd0fc88c51825a929dee4a82aa37de102] Merge branch 'cpufreq/arm/linux-next' of https://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git
git bisect bad 1eca822fd0fc88c51825a929dee4a82aa37de102
# bad: [6fdae20d32f045dad3f9d89a7bc53a201ae6061c] Merge branch 'for-next' of https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git
git bisect bad 6fdae20d32f045dad3f9d89a7bc53a201ae6061c
# bad: [b16cd43ecfee91682ed0f6c7e6686252812a1d53] Merge branch 'mm-unstable' of https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
git bisect bad b16cd43ecfee91682ed0f6c7e6686252812a1d53
# good: [c1a5408bb0df483c9a6e1b0bb585aa120304b869] Merge branch 'i2c/i2c-host-fixes' of https://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git
git bisect good c1a5408bb0df483c9a6e1b0bb585aa120304b869
# good: [ad0cb3a198c18e9ea623415998371967625b7a6f] mm/huge_memory: convert "tva_flags" to "enum tva_type"
git bisect good ad0cb3a198c18e9ea623415998371967625b7a6f
# bad: [219d594f4ae85b505c8900149eeae48de58714ef] Merge branch 'for-linux-next-fixes' of https://gitlab.freedesktop.org/drm/misc/kernel.git
git bisect bad 219d594f4ae85b505c8900149eeae48de58714ef
# bad: [117c87380b3a3f9fbc925d39f20fec65cfc998f7] Merge branch 'msm-fixes' of https://gitlab.freedesktop.org/drm/msm.git
git bisect bad 117c87380b3a3f9fbc925d39f20fec65cfc998f7
# good: [553666f839b86545300773954df7426a45c169c4] drm/msm/kms: move snapshot init earlier in KMS init
git bisect good 553666f839b86545300773954df7426a45c169c4
# bad: [d1bd269dc6608aef35e150ec60644545f2084584] Merge branch 'trace/fixes' of https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
git bisect bad d1bd269dc6608aef35e150ec60644545f2084584
# good: [cd6e4faba96fe41d6b686e144b96dad5e6f2e771] ring-buffer: Remove redundant semicolons
git bisect good cd6e4faba96fe41d6b686e144b96dad5e6f2e771
# bad: [48d06e78b7cba941e991da71ca351f5104ea927e] ftrace: Also allocate and copy hash for reading of filter files
git bisect bad 48d06e78b7cba941e991da71ca351f5104ea927e
# good: [edede7a6dcd7435395cf757d053974aaab6ab1c2] trace/fgraph: Fix the warning caused by missing unregister notifier
git bisect good edede7a6dcd7435395cf757d053974aaab6ab1c2
# first bad commit: [48d06e78b7cba941e991da71ca351f5104ea927e] ftrace: Also allocate and copy hash for reading of filter files

$ sudo ./read_all -d /sys
tst_test.c:1459: TINFO: Timeout per run is 0h 05m 00s
read_all.c:216: TINFO: read(/sys/kernel/mm/page_idle/bitmap): EINVAL (22)
read_all.c:204: TINFO: open(/sys/kernel/mm/hugepages/hugepages-1048576kB/demote): EACCES (13)
read_all.c:204: TINFO: open(/sys/kernel/tracing/osnoise/per_cpu/cpu7/timerlat_fd): EINVAL (22)
read_all.c:204: TINFO: open(/sys/kernel/tracing/osnoise/per_cpu/cpu6/timerlat_fd): EINVAL (22)
read_all.c:204: TINFO: open(/sys/kernel/tracing/osnoise/per_cpu/cpu5/timerlat_fd): EINVAL (22)
read_all.c:204: TINFO: open(/sys/kernel/tracing/osnoise/per_cpu/cpu4/timerlat_fd): EINVAL (22)
read_all.c:204: TINFO: open(/sys/kernel/tracing/osnoise/per_cpu/cpu3/timerlat_fd): EINVAL (22)
read_all.c:204: TINFO: open(/sys/kernel/tracing/osnoise/per_cpu/cpu2/timerlat_fd): EINVAL (22)
read_all.c:204: TINFO: open(/sys/kernel/tracing/osnoise/per_cpu/cpu1/timerlat_fd): EINVAL (22)
read_all.c:204: TINFO: open(/sys/kernel/tracing/osnoise/per_cpu/cpu0/timerlat_fd): EINVAL (22)
^CSending SIGKILL to test process...
tst_test.c:1503: TINFO: Killed the leftover descendant processes
tst_test.c:1509: TINFO: If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1
tst_test.c:1511: TBROK: Test killed! (timeout?)

Summary:
passed   0
failed   0
broken   1
skipped  0
warnings 0

$ dmesg
[   62.221518] BUG: kernel NULL pointer dereference, address: 0000000000000000
[   62.222457] #PF: supervisor read access in kernel mode
[   62.223068] #PF: error_code(0x0000) - not-present page
[   62.223720] PGD 1076a2067 P4D 10fe33067 PUD 112688067 PMD 0
[   62.224436] Oops: Oops: 0000 [#1] SMP NOPTI
[   62.224939] CPU: 4 UID: 0 PID: 1145 Comm: read_all Not tainted 6.17.0-rc2-00006-g48d06e78b7cb #1 PREEMPT(full)  ab6dff6fe4772c3d341055188b1594d9637c1b0d
[   62.226579] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unknown 02/02/2022
[   62.227561] RIP: 0010:ftrace_regex_open+0x153/0x280
[   62.228177] Code: 48 89 04 24 e8 4e af ff ff 48 8b 04 24 48 89 c7 48 8b 00 49 39 fe 75 e8 48 c7 c7 80 b6 55 ba e8 93 7e 10 01 48 8b 45 50 eb 0b <8b> 3e e8 d6 bc ff ff 48 89 45 50 48 85 c0 0f 84 fd 00 00 00 41 f6
[   62.230434] RSP: 0018:ff4bded7c4e5bba0 EFLAGS: 00010246
[   62.231052] RAX: 0000000000000000 RBX: ffffffffba728660 RCX: 0000000000000000
[   62.231983] RDX: ff172e52cc1b2180 RSI: 0000000000000000 RDI: ffffffffba728698
[   62.232852] RBP: ff172e52c44f3500 R08: ff172e52c3db6c00 R09: ff172e52c3db6c00
[   62.233725] R10: ff4bded7c4e5bb88 R11: 00000000ffffffff R12: 0000000000000000
[   62.234594] R13: 0000000000000000 R14: 0000000000000000 R15: ff172e52d45d1240
[   62.235465] FS:  0000000000449778(0000) GS:ff172e5674a92000(0000) knlGS:0000000000000000
[   62.236433] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   62.237110] CR2: 0000000000000000 CR3: 00000001144fd006 CR4: 0000000000771ef0
[   62.237968] PKRU: 55555554
[   62.238321] Call Trace:
[   62.238632]  <TASK>
[   62.238898]  ? __pfx_stack_trace_filter_open+0x10/0x10
[   62.239565]  do_dentry_open+0x23d/0x480
[   62.240035]  vfs_open+0x30/0x100
[   62.240448]  path_openat+0x7ea/0x12e0
[   62.240900]  ? srso_alias_return_thunk+0x5/0xfbef5
[   62.241511]  ? __memcg_slab_free_hook+0xf4/0x140
[   62.242065]  do_filp_open+0xd8/0x180
[   62.242518]  ? alloc_fd+0x12e/0x190
[   62.242944]  do_sys_openat2+0x88/0xe0
[   62.243409]  __x64_sys_open+0x5f/0xa0
[   62.243852]  do_syscall_64+0x81/0x970
[   62.244331]  ? srso_alias_return_thunk+0x5/0xfbef5
[   62.244899]  ? do_syscall_64+0x81/0x970
[   62.245398]  ? srso_alias_return_thunk+0x5/0xfbef5
[   62.245972]  ? __x64_sys_open+0x5f/0xa0
[   62.246462]  ? srso_alias_return_thunk+0x5/0xfbef5
[   62.247036]  ? do_syscall_64+0x81/0x970
[   62.247528]  ? srso_alias_return_thunk+0x5/0xfbef5
[   62.248093]  ? __irq_exit_rcu+0x4c/0xf0
[   62.248588]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   62.249196] RIP: 0033:0x4243b8
[   62.249590] Code: 0f 05 48 83 f8 da 75 08 4c 89 c0 48 89 d6 0f 05 c3 48 89 f8 4d 89 c2 48 89 f7 4d 89 c8 48 89 d6 4c 8b 4c 24 08 48 89 ca 0f 05 <c3> e9 e1 ff ff ff 48 8d 3d 9b 52 02 00 e9 8a 06 00 00 48 8d 3d 8f
[   62.251882] RSP: 002b:00007ffedeaeff18 EFLAGS: 00000286 ORIG_RAX: 0000000000000002
[   62.252805] RAX: ffffffffffffffda RBX: 0000000000000800 RCX: 00000000004243b8
[   62.253687] RDX: 0000000000000000 RSI: 0000000000008800 RDI: 00007ffedeaf0040
[   62.254558] RBP: 000000002150ffc1 R08: 0000000000000000 R09: 0000000000000000
[   62.255421] R10: 0000000000000000 R11: 0000000000000286 R12: 00007febbedb9000
[   62.256280] R13: 000000000042b00c R14: 00007ffedeaf0040 R15: 000000000043f130
[   62.257129]  </TASK>
[   62.257428] Modules linked in:
[   62.257808] CR2: 0000000000000000
[   62.258213] ---[ end trace 0000000000000000 ]---
[   62.258795] RIP: 0010:ftrace_regex_open+0x153/0x280
[   62.259400] Code: 48 89 04 24 e8 4e af ff ff 48 8b 04 24 48 89 c7 48 8b 00 49 39 fe 75 e8 48 c7 c7 80 b6 55 ba e8 93 7e 10 01 48 8b 45 50 eb 0b <8b> 3e e8 d6 bc ff ff 48 89 45 50 48 85 c0 0f 84 fd 00 00 00 41 f6
[   62.261614] RSP: 0018:ff4bded7c4e5bba0 EFLAGS: 00010246
[   62.262231] RAX: 0000000000000000 RBX: ffffffffba728660 RCX: 0000000000000000
[   62.263084] RDX: ff172e52cc1b2180 RSI: 0000000000000000 RDI: ffffffffba728698
[   62.263938] RBP: ff172e52c44f3500 R08: ff172e52c3db6c00 R09: ff172e52c3db6c00
[   62.264796] R10: ff4bded7c4e5bb88 R11: 00000000ffffffff R12: 0000000000000000
[   62.265659] R13: 0000000000000000 R14: 0000000000000000 R15: ff172e52d45d1240
[   62.266526] FS:  0000000000449778(0000) GS:ff172e5674a92000(0000) knlGS:0000000000000000
[   62.267488] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   62.268171] CR2: 0000000000000000 CR3: 00000001144fd006 CR4: 0000000000771ef0
[   62.269026] PKRU: 55555554
[   62.269386] note: read_all[1145] exited with irqs disabled

[1]: https://github.com/nathanchance/env/raw/a98b8aa3a7017f6b1d94ee26dd217a968da81dd1/bin/x86_64/read_all

If there is any other information I can provide or patches I can test, I
am happy to do so.

Cheers,
Nathan

