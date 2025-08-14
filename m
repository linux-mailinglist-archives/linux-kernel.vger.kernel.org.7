Return-Path: <linux-kernel+bounces-769048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD08EB26998
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 16:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ECE41D01D12
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 14:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB2C189906;
	Thu, 14 Aug 2025 14:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="coaoqa3a"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11FF321459
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 14:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755181275; cv=none; b=NFNp+doHKXM4v2hnCqcEJA6bd82GksW7V6wiN9lNVHVK5UrIFyLRpKxW5D29NG5HgoPucx/pd8JVnPIlFTfaftK2f4pSnadEdZrHasIfRuu+IAuIvzoFD8YMkYPso2BYsjbJ4BlAHxI9j3GWFkfBrX0wVD2Jh0BGBk2BP+Rl9dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755181275; c=relaxed/simple;
	bh=KUV2rJc0cJh4fPOX4A3tWdZN2OJuiU0vmq4Tka5UT4Q=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=qqTc4qgr08GTopWl7TuxrPmlW7omB/RDCYjfPVUiOcG9AhLayRhgKxZ1A+qU0ebX+LxJkJY/kycJfMmv65HdY5l4hcdNG8mZTEouKYZm+JF6O2hd0nnnIQ07vJDRCwVxrpm/D4+A9cYEHBUW7SU+nBfHfn7IREBBKTVATgGoazE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=coaoqa3a; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3b9edf4cf6cso784935f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 07:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755181271; x=1755786071; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4vFp1QCJpRDcLOP+2iU18C4auf6bivSiIUcw7C2wHw4=;
        b=coaoqa3alvU99TYs5/gto5BmYOOmUw4yVUkljH6xRnbGe949v4lfc0Igac6QXVtsWZ
         b/yXVFbtQaYf+PVtJOZn3XHG7E7wKinksHWIwepdcqN2+Q4YLaBZwEZuVJARoe4lFgbw
         5EYLZ0WZdczKHnT+JznYPeCkU7kKkapMifXLIjFOQ/k6a/Eeg4/CM9LH2E+koIMkQ+pz
         DiNPYIYgrgq+08ZNHwMvA4SkQ94L6td8jE/anO0XN3LjyIHiQgM02fO2iIPligW4ULMr
         egSLCQdCU2bUw1/KyxJeFsPagNB9E6nDLcW1tyEzg+WCj460qTYhivIO0AJ+H1PHIyk/
         NNgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755181271; x=1755786071;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4vFp1QCJpRDcLOP+2iU18C4auf6bivSiIUcw7C2wHw4=;
        b=arBHw5/+dpwDDjYP8imsFEW0tpSX2BKvR7OADbbj2nxEfzr64XyShzXE9T3v0LnrCI
         7Os3sq4iCG9b46b7To8iYf5pd27lBX8oJImLfPJl5MEEA+2o0Xf8Y6cdQpPaGjJSTjPb
         w0JKVtoUSpGnXIwdmeemxdrL5OMh9ys5qgToRct3+Bi4KMnXE3p80NN1o/7OwocOd91Y
         4EKxkxPYI4MWDQGru2OU/fCeS8GcakfGFqjLEJ1MJwZmZmWFDoRXTmH0UMPhcpGWnuAh
         qpOe9H6vLG38VP2hu+ETRiTkj5aODcSAaEJIIGv4QgWzEQA9aQdJnPwvBXp1el18Dy/2
         UXYg==
X-Forwarded-Encrypted: i=1; AJvYcCXU9OnbMhXrf9WWZre5jEHFuLQMl5rtsV8AN/6FjZx45zgZn2cKVm76i8u/k/9erSpMYX9hwdXcyI7bdPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvlNkaH3LYa6vYYhxXE8x9RUL5dyiUgHI3ehBlcG/B+nHCFqwy
	VZvb2DfdKhNUNUdh2VAPVTKKGxAeiyoBByPLukK8xR51HI3OSApWo5ohcaWGOO29b2k=
X-Gm-Gg: ASbGnct+fjDaLJ/9KPeZ/mUGMY2MeIPe5UZ9DCZm4Lw7baxxj8Pfdy1Z9PExPSgHDTt
	KuZsJAifd0hZhQf75VeLcWbYPunyZKTv+yPJZdf3DcKEU7wPUzN3fQOp5narB6RDWG6cpDOgl2o
	vEgBwTFC+bYzeoqGIl5KMDUIfThnhyKst1kdqfoCD2K+PA0YsNC2gOGsmmEQrjnxHdYiLBA9NZv
	BbXOMbrKExtXmB/SYtu3HFeDJhgHnJCe8oJiK5aWDdw/XkRE3VzQr0dKtbd9A00dgEu1b0X//dz
	3G10gGw6XONv9lG0mfnQtg9TIt6Oqomq4iB/3oUT95vKc1u9vhRHkpM2eqF5nCzHsDp8EBP6Jbc
	PlLK3yxSNyuqrmPnlrQ1eHqZeGMQcJXY/TvHQWMLxN8vQ7bTQCuyYrDU2FvbCc2daaMFqOrkg
X-Google-Smtp-Source: AGHT+IE+4++8ILvUsYg3hhgJDOtLRyfm3QvNNAALFyboVt/WjmkjcDQBTvinmWUaP7p4FTRya3vjvg==
X-Received: by 2002:a05:6000:3111:b0:3b7:b3f2:f8b3 with SMTP id ffacd0b85a97d-3b9fc34c406mr2447041f8f.38.1755181271072;
        Thu, 14 Aug 2025 07:21:11 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:7336:e60:7f9e:21e6? ([2a01:e0a:3d9:2080:7336:e60:7f9e:21e6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c6dba38sm24179585e9.13.2025.08.14.07.21.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 07:21:10 -0700 (PDT)
Message-ID: <536dd237-e668-4a88-ac2b-3bc88dca8a3e@linaro.org>
Date: Thu, 14 Aug 2025 16:21:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v6 1/2] arm64: dts: qcom: x1e78100-t14s: add hpd gpio to
 dp controller
To: Christopher Obbard <christopher.obbard@linaro.org>,
 Johan Hovold <johan@kernel.org>
Cc: Douglas Anderson <dianders@chromium.org>,
 Jessica Zhang <quic_jesszhan@quicinc.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, Rui Miguel Silva <rui.silva@linaro.org>,
 Abel Vesa <abel.vesa@linaro.org>, devicetree@vger.kernel.org
References: <20250731-wip-obbardc-qcom-t14s-oled-panel-v6-0-4782074104d1@linaro.org>
 <20250731-wip-obbardc-qcom-t14s-oled-panel-v6-1-4782074104d1@linaro.org>
 <aJCyBbwNjZvTHnjT@hovoldconsulting.com>
 <CACr-zFCq08Pu2=eLfe5=sYdGWEHmy7w+=Eo++9AjP96uCLCNcQ@mail.gmail.com>
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
In-Reply-To: <CACr-zFCq08Pu2=eLfe5=sYdGWEHmy7w+=Eo++9AjP96uCLCNcQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/08/2025 00:28, Christopher Obbard wrote:
> Hi Johan,
> 
> 
> On Mon, 4 Aug 2025 at 14:13, Johan Hovold <johan@kernel.org> wrote:
>>
>> On Thu, Jul 31, 2025 at 09:51:26PM +0100, Christopher Obbard wrote:
>>> The eDP controller has an HPD GPIO. Describe it in the device tree
>>> for the generic T14s model, as the HPD GPIO is used in both the
>>> OLED and LCD models which inherit this device tree.
>>
>>> @@ -5779,6 +5779,11 @@ tlmm: pinctrl@f100000 {
>>>                        gpio-ranges = <&tlmm 0 0 239>;
>>>                        wakeup-parent = <&pdc>;
>>>
>>> +                     edp_hpd_active: edp-hpd-active-state {
>>
>> The node name and label needs an index as this SoC has two edp hpd pins
>> as I already pointed out.
> 
> Sure. After looking at the schematics this should be called
> edp0_hpd_active. I will fix this in the next revision.
> 
> 
>>> +                             pins = "gpio119";
>>> +                             function = "edp0_hot";
>>
>> And you also need to configure the bias somewhere as you should not rely
>> on the firmware having configured things for you (as I also pointed out
>> before).
>>
>> On my T14s the internal pull-up has been disabled.
> 
> I am still unsure of what else needs to be set here. Can you help me
> with the correct settings?

Just add bias-disable;

Neil

> 
> Thanks,
> Chris


