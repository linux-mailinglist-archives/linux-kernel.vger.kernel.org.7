Return-Path: <linux-kernel+bounces-781453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E12DB312AC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B4BE1CE5A10
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8501B137750;
	Fri, 22 Aug 2025 09:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QGKqcEWQ"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDAA393DF1
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 09:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755854141; cv=none; b=FtyU213ma1NduEJ63CEBpqAghG6+AI1IRi8cx9s+T90OjujUGuNXmiMn3qq75C51KNt74U+UrtwYTu0DwZoRkG1cREvRGn4LIiPHjicX7WT4PJe8CAiJELGzuHMAgXQ5kTTg3L+pirtvpA/iFmuH3RDce8sbvs4It7EUVk9i7d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755854141; c=relaxed/simple;
	bh=67quhyAVURtfXAvI5qZ+yhWFpelxcQR0uV33pnuuydM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=oihsP3Yhck3zfigm+CHOms/o2O+7O4PnkZrK4ZtGSEugXooWplI1H/Qx1zDBzyUMtYtqNZ5Zc7Gg8PEp70+wjmRC8CsD9Nz87SD7m8i8cI6uawdVqyOhy303CnqfiS/gOLHicNnNKkxkrV75QW354ISYwtfYIZxx3/yLyYpEG6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QGKqcEWQ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45a1b0990b2so14164015e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 02:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755854138; x=1756458938; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NGpPFRfpj+k+209KhRHwNeakdQDjhN17yXLode2Nb/4=;
        b=QGKqcEWQ4Mp1oN56nFADnvX76jSjdFUPAw6g8QlF5tRe3kb2S8GXhoSTlCvAEljntN
         dju+EE03Q0xNTzF6JUBknc6yu2ydDceMDGwFtIdicjM6Ri+ShdFtQYDl22DAFc6bXO3H
         9VkzRPFBxrx79ULBwOVGqeWEjAYbeqja/CN9+hgkxZULfwnyuuvMtRBcSnivn1udm7gR
         Gl5ZWB0/ZeP3WWjNomDuofbSUDzZ8NumFvCCV81FbGhJH7jVoCqIWZmlrllS8jqHDbsb
         bZp+032aiy9bsh62+HYd3SmW9kBqusDcNz57pcylkempBWISi+EX7ecAhPmkjJg7j6jc
         twPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755854138; x=1756458938;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NGpPFRfpj+k+209KhRHwNeakdQDjhN17yXLode2Nb/4=;
        b=vqnyiGIFegO2ls641dcL07e4xtDHS+u0Fd2/NAflhUKkGnzQo+52GAysEPPsAfziZp
         Fj1GGSXxi4TjqUc3cqyHCMQC27FckNxgoiC1NDCYqBLyUMMlDsm4u0VRpccqbCoLhmmV
         XhawgBEJQFRNcgeTg35MCRsMTs6wXXwORp683BODQtD/am9TC79KEaejtJrm2KVSOrE9
         ZVARnudlxL/wRMlAA1y4vyRfe062kEAIGhtNMj80pgVtzX4Yx8ETpP+72C2XQWe4Zy3M
         pr7UFi+cRwlsgMuWH2rCZhDST79+nJslbOtvXlF9vbzRjVPrbaI0uDDHaK5/jACnrnoD
         kSew==
X-Forwarded-Encrypted: i=1; AJvYcCV2Ty9+C4zjRIsyxsUZRJqBvh3Y4+8v+coyhdTwvt/0rCQV2Gt/E+ppYwVbOr8NU7ki8yaXxhaQX0CR/MM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4zVhsCdqSLBKHV6WkWLc9z7IhHqKdWKCmQ4A6reU7kjUIIqDT
	WVwT7rBg5dzJG6P8PpjcMHh2aUvo7dDp9tIxV9rBbtW0E1IbEvWrGYAjukHaru8IhBQieXvxLM9
	w+ay/4wI=
X-Gm-Gg: ASbGncs0N5LBd+JNFx8Wvxu5VtAXEUFTUeApvfDuSvzIy5I0poiaM+fGmyRBBVe4eV8
	sHjaT7E3TcroBnqT421QJrdnS0i0Q6grulbo2g5fKOqfjHdZ2f94423ZSSToX0XeV6rsp47FtHl
	RVrPouu4BR0e3bJB0cRy6ehHs30FwhrDzJXxg8K8ZAnqhI2NH+hjfMMkQvHaFjPDCLq0PD4TIG0
	1PoRZkIvF6iglRkD6DmiX4eqmIJiMaDWTwF1efCi+ms5xI3kaa2keuS2xJpWpCUzEglc0PcY2N6
	N+Z+G+L2Uhwcpd9Zg5IcllYnZGlSuecpeMVH9DBLcCLtdERFF5BY1X0hX68CZR+vYU2Q4wroj8H
	06vF3PLGcZxJO4pcKo0MjEvr+RhL1dFm/ahc6pNOUlYxGvpWIABzK8iqzZL7hDdK+2wUYovPDHk
	o=
X-Google-Smtp-Source: AGHT+IF6MiE5xPg9MihtExsD8an9MDPxTItFLL+t2cF0hyrhB6S/GPbejDFdhHauuLqGnFd5oYU4WQ==
X-Received: by 2002:a05:6000:26c1:b0:3b8:f864:2fec with SMTP id ffacd0b85a97d-3c5dac1706emr1452253f8f.2.1755854138179;
        Fri, 22 Aug 2025 02:15:38 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:3dd7:7361:c101:6a77? ([2a01:e0a:3d9:2080:3dd7:7361:c101:6a77])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c26fce3930sm12091681f8f.29.2025.08.22.02.15.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Aug 2025 02:15:37 -0700 (PDT)
Message-ID: <0f64e926-8b9e-45ee-b635-d6aeb9c75d9a@linaro.org>
Date: Fri, 22 Aug 2025 11:15:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 5/6] arm64: dts: qcom: sm8550: Additionally manage MXC
 power domain in camcc
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jagadeesh Kona <quic_jkona@quicinc.com>,
 Dmitry Baryshkov <lumag@kernel.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Taniya Das <quic_tdas@quicinc.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
References: <20250821-topic-sm8x50-upstream-pll-multi-pd-voting-dt-v1-0-a510c72da096@linaro.org>
 <20250821-topic-sm8x50-upstream-pll-multi-pd-voting-dt-v1-5-a510c72da096@linaro.org>
 <eaxppztxjggd7kdg3p5actz5rcsiy7czw7lnv5jrvnab26gxdj@pwmwlupaievv>
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
In-Reply-To: <eaxppztxjggd7kdg3p5actz5rcsiy7czw7lnv5jrvnab26gxdj@pwmwlupaievv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/08/2025 12:19, Dmitry Baryshkov wrote:
> On Thu, Aug 21, 2025 at 09:16:38AM +0200, Neil Armstrong wrote:
>> From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
>>
>> Camcc requires both MMCX and MXC rails to be powered ON to configure
>> the camera PLLs on SM8550 platform. Hence add MXC power domain to
>> camcc node on SM8550. While at it, update SM8550_MMCX macro to RPMHPD_MMCX
>> to align towards common macros.
> 
> The last phrase no longer applies.

Ack will fixup

> 
>>
>> Fixes: e271b59e39a6f ("arm64: dts: qcom: sm8550: Add camera clock controller")
>> Reviewed-by: Taniya Das <quic_tdas@quicinc.com>
>> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>> Signed-off-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
>> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   arch/arm64/boot/dts/qcom/sm8550.dtsi | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
>> index d4bffcc244c98e87464cb2a4075c21f3cd368482..54ea21e1778a7c104cdf6865f84a7f8b5a8691ca 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
>> @@ -3625,8 +3625,10 @@ camcc: clock-controller@ade0000 {
>>   				 <&bi_tcxo_div2>,
>>   				 <&bi_tcxo_ao_div2>,
>>   				 <&sleep_clk>;
>> -			power-domains = <&rpmhpd RPMHPD_MMCX>;
>> -			required-opps = <&rpmhpd_opp_low_svs>;
>> +			power-domains = <&rpmhpd RPMHPD_MMCX>,
>> +					<&rpmhpd RPMHPD_MXC>;
>> +			required-opps = <&rpmhpd_opp_low_svs>,
>> +					<&rpmhpd_opp_low_svs>;
>>   			#clock-cells = <1>;
>>   			#reset-cells = <1>;
>>   			#power-domain-cells = <1>;
>>
>> -- 
>> 2.34.1
>>
> 


