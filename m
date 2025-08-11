Return-Path: <linux-kernel+bounces-762875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D13EB20BB1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 16:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C168E1882B8A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47558202969;
	Mon, 11 Aug 2025 14:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qXUIcKvW"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FFA21A435
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 14:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754921976; cv=none; b=SHQSmQ8BrORk558L47ENrb3ytYrkDhsSP9LM/ZKwOsYAc+JnrlSOwONNRzWDSmZP16cF/ZY28TaQCL1A3ZyD+qIMs61jRuHDl5PHVfIH2PAPaEKo0YWsNJsYvUUDYk2084UNoevFbWmMDJ7hMmlmxYwtmjGA9SuWx/nOXec7X2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754921976; c=relaxed/simple;
	bh=sJ/+Dba9xvP6fdv277w74ayy19TMUod8r5H1Q2Iw6qo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cJnpd61lIl3LPq2BTNEi8yp5P5HszRZhMWz5J4IVzdqwcSWTjEuhL4XiOuCGlLdhRgDpOSa0zvLMGb9Pw6wvsMRUBC6wBFSZvtiN88ntsGBBNqZry3uCc5FNBC8IkManXIGy3xGqs2Oud6AkG5v786kBEcbg8YHz7dWNzJD4+ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qXUIcKvW; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6155527ab87so779858a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 07:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754921973; x=1755526773; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ukJvVGY67SRCEDRTUAiknYRlpJloxMFuVeYboh/clkg=;
        b=qXUIcKvW/dp+PSbBTWGa0AsRsY4woLSC0SL6ro1gHw3KqQhzb8OeJjBhapN5j6WQxg
         bIwWPHl2mi+/8QIIgN0leGo3E4DRLsp/PVvGYYf7tw0I8l0I53m2qUu/7QVVyBW1D2ks
         iVBTEuz5UndW0pifg4x+2SwHQOYepJ534kKJmfENqHwSyRqcikE6VNYI7uEhRWAu1sNc
         pmjrlyeqjMYu28DYxCv6lTI+zU9zpnB9KyAcJea105a83uxvReDsj2t3/CfguGQKbzxG
         oP0Ws7CI6TdU6BsUR+YQEFWoyk9fAjpAk+QIdAJRdrdrbB9IqajU7oS8c4TwZ47fas+8
         jp7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754921973; x=1755526773;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ukJvVGY67SRCEDRTUAiknYRlpJloxMFuVeYboh/clkg=;
        b=HR9PvgXaJnMgyfTFno5+HZHWYLk3Nq/yVkccQbkFYfhD+wCTfXI3AaeGwOQxtCY8GN
         vyDB1PfQq7CArls9gaIPPN09f/Ne1kQF0b97PvkznT0QOp5ZcR+/uKiBD1VvHr/4VqAW
         tauW0Tb36YOUYGv+IWuIMa4aPP6+eCUABeAOPaHDR6wDltuV//CXNednq8rnWpYKvbQX
         NYA17GBu2OdbtUTkvkjvKujsJ6IpX+WjJ6Tn5BfMdAZI1/MqC4zStoSFJQ/ZoUbQFTg5
         KtjABilOFnxwJJULleC8cc1w0sLA5ZB6WgVy6OX5BLROiOner1wtsItcPUwVqz2eJTy7
         sv8Q==
X-Forwarded-Encrypted: i=1; AJvYcCU6NVTSkv/z/raxHT+5cidSxIByGZlFLnopyDfDKQStgah2s4O0fYz++kwRLiEtfFxOvhvcEHceQ79egwE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3EcRWYKNkWboDJct1K/uKHPBEbGzEfUgig/L9yZ6o8Nwc6MKG
	OezVPbR464eDAV/RCF81yYeZ2qvBhoaTm55AF8J98j07Q97IYgM00WrXUsetz6raJ9Q=
X-Gm-Gg: ASbGnctCCZIV/67DcoMmZxc/29w5M8exhm3Wn8jYF/WKzzCaYjF6ozj82GDPg2DXF3u
	OvKbbCgIgaA89h9i9jqmec3J5brDepKXR7tDmUMkkbFMJNDkhfeziO3EMl6BYQ0wU5+/NCKgVwr
	URPik3yDo1YJkvQEcamjZGMDuxTiJrH1urvHlVfpEJQQpUH0wGjlC/pKpVV+L6i8P4amEV1xmyl
	dSCN/dVW4QS4/GCAOowaR6uWAoPPmqQJBu36Gp2AlQo1O2hmpUt9QlOJ1gVxUkcxGX5DHG6Q3Cm
	Qne1wsfUCIzOLqPCiCu77Nv632Em9PT5HAtAVgoTjjZOAEevk8A8w9Uvp6Im2FtvOuqro51jeVc
	eBXyhLsVckB/fToymNpjr7JsQMvaTgDCmgzXdIjbETFM=
X-Google-Smtp-Source: AGHT+IGISlXXKbNN4WBuSR8PDVvMccroTXbeDu/hTumwuwdfw4oDAbeip4RuSSQ7J2kZBKfEYuZPlg==
X-Received: by 2002:a17:907:3da9:b0:ae3:cd73:efb9 with SMTP id a640c23a62f3a-af9dec80ca5mr366356666b.12.1754921973223;
        Mon, 11 Aug 2025 07:19:33 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0a3e80sm2042966466b.47.2025.08.11.07.19.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 07:19:32 -0700 (PDT)
Message-ID: <6203a510-da79-42bf-9f85-7a2092b5057c@linaro.org>
Date: Mon, 11 Aug 2025 16:19:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 2/2] dt-bindings: phy: fsl,imx8mq-usb: Drop 'db'
 suffix duplicating dtschema
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Vincent Knecht <vincent.knecht@mailoo.org>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Li Jun <jun.li@nxp.com>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
References: <20250811-dt-bindings-db-v1-0-457301523bb5@linaro.org>
 <20250811-dt-bindings-db-v1-2-457301523bb5@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <20250811-dt-bindings-db-v1-2-457301523bb5@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/08/2025 15:54, Krzysztof Kozlowski wrote:
> A common property unit suffix '-db' was added to dtschema, thus
> in-kernel bindings should not reference the type.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> RFC because this depends on dtschema changes and should be accepted
> after new dtschema is released with this merged:
> https://github.com/devicetree-org/dt-schema/pull/166


This note is outdated - you can apply the patch.


Best regards,
Krzysztof

