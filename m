Return-Path: <linux-kernel+bounces-887642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00839C38C74
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 03:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06B0B1A20386
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 02:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5952233711;
	Thu,  6 Nov 2025 02:00:03 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8DA17C21E
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 02:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762394403; cv=none; b=t88phaLNZsuON4jtAAJMX0sD1B5q51E7k6sjn6AqsYjZ93ZTr/eNN8NbnBd/iH+t3NTyekZMMO5nPxh5h43h0xp/5N09zd9Nh1L30+Pug6IZ2pi4C7eocWiqfFfP4/i8+2TK7H2OQb3lwd1tY+fQ4dxb5AI3pTTw2VV14FrZ95Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762394403; c=relaxed/simple;
	bh=uJ1oAMyLnWN/071VpfSW2SjsKJHUByvb60uN57wMAfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V6owylV+qeThxqx/7CJN6NwPlQGAv6wle1V5MgT/P17FDqH52X5D3qk9oFFIBgIj9zDnJD9t+t+kfYlxj42ovc9g6kq1Qqs4HinayApRxMoRKQ4tGG5Pi1jp43tBrAsrHlzpXHuW6nxCdskJCvf4YpF9kDDfDn80viIXBxJZSSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D6C3B168F;
	Wed,  5 Nov 2025 17:59:52 -0800 (PST)
Received: from [10.163.73.244] (unknown [10.163.73.244])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CB8833F66E;
	Wed,  5 Nov 2025 17:59:58 -0800 (PST)
Message-ID: <044a6526-d6e8-4ae0-9279-8cc42bff5aa0@arm.com>
Date: Thu, 6 Nov 2025 07:29:55 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64/mm: Add a fallback stub for pgd_page_paddr()
To: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, ryan.roberts@arm.com,
 Catalin Marinas <catalin.marinas@arm.com>, linux-kernel@vger.kernel.org
References: <20251014110633.304961-1-anshuman.khandual@arm.com>
 <aQoORmgliayA0s_a@willie-the-truck>
 <e660e033-6300-4deb-b034-4d26746d8d01@arm.com>
 <aQuDdE_Tj3di7q3P@willie-the-truck>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <aQuDdE_Tj3di7q3P@willie-the-truck>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 05/11/25 10:33 PM, Will Deacon wrote:
> On Wed, Nov 05, 2025 at 08:24:40AM +0530, Anshuman Khandual wrote:
>> On 04/11/25 8:01 PM, Will Deacon wrote:
>>> On Tue, Oct 14, 2025 at 12:06:33PM +0100, Anshuman Khandual wrote:
>>>> Add a fallback stub for pgd_page_paddr() when (PGTBALE_LEVELS <= 4) which
>>>
>>> typo
>>
>> Sure will change - s/Add/Adds
>>>
>>>> helps in intercepting any unintended usage and which is also in line with
>>>> existing stubs for similar [pud|p4d]_page_paddr() helpers.
>>>
>>> Are you saying the kernel compiles in this case without your patch? Which
>>> definition of pgd_page_paddr() does it end up using?
>>
>> Kernel compiles for PGTBALE_LEVELS <= 4 just fine without this patch as both
>> its current users p4d_offset_phys() and p4d_offset_lockless() are wrapped in
>> with PGTBALE_LEVELS > 4.
> 
> Ok, but your patch is trying to catch broken users of the macro, right?

Right but there are no broken users at present because all the users are
wrapped inside #ifdef PGTBALE_LEVELS > 4.

> So my question is, would such a user compile today? If not, then your
> patch is pointless.

The point is this macro is not visible outside #ifdef PGTBALE_LEVELS > 4
where as similar ones such as p4d_page_paddr() and pud_page_paddr() are
always visible via their respective fallback stubs, when PGTABLE_LEVELS
are lower.

