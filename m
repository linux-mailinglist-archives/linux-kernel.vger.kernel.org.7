Return-Path: <linux-kernel+bounces-846274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1ADBC7732
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 07:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9256E4F32C6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 05:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11EB262FC1;
	Thu,  9 Oct 2025 05:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GgwPnMC/"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEA82609E3
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 05:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759988329; cv=none; b=WDG5L9ZNqm3nCVsxStCI78Bgf+rhED3F8Enp0c649Mw5CpjzteXz303MzYIKzLxYzq6isZ2CmRlRF6vJcifezPvghwxqJRya785bmTbNJvj0aZKtf5s2xc1vcylQz6EsHfKCQt/YPfEROyybYQ/OSVacKwXpQDVLJQU9Dfdzdtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759988329; c=relaxed/simple;
	bh=npR5+hdrCx438MidrYA4MYFDxbFLQwa9+iFgs/BnSQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=krgLCAnuqusZj24lSb+h7+dBWq+vzMlVtUoq7USlE1Ms+kTxsEiwQJXOHCZn3wCQaTWV5AgBHaC2ztuoVvaN5HVZVexAE2b3Su5wY3Prbw1g8GoldGBc3VnuLnt2SsPQ+7Egajw0MmlTeS9lCcYMXdhSzvgJN3Q73rD8oEJUijY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GgwPnMC/; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-78125ed4052so670179b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 22:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759988327; x=1760593127; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aKbCLdA0D3ZyyrFcf4HmlfoknTM5HGR4JdTF6XUV7wY=;
        b=GgwPnMC/5b7I4MiftvL4t9BJjpH5GOyIo74rEteiiesxPSVrFENSx1m83eXCLspkM7
         w7p/dXj55rMPH8icSGq1nUZS4W6wWsEGGS+j9X69BMDOE/HvZbNlDDiPX3wJgbXBU1pg
         3mz1E6auBbLHqkmvbMz8WEOcTeDtYK4zJN524dONEf18ZNprdbFrucgaf5GZ7YBRT+1e
         LATpWP3xvoWk5MI+QaeQvKhdhjuFQMhzd08g+o/AUrXPviPyH8Cas/eShcKXxNEAB8vW
         GHvtk3rNFJFR5xdzL9UX5dfhJaHPjaYFQF6fAM+1h55M5q8tsMsLMHRnfvXFfw13/z0f
         8ZZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759988327; x=1760593127;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aKbCLdA0D3ZyyrFcf4HmlfoknTM5HGR4JdTF6XUV7wY=;
        b=ZrOE2CYs38LKXVdZcD6idUqhZZcfUyo1wYAzXCadwXm5Fbbqp3oMyoZk2t2fJWb1Su
         G6TxMvNsZSRkgK0OE9gNtzp/2k3dkBexhOmQgkOQKwIkkAypPqMGNZ2FfqcZfP7gp8/D
         D0k8D+K5VlZ7iSD8sdyMv76772OURDXaoux35tKTzHmXkIYLMlH8Va48fAHovBhCEOC8
         vY1g+MqrxQHqRStkKO+NhmlDd4/0ozH38fxSHM8OX/ahTNZjecYM8rLAc2Ou6OGF55j3
         SNIIAx19o5d3amPsiP28T1xLNmyXrzgy5ngk8DKvXEdCPWxpDEY+9ouI4anZQKb95B4V
         D9mw==
X-Forwarded-Encrypted: i=1; AJvYcCXXyU8aqvXdmRIh2nDnNkdfQOzlCT7OOtGUxmEGuKTj+TX99E7l/yThoMuspIj23p3qiLt30p8t7magkLA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsuj1ZyNEHj5QamUFuzQBqD6F+1Jfe3d/Isez3xzrZN1GcPBBa
	6WbvUQvh28DNSJVSoBfb3HA+pyiOGzqXqXqW6AXCizjlH/2onPsYXZaN
X-Gm-Gg: ASbGncu2/o+20E5exIfFEnbU8m44Z/ZGpQu5mUwkXe8dgoOFVrXe3y2a1gENhL2Cjyr
	ZcZ1jgbgBXoMUwSg4rsX/Hjf5ZwLkll+V1MWfaFXoenJf4GBruNLdeMhIZhjcBAlUMfNymJlwy5
	plNSdKm7hrJc1ZwAPqtdjJgvswbE16KbsJ7j2JDQt6fwiRoEX6VCwNri67vAZ9zTZmQG2Q2VYaK
	pWRA3ocgwtFcblxhByqaUGn34DYI0g3FZvMn3kgEuhEmBezEj8B4Vj7jwSSThELF5BxFhtYkIGp
	Q35fWrh7E/T5qVucNFF3KLH24HsQjsYP0vkI3ivW/ToYUaTlwp/wuzkNBYV/aq3n2kajmH0bfo8
	dezWKkTIo6YXsA0EjxGCtf0YZZDtsUbK8hKcPyef+z6YlgOHjgxyuHcZeALipBM3IaYM=
X-Google-Smtp-Source: AGHT+IHZ44y6ZFCxVyEDZOYJddPo2NG2UBmtyjURIoIIViVofpipLRjydPLmmlTTcL3OK6IoivH0yg==
X-Received: by 2002:a05:6a21:33a8:b0:32b:70a3:afea with SMTP id adf61e73a8af0-32da80da519mr8783258637.3.1759988326785;
        Wed, 08 Oct 2025 22:38:46 -0700 (PDT)
Received: from [10.0.2.15] ([14.98.178.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b51113776sm5508816a91.14.2025.10.08.22.38.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 22:38:46 -0700 (PDT)
Message-ID: <5fe7d13e-e608-48a7-8205-514c461a145d@gmail.com>
Date: Thu, 9 Oct 2025 11:08:40 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: usb: lan78xx: Fix lost EEPROM write timeout
 error(-ETIMEDOUT) in lan78xx_write_raw_eeprom
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Thangaraj Samynathan <Thangaraj.S@microchip.com>,
 Rengarajan Sundararajan <Rengarajan.S@microchip.com>,
 UNGLinuxDriver@microchip.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Oleksij Rempel <o.rempel@pengutronix.de>,
 khalid@kernel.org, linux-kernel-mentees@lists.linuxfoundation.org,
 skhan@linuxfoundation.org, david.hunter.linux@gmail.com,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251004040722.82882-1-bhanuseshukumar@gmail.com>
 <2025100407-devalue-overarch-afe0@gregkh>
Content-Language: en-US
From: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
In-Reply-To: <2025100407-devalue-overarch-afe0@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/10/25 11:21, Greg KH wrote:
> Hi,
> 
> This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
> a patch that has triggered this response.  He used to manually respond
> to these common problems, but in order to save his sanity (he kept
> writing the same thing over and over, yet to different people), I was
> created.  Hopefully you will not take offence and will fix the problem
> in your patch and resubmit it so that it can be accepted into the Linux
> kernel tree.
> 
> You are receiving this message because of the following common error(s)
> as indicated below:
> 
> - You have marked a patch with a "Fixes:" tag for a commit that is in an
>   older released kernel, yet you do not have a cc: stable line in the
>   signed-off-by area at all, which means that the patch will not be
>   applied to any older kernel releases.  To properly fix this, please
>   follow the documented rules in the
>   Documentation/process/stable-kernel-rules.rst file for how to resolve
>   this.
> 

Hi,

Sent a v2 with cc: stable tag.
v2 Link https://lore.kernel.org/all/20251009053009.5427-1-bhanuseshukumar@gmail.com/

Regards,
Bhanu Seshu Kumar Valluri



