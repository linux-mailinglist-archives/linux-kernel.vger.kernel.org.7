Return-Path: <linux-kernel+bounces-814197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB73B5509C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 16:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 870BB1D6460D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD5130F94A;
	Fri, 12 Sep 2025 14:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RqlaQmsV"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB3A30F924
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 14:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757686458; cv=none; b=ckD8HqLBpgZPslhTbtesNmMUu4PY5h/yyCI2IpQDay9Nn/qHt4H7xE//kQohN38vLTurI0XzFOEs4+2c5q9h3mx+nBsj0paF78cdn9RQdPO1ZRMs/0p08/81INrgsaMepCyscAEHbblmEITiVmhJK1fQoKhRAs+qVfd5UOZzGps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757686458; c=relaxed/simple;
	bh=syq7R/TABSukLftxI0B42rdJQ8RsDVRse96nLdFcyY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fUzFZTa+Tmo3X8LmxtbmFLCdNqXDzwy75RMbJNEjqueewaYr8v04MKTSC7FxEUwdoHQElJzt1eVL1n94OTVVtJ8HQefHHibStZII7HLmr1T/pa78ZJQ5sfvD2y+z7zS1btYJlRSm3Oo337UGFobcE8Fm4IEv4cPNeqJ1yYheNPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RqlaQmsV; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e970599004aso1366604276.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 07:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757686455; x=1758291255; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=syq7R/TABSukLftxI0B42rdJQ8RsDVRse96nLdFcyY0=;
        b=RqlaQmsVPGUULLBHFgQ+FzFu+neOJffz+nkLUE8um5Xtg0xNcFrShJyfkWsbO92LZs
         vXdH3wsLt65TWCXQZUrbUMEirOafdXcs9FqckWY4Hl5TYmxiA3Ntj94cx51stOiiEfsQ
         7TtWmHy28PradQ6oljJrfNfhGRLtWYR4tOaBBN3X1CM5ePOm1LPsU4xISbMAcBi8xIF/
         Z69y/GrTQTIKs/GtMpVNp87aMM8qqB0PDToJs/fpeOTLZKR0X68YtwH3WcgVfCiuQDWy
         Q3NdZScYNytht9NjyVV+PNFKKPp6JmC3DryiUZkQjXXuudJyhyKsuhX1AhDPj5Lj/UFe
         nkRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757686455; x=1758291255;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=syq7R/TABSukLftxI0B42rdJQ8RsDVRse96nLdFcyY0=;
        b=fULCztRr4ZnCd2ApCX2S7tTW2xl72yJXnJEmWNAyu6HbAYSir8AeI/1rdqBrRx8uVG
         su6MB2Pk/iEVLkNMn60EEgIcW6Kt1+LZw7wKEnwx7LUYDDsB12RteEGdZyU4ohLd/AWH
         K1gkWOElOItbYMtuYoB6MFPO2TO2hFCjj7CocxgaMTyRKWBnGiea+EUfPKged7zaydlx
         iHdyDiyFjvb6N8eaOrKIoWJG5lrXlFjxXCZtfyP8r80SvJgVCYoPSyhxHFOwEKWTMUQ5
         d7wz82j7vKnlYL5tncdl70XcRBZxwwtL9qVH41OrGT59TDEP9Kv7NuFM9KxtWyWhJLjr
         6Xng==
X-Forwarded-Encrypted: i=1; AJvYcCXwWUyioQSVtEtGaZewvhdU/V+q7qqDyanXbW75tGjdHx7a/t3wDpfqFsatmBznjTGyq1j76DpT6U8amw4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4SXYP3xa22TCJ2WTbkDMNb+eYqP2s3cGyK+2lc61snm//wK4H
	qynpnpM2pTp+6kZ5ZY5dbt7bc0HVZYbEfX0WDEPgmkfrI3vwqSvxZqGyvtJDRdpeW4hRRjy6ySr
	w4F9+3OwlY4kKf1IiwzxG9N1cglo21hXMIZJma3pSqaRwp5/jkxDv
X-Gm-Gg: ASbGncuYhjI52gMdyalZP1uSjFb/PA43+nbQFIfIbnI2u0RBkgMBhSICoHCf5hue30U
	EQgwlTvMKKRItvK/hI+a8+VnNew7J6Gfb4H0yBfK0ZfqWihXKLWeXYnBnfDUAZXfJqAfoXjb/y7
	wUBYw7sFX0IOSzdbvvqzS8bWyU/HAK6AHne2L5XqPBoJcKknBMFqLZUsN3xJoXdOACyt4hpnK6L
	s7rwJ6v
X-Google-Smtp-Source: AGHT+IEC61hvh4OfyNmiTCvk/1998ACYEQ5yD3djOahpsZ3sLPvFzoPVjU3sgdw+G9LxrD3JRV572wd+3JUf13+iNPc=
X-Received: by 2002:a05:6902:4284:b0:ea3:ca1a:5714 with SMTP id
 3f1490d57ef6-ea3d9a3013amr2865414276.12.1757686454996; Fri, 12 Sep 2025
 07:14:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731121832.213671-1-jonathanh@nvidia.com> <CAPDyKFr+uVDYBMvsN+L9XPToaD+Wr9P=SnnXyKB6ucqQ7se=7A@mail.gmail.com>
 <sgsi4wia74nbvme4ik27waec2yuipbw7hfh7jyygxlbfhvsc5q@4onfx46nle56>
In-Reply-To: <sgsi4wia74nbvme4ik27waec2yuipbw7hfh7jyygxlbfhvsc5q@4onfx46nle56>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 12 Sep 2025 16:13:37 +0200
X-Gm-Features: AS18NWCRtDpXFh4iNUnsUuINjx8fawHh0EDHYECyLm0OrLBfYlrMe8r95f0_480
Message-ID: <CAPDyKFpVohjP4bkSkxxOXiEsbWqWNa2GFRdDbQ7YC60NyC=c9A@mail.gmail.com>
Subject: Re: [PATCH] soc/tegra: pmc: Ensure power-domains are in a known state
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Jon Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 26 Aug 2025 at 17:29, Thierry Reding <thierry.reding@gmail.com> wrote:
>
> On Mon, Aug 11, 2025 at 12:37:25PM +0200, Ulf Hansson wrote:
> > On Thu, 31 Jul 2025 at 14:18, Jon Hunter <jonathanh@nvidia.com> wrote:
> > >
> > > After commit 13a4b7fb6260 ("pmdomain: core: Leave powered-on genpds on
> > > until late_initcall_sync") was applied, the Tegra210 Jetson TX1 board
> > > failed to boot. Looking into this issue, before this commit was applied,
> > > if any of the Tegra power-domains were in 'on' state when the kernel
> > > booted, they were being turned off by the genpd core before any driver
> > > had chance to request them. This was purely by luck and a consequence of
> > > the power-domains being turned off earlier during boot. After this
> > > commit was applied, any power-domains in the 'on' state are kept on for
> > > longer during boot and therefore, may never transitioned to the off
> > > state before they are requested/used. The hang on the Tegra210 Jetson
> > > TX1 is caused because devices in some power-domains are accessed without
> > > the power-domain being turned off and on, indicating that the
> > > power-domain is not in a completely on state.
> > >
> > > From reviewing the Tegra PMC driver code, if a power-domain is in the
> > > 'on' state there is no guarantee that all the necessary clocks
> > > associated with the power-domain are on and even if they are they would
> > > not have been requested via the clock framework and so could be turned
> > > off later. Some power-domains also have a 'clamping' register that needs
> > > to be configured as well. In short, if a power-domain is already 'on' it
> > > is difficult to know if it has been configured correctly. Given that the
> > > power-domains happened to be switched off during boot previously, to
> > > ensure that they are in a good known state on boot, fix this by
> > > switching off any power-domains that are on initially when registering
> > > the power-domains with the genpd framework.
> > >
> > > Note that commit 05cfb988a4d0 ("soc/tegra: pmc: Initialise resets
> > > associated with a power partition") updated the
> > > tegra_powergate_of_get_resets() function to pass the 'off' to ensure
> > > that the resets for the power-domain are in the correct state on boot.
> > > However, now that we may power off a domain on boot, if it is on, it is
> > > better to move this logic into the tegra_powergate_add() function so
> > > that there is a single place where we are handling the initial state of
> > > the power-domain.
> > >
> > > Fixes: a38045121bf4 ("soc/tegra: pmc: Add generic PM domain support")
> > > Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> >
> > Thanks for looking into this!
> >
> > I have picked this up via my pmdomain tree and applied it as a fix
> > with a stable tag. Please let me know if you prefer to take this via
> > your soc tree instead.
> >
> > That said, I guess we have some use-cases on Tegra where it actually
> > would make sense to allow powered-on PM-domains to stay on during
> > boot. Although, at this point, it seems better to deal with those on a
> > case by case basis, as improvements on top.
>
> We're actually running into one of these cases right now. This happens
> for display hardware where we have simple-framebuffer device tree nodes
> that are meant to allow a seamless transition from the firmware's early
> framebuffer to the Linux framebuffer. But since Jon's patch disables all
> of the power domains, the seamless transition no longer works.
>
> I suppose we could argue that seamless display is less important than
> systems booting, so I'm inclined to say we want to keep this patch to
> fix the earlier regression and then apply a fix on top to address the
> issue with the early display.
>
> Do you have any thoughts on how to deal with specific power domains that
> should remain powered on during boot? Ideally it would be something
> standard, but worst case we can also special-case in the Tegra PMC
> driver.

Does it work to leave that particular PM domain for the display powered-on?

Genpd should deal with this then, by simply leaving the PM domain on,
until the consumers of it have been probed.

Kind regards
Uffe

