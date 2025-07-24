Return-Path: <linux-kernel+bounces-743792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB73B10361
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 10:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79BB15A1BDA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 08:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652822749F9;
	Thu, 24 Jul 2025 08:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y09Qmn33"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2723C2749CF
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 08:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753345210; cv=none; b=H36TS/Z+M5yo4iBJSs+SYf7lZI78q/H9iwTqTokgmMpGVfndwWH0H73iCk1hXxIebFlIwMUOoES7YMg8azkkOqGzYXlZ49ibyjZ7oeRyrDA5xLg69C+m4MoofieKMpOFQrFGODdVurfNSDtLriZ7p3E8y2z+n3Dn1L1hBsziMZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753345210; c=relaxed/simple;
	bh=zdjUOV5VLfUOfX2jC9gvpXSoRGzu77A6WDjzl1O8nQ8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Id76oGvTCDBmJIG/viQla93HuiK2zN/WFE9fjJVQtL7DT5eVJELs9fu0wrHdvMbyOxHeaFaseonQZHElnCrQcIyKBvICpJjUTYJjvxyfd7DXNASzrFohCoq60HIRtxe/bOxwtwJpfh7yh4kyUicra5wtodNCqefBXnD2a0dtfLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y09Qmn33; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b611665b96so407341f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 01:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753345206; x=1753950006; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7FdmlstLnkttVYH+Av5Wxpm50CkHTFn7Ud/HRCiiFb0=;
        b=y09Qmn33Yf/W6u1vtuFTxWrNLOj9RxDvPsuIYx+RA4ODSMombJc/9/NZFtMeDoddRg
         xuQYjlMJA3+v58PIsDv4JJEl2pdDClog7/eqxFVoj6JMoF28eAFHl+1GldT5b/EDkGYF
         HsvSfh+nk3aNgDTSTpxTezhj/d54zu8voEEEMO4sCErtKqYNiW+1tumGksfySb+rNyp3
         8K5PBr5hVA90F0vxCfflWOHsLrpo+I8kWv4u8U0sl38xG0ZaZdabf0Ilnpuv5pHWvGIF
         ICLJS87zM6zTybPtembdwLzGh/mHrWbg5i++04n+yBT155AR4n/KI+B2v3UtpIovZEIT
         x+xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753345206; x=1753950006;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7FdmlstLnkttVYH+Av5Wxpm50CkHTFn7Ud/HRCiiFb0=;
        b=hMn+cMCaIb7B+/yWz+S8hrjsK97LvRWTAtq2RvEF3DvtZVTG4YRNAQInXvYRkQUNIk
         aw/KEjFGjFoezW3VN49WI/gWF8RBPdLrFWVg1Dbt168xp+GWdgLeIlW3h2mQs477NxLE
         6j8hHUwkif54LmTuzAE5qbsHRZ7FDy356wHPAtVdhTlxi7SyNAhRLIhwEk9csIhggtqv
         LqWlAtc15Kh8UAKCFUUod0yeMT2U/P2BEvu/tc6LxQHx7E19vICi5SDcPdIqNJbIBgc0
         Y6WL8qAs36JXgsAtINDcE2edU9+D9SWRpPbB1RW4qUjxht9DdixvCA0h9OtKYLEF89CE
         sFVA==
X-Forwarded-Encrypted: i=1; AJvYcCU/8QH24h6nM8+oHghsOf37/cOCDCQq1rVVpFjJiHYEyMhWbfazANsw3IYJmhgxyvmQCa190TeruqHvYs0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+zexBjV/FYOlzkL80uL9X0iDFpV3LQ5//5hxFlayF16Z3SM4x
	FEcYYYzcqROdWN5OnrSZBvxrj19HJW79BFr3Mi3iazE77b89zSM57zpW7NVdMWuvjwc=
X-Gm-Gg: ASbGnctmZzp1dbm8lART4y9Aaz5siiZ1Jx8pfzjW37l6nsMOBkxLEwwqjJxLb9gGGqs
	5c1VNrNdtkpmSV6Sq/FXrXYvZfvAA576Z7OJfcPVqWPsAHgPkqjfZ7kLhSXN1Bnot9x8uBGl39z
	AlMHuNKpa1oVbmYN3iphizCcy/LZIfGIHqdwfDRb16R56k0hvVH2mYbj77V+4Ejswdz5ppS3JEo
	qnObHP6sOg45xEM7eIDuSaKTMOOZaUbYARd6koUIVTPjgpl3eJnDV3x2rG5JjfRnW8ZRc7kg7Lq
	D+YJMcx8OYxwhFTsf6Pi5gqJnERmP0bjsVOcx/ierWwIUdwDEeALTOhvyQBcQGYDSr9ByrMDTjy
	FW3Z6hm9WTlY3mlQDDr+3V5+avq0lzir8
X-Google-Smtp-Source: AGHT+IGHiElzTF/gXef/+TO8x62wPd+zvsVrwxUQ5wkCAUo0PV/PAIhvByy+nqqydTSRIhHh52MS9g==
X-Received: by 2002:a05:6000:40da:b0:3a4:ee3f:8e1e with SMTP id ffacd0b85a97d-3b768f026fdmr4924247f8f.39.1753345206330;
        Thu, 24 Jul 2025 01:20:06 -0700 (PDT)
Received: from [172.20.10.3] ([78.246.240.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b76fc71437sm1382862f8f.29.2025.07.24.01.20.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 01:20:05 -0700 (PDT)
Message-ID: <f36b7706-5b92-4187-986a-8dd8378051cc@linaro.org>
Date: Thu, 24 Jul 2025 10:20:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 21/23] arm64: dts: qcom: sm8550: add sound prefix for wsa2
To: srinivas.kandagatla@oss.qualcomm.com, andersson@kernel.org,
 konradybcio@kernel.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250723222737.35561-1-srinivas.kandagatla@oss.qualcomm.com>
 <20250723222737.35561-22-srinivas.kandagatla@oss.qualcomm.com>
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
In-Reply-To: <20250723222737.35561-22-srinivas.kandagatla@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 24/07/2025 00:27, srinivas.kandagatla@oss.qualcomm.com wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> 
> WSA and WSA2 are two instances of WSA codec macro, this can lead
> dupicate dapm widgets and mixers resulting in failing to probe


duplicate

> soundcard if both of these instances are part of the dai-link.
> 
> Correct way to address this is to add sound-name-prefix to WSA2
> instances to avoid such confilcting mixers and dapm widgets.

conflicting

> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> ---
>   arch/arm64/boot/dts/qcom/sm8550.dtsi | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> index d35d2b9b438d..5f748f6eb27a 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> @@ -2811,6 +2811,7 @@ lpass_wsa2macro: codec@6aa0000 {
>   			#clock-cells = <0>;
>   			clock-output-names = "wsa2-mclk";
>   			#sound-dai-cells = <1>;
> +			sound-name-prefix = "WSA2";
>   		};
>   
>   		swr3: soundwire@6ab0000 {


Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

