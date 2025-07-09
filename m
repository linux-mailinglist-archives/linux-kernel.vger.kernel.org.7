Return-Path: <linux-kernel+bounces-723422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60359AFE67E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 12:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0CC2174DE0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 10:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AAA291C38;
	Wed,  9 Jul 2025 10:51:53 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF22292917
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 10:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752058313; cv=none; b=eoC3gBoBxs7J2vzfY1YOIPBvIQ6BUfHxy9IdtjC48es8j3UeDYc+XDvo19+hEqm5soYg7ySIaSIO3iJ/m7XHQutA2oOo4SE2jsDMc+vQ6wi2K2z5O5VsIwVpHSPEP8o4eqktB/1PeojZShcNOgJ5dLU/5FchBOeBncxx4Mautz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752058313; c=relaxed/simple;
	bh=6tHK7VmG/sTT6rc1fJyf/ntd/H5qItiTB1SYdutKi8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SZQ2uejv20iA9gW8FfCmpo6BobFRARe6a/cWL7QAeVKDGgW95CQChM/gNKphTR34WtFnFb7heAkYjyjPUhaVo8kJZu+h+q2fbJ//XeR11AxXH8jBRx3Uke/jejidJ8srxhE6xmRNwyvUwZJjhdEN27yjPb55HYgl2YBqP9pPF94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1FAFE1515
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 03:51:39 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7C37D3F738
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 03:51:50 -0700 (PDT)
Date: Wed, 9 Jul 2025 11:51:47 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Daniel Mentz <danielmentz@google.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH] iommu/io-pgtable-arm: Remove unused macro iopte_prot
Message-ID: <aG5JwzypmNwh78oX@e110455-lin.cambridge.arm.com>
References: <20250708211705.1567787-1-danielmentz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250708211705.1567787-1-danielmentz@google.com>

On Tue, Jul 08, 2025 at 09:17:05PM +0000, Daniel Mentz wrote:
> Commit 33729a5fc0ca ("iommu/io-pgtable-arm: Remove split on unmap
> behavior") removed the last user of the macro iopte_prot. Remove the
> macro definition of iopte_prot as well as three other related
> definitions.
> 
> Fixes: 33729a5fc0ca ("iommu/io-pgtable-arm: Remove split on unmap behavior")
> Signed-off-by: Daniel Mentz <danielmentz@google.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  drivers/iommu/io-pgtable-arm.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index 96425e92f313..7e8e2216c294 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -85,11 +85,6 @@
>  #define ARM_LPAE_PTE_NS			(((arm_lpae_iopte)1) << 5)
>  #define ARM_LPAE_PTE_VALID		(((arm_lpae_iopte)1) << 0)
>  
> -#define ARM_LPAE_PTE_ATTR_LO_MASK	(((arm_lpae_iopte)0x3ff) << 2)
> -/* Ignore the contiguous bit for block splitting */
> -#define ARM_LPAE_PTE_ATTR_HI_MASK	(ARM_LPAE_PTE_XN | ARM_LPAE_PTE_DBM)
> -#define ARM_LPAE_PTE_ATTR_MASK		(ARM_LPAE_PTE_ATTR_LO_MASK |	\
> -					 ARM_LPAE_PTE_ATTR_HI_MASK)
>  /* Software bit for solving coherency races */
>  #define ARM_LPAE_PTE_SW_SYNC		(((arm_lpae_iopte)1) << 55)
>  
> @@ -155,8 +150,6 @@
>  #define iopte_type(pte)					\
>  	(((pte) >> ARM_LPAE_PTE_TYPE_SHIFT) & ARM_LPAE_PTE_TYPE_MASK)
>  
> -#define iopte_prot(pte)	((pte) & ARM_LPAE_PTE_ATTR_MASK)
> -
>  #define iopte_writeable_dirty(pte)				\
>  	(((pte) & ARM_LPAE_PTE_AP_WR_CLEAN_MASK) == ARM_LPAE_PTE_DBM)
>  
> -- 
> 2.50.0.727.gbf7dc18ff4-goog
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯

