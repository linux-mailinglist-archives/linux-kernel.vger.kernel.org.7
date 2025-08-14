Return-Path: <linux-kernel+bounces-767926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F2FB25AA1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 06:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BCD19A191A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 04:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94EE021A425;
	Thu, 14 Aug 2025 04:58:58 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412591FDE19
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 04:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755147538; cv=none; b=N8MkDn9DuX7xHw7nrQKLH8q04WVffncH5RVysPaKm4h+sTzZOh/1uIiQ9EKwX5HfSntAiaEgV/qvNgbKT5wCUHsvsbkR8os75cmVwn62O0OpG5fnwsMms1/7Y5Jml8jVDhkAWpJmyg7lF4EkyDX1OyV358KVwTh2Vsswam3nfMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755147538; c=relaxed/simple;
	bh=MTQU2eXAIATJzrYJqz53j3kQwUq/5ZcFFz5BoC//o50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AfcxXRqkk3idGOuTLIvGn/gYHP1mdFfFT5PQ+JNoPsdCeN3SuOZorfQ8Iv4n8Iv7Y+7wW316k5Nk/rWShd+7SL4+kugjJaDlT70FHXJMVRwdeoi36aVvLwPP/H80ikc4mHIhJ8NVXp0W3F7WLR7sg6zS5/8uxF+VNbjGR8BJME0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 206DA1691;
	Wed, 13 Aug 2025 21:58:47 -0700 (PDT)
Received: from [10.163.65.190] (unknown [10.163.65.190])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A7F0D3F63F;
	Wed, 13 Aug 2025 21:58:50 -0700 (PDT)
Message-ID: <8683495e-da79-4746-b6da-52164cdc031d@arm.com>
Date: Thu, 14 Aug 2025 10:28:47 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] KVM: arm64: ptdump: Don't test PTE_VALID alongside
 other attributes
To: Wei-Lin Chang <r09922117@csie.ntu.edu.tw>,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 linux-kernel@vger.kernel.org
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
 Joey Gouly <joey.gouly@arm.com>, Sebastian Ene <sebastianene@google.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu
 <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>
References: <20250809135356.1003520-1-r09922117@csie.ntu.edu.tw>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20250809135356.1003520-1-r09922117@csie.ntu.edu.tw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 09/08/25 7:23 PM, Wei-Lin Chang wrote:
> The attribute masks and test values in the ptdump code are meant for
> individual attributes, however for stage-2 ptdump we included PTE_VALID
> while testing for R, W, X, and AF. This led to some confusion and the
> flipped output for the executable attribute.
> 
> Remove PTE_VALID from all attribute masks and values so that each test
> matches only the relevant bits.
> 
> Additionally, the executable attribute printing is updated to align with
> stage-1 ptdump, printing "NX" for non-executable regions and "x " for
> executable ones.
> 
> Suggested-by: Anshuman Khandual <anshuman.khandual@arm.com>
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Suggested-by: Sebastian Ene <sebastianene@google.com>
> Signed-off-by: Wei-Lin Chang <r09922117@csie.ntu.edu.tw>
> ---
> Tested on QEMU.
> 
> Changes in v2, thanks to those listed in the Suggested-by tags:
>   - remove PTE_VALID from .mask and .val
>   - make executable attribute output format identical to stage-1 ptdump
>   - Link to v1: https://lore.kernel.org/kvmarm/20250802104021.3076621-1-r09922117@csie.ntu.edu.tw/
> ---
>  arch/arm64/kvm/ptdump.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm64/kvm/ptdump.c b/arch/arm64/kvm/ptdump.c
> index 098416d7e5c25..dc5acfb00af91 100644
> --- a/arch/arm64/kvm/ptdump.c
> +++ b/arch/arm64/kvm/ptdump.c
> @@ -32,23 +32,23 @@ static const struct ptdump_prot_bits stage2_pte_bits[] = {
>  		.set	= " ",
>  		.clear	= "F",
>  	}, {
> -		.mask	= KVM_PTE_LEAF_ATTR_LO_S2_S2AP_R | PTE_VALID,
> -		.val	= KVM_PTE_LEAF_ATTR_LO_S2_S2AP_R | PTE_VALID,
> +		.mask	= KVM_PTE_LEAF_ATTR_LO_S2_S2AP_R,
> +		.val	= KVM_PTE_LEAF_ATTR_LO_S2_S2AP_R,
>  		.set	= "R",
>  		.clear	= " ",
>  	}, {
> -		.mask	= KVM_PTE_LEAF_ATTR_LO_S2_S2AP_W | PTE_VALID,
> -		.val	= KVM_PTE_LEAF_ATTR_LO_S2_S2AP_W | PTE_VALID,
> +		.mask	= KVM_PTE_LEAF_ATTR_LO_S2_S2AP_W,
> +		.val	= KVM_PTE_LEAF_ATTR_LO_S2_S2AP_W,
>  		.set	= "W",
>  		.clear	= " ",
>  	}, {
> -		.mask	= KVM_PTE_LEAF_ATTR_HI_S2_XN | PTE_VALID,
> -		.val	= PTE_VALID,
> -		.set	= " ",
> -		.clear	= "X",
> +		.mask	= KVM_PTE_LEAF_ATTR_HI_S2_XN,
> +		.val	= KVM_PTE_LEAF_ATTR_HI_S2_XN,
> +		.set	= "NX",
> +		.clear	= "x ",
>  	}, {
> -		.mask	= KVM_PTE_LEAF_ATTR_LO_S2_AF | PTE_VALID,
> -		.val	= KVM_PTE_LEAF_ATTR_LO_S2_AF | PTE_VALID,
> +		.mask	= KVM_PTE_LEAF_ATTR_LO_S2_AF,
> +		.val	= KVM_PTE_LEAF_ATTR_LO_S2_AF,
>  		.set	= "AF",
>  		.clear	= "  ",
>  	}, {

LGTM and consistent with Stage-1.

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

