Return-Path: <linux-kernel+bounces-700686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F9EAE6B8B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jun 2025 17:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BA751C404AC
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jun 2025 15:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CFD2D8760;
	Tue, 24 Jun 2025 15:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MB2+Zuap"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B934C2C325C
	for <linux-kernel@vger.kernel.org>; Tue, 24 Jun 2025 15:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750779007; cv=none; b=iHveKx0tDMQGpJdA/J/od62OVXv09bs+qbrKV3kNy7yIw8j44uJi8BgLm+Ngy+KVivZdtCQXleWROHxd3dKfoTA+qQsf8lf8i81cAmpeHfxV/DMWPNqz1T/WawQOf0Q71X2tIRfWug3tzUdF0YwMr64Gpg8xlH2r5Uz+Qvxd8y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750779007; c=relaxed/simple;
	bh=O/aE8zjFpgCjWByRQyEg+FiX+qYxXtQq6PkM5l9G+p8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GzP7ny2itV0v6AkFwBzo0beBeXa/xM84rCEsGqqdAUmQi6ESFO8puMljlg7UP9ooeCOjtG9J2IIqb6X0CMbHFflQWLKSDSkVlgpHvRljqySoaLlWYkETKGTcomqGPPYtXsbSSceHJGRDXdVzNrUoON5LqIURBUz8CPTNX6zJzW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MB2+Zuap; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e81877c1ed6so4533925276.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jun 2025 08:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750779005; x=1751383805; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8dJOF+dkZKOGrXkHRENXg44LMKX4qd4pEo3+Zbj7kKM=;
        b=MB2+Zuapd+mr9UfpX3M5NefZPWfAHq6gIMIzF4pD8lG0KxZ5ObjMDZVFAcyPeeh10s
         w8G4t0efqyyzC3Lc8dx4NIKafKm0lr19flEPuoMtWTU7XsWAOGyt/EBiuE+UMOW04YsA
         4YVl9b6P745Hg7ItUzYFpJ198evgpcqUV2srNgbHeenz/S0ly7P+zt+PV6bN0wgvGvzc
         7Z1T/u/VxWgjE3ton9MeWlZ9Expx1ytjreW253z00ww1cc7kRsAVl2cBrqOoL5912OpZ
         wvHwnnsz9V5VxpkrVuePNUY2tdwm4sbUDB+HWHMAZyZnR3CvNW8wA8WN+4VU43myRW0H
         4Zpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750779005; x=1751383805;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8dJOF+dkZKOGrXkHRENXg44LMKX4qd4pEo3+Zbj7kKM=;
        b=wPOQgjRxlzrFnTKW8iCFJzs777N1uf64XIWaOl7JSgSM3jawFf//n+GPyLfBMFauX5
         QNh9P221m4I16HJYCtCY1N/LUBR7So7Jnd8ayl3eF33HeJzvJ8EFlINFcBwXLAUthUp+
         80OsYRv4U8QQo+go34o2LjeFcEidnVpLWOekUcs40IhemQTVIrqYFut4YcIVKmZKDj6m
         seQ2WJfcqe0DY7ICdv+EZv4c4T6yMYI3uxo7fy+6OsuXgk8ar60KJ60S0xNoG8l5D4KI
         69RxMxpsrPaXQBe4wtymi6tfnZ8qEA0pnIpp1wUQKMxVN4xNf/8eKg5BMnDtaeoh3uQ8
         gKow==
X-Forwarded-Encrypted: i=1; AJvYcCX45w73k0BhkqSPXcB5El9j/gh8Q2F/YPa57YOIHHrWHcoVOQa1m3javomTvBEzXgEtqt/enMRIxAnlTjI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhXfDwF4D15B9W/SDmdEk6EcZr68ENbvr8IzPbCMI/3FKIcxOb
	Qf5CHw8GmF1HCm3JFGnG05P5ZDnyd15U6jpADp+PzCKuPh2FBwwXJHQGXK5r6yGUuLzpL8yQKIF
	eKjJjK0puBhOxt+xsbAfTjETTTy9ZXSx1QrXbJc+c4w==
X-Gm-Gg: ASbGncugRWnqNbd15grMNkkmtWJx8pAWbi3eIbSOThzCh2NBz9JPltRGXXxlo01Ip9w
	7mAnXcfA/EJhPglhLIg+GcZRUFHIj9gG+Mp6SDjaQFq6IweayV3gFxAvOMUu6k50urYcbw+6a5x
	Q+Cgbg2B3kyRZEM2657uELSKlxGjyUG9kVpCHechaJLn8IpDOSDTenEbs=
X-Google-Smtp-Source: AGHT+IHATcRs0RklhKZHJE22UBmrpX8en+JTsoR7JvemTlqCu4NknqQmYKRTJnXSHRC2xNDXA70wYENoyIcfbMnd1YU=
X-Received: by 2002:a05:6902:274a:b0:e84:4be2:de76 with SMTP id
 3f1490d57ef6-e85f1ec2397mr5375345276.24.1750779004282; Tue, 24 Jun 2025
 08:30:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250523134025.75130-1-ulf.hansson@linaro.org>
 <fd4cfe7a-e29b-4237-b82f-48354deead3b@ideasonboard.com> <CAPDyKFpprO=HGuiHX3MQ_+m1YRnaWG=XwCx8-fSdXak8VBDUbQ@mail.gmail.com>
 <CAPDyKFpXcpwkacnYqWz2vxaTd7pW5bSRa2F063BryFxVNEAmPA@mail.gmail.com> <CAMuHMdXGS+efbbQ_Pn1iYhQ1aWc_DuJ-CBN=jxfjwOWxTRx+9Q@mail.gmail.com>
In-Reply-To: <CAMuHMdXGS+efbbQ_Pn1iYhQ1aWc_DuJ-CBN=jxfjwOWxTRx+9Q@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 24 Jun 2025 17:29:27 +0200
X-Gm-Features: Ac12FXxfHF_RfveQAeQ0ntPO20zA_1gHc1ii1mqp7uJj4D3vjCp3dlPLBhgbDVo
Message-ID: <CAPDyKFoJHFuY278eEobje4TOv_+-i966H2OuP9fqHMLLevb0qw@mail.gmail.com>
Subject: Re: [PATCH v2 00/21] pmdomain: Add generic ->sync_state() support to genpd
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Saravana Kannan <saravanak@google.com>, 
	Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Michael Grzeschik <m.grzeschik@pengutronix.de>, Bjorn Andersson <andersson@kernel.org>, 
	Abel Vesa <abel.vesa@linaro.org>, Peng Fan <peng.fan@oss.nxp.com>, 
	Johan Hovold <johan@kernel.org>, Maulik Shah <maulik.shah@oss.qualcomm.com>, 
	Michal Simek <michal.simek@amd.com>, Konrad Dybcio <konradybcio@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Jun 2025 at 17:06, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Ulf,
>
> On Mon, 23 Jun 2025 at 16:21, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > On Thu, 19 Jun 2025 at 13:40, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > On Fri, 13 Jun 2025 at 12:33, Tomi Valkeinen
> > > <tomi.valkeinen@ideasonboard.com> wrote:
> > > > On 23/05/2025 16:39, Ulf Hansson wrote:
> > > > > Changes in v2:
> > > > >       - Well, quite a lot as I discovered various problems when doing
> > > > >       additional testing of corner-case. I suggest re-review from scratch,
> > > > >       even if I decided to keep some reviewed-by tags.
> > > > >       - Added patches to allow some drivers that needs to align or opt-out
> > > > >       from the new common behaviour in genpd.
> > > > >
> > > > > If a PM domain (genpd) is powered-on during boot, there is probably a good
> > > > > reason for it. Therefore it's known to be a bad idea to allow such genpd to be
> > > > > powered-off before all of its consumer devices have been probed. This series
> > > > > intends to fix this problem.
> > > > >
> > > > > We have been discussing these issues at LKML and at various Linux-conferences
> > > > > in the past. I have therefore tried to include the people I can recall being
> > > > > involved, but I may have forgotten some (my apologies), feel free to loop them
> > > > > in.
> > > > >
> > > > > I have tested this with QEMU with a bunch of local test-drivers and DT nodes.
> > > > > Let me know if you want me to share this code too.
> > > > >
> > > > > Please help review and test!
> > > >
> > > > I tested this Renesas white-hawk board, and it hangs at boot. With
> > > > earlycon, I captured with/without boot logs, attached.
> > > >
> > > > The hang case doesn't look very healthy with all these: "kobject:
> > > > '(null)' ((____ptrval____)): is not initialized, yet kobject_get() is
> > > > being called."
> > >
> > > Tomi, thanks a lot for helping out with testing!
> > >
> > > rcar_gen4_sysc_pd_init() calls pm_genpd_init() and
> > > of_genpd_add_provider_onecell().
> > >
> > > rcar_gen4_sysc_pd_init() is an early_initcall, which I guess is the
> > > reason for these problems, as the genpd_provider_bus has not been
> > > registered that early (it's done at core_initcall)
> > >
> > > Do you think it would be possible to move rcar_gen4_sysc_pd_init() to
> > > a postcore/arch_initcall?
> >
> > I did some investigation around this and found that both
> > drivers/pmdomain/renesas/rcar-gen4-sysc.c and
> > drivers/pmdomain/renesas/rcar-sysc.c are registering their genpd
> > providers at the early_initcall() level.
> >
> > I was trying to find (by browsing renesas DTSes and looking into
> > drivers) if there is any consumers that actually relies on this, but
> > so far the earliest consumer I have found is the
> > drivers/irqchip/irq-renesas-irqc.c, but that's at postcore_initcall().
> > Of course, it's difficult to say if my analysis is complete as there
> > are a lot of platform variants and I didn't check them all.
> >
> > Maybe we should just give it a try and move both two drivers above to
> > postcore_initcall and see if it works (assuming the irq-renesas-irqc
> > supports -EPROBE_DEFER correctly too).
> >
> > If this doesn't work, I think we need to find a way to allow deferring
> > the call to device_add() in of_genpd_provider_add*() for genpd
> > provider's devices.
>
> Commit dcc09fd143bb97c2 ("soc: renesas: rcar-sysc: Add DT support for
> SYSC PM domains") explains:
>
>    "Initialization is done from an early_initcall(), to make sure the PM
>     Domains are initialized before secondary CPU bringup."
>
> but that matters only for arm32 systems (R-Car Gen1 and Gen2).
> Arm64 systems (R-Car Gen3 and Gen4) use PSCI for CPU PM Domain control.

Geert, thanks a lot for providing these details and helping out, much
appreciated!

>
> While changing rcar-sysc.c to use a postcore_initcall indeed moves PM
> Domain initialization after secondary CPU bringup, the second CPU core
> on R-Car M2-W is still brought up fine.
>
> For R-Car H1, there is a regression:
>
>     smp: Bringing up secondary CPUs ...
>     CPU1: failed to boot: -19
>     CPU2: failed to boot: -19
>     CPU3: failed to boot: -19
>     smp: Brought up 1 node, 1 CPU
>     SMP: Total of 1 processors activated (500.00 BogoMIPS).
>
> CPU bringup/teardown in userspace using
> /sys/devices/system/cpu/cpu*/online still works.
> R-Car H1 was never converted to use "enable-method" in DT, and relies
> on calling into the rcar-sysc driver directly (see [1]).  However,
> that does not use any actual calls into the genpd core, so probably it
> can be made to work by splitting rcar_sysc_pd_init() in two parts: an
> early_initcall() that allocates all domain structures and populates the
> internal hierarchy, and a postcore_initcall() that registers everything
> with the genpd core.

Yes, that seems like a viable option.

Unless you prefer to have a stab at it, I intend to look into it and
make the patch(es) part of a new version of the $subject series. Of
course I am still relying on your help with testing/review.

>
> As expected, there is no impact on R-Car H3 ES2.0.
> I will test on R-Car V4M tomorrow, but expect no issues.
>
> FTR, drivers/pmdomain/renesas/rmobile-sysc.c uses core_initcall().
> Changing that to postcore_initcall does not seem to make a difference
> (on R-Mobile A1).

Okay, it sure looks like we should be able to take care of this
problem for the Renesas platforms. That's great!

That said, it seems like we should also add some internal check in
genpd to see whether the genpd_provider_bus has been registered,
before we try to add devices to it. Then, perhaps log a warning and
return -EPROBE_DEFER if we hit  that case.

>
> [1] https://elixir.bootlin.com/linux/v6.15.3/source/drivers/pmdomain/renesas/rcar-sysc.c#L439
>

Kind regards
Uffe

