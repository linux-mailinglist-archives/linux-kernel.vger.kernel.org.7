Return-Path: <linux-kernel+bounces-734200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A76B07E4D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 21:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B4DC1C2144A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 19:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF7129A9F9;
	Wed, 16 Jul 2025 19:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJtdSeRW"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FF315D1;
	Wed, 16 Jul 2025 19:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752695088; cv=none; b=orfAD0znfnHDkOqxMYZnzBu7SGYtxTHxT4t3pGGw9jlsOxW4u8dP2AAE22gEKTU5RRtRK3L0O8JiM+0PBu12/mOicQDrH09boWNNw3TRXMWK3j/ggwSYPFGyvhmMcYEXNfyC5tS4GcXqMfQNt0FbOKBJ95+J0fkCsP4FwepCBpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752695088; c=relaxed/simple;
	bh=rWlxj9bCrZ5JrkdaB9LEQwfdXLFqyvRTJ/M3T9x+27E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LDiUiyXq9nPmGsaxUSxeh08P2j5qYHn8DVfSfyfymj8hRF9WNeDqstGOzT1i71DFD8PxKyw96cMcrbEfQtcA33ChA2t2SriBS6uEzGS9RNmeYtFeEGbch/TpNf4bZeW/2Pkt4wPmuyz2xlDeigbijVJWjna5jgrYeV6a6hViPc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lJtdSeRW; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2353a2bc210so1674965ad.2;
        Wed, 16 Jul 2025 12:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752695086; x=1753299886; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=344G/5oCpBbSmGzTdoVwcn6E4LLYeUG2XVgvtMN0lh4=;
        b=lJtdSeRWFIikvsDbjXrdKRkFgrh5zEDHSUfbyVZQSt05xraot+Pz+TG23amRnt8GYR
         TwM0KhT9cnL0yBkS9IA+Y6qWm7zz0TcZKnGarVOmDtm+hWiQQQIHrITs+h2JgjeHKged
         aSeqAnRlXCwkK0Q7ggSMEzG4D+zZ9bfnFiW3GP5vfBfFfMDmWuZ7W6mTBFN1TgZbQQDI
         0hYN6786A9RuEPbKpwq/svCD4CVGvUTv4u7lOfxjNKcAS28ScQGG5WHxgw5iaru1X78n
         bd08FIl8ImR2emZC4TTMwgYamesTvokUID97tg2CAwC1Fk1LyZ3pouIONqaUpjYmB/C/
         Mq5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752695086; x=1753299886;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=344G/5oCpBbSmGzTdoVwcn6E4LLYeUG2XVgvtMN0lh4=;
        b=ZubkpN/xCfyX1Lz7N8PI7SqV2Sfu98XLB9ExJn2VvGkNYXlTqWqvEKKb0w9grqQs6+
         K3Jp0Asn/8fvrmVfxhw4bJUHuLw2fEsigW0lNxw1F0xo5ktvrIKfnHc+SLajf8QJ/ycZ
         AsR1HzbLNL8ZLQ+tu9f98nszJ4DVUBY7sLZLvMZ9vpjhZ2SdupAFGG6rL1qWLS+GgMm1
         D9PY/FCBEzEZndWpHZIAmlrlNW2QGN7WEVkz6RIBIT7iyEo631UtBCGBfO4oafydQMtr
         IT8cGwWeIvS47pCdGOrLhEsFJPtWYza7eHXMci3JjJc2eR8am+RyfLNkd1PoLxGjPiXe
         ostQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0yK9fL2S4k0yB+HUZoIFJgUxtgLHY4aK4HC3rQTRzqPRceXCAz8+/0WJnYe0ab8DQ0J3lZp/HUl75hacV@vger.kernel.org, AJvYcCVkPO7lTshcrrSemDYVQLthCISjFHg59RvrYQDYWHOrWmpwmPW0MVj5hDWJLd1iHwLt1LtHRA/qOs3ifh8=@vger.kernel.org, AJvYcCW+Dr3YUp+e8rG4ovdMgF/UZEf6ZP7936sxDFcmw6QgKmWfQ4+4ma1VQ61pIX9Zw4lcbvYHcmJiXgM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoeQMuUT0LtMQeBbPDbqY8iG3wecSMYyuqbSsMssIlE4LYxWWW
	uix2Io/pv5GkiGN2bYwj3nl8Utx0IW26iJxUkX+tnF4itovK2WUp8vRC
X-Gm-Gg: ASbGncv2x3GZfkNnEmHDC34LuIIasXgncf/Y/0ZJMM1T65uItv12BzXvvaIUh4xgBWb
	vevd5zQM/HwPcWquZatYy8fi6x6IRTGHhhX+ZZHqWawrRjAs1ILUb7CMSi2xiYpVFAY8ZymPuDu
	wt6/klMCQTIrgKP/FVhZ8e8oTzUctZB0v3qdN4sTxWKuNbhEOQCybfRYcVfuHJ+6ZxLkTN0hAlE
	OCICWSJU2PmZDO9rlipcXIOjWOpNWodsAmlLvH2Yh3NGKWSwuMYlwhyGoyuCpHqq6Klgmos0+pu
	nD096G8fPS3+fJU4pHrEXgLI+XXYoyaeRo7ZeN1AMksmcxCmFm7itNQZS3OTiElC73DxN45bCtY
	BruNiOudM+oLzS9iOVa7XmXiEyDTIbux/LM+RIerrhmGa9DHQwbKBljefnNiYheMkKiAUdZ8=
X-Google-Smtp-Source: AGHT+IFxUCDXSWik+PD1TfU/TfjoOIgNNw8gHrizVoZXaax5sqkNFm0hdOCwHWWPp081iAty4cIIWw==
X-Received: by 2002:a17:903:1245:b0:235:f143:9b16 with SMTP id d9443c01a7336-23e25770caamr50691815ad.41.1752695085579;
        Wed, 16 Jul 2025 12:44:45 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de428663esm127562065ad.15.2025.07.16.12.44.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 12:44:45 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <1a6c43c7-3f77-4d47-9913-54c50cb59e9d@roeck-us.net>
Date: Wed, 16 Jul 2025 12:44:43 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] hwmon: Add support for MPS mp2869,mp29502 chip
To: wenswang@yeah.net, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, jdelvare@suse.com, corbet@lwn.net
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org
References: <20250709092734.455976-1-wenswang@yeah.net>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20250709092734.455976-1-wenswang@yeah.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/9/25 02:27, wenswang@yeah.net wrote:
> From: Wensheng Wang <wenswang@yeah.net>
> 
> Add mp2869,mp29502 driver in hwmon and add dt-bindings for them.
> 
> V2 -> V3:
>      merge patches for MP29502 and MP2869

Why ? It only makes review more difficult.

Either case, I now have submissions for two drivers supporting MP2869
(or MP2869). One of them also supports MP29612A. That needs to be consolidated,
and I guess I'll need to spend a lot of time trying to figure out if separate
drivers for all those chips are really needed. That is going to take a while.

Guenter

> 
> V1 -> V2:
>      add Rob's Acked-by
> 
> Wensheng Wang (2):
>    dt-bindings: hwmon: Add MPS mp2869 series and mp29502
>    hwmon: add MP2869 series and MP29502 driver
> 
>   .../devicetree/bindings/trivial-devices.yaml  |  10 +
>   Documentation/hwmon/index.rst                 |   2 +
>   Documentation/hwmon/mp2869.rst                | 175 +++++
>   Documentation/hwmon/mp29502.rst               |  93 +++
>   MAINTAINERS                                   |   9 +
>   drivers/hwmon/pmbus/Kconfig                   |  18 +
>   drivers/hwmon/pmbus/Makefile                  |   2 +
>   drivers/hwmon/pmbus/mp2869.c                  | 711 ++++++++++++++++++
>   drivers/hwmon/pmbus/mp29502.c                 | 670 +++++++++++++++++
>   9 files changed, 1690 insertions(+)
>   create mode 100644 Documentation/hwmon/mp2869.rst
>   create mode 100644 Documentation/hwmon/mp29502.rst
>   create mode 100644 drivers/hwmon/pmbus/mp2869.c
>   create mode 100644 drivers/hwmon/pmbus/mp29502.c
> 


