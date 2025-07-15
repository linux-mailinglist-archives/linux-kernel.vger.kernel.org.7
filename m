Return-Path: <linux-kernel+bounces-731771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B8BB0593E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 13:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E315E4A5543
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 11:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C58E2DCF5D;
	Tue, 15 Jul 2025 11:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j1I8KR70"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E308E2DA777
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 11:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752580221; cv=none; b=HPK2gtqfHTbJh2s7jGTb6PX7Q/4c20/uPbSb79B/g3+XOypLNfom7g9jRTrMa0OAus6O7i2j07J057xxoBvnH+kLzavioj550YL+fzHH6tA40Ih6rs1dJs3S91UeAM9Ir6iKVPxHeg0G2ZiPUuIXRJ8Rrv6i93crISm2kg5AuMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752580221; c=relaxed/simple;
	bh=QNcCDmqQ5Df7rSq9TtFAWYVAUpPVzmHMgnOLyE7lX6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i0oFdGWos3KB42wr+dhbX/2M36ocdqFAr8CJ21w3TW39SJP5ZTolC5oW9OKqzbg0Z+x6lX+qI8O7SsrixisusuV9CGW4Grj/ar1j/Dujqx9J8tvSttWwo1NN7n4BqhSeETa9KN50NgWpR+mgJqxmf4q6ctjiuUnMH24Qga/Ipa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j1I8KR70; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-70e3c6b88dbso37920837b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 04:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752580219; x=1753185019; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4wNySUjatYeI6OvV2zA4z/a1VqMlHoZrAYnvby/JKWM=;
        b=j1I8KR70P6F5yMATLVDnhuOHbDdqhP7kWYbqS3zCm1CEm2fFiCZ3FVVD6pvQtBEqZY
         wZQM8srF+xabr+VKvvYgxXZQkGCtx9kALLprEqxkX6rFJ8ndA5YI6X75qQ7La5GPWw7k
         N20odE9i4g2/63bhfOjLEqiq/hE8GPa/EkHVbU14ClMS1FXevJ7CBO/qG5WnktxyF38i
         RUbpDDRnBZVjS/Ft3zWCxhdZaum0q3ykiLu39ySrr1ao0mJLFBsgF5b6M6WS3eL1waWn
         XNo3Kk/IJcSx3kDKHFlWA772WJvTHcYEL9NUFC6fY5LmL1NVJgHKPYh5XXX09JtyjAQJ
         cP7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752580219; x=1753185019;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4wNySUjatYeI6OvV2zA4z/a1VqMlHoZrAYnvby/JKWM=;
        b=aWHEY+66dkYgiVBLBoLMnNZAN4JkEco+9c5ARze0EvMvB3psRMA4AGQaGDz2w9Itsa
         AHQhmdaBuVDl4z/cxtdgI7r3El4lQwOFGZM7CCZmg4O8Ik4I6PmlFWPdcOigE3lHLLyr
         1mchXfkZHeDH5D2Ock4pp/bY0UqzOPpfA/9t2b9Zn1Ay7loc7nIcGkWA7TCW3o+kgITG
         20cHOgaB2IMvdXuMdpTz4zuqYPmkwdkFHThquMBt7h49JvUOVwrLxAAMjtb1U8DetWuE
         TaNijzELLTI3yWEFxGzD77jBSjOJHhjPubKyImLiIEoo7oZEyAoAUmtaZJkWNipGJeUW
         7aaA==
X-Forwarded-Encrypted: i=1; AJvYcCUQ3BAXcrq46IXFd6rAHfXiG78ZzDF4VPBFJgDgKYvLHpHkR7qcGD47y+zkAadKSpfTUPUbAzbt7MKm2uQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YySROH388InaSlipmOgYuRGgzP64fsjSLYeodiSFX6FnKWSkEQn
	QTJXKkW14NR9O7oXpUoOx2AXynLsAg5Gcf5JngyLzkCcBsP3sGvmFM7WmCj87OZE3pMwX5bnBsq
	glt8+txrQRL4gXDXzzNumESdUDIeGjq1JqqZRClx17g==
X-Gm-Gg: ASbGncu1xuTIAM/QEt65YHFW9Tlgeweza55AaOa0nSptZNZVwKY6i6dNB7EXj3/OfPd
	eSqhd2UYoGiNW4YdbZsDRGz64EWAtw0pjuuhYwKQ/moqEqZDeYswc18CQOL2Cbd3r16cfNzqKYJ
	3FopLPun8Fq2UB8qkM2NZR4HuHdawRNJGUIJOLv+0cC853h5iOS18DltBQIf3rJTiU3FGjDei4w
	XAqQiTt
X-Google-Smtp-Source: AGHT+IF/K38yeveYq70L/mHAPtfjeL+GIee4NoKApQPc4/AmworpqftrKbu0K7Q7h4oLInJZL2btkmXzEuBJtreqbG4=
X-Received: by 2002:a05:690c:7483:b0:716:3dc5:a35f with SMTP id
 00721157ae682-717d5e94ad5mr256657057b3.19.1752580218628; Tue, 15 Jul 2025
 04:50:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250629172512.14857-1-hiagofranco@gmail.com> <aGazjaJQXl03HUJE@p14s>
In-Reply-To: <aGazjaJQXl03HUJE@p14s>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 15 Jul 2025 13:49:42 +0200
X-Gm-Features: Ac12FXwJ5N_wrB84X7RLvjAxpSUj8wCAKwcHpPhNOwV7kx7yjVIlAOOax7yXEA4
Message-ID: <CAPDyKFpUF+S8EqVsHct7TFZGupq71Bu7eL3t2Sr=ibhZ518nsQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/3] remoteproc: imx_rproc: allow attaching to running
 core kicked by the bootloader
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Hiago De Franco <hiagofranco@gmail.com>, linux-pm@vger.kernel.org, 
	linux-remoteproc@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Bjorn Andersson <andersson@kernel.org>, 
	Hiago De Franco <hiago.franco@toradex.com>, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Peng Fan <peng.fan@oss.nxp.com>, daniel.baluta@nxp.com, iuliana.prodan@oss.nxp.com, 
	"Rafael J . Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Mathieu,

On Thu, 3 Jul 2025 at 18:45, Mathieu Poirier <mathieu.poirier@linaro.org> wrote:
>
> Hi Hiago,
>
> Many thanks for re-working the changelog and comments in this patchset, things
> are much clearer now.
>
> Thanks,
> Mathieu
>
> On Sun, Jun 29, 2025 at 02:25:09PM -0300, Hiago De Franco wrote:
> > From: Hiago De Franco <hiago.franco@toradex.com>
> >
> > This patch series depends on Ulf's patches that are currently under
> > review, "pmdomain: Add generic ->sync_state() support to genpd" [1].
> > Without them, this series is not going to work.

The series above have been queued for v6.17 in my pmdomain tree.

Do I have your ack to pick $subject series via my pmdomain tree for
v6.17 too or do you think it's better to postpone to v6.18?

Kind regards
Uffe

> >
> > For the i.MX8X and i.MX8 family SoCs, currently when the remotecore is
> > started by the bootloader and the M core and A core are in the same
> > partition, the driver is not capable to detect the remote core and
> > report the correct state of it.
> >
> > This patch series implement a new function, dev_pm_genpd_is_on(), which
> > returns the power status of a given power domain (M core power domains
> > IMX_SC_R_M4_0_PID0 and IMX_SC_R_M4_0_MU_1A in this case). If it is
> > already powered on, the driver will attach to it.
> >
> > Finally, the imx_rproc_clk_enable() function was also changed to make it
> > return before dev_clk_get() is called, as it currently generates an SCU
> > fault reset if the remote core is already running and the kernel tries
> > to enable the clock again. These changes are a follow up from a v1 sent
> > to imx_rproc [2] and from a reported regression [3].
> >
> > [1] https://lore.kernel.org/all/20250523134025.75130-1-ulf.hansson@linaro.org/
> > [2] https://lore.kernel.org/lkml/20250423155131.101473-1-hiagofranco@gmail.com/
> > [3] https://lore.kernel.org/lkml/20250404141713.ac2ntcsjsf7epdfa@hiago-nb/
> >
> > v7:
> > - Added Peng reviewed-by.
> > v6:
> > - https://lore.kernel.org/all/20250626215911.5992-1-hiagofranco@gmail.com/
> > v5:
> > - https://lore.kernel.org/all/20250617193450.183889-1-hiagofranco@gmail.com/
> > v4:
> > - https://lore.kernel.org/lkml/20250602131906.25751-1-hiagofranco@gmail.com/
> > v3:
> > - https://lore.kernel.org/all/20250519171514.61974-1-hiagofranco@gmail.com/
> > v2:
> > - https://lore.kernel.org/lkml/20250507160056.11876-1-hiagofranco@gmail.com/
> > v1:
> > - https://lore.kernel.org/lkml/20250505154849.64889-1-hiagofranco@gmail.com/
> >
> > Hiago De Franco (3):
> >   pmdomain: core: introduce dev_pm_genpd_is_on()
> >   remoteproc: imx_rproc: skip clock enable when M-core is managed by the
> >     SCU
> >   remoteproc: imx_rproc: detect and attach to pre-booted remote cores
> >
> >  drivers/pmdomain/core.c        | 33 +++++++++++++++++++++++++++
> >  drivers/remoteproc/imx_rproc.c | 41 ++++++++++++++++++++++++++++------
> >  include/linux/pm_domain.h      |  6 +++++
> >  3 files changed, 73 insertions(+), 7 deletions(-)
> >
> > --
> > 2.39.5
> >

