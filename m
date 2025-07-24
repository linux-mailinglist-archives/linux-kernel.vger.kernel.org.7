Return-Path: <linux-kernel+bounces-743791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E32B1035F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 10:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEBAB565CCD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 08:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F00274B47;
	Thu, 24 Jul 2025 08:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kAY+rszw"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41502749E0
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 08:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753345168; cv=none; b=F59zv++SiXtvKz13E0yeQVI+SET9gEB2bXGVdeec5g84hrhfLdUXX11keXViP7i1vM23sglPYPNTeDlPaN0QeKN0bWq2ckWlhelvczCtqZLvfrrveM57ii4mZwjOSVwsrz1530wrttqQq7VImB9cYu1I4dcQzHry+qOLuTdESZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753345168; c=relaxed/simple;
	bh=WA8iYJZG3OCrX6W3ADAz4ts6Lm5xt3MUUZZKZF+K0pc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=dcNpFUytREN4YQK1iG/kCqFXoG6xhrrXQ8yEi+nJgZu7HNyW3CkFF4P0D3SFqkCkjtHQjgMD+pc0D3ZBMCw5v/QjN8PAt+UbIIBgMTdJrj4Vpk2a7sHei6hveX0/bjLnlo+QMQDR6gLIsf+qlQ7hTIdNsXWispomMfd5ti7nVSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kAY+rszw; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a6cdc27438so608056f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 01:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753345165; x=1753949965; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1fCHD2TMNsDylkVNHGBO475Mk4bPsZj0rm7XMe2WkGM=;
        b=kAY+rszwzecM6uncPL3p3gsq9Rc5QlwQXwHOMx/2s+A312TIIT24oFWIlzumhYwCkb
         5MGDm8bqW2sesu3wRUg2nguNC8hiUoTLISYGiUd38V2rfGCPHbAtoRCsnHBRo4Ui9+1H
         UAqJ6BB1321Zm+VAYta/FjWnEPI4xhCJJSW0cOTTvOkTnmRmu/O2CYnSiPaS54ih4otm
         GmoElGomlL22R0Rm2uQEKRPmST1XWo2rNkUm2F1xT7q9XsFn6L+31R6w69GJvO6tP7X5
         3rxfpswuTCsRgafCXbz1MJZ9VBwSGVuK0ByiWUeKkBaGzP8JgN3DXpm1SLxyNvg2q+B8
         GBeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753345165; x=1753949965;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1fCHD2TMNsDylkVNHGBO475Mk4bPsZj0rm7XMe2WkGM=;
        b=SO+S/PeqXXCFkNrle9waNIFfPDWbeywfzElNjtqsYSV/uhlFgVC9Z44c7g6D8DOe7Q
         wT3uD3q/ClZhHOrqiacLhTwnDHMlCk78KtWRDB4GTYU7Eg/bChHHxBMgLfRQGkK6DTV4
         S9JFq/XOJY0sJqfeMmKM5ew4Jaj9++lXxBpmvkemT1lBwqiYi4PDN8hEESNbNaCobyro
         sKEOz3c4H495QXqroVIpiZUaJQQizTyfvVNn1NsM1VcKWpqtVYiJlUmwKTQRsI5EJDEp
         w6stiWbkdyxGCS6b9ArK+9ugs/tUCwtExeW+sLhQvamzIrC2Hz728QMyOe407Tu6hDB0
         xegA==
X-Forwarded-Encrypted: i=1; AJvYcCWtXBv5b4HrLyaq8A2iYXwAH3FbKJhcPIs6bJ3f0RMpQAPo0I6AKmdMMM0GGv3mKxAh44MgLbjjoIkyYqw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3nPejFrtQjdm3MKOL8aT9AeiPqQnnkeDtgNx6+NUOA4JvXkw3
	6gBOYhEcK2tW1JCunmY8bGe5/noqKuLAIrp018UXwEr0nA0KG6etyRMH7wH/QEsx2wE=
X-Gm-Gg: ASbGncuoxHwbn/tOWbhHNd03hH9IpG7YDb0k+UztUXBexU1eZbIp42KwerXMMXqUs0y
	B5m9UurD803ia0UjTmw2YMZb+Kd6MDNNkPwfsFnhIOtThVAZuFLpmWXTd2rFjl0lVOX6tG+7s9O
	CThpBMFJhYkzS4kBkSOk1eIHlc5Tx+DCJeaPYwBFOA0X2aShUE22AigdPcyo7SGIgitqtoxTqGZ
	xGzv+HfH9O7K/GknkZ+/jyLWvnqGDg12IhmkF2ounVh7Svcceh9BPGz+kziO7N6LzLxJdjXR5a9
	RtTFuXDUGh4Jd2ReZBE69N8g3NBIkqjGoPZmO7D5fLQ9rfHsHqOj8zXUC+1rxXu4jvU+3/ABi8a
	gQPRuXXlIm4aTtRSiA7bSuctlVa2++VAr
X-Google-Smtp-Source: AGHT+IEUVFrQZUfwoO9P6Z6/FU1C9i2Mg8enZw2F7nU5fkqy4VoHbjMRqy8I3MWa90OfSAZLdtNdzw==
X-Received: by 2002:a05:6000:230d:b0:3b5:dfcb:7b34 with SMTP id ffacd0b85a97d-3b768eedf9bmr4522023f8f.17.1753345165005;
        Thu, 24 Jul 2025 01:19:25 -0700 (PDT)
Received: from [172.20.10.3] ([78.246.240.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b76fcad2b4sm1385567f8f.47.2025.07.24.01.19.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 01:19:24 -0700 (PDT)
Message-ID: <d83998cd-5c28-4e41-8487-08cbbe707ebe@linaro.org>
Date: Thu, 24 Jul 2025 10:19:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 4/4] arm64: dts: qcom: sm8550: stop using SoC-specific
 genpd indices
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Ling Xu <quic_lxu5@quicinc.com>, Dmitry Baryshkov <lumag@kernel.org>,
 Tengfei Fan <quic_tengfan@quicinc.com>,
 Jagadeesh Kona <quic_jkona@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20250718-fix-rpmhpd-abi-v2-0-0059edb9ddb3@oss.qualcomm.com>
 <20250718-fix-rpmhpd-abi-v2-4-0059edb9ddb3@oss.qualcomm.com>
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
In-Reply-To: <20250718-fix-rpmhpd-abi-v2-4-0059edb9ddb3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/07/2025 17:25, Dmitry Baryshkov wrote:
> The SM8550 has switched to RPMHPD_* indices for RPMh power domains,
> however commit e271b59e39a6 ("arm64: dts: qcom: sm8550: Add camera clock
> controller") brought some more old-style indices. Convert all of them to
> use common RPMh PD indices.
> 
> Fixes: e271b59e39a6 ("arm64: dts: qcom: sm8550: Add camera clock controller")
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>   arch/arm64/boot/dts/qcom/sm8550.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> index 45713d46f3c52487d2638b7ab194c111f58679ce..a4ca06679c2f1eebacdd5938e380981c1b17925b 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> @@ -3623,7 +3623,7 @@ camcc: clock-controller@ade0000 {
>   				 <&bi_tcxo_div2>,
>   				 <&bi_tcxo_ao_div2>,
>   				 <&sleep_clk>;
> -			power-domains = <&rpmhpd SM8550_MMCX>;
> +			power-domains = <&rpmhpd RPMHPD_MMCX>;
>   			required-opps = <&rpmhpd_opp_low_svs>;
>   			#clock-cells = <1>;
>   			#reset-cells = <1>;
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

