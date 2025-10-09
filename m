Return-Path: <linux-kernel+bounces-847188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B33A5BCA351
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 18:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4339D35072E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 16:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B229F225397;
	Thu,  9 Oct 2025 16:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n0usMXNi"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD81422127A
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 16:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760027899; cv=none; b=ERxdqsliOAgCufNlYYe0AmfVSJUgeZXtRkuRl1UpOSKsbnGHStbgG7ykXFzEeHUiDF7bfQEyFrEbx01jfJq+jJZ333TNSvTYb4ML1GTnuCk09zsnckx610l3UKVX79Fk/lOBJqD1amMA5MhvwvyKFNGLwx8XClPjePj/jM/l2g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760027899; c=relaxed/simple;
	bh=gOf5m4DhshwdMaYusEOFIoFtXBZQ58skxHLLV4RK0X0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=bIA7VGChYI+ah5WxCTH4K8WhBHipy/s4bq3K/O+8fFBg45JhLCBxQRpwnsqpaiCJolnPbVvdwLhHUmKHsoP//i0VZBjX3bF5i0R9IZHJjUc4NrX5E4o5RgQMKziupdWemK4N+MU8x5j/1THkBHLh7rByA1/8dwIM3SiAFOVw+X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=n0usMXNi; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46e5980471eso6738915e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 09:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760027894; x=1760632694; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rcBStxH+Wrq6khr9+aB3AtD7KnFNOJRAT4fdx7tuAMo=;
        b=n0usMXNiWE/3frvPfbbOnfnW7KU/zur7htgv1050jrEKdi2IPp/ClRM+UGVlnndeC4
         pdw49rsd3crEiWr9ZREYx9Htco1CgDuPuhoWhRRP7JPFRy8WQfxPYXj2pi1a46+ZnR+4
         M4cIlKYMaXKm40zYLzh6ImCshwyUovw2o84jHxUM3xkjCMmCdVr6sCYjrf2JoqxyoIbs
         5mM77RX9eIAtTu6tNvE9OfSpzLyo0qf5SO8NVXUKvZviSjbD7U3JMfEkSQ3cGb3u+Qwh
         VH7T54m6STm/+KwHyfEO6uCUlsYdna4k15aMyFq10eb/foD+z5UTwnfW8eOS2pBm53s2
         UkuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760027894; x=1760632694;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rcBStxH+Wrq6khr9+aB3AtD7KnFNOJRAT4fdx7tuAMo=;
        b=gY47OBxx4DW8J3GThEOcR7HJCwB4mQEkuQT0xQuqU0pO3OV3YUds7+IU6sJZ8VKOaL
         IzXG6pVkK2k3htQVz6bVPP/j1Cf/B1tsLP97TCQR+NoiC2a3z2CWPUwNQjIya8i5QOy8
         Tw/FQQSOR1zk9Gy41cBUrTMpVDH4YwkRYE8WDKGM0vIz+juNZfymAEDzJrVGVygieuCM
         Cr/3cTJ+t9Hmd6GW+ZdYZzo0flmaAqylRq5RCLHodtD3NqO/hpZeqrVFkmcuJ/bYOXe9
         ADg0JOt5we4GlRLNuFYdiLQPAGe0j5wKtpoC6HwNZgGYbT38yuX2tnX8E97yPz7kraSA
         iBeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIJIeVOOhDerUKjmoUwx0+XB6IgUMft5Or4lysOS0ERs63D73GG2kEFMoq/Wes4dw9LOd7I/jfzTvKylU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6iLF4RdQxQUhj600R3x7UJl1gW9S8tHEA2hXuapphhE6FSRvf
	0NVZ3GtWzWV6T/bvKrQ7kEvK5Il9FtiIXxmLz9mIf78QCVlXOzOuwFNH2qkIAifZz/8=
X-Gm-Gg: ASbGnctbXrWF9HSQbwHl8EYZgAFZmG7mbXLogEHtznYEQGIVoTLyjwmSa8WmklWIi7m
	HKJOFW7bIoDg6BpayzsMyX8+e03zEzY3VI1J6RKGFFRD+vtAYattwsZqarTNa/DQWk5tIoVVLTb
	BLJ0NzFHDerlckX8EMOQB/8JjoysE3csuzQ/Zm6DMppLNE7Whk32H4QQ9/YCuIlMD3WWyV6T0eJ
	+0vy7xULjWhSSma2zOS8Rx35e8hfEZdhIe3uA6X+elHiW929b+ZybXah7cxStsDu3hkY/A0+lOg
	9+bSmBnR/3DkdQYXgUWdVCwsVqjKcgBvoc9KSZcnl0wGSn8uRHWDsFqrwa5JOZQwIsjtgFMsPQg
	S60S2rto4oGN6a0Xpsi2dkFefEO06zr86orvbVgLdLE2RIF9X6/PM8KBUFSVq6qmcZJ1mvD4v/5
	fFMlAq8SEG9w9KiMDmzwgWwSSzXOvPmsGHD5ZG6g==
X-Google-Smtp-Source: AGHT+IEgbSrDBPs4jShYRmrpIelnSLdiWABx9BTrJU9pmtlQs9UWdJ8j+RxcwelFukfDfOS44F2Nrg==
X-Received: by 2002:a05:600d:4301:b0:46f:aa8a:d2e7 with SMTP id 5b1f17b1804b1-46faa8ad4bamr35482135e9.4.1760027893916;
        Thu, 09 Oct 2025 09:38:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:7a0c:da2f:6591:67ee? ([2a01:e0a:3d9:2080:7a0c:da2f:6591:67ee])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426cd93f8d8sm196019f8f.2.2025.10.09.09.38.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 09:38:13 -0700 (PDT)
Message-ID: <6941e754-0c2b-42b5-a01b-54351e8714f1@linaro.org>
Date: Thu, 9 Oct 2025 18:38:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v5 2/3] phy: qcom: qmp-combo: get the USB3 & DisplayPort
 lanes mapping from DT
To: Xilin Wu <sophon@radxa.com>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20251006-topic-x1e80100-hdmi-v5-0-c006311d59d7@linaro.org>
 <20251006-topic-x1e80100-hdmi-v5-2-c006311d59d7@linaro.org>
 <60E11B9D37CEE163+8cf864e4-579f-432a-a507-9711d03776ed@radxa.com>
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
In-Reply-To: <60E11B9D37CEE163+8cf864e4-579f-432a-a507-9711d03776ed@radxa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/9/25 16:51, Xilin Wu wrote:
> On 10/6/2025 9:55 PM, Neil Armstrong wrote:
>> The QMP USB3/DP Combo PHY hosts an USB3 phy and a DP PHY on top
>> of a combo glue to route either lanes to the 4 shared physical lanes.
>>
>> The routing of the lanes can be:
>> - 2 DP + 2 USB3
>> - 4 DP
>> - 2 USB3
>>
>> Get the lanes mapping from DT and stop registering the USB-C
>> muxes in favor of a static mode and orientation detemined
>> by the lanes mapping.
>>
>> This allows supporting boards with direct connection of USB3 and
>> DisplayPort lanes to the QMP Combo PHY lanes, not using the
>> USB-C Altmode feature.
>>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
> 
> [...]
>> +static int qmp_combo_get_dt_lanes_mapping(struct device *dev, unsigned int endpoint,
>> +                      u32 *data_lanes, unsigned int max,
>> +                      unsigned int *count)
>> +{
>> +    struct device_node *ep;
>> +    int ret;
>> +
>> +    ep = of_graph_get_endpoint_by_regs(dev->of_node, 0, endpoint);
>> +    if (!ep)
>> +        return -EINVAL;
>> +
>> +    ret = of_property_count_u32_elems(ep, "data-lanes");
>> +    if (ret < 0)
>> +        goto err_node_put;
>> +
>> +    *count = ret;
>> +
>> +    ret = of_property_read_u32_array(ep, "data-lanes", data_lanes,
>> +                     max_t(unsigned int, *count, max));
> 
> I think this should be min_t instead of max_t.

You're right, thanks for noticing !

> 
> With this fixed,
> 
> Tested-by: Xilin Wu <sophon@radxa.com> # qcs6490-radxa-dragon-q6a
> 


Thanks,
Neil

