Return-Path: <linux-kernel+bounces-741942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BB4B0EAFD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 08:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19F7D1AA76B5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 06:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3388F254858;
	Wed, 23 Jul 2025 06:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lyJqum4I"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECA3219303
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 06:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753253487; cv=none; b=gfm63AgiFUp4Om/rxVlsV5JCBDyqF2zC5Ibzp5022187Y/FJEbOkmWImak56FTVUYFWGjCu8GCieeIaFQPlb2Ij8TGWYz/MU36Vw+Sg2BAPgPzkNU8dYu+z/iKWlroDjbtppUAKcrn1zvR3Va93MdBpEmappdw4rvPxVUnQ8gFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753253487; c=relaxed/simple;
	bh=jwzBPgPewamRNsaxEfFNMIFmvlapYYp5J3XKIArutF8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Of1QBH+ioHlmZmiLK7C0XhJksMIpewzmh8qrGkyltKt8Bx/Kp3WJXwiSpNPxmhpHcjogazvPHNLsHVOOj201SvjhYIn27c0gKOIJOivbXSKUirvbS/CaRA7YteYzpc5xLhE1djyN0fmfoEohKXNa7/YGghTlOJuIjZaJOFgS+8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lyJqum4I; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-451d6ade159so45444675e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 23:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753253484; x=1753858284; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HmDQpPxfKm8bqCiPdWg9uZmJGwJELrN8lL27X6M5AKY=;
        b=lyJqum4IK5euPOQqRk07RkpDOt9Rhq477gNSqyyjz+ju4EZcOMBd5pjfBZdZx2mSF5
         eWAzBJeUkw867eX1ZI9B4tvtwFp3lZ/U2fgj16DBUzCGv/+7txRfxEExgT3aQmrarlhb
         B1X5WKIlvduQvoC8iofjnpk+bfKu34OByXeSJPprpn3bJLTdMTkMbuIb+V0JqWlHwiiK
         l2f4YnXtk2EWuvjtGyZTOPKVC7WKmtKeCCNUE0m49JEtJpOIGrl60nBKyPXGstC3+T2O
         L4nUW070zqDA6rqG2z3jvE4EjaVXkif9wCc5JgXJn62OzwvZJoH19InY5a2vrG2lZ2xI
         ob+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753253484; x=1753858284;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HmDQpPxfKm8bqCiPdWg9uZmJGwJELrN8lL27X6M5AKY=;
        b=FCsyPaiVpg1zk3K/ylEXVExLdkFz37vsDgZ7mDh2iby7zI7QFs+9F6lEjCahFogUfH
         vJmlELBuRWH3U0bbq8gFETRY3tCnOxU0RhbkWjK1oRL2wMFFsdjO3MoCgquYiMfnMcRf
         vLSw4F1SwQltO7ewxWO5Ans9VEZ20pEJyK6sWVaz0SYy9sFHheIxU2VtjRWfVOT/Vp/q
         uPJu6fFPNBVMl/mjKeK99Uww1wYUzIzFL92JmkaicsVLFNoIFxjPSH0JJvfeGMzFjKme
         /k5nBNJ0Q93/vrFfE5/Sa5ORg9r49tIIit0mJqoNW26blkUYVPbdZusmUZK9CE9GC8sH
         DO0w==
X-Forwarded-Encrypted: i=1; AJvYcCUCrGJc6/JAumFsLuF9OPkFCYi2YzAziNbwwE5+s8hP0s6VBTrpiXRkz1Lz0TBzyL3uofLN6YQhng/Pknw=@vger.kernel.org
X-Gm-Message-State: AOJu0YySVRW50U+nyNXtLMJj23ELVuGLW4qh5X4nSsblaEKVYGWFIn6X
	0DEuX79RYw4y7gyPFl2jInSrP+hrUwiTyF8fYZUPMJksPeXCSwlqDu55VT8aHn1gfIU=
X-Gm-Gg: ASbGncunLidaELAfKGMfDYbolc9qCRR67xPyJg5aAyF8N8rPGHsx8pbtYhLEHjRuUPa
	pxCeFYTGlTsvqP52VHy/bH6mEVKlMRD5b2pnjlqbvHRPlALsxYrWnwJFXdzLj6BgjbPxk0PU5Wj
	J7unvB89OX0P41hfbWS3JuoFDvfyGwF7cSE3VqEiNiVSUsraqKyYek2im3iXJoGK072GinFjeYf
	QVFrNkVFrB5oO/Q4dUp4f6xrv3X95lSYaEfFYcqJzch24Iix+J45Pkh+mZyhX4qX8sQsXW8OIbY
	HBs5uKySIqwAK6BWeYkygTJwRHZvzmrfb3XHNrsnNiXuq+7MpFoqQz7b7ujqoN1zqTOhYLCrjEa
	7p72L6/Z4hjFuF+LbsFl7hBxT4J5taeb6jh2XTZois8ByloCLzl0FzhLrbe8F6cGyb9iImHD9Ts
	8=
X-Google-Smtp-Source: AGHT+IEoaOAXH2QorgnFzRzUfqE4JxvZBAunYUky46cjn0XM/7dCjKSv+Bq3sv4bmyNmd02W6oc5ww==
X-Received: by 2002:a05:600c:a08e:b0:455:f6cd:8703 with SMTP id 5b1f17b1804b1-45868d5326cmr11861405e9.31.1753253483979;
        Tue, 22 Jul 2025 23:51:23 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:8813:2f0d:f9e0:5294? ([2a01:e0a:3d9:2080:8813:2f0d:f9e0:5294])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4586918b65dsm12638235e9.10.2025.07.22.23.51.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 23:51:23 -0700 (PDT)
Message-ID: <e9c63414-8434-4e35-a159-66df1864f9f3@linaro.org>
Date: Wed, 23 Jul 2025 08:51:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v5 0/3] Add support for OLED panel used on Snapdragon
 Lenovo T14s Gen6
To: Rui Miguel Silva <rmfrfs@gmail.com>, Johan Hovold <johan@kernel.org>,
 Christopher Obbard <christopher.obbard@linaro.org>
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
References: <20250402-wip-obbardc-qcom-t14s-oled-panel-v5-0-ff33f4d0020f@linaro.org>
 <aCw9pYehCdfXXeiR@hovoldconsulting.com>
 <aG-QyF12rGY55gcG@hovoldconsulting.com>
 <d431435b-4ac0-44aa-922d-0bde126ca563@linaro.org>
 <DBIMQO2CS0I3.17XLZPKPCVW2S@linaro.com>
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
In-Reply-To: <DBIMQO2CS0I3.17XLZPKPCVW2S@linaro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/07/2025 15:48, Rui Miguel Silva wrote:
> Hey Neil,
> 
> On Tue Jul 22, 2025 at 2:01 PM WEST, Neil Armstrong wrote:
> 
>> On 10/07/2025 12:07, Johan Hovold wrote:
>>> Hi Chris (and Neil),
>>>
>>> On Tue, May 20, 2025 at 10:30:29AM +0200, Johan Hovold wrote:
>>>
>>>> On Wed, Apr 02, 2025 at 03:36:31PM +0100, Christopher Obbard wrote:
>>>>> The Snapdragon Lenovo T14s Gen6 can be bought with a number of different
>>>>> panels. This patch series adds support for the OLED model which has a
>>>>> Samsung ATNA40YK20 panel.
>>>>>
>>>>> With this patch series the backlight of the OLED eDP panel does not
>>>>> illuminate since the brightness is incorrectly read from the eDP panel
>>>>> as (to be clear this is not a regression). This is fixed in [0].
>>>>>
>>>>> [0]: https://lore.kernel.org/all/20250330-wip-obbardc-qcom-t14s-oled-panel-brightness-v6-1-84ad1cd1078a@linaro.org/
>>>>
>>>> It would be good to get OLED support for the T14s merged. Are you
>>>> planning on sending another revision of this series?
>>>
>>> No reply for over a month. Do you intend to respin these or should
>>> someone else take over?
>>>
>>> Neil, do you have the OLED version now?
>>
>> I'm not sure, how do I determine that ? Is there something specific in the type number ?
> 
> Yes, yours is the OLED version, the exact models stated above.

Ack thx, I'll test and re-spin this patchset then.

Neil

> 
> Cheers,
>       Rui
> 
>>
>> Neil
>>
>>>
>>>>> Christopher Obbard (3):
>>>>>         arm64: dts: qcom: x1e80100: add epd hpd pinctrl
>>>>>         arm64: dts: qcom: x1e78100-t14s: add hpd gpio to dp controller
>>>>
>>>>>         arm64: dts: qcom: x1e78100-t14s-oled: add edp panel
>>>>
>>>> Strictly speaking you could have posted this last patch on it's own as
>>>> it doesn't depend on adding the hpd pinctrl.
>>>
>>> Johan
> 
> 
> 


