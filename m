Return-Path: <linux-kernel+bounces-824467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69479B894DF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 13:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 367831CC05EA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 11:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE0E3054F8;
	Fri, 19 Sep 2025 11:49:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F722199934
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 11:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758282570; cv=none; b=BjUAnnKYXscQc2cPCavzA6ykn97KpvIScr5WJWtNee8GUAbLmyGcRWZE5C0lkbi5Yoys8QhAguoQflosvXfAR2ImITwiCzNqp4NNrZ9VnTNPcn1ajp/MlqGHmhtpkpEXYVqX41wSoH914QzzyhI8oP5cNR9u4AiSZh1zxgujafU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758282570; c=relaxed/simple;
	bh=BWvKdzka+QmJcsua1Doa/4aXsgwxp0CICoCgvO+IS2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dWAACpFu1wKf02HgS1BIu1A/ryXyIreRguLbr9+S5U8InvRzlZnCrf8/PdwU4JQg1oIrbLyitzgsPkxE7ufoMxXRfhP0opMVTXfCViRdn7qET1TkKcsgmKoIA8dr3k5hx8OWhED5ca14CX4aqoNRBfjn70teh8Hl0YYUV0NL6UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 18CB71691;
	Fri, 19 Sep 2025 04:49:19 -0700 (PDT)
Received: from [10.57.95.38] (unknown [10.57.95.38])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C34EB3F66E;
	Fri, 19 Sep 2025 04:49:24 -0700 (PDT)
Message-ID: <ceaf604f-8ad7-4e19-812e-7eeace10d835@arm.com>
Date: Fri, 19 Sep 2025 12:49:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/5] arm64: support FEAT_BBM level 2 and large block
 mapping when rodata=full
Content-Language: en-GB
To: Will Deacon <will@kernel.org>
Cc: catalin.marinas@arm.com, akpm@linux-foundation.org, david@redhat.com,
 lorenzo.stoakes@oracle.com, ardb@kernel.org, dev.jain@arm.com,
 scott@os.amperecomputing.com, cl@gentwo.org,
 Yang Shi <yang@os.amperecomputing.com>, kernel-team@android.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20250917190323.3828347-1-yang@os.amperecomputing.com>
 <175822779944.710258.10028837182267037801.b4-ty@kernel.org>
 <fc43aa07-d4ad-47d5-8381-61d4a9b8c467@arm.com>
 <aM0-FQlepoxxGkRd@willie-the-truck>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <aM0-FQlepoxxGkRd@willie-the-truck>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/09/2025 12:27, Will Deacon wrote:
> On Fri, Sep 19, 2025 at 11:08:47AM +0100, Ryan Roberts wrote:
>> On 18/09/2025 22:10, Will Deacon wrote:
>>> On Wed, 17 Sep 2025 12:02:06 -0700, Yang Shi wrote:
>>>> On systems with BBML2_NOABORT support, it causes the linear map to be mapped
>>>> with large blocks, even when rodata=full, and leads to some nice performance
>>>> improvements.
>>>>
>>>> Ryan tested v7 on an AmpereOne system (a VM with 12G RAM) in all 3 possible
>>>> modes by hacking the BBML2 feature detection code:
>>>>
>>>> [...]
>>>
>>> Applied patches 1 and 3 to arm64 (for-next/mm), thanks!
>>>
>>> [1/5] arm64: Enable permission change on arm64 kernel block mappings
>>>       https://git.kernel.org/arm64/c/a660194dd101
>>> [3/5] arm64: mm: support large block mapping when rodata=full
>>>       https://git.kernel.org/arm64/c/a166563e7ec3
>>>
>>> I also picked up the BBML allow-list addition (second patch) on
>>> for-next/cpufeature.
>>>
>>> The fourth patch ("arm64: mm: split linear mapping if BBML2 unsupported
>>> on secondary CPUs") has some really horrible conflicts. These are partly
>>> due to some of the type cleanups on for-next/mm but I think mainly due
>>> to Kevin's kpti rework that landed after -rc1.
>>
>> Thanks Will, although I'm nervous that without this patch, some platforms might
>> not boot; Wikipedia tells me that there are some Google, Mediatek and Qualcomm
>> SoCs that pair X4 CPUs (which is on the BBML2_NOABORT allow list) with A720
>> and/or A520 (which are not). See previous mail at [1].
> 
> I'd be surprised if these SoCs are booting on the X4 but who knows.

Ahh. You can probably tell I'm a bit naive to some of this system level stuff...
I had assumed they would want to boot on the big CPU to reduce boot time.

> 
> Lemme have another look at applying the patch with fresh eyes, but I do
> wonder whether having X4 on the allow list really makes any sense. Are
> there any SoCs out there that _don't_ pair it with CPUs that aren't on
> the allow list? (apologies for the double negative).

Hmm, that's a fair question. I'm not aware of any. So I guess the simplest
solution is to remove X4 from the allow list and ditch fourth patch.


> 
> Will


