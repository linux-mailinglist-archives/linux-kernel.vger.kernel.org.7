Return-Path: <linux-kernel+bounces-736756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9329B0A172
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 13:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B0971693CC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 11:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE092BDC11;
	Fri, 18 Jul 2025 11:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="VPZjAuiC"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDD02376F7
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 11:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752836427; cv=none; b=FxfpylpTuFGzMVDIXragcEIIaSFSQga2qV6DSvkAzJ1Mm52Hsr7t06+d3wtcfmVahwveB73Mf35gPxL7F/iV/tkLPdBQEuHDvbYqekXEdnLBGbDCl0jflLY2evrQuiAmy+6mux4cr/9gVnRA+pjT/YhrQuTN4Oy/C1jNobNqQL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752836427; c=relaxed/simple;
	bh=QshWU78gg8gxdee5BtQnCbEaY6Tmctropapxb3/nbNQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kQcDPLtF/V0F04S/WY2QuaBuZQtBmHoTmM957ydd2RYI+ESfY8Sd+S4yv94/gl4Tuht0LTG4AH/2NYYTvPa3zrsiloCKGsSzYDxy+WnQo8hztAp1sMejD/6zVpH5pb6lILk9NLBLx9g8vRv8yZiHChP+fh/EtExqDGVPWLYGELg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=VPZjAuiC; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-60c9d8a169bso3415420a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 04:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1752836423; x=1753441223; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8G9viKp190Snv9/y4e9WNoJDJ/21KIBMuhohTjZv+R8=;
        b=VPZjAuiCRDQlyRZXUbdEEgMkAx5+kvoVXSSkuu5glSS53EFs40C1HE/ejxlVaAFtAZ
         unrnZOdLNWlPwWdARAxip2qPmmeTfAEwsqresnVKND+NazfMPVsVTWdnX+zxlB390ivo
         pSu1na3DUHlh2eHQtZ79blm2qo1Nm59CkEqEJvxdqNBjupm5B6yuahdIXKnadPWWTuUL
         lTpM7/wJucUe7U8qhJMIdDCINh2gXnPEY5spnjCS186c0HC44UMJipjj6HTa7TucSfSK
         8QCABujtK8GVluGDcIC0vhJmwnDQfhn6Tk/PAsuJL6xWNi6gWxLLy1Zsi/yetlioBARl
         nWFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752836423; x=1753441223;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8G9viKp190Snv9/y4e9WNoJDJ/21KIBMuhohTjZv+R8=;
        b=vagQ5M3w/hDTE+yYjuAbeaagK/xwoyIT+WbLV1RHbgBmXH9DDuFwVFOcTss0vLrC0Y
         BnopVvD3jS20DwGURTNWtjtS058V5FUZH2Rnyaqa+I5qIwjla73SiE9h9N0znIrumzF5
         X6TsqwoAeWsARYS40RmV1qp7laJY0Ac5cirY+LF2UVRgPzk+AAdtnShaCQHiOvtDAPGW
         DsqQbvtkyuAxOjWyz1MRhYUtSDGpsnZEGfmpFna7MFqkEhMHK1Q1+xSC7VyrCGAl707b
         oPom0F3eUoYsOH1t01qwbME9MiV7KHzPhUtY5Tu7jRP3fdmOjFS5H6KVmZdkLHAfaQhA
         HcVg==
X-Forwarded-Encrypted: i=1; AJvYcCV4D7EEmQ6ZFb8t6X6m4QZ4XusDevnpMBWbvrinklwDbVgW6DjuUXZgSjAbBoC8WizDhSO+oQqdo4BBRj8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIhAUeU6TMsuBgchKqWWZJKJrfe4ksTQ+Wsr3kazH2iB7iclbM
	lhVkAf0KL8G0FrDGrhyxhKuqbsPIj6iWTZoxQWuVkFd3rS7hbNjzaNe1zguNBdGnAC8=
X-Gm-Gg: ASbGncv+sFO8ALtUjcLrp6WWS4h/hKZqPCoNUOQxprNEwXBjCco60AFTNXXZ95symIi
	9w3m0DVqPDB290/TqgPwj4jcwzt2briWkvNwzOIXHryQQ8/oCoa7CZZqORiS8TiWo1Ugv/Pn0QG
	HHSy0dWAcCES7mJ2VA8yGQm7/vjbPfp7ce6T7x9jB5Y1C70wU5fnLzrYXTjMFH14gcGon7rO8z2
	TZTcLC42voLM8ck3ghiYYPlW9X42Sy/aSHz0OWLfolgnGpW50c+6u/1fE44wpUru1EU6bhltZFJ
	NnxLMq8qHgWJJekS2Ugqg0o0h6DW8Nj9b33nR/CskH86Xzb6645vWDqB67TmKgZYm6FmjyL7/aS
	xxSSTJz+FvQIL577XME+8Djp/iQK7fg==
X-Google-Smtp-Source: AGHT+IEWR5nv/oQJzwgF0qcajAF2Z8LBQapmjvceGu3HRHJPS7XWZrDCVWw4hyx2KUGl8xQpn1ru3A==
X-Received: by 2002:a17:907:c5cd:b0:ae3:6744:3661 with SMTP id a640c23a62f3a-ae9ce10c4f9mr786897166b.44.1752836422360;
        Fri, 18 Jul 2025 04:00:22 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c79c6a7sm101144766b.26.2025.07.18.04.00.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 04:00:21 -0700 (PDT)
Message-ID: <fe20bc48-8532-441d-bc40-e80dd6d30ee0@tuxon.dev>
Date: Fri, 18 Jul 2025 14:00:20 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] net: cadence: macb: sama7g5_emac: Remove USARIO
 CLKEN flag
To: Ryan.Wanner@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <cover.1752510727.git.Ryan.Wanner@microchip.com>
 <1e7a8c324526f631f279925aa8a6aa937d55c796.1752510727.git.Ryan.Wanner@microchip.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <1e7a8c324526f631f279925aa8a6aa937d55c796.1752510727.git.Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Ryan,

On 14.07.2025 19:37, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> Remove USARIO_CLKEN flag since this is now a device tree argument and

s/USARIO_CLKEN/USRIO_HAS_CLKEN here and in title as well.

> not fixed to the SoC.
> 
> This will instead be selected by the "cdns,refclk-ext"
> device tree property.
> 
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
>  drivers/net/ethernet/cadence/macb_main.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index 51667263c01d..cd54e4065690 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -5113,8 +5113,7 @@ static const struct macb_config sama7g5_gem_config = {
>  
>  static const struct macb_config sama7g5_emac_config = {
>  	.caps = MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII |
> -		MACB_CAPS_USRIO_HAS_CLKEN | MACB_CAPS_MIIONRGMII |

Will old DTBs still work with new kernels with this change?

Thank you,
Claudiu

> -		MACB_CAPS_GEM_HAS_PTP,
> +		MACB_CAPS_MIIONRGMII | MACB_CAPS_GEM_HAS_PTP,
>  	.dma_burst_length = 16,
>  	.clk_init = macb_clk_init,
>  	.init = macb_init,


