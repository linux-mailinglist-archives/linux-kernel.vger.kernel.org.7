Return-Path: <linux-kernel+bounces-802226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C421FB44F37
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93C2CAA17EF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 07:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1986D2E11BC;
	Fri,  5 Sep 2025 07:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VIuKmvtt"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735B82D6621
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 07:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757056600; cv=none; b=Zgfl8r6eKAcVU5DjC3ELnQBJyXFOwf3nsZmjsDaVSTe5GoeKdRtd0ePqwtP4KyOLHSTYLBrHRpkqc/Y15HCQoYS7b99rf/jppDCUA10XJXeD0ZmfKlW+Luece6gC1qi7/Wk0TqiGe9wn7L7+qZW9rT7dErayFnoTP4VS+5xepW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757056600; c=relaxed/simple;
	bh=uYIHqhuJbFbbLzl91KJ9E9JiWGi+o9b6jmgKGYFUkF4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZZ/eoQeOgpkpxvlMdssHUX68mGLHL1TckPcpzU1BDPDbfkmkJW5ARY8qSvhQiPL+rPlASRq5WHC30JzG1Gsi/1j7dIgK5XDSQJlwtJNM5+QKr1fd/SIrALtipxyFf5ALPZbAurlUWMUaExaE88fpXTywUBzeQl14XmDFUVPvoKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VIuKmvtt; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b042cc39551so323756666b.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 00:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757056597; x=1757661397; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2kp4JD2bZttGmbx+T4NyRquvfEBXW2E37LfUlYO3b1o=;
        b=VIuKmvtt5r2CmjqB6+owH4aUOrRuR+eAF4oGOi/DHAWjhagc25pxkL+3h5gzqHX6gq
         b8GZnoFlKdqkhthbxoiJu/uMMc17lDWeibg+WP4boRK2UKfkno4O9J3yieKkXdxlSjij
         iMHpo/5ObQtmUz4almWbkuEfsMNl3noa9vJYTtyp6YrzrezehY3rz7J4flOiOkGsb3RE
         FPFkiy1b8WFCD97zdOIhFnGnOxt7fAOEk9hA8tAQNcw2dABdeUdJjDq4CaLu3nF5HrTs
         nZaTUrzPbyMjackSpr79/dR+dVxtMo+2pRN6dxJ7cW6Nd3zKDvXRSnyrgnLhbWoOkEHS
         gOYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757056597; x=1757661397;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2kp4JD2bZttGmbx+T4NyRquvfEBXW2E37LfUlYO3b1o=;
        b=bmYHQAt6jpYZWi2OUjj/akvcn8zNkX6AriUFZ0iY4yPVxuyrr7hkhdc353dOcBFxje
         M84Ab1EfZaPWNuVW9ech/Vc4gtRI53tZm+inRyRn7gDun4uKiKZzP9XWFIKLEYvnuXRt
         hNpG4sTjecCngxbfeIdSHO7psU187bVbzUjs0irlV8p0U8PUtY8h1GpsioTynwt59EEJ
         7Tv047hiUXRH09o8guOGQyVYyDZsMquvyAzY2KtEQ0dza/8jdw8nZ2fJu+Iz08Yia3yj
         Rx6PG9MnYxdcnUiLXYj5EOlfMr1XBW4Q8OvopeO/mbeX9hbr//sSzcC2q+OZ4XNTa4fT
         SnFg==
X-Forwarded-Encrypted: i=1; AJvYcCVjvHn9ZLudinALQgBi6SIkiKOPEJlWrD8PL1f2Rq2chh8MuDyTcAwcgiXegStpan/b8pULdmUfArsUjZY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkulv1jxL33dlKMrzGULr5QwotVqSjb2AUX88RIZyzpAGk3SOa
	AQmMyMj1uHSz44anRfcJ6aJipyY/gATttS4+m2dPLQYAcBvhpBP3CgGQUyEUh7q1mRw=
X-Gm-Gg: ASbGncuOorCjcqRFqvwZV3KMQtJGVWIeCeeOLwZz17a1ovOQ0gweDkuEpQSz+PiXE/T
	x6IX0GzcQXLWquqU4FB7hJDeuIwSc1WaBp6RYeZlIXJu9ROGGkVMwJ7wbWDZVvKA/+lkBPfXhkG
	Z4E9JzttMxjowTFxRDx36zuLbAquzwh3LkWQowpuB62QTsF+4Mshfz+dxA7SybPrTkog5+H4bQ+
	0LN8J8u70hzsQVeZ27r7v8sbgTly8MdVDykNSAvHbmoRxGJUrcGDW+MimYG78cVR7Bb0wsUOaU6
	N2wDBlhluN+kGN4kpzOnw0HDg0t1ihLwBBUL5mVppcKj/7hlKwx4FbIxzFHbkHZhWjbgd4sW3jy
	O0gWuD9wiLPhOks7elepU6Y72seUjU7kxaDDqtIPVCH/p92tIO1JBY4E=
X-Google-Smtp-Source: AGHT+IHN1s8kTSyfhSU5wHjajOFmjDbm1ZSDrIzxsUIy94QQNaiThEepAiCWlOP88EXeHFDYK6UbIw==
X-Received: by 2002:a17:907:7e85:b0:afe:9f26:5819 with SMTP id a640c23a62f3a-b01d8c83763mr1972815366b.28.1757056596546;
        Fri, 05 Sep 2025 00:16:36 -0700 (PDT)
Received: from [192.168.7.190] ([212.114.21.58])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b04634dbd5csm647972566b.19.2025.09.05.00.16.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 00:16:36 -0700 (PDT)
Message-ID: <872cc8dd-4b9a-4cfd-9a52-eef040b52daf@linaro.org>
Date: Fri, 5 Sep 2025 09:16:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 1/6] dt-bindings: phy: qcom,sc8280xp-qmp-usb43dp:
 Reference usb-switch.yaml to allow mode-switch
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Rob Herring <robh@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>
References: <20250807-topic-4ln_dp_respin-v4-0-43272d6eca92@oss.qualcomm.com>
 <20250807-topic-4ln_dp_respin-v4-1-43272d6eca92@oss.qualcomm.com>
 <20250822212043.GA475528-robh@kernel.org>
 <db5220ad-6153-4f04-89be-5d74838151b1@oss.qualcomm.com>
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
In-Reply-To: <db5220ad-6153-4f04-89be-5d74838151b1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/09/2025 17:18, Konrad Dybcio wrote:
> On 8/22/25 11:20 PM, Rob Herring wrote:
>> On Thu, Aug 07, 2025 at 06:33:19PM +0200, Konrad Dybcio wrote:
>>> From: Neil Armstrong <neil.armstrong@linaro.org>
>>>
>>> The QMP USB3/DP Combo PHY can work in 3 modes:
>>> - DisplayPort Only
>>> - USB3 Only
>>> - USB3 + DisplayPort Combo mode
>>>
>>> In order to switch between those modes, the PHY needs to receive
>>> Type-C events, allow marking to the phy with the mode-switch
>>> property in order to allow the PHY to Type-C events.
>>>
>>> Reference usb-switch.yaml as a simpler way to allow the mode-switch
>>> property instead of duplicating the property definition.
>>>
>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>> ---
>>>   .../devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml     | 7 +++----
>>>   1 file changed, 3 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
>>> index 38ce04c35d945d0d8d319191c241920810ee9005..c8bc512df08b5694c8599f475de78679a4438449 100644
>>> --- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
>>> +++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
>>> @@ -73,10 +73,8 @@ properties:
>>>       description:
>>>         See include/dt-bindings/phy/phy-qcom-qmp.h
>>>   
>>> -  orientation-switch:
>>> -    description:
>>> -      Flag the PHY as possible handler of USB Type-C orientation switching
>>> -    type: boolean
>>> +  mode-switch: true
>>> +  orientation-switch: true
>>>   
>>>     ports:
>>>       $ref: /schemas/graph.yaml#/properties/ports
>>> @@ -106,6 +104,7 @@ required:
>>>     - "#phy-cells"
>>>   
>>>   allOf:
>>> +  - $ref: /schemas/usb/usb-switch.yaml#
>>
>> As reported already in this thread, this adds a crap load of warnings as
>> it makes ports or port required. Sigh. Can QCom folks pay more attention
>> to this please. Every cycle the number goes up though that's often
>> temporary because there's no coordination of taking .dts files after
>> bindings. But generally, progress on QCom warnings has stalled.
>>
>> Here's the top (bottom?) platforms in arm64. The first number is
>> total warnings. The 2nd number is unique warnings (to remove inflated
>> numbers due to lots of boards per SoC).
> 
> I'm sorry this happened, Rob.
> 
> I assumed this was a solved problem as I picked up this series, but
> of course not testing always ends up biting..

My bad actually, I didn't figure out the ports definition would conflict,
I sent a fixup patch at https://lore.kernel.org/all/20250902-topic-sm8x50-fix-qmp-usb43dp-usb-switch-v1-1-5b4a51c8c5a8@linaro.org/

Neil

> 
> Konrad


