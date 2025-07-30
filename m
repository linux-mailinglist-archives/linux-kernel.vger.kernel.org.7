Return-Path: <linux-kernel+bounces-750570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2D6B15E2D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 12:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6716E16A79D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 10:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2226226B95A;
	Wed, 30 Jul 2025 10:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JBzaE8mt"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6ACE21323C
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 10:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753871394; cv=none; b=asK9uPr7u+2f7adOxL1SH1OW3epbvMiqJPXlXBtEU4Zh/8uc1af36D3CUtxJg6EhoTUAOHVMvawqjP/zp3osCkKX+D85fE8nzvvCurRnXnk8LTVgOLOGkIUHxboo4KTBt85kz+lMGrSiEtWpM5+8U83Qplv4zTW81DmEe6y149Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753871394; c=relaxed/simple;
	bh=g32rR9qU4kIiq4ZDdhalVntuHNQUFPPPoLfAdLm96tM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qKoAV7l+plAlAgvh70eLLZtSBasscoWJtx6BTdfLi7xcj8R//2TH23AHwhMnaHBkJRBdXS0P6Unc1GawZIXEC5B8VevmjW5f0othSqNJkLU2hZNUCGWSxRCErB5yBsWf03v2cti4E/s2TSgfM8rdi6aS1BYRXsS4LnALLLcAu4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JBzaE8mt; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-719f5a141a3so4894547b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 03:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753871392; x=1754476192; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8DfRGBX3mcpytWgeuQOoQcWlLUxxXP7ehgwEP8S8+jQ=;
        b=JBzaE8mtJ3Ny2bHKAB30lPQDy6AaMbEqiAEki77two5pZm+C3NT/o1khfRr8Hr5hpB
         iTecnffx+lLkLzO7BadFmMgBJcxYzmKYq/UsTJ4jBS6C08L4ynvd9xH/FjZiBN6kPen9
         4NThFlbcG5c/EV5Eqtkc3I+wyV7R64ghPBPMKYRZaeYDj5kf155ocwhLrbhKXGeCxK/p
         ukV3m2kivRp754NLy7GFzIbh1VQ8F/vIJpNUNsdQ3eLJSJCXj3mYMtjB8V8bZyjlskLb
         RPQpbHGraTLpy5zN/r3LlpyAzgfsA+xpjcvJsbi2WSpWrF9MQjBdO2dgcukFbf1SXFDW
         8buQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753871392; x=1754476192;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8DfRGBX3mcpytWgeuQOoQcWlLUxxXP7ehgwEP8S8+jQ=;
        b=psVtArXm9D1XYAOLoB9DJ06bra+BRq9vS5nDXZhw9WpDtH69jo7lDCN+vOHcNkOugi
         ILhvsdpFAVvjDuzrPj5lpZ2CvS8pEMaAOMLA+ejsYOrQ2i++3zA3bi9vVDPFIePr2O/6
         5dd7e4J1CDAisuyw7sFEkAD4BYEFWF7pkTVlbG75+7r0ozwtaEuAwtaWz58wWP/lIIXI
         63Q+Yu9vlBAos2T8SmaYr+3SkOotuC/hzdkFomoBaIyRFzcCXU6NYYQNVbnWagPUJ6Zt
         o+jSHb8GCDAvhi61ofB8wzCBgMxXqlyZwJa4iW37Pjfaeo3bP7ki4HkRhs/QEpWqn5od
         Px4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXaBrialQBJ90DsMzA84n1HNHS/r+ZegApHFOOHnZQZOYqDn1Dn5R6er3v+xYqSRytgOtib1gMjaqhyndc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCNYfX97QkVPpns6h2Bt5aVHaDbkexl2T2dFWhVt6U9ZQDt2he
	nrp0Ch9U723vvSVaAaP02+KHIkyIWnhFd2zL/Xz280mCR9McizKeHJl46VezZj6ctKQMxWwBlOl
	1tiuCnNVDLi38MmoIvNnVVijiCS8YAZB72gWZeRGa1w==
X-Gm-Gg: ASbGncs9g4NJ9OiIYt2PB5uqsE+oXCmheqXRvtct/Tj2b+ApNtR6wOXH/N18bIS23th
	rD1hHjaWKBAz1RRUJnabHOQN9r72qEQSFj/6qW3IIlCFnkMMVw3B2At/MwarBseMsFxe9faoem1
	80G1HS8b1YZMA/AhHhjiX78X7GQ+d3r1eDiHz6E36SrnDEAsshyirzaaoBAnRflhT2bTlDBrGbr
	8MifsMiJiC8soHipTU=
X-Google-Smtp-Source: AGHT+IGFQjbmfwQ2KygX5zLfPtAfVRDoKZEoCDWpl15Tj6cbjvtyN/moXAbjn/fUqackhgtTl9hi4qXu0QdfTHnMzRw=
X-Received: by 2002:a05:690c:3686:b0:71a:2178:3e70 with SMTP id
 00721157ae682-71a4745d2abmr37909517b3.8.1753871391946; Wed, 30 Jul 2025
 03:29:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701114733.636510-1-ulf.hansson@linaro.org>
 <CAPDyKFr=u0u2ijczExkntHK1miWZ6hRrEWBMiyUwShS3m6c29g@mail.gmail.com> <CAMuHMdX1BacUfqtmV8g7NpRnY9aTdL=fh+jC7OryMLz4ijaOCg@mail.gmail.com>
In-Reply-To: <CAMuHMdX1BacUfqtmV8g7NpRnY9aTdL=fh+jC7OryMLz4ijaOCg@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 30 Jul 2025 12:29:13 +0200
X-Gm-Features: Ac12FXyYhnc-5Yj1CQN0T9Q5i6IKPQAs_4KsBvKN_tu1xC2bA9MW4FBogdA1snU
Message-ID: <CAPDyKFqANQZmGXd8ccA5qWiGrCor2N=W_7dmV+OK8hMd_+zmmw@mail.gmail.com>
Subject: Re: [PATCH v3 00/24] pmdomain: Add generic ->sync_state() support to genpd
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Saravana Kannan <saravanak@google.com>, Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org, 
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

On Wed, 30 Jul 2025 at 11:56, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Ulf,
>
> On Wed, 9 Jul 2025 at 13:31, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > On Tue, 1 Jul 2025 at 13:47, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > Changes in v3:
> > >         - Added a couple of patches to adress problems on some Renesas
> > >         platforms. Thanks Geert and Tomi for helping out!
> > >         - Adressed a few comments from Saravanna and Konrad.
> > >         - Added some tested-by tags.
> >
> > I decided it was time to give this a try, so I have queued this up for
> > v6.17 via the next branch at my pmdomain tree.
> >
> > If you encounter any issues, please let me know so I can help to fix them.
>
> Thanks for your series!  Due to holidays, I only managed to test
> this very recently.
>
> Unfortunately I have an issue with unused PM Domains no longer being
> disabled on R-Car:
>   - On R-Car Gen1/2/3, using rcar-sysc.c, unused PM Domains are never
>     disabled.
>   - On R-Car Gen4, using rcar-gen4-sysc.c, unused PM Domains are
>     sometimes not disabled.
>     At first, I noticed the IOMMU driver was not enabled in my config,
>     and enabling it did fix the issue.  However, after that I still
>     encountered the issue in a different config that does have the
>     IOMMU driver enabled...
>
> FTR, unused PM Domains are still disabled correctly on R/SH-Mobile
> (using rmobile-sysc.c) and on BeagleBone Black. Note that these use
> of_genpd_add_provider_simple(), while all R-Car drivers use
> of_genpd_add_provider_onecell().  Perhaps there is an issue with
> the latter?  If you don't have a clue, I plan to do some more
> investigation later...

Geert, thanks for reporting!

>
> BTW, the "pending due to"-messages look weird to me.
> On R-Car M2-W (r8a7791.dtsi) I see e.g.:
>
>     genpd_provider ca15-cpu0: sync_state() pending due to e6020000.watchdog
>     renesas-cpg-mssr e6150000.clock-controller: sync_state() pending
> due to e6020000.watchdog
>
> ca15-cpu0 is the PM Domain holding the first CPU core, while
> the watchdog resides in the always-on Clock Domain, and uses the
> clock-controller for PM_CLK handling.

I will have a closer look as soon as I can  to see if I can find some
potential problems.

Kind regards
Uffe

