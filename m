Return-Path: <linux-kernel+bounces-885081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 725C4C31EE1
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 16:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C63F618C3F33
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 15:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDFD92727E0;
	Tue,  4 Nov 2025 15:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pqphw7Bx"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E64248F73
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 15:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762271452; cv=none; b=MBEneEIM12qZDslKF3QXV0IyJA3PXgcszwuKNA2/cxjD3vWBDpYNnN9i47CVf6DpTSI+dVfHR9p4CNxmeW3S3+cg6smTt73HDQMDttCqDW1X4DeiQd4tUcw/lvP9dAt1fBa2Idnp/DN/lzdwawBRc5Szvs1QKkTTtq3q06XO2HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762271452; c=relaxed/simple;
	bh=v83IllXrV+HmdQxrR1maiOn2Em0xZsyPcnRV9FtKB1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DzzNcVEY2rf5/xtLnemEZCY0ktVey45wBnvL1ch8gE3wwL3TeGtNCnWZ3AE5MdHRcHC+eSnAQcdTNI8oVI9jXWdl18EdFINtU+M/fs6SKqVfQTbUPvhwQVmwD/tIAjitfPOiaAmxWGdLJBrdfS7/upK2DsegzR4UJWj6ySGtXqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pqphw7Bx; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-29516a36affso42908255ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 07:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762271450; x=1762876250; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DF+Xg0KfbjravoPnRqbNNYO0SUruQaoSS8eSZYe/j4M=;
        b=Pqphw7BxXH9JkSC/s0iGn/m8zxeDccfk52PkzcF3gnY9Oo0/HwkZM2Vyz46mduCDn5
         BbfSG5CsmchtC0eUPcFbLO08p8RE2l5M7T8s8GfRwcrXZV93rpwb7a6zT/7+7/tpfJ2k
         SWS/sluRqwJ6vwlHH9Btt77w3q/TcNOfnSDIKGI48WvbTJOAsRB+7iXaDSiWhC19FybO
         Ks3O6SSnKLbJ9VTPvv7qgjAaizvgZM1LrLes6rI99Vxg+te2f/DhIDnEyU5KzsN2Oks7
         y2nK6TIZs/apxiNgu5lXhOajgx3rPXMFejc/myUy6iraEgolOIDHtvWk+0aYe18AnBqy
         rl6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762271450; x=1762876250;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DF+Xg0KfbjravoPnRqbNNYO0SUruQaoSS8eSZYe/j4M=;
        b=Oxqqu0RtCVskVS3IgkQH/DxLkQ3nDLmdB1xtbtYkMQjQdNB4WAVP9Vv3Ysvw3SCJnH
         uWbY/mrBjNV7oMsFTkg9WSg4Laabte4EElmuHSvoORUOzccRLpwRAL+SXcGFW6yh4ogx
         +Tpg8xzTzTJ1Qvczya7WvMsGYeM8uSkeNwlAb76vvs0M/WxWmu7iSMYNBNjKFrCfY8fi
         Er8afjvdYsyRCtGbxSIdK1RKIORjwnSxc/xpgTEfqh9s2BfAK0lw9ifDJSd/u9yDWkSH
         xTiejyfl+TOZ4MrvqHWGPGLkbUucwrYLmOz2CYOC/t5Z3szvKP7T0wQO4Qn3wO1WvQUb
         HMRw==
X-Forwarded-Encrypted: i=1; AJvYcCXslaFZZDi8vV6S8kxgZIS5pEDOgdK5yqDWwDqhXuiELQ5/pZrZjmyqY/lO/hVhPyQt0X4tgveS43xJino=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8Ycxw56kpjptFKd2IbwWAqRxQzw+/RsJ4OPcpl4PJvLbVTkMU
	mHmO+0KgLXIt3JnHemxSyupXZlb2wq5cGIBYgOCgTCgSt5kh6OCP+kq3CavqnhwWRn0cflLuMOp
	0jw0whugO5ejD9lGLdzz7J8omeG8gMTQ=
X-Gm-Gg: ASbGnctP+TpZHVdw+cSTI3rckLXhNqPRQppjCKzVv3sF6h1Ab9CUR4oibuRrUqHoFzc
	Rxgpg+ybklHCrM7PnDTiCddq3O8UqlA+cEnfOmxGAPdUzxfLckkRvBPFfWueNcqzJzDgxdeYF4q
	+wKSLAKwYBCW6jMUtsXWGrjpDrJTzyvpTPl+Ul5ccrgdsKJiWnA5ik+ZviLEHkoCwvsg11wKtC+
	sCxPBxdXKLrNJ2bFwZBqmSXA2DQ0qIIOKQcp91+TssNRyhmj4H+wK35PqvF9Q==
X-Google-Smtp-Source: AGHT+IFMX3GimODm1zGJLS3LPmzvdh2a8d1e8mZX8+bPjZowTFcWILNTw2aU/zYsH97Ej4/MFFRAuPJ+g4TDC+o8/KY=
X-Received: by 2002:a17:902:c40d:b0:295:fe17:83e with SMTP id
 d9443c01a7336-2962ad1c9a2mr1375335ad.19.1762271449948; Tue, 04 Nov 2025
 07:50:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919183042.273687-1-marek.vasut@mailbox.org> <CAH9NwWcK_z_4CcDBRYS2nf3AxYV9-XwirvTd+O9uJtHMhyA3Og@mail.gmail.com>
In-Reply-To: <CAH9NwWcK_z_4CcDBRYS2nf3AxYV9-XwirvTd+O9uJtHMhyA3Og@mail.gmail.com>
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Date: Tue, 4 Nov 2025 16:50:36 +0100
X-Gm-Features: AWmQ_bkWGPLr80FTYocQH54j43c8QbQrHNTa44SWp_HgbPcP7OEt6fQrdnJo2z8
Message-ID: <CAH9NwWdkjpV5YHmOpuCE=f7RVm1kXzqAOgN6=Sx1s-wxO_SGGA@mail.gmail.com>
Subject: Re: [PATCH] drm/etnaviv: add HWDB entry for GC8000 Nano Ultra VIP r6205
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: dri-devel@lists.freedesktop.org, David Airlie <airlied@gmail.com>, 
	Lucas Stach <l.stach@pengutronix.de>, Simona Vetter <simona@ffwll.ch>, etnaviv@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > This is the GPU/NPU combined device found on the ST STM32MP25 SoC.
> > Feature bits taken from the downstream kernel driver 6.4.21.
> >
> > Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
>
> Acked-by: Christian Gmeiner <cgmeiner@igalia.com>
>
> > ---
> > Cc: Christian Gmeiner <christian.gmeiner@gmail.com>
> > Cc: David Airlie <airlied@gmail.com>
> > Cc: Lucas Stach <l.stach@pengutronix.de>
> > Cc: Simona Vetter <simona@ffwll.ch>
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: etnaviv@lists.freedesktop.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  drivers/gpu/drm/etnaviv/etnaviv_hwdb.c | 32 ++++++++++++++++++++++++++
> >  1 file changed, 32 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c b/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
> > index 8665f2658d51b..32d710baf17fe 100644
> > --- a/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
> > +++ b/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
> > @@ -196,6 +196,38 @@ static const struct etnaviv_chip_identity etnaviv_chip_identities[] = {
> >                 .minor_features10 = 0x90044250,
> >                 .minor_features11 = 0x00000024,
> >         },
> > +       {
> > +               .model = 0x8000,
> > +               .revision = 0x6205,
> > +               .product_id = 0x80003,
> > +               .customer_id = 0x15,
> > +               .eco_id = 0,
> > +               .stream_count = 16,
> > +               .register_max = 64,
> > +               .thread_count = 512,
> > +               .shader_core_count = 2,
> > +               .nn_core_count = 2,
> > +               .vertex_cache_size = 16,
> > +               .vertex_output_buffer_size = 1024,
> > +               .pixel_pipes = 1,
> > +               .instruction_count = 512,
> > +               .num_constants = 320,
> > +               .buffer_size = 0,
> > +               .varyings_count = 16,
> > +               .features = 0xe0287c8d,
> > +               .minor_features0 = 0xc1799eff,
> > +               .minor_features1 = 0xfefbfad9,
> > +               .minor_features2 = 0xeb9d4fbf,
> > +               .minor_features3 = 0xedfffced,
> > +               .minor_features4 = 0xdb0dafc7,
> > +               .minor_features5 = 0x7b5ac333,
> > +               .minor_features6 = 0xfcce6000,
> > +               .minor_features7 = 0x03fbfa6f,
> > +               .minor_features8 = 0x00ef0ef0,
> > +               .minor_features9 = 0x0eca703c,
> > +               .minor_features10 = 0x898048f0,
> > +               .minor_features11 = 0x00000034,
> > +       },
> >         {
> >                 .model = 0x8000,
> >                 .revision = 0x7120,
> > --
> > 2.51.0
> >
>

Applied to drm-misc-next.

-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy

