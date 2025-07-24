Return-Path: <linux-kernel+bounces-743805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2ED8B10380
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 10:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 829483B0600
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 08:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A036274B50;
	Thu, 24 Jul 2025 08:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="edpBLqTw"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5CD274B49
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 08:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753345583; cv=none; b=eQv8NyKVCuYhipW+3k9GBATm5b5XDKhBGXnkYzKtDdjsu5CcdnCicU1JJSL6BJMZl5MK6ScKS9UlQoJIb3mrcafuYyUhFVAyux+2AVDQWmaTHvZeJXv3euxVsCOOxJJgf7h3vcZn5uDEtMQ2G0kPEd4Pwbl1fgUweGruka5MBzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753345583; c=relaxed/simple;
	bh=nl+6DslWkdknEma/1FpgDAcjZ5mCaQrKJgFsrcaUu04=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=I9zzp2ntzZpvSiWMAHXNcV01gb7byW3aEP+lVC7LHbBENOXiO8R+oYXzl0aD+L+qymj8aj1/C+wq42vI9PbW0uGjjTcS8GwEMgGwX7wh79bno9cNs/kkDMp2xpFyimDh6syKx4m6vyNeoUn/ZSf60lTL3QbmABk0KucFHzF/LVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=edpBLqTw; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-455b002833bso2883025e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 01:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753345579; x=1753950379; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p+qr0F23e5u4tMQJsE/K/fpOfgQdON5nkMPyqMgykI8=;
        b=edpBLqTwbS/CC8CfMSTuq00neIeuYG6hFbS1BHGXzAkwD8GRtY0lO2pAY6MXZBgkmS
         +yOFvHzDUWz7KlqkDdy48flIXT9vEBfYCKWt6EUHWlrhLRTofqG2B1+/Ac/rUorxnpwt
         UIOvHB2yVD3STh1udQueorPss5Oq6CDB8Jv4Yrgz1KM3wBcF50ts//a4xwyHltLw/wuR
         UO7mSjhnYyMsG8Ssj0WT7jcp3rK0Jrp33ZAMHHLWSAUch+Mn3LqX+yPUBbG6JbqcENTE
         i90A8qIUf58wxbWvOXeaiDca2Q5i0bSxN8R8u5Xx+MOopXBwefNDwWJ/TBfXe4zIo/g5
         QheA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753345579; x=1753950379;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p+qr0F23e5u4tMQJsE/K/fpOfgQdON5nkMPyqMgykI8=;
        b=lOnATK3enI2E9P4qZVIKdiZFf+ZiCJUCSHWsi2N2nVTcwRSO3YBRISSm3UR2/dMw9x
         nQ5e+Rn7+nn4Kw0/fc0TuD2hbbLWq2JTk29EgwI68NF/jvQHuYgzYvz6jN/a1L2xsI4J
         k20Ws+PwPAdLjqWBOdezMaj6tr1eRqclkgZlf0iczVGvNpiMxWzEiC+jT2xZLYKk4ti9
         C2lF/5otPEQpu708k/baK31uIJqmkWjezKtV1bTOusqUxWnUd7J+tUz82gRWyqyQyCBH
         wzuo03GcpuoCVvtsrgjKuNwuGcMpp9l9r/TYFOkZwM1qqg8XN9QC2DuW6/RCDwkNWEBI
         Pq6g==
X-Forwarded-Encrypted: i=1; AJvYcCVawfH5XwKYQy9AZwjFW1x+xwKurxes/eMyx6dQvw7hGpX3dxmWBMrW1yLkEgFWKfhq210PN1k5W2CG9OI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO/oPxajc6KrPE3sbw//C5GsmUjlfAAgiTAiguXsyaiBO6eMoF
	IQ83UL35RIZxME8/J7lkxnZntn8Sr9JFhtiUyfSv/JoHaLe3Cq0Msei2ToWZEF1EJ1w=
X-Gm-Gg: ASbGnctetSyaKRZvE471f9DvzENmPmylcUWdj1lN5/Om5pm02TGOsjwwYIvdNv4IIQP
	qT/XtaPlyVzCeh86WuK6dJPEOyJIspC9ArgFkWG7oCbD1g7iYkLdlh+8+oaqNP9pNAKqQ/8p/JN
	Q9SEw0jqI/MYvVV+FzslGz9FoopSmuSgy36Q/zMR6j1jHADClWoJw61Xk0ISKyckhZb08aygSAS
	t3FiZATtSaFs+lUW9p4K8uK7DJlajdUbCwXSfPAt9QW9lIHyk7amhev6V5AoDKRUjpIcuBNnteg
	Q6SetplH3XVEgBdzjiCe4NsdiE5DPC9t4CKDzWyskcyVGUD1UyQidrMKTxUjDlr2OGOL6+P5AdZ
	tNhs1ZkDKXcg7n3Bwa6eynVHfvIc1Yrgp
X-Google-Smtp-Source: AGHT+IGTvw2r1ZkAjtPeWV/yG76d/Vji9taNRA/Wmxkm4UGIwrCCLgWEqwuwDjAwl8Njt6FkI3kJVw==
X-Received: by 2002:a05:600d:4:b0:439:9b2a:1b2f with SMTP id 5b1f17b1804b1-4586974aeccmr46225235e9.3.1753345578879;
        Thu, 24 Jul 2025 01:26:18 -0700 (PDT)
Received: from [172.20.10.3] ([78.246.240.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4586f88cfe3sm8750465e9.0.2025.07.24.01.26.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 01:26:18 -0700 (PDT)
Message-ID: <93d80822-afa0-4bff-9e73-3ece36e8c23a@linaro.org>
Date: Thu, 24 Jul 2025 10:26:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 03/23] arm64: dts: qcom: sm8650: use dedicated audioreach
 dtsi
To: srinivas.kandagatla@oss.qualcomm.com, andersson@kernel.org,
 konradybcio@kernel.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250723222737.35561-1-srinivas.kandagatla@oss.qualcomm.com>
 <20250723222737.35561-4-srinivas.kandagatla@oss.qualcomm.com>
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
In-Reply-To: <20250723222737.35561-4-srinivas.kandagatla@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/07/2025 00:27, srinivas.kandagatla@oss.qualcomm.com wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> 
> Make use of audioreach-audio.dtsi and remove the gpr nodes from SoC dtsi.
> This move removes duplication.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> ---
>   arch/arm64/boot/dts/qcom/sm8650-audio.dtsi | 10 +++++
>   arch/arm64/boot/dts/qcom/sm8650-hdk.dts    |  1 +
>   arch/arm64/boot/dts/qcom/sm8650-mtp.dts    |  1 +
>   arch/arm64/boot/dts/qcom/sm8650-qrd.dts    |  1 +
>   arch/arm64/boot/dts/qcom/sm8650.dtsi       | 43 ++--------------------
>   5 files changed, 16 insertions(+), 40 deletions(-)
>   create mode 100644 arch/arm64/boot/dts/qcom/sm8650-audio.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8650-audio.dtsi b/arch/arm64/boot/dts/qcom/sm8650-audio.dtsi
> new file mode 100644
> index 000000000000..14ae50e72e4b
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sm8650-audio.dtsi
> @@ -0,0 +1,10 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +#include "audioreach-audio.dtsi"
> +
> +&q6apmdai{
> +	iommus = <&apps_smmu 0x1001 0x80>,
> +		 <&apps_smmu 0x1061 0x0>;

As patch 1 comment, I'm not fan either of this intermediate dtsi, or perhaps there's
some bigger plans for those files ?

Anyway per-se, it's not necessary and it should be in the SoC dtsi.

Thanks,
Neil

> +};
> diff --git a/arch/arm64/boot/dts/qcom/sm8650-hdk.dts b/arch/arm64/boot/dts/qcom/sm8650-hdk.dts
> index 259649d7dcd7..94fa52437d79 100644
> --- a/arch/arm64/boot/dts/qcom/sm8650-hdk.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8650-hdk.dts
> @@ -8,6 +8,7 @@
>   #include <dt-bindings/leds/common.h>
>   #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>   #include "sm8650.dtsi"
> +#include "sm8650-audio.dtsi"
>   #include "pm8010.dtsi"
>   #include "pm8550.dtsi"
>   #include "pm8550b.dtsi"
> diff --git a/arch/arm64/boot/dts/qcom/sm8650-mtp.dts b/arch/arm64/boot/dts/qcom/sm8650-mtp.dts
> index 8a957adbfb38..07e62918422e 100644
> --- a/arch/arm64/boot/dts/qcom/sm8650-mtp.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8650-mtp.dts
> @@ -7,6 +7,7 @@
>   
>   #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>   #include "sm8650.dtsi"
> +#include "sm8650-audio.dtsi"
>   #include "pm8010.dtsi"
>   #include "pm8550.dtsi"
>   #include "pm8550b.dtsi"
> diff --git a/arch/arm64/boot/dts/qcom/sm8650-qrd.dts b/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
> index 7552d5d3fb40..7f26095e6f07 100644
> --- a/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
> @@ -8,6 +8,7 @@
>   #include <dt-bindings/leds/common.h>
>   #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>   #include "sm8650.dtsi"
> +#include "sm8650-audio.dtsi"
>   #include "pm8010.dtsi"
>   #include "pm8550.dtsi"
>   #include "pm8550b.dtsi"
> diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
> index e14d3d778b71..5212000bf34c 100644
> --- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
> @@ -23,7 +23,6 @@
>   #include <dt-bindings/power/qcom,rpmhpd.h>
>   #include <dt-bindings/power/qcom-rpmpd.h>
>   #include <dt-bindings/reset/qcom,sm8650-gpucc.h>
> -#include <dt-bindings/soc/qcom,gpr.h>
>   #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>   #include <dt-bindings/sound/qcom,q6dsp-lpass-ports.h>
>   #include <dt-bindings/thermal/thermal.h>
> @@ -4447,6 +4446,9 @@ IPCC_MPROC_SIGNAL_GLINK_QMP
>   
>   				label = "lpass";
>   
> +				gpr: gpr {
> +				};
> +
>   				fastrpc {
>   					compatible = "qcom,fastrpc";
>   
> @@ -4506,45 +4508,6 @@ compute-cb@7 {
>   					};
>   				};
>   
> -				gpr {
> -					compatible = "qcom,gpr";
> -					qcom,glink-channels = "adsp_apps";
> -					qcom,domain = <GPR_DOMAIN_ID_ADSP>;
> -					qcom,intents = <512 20>;
> -					#address-cells = <1>;
> -					#size-cells = <0>;
> -
> -					q6apm: service@1 {
> -						compatible = "qcom,q6apm";
> -						reg = <GPR_APM_MODULE_IID>;
> -						#sound-dai-cells = <0>;
> -						qcom,protection-domain = "avs/audio",
> -									 "msm/adsp/audio_pd";
> -
> -						q6apmbedai: bedais {
> -							compatible = "qcom,q6apm-lpass-dais";
> -							#sound-dai-cells = <1>;
> -						};
> -
> -						q6apmdai: dais {
> -							compatible = "qcom,q6apm-dais";
> -							iommus = <&apps_smmu 0x1001 0x80>,
> -								 <&apps_smmu 0x1061 0x0>;
> -						};
> -					};
> -
> -					q6prm: service@2 {
> -						compatible = "qcom,q6prm";
> -						reg = <GPR_PRM_MODULE_IID>;
> -						qcom,protection-domain = "avs/audio",
> -									 "msm/adsp/audio_pd";
> -
> -						q6prmcc: clock-controller {
> -							compatible = "qcom,q6prm-lpass-clocks";
> -							#clock-cells = <2>;
> -						};
> -					};
> -				};
>   			};
>   		};
>   


