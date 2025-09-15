Return-Path: <linux-kernel+bounces-816705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F41C6B57762
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FDC116E28A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 11:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7FB2FDC51;
	Mon, 15 Sep 2025 11:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YdD0Ed3X"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EDD2FD1D5
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 11:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757934005; cv=none; b=HkhR2qnBXNio7HyF8pUW+A94tq9Z3wgLwPPWFx4BYG0FWOyXwlfx6IePCs4wEVjJ7/3856UDUkBiLf5O64zIQEwc8N2dHyqzWK+z1kv/6wBbd5myRUX7og8OLcMcZ1TUgfT410PHeX7nEeO53/rUufTlyP8hcz15SiLxiQ+nBHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757934005; c=relaxed/simple;
	bh=p2/ZPKgcStHycFEf+Ant3HyIhob+pL98PMAiJ6xa878=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jVVUwyItNlqlGFEG6wUmNhuVkX+EfLcbFnPuKvzLVX0XQ4hCmotj2+D7lGfnJmpqpnOm7qo0JtMrqUVgPFj+7Eg1wiwW3ZMesEPlMCQINI0AwWzLZD8LWgXPY55mIKWYGk/o3TGU2nT6pl9SNJ3UO4R1UxgiKLyDNP9+NoOk1RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YdD0Ed3X; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3c6abcfd142so1953822f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 04:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757934001; x=1758538801; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O0o3IPn9M5Wlzy4ZImaO9t62aQnz+OKdCohSLnutdNc=;
        b=YdD0Ed3XUrX4TUOikbc9/BwqSOqpypZ9g5RBOhB/j8Ez2BL86LzxXgQv2CWBz9y7Gy
         dERReEqK3NkuNg3TIcH5aZ1oiMVgjKVcWAUBQqeCdwFp/T5+PCEExIrLSJN2MTDOliGj
         22RjVgdzcAu82moJ3nIrf0RvszmmDiHBT67o7TFrTphTM72PygNfTc6t+xjoGijmIlVf
         m3grXCH98uWIdmnBTVINfXnDuMzLyAOS2D0dFWF3bqEDVSn/T8XMYheOkapLwzFdWStD
         K2WOYhsY/QIyTc+pKNtmRiafU0wVeT9IURn22bdrRMK2ndCiWNkYHCCssZijxlrTVsTV
         rw7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757934001; x=1758538801;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O0o3IPn9M5Wlzy4ZImaO9t62aQnz+OKdCohSLnutdNc=;
        b=Xqh7GmukAoyXq9pHhVu/EEN+ucMbXq8OPQW7yHZ6yq6l3YdjtG15OfME8bwvmOxTFy
         6rdSi2c95AGNW3DnmFtdV5B5kD/N6juzxFwQx4CgsZZI4S5B4IR4wtuwLw88+KiMmgcC
         7WYii3/aNkgsYHUB8lOEVECoK8PVarPQ1RBDmrK/8s4X6AKUjl3jV+JfDuSxJ3nrQsdt
         Z+GL8VKs2fCX4srMW9/qpynYmZxKkqcs/8eaNqGWwKgjb6V/sncxAR4QAlcpUtEtnoYN
         2J9Z/Xj93oEHUqhQIKjA9cgzkoNrxmmmneWCIhdxaFYZcUmpdj/+jvnodipyL+rPgU6e
         Wgeg==
X-Forwarded-Encrypted: i=1; AJvYcCVyrfr7o3YvfGaBCY+MwUlGAn4gGx79tg4OJYuvhOJ9sfBUPfJbtwIYkg06AaWFktSO1+3ActCNE1pby90=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIU8o6I4DyQtF1ZNTePpo5nFm5dka5/MrZNYGIfzswiIGRkn7X
	RVne3KjbZ93/SmhiSm9J7J+mJphxEBNbhWxyYzOtgp5K4erpcahfC27DRuLBFukmjw0=
X-Gm-Gg: ASbGnctbJrwd8ypcG/RIpQFrCWrZR4TBUEdfU9pil+YMPPHAHgNekeioQm9iVhoBYqU
	qN91NS6GAkb6z2LIdFq4jPE4iFwTgWnxR4ShgrTbvNimQ5xgusoXdNwRwVXegK2ajIffFBq+R5i
	vcgMqd/6oM2JJTNVCtxl/OH9iozN2lVopMgPHzeq9cPDakwEJBPr6lgYzYCWKyoP+JHj3ON9bX7
	XqXfMYR9Rd73vdGX7feQ0XuZfd52JMiPFRvuufCAiECgH6duPe3JVNE/F27dbbIhHRRfI/4FNU+
	HatTxbRNUJFPEEyG7rI1K0FpGUP63RmP99bwZiOmIAS/Ja+NgdSkD2glUVzszfcBwf3R93z5Zyn
	DSvdeQqS7an8u+r1u464vsW3wtrC1we2qKBb8RJmlAu9X+AsenNz7wlte8I4222D9SjXvBnYZn2
	7s4ZGeL3/D+mlLKKxQM18=
X-Google-Smtp-Source: AGHT+IF7I4hHNfu991VPRyMDMxfa7LI4rWf+MOpyFvwb/HmEQhJI0mbx4eiQS7LrjFmOi7A2pB86wg==
X-Received: by 2002:a05:6000:2087:b0:3ea:b91f:8f4b with SMTP id ffacd0b85a97d-3eab91f94acmr1414030f8f.4.1757934001081;
        Mon, 15 Sep 2025 04:00:01 -0700 (PDT)
Received: from [192.168.0.19] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e037c3ce5sm172289455e9.16.2025.09.15.03.59.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 04:00:00 -0700 (PDT)
Message-ID: <4bca13c2-0bdc-4709-a502-805f2b842846@linaro.org>
Date: Mon, 15 Sep 2025 11:59:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/9] arm64: dts: qcom: x1e80100-dell-latitude-7455:
 Enable IRIS
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
 <20250915-x1e-iris-dt-v2-8-1f928de08fd4@linaro.org>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20250915-x1e-iris-dt-v2-8-1f928de08fd4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/09/2025 11:06, Stephan Gerhold wrote:
> Enable IRIS to allow using the hardware-accelerated video codecs. The
> firmware is not upstream in linux-firmware yet, so users need to copy it
> from Windows to qcom/x1e80100/dell/latitude-7455/qcvss8380.mbn (just like
> GPU/ADSP/CDSP firmware).
> 
> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/x1e80100-dell-latitude-7455.dts | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100-dell-latitude-7455.dts b/arch/arm64/boot/dts/qcom/x1e80100-dell-latitude-7455.dts
> index ace2a905e4430d6cd1db59e9a9fb7441f7fe0aa9..32ad9679550efce1fda1182bd874d6a3c53d8f03 100644
> --- a/arch/arm64/boot/dts/qcom/x1e80100-dell-latitude-7455.dts
> +++ b/arch/arm64/boot/dts/qcom/x1e80100-dell-latitude-7455.dts
> @@ -38,6 +38,11 @@ touchscreen@9 {
>   	};
>   };
>   
> +&iris {
> +	firmware-name = "qcom/x1e80100/dell/latitude-7455/qcvss8380.mbn";
> +	status = "okay";
> +};
> +
>   &remoteproc_adsp {
>   	firmware-name = "qcom/x1e80100/dell/latitude-7455/qcadsp8380.mbn",
>   			"qcom/x1e80100/dell/latitude-7455/adsp_dtbs.elf";
> 
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

