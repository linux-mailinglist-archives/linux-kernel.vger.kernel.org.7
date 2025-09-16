Return-Path: <linux-kernel+bounces-819020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4B2B59A2F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B121D4A309D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 14:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6231F03D8;
	Tue, 16 Sep 2025 14:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yw7Oa99U"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDD217B505
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 14:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758032693; cv=none; b=aSkNBqN3cThO1+QiEp/UkOQ4WY524/fUZPSwxXbQ7AphctRT8pkG+9jj3XMgk6M9bo4L7QNH0yBJlcsvW+vWO+UuXWhQObXD+M3Rsiy7YiiBM0tE4+pw2INjkc8bgqKCYhEszfw50ZM//iBzv80wpLGGnizRSC69vUSSMFRQIU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758032693; c=relaxed/simple;
	bh=9FKMvjaVooNs8mUaTMZuG1iwH62PNlh/Vx9vRvmfxg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V1B7vpzQ47JG7T/LeGJ6CeJVcUKr7GtRBrVI+JhRsqHZysHgTeN9ht6buZ33z1X/OxbdT3YCoz2kq7Du65CZvofPodA1kXhem304Tyu00ONnhg4MXMl7N4aG1yScGO9Q5HOkJetnBUvybJPRgq0rSUFP0iHG4K85BlkxWBOdDFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yw7Oa99U; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45f28aba94cso55045e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 07:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758032690; x=1758637490; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=phDp4VnCXN9xpbEyamDNS1NPHJ+wYuQ3EZcaTqxylTM=;
        b=Yw7Oa99Ube+kuzEYslX2+KjbWK3Kib7H2A8OSaZKRrjHYbmubmrtPQGaFBzdWZkllK
         uD4rwzn0Gu3w8MAS2hoUCLfi3Prf0avBH2HHzklEcG8imCbdsij+5eIOLf8dTgw/7Ptp
         se1hUt5cO9nQoCStTahWHt6rbqaWIDXWSdcvCLdaqMU0u0DiDcmNyouq9Ij+DopZ5/o5
         Xnr7cKRHO9Jzdci6YcRZKH9AI2T3qG9reM++NAswuJX2Bh4QAUrz2QMdzntaIHUM0hiz
         5gNURdyU6adQMKkQPlXLZT9LxOn1R25OU9uyuv5XBv0ITjXGNkx2e9r9ikA2CTMMh39G
         g6Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758032690; x=1758637490;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=phDp4VnCXN9xpbEyamDNS1NPHJ+wYuQ3EZcaTqxylTM=;
        b=SDjMAUBdLWnBDsN2ab9+Whs5Yceg1kPA7EhlaAlTUlCLqxzbJ7ntPyfTUaL24h3n/K
         B63IlAPzPelIvhQH2+DtPRfBh9eB0c02VfH9bM39UYIJ8gYDlzzycrqfSc3CEbL5QXkc
         cfVneqDMOMTRaDBHoS4GSNbHel/Ut9sp3KgSRPwf4Kpiq4D8oMnQxO0vlZ4VmJ0HHKJ2
         S4sh3o0UJ9q3y5ZCeHVIITDPXTAoN2bDADGuhg5/tQfxI4iRvvWrLmP76iBRcEvWwWCK
         er6XHJ6Qw1lSpsffdmEDca3Z/aS6PVIq8brm6SCQEdD9D4Myz3iSDIp5zNYmFU947kYd
         y3Iw==
X-Gm-Message-State: AOJu0YyiWJ5y79VMGG6wUUtUL4E8Yu2bZ6a5yPRk9JJnvCvRSiEwd2ub
	8FD8R+SGM3BnQO3K1h83nQqh9Wul0NK2lRX6xm7W/5B+5uacoOK5PU+bP7yHn1elOg==
X-Gm-Gg: ASbGncubga2T8cxCCreKlWGTWqTxltsS+r4STApEMW1jy+yRQKH0xO1jR85tZswjUB4
	1ukkG5uW0mlJOW6qh/0WX4SagOp2HZaWM7XUWSsoZaFBmUJtEl2J5SizQ9gNRcGofQHlnQtZnsz
	OtdBicwikTEVSaGLeHjiEatBAr7W9HiCfH5LBdJ8UUojbbHw7JRPTaqiX006W+xpt4lsuw8n4DV
	VnLxckxNqwxPTDu2JqBSk8laFdQR4xmGT56VLNKG+uK65c0NpbJBe+ZXpFcPECikSm1j1m419Rf
	Qqcvg5jUXeN+Zcbtfk19+/oWUi0+vbWQNG9RXyi4vR/2mPZoSmPloAfV3tENo9a8BtMIWWzF9y2
	kyL/fPdrQx5paJx108IwF2O6nTnYGlWpC2d3vm9ASz7Itu/EzjJ6LeMQpWeJuyqQkpNYz80baCO
	e3epMtPuOJMcQD47Q=
X-Google-Smtp-Source: AGHT+IGY+tRtVLT/xfCf+KRVVpAwIAtGnuReJMbcXmJZJALHm+2tVODOb2attNahOqJDhG6WrbUOoA==
X-Received: by 2002:a05:600c:3b85:b0:45c:b4fb:f0b3 with SMTP id 5b1f17b1804b1-45f3278c3admr1416035e9.3.1758032689764;
        Tue, 16 Sep 2025 07:24:49 -0700 (PDT)
Received: from google.com (157.24.148.146.bc.googleusercontent.com. [146.148.24.157])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ea4b52b7fcsm9859169f8f.33.2025.09.16.07.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 07:24:49 -0700 (PDT)
Date: Tue, 16 Sep 2025 14:24:46 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, robin.murphy@arm.com,
	jean-philippe@linaro.org, qperret@google.com, tabba@google.com,
	jgg@ziepe.ca, mark.rutland@arm.com, praan@google.com
Subject: Re: [PATCH v4 10/28] KVM: arm64: iommu: Shadow host stage-2 page
 table
Message-ID: <aMlzLsj5slPQhWEr@google.com>
References: <20250819215156.2494305-1-smostafa@google.com>
 <20250819215156.2494305-11-smostafa@google.com>
 <aMA8vz0v0Vn-02QP@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aMA8vz0v0Vn-02QP@willie-the-truck>

On Tue, Sep 09, 2025 at 03:42:07PM +0100, Will Deacon wrote:
> On Tue, Aug 19, 2025 at 09:51:38PM +0000, Mostafa Saleh wrote:
> > Create a shadow page table for the IOMMU that shadows the
> > host CPU stage-2 into the IOMMUs to establish DMA isolation.
> > 
> > An initial snapshot is created after the driver init, then
> > on every permission change a callback would be called for
> > the IOMMU driver to update the page table.
> > 
> > For some cases, an SMMUv3 may be able to share the same page
> > table used with the host CPU stage-2 directly.
> > However, this is too strict and requires changes to the core hypervisor
> > page table code, plus it would require the hypervisor to handle IOMMU
> > page faults. This can be added later as an optimization for SMMUV3.
> > 
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > ---
> >  arch/arm64/kvm/hyp/include/nvhe/iommu.h |  4 ++
> >  arch/arm64/kvm/hyp/nvhe/iommu/iommu.c   | 83 ++++++++++++++++++++++++-
> >  arch/arm64/kvm/hyp/nvhe/mem_protect.c   |  5 ++
> >  3 files changed, 90 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm64/kvm/hyp/include/nvhe/iommu.h b/arch/arm64/kvm/hyp/include/nvhe/iommu.h
> > index 1ac70cc28a9e..219363045b1c 100644
> > --- a/arch/arm64/kvm/hyp/include/nvhe/iommu.h
> > +++ b/arch/arm64/kvm/hyp/include/nvhe/iommu.h
> > @@ -3,11 +3,15 @@
> >  #define __ARM64_KVM_NVHE_IOMMU_H__
> >  
> >  #include <asm/kvm_host.h>
> > +#include <asm/kvm_pgtable.h>
> >  
> >  struct kvm_iommu_ops {
> >  	int (*init)(void);
> > +	void (*host_stage2_idmap)(phys_addr_t start, phys_addr_t end, int prot);
> >  };
> >  
> >  int kvm_iommu_init(void);
> >  
> > +void kvm_iommu_host_stage2_idmap(phys_addr_t start, phys_addr_t end,
> > +				 enum kvm_pgtable_prot prot);
> >  #endif /* __ARM64_KVM_NVHE_IOMMU_H__ */
> > diff --git a/arch/arm64/kvm/hyp/nvhe/iommu/iommu.c b/arch/arm64/kvm/hyp/nvhe/iommu/iommu.c
> > index a01c036c55be..f7d1c8feb358 100644
> > --- a/arch/arm64/kvm/hyp/nvhe/iommu/iommu.c
> > +++ b/arch/arm64/kvm/hyp/nvhe/iommu/iommu.c
> > @@ -4,15 +4,94 @@
> >   *
> >   * Copyright (C) 2022 Linaro Ltd.
> >   */
> > +#include <linux/iommu.h>
> > +
> >  #include <nvhe/iommu.h>
> > +#include <nvhe/mem_protect.h>
> > +#include <nvhe/spinlock.h>
> >  
> >  /* Only one set of ops supported */
> >  struct kvm_iommu_ops *kvm_iommu_ops;
> >  
> > +/* Protected by host_mmu.lock */
> > +static bool kvm_idmap_initialized;
> > +
> > +static inline int pkvm_to_iommu_prot(enum kvm_pgtable_prot prot)
> > +{
> > +	int iommu_prot = 0;
> > +
> > +	if (prot & KVM_PGTABLE_PROT_R)
> > +		iommu_prot |= IOMMU_READ;
> > +	if (prot & KVM_PGTABLE_PROT_W)
> > +		iommu_prot |= IOMMU_WRITE;
> > +	if (prot == PKVM_HOST_MMIO_PROT)
> > +		iommu_prot |= IOMMU_MMIO;
> 
> This looks a little odd to me.
> 
> On the CPU side, the only different between PKVM_HOST_MEM_PROT and
> PKVM_HOST_MMIO_PROT is that the former has execute permission. Both are
> mapped as cacheable at stage-2 because it's the job of the host to set
> the more restrictive memory type at stage-1.
> 
> Carrying that over to the SMMU would suggest that we don't care about
> IOMMU_MMIO at stage-2 at all, so why do we need to set it here?

Unlike the CPU, the host can set the SMMU to bypass, in that case the
hypervisor will attach its stage-2 with no stage-1 configured. So,
stage-2 must have the correct attrs for MMIO.

> 
> > +	/* We don't understand that, might be dangerous. */
> > +	WARN_ON(prot & ~PKVM_HOST_MEM_PROT);
> > +	return iommu_prot;
> > +}
> > +
> > +static int __snapshot_host_stage2(const struct kvm_pgtable_visit_ctx *ctx,
> > +				  enum kvm_pgtable_walk_flags visit)
> > +{
> > +	u64 start = ctx->addr;
> > +	kvm_pte_t pte = *ctx->ptep;
> > +	u32 level = ctx->level;
> > +	u64 end = start + kvm_granule_size(level);
> > +	int prot =  IOMMU_READ | IOMMU_WRITE;
> > +
> > +	/* Keep unmapped. */
> > +	if (pte && !kvm_pte_valid(pte))
> > +		return 0;
> > +
> > +	if (kvm_pte_valid(pte))
> > +		prot = pkvm_to_iommu_prot(kvm_pgtable_stage2_pte_prot(pte));
> > +	else if (!addr_is_memory(start))
> > +		prot |= IOMMU_MMIO;
> 
> Why do we need to map MMIO regions pro-actively here? I'd have thought
> we could just do:
> 
> 	if (!kvm_pte_valid(pte))
> 		return 0;
> 
> 	prot = pkvm_to_iommu_prot(kvm_pgtable_stage2_pte_prot(pte);
> 	kvm_iommu_ops->host_stage2_idmap(start, end, prot);
> 	return 0;
> 
> but I think that IOMMU_MMIO is throwing me again...

We have to map everything pro-actively as we don’t handle page faults
in the SMMUv3 driver.
This would be a future work where the CPU stage-2 page table is shared with
the SMMUv3.

Thanks,
Mostafa

> 
> Will

