Return-Path: <linux-kernel+bounces-754424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73022B19424
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 16:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EEC71892415
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 14:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C5A13D521;
	Sun,  3 Aug 2025 14:03:16 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3C02E36FD
	for <linux-kernel@vger.kernel.org>; Sun,  3 Aug 2025 14:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754229796; cv=none; b=TMt+YqaqXggClPVhbdLq3GdfqbXQPGKlXk5n64RdRygQrfOMIHO4YGetNLfv6TxgnFOjDm8DhNnrrEk8e4hqfY3CSyB7xAG3h9z6lAuWDpAIEenZS+odXoHIKwmhr1pY7kLiUpAS/2gI6/3QpSjKK28ZmIgPl9E9SLnN8kpDxD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754229796; c=relaxed/simple;
	bh=tmWp+irwjEzca2oPejN1nGBiYMdPAZU4tSUzg1WZ3DA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pqGJe0lWA7fagGQNqfsBYCCpSKgXlYKgpzBV7NbaQ9PUqzECxrjh+cEjEtcQOotmmU90/UWSaFnfdjSvt3KklR5wN8YhpSOnc7/CYAh8yDaRd/mN60xo/bjcsbucIrTHVRQdwlgq2sAvk9lH4AZ42xr+tSISoNr+fA1foaQTqaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2BDFB150C;
	Sun,  3 Aug 2025 07:03:04 -0700 (PDT)
Received: from [10.163.64.130] (unknown [10.163.64.130])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 190E63F5A1;
	Sun,  3 Aug 2025 07:03:07 -0700 (PDT)
Message-ID: <d72b7928-8646-4616-a8f0-96b9d9bbaf09@arm.com>
Date: Sun, 3 Aug 2025 19:33:04 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: arm64: ptdump: Fix exec attribute printing
To: Wei-Lin Chang <r09922117@csie.ntu.edu.tw>,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 linux-kernel@vger.kernel.org
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
 Joey Gouly <joey.gouly@arm.com>, Sebastian Ene <sebastianene@google.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu
 <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>
References: <20250802104021.3076621-1-r09922117@csie.ntu.edu.tw>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20250802104021.3076621-1-r09922117@csie.ntu.edu.tw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 02/08/25 4:10 PM, Wei-Lin Chang wrote:
> Currently the guest stage-2 page table dump has the executable attribute
> printed in reverse, showing "X" for a non-executable region and showing
> " " for an executable one. This is caused by misjudgement of which
> string gets printed for the executable and non-executable case. Fix it
> by swapping the two strings.
> 
> Signed-off-by: Wei-Lin Chang <r09922117@csie.ntu.edu.tw>
> ---
>  arch/arm64/kvm/ptdump.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kvm/ptdump.c b/arch/arm64/kvm/ptdump.c
> index 098416d7e5c25..99fc13f1c11fb 100644
> --- a/arch/arm64/kvm/ptdump.c
> +++ b/arch/arm64/kvm/ptdump.c
> @@ -44,8 +44,8 @@ static const struct ptdump_prot_bits stage2_pte_bits[] = {
>  	}, {
>  		.mask	= KVM_PTE_LEAF_ATTR_HI_S2_XN | PTE_VALID,
>  		.val	= PTE_VALID,
> -		.set	= " ",
> -		.clear	= "X",
> +		.set	= "X",
> +		.clear	= " ",
>  	}, {
>  		.mask	= KVM_PTE_LEAF_ATTR_LO_S2_AF | PTE_VALID,
>  		.val	= KVM_PTE_LEAF_ATTR_LO_S2_AF | PTE_VALID,

Is not KVM_PTE_LEAF_ATTR_HI_S2_XN already in the reverse semantics aka
XN (Execute Never). Hence when KVM_PTE_LEAF_ATTR_HI_S2_XN macro is set
that means the entry is not executable and vice versa.

