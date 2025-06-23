Return-Path: <linux-kernel+bounces-698845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 700B1AE4AC5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 18:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E401B4A1550
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 16:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2044C2D29DD;
	Mon, 23 Jun 2025 16:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ok3fQtyN"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1562BE7BE
	for <linux-kernel@vger.kernel.org>; Mon, 23 Jun 2025 16:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750695529; cv=none; b=ErlUZSm1zk0mhpW8QWlZWWl+1ccB/L57tXJJb1LReLFQ0kVC+KyZZlu7W2DvdG41t47qE1aB440vpUjjvBbByVvLQFFFuIymMjPznjIbG3vha/RcWxC8FlMV7/0NJVbjDlh1LCdypwilNv+pHSx8RHGzNCEw8Xp6gOW1OPAL6pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750695529; c=relaxed/simple;
	bh=EDHaxySB1XyXigRSYjSRI7C2L41azpKZfXI/ttcEEo0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Kf6DFmtonUY/KwiqnOmUMVtENyJllPhQw1ijnUc3+4YhFPcRqxsco06MxI/Ma2Ki7HIgQYlsumwu9ex7FWOlcR+1HvSZt+yK2QNcXVrERLNzloHXHfgTKZn+XmMYQ25NjdzVZ58FNI9uvGmMmu4FyQd+upCKWxDKXquTCEpryFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ok3fQtyN; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b2c36951518so5571828a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jun 2025 09:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750695527; x=1751300327; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OOkpzMlhlXRiMCNdOIvauV/qFub0T/UowmpNSsYnBL4=;
        b=ok3fQtyNSBcUqCubl+Lz2K0WlkXRHfvXkDzsv/rGPc7b1ghBZc+p2/IYP5cwxthWEF
         rn9Nx0bpDO/K7E5va/IkUeW7tpTJQRbe8DqDFP82HxyTTPe3V7zV1t4l1fRs7My5LtUZ
         /N9Nb91DUny3N/8MFK1qTU2RDH/8yUB5FgZpPcNRA9KKcfenjfcGv5MLYK/uyv/4KHOe
         uZBvN7FLoX6qDzVaWmrIv9G2J+CnrEA1/EoVwApG8Yiu7ECmgLE+Dozn58L9acBrfRgv
         H2zfUsJvp12C6RwZraUq4sT2GdVHQ/tNTT8Jz52AIWTtUtdQvQ9iSQvYzGczv+DFnr7I
         rerg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750695527; x=1751300327;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OOkpzMlhlXRiMCNdOIvauV/qFub0T/UowmpNSsYnBL4=;
        b=mtdApbpgs+ISEGL1b6qD0c84Cbc5BlO64pwTQmYTy6ZnMFJPB87oAZCRA/1217ICV7
         GVTYCcqyeWA+rOm7Ej2mD9AllfbHcZsKoyqO6fSkksOecSYn48GKIvp/t7KmGlRvFdwr
         JOMiCNsxtpTYUO/ithYoLHatyGrGbFPPwL9YJ0Jj5bPdhNW6N3nwmKVIV7SN1kFwgtWK
         0G3ucUsVw+ShcLWjPYykrT4OMONHzrzcyayq2CRD8vjxqe8kSFkRXq7IpJOrjzjTnA+H
         Jf8gtz6Tf6AaeggZmnB23WAVn/otMLogMPFgAnBl9pZlWG5Iy32wMaEfgm1ULMf3ZhcU
         TInw==
X-Forwarded-Encrypted: i=1; AJvYcCV/UrljV2iTOSzJYLCrqL10JlHexVdbKmu1gJdXmxH5l5MC8TQ26Qd6l2dmh8CYkgIh2EiCPQeB96m/lN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEyxsQqlvEriuvHFxNRfZGoY/NUxJ2auRMioDTCJ+kTGYDVJd+
	0GFEy0Xh3nQnDsNFOMctri/ZB3FnPe9UwYaeQOQ52xdI7bwBOhU5hbyox0Bf8802zVFWL8Ffr62
	x90qoEw==
X-Google-Smtp-Source: AGHT+IENQipggL2SOcRyFklB3/6faa8uHHLu36CbWgSZEypv6kRSEUBRnwpSzpoNeCEIYgBhsThVyFLxqUA=
X-Received: from pfug19.prod.google.com ([2002:a05:6a00:793:b0:749:8f7:e14e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:c992:b0:21f:5c9d:498e
 with SMTP id adf61e73a8af0-22026d32fe2mr19839452637.7.1750695527173; Mon, 23
 Jun 2025 09:18:47 -0700 (PDT)
Date: Mon, 23 Jun 2025 09:18:45 -0700
In-Reply-To: <pxtvegopzsyhn7lelksclxiiee7tumppu76553rax7octqpy7i@giclgo667htf>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250611224604.313496-2-seanjc@google.com> <20250611224604.313496-22-seanjc@google.com>
 <pxtvegopzsyhn7lelksclxiiee7tumppu76553rax7octqpy7i@giclgo667htf>
Message-ID: <aFl-ZYyf9guxSkHE@google.com>
Subject: Re: [PATCH v3 20/62] KVM: SVM: Add a comment to explain why
 avic_vcpu_blocking() ignores IRQ blocking
From: Sean Christopherson <seanjc@google.com>
To: Naveen N Rao <naveen@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Paolo Bonzini <pbonzini@redhat.com>, Joerg Roedel <joro@8bytes.org>, 
	David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Sairaj Kodilkar <sarunkod@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	Francesco Lavra <francescolavra.fl@gmail.com>, David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Jun 23, 2025, Naveen N Rao wrote:
> On Wed, Jun 11, 2025 at 03:45:23PM -0700, Sean Christopherson wrote:
> > Add a comment to explain why KVM clears IsRunning when putting a vCPU,
> > even though leaving IsRunning=1 would be ok from a functional perspective.
> > Per Maxim's experiments, a misbehaving VM could spam the AVIC doorbell so
> > fast as to induce a 50%+ loss in performance.
> > 
> > Link: https://lore.kernel.org/all/8d7e0d0391df4efc7cb28557297eb2ec9904f1e5.camel@redhat.com
> > Cc: Maxim Levitsky <mlevitsk@redhat.com>
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  arch/x86/kvm/svm/avic.c | 31 ++++++++++++++++++-------------
> >  1 file changed, 18 insertions(+), 13 deletions(-)
> > 
> > diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
> > index bf8b59556373..3cf929ac117f 100644
> > --- a/arch/x86/kvm/svm/avic.c
> > +++ b/arch/x86/kvm/svm/avic.c
> > @@ -1121,19 +1121,24 @@ void avic_vcpu_blocking(struct kvm_vcpu *vcpu)
> >  	if (!kvm_vcpu_apicv_active(vcpu))
> >  		return;
> >  
> > -       /*
> > -        * Unload the AVIC when the vCPU is about to block, _before_
> > -        * the vCPU actually blocks.
> > -        *
> > -        * Any IRQs that arrive before IsRunning=0 will not cause an
> > -        * incomplete IPI vmexit on the source, therefore vIRR will also
> > -        * be checked by kvm_vcpu_check_block() before blocking.  The
> > -        * memory barrier implicit in set_current_state orders writing
> > -        * IsRunning=0 before reading the vIRR.  The processor needs a
> > -        * matching memory barrier on interrupt delivery between writing
> > -        * IRR and reading IsRunning; the lack of this barrier might be
> > -        * the cause of errata #1235).
> > -        */
> > +	/*
> > +	 * Unload the AVIC when the vCPU is about to block, _before_ the vCPU
> > +	 * actually blocks.
> > +	 *
> > +	 * Note, any IRQs that arrive before IsRunning=0 will not cause an
> > +	 * incomplete IPI vmexit on the source; kvm_vcpu_check_block() handles
> > +	 * this by checking vIRR one last time before blocking.  The memory
> > +	 * barrier implicit in set_current_state orders writing IsRunning=0
> > +	 * before reading the vIRR.  The processor needs a matching memory
> > +	 * barrier on interrupt delivery between writing IRR and reading
> > +	 * IsRunning; the lack of this barrier might be the cause of errata #1235).
> > +	 *
> > +	 * Clear IsRunning=0 even if guest IRQs are disabled, i.e. even if KVM
> > +	 * doesn't need to detect events for scheduling purposes.  The doorbell
> 
> Nit: just IsRunning (you can drop the =0 part).

Hmm, not really.  It could be:

	/* Note, any IRQs that arrive while IsRunning is set will not cause an

or

	/* Note, any IRQs that arrive while IsRunning=1 will not cause an

but that's just regurgitating the spec.  The slightly more interesting scenario
that's being described here is what will happen if an IRQ arrives _just_ before
the below code toggle IsRunning from 1 => 0.

> Trying to understand the significance of IRQs being disabled here. Is 
> that a path KVM tries to optimize?

Yep.  KVM doesn't need a notification for the undelivered (virtual) IRQ, because
it won't be handled by the vCPU until the vCPU enables IRQs, and thus it's not a
valid wake event for the vCPU.

So, *if* spurious doorbells didn't affect performance or functionality, then
ideally KVM would leave IsRunning=1, e.g. so that the IOMMU doesn't need to
generate GA log events, and so that other vCPUs aren't forced to VM-Exit when
sending an IPI.  Unfortunately, spurious doorbells are quite intrusive, and so
KVM "needs" to clear IsRunning.

> Theoretically, it looks like we want to clear IsRunning regardless of whether
> the vCPU is blocked so as to prevent the guest from spamming the host with
> AVIC doorbells -- compared to always keeping IsRunning set so as to speed up
> VM entry/exit.

Yep, exactly.

> > +	 * used to signal running vCPUs cannot be blocked, i.e. will perturb the
> > +	 * CPU and cause noisy neighbor problems if the VM is sending interrupts
> > +	 * to the vCPU while it's scheduled out.
> > +	 */
> >  	avic_vcpu_put(vcpu);
> >  }
> 
> Otherwise, this LGTM.
> Acked-by: Naveen N Rao (AMD) <naveen@kernel.org>
> 
> 
> Thanks,
> Naveen
> 

