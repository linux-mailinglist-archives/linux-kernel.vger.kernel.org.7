Return-Path: <linux-kernel+bounces-726512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A68B00DEC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 23:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 557E03A8FF4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 21:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A85A2749E4;
	Thu, 10 Jul 2025 21:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0V6Lx88"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951951E520B;
	Thu, 10 Jul 2025 21:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752183274; cv=none; b=AVNBt2rGWNRcGTTmeA+01k5xdZjWYikGcgyxyJ7t/l1vk/A4B3vcWnSrA4vtRnDGlKDaaEKKMm84HhQjElqv2GuM4++cuCRVeI865gFf5v/5pYpyqpmBP3BaCiIuFZ5KCSTwu6N/t3Q86s3LMQ4a2EwWjZwMDrQZ4lzODLPFnAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752183274; c=relaxed/simple;
	bh=D2gSOs6w5MoNnB8XjW8YjK8yUYQ9o/D5CpbFMvAMgPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nuRAUXDbOxERKIO1ksv1OeB0nwlJgvlmViOV6DOD3Qoz7b/bqdjlGO+p0cvxE+If2ZTSF+zfu4+/BEnSRaZ5jd6oLPw15icFdsbKiefXqf7MWq5h528jW4yIzHgA/4KoAqmAa9YysaeQyMFMgpUIugFbcPH6XLYtSUJAbKDn9zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0V6Lx88; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98CB8C4CEE3;
	Thu, 10 Jul 2025 21:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752183274;
	bh=D2gSOs6w5MoNnB8XjW8YjK8yUYQ9o/D5CpbFMvAMgPY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=o0V6Lx88eBTVlQEr0scRQNALsAyn9o1OtLFMtdvKpeVSO3wDoohldvUijlKsy/srV
	 SzFQxiiAfzotgNxJmVfVqgPTwMovoguKB/Zz/TQclDUo8HkM2ZbvqBZOKRlOpPtcG1
	 sTJFkRwRHv6xGBLpfQDvBRTsiAWukX5p1NHycK5nvzHlsIsRgbln9mN22pOb+IFBQ2
	 9vXvSqcg1BvkhoaqDpS2sfIEzCsj4SXssvqPPxWpvPeMuFZvs8IqHDxKUS0i2YoMVz
	 /V87+tMhQmBukvSJNBNVhNkjGAJ+rNAz44IO7plqzQt4mIgwWhjDAES3lFLbw5zih1
	 XVF+84bXn2w1g==
Message-ID: <8dd8588c-2384-4999-8433-9ebcf7d5a863@kernel.org>
Date: Thu, 10 Jul 2025 23:34:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 3/9] dt-bindings: power: Add AMD Versal power domain
 bindings
To: "Williams, Gregory" <gregoryw@amd.com>,
 Gregory Williams <gregory.williams@amd.com>, ogabbay@kernel.org,
 michal.simek@amd.com, robh@kernel.org
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250702155630.1737227-1-gregory.williams@amd.com>
 <20250702155630.1737227-4-gregory.williams@amd.com>
 <6f4f68af-7b24-480f-8dae-372098b437fc@kernel.org>
 <d4beb853-12a4-43ec-96af-9f6a7881600f@amd.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <d4beb853-12a4-43ec-96af-9f6a7881600f@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/07/2025 20:53, Williams, Gregory wrote:
>>
>>
>>>  1 file changed, 55 insertions(+)
>>>  create mode 100644 include/dt-bindings/power/xlnx-versal-power.h
>>>
>>> diff --git a/include/dt-bindings/power/xlnx-versal-power.h b/include/dt-bindings/power/xlnx-versal-power.h
>>> new file mode 100644
>>> index 000000000000..effbc70e5a12
>>> --- /dev/null
>>> +++ b/include/dt-bindings/power/xlnx-versal-power.h
>>> @@ -0,0 +1,55 @@
>>> +/* SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) */
>>> +/*
>>> + *  Copyright (C) 2019 - 2021 Xilinx, Inc.
>>> + *  Copyright (C) 2024 Advanced Micro Devices, Inc.
>>> + */
>>> +
>>> +#ifndef _DT_BINDINGS_VERSAL_POWER_H
>>> +#define _DT_BINDINGS_VERSAL_POWER_H
>>> +
>>> +#define PM_DEV_RPU0_0                                (0x18110005U)
>>> +#define PM_DEV_RPU0_1                                (0x18110006U)
>>
>> Bindings ID start from 0 or 1 and are decimal numbers. None of these are
>> bindings (and commit msg does not explain here anything).
>>
>> Also, where is the compatible using these? Why is this a separate patch?
> In 'Submitting DT binding patches' it says: "The Documentation/ and include/dt-bindings/ portion of the patch should be a separate patch".

Separate from the driver. But that's a single patch.


Best regards,
Krzysztof

