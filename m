Return-Path: <linux-kernel+bounces-816717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC4AB57791
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1902169D6E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 11:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0989D2DA776;
	Mon, 15 Sep 2025 11:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RLL7CAKH"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68572D2488
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 11:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757934105; cv=none; b=mqUA2gTKy+ijmXn1qS2L3TWC6ZI3uTEvE/JNwADzTPd4Xq91iNr67BqbxerYUmKJVI/QDllEsG5PlaUTqR6qVGrKF71AWuMovXpwNQ11MsaB7PJeFGMmBTeLg6AxAVdmRXw/0Cor39M+w5R7CcVV1RtZHVgxgVVgfk2Jsq99fbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757934105; c=relaxed/simple;
	bh=/Qc9d9aZzIeejKzsoFImNVQNyJaCsuJtl9kVd1OJcbI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uMcxjsO/fFX0NCKnKkVZz3LnW3Mx6Kq2zRsCKq0GJCC41646BgpVCX7LxwOjM0y6osne6ck6SS28RYuva/LmeZmVGLrqz3aO5yrqvPdKneD0km+OHwr3Yji5oHMyzRlNMC8/A3ZG3DxRvgVgOc8cogYErKv8A3ha9jp8D8U7aLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RLL7CAKH; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3e957ca53d1so1176914f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 04:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757934102; x=1758538902; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NZDo3HJj+JKsYYxffoSm3zbBIPvQZvsDjUn20WFmAPw=;
        b=RLL7CAKHMBAaXQsRfYz7qejDG4+TbJZUUBEMM4GU3VTTewmOi0JAZr6od0AMGqvFzo
         aKTK7W3sPX2h62D298fAbgKqwHdN6ZtenCRxZKIcUBnm/MZxGjv35hZs6I2eOxH/Dhmp
         VvydyViRmn562Vn8zLyojP6J0IcX2njUXZ4EdwlSXp7E6Fc673sBe+Yl9QfOtF8nDIp9
         DKePDd8HGvSI36JxGbXwmlJGq2J4JPS+iXuByejXlcTi6xPTE9J8tNXFaGhCnybBo9U4
         A28ogoCn6vTzjyqLC63QzR6gy1OUzknMNbS4W+Oy+cQ4NCT66Kg0aJjSHjx58DCIpu+T
         QFSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757934102; x=1758538902;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NZDo3HJj+JKsYYxffoSm3zbBIPvQZvsDjUn20WFmAPw=;
        b=lgMP81N1gcD0V0AvoCwrZCwPo4UelSBgFkGFFZVceb/qBctA4o8TL/57CBgqygkRTC
         yMKGwhurkUhiFsF3ga6x1Vpbm+bZABu1kyNG5pd3RXvo/cTKiCY3M1M1r4MkaUCblDcg
         YnJk+ykkUW6KRZDsDwHb1cB51zLeG/VgdrYNUK8vy0HYdT5Zduu3Lrntz0nQCfSZs1/o
         6bhqelFzt5dvnJM0yj0L5FXzfe2huVKZ3lM3V78EsKoksb7esjq7b9XpAOe9feV5KxPK
         lkRCcusFFq4TQhi8FyD5t4ZNXzWFStfzLY9kybJHtexihAUzIu9ESrO21hXO11zfuEuL
         4Qpw==
X-Forwarded-Encrypted: i=1; AJvYcCWIJgQNYHupSoHbGqpOTmxwVJ9c/VuCJigxDf8tAxYa5vkz4br30ASqFSQ024b4yU/5XTDfg5hSZiyN5yg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw12f/dtmBCYRDrkLEGsHckqzllzYjw4mI5klcYqAfiZQk75jv5
	y+ZMdz8cyMoJfVH42Uwf/5vOOrxLejeRCAkfezTPsfQqvMcfC3BvKKqfxNGk1DI8Ie4=
X-Gm-Gg: ASbGncsSs4hNjDb2lVFawQ0mtdvNjCcSstoKdyYnDuNbqI8QORhgbQlkEQ0CuG2xzem
	hIujplyBEwFTwTM/aZJmKyY2A9IEG7KW8AynKlO6IbAp+MTPMvGQCGmREhT5DXNnUtiRTHmCDdC
	v750db2mnAjSiso7W1rQmOYclVpu5nz52vrvRo71G9DSDxPpR67sR1vCEvc2sWiISOl349NgkOQ
	mgp+n6CugrMCSDB03T8lbal3L2y0XP38d2IsZMMsNEJAnwFWxQ2olP1sE47nGP36uPx5m++2tVs
	Y3jQMmQkuzQ+aXBtq4MfibiZCu++B9WJZiAEWojx3eTUsdeENSCGRZfHo/9gpdCuG7Y/vBkbrXz
	S+6lgbFox2gdAcmihUQScwY18CECETf5VoCcjEoqbdaaBFUP8OKb/u5zJSLuZAZvR6JQSleYXZc
	mBOx2/5zVR9ErUW2yzzoA=
X-Google-Smtp-Source: AGHT+IHEbWM22bIRf2y6UTpO/R5u8kTDR+0OddRsCBt1HZIW8yyIVi08dQKVxGLboPuRerqVIo9Bmg==
X-Received: by 2002:a05:6000:26cc:b0:3e0:34f4:3225 with SMTP id ffacd0b85a97d-3e765a09238mr13094569f8f.45.1757934102095;
        Mon, 15 Sep 2025 04:01:42 -0700 (PDT)
Received: from [192.168.0.19] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e81dbf9acdsm10439024f8f.55.2025.09.15.04.01.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 04:01:40 -0700 (PDT)
Message-ID: <77cfc92b-5ec6-477d-a92a-123b17dd1c60@linaro.org>
Date: Mon, 15 Sep 2025 12:01:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/9] arm64: dts: qcom:
 x1e80100-dell-inspiron-14-plus-7441: Enable IRIS
To: Stephan Gerhold <stephan.gerhold@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Klimov <alexey.klimov@linaro.org>,
 Anthony Ruhier <aruhier@mailbox.org>,
 Stefan Schmidt <stefan.schmidt@linaro.org>
References: <20250915-x1e-iris-dt-v2-0-1f928de08fd4@linaro.org>
 <20250915-x1e-iris-dt-v2-7-1f928de08fd4@linaro.org>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20250915-x1e-iris-dt-v2-7-1f928de08fd4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/09/2025 11:06, Stephan Gerhold wrote:
> Enable IRIS to allow using the hardware-accelerated video codecs. The
> firmware is not upstream in linux-firmware yet, so users need to copy it
> from Windows to qcom/x1e80100/dell/inspiron-14-plus-7441/qcvss8380.mbn
> (just like GPU/ADSP/CDSP firmware).
> 
> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/x1e80100-dell-inspiron-14-plus-7441.dts | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100-dell-inspiron-14-plus-7441.dts b/arch/arm64/boot/dts/qcom/x1e80100-dell-inspiron-14-plus-7441.dts
> index f728d298c72f4bf2ee151698e36108fdd7a8e5a5..cf2a7c2628881e44f093d73e6496462c22326d9a 100644
> --- a/arch/arm64/boot/dts/qcom/x1e80100-dell-inspiron-14-plus-7441.dts
> +++ b/arch/arm64/boot/dts/qcom/x1e80100-dell-inspiron-14-plus-7441.dts
> @@ -37,6 +37,11 @@ touchscreen@10 {
>   	};
>   };
>   
> +&iris {
> +	firmware-name = "qcom/x1e80100/dell/inspiron-14-plus-7441/qcvss8380.mbn";
> +	status = "okay";
> +};
> +
>   &remoteproc_adsp {
>   	firmware-name = "qcom/x1e80100/dell/inspiron-14-plus-7441/qcadsp8380.mbn",
>   			"qcom/x1e80100/dell/inspiron-14-plus-7441/adsp_dtbs.elf";
> 
Tested-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

