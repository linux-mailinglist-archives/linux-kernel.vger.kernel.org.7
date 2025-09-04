Return-Path: <linux-kernel+bounces-800590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C781B4399C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF2BC1B2859D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 11:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364102FC00C;
	Thu,  4 Sep 2025 11:09:11 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650982FB63D
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 11:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756984150; cv=none; b=B+jq8mf4/n8iqUv+aPYymfHf+jQ5SCbL7DieMzMntoal6s4opZz0i/vQnqizdkHITgmj84ut1DwWO+7nowzJNOfouKSliO0/2rHikfmrXAmwjfiDEjYCjSYlRQNmtkshipXCm2OgEhwTlMvvOA5+3dQBTuHwjwfkJKOXFNeqvr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756984150; c=relaxed/simple;
	bh=Jq3FjfccAiPy+TJ9SZX9XZOPdmefL52M+uAcJ4V2clU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F3egiaInVPpcWtHLtJpoD4FYZ4I4APafoKvuZPSBxXaWI7Xlpv6pvK47os8SxYECB2Qw0Rw3/Ucr4UpHfG6ntmeMxvgg/7U7bouSOX6UiNIs6mlKSYD1Rs8ZJRJ8qLKnU8sTIRLrH5tQGtDucOhhavXOZQjvx7FnfRYCgFCc2Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A9691756;
	Thu,  4 Sep 2025 04:09:00 -0700 (PDT)
Received: from [10.1.37.179] (XHFQ2J9959.cambridge.arm.com [10.1.37.179])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 669B33F6A8;
	Thu,  4 Sep 2025 04:09:06 -0700 (PDT)
Message-ID: <d6e6b96e-1bee-4af0-9343-9fb365beb4b3@arm.com>
Date: Thu, 4 Sep 2025 12:09:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/6] arm64: mm: support large block mapping when
 rodata=full
Content-Language: en-GB
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Yang Shi <yang@os.amperecomputing.com>, Ard Biesheuvel <ardb@kernel.org>,
 Dev Jain <dev.jain@arm.com>, scott@os.amperecomputing.com, cl@gentwo.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20250829115250.2395585-1-ryan.roberts@arm.com>
 <20250829115250.2395585-4-ryan.roberts@arm.com> <aLiTzJ6E-YBIYuGo@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <aLiTzJ6E-YBIYuGo@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/09/2025 20:15, Catalin Marinas wrote:
> On Fri, Aug 29, 2025 at 12:52:44PM +0100, Ryan Roberts wrote:
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index 34e5d78af076..114b88216b0c 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -481,6 +481,8 @@ void create_kpti_ng_temp_pgd(pgd_t *pgdir, phys_addr_t phys, unsigned long virt,
>>  			     int flags);
>>  #endif
>>  
>> +#define INVALID_PHYS_ADDR	-1
> 
> Nitpick: (-1UL) (or (-1ULL), KVM_PHYS_INVALID is defined as the latter).

Fair. Will fix.

> 
> Otherwise the patch looks fine.
> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Cheers! But I think we need to solve the issue where code is ignoring the error
code problem that Dev raised before merging this.

