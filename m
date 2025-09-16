Return-Path: <linux-kernel+bounces-818719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C70CB595A3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 13:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B7822A742E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 11:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B53307AD9;
	Tue, 16 Sep 2025 11:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RTN/35BN"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41348305077
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 11:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758023826; cv=none; b=S6rijP/caYK1Qaoal5pO51mfI2ZVv9MZf3uuITYolooIaa7m+i/NhI7kq6fFTA8wvN+XusmAycXoBmgaZAR6Ew1GuxEAVKyuEkQQdBAZN5hMlB54jOBX+SEmdeAIJZkPkCQeQ92526lnYy+udbZgKOvNYOfMFUghqt/DgNiAUkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758023826; c=relaxed/simple;
	bh=DhwkCUF4dudkXP7+wY51z+786KhHrdUbmAB0Gd0fdow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gf0+FFfyNVV3MAJWEylHL5vX9/7W+oQ0/UlypkU/+rLWhxFXh9IJYbJWXSyn1LqqbVnFfnvRYINWab2Adq8xlo7NxCBbg4TT2UNRu6NJzc1ELYxO/4kphfSI6f+mwOh2x0TN0fmIqy57xca5Mz/bfo4gMrlPWXb/iMGZvmKEOlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RTN/35BN; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45f2f894632so46005e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 04:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758023822; x=1758628622; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ySSczih2oIxRE/mCuJE87rsnZpN4MGD71PRCDCNKi2s=;
        b=RTN/35BNWCzFhL5XvT06vAqs+LWvPH8J88irDti3bqW9vTzAWPJmYpunDMpmLah8dB
         WEYLdSBWyKKjrnIlGZccENp5uXJS56FgSwQuWzYuHdJN6r8Y5jM630+UAIXHAkWiCN2+
         jMhlwskb6BKElzX5k5WiDoWAjkiXVSlKPFKxlsLFoFFBLP1LVUGtHNK/CMRlK5jaw9ZJ
         IPZ8tycVOr7303n2Doi3h6vZQevuudqFb+ofQkMdwvN5F5zIUbgJ02nWxFXnTQR2hkJi
         FDUNhY55thBsvceRo3vttNUZhKxnj4Umjl4IIsokccIoG9KGjkpNFv204q2t5sJiVoAz
         9w6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758023822; x=1758628622;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ySSczih2oIxRE/mCuJE87rsnZpN4MGD71PRCDCNKi2s=;
        b=tsWEaV+kL8U/bTepLbFV0AkQDRaV8UNaLw6Eog8EWBWsM1i+D/a22Npc9rrmxL5pZ6
         NIs+Oeu08xX6lAzrxgNr3woBmYhzkzR3DQzXC2xQqW8MtnlwSRnMC62WX2bkTkquehOJ
         k2P5C23/O/Bcg7Y0WkVAzMwbkJbEOckfjck5xwWtkf4Y8AjHrZnq9yG/8POlYRb902nR
         SaP38Swx/iD4Hn3anbcAzQSr4R/zM8KAfPv0sFF+WToRPU7+5f57kNKHBnA2WiStwdli
         JpK6alZIJcwVeAPmqb/IuMsteoGarMxWvG1l44TYb3v5jg7Mb4Dc5sgKpBa9sGj0WsBV
         2tFg==
X-Gm-Message-State: AOJu0YwF26rHgrkGKb01xtP0/eUuyHMgquZxsJmembJDVeZ6nTiygp4y
	QBZVJWXa0VnuJybDyB9f3BrT15Sv0s7s/YjTxbpc18S2gWLGLddXAgk68uCdnGdZIA==
X-Gm-Gg: ASbGncsa/PQBtY8nAtuTUTZE1Fk3FVoDlHlgLPq7elFOM0ICUr+jCdtWRsrg+WQOXRk
	/AY8ongKolrWdNIjQI536gEAdGZTRB/ukJW6QFE7sCvVCP7NKZhkZi0gMgFd0duAzjOQGDV+0B0
	UTKv2kxvDWLMEQZXXQtjw6LgjW1csLjayvthpCDBFn5klpGuSNk3Fg/cSMar86aUwKzM4qc6dZg
	tEJND3cJn2jzVsjhSeLbYGj6Q0jZ5BHPxKIXHy54X1LocU+sueSnOamuN2skdEnGasD2plKXzfN
	OE8J4ZfgPmrWbnE5BzY9IScG/P9r8WaFa5lgwvAXr5kzvwaDt0dbT5ibyclIKBDu3Cs+uMZmH++
	/3fRZzuQO14A2RFRzNJrYhbvar7ZxIMnW26Ad1iCCXpEYrBxCwThzlDgoKnMFF1Z0Gwi1KQ==
X-Google-Smtp-Source: AGHT+IHVAA1mnayi87cRkdBzWdXwnComM1Vq5NxdtVwd631wdxx6byWBLXjdkxRQfsfT6Te7gJR0sQ==
X-Received: by 2002:a05:600c:4689:b0:43d:409c:6142 with SMTP id 5b1f17b1804b1-45f320079e2mr1709505e9.0.1758023822383;
        Tue, 16 Sep 2025 04:57:02 -0700 (PDT)
Received: from google.com (157.24.148.146.bc.googleusercontent.com. [146.148.24.157])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f3260a1ddsm15806845e9.5.2025.09.16.04.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 04:57:01 -0700 (PDT)
Date: Tue, 16 Sep 2025 11:56:58 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, robin.murphy@arm.com,
	jean-philippe@linaro.org, qperret@google.com, tabba@google.com,
	jgg@ziepe.ca, mark.rutland@arm.com, praan@google.com
Subject: Re: [PATCH v4 01/28] KVM: arm64: Add a new function to donate memory
 with prot
Message-ID: <aMlQivFvqf1FGK_T@google.com>
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

Yes, this series doesn't do any permisson changes, I was not sure if
that would be needed in the future or not (some RO mappings), but I will
update the check as suggested to be more strict.

Thanks,
Mostafa

> 
> Will

