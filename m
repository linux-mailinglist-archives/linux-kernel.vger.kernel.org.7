Return-Path: <linux-kernel+bounces-758594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 740EFB1D12B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 05:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FDC3726631
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 03:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213E51A8F97;
	Thu,  7 Aug 2025 03:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csie.ntu.edu.tw header.i=@csie.ntu.edu.tw header.b="kbuYeSEB"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D7C199EAD
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 03:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754536229; cv=none; b=lFJD71BNAdYF9fxnKBXFT3johZ0KH3+rQie0x4Ppq10bbVYi1xM1tuTkJVO4u22y2sMmFEkLf3XEdX8apjuLs55weTVsz7zw1SqnYgg31y50JfaSK4kELx0fkL/tu60pXuZbUda36mZQbxEs0I4eOdggp/Opv72PQtfTeBTVEhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754536229; c=relaxed/simple;
	bh=nrN/WKRHHInr2RbhcbZ9vP8u1SI12TAyiL10R/cI0GI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r278sh/7Ihd0Q01vtmns0i0SpMyXipCmdxu2zpA+b13xPSJB/ItHqWSNC43//W2SXlwXFI9sXhUr7GdetsDphU317Wv4Cepux3kqdnc1efOl5yyRrR2k3xcB5VPbbFKqU1/s6XcQ2fhE88GVrotbnJz9IDQgwtmZxs4eLfBoFd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.ntu.edu.tw; spf=pass smtp.mailfrom=csie.ntu.edu.tw; dkim=pass (2048-bit key) header.d=csie.ntu.edu.tw header.i=@csie.ntu.edu.tw header.b=kbuYeSEB; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.ntu.edu.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csie.ntu.edu.tw
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b3aa2a0022cso547848a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 20:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=csie.ntu.edu.tw; s=google; t=1754536225; x=1755141025; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gDbbzO/MBfCwa9anx+czvBO5imGoZ/RyUt5Cn2glgCY=;
        b=kbuYeSEBmdZfb+qzzfz5ps8a4ySyZAKXNsNf85w6BVA4CyGLlVCFFYh4oue9vELGK/
         YsPr2Vgk3Iw2nxWXgXl11Rx3MfIhH2Czg5GF8g1LLdeirOTtX7lKlOj4mU8Ga6NKuwZB
         6U/r1Y3jamvYWS6Ln2Rrne8Gdyp1YuXPOC+uX5xet9jm97adGVHSdtOT19Vxv2Tl35yK
         VbTtmNVbUCVBULVHgMwYyoTmC8TMUVYZYAP92d5FuZAK8KR3D2gS1wB8PzuQXO3aSPBg
         sLqa3Tt0e9CAK22hQnIt3b7gcoJnDC6JCwgqqalOBahG/PazwR7Rr/8mxMEE7ZGm7CMe
         yAfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754536225; x=1755141025;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gDbbzO/MBfCwa9anx+czvBO5imGoZ/RyUt5Cn2glgCY=;
        b=K3N2X+CKFsdxE+YroufaD3DExW4PyDNYVVOVERQ5z8P9yim9PczWzbWDxqJZVgIss8
         Qdgfmmjcx07e72znk/593IVks8iFBAqd+kxoJwO3yewQvc9ckjmc7lI7UlLM929BaBLR
         EP4fAUAVm5cdcG2hLLZXxr4fp5gt+W6Y2A6kVVyZYa07yenKXuEphrMnfx2oYm0e+oen
         t7dCa4zBXdhv5I3cFRQ6FnsddnvpjI81c9UkNgFMdL367RX2hBB9OkpJQrdi2G4E+zJn
         tOyMndrVs3RbH2+iblvPhRqgiJgb7ygdr8/Q+FCZpbbB2dX7plz8MoFiM9TYevNiCFtQ
         qz5w==
X-Forwarded-Encrypted: i=1; AJvYcCXKY7PeSdltL/ljBKBamtpnu3MZ1y+O+QX5YRGMaalw8rO738xnKs2e1fSRWWCmlf90pZuV1UEpt5CYTdo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAdyhOubHf0KXNWAcsTjzor98Ar02Y4a7FqiUgtdDNwaG5dP2z
	+do16m00G2Q2SK7N8CjaEaIYQ4ImF/VMGOlh4+f3CX9Ee/g5Oizy6eICKgAGmqG6uIO4NbcxFU/
	9zz3IL1m5XGkusd8QIxxP5pZoB53yLgbqWw8pow/Em3M0fe9urb1gLfLAHlYsi8hVWVHEO6kZe+
	s=
X-Gm-Gg: ASbGncvusaiX6riQfkZCqaPqI5jIwntC3I+qOqCgZcolRMXU/i0OCZ3vlXbkudx48Ag
	YA8c6fAT6IhNxQTzX+iJC+qeBthuyfA0wQ6rM9OfeBBPCOLjOdC3e24ca70NOQcSkzP7Q4dniJr
	+I3W1gyRg4ZEZ4rmMFADHT8LJE8uy2FX2Ymq8m7Nmj+Rj9/ZNUKkPbgVku/16uFZ+u0np2f6Upt
	zFPr0HyRSKp4A8kkxd6uu3aBtkDN9Lp4tyo8uthx/TiUqb9Et0vKBD079+awPvOO6XA6r8VUTgq
	cpSnedXazNMUrnAXEURvT4hSL0vaTSfqCH7J6/w+pWbg6G+uNHs+4RZv6+p/6cgrFwZpKfkTCAp
	QVjFDED7IWFdmkb5K/sCneeNAQmdT5JKH0W4q0Ju97Xsd3YT+s1Jav9+fBBEHeEsYVbaDdTQ=
X-Google-Smtp-Source: AGHT+IFMVcRp6VR4IdWnWexUALKIuSPhb07wbduD4zm+PjHvxwvZ6x3aGSq9zjx5g1N+kmv/0FkZ2Q==
X-Received: by 2002:a17:902:e748:b0:242:9bca:863d with SMTP id d9443c01a7336-2429f59ce44mr64630105ad.55.1754536224661;
        Wed, 06 Aug 2025 20:10:24 -0700 (PDT)
Received: from zenbook (118-163-61-247.hinet-ip.hinet.net. [118.163.61.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3216126c96esm4081982a91.22.2025.08.06.20.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 20:10:23 -0700 (PDT)
Date: Thu, 7 Aug 2025 11:12:55 +0800
From: Wei-Lin Chang <r09922117@csie.ntu.edu.tw>
To: Sebastian Ene <sebastianene@google.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] KVM: arm64: ptdump: Fix exec attribute printing
Message-ID: <yzl5a3r3vq42kbcsetdlmmtfaafzsyhcqzpfmlbhy3fqh4eylm@hocbkksrt2nj>
References: <20250802104021.3076621-1-r09922117@csie.ntu.edu.tw>
 <d72b7928-8646-4616-a8f0-96b9d9bbaf09@arm.com>
 <z2hmwwmtgbrio2wv3sj2pc4zhxdjioorlhnm45o2arcsjahjni@xod435q26jqq>
 <aJHBf4KCUPpWbyU5@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJHBf4KCUPpWbyU5@google.com>
X-Gm-Spam: 0
X-Gm-Phishy: 0

Hi all,

On Tue, Aug 05, 2025 at 08:31:59AM +0000, Sebastian Ene wrote:
> On Mon, Aug 04, 2025 at 08:41:35PM +0800, Wei-Lin Chang wrote:
> 
> Hi Wei-Lin,
> 
> > Hi Anshuman,
> > 
> > On Sun, Aug 03, 2025 at 07:33:04PM +0530, Anshuman Khandual wrote:
> > > 
> > > 
> > > On 02/08/25 4:10 PM, Wei-Lin Chang wrote:
> > > > Currently the guest stage-2 page table dump has the executable attribute
> > > > printed in reverse, showing "X" for a non-executable region and showing
> > > > " " for an executable one. This is caused by misjudgement of which
> > > > string gets printed for the executable and non-executable case. Fix it
> > > > by swapping the two strings.
> > > > 
> > > > Signed-off-by: Wei-Lin Chang <r09922117@csie.ntu.edu.tw>
> > > > ---
> > > >  arch/arm64/kvm/ptdump.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/arch/arm64/kvm/ptdump.c b/arch/arm64/kvm/ptdump.c
> > > > index 098416d7e5c25..99fc13f1c11fb 100644
> > > > --- a/arch/arm64/kvm/ptdump.c
> > > > +++ b/arch/arm64/kvm/ptdump.c
> > > > @@ -44,8 +44,8 @@ static const struct ptdump_prot_bits stage2_pte_bits[] = {
> > > >  	}, {
> > > >  		.mask	= KVM_PTE_LEAF_ATTR_HI_S2_XN | PTE_VALID,
> > > >  		.val	= PTE_VALID,
> > > > -		.set	= " ",
> > > > -		.clear	= "X",
> > > > +		.set	= "X",
> > > > +		.clear	= " ",
> > > >  	}, {
> > > >  		.mask	= KVM_PTE_LEAF_ATTR_LO_S2_AF | PTE_VALID,
> > > >  		.val	= KVM_PTE_LEAF_ATTR_LO_S2_AF | PTE_VALID,
> > > 
> > > Is not KVM_PTE_LEAF_ATTR_HI_S2_XN already in the reverse semantics aka
> > > XN (Execute Never). Hence when KVM_PTE_LEAF_ATTR_HI_S2_XN macro is set
> > > that means the entry is not executable and vice versa.
> > 
> > Yes you are correct. However in dump_prot() we have:
> > 
> > if ((st->current_prot & bits->mask) == bits->val)
> > 	s = bits->set;
> > else
> > 	s = bits->clear;
> > 
> > Analysis:
> > 
> > 1. region is executable:
> >     - st->current_prot == PTE_VALID (ignore other bits)
> >     - st->current_prot & bits->mask gets PTE_VALID
> >     - if condition is true (.val is PTE_VALID)
> >     - prints bits->set
> > 
> > 2. region is not executable:
> >     - st->current_prot == KVM_PTE_LEAF_ATTR_HI_S2_XN | PTE_VALID
> >     - st->current_prot & bits->mask gets (KVM_PTE_LEAF_ATTR_HI_S2_XN | PTE_VALID)
> >     - if condition is false
> >     - prints bits->clear
> > 
> > Therefore we want .set = "X", and .clear = " ".
> 
> 
> This seems correct but it will produce a different output than the
> stage-1 ptdump. What if we drop the PTE_VALID from the mask & value as
> Mark and Anshuman are suggesting and print NX when the bit is set and x
> otherwise as the stage-1 ptdump does ?
> 

Thank you all for the valuable feedback!
Yes, let me follow this and send a v2.

Thanks,
Wei-Lin Chang

> > 
> > Thanks,
> > Wei-Lin Chang
> 
> Thanks,
> Sebastian

