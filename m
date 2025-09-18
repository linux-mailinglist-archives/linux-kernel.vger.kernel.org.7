Return-Path: <linux-kernel+bounces-759408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E984B1DD2D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 20:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EEF534E254E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 18:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12383218ACC;
	Thu,  7 Aug 2025 18:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hnmqpRKz"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051F7258A
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 18:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754591929; cv=none; b=oHeALNwY6XlJrCsb0iTASehDvQuZ8w1UgUvzJRzxe9598Yh5NhvSMIi0W9DvygmcxhKOYTDxiaEY6yTTPEobsEV5yoYAZi3ePNcATp+aGHqNjVaejnqT+7e+SAzcZi+1Cs6kh6lUWozaCM0ceBfP1JOB+ylO1yirtVj2lNdXxiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754591929; c=relaxed/simple;
	bh=xmmHCmJcE2ulD2451FS6SDHBUoDFstNnx3dJA00gofo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SgtI2U2fiy4ltd3F5wIACOf+jtV0i36qJszWIIUbOWwBI0elj8FMQVQq8pdC5oHbF6T3epk1diocPGiTVFSz1SCmMlHTYb6zf4ZfQOzcg0uXtA1TiSMivrtX6Hj3nTGhw2IasBK+iLZ72xye/zHWxc3tAqJg/9TmwMCN5OEf4lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hnmqpRKz; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3211b736a11so2788834a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 11:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754591927; x=1755196727; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yp84IsrpOeYSbgICcPR8apvUJuROu2Gav6Oyrx9mTk4=;
        b=hnmqpRKzSQp0UndbKtkjlzsUeE52pwoO38uc6md0/VsOZ30hrpGBYfIVSY3n46So4D
         qvcjHtUBxOxgLjGVZ3d5fvytgJGxYZ6N2XI1+2oLVAbVtpnLMRqK588RTV9FrYf5vMuW
         OYb0f6J5eAFTtuWqKlNKdFn8IoR9jfY2ONyZZwX3xXSsoXBuv295hLpkmeXpes1rVwrA
         /UYYqd5tA8QeeqyJNxhDeX9AyHXgyM6m6LVgewrIWd9TmBqd6+wL7CaRaENifMYFpJoB
         P9rsn9CHqw4njfOOH2wX3RL2OYmf51TCiSHI5gltPW+MMcpARprDlN/V2fkG+Herjfmd
         EaoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754591927; x=1755196727;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yp84IsrpOeYSbgICcPR8apvUJuROu2Gav6Oyrx9mTk4=;
        b=QXhe6+6MkJSK/8G3BCKFB1Cz3z8lWyiVDI/Ueq0U1vVfGVdJtCqLEDCtfLq0YQODOx
         sl2sWr52s/VQEczwy3TDn5HUU2c+DcVa+94a2VM6ZayHAw07TosZIXEH0frJsU+9y3a0
         34+SulNn6li7W79pP1p3kE7gcUl0/0FX9+MwlkStCqrry/YlJdhmzssDO33FLPqOPNr9
         Ap+pDigAFr4YlYZNn/G7mcFtJXwzFab+C7NIW6uzSSPhG7g6PrqjHzwDF46yl08zPMd1
         SmE1W4uplFGKIOXLiwZ+7HSzzX+Xod7W+uq1R7jTMmrbufnfhHWbD3f2E3/eXNxnMZY5
         npCw==
X-Forwarded-Encrypted: i=1; AJvYcCWtLQgOubINk19k5z/2iI2XytBU9JnRtQjh+Z244WDivQrvilaK24J8tNjX/fJnwbHPtOKTe0xK0EkEFkU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZTuaSp3R4+SGmUBUJ20K4VAvDzEgvxUA1FaMUCSJQz+HH28DY
	WndlzWX4msGU5ZxGCVF6YkH8JKPEjDERxTHQSbSEH9fl/QRKs/QYrTp7UXwuPgulkfCZ+N0bBfl
	2GZzD+w==
X-Google-Smtp-Source: AGHT+IFCWCOlCO6n5/AEOdaCe6fYz3jM8iX2vBVKNK9vB/91SLgPbLstukRS4VE0qXM9vySMQaYSmXIXgcA=
X-Received: from pjg13.prod.google.com ([2002:a17:90b:3f4d:b0:31c:2fe4:33ba])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4b41:b0:31f:6ddd:ef3
 with SMTP id 98e67ed59e1d1-32183e74d4dmr55251a91.35.1754591927300; Thu, 07
 Aug 2025 11:38:47 -0700 (PDT)
Date: Thu, 7 Aug 2025 11:38:46 -0700
In-Reply-To: <CAAdeq_+Ppuj8PxABvCT54phuXY021HxdayYyb68G3JjkQE0WQg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250806081051.3533470-1-hugoolli@tencent.com>
 <aJOc8vIkds_t3e8C@google.com> <CAAdeq_+Ppuj8PxABvCT54phuXY021HxdayYyb68G3JjkQE0WQg@mail.gmail.com>
Message-ID: <aJTytueCqmZXtbUk@google.com>
Subject: Re: [PATCH] KVM: x86: Synchronize APIC State with QEMU when irqchip=split
From: Sean Christopherson <seanjc@google.com>
To: hugo lee <cs.hugolee@gmail.com>
Cc: pbonzini@redhat.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, x86@kernel.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yuguo Li <hugoolli@tencent.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Aug 07, 2025, hugo lee wrote:
> On Thu, Aug 7, 2025 Sean Christopherson wrote:
> >
> > On Wed, Aug 06, 2025, Yuguo Li wrote:
> > > When using split irqchip mode, IOAPIC is handled by QEMU while the LAPIC is
> > > emulated by KVM.  When guest disables LINT0, KVM doesn't exit to QEMU for
> > > synchronization, leaving IOAPIC unaware of this change.  This may cause vCPU
> > > to be kicked when external devices(e.g. PIT)keep sending interrupts.
> >
> > I don't entirely follow what the problem is.  Is the issue that QEMU injects an
> > IRQ that should have been blocked?  Or is QEMU forcing the vCPU to exit unnecessarily?
> >
> 
> This issue is about QEMU keeps injecting should-be-blocked
> (blocked by guest and qemu just doesn't know that) IRQs.
> As a result, QEMU forces vCPU to exit unnecessarily.

Is the problem that the guest receives spurious IRQs, or that QEMU is forcing
unnecesary exits, i.e hurting performance?

> > > diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> > > index 8172c2042dd6..65ffa89bf8a6 100644
> > > --- a/arch/x86/kvm/lapic.c
> > > +++ b/arch/x86/kvm/lapic.c
> > > @@ -2329,6 +2329,10 @@ static int kvm_lapic_reg_write(struct kvm_lapic *apic, u32 reg, u32 val)
> > >                       val |= APIC_LVT_MASKED;
> > >               val &= apic_lvt_mask[index];
> > >               kvm_lapic_set_reg(apic, reg, val);
> > > +             if (irqchip_split(apic->vcpu->kvm) && (val & APIC_LVT_MASKED)) {
> >
> > This applies to much more than just LINT0, and for at least LVTPC and LVTCMCI,
> > KVM definitely doesn't want to exit on every change.
> 
> Actually every masking on LAPIC should be synchronized with IOAPIC.

No, because not all LVT entries can be wired up to the I/O APIC.

> Because any desynchronization may cause unnecessary kicks
> which rarely happens due to the well-behaving guests.
> Exits here won't harm, but maybe only exit when LINT0 is being masked?

Exits here absolutely will harm the VM by generating spurious slow path exits.

> Since others unlikely cause exits.

On Intel, LVTPC is masked on every PMI.

> > Even for LINT0, it's not obvious that "pushing" from KVM is a better option than
> > having QEMU "pull" as needed.
> >
> 
> QEMU has no idea when LINT0 is masked by the guest. Then the problem becomes
> when it is needed to "pull". The guess on this could lead to extra costs.

So this patch is motivated by performance?

