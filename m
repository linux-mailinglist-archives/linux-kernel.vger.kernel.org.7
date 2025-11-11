Return-Path: <linux-kernel+bounces-895073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D331C4CDA5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 62A304E027D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869E52FC89C;
	Tue, 11 Nov 2025 09:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iUKPSIUM"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FA92EDD51
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 09:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762855002; cv=none; b=t74l2juGwolWP0Ndk/iMx2IOZL52OSHC/ztFVJjIrwXJyYkkN3SjZXorzgxBfQrr+YtIhZKw4P+ezgDKbl+lq1BwfbcIy921zyG8DGpMr2Wgfp7W+6BIOM5P+RlaZQKiLPeWrgFZsQwyiH3tfMSa5b2vvmzb+L1oT3A68D1c5bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762855002; c=relaxed/simple;
	bh=jkgc5+vd53UiZCxhNe3hI/jvAtzcUQj3f4ZwiPIU3CE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p6QZaVKBDorurPQu4JedVvHW7u2Aa8UGcUti6J4Vs32ehfnPL8TPoP6AE6xl2hh1gd5BxE2Rau9mGnDhh+rtnLxfgqnUFZKZwIt2echqQGPD6m5gQNbe5KRrS5E5cBZPRhKS1LQd227rMAZWz5nHmhpWIa+KW+qXwOYYSgEjK5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iUKPSIUM; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4777771ed1aso18250235e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 01:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762854999; x=1763459799; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=old4NHpZNRQlq5F/NJ7Wd36OkosNtO/noel5lfu80nM=;
        b=iUKPSIUMbkcVBQ6J9sWiyhEhXn0A4LRUn8lWuQymCcLXcgqBqAxpWaOc5h8AUvmZht
         VcJAs88YIQYae9CXNl14OFoKW8gbFe/J5AXZhB5pZ7sUf9WNKbyCqJ+KsIj9L+qIjqMT
         RMuhxV+3qxWr6kZOHNZsVNhmltHE1U/0PGx9G6aqG1SyHI1wsuhCtDGcDcrhvQhxim3S
         z8m9GdunEecY3xzehoiDUCpN8VUfb1KSD13yiqBxrmsRjwX/NnL6Qmt1252+FOEJ+6n9
         UmP2kWLq97X0tBR7w/0tn28CV8dwK7EZ7OAbGPRwdAfSyW5SCO+lrDnoVeED9ZWFS3aD
         iCUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762854999; x=1763459799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=old4NHpZNRQlq5F/NJ7Wd36OkosNtO/noel5lfu80nM=;
        b=PwjkIGyYSpuTp15sPJIAab6LlmkzxCoDSR8TPanB5RSTI+GfSDrIUFLIus8xJWMZbm
         4Ency4g1UtsP1tF9u+fObQD0yZ0l1LSoXriHYwClIK6O5Jwukkg280RU1M3tJKvPDJIM
         9VLoP+sXJ3Rr8lCBhEy4vclpZ1KtIn3S6aY7dIt/8SdxBfls5C/gAILu8yU5Hjb7pSor
         x1ik3N0RYNofx/GqlGcflpxdLRMv1d2pDJL1wc2mFjJwiu0RMMKpNOv8yMdGzho0fh4p
         WKZLHU3P8KBj1BLDADE+ifC2rVpJclluHnLA0bGhHKLPgxFd+mJceF+X9rJRIUS6GUGt
         tCaA==
X-Forwarded-Encrypted: i=1; AJvYcCWCeOKEPh7SiQWqkX/nZ22GrhXs8tCTcg66yVevUJU6gX0pN6bd28bKVkulAAiG9FX4LkCDsrAjFllPTiI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX8V8m+wpwZaoomx7acyB3wEIMBKO4PEpL336wwmaHuvu6qQLE
	7hH/J59SozheK5O4qaDhLuzfIx7AGtX2C+CIaQYVmNFwB0mRDjdUBu8U9nuLA4HjKvkj2hCru84
	N8HoByl7cu5PyMusWH+2mSeh8jEveilk=
X-Gm-Gg: ASbGnct9kzV4QbehQYLCWjwZLci3OpTHQsCfV4vFv2yoXvyHEd9AWd3C5NHT6pkyUAE
	KGbqZw5GWVqFEtvglhP/i+jEbOfB7xAyl3n8OMc0HGrnsl4NUM1c5keQoNMNr2+rC05AhOGykzA
	jNTwLDPvI2tbN2u0Ruos/7uxI77mTGYK+TN2tIDAoeFs2AmL4I/YqtLvfIzKMQH8XJUhIR4DUrr
	HwwPoPC++/pNj4R0ec5iJpP58Pmm/G4CUyQLU50ZR4dHgQpPFp5EdLQ2GD9+a8GF4phxv2H
X-Google-Smtp-Source: AGHT+IF7qpKo+MsmIWpLUty6mew6BjAdPBm9lIre8k2/Jvv5ZucJOwY+zC+wLimhZNmUnrg5eMJyJxNj/dIokpZI+F0=
X-Received: by 2002:a05:600c:1f1a:b0:477:7f4a:44b4 with SMTP id
 5b1f17b1804b1-4777f4a496bmr40099395e9.1.1762854999316; Tue, 11 Nov 2025
 01:56:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111091047.831005-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20251111091047.831005-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <40e744b5-cc17-4b33-8d0b-1e9987eece7c@microchip.com>
In-Reply-To: <40e744b5-cc17-4b33-8d0b-1e9987eece7c@microchip.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 11 Nov 2025 09:56:12 +0000
X-Gm-Features: AWmQ_bluZAgbO3v-1VvKVux1F4V0OMKz7MOCbUQ70QEf8OgOn18rDwQSq7RXXHM
Message-ID: <CA+V-a8t5Ac_pb3iUGsQSEiJ_Ji-TrKGr-E6xCJEcx_cK2nKeFA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/3] net: phy: mscc: Consolidate probe
 functions into a common helper
To: Parthiban.Veerasooran@microchip.com
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	Horatiu.Vultur@microchip.com, geert+renesas@glider.be, 
	vladimir.oltean@nxp.com, vadim.fedorenko@linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	biju.das.jz@bp.renesas.com, fabrizio.castro.jz@renesas.com, 
	prabhakar.mahadev-lad.rj@bp.renesas.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Parthiban,

Thank you for the review.

On Tue, Nov 11, 2025 at 9:50=E2=80=AFAM <Parthiban.Veerasooran@microchip.co=
m> wrote:
>
> Hi,
>
> On 11/11/25 2:40 pm, Prabhakar wrote:
> > +static int vsc85xx_probe_common(struct phy_device *phydev,
> > +                               const struct vsc85xx_probe_config *cfg,
> > +                               const u32 *default_led_mode)
> > +{
> > +       struct vsc8531_private *vsc8531;
> > +       int ret;
> > +
> > +       vsc8531 =3D devm_kzalloc(&phydev->mdio.dev, sizeof(*vsc8531), G=
FP_KERNEL);
> > +       if (!vsc8531)
> > +               return -ENOMEM;
> > +
> > +       phydev->priv =3D vsc8531;
> > +
> > +       /* Check rate magic if needed (only for non-package PHYs) */
> > +       if (cfg->check_rate_magic) {
> > +               ret =3D vsc85xx_edge_rate_magic_get(phydev);
> > +               if (ret < 0)
> > +                       return ret;
> > +
> > +               vsc8531->rate_magic =3D ret;
> > +       }
> > +
> > +       /* Set up package if needed */
> > +       if (cfg->use_package) {
> > +               vsc8584_get_base_addr(phydev);
> > +               devm_phy_package_join(&phydev->mdio.dev, phydev,
> > +                                     vsc8531->base_addr, cfg->shared_s=
ize);
> Don't you need to check the return value here?
>
Good point. The orignal code didn't check the return value. Would you
prefer a separate patch on top of this series or fix it in this
consolidation patch itself?

Cheers,
Prabhakar

