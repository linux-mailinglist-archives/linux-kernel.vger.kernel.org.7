Return-Path: <linux-kernel+bounces-786599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAAD7B35EE8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 14:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E73A6177071
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 12:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4C6310647;
	Tue, 26 Aug 2025 12:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OgG+RPgI"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC90749C;
	Tue, 26 Aug 2025 12:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756210397; cv=none; b=QN2x3sMv+OQgz2G/AZDC3UiGZVE36hMstzMjsENF1HRQVXK3tycADqsdfw7Qgt1229jzgLC2tgvNz8wQFS029eLRRzOlFwGEyl7A1XsVxj3Yg/35t6yFrlAmsrwT1FSmbpWyjRBvWNM/0zD6oXJM44AVxjWZaQ3PvXY7ZRG1Ny8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756210397; c=relaxed/simple;
	bh=ZVQ546FAApz6UcjEvZFka6hskjqm07TCicK6vy3e3Vw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SsA4IbQ8ZYkTQ+d9TWuUM8l3R1bLaCVAwHixiYYbRzO/FguVkcjacQ+66Lhr7sz2XMS18IBhBs6FKHLcRgjIlj6JY2fgqeQrhlnDYeO/Xm8WFTRXtSe4IrYLrCd/1SBL3DBg+3A3AMX3qqS0vl9HCaDJujUexaFmBi9UfBxxoq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OgG+RPgI; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-324eb9cc40aso4139091a91.0;
        Tue, 26 Aug 2025 05:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756210394; x=1756815194; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=zfdsER7M2F2SOBCmhT/Yv94jMTwqsyZqNQBE2tZGyDs=;
        b=OgG+RPgIvNrOZEKiD2ep4l+l/0UhFBVD0Irvnyj9cVEio5xAdopfZTj11YGNYB97EU
         oilYDPGVlNOd6vUqpg3uToOgEm0d5rf0jF4G0MkYDT/HQQqr62RCxh6guUWXKj5k2h/m
         Ray5EBWdFaXMV0ShJBSvMtZL+k3/k9BWAP1SOe2N83CD7BAmv5KBx1LwM5kOt75vaMOw
         v9/w7ig6q5FilgUdVsAKhs9iIw3NhZZQczSFIFVrhxMYmAiY20vZqeLLxzd//74jnOjD
         04gttJB3WPr8qXH0vJNQC46L/YiG5ihvdWAry1lYdjQCvF0SQ0rLLn74M60T5pgHNZ1U
         Tz7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756210394; x=1756815194;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zfdsER7M2F2SOBCmhT/Yv94jMTwqsyZqNQBE2tZGyDs=;
        b=LD9y+ObC71/sSJdmX2z+phHmjdWMzikx9koSHMKyCnrvhb0d9tzdYMvAfOvd/ubQg4
         g2nnA+gb7CIiJ5HCpLobktXyETN6HB0y8VxjO/2IfkdjQoP+VfqdZpWy0dSXw8rpRxz0
         d4eJYKu1Lwu8ply2bXdv3Nco2cGpxs9Qnds1eKoszTXUMgWk0290usNOFiy6bVn0xGnm
         3i8HREIutpjthgLEHtyIRK5o292Q59K3M5uVZe7EKg4Hmcj5Lwt11TK2KcFtUCd0uu9B
         vGhPMc/rT+sm1O3Kek3LCZ6ZJ19pEVeaq4kXfTHUqQ5xXWE2L5F/1AR+6YFAOohBLKQq
         2YrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRGl0/lPPgb1ls/rkVQ8U5eAOcYw/4ozsNlqaijVQz9IsreRAyl7ywHxysY6gtuVbux9T2JTUBw48wWA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwU5ctEI4PiG6323nk0x73st0twzuig7IsyYFfyN8PZA81MtUt/
	t+B94dWsRec/6kFX3MtFgW6/s7trARA6wBEsfPSLw9+O7wQXR6w5RvDQ
X-Gm-Gg: ASbGncsYVklyqa+iKfaZvjLVnFd4IgeDzXEHkja+InE3ZXg0UcHVxGTfcGuA3jP0j9r
	kWolF/eTEMnfSp7SUCcrI/T9JsNUTxLyMKHKgVqTpXt63MUvVpS8hYS8m7E92sE9bGYG2F2CsM/
	2USBZNmJ+7mFRC/tJGebsJrDIZiUIR23CgORkQ2cnbVz1J2bjC7aYxIScgCtIAgcx6/lG0Wcqdm
	CkgsbiLmseeWLdHwnyc1kLdLe+4mq3HbvOkFK/6NyyKlyjnDD5aCcYowhub6iTEPPSZgM5B2ZWd
	il1k0OleuCzSPXoi+ia/y3ww1+eJSsvYp4qYLp/9/lvr5ZWgLIvWSPEtTrbyGtiV3zweIlMuyPl
	KiFgB82p4hl/Hj90dBmXtusvYBsCl71wXesc0NbOdQe3OWLWnmzCCUX1m5aWNYyc0l4r3thE=
X-Google-Smtp-Source: AGHT+IFTVEJIawrDnKEaMUtkbYOc14Q721TqIQN36vvLto2SFWRAEF2Qyx/hQZBWrLW4EiNpse8EaA==
X-Received: by 2002:a17:90b:350a:b0:325:6598:30d7 with SMTP id 98e67ed59e1d1-3275085dcf5mr1601263a91.16.1756210394342;
        Tue, 26 Aug 2025 05:13:14 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-771cd487f90sm5934115b3a.97.2025.08.26.05.13.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 05:13:13 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <ff8d639d-a9b7-4992-8587-e6b5284c3540@roeck-us.net>
Date: Tue, 26 Aug 2025 05:13:12 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hwmon: Add support for TI ina700 power monitor
To: Christian Kahr <christian.kahr@sie.at>, jdelvare@suse.com
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
References: <a8156dd0-ceff-4ad3-8647-a9c47491b599.98d92f9b-fa19-453e-a7dd-7ac376786b24.5ce0c954-cef9-4788-93e6-ea1d0263884f@emailsignatures365.codetwo.com>
 <a8156dd0-ceff-4ad3-8647-a9c47491b599.cccb958b-a4df-41b5-b2de-11045d5a9527.4676e9c5-8881-4585-a715-630663ab4f8b@emailsignatures365.codetwo.com>
 <a8156dd0-ceff-4ad3-8647-a9c47491b599.7b873dd0-16c4-429f-89d5-30f15a3af0d1.660caff0-2d53-4d54-b4b0-b8956c85dd8e@emailsignatures365.codetwo.com>
 <20250826102351.18166-1-christian.kahr@sie.at>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20250826102351.18166-1-christian.kahr@sie.at>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/26/25 03:23, Christian Kahr wrote:
> This patch adds a new driver for the Texas Instruments INA700 power monitor.
> Supporting Bus-Voltage, Current, Temperature and Energy.
> 
> Signed-off-by: Christian Kahr <christian.kahr@sie.at>

Almost identical to the chips supported by the ina238 driver.
Please add support for this chip to that driver.

Guenter


