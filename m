Return-Path: <linux-kernel+bounces-750933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B94C4B162FE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 16:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E431718C83B8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 14:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AAF42DA779;
	Wed, 30 Jul 2025 14:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Xc39EcwP"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E36E2D97BC
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 14:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753886578; cv=none; b=CrZx0jji+EzrUW6EfhxIbe+etpp7ppIcxLuP0ByGlmfdTRvTBwN5gFIHEl+UUa4z8JrdH+yuUFdThpqz9akteq3AomuubslOvwL4AapMAbQtakYCuTUQjuWvQ2F6FOoYjX8LoyYOLi0nrw+le/kjcpiNXUwYKGFxiGtjK7QYkXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753886578; c=relaxed/simple;
	bh=gGRfP7BSpng2geWuLtovyzO2vvewCAFqLFPtlv86Vs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M91u7kGZU6xmzaAEWZdYFUnzIGTGwXOXZZhnHDHPCuXdcyWEFEbB1/c3IvRkpCWTC+8+GQIknhNnKTrh9+4BQLsfrO8N6L5WyD82035YyUMmzrnnMxghdvy5oofu2g+HwsRo50F4Xapvfnpoy13Emds4Uc14W0zPmu6ko5OLu2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Xc39EcwP; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-707453b0306so34482986d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 07:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1753886574; x=1754491374; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yE9XS5x/IPLFg7Q0+oI241GEqid5njht4Vd0VCx+/2E=;
        b=Xc39EcwPHn8Za/GGpAlReewYoKJGNax1dmkCG5QsmeO1926lN2CEisE8C08YE5Z8Mz
         T3q97Jstlsp/B8grFe8t+BYm1CvlASjFYYNBvzKC1FUAgtyerPlZLZ0VU7U7pXm++Osn
         Si2viBpUlBrETT4rLJkQ5WkZB8H2n/tG7OZbmkuAkrMx8kqN9f9Orbk/e9soYqB4ZCvd
         9oteokSIev2a3INMW/XnWQIBoBtlOLXIv17a39J1hOCp8/8p7xIUzcToGg6zFY8TGsQb
         t6yF5IU24wvjdx/4b86AxH4RTTcNJBkv+pjKHvGSYfT80kkd7/3vdSYlFFN7TlGDQ57H
         VSAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753886574; x=1754491374;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yE9XS5x/IPLFg7Q0+oI241GEqid5njht4Vd0VCx+/2E=;
        b=LXq0tF8I57El3NJ2jiDn3Ru6ux9PKeaS58ZRlPy2qBQQolPq3dot2uGzJrAP3DqiZy
         cZ7eSuubTAvKIxKYls27/R/YiRiZb1Tab1DdjjVpMbyCnuO7ql5gcfwBCURG6HkKCVL/
         54eUFpTRhrl04Y+kqJqhGQnogVQyc/EjN6YVINShS/PR15krgXmfhwbH4jadw0aS/M+x
         WaWv+tHmn0VQ8neYYo1/UA9tcGQYov9ThOssq70lN1J4Rm1P+A2g1S1i5C04RgyiLwl7
         1ZP3BEnkMPyhylWOcoke+9t3GJCS6bB9g/jvEv9IYk2pHhvy6dK+dCpsuaCzPbpauRgP
         7cIA==
X-Gm-Message-State: AOJu0Yxizgq8peHWY0bCZTcjcJ5rKXR01tbEru0L0G8YsF/UlC9AFMJ3
	OqrJIVHgw2QPz2Xnp+ndqvT1NwQio8cKE1CUU5IgI6ynPwi0jpemWA4INFh34bH4gS8=
X-Gm-Gg: ASbGncu67+QAqHieBvnW0VltwRdVTiBV3o6ozxIYCNa4FY/zinRL77o7yyOM7R3eIlc
	vE+qvvOyQDwzSvoyyrmiMZD2Epeiv/27g8NdoPxMCHtcmpUHypxIBhpnIHcGKIWQrMcYWeHXsta
	sfE+B3O4cArUE/Q+HGN0IVcNbRcbTx0Q5PRyGwd/2rEnN4LChBX2lcZ/zgrWsk+PprbED5I85Sp
	B6QJqcTwDKso/lYYNVRGN+E85QaYkqNa1dkD65gI9NyB+Rp7aSfJwc/eKiXnM9NkIJp18wrtt6+
	zkrUs/j6jCpkMxNMqbScBB95cjWeVec0uKOOqo+e5Z/s0PLiztsgaQskH/KTIDmK68FfLPUFA+h
	jy/vgSkKpgU91jsWAbjPo5ghjB7NXsswlfIQ+BH2R5agZEtQjOfg6cpDYtNCONYinTdhtvCaMPn
	iDrAA=
X-Google-Smtp-Source: AGHT+IFTshf+JMDcrv8+0/UalWTBjWGXz7BdMW99vihoM+QJWNKuspc/O9f/fXBj039JGJi+af7NVQ==
X-Received: by 2002:a05:6214:ac7:b0:707:4daf:631 with SMTP id 6a1803df08f44-7076719b73dmr50415456d6.42.1753886574527;
        Wed, 30 Jul 2025 07:42:54 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7074b52ddc7sm39845896d6.77.2025.07.30.07.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 07:42:53 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uh817-00000000RlW-0qIU;
	Wed, 30 Jul 2025 11:42:53 -0300
Date: Wed, 30 Jul 2025 11:42:53 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org, robin.murphy@arm.com,
	jean-philippe@linaro.org, qperret@google.com, tabba@google.com,
	mark.rutland@arm.com, praan@google.com
Subject: Re: [PATCH v3 29/29] iommu/arm-smmu-v3-kvm: Add IOMMU ops
Message-ID: <20250730144253.GM26511@ziepe.ca>
References: <20250728175316.3706196-1-smostafa@google.com>
 <20250728175316.3706196-30-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728175316.3706196-30-smostafa@google.com>

On Mon, Jul 28, 2025 at 05:53:16PM +0000, Mostafa Saleh wrote:
> Register the SMMUv3 through IOMMU ops, that only support identity
> domains. This allows the driver to know which device are currently used
> to properly enable/disable then.
> 
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c   | 92 ++++++++++++++++++-
>  1 file changed, 91 insertions(+), 1 deletion(-)

Can you split the new iommu subysstem driver out please? I think I
asked this before.

This series is big, reviewing a new iommu driver should be done separately.

Please review all the comments for the verisilicon driver, I think
many of the remarks apply here too:

 - Domain attachment looks questionable. Please do not have
   attach/detach language at all in the hypervisor facing API.
 - Get the ordering and APIs right so replace works. You need this to support RMRs
 - Use a blocking domain not some unclear detatch idea
 - Use a blocking domain for release
 - Use the smmu-v3 approach for the fwspec, don't store things in the drvdata.

Jason

