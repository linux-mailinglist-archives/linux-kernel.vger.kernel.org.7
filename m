Return-Path: <linux-kernel+bounces-728051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F2AB02312
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 19:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98C67A80571
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 17:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1DB12F1FFA;
	Fri, 11 Jul 2025 17:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DsAOHhhN"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD3A2F1FDB
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 17:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752255931; cv=none; b=XZnKabxwRFJUUlOuHviQ4EY8IfhJ72KVMIxkoXy7SMqoSgeYcf8fibjSeA9bZ+STW3e0/tXtmc8MhtI/kS1uhY22OazN06v7t1BPAVm3/sM0u18sxeWnmWAoXtsT/ZCWJkeEIpmU7h0AFfebHz/ZZ6OSB1Hqmf9BUrB/6UQLtdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752255931; c=relaxed/simple;
	bh=mb/k9Ts4NFFqDMDgg//vbq5zdcUl72jlNOg9BWpwo5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JJZ8dtl+GiJwfv6955ZcttpKAAaOPLMqkieg3M5+dX91NWty8EAHHdKRT/HSslD43+IdIKxQGFw7B5qlHjbYnQhNnAZzW8SYPPRwweHYcxV1kjVEKXvGrvenninNGsDmXAq+np45TS7QpdKDA2BScXeLhuCUD+E3ZL1ffXajCuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DsAOHhhN; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-558facbc19cso1946925e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 10:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752255927; x=1752860727; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mb/k9Ts4NFFqDMDgg//vbq5zdcUl72jlNOg9BWpwo5Y=;
        b=DsAOHhhNfQWrOBSodqloZZkx+mrGk42CQf1xlp4MCnECgkYK/bzxIWTsy1ZoqqRJAd
         4d5vdX1r5W6NkUrDoHlXlvHhi8jfwjzikBLRB8PrA1w6yNdU3yQYktvWe+hAcJ5yOc7e
         Oqei/L5WS4binn/957lvfGqiXlxj5gcJ1rHUEcL7UPQ5XgqfcTAO5dqiwFGpweopO8oW
         3r1UTY4kV7vwGqhZkw9BqMgBn0Kn3raaNvLT2xY5n6kM+Q6k6KGqdrJcEbtDMwdC8dbi
         j6us6x0LP7vM6nIDXKLtpFLAQSdN9Jy5pFNsR/ULb8lZxkL5+rLQRyXOLcnj1UdGfhW2
         kRFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752255927; x=1752860727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mb/k9Ts4NFFqDMDgg//vbq5zdcUl72jlNOg9BWpwo5Y=;
        b=cIw4sGFm4uyYEJEVmiXpSYf+9zrLXSErZvme/xapcT+0Fpv6gdRaHhpSeJkB7p8xLD
         aOzx0X2Cafgsup1PubDwSgGIhZQQ7TFUULHLiqVXCBdxyJhQRo/Uolc9E5vpA5QOk3vJ
         GNrMt6dAx2xWZ/7jcSZF3yV3p8dbOYxjhq+8JqHVDKsc+iCzkDztRFjJG8mwtBGy46Kd
         Xg8kDKoMB+wjvqp1waHKVkm1HI1pCpJCLZCMvO64y8+fp5WHFxk55Vwdo44n6Ebghl7U
         p7UMFnuhkywNnvjK3DhJH9vHzHicF1CO1aGfISEh9ebRqtYXJ8vFly4SxOH02BjalCVL
         75Vg==
X-Forwarded-Encrypted: i=1; AJvYcCUnGqltnjGteRosnoA2oi0c3RIeu7fzmAQAA4T/qlDGRYQm8Zif0WKFlYEJ7vN4YsJgT3Jb7EPD9xcdfLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfwRCFmQC6vxLLsuC3k53pJCGKq3DwEKibz3bqK0oefzHO+x6H
	CeGWREwxC/IQPHuWPDJpqBkm1PhDnrFIl/XAAhly+S+LUEkow71CLk7VnNzWyEKTa4d5MRMAJlc
	ERqJjn3WAhRGQWiq/Ql9TgXpkCi8oKj81W9DBfYnSyw==
X-Gm-Gg: ASbGnctE3dSjPoqHerRrvLmc5tvqJBFQ3uo0yXt3VpzAsI7qfvamlIznw5fiK+QhZi4
	LrhLRfgifvExE/PwbCj7JGhxDF7TQ1CayBZ1de2qtFve2/3pfX52LbGIdACTH3tbxgEdQXQFpCo
	bX6pBhnIpS77UiX67hQGUpOjw+xqPf3cm8gOWV7rA0CyZrjMf6cWDll84gwch6GyN+r8z0Fvj9m
	lp/wvzxxuEsZDXcIQ==
X-Google-Smtp-Source: AGHT+IFZDCZTlE6gWaEB19mO+GckYjvcVz7Jadiih65ETG/CCRys4RjtiQYLjKpiBNN+Zotnz3hQQ0D3S79xjWv4t0M=
X-Received: by 2002:a05:6512:32d1:b0:553:24b7:2f6f with SMTP id
 2adb3069b0e04-55a0464f653mr1135322e87.51.1752255927288; Fri, 11 Jul 2025
 10:45:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710-arm32-clk-round-rate-v1-0-a9146b77aca9@redhat.com> <20250710-arm32-clk-round-rate-v1-3-a9146b77aca9@redhat.com>
In-Reply-To: <20250710-arm32-clk-round-rate-v1-3-a9146b77aca9@redhat.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 11 Jul 2025 19:45:16 +0200
X-Gm-Features: Ac12FXxij1ZPhhWO-gI9e94mzHRwj1K4FxFxtD7flD8pQuiwVzPSrPB2LvZpGlg
Message-ID: <CACRpkdbpXPXFgRTyAG2MeZvDp7wj32yQO6eRRMp4rQ3sCbQ+Sg@mail.gmail.com>
Subject: Re: [PATCH 3/3] ARM: versatile: clock: convert from round_rate() to determine_rate()
To: Brian Masney <bmasney@redhat.com>
Cc: Paul Walmsley <paul@pwsan.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Janusz Krzysztofik <jmkrzyszt@gmail.com>, Tony Lindgren <tony@atomide.com>, 
	Russell King <linux@armlinux.org.uk>, Andreas Kemnade <andreas@kemnade.info>, 
	Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, 
	Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Maxime Ripard <mripard@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 1:42=E2=80=AFAM Brian Masney <bmasney@redhat.com> w=
rote:

> The round_rate() clk ops is deprecated, so migrate this driver from
> round_rate() to determine_rate() using the Coccinelle semantic patch
> on the cover letter of this series.
>
> Signed-off-by: Brian Masney <bmasney@redhat.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

