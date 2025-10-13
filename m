Return-Path: <linux-kernel+bounces-850982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FF3BD5035
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 12B0F583325
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640A9310654;
	Mon, 13 Oct 2025 15:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="b66B9yjo"
Received: from mail-ua1-f99.google.com (mail-ua1-f99.google.com [209.85.222.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0D831064A
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 15:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760371012; cv=none; b=S11T9SWaJrucjkOeremwqa3brGeyfZiw6GIvGR5/YLxYxvN4kiWNuxrFBOl2Ncejw/l8DDEuvdZU3reyIA7ONHuISVayns4vERD1XKddSnRs7uIs/JLYfpPITCZJHg9uN85qXfUSBwiGLCXOKWa7TPNfqp5eHcqncn9/MSySfbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760371012; c=relaxed/simple;
	bh=Ss93tFmEYJlMZd9Wc58BbxxGQ+xwJFyZdWu2RHMRzgk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EiFNAOQyIjeDYTecqYE4LHwCBZtoUqMCOUIFFMSw0s2RYyHy97+OPh4a1GV1JPf1Vp79f8U2KaxDDbtAAZ2m68eCUBf8HuOrvmU02ZF5dHJytombLtHThnwuCs2QcGx539IJFKWdviZTDO/JqWOKFzEcByiAZd3ebdirn8v2pZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=b66B9yjo; arc=none smtp.client-ip=209.85.222.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ua1-f99.google.com with SMTP id a1e0cc1a2514c-90f6d66e96dso1032697241.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:56:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760371010; x=1760975810;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4TUsSNeUY9kbs3ebqI1ua2BS1zD+qEH9X1wvEGJyTqQ=;
        b=XBDfiP0yuSKSt6lrfYsHFKUAGO7vTPsAlkBaIC7pcRYAhHKNavWbEqG40Ym310AkIL
         6O3pOyvilAUz2HTyzQq/r1GYxk4ZxOoYbwy3r/EyHZkpAy/Ko+gC3z73/KWTZdYV1TLS
         8nFqQt0ZXtozMqubnATKybEewhzi+S1hzqNZL8GP0cP5Gk/Ay6RsNqyz+1dJ5ZK8PDN1
         Gb3QmTv5rqPfjmpz0ukL9MgU8oXHNBN9nL/ygDcZoXYaBgU9DIfZWBslyz+hQBhICaHq
         JRi2BtYiWAnqyTxbYNlr9xy0U0D73R8bAHbp5Fto9Qi2Q+0AnYUxIg2bwLADgB20cNCj
         D+6A==
X-Forwarded-Encrypted: i=1; AJvYcCXbRxMWxoZiaWQDyXu2xBHX5kkY2/VJG+AJIVB1ZsMjQCMvq6DM5lnEBVzBnOaJcWuqvRD26Z4G/KtVgk8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaHMg3YRQrOkqhEJ62yF4MA0taHscgsJGW/AoQaueOGrwXJKnS
	ScaXd3mDhcfXbG68SdFJKZ/v1IdlUVktfYgYmdki3vRutRqjJYkQrrSGBP5adLBcD5UnvSGSm4d
	/cvtAxM2WY0EEDvDb50vSxmQNipi8QBzj9CEM2cAOx1sjQtW+DCSGNqQWN9wszPh7DRCi1aOcyb
	AxbMMm2GIvx/PwBwzg/tajpmgIJBQ3NJEndm36pMwQ4AyIXDHlGQ/mw1TcP6+PUiL28Zod1YOhk
	yTpvune3kGEOUU3xwBZOX6p
X-Gm-Gg: ASbGncvPO8Szjc3lmZK8nP/8//YkmdISZBhTTob2L/uGnH/Wgqrhcj45VF41dMeJXuH
	NWYjPzZOn5nYBlBeyrDVVsztZ7EvqaDVUMFO85A0etfvro6un9xS9j4lpIVsMnsxtNgvUrzCH7P
	QU8woWcEnaTxZqJCDKlYYR7KatitzuMkJthjTZdASirfZC97dBe+9qwFpYIYWKX2xfhkakCibRi
	RkIBJOAUX9N9ZK6Cu2lIrjiT0Y5u6hAPqzQh9FSyyPllxhyyszep7KpTNKsoTaptem9iTcSCoQ8
	+isKbTE2lTXMOaacZ86pKOmTdJGtl1oXbynB1Ta0800/ccPC/KXcd64vpbvoeKZrjY7wrzDvIqV
	aSTtGE2sIGcay31vFymCfbn6tcTKWZpJ4TPZv4Sy4Z9jPcZxO1vr//AI2PLv2q5Dmt5PpPPTcez
	YPRG0k
X-Google-Smtp-Source: AGHT+IFQTxQm2KjvvJxLDY2dGDkf91Cj8Cy1dMLu1zhvDLIDUuuNKnRa6GVanM7LqpTslTmMcAFeA6RM6vgs
X-Received: by 2002:a05:6102:290a:b0:5d6:df5:73a with SMTP id ada2fe7eead31-5d60df50764mr1793916137.38.1760371010047;
        Mon, 13 Oct 2025 08:56:50 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-15.dlp.protect.broadcom.com. [144.49.247.15])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-5d5fc8e3a19sm1293258137.4.2025.10.13.08.56.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Oct 2025 08:56:50 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7810af03a63so14579990b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1760371008; x=1760975808; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4TUsSNeUY9kbs3ebqI1ua2BS1zD+qEH9X1wvEGJyTqQ=;
        b=b66B9yjoSWoVtAsPgCbE86u5Wo3WjPXosu+FlSX7jhO6l05iEe4g8aOuuLvNpdMA5l
         lElETEh+qQRyDRb0PfnjqSk/Nsj38G4+QnWmmj1JSYdB/GWSD7ruPqvbylnKGBJFAZ63
         xoX9Zi3PPenz9ADGJyP6Hzhg0PKXbG3FaUCj4=
X-Forwarded-Encrypted: i=1; AJvYcCXy/dO+IWAj3NqXOJgHFMcleiyv8mpDUAw/6zT8NaSBlSkArBCR3otWQZNg8FkvhXhpo/kC5+1klL3bewI=@vger.kernel.org
X-Received: by 2002:a05:6a00:17a5:b0:77f:620f:45bd with SMTP id d2e1a72fcca58-79385324ddbmr25211157b3a.7.1760371008628;
        Mon, 13 Oct 2025 08:56:48 -0700 (PDT)
X-Received: by 2002:a05:6a00:17a5:b0:77f:620f:45bd with SMTP id d2e1a72fcca58-79385324ddbmr25211133b3a.7.1760371008255;
        Mon, 13 Oct 2025 08:56:48 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d0e275csm11992020b3a.61.2025.10.13.08.56.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 08:56:47 -0700 (PDT)
Message-ID: <15fa4419-4c1d-4082-8e57-f3030cd95334@broadcom.com>
Date: Mon, 13 Oct 2025 08:56:45 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/11] irqchip/irq-bcm7038-l1: Fix section mismatch
To: Johan Hovold <johan@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Changhuang Liang <changhuang.liang@starfivetech.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org,
 Florian Fainelli <f.fainelli@gmail.com>
References: <20251013094611.11745-1-johan@kernel.org>
 <20251013094611.11745-4-johan@kernel.org>
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
In-Reply-To: <20251013094611.11745-4-johan@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/13/25 02:46, Johan Hovold wrote:
> Platform drivers can be probed after their init sections have been
> discarded so the irqchip init callback must not live in init.
> 
> Fixes: c057c799e379 ("irqchip/irq-bcm7038-l1: Switch to IRQCHIP_PLATFORM_DRIVER")
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

