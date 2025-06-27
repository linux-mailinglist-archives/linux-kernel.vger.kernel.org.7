Return-Path: <linux-kernel+bounces-705950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5CFAEAFDD
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 09:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2E50189D6C2
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 07:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973D221C195;
	Fri, 27 Jun 2025 07:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="os8eh9Om"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4341E9919;
	Fri, 27 Jun 2025 07:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751008337; cv=none; b=W8WMu/hElSYJpFp9704AcHC4xXy2G54eErk5cZdiYADLj+KLcip4fdVddT2rSSusij7qX0XVHfZ8njFEWVq88UIq/kBZBJyP3C6ueN8KFX9G1HgEBsBbXw0MJA5QyEfnxUnTNdM/MKpUlvfIL7S691svKRXnHsYcFFftWtOznVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751008337; c=relaxed/simple;
	bh=hViMdqb6dxMsSc22iEs4gFV/W3OyUowtbhavaS4N2C4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XsMUxTSlEfxD8lR1gfmRKmJx/pUDwPKiMgzH5yKGGBav9nAEfkcvUekz3ExdyjaP0QJPetSt+UES9L+fOCgLIdrxuNrq9OStV0Km5QtmzfP8PJNJW8zoadyvwtnMGJdSNbO0fPMWzegzRvSmyiwgnSaLcR+ZC7QcqtHRHu2ZBN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=os8eh9Om; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 382E94D686;
	Fri, 27 Jun 2025 09:12:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1751008333;
	bh=hViMdqb6dxMsSc22iEs4gFV/W3OyUowtbhavaS4N2C4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=os8eh9OmTEn/Dx1LHcwVX5y/zK9/DPU+4gdnpJKgvmO8zgLCFp6UyZQzhdVu/eTB5
	 ymyVzF6dt2XSAV1mvIVjI4FKvk41lONyZrMBQn4PxkBdn1BcFwrjk/vusMYrkdD0+t
	 b4IEj9E5srjbXb25KOIHy0R+93xNZ1Hp+3MskKXm6EyeWCW/Myweg9idpwczBK5DIU
	 5UIc1k7ayRmlhP+3k0Yp1KlD3ld/piGG2aRMG6PjylYIXcPeC6+G8+jwYAjKQOlAD/
	 U7ACVw6okT+2NBBXG0Nx+ZNTUt18dp9sVNkVpInqzvcmgrKjHyI8oS+0vwQhkOXQub
	 +76+NJjhyQ8GQ==
Date: Fri, 27 Jun 2025 09:12:12 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Simon Xue <xxm@rock-chips.com>
Cc: will@kernel.org, heiko@sntech.de, robin.murphy@arm.com,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] iommu/rockchip: prevent iommus dead loop when two
 masters share one IOMMU
Message-ID: <aF5ETB6HEGywYKS9@8bytes.org>
References: <20250623010532.584409-1-xxm@rock-chips.com>
 <20250623020018.584802-1-xxm@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623020018.584802-1-xxm@rock-chips.com>

On Mon, Jun 23, 2025 at 10:00:18AM +0800, Simon Xue wrote:
> When two masters share an IOMMU, calling ops->of_xlate during
> the second master's driver init may overwrite iommu->domain set
> by the first. This causes the check if (iommu->domain == domain)
> in rk_iommu_attach_device() to fail, resulting in the same
> iommu->node being added twice to &rk_domain->iommus, which can
> lead to an infinite loop in subsequent &rk_domain->iommus operations.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: 25c2325575cc ("iommu/rockchip: Add missing set_platform_dma_ops callback")
> Signed-off-by: Simon Xue <xxm@rock-chips.com>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> 
> v3:
>    Add missing `Cc: stable@vger.kernel.org` in commit message.
>    No functional changes.
> v2:
>    No functional changes.
> ---
>  drivers/iommu/rockchip-iommu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied for -rc, thanks.

