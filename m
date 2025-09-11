Return-Path: <linux-kernel+bounces-811875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3CCB52EFC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 12:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C54D1BC7C70
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 10:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E25430FC3D;
	Thu, 11 Sep 2025 10:52:12 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4202C21D9
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 10:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757587931; cv=none; b=rfp9q7/2RBQ+g1xRBlmFmrKe/TrdgybmuGXiJVNR93QIfiUpkO914muQb16dLyr/1tJQIOH4Z8gXaANZl3GUEki5VlBU2VZTmliWB14OSaaA8UpfDpsqGYdMyztDoJtkaR8QkWI8YCbhrP/cYkgFafxmgE31eIH9eF5yI5DvxO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757587931; c=relaxed/simple;
	bh=5xm/oKxNE7MpPJD888pjCXmQJWzr/yIx12TTrwyYy9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h/0lfU9/c8pdHdL6RLrtm4AZg8X57bBHz8Gh36c1gaQrjAeFgLeBnwQBjBcK+SRRgtNlDH2KLnzZlQwcuHJihsRM1CYKavTxRuwMAt3BTe3lbWhCq8SBLfUNxyaHleumjUsLJBk8ggkRUnNOQyHmM+oNLVJi2QeGq7ll7CTrvyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E965153B;
	Thu, 11 Sep 2025 03:52:00 -0700 (PDT)
Received: from [10.57.70.14] (unknown [10.57.70.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0A66F3F694;
	Thu, 11 Sep 2025 03:52:05 -0700 (PDT)
Message-ID: <b0b11c57-e45b-4a53-8dba-93e8ce5800c1@arm.com>
Date: Thu, 11 Sep 2025 12:52:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: mm: Move KPTI helpers to mmu.c
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Kees Cook <kees@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Will Deacon <will@kernel.org>,
 Yeoreum Yun <yeoreum.yun@arm.com>
References: <20250910104454.317067-1-kevin.brodsky@arm.com>
 <CAMj1kXHR34kpL1qLgeEgEmRZN1o=umWzjZEzmSV+X2AX-4CvVg@mail.gmail.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <CAMj1kXHR34kpL1qLgeEgEmRZN1o=umWzjZEzmSV+X2AX-4CvVg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/09/2025 11:19, Ard Biesheuvel wrote:
>> diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
>> index 49f1a810df16..624edd6c4964 100644
>> --- a/arch/arm64/include/asm/mmu.h
>> +++ b/arch/arm64/include/asm/mmu.h
>> @@ -104,5 +104,11 @@ static inline bool kaslr_requires_kpti(void)
>>         return true;
>>  }
>>
>> +#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
>> +void kpti_install_ng_mappings(void);
>> +#else
>> +static inline void kpti_install_ng_mappings(void) {}
>> +#endif
>> +
> Nit: you might just keep the former declaration, and check for
> IS_ENABLED(CONFIG_UNMAP_KERNEL_AT_EL0) in the function, rather than
> propagating this distinction to the header file.
> But either is fine with me.

That's an option, but that would mean removing the #ifdef around the
functions defined in mmu.c. They would probably get eliminated by the
linker if the CONFIG isn't defined, but I'm not so sure about the static
variable (kpti_ng_temp_alloc). Probably not a big deal but I feel
keeping the #ifdef is more self-documenting as well.

- Kevin

