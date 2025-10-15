Return-Path: <linux-kernel+bounces-855221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA04BE08C7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 21:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AF9A3506901
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C037304BCD;
	Wed, 15 Oct 2025 19:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ObYaBkA0"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAE920E00B
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 19:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760557959; cv=none; b=mW+GEckc9IRgJ3pk1Vu7PlLH4yrvluOSUAVMaSxcL9LIwEbpTGtizvycWlLfU6nt68P9ygcmQl6yC3CIrUq3UMGFy3lLtKtgNbpntXhPvtWHp0jnkJBa/SFY5thnv4kis8do9i2+fK+buHFc4GnXPsKU8GLA6DunYxSBKajC8/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760557959; c=relaxed/simple;
	bh=af8Xe6TRc+JzmwAuvgEbc4JHLFA1oiSBVP44j7jh3EU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jTF6X9Cev3ZrOGKR5uT33qGsLuUv0BKeXYWmI7ILFfVl+rbkU32+OiF/qCGSnsWdf8Ubv0LoujC0vHR557zrCjCDFRwaVeO4luaoKUnvkMtlyAq7+4EupEVGS4bmw0J3aWettG4xS7mj9bq316d9ZUm/vjIrmpTyuEn+eYwyWrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ObYaBkA0; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46b303f7469so48565935e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 12:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760557956; x=1761162756; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9GS1idVixeI5e2i+7QHqAFbRFPE0KaUN0lsPmnrv+9w=;
        b=ObYaBkA01lQyxQhQ8kKSQS/RPGNqcvyHVTldqN5eRNylfz7gCGR5SvaQoP/MB4iNVT
         3DchSRkM+24PNgUiYDUXTMT/dNu9OEwYdp3YbvMvEtQad0m4DRNZ3PZZbl3z//pLOWSw
         kjfknvKRcAs40ttBipcx0cvgoj1ZQ/0Yd4fPYEn2+XLSettgAgu7H9aagLhvuIavhXb9
         U+6Uxv9GLmntVcWFMCsZDezMt6fqklBHMw5dEBa6+G6SG7LBEIqh0lrp6qqexrUGLzMY
         9P7CRhdbq+Q4XA+0KtpcOy5MrztJB//q8ay1nAAPwNgHAuzxeMfAEWchvccMoKrOVQR0
         h3HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760557956; x=1761162756;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9GS1idVixeI5e2i+7QHqAFbRFPE0KaUN0lsPmnrv+9w=;
        b=aSxVsxpeaD8mhv9bpDDImk/TrT2Dspb8t/uKLACaBSb+H6g85xSU55CX1Rx8mFJKQy
         5a0FAIetxuj7F/l3LG2huSPt8k3ZFveHaVSbmOadpryHRrM8JAuIPse+W39mGIxgTupF
         wJHj8OPUPIaHSHIKFqMov6UzUHu2Wvrw4a66twQH3xslgbp2H5qTvUPLAJZi3Fi3aW46
         NqGyx0vaeyJZltuhPBYJlx8Z0LY/aMz0uAH5tTabyXPpZ5TiQhEDa7M6j84slvOZn2h1
         0/ArUwVajiXIMnczb1cOLAip+VQqZiMW7ja42TGXj73g+6MhDEGs0CuDOHirByaeJL05
         pJcw==
X-Forwarded-Encrypted: i=1; AJvYcCXs8r2BovxYTxTpa05gqD34Y3ocJQGC45m8NGN0xd3yoXzbmZj9wxg0+u6VmHF0xcG3snlVGD+U7UCVyPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXq9S0QcMAxftk+XaIpp4h38ukq327B3WkhXo3uAtUdOYjD1ZY
	BAhifqB0nizgjZgeoJcMOBY6D31kdioE8HCeS1sYpxPLlxmFkoasoA8c4GlmkFWiBYA=
X-Gm-Gg: ASbGncteRTcJM6OMEHKIWqiZo0ZaEaIyzSs0UQh/ot2y5LuhSAtEV7Pq4PGakzaq2Xz
	BIDDsG5G0eBvZlFz0N4PAhm3rkPcehd9D1qV4cNzS+aBCWDq4fuvpdNDj4CW/eSyR/8Mqj0SrlM
	ugbWkQLvm2f6cyRa6skZp13leO9XQjWD4o2tGQ1Z9C+L3wmVh/6xZf6hayUAsSOmyf+4BqHGSRB
	QfQyoZVpDAivqlUsueLTJ/KUmlEPlQ/U/7AnCR/yA90zCBEU9CuUjLht1k1REbc6wOtaiqQLIpv
	TbULOyyxIU8vmzgk6nRuIGt7JpqB+gXEsrmnt/fA3r/xeTjsI+jtAAYUO2BZQnQIWUYpIVInWkA
	8gBWYvhP16hN/B+HR465ouNs0ANIYS8PevjPlaLS+wy35d43D0gil6oj57/U1k6GRSlse5Lkrvx
	qtHG7BrqgdwN5KJzmHXBtfDx6bi2MWWOdBbjp+4/OeNztNTVPguSxCIa/gGrzVb4VZeqs=
X-Google-Smtp-Source: AGHT+IGkZ6+GeFJQTzXCmHptwwr4bo+TRjYBptncrFFbipQ1Aojn7DOqu6C8j1sCaiyxrTrPkDJUeQ==
X-Received: by 2002:a05:600c:a4a:b0:471:672:3486 with SMTP id 5b1f17b1804b1-471067234b4mr23258485e9.15.1760557956297;
        Wed, 15 Oct 2025 12:52:36 -0700 (PDT)
Received: from [192.168.0.19] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47101c2359fsm48647285e9.11.2025.10.15.12.52.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Oct 2025 12:52:35 -0700 (PDT)
Message-ID: <aae11951-35c2-48f8-b919-e32393279c79@linaro.org>
Date: Wed, 15 Oct 2025 20:52:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: qcom: camss: Use a macro to specify the initial
 buffer count
To: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>, Robert Foss
 <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Todor Tomov <todor.too@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org
References: <20251014-use-marco-to-denote-image-buffer-number-v1-1-f782e4cc622d@oss.qualcomm.com>
 <62da6efb-24d0-4a6b-9a52-c8f981f09d30@linaro.org>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <62da6efb-24d0-4a6b-9a52-c8f981f09d30@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/10/2025 20:22, Vladimir Zapolskiy wrote:
> On 10/15/25 05:42, Hangxiang Ma wrote:
>> Replace the hardcoded buffer count value with a macro to enable
>> operating on these buffers elsewhere in the CAMSS driver based on this
>> count. Some of the hardware architectures require deferring the AUP and
>> REG update until after the CSID configuration and this macro is expected
>> to be useful in such scenarios.
>>
>> Signed-off-by: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
>> ---
>> This change use a global macro to specify the initial buffer count. It
>> meets the requirement that some hardware architectures need to defer the
>> AUP and REG update to CSID configuration stage.
> 
> Both the commit message and the explanation above brings no clarity on
> the necessity of this change at all.

I don't agree. Removing a hard-coded value for a define is an obviously 
correct change.

> This is a dangling useless commit, if you'd like to connect it to
> something meaningful, please include it into a series.

No. It is fine as is.

---
bod

