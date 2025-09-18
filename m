Return-Path: <linux-kernel+bounces-809528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E89A3B50EB6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 09:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9BB71BC5C54
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 07:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F083064A7;
	Wed, 10 Sep 2025 07:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XTi7q0Fg"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B8625A350
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 07:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757487909; cv=none; b=pRKbkJ+Cam2sFDWi5mSx57+eQ8gz5PcQ4yzlGOHCCj5gxSEuYgV5a4Ub9ZZqq9VdJCddC2KYbCIeNH7iSphUPn0OB7d7ZWHT2u3drTeAtcz45Dojuq1geL91HFjIj7MBf6KpxjA+6eW+dUVqpKA6ZZwe6t/abS9NUBoYwtENKyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757487909; c=relaxed/simple;
	bh=d8hmiUDR1FPyrv/h2Z5VEyQf1SylCYArkTOxhPAYJWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L8d6wZNA9M2NCcEx/XGM1jCHElpPbhg3EE4pHUh47jdT2T5YX4155f32zdk0hmBDiaeypyDSRr49uAafEmJkHnDm2BoYitZsvEj/XnYbVFO1souB5iaqMnysUWdDhlktud2BKl++I9XRxiwr71cqy5deSdf9gGFG4gDw1wgQ9HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XTi7q0Fg; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b041264542eso88828166b.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 00:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757487906; x=1758092706; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=as8/dZDO8owF6SFVquRrpoPe4TAAz7QgxjhL0k5eGCs=;
        b=XTi7q0Fgfqq1FMygZqR22zlilDEFvvRkaRGiO4WSjsxFKvZUV9zW43Ei8GJmbk2ILX
         7VXidQF1MzpsLQyvMO4talu+95vRhJD52cibqIb5XQGH1hetUVcGuPjie190Q+/5L0Uf
         EEFgzZRWp5TGfo5legJuyhx++DSK7hgJT+DkC2uwOvHWWHjSfZrP0DyPx5fy6Kjljl+Z
         01o8NKlO05fNuc/Jlf8WZ3BkjSU5Nx3WZ+ogqXwIAUBdJFMlUB1oeLAWeDTjTVucFaVM
         v9r29MWkeXl1yCR1OIL3fbHexT1nw8wB62MebafBdJWG3kd6vdf2lqixqZYI2Yrks0MU
         KeSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757487906; x=1758092706;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=as8/dZDO8owF6SFVquRrpoPe4TAAz7QgxjhL0k5eGCs=;
        b=EdxPj/FnqDU3jVq+eDTsl5NCHrEVA+ss1DoV7LLHgqVFZxZGJJ7hdVMhn0zg7EWu7o
         kg/jaIbUf78fKKVCo7JPUhSLG2lVseton8ufRQnDA3069yKNMftIb6VfNCiRqKQe/kOJ
         aXJda+9CPtw/6GkQ7kfqt6RDGKeR2R/pUaOp5sdAsE6nsbzfVec3h/Foi54hYMkkZSRL
         x7poHa8pX6qwq2Rm1pCA8BcYqXo/OTYq9mdYegUMDWDm8ElNGqWlZCHRY6Bbbbr7lXb+
         U5d7YQ0VxK2d8E7E+aI+t5WXs263OD7JOn7zY2FtBCR7eeDabvesQT/gA9b8wLetX7Tl
         g6xg==
X-Forwarded-Encrypted: i=1; AJvYcCUGW6rcqCkPivLX0TvqaKJrMMpSB0dsupbTGzMg5ZYMp+ZNj2RnqU0yVKzcC0mhErht8TnOe/ka81QcFSM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNoDuQ6BEYMWL8my3ImItk2H2uq77sd3jpl3Knyd5dUgV2cn2T
	e3cF7P8qtzeC04AP0DDIZq1ZXhMtk1azDyKHyDyhcNdcts+rQPf2nLubXUbl3Ocy7QI=
X-Gm-Gg: ASbGncv1TUwx4Z7DPA9uGL+Xs75IrPSFm2cnU6NiMobXRIQ6Pc+GhosfnOJPKwcAi89
	YL18pSophcfY6Me1jyTDBu2tEyTfoSf9qmZ4dIDGVBNkmH4pU5Q1BTY/QGpeQ3xFqEyeZQbcwLw
	e+RN2plqMRbAhR26RYjadT83hznxa1E0saNEjSRRUI9T5UMWFhcXPjjMFseY2/NWO3Sv1ntMtP3
	OQ/6KDcTx081idc+LGlg2W21K/lL1dKFGCmm8GMX3h52gtOClNwHH8kR3dO06Y6E+lKQm8rH0zk
	M3zp6Uc+hCkmjTZmC70MqHO6+VhTxytokL+b5uhBksks4QRJ2sDrgWHp62cAD8JY/aSC5WWSVra
	eHfBRHrRm9xyinQpOAtrQUBEvJw4SQo4vIX/lcd1S074=
X-Google-Smtp-Source: AGHT+IF3KfrNaYL9BAO6+0dQRxMKq/YdSHLmLqiuiTFOITlhEkhRhqhcPD3U+CMEhWrTIxTJYOV9jw==
X-Received: by 2002:a17:907:60cc:b0:afe:ee31:4b93 with SMTP id a640c23a62f3a-b04b10a4accmr724030566b.0.1757487905603;
        Wed, 10 Sep 2025 00:05:05 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07833ebe61sm116132666b.89.2025.09.10.00.05.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 00:05:04 -0700 (PDT)
Message-ID: <f1e3c3a9-9929-477a-b1ad-e485c059cbc2@linaro.org>
Date: Wed, 10 Sep 2025 09:05:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/7] media: dt-bindings: Add qcom,qcs8300-camss
 compatible
To: Vikram Sharma <quic_vikramsa@quicinc.com>, rfoss@kernel.org,
 todor.too@gmail.com, bryan.odonoghue@linaro.org, mchehab@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andersson@kernel.org, konradybcio@kernel.org, hverkuil-cisco@xs4all.nl,
 cros-qcom-dts-watchers@chromium.org, catalin.marinas@arm.com, will@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250813053724.232494-1-quic_vikramsa@quicinc.com>
 <20250813053724.232494-2-quic_vikramsa@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <20250813053724.232494-2-quic_vikramsa@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/08/2025 07:37, Vikram Sharma wrote:
> Add the compatible string "qcom,qcs8300-camss" to support the
> Camera Subsystem (CAMSS) on the Qualcomm QCS8300 platform.
> 
> The QCS8300 platform provides:
> - 2 x VFE (version 690), each with 3 RDI
> - 5 x VFE Lite (version 690), each with 6 RDI
> - 2 x CSID (version 690)
> - 5 x CSID Lite (version 690)
> - 3 x CSIPHY (version 690)
> - 3 x TPG
> 
> Signed-off-by: Vikram Sharma <quic_vikramsa@quicinc.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/media/qcom,qcs8300-camss.yaml    | 336 ++++++++++++++++++
>  1 file changed, 336 insertions(+)

So it turns out this code is wrong and you already sent fixes for it.

Bryan, please don't apply it.

Best regards,
Krzysztof

