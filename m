Return-Path: <linux-kernel+bounces-733387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA55B07405
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 12:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9143505741
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 10:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17282F3645;
	Wed, 16 Jul 2025 10:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S9zpFARf"
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777832F2C69
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 10:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752663201; cv=none; b=GXAXDt8/Eesbsai05gajp6n4GOTFKfRHXDZXR0X3uclq7ZQcoAUopAdZl9b7yR46yrMrsj07URHF6tySE3TXPWroDxOLQkDJdW5+u53YtLsf0+taSYHEIp6q5nOdrHuaksg3Yo+oBnHlhB0YaoNc0EGJ68U7O+KPquGa2ah4cuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752663201; c=relaxed/simple;
	bh=uXkQwXePVkjKmDB6B3sdrREQ8QLpKEcUmjYTykYPIl8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cLb220LkttFSLZyc6/VDY4r784kckAKkI29LrOo3lWU6FoxixZZeEbiUSL7vwkjyLVetPYGVx3TVwWw1AxtVX0AMgsn2uBWga1Kqc49p6VL0mDRBC6fXQ2s6o/3Y+JUKPwjQQp3hXDM+cmjd6cpEg55p9Pd1dhGXR510Bb6IJEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S9zpFARf; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-45610582d07so26627415e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 03:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752663197; x=1753267997; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8CW2/O0TzBqschJZP93TpDVHYIZvXtSrznuz3Stcnpw=;
        b=S9zpFARf5kagB7hbUoIGHG6WPHLiDLA1UTGYVWEaIJ/6GPEEHNjc9ApxHhX9BVVmro
         nspEE61Sa0YaF4OtBDAVBd3kISi+8FAMUOrPx8m7lu3NX8LgXQ8dkzvI8kutnvdUpoS2
         b4pTDxSOsvoD7k6vgq3UNP/WoXcACH4NOEsCIK0okDEJt0iohwK5QWQZAKnG5OUxCJ0O
         danbwAadC26xPonWZ8DU3eUqIoT4jggPUHo1vP7+CzahAIH5DrfoEp2u1zHyUQJbd/um
         fX5cxyqHWrJP050ruBwUxdJiooPQATQpzCrEPmg4w82sZa4Q1RkZQhEwp+dI+mfZRWTM
         dm5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752663197; x=1753267997;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8CW2/O0TzBqschJZP93TpDVHYIZvXtSrznuz3Stcnpw=;
        b=YLnrJM5tvVg+RzITeuEdk4nubJ11cBCR8iJh3lzmg3iZCmNsDPmJClBWJJ/mnSS51c
         Sf7dRajA/cMwyi+iIDdOH1Fn4kpl7kGpifxRxV738yKS4hyGhPq/kJ8Y+P5FhBJl1cgk
         h6Biq9/TCJyzPqG2a7lCDXqZX64m4LWllWSOAPo4FCU0pryuWfDRgqm77OVyph4d30qJ
         6HXZejsuR90+ZYWRObWiYUKiwvNwU16Pt+mcV3IE3IY559C5RLBO9KPhe4phcqpO1hVG
         NjSK8sy/aUlo16C9Bh+ZmF9tP0YJeyXWB7ySLbbcEgYgONFN7zfvhrrS0LzcLziyY7Cc
         cONQ==
X-Forwarded-Encrypted: i=1; AJvYcCULKNA6Dp95foy6NB0Pl+ztnac8BwOdTuRTInEl+IPo2GNOFYPRH3BeHcC2+vHIB3MbZEdGoZOAxuj8niw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBXR9eKjatni1LZKqO0vm8Y5my3LjURVJlG1o9Xyc7cZJ/0MlU
	4tRQ24opJ/M4inlrAvkj/3erPoedysBYilQQAvcLJg/EGcTl6crxu2/Udj4A/uK8ZVk=
X-Gm-Gg: ASbGncuGhht/hik7GG/r2X7bLVbzcigf56Wnda/A3AtBnggi5G/JOruCNXj0o0ZLgqy
	rmnSZX0AJ6GH2ZCAi1N5Zch++nXAC7ZG4/BGZ5FTJvvaL27sfHjOQ/g3jfeuEOVHpegc3CtY+tz
	W7Al7b8TYIwTLaNXc+VOPL6AwyonWsza5PX6Bd2oRvEKM+O7ERTPyHmHNC2davB4ACIWLVYAfV1
	vYsplMs3nM1NcSyx87rgynHzY7R+WjwimhNmjC4wljz69DtphCEpoJlI45ToR+iX67ujxIzrAEV
	z7GPMVnaXsV3SQeBDGKskXysTN7lHFIqJMHExal0RYLAM/N4VRwt64SyiRyDbheiE6kZT4aCAg0
	MLx0t12xmCQPaDgH4hhHD2XD/0utgPfSF+erxUVlQ1gVNfGk6XVlx2hz6Nyc8fGI=
X-Google-Smtp-Source: AGHT+IEUeJJ3NfX00M2OD8gjxuXAAcmIdfAZqCKGjvqb2/EEjyffgUkLner7WOBZzioDHf2iP0fReA==
X-Received: by 2002:a05:600c:19c7:b0:450:d386:1afb with SMTP id 5b1f17b1804b1-4562dfe6e65mr24230655e9.9.1752663196643;
        Wed, 16 Jul 2025 03:53:16 -0700 (PDT)
Received: from [192.168.0.35] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc21e7sm17523816f8f.36.2025.07.16.03.53.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 03:53:16 -0700 (PDT)
Message-ID: <a2681844-a96a-465a-a48d-49e1ede526c6@linaro.org>
Date: Wed, 16 Jul 2025 11:53:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] Add Dell Inspiron 7441 / Latitude 7455
 (X1E-80-100)
To: Val Packett <val@packett.cool>
Cc: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250716003139.18543-1-val@packett.cool>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20250716003139.18543-1-val@packett.cool>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/07/2025 01:26, Val Packett wrote:
> Since v3[1]:
> 
> - Applied R-b tags
> - Skipping the eDP panel ID patch now since it's been applied
> - Fixed the last remaining '-names before -0' order issue
> - Changed usb_mp: keep the unused PHYs enabled in the DT
>    (to let them go to sleep), like how it is done for the XPS
> 
> [1]: https://lore.kernel.org/all/20250706205723.9790-2-val@packett.cool/
> 
> Bryan O'Donoghue (2):
>    dt-bindings: arm: qcom: Add Dell Inspiron 14 Plus 7441
>    arm64: dts: qcom: Add support for Dell Inspiron 7441 / Latitude 7455
> 
> Val Packett (2):
>    dt-bindings: arm: qcom: Add Dell Latitude 7455
>    firmware: qcom: scm: Allow QSEECOM on Dell Inspiron 7441 / Latitude
>      7455
> 
>   .../devicetree/bindings/arm/qcom.yaml         |    2 +
>   arch/arm64/boot/dts/qcom/Makefile             |    4 +
>   arch/arm64/boot/dts/qcom/x1-dell-thena.dtsi   | 1666 +++++++++++++++++
>   .../x1e80100-dell-inspiron-14-plus-7441.dts   |   52 +
>   .../dts/qcom/x1e80100-dell-latitude-7455.dts  |   53 +
>   drivers/firmware/qcom/qcom_scm.c              |    2 +
>   6 files changed, 1779 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/qcom/x1-dell-thena.dtsi
>   create mode 100644 arch/arm64/boot/dts/qcom/x1e80100-dell-inspiron-14-plus-7441.dts
>   create mode 100644 arch/arm64/boot/dts/qcom/x1e80100-dell-latitude-7455.dts
> 

Just tested on the 14p this updated version seems to work just about 
fine - or no worse than previous.

Tested-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

