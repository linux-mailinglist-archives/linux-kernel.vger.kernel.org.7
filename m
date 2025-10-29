Return-Path: <linux-kernel+bounces-876443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D5FC1B72F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E520F349FC3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A7933A037;
	Wed, 29 Oct 2025 14:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/WSyaxN"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E51C34F49B
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761749391; cv=none; b=APEHBaByw3ZTeYZMglbkacmEIh9/UO3Btlpogqfd4EzQ6VsrOntfHuwmk+XZ0StbANqXTxEsHSKWenA1yOAWVvoNLJyHDjzNj4fp63Y+xTm9rLJ/rlWqc36v0Ep6RToKLxEeCMiSBrbEx6bldPjzTcGMG5MJoBfrk/b+715h0IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761749391; c=relaxed/simple;
	bh=blmtGdraqZmNef4bdInUD56F+UCEYFIYeD4u5JV9gL4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qhEizoqTJjyYK/Sh5gjCYQVsoiugteW9aj3pZhBnq6KglnNSPSDwwozMWpfp2L0hM1xVB56s4vK7Pm0XqMMB5rLmLW3P3NOfdrq0Ur9dSbB0qdBc1UIQQaUy8rxlQCBk3zKR3SDrgLg+Lbt/ETCtfvo66NFbc76r7tec/6t1Noc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O/WSyaxN; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b6d78062424so73010666b.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761749388; x=1762354188; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1+/I2yfPoWDJTBN37DUOvTovSE+HP8yoku6LrNjmVH0=;
        b=O/WSyaxN1jPnwe9CaAkPCH1WWpqOse8xO9WAtBYvP80tlz5zRR7J5yKzTDCyjU6jko
         6BveBnqu327q+x9FO1ANtrB0RuFhenMYvTfShdZEc/Sb0Ug8HRdmtENVpWHMNd8EJJu5
         cDtQkSlYz3kbwXaeKmuMHGhqerTgVnvB9nyd7yP0aq1ExxnXOszYJmYTa45amAl6i4m4
         bdKSFBzN71LnZiHUf8SFHX/wLqYlVwt3VLVBOhmzl9ZPoQMKy7bfeQoG7a/+5mpZpvIY
         D9xmdoPqKJ/6+a+ivnXhQnem1bWiHdnq0YLm76KaDYxfvTslba5NXFvB6ejFkZiLtU1u
         b0kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761749388; x=1762354188;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1+/I2yfPoWDJTBN37DUOvTovSE+HP8yoku6LrNjmVH0=;
        b=sQrijMQ0STTXWRgR6ZpIRiyO7TCXKnFKY2DwchJalNVD6LgilM7MgJABBMBZkHHVci
         Ai+zk3wDoz4cZGCsJfYUkDJ1ObbrOvd+mloHeZpHoYF64/XyqvHKwlK74uSyneTnNks+
         zvhbhOWEtLtp2T0KrQh524n2svg3amgfFenEmkwHS2tLH9R3kaq7INhFS0YydpD/Hlaa
         qnoX8De4KawapDdGrKNfErx0o+Wi5qlac/4if+UdjqoLRYm67gxH8BIt5Mo7Q14hS6m7
         GIrCySQeAZoYDQ2kGMNPzDP88ECOGFRNYh9ycVaVRl1q6EVtWh2gFn5ye5lsY5YfjyT4
         w5jg==
X-Forwarded-Encrypted: i=1; AJvYcCU7sp5xWio5NsRB54NzNTMBTCtAhDKYsDLfiEO/GNscK9GI3u/iOT5YBoyJXdKmAuaBTwEmIXDYEJXVGpM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSwa/I8+hznq5TDfinOM7luJe+LupGrGTw9L3QY6xZRkeQE9kY
	Z29a0bmSKwsiqibhJtHLMQYAQHkoAAbHtkYKkJKYAI1Ac3CzbkzxN/n5
X-Gm-Gg: ASbGncvaOF4yNHy/mQiSr8v0YesMT6KS/s5sdFt5EsYRFcHnYZOlpLeyT4lPGCTBHFa
	uT3y8JUYb2L0yEyAy/NROL3Sds3FulcWFqosLbKEW5zk0Y/NUcurA6N9zJuiehb4kpm1mildfCF
	J7H0mfbt3JW8ANiS7fsO/x99+jcOno3jSB0/YByNfb0RMaULq/ECT0d+pxPB6FTC3qcf810hSXF
	NxYioapEv9cbACDcIAvOO+ECPz008w1Yky4sSwWV07Xpv+u7OxS/LYH2Y2KhQHVmvsHx8JSkXE7
	IuVE5vLgHmT16SJDhZmrLXQSVs7eIbkHPRaxRfKL8bqX+ch97qIvYlVqzAJCDPsO3CIm6vZdEea
	P/oyv2Asojb3KM3bYkkDXxMCc9YtFrhMbS8zHYtCBzMIF0Sc9mhTXDJdT2KEjxbQtU/9kYbDk1+
	+8cvOmhjiEkAwsBSWaf2mN4R9pOoqUW3Gw
X-Google-Smtp-Source: AGHT+IH7Dg5hdlveNGeW6IpzIDCcpEZ/tZk4UbIRTBBgmJ7JsmueX6/YbGVE72Hk++yrO2YhhzUdTg==
X-Received: by 2002:a17:907:7f0f:b0:b6d:95b3:7f11 with SMTP id a640c23a62f3a-b703d555a7amr325167466b.58.1761749387588;
        Wed, 29 Oct 2025 07:49:47 -0700 (PDT)
Received: from [10.25.210.164] ([128.77.115.157])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d854395absm1463176966b.62.2025.10.29.07.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 07:49:47 -0700 (PDT)
Message-ID: <b939e7f7-6be6-4f07-97f2-a3146682fbe7@gmail.com>
Date: Wed, 29 Oct 2025 07:49:44 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arm64: dts: imx8mp: add aipstz-related definitions
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250821105634.1893-1-laurentiumihalcea111@gmail.com>
 <20250821105634.1893-4-laurentiumihalcea111@gmail.com>
 <cc465cae-a1b2-4116-82fa-ae42ad0706d3@kernel.org>
Content-Language: en-US
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
In-Reply-To: <cc465cae-a1b2-4116-82fa-ae42ad0706d3@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 8/24/2025 4:29 AM, Krzysztof Kozlowski wrote:
> On 21/08/2025 12:56, Laurentiu Mihalcea wrote:
>> +#endif /* __IMX8MP_AIPSTZ_H */
>> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
>> index b62bb821cf61..afcd8c785cfd 100644
>> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
>> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
>> @@ -13,6 +13,7 @@
>>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>>  #include <dt-bindings/thermal/thermal.h>
>>  
>> +#include "imx8mp-aipstz.h"
> Completely unused define. Your patchset is not organized in logical chunks.


ACK, will squash this into patch 4.


>
>>  #include "imx8mp-pinfunc.h"
>>  
>>  / {
>
> Best regards,
> Krzysztof

