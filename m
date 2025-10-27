Return-Path: <linux-kernel+bounces-871792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1729CC0E6B8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C49914F6B78
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32FB308F1B;
	Mon, 27 Oct 2025 14:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="Ye1Ruhpc"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A33307AF2
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 14:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761574266; cv=none; b=imeMhT1ZRm+p50/x6ELM38+odXzk7Zjycuyav9wYlr2cnFYM8VDljdPs9kpu39uLqPF7TN5MBBhsIjg1UzBrhCdkBxj9W9ZJJefxwf/jfuCwLzpOLBj5fPZFBWiU9vKz33SJX2b/XR4P6r16VVgU8eTkrBXHKg0b8BF6jE8NdNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761574266; c=relaxed/simple;
	bh=RI6Ga+o9ES48y+izWKuxJ72L11cXHNmbN8bD7qs3OwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JIDg0Cpko7GWfZdJ5sZ4RNyPtraM5CGIN8XNeQUFTVYuqxRxGSU+6sBqOcR8C8U4f5/OEs005o+duEjy1/mrsZUtIBlGyMGQxv//7o7eQ8jISuSzGYB3h2qCAAToayg7iQsytrXgGyJbagRsGJ2Ot7iD/v/SjIXQ4PH5+trXft0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=Ye1Ruhpc; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p549214ac.dip0.t-ipconnect.de [84.146.20.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id F0D46596EB;
	Mon, 27 Oct 2025 15:11:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1761574263;
	bh=RI6Ga+o9ES48y+izWKuxJ72L11cXHNmbN8bD7qs3OwQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ye1RuhpcBXk3yCC+nyDn6WdfQrs8tjyKQlR/h+dDdKLVDOt/cwdTD+Rna2AWh96NB
	 YsVfiQR9F7UUDIhG9eLopet+4PIz1lk+MirnuStwadZsH9145h7emDunzKmVfW7hgR
	 2uUqxJhrFtgurnY7U5jAQNYFKAVD0cEYYBBJNuRI4eMLM5xhBpHWFst9b0KUvdHpa4
	 1qi79hj2m1HUKepx9bIxaB/tf0BIoy5IvugNeBzvoKqjZ1B/mGpkdmGsUMCCs/6h4T
	 +leYUhIgVGgo3kbsMkKMm9+mMML4uIlk2qVREMSf2X9htPQymLwrRSbQiw+4c7ZP8N
	 CINFHbLIoxwSA==
Date: Mon, 27 Oct 2025 15:11:01 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Johan Hovold <johan@kernel.org>
Cc: Will Deacon <will@kernel.org>, Russell King <linux@armlinux.org.uk>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] amba/iommu: tegra: enable compile testing
Message-ID: <kbiedayyx4swmz3fh22mk4zegxoorpuz6ocuvt2ooo42vm2j5o@5rgxwy5mwmc7>
References: <20250925153120.7129-1-johan@kernel.org>
 <aP92Vs7UfkU-Xvj9@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aP92Vs7UfkU-Xvj9@hovoldconsulting.com>

On Mon, Oct 27, 2025 at 02:40:38PM +0100, Johan Hovold wrote:
> On Thu, Sep 25, 2025 at 05:31:18PM +0200, Johan Hovold wrote:
> > There seems to be nothing preventing us from enabling compile testing of
> > the Tegra AHB and IOMMU drivers so enable that to increase build
> > coverage.
> > 
> > Note that these could go in through separate trees, but compile testing
> > of the IOMMU driver does depend on the AHB driver being enabled.
> 
> > Johan Hovold (2):
> >   amba: tegra-ahb: enable compile testing
> 
> Joerg, could you consider taking also the amba patch through the iommu
> tree as a dependency with the nVidia guys' acks?

Done.

