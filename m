Return-Path: <linux-kernel+bounces-805595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D1BB48AB4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 12:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55CAC1891591
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 10:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4942B2E9757;
	Mon,  8 Sep 2025 10:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TVzGj2vO"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224CA226D04
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 10:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757329028; cv=none; b=CKzL/nyHTo3slCZaCXXEJBe1spS3ei+WtTe49/eV+pbOhd3Yy1NtuN74jlPgPZ13qS2FImARPKC9dSfFRnzPmyCauT0wVZSjdzDV3iAOL/fuM4gYFQETIbEsJr5eBcKBpY17Xckq52I68SqdcA+ko22BFnGxfVIoo+QAddLJ+x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757329028; c=relaxed/simple;
	bh=H4GKqV9vKQYnuJ8t0TV9btzVLh6ocsYYvcT3DTkijw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=etFPv1Q9ZSDUyyBPzTCbn0stq7dyBQq5sEc5/Z/q/gDS55G3sUETIbH44O+01tACHcrekjq1dFiUMWpjcDlJrWdWZgRnq9/9C0w9sEOuu8SFtlEkMN3GDbEf1GBCCcIo9ci2dSt73FJYZpJnW0P3dap1d3bH1/nVxXpK/sfcET4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TVzGj2vO; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3dcce361897so2762933f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 03:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757329024; x=1757933824; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lXcNKb7eAeUSAOD3P9kbauHvQhJ/T5mYxvtqvBukuQM=;
        b=TVzGj2vOOi0iJTRHBf+JjlEVlcLFofPEc0ysXPC92iHoIMR3ld7KIeIkcnxAY1lSI5
         EUle7uLJIyN1lJ+Bor89QzHObAQ3/zf1ibdu4FrEqn5ZeSZx4KCcQO31SdIc26BpxZVD
         2/mludSs1DYd4YtOfamP3vkfZRyoS1D/gGaD8tiprRyKvXzbtKK7TlPMcFOsmUn7hfB0
         QAK8eqhADN19p1opLcJMzpuUOwRkaaIiJb+dXK6SlN6MMDiB53Kfz3Ck53fjRaeOfr6X
         5KwR80sHC1NtRDiuuMHkiLbY+AQnvBEXAEnuwdoHUcVqGmLP8DXWerS5h2R/DOe1HC/5
         mmkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757329024; x=1757933824;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lXcNKb7eAeUSAOD3P9kbauHvQhJ/T5mYxvtqvBukuQM=;
        b=KQpy2NEzyHcFz2wV3kCx3N9nNTThw6g2sZKxAorCQKOtOjjK2Ft8Q8oI0pAoOxAocM
         N3GLO0bKjAdnOKQCfC8y7AHQkR91jSBkG9qDcvVOuCaOBEgu8ozElznYo9HzN7KZpVo6
         eW5telB39HbPZ6CWAdqDtPu1zXJ5r3merWlCWC8iA3HIlvWlSdmTeYSOztV35ADwRtny
         jlf/XISwhOrpMsfOenneNtpWkOPqAU5qBM3Ca4x5SYIpoaOyVTig5mPZSWpD6Khf2GJI
         S2CBirH42AoopVpGb7ytQndCiF8X4PGvnVhdl5QbMdo1pyLP8LWXtC5H8U49lEkVnJRe
         09hw==
X-Forwarded-Encrypted: i=1; AJvYcCW6CL9pTvS+WFkLUjEDPi/Qs/qy1ssitA41h025Ib8k87F6YFTWguqL63ddHWIC02hmuEEeAf3muZ53PC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOyLQ/CUYKiqX3PNhPsFcZT1CUYT9JznJ7mX4ijGtvC0Jr7LPo
	HpsIrCzhlN9JjBO3FjHaql3gVaxhBmbWyG5FXfrpdJEbWxHam2hVrxNBi8zZNT7edOE=
X-Gm-Gg: ASbGnctErLPXS6cj7OTsBFB+bF+s3JupDBfAs83pwx8d3qh1KsE8tTtkqrYsplejQvU
	AQrr+bRORfeP6iJt5gX3SlIXF1VsGgJlPDYxjXyH3GWw5PpU8c9Ee32ExPpzEiRloNHIop/9C6R
	2kmG9t7V71bZ7XpK7ez/kaAR4FXBUGPaVRriow0I4F8s35SoYSTwAxPxnpezVEt7kMGjJj85F17
	bDD56ZLKTqUeUJ0mQFCS7AiOa4g47pWVAHfL7wBEIB3I2gwQ1MVagxukP0pCd/vO4MMWFs3buob
	tTvEbkLqZudKSL5WvmrM1jpQa4Or3jBnb5Yg8sP4fhJXlunyVQqGR1+48qU/DjYaohqNH0h6qMR
	Ib5OrOZJSD6VKKRSXDDZ8N4O8EtKiowFVlfDIRhdkRvoxS56lRImHmq9A7/RRTP6zh2KABa9kFP
	j5KXFQgRvcd7x+4bvfVT0=
X-Google-Smtp-Source: AGHT+IHJenZkBnBqX5JJGGi8QCqzH35vWp8fn9f5als83N3CMmj4jtZhM8xY4+BhMYtweIKXzuwxjA==
X-Received: by 2002:a05:6000:24c9:b0:3e2:4a3e:d3ee with SMTP id ffacd0b85a97d-3e64ca75db9mr5387379f8f.58.1757329024396;
        Mon, 08 Sep 2025 03:57:04 -0700 (PDT)
Received: from [192.168.0.19] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e8879cesm440740795e9.12.2025.09.08.03.57.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 03:57:03 -0700 (PDT)
Message-ID: <bfc3838c-b2fe-40c9-a1bf-f5269b48dca9@linaro.org>
Date: Mon, 8 Sep 2025 11:56:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Add CAMSS support for MSM8939
To: git@apitzsch.eu, Robert Foss <rfoss@kernel.org>,
 Todor Tomov <todor.too@gmail.com>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Vincent Knecht <vincent.knecht@mailoo.org>
References: <20250908-camss-8x39-vbif-v1-0-f198c9fd0d4d@apitzsch.eu>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20250908-camss-8x39-vbif-v1-0-f198c9fd0d4d@apitzsch.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 07/09/2025 23:04, André Apitzsch via B4 Relay wrote:
> (This series resumes [1].)
> 
> This series adds CAMSS support for MSM8939.  It's mostly identical to
> MSM8916, except for some clocks and an additional CSI.
> 
> To fix black stripes across sensor output, and garbage in CSID TPG
> output, 2 VFE VBIF register settings are needed.  So the 2nd patch adds
> helper functions to do just that.
> 
> Patch 1: documents qcom,msm8939-camss DT bindings
> Patch 2: adds helper for VFE VBIF settings
> Patch 3: adds CAMSS_8x39 version in CAMSS driver
> Patch 4: adds camss and cci in msm8939.dtsi
> 
> Changes compared to [1]:
> - Move bindings patch to the beginning
> - Make the order of {reg, clock, interrupt} items the same as in 8916 +
>    append additional items
> - Drop R-b tags from bindings and dts patches as order of items was
>    changed
> 
> [1] https://lore.kernel.org/all/20250613-camss-8x39-vbif-v5-0-a002301a7730@mailoo.org/
> 
> Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
> [André: Apply reviewer comments]
> Signed-off-by: André Apitzsch <git@apitzsch.eu>
> ---
> Vincent Knecht (4):
>        media: dt-bindings: Add qcom,msm8939-camss
>        media: qcom: camss: vfe: Add VBIF setting support
>        media: qcom: camss: Add support for MSM8939
>        arm64: dts: qcom: msm8939: Add camss and cci
> 
>   .../bindings/media/qcom,msm8939-camss.yaml         | 254 +++++++++++++++++++++
>   arch/arm64/boot/dts/qcom/msm8939-pm8916.dtsi       |   4 +
>   arch/arm64/boot/dts/qcom/msm8939.dtsi              | 146 ++++++++++++
>   drivers/media/platform/qcom/camss/Makefile         |   1 +
>   drivers/media/platform/qcom/camss/camss-csiphy.c   |   1 +
>   drivers/media/platform/qcom/camss/camss-ispif.c    |   8 +-
>   drivers/media/platform/qcom/camss/camss-vfe-4-1.c  |  12 +
>   drivers/media/platform/qcom/camss/camss-vfe-vbif.c |  31 +++
>   drivers/media/platform/qcom/camss/camss-vfe-vbif.h |  19 ++
>   drivers/media/platform/qcom/camss/camss-vfe.c      |  10 +
>   drivers/media/platform/qcom/camss/camss-vfe.h      |   3 +
>   drivers/media/platform/qcom/camss/camss.c          | 157 +++++++++++++
>   drivers/media/platform/qcom/camss/camss.h          |   1 +
>   13 files changed, 645 insertions(+), 2 deletions(-)
> ---
> base-commit: be5d4872e528796df9d7425f2bd9b3893eb3a42c
> change-id: 20250517-camss-8x39-vbif-975ff5819198
> 
> Best regards,

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>


