Return-Path: <linux-kernel+bounces-735025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A35B0899C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 11:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 940884A0C77
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 09:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44B71547CC;
	Thu, 17 Jul 2025 09:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bJJ64sE7"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946903BBC9
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 09:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752745557; cv=none; b=iP+Bgq14CNHb9zyAvAo1GD7/uGRRYEkgD+uGMkFkf0PkD2gpwqV2aCo/8vyjxPB/4mPn6N2FsqMABzBhix+QJemrLnqLLW91CK0vS2nL+o4+vsd2BITH33Js+c1efk7JeITbxT3xj1oNfHBsvAXCbA3RR0LJFcfUFkJ4f8Hqbvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752745557; c=relaxed/simple;
	bh=icvA0K1RPNBcWvfLGCmVKRBjbcIiYHmiy0ARHjx5WsA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WPsIGulMQxTgub693A4ZUnvqrf8gJZKGCy4v7MuW8ULjOkvXipShyC4r0H2h3pJxwbgg5YlxcqvZN0wtqWO553td6Iiz4EADH7gpuvxWKq9xdBLyQ+ywne/7B3aopm8+cSa+4w4p16A8y1uHHSYT6x/gE2Wfau5hRuSDZq46z0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bJJ64sE7; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-455b00283a5so4589255e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 02:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752745554; x=1753350354; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4UUb+eCCVRH9h09fVkojxVw36lrz4Ml2/6BK0w+a3Nk=;
        b=bJJ64sE7ElzZf0LGDF+KQU5J3rGT2qjQAZdFWW9zG8CoP4+aKDavgcMdVyKYlV56eR
         Zco96hfKijdjLHY4z65V0XgOZbN2/1NQ1hn9ajJchvY27cMY8Kr2gTRRUUc10dquiwWH
         EIy529hfKMPAeAy9L9i7GLmU2R7MSAqkMV0pmRm/SV43lL14jxoYBb4O2IMgHDciSya7
         +75L3aQS9nuyVIdF9rz/LHQ3+E631Lg4QloQfF0BHD+djy2Yrm4ATaP44c5jFb4rDMLY
         wYMxHDpCZCOpInAJVrzfMN5ru10QWz/H9mGaPUiyouvTiTgF3B8QHIDW161yH7mARoQZ
         XxEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752745554; x=1753350354;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4UUb+eCCVRH9h09fVkojxVw36lrz4Ml2/6BK0w+a3Nk=;
        b=RJoz5SvHZLANW02AeV0lcLOyHXm7Y+Kh+vIW3ZRLnRKxBCeKLay6e6eIPGwhWyLPQg
         oHgXvNZ+XOT6Pjz2le52RxUyAJ2wBiGIs7i+qpBITsFBg3ULNPmc7NWPxWEzq/oitLdT
         I7spsCcC1ox2TFjYG53djo7Z7XnAbtv/2CizTLxlXRduAKZWyKy+4VYlMOs5XRw41Ywo
         h6e7KwSX7TMrk7PXrx7bEJiLwyMm8yOT48IX7k8YKJF0orfDFZvL00n+0nD7o6Ug/Tl7
         xFo+15OSfo/tnKgNUjQYp2sEhB9wHMC+7WuWYrGq4nn+w/Rmx/Bwoy/cdzVVVEbRmn3m
         PEWg==
X-Forwarded-Encrypted: i=1; AJvYcCWSwWTy0AHsNxuZCbgU7QAecb2b6GVoCEdrDH8WhMMICoOrezGAcpWM7vXzgntGNvuPCqTFTZGHyeq4fww=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO4ANw41XHCqBqOvLU0F60gTXwDhN7eQ34L8lrhy+xQ2aKolQj
	sJccBCSYhuBVpj/6Ln/F4Wu03biu6btqxEGWjl5AdPj2U80kVMEH7BwLntxd404FF30=
X-Gm-Gg: ASbGncvIOg5ktEdgWSpjynzbRUfm7BaZBc8iqyC5iAUecvSu0K3wtrKWtngqx0D9P+m
	1agQmo24aI9wIOo1+F/tqSjuQrxHnTZbEbBagZaxJgl4MxVg9zt0N1vplBGG0rpAWFVD+GD+Kfj
	72/raLz8UmGTeO9/6XOAe2fTbeY6RvXsd5IMQh0ozdeXYLXgl5bUqbGEuqSwXOj7w81aDG+HbrX
	nQuD5clesLeIxpeDu3bGQSvacaTWMRJjl33UxSRT+97v509ouEfGkprQlZ6pcLDZhsdOPeZ4N/e
	aDmJp/JGH1TZjlVo/P6r1R/V6HyrZ9Nw/HDHbg5ZUSb0HNXNOb/rWOssC2UrXWMDNxOx0noPaHq
	0T15pjx6FPAgpZZNqH+0pNhaLwt7fa8o5gXNbq6aTSwxZv2ETKmpXALKz0iHYoGM=
X-Google-Smtp-Source: AGHT+IHP2SvnCCzI3J6cTXMGXPD2s7F8PxV92aFEphVYbHWG+syxiVGQMy54GQ/w+kIwvVDzdKb1dw==
X-Received: by 2002:a05:6000:4a06:b0:3a4:dc32:6cbc with SMTP id ffacd0b85a97d-3b60dd53fe5mr5975700f8f.20.1752745553877;
        Thu, 17 Jul 2025 02:45:53 -0700 (PDT)
Received: from [192.168.0.35] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc1de0sm20112044f8f.24.2025.07.17.02.45.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 02:45:53 -0700 (PDT)
Message-ID: <00be65fd-2a25-4b6d-8fb8-7a40f8ca846c@linaro.org>
Date: Thu, 17 Jul 2025 10:45:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 7/7] arm64: dts: qcom: qrb2210-rb1: Enable Venus
To: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
 quic_vgarodia@quicinc.com, quic_dikshita@quicinc.com, krzk+dt@kernel.org,
 konradybcio@kernel.org, mchehab@kernel.org, andersson@kernel.org,
 conor+dt@kernel.org, amit.kucheria@oss.qualcomm.com
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250715204749.2189875-1-jorge.ramirez@oss.qualcomm.com>
 <20250715204749.2189875-8-jorge.ramirez@oss.qualcomm.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20250715204749.2189875-8-jorge.ramirez@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/07/2025 21:47, Jorge Ramirez-Ortiz wrote:
> Enable Venus on the QRB2210 RB1 development board.
> 
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
> ---
>   arch/arm64/boot/dts/qcom/qrb2210-rb1.dts | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
> index b2e0fc5501c1..8ccc217d2a80 100644
> --- a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
> +++ b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
> @@ -711,3 +711,7 @@ &wifi {
>   &xo_board {
>   	clock-frequency = <38400000>;
>   };
> +
> +&venus {
> +	status = "okay";
> +};


goes here

&venus {
	status = "okay";
};

&wifi {
         vdd-0.8-cx-mx-supply = <&pm4125_l7>;
         vdd-1.8-xo-supply = <&pm4125_l13>;
         vdd-1.3-rfa-supply = <&pm4125_l10>;
         vdd-3.3-ch0-supply = <&pm4125_l22>;
         qcom,calibration-variant = "Thundercomm_RB1";
         firmware-name = "qcm2290";
         status = "okay";
};

&xo_board {
         clock-frequency = <38400000>;
};

---
bod

