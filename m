Return-Path: <linux-kernel+bounces-786730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DA7B3663F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 15:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10DE28E7BEF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 13:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D9E350D60;
	Tue, 26 Aug 2025 13:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csie.ntu.edu.tw header.i=@csie.ntu.edu.tw header.b="iSt/vX2T"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A9F350830
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 13:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756216014; cv=none; b=N1u5bDsO3oEBbKtqEzf8si1AaLiyejjAZ19HEKWZldfGQLigvYBKG+v4zwNnLyfgK1LJhlvxYvPUYEz9AWEdW6SR9moYnw9k0gT15lL4d071n5TDZ6nCCr5yfwxlysF3JYek8NYRMY1Z6U7S8c0XYWX3HpiHpEOMA7892IPoBlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756216014; c=relaxed/simple;
	bh=D2WCPWAROvWpGOBAO/irESE4qw7Dj1nlyMvIle7uz6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eL1e3CQkm18WCegu8lTNCnZbq+efhRHd2RetcVBGcSpr7pyjnXl913ngdVqNq7i/Y9td7bid0/Jkq97SkhgU51mPGTzqr7T+DFKRa8EKgEXhcFtZOR5KJSYOR9+aFz8+O3A4MO6Wrlm+Qtdv8L8MJM1Wl0Tbt+xtjPkcr2VtrC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.ntu.edu.tw; spf=pass smtp.mailfrom=csie.ntu.edu.tw; dkim=pass (2048-bit key) header.d=csie.ntu.edu.tw header.i=@csie.ntu.edu.tw header.b=iSt/vX2T; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.ntu.edu.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csie.ntu.edu.tw
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso4928272a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 06:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=csie.ntu.edu.tw; s=google; t=1756216010; x=1756820810; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=osdPfu3X+WvVcN3qUZlA7PO/Is6NQe7OboBpnwUj8qo=;
        b=iSt/vX2TlYvIWAyJwv3gDnZUwmQxwCCuWUg4SosEshIvkjzo/wKX/oADP/UnWoMjHD
         bZsaemNv07Lte3vtSE7LHs/zjpwP1/SyPgLqqYc9uqut6OylzZbTBWPJoRP6GKPj2rWj
         +wKemfkEHQzekyjD7LVCaPvBKcMkncA8FUbESh6BtJUj7wjSTIHvqcOnksrke2uvnTuo
         pfrrOnr6EeMtaUNz0vLVdEeCPQoEE1lGco1Iuq7xNdqt/xRcXcPw0kqHcurnruKacJoF
         ND1H20gONENVcuRBd2u45wbCwt8/4YOJm1MwcHcbViQUjAlMUCSLbcLj2q2eFYYhTzfy
         pohw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756216010; x=1756820810;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=osdPfu3X+WvVcN3qUZlA7PO/Is6NQe7OboBpnwUj8qo=;
        b=CPjX/AzFJ/7OCYt3n/9alB5ApAPbO2mw/PFnig9Ue66RTZbB+V1m4DFK8qtft9k1XR
         QiUGRnKjCmcantYs5pqv9FPOH20mFQRtUihWFxD1Wpm3dU4cp6hvVc2IGLqdxAkE+BfZ
         RYwXkQZrDgX+2FlUNwFx06sgI4eBQgaxD789q9kmd7ftPAxB/djzdSVclhbpgF2bb9eS
         +dqZL14/j6cVW/ednQJ7tH3IjpizJIfhRECqDo3ht1XVGB3PWfbQ4phRloy1Ulv/ecT6
         3kKGSqLGTIakyNrDskr/3oQjEIxxpRzYhMI0LFduBlYhU5CdLfALCH8pw1VPGYJhulKM
         wMvg==
X-Forwarded-Encrypted: i=1; AJvYcCUKXrOZY7Z12v+Lw0OKX6rXbZeiqwz5epYG6tt73BKeeqL81dSJMVRFr12eBF5hAFAjTPoqYuAudDCIarw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN044jhI+XluzTS8zSGjZIg006y0MwKLH1kZBEAH1HTLZuXGSW
	xPOU8htZpTu/Zx3eCRJ10rJSKTHcG50zjPEaL58YkxCRlvWZFY+V/R43KFOj7+AWFkHVGpgG3Aj
	SPp6YAjYHKsxvlcBzSyTZT5MT2B+GkFcNGYTXZ92ijAN0wUHybpQrXxJ68KKqF1536f9VjZDhCk
	w=
X-Gm-Gg: ASbGnct+gjZahCMsGRX/yDA3f0qVVJ+vMq0weIKWT8zFiBWt9ChJ1tfrjqP3PNbn1oA
	zim9OBy0rBf5py2+fMJ85Ea1gaX5v7cMm/HCp0tAv+iUUJWOhWM9wMSzY3GbKzay7a9ZHh6B4nC
	/hD43Beqy/8KBnvR4Qj97gjs/AcnKF5yahAAzr+WA0ZGGK3RtM2Cjy0/FmEse/SafLYFgze2bBi
	O+GDtvtv5oX3+y4Jkqa5e02copCNmGWgFQ9gmDgRQJX9/4kJT5EoXHrZS97CbBCBFkO8gRirW8D
	2ZJwDq8qlb0/34fr8Msp8tKguocjhzwgPSC51NvFp+bweDeczQCFj2xtM5OJDDgnDTmQ04UUu1C
	ZRxQAceDV+rtDymOIJdOkMTGSZP0o7emi2O4LahvwGUHyxPBTLb5BhcH6zg==
X-Google-Smtp-Source: AGHT+IEapx+qUYn+gnSfpFGolofqtYLrq6ffT2yt159qZt5g4CsSb6AqyhXzJhjpuNXlfxvFnyc/wA==
X-Received: by 2002:a17:902:c94d:b0:245:f002:d67c with SMTP id d9443c01a7336-2462eeb6325mr197352005ad.30.1756216009581;
        Tue, 26 Aug 2025 06:46:49 -0700 (PDT)
Received: from zenbook (1-162-83-231.dynamic-ip.hinet.net. [1.162.83.231])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2466887198dsm96470935ad.110.2025.08.26.06.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 06:46:49 -0700 (PDT)
Date: Tue, 26 Aug 2025 21:49:27 +0800
From: Wei-Lin Chang <r09922117@csie.ntu.edu.tw>
To: Marc Zyngier <maz@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH] KVM: arm64: nv: Allow shadow stage 2 read fault
Message-ID: <djypsyratk63ovzv3flzb2tmunqtcoryzserwhsaaq5nuogsrx@u3uuwynnafbj>
References: <20250822031853.2007437-1-r09922117@csie.ntu.edu.tw>
 <87a53rk83s.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a53rk83s.wl-maz@kernel.org>
X-Gm-Spam: 0
X-Gm-Phishy: 0

Hi Marc,

On Fri, Aug 22, 2025 at 10:40:07AM +0100, Marc Zyngier wrote:
> Hey Wei-Lin,
> 
> On Fri, 22 Aug 2025 04:18:53 +0100,
> Wei-Lin Chang <r09922117@csie.ntu.edu.tw> wrote:
> > 
> > We don't expect to ever encounter a stage-2 read permission fault,
> > because read permission is always granted when mapping stage-2. However,
> > this isn't certainly the case when NV is involved. The key is the shadow
> > mapping built for L2 must have the same or stricter permissions than
> > those that L1 built for L2, hence opening the possibility of mappings
> > without read permission.
> > 
> > Let's continue handling the read fault if we're handling a shadow
> > stage-2 fault, instead of erroring out.
> > 
> > The following illustrates an example, vertical lines stand for either
> > L0, L1, or L2 running, with left: L0, middle: L1, and right: L2.
> > Horizontal arrows stand for traps and erets between them.
> > 
> > '''
> > L0                               L1                               L2
> >                                                L2                 |
> >                                                writes to an L2 PA |
> > |<----------------------------------------------------------------|
> > |
> > | L0
> > | finds no mapping in
> > | L1's s2pt for L2
> > |
> > | L0
> > | injects data abort
> > |------------------------------->|
> >                                  | L1
> >                                  | for whatever reason
> >                                  | treats this abort specially,
> >                                  | only gives it W permission
> >                                  |
> >        eret traps to L0          |
> > |<-------------------------------|
> > |
> > |      eret back to L2
> > |---------------------------------------------------------------->|
> >                                                                   |
> >                                                    L2             |
> >                                                    writes to same |
> >                                                    L2 PA (replay) |
> > |<----------------------------------------------------------------|
> > |
> > | L0
> > | finds mapping in s2pt that
> > | L1 built for L2, create
> > | shadow mapping for L2,
> > | but only gives it W to match
> > | what L1 had given
> > |
> > |
> > |      eret back to L2
> > |---------------------------------------------------------------->|
> >                                                                   |
> >                                                    L2             |
> >                                                    writes to same |
> >                                                    L2 PA (replay) |
> >                                                    success        |
> > |<----------------------------------------------------------------|
> > |
> > |
> > |------------------------------->| L1
> >                                  | for some reason, relaxes
> >                                  | L2's permission from W
> >                                  | to RW, AND, doesn't flush
> >                                  | TLB
> >                                  |
> >        eret traps to L0          |
> > |<-------------------------------|
> > |
> > |      eret back to L2
> > |---------------------------------------------------------------->|
> >                                                                   |
> >                                                     L2            |
> >                                                     read to L2 PA |
> > |<----------------------------------------------------------------|
> > | stage-2 read fault
> > |
> > '''
> > 
> > Signed-off-by: Wei-Lin Chang <r09922117@csie.ntu.edu.tw>
> 
> Excellent detective work! Bonus points for the ASCII art -- I'm not
> sure how practical it will be to keep it in the final commit, but this
> definitely helps understanding the issue.

Thanks, I tried to make it clear for those that aren't familiar with NV,
including myself :P

> 
> > ---
> > 
> > I am able to trigger this error with a modified L1 KVM, but I do realize
> > this requires L1 to be very strange (or even just wrong) so I understand
> > if we don't want to handle this kind of edge case. On the other hand,
> > could there also be other ways to trigger this that I have not thought
> > of?
> > 
> > Another thing is that this change lets L1 get away with not flushing the
> > TLB, but TLBs are ephemeral so it's fine in this aspect, however I'm not
> > sure if there are other considerations.
> 
> Well, it depends whose TLBs we're talking about. The CPU TLBs are
> definitely ephemeral. But the KVM-managed TLBs (aka the shadow S2) is
> pretty static, and I am a bit worried to relax this.
> 
> What would happen on actual HW? L1 would take a S2 fault, because the
> TLBs are out of sync with the S2 PTs. And yes, maybe the TLB pressure
> woulds make it so that it works *sometimes*, but there wouldn't be any
> guarantee of forward progress as long as EL2 doesn't issue a TLBI.
> 
> I reckon we should implement that particular behaviour whenever
> possible, and handle permission faults early, possibly ahead of the
> guest S2 walk (the way we handle VNCR_EL2 faults is IMO a good model).

The parts above make complete sense.

> 
> This would imply taking the guest's S2 permission at face value, and
> only drop W permission when the memslot is RO -- you'd then need to
> keep track of the original W bit somewhere. And that's where things
> become much harder, because KVM can decide to remap arbitrary ranges
> of IPA space as RO, which implies we should track the W bit at all
> times, most likely as one of the SW bits in the PTE.

But sorry, I struggle to understand this paragraph after reading it many
times, probably my experience with the code isn't enough for me to make
the connection. Why are we talking about the W bit suddenly?
If you don't mind, can you reword what's discussed here?
I only very vaguely get that there will be 2 W bits, one from what L1 set,
and one from the L0 memslot, if I didn't completely miss the point..

> 
> We'll need exactly that if we ever want to implement the
> Hardware-managed Dirty Bit, but I have the feeling we need an actual
> design for this, and not a quick hack. Your approach is therefore the
> correct one for the time being.
> 
> > 
> > ---
> >  arch/arm64/kvm/mmu.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> > index 1c78864767c5c..41017ca579b19 100644
> > --- a/arch/arm64/kvm/mmu.c
> > +++ b/arch/arm64/kvm/mmu.c
> > @@ -1508,8 +1508,8 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
> >  	exec_fault = kvm_vcpu_trap_is_exec_fault(vcpu);
> >  	VM_BUG_ON(write_fault && exec_fault);
> >  
> > -	if (fault_is_perm && !write_fault && !exec_fault) {
> > -		kvm_err("Unexpected L2 read permission error\n");
> > +	if (fault_is_perm && !write_fault && !exec_fault && !nested) {
> > +		kvm_err("Unexpected S2 read permission error\n");
> >  		return -EFAULT;
> >  	}
> >  
> 
> Honestly, I'd rather kill this check altogether rather than adding
> another condition to it -- I suggested it to Fuad a while ago. This is
> the first time we ever see it firing, and I don't think it is bringing
> much.

No problem and agreed. Let me prepare another version.

Thanks,
Wei-Lin Chang

> 
> Thanks,
> 
> 	M.
> 
> -- 
> Jazz isn't dead. It just smells funny.

