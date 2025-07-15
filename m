Return-Path: <linux-kernel+bounces-731652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 513B0B057C3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 12:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 768A117AE6B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 10:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73962D8398;
	Tue, 15 Jul 2025 10:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SilQHJBj"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B25926D4C0
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 10:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752575273; cv=none; b=EIbtZ5lowD3pRLor6ifrnlB9cwtffpmEi9bBGEiy4HIKgVtggbt/7w8TI36NjQGqcHmyUzccSGphhx1i7wnvfO8ZawBz9k8/9SmnLotp3BE0B8PFTHm+9xs4lvq9PMCqdFmabxGFIudUVyer2glr0Tf9hcirifAlRHp4hDFYlBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752575273; c=relaxed/simple;
	bh=9GliLAWN9yboDvyuwIIOcsrA/WXw2EdBByjduEbn3pc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pYRFqCJ3YPdw4xM5Z8EGOLb5YkhLRPQdxnD6HoVXwhRkETZi2wc1NVOdNFNe2WxNUM4Pb/W0dJDti8NxI0E0wlUA6sMUSIroApeyB7UCIu2/Pj9S0ZuRHIvLpp2Hf4NsWVpHA4Ll74F6H+/YQmYwQp150UwUOkAL8WdhM8q27CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SilQHJBj; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-553affea534so727269e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 03:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752575269; x=1753180069; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i/2pXjO/4cLFhq1C0pbXxCDCYXatFBoRRv1ycMlT/jo=;
        b=SilQHJBj/vOqL2aZ1mynhuBa3YlbWYnp2VWNJYIrwqNE/FiZt8SD2CcZIOup7J7CKP
         cTWeZ8gySjx+ZEZUyrT2d9BaM7Dfq/Zayj8ZB6rlvffMuPzE9p8LTRiaoBseKw2QXuoq
         9ytrGvYbCt+pDQUPfjFfBVWp51uSvffrYeAp76EHe0Wu6IaA0fXhRWWcTvgoEU6aNAIR
         7WQ0XvPJwkoHHHItSF3Euzb7DXAfVh7Xq8yS8FOkcKBlciBoW6Ek3cFPHYMoSCs2zFSP
         2rvnH0eqFUtEvRWTlPBaimsXBLWSd9XJsIK0mTOhi8FUK1A3o6dm5A6gHbOJulrhG7dE
         t4Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752575269; x=1753180069;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i/2pXjO/4cLFhq1C0pbXxCDCYXatFBoRRv1ycMlT/jo=;
        b=vdICodRvMji/yNBWw4qWdvNK2mmXQfIKHfMgD0jkFsXeWZYBeLOXadR7yiBcy/UNEn
         mCvQB+PMkzoqZxyVAX4MAZosCfjNnvDNI8xBw5BQ/dYfAtwhiNbV3psT7r5XvlP+Daui
         nN8cOItbNZC8F8DGyMCecBAml6q7VRNDsMPCEy1GOIPErphPpjhD+Enlfjlo5GMsAugd
         8sTXzNkHMeVDHssxjR4clEz5vCoVT9PBc6ihSTWdorgHCYk6qAbahNfXUBgGfSxvhNnq
         E7YRkhUCtdlgkNbIXRvx4Chil5egEq15qnefqKmqdLUFdWJGkldDvbkoyFB3j+udDBIt
         BsMw==
X-Forwarded-Encrypted: i=1; AJvYcCWGCGE1xUxLjUWHXgQBzE8GXddpbBBeIZ60DQknbaPsHc68qfbQUZd4PR+9eFxTpg5eqEdEns+cQ+QUrMo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf+OfnudDGhs3NGLPMGjAk34vXNTo8Zy3KFa/Of4b4dmZcBuPA
	ICKSKb6XlM7+DS8v/xkjLjK3m3/nqmSXeKrecEb/MN80teq3NQhrjBtB8LJdgrNkdaQ=
X-Gm-Gg: ASbGncvmPJple2i5fGvrk6uSf2LIdaJqVbql+NRyGEKWeeFH/MNt6S5zPa21gISFMnD
	vIhg14HgUpVHdIh6qmM00KiJysqRNjtvEWL1AjeaE5rnTzUBiPGu0nFkF0tISMx5S2vtoKWrDjH
	m424FTzB9J0rvpklNVuryKYt7EdOrJWFpHbYlPG8cTThd4QFKXSJgV4xErcI6wU10X9QC8BBN5G
	BereVW9lI+aih5FOyq3J8QAhyrM2qi03hiuMxkPdfw+7SAKVx7VCakAsGlETCJ0IuWae5VKzHNQ
	tP/Cbwe1DslLF4v0YwIz5/NdZASH09ABKkMzkjsS9k90bdVEYQ0e3mag0Psk8Phs/SlV9bhvrN5
	rnQe/MLJFuyqK0D+mWWHsh9Uz8lef8N14o4rnNI3WvuvepRCiGdiVBZJuNrI5Cu5vkHQl8JBcBG
	3ta5cRoMYRrE0=
X-Google-Smtp-Source: AGHT+IGB+l68nNmN+r0g2875eUAVEOWrNNxT+B1p1QscYHqf8lqIHRGyo9DMLsNHAwQ5NssRAlfp8Q==
X-Received: by 2002:a05:6512:e88:b0:54f:c2ab:c6be with SMTP id 2adb3069b0e04-55a1fd90378mr115569e87.7.1752575269207;
        Tue, 15 Jul 2025 03:27:49 -0700 (PDT)
Received: from [192.168.1.100] (88-112-128-43.elisa-laajakaista.fi. [88.112.128.43])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5593c7bd725sm2259718e87.14.2025.07.15.03.27.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 03:27:48 -0700 (PDT)
Message-ID: <a4ebdf5c-8d4f-4994-afd9-22c8d889fe97@linaro.org>
Date: Tue, 15 Jul 2025 13:27:47 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/15] Add dt-bindings and dtsi changes for CAMSS on
 x1e80100 silicon
Content-Language: ru-RU
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Robert Foss <rfoss@kernel.org>,
 Todor Tomov <todor.too@gmail.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20250711-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v7-0-0bc5da82f526@linaro.org>
 <9361e954-e2c9-41c6-be4c-12b0e4f367f5@linaro.org>
 <ae0a309f-7e52-4d3c-8f26-989f22da5b07@linaro.org>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <ae0a309f-7e52-4d3c-8f26-989f22da5b07@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/15/25 11:48, Bryan O'Donoghue wrote:
> On 15/07/2025 07:53, Vladimir Zapolskiy wrote:
>>>     Finally I believe we should contine to have endpoints go from the
>>> sensor
>>>     to CAMSS not the PHY as CAMSS' CSI decoder is the consumer of the data
>>>     not the PHY.
>>>
>>
>> 1. This is an incorrect assumption, unfortunately it was not discussed
>> previously for whatever reason, good news now it gets a discussion under
>> drivers/phy changeset.
> 
> Perhaps you can explain why ?

It's quite easy, sensors are not connected to CSIDs. Moreover data flows
from any sensor can be processed on any CSID, there is no static hardware
links, which are attempted to be introduced.

This is a similar review:

https://lore.kernel.org/all/427548c0-b0e3-4462-a15e-bd7843f00c7f@oss.qualcomm.com/

> Taking the example of other setups similar to CAMSS I believe as laid
> out above we should have
> 
> - Dedicated CSIPHY nodes

I see no problem here.

> - Use the upstream PHY API

I see no problem here as well.

> I believe individual CSIPHY nodes and endpoints from sensor to CSID are
> more consistent with established upstream schema.
> 
>> 2. The whole new changes for legacy/new CSIPHY support is not present
>> in v1-v6 of this changeset, it just appears out of nowhere in the v7,
>> and since it is broken it should be removed from v8 expectedly.
> Broken how though ?
> 
>> It's a pity to realize that instead of providing any review comments
>> for the CSIPHY support series sent to you one month ago a lot of time
>> is wastefully burnt on a broken by design change development.
> 
> I've been working on this on-and-off since the end of April:
> Link:
> https://lore.kernel.org/linux-media/c5cf0155-f839-4db9-b865-d39b56bb1e0a@linaro.org
> 
> The length of time isn't a good argument to apply a patch but, of course
> its annoying.

My experienced frustration is that I didn't get a maintainer's response
for more than one month:

https://lore.kernel.org/all/20250612011531.2923701-1-vladimir.zapolskiy@linaro.org/

> The rationale here is:
> 

A stitch in time saves nine.

You may start now a technical discussion right on the series above, then
I will make my best to fix any issues and send v2 following the regular
development process.

-- 
Best wishes,
Vladimir

