Return-Path: <linux-kernel+bounces-809603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8240CB50FB9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 09:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 250D817CFC6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 07:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C3A30C35C;
	Wed, 10 Sep 2025 07:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QNUhMG1u"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996212DF3D9
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 07:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757490031; cv=none; b=myfUchBrhZ/iJkeB8XxKifUNqoRuKfFfP8SgojhQ/H/rX2IKxnYTNo/Z509XOeUxfVnWbB1V24AfaM9uAV7othurcLsstK21+1/9K/+qLxOzR+R4XrqAfSD3psxJtTBNwt2JtiVSzVN0nw1JZoxFivaL+4ndES2ZbSy4bGS9oEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757490031; c=relaxed/simple;
	bh=JRAX/XAvWRp8CqyxdYEQByS3AJb2IBdqMsyZRQinqmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pvnH/4d0Rw2iffbHoY0Eqvftq8EUjNzah5+ArdBgmRiEGSZMhNczJbTW4qFIctPbOUoRdVvHXc+SJZmIEW2f5PRUChoDZ4cvqAwe0DhrBXRHBbvh0MiSWjCZeiWrYs+te3/j8jlXSUoXfOjwQZYg4pTAlWBDM0hf+nLNcnOlrgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QNUhMG1u; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3b9edf4cf6cso5395919f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 00:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757490028; x=1758094828; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j3EKGSnBwHuNSIr2tmPSNOH8emkkaIX6JPZtG/ZhSqk=;
        b=QNUhMG1uub6bohe0TGQ+csZPTrKPfJs8ayxl0WauS9BGJA+CNWlwNlaKHeDrDS2TFD
         P40bteiAOErx/Uq/lqH14ZMfHm0AD0jRgV9MVCo9JVWyExSwntXuYwJc7SLVfTyxHwDG
         Od3fFtvZxh4mMa0PbisF03nkcZ3CJ1O9amXfgCRgMzxVBuvaq99+7T3dbzKUPu1wRCbM
         HSZpINjt+gP8p6oiAlgZvod6V+pU+XKoU9jME7tY/PIBFRjy+kAS09TetYjsW1cgC9Ok
         qwZV7P+pk6zzFq0L2dIg8SwVeZbB8v15B04ZrDclIap5/0XrrhTbPM441cLUBEQQvcDX
         OZeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757490028; x=1758094828;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=j3EKGSnBwHuNSIr2tmPSNOH8emkkaIX6JPZtG/ZhSqk=;
        b=i1aSzumlWgugXtay7ZbB8DAQGJhYUneBrIKq+i5qMHrCH0SwBEQrx5bduKKImPLKqa
         Kn0MGvLYFJcoDNQJW9TF1jkrK3SDfX3AtJAXgtfZeHvmYwr4cS0jUCQfQO1we5IfhsEr
         xuuS/Z7toI68X+iO+qpF9cqdw7RT3W7b6SAPAkEWBVXrqPubgylTt9r5uqAhsOEo6pp0
         oLV38QDLv8XaaQFnyx5szmxIJKkzEKk6AuWi4m6UC9yeNTjB1dyej6T2pxHaLt6FOtxz
         krPpYZ32Pvk/NPtXEwO8B6EhaWsTEZqLKb79WaS8PKIZ+KMXrcwxLh1ZqpSZ20hW4wzc
         eUaw==
X-Forwarded-Encrypted: i=1; AJvYcCXlP8CfcSYOKoj5bS+HtL8xBSy+zinUKeTTl89913lF1Tr9t/iBucl5FFkibusLfyyVD5+4vwvv6FPMXj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVNTMTc6NaGd0peNr5YaW51VsyBvGIt+iGg0hn/6htiDnk+Bij
	yoA63+ZyP7+B0A/kEeZ9NLC33yJK7zK75B5kFtpHGAqTchaxEFvLeh8YAyL+vQfqrXo=
X-Gm-Gg: ASbGncs6deU+PCOnv5nrAjkiF+eoQkud0S0PbH4RiGwjFsW3/CjOtx+CK38jYdOB3TC
	kdgAn3Pqj3FRlggGIA8wVZA4v6Cs8G94pZxtn6E6ZqI3jPXYpytuFaN+c8hz4CboL8HGU5+MdA4
	5npdflmeVQ8WrNI3H5WnEgDe0+ylh8HhIoZZnTpH2f5g+ZbMAnMt1cmWwKvx/k2IFpmoiqNjHE+
	854WExp+VqkOCqKh4H00BbSkNL4oFcFKkQqfYzywoTJA61zq0bA2k+CYrjoUXUgRaUmzc1GpFFi
	a1WFS38olzTKmdPWpu5jR7mthkFyYELce5wyUgSFPQgusPV9n7K0SV9YnlrAnSC+4PDXwxv4a8e
	n8Y+l8KfzFvquW18ztKkycTehHEsLL0FSRpK3rlAKice5lZvPfrx1lvzq6LrMeKgKOc52obLS+r
	0=
X-Google-Smtp-Source: AGHT+IH8laMHpoyfQVOQDRqhoJ/JQf0Axz3FnNURrZxQhkLXqA9IdJUrOWmbZDNZE52Izb8qgOZN9Q==
X-Received: by 2002:adf:b1d6:0:b0:3e7:451f:3a6b with SMTP id ffacd0b85a97d-3e7451f3e56mr7984664f8f.42.1757490027811;
        Wed, 10 Sep 2025 00:40:27 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:29d1:7c56:69a9:30b2? ([2a01:e0a:3d9:2080:29d1:7c56:69a9:30b2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e75594a271sm2735771f8f.30.2025.09.10.00.40.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 00:40:27 -0700 (PDT)
Message-ID: <99525a03-4a92-4bd0-b4b7-dfcd35a523c5@linaro.org>
Date: Wed, 10 Sep 2025 09:40:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH RFC 1/2] dt-bindings: phy: rockchip-usbdp: add improved
 ports scheme
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Frank Wang <frank.wang@rock-chips.com>,
 Zhang Yubing <yubing.zhang@rock-chips.com>, Andy Yan <andyshrk@163.com>,
 Maud Spierings <maud_spierings@hotmail.com>, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250904-rock5b-dp-alt-mode-v1-0-23df726b31ce@collabora.com>
 <20250904-rock5b-dp-alt-mode-v1-1-23df726b31ce@collabora.com>
 <aLyKhngeksG2SKdq@umbar.lan>
 <jzooq6qg3y7nee2nz6lujustdf4z7vtn6t2slikw43dann5sbk@2telraae26tl>
 <aLyo4N59o4CIYm-6@umbar.lan>
 <xyya5zy52mx4o76s6rr5h7lrfkhbri6bvmp7a5mn7cifpbpqlc@ca3zhclu6u3y>
From: Neil Armstrong <neil.armstrong@linaro.org>
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
In-Reply-To: <xyya5zy52mx4o76s6rr5h7lrfkhbri6bvmp7a5mn7cifpbpqlc@ca3zhclu6u3y>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/09/2025 01:52, Sebastian Reichel wrote:
> Hi,
> 
> On Sun, Sep 07, 2025 at 12:34:24AM +0300, Dmitry Baryshkov wrote:
>> On Sat, Sep 06, 2025 at 10:42:22PM +0200, Sebastian Reichel wrote:
>>> On Sat, Sep 06, 2025 at 10:24:54PM +0300, Dmitry Baryshkov wrote:
>>>> On Thu, Sep 04, 2025 at 08:26:02PM +0200, Sebastian Reichel wrote:
>>>>> Currently the Rockchip USBDP PHY as a very simply port scheme: It just
>>>>> offers a single port, which is supposed to point towards the connector.
>>>>> Usually with 2 endpoints, one for the USB-C superspeed port and one for
>>>>> the USB-C SBU port.
>>>>>
>>>>> This scheme is not good enough to properly handle DP AltMode, so add
>>>>> a new scheme, which has separate ports for everything. This has been
>>>>> modelled after the Qualcomm QMP USB4-USB3-DP PHY controller binding
>>>>> with a slight difference that there is an additional port for the
>>>>> USB-C SBU port as the Rockchip USB-DP PHY also contains the mux.
>>>>>
>>>>> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
>>>>> ---
>>>>>   .../bindings/phy/phy-rockchip-usbdp.yaml           | 23 ++++++++++++++++++++++
>>>>>   1 file changed, 23 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-usbdp.yaml b/Documentation/devicetree/bindings/phy/phy-rockchip-usbdp.yaml
>>>>> index 8b7059d5b1826fdec5170cf78d6e27f2bd6766bb..f728acf057e4046a4d254ee687af3451f17bcd01 100644
>>>>> --- a/Documentation/devicetree/bindings/phy/phy-rockchip-usbdp.yaml
>>>>> +++ b/Documentation/devicetree/bindings/phy/phy-rockchip-usbdp.yaml
>>>>> @@ -114,6 +114,29 @@ properties:
>>>>>         A port node to link the PHY to a TypeC controller for the purpose of
>>>>>         handling orientation switching.
>>>>>   
>>>>> +  ports:
>>>>> +    $ref: /schemas/graph.yaml#/properties/ports
>>>>> +    properties:
>>>>> +      port@0:
>>>>> +        $ref: /schemas/graph.yaml#/properties/port
>>>>> +        description:
>>>>> +          Output endpoint of the PHY for USB (or DP when configured into 4 lane
>>>>> +          mode), which should point to the superspeed port of a USB connector.
>>>>
>>>> What abourt USB+DP mode, where each one gets 2 lanes?
>>>
>>> Right, I guess we would need one port more and have one port for
>>> lane 0 + 1 and one port for 1 + 2. For USB-C both ports are
>>> connected to the USB-C superspeed port. For DP 4-lane mode the
>>> same is done for the input port of the connector. Last but not
>>> least for 2 lanes USB + 2 lanes DP, one port can be connected
>>> to the USB connector and one port can be connected to the DP
>>> connector.
>>
>> Hmm. I'm not sure what do you mean here. Basically, it should be:
>>
>> - Normal USB-C case with DP AltMode:
>>    + port@0 routed to connector's port@1 (through mux or retimer if any)
>>    + port@4 routed to connector's port@2 (through mux or retimer if any)
>>
>> - Actual DP or mini-DP connector:
>>    + port@0 routed to connector's sole port (most likely direcrly)
>>    + port@4 most likely unconnected (at least for now, dp-connector
>>      doesn't have AUX lines described)
>>
>> - Weird mode of having both USB-A or -C and actual DisplayPort
>>    + port@0 should get two endpoints, each having data-lines properties,
>>      one endpoint being connected to the USB port, another endpoint being
>>      connected to DP connector.
>>    + port@4 unconnected (yep, we should extend DP properties, maybe I'll
>>      send a patch)
> 
> That's a bit different from what I described, but sounds more
> sensible. Effectively the Rockchip USBDP PHY binding would need
> to deprecate rockchip,dp-lane-mux and switch to using data-lines
> on the endpoint instead, just like it is currently proposed for
> Qualcomm (I follow the T14S HDMI thread).
> 
> AFAIK the Rockchip PHY hardware does not support 1-lane DP, so the
> binding will have to forbid that. Shouldn't be a problem, though :)
> 
>> I'd say, the first two options are the most important ones. Unless you
>> have actual hardware that uses the USB + separate DP, I'd say, we can
>> ignore that part.
> 
> The RK3588 evaluation board routes the first two lanes to a USB-A
> connector and the second two lanes + AUX to a RTD2166 bridge, which
> converts it to VGA and then terminates on a VGA connector. I have
> that on my desk and can do some tests. But I don't have enough time
> for preparing patches right now - especially since the RTD2166 is
> not yet supported upstream.
> 
> Greetings,
> 
> -- Sebastian
> 
>>>>> +      port@1:
>>>>> +        $ref: /schemas/graph.yaml#/properties/port
>>>>> +        description: Incoming endpoint from the USB controller
>>>>> +
>>>>> +      port@2:
>>>>> +        $ref: /schemas/graph.yaml#/properties/port
>>>>> +        description: Incoming endpoint from the DisplayPort controller
>>>>> +
>>>>> +      port@3:
>>>>> +        $ref: /schemas/graph.yaml#/properties/port
>>>>> +        description:
>>>>> +          Output endpoint of the PHY for DP, which should either point to the
>>>>> +          SBU port of a USB-C connector or a DisplayPort connector input port.
>>>>
>>>> I would suggest describing this port as 'DisplayPort AUX signals to be
>>>> connected to the SBU port of a USB-C connector (maybe through the
>>>> additinal mux, switch or retimer)'. It should not be confused with the
>>>> actual DisplayPort signals (as those go through the port@0).

This is the use-case we're trying to support aswell on the Radxa Dragon Q6A.

Neil

>>>>
>>>> In the Qualcomm world we currently do not describe this link from the
>>>> PHY to the gpio-mux or retimer, but I think we will have to do that
>>>> soon.
>>>
>>> It does looks like no upstream platform does a proper description of
>>> USB-C setups :(
>>>
>>> Thanks for having a look,
>>>
>>> -- Sebastian
>>
>>
>>
>>> _______________________________________________
>>> Linux-rockchip mailing list
>>> Linux-rockchip@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-rockchip
>>
>>
>> -- 
>> With best wishes
>> Dmitry


