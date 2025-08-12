Return-Path: <linux-kernel+bounces-765219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F96B22CF5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 18:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27A2D68019E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 16:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64EDE286D6F;
	Tue, 12 Aug 2025 16:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JQ52cMjo"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CA2305E0D
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 16:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755014926; cv=none; b=ShdnqeZPIItY7orAkuQIy0BvGxrA0pzu26rxrmo+QXuYUEILPZqUnBdFSUrxKIAZWpG/AWgBFb0F3pmi/NLN54mBJneOsDRg15Pc3H/ZbLC1Pnpy7HgfBon8FTC9D5pj1dzVI/raKbTFR8HayUxgATeFY/weZ5KBLJT3GRe2rU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755014926; c=relaxed/simple;
	bh=FpIvkzJnxRWf+RK44t2QTwvE47J9fQgcxUAuyJ4Zm3w=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=NHK4W/QHtHqmE4DmsRKIBNQJ1NIIUESrlMv+PZ4ZNlnGtzCcdO0i8LPNc+d6xzlkhH6QsJnEUSr+Nmd9iw/MKwQ2+VQ9zts9fkV8R2FizxerfEFjGnpWTiquXwipg4ZaM86GCttTMXY5u1kftgURzOkIAd2yV9rS0e3zSICPjmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JQ52cMjo; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-459e1338565so53019305e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 09:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755014922; x=1755619722; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BFSWMsjZodOzDrOuJCoS7BkVLEszHuWpZmYI2ozmnzw=;
        b=JQ52cMjobvIUJUk1wn8S3wSV9N6BnjcpKSP4P+bG3OHlI4nkvsskZIOc9D7i6xpmOE
         4We//eeq8gJlmlTg2HASCEkAizK0YiGVW2ZgJKmtkg/t6hvHJInuxvNBwSfxONDcX9PL
         4aNY5nE84/bCQLOXV4fMv8g53igD+oAvejgbJzBWXPzUoMkPBqtzniRJAQGlz9D3TauF
         QR7g4iSsBl3SYobX9yFAB6Qj0JIpvmcWXRtYfaRPCVzH/pis9D3MU8ebDsb58KjldGLa
         l3qbdD5ZHDz8sJAIdJFzdxT2ZG0nm+60ObmKWEBSl71VRkRSl0zzBP3E28tuviyJ9s3w
         ao8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755014922; x=1755619722;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BFSWMsjZodOzDrOuJCoS7BkVLEszHuWpZmYI2ozmnzw=;
        b=PPE2rDB9/CP8ZwAXN3gapfZcwHlpP7txAXEHRO7WBAPozmowllFuHdLqapbO1vKeur
         h+2vcTT03iGfDkTCqyFPc05L1FPNWBhdGYUr3jgqm2iBk1Di53xMHVx19Wb7BXszhnGE
         AXtEFH9/1HWnnnovHc06vcLnXJVBrvaUwCooZK9okZ4tQ0zZi4rgr/P4T9OgHOSbSi4z
         koSM1RCMKOOoPsCu6KMejs2K04ZvqvCq/HTDUhHaSoUMo0tYhyER5AAyn/c3/wopAf86
         9CLmiyJjLu4klIk1ZNPtVbthBbnvE2ls212AN5Ki+llUzNREdNdQ5GFxSjRxLeux1OgP
         SQJw==
X-Forwarded-Encrypted: i=1; AJvYcCVsGoSereqRd4FwrUQTX8Sk+2KOtnwtbNS8n31ovqY/EE/C+//7ZYe8kwHFw1Natfimjxzr43gEbq4MexQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSPVzOt0nkO4GZdPmaTLd9V5KOlh2CStyezZ1boZd0VSMnRx/9
	1zTOyd+Dvfneh4vR7DTRv5FSUJijIjPPO7JWjGtmcfqhcFOtU+s6xMxmbiN1OEjbGRE=
X-Gm-Gg: ASbGncu2cl5eVDtmiuC9bEvJdg4UZ4XqTMHe7lSdQuDGWVOnNePjivup/sl0LlyLqF9
	umgVrNPHvmtmv4atuyP5plK1FxJGSTK/lmxAO73yIX2zZD23bZn87TKbLqwoGDzzFg833jSyoZ/
	cI1fE2aem8WW1T3d0HpfQGp8HVI3P1rR9vkqJ1GmaBjF5sK5CXRN33CK3rmaKiumyrXdcSUqRfB
	eGFIQF9RYZrSkutWIK7WESMshsMimW/teHoaRNeuJ6C8mlZaWvR3ehlVWt2Jh568vyWfYRpAOXr
	B5K3l9ecDb7G29EJtX4vUAqkF7eK4pPobJ3pnqzDAbszjMNDOLCHdH2ucrLz1z4mb1gGzIv8FMx
	pwm214fqvJqjyMlCmk2WiC8L8xBE4aoNuMkOY5rF2qHGLan/N58xAEfGtcdE53QwyAlrrnn8S5m
	gD3niq3CKbYA==
X-Google-Smtp-Source: AGHT+IGWhSp2YqDcC+/Jt+aP3cE7/6QMFB+yYZoU2vCD1m9RO2LLMzcUXXdfrtNNkB+uXFFUtvtc/g==
X-Received: by 2002:a05:600c:1c88:b0:456:11cc:360d with SMTP id 5b1f17b1804b1-45a15b17f2amr3800875e9.9.1755014921954;
        Tue, 12 Aug 2025 09:08:41 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:9086:bd36:16a7:1f8b? ([2a01:e0a:3d9:2080:9086:bd36:16a7:1f8b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e5843021sm328553675e9.3.2025.08.12.09.08.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 09:08:41 -0700 (PDT)
Message-ID: <8b8207bf-e841-4033-8356-dffa2c2e2d25@linaro.org>
Date: Tue, 12 Aug 2025 18:08:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 2/2] phy: qcom-mipi-csi2: Add a CSI2 MIPI D-PHY driver
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Bryan O'Donoghue <bod@kernel.org>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-media@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250710-x1e-csi2-phy-v1-0-74acbb5b162b@linaro.org>
 <20250710-x1e-csi2-phy-v1-2-74acbb5b162b@linaro.org>
 <d7949778-73c4-4575-8db3-a3724f75eb38@linaro.org>
 <16e4883a-a056-46c3-a7c7-a87ff5da89a1@linaro.org>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <16e4883a-a056-46c3-a7c7-a87ff5da89a1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/08/2025 17:05, Bryan O'Donoghue wrote:
> On 12/08/2025 14:39, neil.armstrong@linaro.org wrote:
>>> +    .clk_freq = {
>>> +        zero,
>>
>> It seems clang doesn't like this at all:
>> drivers/phy/qualcomm/phy-qcom-mipi-csi2-3ph-dphy.c:486:3: error: initializer element is not a compile-time constant
>>                  zero,
>>                  ^~~~
>> 1 error generated.
> 
> Weirdly I compile with clang..

The tuxmake log is available at https://storage.tuxsuite.com/public/linaro/neil.armstrong/builds/31Boss31K6meeYAxqhJUZo8yhwK/build.log

It uses clang-16

Neil

> 
> thx though
> 
> ---
> bod


