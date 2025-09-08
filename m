Return-Path: <linux-kernel+bounces-805812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 597CFB48DBD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E503520341C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 12:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA353301008;
	Mon,  8 Sep 2025 12:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lKeU024B"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C3E2FF654
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 12:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757335044; cv=none; b=mKTI0mPTh8tCPDINVDa1vlnEVkUgZETg9FBbRUAbxAMOvUfrUlN5Hx12CSHXppuhirVLjbiurHkvtgB84QnLiHagQK3jeUi4UvcAMm2HIHxen2kCZlAIO4cm4NXx3/DcvRCrf6TL+CcMhT/vYIqttXsi0DVBet1XSeN0bCmFmR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757335044; c=relaxed/simple;
	bh=Qy1XMDJ6lgYtKZeqEsXcyBftJcPIoZvk7qPmU1fod9Y=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=m4nMXdYxsokNRbC0OBpiju+5IyEAQFkhfjytuse7coorI4QCOLzDD86sRnc0hoAJUhM1SVk/f+WibG9oUfIoSKXdUqpS00feURaXN1SsUFgFjSfkrrbI5P7COBMGkEDn8sH4ySD4RipUWTZ6g5YG5owFj7l2/KrL8TtAuqKhj/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lKeU024B; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45de6490e74so8602165e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 05:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757335041; x=1757939841; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6NFJOGdTOAIrWSGSI9q3EKjG6ufco2aZBuT9TNv9EzI=;
        b=lKeU024BY1+cT+HOnsCGP0lxTcAYzwJPau65RT95+V1wnJY8W9F3uK+2FkDoBAUT1t
         fl92JDPfWOrlrRmnlQcY/GswomYpsrdMcP+jBOxNFpMP8OlZVmxBM+NFC6PWSwnieoj8
         5yohmeGd8KuS3wmuqMWWwrBmWeCivXa489EbuKQao5wKATtgGsmJKGVMzbJwnRVznM6F
         JUuc9fHYFxZAzcp9e13NEXGpnrpF8Eb+xTLvK5WKbhK23UOGqIBcJoL+5SK8+Y4G50C8
         3OKJF2iH7MxYOa3rdLiUtesqCyPnWq7KhAyvwDgEUPoDNDD4xjm0MLOUbLIaClR7wNjP
         KGWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757335041; x=1757939841;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6NFJOGdTOAIrWSGSI9q3EKjG6ufco2aZBuT9TNv9EzI=;
        b=Jg08L3uSu6NSeE5FJ3OD7L6JD8Dzz0DRJKTd6vdfd0xlyLWRbgAI+TpXM3JVfQuKeJ
         S4u6kYez9BAMgrJI1iHG7ge0wuidVw9C3Tpd5PAxvIdnMptusiGGq4AaMyckl9jA+x3f
         oo4FtcoFzHhbtP1l1Ka6jJO4mf+md+TCO1wXNogqJbtDlxBS/btiUDbjxwEIj4PysBjC
         9Dc++xgvcwmOanj6D4jgHIbhEU7zvilQHE2yBCtq+6J3CvSAC7yMacRW80WHh+GSUB4B
         D9m0ssBNUP3DZ7RzyDso4RwNTm2NBSraAxJd2OvGiV5gjlC9zoWQXCsTd0Bq6A4ksVXw
         Itwg==
X-Forwarded-Encrypted: i=1; AJvYcCVuzxZiVdy/+TlMcqOAlPTjsolECwQUxjLzCJDLlDXdSwdCBLHXzbrmg688+NpIqC2m15KL1qlETOB4G6I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8PyLhW8lXz6lg7vY6ZdpzwOdvy2BsgSLRYpUkMuTE++171t05
	VxuuEcnv+Ujl3SM3WiYljY6+izDMVDQDe1x6RTHcMRz0qYmeghr2VtXdYNRUU5HKvNc=
X-Gm-Gg: ASbGncu1frQkjuPv0z2KpmPihjItPNVeSEL1P9v4J3/V2eWZeCoq3kl2y2+D/FHNCs3
	zY5pIriyjbdg9kprmKnJzGmw37LpNq0PJuDHquSSnmlwyJ7gG7IQH1qyA2tlIaIBmOpl/xJRLgP
	0Fz3xLZRueD4OuulgpkBT2bRzrkG/9mE8GMH9WXxnBauXDSqChF3PusaFjxu2C3B8WRDVhuWJ8I
	YHPawid2ABdmacjCzWFoW3WaYJvjq5Q+8W1qyh5mn0WN5Kvc1S2bo2LnHQtNBSkf7lP/7sT/ojP
	0KmjfYuby1T9s6KPjwJkSlbEDmbSX+RZoWrxEH4Xm8aPD51mN28oTDfADtJnFAifs+BlLOWeVKh
	OO0ANjG15RQxFQlOo5KLXKCRqqVCMPkSMnUhBTDcHSUTGt8zhAeISGmC7Tefz/4EBPxH52SZKBJ
	dS3pRB+cwqaQ==
X-Google-Smtp-Source: AGHT+IFCx8qWLzEWowJjY2uRE93rwEETbujkQqV4hxx0CGnBG1GMQzaFpRPAyUPxe8RBB4Sd+qTUdw==
X-Received: by 2002:a05:600c:a43:b0:45b:81ad:336 with SMTP id 5b1f17b1804b1-45dddea520dmr85902925e9.16.1757335040676;
        Mon, 08 Sep 2025 05:37:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:61c1:5d31:4427:381b? ([2a01:e0a:3d9:2080:61c1:5d31:4427:381b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3dedea839c1sm19912772f8f.63.2025.09.08.05.37.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 05:37:20 -0700 (PDT)
Message-ID: <7462e29c-7602-45fc-b8f6-31e881ef3fc4@linaro.org>
Date: Mon, 8 Sep 2025 14:37:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH RFC 3/3] arm64: dts: qcom: x1e78100-lenovo-thinkpad-t14s:
 add HDMI nodes
To: Jens Glathe <jens.glathe@oldschoolsolutions.biz>,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250821-topic-x1e80100-hdmi-v1-0-f14ad9430e88@linaro.org>
 <20250821-topic-x1e80100-hdmi-v1-3-f14ad9430e88@linaro.org>
 <a38df652-54c0-4216-9aa5-c8d32599c8f7@oldschoolsolutions.biz>
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
In-Reply-To: <a38df652-54c0-4216-9aa5-c8d32599c8f7@oldschoolsolutions.biz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 06/09/2025 10:41, Jens Glathe wrote:
> On 21.08.25 15:53, Neil Armstrong wrote:
>> The Thinkpad T14s embeds a transparent 4lanes DP->HDMI transceiver
>> connected to the third QMP Combo PHY 4 lanes.
>>
> [...]
>>   .../dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi    | 44 ++++++++++++++++++++++
>>   1 file changed, 44 insertions(+)
> [...]
>> diff --git a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
>> index 4cf61c2a34e31233b1adc93332bcabef22de3f86..5b62b8c3123633360f249e3ecdc8ea23f44e8e09 100644
>> --- a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
> [...]
>> +&mdss_dp2 {
>> +    status = "okay";
>> +};
>> +
>> +&mdss_dp2_out {
>> +    data-lanes = <0 1 2 3>;
>> +};
>> +
> 
> Hi Neil,
> 
> shouldn't mdss_dp2_out also have the link-frequencies property?
> 
> +    link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
> 
> Or is it something the bridge already negotiates?

No, indeed I'll add it, it will fall back to HBR2 anyway (as actually) if the link quality is low.

Neil

> 
> with best regards
> 
> Jens
> 


