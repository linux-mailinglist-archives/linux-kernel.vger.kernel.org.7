Return-Path: <linux-kernel+bounces-821849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D99ACB826FD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 02:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 981C14A504D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 00:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8CF12B73;
	Thu, 18 Sep 2025 00:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Xvlx1QYh"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4C82F32
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 00:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758156459; cv=none; b=bq9xde26JImpvcvadLRIuy6yOXAPfg7Eu5E8AGwWZEq191zdJL4foybLqdAoo5mZh6J6r2ID+ez0m/YJGIWFTsyx3xjDvZ1ld1PhJ2mDdBaYdFXikhcaDuOmoHUzQVs8n+ZpiCMQtfzIlxpmJT3giqjVZRXSMaltyPcV2U12K7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758156459; c=relaxed/simple;
	bh=IrbF+vK94gpu/ozn7Qtd6NvlKSesxn8hE2qZizKldxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NROX7uc9vRx33psmw79DtuUHIuCjs69VjCbTsilgW34oqdvAGK9wQTLLdULyYgCuzL2lTpbkoVx+AUTASOjg8bNsOqGE7TqcEkaE7mwNtMdkvzLNys9nsaoNifjim20x+abTgC8UeAvPJmA/NYPCzewrCSNLcVyy94eeGDvjK7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Xvlx1QYh; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45b4d89217aso2471195e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 17:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1758156456; x=1758761256; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dy3po34F373z2LL6aW/ho/h2XKggLTL7CNUt6WWnkWM=;
        b=Xvlx1QYhwouY7GrnLC4ddxEpoYmHruCJM6XA47zzQZIpxhkM8o5W+MY1AHubPtTZ68
         Jn+LlqYphah1YKP6on77LaWwWMKLBGm79qFyPx982SbqySesvPLNG4R5+Puvs2DiRhHs
         AW8I+GjlyEL61y4oacfQdwOeVJFcmnEPWNiNLldLMesEgeCrsBskrRFHYfmZ37AA2MiM
         0TIjhItsjV4XUORSKslLNr5ai/lppRsd2Wr9bg8XLK6268rFwDS/N7tJ2BOSmm3lsS1v
         nO+sOJ5z4m+fYhNB/X4ItJvPzBQYIxn8tazRbBhf96gnjDT5ox7dE0FBGRzyXw8f4imc
         pA1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758156456; x=1758761256;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dy3po34F373z2LL6aW/ho/h2XKggLTL7CNUt6WWnkWM=;
        b=lekOa3fZPN9Z+60M5GJNcLMylQw4pOyojT9/hlGF8cbESjk7o+s4lDAXHRM+dHrmxn
         DUj5aQDRszlWZwNPXnSe+BT56Eix6O4+yHmVhLK5tLInlXDlYuZzPx/r6kqXMPraHH9V
         fsLdJqyeWhSY2fTwxkStPiuUwdMZp0RYnWE/0J5v4HU62rSxg9/A62yeEYdGxHVR2Q2N
         o6Qsw557W38Lw3iHOe8Y6vdD99eOFvsdwe2zRLyPrHQGCRkDh8U3WO62LSx1V6hJzXLV
         rdN/kRZidoWVynHY9MYIrJF/f2gvMcUVFnmE6wWotOzEb+gWDwj/VJ4dI6uCTXBHnw4z
         zFKQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4a5F7vQR+eY44YQ9yOfP3RAKPurIdtOeLauomj+40hUt8Ioes1iQlojqx6ppNAO+04nCsF7mqtCaAU7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaYmUkFBVBKIn/ex5Z9u25laePIx4cuG1EzQvQhBNqSR5fGU/v
	7wbd2Y7IGpmFXFwDNYZXpP6rUC7QbtRGY4tVyO7vXTuOby1SSQD5D9Q=
X-Gm-Gg: ASbGncvM2EB4pG7SeA1DQYRX2Y50pxHBqcU2wYsKTwrJUN5KLyf8m0Gweunz1Wcm2xa
	ye/5qv9m3AFIhq8WggbcOXgVYp792J/Ii8bBZt+nEXNvBTwrCGTyw2majb9gqeHzBWDPy9b6zoO
	jrvvhwbXESIEEnb7+an7cqlXPf1bmoShyEcw+Ahkwk79pTamPAmm8xPtkcCFip+35+Js+5zp0Q4
	sh9sHPYSNgnUv6FdqL+NH3l9o5Ir8yoUgeI75mloWBbmQuOb+ei4rryRp8n33fd0dN1gCOUNVgo
	OypZqS0sN/dykVM6df/M830Zvt6+gLiuXR/sacYTLveBtKWzOe61T6poODuzizWHTRcy3mmVdJp
	iWqcN8ynrGAXGJzJTNOWyrs9zFjuktQVS6HBPtJBTJA6lzii+Fx/cGMB6z8ThIM7r3f79RcNoUO
	flc6UY9wjwdEXl8vqLEQ==
X-Google-Smtp-Source: AGHT+IF2GdKlp1Cj55CMvxh773K38LbN60g3EFJ2JiKm4A5B9QL/on7+DP5zXojEycCtnsrb/d1cTg==
X-Received: by 2002:a05:600c:1993:b0:45f:2cd5:5086 with SMTP id 5b1f17b1804b1-46201f8b30bmr40989045e9.3.1758156455984;
        Wed, 17 Sep 2025 17:47:35 -0700 (PDT)
Received: from [192.168.1.3] (p5b2aca14.dip0.t-ipconnect.de. [91.42.202.20])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f320ff272sm48908065e9.1.2025.09.17.17.47.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 17:47:35 -0700 (PDT)
Message-ID: <b7a5110c-42b0-48f3-9a68-7681ad588142@googlemail.com>
Date: Thu, 18 Sep 2025 02:47:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 000/101] 6.6.107-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org
References: <20250917123336.863698492@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250917123336.863698492@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 17.09.2025 um 14:33 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.107 release.
> There are 101 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg oddities or regressions found.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>


Beste Grüße,
Peter Schneider

-- 
Climb the mountain not to plant your flag, but to embrace the challenge,
enjoy the air and behold the view. Climb it so you can see the world,
not so the world can see you.                    -- David McCullough Jr.

OpenPGP:  0xA3828BD796CCE11A8CADE8866E3A92C92C3FF244
Download: https://www.peters-netzplatz.de/download/pschneider1968_pub.asc
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@googlemail.com
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@gmail.com

