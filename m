Return-Path: <linux-kernel+bounces-689646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFB2ADC499
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 10:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14F3B1619E7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 08:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E5A2989A2;
	Tue, 17 Jun 2025 08:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ybOdJdyu"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F48298CB3
	for <linux-kernel@vger.kernel.org>; Tue, 17 Jun 2025 08:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750148429; cv=none; b=jp6AI8Ugm2mUdeH9XsgXmnMMnROWfO1CqGISjfLOM0Wh1HDifgFtURtSlEifKKah3NZ1MlAPJongN3FNactLc8ig4nKeDAZXMcJnRju6sFAt5QjXK1yl2chCR4NRPT5affeWxwDUSE5+LFH4QrDINYx19zZI1UFzg34lEQRMj0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750148429; c=relaxed/simple;
	bh=/WQbHnfRtWRIQdeI3JmHziVIp79qdv/zvvBmBI3l+1E=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=rtPl4ef02u8AWzR7b9RZN1IHWlyk5pMG/r5jMtXLLlQqUw5bwRM2r1+yrBAktUF/sQ+Ssf9gOzeNNTJxCokCAaNHCy1qeUBA/Acdd9vDmkeG04nfjOmGyvp8onawddWgtvQPF6ghaXoU4xeYONz92O+vXBUOXlc+K9THQAP5uz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ybOdJdyu; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43ea40a6e98so66843955e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jun 2025 01:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750148426; x=1750753226; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rRutXZGiZkOK4IPQRRMmCzuE+5vrVS6DYaoEnbP08XU=;
        b=ybOdJdyuZMD2fRIELjfaJYkQEeC0b0FTf+KKPTGHTdoyvUCND82s8eqpVHuuBjVCUv
         Snj3dG3OWEgoeBdartElATKsUPQXauMXR6kc0Jxo+MYCX87Dp9mE6Y8+Ny+3Qz01kBVt
         /DrQ4BjdggovMVpISBWH4zwfwJMs8KLlMSUqx2MLpzsXhjNo/ncHxD2qWB4GyBWxcrCy
         TuIaQ2ffKh1LZM6sVOsvUdihln9EkgxddP/DZYS5AjLoLpk2WDQSaJXBSTV+tLmhDmhK
         tzbmQ9MBabQZeQBw0sB7bnYv8glIrB1Kvw///G9yO5r4FWD3L5EU42AItoq+7TjMZGP+
         wIZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750148426; x=1750753226;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rRutXZGiZkOK4IPQRRMmCzuE+5vrVS6DYaoEnbP08XU=;
        b=lNkDsHIPiCIfH9Pt99OOrnKArQk1Li+LA7mkumvjzrTQ+aYzwETN80duLtA7USXNvd
         qNSJaL5fPbXi06xcJ7Ec9Z9i9NVOxtYgf/y3HpSUJ+y9zSuMwJEcQ5TEW94vZ/4YsMKS
         m8JgIJeprGLyE1xzRBYyPrtBOtN/5I7qFz9gIA3pdYmReW/77Sa1+63SerapuO1Gh/Qj
         XydCJ6z56gJwM/xyMIuMip/2Y//WeU7Ntt9OSacEZuY2PR8VDJeHE6kjPOAY7enR9QIQ
         DqEItYbzZYQaJuTrbAeAB74F3QAr8EuOSDJ5BENbziaEY7p0MeGY+q9XquBQzGUlz959
         44Yw==
X-Forwarded-Encrypted: i=1; AJvYcCV6hwO0sT+AGPygXksyv/YGb303NaUuesqssy/Cvs2fU3DNiB0TGb/QHlLR3wvexGf6ihWe9n5Z3qSSWOw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJt2QgcIi2KLoGOOegXCen2CsDkJDYnoyuhEXo7PHs+qKNEF/F
	6xL+95f4rFsjo6sGggCJyxzgFuOjUkrTQItFnpq7ozmJtB3dRc2m6c1jZbMILX9gkeA=
X-Gm-Gg: ASbGncvP0zw6fXwsaVCO/q4FZ74rbSy6L8vTrNTYI/JWAu/ScpNF2BJxf7RQjz90ZGj
	fuTs/WJ//Al+KufDVWHDtjckgc8AlsGZqMevrU7R5pVouKveni3ElNZMRqxmW8+CqF+NM7U2rrq
	tWnJI75+dNy/a2OybBMlcp7rjAdPEAXHY57Wgm0sXZMSvH1eZCQ7SbaEHjaGa4Q3xCw3kdwTlhd
	VUrgMOzLa2JxHaY/zF6dtTTxB4XI4rgmCt1k+ZlUDawNyZCymumg5yZsFXeqd3zfB5w1xLrhgU6
	bpV2WvM/S/KvX5XUEArqaB2YWe0eLG8wTG3VYYHCXOantGgjO2gISpu51YKj5UBJB0UhFlk7mz3
	Q5YMYVWf885g0/WkwEl6T2a0CvtEa84+IZQnX57B82tcphYjf+A==
X-Google-Smtp-Source: AGHT+IFEN/PY92LwnlT1UIgo+2I6xRqQ1JxYeqAwOpj11+y0e6KjDrQEgfFE+cFB2pOIqzh1vYyHiA==
X-Received: by 2002:a05:6000:2486:b0:3a5:52d4:5b39 with SMTP id ffacd0b85a97d-3a572398ea5mr10039548f8f.8.1750148426115;
        Tue, 17 Jun 2025 01:20:26 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:3819:3250:4f73:db31? ([2a01:e0a:3d9:2080:3819:3250:4f73:db31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e268de2sm168241545e9.40.2025.06.17.01.20.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 01:20:25 -0700 (PDT)
Message-ID: <b56ae254-2b13-4a28-bd97-c815ee773abb@linaro.org>
Date: Tue, 17 Jun 2025 10:20:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] phy: qcom: m31-eusb2: fix match data santity check
To: Johan Hovold <johan+linaro@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>,
 Wesley Cheng <quic_wcheng@quicinc.com>,
 Melody Olvera <melody.olvera@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250617080503.11262-1-johan+linaro@kernel.org>
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
In-Reply-To: <20250617080503.11262-1-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/06/2025 10:05, Johan Hovold wrote:
> The device_get_match_data() helper returns NULL if a new entry is ever
> added without corresponding match data.
> 
> Fixes: 9c8504861cc4 ("phy: qcom: Add M31 based eUSB2 PHY driver")
> Cc: Wesley Cheng <quic_wcheng@quicinc.com>
> Cc: Melody Olvera <melody.olvera@oss.qualcomm.com>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-m31-eusb2.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-m31-eusb2.c b/drivers/phy/qualcomm/phy-qcom-m31-eusb2.c
> index 9b987911fcdb..9ad7af503baa 100644
> --- a/drivers/phy/qualcomm/phy-qcom-m31-eusb2.c
> +++ b/drivers/phy/qualcomm/phy-qcom-m31-eusb2.c
> @@ -252,7 +252,7 @@ static int m31eusb2_phy_probe(struct platform_device *pdev)
>   		return -ENOMEM;
>   
>   	data = device_get_match_data(dev);
> -	if (IS_ERR(data))
> +	if (!data)
>   		return -EINVAL;
>   	phy->data = data;
>   

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

