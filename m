Return-Path: <linux-kernel+bounces-782795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F629B32572
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 01:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8779D18957D5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 23:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72EB2D7DE3;
	Fri, 22 Aug 2025 23:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n/JKxNoj"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877F52D77ED
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 23:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755906107; cv=none; b=UEYoai2ktrSuMXity96xhwuQQRBizIlpU4atP0Do4hdO7+b4CNUwDVhDYaTneDbjAA9KpFfm/Vv6WKBY8cl/oaRcD5YeHGhdEh/8ZFThJz2AApxXPk57MJ+2xRNJ3IaULUgJmmYm/fNgeoVvEOKqXmrEaVQ02NVFyKMOWgNcsVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755906107; c=relaxed/simple;
	bh=SOvXdEZ36PH+tJcH1zN06z9olV2DKvljFieOLV0k5vs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e87Y5CS+yMiphIrx1E6Yy7aa0K3CjDnaHOE9ebhTzkVurO6cJ8GKxDR08orQua0bDkvnd2O14yRqFPN1mf1RAD1w1qXtvHTJdOYxIzY+V7e9vQ6Cn5XRxBL+53YguBFLUx4veU0DMdiHRyfP1juhpL6a3U8ClufkXaD9IgEbQcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n/JKxNoj; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b4716fa1e59so2174258a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 16:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755906105; x=1756510905; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fFU7jCN2XLKUQXn5ynDvIjTb9dOTtmOmapnVFiz/ZUE=;
        b=n/JKxNoj9PlT396/ERHms7Q9H/TPVwlnH8CDgiPUCYF3ZachXaGhxrLyDwdhRuR+Dl
         8Eh9mMEfhpTf07RM9REZqFjNDxJsK7pTv3ChspYRAuMxT4UWm+QmSAuQ928/rtr2qLVT
         bmfM/nxshU7ulXph5NzeumjOI9alnrtY+CG+iaQRt2afZgi54rEJV58afErgxZayJ2TR
         HGF7KXPOquCAW5bp/ZzNdt58PXf6GzBfIqyudRtkIEPGn+ajAwjEBRB2rITD/aKAPqt2
         24+Tx8utp2FP8an1ivRBiXt1Ey6K04wJaNxwcOkwmNYs65dVnQ5gcQO5QzV7Fk0AKgsz
         5vBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755906105; x=1756510905;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fFU7jCN2XLKUQXn5ynDvIjTb9dOTtmOmapnVFiz/ZUE=;
        b=cOFXnybpNEimBPd+LBCH8ruawmFQ/tUuH2DZXV3MIUHO1a79mj5VljSEiZsH3TGffk
         78qDcbNrANv1JeMDsOPFQkLUGskZlhaNNd4dAacdFXvWVCLvddgSna3pWS3E0uSQz8hV
         iLBZQoKwIIKF1gbQkwS2gpiLKgEPPNp0zjQ01tX9dygLfdmy3wVUxkUxtxsNORud3b4W
         Pf8B2jdSoy3TiPseb3dspEXevOsoNMTmSZ9C2ZIs7sylzA5DODP6p4IzdZgN8q/jqAnb
         sXOwSKmFXpNnx8a4uh9cwC8mfUrILMFoSyIs2nwwnWiIgnYXuZZAcFZtnO5sx+SYISCk
         VPmw==
X-Forwarded-Encrypted: i=1; AJvYcCWtxsm4GdMLViLz0BVVvLgfPgyIkMBJfgsfuV/iRzjj47UJR0HEriqR86G70dUN2YfNgRmwSPqgJ9TIQjo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiXKGpObzzU+tMhhNR+28+YxHChv6O2tjvrELgE1jlvbH67Bqm
	/UbBr7KRU8tl20JzGPhkERktUyS715vJl47oAsenq7CDFXCLJ8jwFJG/NZCuDjIOW0L9I5aT9qZ
	XJMIvTQ==
X-Google-Smtp-Source: AGHT+IHIwd6WsabwqhIfexWFn6ScxbjqhO8dREcNotaTn36N/6t2XCMygT7osaldW9LFD2HPd2SxZPAJssk=
X-Received: from pfbft10.prod.google.com ([2002:a05:6a00:81ca:b0:746:2ae9:24a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:1596:b0:240:1f14:f6c5
 with SMTP id adf61e73a8af0-24340daf373mr6558922637.32.1755906104831; Fri, 22
 Aug 2025 16:41:44 -0700 (PDT)
Date: Fri, 22 Aug 2025 16:41:43 -0700
In-Reply-To: <90f4e95a-14ca-40aa-9233-389974734c3c@maciej.szmigiero.name>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1755609446.git.maciej.szmigiero@oracle.com>
 <2b2cfff9a2bd6bcc97b97fee7f3a3e1186c9b03c.1755609446.git.maciej.szmigiero@oracle.com>
 <aKeDuaW5Df7PgA38@google.com> <90f4e95a-14ca-40aa-9233-389974734c3c@maciej.szmigiero.name>
Message-ID: <aKkAN1-2gQWCpWx4@google.com>
Subject: Re: [PATCH 1/2] KVM: SVM: Sync TPR from LAPIC into VMCB::V_TPR when
 setting LAPIC regs
From: Sean Christopherson <seanjc@google.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>, 
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, 
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Naveen N Rao <naveen@kernel.org>, 
	"Radim =?utf-8?B?S3LEjW3DocWZ?=" <rkrcmar@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Sat, Aug 23, 2025, Maciej S. Szmigiero wrote:
> On 21.08.2025 22:38, Sean Christopherson wrote:
> > On Tue, Aug 19, 2025, Maciej S. Szmigiero wrote:
> > > +	/*
> > > +	 * Sync TPR from LAPIC TASKPRI into V_TPR field of the VMCB.
> > > +	 *
> > > +	 * When AVIC is enabled the normal pre-VMRUN sync in sync_lapic_to_cr8()
> > > +	 * is inhibited so any set TPR LAPIC state would not get reflected
> > > +	 * in V_TPR.
> > 
> > Hmm, I think that code is straight up wrong.  There's no justification, just a
> > claim:
> > 
> >    commit 3bbf3565f48ce3999b5a12cde946f81bd4475312
> >    Author:     Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> >    AuthorDate: Wed May 4 14:09:51 2016 -0500
> >    Commit:     Paolo Bonzini <pbonzini@redhat.com>
> >    CommitDate: Wed May 18 18:04:31 2016 +0200
> > 
> >      svm: Do not intercept CR8 when enable AVIC
> >      When enable AVIC:
> >          * Do not intercept CR8 since this should be handled by AVIC HW.
> >          * Also, we don't need to sync cr8/V_TPR and APIC backing page.   <======
> >      Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> >      [Rename svm_in_nested_interrupt_shadow to svm_nested_virtualize_tpr. - Paolo]
> >      Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > 
> > That claim assumes APIC[TPR] will _never_ be modified by anything other than
> > hardware.  That's obviously false for state restore from userspace, and it's also
> > technically false at steady state, e.g. if KVM managed to trigger emulation of a
> > store to the APIC page, then KVM would bypass the automatic harware sync.
> > 
> > There's also the comically ancient KVM_SET_VAPIC_ADDR, which AFAICT appears to
> > be largely dead code with respect to vTPR (nothing sets KVM_APIC_CHECK_VAPIC
> > except for the initial ioctl), but could again set APIC[TPR] without updating
> > V_TPR.
> > 
> > So, rather than manually do the update during state restore, my vote is to restore
> > the sync logic.  And if we want to optimize that code (seems unnecessary), then
> > we should hook all TPR writes.
> > 
> > diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> > index d9931c6c4bc6..1bfebe40854f 100644
> > --- a/arch/x86/kvm/svm/svm.c
> > +++ b/arch/x86/kvm/svm/svm.c
> > @@ -4046,8 +4046,7 @@ static inline void sync_lapic_to_cr8(struct kvm_vcpu *vcpu)
> >          struct vcpu_svm *svm = to_svm(vcpu);
> >          u64 cr8;
> > -       if (nested_svm_virtualize_tpr(vcpu) ||
> > -           kvm_vcpu_apicv_active(vcpu))
> > +       if (nested_svm_virtualize_tpr(vcpu))
> >                  return;
> >          cr8 = kvm_get_cr8(vcpu);
> > 
> > 
> 
> So you want to just do an unconditional LAPIC -> V_TPR sync at each VMRUN
> and not try to patch every code flow where these possibly could get de-synced
> to do such sync only on demand, correct?

Yep.  For a fix, I definitely want to go with the bare minimum.  If we want to
optimize the sync, that can be done on top, and it can be done irrespective of
AVIC.  E.g. for guests that don't modify TPR, the sync is almost pure overhead
too.

> By the way, the original Suravee's submission for the aforementioned patch
> did *not* inhibit that sync when AVIC is on [1].
> 
> Something similar to this sync inhibit only showed in v4 [2],
> probably upon Radim's comment on v3 [3] that:
> > I think we can exit early with svm_vcpu_avic_enabled().
> 
> But the initial sync inhibit condition in v4 was essentially
> nested_svm_virtualize_tpr() && svm_vcpu_avic_enabled(),
> which suggests there was some confusion what was exactly meant
> by the reviewer comment.

Hmm, I suspect that was just a goof.  My guess is that Radim and Suravee simply
forgot to consider TPR writes that aren't handled by hardware.

> The final sync inhibit condition only showed in v5 [4].
> No further discussion happened on that point.
> 
> Thanks,
> Maciej
> 
> [1]: https://lore.kernel.org/kvm/1455285574-27892-9-git-send-email-suravee.suthikulpanit@amd.com/
> [2]: https://lore.kernel.org/kvm/1460017232-17429-11-git-send-email-Suravee.Suthikulpanit@amd.com/
> [3]: https://lore.kernel.org/kvm/20160318211048.GB26119@potion.brq.redhat.com/
> [4]: https://lore.kernel.org/kvm/1462388992-25242-13-git-send-email-Suravee.Suthikulpanit@amd.com/
> 

