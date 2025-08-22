Return-Path: <linux-kernel+bounces-781543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A80B313E4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84C74565B0F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E642F0C56;
	Fri, 22 Aug 2025 09:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a0a/ehrZ"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C7A2F8BF6
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 09:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755855332; cv=none; b=t7NCqq7psw47QsxCBlupVOp1WIuEPaTRUsSmpPeXGtFPXcoKuys5o513pSIqCK61T1GhD2Uo38nHARqMRy5Wndze2asMWlgOfEUa2jARUAXI7i74C3sBGluZx+s41akd/7IbpOmaaMt8hvjS09PgovafEyemPHXsi65BxSF0bLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755855332; c=relaxed/simple;
	bh=u2cVZCViLmM0qGu+nHCKy5aS4XNiSfo4aTc8MMywpew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UEBFOEgRmTAQluFDR8x1unj2ZawDXitX6BDjKZlH9R6ckELhGl93DMM17+sDYDdqm4nUCz5/X5XrslGG9RaZ5i425VapyqW/lCFzThmuvwccPQb4iU27ajASiRv0JQd58+HZmKpPvuD79dGJWwi/lt2FAHc66u/GFeHtn8fR/lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a0a/ehrZ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45a1b0c52f3so11420935e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 02:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755855328; x=1756460128; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OJkW9jOdewoj0W9ptZbkJ608Pxc0QK82I1kL9/NJC98=;
        b=a0a/ehrZdcTI55fygq5cj1TlhARWCwekzYiSa3ff47F148jFUzCGB7pG8EbKIRX/3L
         09Qf87e9fyhyUKcMRyVaucsY01MGoKg7XXFzCIzc3C4uifGkGTLzWxl9TJVwT2yqwoVQ
         z0BrgmUYFxeaAxQCJ5YhBQvm7i3TMsNzPmU81DjGuptv7bDXmlvTnOmsy+OlbHyW4AK2
         93kl/Qmsk4oVnuNu1mUbBVd5wVWHaflSWIeSV0efhA1LT5+Gzs2TTvxLSIxOOaGiuEfz
         zY9kJ2njTWMLDSaxqNbNh3PdP2kjGlZsA7MT9yykzZEh6pQIW1tKs+p2775xa7s0wsTL
         AfVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755855328; x=1756460128;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OJkW9jOdewoj0W9ptZbkJ608Pxc0QK82I1kL9/NJC98=;
        b=gFqucioUoNZB9Svu84JwoLPjkuPxdPg8cVho2IQSA5xhJOsfJSPgwj9S5uTq8vU8mD
         ylTPcW00Jpp4WucXdXyQaEMzVFLl5quF1HdZ0wHiNpU+OEyhebS8ithsLR8cWqwqxpVE
         daMh7NxyVPN+0zZ7wOM3Rcj1c8NEqfJ11Mrx4n/ZTnnnNC0MEocGV6MClwYRP6mt8ZAC
         +1cjkAr8YbJ0THpcvXwwCXyOrwUkG2F8bbG9XyQ40vcXyUN/9FoaO914ySmib8LgxYtM
         lZVnBrJ7guChBVc7IfYh5AZBXkudKbTEobtcvU7l5iHo2ZEpX/6RGalRYhycbs61AF1B
         aKWA==
X-Forwarded-Encrypted: i=1; AJvYcCWLTGjnpQmojQDvRi+VwIAHvTeiHm/NP6dzk7xQcdyBt9czru5v65yITbX1yyQlEwrOeUnnjcaO2+AJW6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH36YN6kXVuQHgr3PV1TTqeQJfSCH4PoFi4SC6d5RehWDlvnf+
	kNCm9Yna7eaDZjqD5wT5oX91nA2p4SubODceF9/5kFKrLyceGm5LpUR+2+Rj0Q5YTpU=
X-Gm-Gg: ASbGnctaQtWgd69VvaxEUwxhqAR8N2Qz1ZUJJIvHSLAblS47mwVrT9AV7z5RrcrziEH
	2vzbo0kn0ejoDPvbgRDxraSN4jbxtrXTpF+977UEMiEAJVUU48MzFFDTZKr23ZOj5P+MWj3pgg/
	SFmqswYFEoODPjPVrWQukzjUT84xD0rI0Xky/nY289HBh4ao0WbySnqPYeUeQHZPnJvK454CFCv
	V369sIoetsCELyDMNT/YLAfDX25QQNosWJTa1Z+133haaa5xxMn11YE5w+cppquhE7tbzBJfGom
	9QrrF3d5q0QW6BjusY3S7umdF5prIyylCP8hctg0i4/bUK8915k8BTu4VYJBfrUa0+U3Zm7E+cR
	t4825vWVYhhCSsT4YVNw3e4ISM8FNSWPoCHpqcwd7PndK2lhcBS5Z8UlQHnQKOgeebXnwDO90t/
	8=
X-Google-Smtp-Source: AGHT+IHLpgQ4dn+cM03lopM+8J38FUhN5HG9CkM9OhhaBf0+riVpwc8dRtPrCsKf5QsWgdRMaAlFJA==
X-Received: by 2002:a05:6000:288a:b0:3b7:92ca:2831 with SMTP id ffacd0b85a97d-3c5daa2800dmr1587093f8f.12.1755855327805;
        Fri, 22 Aug 2025 02:35:27 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:3dd7:7361:c101:6a77? ([2a01:e0a:3d9:2080:3dd7:7361:c101:6a77])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c0777892basm14547830f8f.56.2025.08.22.02.35.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Aug 2025 02:35:27 -0700 (PDT)
Message-ID: <9f6ee709-662e-4bd1-ac28-601bb530458c@linaro.org>
Date: Fri, 22 Aug 2025 11:35:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 01/10] arm64: dts: qcom: x1e80100: Add pinctrl template
 for eDP0 HPD
To: Stephan Gerhold <stephan.gerhold@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Aleksandrs Vinarskis <alex.vinarskis@gmail.com>,
 Abel Vesa <abel.vesa@linaro.org>, Xilin Wu <wuxilin123@gmail.com>,
 Jens Glathe <jens.glathe@oldschoolsolutions.biz>,
 Srinivas Kandagatla <srini@kernel.org>, Sibi Sankar
 <quic_sibis@quicinc.com>, Rajendra Nayak <quic_rjendra@quicinc.com>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20250822-x1e80100-add-edp-hpd-v2-0-6310176239a6@linaro.org>
 <20250822-x1e80100-add-edp-hpd-v2-1-6310176239a6@linaro.org>
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
In-Reply-To: <20250822-x1e80100-add-edp-hpd-v2-1-6310176239a6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/08/2025 11:28, Stephan Gerhold wrote:
> At the moment, we indirectly rely on the boot firmware to set up the
> pinctrl for the eDP HPD line coming from the internal display. If the boot
> firmware does not configure the display (e.g. because a different display
> is selected for output in the UEFI settings), then the display fails to
> come up and there are several errors in the kernel log:
> 
>   [drm:dpu_encoder_phys_vid_wait_for_commit_done:544] [dpu error]vblank timeout: 80020041
>   [drm:dpu_kms_wait_for_commit_done:524] [dpu error]wait for commit done returned -110
>   [drm:dpu_encoder_frame_done_timeout:2715] [dpu error]enc40 frame done timeout
>   ...
> 
> Add a new &edp0_hpd_default pinctrl template that can be used by boards to
> set up the eDP HPD pin correctly. All boards upstream so far need the same
> configuration; if a board needs a different configuration it can just avoid
> using this template and define a custom one in the board DT.
> 
> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/x1e80100.dtsi | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> index f293b13ecc0ce426661187ac793f147d12434fcb..32fa9fa6fb946c4933f74fd0ee820ecb9284901e 100644
> --- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> +++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> @@ -5808,6 +5808,12 @@ tlmm: pinctrl@f100000 {
>   			gpio-ranges = <&tlmm 0 0 239>;
>   			wakeup-parent = <&pdc>;
>   
> +			edp0_hpd_default: edp0-hpd-default-state {
> +				pins = "gpio119";
> +				function = "edp0_hot";
> +				bias-disable;
> +			};
> +
>   			qup_i2c0_data_clk: qup-i2c0-data-clk-state {
>   				/* SDA, SCL */
>   				pins = "gpio0", "gpio1";
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

