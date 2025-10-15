Return-Path: <linux-kernel+bounces-855312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F263BE0D90
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 23:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04980546778
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 21:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731A12D4B7F;
	Wed, 15 Oct 2025 21:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CNcsUy3O"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A9F3016E7
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 21:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760564613; cv=none; b=W1t522QhiHks1qYgEslSq6W+8j+PMlnTLarqQstS0Cb+uMoioaOqlOEnbBuSldTet1w2iayBy90YfbjBdj+VEZmtz6Eg4nsPvElgXs4At0aVso28tCPJTirseFbV36lT8BpqknEJTj2wD56CurN1hqra9br0XdK9tNzNnUpZHC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760564613; c=relaxed/simple;
	bh=AoGR0N/WRa1KwSM19W6VN8WXSjWSD6KuRKpcEKai8Iw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LpMm/T/NCE3CDVW3niw4EiLA2FjFCe1v6jYl6UMcpvo63d2WlYOQKaKQwOv6/8P/ExYn5UceifwXlZEk51R89PMprEQcvSFRSyK9pcwzLIrjwPcvm6cjoCg2CItQ9tOZww/CW4SJg1HiEueAiabZuNW7+KdsFhKD9l1Qx/6Se3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CNcsUy3O; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3ee15b5435bso55876f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 14:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760564610; x=1761169410; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zDF8d+4H3i2iv4u1yiFtrqUVQxc1Kn/G01hl0muKOgA=;
        b=CNcsUy3Ol7xzE8L++OkzH05UyK7SGRYPqrU4282wKBhBI2fRgEKGcNutEjSlc91KE6
         Q0uCV9hE6bWYje+NKSLt8Ny6rZDc+Ac4QySGlPCVaW1H4TafOzVzSH7yQIA9jbP3UpkV
         Ufi5NZHL0Xv15ZRW2U8ePR1KPv8NmAuii7OVA9MavsQdRi5WvY0xU2t0dI9w6a4xSac0
         s6NAay1hscAH8ibWpbug2wyG9Ox0EX4Y2+IC6f9n/MKAUWSOqOzjd27vZXnrqGXrmxpD
         lm9IS0ZEYwqVXpqv3LNU0AAsWtfYQwR2yJAz3nVjFbM1i15QRAOUmxDssITWIVR6krEm
         igjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760564610; x=1761169410;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zDF8d+4H3i2iv4u1yiFtrqUVQxc1Kn/G01hl0muKOgA=;
        b=nir/INqFYEnnSMJmgnPMuADDTXWzOB2Q00zFpNuAPBlJwbbrPoa5NSwmSg5pyT7sAd
         1YfImxU0nMOyE/+1bDDQHQb6IOe2Nfa45+gLL3EhSA1LOE+yRoYqSNJSVfoVLEa22zSk
         5ww8zWbmZzahFCGHWRd1/j+DmyhESZ1KYesdMF4Hmd4jICXJEqswRTzdnq7aMqEms77j
         8rpYltHVtiW+Zy/+cYNDMZ11zeHhJzFktQolkGwsrzjzcbj20Lr2qTCN43DLjJc/NVUV
         72YhNFkiGjoMjzF9xLo25vVQw0LEEw069XaQgKm6XdNsZy8iMk19JYB9N0SRHT8D/5Y7
         NesA==
X-Forwarded-Encrypted: i=1; AJvYcCUbdBGKyQPEFuEqV60jJy+Nwt18xDt1xYO8+qLPc8903Pj8r/hPplWh+qgGLIrIwNArmcMEYcy8KC4usU4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAK4aIwXaXkvM82uIGRsszwsHR6lkkATC6lQqMX2PAfqHWPHMS
	z2zgOyeVIzu+ArYDxmZBL0ZS+ogxbSzenNZj0o7xB7fEaxbg/44lxv9JR+DEawPglz0=
X-Gm-Gg: ASbGncs6DfUwULVCtLta/mzjypKjwf50H8WXtKCEWilBOQcHDxz93O+YZkTngp9UGox
	ifQNc7JBpVdd9rrwKYGAY8CtUE9K1kBc3bcOBhgWCnCgzAytfEbHP9mswcZxR3PTG/xJ1tj30Oo
	Jtd+PhWm/E9rNVD+Ys1381P6glUTlfE+K3kvf1mKdKPWCLyAugWlXx3z70FuYzNvc0e3FI+lfvq
	w09Gyhfy3leSOaVZnrfYcWYj/2vS8voRZOvYYFeXvS4o5X0RWW1HH5ZKxOPQr5gsuG3/xtwKWZo
	eDGL9p3DrU+zkYFcgJV9uu2ueK63F9Vst5Dzg7A4lQP29A7aODU1N/ua2cVpNuK3EttLrkyEzz3
	XiOHcsOaT0M5AbweB+HeoC2cg4hAT+i3F1fsbVdnJTUaD5kQ8DiLbgJUQQWbRClB3g4E5uF4B3t
	uBm1AQg1J8BmdHbXpsxhLRBwvhh/92vD40ysywbmss9caJm4bhswwOdNKd
X-Google-Smtp-Source: AGHT+IGnQKKNQd7/bwUbO/GQuYepHvtuUzlr5o5rKuZYtYUxhm0e4zkPUt4aDvFWg6NhRrSxe6cX1w==
X-Received: by 2002:a05:6000:310a:b0:414:a552:86b1 with SMTP id ffacd0b85a97d-4266e8e48ccmr20004387f8f.63.1760564610303;
        Wed, 15 Oct 2025 14:43:30 -0700 (PDT)
Received: from [192.168.0.19] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426fc54b32dsm1314209f8f.30.2025.10.15.14.43.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Oct 2025 14:43:29 -0700 (PDT)
Message-ID: <0b6c157a-3d8d-4251-a704-31f8369f6a4e@linaro.org>
Date: Wed, 15 Oct 2025 22:43:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] dt-bindings: media: camss: Add
 qcom,kaanapali-camss binding
To: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>, Robert Foss
 <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Todor Tomov <todor.too@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, aiqun.yu@oss.qualcomm.com,
 tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
 yijie.yang@oss.qualcomm.com, Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
 Atiya Kailany <atiya.kailany@oss.qualcomm.com>
References: <20251014-add-support-for-camss-on-kaanapali-v2-0-f5745ba2dff9@oss.qualcomm.com>
 <20251014-add-support-for-camss-on-kaanapali-v2-2-f5745ba2dff9@oss.qualcomm.com>
 <dce1018c-6165-407c-8f3d-40859cb36b11@linaro.org>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <dce1018c-6165-407c-8f3d-40859cb36b11@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15/10/2025 20:45, Vladimir Zapolskiy wrote:
>> +  power-domains:
>> +    items:
>> +      - description:
>> +          TFE0 GDSC - Thin Front End, Global Distributed Switch 
>> Controller.
>> +      - description:
>> +          TFE1 GDSC - Thin Front End, Global Distributed Switch 
>> Controller.
>> +      - description:
>> +          TFE2 GDSC - Thin Front End, Global Distributed Switch 
>> Controller.
>> +      - description:
>> +          Titan GDSC - Titan ISP Block Global Distributed Switch 
>> Controller.
>> +
>> +  power-domain-names:
>> +    items:
>> +      - const: tfe0
>> +      - const: tfe1
>> +      - const: tfe2
> 
> Please remove all 'tfeX' power domains, they are not going to be utilized
> any time soon.
> 
> When 'power-domains' list is just a single Titan GDSC, 'power-domain-names'
> property is not needed.

Each one of these TFEs powers an individually power-collapsible TFEs.

This is also so with the other xFE power-domains on previous SoC 
generations.

You'll need the TFEx power-domain to process any data on TFEx with the 
'lite' versions being tied to the TOP GDSC.

So please keep the power-domain list, TOP isn't enough.

---
bod

