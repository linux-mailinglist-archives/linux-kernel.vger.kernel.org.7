Return-Path: <linux-kernel+bounces-838062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFEABAE580
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 20:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93E191925F07
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 18:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47BE3228CBC;
	Tue, 30 Sep 2025 18:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lXbcCMZk"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9318287E
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 18:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759258099; cv=none; b=GEEIawhTTl7v8tHpgXcNENF2rqVWd1iVMqbRwKXZ9VE8UXah57p7WQypp271vGbtVnIOaxlV1Ys5mgFASHrWgrYKUPCpn11wpeZzn/rO72fm1QhT4Y/KVgg+lT7gF+lBY0Cw5JH5pyL3JVDiyMqoq7GJLZjY7jZbYT5zRM50SAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759258099; c=relaxed/simple;
	bh=AkSZ2p2ipyMcwGlPDAvkNQcfgzKLfIjz9ybYo7uFpDY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=cJzIJIPqgNusvTyAMA8DH7Qi1KWyW+ee49GgwGr/FKwsXqGbXHK6blQnhMKuHyos6UHTfVh53kZGLXhZ0bhC3OdGRx2h6/2HqW0ey0TthZwHoqYMdSVTGb1j+wmjID8j7M6iENiGfSMYxOkVp1UCamZcgyOalF1CS5496SwL0pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lXbcCMZk; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-46e5980471eso9506365e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 11:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759258096; x=1759862896; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ffgRfYtnm1HKc4tZUZavEotYf7CHOSNEIdJwn2PiGvQ=;
        b=lXbcCMZknREsrO0Mtv0yPYP13BJVVZ2gkmpfkDKw6p1ZzRMiivZOqT09U4l28iNtxU
         3iKpihgtEh4t3amIpA6sefYQe4qyPpsEonzquIoeSVXlkHyvp2hSLg9MiT20De8d5rw/
         1l0ca3tj/lrZb29j0KYyElE0vBbucFWTt74e8ByCdG+JdRHArWmqOlrqE6RytaC3zfhD
         GNmZezOs4Olu61uBpdonmVG2c/PCm3walosz2XHfaGw7nHI0z6Lib4yc+TuERuTAd4py
         QeVFk73u5ro48O3P4WWo7uG7X6o1NR0Z6I0RY0v83MMNsrcQRl5NzlAv4e2tjK/fXo4x
         bglA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759258096; x=1759862896;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ffgRfYtnm1HKc4tZUZavEotYf7CHOSNEIdJwn2PiGvQ=;
        b=CtljYeQ9rJJDyqQDJ+O8bXA95MXNbp6qbRPvuk6JN3beUC04PYPWnCb3LJT5N89GKM
         sutZHdcuei3WurTQpEh5keJWf95Dinyls4Hh66dNVlqb8t+cRfup6sNAyif6lr969oBX
         jVgevOp9knokcsYPe3jqAWUFwF4fk1zCTrEgnne+ath8Tymo2lhPwouI1jO6LITqAzl+
         KNLq4sig4+FfpbPRQQmSX2Cn3G+SjtC3aYw4+Nm93rc1jl7C8oTQyxlFnZCJBQCGcdv7
         ZuB/+cD8jDLkc8eoOvoVQdlkAgkcKsbhwpvcRTkz98NrYvMMkSvFG90nNedo2fQ6Ff97
         ZCAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMwZ5s5NP34cOOd9xmQ412vT+BRwHPILDablK7Q9L7nUvIRjrQk3KQ0YqHww7Oxg0CDuWo/nk3+VobT18=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDM1+TWPosffyjriBKMm5df/NDqCcSXJEE9NZ0dkWQH7mv1AOE
	JHOR/c12tyL9c0ZCv+ekq19/QXpY4Igb4T7YNXvKN6rQzc96c3MdRlZ5D16lAIoDCgY=
X-Gm-Gg: ASbGncvhFPFkD70vqy9toATdbin3iONtwvxhHc5vj4vCzqDGjOJJ9SL664I9aI12ZOu
	DDJTv9N89t+d7iMm3BVnhrM4fIAUc5n1hYeJrRUVVMrs6YUHca6hsFr+xb5RCaj8lCyuZh/4dIb
	DiHug3+wmSZd2rDVinPF7kqlEddFSOgrool7cf5saDW4Gxxdu8W/SYVGAJjk+QpHfX32s3t8ORP
	ZmxwBqYz4uXuBeESe6o1xnhDDkAdoDgLQ9mKlRSFuBFWdZ2HgCJ9DS+aZUsOEMZbB7iLg0VdTt/
	BLFT26cSbaB24TygPHWBZ0s/iWWXqT9VM5bY8zI2PyyEdX+Iq2VKr3zv6MAo7REJUlF9Xh4jHfm
	n9j0CvQD85bHzEejJZIz2ZDL2x2ColojJC7yFlwC7L2vO/FLhM73XULPbDxSMhCcBt7jnriHzOj
	IiyH8neRGz0mqbagqGCc6c/4A=
X-Google-Smtp-Source: AGHT+IEYI3huopKWdfDQEJir5e/rv3rOBRHS1Emu0fC6ieyMwwYyTSg13GLpRz3qoAuTqhlVIXzV/Q==
X-Received: by 2002:a05:600c:5303:b0:46e:4287:a85e with SMTP id 5b1f17b1804b1-46e612192ecmr7706325e9.13.1759258095988;
        Tue, 30 Sep 2025 11:48:15 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:9459:14e0:525e:d859? ([2a01:e0a:3d9:2080:9459:14e0:525e:d859])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e6199fb54sm5013245e9.9.2025.09.30.11.48.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 11:48:15 -0700 (PDT)
Message-ID: <426679ae-03c4-47d5-895d-7c927b2c3b07@linaro.org>
Date: Tue, 30 Sep 2025 20:48:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] dt-bindings: usb: switch: split out ports definition
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Romain Gantois <romain.gantois@bootlin.com>, Li Jun <jun.li@nxp.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Bjorn Andersson <andersson@kernel.org>, Luca Weiss
 <luca.weiss@fairphone.com>, Abel Vesa <abel.vesa@linaro.org>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20250930-topic-sm8x50-fix-qmp-usb43dp-usb-switch-v1-1-060568de9538@linaro.org>
 <vwlshz5li23xlthn5delxwxdsdci5nc22iey3xih4qf5uhbory@clskdsy64xpx>
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
In-Reply-To: <vwlshz5li23xlthn5delxwxdsdci5nc22iey3xih4qf5uhbory@clskdsy64xpx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/30/25 20:43, Dmitry Baryshkov wrote:
> On Tue, Sep 30, 2025 at 07:17:21PM +0200, Neil Armstrong wrote:
>> The ports definition currently defined in the usb-switch.yaml
>> fits standards devices which are either recipient of altmode
>> muxing and orientation switching events or an element of the
>> USB Super Speed data lanes.
>>
>> This doesn't necessarely fit combo PHYs like the Qualcomm
>> USB3/DP Combo which has a different ports representation.
>>
>> Move the ports definition to a separate usb-switch-ports.yaml
>> and reference it next to the usb-switch.yaml, except for
>> the Qualcomm USB3/DP Combo PHY bindings.
> 
> Isn't it easier to make QMP PHY use $ref for port nodes instead of allOf
> and keep ports definitions inside the usb-switch schema?

Rob asked to not do that... see https://lore.kernel.org/all/20250905175533.GA1000951-robh@kernel.org/

Neil

> 
>>
>> Reported-by: Rob Herring <robh@kernel.org>
>> Closes: https://lore.kernel.org/all/175462129176.394940.16810637795278334342.robh@kernel.org/
>> Fixes: 3bad7fe22796 ("dt-bindings: phy: qcom,sc8280xp-qmp-usb43dp: Reference usb-switch.yaml to allow mode-switch")
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   .../bindings/phy/fsl,imx8mq-usb-phy.yaml           |  4 +-
>>   .../bindings/phy/samsung,usb3-drd-phy.yaml         |  4 +-
>>   .../devicetree/bindings/usb/fcs,fsa4480.yaml       |  1 +
>>   .../devicetree/bindings/usb/gpio-sbu-mux.yaml      |  1 +
>>   .../devicetree/bindings/usb/nxp,ptn36502.yaml      |  1 +
>>   .../devicetree/bindings/usb/onnn,nb7vpq904m.yaml   |  1 +
>>   .../devicetree/bindings/usb/parade,ps8830.yaml     |  1 +
>>   .../bindings/usb/qcom,wcd939x-usbss.yaml           |  1 +
>>   .../devicetree/bindings/usb/ti,tusb1046.yaml       |  1 +
>>   .../devicetree/bindings/usb/usb-switch-ports.yaml  | 68 ++++++++++++++++++++++
>>   .../devicetree/bindings/usb/usb-switch.yaml        | 52 -----------------
>>   11 files changed, 81 insertions(+), 54 deletions(-)
>>
> 


