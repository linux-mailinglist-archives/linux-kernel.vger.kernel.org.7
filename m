Return-Path: <linux-kernel+bounces-818720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8F0B595A4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 13:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFE421646A9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 11:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12AF307AD9;
	Tue, 16 Sep 2025 11:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oLRaMHFV"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6872D661D
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 11:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758023888; cv=none; b=eKar9QC0H11CKxKcmCG8V+dmyksc+TG6wdYo2+gEz2MOdEFUK4bIBSnL9vJFboJDcFfeuie+1oLsSmjMCK1tkhWVPB6Dhzz5hGhE23Q/vVdVl0MlXtQlEvbn6Bh7w9C0y2gHsARIM2bulgsznRybsMSdiGfld2X04xcZW2aFxWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758023888; c=relaxed/simple;
	bh=uO0NCh73QWjdt5Uyj9kU6fcAnxi3vw1tE7kTtVZcrLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uK/XSNNAzDLoZUNajR3vgPvY/R9GiJxgKhEwaP8AxngyG4err9g7msex4msGFQehC3K1JO8UxWratDK7BfhvuADrBewcGD1yx5qKhIRRqfm+Ql633cGTKM++T6jYIFY67emwcIQL9nrbHinR4K/2EcFrKNtvcrwHPX1Ac2I+7us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oLRaMHFV; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45f28aba94cso43575e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 04:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758023885; x=1758628685; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3psH5CD7tcrvwMqVdIhmXfChnHfszSZCh0gJTDmLAQs=;
        b=oLRaMHFVQMkysV66+Nu69wmZRbOiS4zzsiqqc8Bdz43D4CLu2W9hUjwiSRA67f2RAI
         82ALpWoO9zH9WFEwS8PbsveaYoyvhDOIPRFyODemlUyh9Co7rAYU67l36X12ryCzz+VY
         7cp+22IlCaCdAzv80G08oXk7OzfMnRiKnbflUklGwBO1y796mnRWhfL3N4vEH8r9i0lV
         o5c4tdTqVqs1HH+peefgGn/faapJTTh93XINMqhLat70pT+ad5dqeK3F162jeILo/PKp
         DyI1SowAEtED8ku3332fCe0jw0T2uc+tn3SnYvHl+KmlJxUJor3GE3HCYLbStQ/Ep/7i
         vjtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758023885; x=1758628685;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3psH5CD7tcrvwMqVdIhmXfChnHfszSZCh0gJTDmLAQs=;
        b=kAAoTXUYMLxzUdwsgbtNZP+TouUOScHs2HgStQFRVLQTI+fVc8xg77ClGXmHGt6SF9
         8IVWEWecUg5NGJafTBctYsjCkE5TwiuZSvzqTvYlGR9lMjCRAjGfXxJfriud+Lv8S42f
         MzpW+YyCG85W5PcWkXanyy21cYxkiOKcnjb4VdnQNI/+dV7msMVYoiGJDOAejr6Xn53a
         27buGw/73QYuTNM5ppXS342mT2Uz82cmJYbu4iduWkFZNyhShcYZtXrFNddYXJD0dtuM
         2tUBwc8H3R1LXbLicG6DOY4f6M+itm995zeWwakt6PtrOCrqud5raGYhfGaCxA6EKCgm
         JZeA==
X-Forwarded-Encrypted: i=1; AJvYcCUPHG3cWrBJhAlXLGFX9mA/Q/rG6hf4XMypKVAMn8kQg6EpbztK75MFjzDM94elXvrBdelnPwZVbsemEyM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwsuE63kuJ4FdiG1nKFlKN2YhXU7EMFksa9IQYm7elDnusBAb/
	bDRQy5Zt3Mwga3wVN6hOG9zFbJTTyivZigpAeUju1nlQfEKQK4wgjXmvQTdrA4O3CA==
X-Gm-Gg: ASbGnctRP1507ajHjUBcguP5LpyC5fW3jzet3KyZm6My+Hk6ufKlJF1ncpgeBkhlFd3
	H8/Kob0QZ6vRfOmkxXTtHawYit2j+rJIOAAmWuh/bJEhrIVLLXhr0wvrWdHnZowSxx3gDDqNs6e
	sVffdbzscuOGE3FKm5LWYGnMQJReMInbfe9sCNC7HCEmLXp95a+hAmE3s7rIZxs8jkSNFH7iF3U
	sSA4ZXQ4bIscr7o1MSmjBt2bQvUeUXcFEjss0wd11meeoO+XNehRMhZjZJ6sdGi32lzKlGGBNsF
	sAwLZ9X6EE+5LGpAu9V+MWw6SJ1JLWdhq6N7KShhQCSBExkECv0nThQ+p9qrVo6W7P+10kaHeqJ
	f7gFAGo6H2PBaheGCGqgcPdt5+/EM1QoR/3W/6lx49mJogYnFSD096rDqsh7h0hPHTZ8Qeg==
X-Google-Smtp-Source: AGHT+IG7Q075/69lFtwq0hoEJKVoCNlBE4hU6CDHrnoiEI5/aWCVfJbO7FkOPky6dULeT2aGJwID/Q==
X-Received: by 2002:a05:600c:8b6a:b0:45f:5b02:b0cb with SMTP id 5b1f17b1804b1-45f5b02b390mr996015e9.0.1758023884645;
        Tue, 16 Sep 2025 04:58:04 -0700 (PDT)
Received: from google.com (157.24.148.146.bc.googleusercontent.com. [146.148.24.157])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7e645d1fcsm15966584f8f.48.2025.09.16.04.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 04:58:03 -0700 (PDT)
Date: Tue, 16 Sep 2025 11:58:00 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, maz@kernel.org, oliver.upton@linux.dev,
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, robin.murphy@arm.com,
	jean-philippe@linaro.org, qperret@google.com, tabba@google.com,
	jgg@ziepe.ca, mark.rutland@arm.com
Subject: Re: [PATCH v4 01/28] KVM: arm64: Add a new function to donate memory
 with prot
Message-ID: <aMlQyEdJdJ4Q9iS5@google.com>
References: <20250819215156.2494305-1-smostafa@google.com>
 <20250819215156.2494305-2-smostafa@google.com>
 <aMAvwlMQ-Jf2MWzd@willie-the-truck>
 <aMcWIDQzi5CDNC4C@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMcWIDQzi5CDNC4C@google.com>

On Sun, Sep 14, 2025 at 07:23:12PM +0000, Pranjal Shrivastava wrote:
> On Tue, Sep 09, 2025 at 02:46:42PM +0100, Will Deacon wrote:
> > On Tue, Aug 19, 2025 at 09:51:29PM +0000, Mostafa Saleh wrote:
> > > Soon, IOMMU drivers running in the hypervisor might interact with
> > > non-coherent devices, so it needs a mechanism to map memory as
> > > non cacheable.
> > > Add ___pkvm_host_donate_hyp() which accepts a new argument for prot,
> > > so the driver can add KVM_PGTABLE_PROT_NORMAL_NC.
> > > 
> > > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > > ---
> > >  arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |  1 +
> > >  arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 11 +++++++++--
> > >  2 files changed, 10 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> > > index 5f9d56754e39..52d7ee91e18c 100644
> > > --- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> > > +++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> > > @@ -36,6 +36,7 @@ int __pkvm_prot_finalize(void);
> > >  int __pkvm_host_share_hyp(u64 pfn);
> > >  int __pkvm_host_unshare_hyp(u64 pfn);
> > >  int __pkvm_host_donate_hyp(u64 pfn, u64 nr_pages);
> > > +int ___pkvm_host_donate_hyp(u64 pfn, u64 nr_pages, enum kvm_pgtable_prot prot);
> > >  int __pkvm_hyp_donate_host(u64 pfn, u64 nr_pages);
> > >  int __pkvm_host_share_ffa(u64 pfn, u64 nr_pages);
> > >  int __pkvm_host_unshare_ffa(u64 pfn, u64 nr_pages);
> > > diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > > index 8957734d6183..861e448183fd 100644
> > > --- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > > +++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > > @@ -769,13 +769,15 @@ int __pkvm_host_unshare_hyp(u64 pfn)
> > >  	return ret;
> > >  }
> > >  
> > > -int __pkvm_host_donate_hyp(u64 pfn, u64 nr_pages)
> > > +int ___pkvm_host_donate_hyp(u64 pfn, u64 nr_pages, enum kvm_pgtable_prot prot)
> > >  {
> > >  	u64 phys = hyp_pfn_to_phys(pfn);
> > >  	u64 size = PAGE_SIZE * nr_pages;
> > >  	void *virt = __hyp_va(phys);
> > >  	int ret;
> > >  
> > > +	WARN_ON(prot & KVM_PGTABLE_PROT_X);
> > 
> > Should this actually just enforce that the permissions are
> > KVM_PGTABLE_PROT_RW:
> > 
> > 	WARN_ON((prot & KVM_PGTABLE_PROT_RWX) != KVM_PGTABLE_PROT_RW);
> > 
> > ?
> > 
> > Since the motivation is about the memory type rather than the
> > permissions, it would be best to preserve the current behaviour.
> 
> +1. I believe the current `WARN_ON(prot & KVM_PGTABLE_PROT_X);` check
> would potentially allow "Read-only" or "Write-only" donations to slide
> through silently.

True, this can only be done from the hypervisor code though, I will
make the check stricter as Will suggested, and if needed we can relax
that later.

Thanks,
Mostafa

> 
> > 
> > Will
> 
> Thanks,
> Praan

