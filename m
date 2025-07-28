Return-Path: <linux-kernel+bounces-748158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A91B13D39
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 16:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 483241898FB1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 14:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8109C1DE4CD;
	Mon, 28 Jul 2025 14:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="EugBp2bK"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5273525D53B
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 14:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753713203; cv=none; b=ga5mRloP9P25ET2xqPabwxuulpcxcMltJNT3FZRSp8Yidw5ukKdzArEHOsOWCOIlEgEqsrAIhNUemDJjn+nmUgyoxxP3QmLq/K/3LZBW4wQTb0svr9BCkUksBv4wUUT7rfSqgDzeyYfz/z4vSQXQNxn8rejn1C+ifQmbPLj2kLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753713203; c=relaxed/simple;
	bh=W9cZd84LF6duF0602DMOOstiN56aNMhgPt1nX1d9jRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q+5Vn4BWd6pZ54bbk3yP78GOlKksZltl/iF6mp4Z0yHza+OYwdnslpDTA2Y/qM9H71uSmCnnksjXrWD2RhnclmpWKvZegLA6ee8x0YblvBXl5t/gIYZ+ig7BYPNOYoA6C/aKk8yWPOZoYMkHpkOi6hPSfUm/rz+UbrG8FoyEh+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=EugBp2bK; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6fad4e6d949so17456706d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 07:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1753713200; x=1754318000; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VWXJt0ksyO0+qZpgSvPEVSB9f2WnFWOci7NBGJx/i70=;
        b=EugBp2bKZzZS1D0wsHPwDGKmbt6hCvQ0lYjaRuSyVoMbQqXNRL4KPYOSVQlz+nqN9w
         EitNkB7XMRAlfRmiX0v9POBps1zB5HCoCOvywJ2qiymUQ85UQgVNJcu0fskwuKay1YzD
         uAqC4l6m6p4AiE+JvwedqRqS38Cbk1kZ2KXlsrHRIfH69xtxI7XmWDvQSK60EzCqvkpu
         piGZfwduta7VOMAFLaYYY+DeVb+I7DS1U6a7dUBXXHj9WmFg9bueAaCVAU9FJlKXzyrl
         5KvTx9/FYvCaCd3RG9A+Edx/iZqBawjHbsDJQv3xa1NkDqAscTfbYO8rMizr+3YvTijD
         1qrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753713200; x=1754318000;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VWXJt0ksyO0+qZpgSvPEVSB9f2WnFWOci7NBGJx/i70=;
        b=tb9HRiqCo3WjdLBZFCrQKEBKgOAfHrv32Ct+Bh40MNDV5zS2rivQw1FukF7qvQElDM
         oCY9QlrfXU9ylYHbi6/2n8Lj+4ZZrMH72dwsE0U5z2mQmIKKUkOgficQgHy8R47Plame
         Kp4Z3uc/F8A4SVRgJ6bTAUSgzL6oePiwcYrlwG5WODAt4guSitXlzhUu7T+TSwsPF9/r
         8WgOm/8VkmkCsvvYP+gfoZN4xLX39VxlDlb+ccoRVS0Vm/mkuXEW4bqjirf+R6DXgwYM
         oI5NPzhJnqF/hp12a+SyB12kpZFQtA2zoAhh0AOTW8JPdzVIhjSuUUuc1lXGmCUDyGk3
         k95w==
X-Forwarded-Encrypted: i=1; AJvYcCXHxUEHJp6Bu66yLGE1wSfi58Lo2bHEP9+SYn+rcIAlMvzh/oD0vBEalQ5T4ZdkKZTtWwC7MTsoXEmW5y0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1vay+nm0hSozqTAQtxbfWYX9tFfNR+OQJb/5/xYt9Doo7XoQG
	p2dnao/2pmM5OrTb4z3iOikBlfhGRel1A/LGfVEVUgXl/VqkIL2cHceoOmmPh/4QuTk=
X-Gm-Gg: ASbGncvxVm4Y3+cC1zOmSIS7lWXaO1dgbTY8hE+88V+I1KmFwcyAbeW69sJCD+Me5TB
	Tf7ort/aoCyCvB6Hnzbipe+42+Cm7MVuCrhaE99Jr8xnx/T9UgxZIokekSqLnArGAN+/bMhybuY
	nsSYSP5u+DsvnIkOcBU66kNBFReJ3SEJxJzfq8yosUY2FIdZ8NSEjLHmFTJ34A/A6YvelMALAF0
	+LRFv5gV1u6BMENljOuhp0kxYDH7ND7AgEzmjAw2MvArIA3DlLn61/cskeHwCvkCuITEQ58GQls
	mc9qDbxn2aeMVpB79EYjbpR1t0LMquZZ4wgjNG14+lSqBi53piPZSVIXOxcpzGSvtjuGJ4AH/iy
	R6+ED/YNCJX2jYL219YefcRwsYR3A9lHdtkZQ7xiO2/a5zhCNheogoaeRyeisxfKiIdmKDk7w9h
	tGXcQ=
X-Google-Smtp-Source: AGHT+IHMY4rGulXXEHfYzZtPMGVblgwyt5UUI5t558D0JMhsu4TWVCWFWjqwz9Xtl5YNFBAdYTlQIg==
X-Received: by 2002:a05:6214:224a:b0:707:9eb:d483 with SMTP id 6a1803df08f44-707205a1bcemr162291726d6.27.1753713199708;
        Mon, 28 Jul 2025 07:33:19 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7074c37e84asm9044456d6.19.2025.07.28.07.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 07:33:19 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1ugOuk-00000000Ayl-2Dx4;
	Mon, 28 Jul 2025 11:33:18 -0300
Date: Mon, 28 Jul 2025 11:33:18 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	aik@amd.com, lukas@wunner.de, Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 04/38] tsm: Support DMA Allocation from private
 memory
Message-ID: <20250728143318.GD26511@ziepe.ca>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-5-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728135216.48084-5-aneesh.kumar@kernel.org>

On Mon, Jul 28, 2025 at 07:21:41PM +0530, Aneesh Kumar K.V (Arm) wrote:
> @@ -48,3 +49,12 @@ int set_memory_decrypted(unsigned long addr, int numpages)
>  	return crypt_ops->decrypt(addr, numpages);
>  }
>  EXPORT_SYMBOL_GPL(set_memory_decrypted);
> +
> +bool force_dma_unencrypted(struct device *dev)
> +{
> +	if (dev->tdi_enabled)
> +		return false;

Is this OK? I see code like this:

static inline dma_addr_t phys_to_dma_direct(struct device *dev,
		phys_addr_t phys)
{
	if (force_dma_unencrypted(dev))
		return phys_to_dma_unencrypted(dev, phys);
	return phys_to_dma(dev, phys);

What are the ARM rules for generating dma addreses?

1) Device is T=0, memory is unencrypted, call dma_addr_unencrypted()
   and do "top bit IBA set"

2) Device is T=1, memory is encrypted, use the phys_to_dma() normally

3) Device it T=1, memory is uncrypted, use the phys_to_dma()
   normally??? Seems odd, I would have guessed the DMA address sould
   be the same as case #1?

Can you document this in a comment?

> diff --git a/include/linux/device.h b/include/linux/device.h
> index 4940db137fff..d62e0dd9d8ee 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -688,6 +688,7 @@ struct device {
>  #ifdef CONFIG_IOMMU_DMA
>  	bool			dma_iommu:1;
>  #endif
> +	bool			tdi_enabled:1;
>  };

I would give the dev->tdi_enabled a clearer name, maybe
dev->encrypted_dma_supported ?

Also need to think carefully of a bitfield is OK here, we can't
locklessly change a bitfield so need to audit that all members are set
under, probably, the device lock or some other single threaded hand
waving. It seems believable it is like that but should be checked out,
and add a lockdep if it relies on the device lock.

Jason


