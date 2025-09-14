Return-Path: <linux-kernel+bounces-815826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3214CB56B86
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 21:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2BCE3B90CB
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 19:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9142D191C;
	Sun, 14 Sep 2025 19:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yRfzZGdQ"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFB0288C35
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 19:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757877803; cv=none; b=W40Mz/BGymVzHtt5soH2MHXmm36HBRI8XT9mu7THBflGIjuWctbpLXnupuvnNwUYkcWNWs1+SD4xm9t6bkRc3Xx07+ZoaUBBCxehjMMYMJ0hbSxVLRxcJ3R6pLonCBEj+p5MAr0FABzLAbSiOrZ1oeYd9x9nXfnfwl3V5UYzi4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757877803; c=relaxed/simple;
	bh=uX0wZKJmEpYuqOqFw3mmAD3zJbyD9U44trnTAWBGHIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hP5izCxOTUdn1KlAgNnELLlsEHT9iZph3T7b3mCUhVCjNtt4tvQ0RFS+WubhtRCTzaEvkJtj7HHmbznfgy4JpaQknyHvvJo00+v9AFujB6SCMWiBSPckDi7D17KXsWvxKfHuxf2z/0u7OpTcooZQUAqr5mASa+CdTizCtbIA7iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yRfzZGdQ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-24cca557085so213495ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 12:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757877801; x=1758482601; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TG+gYRralj304lv9jlQQvH2rsqe/nskBvKJU5W4aZb0=;
        b=yRfzZGdQAclHqi/yz6LUekFh3PTIvSSkx90pCmM+T1FYzD2Xzw2B9C8CGzBR5dqvEZ
         5UoTM7cpbULnzchvpJAHFBautQVmmXns/vc96mXQePeie1Crea84qqYuv1YW+MMIzEZw
         aMAzMpJauhpDsZ1w054qL0dtchtKJXBPEWm+YtImzMAduKYXwO+WDJscq4FNPOffbARu
         EUPDJlr5TkIP32A/32fW1HaPu+90kd8LcMEVaIJLzeiSBkPwW+KZHnrVP8ADZCBok5du
         lMw3ECxRI/7ahWS7DvDO0jntZcEp2j8kWgT7nkjujG6qJkAJvY3M2Pi2Do8HCY328X6F
         74Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757877801; x=1758482601;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TG+gYRralj304lv9jlQQvH2rsqe/nskBvKJU5W4aZb0=;
        b=n+xcO7AUvyb8VArSAusUy83rBGBLh+j0jdvP2ta+mynrFgn2+mIqxzrhuOoFSPRB5U
         a0LmqcYD+LEm7phIo2k/bEPb2hOxsa88FET91cli+7GYX6c8WzaPEpAOPmKpqsAFa8iK
         4aF3edG94e1ncGm0eBFaR/cHbJQ9hZP+6lmScp4jo4POIn7J8IkN9Ln8nM0WwSZYvqoU
         Ship5CE3324D1OFSrjm1f/ZFeyJLLBGOLrl2YzDs6rK3yroGH3f6rtd+efHCveHpfTPp
         WQh7X2eAgZ+aUMGs74n57NvreeW3yYg4JQ6lDU/Ycyc+5AVQGWHhBjtUV8aecPR0NeGj
         2Uig==
X-Forwarded-Encrypted: i=1; AJvYcCWNpJJMv0cuSH2jpoTEyarM/dXVsKbu3VVqVU/6WRxlheA2SgHO80EBjHCTqocumHzwuex58LocgVXs9wM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY2kvpv12n0ya3z/x1VT+7VSZGVqiqCD7T5jDmIZrr/0D+xT35
	o2AbmQp1gUADtw01ygkDCYbIecWxKzEGVIJcQdOZQVaTabyt9nfPgMaYtMb+HM1cqA==
X-Gm-Gg: ASbGnctvOorlLjLc/ijzeFo4S9ZtNcY+N+M0W7yj+D1K284TS8BeHcxNmE0bnRFnSf+
	iop/dNcARylh0Shkxp9CrSSARs3WfqwdIbA+W/Lov90QwpViO7xGCkgbvL7YiIrSA/Mmm5RIn36
	JrrJki2g/PWHfCqclTzJcXlyQESssI2tvHV00YQDEISmXaOR/vSEO4cFdnuXKSebkIVXaS14qES
	mvbW5BncjNZy7jigEG60qJrb4NjTctBzO/hQQzfMWAklxzkHpqdDWdQPu8w8N3hS8RRXYH9cImi
	HCk+L6UBEupwFdP2Mp5RzVetqgCODEoONeLEh0Y5D9a8WH0cmippC4Nsw/v28uzXeYGUdivK3qE
	F7nUu9BdbFje6BcVB5pfbQV3NO9KdeomD52Z2TMk79iq5vlFi6bqXubrbQqekhRSjOJmVSKkzOg
	==
X-Google-Smtp-Source: AGHT+IHeCAQpludM0vTJDLMiqTdpngcD9vok0tgM2qTCvopIbkrrbFlepcXGw62j8sLSWvlQCNe2WQ==
X-Received: by 2002:a17:903:183:b0:246:a8ac:1a36 with SMTP id d9443c01a7336-260e7c51cb0mr3888035ad.2.1757877800544;
        Sun, 14 Sep 2025 12:23:20 -0700 (PDT)
Received: from google.com (23.178.142.34.bc.googleusercontent.com. [34.142.178.23])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32e2b9125a8sm1504984a91.1.2025.09.14.12.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 12:23:19 -0700 (PDT)
Date: Sun, 14 Sep 2025 19:23:12 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Will Deacon <will@kernel.org>
Cc: Mostafa Saleh <smostafa@google.com>, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, maz@kernel.org, oliver.upton@linux.dev,
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, robin.murphy@arm.com,
	jean-philippe@linaro.org, qperret@google.com, tabba@google.com,
	jgg@ziepe.ca, mark.rutland@arm.com
Subject: Re: [PATCH v4 01/28] KVM: arm64: Add a new function to donate memory
 with prot
Message-ID: <aMcWIDQzi5CDNC4C@google.com>
References: <20250819215156.2494305-1-smostafa@google.com>
 <20250819215156.2494305-2-smostafa@google.com>
 <aMAvwlMQ-Jf2MWzd@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMAvwlMQ-Jf2MWzd@willie-the-truck>

On Tue, Sep 09, 2025 at 02:46:42PM +0100, Will Deacon wrote:
> On Tue, Aug 19, 2025 at 09:51:29PM +0000, Mostafa Saleh wrote:
> > Soon, IOMMU drivers running in the hypervisor might interact with
> > non-coherent devices, so it needs a mechanism to map memory as
> > non cacheable.
> > Add ___pkvm_host_donate_hyp() which accepts a new argument for prot,
> > so the driver can add KVM_PGTABLE_PROT_NORMAL_NC.
> > 
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > ---
> >  arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |  1 +
> >  arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 11 +++++++++--
> >  2 files changed, 10 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> > index 5f9d56754e39..52d7ee91e18c 100644
> > --- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> > +++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> > @@ -36,6 +36,7 @@ int __pkvm_prot_finalize(void);
> >  int __pkvm_host_share_hyp(u64 pfn);
> >  int __pkvm_host_unshare_hyp(u64 pfn);
> >  int __pkvm_host_donate_hyp(u64 pfn, u64 nr_pages);
> > +int ___pkvm_host_donate_hyp(u64 pfn, u64 nr_pages, enum kvm_pgtable_prot prot);
> >  int __pkvm_hyp_donate_host(u64 pfn, u64 nr_pages);
> >  int __pkvm_host_share_ffa(u64 pfn, u64 nr_pages);
> >  int __pkvm_host_unshare_ffa(u64 pfn, u64 nr_pages);
> > diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > index 8957734d6183..861e448183fd 100644
> > --- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > +++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > @@ -769,13 +769,15 @@ int __pkvm_host_unshare_hyp(u64 pfn)
> >  	return ret;
> >  }
> >  
> > -int __pkvm_host_donate_hyp(u64 pfn, u64 nr_pages)
> > +int ___pkvm_host_donate_hyp(u64 pfn, u64 nr_pages, enum kvm_pgtable_prot prot)
> >  {
> >  	u64 phys = hyp_pfn_to_phys(pfn);
> >  	u64 size = PAGE_SIZE * nr_pages;
> >  	void *virt = __hyp_va(phys);
> >  	int ret;
> >  
> > +	WARN_ON(prot & KVM_PGTABLE_PROT_X);
> 
> Should this actually just enforce that the permissions are
> KVM_PGTABLE_PROT_RW:
> 
> 	WARN_ON((prot & KVM_PGTABLE_PROT_RWX) != KVM_PGTABLE_PROT_RW);
> 
> ?
> 
> Since the motivation is about the memory type rather than the
> permissions, it would be best to preserve the current behaviour.

+1. I believe the current `WARN_ON(prot & KVM_PGTABLE_PROT_X);` check
would potentially allow "Read-only" or "Write-only" donations to slide
through silently.

> 
> Will

Thanks,
Praan

