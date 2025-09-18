Return-Path: <linux-kernel+bounces-797920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 938A0B41733
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5870D1899467
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 07:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C8C2DF135;
	Wed,  3 Sep 2025 07:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kz5u3PbT"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85622DE6FC
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 07:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756885797; cv=none; b=GcBEcOXSpc2/l1DSVuznA8Ue1TlHq96eQXZMRtQhxtxscePFbenH5ly+O6qfyaVBGUmRuplx0IBQReRN8NldxeynKr1K8EdpLdrhAytqy5aLV/VVQjbk+KGCy5YvrvS1gR1eGHTCFSd7E7uMiW4GFURfooHzu/Z64cOMxsjZbw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756885797; c=relaxed/simple;
	bh=EJfrYL5HJI0QUtaBffL6WlEbo2xIumV+JPls7FbJoTI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ol75Li+Vi3aw+bIbWVAmfTjP3iVDZyHEt1UtR2hNQWrOGh3fyWBWlVouh9r/yLAKP8KUPCIhZC2zelglLBEBBSPhn0pbZajWSpXjRa5SxzjOoIrsLECPIO381z0wLupcWJofTDAtRxa6TVDhFcc8sbBfOeKWl1/HTxCtecdSm3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Kz5u3PbT; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3df726ecff3so44776f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 00:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756885793; x=1757490593; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PioyJaDS8ksrS/yIYTZans1q2zfR8i6mk/EV1gul67A=;
        b=Kz5u3PbTnXQhIla15B4QrJUgKE/Bq1kyHRsyWJerX6SjoDavyhzSkYNT4/0Eg5DVZG
         jvEpKAgQA3QLS3cYCOGFAnNZ4UYFILGxCREqAJ/XK6dVFFKcWCYrj60aqUB8AXgmnymZ
         vBjEsl6ck9coPHCxJWJ2gwyPkwpqC688+XlJcptZ6ycs+uc1wWiSK07Z9IxzwHBV9b5j
         gMTbxRjCZcReV/u9JI7u8WyxgKtZ16r/tJrBxdt53QlKcezTwLdXx47ucZXdt0YLxDFa
         HTIEnPizgqEzbjxa/LK1LkUqBPfwHfwUvHnfW8vgT7azl4TRbYJaWZBl5g1mQN7C8Dri
         XlQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756885793; x=1757490593;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PioyJaDS8ksrS/yIYTZans1q2zfR8i6mk/EV1gul67A=;
        b=JF1Nvc4zY34FVwG3kC+LORWEa8i8+nNRAch3dDMKqRCcbZ/E4VKM1me1+UtlqhiK1q
         XRJhs55W/MRG6aJ1fsyoi0eP7C5F2ITtACAFRgoZaR67o+xg2xVZBxAQDh+Fo2v9hY0i
         Xuf1HhSqFTQAJ+hCb/DtnEu/v0MPDv45QNAgLeXZtJMilUMFd+orKiw3741YrWm4wdPw
         3sy1NPzjaxmsSsupXBuUk3fwi7b7BcXZEogBe3flxZ1RWPbEN9I/STXAqXFz4UUltdXZ
         4PiBtFuh1zCUkEQ4GLyOiCgHkMdHxkxx8zq+qTC48c+WOqQljj1rpRGjXeFoZbjswu6t
         O/PQ==
X-Forwarded-Encrypted: i=1; AJvYcCUg9WcaSZVqS1lG2kz54cXinjGjovHMGxpuWx1Jy9jLPa9vun7SxMefBshuW8eWzAZRdEzsh1x7Eemt+4M=@vger.kernel.org
X-Gm-Message-State: AOJu0YynRy0uZrWfmhtQaZSqFBPvw7G0cAeArsmNzaPDqV9KXCrhB9wz
	2W4F09jcUX7QpfLZfPjVKL2rbWxbz8BFxWmWVL/sqXRsNg344lGNPreloI7mhkdnUFg=
X-Gm-Gg: ASbGncs8T3tA1CeyDHuJQlhTHO7md0DT/zNrpwwsgDx71//BzNBuEGv0SHERNIpd+W5
	/8aJcG9UaOj6B/6zxmPQAlLykPNwrbCuzKAwBoCOlfZQzUFqXWzuBZA7F49Wl5zJALueqVFCNhn
	VVjT+sDMa4eT17jGNv3h0pJUmHiBQuf7QEQPionm2WueP2QAH2kz3cRx8m6c7ZqGx2IDXSuq5hQ
	ddQ2grdQ1dAmBY76dI7sfDioY/wF86KfpGGOWiSzzdJWXv2CPGCGpCmG6tsicXMn81HDMQ35SFM
	hQwuK9qic2/Qn56goq7u6PCSssVp/0SbBXY5YblB6CHJkIBDJ7tSdp7QIyGY3gT7NRdofS5pZKT
	84v8oXvx6Q7vFayDQUORQdtbv4Pj4JZ5KzZiFECotru36Kp454NwPE+GJyd1SgW99hHVss5jB0j
	aWernkRSRnLmKiwLEIkA==
X-Google-Smtp-Source: AGHT+IGNcwf7dquah88p3kbUCZQzfg4W/YTjPdyhyrclopN+udAN3w1xt+8R2YdXZebjRcfFI3x01g==
X-Received: by 2002:a05:6000:2011:b0:3c9:3f46:70eb with SMTP id ffacd0b85a97d-3d1def69bc3mr8693458f8f.52.1756885793260;
        Wed, 03 Sep 2025 00:49:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:431c:dad5:266c:f97? ([2a01:e0a:3d9:2080:431c:dad5:266c:f97])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b93fae643sm75085675e9.3.2025.09.03.00.49.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 00:49:52 -0700 (PDT)
Message-ID: <418ba924-7e3d-474f-ab1e-084ca8ad313d@linaro.org>
Date: Wed, 3 Sep 2025 09:49:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 3/5] dt-bindings: phy: qcom,sc8280xp-qmp-usb43dp-phy:
 Document static lanes mapping
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org
References: <20250902-topic-x1e80100-hdmi-v2-0-f4ccf0ef79ab@linaro.org>
 <20250902-topic-x1e80100-hdmi-v2-3-f4ccf0ef79ab@linaro.org>
 <20250903-amaranth-rhino-of-wind-3b8850@kuoka>
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
In-Reply-To: <20250903-amaranth-rhino-of-wind-3b8850@kuoka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/09/2025 09:07, Krzysztof Kozlowski wrote:
> On Tue, Sep 02, 2025 at 11:00:30AM +0200, Neil Armstrong wrote:
>> The QMP USB3/DP Combo PHY hosts an USB3 phy and a DP PHY on top
>> of a combo glue to route either lanes to the 4 shared physical lanes.
>>
>> The routing of the lanes can be:
>> - 2 DP + 2 USB3
>> - 4 DP
>> - 2 USB3
>>
>> The layout of the lanes was designed to be mapped and swapped
>> related to the USB-C Power Delivery negociation, so it supports
>> a finite set of mappings inherited by the USB-C Altmode layouts.
>>
>> Nevertheless those QMP Comby PHY can be statically used to
>> drive a DisplayPort connector, DP->HDMI bridge, USB3 A Connector,
>> etc... without an USB-C connector and no PD events.
> 
> What is the use case for static mapping? Embedded HDMI port on T14s
> laptop?
> 
>>
>> Add a property that documents the static lanes mapping to
>> each underlying PHY to allow supporting boards directly
>> connecting USB3 and DisplayPort lanes to the QMP Combo
>> lanes.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   .../phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml         | 29 ++++++++++++++++++++++
>>   1 file changed, 29 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
>> index c8bc512df08b5694c8599f475de78679a4438449..12511a462bc6245e0b82726d053d8605148c5047 100644
>> --- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
>> +++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
>> @@ -76,6 +76,35 @@ properties:
>>     mode-switch: true
>>     orientation-switch: true
>>   
>> +  qcom,static-lanes-mapping:
>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>> +    minItems: 4
>> +    items:
>> +      enum:
>> +        - 0 # Unconnected (PHY_NONE)
>> +        - 4 # USB3 (PHY_TYPE_USB3)
>> +        - 6 # DisplayPort (PHY_TYPE_DP)
>> +    description:
>> +      Describes the static mapping of the Combo PHY lanes, when not used
>> +      a in a Type-C dynamic setup using USB-C PD Events to change the mapping.
>> +      The 4 lanes can either routed to the underlying DP PHY or the USB3 PHY.
>> +      Only 2 of the lanes can be connected to the USB3 PHY, but the 4 lanes can
>> +      be connected to the DP PHY.
>> +      The numbers corresponds to the PHY Type the lanes are connected to.
>> +      The possible combinations are
>> +        <0 0 0 0> when none are connected
>> +        <4 4 0 6> USB3 and DP single lane
>> +        <4 4 6 6> USB3 and DP
>> +        <6 6 4 4> DP and USB3
>> +        <6 0 4 4> DP and USB3 single lane
> 
>> +        <4 4 0 0> USB3 Only
>> +        <0 0 4 4> USB3 Only
> 
> Why do you need to handle here and in few other places mirrored case?
> Isn't enough to just say you only want USB3? Maybe my first question
> (what is usecase for this) answers this, though.

Usecase is larger than the HDMI on the T14s, we must handle boards directly
connected some USB-A and DP stuff directly on the combo lanes.

See https://lore.kernel.org/all/8A7C126C22789C9B+f30def47-302a-45ee-8f76-64ef277f773f@radxa.com/

> 
> This looks similar to rockchip,dp-lane-mux, from the objective point of
> view. Please look there and if it is really similar concept this would
> warrant having it as generic property in video-interfaces for example.

Yes it's quite the same

> 
> I also wonder if this should not be stored in the endpoint.

But I'm trying to store this in the endpoint as [1], the Bindings & DT part looks fine,
but the driver part looks horrible...

I'll probably post an RFC of that shortly

[1] https://lore.kernel.org/all/14f334fc-35de-4f21-8eb1-f6b41ac24704@linaro.org/

Neil

> 
> Best regards,
> Krzysztof
> 


