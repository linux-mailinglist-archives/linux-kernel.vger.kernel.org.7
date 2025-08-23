Return-Path: <linux-kernel+bounces-782827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A84B325C9
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 02:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 975B74E1051
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 00:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8D42C1A2;
	Sat, 23 Aug 2025 00:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K/FnR23D"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F44E1CF96
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 00:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755908886; cv=none; b=Z9E/zdaofCQ1Dmtk4h7XhcM5BMs+yRGfk4PAVJpue2Uucv5ANG1Dztk1NqxSd7glXeQfVYBEJkNWEVtYWKdx5/4YAxIf9XKd81veyXQ/b/r+eOTL2ww5OOIoQbWVaczDQ/lxq5AcR1VNtZTyvCU9vUTNd6cTNjCTWV5DXk4R+1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755908886; c=relaxed/simple;
	bh=hyOd0YUD1N0ACAgcnS/fs0ogTMo7hyxUJ0NPL9gffQo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rmcTNzqjNmpgQJViUiW2T067wEE8axnoi4LYbGB0a5GkVTmqEBEhdvvzkdJeR85rT2DBTydXwrNFpBFaMfnyZBExGPSbeNbd6BBszgwtDfuctALPw4w5nzYpBW3zp9m/nY2jTKptrAqLHXdzX0DgOWLbHcwra/NyPI4w1HO0l3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K/FnR23D; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-76e2eb9bb19so4982025b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 17:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755908884; x=1756513684; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TkEHMhAEdYNKCzTUp7mzIlSinN5tn5GnFa4nP8/febw=;
        b=K/FnR23DqLSRAItd7b8B/rNde4RmWhD64I8nEsx723n3EZWTPXV+mij86JISgs1V4G
         j5YjDdn561mHJc3lve1tux89laVuvP+0gwzjyj7zjDcfty76jOBXve8EycUpsQdztlbz
         SmRc4c+nRjIyZ4ngRLdNCDa4BQQCKYA440s3fnBaJ47HI5MjqFO1LaYij0tkQA+pkOUS
         ym6cxpaMU4F3Wx6q8NSPrev4VWkZYPpntoLi2fyXWTA/aGdePYiUTUYd26vahCKI/2Ga
         2nSPd2JNyV5F9QAhIPklprki1HopcZugQPF4BfTyS1sfUXcVIjaxQjTHSzRRFw4RMOBz
         M12Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755908884; x=1756513684;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TkEHMhAEdYNKCzTUp7mzIlSinN5tn5GnFa4nP8/febw=;
        b=JL5uVk5xtnK4k/y+KpKg92ePVZ//h+QOQdYVgkFC6BeMO/GmBwBntSarp//xbABPIU
         Luha3rSotqV8l8GIf6vvhYl3UrOO/0OpNOQX2qSP7ijuez4/4u6ymSuZw9ks3r1tchtY
         GZW1BDvLwjn4EdB2eHTrdL/kiNjUfzLEKodk09CP0RbxWab0F5y9ZTU050gNkUrPXVQw
         hmVlsvS8ft1rRdxNf/jg5xC7ZIIYV3GszLg0se5myva+3d1ajzpxUD5FB4vqcD/wGcfV
         SYY6iKwQ52nAejMsU6dDNOpdgil0k/BDqkXXCE5pJ6X8g2boUndMF0E0IbGN4Qur9LXq
         ui6A==
X-Forwarded-Encrypted: i=1; AJvYcCXJLKD3hMyhsIKPJR+ndvf8VacBc3uLlyEsAbYtsgXNWgw+B/QOY6qDKjJvqfUde/6V0pMWsjQf/0thGnk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnATtLpyDb3hSaHSMNwDDN33iDgUFQ1kuZeek4NDAmpiqyllaE
	uYbqUujg8UdmHRAt91VdmzUw9fUBsfOK8cQGNo+0IrJ25+VuUvrPcc6kVNFQkKgq6Ek+zboctUO
	0DTjKLA==
X-Google-Smtp-Source: AGHT+IF+WKzD3QdfmIKmm1OBwD2lCA0RvTEGx7cbeiNK8nRM8vTVQFF9HTAQzlFvfmsfwWAdhsCwnau8cvU=
X-Received: from pfbgo7.prod.google.com ([2002:a05:6a00:3b07:b0:76e:396a:e2dd])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3695:b0:76e:885a:c3ec
 with SMTP id d2e1a72fcca58-7702fc0aa85mr6804014b3a.32.1755908884373; Fri, 22
 Aug 2025 17:28:04 -0700 (PDT)
Date: Fri, 22 Aug 2025 17:28:02 -0700
In-Reply-To: <20250822141654.Sjoffo8F@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250809180207.GAaJeNHymvt6gaR5nY@fat_crate.local>
 <CAHk-=wi+X2A6K839AxrRvaCDCakya-2B68NTkYP5YGfi-h5EuQ@mail.gmail.com>
 <aKd3cNJqj6_g_ATE@google.com> <20250822141654.Sjoffo8F@linutronix.de>
Message-ID: <aKkLEtoDXKxAAWju@google.com>
Subject: Re: [GIT PULL] locking/urgent for v6.17-rc1
From: Sean Christopherson <seanjc@google.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Borislav Petkov <bp@alien8.de>, 
	Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, x86-ml <x86@kernel.org>, 
	lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Fri, Aug 22, 2025, Sebastian Andrzej Siewior wrote:
> On 2025-08-21 12:45:52 [-0700], Sean Christopherson wrote:
> > Piggybacking the futex private hashing attention, the new fanciness is causing
> > crashes in my testing.  The crashes are 100% reproducible, but my reproducer is
> > simply running a variety of tests in parallel, i.e. isn't very debug-friendly,
> > and the code itself is black magic to me, so all I've done is bisect.
> > 
> > I reported the issue on the original thread, but haven't seen any follow-up.
> > 
> > https://lore.kernel.org/all/aJ_vEP2EHj6l0xRT@google.com
> 
> I somehow missed it. Can you try rc2 with the patch I just sent? 

No dice, fails with the same signature.

I got a trimmed down reproduer.  Load KVM, run this in the background (in a loop)
to constantly trigger try_to_wake_up() on relevant tasks (needs to be run as root):

  echo Y > /sys/module/kvm/parameters/nx_huge_pages
  echo N > /sys/module/kvm/parameters/nx_huge_pages
  sleep .2

and then run the hardware_disable_test KVM selftest (from
tools/testing/selftests/kvm/hardware_disable_test.c).

Strace on hardware_disable_test spewed a whole pile of these

  wait4(32861, 0x7ffc66475dec, WNOHANG, NULL) = 0
  futex(0x7fb735c43000, FUTEX_WAIT_BITSET|FUTEX_CLOCK_REALTIME, 0, {tv_sec=1, tv_nsec=0}, FUTEX_BITSET_MATCH_ANY) = -1 ETIMEDOUT (Connection timed out)

immediately before the crash.  I assume it corresponds to this:

		/* Child is still running, keep waiting. */
		if (pid != waitpid(pid, &status, WNOHANG))
			continue;

I also got a new splat on the "WARN_ON_ONCE(ret < 0);" at the end of __futex_ref_atomic_end().
This happened during boot; AFAICT our userspace was setting up cgroups.  In this
case, the system hung and I had to reboot.

  ------------[ cut here ]------------
  WARNING: CPU: 45 PID: 0 at kernel/futex/core.c:1604 futex_ref_rcu+0xbf/0xf0
  Modules linked in: vfat fat i2c_mux_pca954x i2c_mux spidev cdc_acm xhci_pci xhci_hcd gq(O) sha3_generic
  CPU: 45 UID: 0 PID: 0 Comm: swapper/45 Tainted: G S         O        6.17.0-smp--1278d576b27d-futex #886 NONE 
  Tainted: [S]=CPU_OUT_OF_SPEC, [O]=OOT_MODULE
  Hardware name: Google LLC Indus/Indus_QC_03, BIOS 30.110.0 09/13/2024
  RIP: 0010:futex_ref_rcu+0xbf/0xf0
  Code: c7 04 0a 00 00 00 00 48 ff c0 eb c2 65 ff 01 89 e8 4c 01 f0 48 ff c0 48 89 c1 f0 48 0f c1 8b 48 01 00 00 48 01 c1 74 06 79 0c <0f> 0b eb 08 48 89 df e8 55 0a f9 ff 48 89 df 5b 41 5e 5d e9 f9 5c
  RSP: 0018:ffffa43c8d440ec8 EFLAGS: 00010286
  RAX: 8000000000000000 RBX: ffff933782245080 RCX: ffffffffffffffff
  RDX: 0000000000000060 RSI: 0000000000000060 RDI: ffffffffac840520
  RBP: 0000000000000000 R08: ffff933680044d00 R09: ffffffff00000000
  R10: ffff9365c9b59e00 R11: ffff9365c9b59e00 R12: ffffffffab77ac10
  R13: ffff9337822451b8 R14: 7fffffffffffffff R15: ffff9365c749de00
  FS:  0000000000000000(0000) GS:ffff9395514f2000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 00007fad8a21cf38 CR3: 00000055c062b002 CR4: 00000000007706f0
  PKRU: 55555554
  Call Trace:
   <IRQ>
   rcu_do_batch+0x250/0x7e0
   rcu_core+0x12f/0x230
   handle_softirqs+0xc8/0x280
   __irq_exit_rcu+0x48/0x100
   sysvec_apic_timer_interrupt+0x74/0x80
   </IRQ>
   <TASK>
   asm_sysvec_apic_timer_interrupt+0x1a/0x20
  RIP: 0010:cpuidle_enter_state+0xfb/0x290
  Code: bb f6 ff ff 49 89 c4 8b 73 04 bf ff ff ff ff e8 9b 68 d8 ff 31 ff e8 f4 32 48 ff 80 7c 24 04 00 74 05 e8 c8 68 d8 ff fb 85 ed <0f> 88 ba 00 00 00 89 e9 48 6b f9 68 4c 8b 44 24 08 49 8b 54 38 30
  RSP: 0018:ffffa43c803d3e80 EFLAGS: 00000206
  RAX: ffff9395514f2000 RBX: ffff9394ff776548 RCX: 000000000000001f
  RDX: 000000000018ec50 RSI: 000000000000002d RDI: 0000000000000000
  RBP: 0000000000000003 R08: 0000000000000002 R09: 0000000000000002
  R10: 00000000000003dc R11: 0000000000000389 R12: 00000010fb32644d
  R13: 00000010fb2333f7 R14: ffffffffad276f68 R15: 0000000000000003
   cpuidle_enter+0x2c/0x40
   do_idle+0x1ac/0x250
   cpu_startup_entry+0x2a/0x30
   start_secondary+0x80/0x80
   common_startup_64+0x13e/0x140
   </TASK>
  ---[ end trace 0000000000000000 ]---

Heh, and two more when booting a different system.  Guess it's my lucky day.
This time whatever went sideways didn't appear to be fatal as the system booted
and I could ssh in.  One is the same WARN as above, and the second WARN on the
system hit the

  WARN_ON_ONCE(atomic_long_read(&mm->futex_atomic) != 0);

in futex_hash_allocate().

  ------------[ cut here ]------------
  WARNING: CPU: 120 PID: 11779 at kernel/futex/core.c:1553 futex_hash_allocate+0x436/0x450
  Modules linked in: vfat fat ccp k10temp i2c_piix4 cdc_acm xhci_pci xhci_hcd gq(O) sha3_generic
  CPU: 120 UID: 0 PID: 11779 Comm: borglet Tainted: G     U  W  O        6.17.0-smp--1278d576b27d-futex #886 NONE 
  Tainted: [U]=USER, [W]=WARN, [O]=OOT_MODULE
  Hardware name: Google, Inc.                                                       Arcadia_IT_80/Arcadia_IT_80, BIOS 34.64.2-0 12/26/2024
  RIP: 0010:futex_hash_allocate+0x436/0x450
  Code: 31 ff 65 48 8b 05 ba bc ae 02 48 3b 44 24 48 75 20 44 89 f8 48 83 c4 50 5b 41 5c 41 5d 41 5e 41 5f 5d c3 0f 0b e9 9d fe ff ff <0f> 0b e9 c0 fe ff ff e8 ce 99 af 00 66 66 66 66 66 2e 0f 1f 84 00
  RSP: 0018:ffffbbc0f1237d10 EFLAGS: 00010286
  RAX: 0000000000000001 RBX: 0000000000000000 RCX: ffffa25747532180
  RDX: 0000000000000400 RSI: 000000000000ffc0 RDI: 00000000000039b8
  RBP: ffffa296a2620000 R08: 00000000004029c0 R09: 00000000ffffffff
  R10: 00000000ffffffff R11: 0000000000010040 R12: ffffa2571336b700
  R13: ffffa2571336b600 R14: ffffa2571336b600 R15: ffffa296b9270000
  FS:  00007f6bbd3297c0(0000) GS:ffffa2d5a31b2000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 00007f6bae810f38 CR3: 00000001330a4001 CR4: 0000000000770ef0
  PKRU: 55555554
  Call Trace:
   <TASK>
   ? cgroup_can_fork+0x258/0x420
   copy_process+0xae3/0xff0
   kernel_clone+0x99/0x320
   __x64_sys_clone+0xc8/0xf0
   do_syscall_64+0x6f/0x1f0
   ? arch_exit_to_user_mode_prepare+0x9/0x50
   entry_SYSCALL_64_after_hwframe+0x4b/0x53
  RIP: 0033:0x7f6bbd466051
  Code: 48 85 ff 74 3d 48 85 f6 74 38 48 83 ee 10 48 89 4e 08 48 89 3e 48 89 d7 4c 89 c2 4d 89 c8 4c 8b 54 24 08 b8 38 00 00 00 0f 05 <48> 85 c0 7c 13 74 01 c3 31 ed 58 5f ff d0 48 89 c7 b8 3c 00 00 00
  RSP: 002b:00007fffff2eda98 EFLAGS: 00000206 ORIG_RAX: 0000000000000038
  RAX: ffffffffffffffda RBX: 00007f6bae812700 RCX: 00007f6bbd466051
  RDX: 00007f6bae8129d0 RSI: 00007f6bae810f30 RDI: 00000000003d0f00
  RBP: 00007fffff2edad0 R08: 00007f6bae812700 R09: 00007f6bae812700
  R10: 00007f6bae8129d0 R11: 0000000000000206 R12: 00007f6bae8129d0
  R13: 00007fffff2edb66 R14: 00007fffff2edbd0 R15: 00007f6bae810f40
   </TASK>
  ---[ end trace 0000000000000000 ]---

