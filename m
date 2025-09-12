Return-Path: <linux-kernel+bounces-813316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F726B54379
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 09:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2541C3BB9EE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 07:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3779A29B76F;
	Fri, 12 Sep 2025 07:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fXt/yalM"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B363226E6F8
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 07:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757660744; cv=none; b=DvDhuWOkrWdbN04xRh30+LDiAdHWh2PmHhiTaZSpOOyRyuUvIcOnJWxv+dg7uEW30YOWqkgZ0rfjN2hbTLgWBRjKcPWb19tyhpMsXEdTNmCL0+MTcbc0ckkt91PxBjKk44CP0r+9S8AIkzyntk6/fg0HbVm2BW0MgB2ypb++4TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757660744; c=relaxed/simple;
	bh=MSqfKpQxC59e9W+Wm881SqsMQBaGuxrnl4dVvzErtS0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=PZTRZNxJEv8C4FhTT2PyMCLA15lvHAZzkKnszKX0eaKFu6l9ZwI3UXmAlDRz70TexTzepAm/l3NX7eb6gyg04mhPcp+Xr5lqIv8xXhF3eqcFdN/XFO1U2VpB7dzBNDNh0mF3lZ9zgyufvQQ/VdvrJxMMeRqpay1loQ5gRsSPGG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fXt/yalM; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45dcff2f313so11225135e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 00:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757660740; x=1758265540; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KCj8FPMD6tHCY0hrfwP7BeJsW8lye+3YpeZhQSMCT6w=;
        b=fXt/yalMGQaxNtRbzStqmLe3KM5eZtFrNo3iQzjYlDH9ywYD+IRK6OqGw9cnbH6Io7
         tzGtolq+hbJEMvSAQNBkVrH5AbwAt05JyTAY8AMWYa4YP58QNjJoZ/kd0T+a5DkXqXhJ
         RUwJYrDKWOqFvCLwaxfi/6Jwkf8VOhVYCF8R85kqqrBFi8UpDLGFH+tKCZ0Of6W2nxMt
         VOvfbzCxlp2dZDAlGD7GhzOpS5IBtopYXEjOg2DiE6DuL5ZhzijTKyG5AB9eb68ZBcIR
         mzwJIQdB/pbrOCJ5iI5HoGteK4HSHb5iW+C/G1yD3QNTKkKScaAvX5lt7I3ZcQP3bjHO
         wURg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757660740; x=1758265540;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KCj8FPMD6tHCY0hrfwP7BeJsW8lye+3YpeZhQSMCT6w=;
        b=AIidVz1r1GWEPlaxgBEnLjXWXimmYtQZvY0T/5+LgO/afHbK6ryXyfjW2tbYXgXXO/
         y53NqAwsO4gHuRXhrwqK9J/sSuWrr5K2kzTp9LxL3l0qCtKM0YJGJ3rta4gxpNt7U066
         NuxkVXCKeMxxjPpIbA5ubD50g3dMXzA/kO3RRxrTXoQK79W7X+VwKtIVhAltzp6/hDQ2
         W9j+FouqYIGwHLXkUx3Svtz/fRO8gABKytfIlWV8NdMmGuEOWHKCJF/7gDwc+lpGdfJz
         B5CbFlwRqd72PD3P5ki0Dk209DkoUDBO02mKqi2Eh987NGSuOa8DYSMRCeUHGNTQRrMS
         sPvw==
X-Forwarded-Encrypted: i=1; AJvYcCVbsiZVfWg3uUPfwVS1Cemoj+Bf1tcf3KQWj1W41KpgW17V42HoueJn2/rjR9lNPhkx8SXnlMzGMGyKWHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqM8cfYdZ0qBhFOjSFCdPyDA4nKLaMdPMvB8f0xN1t80mukiN9
	mDM0SVmKPgujqKjPc1tx62NcYQAWB4/AAqDpBd4bZHCzOmrzKBSCFw6Y1Kyu4o4LotPrQgNnswN
	okfYVLi0tag==
X-Gm-Gg: ASbGncs5Yoa0mD7PB7VUzEwyaaPpkFH8UL6ORUSCT1Tnr6wMe8lRSHW3bpigPaOe43X
	v/LIehTEeZpRApirXDImNOTqicgcrQg/3ZfK1vCvzkXVkwb0Ru0hn0xf9//6QpXIozXrYKyGqIN
	tQbtMWueun1qDaaM+YZB7YlPMyQA1M3/5N5gxhTSVLuQG7q1tJKnoaC8zCXU5oVHLpGnOSml9xG
	hyRGP4ex1TtPm84+HSiC9SYSQZ/cIZOIbQC595862Hw60qYlXRvKTPEb5S+eB55ix3FqPmP9xaT
	6K/IhcpTZIyv0dZoUFUIvnjeI73GIKuJLs2ImngL/m4E3+ro7ORHkYceou06wlVYLT69RrNRNbe
	g+XlX3oHqZ22GGy3qAPRfpQz6HIA6p7Nn/zNwNRJbPVWwNNopTE/l8Dsu7qeQQ8DrD+t3ijRKtQ
	hmmkeJDPT3ZQ==
X-Google-Smtp-Source: AGHT+IGoaBBXEvlzDTsU1C03GV4YLPpPCLc3caF+CAlRHDL62IC2h9RN1444RdSjA5EQjkfLng46dg==
X-Received: by 2002:a05:600c:c04b:10b0:45d:f7e4:7a9e with SMTP id 5b1f17b1804b1-45f211caa00mr17292745e9.5.1757660739962;
        Fri, 12 Sep 2025 00:05:39 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:3242:9953:dff6:b6d7? ([2a01:e0a:3d9:2080:3242:9953:dff6:b6d7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e037d638dsm49017565e9.22.2025.09.12.00.05.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 00:05:39 -0700 (PDT)
Message-ID: <54dbbb39-436b-4ef2-9eef-0c9676340cb0@linaro.org>
Date: Fri, 12 Sep 2025 09:05:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 0/4] arm64: dts: qcom: x1e80100: Add IRIS video codec
To: Stephan Gerhold <stephan.gerhold@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
References: <20250911-x1e-iris-dt-v1-0-63caf0fd202c@linaro.org>
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
In-Reply-To: <20250911-x1e-iris-dt-v1-0-63caf0fd202c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/09/2025 20:38, Stephan Gerhold wrote:
> Add the necessary definitions to enable the IRIS video codec for
> accelerated video decoding on the X1E CRD and Lenovo ThinkPad T14s. The
> additions are largely copied as-is from sm8550.dtsi with some minor changes
> necessary for X1E.
> 
> The PAS interface used to boot the IRIS firmware is not functional in EL2.
> The code to start it without using PAS exists already in the Venus driver,
> but was not ported over to IRIS yet. Discussions how to model the
> video-firmware IOMMU are still ongoing, so disable IRIS in x1-el2.dtso for
> now to avoid regressions when running in EL2.
> 
> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> ---
> Stephan Gerhold (4):
>        arm64: dts: qcom: x1e80100: Add IRIS video codec
>        arm64: dts: qcom: x1-el2: Disable IRIS for now
>        arm64: dts: qcom: x1e80100-crd: Enable IRIS video codec
>        arm64: dts: qcom: x1e78100-lenovo-thinkpad-t14s: Enable IRIS
> 
>   arch/arm64/boot/dts/qcom/x1-el2.dtso               |  5 ++
>   .../dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi    |  5 ++
>   arch/arm64/boot/dts/qcom/x1e80100-crd.dts          |  4 +
>   arch/arm64/boot/dts/qcom/x1e80100.dtsi             | 87 ++++++++++++++++++++++
>   4 files changed, 101 insertions(+)
> ---
> base-commit: 8f21d9da46702c4d6951ba60ca8a05f42870fe8f
> change-id: 20250909-x1e-iris-dt-eb0494a130ca
> 
> Best regards,

Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on Thinkpad T14S OLED

Thanks,
Neil

