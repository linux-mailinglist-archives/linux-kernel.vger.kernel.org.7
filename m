Return-Path: <linux-kernel+bounces-850983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E096BD532C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2D1AB561D53
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050E5310650;
	Mon, 13 Oct 2025 15:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HLELEBKy"
Received: from mail-qv1-f100.google.com (mail-qv1-f100.google.com [209.85.219.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB0731065D
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 15:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760371028; cv=none; b=gvgqJw/9ywwGlGXqnCFr/dEfoC0mHErFAzIBnKFiQ2hHs8c4FZFrWJ+NaPZrvshR8hNWCygx1qkKU7A5Ziqc/fzV3wifT+YYR4XcZvWgMwJUsf+xvCvYZB4mhkEItalwohlVA44rFlV7ea7Rg55CK0kfE9WdzmgF1TlIdABrUvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760371028; c=relaxed/simple;
	bh=YqXalc0GiLn5NwUzE0OPVdriL8vVonsJAB2+jCa6i3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VeXjaQLOTl+ORsaMzFVCuIcrWLIInHC6D4qj4zDej8qdemgMHzurPSmN+K3FK0yxTtaymwjOWvFiRfExYDSSV8g5g+oQoqjwPU1MlF4PsDVeiDXEMAXo9hwCwHWQOB4rF0i1XP+m7QFQbHy80LI1uke7LxEjyzo7vXUDxCxp/+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=HLELEBKy; arc=none smtp.client-ip=209.85.219.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f100.google.com with SMTP id 6a1803df08f44-80ff41475cdso89785396d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:57:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760371024; x=1760975824;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8TFuvLKu4ynjIvMufArSQE1PDlrrioAZvFwM7LRBZGw=;
        b=a6qJZ7Tx8GHdhYf4vaYpPrt8jHk4eVygmv2AJ/xLLxZ1VY8rtMpmZIhvnB7G6buAM+
         AV498ebadGx39dA7/VQihko2AqrtDxOjmTxTU799OknIAJ9iyHC1D9fcYe1lVS6re4bo
         NiQQN4gfgQf9wvBfVn8BbShZbXT1bH3p16iHU1Ed8PFfzh+tkazJICSVUIjDurkyvva+
         Wg/gqj3A2KkrNflKzEGiBTzCd8mFJmkisPrqA4CAgpp/Nn/uE4oTHTwh+cH+wrh604hT
         ZOZZiJRxGVv1kDiv4FV8GCEA5/dNlUwseAm6LiIIiljEAmIyFMVtgb8FkfdIT43Epcfo
         PBlA==
X-Forwarded-Encrypted: i=1; AJvYcCVUcya1UHn838onDai6PI6yEaFj6mzNABaMg7HjZ/KWBhHJnsm+jexXwqH4cA5cG0MexYOZJotJab5WwTw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwsp6znUNF6qFnvcoz9D/6xHubfp7rfL7NWzvAHyYwUJ9YYqv7
	e5l7ukxB4dVjE9Na3fsYtNPcMW4oINB7FGdbo2gsjXSgtAyUYDPJMiXVsf9hS+fU/OzPpp9v2Wn
	N3g/PPSN5tlQCqHmE9EuYZ4AufP9jEdVlU8b9vcackw4Vmse9uMV14Z0MS/CpuRrQUZI9Tt3ym6
	TuY2b3YPo0w47TcCzidJBxnXl/K76NPsWn0U62LTy1e7+x7YF8zXXKv8NWpnazRyvKc2v50NWbB
	8TOkBAJ9rrWm1amIOGayFVn
X-Gm-Gg: ASbGncuL0UTVmNyQj1LYLZUKD4MMvUlqZoEXw+oJQOQavEQmxCQSwE9iChD7/cqtHQA
	fDy1j1GSa2UPJyGN1blGBAtl1NMZm2wBkAX+z7+MNdJMyAnpLAE3Ug0dT5dd6VD/4YtVePHberD
	hV6uIkLbjG9jB1JyS5uPVpt/Ec4xj0THB++bE3xvtySaFO7zue/z+A0XaF+v1Sbr3h1kCbNg0Ri
	1A0xbnphqCRu/8s4FrJDei1PO2ySmNN8rVpKSDh+vOPgWupw5Wg2zhiTqhL+3Ik/e3A6NOTMjz+
	xHInd7qlogv+CZQxPY46vGiOHN9IytCHhYWxySGidVH5StUnYJtstlEqm+z8SuUTOP5d3A5cK3n
	bT/Cqvko/JlLR8jk7tVvJpSHjfs22X578KxcAlQFau+IM3ZrHHYsuPaJCdnfsks2d2kqPjpRhkq
	KPoSNU
X-Google-Smtp-Source: AGHT+IFmgQMG+zOtbv5MjisjZCotLEQHaFrUaAiLwqwo5iRgV3ZRXAH6xXSBFgPmBTnEie1Qyc0pl56xLmWu
X-Received: by 2002:a05:6214:2405:b0:796:268e:74eb with SMTP id 6a1803df08f44-87b21000fd3mr261500666d6.6.1760371024515;
        Mon, 13 Oct 2025 08:57:04 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-15.dlp.protect.broadcom.com. [144.49.247.15])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-87bc3461604sm8744256d6.15.2025.10.13.08.57.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Oct 2025 08:57:04 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3352a336ee1so17584230a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1760371023; x=1760975823; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8TFuvLKu4ynjIvMufArSQE1PDlrrioAZvFwM7LRBZGw=;
        b=HLELEBKy5joUGQVrMro8M2RGoDlsc6cK96XI+HwYHbU5mQNYVG20W0zc/IFz45QbYH
         GZRjH0B5Q5Tgtvp99LP9uLxgvGR+XHAkGSvnNLtwTdzIVQkjhZ77x5iOMrfdUqbaNWS3
         aoJoB8E/SIUxn5fxC6GGYmDZ2ck0SbNX9xgZk=
X-Forwarded-Encrypted: i=1; AJvYcCVOfYSslPgqDKZqkXy13Sf4NOdvXkHGL3pvdzBbIIr8FB77spg1XNwdfMIlgScLk+0opberPHWoDpQY8h4=@vger.kernel.org
X-Received: by 2002:a17:90b:33c2:b0:32d:90c7:c63b with SMTP id 98e67ed59e1d1-33b513862d9mr31366217a91.30.1760371023243;
        Mon, 13 Oct 2025 08:57:03 -0700 (PDT)
X-Received: by 2002:a17:90b:33c2:b0:32d:90c7:c63b with SMTP id 98e67ed59e1d1-33b513862d9mr31366182a91.30.1760371022815;
        Mon, 13 Oct 2025 08:57:02 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b626ec2f9sm12358432a91.25.2025.10.13.08.57.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 08:57:01 -0700 (PDT)
Message-ID: <7329db14-43c6-4ffd-bbdf-a5870ea895e4@broadcom.com>
Date: Mon, 13 Oct 2025 08:57:00 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] irqchip/irq-bcm7120-l2: Fix section mismatch
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
 <20251013094611.11745-5-johan@kernel.org>
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
In-Reply-To: <20251013094611.11745-5-johan@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/13/25 02:46, Johan Hovold wrote:
> Platform drivers can be probed after their init sections have been
> discarded so the irqchip init callbacks must not live in init.
> 
> Fixes: 3ac268d5ed22 ("irqchip/irq-bcm7120-l2: Switch to IRQCHIP_PLATFORM_DRIVER")
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

