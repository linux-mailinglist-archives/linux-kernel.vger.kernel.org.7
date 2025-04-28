Return-Path: <linux-kernel+bounces-622959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C7CA9EEF2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Apr 2025 13:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A53595A2579
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Apr 2025 11:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3D1265604;
	Mon, 28 Apr 2025 11:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="IZFzGS/d"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19AEB1367
	for <linux-kernel@vger.kernel.org>; Mon, 28 Apr 2025 11:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745839230; cv=none; b=odaUrEJhJVTgI1ohFrGgbLOlmamL/tf10OFqrowttdK1lG2TKJvszHR6+O+fmvbs05Atspvtl7nSN0pCc1S7TX0+fUQpcNZqmCaTmEOMLzYw80i09NlgpUj+kOINjzFGDA9o9eX0psLBrd22jyuLRTspTir2yW+sLXKRWZF1xTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745839230; c=relaxed/simple;
	bh=HVqnScGTXGgERyMunahXa/BwgWxQI2co+xWQMd1xiME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sST+ls2PVK42VXCdcHvY/4UD+3zrM5XqGt9ZvfoHk097WU0nR8RrqNhT2ZgSJm46EG7Jfo+JPRrKNUBuhk2DTbpORIvVpe1FPylxV4cB65KW4Kf7u8V8/PnrtsWVVRQfZ6lyCAIVVfu6/HNz20NSQ7gldBTMG4aM6i0JyT8TGvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=IZFzGS/d; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id DCA8149621;
	Mon, 28 Apr 2025 13:20:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1745839228;
	bh=HVqnScGTXGgERyMunahXa/BwgWxQI2co+xWQMd1xiME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IZFzGS/d7QuFeo7nFTZ6kE2Fx3acNo1TRL4gG1x05K5/kEXI9wNVf8Jfeqdze+ddb
	 oPY+FrIMgxwVwoBM9AUzyenxbvQLx93o0kS3F+gCbGhIJi6VEim3RjEsvzs5DdD42a
	 I/9GKgYDYySWZ9+eCOkCF2tFs2HjCCjWx+zENL0opNLe3d+2Oqwn6v5pJEoEjKLa55
	 /akAzSLdggejTH7QGQepKBBa8lkzduFt46SPHYRC95sIrGWTEYoEg3FMNF+mb1FUNW
	 aNHRqiRd+mpHUKIfw7J2Lbk47NDyv2ffV7v+Xk8vx9hAbAITG2X+K9LLc/aiq0BVo0
	 NZI8OSMOoQ3uA==
Date: Mon, 28 Apr 2025 13:20:26 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Will Deacon <will@kernel.org>, Magnus Damm <damm+renesas@opensource.se>,
	Arnd Bergmann <arnd@arndb.de>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: ipmmu-vmsa: avoid Wformat-security warning
Message-ID: <aA9keotHp257k1cS@8bytes.org>
References: <20250423164006.2661372-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423164006.2661372-1-arnd@kernel.org>

On Wed, Apr 23, 2025 at 06:40:02PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> iommu_device_sysfs_add() requires a constant format string, otherwise
> a W=1 build produces a warning:
> 
> drivers/iommu/ipmmu-vmsa.c:1093:62: error: format string is not a string literal (potentially insecure) [-Werror,-Wformat-security]
>  1093 |         ret = iommu_device_sysfs_add(&mmu->iommu, &pdev->dev, NULL, dev_name(&pdev->dev));
>       |                                                                     ^~~~~~~~~~~~~~~~~~~~
> drivers/iommu/ipmmu-vmsa.c:1093:62: note: treat the string as an argument to avoid this
>  1093 |         ret = iommu_device_sysfs_add(&mmu->iommu, &pdev->dev, NULL, dev_name(&pdev->dev));
>       |                                                                     ^
>       |                                                                     "%s",
> 
> This was an old bug but I saw it now because the code was changed as part
> of commit d9d3cede4167 ("iommu/ipmmu-vmsa: Register in a sensible order").
> 
> Fixes: 7af9a5fdb9e0 ("iommu/ipmmu-vmsa: Use iommu_device_sysfs_add()/remove()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/iommu/ipmmu-vmsa.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied, thanks.

