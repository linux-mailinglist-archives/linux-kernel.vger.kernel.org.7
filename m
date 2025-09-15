Return-Path: <linux-kernel+bounces-816024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5F2B56E4F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 04:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BED617989A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 02:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D0122258E;
	Mon, 15 Sep 2025 02:24:31 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9110C227E95
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 02:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757903070; cv=none; b=AUUFiMU6fXBCL1AC/Qxiddt3DUza3j52bJJaEweFNR3H6g7+QU7hSkuWwlRmr3m8jHRrcTbjEWUPecMrpi7xi2lZ85j01xFzR90vTXCBLLwEWeYPU+2NdTv8TBCct+YVjm+sovfm571wMW+/z1pWMqNWY+AS6AFm/5Jw5JHPUyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757903070; c=relaxed/simple;
	bh=/I+hLorKB6/td5XQaZ5HcF/BR05kv9cle1qcnnP85Co=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kjiApWzseVor9jhxJ0Sb0n5CHsht4tKwdY2OK6Q03Ynhhe8SDUWlp3V4WTAaYGJ4n4hwDQwfgwFOLWTQidW2sLRjLY0qMwxbE5TQpkh0PEMq1hip1tJhW6x4zomUqWWPpo6SKMoZduboCag+jsnQwMUxJAGpixxYSTw5z2OzemA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D2BF1424;
	Sun, 14 Sep 2025 19:24:14 -0700 (PDT)
Received: from [10.164.18.48] (unknown [10.164.18.48])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B82393F66E;
	Sun, 14 Sep 2025 19:24:19 -0700 (PDT)
Message-ID: <e1d9c9a9-7ab0-44e0-b293-7655f18638b5@arm.com>
Date: Mon, 15 Sep 2025 07:54:16 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 0/2] arm64/sysreg: Clean up TCR_EL1 field macros
To: linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
 Mark Brown <broonie@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
 kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250907123000.414181-1-anshuman.khandual@arm.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20250907123000.414181-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 07/09/25 5:59 PM, Anshuman Khandual wrote:
> Currently TCR_EL1 field macros are sprinkled across the arm64 platform code
> including KVM implementation. Clean these up via updating required register
> filed definitions in tools sysreg format and then subsequently doing all
> necessary replacements. All required TCR_XXX macros have been moved from
> (asm/pgtable-hwdef.h) into KVM header (asm/kvm_arm.h) for their continued
> usage in KVM.
> 
> The cleanup does not cause any functional change.
> 
> This applies on v6.17-rc4

Gentle ping.

Any updates on this ?
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Oliver Upton <oliver.upton@linux.dev>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: kvmarm@lists.linux.dev
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> 
> Changes in V4:
> 
> - Dropped all unused TCR_XXX macros while moving into KVM header
> 
> Changes in V3:
> 
> https://lore.kernel.org/all/20250901072037.743380-1-anshuman.khandual@arm.com/
> 
> - KVM TCR_XXX flags are expressed via TCR_EL1_XXX flags per Marc
> 
> Changes in V2:
> 
> https://lore.kernel.org/all/20250829060215.1086792-1-anshuman.khandual@arm.com/
> 
> - Fixed ARM ARM version from 7.B to L.B
> - Changed UnsignedEnum into Enum per Mark
> - Dropped all TCR_EL1 replacements from KVM code
> - Moved existing TCR_XXX macros from (asm/pgtable-hwdef.h) into KVM header
>   (asm/kvm_arm.h) for their continued usage
> - Dropped patches 3 and 4 which could be done subsequently
> 
> Changes in V1:
> 
> https://lore.kernel.org/linux-arm-kernel/20250818045759.672408-1-anshuman.khandual@arm.com/
> 
> 
> Anshuman Khandual (2):
>   arm64/sysreg: Update TCR_EL1 register
>   arm64/sysreg: Replace TCR_EL1 field macros
> 
>  arch/arm64/include/asm/assembler.h     |  6 +-
>  arch/arm64/include/asm/cputype.h       |  2 +-
>  arch/arm64/include/asm/kvm_arm.h       | 43 +++++++++++
>  arch/arm64/include/asm/mmu_context.h   |  4 +-
>  arch/arm64/include/asm/pgtable-hwdef.h | 98 +-------------------------
>  arch/arm64/include/asm/pgtable-prot.h  |  2 +-
>  arch/arm64/include/asm/sysreg.h        |  2 -
>  arch/arm64/kernel/cpufeature.c         |  4 +-
>  arch/arm64/kernel/pi/map_kernel.c      |  8 +--
>  arch/arm64/kernel/vmcore_info.c        |  2 +-
>  arch/arm64/mm/proc.S                   | 36 ++++++----
>  arch/arm64/tools/sysreg                | 52 +++++++++++---
>  tools/arch/arm64/include/asm/cputype.h |  2 +-
>  13 files changed, 127 insertions(+), 134 deletions(-)
> 


