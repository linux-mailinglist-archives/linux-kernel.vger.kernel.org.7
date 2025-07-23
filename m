Return-Path: <linux-kernel+bounces-743185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D328B0FB91
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 22:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AAFA3BC43E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 20:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E591D238C3A;
	Wed, 23 Jul 2025 20:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Co0wzGkI"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1ADD236431
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 20:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753302904; cv=none; b=Lyg1Au0gfD0lF7aI09N1MBdFGPVQdJg6gCuSqhHTspU0/YvGWCSOEunbDrPpaB6CI4W5GRoVHupJf3M40iqxUG4OFFoBNV8woFX2c56uGI5dU47EOU4HpqT9ZoXLZjEprj4uyuPBsvnAP1Cx+g9hZMOeHL2RokFKbo0j/UJsOaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753302904; c=relaxed/simple;
	bh=WTZXIXoDsiyMHH7jLVN7/heBJWOZLBzitc9MnX4fESk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=azG4HfhbnzLvMwh6BgmFRUEWxoY9fu+Ya8kTPlIMSI7qA2DgeMB4rtmcMKYiCHLvFMlyqS5az/J32kObnKKkmOFoxEdClFV8KFf6zVqvNaTRVAVx0GOdgCReMlYk2h4iqVo3gAKfdMv1m0sabTqYwW5RVudM+n1vQZhoIEBJamA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Co0wzGkI; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-31e3fdf1906so206773a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 13:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753302901; x=1753907701; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QnR7w9stPdKm98nKrJQNM9+YNaTPwRCkK6LNcC2wLbg=;
        b=Co0wzGkIGFdyRgIKDioE5QfAlzl09kQtRI0cjx0oQhAAJyCvvZSNh4GrdzQKkaVkSY
         SN+6SmeWEi2vdEJxKp2gbuB+vgfHW64zQvDO/PyAx+elpala3EnGMdxtBZSBCR3wZo7j
         eIWLNwqcjVwTg9K0+ocq4mCfuJGyeshpwnE8yX4Je0Ny6dRT7viu8oChchHUMPblvvL7
         /CeoWSmu9soNFUqpQkS4JFwZB8lvdBykUOlOqC3mTuQhxtLkZAc1nkv88MPWKWj1gfMg
         Oo3osTtyV5m6ZgHnbSVMr5Sc4SwWvSFdiFX0LXtZf7EL3WcMDo0PunuBwPos6J9r58Mq
         YD1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753302901; x=1753907701;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QnR7w9stPdKm98nKrJQNM9+YNaTPwRCkK6LNcC2wLbg=;
        b=HZDJQT0gdkjDE1lAsQQUbXNSMROKyaYstXCxZtA76eGjZ1rfesZPPJn2rAxYbwCCqh
         av68ZwXPDe00WTshZajuINstFDdbPWNflck/ovZuXO3p4uWOBAfFulvGb+ZYYEq1IZ9C
         T/HwF0rqS56kLaFgek6EEkmWOX7+PSjxz30o+yWF5a3rjgUfHD21mEXDTa+djNOodeij
         8gT1QC5dUCNPi9Z7uBhv3Vf2fb5zT2D4h6MfW2f77Hh++ZnKrtOwjYphs08DJfaTkdJU
         oFfs1jnGx736xspe2ZG8goceVWmwLdbldA71vFanbDA3L2L29r7l+i9fbbX1AygV3y0G
         TbgA==
X-Forwarded-Encrypted: i=1; AJvYcCVpyc46W1TYy66YhL/hQjaQmqPwdDpQHMFBsLSon9p5W4xIGm5xP9We+6mhWyBR77LJjx65DkgsuZDOtOw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU98PfzRM/iNppzPIU30o5D+Kffo3JKJUQOM7iWNIBMnMmJuWm
	WZg3tgFm1So67XufR4rP6rW8hxgY4AEiFYeKrPFR4YzVJd8fCR+PxZyW3WFu2J2yEXY1wxYzCQ0
	3dB5VlQ==
X-Google-Smtp-Source: AGHT+IElGF/a2fa0rRJVG8x7Wl025nPKxmm0Kd4MFuq7jeA062GW0ZiySl0PXMrGcapOCBE04uzxFXddxes=
X-Received: from pjbos14.prod.google.com ([2002:a17:90b:1cce:b0:30a:31eb:ec8e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:da8f:b0:313:283e:e87c
 with SMTP id 98e67ed59e1d1-31e506eea04mr5481708a91.3.1753302901160; Wed, 23
 Jul 2025 13:35:01 -0700 (PDT)
Date: Wed, 23 Jul 2025 13:34:59 -0700
In-Reply-To: <20250707224720.4016504-4-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250707224720.4016504-1-jthoughton@google.com> <20250707224720.4016504-4-jthoughton@google.com>
Message-ID: <aIFHc83PtfB9fkKB@google.com>
Subject: Re: [PATCH v5 3/7] KVM: x86/mmu: Recover TDP MMU NX huge pages using
 MMU read lock
From: Sean Christopherson <seanjc@google.com>
To: James Houghton <jthoughton@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vipin Sharma <vipinsh@google.com>, 
	David Matlack <dmatlack@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Jul 07, 2025, James Houghton wrote:
> From: Vipin Sharma <vipinsh@google.com>
> 
> Use MMU read lock to recover TDP MMU NX huge pages. Iterate

Wrap at ~75 chars.

> over the huge pages list under tdp_mmu_pages_lock protection and
> unaccount the page before dropping the lock.
> 
> We must not zap an SPTE if:

No pronouns!

> - The SPTE is a root page.
> - The SPTE does not point at the SP's page table.
> 
> If the SPTE does not point at the SP's page table, then something else
> has change the SPTE, so we cannot safely zap it.
> 
> Warn if zapping SPTE fails and current SPTE is still pointing to same
> page table. This should never happen.
> 
> There is always a race between dirty logging, vCPU faults, and NX huge
> page recovery for backing a gfn by an NX huge page or an executable
> small page. Unaccounting sooner during the list traversal is increasing
> the window of that race. Functionally, it is okay, because accounting
> doesn't protect against iTLB multi-hit bug, it is there purely to
> prevent KVM from bouncing a gfn between two page sizes. The only
> downside is that a vCPU will end up doing more work in tearing down all
> the child SPTEs. This should be a very rare race.
> 
> Zapping under MMU read lock unblocks vCPUs which are waiting for MMU
> read lock. This optimizaion is done to solve a guest jitter issue on
> Windows VM which was observing an increase in network latency.

With slight tweaking:

Use MMU read lock to recover TDP MMU NX huge pages.  To prevent
concurrent modification of the list of potential huge pages, iterate over
the list under tdp_mmu_pages_lock protection and unaccount the page
before dropping the lock.

Zapping under MMU read lock unblocks vCPUs which are waiting for MMU
read lock, which solves a guest jitter issue on Windows VMs which were
observing an increase in network latency.

Do not zap an SPTE if:
- The SPTE is a root page.
- The SPTE does not point at the SP's page table.

If the SPTE does not point at the SP's page table, then something else
has change the SPTE, so KVM cannot safely zap it.

Warn if zapping SPTE fails and current SPTE is still pointing to same
page table, as it should be impossible for the CMPXCHG to fail due to all
other write scenarios being mutually exclusive.

There is always a race between dirty logging, vCPU faults, and NX huge
page recovery for backing a gfn by an NX huge page or an executable
small page.  Unaccounting sooner during the list traversal increases the
window of that race, but functionally, it is okay.  Accounting doesn't
protect against iTLB multi-hit bug, it is there purely to prevent KVM
from bouncing a gfn between two page sizes. The only  downside is that a
vCPU will end up doing more work in tearing down all  the child SPTEs.
This should be a very rare race.

> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Vipin Sharma <vipinsh@google.com>
> Co-developed-by: James Houghton <jthoughton@google.com>
> Signed-off-by: James Houghton <jthoughton@google.com>
> ---
>  arch/x86/kvm/mmu/mmu.c     | 107 ++++++++++++++++++++++++-------------
>  arch/x86/kvm/mmu/tdp_mmu.c |  42 ++++++++++++---
>  2 files changed, 105 insertions(+), 44 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index b074f7bb5cc58..7df1b4ead705b 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -7535,12 +7535,40 @@ static unsigned long nx_huge_pages_to_zap(struct kvm *kvm,
>  	return ratio ? DIV_ROUND_UP(pages, ratio) : 0;
>  }
>  
> +static bool kvm_mmu_sp_dirty_logging_enabled(struct kvm *kvm,
> +					     struct kvm_mmu_page *sp)
> +{
> +	struct kvm_memory_slot *slot = NULL;
> +
> +	/*
> +	 * Since gfn_to_memslot() is relatively expensive, it helps to skip it if
> +	 * it the test cannot possibly return true.  On the other hand, if any
> +	 * memslot has logging enabled, chances are good that all of them do, in
> +	 * which case unaccount_nx_huge_page() is much cheaper than zapping the
> +	 * page.

And largely irrelevant, because KVM should unaccount the NX no matter what.  I
kinda get what you're saying, but honestly it adds a lot of confusion, especially
since unaccount_nx_huge_page() is in the caller.

> +	 *
> +	 * If a memslot update is in progress, reading an incorrect value of
> +	 * kvm->nr_memslots_dirty_logging is not a problem: if it is becoming
> +	 * zero, gfn_to_memslot() will be done unnecessarily; if it is becoming
> +	 * nonzero, the page will be zapped unnecessarily.  Either way, this only
> +	 * affects efficiency in racy situations, and not correctness.
> +	 */
> +	if (atomic_read(&kvm->nr_memslots_dirty_logging)) {

Short-circuit the function to decrease indentation, and so that "slot" doesn't
need to be NULL-initialized.

> +		struct kvm_memslots *slots;
> +
> +		slots = kvm_memslots_for_spte_role(kvm, sp->role);
> +		slot = __gfn_to_memslot(slots, sp->gfn);

Then this can be:

	slot = __gfn_to_memslot(kvm_memslots_for_spte_role(kvm, sp->role), sp->gfn);

without creating a stupid-long line.

> +		WARN_ON_ONCE(!slot);

And then:

	if (WARN_ON_ONCE(!slot))
		return false;

	return kvm_slot_dirty_track_enabled(slot);

With a comment cleanup:

	struct kvm_memory_slot *slot;

	/*
	 * Skip the memslot lookup if dirty tracking can't possibly be enabled,
	 * as memslot lookups are relatively expensive.
	 *
	 * If a memslot update is in progress, reading an incorrect value of
	 * kvm->nr_memslots_dirty_logging is not a problem: if it is becoming
	 * zero, KVM will  do an unnecessary memslot lookup;  if it is becoming
	 * nonzero, the page will be zapped unnecessarily.  Either way, this
	 * only affects efficiency in racy situations, and not correctness.
	 */
	if (!atomic_read(&kvm->nr_memslots_dirty_logging))
		return false;

	slot = __gfn_to_memslot(kvm_memslots_for_spte_role(kvm, sp->role), sp->gfn);
	if (WARN_ON_ONCE(!slot))
		return false;

	return kvm_slot_dirty_track_enabled(slot);
> @@ -7559,8 +7590,17 @@ static void kvm_recover_nx_huge_pages(struct kvm *kvm,
>  	rcu_read_lock();
>  
>  	for ( ; to_zap; --to_zap) {
> -		if (list_empty(nx_huge_pages))
> +#ifdef CONFIG_X86_64

These #ifdefs still make me sad, but I also still think they're the least awful
solution.  And hopefully we will jettison 32-bit sooner than later :-)

