Return-Path: <linux-kernel+bounces-790485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF58B3A855
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 19:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9417E18957C0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 17:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944F03375BC;
	Thu, 28 Aug 2025 17:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iPUqdSib"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608D621B9F1
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 17:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756402699; cv=none; b=E+0Q+8nK8M/FlzXeOnw9RnLOcROtvDv4Ept19bqyu7wi+LrfXOD0q+Csncaf/9DHDdHi0GulT03zFFPI4wfZUglWP4VrQdXhR3JSo7xFFrFF+9IRW3k2+tzAiHaVQR26H/+Y6g+D5CT+8l72SScKlcYDxUGw9qNZzBBnHbTUniE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756402699; c=relaxed/simple;
	bh=SNXhCWfAZBtgC6ZU2ndzFpAUbXp6YJbSyN/+bro18TM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nTXmwJjkEsmPP2CXjlb4tPotWnu2USBXGXmfXvly4Qct5evYdfWePN4nzqtjBMAX/MES2svbGztkTSbUY7RtOCP6lDBpPs9i596oGhlouP+9/xIkK+UUOOiUH+NWvYDQzX7QCIaRD54iWhdaFmzUO0NBPq7rMkUrwVjNVOnIbq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iPUqdSib; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756402697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K6p2tt16Ex86fLCzx2c9aJ/wVLkuf0FjhhNKWXNuhhU=;
	b=iPUqdSibglKYt8sO0mKT7KnL8E7tPFJhbtIit0Z7wTrAyMVT+Pa1ijeyRl/WG8cjwcnSDH
	cSec420KMiz2MxdDHmrZOu4fAnHepwZZ968ZVBhkhf+CaFL8zZKSO8U/hklsq7ZqFgG9wS
	PL2H00I73bKvaCVHYmsgcPX0t7YxDOc=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-VguEAYxmPlGhMKZodmjXGg-1; Thu, 28 Aug 2025 13:38:15 -0400
X-MC-Unique: VguEAYxmPlGhMKZodmjXGg-1
X-Mimecast-MFC-AGG-ID: VguEAYxmPlGhMKZodmjXGg_1756402695
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70dd6d25609so32545516d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 10:38:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756402695; x=1757007495;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K6p2tt16Ex86fLCzx2c9aJ/wVLkuf0FjhhNKWXNuhhU=;
        b=AEAjw3Y42+spnquEfPdIzownTclD3rCbk9Wq0h31zCBtrzFosqbwjm3HlCgieQqk18
         rg3eBxNu8OljBE9kEDHLu5zZWxQHx9I1XgLoSLntxyK1mlc4D7zMnBuxMcQxv2j7lTp9
         uiHqeCWvLfZMae5zpspUyZfEXhw2AbmTpq+0y+QKuzMlxoGa7InFYS+WgdsZhMpPftvl
         a2i2xBwI67RGaphsjRbVGPkZ4Kr7ys/YA5K9Ognk7xS627fHhtaOgkqRdVI/dJrUUn6y
         gsfEqeu/OZQqyFOjwHmMImluvnX35hOqYnLx5Km8rDujDcjrmshQU5rqI2GHpQZK1eeN
         hc6g==
X-Forwarded-Encrypted: i=1; AJvYcCVf4yv0xw9pnGlm0yKIkVl4mVFT3MpHnx9JC/1imqpcYHKI9V0q46uGHrpP+BkOfhHWi4eR9cspGtc3SQA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSOhey6/Cvcdgr2Pcai8FEEBECFVwm7Q/EgErJdqR7J39NopUG
	uLrvLKeLlmsrwRM9/fZfgbjSkKxY2YkYmwQxo5sPyEfRRSBOxeUEUj2Jm9mcfGhpujGo6h+NbJQ
	1A57wzlgil7HMYrCiAhtueS8WB1Ngg6jtlZiJrkeWytRnFDlzqIeFKXIsKAYQbIY5Eg==
X-Gm-Gg: ASbGncvy19mX1Eh1Wpbnh8SCFyzZ30oJhpeaPnjuQyGRnON2mr5y2b0Jb0M3W++HXdy
	LUgkboKxscp/KOMq165vCeXn7lLp1RDLi52znod3EtHpRDCojboGrrYYgwQEAAAZto1H6IdwtjB
	dTqJvFKvwKOw9n9TucPCepRrKzF+xUEsiqfmL2Xzp7YXkEK4tIg87PsE8XeWW1eV1wVjuEqiJhq
	2qTzYY90IqZKVxIXyH9W6rVNAWkzAN1PBcGOH5A+W2wcI3JTYKWOVXkx+xcZYH+OYe8+GZy2kbB
	mzMHWUjJ8ZMQ6BnXOO8TKHFq+KDqVPefPwP7awCfPiPB0D9ZKBzSUj1szNzpb+WoY1rjYspIp8T
	v/1/055YDdzuGeAsYz9A=
X-Received: by 2002:a05:6214:c65:b0:707:4539:5183 with SMTP id 6a1803df08f44-70d970980e6mr246817966d6.5.1756402695122;
        Thu, 28 Aug 2025 10:38:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFolBQi5Yqb+JsBG1B+iQ0UbKTmrqVThPcyhvOhG9tT6SqvRRRfRTx8LsjupRZvAV5rgEeAWg==
X-Received: by 2002:a05:6214:c65:b0:707:4539:5183 with SMTP id 6a1803df08f44-70d970980e6mr246817666d6.5.1756402694644;
        Thu, 28 Aug 2025 10:38:14 -0700 (PDT)
Received: from x1 (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70da72cbff7sm108739796d6.62.2025.08.28.10.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 10:38:14 -0700 (PDT)
Date: Thu, 28 Aug 2025 13:38:12 -0400
From: Brian Masney <bmasney@redhat.com>
To: Ryan.Wanner@microchip.com
Cc: mturquette@baylibre.com, sboyd@kernel.org, nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
	varshini.rajendran@microchip.com, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	robh@kernel.org
Subject: Re: [PATCH v3 03/32] clk: at91: sam9x75: switch to parent_hw and
 parent_data
Message-ID: <aLCUBDXzZm8LukL9@x1>
References: <cover.1752176711.git.Ryan.Wanner@microchip.com>
 <b39fdf4c800103e4fd3fe2ace2c295f635a59d0f.1752176711.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b39fdf4c800103e4fd3fe2ace2c295f635a59d0f.1752176711.git.Ryan.Wanner@microchip.com>
User-Agent: Mutt/2.2.14 (2025-02-20)

On Thu, Jul 10, 2025 at 01:06:56PM -0700, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> Switch SAM9X75 clocks to use parent_hw and parent_data. Having
> parent_hw instead of parent names improves to clock registration
> speed and re-parenting.
> 
> The USBCLK will be updated in subsequent patches that update the clock
> registration functions to use parent_hw and parent_data.
> 
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
>  drivers/clk/at91/sam9x7.c | 308 +++++++++++++++++++++-----------------
>  1 file changed, 173 insertions(+), 135 deletions(-)
> 
> diff --git a/drivers/clk/at91/sam9x7.c b/drivers/clk/at91/sam9x7.c
> index cbb8b220f16b..31184e11165a 100644
> --- a/drivers/clk/at91/sam9x7.c
> +++ b/drivers/clk/at91/sam9x7.c
> +		[PLL_COMPID_DIV1] = {
> +			.n = "plla_div2pmcck",
> +			.p = SAM9X7_PLL_PARENT_FRACCK,
> +			.l = &plladiv2_divpmc_layout,
> +			/*
> +			 * This may feed critical parts of the system like timers.
> +			 * It should not be disabled.
> +			 */
> +			.f = CLK_IS_CRITICAL | CLK_SET_RATE_GATE,
> +			.c = &plladiv2_characteristics,
> +			.eid = PMC_PLLADIV2,
> +			.t = PLL_TYPE_DIV,
> +		},

[snip]

> -	[PLL_ID_PLLA_DIV2] = {
> -		{
> -			.n = "plla_div2pmcck",
> -			.p = "plla_fracck",
> -			.l = &plladiv2_divpmc_layout,
> -			/*
> -			 * This may feed critical parts of the system like timers.
> -			 * It should not be disabled.
> -			 */
> -			.f = CLK_IS_CRITICAL | CLK_SET_RATE_GATE,
> -			.c = &plladiv2_characteristics,
> -			.eid = PMC_PLLADIV2,
> -			.t = PLL_TYPE_DIV,
> -		},
> -	},

Should the div2 to div1 rename be mentioned in the commit log?

> @@ -710,32 +738,24 @@ static const struct {
>  static void __init sam9x7_pmc_setup(struct device_node *np)
>  {
>  	struct clk_range range = CLK_RANGE(0, 0);
> -	const char *td_slck_name, *md_slck_name, *mainxtal_name;
> +	const char *main_xtal_name = "main_xtal";
>  	struct pmc_data *sam9x7_pmc;
>  	const char *parent_names[9];
>  	void **clk_mux_buffer = NULL;
>  	int clk_mux_buffer_size = 0;
> -	struct clk_hw *main_osc_hw;
>  	struct regmap *regmap;
> -	struct clk_hw *hw;
> +	struct clk_hw *hw, *main_rc_hw, *main_osc_hw, *main_xtal_hw;
> +	struct clk_hw *td_slck_hw, *md_slck_hw, *usbck_hw;
> +	static struct clk_parent_data parent_data;
> +	struct clk_hw *parent_hws[9];
>  	int i, j;
>  
> -	i = of_property_match_string(np, "clock-names", "td_slck");
> -	if (i < 0)
> -		return;
> -
> -	td_slck_name = of_clk_get_parent_name(np, i);
> -
> -	i = of_property_match_string(np, "clock-names", "md_slck");
> -	if (i < 0)
> -		return;
> -
> -	md_slck_name = of_clk_get_parent_name(np, i);
> +	td_slck_hw = __clk_get_hw(of_clk_get_by_name(np, "td_slck"));
> +	md_slck_hw = __clk_get_hw(of_clk_get_by_name(np, "md_slck"));
> +	main_xtal_hw = __clk_get_hw(of_clk_get_by_name(np, main_xtal_name));

Based on Stephen's comment on your earlier series, I think it would be
worthwhile to call out that these __clk_get_hw() calls will be removed
in later patches in this series. I know you do in the next patch.

Everything else in this patch looks good to me.

Brian


