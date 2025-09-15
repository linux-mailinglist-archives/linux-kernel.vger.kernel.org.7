Return-Path: <linux-kernel+bounces-816383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C491B5731E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D60453A4E4B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 08:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DCBC2F0669;
	Mon, 15 Sep 2025 08:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w/O9YIyC"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A53A2ECD34
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 08:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757925394; cv=none; b=mf4llQd3MbFYKt1ih1OSZxLvWOezPMnCGZ7vXcw379aY1S9Dc8A1UvOnpLW2nnNmGg43SScgIYG5EU7O71wSanNYWwALYepELibRhklVD0/YFjdf1Pb3o7CDdVoGyvQ7ytIgdyoOgIS4WUpHh+D7irqKdPC4NDRnoUEcz3JxqAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757925394; c=relaxed/simple;
	bh=oTUc05uAoj8tDOxyEV34nE5zIEyVRYInAxKt2au/nUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c6E8TAtA65bqfaViGryqbc3nCw1/6V411wP7qpQEVznpX/KpGaX97GtUG0Lie0w/B1WG+NuO5qIbC1ipgPFvt9wH1VSqbNfpMSOAcn7rHcY6qNFqrfmzWpkz0QhAlV7SAFtz/MTy56sgGlCVo97rEQU1zyGjxJ+KS93FTaw3chc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w/O9YIyC; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45f30011eceso8585e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 01:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757925391; x=1758530191; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uuG6t3iAuSKi0EnadmhBvC3rHWT3Byv2xYmpCXcLPYA=;
        b=w/O9YIyCCqeV6hJT8tHBteDemBGBn/uk5yrRDmODXjY7Of1IAIOvvOpDZSAWB+UAH3
         62NBsL13BU8ofJZtaiRHVrNH7g3ke7uGiRtGbJ1+3tK82kdId1mavHgWg5eVOI12+Dly
         7FyCNrPOXb6AbrCuRpvCeRWi9mo/LYYMDY/adQrSjh27i6ctWrf2ed4y4OjVRH+RpplC
         ZMcQtqBxs6QuOqy9jwHIxT91Ohyw14xTkDuf8P8tnnFTnka+G68A6iqsdPKQR6x+HqOs
         /zTPSciIRDf0YGpwp+yxm6OaM1G6EsY6U6lzFg5JYhl98TGf7YE71QPHbAM+BDnGjCnp
         eTyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757925391; x=1758530191;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uuG6t3iAuSKi0EnadmhBvC3rHWT3Byv2xYmpCXcLPYA=;
        b=REfYb9R5X77HQGgXzNeydfm9ElozcE/xsID/DDdWoFxMcb0vYTPexnsC5l1+PnaqkL
         UJ+xUeqJRv1HPBe9eYXa1Dz37KqQ7gJoGAKtow2NmV8tiQHKF0wKlT2Y+j8hYf7+EoW8
         ZeLsL/axVFA+bLacXOCS1dJSaL5mLa9pgeKw2tJel31Q8YRlBh4SJnWfMOyX9DHj4gJ0
         THlCJhRPlgwtO7exN2eKgL4DqgOSOpETq6jTSJ9qytnPmOIxBT3BgusFW/jGX4HyS3xw
         AfcvDlyQREEybmc0WM5nijYMGgx7wcfCBPlInsyd8x+4AgRJfM+skzjKfiaLExiCzVAw
         lGKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxutLq+wTnZvm7oyP8RaaytPMVqgJrzq9PabwqPpNBRvYe/w+2mNAOh2ZGp1C6MORhHy7jENA9YRtDpQA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCyuXcIcz2zAXiu3gUa7vJsnjM/sOA/sl91DCg2dMWVcsXm5HC
	XQGUEwz+DJ6HWEL3m/3UlwmGgU0uqUyM2VzBK/Qh8OWrq9VVPhnwwpKrmJRuUyL/Hj7A/c3lzyo
	bQxFXHw==
X-Gm-Gg: ASbGncseEVEe7lAJ7gO3261kZjzNnDSQyHlffeeyNnKwhFQ66aiLkVcjIz/knXoidmr
	V/zwm6OZixjLEnOBEs/HsMcsTtqjkM8r4b0nUl6C6UcU8iL2nhkoV4AJIikYlifbOFHERn6c5R/
	+tJ2p8xR43f3cekA4Q8L+g+nPL6SR2LpCHAVH7GkZQa+PJ2PgmziOuK2fgdRmVX1FoOX0l+Kjzr
	jrk20mVRyVqwJxS7R2PtE+uD7A2O1feeghUJM3pzeHLc+xq2f8X9ZMZrqKWerpDRFZ9yDkdhjEl
	k1KhyLwnaUBQsQvVzcX9NdPgtHdtUmQ8odaffyhgjTp8Q6G0/LOQzOy6bGSNeoJ6flxTHHTHdOf
	4dsoZCsjA28W9ThhJjd09NMWlw8JyabqOQGVU12I8IO3Ltx/Z4RsiMWcHvUQtoz/BixdH1Q==
X-Google-Smtp-Source: AGHT+IGhw7FjFgBAENHxwqNBn+q5TwhC7OvA4GcuoSnWIVBJGcdJW/TW82vig7dbFCs8/b6w3sEoaQ==
X-Received: by 2002:a05:600c:a10c:b0:45f:2db6:5202 with SMTP id 5b1f17b1804b1-45f2db65722mr740645e9.3.1757925390598;
        Mon, 15 Sep 2025 01:36:30 -0700 (PDT)
Received: from google.com (157.24.148.146.bc.googleusercontent.com. [146.148.24.157])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ebc49f7ebbsm397501f8f.51.2025.09.15.01.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 01:36:30 -0700 (PDT)
Date: Mon, 15 Sep 2025 08:36:26 +0000
From: Mostafa Saleh <smostafa@google.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	aik@amd.com, lukas@wunner.de, Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 04/38] tsm: Support DMA Allocation from private
 memory
Message-ID: <aMfQCoLuVeR0nf02@google.com>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-5-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250728135216.48084-5-aneesh.kumar@kernel.org>

Hi Aneesh,

On Mon, Jul 28, 2025 at 07:21:41PM +0530, Aneesh Kumar K.V (Arm) wrote:
> Currently, we enforce the use of bounce buffers to ensure that memory
> accessed by non-secure devices is explicitly shared with the host [1].
> However, for secure devices, this approach must be avoided.


Sorry this might be a basic question, I just started looking into this.
I see that “force_dma_unencrypted” and “is_swiotlb_force_bounce” are only
used from DMA-direct, but it seems in your case it involves an IOMMU.
How does it influence bouncing in that case?

Thanks,
Mostafa

> 
> To achieve this, we introduce a device flag that controls whether a
> bounce buffer allocation is required for the device. Additionally, this flag is
> used to manage the top IPA bit assignment for setting up
> protected/unprotected IPA aliases.
> 
> [1] commit fbf979a01375 ("arm64: Enforce bounce buffers for realm DMA")
> 
> based on changes from Alexey Kardashevskiy <aik@amd.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  arch/arm64/include/asm/mem_encrypt.h |  6 +-----
>  arch/arm64/mm/mem_encrypt.c          | 10 ++++++++++
>  drivers/pci/tsm.c                    |  6 ++++++
>  include/linux/device.h               |  1 +
>  include/linux/swiotlb.h              |  4 ++++
>  5 files changed, 22 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/mem_encrypt.h b/arch/arm64/include/asm/mem_encrypt.h
> index 314b2b52025f..d77c10cd5b79 100644
> --- a/arch/arm64/include/asm/mem_encrypt.h
> +++ b/arch/arm64/include/asm/mem_encrypt.h
> @@ -15,14 +15,10 @@ int arm64_mem_crypt_ops_register(const struct arm64_mem_crypt_ops *ops);
>  
>  int set_memory_encrypted(unsigned long addr, int numpages);
>  int set_memory_decrypted(unsigned long addr, int numpages);
> +bool force_dma_unencrypted(struct device *dev);
>  
>  int realm_register_memory_enc_ops(void);
>  
> -static inline bool force_dma_unencrypted(struct device *dev)
> -{
> -	return is_realm_world();
> -}
> -
>  /*
>   * For Arm CCA guests, canonical addresses are "encrypted", so no changes
>   * required for dma_addr_encrypted().
> diff --git a/arch/arm64/mm/mem_encrypt.c b/arch/arm64/mm/mem_encrypt.c
> index ee3c0ab04384..279696a8af3f 100644
> --- a/arch/arm64/mm/mem_encrypt.c
> +++ b/arch/arm64/mm/mem_encrypt.c
> @@ -17,6 +17,7 @@
>  #include <linux/compiler.h>
>  #include <linux/err.h>
>  #include <linux/mm.h>
> +#include <linux/device.h>
>  
>  #include <asm/mem_encrypt.h>
>  
> @@ -48,3 +49,12 @@ int set_memory_decrypted(unsigned long addr, int numpages)
>  	return crypt_ops->decrypt(addr, numpages);
>  }
>  EXPORT_SYMBOL_GPL(set_memory_decrypted);
> +
> +bool force_dma_unencrypted(struct device *dev)
> +{
> +	if (dev->tdi_enabled)
> +		return false;
> +
> +	return is_realm_world();
> +}
> +EXPORT_SYMBOL_GPL(force_dma_unencrypted);
> diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
> index e4a3b5b37939..60f50d57a725 100644
> --- a/drivers/pci/tsm.c
> +++ b/drivers/pci/tsm.c
> @@ -120,6 +120,7 @@ static int pci_tsm_disconnect(struct pci_dev *pdev)
>  
>  	tsm_ops->disconnect(pdev);
>  	tsm->state = PCI_TSM_INIT;
> +	pdev->dev.tdi_enabled = false;
>  
>  	return 0;
>  }
> @@ -199,6 +200,8 @@ static int pci_tsm_accept(struct pci_dev *pdev)
>  	if (rc)
>  		return rc;
>  	tsm->state = PCI_TSM_ACCEPT;
> +	pdev->dev.tdi_enabled = true;
> +
>  	return 0;
>  }
>  
> @@ -557,6 +560,9 @@ static void __pci_tsm_init(struct pci_dev *pdev)
>  	default:
>  		break;
>  	}
> +
> +	/* FIXME!! should this be default true and switch to false for TEE capable device */
> +	pdev->dev.tdi_enabled = false;
>  }
>  
>  void pci_tsm_init(struct pci_dev *pdev)
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
>  
>  /**
> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index 3dae0f592063..61e7cff7768b 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -173,6 +173,10 @@ static inline bool is_swiotlb_force_bounce(struct device *dev)
>  {
>  	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
>  
> +	if (dev->tdi_enabled) {
> +		dev_warn_once(dev, "(TIO) Disable SWIOTLB");
> +		return false;
> +	}
>  	return mem && mem->force_bounce;
>  }
>  
> -- 
> 2.43.0
> 

