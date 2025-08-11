Return-Path: <linux-kernel+bounces-762835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1A2B20B75
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 16:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1942B7B10AA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792EE1DE4E0;
	Mon, 11 Aug 2025 14:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AzeKLnSC"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4925922257B;
	Mon, 11 Aug 2025 14:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754921173; cv=none; b=NO5Oy08t3Si2XkVBXgTmhKYI9Jv9/YTAFesUYVcBUnBBZixHu2XXrJGl+ulFJfbyMYJrTewOHMJ/ZRz1IQBhoDn/MpakTV98pT0sw3QHC4EPAa2simG779X9cfRxkFL/uqwzkqIKNbTQUjECOmfPBAaRUnAJ8JVNTFs3Bd2vm7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754921173; c=relaxed/simple;
	bh=Nvh/uOAk/MDfCPBtlZRzdHaHOB6Du08aKJTNs5qDK70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BXjUEmJqhQEDKo74zPXGJN2xp8IJ99JvP29VkgoTNZk2v0STCSnT62p/mpENhxoAqmYB8Hpqa5MFS6D1htyAgJs5IrXrTPraAjIaZ5moQNfkLilbCev1VY8fdxVQY5VnYO7txp7Im0QV1U/GyKRAMRV3rhMVgNxPEsXJI1BCAa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AzeKLnSC; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b4255b4d8f9so2887773a12.0;
        Mon, 11 Aug 2025 07:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754921170; x=1755525970; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=WNGafiRX+HqlDwS0BXmPS/dqouNRqSHQ14CXdgfNMdI=;
        b=AzeKLnSCTGYsmHtWCZtfPJElnGzE1Dc3Du1OoL+r8MTOeoq8M+6hBFqiroJWorTqEW
         0ID/Rcnz1CkDxHeoVq5OD5aZA9BG3dElIt9f7HLUS/j87gCJMmU1LqJk35Xet2PnBubd
         7oOxapt5a23TXfpEEPi9GOu+6HXdVlrUexJa7ENDy/+UdmpI5zizqzeNsNUHNvul47Qm
         wC0Ip6OlQoCtYye7I7AZCirtToPmkhyHik84LeE3hyLZswKe//F5Ij/OYxntHUN1nM1n
         NIl1N2LgOCDycxQGZh7Q0wWgsdDWCNXts8m8j4hqDsQO+gb3dWBURCZCJCKzmrLeBGVH
         8MCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754921170; x=1755525970;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WNGafiRX+HqlDwS0BXmPS/dqouNRqSHQ14CXdgfNMdI=;
        b=DXsjMFHiN46K24h+8lCFUrpTwZhmShuNK2xcqO1RGO23rCky40ir23iYv/FDEu+eZv
         eRrPbeQamR0ZyKrZX5Fu0AVj8ZElCP0gmE1e08Q8Oxx5Mu4DofgK/3HMFEJgAfvn6YmC
         GZAuk2MQGgQnTWs0uOpxbOu++fdCp0/lh4OKCbmiJ53ykP/xEkeVXb40anf3GNPQBCLD
         i5ThIHn+M6gyJxWDhQZhMIppcRzbkDfUi90t6S8coSwXAhBArqkIuEUCsaLQ6834qxsl
         Qc8p4J5JRtlFpltLyK7hiwBgwkoarwT5uKzcILBL9AIo2bj+EXGWYzFR19Xm/2speG22
         HQWA==
X-Forwarded-Encrypted: i=1; AJvYcCUmH3eC5cM2ajnQjKRftFuaFQi0zXBPoGw2pWkt+0Fjc9cwkYACUHdZ6zdTg5DyJZzMIUtLqqwGqzO2@vger.kernel.org, AJvYcCVF8sShDh1iwKxx9pGjmwDY7JlZdyIsVZMc7IvHq1U8/rR5bwoA/EIDvmFFi1oRBY32F7hzv36/ColfqZdV@vger.kernel.org
X-Gm-Message-State: AOJu0YynbXWTEstJqqOyEvY5cff44wgPSdHHOAb5XTdV9OJGTkNtaOn2
	4bTb6IlxSxyu5PlmSXucrpStSYUAmoF3W2gynFf3LSBhWmTHmDo+tzH3
X-Gm-Gg: ASbGncuSdzeWXehYUxj+HzCLy+J1LYmXWtVqgGg8LrXdb6ajnGXXk9SYcYaa1qyQQr5
	CbZlwlnkRZpsjgDUlX/sIhjIU5ubd8CVDFZWlYSdkksVQB4TLZgHblXq4ki93kbQ1ogjGNSN7V1
	oHdMju42neEuaSrCN3cAr8nHqlvTffGUCxyswCYdPERqs1xJ8XZtghNI2tOYlSCIUj+tcAA/YC5
	LeJES25RY34+qAcmYbK5z1be4hcxxyB7pEvbTIZE8C26q2u2RphKFrZLC/lG0T9L/jYKULT0n2o
	OV9iWliCkmNyQ5anf1pEcXfEtc+Nd9b+JfSBAFgLW3Vqbj+BNg67QA3wKvhdtcsHJWn4B8Dlav7
	1bTvJ6HjIBm2P00Grp4m4vof6JWNFKKmwXTSrtsl9eK+gqeY6KpCzFGYoeMsUR+nlV5atelg=
X-Google-Smtp-Source: AGHT+IFH/yMh9FGn6earRny56wOPbrDf0S2gGIy9zzNabyq+nzMuKcuLR2dZqSlB+QuwmwPA1v/QuA==
X-Received: by 2002:a17:902:da83:b0:235:ea0d:ae23 with SMTP id d9443c01a7336-242c1fdc182mr169797985ad.6.1754921170086;
        Mon, 11 Aug 2025 07:06:10 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef6bcfsm277188645ad.5.2025.08.11.07.06.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 07:06:09 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <551408c6-c468-4ffd-86ee-f93d1cba6a73@roeck-us.net>
Date: Mon, 11 Aug 2025 07:06:08 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] regulator: dt-bindings: infineon,ir38060: Add maintainer
 from IBM
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ninad Palsule <ninad@linux.ibm.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc: Conor Dooley <conor.dooley@microchip.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>
References: <20250811134703.161941-2-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20250811134703.161941-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/11/25 06:47, Krzysztof Kozlowski wrote:
> The infineon,ir38060 binding never got maintainer and fake "Not Me"
> entry have been causing dt_binding_check warnings for 1.5 years now:
> 
>    regulator/infineon,ir38060.yaml: maintainers:0: 'Not Me.' does not match '@'
> 
> The devices are used on few Aspeed-based IBM BMCs, so maybe recent
> contributor to these boards - Ninad Palsule - can help here in the
> maintenance?
> 
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Conor Dooley <conor.dooley@microchip.com>
> Cc: Andrew Jeffery <andrew@codeconstruct.com.au>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Ninad,
> Can you confirm that you are ok with maintenance?
> 
> Alternatively, if there is still not dedicated maintainer for this
> hardware, we should drop it along with the drvier. This will break
> users' setups (e.g. IBM BMC boards), but maybe this will encourage them
> to find someone to maintain this hardware?

Oh, please. Just list me as maintainer.

Guenter

> ---
>   .../devicetree/bindings/regulator/infineon,ir38060.yaml         | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/regulator/infineon,ir38060.yaml b/Documentation/devicetree/bindings/regulator/infineon,ir38060.yaml
> index e6ffbc2a2298..1267b68217bd 100644
> --- a/Documentation/devicetree/bindings/regulator/infineon,ir38060.yaml
> +++ b/Documentation/devicetree/bindings/regulator/infineon,ir38060.yaml
> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>   title: Infineon Buck Regulators with PMBUS interfaces
>   
>   maintainers:
> -  - Not Me.
> +  - Ninad Palsule <ninad@linux.ibm.com>
>   
>   allOf:
>     - $ref: regulator.yaml#


