Return-Path: <linux-kernel+bounces-839900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D26BB2AFF
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 09:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72CA77B315B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 07:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E222C159A;
	Thu,  2 Oct 2025 07:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZQtsbTz/"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EA333F6
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 07:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759390013; cv=none; b=jnQkbxdjz7Fk0ZVeu03EzyjAhIfzbQqWxMiVu140o7LpTHWG3W+fPfAaql3pj2MAywlzHkateptyqmrCh2G8runX72dqd/5Vep4FGoNPlvw/HInvLySW7QAMLsfFE3osRp02w8xRGr+vEcfho8DKBnoysR1wcOS5LCy6nNDQ0oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759390013; c=relaxed/simple;
	bh=sG9fmz4Dxc0mqGKBEzFBPKIgWUeLcb/MhceTWoMOVg0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=i7qlp7MjZQmapZAVN2An98DUI+Dip0rLEYtNo4TUHl3WUG3fS7HE7go5A/3hFFxisHR4otMXRIaJOQN0ACf8z3+5HbYESuYyuCRSt4qDO0RH6cJO8+Qr+QQX9yhHjvEhqLBVYB6roozw+0hR2yLq+9nv7ur1x8l10PoPoP5PK6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZQtsbTz/; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3fa528f127fso439914f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 00:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759390009; x=1759994809; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OgFAvhDVaoxAtr2iADn6RVzu91lOh6v/w6Asw54CiCk=;
        b=ZQtsbTz/XZUc1Qodd+GnhoF35FEumJbJZCSc9MlqQsn/crv7sDumY6qTvZp8sSpUMN
         b2KyankVWtUlgkEmzY/aRPP9W7cmfc2tGZwGN2OaMdup9I21sYa8UAFyPTRxjHjF1e2K
         GW1K9m0EdFzPXRsIaImFhx7FLNpVUR7vHsqddLE7DQoMXGk+lgDyYUhB9yYb27uxrjTy
         cxEpHIW+p5MP2+uG03x/f3a61crKLhCb9RmQbQBYD3jPSLSpLcsRKMDivRWX+gNBZCPF
         rZxZ5YmW9Yxh5s3bX0u3e+qKm53V1zQpWJsiAcI/PMOnO7/6l8UdqGa5MRIrlwGrgETw
         gbcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759390009; x=1759994809;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OgFAvhDVaoxAtr2iADn6RVzu91lOh6v/w6Asw54CiCk=;
        b=ZNIAMeuX7OKFHyMW9VhgzuXls6Pox4B5BjUIal0K3SFJimphuQLu2CbRk0ivjbJGme
         q5Ip0tlieDE/YCx03i2Cm6BgHzoiSmlr7ESYtMrpu6c2MxWMJDzMoSwZhqPuXpLeJuXq
         wTkW5h4VVQigrDVMpR8GNfjkt77rLjjD62bPY4mDDbn2uhrErKe5eXxMQvHKjfESPh5u
         qVr4qb4GVi1ZrQT6kZUw9cakz0cR2tN6ds8RuG9PMstUmHXEKivDDU6pbmYTxG0JtOwM
         xGz5QWKxqWxkpcAAkXvjbzhqdVH1DtVeWAnjG+kvKSu9lqZoHFq9ENmGusWZLJ5/xM8a
         MraA==
X-Forwarded-Encrypted: i=1; AJvYcCUlKf6RSF5XoZ4OiVfbfrlqIOeN30UrgXo0t5+sXgHAauvri7FcSn9VMORjItSX/ywbk5wrabk76M3LPQw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRqXeaGSxHwWN6lremiMfI8fTzdIJJEOkMOkF5UhKD7IabyGfb
	k7KvABqy/xLH7mB4V7JWKiwCeB/sjwAEiQmRlr+SVW1oOuGzUUK+dni7gdyz7dHnAWM=
X-Gm-Gg: ASbGnctIVqhYFYumahwnoi1YtbMDXWImWbPy3OmAmGLfgfjmhIGwWqbEp6Rz6wRGWWu
	7xSnu9fh64OVxiCY1yeJg0TT6kxIcv/+bivzoXzSxkwxquIouLziJ/4Mih+doJk5LHHTfnUi7sl
	yZXWWTGe2TKyanBqlIjWYczkvZSLvO9AIBttrTRXARN44cFMVQjirporsd3GMps3n34gnZHThNL
	sa8S5lExNPdfG9v1zzFoJ9hHwBddM1FkK7XSNvQnzplT3n3/Uq5wRY08MkNi4lDN0BUeEgcdQbN
	AbOxumbhm8p3+zwUj7AntB9pDhnBiGkw9CGCrwo4TiS8M68Xm2/j2AaNdPzljt/mtv6rm4Uetj5
	O+0EzPozzXQvPM+ztuFrYH3ECBtejiqT8D0+rJqB3DxEWk2rf6yE6Zl92DFZ7mHEY8I3jQcCY3V
	UhdcyQ56qTFhbZo1pXJkN05vMtep8QdCRVmVPDJw==
X-Google-Smtp-Source: AGHT+IFteDch3BVt0bDc3AgrulJS8q/xxMOCOQx7fQ+JlPLxSOHm9OmUPhVp7LLdzvzStKCXdc/FyA==
X-Received: by 2002:a05:6000:144f:b0:403:8633:b7e3 with SMTP id ffacd0b85a97d-4255d2b744cmr1489346f8f.30.1759390008988;
        Thu, 02 Oct 2025 00:26:48 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:9092:34c0:f6b9:8584? ([2a01:e0a:3d9:2080:9092:34c0:f6b9:8584])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8ab8fdsm2374781f8f.15.2025.10.02.00.26.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 00:26:48 -0700 (PDT)
Message-ID: <58d5f774-f0a5-419b-bea6-118cb98c944e@linaro.org>
Date: Thu, 2 Oct 2025 09:26:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] dt-bindings: phy: qcom,sc8280xp-qmp-usb43dp: do not
 reference whole usb-switch.yaml
To: Rob Herring <robh@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250902-topic-sm8x50-fix-qmp-usb43dp-usb-switch-v1-1-5b4a51c8c5a8@linaro.org>
 <20250905175533.GA1000951-robh@kernel.org>
 <nwtt76n4t7tlf26ex47wrot7g7nldtmavbzgwmluls3egamjsi@mkomopb6fjh6>
 <20251001163139.GA1877961-robh@kernel.org>
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
In-Reply-To: <20251001163139.GA1877961-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/1/25 18:31, Rob Herring wrote:
> On Tue, Sep 30, 2025 at 10:10:25PM +0300, Dmitry Baryshkov wrote:
>> On Fri, Sep 05, 2025 at 12:55:33PM -0500, Rob Herring wrote:
>>> On Tue, Sep 02, 2025 at 06:10:05PM +0200, Neil Armstrong wrote:
>>>> Both bindings describe a different layout of the ports properties,
>>>> leading to errors when validating DT using this PHY bindings as
>>>> reported by Rob Herring.
>>>>
>>>> Reported-by: Rob Herring <robh@kernel.org>
>>>> Closes: https://lore.kernel.org/all/175462129176.394940.16810637795278334342.robh@kernel.org/
>>>> Fixes: 3bad7fe22796 ("dt-bindings: phy: qcom,sc8280xp-qmp-usb43dp: Reference usb-switch.yaml to allow mode-switch")
>>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>>> ---
>>>>   .../devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml    | 8 +++++---
>>>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
>>>> index c8bc512df08b5694c8599f475de78679a4438449..5005514d7c3a1e4a8893883497fd204bc04e12be 100644
>>>> --- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
>>>> +++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
>>>> @@ -73,8 +73,11 @@ properties:
>>>>       description:
>>>>         See include/dt-bindings/phy/phy-qcom-qmp.h
>>>>   
>>>> -  mode-switch: true
>>>> -  orientation-switch: true
>>>> +  mode-switch:
>>>> +    $ref: /schemas/usb/usb-switch.yaml#properties/mode-switch
>>>> +
>>>> +  orientation-switch:
>>>> +    $ref: /schemas/usb/usb-switch.yaml#properties/orientation-switch
> 
> Looking at this again, this isn't even correct and I don't think it
> works. It's missing a '/' and  should be ...#/properties/... to be a
> valid json pointer.
> 
> I thought we checked this...
> 
>>>
>>> This is a pattern we try to avoid with references at a property level. I
>>> prefer you make port and ports not required in usb-switch.yaml.
>>
>> But this solution is also not perfect. E.g.
>> Documentation/devicetree/bindings/phy/fsl,imx8mq-usb-phy.yaml should
>> only allow the orienttion-switch property, while using
>> allOf:$ref:usb-switch.yaml allows all three (orientation-switch,
>> mode-switch, retimer-switch).
> 
> That can be handled like this:
> 
> $ref: usb-switch.yaml
> properties:
>    orientation-switch: true
> additionalProperties: false
> 
> Though if you need unevaluatedProperties for some other reason, then
> that won't enforce it and it's just documentation. In that case, then
> perhaps usb-switch.yaml is not the right granularity and should be split
> up.

I did a split up at:
https://lore.kernel.org/all/20250930-topic-sm8x50-fix-qmp-usb43dp-usb-switch-v1-1-060568de9538@linaro.org/

> 
> I put this into the category of "this is the least of our problems". I'm
> not that interested in enforcing what common properties a device uses or
> not. It's undocumented properties I'm worried about or lack of
> constraints (on reg, clocks, interrupts, etc.).

Thanks for the comment, I'll have a look if this would work.

Thanks,
Neil

> 
> Rob


