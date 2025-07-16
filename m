Return-Path: <linux-kernel+bounces-733793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CC4B07927
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 17:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3817189189A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091842F3C2F;
	Wed, 16 Jul 2025 15:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OMT2RATd"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49CF20F09C;
	Wed, 16 Jul 2025 15:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752678261; cv=none; b=E0FTYayN9PDeVIiHKpyT0hhvsRKZ+Xv/5blSHrPeBCyaFX2JmusT5uyBAqhBPMMfTv1rs5Prq2yi8iQ8YQDWO8eW6qJPGFH+hUJTsyyGml+p9zza/dAQz8cRdEPQtAH4WaIDU16PTilA/gnTl9Ty7Ude9LtHlulFv/KA8RbvwVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752678261; c=relaxed/simple;
	bh=fm25DdU4c1zB4DVvj8YQeLiYvOn6WXXQyik4zTzRyPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ETNQEaAht0etztKMwAzcNccZya1EX7PwV8v/zpekDXxBMmkIYJY8DTE/KHe1SGwoJC0qUw1KIXCECKsYIPrxZXv9/ZH/5hqV0OSct7MG0jodqunSr9MYBeFyXXnqZvvLT8xIhlUx7Xrc96NresvDRpKdjbhgFyDuOWVrpum9Pxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OMT2RATd; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-23508d30142so71815135ad.0;
        Wed, 16 Jul 2025 08:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752678259; x=1753283059; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=M5QSyX9af/GNAYKkSFCbWWSXm+ImKqp8zhujTWyCrgI=;
        b=OMT2RATdnJLxcRGNPNgHL/K7IaRSm0ph3oi+Y+8ZQ3gBAezRmX5tTkELGDuAtxkxqt
         coicos1fgCvj5A5c9OLiF82WmsUtf562OI5w/WUH/xozZNUjHQPgWPEGcwhhNBzIOMD0
         ndxNeFd95aVu4gx3/81DmRB7A3OnbxjPE511OQMO/sLSCDPTP77HDADeUdXIVg2Zj9C0
         93RZ55ob+gafB3VFoZEw3Idph/1JSjPkc3jqgPUev1YxQQNKiJBO2VvMbzRmYdUQYUke
         ajHkuciB9UeVWSA7CYrclXpIY9wiK4GIs5axxN+YO3OQog9/tDf/RmyVNE5EYjrR9u1V
         BLyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752678259; x=1753283059;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M5QSyX9af/GNAYKkSFCbWWSXm+ImKqp8zhujTWyCrgI=;
        b=hjTj6IXtF00ipOEkOsxa3ElBv85PTFWMLnsNatJ8nh/DIQPIsjFOBtpGJ29rOOGRFW
         HYOm+zR7ARuKiOWlho+3fYXO/O1YV3aiM9W9kJf44HxcNXfYjg/Y9nlqinQe/qWy5aNU
         En4/zoFFtH8+2NHD1bpIDuWYA1lTJwXNSTpNAXu7/xGxPrTDfzV2pnNI92F8ODZQHzIV
         bL6aeNYSDyo8nsonuGeVRKRvwYpvfQXUCY74tLTppr3QaP2XOw8J07pAKbJC6ai9/TGo
         3RH9gJTFEYOmOm/3vrouZziliuH1urdTo6fgPsvZxRXmZz7ZmX/PcBCXuDMXtWO2T78S
         6KtQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2diZ5d9J8BWpYInVSjhLQKsPWyUJ6/LloNdgX39GdCO5znep6t4JB/K+uWztEeomICLv7rUTOUMzR@vger.kernel.org, AJvYcCWeCq9jw4kKz65R6EeG5wxJrUFyq1uoeXp21iTz5FES71uBapMmBj9oDL2GyQeduN/7n86HgrvrHfCkaw8A@vger.kernel.org
X-Gm-Message-State: AOJu0Yye6eOKZzpKWnGP4pgGqyB+oGy7y/l9FSDzfiqmrioZ7b7iIBfj
	cEZjfIXgsCcIaBmTZAvKZUO8XsXMpYkEWx11FC/neDnem6Gfwn2c3rNP
X-Gm-Gg: ASbGncuYQFuSZK6q+aF6BSoLtRtUE5KiiZw7izV6vXdj3zzl9SI/D8RL0taYo2he16V
	09r10T60qjAm4plR0RuGWM2NROWd8qI0ikJFa/ibuC5E12qfKC3AEyPJfJ2M+BP0MzZ5tkw0LNO
	PNxcCwppRG78/M6zy+hXxFm7wmNELBk/S/A3sX14GAIxr5jltg2KVPDQbJ4OXn6QVQ/3BqQ/tGG
	Sn/HWF/leeTQTxne1y0y0GyYgFp4/jaVabheDrvW2Lc+KH6qJpqIW0ARSBqw2uPTNbH3mNx3V5R
	l9/eNpnb03Tie2Iuf3wAxi5TmfkuR96dk7w8LA7dAteYnJH7dLuKawnpoE4LgbJlHcFOFxltBg9
	m2InuN7My7cV4emJ4wduF3N6pBE/411kXYvodUXnekDGrv3OZLi3uhweD/OiT+5qJ50XoAiHKtO
	IW7k38Yw==
X-Google-Smtp-Source: AGHT+IGE/OSfI8JuYq60NlOpBZmUwu3J29DCnumLYThUTFanTYy5hEaullssgXFaxHjyekvR69xpGw==
X-Received: by 2002:a17:902:cecb:b0:234:d7b2:2abd with SMTP id d9443c01a7336-23e256b5db1mr42421745ad.19.1752678258958;
        Wed, 16 Jul 2025 08:04:18 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de434d6b0sm130716565ad.203.2025.07.16.08.04.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 08:04:18 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <eaa183cc-a56f-4a33-bf01-a5279799f395@roeck-us.net>
Date: Wed, 16 Jul 2025 08:04:16 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] hwmon: ina238: Add label support for voltage inputs
To: Jonas Rebmann <jre@pengutronix.de>, Jean Delvare <jdelvare@suse.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org,
 kernel@pengutronix.de
References: <20250715-ina228-v1-0-3302fae4434b@pengutronix.de>
 <20250715-ina228-v1-2-3302fae4434b@pengutronix.de>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20250715-ina228-v1-2-3302fae4434b@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/15/25 13:49, Jonas Rebmann wrote:
> The INA family of power monitors estimate power consumption based on
> two voltage measurements: across a shunt resistor and across the bus.
> 
> Conveniently label them "Shunt Voltage" and "Bus Voltage".
> 

Labels are supposed to show the sensor's association with the system, not
the chip labeling. So this is a no-go. And, yes, apparently I have been too
complacent with people (mis-)using the label attributes. That doesn't make
it better, so don't use it as argument to support this one.

Guenter


