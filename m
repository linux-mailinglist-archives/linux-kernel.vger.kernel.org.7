Return-Path: <linux-kernel+bounces-883381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F705C2D3E5
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 17:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0603234B366
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 16:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B616331A807;
	Mon,  3 Nov 2025 16:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="E0jtBi4C"
Received: from mail-oo1-f98.google.com (mail-oo1-f98.google.com [209.85.161.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694062DCF44
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 16:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762188534; cv=none; b=EaT6VXGjCOJP2V7WsWjbHGjrYBjp1G4J8rQ4O6ICr0n9oym4AwNfJIsorolKcaHkMVVgloKntfA3Lvx+5dn4qWTZT+npH0NUDRiM/RIuCVec8Gc8Rq4BgORLzWua083gyp+vz4A1oER0gGlBgiBlVqxAq60edQHEakM9+O34Ta4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762188534; c=relaxed/simple;
	bh=Kx/3UK2ATvOwLdoxaPKJfnie65Cy3XdnBCgcPNE6Nlg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CDTdPxUnjz+cL/SK6FlPxfDFEVPZ+SWzLu1AOoyB6Sg1JZJNVn9vUoVr0sR93Q0qreZlONNyCkpj0mMt9It4wvbbCuw/J7PKr55Aj5SkEp2+m0Su+XI6iC2oZ2C5Xy4eKNQM6FIT6rhhmbaGjWzFM8F1Cq7UCL6xpm+e6OYwadQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=E0jtBi4C; arc=none smtp.client-ip=209.85.161.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f98.google.com with SMTP id 006d021491bc7-656a5e7b07dso327016eaf.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 08:48:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762188532; x=1762793332;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pqnmc5hjtvFiB5sik2+Li461LIA6YCCGre95K3wVVkc=;
        b=DYTL7UEiICv0HGcIMTe5x+AviGUAA0mg9SafbGqoV9H8VUSw+ErwFN8MNXI73lwewo
         NAUzVN/I8658yg1irndnzjf5oTR4mYywqSfJHiI+i2hp0/eOWHWqldzSIhAgU3a5UcK6
         fX8+1YgeaSUy4XJP9+4003qAdiMc+RpfUsvhtDShoEYWup9eTviCBzR7GhOs5ucez7+N
         3KFaYhNpNtSTpvSNGJsbtusFJxN5aftCgJlaFFDW6ZEfTW753MfzDQX9GeSrMJ5uskXt
         m3HI3gCoSXweakMbEA23fFtkrEuYJpjF2s44L+s08vammDu0yy2TqgjWiDJkcg3mXXfG
         I1zg==
X-Forwarded-Encrypted: i=1; AJvYcCXpW75vCDZoUTHqCA+HvpwNB9knny+BkAoMBIolqy1YGHM//UyURPU+0zDavlfyGf588ob3eVA0DFwcqpI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTFbXmNR8IW7dyjRGBtqWwc8K+GN5RgUvIjE+152BHA4K5vT6I
	mH6wTeU5+glmHduFOeZa3onW6Lxt8AF1sg/KIW7R+vdWSbeQZeqwochVyd1oKDhaDbOxHpOSjFS
	YBHYBQxs8QXhPPs59MSx6RHh/07hy+DslBvG4DFZrVW57aFWf7nyeyfWjItztYVXbW3k5hhKR9Z
	4uIk2sxMaqv/feRccn1bus/CxGOuV+ts1FVh30B0fjxPbsgYN6eWWnn6CqtQS/YX92NNVDLsCYj
	zdl7hRyZ/KOhY2RAUoIK6cb
X-Gm-Gg: ASbGncvgIX9nqA8Ce0n6NGL+L992mh13g9Fg/xCSVcBQ+WMEWBZSWTFTMIE6Uis5qu3
	IBYvZ60MbErpJlF/q43TJ3q5HedP6PgFhh+4h1aFciiPLBnqLNAJQhB+DD6XHTPkeNIXxWmWl3R
	KPhEoRNmX4w798bwmBfw0BKwwaaoP3b2aww17GcioG1EK4ZO7mO15AXSK5S0+kog+whbLFkhXgl
	bBHZ0oZUQCr0F0SPTT1UukGzzPGDiwU9dWk3+7RTa9ai6iubuSy6fLzI/n//uKHNwwOFhadBBB9
	8ui5w1OQ9en21RsUSzfmpeqjcJ1RxUkXcRlh7ZK0oIPCQHDCzE2IZBgnCiMFyNyDKt97reZvoX+
	/5wVvxmM2ZMCMcT7NUSXon4EdKuOIXbGkYmT4TaB9uUJ1qhYFl3jNwm6Zib71xrqegAioyjKakY
	E/2uUwtwbN8q6mgsvRt4JBjb9NR1AQcInX2cuFlxA=
X-Google-Smtp-Source: AGHT+IGgWW91K4gyryvVNVxChWV6/xOAH8wzWyXNt8Uwi25OGWfbbPxqAlLD2P5tzz5JTmybSAaOHJZOVLLX
X-Received: by 2002:a05:6808:d54:b0:441:8f74:e81 with SMTP id 5614622812f47-44f95fa23d4mr5614458b6e.59.1762188532281;
        Mon, 03 Nov 2025 08:48:52 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-3dff71614acsm56801fac.14.2025.11.03.08.48.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Nov 2025 08:48:52 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-89f80890618so1976834885a.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 08:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1762188531; x=1762793331; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pqnmc5hjtvFiB5sik2+Li461LIA6YCCGre95K3wVVkc=;
        b=E0jtBi4CO/wGjNUsFCNFS4FVXa4YCihDBWmDm/MiulebVLiMHxHe5w9K8Ru9O3Fsnf
         R24NYn1eVHnlta+T/ylpUhjo0Wi43aFmrerDZd/O9NUsaxkWFJYG/zXl7bZlGn8N30Bo
         dZRybjjae+oiivCRV5PAO1FXzdhZI0H5EvPq0=
X-Forwarded-Encrypted: i=1; AJvYcCUf7OVfEzh6/zTvO0jlNcSqyZ0A0SpeznhSVEhjp/vsfhEDubv6vhnywjcRZ+dDgcoSb/PLSz/1+s/c7LE=@vger.kernel.org
X-Received: by 2002:a05:620a:1922:b0:8a1:c120:4617 with SMTP id af79cd13be357-8ab9ade562emr1585796085a.51.1762188531414;
        Mon, 03 Nov 2025 08:48:51 -0800 (PST)
X-Received: by 2002:a05:620a:1922:b0:8a1:c120:4617 with SMTP id af79cd13be357-8ab9ade562emr1585782585a.51.1762188529424;
        Mon, 03 Nov 2025 08:48:49 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b0f75d7cc7sm16533085a.27.2025.11.03.08.48.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 08:48:48 -0800 (PST)
Message-ID: <8655d193-2eb2-4bd3-96ad-c7615ffc7ed1@broadcom.com>
Date: Mon, 3 Nov 2025 08:48:45 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] net: dsa: b53: fix resetting speed and pause on
 forced link
To: Jonas Gorski <jonas.gorski@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251101132807.50419-1-jonas.gorski@gmail.com>
 <20251101132807.50419-2-jonas.gorski@gmail.com>
Content-Language: en-US, fr-FR
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <20251101132807.50419-2-jonas.gorski@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 11/1/25 06:28, Jonas Gorski wrote:
> There is no guarantee that the port state override registers have their
> default values, as not all switches support being reset via register or
> have a reset GPIO.
> 
> So when forcing port config, we need to make sure to clear all fields,
> which we currently do not do for the speed and flow control
> configuration. This can cause flow control stay enabled, or in the case
> of speed becoming an illegal value, e.g. configured for 1G (0x2), then
> setting 100M (0x1), results in 0x3 which is invalid.
> 
> For PORT_OVERRIDE_SPEED_2000M we need to make sure to only clear it on
> supported chips, as the bit can have different meanings on other chips,
> e.g. for BCM5389 this controls scanning PHYs for link/speed
> configuration.
> 
> Fixes: 5e004460f874 ("net: dsa: b53: Add helper to set link parameters")
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


