Return-Path: <linux-kernel+bounces-739950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 617EAB0CD7A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 01:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADF311C20B0F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 23:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBC0245008;
	Mon, 21 Jul 2025 23:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gaa2u4S5"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F54B242D72
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 23:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753138823; cv=none; b=T9Ew/9oIO7eRHG7T438vosOEyFuDeWSDBgAwMmr3GUpUA5ud/aLusRMHAD3IPUOFDCsySxdAyIaB6i3uky226shqG+KZ9fsToLOCUBqbYHwHQ3/rrSoxWzKkS9W9FNR/GnvttG5B4qB9tIunZHeWFRpYVYBNJxUGU+CJJEk/qrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753138823; c=relaxed/simple;
	bh=IBXdSjkzXToyIsK2szk6CIoADOtMA/vN9liJcysacZs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kg6WY3bt8e84jiz0FGMsT1Fw85k07wx52ZRuCLv/8Hwro8T3GySq7B356q95aSd/wyJhKhYvoD2mWkftnXErKyzTOoQnUtiXohYIcIDZodvLJiLhrmxUCBYa9FgTfcsLGmeMsFqaYBasqTOgYuelzFmHbLvPghED90vtAYxPtgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gaa2u4S5; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-75ab147e0f7so2176052b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 16:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753138820; x=1753743620; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=A4zRviwi98gBCXXrkevJjeMR4Fn3Bc5d+Hcm8yb/s1w=;
        b=Gaa2u4S5UodRyf7EgEfu4XAcU+x5Mbn0sHdCpnrKmIQEhhKw0qevEcKL0IH29gg6bN
         hygKuMYlr/GIGVJUZRj3DHqf7sV9e7oUf2xBt9W4zWdn33W20u053YOXXHbgrsa6nYo/
         qBc9W/C+ojn0Q0xt7j37l0WZslcavkkenXioEhGI2sZeFO/IaVeIg01b5yUvZuyWosQ9
         lA5bRUtXONwcTL/SQZI/dnmLYAygh+7dZJwmUbUh21i1VOzlmwAOk/DMrCsWh5ePnXby
         Qcpp5jkrKnvsI/GsvJ0boIDSAKuOvWTG6SqNNfeIKbCz/1maqBh2M9g0DnGfoStHg8IJ
         eHmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753138820; x=1753743620;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A4zRviwi98gBCXXrkevJjeMR4Fn3Bc5d+Hcm8yb/s1w=;
        b=Bgqm0cnppImfavofvQH+OTqnhRcxNjCu4b2DaUWZWVc+wqCdZHQVbrAIS9AgP0eUNJ
         Tk7pXN3nB9a73RhjlEZ+CTB9mDUwiaFjx0Odzma0FmDn6qesqyoepZutQ4lSmPyhEvk7
         Ln6NL8eO+3Rbvj9tEsd0O2JipWa24IAhcHb5H8nH3wtO0m52pHL9QF8TJmQBUbILZQUr
         XDuRwqjiFj71oU0Ql0TJ1G+ZOKQz4qIP/3NxBQ2ypgH2Cq5Fg2djJF5w1wu7joQ20nVv
         jbq066kFzTvUpt3vUAbM71RFXuVerlGr0f6Lyb4HYpG3lYcvbI2jaTcGnKC07qpbdeAt
         FNmw==
X-Forwarded-Encrypted: i=1; AJvYcCW+I9hZjvjlpRZ7ZbHrTlbCoHhh3r1gmcEPjQTnh4z2DQ31iN5wuUssP1h81OrWVDsbUXgJ8KPl6jEkBv8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5n89FMWBSFBmxXEoBoo+F0sap4ZGf5eaPAf3N9s6mCLgasCBT
	3tR3pje+DR7ChoXZpaycOqHccO2cndeovgNP4zZDJD6o9M8f5M6MYkMPVVgJgIQj8EcuOsSaohh
	Bg6Ihow==
X-Google-Smtp-Source: AGHT+IEbWalhqro2w+3GvtYOXzOjIhWoVd8vuAeTJn3HOEvfRkfsmvkO2lPbYXdrUt0NsrbO3vm8olNe/yg=
X-Received: from pfbef6.prod.google.com ([2002:a05:6a00:2c86:b0:747:b682:5cc0])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1994:b0:749:122f:5fe5
 with SMTP id d2e1a72fcca58-756ea7bf7b0mr34179699b3a.18.1753138819761; Mon, 21
 Jul 2025 16:00:19 -0700 (PDT)
Date: Mon, 21 Jul 2025 22:59:48 +0000
In-Reply-To: <202507200931.7a89ecd8-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <202507200931.7a89ecd8-lkp@intel.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250721230018.3844892-1-kuniyu@google.com>
Subject: Re: [linus:master] [neighbour]  [confidence: ] f7f5273863: Oops:general_protection_fault,probably_for_non-canonical_address#:#[##]SMP_KASAN
From: Kuniyuki Iwashima <kuniyu@google.com>
To: oliver.sang@intel.com
Cc: edumazet@google.com, gnaaman@drivenets.com, kuba@kernel.org, 
	kuniyu@google.com, linux-kernel@vger.kernel.org, lkp@intel.com, 
	netdev@vger.kernel.org, oe-lkp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

From: kernel test robot <oliver.sang@intel.com>
Date: Sun, 20 Jul 2025 16:12:07 +0800
> Hello,
> 
> kernel test robot noticed "Oops:general_protection_fault,probably_for_non-canonical_address#:#[##]SMP_KASAN" on:
> 
> commit: f7f52738637f4361c108cad36e23ee98959a9006 ("neighbour: Create netdev->neighbour association")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> [test failed on linus/master      f4a40a4282f467ec99745c6ba62cb84346e42139]
> [test failed on linux-next/master d086c886ceb9f59dea6c3a9dae7eb89e780a20c9]
> 
> in testcase: boot
> 
> config: x86_64-randconfig-123-20250718
> compiler: clang-20
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> +----------------------------------------------------------------------------------+------------+------------+
> |                                                                                  | a01a67ab2f | f7f5273863 |
> +----------------------------------------------------------------------------------+------------+------------+
> | BUG_RAWv6                                                                        | 7          |            |
> | WARNING:at_mm/slab_common.c:#kmem_cache_destroy                                  | 7          |            |
> | RIP:kmem_cache_destroy                                                           | 7          |            |
> | UBSAN:signed-integer-overflow_in_include/linux/atomic/atomic-arch-fallback.h     | 7          |            |
> | Oops:general_protection_fault,probably_for_non-canonical_address#:#[##]SMP_KASAN | 0          | 7          |
> | KASAN:null-ptr-deref_in_range[#-#]                                               | 0          | 7          |
> | RIP:neigh_flush_dev.llvm                                                         | 0          | 7          |
> | Kernel_panic-not_syncing:Fatal_exception_in_interrupt                            | 0          | 7          |
> +----------------------------------------------------------------------------------+------------+------------+
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202507200931.7a89ecd8-lkp@intel.com
> 
> 
> [   21.205230][    T1] systemd[1]: RTC configured in localtime, applying delta of 0 minutes to system time.
> [   21.328503][    T1] NET: Registered PF_INET6 protocol family
> [   21.412618][    T1] IPv6: Attempt to unregister permanent protocol 6
> [   21.433405][    T1] IPv6: Attempt to unregister permanent protocol 136
> [   21.443410][    T1] IPv6: Attempt to unregister permanent protocol 17

Probably this is IPv6 module unloading path (init failed).

Then, neigh_table_clear() calls neigh_ifdown() with dev=NULL,
which is not handled in neigh_flush_dev().

I'll post a fix.


btw, it would be nice to update CC lists with .mailmap as my address
was stale one and I missed this report.



> [   22.737430][    T1] Oops: general protection fault, probably for non-canonical address 0xdffffc00000001a0: 0000 [#1] SMP KASAN
> [   22.738764][    T1] KASAN: null-ptr-deref in range [0x0000000000000d00-0x0000000000000d07]
> [   22.739736][    T1] CPU: 1 UID: 0 PID: 1 Comm: systemd Tainted: G                T  6.12.0-rc6-01246-gf7f52738637f #1
> [   22.740972][    T1] Tainted: [T]=RANDSTRUCT
> [   22.741513][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [ 22.742641][ T1] RIP: 0010:neigh_flush_dev.llvm.6395807810224103582 (kbuild/src/consumer/net/core/neighbour.c:380) 
> [ 22.743530][ T1] Code: c1 e8 03 42 8a 04 38 84 c0 0f 85 15 05 00 00 31 c0 41 83 3e 0a 0f 94 c0 48 8d 1c c3 48 81 c3 f8 0c 00 00 48 89 d8 48 c1 e8 03 <42> 80 3c 38 00 74 08 48 89 df e8 f7 49 93 fe 4c 8b 3b 4d 85 ff 0f
> All code
> ========
>    0:	c1 e8 03             	shr    $0x3,%eax
>    3:	42 8a 04 38          	mov    (%rax,%r15,1),%al
>    7:	84 c0                	test   %al,%al
>    9:	0f 85 15 05 00 00    	jne    0x524
>    f:	31 c0                	xor    %eax,%eax
>   11:	41 83 3e 0a          	cmpl   $0xa,(%r14)
>   15:	0f 94 c0             	sete   %al
>   18:	48 8d 1c c3          	lea    (%rbx,%rax,8),%rbx
>   1c:	48 81 c3 f8 0c 00 00 	add    $0xcf8,%rbx
>   23:	48 89 d8             	mov    %rbx,%rax
>   26:	48 c1 e8 03          	shr    $0x3,%rax
>   2a:*	42 80 3c 38 00       	cmpb   $0x0,(%rax,%r15,1)		<-- trapping instruction
>   2f:	74 08                	je     0x39
>   31:	48 89 df             	mov    %rbx,%rdi
>   34:	e8 f7 49 93 fe       	call   0xfffffffffe934a30
>   39:	4c 8b 3b             	mov    (%rbx),%r15
>   3c:	4d 85 ff             	test   %r15,%r15
>   3f:	0f                   	.byte 0xf
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	42 80 3c 38 00       	cmpb   $0x0,(%rax,%r15,1)
>    5:	74 08                	je     0xf
>    7:	48 89 df             	mov    %rbx,%rdi
>    a:	e8 f7 49 93 fe       	call   0xfffffffffe934a06
>    f:	4c 8b 3b             	mov    (%rbx),%r15
>   12:	4d 85 ff             	test   %r15,%r15
>   15:	0f                   	.byte 0xf
> [   22.745585][    T1] RSP: 0000:ffff88810026f408 EFLAGS: 00010206
> [   22.746292][    T1] RAX: 00000000000001a0 RBX: 0000000000000d00 RCX: 0000000000000000
> [   22.747239][    T1] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffffc0631640
> [   22.748176][    T1] RBP: ffff88810026f470 R08: 0000000000000000 R09: 0000000000000000
> [   22.749092][    T1] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> [   22.750004][    T1] R13: ffffffffc0625250 R14: ffffffffc0631640 R15: dffffc0000000000
> [   22.750956][    T1] FS:  00007f575cb83940(0000) GS:ffff8883aee00000(0000) knlGS:0000000000000000
> [   22.752016][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   22.752799][    T1] CR2: 00007f575db40008 CR3: 00000002bf936000 CR4: 00000000000406f0
> [   22.753770][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   22.754687][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   22.755620][    T1] Call Trace:
> [   22.756076][    T1]  <TASK>
> [ 22.756491][ T1] ? show_regs (kbuild/src/consumer/arch/x86/kernel/dumpstack.c:?) 
> [ 22.757025][ T1] ? __die_body.llvm.18112809324785033505 (kbuild/src/consumer/arch/x86/kernel/dumpstack.c:421) 
> [ 22.757760][ T1] ? die_addr (kbuild/src/consumer/arch/x86/kernel/dumpstack.c:?) 
> [ 22.758289][ T1] ? exc_general_protection (kbuild/src/consumer/arch/x86/kernel/traps.c:751) 
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20250720/202507200931.7a89ecd8-lkp@intel.com
> 
> 
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 

