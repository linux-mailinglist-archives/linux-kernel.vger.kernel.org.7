Return-Path: <linux-kernel+bounces-800052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F92EB432D1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 08:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2752188D2D0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6EF2798E8;
	Thu,  4 Sep 2025 06:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ctuChMNB"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059AE28541F
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 06:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756968714; cv=none; b=FKcgSNPPDNmoJVBPdEecnteRgIi17XEFiuHNsHkKyjI1n54RRaKjhqr6EQ/h4Oz64sJkF/4Tmg/xq2kZj3U0AZ+Hj7UDknpsLxJBaoq526Ys4G/d2zSgZFDvHr57R0HLVdGCnS3KIK1Bid7H1gVCVZxYFV6b/990r5WkL/8ouu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756968714; c=relaxed/simple;
	bh=IJy2vjz+7fPQ+XrcqTgMIkNFU9ThCqtlQVZ8lYBivd0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=FQB2BiV6Dj3q1wkhK17P+rxjJtkcTbQEWtN2rxB0+6IR4/VH3eejJIClZqn3GgUNH/UMedxMFYDdrgJ4MWKG1i4AAdl1Nq2Atj9IqOqBO5N7Ha+jSk9yfCf+64OoppKuCHIrI+9ZfT/kEK1zVBOessfWiIXyOtugyyOeP+bNbbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ctuChMNB; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-61ec7a9a002so112319a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 23:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756968711; x=1757573511; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CdjOlgNh/y7eLo86RUzv7Bt8tBIqvVaGzK6r9fvl2iQ=;
        b=ctuChMNBiRqJWUw0eX58/EllTiQZdyD08VfZz56uvs2tYg8E9cM8jAI2e53jaeC0QD
         qkO8n7odIVznY3H9ThpLBwYZIT42mB/a8Xuc6F+NPOBLt/VcZnKc3SACp0Qf3dsM5CHG
         928mAj88YRHEeVI0ojXvoLwanzG490VxLJkFpaqyMNgbsS2M85cs8K8i+TJmNtt9VxMC
         4U2j84gdvAjaiyQItX40lpRdqwX6+6nGpn+jUtGQLsyyPHfHksnhzFT+V5pconpNMqrW
         YACWKFdmV+ZH9A65yyP/U5r3seD8IH90IGychBuE9R7EPdO4KWiHDy8mzDPjNxoJGCY8
         y53g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756968711; x=1757573511;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CdjOlgNh/y7eLo86RUzv7Bt8tBIqvVaGzK6r9fvl2iQ=;
        b=G5jkjSHVpvI/Bf0Wtupi+TgIScoJ5hkatOwjJ5QoMqWXyyRKbLa2YArLgSnDPqLMTh
         MgrLtUWwU8J0U2sBIs4WkVyiYVSFLKJnSbn2+spAurycdKUFCcl8k81F71oiY2i+v8Ls
         q4DNNKorY/+VpUram9Tznyw93/KtrtRT5LcdWGAtA1U+u7VAgNzrKo7gkqYe8ZsBijqK
         uG0En8Y+lEedFdX1oRto7yMXn9UPmBK+qytjQQhybI0Yo/ln5RsBtRrqFR8qfTvehRRB
         DfLERpIQqnCf9yp10EIyDyqT0z//n6gTp/RWJEfEXiNvNFL43RxevQfM9gPbds6oMLk9
         yZSA==
X-Forwarded-Encrypted: i=1; AJvYcCWzV2T0mG69/Fm1gxAsDzNTUoIRZwd6RtrMu50oMCBPWPqOHEp5PMMF0mFqdfuxJdpTHM14HbRh7k2+lqw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAkBN8Grf/yQka8NtmQJ8Dvbbyes01KmZExxsORgI0eUc+pLAT
	NBsq62LgUNFOkPtnDq+eQdKZ9Tzi6t9QH1OY8xQkFmN8XVhGvMC0jeFGvJe/BAxYkE0=
X-Gm-Gg: ASbGncuFcKAe1bMNeeipg0KLrGXW2eWHZL2sUqmxUDjT1+yqJOMEi/0GvyD5eaRCazc
	atuH+l+QNLQTjNou7nZfovK+VOv+Nm025Nj+lMxkfJ0XxDgH/DFv4cCmQcqVt/kcdAnxfKcHifE
	hFfrADIW2m55PBrXd3MTGttdHcxoSXmsoSWcvsr/Vr/RS0HYfx4u6JsAr3qsCSQsqgHVvL/71iH
	mxpXIEGHFDe35Cg4GRG7XdqRg4HHpPscZmo7IGeyFNUFYmKDNaXUP0oD2RIUkB1bMj3MsKFduCS
	GKJ6kHtEKDYsbxP2iIHYbBtULL9SkOVqxPs3UPsYHItneIppX4x191mf/GscK/yW9K44YsI8Qe9
	FcYKKJLaa8ArdezHdRgqmx1tigvuAEb0SA5m9msu6EpBn/ZtvPCW12Q==
X-Google-Smtp-Source: AGHT+IHmdmBdwywisUEuGkl8Y4YRksf5bRCeh9RSJ2PP2a1QEuIml1vKP+r0gUO5VROTDRi+NY5XOw==
X-Received: by 2002:a17:907:e8d:b0:b04:79ed:73aa with SMTP id a640c23a62f3a-b0479ed8b38mr125555866b.1.1756968711268;
        Wed, 03 Sep 2025 23:51:51 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0416e878a2sm1073819566b.95.2025.09.03.23.51.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 23:51:50 -0700 (PDT)
Message-ID: <49a1ed5b-2afd-46b5-b5b1-74dd82dae95b@linaro.org>
Date: Thu, 4 Sep 2025 08:51:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: phy: qcom-edp: Add missing clock for
 X Elite
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Abel Vesa <abel.vesa@linaro.org>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Sibi Sankar <quic_sibis@quicinc.com>,
 Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: Johan Hovold <johan@kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250903-phy-qcom-edp-add-missing-refclk-v2-0-d88c1b0cdc1b@linaro.org>
 <20250903-phy-qcom-edp-add-missing-refclk-v2-1-d88c1b0cdc1b@linaro.org>
 <04437373-c5a2-43e4-b591-921ce450f3d8@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <04437373-c5a2-43e4-b591-921ce450f3d8@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/09/2025 08:50, Krzysztof Kozlowski wrote:
>> +allOf:
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          enum:
>> +            - qcom,x1e80100-dp-phy
>> +    then:
>> +      properties:
>> +        clocks:
>> +          minItems: 3
> 
> That's an ABI break, so you need to explain it and mention the impact.
> Reason that there is one more clock, but everything was working fine, is
> not usually enough.
Heh, I already asked for that at v1 and nothing improved.

Best regards,
Krzysztof

