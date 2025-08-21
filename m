Return-Path: <linux-kernel+bounces-780455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A4BB30211
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 20:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83C90B62B08
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 18:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BEB4343D66;
	Thu, 21 Aug 2025 18:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H2KFGkXW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39948341AA1
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 18:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755801003; cv=none; b=ag8IqSdtiO13+18PLxb/HDxyWDbntIDmoB0Tw0LH1n3VA4H0tz9VEEeZz19mC5D0vI+kynvLQvxvZuPhqp30TmZUQiwGokSgR2OvhKNIeFInT/pGSHisv9Ag43Fw37p9BKFzhxX/7cBIq77C9EoKCdkyj+EOeF96qRN/8ZNF8Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755801003; c=relaxed/simple;
	bh=ybiNjcXgyPDUVFsLBLcWU7xqEVKtRmFUSuJNCZp1LJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KUMGaUdVX2wZLxyNGCObW8g0ShuthWG6ICrWC2KGJ+WgO8XRbo06EPS5L+gQegqqRtPwvKUTolSY5IwTs26/NCAHOkuzKPqjOkJhcHfIIKMqCWjVDGnTGJy1E6xnMNN0LMLgdmJB+HaDwY9r2u71OZ68XIIDOd+xtcbC7SQKyIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H2KFGkXW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755801001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yhECXnCIPDw3Lg4MBh/5jtv3LHZEJ/t3IMSb4dezezI=;
	b=H2KFGkXWgJAdQlpgsCOLDxGJQj0U4xbf6vsk2KTo1olge5RG6Cp6oQHvZjM01VY9UGEIqx
	tvCnIL8FcSzisrepmddLczNZr2NB+s+v6nejhuejMAlNtcO0/tzaOtfg94yz2PS8M3EGSf
	01j12HDd5efAhlKdiJ9EphTvXHbKHfU=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-4jlZhhPoOT2MMI7L0-Z6aQ-1; Thu, 21 Aug 2025 14:29:59 -0400
X-MC-Unique: 4jlZhhPoOT2MMI7L0-Z6aQ-1
X-Mimecast-MFC-AGG-ID: 4jlZhhPoOT2MMI7L0-Z6aQ_1755800999
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-70a928da763so27637556d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 11:29:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755800999; x=1756405799;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yhECXnCIPDw3Lg4MBh/5jtv3LHZEJ/t3IMSb4dezezI=;
        b=QuKDQcuO0Ak3HUaEZnBjTZ92m8vTYMLKlkcjVXickhH9WSeL2t2TuuzSRs66pf1TDd
         RdwN8Z3ov4I5cWWZq50qQd9CZKn0LYoWRMveZnjPNJWkxBD51ajIFN1N3GDRAQkDJP5U
         dANUzAxVhm8g54yfvfwW2Fwuq1bEGwhDVdSajEQBjap/5C3lYxQSV3wmPEII2sXaOdgb
         cMpy5Ldtr8JtWGxvjm7LbIGP+0Nz0uI5IlvdfKuna2bVXlwAthfxad3kqtjKp1OVOjmc
         7PADYl99funLZSjPu2J3RG0ax/qyUaxBuVDZVlvUvE2jzlr9Q+SQaKcidoPRwkvD+HQi
         /7Mw==
X-Forwarded-Encrypted: i=1; AJvYcCXzFpvRAaEcR3jrEizzc5Enns0xM68kDUUU53tDFx7M9oPHGBnprhkvjPAqkD3vRjYHAGpkMZi+V43zZ+0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv4m0Dujo+CaImOxOHVhhuEUr0sJ2mn91bIH6w6gpppZOCXWYx
	3bWibECtof9DibBX7qUvr5oXG1GkxXGn7/ZpHC1LzTjEIUpIcbLqffXQ0RZtXi9WzMrKO+swyF2
	VstS2yPG0f0pfbzQvo3XBJrD/nC/T+RJGVPaOZjeCIfFTbs0uJJ6gCmHgzjMz+IHY/Q==
X-Gm-Gg: ASbGncv4aAX8Ca3IQqXBV4G1mT8SM5Dnb7H6LyYFj0WceSzc49/zr9AP3HgKyWQEJoO
	SMyl/fVzGZNGJZbLV62E95/nsaxJ4jbsfHbX7VHujFPhd2pjK/IXjnTS7n7o4UQNI547tEJSnV2
	Nqm7qrW1EsIfzPQaWL++C7t11b/Ks9DrwajDsOHsdSKzsv97MlCqtRHtNPjHhEJXlCzFSt3BNq9
	YAFeXmirIKaVzsTse/+lMkL0R7+dUFxYouxChfbAwvs3npVyyTPKsYTleaXqYDEDww5orvoMeCu
	aGaldxBAxQ/Xol8JoFiB1yB1kuyypQ1rLVyQSIhGg3Tuci/zZrfcx/h8ks1G3qQ=
X-Received: by 2002:a05:6214:411c:b0:707:5d90:5e92 with SMTP id 6a1803df08f44-70d9712564dmr7627166d6.23.1755800998806;
        Thu, 21 Aug 2025 11:29:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHe8EN56eHT/hjQKp2x48P3siaQqYBM5dZ5CGM9Mf8D+ZZvBzIAW/a9XWvDRsldQ0ClduM2xQ==
X-Received: by 2002:a05:6214:411c:b0:707:5d90:5e92 with SMTP id 6a1803df08f44-70d9712564dmr7626826d6.23.1755800998251;
        Thu, 21 Aug 2025 11:29:58 -0700 (PDT)
Received: from x1 (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70ba9097dc4sm109917596d6.26.2025.08.21.11.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 11:29:57 -0700 (PDT)
Date: Thu, 21 Aug 2025 14:29:55 -0400
From: Brian Masney <bmasney@redhat.com>
To: Icenowy Zheng <uwu@icenowy.me>
Cc: Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Michal Wilczynski <m.wilczynski@samsung.com>,
	linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] clk: thead: support changing DPU pixel clock rate
Message-ID: <aKdlo6R3ER99klYn@x1>
References: <20250812054258.1968351-1-uwu@icenowy.me>
 <20250812054258.1968351-3-uwu@icenowy.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812054258.1968351-3-uwu@icenowy.me>
User-Agent: Mutt/2.2.14 (2025-02-20)

On Tue, Aug 12, 2025 at 01:42:56PM +0800, Icenowy Zheng wrote:
> The DPU pixel clock rate corresponds to the required dot clock of the
> display mode, so it needs to be tweakable.
> 
> Add support to change it, by adding generic divider setting code,
> arming the code to the dpu0/dpu1 clocks, and setting the pixel clock
> connected to the DPU (after a gate) to CLK_SET_RATE_PARENT to propagate
> it to the dividers.
> 
> Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> ---
>  drivers/clk/thead/clk-th1520-ap.c | 87 +++++++++++++++++++++++++++++--
>  1 file changed, 82 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/clk/thead/clk-th1520-ap.c b/drivers/clk/thead/clk-th1520-ap.c
> index 2f87c7c2c3baf..3e81f3051cd6c 100644
> --- a/drivers/clk/thead/clk-th1520-ap.c
> +++ b/drivers/clk/thead/clk-th1520-ap.c
> @@ -55,6 +55,7 @@ struct ccu_gate {
>  
>  struct ccu_div {
>  	u32			enable;
> +	u32			div_en;
>  	struct ccu_div_internal	div;
>  	struct ccu_internal	mux;
>  	struct ccu_common	common;
> @@ -198,6 +199,78 @@ static unsigned long ccu_div_recalc_rate(struct clk_hw *hw,
>  	return rate;
>  }
>  
> +static long ccu_div_round_rate(struct clk_hw *hw, unsigned long rate,
> +			       unsigned long *parent_rate)
> +{
> +	struct ccu_div *cd = hw_to_ccu_div(hw);
> +	unsigned int val;
> +
> +	if (!cd->div_en) {
> +		regmap_read(cd->common.map, cd->common.cfg0, &val);
> +		val = val >> cd->div.shift;
> +		val &= GENMASK(cd->div.width - 1, 0);
> +		return divider_ro_round_rate(hw, rate, parent_rate,
> +					     NULL, cd->div.width, cd->div.flags,
> +					     val);
> +	} else {
> +		return divider_round_rate(hw, rate, parent_rate,
> +					  NULL, cd->div.width, cd->div.flags);
> +	}
> +}

The round_rate clk op is deprecated. Please convert this over to use
determine_rate.

Brian


