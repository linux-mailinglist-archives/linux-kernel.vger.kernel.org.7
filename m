Return-Path: <linux-kernel+bounces-774852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E50B2B859
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 06:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31EC218912C3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 04:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F0825A331;
	Tue, 19 Aug 2025 04:24:39 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC031B87EB
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 04:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755577479; cv=none; b=WbXC2QFw68zhCkjvB8Y2lKojVx+ITlMpENgGoBgfJ3zgMDdDJf2LQwmS/SO4n/6SZRAfgLVJ3ngaiO3B9x3IZ/wQQw/g52ONNtyv7GiTXG+hH0QLen0oO/ezPmq2LQ8Y1MEDFEZM6uqt+KbojTuU72DWZcYrb5gmydb1QE7cR5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755577479; c=relaxed/simple;
	bh=yZWO+us9BsBsZLgRyLz1RZnETM4MXpixOqlu1zQX1Tk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sdKdpaDAy4mbVMZqIgulqu+t5XYmPlZquY6ZXNA/KUVlLn3SqgDvC3stVyKctjE7n+AYGFqHfZITfBEXvrOAH+GpCfwNRuuphDL974Mp/vGDd2sIerJEKs8DjAB7O456NYYBP9LMi4VREPK3SDbaWcmqoInwzi1NdZqVG0NAtyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 65603152B;
	Mon, 18 Aug 2025 21:24:27 -0700 (PDT)
Received: from [10.164.146.16] (J09HK2D2RT.blr.arm.com [10.164.146.16])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5DF223F63F;
	Mon, 18 Aug 2025 21:24:32 -0700 (PDT)
Message-ID: <bf78530c-e3e7-42b1-be7c-409d6427afda@arm.com>
Date: Tue, 19 Aug 2025 09:54:29 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] arm64/sysreg: Add VTCR_EL2 register
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
 Mark Brown <broonie@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
 kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250818045759.672408-1-anshuman.khandual@arm.com>
 <20250818045759.672408-5-anshuman.khandual@arm.com>
 <aKLw1jvwOo4wG64n@J2N7QTR9R3>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <aKLw1jvwOo4wG64n@J2N7QTR9R3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 18/08/25 2:52 PM, Mark Rutland wrote:
> On Mon, Aug 18, 2025 at 10:27:59AM +0530, Anshuman Khandual wrote:
>> diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
>> index d2b40105eb41..f5a0a304f844 100644
>> --- a/arch/arm64/tools/sysreg
>> +++ b/arch/arm64/tools/sysreg
>> @@ -4910,6 +4910,63 @@ Field	1	PIE
>>  Field	0	PnCH
>>  EndSysreg
>>  
>> +Sysreg	VTCR_EL2	3	4	2	1	2
>> +Res0	63:46
>> +Field	45	HDBSS
>> +Field	44	HAFT
>> +Res0	43:42
>> +Field	41	TL0
>> +Field	40	GCSH
>> +Res0	39
>> +Field	38	D128
>> +Field	37	S2POE
>> +Field	36	S2PIE
>> +Field	35	TL1
>> +Field	34	AssuredOnly
>> +Field	33	SL2
>> +Field	32	DS
>> +Res1	31
>> +Field	30	NSA
>> +Field	29	NSW
>> +Field	28	HWU62
>> +Field	27	HWU61
>> +Field	26	HWU60
>> +Field	25	HWU59
>> +Res0	24:23
>> +Field	22	HD
>> +Field	21	HA
>> +Res0	20
>> +UnsignedEnum	19	VS
>> +	0b0	8BIT
>> +	0b1	16BIT
>> +EndEnum
> 
> You left TCR_EL1.AS as a single-bit 'Field', so please do the same here
> for consistency. I don't think there's much gained by making this any
> sort of enum.

But actually there is an use case in kvm_get_vtcr().

        /* Set the vmid bits */
        vtcr |= (get_vmid_bits(mmfr1) == 16) ?
                SYS_FIELD_PREP_ENUM(VTCR_EL2, VS, 16BIT) :
                SYS_FIELD_PREP_ENUM(VTCR_EL2, VS, 8BIT);

> 
>> +Field	18:16	PS
>> +UnsignedEnum	15:14	TG0
>> +		0b00	4K
>> +		0b01	64K
>> +		0b10	16K
>> +EndEnum
> 
> As with other patches, this is not ordered. Please use Enum.
> 
> Likewise for the other cases below.


Sure, will do the changes.
> 
> Mark.
> 
>> +UnsignedEnum	13:12	SH0
>> +		0b00	NONE
>> +		0b10	OUTER
>> +		0b11	INNER
>> +EndEnum
>> +UnsignedEnum	11:10	ORGN0
>> +	0b00	NC
>> +	0b01	WBWA
>> +	0b10	WT
>> +	0b11	WBnWA
>> +EndEnum
>> +UnsignedEnum	9:8	IRGN0
>> +	0b00	NC
>> +	0b01	WBWA
>> +	0b10	WT
>> +	0b11	WBnWA
>> +EndEnum
>> +Field	7:6	SL0
>> +Field	5:0	T0SZ
>> +EndSysreg
>> +
>>  SysregFields MAIR2_ELx
>>  Field	63:56	Attr7
>>  Field	55:48	Attr6
>> -- 
>> 2.25.1
>>
>>


