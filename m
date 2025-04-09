Return-Path: <linux-kernel+bounces-596384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6799A82B25
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Apr 2025 17:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CFE71B61407
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Apr 2025 15:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C112698B3;
	Wed,  9 Apr 2025 15:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="pZTLeuZ1"
Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563B82690D1
	for <linux-kernel@vger.kernel.org>; Wed,  9 Apr 2025 15:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744213479; cv=none; b=YWTX2hNftvlMzrR95VFhVRDLMiPBHp2YPnFQiMQxPnTrvEsZ+bUTrJtoRXpZ1bd0zjrtzueb+5JlqpPnuyjJD5k1F1x7UM1V06UN/PCgResxhpCfAZhNwXMfY1xHbXIoDNnR4dHKaV435ndric58a3uK7ZTAnvV/Tgv/JTaEtKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744213479; c=relaxed/simple;
	bh=qYREGvtJjd5TJ9Nfnq3n+/uQZIwjHAzTbMhhJZ8bxtk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dEOiwelavRRrxVnxqDvILKzypnyAo5T2XC42SZPDVSJMHF3p97HSIzASj0ZZqa9xUw9CgwyWfo9lbBweRNilxnWy1lhHT2IyixKDAAImDxxyK65sLrB08VW33F9RnkEuK4hOi5eOCzuAIer6rwd/kCQMXKVuskx4ZupdZiEPBq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=pZTLeuZ1; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 95F4C22544D;
	Wed,  9 Apr 2025 17:44:31 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1744213471; bh=tUXY0pcf31Nt1pAHcBHzpdWKoN0ie9ydJgZq/X/mo6Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pZTLeuZ1Zc9LZncPbifJhBPUc2B4DnP+y86jbDboDGfPhXnBJfi7izJ0WsgirQIiE
	 gjqqYDGD+sKcS+RMGBXP1UaueHZ3DcllN+nc464LJjyes9p5ebaKgodRnWQ5amWMPh
	 NRggdCvzAMKxosBukp5+BQyOnzkFqqppOR8RNkEkZxgUKiKtona16jDJ3+Oc7GxlgV
	 MJqjejVouh+ndDhxNZlLhlFUxgsqYV8pmKcg/ttugEyzelE3mqViSmr34YUlTC92hq
	 HmRK7nekHeKlSpR1ePVBfryeRE1dXSlKKuqFv5ACPq1dP0+W+dAjJnOHghjb7H3q9Q
	 aGVqdAOSEHH5w==
Date: Wed, 9 Apr 2025 17:44:30 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: iommu@lists.linux.dev
Cc: Petr Tesarik <ptesarik@suse.com>, David Woodhouse <dwmw2@infradead.org>,
 Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will
 Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Tom Murphy
 <murphyt7@tcd.ie>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/vt-d: Remove an unnecessary call set_dma_ops()
Message-ID: <20250409174430.00ff4a09@meshulam.tesarici.cz>
In-Reply-To: <20250403165605.278541-1-ptesarik@suse.com>
References: <20250403165605.278541-1-ptesarik@suse.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  3 Apr 2025 18:56:05 +0200
Petr Tesarik <ptesarik@suse.com> wrote:

> Do not touch per-device DMA ops when the driver has been converted to use
> the dma-iommu API.
> 
> Fixes: c588072bba6b ("iommu/vt-d: Convert intel iommu driver to the iommu ops")
> Signed-off-by: Petr Tesarik <ptesarik@suse.com>

Does anyone agree? Or see any issues?

Petr T

> ---
>  drivers/iommu/intel/iommu.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index bf1f0c814348..b7e500451d4f 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -3789,7 +3789,6 @@ static void intel_iommu_release_device(struct device *dev)
>  	intel_pasid_free_table(dev);
>  	intel_iommu_debugfs_remove_dev(info);
>  	kfree(info);
> -	set_dma_ops(dev, NULL);
>  }
>  
>  static void intel_iommu_get_resv_regions(struct device *device,


