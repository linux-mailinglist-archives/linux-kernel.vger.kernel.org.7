Return-Path: <linux-kernel+bounces-861603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF91BF32B6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D4F6B4FA8B0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 19:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0DF2D3A77;
	Mon, 20 Oct 2025 19:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="hx1O/UHh"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791A927B34F
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 19:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760987847; cv=none; b=jxoIf56njAnKJIktYP7Iu8FanpsUnCyaqLCx3RD1v1OCkI3OU7ZfhDkksTSo/qxX4ihQ+vtAEF9Vmf4SSfJ6QBfn4aoB461YuQ4P69zG/xiPDAPjzsIn3neJP//YTrZv4hsEsTKm5sU8P+9+I4+u4kepoN+u/59remsiA4ObTX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760987847; c=relaxed/simple;
	bh=8xDpo92mB5twoWrjolGZwTuSzwa3UBDnu8dKD9TvmDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h6ni43u6J5rHhh7mzH6wRv9rG3QBPbogfBoghmne+YzdBiJy55pqlvqJ3qArbZlBYHKVQ0saDAJCpgsh8zdo2RWzz0G5QxQmcMbnvh28jhMtlVevyvweYT+soRwNhTywXuJRgYnzu2bP1v+0XXBAEGFfk4WSio8OkIVTj+xbhj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=hx1O/UHh; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4712c6d9495so2236995e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 12:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1760987843; x=1761592643; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gNuJNEa8H6a1Hi9ZFQNvUrGKVUMBUcGXXY/Ad9QcmGg=;
        b=hx1O/UHhdHaCqyHnoPF0vrM3A+jdbmEVTPp+J+n1k3E2CLh0Vpvb2Wof1dk5OsZFIX
         rWDIyThyzIF0Acbkrn+R2M1ztnmzF6cETiV4aueNhxrUdh0twyjMNymZ/Cc4/8hzs7VK
         Ix5G6RwBJa1JeKMU55CG4qLLmQBx6Wftkn1GZyfAGzCX/14zdkczle0wxpTbIbbCVOah
         Lmm6saWGdmomPdwd/uuifP5hUUvqqkQLEi7fatptfNYkk3DiGJIz4erg/Yq7GjLKbto6
         uohf5ArRS1qvufeDgipgfcyA6aP2XhD8tR3ecf/HEtgH3aJKW4JgFyT+HSNSubmJePTY
         FZiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760987843; x=1761592643;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gNuJNEa8H6a1Hi9ZFQNvUrGKVUMBUcGXXY/Ad9QcmGg=;
        b=ewNzVsHSan3hlIS0GkqndhtKBdfo78UZqF1o7rDt++WdIV/M/THAzfY71DZcr4/PQD
         wnqEoKxvZxqSht3B4NWRd6V/O31LtOhbM9hnL7wpawzzQJdHUmfZzvcbQlVOc3oN2832
         6BE2S8aJa7WI4Ia2i9EMhwmpYjM42sSM5QrIfkB4O62ryP8JFViaLZDzakaVIcLLA2du
         LJqG9UN3UnrsmL3rUI84+mcMBjoJjU7yWFkAaVBf9ea4pxl8/Uv2BJKp1YMpqBaFDmsJ
         36OzAn7y8QidBT4UBNXFe3QastmQYV+OG8hvlGqXIh7Jg/h4+SYOO9p+zi/I3rhFwhb0
         sRtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWS9dRrlxAL7fB5Wizk9A2fCE7nc6K8omCFYmmgnCfD2P3YNOhl1ni/JhISj5Df+qJ1WZROQ+s5CnN6tUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNzlOaOTDHnGb6Qh528dZUrazLYEFhGLa39+pDZxp0gzAhAL/p
	Ph+cjPka8yMUK/+ejxlpZ6oPVu0JA7FmTGpOn+xvKFft0pmwBcM+G2n9fiEalQITcZQ=
X-Gm-Gg: ASbGncuq6W41NHx6xms2tYMqwatBxvpoumN+QofMIZzuRs+h/6xpgUbnIyP5oKTWXcL
	MoDQPcl5OSNgeA3qVNKzNGzY9f7e4WkgLwF8UOmMsyUONp5/JTewrR7cnMeZ0VZzNUXkC3A0Jub
	Q4kuU6XGqNFWiJYFM6qWBx+K2WO9LHUNSRrp8WrKkqWHp5ZxlidY6+O+NbP9xwhF8SBKx4zQ3EW
	+Cc3p9FHhnARjR39MDVurHQrzOFswVWmpEYUiQaEwye3/CGQkqawh9JRn8OWvTBFkicq+4qPqBj
	FyCxMnaueXf21JrxWmZ2RHAguLf74Myl1wzFcFLwAU54ClgjYgW38BcjQjcaRikLJNy5TkcDVD+
	qU/ivAKI+sWQCgq+DeCiPIq8PuQOikCL2nyrBuHHx3hxA9jM67KVU0XQbbVGS3JKtvNyzoMQe6q
	O3ULpphkdafEx3L4VXdtI=
X-Google-Smtp-Source: AGHT+IESk1yhEUcjFDijdAA3soTez4joNNS0ROTIat4Ft5zVYJZ3e548G/BmPG8k76dQyy5/TyttJA==
X-Received: by 2002:a05:600c:470d:b0:471:12c2:2025 with SMTP id 5b1f17b1804b1-471179140abmr122949465e9.32.1760987843277;
        Mon, 20 Oct 2025 12:17:23 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.151])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47152959b55sm163583265e9.6.2025.10.20.12.17.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 12:17:22 -0700 (PDT)
Message-ID: <27aab227-01e3-4074-8aab-38623b4d9808@tuxon.dev>
Date: Mon, 20 Oct 2025 22:17:21 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/31] clk: at91: clk-usb: add support for
 clk_parent_data
To: Ryan.Wanner@microchip.com, mturquette@baylibre.com, sboyd@kernel.org,
 alexandre.belloni@bootlin.com, nicolas.ferre@microchip.com
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, varshini.rajendran@microchip.com
References: <cover.1758226719.git.Ryan.Wanner@microchip.com>
 <6979b3734462c97381159f3968a3f22b6193e04d.1758226719.git.Ryan.Wanner@microchip.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <6979b3734462c97381159f3968a3f22b6193e04d.1758226719.git.Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Ryan,

On 9/19/25 00:15, Ryan.Wanner@microchip.com wrote:
> From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> 
> Add support for clk_parent_data in usb clock driver.
> 
> All the SoC based drivers that rely on clk-usb were adapted
> to the new API change. The switch itself for SoCs will be done
> in subsequent patches.
> 
> Remove the use of __clk_get_hw() for the slow clocks.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> [ryan.wanner@microchip: Add SAMA7D65 and SAM9X75 SoCs to the changes.
> Change how the main_xtal and slcks are initialized so they match the
> parent_data API]
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
>  drivers/clk/at91/at91rm9200.c  |  2 +-
>  drivers/clk/at91/at91sam9260.c |  2 +-
>  drivers/clk/at91/at91sam9g45.c |  2 +-
>  drivers/clk/at91/at91sam9n12.c |  2 +-
>  drivers/clk/at91/at91sam9x5.c  |  2 +-
>  drivers/clk/at91/clk-usb.c     | 41 ++++++++++++++++++++++------------
>  drivers/clk/at91/dt-compat.c   |  6 ++---
>  drivers/clk/at91/pmc.h         | 11 +++++----
>  drivers/clk/at91/sam9x60.c     |  2 +-
>  drivers/clk/at91/sam9x7.c      | 21 +++++++++--------
>  drivers/clk/at91/sama5d2.c     |  2 +-
>  drivers/clk/at91/sama5d3.c     |  2 +-
>  drivers/clk/at91/sama5d4.c     |  2 +-
>  drivers/clk/at91/sama7d65.c    | 24 +++++++++++---------
>  14 files changed, 72 insertions(+), 49 deletions(-)
> 

[ ... ]

> @@ -882,10 +885,10 @@ static void __init sam9x7_pmc_setup(struct device_node *np)
>  
>  	sam9x7_pmc->chws[PMC_MCK] = hw;
>  
> -	parent_names[0] = "plla_divpmcck";
> -	parent_names[1] = "upll_divpmcck";
> -	parent_names[2] = "main_osc";
> -	usbck_hw = sam9x60_clk_register_usb(regmap, "usbck", parent_names, 3);
> +	parent_data[0] = AT91_CLK_PD_HW(sam9x7_plls[PLL_ID_PLLA][PLL_COMPID_DIV0].hw);
> +	parent_data[1] = AT91_CLK_PD_HW(sam9x7_plls[PLL_ID_UPLL][PLL_COMPID_DIV0].hw);
> +	parent_data[2] = AT91_CLK_PD_HW(main_osc_hw);
> +	usbck_hw = sam9x60_clk_register_usb(regmap, "usbck", NULL, parent_data, 3);

sam9x60_clk_register_usb() could be converted to use parent_hws member of
struct clk_init_data instead of parent_data.


