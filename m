Return-Path: <linux-kernel+bounces-841230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 778DCBB690E
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 13:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C83534E5B42
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 11:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5279E27F19F;
	Fri,  3 Oct 2025 11:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D5MpwQ9Y"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FAB26B2D5
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 11:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759492431; cv=none; b=p/dbEkQgeuQ1QJkvDXW2egZAVF1nUHX1IOBdf0Yrr/NhZEmJwpS5XRfAQqrAXZvUXWnI/IvKywVKkf9HMWvZfqnTpMccMAFKAbJypglVtYFkDgc/omIbYmETnsamehtsk9jePT/yUmXiOxp4TzjdH1Mssv1DSSJk5zXTjZ8dI38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759492431; c=relaxed/simple;
	bh=xxNiT++Ko9RTw9HOwLGTPFz5Lc+N7FUYBe8+a9G5faw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eB1/yrggnwNN1NCd9eVGGYpZOf76B2KTbNK6viJfgjjVnSv4OCZ3spyH3iK4c/9x6wKnoMv6ve6D25eHoCe3srErHt4PHeyzqpzVmLp92DwyvsXEHbDSrPA5R0xTwZFJsNt1S6M9BtBQGZnMgEbKl8o4vLDLQcefUtFUCYMqeYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D5MpwQ9Y; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-631df7b2dffso4979665a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 04:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759492427; x=1760097227; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v348Sd1HyGnZQBz/neaZqbiR/lhhLUWkTvsJPcWV5Ok=;
        b=D5MpwQ9Yvwa0gPLhdrjtHBdug+tLd/dV37tlrTHl+hGtuDz2EflORc9mp1b5dGlILC
         uhf2f8ar3J8tLLD6T8GaqR1AyBDShoWlsIQPo8FcTeN8n7i2lTfM6EQ2sNFmbuvQIQT+
         KQkHG4oH071+/BakPXEaRB6GyehwBVGMu9Qp94sZlBV4zbqPrpn8v1DEJmbcxu1DqWrk
         sS+YiwWT2IEUfEE4D2LXosZxGiqRhM7zd0Xl/3vExzYfkj/ARb4pd7JLkphMBxFi2uAi
         5gj8hG1D/5t7zS8We8nIXnPNcC7SJRKultY1+olmWeSIZcCsA+16N5kqLehqxZ6macR7
         GO1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759492427; x=1760097227;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v348Sd1HyGnZQBz/neaZqbiR/lhhLUWkTvsJPcWV5Ok=;
        b=VWAsed+qimc/onlCtkiqwLFTL2bpluNQOVtWKSnrcRZrLk6cLIQ2vZnqt0KkNPCnkV
         OxCcWbMtSa1vrQjUb0b4h2KT+baaHayP7B0q8BL0x/v7tIi9Uaom9Mjw0uytQAvHlOLh
         adB05C0ub6f/CxiO3y/psL9usvIQByJ5gfDRZvMdHWruLJuIpG+zCh1z2U7ZBeaFX8r5
         67AsNDMxogGphbaqhHhHqSb6ysrmuYyPSo6w5GCtrq1Ut4+Jdbexp60eemhPk2ZExO2e
         MU9BUsxOldnqIiQVayxnpnLn81f6P0QoH+nKhHmCxwbh7rA44FYJcS4HScYLOsx8c6yn
         OvcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfIbGoa1Ra7BgzbHWF+XBKNiq8GSBakGBQ1+Ku2fRzRFsQGk0cHIIiU5WlMy9cctnXJ4Q/NthGdOPm7H4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrYwwQyEcN9wZww7rUuNcScP9IPhGNaWk3YowqcjPfE/UdaqNs
	aXWi5zDKudCpB55MmdtfRHGenoJraHoI0HDQC8w6zsUt8Tpjay4+j2W2cs49Lm+R4Lw=
X-Gm-Gg: ASbGncsk2ydfOZNsle8r1npge02Zj0cIkF0uXSziJdn3aVsmaDDRkMBvU72XeU8ncuu
	CQ5/NjNIHq7FynK7Vi1hwlRteVPuSXjvEsov0Nca3ee/mHhW8207RD4GhtjKw3fYWIRmnwdZCLm
	Fsbz3wm60uRHT7VlBWlooRFTURK4EB1VO/6c6wXhPL8epTU1OM53RdjUwnpLyLtRTZwZU6/h5oK
	DeLIHscmGxQGQzygQ4lqBWISuvQBdr7aVK0Wof3nypAys26PR0bl6Pv72OeAT/W/hdtEEAcfeHy
	rM8IuPzwmz8ZrgbamEX1gTzm/cKUZumRYYcuLKbdUSigu9eFZlD9p/R/MM+RaYzOLfoEMujz1Mi
	LFLYrPjFXffmqx3PeTkphl6qqP39hQnSmCKxPplrCTloYrTIxgo42H4eq7J5PMhVg6UPp
X-Google-Smtp-Source: AGHT+IHYR3iC2LH79LtowBLJrojMWjOE+pppainz+qSkeukLPpqSESK6b5VQ8mGniwQIYMRLlwAVvA==
X-Received: by 2002:a17:907:6eab:b0:afe:159:14b1 with SMTP id a640c23a62f3a-b49c1971e56mr369945366b.9.1759492427304;
        Fri, 03 Oct 2025 04:53:47 -0700 (PDT)
Received: from [192.168.0.25] ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4865e7c47fsm430327666b.37.2025.10.03.04.53.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Oct 2025 04:53:46 -0700 (PDT)
Message-ID: <8e687353-f505-4122-bd46-57ba0d84dabf@linaro.org>
Date: Fri, 3 Oct 2025 14:53:40 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] dt-bindings: firmware: qcom,scm: document SCM on
 Kaanapali SOC
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Robert Marko <robimarko@gmail.com>,
 Das Srinagesh <quic_gurus@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, aiqun.yu@oss.qualcomm.com,
 tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
 yijie.yang@oss.qualcomm.com
References: <20250924-knp-soc-binding-v1-0-93a072e174f9@oss.qualcomm.com>
 <20250924-knp-soc-binding-v1-3-93a072e174f9@oss.qualcomm.com>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <20250924-knp-soc-binding-v1-3-93a072e174f9@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/25/25 02:31, Jingyi Wang wrote:
> Document scm compatible for the Qualcomm Kaanapali SoC. It is an interface
> to communicate to the secure firmware.

Same nitpicks on subject name and extra sentence

Reviewed-by: Eugen Hristev <eugen.hristev@linaro.org>
> 
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> index ef97faac7e47..340b754e6322 100644
> --- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> +++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> @@ -31,6 +31,7 @@ properties:
>            - qcom,scm-ipq806x
>            - qcom,scm-ipq8074
>            - qcom,scm-ipq9574
> +          - qcom,scm-kaanapali
>            - qcom,scm-mdm9607
>            - qcom,scm-milos
>            - qcom,scm-msm8226
> @@ -202,6 +203,7 @@ allOf:
>            compatible:
>              contains:
>                enum:
> +                - qcom,scm-kaanapali
>                  - qcom,scm-milos
>                  - qcom,scm-sm8450
>                  - qcom,scm-sm8550
> 


