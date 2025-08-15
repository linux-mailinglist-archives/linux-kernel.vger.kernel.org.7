Return-Path: <linux-kernel+bounces-770759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8D9B27EAB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 12:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAF09AC4C37
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 10:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4AB2FD7D6;
	Fri, 15 Aug 2025 10:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nyECjAGZ"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1216A2FC89B
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 10:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755254682; cv=none; b=p+Ue/2huESiclfJURgHBwK0ccBpd+cGD2V7vudQirMhUfjdEgFVvL7Ie3Da4JH2po3ogcmPQdl+EbC6A8VM4IkBiKHenR0gGPjhFXm9R4jeqdGaELkAj7BcGuxGTXbSoLOaGQPwaIekbz7nj6uD6YSeSaJwpzbq5lmyQsV5SDg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755254682; c=relaxed/simple;
	bh=8LA+2kJNuPIw2fJF/HLy1WPGQ4k/QzgOM/5kdp6JFgo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JV+rFwdSfnBNVDtzQla17Lwy9qTpVq+D7GYUtPu4d22WzIPQb2u8O52XI7lPRc5zLH+BV0VQMudQKkSRo3rB1sldqMT9ckZoA2Nidlv3F1vsEKcoohdP4XBb19cyCHM0MeOzWbFtHzOz99PeA5+vcZ8ku47Qf2sOy6YpZzdLKs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nyECjAGZ; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3b916fda762so1369866f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 03:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755254678; x=1755859478; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9VXN7dyuqMDF593piqzOKDuFJ2+OEcBzrRSpDmpGS7k=;
        b=nyECjAGZCoVzy/0AtH4YgMEvaxuJO8Zc4U/+dRSM6fRvVrTO5mByLq3BECjG1/3jmD
         P8I/OtI5JjlQlvjz/gk6OzXP1wavt74YzBA+/gVlUrl+QnenkZpyWOB2Hj+yGckb0IJV
         MV8HpfbN3gRpIRUU4SnSxinVNq3kdnyJTrYOjlOZXHjPa5x/IL26oRKnAv7hRi6OSbg4
         DHRHftdfVRZIeg69irsGzY7x2E0LqS1aUQzVEa28o8WF34XgtdGSKp7SOs1QQ+EIyz42
         rzACdYyhOfM+G8XjvWd7eU/Vpl95SDoG9QnMhGPW/irzSg6vnYj/rpa4cucCPnePxwGi
         09uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755254678; x=1755859478;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9VXN7dyuqMDF593piqzOKDuFJ2+OEcBzrRSpDmpGS7k=;
        b=Jxxf+jOAt7lRiPndYhWS0Bmgw1ue8QNHduqyZUr548kwwtthUdVBshFxRH3HQy0Ww2
         3ZhJBnzwVjIT9iD+QBXLO/0dVg83gBgsbE9cfnt2CDuQrWpMiUkFj1lFckoL2UrK67pL
         FWf583UY4bFKedul/Me++Oe5/zyN4hwuL/2rE5y+UCGu/SZ418Z1SeSEaoYqkFbgndQ2
         aI9tI7Q/nca3dPC7ceXUHe09MZee/uVOUIOne6aEG468BSSnMRu2KekBks3t3+NzYVza
         y+WA/1fLb7KA1hbZePzgoeS58TYQSxOK79suT/PFsANAeGEK4xsCXJGC1XF5XmRFzJHP
         hWxQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8n87IWPeiI7hVG7rnnQRgKGWcW16A7rcykZtfXUbT9Ak08zSxF2CkmPHA4pyTzAyrS5d9FlrJ8LBNN7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaxAoIaa3hYoR6djHVLsJ4rsKBxLOncLzHnzA1/gpYsrT+ymRy
	jRDvuYHHGPo5vDKOiQojLyIrOylIeuBDIKQD+FFOxH8mvshsAW68Ufd+qTKht7daOo0=
X-Gm-Gg: ASbGncvfYy6qrouI5gAeDJj3AYVcf2RxTykrl7/0iBAwVtrI0/BnZ0IWD0BJbk1z/Ot
	Dj9TMAlPxyJkVA+RZA2QcmxX0c/e2LB1x4UCOdnkHNRsYr7djjXkmlk+B8L14YSeKXPJpU8mS+3
	eluYf/RbiXK9o+ex/E+9PMtOPJyfqznvc0F3zi3fBB3yfQ6GrmfldguCTFw6nMVBrgSSGnA95YA
	IS9H8UKrBUku9hBQvBqVl4zHXMYrgUx27ndg/tquZrFFf1yZ7dqA+Nz70rirkRWaGI/4x2UONrI
	g1zGkJC0adrfdpjdWAXPCroAvBaQdWn8golmxrKikPncxBLsbWrHxelr6e9COIL0ZXu7vxPtt3+
	RM/kIcbpF+E3wxnmEkNrF7dOy6gONfW/GUMZKA7/9Wn6ap+B9vffDnp1NfeGczV8=
X-Google-Smtp-Source: AGHT+IG800cLWLqatWasBLVAd1JmHq64uktJOwC1nVkGq12rIf4uwmr3k1nR0sv0K30TYAXp61UV2Q==
X-Received: by 2002:a5d:5f8e:0:b0:3ba:cfe3:ad98 with SMTP id ffacd0b85a97d-3bb4a1f88ccmr1707195f8f.4.1755254678411;
        Fri, 15 Aug 2025 03:44:38 -0700 (PDT)
Received: from [192.168.0.35] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb676c9b27sm1443907f8f.44.2025.08.15.03.44.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Aug 2025 03:44:37 -0700 (PDT)
Message-ID: <75df9709-5778-4a71-bb55-1151c6c657dd@linaro.org>
Date: Fri, 15 Aug 2025 11:44:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: i2c: qcom-cci: Document sa8775p
 compatible
To: Wenmeng Liu <quic_wenmliu@quicinc.com>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>, Robert Foss
 <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, vladimir.zapolskiy@linaro.org,
 todor.too@gmail.com
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org
References: <20250815-rb8_camera-v2-0-6806242913ed@quicinc.com>
 <20250815-rb8_camera-v2-1-6806242913ed@quicinc.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20250815-rb8_camera-v2-1-6806242913ed@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/08/2025 08:07, Wenmeng Liu wrote:
> Add the sa8775p CCI device string compatible.
> 
> Signed-off-by: Wenmeng Liu <quic_wenmliu@quicinc.com>
> ---
>   Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml b/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
> index 73144473b9b24e574bfc6bd7d8908f2f3895e087..54441a638da2b7feb44741264810d7a0de319858 100644
> --- a/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
> +++ b/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
> @@ -25,6 +25,7 @@ properties:
>   
>         - items:
>             - enum:
> +              - qcom,sa8775p-cci
>                 - qcom,sc7280-cci
>                 - qcom,sc8280xp-cci
>                 - qcom,sdm670-cci
> @@ -223,6 +224,7 @@ allOf:
>           compatible:
>             contains:
>               enum:
> +              - qcom,sa8775p-cci
>                 - qcom,sm8550-cci
>                 - qcom,sm8650-cci
>                 - qcom,x1e80100-cci
> 
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

