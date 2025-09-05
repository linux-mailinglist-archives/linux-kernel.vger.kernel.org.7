Return-Path: <linux-kernel+bounces-803840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1071CB4660A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 23:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D64E41889ADF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 21:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A1E2FF66E;
	Fri,  5 Sep 2025 21:40:08 +0000 (UTC)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED9B30749E
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 21:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757108408; cv=none; b=aU6WwD2L7DvEHsECU4xPFE2duYJ4vcpfW2bNI7WFlTEGW29FcC9jecPldqisH9V042IqeelXm3dqlZozYxe/f8jsafM4y0lznzp9nmS4nz7Okcna9AXIZ9zd5IBAS5h+PoMfuPsI5+pQQQQvB7bdNyFQfBofYSHKv+U8KzyHYaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757108408; c=relaxed/simple;
	bh=EuwPVtHyZtk0Y1lc41SsIpHNM6KNvdVwwJODJaVH/gM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pkzjmKiR9kgBsKbbrBRcMbj1xz0n3Xr+FZQYl0Wm3bSnzokEOBtlCPypBbDBzlUoGhsQ5mwhqt8Jn3UUWPTti5XJPSgj1L8WBTDcjXnbbNrNzrLPu39n40C871SHiLr1uzVPFwSxpW206PGafSC0U1p7uxEyg47kIma1Zq/zAiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=baylibre.com; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2518a38e7e4so118805ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 14:40:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757108406; x=1757713206;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xirptwLPscOOrD6MjERvQR7+JKo3MLBeTIYrgAFmkYE=;
        b=GyRt6ErXhTOGaCI8CgEL2GP864mG9xRXHkKGCNErtbrz7AiFsQOJ7NKcrti29FyDGj
         LBifCowljnWw1bw96XQvhBEOETvgiM023rpDsg7OdpFKIUjH632UBmvwoX796UWENKxf
         WSrY1sm7PavtXGOvXe1Lo1Q/T2XkwYTG7yLs1MsWBnjWKTUDPBpXT5E7F6SxyDNRtT7f
         STkcE/D9RLSJn5VWpk09naOQuzmkzEwP9p5RDH/ttvuLT07CQtFDkX7cvLHqCZHsGEhJ
         2AydZjUXE5k24fy20iTjMndYbgHsvJ2CkyS3hdN/2RsWP5eZfzjKhrkmq0P4wbDMf5mr
         /L1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWwoilreJqfi5o60AtKoJwbS3BQ9Zu341xEKnLY9QTpCHCK3b5c7G+HYPPCdPdoyhgXr0E/Du5cpLvIXkk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz/m7xrGBRKKD4mptRykVrnbEsOJMYa53ZEfmy5nzyP9FIMcUe
	loc5KwiTOh1603vTH20ClSbdP/AUr+aDpP70ze39JVeOyrLx0LS+lQ+Q5xmWnhXF+kI=
X-Gm-Gg: ASbGncsBccxUJ62cXfIZtq1zifLqxrg1KmUh4bpY985n4pfMzv6qxQ51TrYkltG75Pb
	sfU0OhfL7N9hYp3z5b5k+SNVJj/w0nkgh6L0JqiM2AUqPnNwv4e/UrG1z1sfycVBr2EW1xDGuaI
	v+LQvDk4ctnzgNQsWSOx0rCoC1GLmg0JF2/n3rBuLWaLPpZSz3IEWCQEGMceKGU4X2DkGLejT2f
	VsqOLddElnrPJOYXlQLniceWIGds9reWuHypqhQqOksPqxi+i5v5YCfOjNrryiFnx4WhnRhRSHT
	jkqJUZ5XUgS2vQObI7eWJTBfo5dlIxiQ8iZr0quDFL7UpSK10pUogxmIJcqB4y5PnJdK/SAEeX5
	n1SDkbbN6XFxJKaANgoa5
X-Google-Smtp-Source: AGHT+IFw9MwANXAgB0eCLMrfpT9FSIah/S2jHqgdaTFzPWLL5Scc72YKTjtxBqxKZTvx50aR9gsoUA==
X-Received: by 2002:a17:903:1c2:b0:24c:affd:6f00 with SMTP id d9443c01a7336-24cef52790fmr57400485ad.14.1757108405639;
        Fri, 05 Sep 2025 14:40:05 -0700 (PDT)
Received: from localhost ([71.212.208.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24c9df827besm74488265ad.152.2025.09.05.14.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 14:40:05 -0700 (PDT)
From: Kevin Hilman <khilman@kernel.org>
To: Alexander Stein <alexander.stein@ew.tq-group.com>, Tero Kristo
 <kristo@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Stephen
 Boyd <sboyd@kernel.org>
Cc: Matthias Schiffer <matthias.schiffer@tq-group.com>,
 linux-omap@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alexander Stein
 <alexander.stein@ew.tq-group.com>
Subject: Re: [PATCH 1/1] clk: ti: am33xx: keep WKUP_DEBUGSS_CLKCTRL enabled
In-Reply-To: <20250825140812.2222185-1-alexander.stein@ew.tq-group.com>
References: <20250825140812.2222185-1-alexander.stein@ew.tq-group.com>
Date: Fri, 05 Sep 2025 14:40:04 -0700
Message-ID: <7hms78a897.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alexander Stein <alexander.stein@ew.tq-group.com> writes:

> From: Matthias Schiffer <matthias.schiffer@tq-group.com>
>
> As described in AM335x Errata Advisory 1.0.42, WKUP_DEBUGSS_CLKCTRL
> can't be disabled - the clock module will just be stuck in transitioning
> state forever, resulting in the following warning message after the wait
> loop times out:
>
>     l3-aon-clkctrl:0000:0: failed to disable
>
> Just add the clock to enable_init_clks, so no attempt is made to disable
> it.
>
> Signed-off-by: Matthias Schiffer <matthias.schiffer@tq-group.com>
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Acked-by: Kevin Hilman <khilman@baylibre.com>

> ---
>  drivers/clk/ti/clk-33xx.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/clk/ti/clk-33xx.c b/drivers/clk/ti/clk-33xx.c
> index 85c50ea39e6da..9269e6a0db6a4 100644
> --- a/drivers/clk/ti/clk-33xx.c
> +++ b/drivers/clk/ti/clk-33xx.c
> @@ -258,6 +258,8 @@ static const char *enable_init_clks[] = {
>  	"dpll_ddr_m2_ck",
>  	"dpll_mpu_m2_ck",
>  	"l3_gclk",
> +	/* WKUP_DEBUGSS_CLKCTRL - disable fails, AM335x Errata Advisory 1.0.42 */
> +	"l3-aon-clkctrl:0000:0",
>  	/* AM3_L3_L3_MAIN_CLKCTRL, needed during suspend */
>  	"l3-clkctrl:00bc:0",
>  	"l4hs_gclk",
> -- 
> 2.43.0

