Return-Path: <linux-kernel+bounces-816712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F18B57782
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDEC84414AC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 11:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE2B2FFDE0;
	Mon, 15 Sep 2025 11:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hbtgKJUa"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7E62FCC16
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 11:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757934059; cv=none; b=oQk6rywTgCqi054DOtDCf3RaMDDQu99TA7K7rLIho1wBffPSlSDu6vrumgXR2xJb9UxMtycRU8iEXDbrXr2yUCw0O7jTNoc83+8RuYqrGyLRG9GNqbg1zj/5lXAS39PBtFnmHHMfF+zlAMduaemL9aJ1rFA7opq59cQRxmIIIx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757934059; c=relaxed/simple;
	bh=Oa5cWbDm7uUKMCDYHkC/Iu8pqcZkNUOYxbEMQLIRbsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KTbPfW/zE2qWR2WKS0HbAbzS/Kzwi/YllU+bQofcLmiYkoO0u8Hw/IzOEiROA3mAM2iayOmJc49fvwW8hCAgdtP9ZeyWasSryjMOZPYps3hpMTMSKZgxk64eARXvJ/b7xGfIIWITtjQd7+WEzVIsCtZkvW3nV3XpHE20BlbYHto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hbtgKJUa; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45f2a69d876so7775465e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 04:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757934056; x=1758538856; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T63X1LQwQk/2hAt8FKtd7anGWLgK9h7B68o/CL4jZ6U=;
        b=hbtgKJUa9vPLZykYf7Vy5SIj0uogdEUHkP9dSCAGJiGGqUXmGGIleSUr5xvijPWcDL
         JrKLEt4q5Z6LHtMojVA8C8JfsfGFflWVwE+f4qtPau8Z0pr3lXrpnMF9VHdIXe+W+yBM
         k6rCS8KEsCJSSsUKGJiLZLlUb8WXfust5jTbSLPuUVWusZMzNpHuQz9A1rrAw4XFcV57
         9elDRxcE+KH4VdxwMywHZ75avK+1L2etboYiGprznIOfrjuAYtRPWoV9ZuckSexh2gWB
         FNEMy1HSrVVt0lefMVLZOWvYk8Q1jnRUzIyChjPAag1pmwD2Q5GR+r6rkZZ2DkD1mTtO
         i16Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757934056; x=1758538856;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T63X1LQwQk/2hAt8FKtd7anGWLgK9h7B68o/CL4jZ6U=;
        b=juQnfIknIuFoAwmCNLTw55NxOnDcQl44AGbA4ij9ivv9RJ5va3DGDfLjfrzMDdiTc8
         9FrC9ochjLhEGsKfFe7JM9vxFzVzG7Y/EJyDQHL7dgS/jPJiGk6c55xDk5exGjFWeMdP
         xb9id8LFzkBqQ536a2IvWEDEH3wYi1e3FAss/adlW08U5YuKMwtm+AMzfz7TlTJqmcNf
         Hu6G/v++S6MGLE0hPRymkJhJh8f9xCvGrhm98vrWMtA2liC3aHauAUJk/zQPeQjDddb8
         O/zIqQQnn3SURqt20r9WMYydca+/hCJrryQlXrxH+xmPqybUxfhuVUXepT/gM0QVin5C
         YkZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZvZ8Xs75KIz0nIytAoPHEurJC6YmvdR4VMhGHEGFh1Z9CaIhTKA4rRTSIUfJGXjpc2kncg48L/HUmVi4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpa/mI1hvZyQRFroaXqOXmC99dFKLMYYzeGzfAUcCO9d2G99LO
	FY6kOis9tc3Jd8aO6Q4FeCEteMb6zQ4o05rNzoKGQ8toO56IGFIZNxUcPbyy3CLCvKI=
X-Gm-Gg: ASbGnct7k3F0BOEiFAS0G21wBXmTKU6NibP2fC2vvpLOuAzmNuIQ0ixULTIMW+eYqH8
	gbEzGb7lrIfgqCvSqbveYpzLsoe0tYMPPMpi7pG6fr/GW+kqJopSGQXdfJgL/kUy9XixCWJViNv
	ruoCIar6Q+K4PD2bTrQE1rowGEAzUllQagz49JGNGxUeGxe0YhZYyS2RnNZ6FHQY7ULSAIsJLti
	omQl0+B87C8mGINHybydcK8ig7OiXMBXSzheY8K6hX1Pxg1n8dxgMW1GfzfCGrTs9wTI98dCkCe
	5lAqrbGBePJattOk9FYMdSd+UlOMoXgPAVwESXZ0twAE88aKdd4auEjoDVuEd7yovLg7JAtOO3x
	+hLlwGYryhWV9/Fb9QHlBlklYoQxTWFCM9IGUKbyqOd86rzEj2LZ+RNlp1cORSx/dffS3LLiySw
	9M9kX0oYYho5HCYLWy9NqQAvD/GtGaYw==
X-Google-Smtp-Source: AGHT+IF2gIGDbHEOgoK5pROighRDhmTz+p7m86Ot1mCrRJvMBJ6OX02h9vrPcUk6pgDO2JUXpwgQlw==
X-Received: by 2002:adf:f547:0:b0:3e9:2189:c2ca with SMTP id ffacd0b85a97d-3e92189f2edmr4043887f8f.39.1757934055977;
        Mon, 15 Sep 2025 04:00:55 -0700 (PDT)
Received: from [192.168.0.19] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3eaa6476fadsm4123755f8f.45.2025.09.15.04.00.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 04:00:55 -0700 (PDT)
Message-ID: <51f233b2-f348-438a-ac11-0b711617dc0f@linaro.org>
Date: Mon, 15 Sep 2025 12:00:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/9] arm64: dts: qcom: x1e78100-lenovo-thinkpad-t14s:
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
 <20250915-x1e-iris-dt-v2-5-1f928de08fd4@linaro.org>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20250915-x1e-iris-dt-v2-5-1f928de08fd4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/09/2025 11:06, Stephan Gerhold wrote:
> IRIS firmware for the Lenovo ThinkPad T14s is already upstream in
> linux-firmware at qcom/x1e80100/LENOVO/21N1/qcvss8380.mbn, so enable IRIS
> for the T14s with the corresponding firmware-name property.
> 
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on Thinkpad T14S OLED
> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
> index 23213b0d9582822e9503e4acf18c62d5c8c7867d..0a989e9d3d23146cb9689b68ba6c5779283b3c98 100644
> --- a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
> +++ b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
> @@ -967,6 +967,11 @@ touchscreen@10 {
>   	/* TODO: second-sourced touchscreen @ 0x41 */
>   };
>   
> +&iris {
> +	firmware-name = "qcom/x1e80100/LENOVO/21N1/qcvss8380.mbn";
> +	status = "okay";
> +};
> +
>   &lpass_tlmm {
>   	spkr_01_sd_n_active: spkr-01-sd-n-active-state {
>   		pins = "gpio12";
> 
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

