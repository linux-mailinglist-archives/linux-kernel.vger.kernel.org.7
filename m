Return-Path: <linux-kernel+bounces-899012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E8AFBC568F8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A1CD7344B28
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 09:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94B127E04C;
	Thu, 13 Nov 2025 09:18:52 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA6125A2C9
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 09:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763025532; cv=none; b=Ql5hZF4eHpPswwkVeIhH9aQA6aGXtm/cTCSI8UAGxhKiWhcnuaX6lBL5dnTmwccj9lqNm2V29pmP6RVRFVJTKce+ZDTpZEbhYKtyj9Hor/rQGwsSUqdKIdtVxn1VqPmaZ5lAH9taP9KD5Y9tVrMvsvLCsnCUs9KIeFyZQgf05d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763025532; c=relaxed/simple;
	bh=2UXp9hl1B9FD5VJ9Oumd38cIdKwN3R5gdxMyId5L8vA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CECxxFewpZ1h0SNHuum6SF+cD3AosxRdZEmHLsCJBUYyu8wRkzFVxGCn7K4h13Ei8WBokRyxQnElCtgN/6tv4S/0DfM0tIthHt0883Q5XLtvKdj0zkuSejYOHp6lLMYwbJgh+oDzurR+vG+bUyh0M9vuCqggHVcYMMyInEFN2x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D06112FC;
	Thu, 13 Nov 2025 01:18:41 -0800 (PST)
Received: from [10.163.74.57] (unknown [10.163.74.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1D4783F66E;
	Thu, 13 Nov 2025 01:18:46 -0800 (PST)
Message-ID: <a1306c3a-5d2e-48e0-aaa8-4e19ea81bef3@arm.com>
Date: Thu, 13 Nov 2025 14:48:44 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] arm64/mm: TTBRx_EL1 related changes
To: linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Ryan Roberts <ryan.roberts@arm.com>, Ard Biesheuvel <ardb@kernel.org>,
 linux-kernel@vger.kernel.org
References: <20251103052618.586763-1-anshuman.khandual@arm.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20251103052618.586763-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/11/25 10:56 AM, Anshuman Khandual wrote:
> This series contains some TTBRx_EL1 related changes, aimed at standardizing
> TTBRx_EL1 register field accesses via tools sysreg format and also explains
> 52 PA specific handling methods via a new macro along with in code comments
> 
> This series applies on v6.18-rc4
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> 
> Anshuman Khandual (6):
>   arm64/mm: Directly use TTBRx_EL1_ASID_MASK
>   arm64/mm: Directly use TTBRx_EL1_CnP
>   arm64/mm: Represent TTBR_BADDR_MASK_52 with TTBRx_EL1_BADDR_MASK
>   arm64/mm: Ensure correct 48 bit PA gets into TTBRx_EL1
>   arm64/mm: Describe 52 PA folding into TTBRx_EL1
>   arm64/mm: Describe TTBR1_BADDR_4852_OFFSET
> 
>  arch/arm64/include/asm/asm-uaccess.h   |  2 +-
>  arch/arm64/include/asm/assembler.h     |  3 ++-
>  arch/arm64/include/asm/mmu_context.h   |  2 +-
>  arch/arm64/include/asm/pgtable-hwdef.h | 23 ++++++++++++++++++++---
>  arch/arm64/include/asm/pgtable.h       |  5 +++--
>  arch/arm64/include/asm/uaccess.h       |  6 +++---
>  arch/arm64/kernel/entry.S              |  2 +-
>  arch/arm64/kernel/mte.c                |  4 ++--
>  arch/arm64/mm/context.c                |  8 ++++----
>  arch/arm64/mm/mmu.c                    |  2 +-
>  10 files changed, 38 insertions(+), 19 deletions(-)

Gentle ping. Beside [PATCH 4/6] (which can be dropped as indicated by Mark)
any concerns regarding reset of these changes here ?

