Return-Path: <linux-kernel+bounces-826394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72221B8E652
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 23:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BCC316D87E
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 21:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6EB826E161;
	Sun, 21 Sep 2025 21:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LqYHalk2"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5DB258ED5
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 21:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758490382; cv=none; b=kZVQPik2AxOV7FAdG+vm1ZrWkpyr72WSjQ/ud3OufqR9CzPfn9kbK9xUiMpvBQrE3aX++upjanawX1h52RuCd5VU8EvaWyAxVEIUvFCosk5a+/hcSs7Oey3ttN6qDJeplIdipjz2SkLphT4e3DnLRELoTEZYgBd3SY4bdOmmuyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758490382; c=relaxed/simple;
	bh=6ypWfiZHJzX/xDZsK0T64csG57qQjcut8czBqxy2qWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pSNpW/buKp1LaM7+9X84bqQPxYTs2PhK1DFEZtmNZH7hHAoQKTRDFycp01COYvShGZVc0QuAZKStKsFSZmNkHlX12cDD8+oC0DWIgw+KjFzRoSBJp9tGb8k0eIve0HQyHerb88T2+rXv04bknz+d3Eeihp9OCkG7CzmrCaFj2Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LqYHalk2; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46db5bb2e9dso43895e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 14:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758490379; x=1759095179; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WcyVlJ5ccBg3OsxdDlx685Nr8K8wL5Pp0q8kjSCRzk0=;
        b=LqYHalk24oU89xEtZI3ebBI005MzS7y8hjblvW2vNhZpD0St2kkku6uWb8Lef/Rrxd
         162YzkAvuOaS8bJCmQOoyNzCKNeBtUTFqxX1jfunLb6unKIETUEcqiPyOqn+FBiqmv87
         V/9uV/btiIFUr67/ZSm8oAkSYLRoTUDjyx9kRT6t7g1B5qRIdo5klFTqW+A9FGUa4Rof
         X5H3ZxwinwQwZ7VyJ+C43LkBGAMs6H/ntkr4PEVn92l4KWrzaLpCk0ZNVzWKH80H3uJs
         T3tFCvkRh9C9RmVhcavG8W7/FWNSDIGpIIouDEUudul8H0N6hTvt4W2zDfl+ak3DJDWR
         0G0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758490379; x=1759095179;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WcyVlJ5ccBg3OsxdDlx685Nr8K8wL5Pp0q8kjSCRzk0=;
        b=t+BYPmpYmVDwas3yfEWKA6hE1+aZe251eIpGj4QBHYUUqxRbQfq8GhxC+2lz7w8Z2V
         CaEtdE0xxvC13lxx2Tz6cRnbFcTHUoJPU4RlJ9+T6Byc4NgVHbIxfQtdlwo7WhneFsdx
         p9LUJoD6VqMM1FnsotGsmlkS6omsQS3s3JEhLQ5a2RbROOGs7F7MG3eWAvSCMTLNag9A
         qMvdqWVCA2mqU3eL3QtsGImT99nGf67NdU7rhE2BPFNf+LwxNdnTK7XeQ7wqfYUbrYgF
         49zYLdUF9fPekemCHPHvLbld2sQrYuUnfRJqguZ8MMfCUboTqAF1Q/OOAthJonvzBmJw
         godg==
X-Forwarded-Encrypted: i=1; AJvYcCVXpwGJr6RdyuytlrIyvSLGYg9TUP9xOtmWqADmGdvV+BxkJDps5Bo2o9nhDdgAfBqG3d/ha3AB0v9IDZA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3nM5Y+Olfxkg/AYXsQ6IQ+PSYe4sAr805wPGPava5q6K7vAiK
	nEl960H3hAiTeo7xMD9e2k6K+oDY+I4gaMJSMZKgPsCziN+OeYNO8Z/Ruf42RYCJdYM=
X-Gm-Gg: ASbGncuQyhJBNNjmohm50J7klozST+Rs3eF83LpzFVPgf5rEvZ9AD9qauZQ58YUn9hZ
	+6FSi+ndgXJOSiAG0hicniHDayr6fsGeclSOeOzczmIvZoSm3z4X5qXRRKnsafPjYyHadpGY7JH
	RA9EGw56kczRyyFN8iFRv8JAvKJiK7YOEofDTQ0hf+5FPSWvkzSC0geV9pkafvTvwYvcQrBN3/h
	o+UNYnicBP7EQ0p+Ay8Aey5NSBQSapJAMIqDFtWhyJm1aPgtcqRY68y5kwXz4h8Aq2XML/UNwAX
	bihQ9x3GzZGPCu4o3El6wYoCCu1nUFUTDFkttR96SqyV/Ergk5DMoU3PMiPGUw/cp2xRF6EG3Ye
	oWI0dSk8NDAbcnAW2Io8kuCAwhcYx1cc5YT8H2lVK9ZqEmJPQBBXzX2qveD9VIH032vSDwCe6uA
	bh94V2KJNfwyIrBFUb8th+yxyeaK/Z0g==
X-Google-Smtp-Source: AGHT+IGrFtUS6kuiPjXUW8VEeVl4lEajrMTBX6lS1ArstWn69VRG3TQJ1C8xitL4/hpLzTt7MqEPSA==
X-Received: by 2002:a05:600c:4754:b0:458:b8b0:6338 with SMTP id 5b1f17b1804b1-467a7f111b4mr119477045e9.6.1758490378901;
        Sun, 21 Sep 2025 14:32:58 -0700 (PDT)
Received: from [192.168.0.19] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f4f9f4e4sm196526075e9.13.2025.09.21.14.32.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Sep 2025 14:32:58 -0700 (PDT)
Message-ID: <f3b384cf-bb2d-4476-b97c-1f63dc64671e@linaro.org>
Date: Sun, 21 Sep 2025 22:32:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/12] dt-bindings: remoteproc: qcom,pas: Add iommus
 property
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250921-kvm_rproc_pas-v3-0-458f09647920@oss.qualcomm.com>
 <CJt90J07fyMMpE4e0cdA57Hr2SAcSOfVD1Y2NWFfICOWw7rfnwzPtCeZnR9dGbu_uYVGKezX9spjUO89uFFMPg==@protonmail.internalid>
 <20250921-kvm_rproc_pas-v3-1-458f09647920@oss.qualcomm.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20250921-kvm_rproc_pas-v3-1-458f09647920@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/09/2025 20:40, Mukesh Ojha wrote:
> Most Qualcomm platforms feature Gunyah hypervisor which handles IOMMU
> configuration for remote processor and when it is not present, the
> operating system must perform these configurations instead and for that
> firmware stream should be presented to the operating system. Hence, add
> iommus property as optional property for PAS supported devices.
> 
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> ---
>   Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
> index 63a82e7a8bf8..8bd7d718be57 100644
> --- a/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
> @@ -44,6 +44,9 @@ properties:
>         - const: stop-ack
>         - const: shutdown-ack
> 
> +  iommus:
> +    minItems: 1
> +
>     power-domains:
>       minItems: 1
>       maxItems: 3
> 
> --
> 2.50.1
> 
> 
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

