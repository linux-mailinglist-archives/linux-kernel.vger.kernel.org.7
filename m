Return-Path: <linux-kernel+bounces-756173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5CCB1B0CE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 11:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11A1D3BD2C5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 09:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9681F872D;
	Tue,  5 Aug 2025 09:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o2EIacLP"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B09425C807
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 09:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754385384; cv=none; b=CDWoHqItAPg6boIavU2ZezVvV9SC72ebQpeAUUYvknLutlOm2aOqUfWl/3cmbFerhFv8YXV+G3hTZZmZlKShIWoN6xExk3LW2b2hOyfgPNDFYQuX4DGW3cNEFmnDK1ZHN6prFv2HmvoTnlO6YEkD12ZUH14VZO411Cwpy19mMuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754385384; c=relaxed/simple;
	bh=K8e8kSu4ViuuLbZIA9BGUagkO+rSx9GESbp1kx7d7BE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jL3urNqtk1Vxk/u+XPAbz6gqicOtwmeicsTt0ZY8AFVy7O0YxWEwnSHhp0r0NS4R2Y905KkmMDUQunIsKLYKtA2eUj4WptOZdGwyt+4AIdXhBOrkEZJ6ZQgiLERVBPpjBizeY1AofBQlUjkANbCNyRJ4Tt2sgRdKN616kKqiJg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o2EIacLP; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-af96fba3b37so312886166b.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 02:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754385380; x=1754990180; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JDojcrGsiLvyGetSooakU+/Jy9s4z/uE44Ez2XuRs8U=;
        b=o2EIacLP0n7hzu9p52l8cQkrO1XSDKqbDvvVBf2ov21fJWQSLpx0HUNJt/1CSsGEew
         Q9pS1QRMDLV2ayR2p35GNAyFziytbH0U7jaYXe19e+wb68CaqQpiBEE8hqBSOsBHTlT+
         IWA8rTTmwXPeNISL5yoBd0dH/hwk/p9OdhdrCqnW0hQK6sLaO4Wqg7kn3lDA3orB1PAA
         nOHUTHWTjIq1U+aU8kF4ADUIn0IyyfPoKzPHePrTvIk8tdjLNjD3mniWe2kXnspx9xiJ
         jJ9Jg+oATz850Whzt8sU0wDfcOmGafT+BZPc/i/g1gkVgqgUGaXtr2yDLbAXOJoTAuft
         uIHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754385380; x=1754990180;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JDojcrGsiLvyGetSooakU+/Jy9s4z/uE44Ez2XuRs8U=;
        b=Pg6gJsQvhG/HfpaCAoQSemq8vooyf2SyMYlnpEEGGJGZYXMkWpRIM82j/ysPp3psw0
         0ZoQR9UtCY8UIdds/tH8nOGxeaZ1gDACprFjQJJ7+700jepkxdCRXaRLTsE5yrjS4EUL
         Hsqf/zl4K9DCvjRgar5HukgY5P5MXeJUh79ofjk0IGAsPhA1rz9q6rv/lBv0AWFNsOPn
         j+a1Apx+M7riVVDZrIuYwiPXw6Xa99J4vPKqxAIV+xSERSbc/zLzSCbaZvNv0kMVFSfd
         d00KA3/AdCijATwYDftTYPrqKYZw0HvYeSxtXhod0N5TTYotFY08hC5X1nyoHoCUZuq0
         Pufg==
X-Forwarded-Encrypted: i=1; AJvYcCXHRiaFJaSCYv/qJr/qiSMTFN98aa/Yc0peLlWoVU7MzhzzyKeUpieNRPmdIqcZ+B50YSR6CpxptOf/X4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDOrqSS1Ay/5zw4wkw+6lJqeCvH035HCH+w1DMt2UsjUpMZaYz
	EMqgIcUQ2FMpPVNIfHSnIBbOh1L6G9YL0F42DDzcfDUOzVg7Kv/gLe4TIMYjr6I2b/Y=
X-Gm-Gg: ASbGncuMjOavffEZnhRYsXCiwbB/Soo2HmALeITx3Gsts+tcJD6S60fL/+9DkJElc25
	hW8J627VJEN/qTsKyoUYtU+b04A96tvEgX9nx0eEyornFeF0AeetxLnzKTkMT/BdQssyV9a1aBJ
	TP1CFZ4T366ZPDJGTvngkc+Hg8LmB5jRjtDYNk8ZBj7oZOvfjCHRfCFxDXEAwEb83e43jAl8EPZ
	fnDlIU97U5d9TfqMgWo0CCi3mfJKSOF7zDMfzj5QDhGUbOmVHx2URyBRieuNeFS/1Falza0ZiBE
	9p84dSd2d8K6x16sgsQT7SQy1RTR8dAHlk6BsXlj6UZsIOVQ2K6hq1pjRf3npNBSHnRlm+nVxF7
	KaAVMA1M5KS9DQAVZhx3Ab27yMjYnLq2tPHCaOvCXWTjHJAZVnFV9MiojqquWOoo=
X-Google-Smtp-Source: AGHT+IGfiOEKnDNaalgfnB3KD7h0EQi2yCZ7mWgv3m5aedKUR5IN315UO5ztIdExPIF/cApsftfQog==
X-Received: by 2002:a17:907:7245:b0:ae0:d019:dac7 with SMTP id a640c23a62f3a-af9400665admr1165035866b.23.1754385380417;
        Tue, 05 Aug 2025 02:16:20 -0700 (PDT)
Received: from [192.168.0.35] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0a3cecsm867039566b.53.2025.08.05.02.16.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 02:16:20 -0700 (PDT)
Message-ID: <38c6b667-2f54-4927-8dbf-1d37b333a648@linaro.org>
Date: Tue, 5 Aug 2025 10:16:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 7/7] arm64: dts: qcom: qrb2210-rb1: Enable Venus
To: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
 quic_dikshita@quicinc.com, quic_vgarodia@quicinc.com,
 konradybcio@kernel.org, krzk+dt@kernel.org
Cc: mchehab@kernel.org, conor+dt@kernel.org, andersson@kernel.org,
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250805064430.782201-1-jorge.ramirez@oss.qualcomm.com>
 <20250805064430.782201-8-jorge.ramirez@oss.qualcomm.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20250805064430.782201-8-jorge.ramirez@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/08/2025 07:44, Jorge Ramirez-Ortiz wrote:
> Enable Venus on the QRB2210 RB1 development board.
> 
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
> ---
>   arch/arm64/boot/dts/qcom/qrb2210-rb1.dts | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
> index b2e0fc5501c1..e92d0d6ad1b8 100644
> --- a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
> +++ b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
> @@ -698,6 +698,10 @@ &usb_qmpphy_out {
>   	remote-endpoint = <&pm4125_ss_in>;
>   };
>   
> +&venus {
> +	status = "okay";
> +};
> +
>   &wifi {
>   	vdd-0.8-cx-mx-supply = <&pm4125_l7>;
>   	vdd-1.8-xo-supply = <&pm4125_l13>;
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

