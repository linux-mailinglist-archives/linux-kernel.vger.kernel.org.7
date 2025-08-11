Return-Path: <linux-kernel+bounces-761988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 359C8B200CA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 871EC3B84DC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 07:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400F9285078;
	Mon, 11 Aug 2025 07:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jR4thrEb"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7582652B2
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 07:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754898666; cv=none; b=hBml5NAz8SeEQx4hXpJPocYrcLErUR8vuNWqEz8+jKpt9G/gBTJYbLNngszY7PdJ9cvVzBDTBfn80iXSUx/4SsQWuwCFiDirm59cE5qMbCSh2N24vrL0ypI7GoVj8k0/VlXoxcZ4X9wlEgMVSNmJtAaQnvpC4EfwkfKTi/sKLRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754898666; c=relaxed/simple;
	bh=v625ymQxFS+YCBJDvagQuBLz+d89QJreJSRQKzXaYps=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=mRuYaRH29XLj9300t5k1753NwRk9lFHxWkm6KG5JNevKNoMET0bqXyPbSwN7g+F1EtRvZ3XWpXj+RIxzDFmU3hmzOAv0yVxOnKi5ywZfx1csS2PBBmzMsTE7Ak3PkQ/3BF3l+QFev/nYn+smd+zClB34LIwW8ZyJZV9o3ajpY+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jR4thrEb; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45994a72356so31634135e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 00:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754898663; x=1755503463; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SCxvGReB/YdPK1TB+jaxnIWUKnSdJ0qulaewLmYALDA=;
        b=jR4thrEbD1wq0fBAcWnhk/RnP4klbCJUBUA8JSiWwrp3txhbQwbnTzSGLgE8PCYFsK
         C42DzOTEGfNpMEJGTJoc9+UyZ9ObyH1dzhGTt58Gudl0SBwNkf/o/CvbKsQgXp14Mx4M
         QMe8NoqvSA5zDVTgjZCIL60oUkowxZ2tjfZH8aW1r2ihcZUSga3M/2vPnGxHRL+MgQwq
         x/ZHcG9/kT4OyEMJol5oGK5esTIKVA5+7aWF96rkjz2EArQ+de6NpPO91VM2nkdS0kJm
         m0ZFjqPRKVxOfz9MWwFzjmDw719L1iiKi+gKaUMbPwq9CRtPP3l+0/uLxrvt5dZmPGEk
         DsrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754898663; x=1755503463;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SCxvGReB/YdPK1TB+jaxnIWUKnSdJ0qulaewLmYALDA=;
        b=dJLb+tePSo2JU5yxo9aUUyg33MVeUCHVT2tOtUoJujpdLIYdHsjLimOrBY9jwHWju3
         flJRPiq1kVA+cuPcheV4Jm5D418SXflFAYQAk0BFFwnWDefVjNZsyRQSfcyHbNcGRAuW
         5SxDSJ/jT49Ldh+hMtE4KdKLYVwKJeYwTLof7lT7OV+tBdkGJ4xzIijzoSVRU7E7cugV
         Hsv2P6xwuDkFZ1CKa+Shcr0QfOhZd4Bc347YMsDuID9FOQx9DB4fQEo2lYHALzpSJRgz
         REI09T2i/Pc/+i2BCSth1OrUl+0gg2DM65fiB/VUu6wT2cxFwMpxW+RSWe+7Gj8JUk/W
         T2ig==
X-Forwarded-Encrypted: i=1; AJvYcCU9n4Z9CXYibpz/QsaUwyxZ9/Mr+jgHTxw/9J1AnumzN/p8E8n801Yxnyah1YRyV5wqqbO3qT+m5zrl7r0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/8nCemYHKiifw218M1fl/Tc+cYRxVjBsbHHksYlBXt31EDTzT
	2fOwiNu0mHXsg1WNEzmfZKqcXJWM1OCybdA9joRXttDHKNDn3ukvy6OJib2yjHd3bEo=
X-Gm-Gg: ASbGnctn0O97fs78xce8c/45M5Z7h+lYQgGrw8kjgH6OEIBVjL/yHqPsMghzO6x88dW
	ZBL8G5YHETR8JvxihGbEGXNZl+4aWks9dDghang4I+Izm8d9MdVPMVNoKO4DPoFWkA7f+1+gzzY
	Zaot8BZYFpBG3Gtf87zUP/OvWspx+Ez0/kZ2HRxKkjrW8nzR+wyjr0/x2ZDHc/YSjLiNJ/6Gi0C
	tDGmR0L82oLXekZsxH0HMgQ0S2bKMUjIeAQ2ApHM/1iTTrFMcEYHEDsStOsEnHOELozTDlM15ry
	txKmkqZJj2lfkc3/pT4UAx82pm7RgPDUE1J5e32J/LVdc+DY2RXGVStJu20ADAUWXkp1KR6O8Lk
	womgBTGZrgDcCkUUpBrf6ZUzt+SuNEImHiIpXK6xbfUsH477ydzmrPvdfYugRCuxUBv3WpDhjPF
	s=
X-Google-Smtp-Source: AGHT+IHVV30FoowHptAlEajvZgXMFWrsREGbOySyGN+RbPFO0235lfTNd4xbMnBALGm7ACcJo6UbZQ==
X-Received: by 2002:a05:600c:c089:b0:43c:ed33:a500 with SMTP id 5b1f17b1804b1-459f3a7ee89mr89086075e9.10.1754898662994;
        Mon, 11 Aug 2025 00:51:02 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:b0fa:b045:4b82:de09? ([2a01:e0a:3d9:2080:b0fa:b045:4b82:de09])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e5c40eb1sm121405305e9.6.2025.08.11.00.51.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 00:51:02 -0700 (PDT)
Message-ID: <37c6a22e-e47a-4559-a765-a7779575d6df@linaro.org>
Date: Mon, 11 Aug 2025 09:51:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 4/8] arm64: dts: qcom: sm8650: Add missing properties for
 cryptobam
To: Stephan Gerhold <stephan.gerhold@linaro.org>,
 Vinod Koul <vkoul@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Yuvaraj Ranganathan <quic_yrangana@quicinc.com>,
 Anusha Rao <quic_anusha@quicinc.com>, Md Sadre Alam
 <quic_mdalam@quicinc.com>, linux-arm-msm@vger.kernel.org,
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
References: <20250212-bam-dma-fixes-v1-0-f560889e65d8@linaro.org>
 <20250212-bam-dma-fixes-v1-4-f560889e65d8@linaro.org>
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
In-Reply-To: <20250212-bam-dma-fixes-v1-4-f560889e65d8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/02/2025 18:03, Stephan Gerhold wrote:
> num-channels and qcom,num-ees are required for BAM nodes without clock,
> because the driver cannot ensure the hardware is powered on when trying to
> obtain the information from the hardware registers. Specifying the node
> without these properties is unsafe and has caused early boot crashes for
> other SoCs before [1, 2].
> 
> Add the missing information from the hardware registers to ensure the
> driver can probe successfully without causing crashes.
> 
> [1]: https://lore.kernel.org/r/CY01EKQVWE36.B9X5TDXAREPF@fairphone.com/
> [2]: https://lore.kernel.org/r/20230626145959.646747-1-krzysztof.kozlowski@linaro.org/
> 
> Cc: stable@vger.kernel.org
> Fixes: 10e024671295 ("arm64: dts: qcom: sm8650: add interconnect dependent device nodes")
> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sm8650.dtsi | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
> index 86684cb9a9325618ddb74458621cf4bbdc1cc0d1..c8a2a76a98f000610f33cd1ada82eebd6ae95343 100644
> --- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
> @@ -2533,6 +2533,8 @@ cryptobam: dma-controller@1dc4000 {
>   				 <&apps_smmu 0x481 0>;
>   
>   			qcom,ee = <0>;
> +			qcom,num-ees = <4>;
> +			num-channels = <20>;
>   			qcom,controlled-remotely;
>   		};
>   
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

