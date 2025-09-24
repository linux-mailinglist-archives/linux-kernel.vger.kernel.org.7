Return-Path: <linux-kernel+bounces-831311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E2EB9C53B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 00:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABCD73BC756
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 22:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129B5286D76;
	Wed, 24 Sep 2025 22:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ClKriybx"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEB3189
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 22:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758751622; cv=none; b=Unu4BuHlZgzn1eAL7EXJn4Lnns4G2KT/SK+cG5uKcrmj+fIa8kLtvm0qcBvAzSnfW0l/7aeNQbZTrpSVdViU9Gai+ntb6lY+fl88z+U2vl9REbuqlppd8b8HRReRg3EsXKAtQOL+pOsPXxuHPVizlL8lxa28aJCRckU3AS0oRLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758751622; c=relaxed/simple;
	bh=Vdn48RE1Y6SB01Zbp0RcO5kB1ekl6UrJmVmLKRQa1xU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LAjlQvS/7o4yZ1a2B/6U22zqOgnvEbUYmW+qHlkgIrEcWW2ph9qHDyArewiV/6+01pVMMk4yodJPfIh01Xmwl5HSJUnzsr1+CPlNQDFHLTObeuklddAuQm969+HSV0jWgzsPqVKtjJwzLr1yJ/ZeIvbFBUd64GhM9Uxf7AmFgh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ClKriybx; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-77f605f22easo362873b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 15:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758751620; x=1759356420; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=dl1V7qUnqNqDbT4UqcP8/hFK+XT68w+b4j9K9r8j1Hw=;
        b=ClKriybxSQyRFTUq134hfxHa21JwATQ85ou+7MkfgI324mwFlJYOI0RxWS/I6bs3rW
         vwvc8d3HP5WRrox2XUV3OHZFJD7Wx0VVeFsnxYQCEvtytmBLxOHH03vaAIsHqZtIHK/V
         wvpNWkKClz1cs4ghXgihgzE+WByGbjZZlv6YzdRvvROUdGBa9OVkzbBl+/7fe3TjXO9y
         dDkNHBS1WZuSvz2NsYbcfHdWP4ckjaAZ4kY2gy32b4+YzbgzL7Sde9OP0rDfeqY+M8O6
         3wgBP8QbhK7JdOpioa9DoUFZOCefzqG3hqDM6baztzMSqwVCpp/o9rd62JJdIUyxvkK2
         PlZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758751620; x=1759356420;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dl1V7qUnqNqDbT4UqcP8/hFK+XT68w+b4j9K9r8j1Hw=;
        b=Ht6i6okT3djMo8x/IbbWwpkVop9c/xQcASc/O+zpgjSBOC1GJ1AL3DJPLTTMRIWPLF
         fArjavIxlS6vH5zTz0qi4FVTyEN2GxMrF1blbBodDfv98zQKvTqqLan5lvXpx5JOojFV
         uEZut/jEK/Q2je3o9PvYMcaLwC2CNQkaCr7MGF2gXpgIuWpTaNz3WDC4coJvlcmYLm/Q
         VBztOqKWT4QrAwwaT2JyRcKvlktZ+r0NjCtsOAN5GEsApmtUxrf4T41LSUhijV09WD5k
         Ci+qUqwEggwB/MDgCwWfv1UBuqffXE/86thL3rORa1Dp5hGYn0+Gin64o7LIaHQG+g4+
         S5bQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5Bp3uvRIAKPkG+ZkBuUKYymtQALD3S+CXNDWgmKTShnVtqbh1oVutCmgXgIgREXPmXQiWTL7cWi+QemA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7pjXttxWbnkCFGAXrwQZB7o9emfIDVqPbpG9R6xjaNhOYjUbZ
	IF/+wUlaMaffVUFSyq2Z14cxQRNNlMSk2hTMxZgXhlP3vuZOhi4By196Z3n+lhgc
X-Gm-Gg: ASbGncuAjS0PciTeUCfW9sPJq/wLMmWe4P6TyQMESRWAA9dhwsLljOoTfX6gurqhEjs
	pPT7bpZDtoJUTSd8JVXBMLm9PSe0SvjCsx80CAUVvOQE5JoVcHpnC521md7oab7xV4d2AyXJMV2
	twwuQkXLZRDmBLPdAhnP+7ER9Du3FY4vZXuxt5PPs/+U4oNXY6AgWVnfDD6TYrb0z6qvDMzzQYA
	2gMi+69Ub0AtDNNY9cPyST+8yV7C4YvrdIl89PruEf6QiH5kHPqjLWylaLHG7UDXu8zvvaficff
	L01cK6aAI3BYCIs8v3h8E8gjZ/9htLXGaIYu6wSD2Sg36u9qN3pFTOgPXcYo6C0+lgbF6wTs2zv
	++ADtxBr3suJTjuk0MLEEeGS8gfEJUCWxNIYI9Z42nRJ26DZCoFeNtNWXsZc0luXed4kJoaA=
X-Google-Smtp-Source: AGHT+IHHnbNi+NkCGS1+ufzKqNVIJruZnu5JQBmRLAXhbf6s572kvM11iqFoULmNTD9qbUTmjoVFXQ==
X-Received: by 2002:a05:6a00:22c4:b0:772:a5c:6eea with SMTP id d2e1a72fcca58-780fcea416bmr1744498b3a.17.1758751619950;
        Wed, 24 Sep 2025 15:06:59 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102c048fasm49845b3a.75.2025.09.24.15.06.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 15:06:59 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <f019dcef-afdd-4d18-b28c-b214fa14f1c8@roeck-us.net>
Date: Wed, 24 Sep 2025 15:06:58 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hwmon: sparx5: make it selectable for ARCH_MICROCHIP
To: Robert Marko <robert.marko@sartura.hr>, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org, daniel.machon@microchip.com
Cc: luka.perkov@sartura.hr, benjamin.ryzman@canonical.com
References: <20250924213027.1887516-1-robert.marko@sartura.hr>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20250924213027.1887516-1-robert.marko@sartura.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/24/25 14:30, Robert Marko wrote:
> LAN969x uses the same sensor and driver, so make it selectable for
> ARCH_MICROCHIP.
> 
LAN969x _is_ the Ethernet switch driver for Sparx5, so this description does
not really make sense. Same as what ? Itself ?

> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> ---
>   drivers/hwmon/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 840d998f850a..ba2b7b2f6c44 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -632,7 +632,7 @@ config SENSORS_I5K_AMB
>   
>   config SENSORS_SPARX5
>   	tristate "Sparx5 SoC temperature sensor"
> -	depends on ARCH_SPARX5 || COMPILE_TEST
> +	depends on ARCH_MICROCHIP || COMPILE_TEST

... and silently disable it for ARCH_SPARX5 at the same time ? That is not what
the description says, and is completely unacceptable unless explained.

>   	help
>   	  If you say yes here you get support for temperature monitoring
>   	  with the Microchip Sparx5 SoC.

... and, on top of all that, still claim to support Sparx5 even that is
no longer the case.

Ah, I see, this patch depends on patches in linux-next. You might want to say that.
Also, there is context missing: If the sensor is _only_ supported on Sparx5
(which everything but the dependency suggests), it does not make sense to extend
the dependencies. Why make the sensor configurable for _all_ microchip architectures
if it is only supported on Sparx5 ? Maybe there is some other series explaining
this, but this patch is all I got and it does not explain anything. It is only
confusing and does not make sense on its own.

Guenter


