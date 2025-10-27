Return-Path: <linux-kernel+bounces-870745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E4AC0B943
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 02:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C98314E4837
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 01:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E6D239567;
	Mon, 27 Oct 2025 01:14:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E805E238150
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 01:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761527654; cv=none; b=P+5nq+6Calaambj0VQX/TUkXyJd0U2Tg7X3q/eHI2WhKyEjuFylyjMLqU6V/vz2SRVWhWaJ4zT1d65dRaeceoLyPWICogTJfSaMWQeAnwhRJkEzEzGMYLxdw1qA1kUX+hJIFTxFCBM7Jz1ttQQUiHRu6KeEMFNh5Yyb3ENSqNqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761527654; c=relaxed/simple;
	bh=9ZDNs8sqkigD3yuqMV8N34wMSfxo33xTGPQNY/sykRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qqEu6rZCXPhR2aJ2fg516z5r0b7OMdhLKfck0HDDFe/ort1hOQldygICxk2q6v2d6H4kdLN6bBniWYZrTgoQK+aCfPzwo7XOcEuqKUeqwvVJBq2KAwJL9PiMEUweVbgf72fuKereueXoyRi4YmyDEoKd+46AHqD/Fd7aApStV68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A346113E;
	Sun, 26 Oct 2025 18:14:03 -0700 (PDT)
Received: from [10.163.70.164] (unknown [10.163.70.164])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 86CEA3F673;
	Sun, 26 Oct 2025 18:14:08 -0700 (PDT)
Message-ID: <d4d2086b-8fd1-4e52-8e5d-24b2447335f7@arm.com>
Date: Mon, 27 Oct 2025 06:44:05 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/2] arm64/mm: Add remaining TLBI_XXX_MASK macros
To: Ben Horgan <ben.horgan@arm.com>, linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
 linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev
References: <20251024040207.137480-1-anshuman.khandual@arm.com>
 <20251024040207.137480-3-anshuman.khandual@arm.com>
 <95ee2490-6904-4a24-93db-411c489bd2b4@arm.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <95ee2490-6904-4a24-93db-411c489bd2b4@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/10/25 2:26 PM, Ben Horgan wrote:
> Hi Anshuman,
> 
> On 10/24/25 05:02, Anshuman Khandual wrote:
>> Add remaining TLBI_XXX_MASK macros and replace current open encoded fields.
>> While here replace hard coded page size based shifts but with derived ones
>> via ilog2() thus adding some required context.
>>
>> TLBI_TTL_MASK has been split into separate TLBI_TTL_MASK and TLBI_TG_MASK
>> as appropriate because currently it simultaneously contains both page size
>> and translation table level information. KVM on arm64 has been updated to
>> accommodate these changes to TLBI_TTL_MASK.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Marc Zyngier <maz@kernel.org>
>> Cc: Oliver Upton <oliver.upton@linux.dev>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Cc: kvmarm@lists.linux.dev
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>  arch/arm64/include/asm/tlbflush.h | 26 ++++++++++++++++++--------
>>  arch/arm64/kvm/nested.c           |  8 +++++---
>>  2 files changed, 23 insertions(+), 11 deletions(-)
>>
> The code looks correct to me, no functional changes. I however, don't
> have any experience with this code and so don't know whether the split
> of TTL into TG and TTL is a good idea or not and if the kvm naming is

TLBI_TTL field contains both encoded page size and also page table
level information. This split in the mask makes the code much clear
and explicit.
> best to stay the same or be updated to match this.
This proposed patch keeps the KVM code churn to the minimum while
also adapting to the mask split as necessary. But further changes
to KVM if required can be done subsequently later.

