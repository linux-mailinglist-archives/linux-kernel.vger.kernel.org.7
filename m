Return-Path: <linux-kernel+bounces-877589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E9ECCC1E834
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 07:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4B8F6347968
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 06:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087553043D1;
	Thu, 30 Oct 2025 06:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ugu+9tB/"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D51272E45
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 06:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761804579; cv=none; b=CiDNneJHgCX8q6FyHoFAbmrkkmQjVLjRN4kRwY4QvlTa3m5X4XaNf+tyuwpEyxYsgxeSnzETpUvM44GRv2Qel8g/tSKb6J2d6r3BO3m+MzlUqRBae7Zp4dsONYNTDRCPovZgocHd3tSwOC6YpYl0FhvEN9vTYteJyCCUQkizlZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761804579; c=relaxed/simple;
	bh=ye3AvcYv/DjDgZmRS42tFjm/DIKFHiOhTeTHpnujgfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rS3VzrAsGEvGeZ0GO4uqYlVxoLoZS44YFJPS6ozQtLEp6hHhc7iXTn86Ifv2uzMyk1ol24h6JPY6stHVOyAEnFoXj86EYCKJ4ir/pISFLx+LrOTdTkTQSB26OqzUq9/D0lk35xI2jkUGKs3vewWecV292hP5PnTU0Z9cNXnu1C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ugu+9tB/; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-470ff2f6e56so40175e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 23:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761804576; x=1762409376; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DLithzThx8pxlXaz1qEgue0vbFKuTuLtSl9y/H9uBGw=;
        b=ugu+9tB/2MDHuIJjM6afdtIrxMLodxxR/gN+33Va4BauIS1DgMpa2aqZmxLmMGMG4L
         tisd1dcJ1zZfbm+G/ahZlHG98asSLGoLA0+NT71fZY184uC619L06j9Wl4WGODDM7DGY
         7iecL8O0STPp9YE1wQ+NKeX8SxS2Pune3VDrnDTi3rbidb9VaGuTMci3kNK/N3Wr+WkJ
         5FgomzssGHIOqDUCWhlSop42CM670iFn45OXC3kON0OKUYd0l1HGhhcoVSq9mNj9RPrb
         9pohaDXXnKHaJBlQx7OOxy2DeIJbTvHciXzG5ITG4AI0PBdjYfceN44l6mMocDmyGGlQ
         i3qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761804576; x=1762409376;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DLithzThx8pxlXaz1qEgue0vbFKuTuLtSl9y/H9uBGw=;
        b=TNbzxEgcqONXW8mroq7fl0urQnyJ59vTn49+LwBKeI/mzpAwhkeZAWxhbz0tzhu9CJ
         y9Rs9gIC+Gv6qykIl8QZT6ceLzLnnxEoWIxJY7UqdktZLEQWTWbkaC31pQqRLa7gfHEB
         lfm8wVqfxJAsjuNfDv9F7eopvxpXbynaBVZgNviHiA4W6Xa5MqhB5SOYpRURcC61iI2/
         zZ+VXFGJKvJSHFqlQTSgCZMquLfgSWRTxCyFfMCbIiwxgkSbD0qnuVG+CIqHVxm2XRL1
         Uv7vjQmLaKWU3fB1ZM2jV44ke62xVBgIvzCteV+vv2UsIXYjCHp8uIQS10OVpcaPo5on
         gthg==
X-Forwarded-Encrypted: i=1; AJvYcCW/ChTYFB+u2ETwyriybSmxHe2qY+3MiV0IpKKOe5sUp4/JYNfZ53Prma5idjdTjJs4326Q916PwiWAPAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTGGEdZjDhRQFVO/a9K/y9no5aQr55tf7ElxXbOWUhZHZvLIX8
	1bUKiQZ8uOHmb5RfEBQ7gTOkJjhcipiOrE4VN1R3eEcF/UgMjMx+TfMrvXCecssSIQ==
X-Gm-Gg: ASbGncvtyOLl2cJ6hz6U053eO8CRjyuu+IiboNKJbKwH8zYN1Ifia8mAL5XG6lgJOL4
	IrCaAbLW5eM25LiRmgfGNPPOYoUWJ395PIsoj3Q5SNhAtxFPBMojbZ9gJ7Z2QelBZvsUsofSeiJ
	Sx5zzvsgDBAHN6EvxE/DRwBcORguWZRUgwph6C4vIOTdag+5qsRCdhkdZ21DeXS2cTODl6nFjg4
	2VHodAtCIvUzwU9CXZBvws4ZGi53OhtIKQctYQ/aao+ND/mQ9hgu2v7jWrLv3QYKpUUwckL7ED5
	ctKwW63PHhdN2aSplDxn9/Jt+pwvES7jMsYvf2fVqpaqFkxdyLHCxjbxCMiH6USMeFB8UKK99Yh
	lKYaHKqER6faqLQ/aa0a0Ts3KcpLieXBkN70VqoeJiyXRVru1KefGbFcJlf907dOFEL3E8BlUUQ
	BT4tAReOdo/UaEcej1HWsPCqDNbXTIlnibDXvJdyUfsaCRZwBJJ1kN4Y1Gyg==
X-Google-Smtp-Source: AGHT+IGeJspzX9tfUeAx5eQ3UCzknbWkBSs575JdAgz7ivV6hKq3b/O79zgLFOS7QUNGGU3V+/JhTA==
X-Received: by 2002:a05:600c:d2:b0:477:255c:bea8 with SMTP id 5b1f17b1804b1-47728a06de2mr733935e9.7.1761804575641;
        Wed, 29 Oct 2025 23:09:35 -0700 (PDT)
Received: from google.com (177.112.205.35.bc.googleusercontent.com. [35.205.112.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477289b0bb3sm20742205e9.8.2025.10.29.23.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 23:09:35 -0700 (PDT)
Date: Thu, 30 Oct 2025 06:09:31 +0000
From: Sebastian Ene <sebastianene@google.com>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org, qperret@google.com,
	keirf@google.com, linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel-team@android.com
Subject: Re: [PATCH v3] KVM: arm64: Check range args for pKVM mem transitions
Message-ID: <aQMBG0SUlNWuQQFZ@google.com>
References: <20251016164541.3771235-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016164541.3771235-1-vdonnefort@google.com>

On Thu, Oct 16, 2025 at 05:45:41PM +0100, Vincent Donnefort wrote:
> There's currently no verification for host issued ranges in most of the
> pKVM memory transitions. The end boundary might therefore be subject to
> overflow and later checks could be evaded.
> 
> Close this loophole with an additional pfn_range_is_valid() check on a
> per public function basis. Once this check has passed, it is safe to
> convert pfn and nr_pages into a phys_addr_t and a size.
> 
> host_unshare_guest transition is already protected via
> __check_host_shared_guest(), while assert_host_shared_guest() callers
> are already ignoring host checks.
> 
> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> 
> ---
> 
> v2 -> v3: 
>    * Test range against PA-range and make the func phys specific.
> 
> v1 -> v2:
>    * Also check for (nr_pages * PAGE_SIZE) overflow. (Quentin)
>    * Rename to check_range_args().
> 
> diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> index ddc8beb55eee..49db32f3ddf7 100644
> --- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> +++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> @@ -367,6 +367,19 @@ static int host_stage2_unmap_dev_all(void)
>  	return kvm_pgtable_stage2_unmap(pgt, addr, BIT(pgt->ia_bits) - addr);
>  }

Hello Vincent,

>  
> +/*
> + * Ensure the PFN range is contained within PA-range.
> + *
> + * This check is also robust to overflows and is therefore a requirement before
> + * using a pfn/nr_pages pair from an untrusted source.
> + */
> +static bool pfn_range_is_valid(u64 pfn, u64 nr_pages)
> +{
> +	u64 limit = BIT(kvm_phys_shift(&host_mmu.arch.mmu) - PAGE_SHIFT);
> +
> +	return pfn < limit && ((limit - pfn) >= nr_pages);
> +}
> +

This newly introduced function is probably fine to be called without the host lock held as long
as no one modifies the vtcr field from the host.mmu structure. While
searching I couldn't find a place where this is directly modified so
this is probably fine. 

>  struct kvm_mem_range {
>  	u64 start;
>  	u64 end;
> @@ -776,6 +789,9 @@ int __pkvm_host_donate_hyp(u64 pfn, u64 nr_pages)
>  	void *virt = __hyp_va(phys);
>  	int ret;
>  
> +	if (!pfn_range_is_valid(pfn, nr_pages))
> +		return -EINVAL;
> +
>  	host_lock_component();
>  	hyp_lock_component();
>  
> @@ -804,6 +820,9 @@ int __pkvm_hyp_donate_host(u64 pfn, u64 nr_pages)
>  	u64 virt = (u64)__hyp_va(phys);
>  	int ret;
>  
> +	if (!pfn_range_is_valid(pfn, nr_pages))
> +		return -EINVAL;
> +
>  	host_lock_component();
>  	hyp_lock_component();
>  
> @@ -887,6 +906,9 @@ int __pkvm_host_share_ffa(u64 pfn, u64 nr_pages)
>  	u64 size = PAGE_SIZE * nr_pages;
>  	int ret;
>  
> +	if (!pfn_range_is_valid(pfn, nr_pages))
> +		return -EINVAL;
> +
>  	host_lock_component();
>  	ret = __host_check_page_state_range(phys, size, PKVM_PAGE_OWNED);
>  	if (!ret)
> @@ -902,6 +924,9 @@ int __pkvm_host_unshare_ffa(u64 pfn, u64 nr_pages)
>  	u64 size = PAGE_SIZE * nr_pages;
>  	int ret;
>  
> +	if (!pfn_range_is_valid(pfn, nr_pages))
> +		return -EINVAL;
> +
>  	host_lock_component();
>  	ret = __host_check_page_state_range(phys, size, PKVM_PAGE_SHARED_OWNED);
>  	if (!ret)
> @@ -945,6 +970,9 @@ int __pkvm_host_share_guest(u64 pfn, u64 gfn, u64 nr_pages, struct pkvm_hyp_vcpu
>  	if (prot & ~KVM_PGTABLE_PROT_RWX)
>  		return -EINVAL;
>  
> +	if (!pfn_range_is_valid(pfn, nr_pages))
> +		return -EINVAL;
> +

I think we don't need it here because __pkvm_host_share_guest has the
__guest_check_transition_size verification in place which limits
nr_pages.  

>  	ret = __guest_check_transition_size(phys, ipa, nr_pages, &size);
>  	if (ret)
>  		return ret;
> 
> base-commit: 7ea30958b3054f5e488fa0b33c352723f7ab3a2a
> -- 
> 2.51.0.869.ge66316f041-goog
>

Other than that this looks good, thanks
Sebastian

