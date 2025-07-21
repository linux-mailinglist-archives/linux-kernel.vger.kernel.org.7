Return-Path: <linux-kernel+bounces-739564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8436DB0C7F2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 17:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07FE67B042E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 15:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4FF2989B4;
	Mon, 21 Jul 2025 15:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ajoXNZX0"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C3B1F1522
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 15:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753112817; cv=none; b=pxQF3TuryYqtfxOS49kOYIEE9+XqkV/ooIHclAGGuW15Im7PW/I+b/Vwzbo28p4hfg4eLupXiPcgLC4qykMKFO+EYm8h/oGCrMifVm4/POkgdq1oPGmIwWYS3NdCpoyWoDvwAXW+NyRxYMhGzFrwAJRRQEVMttiXFyQijzyXHtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753112817; c=relaxed/simple;
	bh=pEmFK3YtX71Ss7IoSfHexKR6lboNbFxDMXbiAmk0Md8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZCwgCHz4S4KAH6Hh4Y19bZwb6RxGkT0iLzbchbcHhqU32UPyCAMVDE1r8oiEV0nEyCBI3WaNEkgcRaGXz6NGs/XACPvLt45KHjm2NqzQef/V8C8MaePCLwgkVCSpUVGpLtva71JB7jN3T6y4tfnNtuumZmYHVNZEQ0UotsdZMMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ajoXNZX0; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a588da60dfso2728050f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 08:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753112814; x=1753717614; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=71JdOjhcRzTfEZ2kGP13U0soxm4bQUZhtALxxJcwpGY=;
        b=ajoXNZX0nijaUEfy6fHi3fC+TeAleT4F5zR/05w7v0YqoY3AhHQn2guCyCAhfeFheX
         WX7lTiAolW5qSUZF/AFiQjtCoH4Pg95uSKJb7vMD6gcF+70gmOGEG8/bNGHlp8qFdJ/U
         +yB2RMpJ7FmjQdsaQe2iO6R+kwfZv8tPhXEDyeYxCnTfJo7q3SS/6MVswKZiIWYeQkrh
         papCUYMV4k/0geWEw1lxpJiqZBr4yvHPxSU325G+r5Khi0EFxqTBUEGzLQriJtfyucd0
         bWvx97pCqWuQrmqbACEMKYdCc16haDnDnUgOaXlBx7tTL/7MbEIWnQKyj85D3CmhK0vj
         jC5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753112814; x=1753717614;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=71JdOjhcRzTfEZ2kGP13U0soxm4bQUZhtALxxJcwpGY=;
        b=ToTp+00YwUcpaY80xsJuxPlMrpizoyqGAfEjSBfbKB5FjoKIliqCBIf4HskQykKlTG
         pojegebfbUGofuqo4hUyrQQA//yjp0RTa4CzZNIRnpro1O4201UGBI0eCxh2sCsCDAti
         7a7qMYixXkCo8R4fZ7jHUjMDLSEzQ+dVUJFl5DDc6ZrabrhKt3hWO4e26NH64VGd3aVS
         WDHamcnV9CbC8DGq6FS/yV9oGbnSPuqS3eeaW6ZiRixzSdNgrWmLyBmT0F21MIXpTFJc
         q2IONFyKWaePFjkGdFqCcFSKMV7Cy1w0LG4PHJXQc0Wj5DwIirexYV62Tv0qcU/ll00U
         hWOA==
X-Forwarded-Encrypted: i=1; AJvYcCXOShk8uUsgJEnt8mqpffykm/Mo00qLR3aAADW67Pc7TF4EJOFkFN/v1oVg+7pio8/OiC89hPf4PVAlA5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT84y9hQV+WWREMX9w2X0SnGIgwvbazkv5ydP3yK+t6emzCeDn
	nkSFu3UaWy4DeQEZCmmVh61SbDYmze8s0GCl52AaT6pOQtM1Q7eIvwxWs+cV7J4m0qA=
X-Gm-Gg: ASbGncsdhacQE5RhKCrpcZdDD4/0SbOExaSDnkN9LOXYIEE3GyC0G/seX9dSS3IEvTK
	CYjn/rev3ZJ4nMCLUS3BzA1PmCEidT3adtaBtQwNV6s4qFw6kISq+9AIub8x9ofYSF3Hf67/nPk
	TnHERYIE6MAzDTGKrUqzQkrclSLB3iWkhxNXdF1c++yABleLcBoGuJDOaekc7Q9W96M7W+zF1q2
	MAxf+f88BZjErYmRgPTOkBi6EWw1DBxiGZZa4b2ZnQgZaFjmr6Dgc1/doejNvkAhs9egYq/XPdT
	cL36GW02u0SzhtmP/4HH1aK2P3X6FQ97ZXCTpSOjqNR/FK/DUbNFNFKR4I3CwAPKjbBXsyv4ho5
	oc3O8kLdNZXn7HErwskOv/TE+rgpsSfz4FuJp/utQafF5T0Ao58p8hDspSQlI3WMryu1pATYg5W
	4=
X-Google-Smtp-Source: AGHT+IE18IBrQLiihCAuzNQ8PIrN0f+oNCcFrb048tnw4oH4ReNy5YSqf9fO8yU7sBsWjafeYv0hqA==
X-Received: by 2002:a5d:64c1:0:b0:3a6:d967:380e with SMTP id ffacd0b85a97d-3b60e4c521dmr14461783f8f.3.1753112814028;
        Mon, 21 Jul 2025 08:46:54 -0700 (PDT)
Received: from ?IPV6:2001:861:c12:13d0:4146:67eb:7420:1c39? ([2001:861:c12:13d0:4146:67eb:7420:1c39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e8ab7a1sm164661725e9.34.2025.07.21.08.46.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 08:46:53 -0700 (PDT)
Message-ID: <8b908a20-0bf3-447d-82ea-a5ecee1bf54c@linaro.org>
Date: Mon, 21 Jul 2025 17:46:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 2/2] phy: qcom-mipi-csi2: Add a CSI2 MIPI D-PHY driver
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Vinod Koul
 <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Bryan O'Donoghue <bod@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250710-x1e-csi2-phy-v1-0-74acbb5b162b@linaro.org>
 <20250710-x1e-csi2-phy-v1-2-74acbb5b162b@linaro.org>
 <11b573d5-ce4d-476c-b94c-216d427cd838@linaro.org>
 <08261aa4-689b-4d6b-bfd2-221c1976d254@linaro.org>
 <a7f64b31-4767-4281-b452-a2bc5351d745@mleia.com>
 <c93624bb-ee7b-45ac-8b53-b5391f11c9c9@linaro.org>
 <eac3a877-a4aa-4789-9013-ab8b6c91e0f3@linaro.org>
 <0a12879f-dc4a-47fb-87a0-ac4b8bcd4d75@linaro.org>
 <53a19b1d-5665-4937-a07c-5dd1fcde06c5@linaro.org>
 <3b760685-97db-46e3-80a3-7fad69ad31cd@oss.qualcomm.com>
 <94b75177-9401-4e0c-966b-5847a29cb6f7@linaro.org>
 <427548c0-b0e3-4462-a15e-bd7843f00c7f@oss.qualcomm.com>
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
In-Reply-To: <427548c0-b0e3-4462-a15e-bd7843f00c7f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15/07/2025 11:33, Konrad Dybcio wrote:
> On 7/15/25 11:20 AM, Vladimir Zapolskiy wrote:
>> On 7/15/25 12:01, Konrad Dybcio wrote:
>>> On 7/15/25 8:35 AM, Vladimir Zapolskiy wrote:
>>>> On 7/15/25 03:13, Bryan O'Donoghue wrote:
>>>>> On 14/07/2025 16:30, Vladimir Zapolskiy wrote:
>>>>>>>
>>>>>>> I think that is genuinely something we should handle in camss-csid.c
>>>>>>> maybe with some meta-data inside of the ports/endpoints..
>>>>>>>
>>>>>>
>>>>>> This is a CSIPHY property, a CSIPHY hardware configuration and a wiring
>>>>>> of sensors to a CSIPHY. Where is the relation to CSID here? There is no.
>>>>>
>>>>> All the PHY really needs to know is the # of lanes in aggregate, which
>>>>> physical lanes to map to which logical lanes and the pixel clock.
>>>>>
>>>>> We should add additional support to the Kernel's D-PHY API parameters
>>>>> mechanism to support that physical-to-logical mapping but, that's not
>>>>> required for this series or for any currently know upstream user of CAMSS.
>>>>>
>>>>>> Please share at least a device tree node description, which supports
>>>>>> a connection of two sensors to a single CSIPHY, like it shall be done
>>>>>> expectedly.
>>>>> &camss {
>>>>>         port@0 {
>>>>>             csiphy0_lanes01_ep: endpoint0 {
>>>>>                 data-lanes = <0 1>;
>>>>>                 remote-endpoint = <&sensor0_ep>;
>>>>>             };
>>>>>
>>>>>             csiphy0_lanes23_ep: endpoint0 {
>>>>>                 data-lanes = <2 3>;
>>>>>                 remote-endpoint = <&sensor1_ep>;
>>>>>             };
>>>>>          };
>>>>> };
>>>>
>>>> Don't you understand that this is broken?.. That's no good.
>>>>
>>>> Please listen and reread the messages given to you above, your proposed
>>>> "solution" does not support by design a valid hardware setup of two
>>>> sensors connected to the same CSIPHY.
>>>>
>>>> I would propose to stop force pushing an uncorrectable dt scheme, it
>>>> makes no sense.
>>>
>>> If all you're asking for is an ability to grab an of_graph reference
>>> from the camss (v4l2) driver, you can simply do something along the
>>> lines of of_graph_get_remote_port(phy->dev->of_node)
>>>
>>
>> It's not about the driver specifics, my comment is about a proper
>> hardware description in dts notation, please see the device tree node
>> names.
> 
> I'm a little lost on what you're trying to argue for..
> 
> I could make out:
> 
> 1. "the phy should be a multimedia device"
> 2. "There is no ports at all, which makes the device tree node unusable,
>    since you can not provide a way to connect any sensors to the phy."
> 
> I don't really understand #1.. maybe that could be the case if the PHY
> has a multitude of tunables (which I don't know if it does, but wouldn't
> be exactly surprised if it did) that may be usecase/pipeline-specific
> 
> As for #2, I do think it makes sense to connect the sensors to the PHY,
> as that's a representation of electrical signals travelling from the
> producer to the consumer (plus the data passed in e.g. data-lanes is
> directly related to the PHY and necessarily consumed by its driver)

The port/endpoint should represent the data flow, and if the signal is the following:

sensor -> csiphy -> csid

and in addition the "csiphy" can handle up to two sensors by splitting the lanes,
then the DT should take this in account and effectively the "csiphy" should be
an element of the graph and should take it's configuration from the DT graph
to properly configure the lanes configuration.

While it can feel simpler to simply move the csiphy code into standalone
PHY device and just replace camss code with phy_*() calls, it doesn't
solve the proper representation on the data flow and doesn't fix how
the combo mode could be handled.

The solution shared by Vladimir (I think the "csiphy" node should be out
of the camss node), solves all this and will be able to handle more
complex situations with shared resources between "csiphys" and start
moving elements out of the gigantic camss node.

Neil


> 
> Konrad
> 


