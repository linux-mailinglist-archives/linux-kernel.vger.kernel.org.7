Return-Path: <linux-kernel+bounces-731570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B60B05663
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 11:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 654BF1678AF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 09:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89FF2D375A;
	Tue, 15 Jul 2025 09:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="idt4IPX1"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F48F1917F0
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 09:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752571983; cv=none; b=ms8Wx5Z8swTRBzqu0kqGc/ejIdEiEJ3kClrOBWQSzXVAs9hBvaaCNQNzq1rVVDIfGiujesdhA69gW/qj8Oit+8XLdfveosuphmhEES12q97bGl1XdHVkwZDyBPFUyCqOZ5pRa8KGqOvxkPl6Qls/0MaFGiRrkoho/XA0Q7oLvHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752571983; c=relaxed/simple;
	bh=XlX30uvNi0+08PXyWI9YmJs8eShmHqEEMc9JhnTOSjA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RBvs/XSjUzTLOynRp048gPDWq4wopKpV5pQE9T7TlecrXnLCkITPIGXFsdMYHh8bS/24MXshCG2LgH9sUuQ5QtEPAtUgGMueUp0DXlREtEqfnKDlueimHFdS/yf80OuAlDjyrW6zH+aeR0Cw3HdTwXZ1mg/DPHWZ8VXpqYJaAHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=idt4IPX1; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3b39c46e1cfso647354f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 02:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752571980; x=1753176780; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0jJME/khjaXQwKsx8AR3T7NhPGSZ++gvfi/UHBNBTFo=;
        b=idt4IPX1MZJHhog3vsjpcY15TtUh20wqP4ZiTEmYUNBjWQ4XYopMDZXUJ3d+E9ZII/
         q5Y0OpdmZb9yWrUOgNbxU6IW/eJlXC1gDH6INQeMJOvfMa1yUbA49pymbjxmFSj1dLag
         CZ4cdYBfin/YT32NGG9AXT2o5S7V0Ji+aN5jlcphPvuFMxg9/pQChgaGuqDZNOHqlJuB
         qGpyYFjp7aYMT0zvS/zaqeEf5x08RkPT+x0lOcn/MgcjfjdIigV8sH8T1IwUwSxfeAc7
         gdORSka/YvQsC2pWFwdGGDvvLMnGJ7iWAGczcDPQjHU7EDAjWT18aHvvKYLFbNfPk+/l
         BfTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752571980; x=1753176780;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0jJME/khjaXQwKsx8AR3T7NhPGSZ++gvfi/UHBNBTFo=;
        b=FbPub5xTFzL5pslF6NFDc9JMHsxC2ms3+/8tvwMhra35OX2BYu0h9MktKR3fxj9gbk
         uPqI8VhNTTALhrbvGFUlBWoTrdlUPJu1PJY/i4tPQ1HTeI9sjZNUr8TNpRZvfzIimR64
         vXnAleHFtFl5hs1ZCw4LgD7T9ZPnn46X2J95TGh4mKU0noHwNG1bPAmFVDlLrMZ8V5dL
         CKgPp16cNjSaLQQ26Dk9BZGPMIWdwFTmPDuTDI5EeKe8dxHZEWmYvpqSuFjqrJAE3NgH
         TUYZ3NLuvk556b3FSXtt7R9Bbt9r2Z4QMqzRLqhSTC/DfwJLcqGTqzc4sXrvsqTTRNtD
         RRBA==
X-Forwarded-Encrypted: i=1; AJvYcCW5onIl9P1Lq8mig4GWST/PVHOTvhYZQ6fsZ8lbmplDcBXvff6tpLkfAbXV7Zk2ueZthdoJskwa0vuYI0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbaPTz8q2jpIX+6k46f99p2XrKyK/lrAONtnwrkF6Jql8ZI+4n
	OmWBp3xkpmhs17xLtDUCt7AO2dE6DzPgtXLfYSOvym1RNEfNjJVLo1i4TdnW8g3b7cg=
X-Gm-Gg: ASbGncu4Nqk+g3vz4843QY1VjsABKskBeoB3YsTEYDmVae/xEHKkCZrsN5/xPY89+j8
	mJpihzDDXTEZSDSLZ2DN+VV8LY0T5m9HyGWPgxgK/J3v+hNeNCC63fbgvehn+LxdvEsBYJ6guC5
	Ivs+vKplYD3MUqgPPI2D1xL0QoOwBlkb2JNgDodHGOPP8msG9Zo0K7HkmkDLLtOMTD9Bwdy2k+j
	FvOJWolHo6GePJMVwMOCeJbQt/2cLwLKS6Pimm+v//fI0ML6HI1xMNnc8pn4zJjElGTkW/z80KL
	2850QX9d1wgpiZunS5m1Lf+VO2cjnod/MEqzThNDYcTgSenbhTXrbLsXAFDdebLRxlwvYS+SNSX
	pYCR6bgOTFsrLrqiobNh8u7pXQjwbH1LNcooTnFAuYw==
X-Google-Smtp-Source: AGHT+IEQlBlRNnKUL+sVTdwMNTFRhe00dUVaelMbSdO6rnFWbfQZsfNCT+9BwuX/7wATZB7qeJ/7Mw==
X-Received: by 2002:a05:6000:2483:b0:3a4:f8a9:a03e with SMTP id ffacd0b85a97d-3b60b2bd879mr307360f8f.3.1752571979682;
        Tue, 15 Jul 2025 02:32:59 -0700 (PDT)
Received: from [192.168.1.110] ([178.197.222.89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e0d867sm14870582f8f.61.2025.07.15.02.32.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 02:32:59 -0700 (PDT)
Message-ID: <5dd36649-821c-450e-bdcc-871735d10059@linaro.org>
Date: Tue, 15 Jul 2025 11:32:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/3] arm64: dts: qcom: sm8750: Add Iris VPU v3.5
To: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250714-b4-sm8750-iris-dts-v1-0-93629b246d2e@linaro.org>
 <20250714-b4-sm8750-iris-dts-v1-1-93629b246d2e@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <20250714-b4-sm8750-iris-dts-v1-1-93629b246d2e@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/07/2025 15:55, Krzysztof Kozlowski wrote:
> +
> +		videocc: clock-controller@aaf0000 {
> +			compatible = "qcom,sm8750-videocc";
> +			reg = <0x0 0x0aaf0000 0x0 0x10000>;
> +			clocks = <&bi_tcxo_div2>,
> +				 <&gcc GCC_VIDEO_AHB_CLK>;
> +			power-domains = <&rpmhpd RPMHPD_MMCX>;

This is incomplete, need second power domain and I did not check against
qcom,sm8750-videocc schema before sending. I will send a v2 a bit later
(maybe some reviews pop up).

> +			#clock-cells = <1>;
> +			#reset-cells = <1>;
> +			#power-domain-cells = <1>;
> +		};
> +
>  		pdc: interrupt-controller@b220000 {
>  			compatible = "qcom,sm8750-pdc", "qcom,pdc";
>  			reg = <0x0 0x0b220000 0x0 0x10000>, <0x0 0x164400f0 0x0 0x64>;
> 


Best regards,
Krzysztof

