Return-Path: <linux-kernel+bounces-885107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A266BC32035
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 17:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 392824EDBBD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 16:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB9932ED52;
	Tue,  4 Nov 2025 16:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IhepErb1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185292561AA;
	Tue,  4 Nov 2025 16:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762273142; cv=none; b=F15Mc6Sx9HsNOJH3vT/uO0kY2gsEw/XcgQBGaLObbQzrZ56P6n7oBmqVhNvnN5ioHvhvWTnKioGeZiNtHdrIDM6Ok7+myOdkiEM2E6nKOIq5wQ3tX17hXhwSt6Pf2fwOs6ZaHEYGGPAnhhonPypbcAV9cT7v6dK8tyeH9cFNazY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762273142; c=relaxed/simple;
	bh=kmpj4lWIyED7ogsuryovdXOfRNSUgLZLKc3VjCHzvC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tdMF1irA8BdsCoe6liZP9+9Nhkvki5M2bV1vdmkqFx124zcMIHLgP4ZpAWLB0IyVqgU/JMOroff68OTqZfBicynLU0LvFt8LQVp/ki/qg9gZo8BC50K2t4t6kC4114e7v6+4t7/W0bU0pW998d/iKjVhHMIThKT8yI1hIin+Xy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IhepErb1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 915A3C4CEF7;
	Tue,  4 Nov 2025 16:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762273141;
	bh=kmpj4lWIyED7ogsuryovdXOfRNSUgLZLKc3VjCHzvC4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=IhepErb1RIJb3YrR26voEf+e64Nwm0Qifq/EBht/92BRMZ9EAT+4i+2hajdxPlrzn
	 7+c/2gbHDP3BEtpNdZHaOkr6wk1b4BMIjVnKIfTwudVZRyeBWAY9davQFWh4m7PnoK
	 /BK/EIYZilxRxenFX8c4dLcwmfni4K8Py4UuzcxnDx0H+d4SdVCLedLk+NgK+PFr99
	 hbW4msFnqLXNVwyCZ7AjVJqnLPqomyK7PBXQ+NAHfoPfskCIwXKo7qHCLrg9Lx1I9p
	 rnJepmIt0kNPeN0IlRrGaQ16rZI27s2lpN7jBGJaVI2hDJBgEPHmM1A/hd8587SIYe
	 me5QZUVw0k9cQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D3341CE0BB3; Tue,  4 Nov 2025 08:18:59 -0800 (PST)
Date: Tue, 4 Nov 2025 08:18:59 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [paulmckrcu:dev.2025.10.30a] [rcutorture]  ab3482dc2a:
 Oops:general_protection_fault,probably_for_non-canonical_address#:#[##]KASAN
Message-ID: <0ae2bb3e-c34d-42cb-860f-aa3c941218e6@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <202511041306.c42f7162-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202511041306.c42f7162-lkp@intel.com>

On Tue, Nov 04, 2025 at 02:04:24PM +0800, kernel test robot wrote:
> 
> hi, Paul,
> 
> we noticed there are fixup! commit for this change in newer branches
> "dev.2025.10.31a" and "dev.2025.11.01a".
> 
> if issue in below report is already captured and fixed, please just ignore this
> report. thanks!
> 
> 
> Hello,
> 
> kernel test robot noticed "Oops:general_protection_fault,probably_for_non-canonical_address#:#[##]KASAN" on:
> 
> commit: ab3482dc2af45fa97143131e0e03e73e18e8fffa ("rcutorture: Make srcu{,d}_torture_init() announce the SRCU type")
> https://github.com/paulmckrcu/linux dev.2025.10.30a
> 
> in testcase: rcutorture
> version: 
> with following parameters:
> 
> 	runtime: 300s
> 	test: default
> 	torture_type: srcud
> 
> 
> 
> config: x86_64-randconfig-101-20251101
> compiler: clang-20
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)

I believe that this is fixed in 978598d63864 ("rcutorture: Make
srcu{,d}_torture_init() announce the SRCU type"), which fixes a blunder
where I failed to initialize the srcu_struct structures for some type
of SRCU readers.

Either way, thank you for your testing efforts, and I will add attribution
given that you did report this earlier.

							Thanx, Paul

> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202511041306.c42f7162-lkp@intel.com
> 
> 
> [   85.244843][  T376] Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] KASAN
> [   85.245696][  T376] KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> [   85.246346][  T376] CPU: 0 UID: 0 PID: 376 Comm: rcu_torture_fak Tainted: G                T   6.17.0-rc1-00079-gab3482dc2af4 #1 PREEMPT(voluntary)  5c143d583914383a8f9ea9c18b817a947366c659
> [   85.247433][  T376] Tainted: [T]=RANDSTRUCT
> [   85.247685][  T376] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [   85.248336][  T376] RIP: 0010:call_srcu (kbuild/src/consumer/kernel/rcu/srcutiny.c:211 (discriminator 1792))
> [   85.248645][  T376] Code: 43 e8 c1 4d 13 00 4d 8d 7c 24 70 4c 89 f8 48 c1 e8 03 80 3c 18 00 74 08 4c 89 ff e8 87 54 2d 00 4d 8b 27 4c 89 e0 48 c1 e8 03 <80> 3c 18 00 74 08 4c 89 e7 e8 0f 55 2d 00 4d 89 34 24 4d 89 37 e8
> All code
> ========
>    0:	43 e8 c1 4d 13 00    	rex.XB call 0x134dc7
>    6:	4d 8d 7c 24 70       	lea    0x70(%r12),%r15
>    b:	4c 89 f8             	mov    %r15,%rax
>    e:	48 c1 e8 03          	shr    $0x3,%rax
>   12:	80 3c 18 00          	cmpb   $0x0,(%rax,%rbx,1)
>   16:	74 08                	je     0x20
>   18:	4c 89 ff             	mov    %r15,%rdi
>   1b:	e8 87 54 2d 00       	call   0x2d54a7
>   20:	4d 8b 27             	mov    (%r15),%r12
>   23:	4c 89 e0             	mov    %r12,%rax
>   26:	48 c1 e8 03          	shr    $0x3,%rax
>   2a:*	80 3c 18 00          	cmpb   $0x0,(%rax,%rbx,1)		<-- trapping instruction
>   2e:	74 08                	je     0x38
>   30:	4c 89 e7             	mov    %r12,%rdi
>   33:	e8 0f 55 2d 00       	call   0x2d5547
>   38:	4d 89 34 24          	mov    %r14,(%r12)
>   3c:	4d 89 37             	mov    %r14,(%r15)
>   3f:	e8                   	.byte 0xe8
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	80 3c 18 00          	cmpb   $0x0,(%rax,%rbx,1)
>    4:	74 08                	je     0xe
>    6:	4c 89 e7             	mov    %r12,%rdi
>    9:	e8 0f 55 2d 00       	call   0x2d551d
>    e:	4d 89 34 24          	mov    %r14,(%r12)
>   12:	4d 89 37             	mov    %r14,(%r15)
>   15:	e8                   	.byte 0xe8
> [   85.249962][  T376] RSP: 0000:ffff88813023fd28 EFLAGS: 00010046
> [   85.250399][  T376] RAX: 0000000000000000 RBX: dffffc0000000000 RCX: dffffc0000000000
> [   85.250914][  T376] RDX: ffffffff852cf470 RSI: ffffffff852d613b RDI: ffffffff852d5d8f
> [   85.251426][  T376] RBP: ffff88813023fd68 R08: 0000000000000002 R09: 0000000000000000
> [   85.251888][  T376] R10: 00000000a56728a8 R11: 000000005e2747a1 R12: 0000000000000000
> [   85.252406][  T376] R13: 0000000000000246 R14: ffff88813023fd78 R15: ffffffffc0183310
> [   85.252874][  T376] FS:  0000000000000000(0000) GS:0000000000000000(0000) knlGS:0000000000000000
> [   85.253484][  T376] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   85.253976][  T376] CR2: 0000562ce1691468 CR3: 000000014ad8a000 CR4: 00000000000406b0
> [   85.254529][  T376] Call Trace:
> [   85.254754][  T376]  <TASK>
> [   85.254937][  T376]  synchronize_srcu (kbuild/src/consumer/kernel/rcu/srcutiny.c:241)
> [   85.255283][  T376]  ? rcu_read_lock_any_held (kbuild/src/consumer/kernel/rcu/update.c:403)
> [   85.255601][  T376] srcu_torture_synchronize_expedited (kbuild/src/consumer/kernel/rcu/rcutorture.c:889) rcutorture
> [   85.256310][  T376] rcu_torture_fakewriter (kbuild/src/consumer/kernel/rcu/rcutorture.c:1903) rcutorture
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20251104/202511041306.c42f7162-lkp@intel.com
> 
> 
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 

