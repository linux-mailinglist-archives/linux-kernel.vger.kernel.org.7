Return-Path: <linux-kernel+bounces-771654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9027DB28A18
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 04:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8FA71C28135
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 02:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5F2136358;
	Sat, 16 Aug 2025 02:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RRPG2/sH"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D82649620
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 02:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755311891; cv=none; b=ZM8k5+M9VJmt1olURO3/Ydlfb9Hpu1ZQF8YgzoA7b2iqTjFrQZZFopsum3VfPCTZ7Ta6g3819IxecsW9HnkQKjC+FHb8ng+IbnBEzUGMcw/1ZbzR8bqH3Xp3i0aLF2O2+p3BScxYka2fXwMLr9drYguAAn8dxntoOK1Ak2HFKVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755311891; c=relaxed/simple;
	bh=MVqjTt8ook1Yhw3NueEeOuTzxHSuRY2jWFypltxSOrA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nDfMxi1Z2NGF7fF1y1D+lYORh8883ztCDbA1sxlIAS/tenc5J2HEUx7H6d6WwWrc8wwaSsYooF+6wVr/5bh+Dvq6tXhRi5MRinYxASSgkUO3cemKYgnfzXyaCVmmn6KM7/JHTAkLaLVQ/jysictMkocSa7jt+kd7ogNpXVwnl7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RRPG2/sH; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b47175d5a90so1839264a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 19:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755311889; x=1755916689; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=I4aFd1kzfxeQxXIJX7Up6VxnD/z08XD5JpqJS5TTEX4=;
        b=RRPG2/sHYMkWMhobv42TyCYHRBXVVE5EK3miJD5maaEtJEj7a/viNXFivHClZuRgSZ
         KzAF36mURWr70WEYXgrkEoCj5QpdudAxlVoOPcfTJ+A1HEXRFXbYPd2MqELxdxD+wVea
         UrfFcOQmYVFVYINWCiU+BBVjdqp1qg7zWD+Ekj9MZZNNv+ICol21iQrqRhXfypuOwpPG
         b4eFJ2zYkSfymB8gBykPvT8XVHsUFhhHyp2KGdVQoJEq0TFHu6EgAo9bsT3EqY5vZOay
         hJ3YjYBHuZVK0WY/wHclRA8wizHxfDIAu3H+FAMLfrHlZEYq6FaY+QzOJtL+r1Yw/kMg
         awGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755311889; x=1755916689;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I4aFd1kzfxeQxXIJX7Up6VxnD/z08XD5JpqJS5TTEX4=;
        b=PEqQP5hNNE6+CCIOhUJ4ON4WRtlkryPNcDqgjoDcLbpRVd3AiwbPAo1udeY2pU/sQo
         t6aapqyOoTrr/lWMEE34VUMPDgwwGVPJGtAocZnGy4kowbxyQdWLihsATZXsmwQe/yr1
         LpUmFtmoqd5rWsVBWUKuxHBqCUrLNWqtEoHvPE11S9NC25zIK7GPqcAKCN0g4mHskQoQ
         UD/pMNxaKE/VRJCmJQlZLe5lcR9whUYt/nFunbkK0Dfgbj3VPqy5asG6lbh4/tGHkwZY
         aFh6Mng6MYhrtQ1SMtLGW2RkuddxyRcw5Xo+kgg0H85yad14bkzHMX14fCunkJjk/c81
         rjEA==
X-Gm-Message-State: AOJu0YzkbrV5e5S8rIF1LyBgCncay/jaZIJ1c2PSmXj7elkxf6Ws4mnx
	yqBfpQG9VIEWi3fFVAOaY8lj2CvzPRspqCER+InbR0QBIef754BbspnJSXQPXge8AfXQa6L+VM8
	vwVy3TeV3r/X5A7At6yORLn70vlTDqXJvwWhKHl/p38jD85d0mih4PFeH8zt8fO2FHHN4xmnpL+
	954QDOabnQWOTwJBU41Bt5E0ZjH18Xfxq14Grr69LaiX40
X-Google-Smtp-Source: AGHT+IGkSD0UN++W+/e1bpqm5LESTczv1DyoPxW9E+7V3lIjC3AH4IpOotDR7wGGHV0c6Shkc5w0TWsKEnI=
X-Received: from pghm22.prod.google.com ([2002:a63:f616:0:b0:b47:35f:5e80])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:9147:b0:240:21e1:cbc1
 with SMTP id adf61e73a8af0-240d31dccf2mr6600429637.41.1755311889312; Fri, 15
 Aug 2025 19:38:09 -0700 (PDT)
Date: Fri, 15 Aug 2025 19:38:08 -0700
In-Reply-To: <175225881640.406.2875698205071601878.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250710110011.384614-3-bigeasy@linutronix.de> <175225881640.406.2875698205071601878.tip-bot2@tip-bot2>
Message-ID: <aJ_vEP2EHj6l0xRT@google.com>
Subject: Re: [tip: locking/futex] futex: Use RCU-based per-CPU reference
 counting instead of rcuref_t
From: Sean Christopherson <seanjc@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, x86@kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Jul 11, 2025, tip-bot2 for Peter Zijlstra wrote:
> The following commit has been merged into the locking/futex branch of tip:
> 
> Commit-ID:     56180dd20c19e5b0fa34822997a9ac66b517e7b3
> Gitweb:        https://git.kernel.org/tip/56180dd20c19e5b0fa34822997a9ac66b517e7b3
> Author:        Peter Zijlstra <peterz@infradead.org>
> AuthorDate:    Thu, 10 Jul 2025 13:00:07 +02:00
> Committer:     Peter Zijlstra <peterz@infradead.org>
> CommitterDate: Fri, 11 Jul 2025 16:02:00 +02:00
> 
> futex: Use RCU-based per-CPU reference counting instead of rcuref_t
> 
> The use of rcuref_t for reference counting introduces a performance bottleneck
> when accessed concurrently by multiple threads during futex operations.
> 
> Replace rcuref_t with special crafted per-CPU reference counters. The
> lifetime logic remains the same.
> 
> The newly allocate private hash starts in FR_PERCPU state. In this state, each
> futex operation that requires the private hash uses a per-CPU counter (an
> unsigned int) for incrementing or decrementing the reference count.
> 
> When the private hash is about to be replaced, the per-CPU counters are
> migrated to a atomic_t counter mm_struct::futex_atomic.
> The migration process:
> - Waiting for one RCU grace period to ensure all users observe the
>   current private hash. This can be skipped if a grace period elapsed
>   since the private hash was assigned.
> 
> - futex_private_hash::state is set to FR_ATOMIC, forcing all users to
>   use mm_struct::futex_atomic for reference counting.
> 
> - After a RCU grace period, all users are guaranteed to be using the
>   atomic counter. The per-CPU counters can now be summed up and added to
>   the atomic_t counter. If the resulting count is zero, the hash can be
>   safely replaced. Otherwise, active users still hold a valid reference.
> 
> - Once the atomic reference count drops to zero, the next futex
>   operation will switch to the new private hash.
> 
> call_rcu_hurry() is used to speed up transition which otherwise might be
> delay with RCU_LAZY. There is nothing wrong with using call_rcu(). The
> side effects would be that on auto scaling the new hash is used later
> and the SET_SLOTS prctl() will block longer.
> 
> [bigeasy: commit description + mm get/ put_async]
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: https://lore.kernel.org/r/20250710110011.384614-3-bigeasy@linutronix.de
> ---

This is causing explosions on my test systems, in code that doesn't obviously
have anything to do with futex.

The most common symptom is a #GP on this code in try_to_wake_up():

		/* Link @node into the waitqueue. */
		WRITE_ONCE(prev->next, node);

although on systems with 5-level paging I _think_ it just manifests as hard
hanges (I assume because prev->next is corrupted, but is still canonical with
LA57?  But that's a wild guess).

The failure always occurs when userspace writes /sys/module/kvm/parameters/nx_huge_pages,
but I don't think there's anything KVM specific about the issue.  Simply writing
the param doesn't explode, the problem only arises when I'm running tests in
parallel (but then failure is almost immediate), so presumably there's a task
migration angle or something?

Manually disabling CONFIG_FUTEX_PRIVATE_HASH makes the problem go away, and
running with CONFIG_FUTEX_PRIVATE_HASH=y prior to this rework is also fine.  So
it appears that the problem is specifically in the new code.

I can provide more info as needed next week.

Oops: general protection fault, probably for non-canonical address 0xff0e899fa1566052: 0000 [#1] SMP
CPU: 51 UID: 0 PID: 53807 Comm: tee Tainted: G S         O        6.17.0-smp--38183c31756a-next #826 NONE 
Tainted: [S]=CPU_OUT_OF_SPEC, [O]=OOT_MODULE
Hardware name: Google LLC Indus/Indus_QC_03, BIOS 30.110.0 09/13/2024
RIP: 0010:queued_spin_lock_slowpath+0x123/0x250
Code: d8 c1 e8 10 66 87 47 02 66 85 c0 74 40 0f b7 c0 89 c2 83 e2 03 c1 e2 04 83 e0 fc 48 c7 c6 f8 ff ff ff 48 8b 84 46 a0 e2 a3 a0 <48> 89 8c 02 c0 da 47 a2 83 79 08 00 75 08 f3 90 83 79 08 00 74 f8
RSP: 0018:ffffbf55cffe7cf8 EFLAGS: 00010006
RAX: ff0e899fff0e8562 RBX: 0000000000d00000 RCX: ffffa39b40aefac0
RDX: 0000000000000030 RSI: fffffffffffffff8 RDI: ffffa39d0592e68c
RBP: 0000000000d00000 R08: 00000000ffffff80 R09: 0000000400000000
R10: ffffa36cce4fe401 R11: 0000000000000800 R12: 0000000000000003
R13: 0000000000000000 R14: ffffa39d0592e68c R15: ffffa39b9e672000
FS:  00007f233b2e9740(0000) GS:ffffa39b9e672000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f233b39fda0 CR3: 00000004d031f002 CR4: 00000000007726f0
PKRU: 55555554
Call Trace:
 <TASK>
 _raw_spin_lock_irqsave+0x50/0x60
 try_to_wake_up+0x4f/0x5d0
 set_nx_huge_pages+0xe4/0x1c0 [kvm]
 param_attr_store+0x89/0xf0
 module_attr_store+0x1e/0x30
 kernfs_fop_write_iter+0xe4/0x160
 vfs_write+0x2cb/0x420
 ksys_write+0x7f/0xf0
 do_syscall_64+0x6f/0x1f0
 ? arch_exit_to_user_mode_prepare+0x9/0x50
 entry_SYSCALL_64_after_hwframe+0x4b/0x53
RIP: 0033:0x7f233b4178b3
Code: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc 48 8b 05 99 91 07 00 83 38 00 75 10 b8 01 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 4d c3 55 48 89 e5 41 57 41 56 53 50 48 89 d3
RSP: 002b:00007ffffbdbf3b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f233b4178b3
RDX: 0000000000000002 RSI: 00007ffffbdbf4a0 RDI: 0000000000000005
RBP: 00007ffffbdbf3e0 R08: 0000000000001004 R09: 0000000000000000
R10: 00000000000001b6 R11: 0000000000000246 R12: 00007ffffbdbf4a0
R13: 0000000000000002 R14: 00000000226ff3d0 R15: 0000000000000002
 </TASK>
Modules linked in: kvm_intel kvm irqbypass vfat fat i2c_mux_pca954x i2c_mux spidev cdc_acm xhci_pci xhci_hcd gq(O) sha3_generic
gsmi: Log Shutdown Reason 0x03
---[ end trace 0000000000000000 ]---
RIP: 0010:queued_spin_lock_slowpath+0x123/0x250
Code: d8 c1 e8 10 66 87 47 02 66 85 c0 74 40 0f b7 c0 89 c2 83 e2 03 c1 e2 04 83 e0 fc 48 c7 c6 f8 ff ff ff 48 8b 84 46 a0 e2 a3 a0 <48> 89 8c 02 c0 da 47 a2 83 79 08 00 75 08 f3 90 83 79 08 00 74 f8
RSP: 0018:ffffbf55cffe7cf8 EFLAGS: 00010006
RAX: ff0e899fff0e8562 RBX: 0000000000d00000 RCX: ffffa39b40aefac0
RDX: 0000000000000030 RSI: fffffffffffffff8 RDI: ffffa39d0592e68c
RBP: 0000000000d00000 R08: 00000000ffffff80 R09: 0000000400000000
R10: ffffa36cce4fe401 R11: 0000000000000800 R12: 0000000000000003
R13: 0000000000000000 R14: ffffa39d0592e68c R15: ffffa39b9e672000
FS:  00007f233b2e9740(0000) GS:ffffa39b9e672000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f233b39fda0 CR3: 00000004d031f002 CR4: 00000000007726f0
PKRU: 55555554
Kernel panic - not syncing: Fatal exception
Kernel Offset: 0x1e600000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
gsmi: Log Shutdown Reason 0x02
Rebooting in 10 seconds..


