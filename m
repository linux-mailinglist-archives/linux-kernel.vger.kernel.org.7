Return-Path: <linux-kernel+bounces-600656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2FB5A862D4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 18:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3AB3441234
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 16:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC92214A93;
	Fri, 11 Apr 2025 16:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="miPD2+rw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2331E102D;
	Fri, 11 Apr 2025 16:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744387439; cv=none; b=tYYYSshGUM6BUkzJ6dHhSFRGtWSP9jFmHJx7IECy3DAWwU/y4PqvpU6Q7q8DX5Rd/LujT2xyebsoTVMuUmg0DPCYuC3r0A1RmNoJ8OKxa3eiQII+sy+BG26DhEZsQgO2oDlBBlUVP64h26Hj+gY0qZOhDg7m+G7l2p/bAqzPkJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744387439; c=relaxed/simple;
	bh=KqcHpLtYGIe+KPzDUv64VC3jawenUyBCz4MhtthBEPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pQp/uEFkBIs+8NRQRJDa+5T4ZLAMLxpSQsTxf5fbeYdkPZgKeX1yQkNzC5Dq1HvQSQHrXB665i7VLMe6kHLoWHqebGCG/sdVXAc+rcgaQ6wHMX9ZkPde8dH+fco8Xfxq7QY2jXasTn/Mu1u1RJ7l9pfCWAjfqLtE7qnGoT1eneA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=miPD2+rw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E90A6C4CEE2;
	Fri, 11 Apr 2025 16:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744387438;
	bh=KqcHpLtYGIe+KPzDUv64VC3jawenUyBCz4MhtthBEPE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=miPD2+rwV0dQP4B/8sjkwn3hZFOS3HTZ8dEsYwuZ/mWBNUem/giiiMYNTXP63So1u
	 NSQhWAzhggX+gnY7U1IUxICmCzVodgwS1gbql/iAE4kH74RUH0MCdFjC315PsFgWmR
	 NxMNE28xpu4Jx9tXRThlZCPxfZOurye0IEBreA6mH/NTQ6VSlQHqiKLcCnT5vUsPKj
	 tPZpUQ454OzPxPoM6TPun1aHAcgdm90fN+2HrbPrcdwXT3yoXVezrY8MjEw+pxBKKq
	 6dSehQI1sziaJUEwrfw2Wh0RwYf7k80VNscV+YTK82tUDxZ61pghqppOx4ozHdUpc9
	 2gC9jvXD66mew==
Date: Fri, 11 Apr 2025 17:03:53 +0100
From: Will Deacon <will@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, robin.murphy@arm.com,
	nicolinc@nvidia.com, jsnitsel@redhat.com, praan@google.com,
	kevin.tian@intel.com, ddutile@redhat.com
Subject: Re: [PATCH] iommu/arm-smmu-v3: Add missing S2FWB feature detection
Message-ID: <20250411160352.GB5675@willie-the-truck>
References: <20250408033351.1012411-1-aneesh.kumar@kernel.org>
 <20250408120919.GB1727154@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408120919.GB1727154@ziepe.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Apr 08, 2025 at 09:09:19AM -0300, Jason Gunthorpe wrote:
> On Tue, Apr 08, 2025 at 09:03:51AM +0530, Aneesh Kumar K.V (Arm) wrote:
> > Commit 67e4fe398513 ("iommu/arm-smmu-v3: Use S2FWB for NESTED domains")
> > introduced S2FWB usage but omitted the corresponding feature detection.
> > As a result, vIOMMU allocation fails on FVP in arm_vsmmu_alloc(), due to
> > the following check:
> > 
> > 	if (!arm_smmu_master_canwbs(master) &&
> > 	    !(smmu->features & ARM_SMMU_FEAT_S2FWB))
> > 		return ERR_PTR(-EOPNOTSUPP);
> > 
> > This patch adds the missing detection logic to prevent allocation
> > failure when S2FWB is supported.
> > 
> > Fixes: 67e4fe398513 ("iommu/arm-smmu-v3: Use S2FWB for NESTED domains")
> > Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> > ---
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 ++
> >  1 file changed, 2 insertions(+)
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> This should go to rc

Yup. I'll pick this up next week along with any other SMMU fixes kicking
around.

Cheers,

Will

