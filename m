Return-Path: <linux-kernel+bounces-886543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0368C35E7A
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 14:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E21E5636DA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 13:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFDCC321F5E;
	Wed,  5 Nov 2025 13:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQgnocUK"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1392F1FD2
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 13:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762350284; cv=none; b=fi+32cM8I+IPitYpS6A4qnmuX2aYToyCX0nD3bQmqB4SH/Y/1GN9Mx7IzrpV+KJrJAjHmrUCEKegGTavxJW1V7453xtxZ04ltiU4lZbP95i/qUykO5JS4StOx3HsHlyJn912Eq/7+DtqPm1R05zPZo4nKlKWWgIRfOEImMLN4FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762350284; c=relaxed/simple;
	bh=Lt/dlDoXaaRvBcACYFJ/k2lWmDZMa8qMR2ImcS7UhPA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mMQU4xGkdbL8PLKhySxSMZOkF7Po1ihx7WI0wX0+bDCLv91HLa/xpikQe/fm4m0YJe1FPtj12raX2X5Es7TeL0NaeBDEdum8h5fSQMLjHBJOZnlS0zP69TIeEUSlywTImj8ZffsS25uP6OB1HTP3p/XRmy3zvH8RiSOavTtpilA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nQgnocUK; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-294fe7c2e69so64001785ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 05:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762350281; x=1762955081; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qozxgj9+n8IudzDS4TqAFoNwmAmvO9fyBs0Aa70Hb2o=;
        b=nQgnocUK0lkSKmfZeO2srLhYh108g+Cty8SK/XAqpc4FL/KSHMIJ+54Bgw8Lbw8k11
         u+MoyzmGc2/tCCxDvoWSe63OAqIqw7VP/UXlLrrMTtke4pAgRCuCvi72hGDzP8RqCWhV
         EPAZpNt+FxFhDM438VlS1xThgUe/F1KsJCXVVLY7g8aC8w/qMYSHZj6S6wfRIfcAxXfk
         +zAcbOT5QcLv/jXl9UKSAes4Y0o/P7S34zvlz/fcyZi44B014+3UQ7VRbA4bd1aBjDeS
         JrxcVehE+Fm53TTR94A/5Vm4xy+1kH85oMBG1OdwSA1i4eA3S5bMP8Nqu//jrsGTgtNS
         0rrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762350281; x=1762955081;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qozxgj9+n8IudzDS4TqAFoNwmAmvO9fyBs0Aa70Hb2o=;
        b=DTtvlihoNYMuQBIgxVXnQDKPj6UPFNdhVU3PgQoURsb3HS7vow6H6YJM+cFWCZsg0f
         98nFx68kJcybQ+uah/NBDN1TvGF04ZPUuhHQs7NjfRl+iSHqUPxUZy4K+aRce8NgYk4h
         4Gd/1oC3KOb3R474UDOSh0lc5mTSeGjeyIAksnWP/SP7PoXDhaj9gar/JIuK4sp+RkrH
         Miw3PYecLrxq+XB1aBj+7xyzkV6REBNzFqxekB21FsYC5M+xcKxk9x5pwMMerAfH7XOR
         AC3LNQAqTyZUinkyZPL0MALSJu9w+5xEQbg32aqLDEXYuz/UBIzLthCgSooOhvXPaJHf
         fDXQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8Xx45I3nQ/UiUavoICJkLWk9MoidCWcE7cb+I8OoMNm3+uqIg/qhdR7tJ4IKfW2aL8kHNFEqCT8qaJCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVleiDniUUncN1+ANuwReM0nBms+Js4zrCtVE7PsiFpRNpFpfn
	FD11tAyDHN1BzV0PUDHLA8eD5bremtoqqTOaHW0GNvspBNw2utdOcLv+Fkwt1h2qNZxEGkm3G3A
	5iOazJbliuupLZBOIEQgByPenX7RjBu0=
X-Gm-Gg: ASbGncujif1b6scbGsdYHUFSI2R3dlyZSUycvI53U9sg3ulRRcUOlXBR4MG9f0bCJ/C
	EJimVLmoOAX6CDyWQ0sq74IDOuU1XCfLhgYM0AHSjVUGfqbI6I8EXEySIG78P9GYD+aAdVy9Fpd
	Gsuo3qodqb6gRLY8YOh1LW/zI4ffnfhpUBLonbIZY40yQUyGJs4X9NCS+IK6Coz+89uRAaRTs3F
	0KAFThyPnvUcPNHM4b05xX2BPYz6sG+CRMJ5EcEY7Cfy1Na1fWsYdp64g8Jmg==
X-Google-Smtp-Source: AGHT+IGOJWY9um79qVuxu4njBLsN3GbMeipdERxJ3YAlKCuabjVwh3d1X0BvNDhx4+pngzesRjCSQ9dXqon7QtnjBCc=
X-Received: by 2002:a17:902:ef09:b0:295:5d0b:e119 with SMTP id
 d9443c01a7336-2962adf02f0mr47786145ad.26.1762350281231; Wed, 05 Nov 2025
 05:44:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919183042.273687-1-marek.vasut@mailbox.org>
 <CAH9NwWcK_z_4CcDBRYS2nf3AxYV9-XwirvTd+O9uJtHMhyA3Og@mail.gmail.com>
 <CAH9NwWdkjpV5YHmOpuCE=f7RVm1kXzqAOgN6=Sx1s-wxO_SGGA@mail.gmail.com> <4ac9dd98-adc8-4be9-9f5c-4e653f656453@mailbox.org>
In-Reply-To: <4ac9dd98-adc8-4be9-9f5c-4e653f656453@mailbox.org>
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Date: Wed, 5 Nov 2025 14:44:29 +0100
X-Gm-Features: AWmQ_bkTuB0eZgSzf5gvoRARCsMfrXaYv_vl3dBWTq6IB-6XyDxKZI40c5vqEcA
Message-ID: <CAH9NwWd+1MSBGdn6G0zRQgmC7cHCmG3BSxeDUQV-waMG75E2KQ@mail.gmail.com>
Subject: Re: [PATCH] drm/etnaviv: add HWDB entry for GC8000 Nano Ultra VIP r6205
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: dri-devel@lists.freedesktop.org, David Airlie <airlied@gmail.com>, 
	Lucas Stach <l.stach@pengutronix.de>, Simona Vetter <simona@ffwll.ch>, etnaviv@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> On 11/4/25 4:50 PM, Christian Gmeiner wrote:
> >>> This is the GPU/NPU combined device found on the ST STM32MP25 SoC.
> >>> Feature bits taken from the downstream kernel driver 6.4.21.
> >>>
> >>> Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
> >>
> >> Acked-by: Christian Gmeiner <cgmeiner@igalia.com>
> >>
> >>> ---
> >>> Cc: Christian Gmeiner <christian.gmeiner@gmail.com>
> >>> Cc: David Airlie <airlied@gmail.com>
> >>> Cc: Lucas Stach <l.stach@pengutronix.de>
> >>> Cc: Simona Vetter <simona@ffwll.ch>
> >>> Cc: dri-devel@lists.freedesktop.org
> >>> Cc: etnaviv@lists.freedesktop.org
> >>> Cc: linux-kernel@vger.kernel.org
> >>> ---
> >>>   drivers/gpu/drm/etnaviv/etnaviv_hwdb.c | 32 ++++++++++++++++++++++++++
> >>>   1 file changed, 32 insertions(+)
> >>>
> >>> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c b/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
> >>> index 8665f2658d51b..32d710baf17fe 100644
> >>> --- a/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
> >>> +++ b/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
> >>> @@ -196,6 +196,38 @@ static const struct etnaviv_chip_identity etnaviv_chip_identities[] = {
> >>>                  .minor_features10 = 0x90044250,
> >>>                  .minor_features11 = 0x00000024,
> >>>          },
> >>> +       {
> >>> +               .model = 0x8000,
> >>> +               .revision = 0x6205,
> >>> +               .product_id = 0x80003,
> >>> +               .customer_id = 0x15,
> >>> +               .eco_id = 0,
> >>> +               .stream_count = 16,
> >>> +               .register_max = 64,
> >>> +               .thread_count = 512,
> >>> +               .shader_core_count = 2,
> >>> +               .nn_core_count = 2,
> >>> +               .vertex_cache_size = 16,
> >>> +               .vertex_output_buffer_size = 1024,
> >>> +               .pixel_pipes = 1,
> >>> +               .instruction_count = 512,
> >>> +               .num_constants = 320,
> >>> +               .buffer_size = 0,
> >>> +               .varyings_count = 16,
> >>> +               .features = 0xe0287c8d,
> >>> +               .minor_features0 = 0xc1799eff,
> >>> +               .minor_features1 = 0xfefbfad9,
> >>> +               .minor_features2 = 0xeb9d4fbf,
> >>> +               .minor_features3 = 0xedfffced,
> >>> +               .minor_features4 = 0xdb0dafc7,
> >>> +               .minor_features5 = 0x7b5ac333,
> >>> +               .minor_features6 = 0xfcce6000,
> >>> +               .minor_features7 = 0x03fbfa6f,
> >>> +               .minor_features8 = 0x00ef0ef0,
> >>> +               .minor_features9 = 0x0eca703c,
> >>> +               .minor_features10 = 0x898048f0,
> >>> +               .minor_features11 = 0x00000034,
> >>> +       },
> >>>          {
> >>>                  .model = 0x8000,
> >>>                  .revision = 0x7120,
> >>> --
> >>> 2.51.0
> >>>
> >>
> >
> > Applied to drm-misc-next.
> Thank you.
>
> I _think_ I will try to respin the flop reset patchset next.

Gert told me on irc that he has reworked the series already and just
needs to do some testing. Maybe wait another 1-2 weeks
and/or sync with him directly.

-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy

