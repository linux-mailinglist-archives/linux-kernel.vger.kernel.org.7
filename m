Return-Path: <linux-kernel+bounces-824271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D704B8889D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 11:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2434626C9E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 09:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92542F362E;
	Fri, 19 Sep 2025 09:22:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60DB2D239F
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 09:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758273769; cv=none; b=BwMVWIANddcRLUlWSDSFiemOzVnqJnLjvD68nk7FRkXuiYONOo47sCcrKnuUl7mygOTWMasVIt9Aq/hqymyw7W9uMcZPmoylxEXdMDSqpNBLGLypW4ctgCbwvuEEIfGemhFAECGvgLbTvntjpOC+wpyJDArjXNXbtN+wQVp2SwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758273769; c=relaxed/simple;
	bh=0ZQCC4VWhyf8uMZ7nGXEpvjFC2ryEIPI0vytiwsSrKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oCTfozGipqj3f1RAgecqFW/JgSjfBdTRt713FZwwL4vhTox/REUYKR++4cuJ4gRLzmP3LwU2aPEJwZLXoBT8+ZNfF61g+1lQfqWvGAtA05uu+0ul+RSxUqOWkPdoZFnG01sLCLpb6jwXYOohHcq7ltO1Qv5ua3hkOzMyVmdfbUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C17E4169E;
	Fri, 19 Sep 2025 02:22:38 -0700 (PDT)
Received: from [10.163.44.14] (unknown [10.163.44.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F4963F66E;
	Fri, 19 Sep 2025 02:22:43 -0700 (PDT)
Message-ID: <554e507a-1a68-4ae9-9345-5aea0a81ba2b@arm.com>
Date: Fri, 19 Sep 2025 14:52:40 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 2/2] arm64/sysreg: Replace TCR_EL1 field macros
To: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
 Oliver Upton <oliver.upton@linux.dev>, Mark Brown <broonie@kernel.org>,
 Ryan Roberts <ryan.roberts@arm.com>, kvmarm@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250907123000.414181-1-anshuman.khandual@arm.com>
 <20250907123000.414181-3-anshuman.khandual@arm.com>
 <aMv2J1hRQm_f4WAP@willie-the-truck>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <aMv2J1hRQm_f4WAP@willie-the-truck>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/09/25 5:38 PM, Will Deacon wrote:
> On Sun, Sep 07, 2025 at 06:00:00PM +0530, Anshuman Khandual wrote:
>> This just replaces all used TCR_EL1 field macros with tools sysreg variant
>> based fields and subsequently drops them from the header (pgtable-hwdef.h)
>> and moves all required macros into KVM header (asm/kvm_arm.h) for continued
>> usage in KVM.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Marc Zyngier <maz@kernel.org>
>> Cc: Mark Brown <broonie@kernel.org>
>> Cc: kvmarm@lists.linux.dev
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>> Changes in V4:
>>
>> - Dropped all unused TCR_XXX macros while moving into KVM header
>>
>>  arch/arm64/include/asm/assembler.h     |  6 +-
>>  arch/arm64/include/asm/cputype.h       |  2 +-
>>  arch/arm64/include/asm/kvm_arm.h       | 43 +++++++++++
>>  arch/arm64/include/asm/mmu_context.h   |  4 +-
>>  arch/arm64/include/asm/pgtable-hwdef.h | 98 +-------------------------
>>  arch/arm64/include/asm/pgtable-prot.h  |  2 +-
>>  arch/arm64/kernel/cpufeature.c         |  4 +-
>>  arch/arm64/kernel/pi/map_kernel.c      |  8 +--
>>  arch/arm64/kernel/vmcore_info.c        |  2 +-
>>  arch/arm64/mm/proc.S                   | 36 ++++++----
>>  tools/arch/arm64/include/asm/cputype.h |  2 +-
> 
> Please don't mix tools/ patches with arch patches. You probably want to keep
> the KVM one separate as well.

Sure, will split these changes in the following order.

- arm64 tool sysreg update for TCR_EL1
- Tools header update for TCR_NFD0/1
- Kernel update
- KVM specific update i.e header macro movement

