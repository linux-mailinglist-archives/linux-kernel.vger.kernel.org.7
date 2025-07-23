Return-Path: <linux-kernel+bounces-741958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F8FB0EB3A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 09:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84C231C82225
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 07:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E2826B96A;
	Wed, 23 Jul 2025 07:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QsvCMDFH"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B418B12FF6F
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 07:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753254225; cv=none; b=juQ9/ufK2gwhsYly4236R0s2R+t+kGdWdmuwoCFx7CVZu9oIxGTyh4TtBiyJGo/oA/Mzmsl1cANELgP8lqUFtrMHR+r7O89nKR27iWdXWMhdDGaro+LnnJdzHkz702jHWhMSqhvV0iYHa9g2Vc72Qjij7AKFx0ho12ivfFrkrqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753254225; c=relaxed/simple;
	bh=xcFUVVpNCBzMypdo6a0Agk2cgD1dPOWvoVB/3YhwBIM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=IN4Vs+s0iB4h2b0vrqCC9BCzAvfeJUEE69bvgYeQU80BRtx3ziQ+0J/gcZEw/J/2WHTo6hR9Z3bC+QbIogDknj38VShsFCHBwL5153fgGGzqYgUIXmJ5Bm4Nh8RTPKKZK8ioODSGnlXo5LYkjhljp5JuOMCQ0Ikf8yp41y2ySoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QsvCMDFH; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4561514c7f0so64918025e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 00:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753254222; x=1753859022; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O/Mv9hJ7CADfZdG1vjDLpd9cy/jj2sy/v75wb10UpHw=;
        b=QsvCMDFHxaPsc4NONtSWNpXEegGBOjXBMm/BT1o6oewNvIVFG3ZYGC26EStATTsWTm
         1afqiF5X+2bQyOQIiDInefloufMq1mcQsazmt2YLMaKFlVj2A4eo4HFl7a3zbdd5Ll7y
         WJC14mHfDBqu/nYoG+IJ1FNxb3XamURFdo6WapiBsx0QjIht+j15fQY3nlRcXLA6qn56
         b8wVVnMviICL788yhPXpvf+7/5j5Sne+3eocsJXpKjYfKehEfwkDPXID8O8DmGxpoBVw
         d9nHr2y0dnB+8UCei/2GhCAYzPyksbX6NYUBfzLSJfVZWm0g2Kc3rqhtiwemKnPxIOHH
         21WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753254222; x=1753859022;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=O/Mv9hJ7CADfZdG1vjDLpd9cy/jj2sy/v75wb10UpHw=;
        b=K4YHiecAatyanWEgwyB/LcUj0qQUI+nqxOs7UCzsh7/d2BFbhkQ0wQHg7bP3L1FKOi
         HKSv7lpG9erlnD0p44GXfBpW8/Wq4EKL3ft5XONaAaajP60eaZlJjPibgEoXs8U+JTgk
         zzgsbUww7Si1UYKdsEQTShtLl//HPV/m/aXKnUmcT57QdBdt5/FF8b14KCdVncpsz9WL
         b1ADq+e0IZ8dK3yBMseRxwShXFtMjXseJQd/Dcn/VmcASxJqd8pGoINXdMhqOnE2wPcV
         VHO8XIEasVfVgaBmrqpRLMp1tCs5Dh0Bp3qGQFgU96uGB9TZMHS0nvG2rknxmo9Tr+TD
         f0Vw==
X-Forwarded-Encrypted: i=1; AJvYcCUP3MOfGkgAtrcLWcmyoLbnXspLIb6aIsfx70kxkXjnX1bEHTsrDf4VCN64OxKUCRzww2+/spTUK26BtZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YynjRwVVGKWv5ssQGx47hPVKNEMcghx2uHGur/J2a0PR/SrjeGf
	QKiDLkVUAz1VcUbUmdbJyGwjuetiaiqw5buLCWLGx6akRs9iC0S95Jv0yB9sdvGQNR8=
X-Gm-Gg: ASbGnctNVRrrVcW1GZ1I6dOPCYD5ZwWjAtGUoh+PHmapkdlkQjW/lWMvf+svlFN4+Gu
	muhL1vl1gYUmgQ7vop7qNFtMtfk0a9jN+b+hpI18EmsuHPOaI5e/4eQqp/aYsqqiDV//Ebo53DD
	TFDVZTBLCCznRXsL0J4qau06U9two8LWaDPKpPftiyfG0M6OQKQaLeSBrEXjASLkPydDPRFksZs
	IU5F7YvKJHk/b1wgYuxBHKuvcnKCfS4Zno5fOdjXz6qyZ3EDwuWB+rqfJMO+t2IH2FHOmO61jJT
	WdGpTO1gEu5HFxkfAaJlUPgPNuADPilka7KrCtTSgS2mEoV+Z48mgXmZFtDU5kSsWae+HhIbNTY
	Iy5IciFQ9SoveNQx05KqS6JVk260qoMdP16Rf0SDePcoodZyU7Pfr+csJFzZaF0B7xpTEzWx9H2
	XifFueTV2xXQ==
X-Google-Smtp-Source: AGHT+IGS53ymu9qWaAuGjwDNEKZnmHcq4dCaL9RMrzf74MJb80sfF+LLy2tGg+h9gGlfS5OVufoOcw==
X-Received: by 2002:a05:600c:5185:b0:454:ab1a:8c39 with SMTP id 5b1f17b1804b1-45868d2dfddmr11464645e9.26.1753254221959;
        Wed, 23 Jul 2025 00:03:41 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:8813:2f0d:f9e0:5294? ([2a01:e0a:3d9:2080:8813:2f0d:f9e0:5294])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458691993d3sm13152435e9.10.2025.07.23.00.03.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 00:03:41 -0700 (PDT)
Message-ID: <bc65cf3e-22ca-4383-bf7a-24a3d343eb26@linaro.org>
Date: Wed, 23 Jul 2025 09:03:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v5 1/3] arm64: dts: qcom: x1e80100: add epd hpd pinctrl
To: Johan Hovold <johan@kernel.org>,
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
 <20250402-wip-obbardc-qcom-t14s-oled-panel-v5-1-ff33f4d0020f@linaro.org>
 <Z_kB3jOH04-zFnym@hovoldconsulting.com>
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
In-Reply-To: <Z_kB3jOH04-zFnym@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/04/2025 13:49, Johan Hovold wrote:
> On Wed, Apr 02, 2025 at 03:36:32PM +0100, Christopher Obbard wrote:
>> Add edp_hpd_active pinctrl to the X1E80100 device tree.
> 
> Please squash this one with the patch adding the user.
>   
>> Signed-off-by: Christopher Obbard <christopher.obbard@linaro.org>
>> ---
>>   arch/arm64/boot/dts/qcom/x1e80100.dtsi | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
>> index 46b79fce92c90d969e3de48bc88e27915d1592bb..5b1b80c445404fd02e9f6e5dab207610b03ff9c5 100644
>> --- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
>> @@ -6389,6 +6389,11 @@ data-pins {
>>   					bias-pull-up;
>>   				};
>>   			};
>> +
>> +			edp_hpd_active: edp-hpd-active-state {
> 
> Please keep the nodes sorted by name.
> 
>> +				pins = "gpio119";
>> +				function = "edp_hot";
> 
> There is no "edp_hot" function on x1e so I wonder how this has been
> tested.
> 
> As I mentioned in a comment to an earlier revision this pin has been
> configured by the firmware as "edp0_hot".

With edp_hot, screen stays black with UI comes up, with edp0_hot it works again.

> 
> Since there is also an "edp1_hot" pin, this needs to be reflected in the
> node name and label.
> 
> Pin configurations really do belong in board files, but unfortunately
> this was not followed for x1e. You should still include the bias
> configuration (somewhere).

Which bias ? do this pin config needs an additional bias config ?

Neil

> 
>> +			};
>>   		};
>>   
>>   		stm@10002000 {
> 
> Johan


