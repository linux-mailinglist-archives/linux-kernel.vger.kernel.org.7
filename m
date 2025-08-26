Return-Path: <linux-kernel+bounces-786744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28048B366F7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 16:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20B59189DFD9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 13:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B8834F490;
	Tue, 26 Aug 2025 13:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csie.ntu.edu.tw header.i=@csie.ntu.edu.tw header.b="jqLjY1G5"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BBD352078
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 13:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756216348; cv=none; b=Ik+M8lYmoz/c6x93HSuC3z3GC6Nflndtr+EraY58qnb5ww4bNuT5b3qFGmFkhP7dVkeU+BwZQM+2LMrQTUSqFg4kGDp1lCzqG7H9tgHlUYZ1bvBQBNtjkxlVc3+++KmS3Uhm82Ywm9MH4wmyzzkQoyxxcy/+xVy8oRFdALXkd10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756216348; c=relaxed/simple;
	bh=ekOHapBN3MK0HyC/SCeCFRc8rNUhhpwxn7KoJlL/4hY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m80QSZfLFDE6/fpavFtUh3RBy0NbmCub3EOAJ6m1xwpAn1YM1FOb1aNetS+bLDc8i9HKkJanrB8AerspXpf01AyMVLIXbcY5x4cal8XXa7lDVkkERsLalFiNZyLVOFZUq5YMIY0aLBiVicbl08KVvm4KYFlPAtbVUiIsQcM+AlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.ntu.edu.tw; spf=pass smtp.mailfrom=csie.ntu.edu.tw; dkim=pass (2048-bit key) header.d=csie.ntu.edu.tw header.i=@csie.ntu.edu.tw header.b=jqLjY1G5; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.ntu.edu.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csie.ntu.edu.tw
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-24456ce0b96so56394945ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 06:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=csie.ntu.edu.tw; s=google; t=1756216346; x=1756821146; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lHGyXOKrjm5oz81TLpvSpWDaUb0vSgaahBghiDLKLpk=;
        b=jqLjY1G5BeX1FmzNlbvR9tZLSDD8pFoUTPU1aYxnojCzJ99gYMrNUFcAf2pg/YBFBL
         x9AzlNfJEmYJHSyGk446/92gq7ZiM8JgKWsK36HMAvEoaYaIW3+aLYkib7Ed/toQeD55
         zlg2fb/DQ98lzoJXmIAgF8caqeFBmsOPfem1kHP2oyirZDn+dMDKmz4+siZ6f2uDjb5G
         lh06f57edZX9Y1iGVmt+lQG6GEv7nlc2JsTTifShUIPM+jdJtgGzN87pApRLvlfk+ScM
         kPmzAvfCb2vYIOt34f6dCrCvTxM1beKDKIZ10Eggq4AhPL1suOowzbtBSvGfOSRf1s92
         nyrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756216346; x=1756821146;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lHGyXOKrjm5oz81TLpvSpWDaUb0vSgaahBghiDLKLpk=;
        b=bnK9D4pVTVmFqc9CpkIKKoeE5rKkQLTILtsMSp1s2oiNxXnrgSjiPJWlhoi19pfpE9
         GvPKoBCMhrz75Vwhwp7+NJPaY3hnj236fiLui4MwVhE/8wNrXF0G8BUkhVLwo+SO6Iu+
         l/YklwOnc5kpYvfZNQwPzW6NZDpHL7hvhokgohy/RWhn4hJ8IU5YfoT6r/ZdIZRSHscJ
         naiIBpRk+G7iEYNLMRpNkeUFRsEatTIT8tqfaYQiDcS/fmO5CTHM/3MxJPmTuKbdFheu
         kbUXDanakNGkCLbsnr+jCAT6DohDDfiU3GKnkWPoZ8qrWVjEgjdmxux8ch4B1GhXMohg
         C8tQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6vbJoELPjSkqK6o4GO2hzzgmrqZLGO87XSBD/AZXnjxzmP+fJWppHaO2SfFLmSoTl82sK4jjDtR8DUA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVhI0OY4OJtLar+qyVCCqjAcVi0vcz+7QDQR09Sc+sV/BadKrM
	DiIEu32KTZlwGpIb2AwbBb+tSFtG9DmZaxYqWkxQgiI/FZHZ7K/kjrEcFOBaeqVJi/GV2ISM0eH
	8LIwdfKTkizbbPaRdYXiXGN5m8W8rMElPEmbOeRyjCSzIaBhn+X6MHLwmBDo=
X-Gm-Gg: ASbGncuN/tbL2lPx1seMEw/qbhcCrSfuJQnsUmdLCdkaNf4Pm9SZKHTd/pdj9Rw8If/
	+sihxZ22AXGWV04jmC1xXr35QlCDoN0+J4uiuYZZERkWPyefkls4dEhMknInp2X41ASQcY/krap
	8Y9ZVkiP/FqU9C8MpOSrWrE7DfROx2mussaELhZsQHVi2egMzMZ86Ug5xUe76p62jhj6ZzLzcL1
	ohbBzX8CtlNRpm7FDatnUhgLIzGDqmpFlGip1m9bpIaa4StcqMWGOsJd1sJAoDImD67cRfIWoao
	AihIYt6agzSYmIO6wKGpZ5jZtvAoqgHkORCmeKsaV5L8DO1p3HzB2ttLqEIgAsUf6rttfSokUkG
	a99QFLCkPPsnM57xfEvuHzAk4A5ThVcVyix8vDP9XCZj0/j6VAMZQoFOzCtqVJ611mKnM
X-Google-Smtp-Source: AGHT+IGxhWDFYVYxqq2b3637yU3GvKWhKRYnWWKXaAejHtAF5wXzw4/2DHVTT2A4Zo0gjU/UoaN6ZA==
X-Received: by 2002:a17:903:238a:b0:245:f860:80b1 with SMTP id d9443c01a7336-248753a264dmr23720075ad.11.1756216345708;
        Tue, 26 Aug 2025 06:52:25 -0700 (PDT)
Received: from zenbook (1-162-83-231.dynamic-ip.hinet.net. [1.162.83.231])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24668889dbbsm96756765ad.132.2025.08.26.06.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 06:52:25 -0700 (PDT)
Date: Tue, 26 Aug 2025 21:55:11 +0800
From: Wei-Lin Chang <r09922117@csie.ntu.edu.tw>
To: Oliver Upton <oliver.upton@linux.dev>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH] KVM: arm64: nv: Allow shadow stage 2 read fault
Message-ID: <l4ge3jp2leuzxkpn7nowptl7hjzeiq6amqowibycdhuahgafnw@o3dcvj7njix5>
References: <20250822031853.2007437-1-r09922117@csie.ntu.edu.tw>
 <aKg3l23hheuQ1dJH@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKg3l23hheuQ1dJH@linux.dev>
X-Gm-Spam: 0
X-Gm-Phishy: 0

Hi Oliver,

On Fri, Aug 22, 2025 at 02:25:43AM -0700, Oliver Upton wrote:
> Hi Wei-Lin,
> 
> You've been finding some good stuff with nested, thank you :)
> 
> On Fri, Aug 22, 2025 at 11:18:53AM +0800, Wei-Lin Chang wrote:
> > I am able to trigger this error with a modified L1 KVM, but I do realize
> > this requires L1 to be very strange (or even just wrong) so I understand
> > if we don't want to handle this kind of edge case. On the other hand,
> > could there also be other ways to trigger this that I have not thought
> > of?
> 
> The architecture is pretty unambiguous here that the stage-2 can
> represent a translation w/o read permission.
> 
> > Another thing is that this change lets L1 get away with not flushing the
> > TLB, but TLBs are ephemeral so it's fine in this aspect, however I'm not
> > sure if there are other considerations.
> 
> FEAT_ETS3 is an interesting one since it provides software with ordering
> expectations around MMU faults (including permission faults) and updates
> to the translation tables. For KVM's shadow stage-2 to comply we need to
> re-walk the guest's stage-2 before injecting the fault at L1.

Thanks for telling me this, I haven't noticed ETS before, let me learn
about it.

> 
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
> 
> Hmm... I'm also willing to just delete this check altogether. The
> likelihood of KVM creating a stage-2 PTE w/o read permission is rather
> low.

Agreed, and this is in agreement with Marc, let me drop this in the next
version.

Thanks,
Wei-Lin Chang

> 
> Thanks,
> Oliver

