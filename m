Return-Path: <linux-kernel+bounces-788766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2F7B38A0C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 21:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 43E904E1B2E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 19:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31252D97A1;
	Wed, 27 Aug 2025 19:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q7IXFfMq"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B7E2C08B2
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 19:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756321712; cv=none; b=d2TakS4enWUOc00kcZR3h+MNLuQiopxmsZfMHGERKeR3PFpEfKPvr2J7cj6Pw7pGtvgPRTc/NdcTjyKkIV30hHAu3DWy8APdccmAhs/TbAie0z7bVbJpDd3TzROzkUfb1mde+/HIyO11JU8Vkkjj/+3jpJRtS0jpKqTc3ov61YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756321712; c=relaxed/simple;
	bh=+k4VXeI8suH6W9b8aCrYCg9/tr59Qoyt9aULAPVos2Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Fj69KTXfJEYbP1tx1wQF3adagR6w2u6LgYZDwsIcvFP6Dj93NYZjL99uO6O+RG+NUFbAi8VFJ2+1cAXZI7zdz712AlfMCz4N8wB/OR2QYBcGDwsZ9QYPh3yZFWXNpwBwzmC+kPaNuO9Djr8xNe3EtGOHxqDyhZnLKPr4vCt+OVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q7IXFfMq; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-244581c62faso1602895ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 12:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756321709; x=1756926509; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xcAuR7T4RT9zVVlNI8n4izXJVHOx6F3XBKP4ipgVkd0=;
        b=q7IXFfMqfZUEwAvBS2MBd7wdExUgqn0Omh3h0hhBA1IRECufM7SWLQxlbYYKivQDsA
         6sW/2MHIB+N4rfeoxR8kkwrp866Be5g5MAmvzNZJEzKclKG57i1sgm9b16eUzD0jEnlC
         Ry643j/uFNFbtqC4ed1iSKptE+fyvA6JVopqjZ8806ip1vS/TPggGwha9YWEe0ShYW36
         MvYSU8+uQegXc+sULnwdLL2J/exaEdumkmOgj3geoxjN7nvqyKBe+XrgZGZHNYdBaAqy
         n5rOU6s8PBFGhg6Fo2vtDSwys2VJawgeFNii3Q92KNQbHJ3OVDyUWN5si3pGWzaHEEAe
         6bGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756321709; x=1756926509;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xcAuR7T4RT9zVVlNI8n4izXJVHOx6F3XBKP4ipgVkd0=;
        b=Lr3kj1NP6TSSta8trsCtvSx2Lszi9vFd6QAWs3TuvAE/SJduI+m1jBq6gVbA5C+a3h
         kh2C7UatQMcXWS94Gu1qQTDS00bfQQJL4S65ukZ6TErfeP4maExp1HJTV28x+m6Fsc15
         DmPCdN3fid8FycoFTKIVhRHtZVtpOa92qrqHW63Ed8AOONR+L8VoNjNOMFCTQDFCwi+x
         kMxDyZwpWKJ0uisU0rsFtFACB0EL5MDD6Hrngz/hWjHcPmi+BYLTk9BQzBqKXAdg3cG6
         LmxVnj0bPI0syIVci4EAQCHCtDlpidvBrdJvn8fAJ8T+i6tfu9tPJ/32JoR9YRgdeB2n
         FTXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuu6N6jI/At5/B/kwjJIkOmtoNecZbqwFKcIgVDqg/oIL9OzGQ7+mncYxYI3OEUc2avyAGShvPeLfiFhg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzluw57mGh46TQ1DJ5plCqawzVwCrZj9Jq9yMnW8LSm0PCEBw4
	dE9J01nX13MIfWTgKYcjTEInRCFNPoLlLFHXk2ZpVJirexTnFr82ivYumNVCqlDzFK3yIfx1PFV
	mBHc84w==
X-Google-Smtp-Source: AGHT+IEhMKtArTIDLxa8v26TStyUxDN5gA5Xm0VZUdjAbdj2048YQG+Bwtxlg063uyONmGMwUmly8Ow2VrA=
X-Received: from plgn18.prod.google.com ([2002:a17:902:f612:b0:248:b2cc:8b2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cf08:b0:248:a4e2:e6d6
 with SMTP id d9443c01a7336-248a4f2333bmr41703845ad.39.1756321709348; Wed, 27
 Aug 2025 12:08:29 -0700 (PDT)
Date: Wed, 27 Aug 2025 12:08:27 -0700
In-Reply-To: <aK7Ji3kAoDaEYn3h@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250827000522.4022426-1-seanjc@google.com> <20250827000522.4022426-10-seanjc@google.com>
 <aK7Ji3kAoDaEYn3h@yzhao56-desk.sh.intel.com>
Message-ID: <aK9Xqy0W1ghonWUL@google.com>
Subject: Re: [RFC PATCH 09/12] KVM: TDX: Fold tdx_mem_page_record_premap_cnt()
 into its sole caller
From: Sean Christopherson <seanjc@google.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michael Roth <michael.roth@amd.com>, Ira Weiny <ira.weiny@intel.com>, 
	Vishal Annapurve <vannapurve@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Aug 27, 2025, Yan Zhao wrote:
> On Tue, Aug 26, 2025 at 05:05:19PM -0700, Sean Christopherson wrote:
> > @@ -1641,14 +1618,30 @@ static int tdx_sept_set_private_spte(struct kvm *kvm, gfn_t gfn,
> >  		return -EIO;
> >  
> >  	/*
> > -	 * Read 'pre_fault_allowed' before 'kvm_tdx->state'; see matching
> > -	 * barrier in tdx_td_finalize().
> > +	 * Ensure pre_fault_allowed is read by kvm_arch_vcpu_pre_fault_memory()
> > +	 * before kvm_tdx->state.  Userspace must not be allowed to pre-fault
> > +	 * arbitrary memory until the initial memory image is finalized.  Pairs
> > +	 * with the smp_wmb() in tdx_td_finalize().
> >  	 */
> >  	smp_rmb();
> > -	if (likely(kvm_tdx->state == TD_STATE_RUNNABLE))
> > -		return tdx_mem_page_aug(kvm, gfn, level, pfn);
> >  
> > -	return tdx_mem_page_record_premap_cnt(kvm, gfn, level, pfn);
> > +	/*
> > +	 * If the TD isn't finalized/runnable, then userspace is initializing
> > +	 * the VM image via KVM_TDX_INIT_MEM_REGION.  Increment the number of
> > +	 * pages that need to be initialized via TDH.MEM.PAGE.ADD (PAGE.ADD
> > +	 * requires a pre-existing S-EPT mapping).  KVM_TDX_FINALIZE_VM checks
> > +	 * the counter to ensure all mapped pages have been added to the image,
> > +	 * to prevent running the TD with uninitialized memory.
> To prevent the mismatch between mirror EPT and the S-EPT?

No?  Because KVM bumps the count when installing the S-EPT and decrements it
on AUG, so I don't see how nr_premapped guards against M-EPT vs. S-EPT issues?

> e.g., Before KVM_TDX_FINALIZE_VM, if userspace performs a zap after the
> TDH.MEM.PAGE.ADD, the page will be removed from the S-EPT. The count of
> nr_premapped will not change after the successful TDH.MEM.RANGE.BLOCK and
> TDH.MEM.PAGE.REMOVE.

Eww.  It would be nice to close that hole, but I suppose it's futile, e.g. the
underlying problem is unexpectedly removing pages from the initial, whether the
VMM is doing stupid things before vs. after FINALIZE doesn't really matter.

> As a result, the TD will still run with uninitialized memory.

No?  Because BLOCK+REMOVE means there are no valid S-EPT mappings.  There's a
"hole" that the guest might not expect, but that hole will trigger an EPT
violation and only get "filled" if the guest explicitly accepts an AUG'd page.

Side topic, why does KVM tolerate tdh_mem_page_add() failure?  IIUC, playing
nice with tdh_mem_page_add() failure necessitates both the
tdx_is_sept_zap_err_due_to_premap() craziness and the check in tdx_td_finalize()
that all pending pages have been consumed.

What reasonable use case is there for gracefully handling tdh_mem_page_add() failure?

If there is a need to handle failure, I gotta imagine it's only for the -EBUSY
case.  And if it's only for -EBUSY, why can't that be handled by retrying in
tdx_vcpu_init_mem_region()?  If tdx_vcpu_init_mem_region() guarantees that all
pages mapped into the S-EPT are ADDed, then it can assert that there are no
pending pages when it completes (even if it "fails"), and similarly
tdx_td_finalize() can KVM_BUG_ON/WARN_ON the number of pending pages being
non-zero.

> > +	 */
> > +	if (unlikely(kvm_tdx->state != TD_STATE_RUNNABLE)) {
> > +		if (KVM_BUG_ON(kvm->arch.pre_fault_allowed, kvm))
> > +			return -EIO;
> > +
> > +		atomic64_inc(&kvm_tdx->nr_premapped);
> > +		return 0;
> > +	}
> > +
> > +	return tdx_mem_page_aug(kvm, gfn, level, pfn);
> >  }
> >  
> >  static int tdx_sept_drop_private_spte(struct kvm *kvm, gfn_t gfn,
> > -- 
> > 2.51.0.268.g9569e192d0-goog
> > 

