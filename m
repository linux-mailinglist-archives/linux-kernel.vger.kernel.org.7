Return-Path: <linux-kernel+bounces-731689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 955FFB0584E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 13:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5AC51A60E1B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 11:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5F22D8786;
	Tue, 15 Jul 2025 11:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ikpqn+2i"
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5C26BB5B
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 11:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752577386; cv=none; b=aE8PXatAVKibv+HJkXb78u68P0coqlD6gZ6hHJc4QgL4sX+C/g/dkB3H2z5y6eE5ZgCVVPJXsdZlXboNShjUWMjwUaF4CYwp4jACbQIHhH4cniMVgpB7dWcAG5qB2x4R81ugPG7AWOT8U9b4xJJzz5ONALzTO+l7/nu+xzfJcl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752577386; c=relaxed/simple;
	bh=JeULfLoO61COXgY9TRNEBynJYaRj3dtYVdnwXi9Urio=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HrACMuG79KIEx8GsQic0r7OHZo31PG2Wi8qPd3OwGwCLnD9e9rQWdmxsjYfnTUwK4xV+2LzWLjAzkfjw/Qstt+20Ee6wV2OdVqfFYaObVKJXOQUOrCxkdNELadlDJAMhhhcLhbOg7Kb8t/7tZQ0T/pupKSEQfLyDbNPc6ykkEU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ikpqn+2i; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-451d41e1ad1so37628155e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 04:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752577383; x=1753182183; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BKUkKIualjoy9v95vK8+BtLhU3lx0OJMWJq7rT63AXY=;
        b=ikpqn+2ib7w+K48082h24IVK3H6n0IIDYGVoUM5G313XtQn1LoLCvVE472qVwH2ZaD
         5WgTvN0WElGFJa0hPup0Bc9iXrnTSM9cuWsF5ncRVPi50jTBhFy/qrH9EpfjFY4Jxky/
         as2EVYDnYYRpIG5LAZyGH1NNQhCkxQxDmYhzadDX7hqSGxJ3tU1Mk43xNdEfuvryYI/b
         KYvinPusrbWrdYjwK5gqNH7yu2301Z/wx35DVgIhKvJG1relVlBxIfoimmB5XRWZ7SkJ
         5wZ/a+NtkuemwR+wQFsg4oFTTlU8wuuBm8F/7DHgML4k6K3m0sPX8cOj298gYxuf8WHd
         eV1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752577383; x=1753182183;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BKUkKIualjoy9v95vK8+BtLhU3lx0OJMWJq7rT63AXY=;
        b=NDJ8eYcW1rIgS7Uw9xpj7ji4dnIQFSghUlsQC+u/0pgELFhcw9dwNZe1FeRmtVcstA
         Ih+v2j2b42cbsLG4t9xgvCDltQKm8xhUybZC8SzOuCiKN4qEg/HUJKdwlLPei2DDdC4F
         GiyrecA/o/UtKGv+ZF4yq2OFBVC7SvGKbUBIALF+nLXFXcY13qCPc+CBLMXJmiUnNRdo
         8ADaZ6cSlGePPCuxlKRGtJ8NtpiaZ9P8wh1skK4JZrCEwv+F9xTnHIbdTVF6wJEEOjw5
         0u1eWxihNy34sMUdT/o1LdJ6PJ3ecZXTFIwNQU3B2Tj6LE5jQOkH01LUB9zbG58B4cYi
         7FXA==
X-Forwarded-Encrypted: i=1; AJvYcCUXFmr+RZQHv2+JyUstY489gSxxw4MLD8kA+U44xsvnMYP5i2RFDk5XT85Xb2zcwxp7Wy8mfF3t2yE/tmc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt5AiQYK2myAb4Zq3H9b2aVRJ8R/UzXICcdjDMwv8u7+ievlIN
	/N4remRH4BeJML8iPVc0Z4EXvGIeBy5MeyMR0gtmWLbCdchDzVzYVLbQxWGOPQdzN9U=
X-Gm-Gg: ASbGncuqOLOcE8Y4uRHR6yKr2kM+MU9txhAWxdEkEzrU5gs3gmR86hHovAR0gtUUsEi
	iGNqZGE8CvidGhbhOixkuDaloS9mmDnYu2WkH2I7jDRLSkl0nf9pKqjrYUHK4aZEryzJxNAuaU0
	azdFSNlnsNGtdZv3EIjkeIRip/RkLNpcMllBxMZsxHdP+ktY7qNBwb/FLmNq+uIZ/uq9BTwWVjN
	LBuWB+wFSfqYBGT6HORLkdNxlX4ODas27EUCJZ1T6leEHBfIuUdVjdpWJmJSGh0l+Hvqf5U+MWX
	XB5Di87L1Lk0GQtntg3vQEPgrxCCgC4MuQNzfX93F9onBpTASnN5pisNoh3+ez9fDdjjo+IZHYb
	2MyMz23Iak3FoG1ngS83xGuYb2jyq7RzHlzbtVif5ooRLb0JB6g8R9Oo/aM4KACI=
X-Google-Smtp-Source: AGHT+IH0nRGAW3eKLJ/DUVNlwgthSfHL2WGPa6jyeTIprfdCexkNpPIzlaJ5b41PyW8SbA84yckY8Q==
X-Received: by 2002:a05:600c:8b70:b0:456:fc1:c286 with SMTP id 5b1f17b1804b1-4560fc1c49amr79262565e9.1.1752577383065;
        Tue, 15 Jul 2025 04:03:03 -0700 (PDT)
Received: from [192.168.0.35] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45617f18d99sm66247625e9.8.2025.07.15.04.03.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 04:03:02 -0700 (PDT)
Message-ID: <2b5ececb-fbf7-4901-8efb-03744f740836@linaro.org>
Date: Tue, 15 Jul 2025 12:03:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: iris: MAINTAINERS: Document actual maintainership
 by Bryan O'Donoghue
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Dikshita Agarwal <quic_dikshita@quicinc.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Hans Verkuil <hverkuil@xs4all.nl>
References: <20250714151609.354267-2-krzysztof.kozlowski@linaro.org>
 <8772c48f-348b-8a68-2099-562a29b9dd8d@quicinc.com>
 <b83cc20b-44d2-4635-a540-7a9c0d36cdb5@linaro.org>
 <a4dfc82b-79df-3e3c-0964-a99db222c6e6@quicinc.com>
 <4f79424f-0005-4978-8c6d-6b726ee7e4ab@linaro.org>
 <c70fd6c6-1a65-41ee-b0e1-f6c792867009@linaro.org>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <c70fd6c6-1a65-41ee-b0e1-f6c792867009@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/07/2025 10:20, Krzysztof Kozlowski wrote:
> On 15/07/2025 09:06, Krzysztof Kozlowski wrote:
>> On 15/07/2025 09:00, Vikash Garodia wrote:
>>>
>>> On 7/15/2025 12:14 PM, Krzysztof Kozlowski wrote:
>>>> On 15/07/2025 07:51, Vikash Garodia wrote:
>>>>>
>>>>> On 7/14/2025 8:46 PM, Krzysztof Kozlowski wrote:
>>>>>> Bryan O'Donoghue reviews and applies patches for both Iris and Venus
>>>>>> Qualcomm SoC video codecs (visible in git log as his Signed-off-by and
>>>>>> in pull requests like [1]), so he is de facto the maintainer responsible
>>>>>> for the code.  Reflect this actual state my changing his entry from
>>>>>> reviewer to maintainer and moving the entry to alphabetical position by
>>>>>> first name.
>>>>>
>>>>> NAK.
>>>>>
>>>>> The roles and responsibilities are well agreed by media maintainer(Hans), with
>>>>> Bryan part of that discussion, w.r.t code contributions to iris and sending
>>>>> patches to media tree. The only reason Bryan post the patches is that Hans wants
>>>>> single PR for patches across Qualcomm media drivers (Camss/Videoss)
>>>>
>>>> That's the maintainer role, so Bryan is the maintainer. I am documenting
>>>> actual status and your NAK is naking what? That Bryan cannot handle patches?
>>> I would say, you are reading too much into it, i updated what we have discussed
>>> and agreed upon the different roles for managing venus and iris drivers.
>>
>> Reading too much? Bryan HANDLES THE PATCHES.
>>
>> That's it.
>>
>> There is nothing "too much here".
>>
>> Person handling the patches IS the maintainer. Full stop.
> 
> Based on email you forwarded to me and some more feedback I got, I think
> I understood what would be the solution to satisfy your point of not
> changing existing entry and solve my problem of maintainer handling
> patches not being listed anywhere as maintainer. I will solve it v2.
> 
> Best regards,
> Krzysztof

Doh, this is definitely my bad, I should have made a _new_ entry in 
MAINTAIENRS similar to this.

AIROHA PCIE PHY DRIVER
M:      Lorenzo Bianconi <lorenzo@kernel.org>
L:      linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
S:      Maintained
F:      Documentation/devicetree/bindings/phy/airoha,en7581-pcie-phy.yaml
F:      drivers/phy/phy-airoha-pcie-regs.h
F:      drivers/phy/phy-airoha-pcie.c

GENERIC PHY FRAMEWORK
M:      Vinod Koul <vkoul@kernel.org>
M:      Kishon Vijay Abraham I <kishon@kernel.org>
L:      linux-phy@lists.infradead.org
S:      Supported
Q:      https://patchwork.kernel.org/project/linux-phy/list/
T:      git git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git
F:      Documentation/devicetree/bindings/phy/
F:      drivers/phy/
F:      include/dt-bindings/phy/
F:      include/linux/phy/

scripts/get_maintainer.pl drivers/phy/phy-airoha-pcie.c
Lorenzo Bianconi <lorenzo@kernel.org> (maintainer:AIROHA PCIE PHY DRIVER)
Vinod Koul <vkoul@kernel.org> (maintainer:GENERIC PHY FRAMEWORK)
Kishon Vijay Abraham I <kishon@kernel.org> (maintainer:GENERIC PHY 
FRAMEWORK)
linux-arm-kernel@lists.infradead.org (moderated list:AIROHA PCIE PHY DRIVER)
linux-phy@lists.infradead.org (open list:GENERIC PHY FRAMEWORK)
linux-kernel@vger.kernel.org (open list)
GENERIC PHY FRAMEWORK status: Supported

Its 1:1 what we have for drivers/media/platform/qcom

I'll add that entry and leave the Iris/Venus entries as-is.

---
bod

