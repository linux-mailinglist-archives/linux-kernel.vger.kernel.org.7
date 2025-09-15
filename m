Return-Path: <linux-kernel+bounces-816716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E80BAB57790
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8025E3ACFF7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 11:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC2E301489;
	Mon, 15 Sep 2025 11:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jahlDWKC"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7B830148C
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 11:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757934087; cv=none; b=S2X1LDbY0rqTX3jxh8Gv+WRYU6yA/4ZxnQFe5k0OexD1n+nK1b/1IPuLzFUsyDIgO7CArG7IqknXhHBEEPigxzxvBHeAZjS8J5UUZu7OSCVNShUaembUcaBv/Jy87YAMRMNU5G19Rz0feuStDXHRImriIsQOzdVjsuB1B3b8ut4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757934087; c=relaxed/simple;
	bh=+xw+xFdVsHtu1zD1rilwuvSTdD7/B9mEEYjrzi4uMe4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r5vsZ7+nfXmAT+MAbbG5SCnGCscIELKNGhIwAytu8Lq3LhZlfW4MuI0u8eHkRGv2KPqqNTTukFu7uaypfS23blqwJ+toV91jQZBcf37HF8WEyumknZWZxNvV8T2hVNwXOjBOp9HWSp50W6jMe/nH9aJ7GGCmpd6XSMi7Obde1VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jahlDWKC; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45deccb2c1eso30966395e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 04:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757934083; x=1758538883; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V8oIXqr3dPAcqClDjfphWnzGOsz2ovd6WwhHnU/sb4k=;
        b=jahlDWKC0UK/QQ2qwQCtYzJ9rX1UjOoVgcO8b4UQuENLjfDRJjFqZoDYFJ7NqDmX9/
         MBC6So+XLT7+PhyJlwnM+8xMMxXs+jRQit1LtI4nlPhdpp+NsusBYfDcxcj5C106qa00
         LBPF3h+T81XJWFjTuPX3lnDDObOgV66MzftqOWlffFxApiHknvfFdAiC5E8jITB277ry
         gImWi/AYjggLFLYALSd9UFQxFcNxqj0t+sxCdfxSAST3TSy0aAJJm5SQ2wIikCAhcbE9
         OuwKFqfbWmlaZBCv1JpqDZpNKwfR5bomt3xru1/PG6MnZpCEMoagkXqHeWaP1Ip5yI/7
         bhBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757934083; x=1758538883;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V8oIXqr3dPAcqClDjfphWnzGOsz2ovd6WwhHnU/sb4k=;
        b=KizyMsZVGpjYQ+R026hyQVhT82iK2lNJVR8080a8ZG2LaPxa0pPR7PVMn9QfBjFRx9
         KPFiBComh6cj8OLLRJISloGleGLHAgJ/vJza1OKbUauhAS3adLdbvWj98+22N4M00rIy
         96OvZRzmhnh+BGujdwCqpY/tEiXTb7mIH5UP/tsX+jplvW9wErZRZaMshyLsFpvGvw6p
         VMAlV0icGBr1UdgkvxCJXFYGDXT6anSyiwcOFxnW1Rx7yRp6sF+/GLNs0NS3NEcagh7w
         20AMBBdZO05GTAhn0+y3f9UYSjMZiV9cj/dHZ6cj8MzX0TsMsOaMBZm6MOkCSnwhiX1w
         7qYA==
X-Forwarded-Encrypted: i=1; AJvYcCVOtPUPJZkt15Uz7rH8CqZ7Uku70gDTuGUl6ZcwyFhrGoVvmIGKqiqfKZQHjssBHk2Y/ax0KpkNQPjN/rw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzllMRNJwN4XoGCQXr+lQ98VTriG9O4cgQYe0QLLtUuocUFGD75
	3eoXXn6e/8sTD6BCJcy6qnng/RiR6J0awq7BqygHXTXYgE+PW2u2+Rq3nqRdlmdve1k=
X-Gm-Gg: ASbGncvRy/VUBtY4G/a3QyILm4CzAPWlzGjk212itcfI/iiCU9JRNHI7vUy4P51UtJ0
	kKFmqL1bHosv6fHWRLmtnY+P5XhhCwOemJMtu+eLY7PK3WefDGbHv7f8heU21iB0XPTBGjR5Wmp
	pjEoKodDfriUYBacK8tVxwGVqvF0/wIAJyOuP2rZ1jJLuKofpab0kxHcnSCni41TBNH7P4AXCBQ
	SvLtFZ9NNHhhESsaiA/yM50ojfutd0Btd2pDHuqkwIFILeY9QQ2ayEVfWCBFd9/BfaBRndaoE/0
	MZMhVWcaY7+HlcAoWFqf1ofFDQJYRuzd6LRKnldL/bVKGMPXXa1FMnwRZxx0Jm8ZF1c061URIym
	7ZgaGPRiVP7365uFoVPikW2FIlWvQAmmx0PwguuapBsf8lvcnGXt1y7RaIQUajGuoqX7op9+Fs6
	KXcq/C162HirQKzlITp1kNoPAdfHFyJqWDCHaf8kW/
X-Google-Smtp-Source: AGHT+IGhUiTErRJMkwIOQHIOBTtyreq7jo0zoyWEEW8wbkAfUFUJ2Pg3JyaoFNKl+Dg3YdUplJLZzg==
X-Received: by 2002:a05:600c:1547:b0:459:db69:56bd with SMTP id 5b1f17b1804b1-45f2710c252mr59087885e9.20.1757934082527;
        Mon, 15 Sep 2025 04:01:22 -0700 (PDT)
Received: from [192.168.0.19] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607878c9sm17402678f8f.26.2025.09.15.04.01.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 04:01:21 -0700 (PDT)
Message-ID: <5cb6b6dc-e5b6-4677-93b1-daefbba56d5c@linaro.org>
Date: Mon, 15 Sep 2025 12:01:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/9] arm64: dts: qcom: x1e80100-crd: Enable IRIS video
 codec
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
 <20250915-x1e-iris-dt-v2-4-1f928de08fd4@linaro.org>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20250915-x1e-iris-dt-v2-4-1f928de08fd4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/09/2025 11:06, Stephan Gerhold wrote:
> IRIS firmware for x1e80100-crd is already upstream in linux-firmware in the
> default path, so enable IRIS for the CRD to accelerate video decoding.
> 
> It looks like the X1P CRD might need a different IRIS firmware (possibly
> even changes in the Linux kernel driver), so keep it local to the X1E CRD
> for now.
> 
> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/x1e80100-crd.dts | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
> index 976b8e44b5763b2d6c0f4786bf5809fee29dcecc..dfc378e1a056a8af27ef4b646f7589e7198dbaf8 100644
> --- a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
> +++ b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
> @@ -16,3 +16,7 @@ / {
>   &gpu_zap_shader {
>   	firmware-name = "qcom/x1e80100/gen70500_zap.mbn";
>   };
> +
> +&iris {
> +	status = "okay";
> +};
> 
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Tested-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

