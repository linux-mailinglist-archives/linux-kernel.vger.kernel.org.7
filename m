Return-Path: <linux-kernel+bounces-833410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C0EBA1E11
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 00:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C1B97B5E58
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 22:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4F6320CCF;
	Thu, 25 Sep 2025 22:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t4noGknX"
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADD5321287
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 22:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758840108; cv=none; b=sEWFcIcplKO8J4hStnAVr+8d/RRf9uCQBitqCewhLLYL/gb/+0inBqg1G1FZStgHo3j7++swKnQpfdJXti+fruGokdYmKu0KvaaPtpYH8nEquR7YptdVP7/FnDYAVxB1Ku+4kJqU/9vgMUD5RG6JZwCD7lBdjBZIuiTp+XoP1Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758840108; c=relaxed/simple;
	bh=IMpuqL+3zUJultws4a8raft+G3Pwvu3TMoBeoCFUSog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bvuadQ7FH9lB0I5F9Kf9scEw9hxFTBASkjzoPydK/YB8zWjjAGgPCX1w3YZaBe453v0TtKtxTl5ioJODnfTY+57Ju9eUXPok1uA9ZtPpuw7ZGPzbqKSnwaMP5N7yY5w2a98R6sqpBqm+qmh5msSAeVHrM/MCmrBd12RsxNuB/CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t4noGknX; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-5570a77eabcso1328144137.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 15:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758840105; x=1759444905; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wHj+PHiUkQISWl2G0dz1sK7qOqKWgrZbDfjsc28nwu8=;
        b=t4noGknXG4sgimhqxh412h+45xPXesmb7nZXy32FWrPX2/Cd1uA8jl4jUFa2Ef46UN
         9YWPfGjFu1cGYV2p9yiVuOy9U61UjcjMuywYyE+74Wz+/rY+CuEAIm15lXKhw7rat9+Y
         4UmX3QaKdPMkyNujVd1SCKr60i7RZzuzHy4HJUDncGAW39M2UlBVTKATFSebPpKUc7u0
         /Djbglhd+Y9l5fibAy4gAtHlgOxtsNxm92csb1asTKL5u28kQ4PZMfjVMkrWRGLtlLyg
         JYWJUXtPNzTRkUBqy+0Iut9hPXPmVVuiH/UDCe734hyVBhZb20tHELaGfiQz6ZarhvpS
         bnbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758840105; x=1759444905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wHj+PHiUkQISWl2G0dz1sK7qOqKWgrZbDfjsc28nwu8=;
        b=JPoP29VEMacqpr3BYDQVmUkYvKnMwRwEQ633FyfgX8/nm0x6Sq3whRIrpaLJGzYIX2
         GJN8MZUgqcY1rcY/C2a74B8jEXGFOQ/2+nxTmtbH40wMLgWWmpL0sT+ezu2dB9xOiHQC
         qk/O6NhK86RkgzjXtMkLSza7kH52T9FSJc2yIuBCCMA4N6HgUfOE7Pp0xE9yH1NWuL5M
         2gBJVTZpJTjgRtJAY/+SDcW6WQ+QCr3ETWJM8B7z2PX7bCXvqEXUJd9LErroZ1Bu/RVn
         pYL45BVHruxcdiwSXOKZawI3MmMr/R49FkmGHL3ZN477IQDFEdm9TPsp4IKvU0YiuL4F
         WCrQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0d8s7fm9qLI4tFPrepXMJfGkQtupwPuopH/dZf4YIm7YbozVsoRQUYlwzfb4i+KD7XKTVu0XQ7mRRHdc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnrsUz6dykviGhD7Dl+YMt7vkahok+Kgh8zzICor/m8Kt9SpVO
	hLSMSKu2WkeBwDsXhr+CobKg8wR/4PH8gEzfvcLrKAx4kYZCjCQYLtqVhYI77xiMLSxZcVsUESy
	94e69vsLrCj+73FlkZORC5yqBpIlA1+quxplo6Fzr
X-Gm-Gg: ASbGnctNs6oIfUMKP8xNNJ9SkZl8hjgEvNUpURo2mIBOQhsGASpHi2FXFdqPgBevfHu
	nKYCfAibQRz1Yh29Fdy5A0q0fXIddpnKQqExNyZEO1pYOFi5GpHeliHEG4yLw2wjRqDM/7033Ri
	CiRbX+/90TJVymaInd0yfTGD1jKXCardrTMPAo21lJ4ydJYpn+kniMgVuO8qZl0mJpGokqVH4eZ
	TLubjOvf0lsZn1Doz2YeStkyzPKOiVYTc0XWfF3tTfa
X-Google-Smtp-Source: AGHT+IFi53lokqPUYgNEQzye6iKr3Z/ilnrjsL+SFz2i8CrL+Ky7RsH/7p9qRjXS5BHvCfGU8MEeb5NCJ3UDJIWnMK4=
X-Received: by 2002:a05:6102:440b:b0:59d:ad3:e1dc with SMTP id
 ada2fe7eead31-5acc680187emr2556063137.8.1758840104879; Thu, 25 Sep 2025
 15:41:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701114733.636510-1-ulf.hansson@linaro.org>
 <CAPDyKFr=u0u2ijczExkntHK1miWZ6hRrEWBMiyUwShS3m6c29g@mail.gmail.com>
 <CAMuHMdX1BacUfqtmV8g7NpRnY9aTdL=fh+jC7OryMLz4ijaOCg@mail.gmail.com>
 <CAPDyKFqANQZmGXd8ccA5qWiGrCor2N=W_7dmV+OK8hMd_+zmmw@mail.gmail.com> <CAMuHMdVrkr56XsRsbG7H-tLHVzmP+g-7=5Nrv9asC25ismwiYA@mail.gmail.com>
In-Reply-To: <CAMuHMdVrkr56XsRsbG7H-tLHVzmP+g-7=5Nrv9asC25ismwiYA@mail.gmail.com>
From: Saravana Kannan <saravanak@google.com>
Date: Thu, 25 Sep 2025 15:41:07 -0700
X-Gm-Features: AS18NWC2s6ZZ6wCDx3tWilFSoKlhNIqaCYwvZMZVl4k7rQcUFUWgg_k_mrXSjCs
Message-ID: <CAGETcx-L-KypYZEkdKRBfZHDhFMTUuwKEGVQ-7QPv=++6uwLSw@mail.gmail.com>
Subject: Re: [PATCH v3 00/24] pmdomain: Add generic ->sync_state() support to genpd
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Michael Grzeschik <m.grzeschik@pengutronix.de>, Bjorn Andersson <andersson@kernel.org>, 
	Abel Vesa <abel.vesa@linaro.org>, Peng Fan <peng.fan@oss.nxp.com>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Johan Hovold <johan@kernel.org>, 
	Maulik Shah <maulik.shah@oss.qualcomm.com>, Michal Simek <michal.simek@amd.com>, 
	Konrad Dybcio <konradybcio@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Hiago De Franco <hiago.franco@toradex.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 7, 2025 at 2:43=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68k=
.org> wrote:
>
> Hi Ulf,
>
> On Wed, 30 Jul 2025 at 12:29, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > On Wed, 30 Jul 2025 at 11:56, Geert Uytterhoeven <geert@linux-m68k.org>=
 wrote:
> > > On Wed, 9 Jul 2025 at 13:31, Ulf Hansson <ulf.hansson@linaro.org> wro=
te:
> > > > On Tue, 1 Jul 2025 at 13:47, Ulf Hansson <ulf.hansson@linaro.org> w=
rote:
> > > > > Changes in v3:
> > > > >         - Added a couple of patches to adress problems on some Re=
nesas
> > > > >         platforms. Thanks Geert and Tomi for helping out!
> > > > >         - Adressed a few comments from Saravanna and Konrad.
> > > > >         - Added some tested-by tags.
> > > >
> > > > I decided it was time to give this a try, so I have queued this up =
for
> > > > v6.17 via the next branch at my pmdomain tree.
> > > >
> > > > If you encounter any issues, please let me know so I can help to fi=
x them.
> > >
> > > Thanks for your series!  Due to holidays, I only managed to test
> > > this very recently.
> > >
> > > Unfortunately I have an issue with unused PM Domains no longer being
> > > disabled on R-Car:
> > >   - On R-Car Gen1/2/3, using rcar-sysc.c, unused PM Domains are never
> > >     disabled.
> > >   - On R-Car Gen4, using rcar-gen4-sysc.c, unused PM Domains are
> > >     sometimes not disabled.
> > >     At first, I noticed the IOMMU driver was not enabled in my config=
,
> > >     and enabling it did fix the issue.  However, after that I still
> > >     encountered the issue in a different config that does have the
> > >     IOMMU driver enabled...
> > >
> > > FTR, unused PM Domains are still disabled correctly on R/SH-Mobile
> > > (using rmobile-sysc.c) and on BeagleBone Black. Note that these use
> > > of_genpd_add_provider_simple(), while all R-Car drivers use
> > > of_genpd_add_provider_onecell().  Perhaps there is an issue with
> > > the latter?  If you don't have a clue, I plan to do some more
> > > investigation later...
>
> of_genpd_add_provider_onecell() has:
>
>     if (!dev)
>             sync_state =3D true;
>     else
>             dev_set_drv_sync_state(dev, genpd_sync_state);
>
>     for (i =3D 0; i < data->num_domains; i++) {
>             ...
>             if (sync_state && !genpd_is_no_sync_state(genpd)) {
>                     genpd->sync_state =3D GENPD_SYNC_STATE_ONECELL;
>                     device_set_node(&genpd->dev, fwnode);
>                     sync_state =3D false;
>                     ^^^^^^^^^^^^^^^^^^^
>             }
>             ...
>     }
>
> As the R-Car SYSC drivers are not platform drivers, dev is NULL, and
> genpd->sync_state is set to GENPD_SYNC_STATE_ONECELL for the first PM
> Domain only.  All other domains have the default value of sync_state
> (0 =3D GENPD_SYNC_STATE_OFF).  Hence when genpd_provider_sync_state()
> is called later, it ignores all but the first domain.
> Apparently this is intentional, as of_genpd_sync_state() tries to
> power off all domains handled by the same controller anyway (see below)?
>
> > > BTW, the "pending due to"-messages look weird to me.
> > > On R-Car M2-W (r8a7791.dtsi) I see e.g.:
> > >
> > >     genpd_provider ca15-cpu0: sync_state() pending due to e6020000.wa=
tchdog
> > >     renesas-cpg-mssr e6150000.clock-controller: sync_state() pending
> > > due to e6020000.watchdog
> > >
> > > ca15-cpu0 is the PM Domain holding the first CPU core, while
> > > the watchdog resides in the always-on Clock Domain, and uses the
> > > clock-controller for PM_CLK handling.
>
> Unfortunately the first PM Domain is "ca15-cpu0", which is blocked on
> these bogus pending states, and no PM Domain is powered off.

Hi Geert,

Thanks for all the reports as ever!

Can you explain why you call these as bogus? Sorry if you already
explained it. But the reason I'm asking is to see if you can set a
flag for the watchdog device so fw_devlink will completely ignore it.

It looks like there's a driver for this watchdog node? Why is it not
probing then?

>
> If I remove the "sync_state =3D false" above, genpd_provider_sync_state()
> considers all domains, and does power down all unused domains (even
> multiple times, as expected).
>
> Upon closer look, all "pending due to" messages I see claim that the
> first (index 0) PM Domain is pending on some devices, while all of
> these devices are part of a different domain (usually the always-on
> domain, which is always the last (32 or 64) on R-Car).
>
> So I think there are two issues:
>   1. Devices are not attributed to the correct PM Domain using
>      fw_devlink sync_state,

Is it a fw_devlink issue? Or is this a multi-domain controller?

>   2. One PM Domain of a multi-domain controller being blocked should
>      not block all other domains handled by the same controller.

This is going to take a while to sort out. But the current behavior is
the safest. How grumpy will you be if we don't fix this :)

Thanks,
Saravana

