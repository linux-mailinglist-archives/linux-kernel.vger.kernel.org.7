Return-Path: <linux-kernel+bounces-833671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B802EBA29E6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 09:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C989B18979DD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 07:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4EA284693;
	Fri, 26 Sep 2025 07:04:18 +0000 (UTC)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1866280308
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 07:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758870258; cv=none; b=DWVpPLF8lFMC1GaUyIqsfrxJdYiXKKjhQLwFmyCekEDSlsxwJBkbWFoCQrEcU69sRyL5nqheYYR2uo2r0A5PnkYOmfbwN52x+Z8ldT6gP4qgxf3EvB0ocV+16yVswtARw9k1iNSCTdhLRfspcHdfL+vMOy4VzihoZrT1lh74uN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758870258; c=relaxed/simple;
	bh=dw8VodF5d0G5wyZprT1Cfu9CVLPEqqgX7pSeump3QdM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N7rDAU4zv2igV98JEGB/mgYEFsx2VLk8pBiEbyqwQq2whoA7zSkEshuP+Md+94uc2/s4eHCpfLoHCXDCV+8naeE1Cct6pRd2laAeZBU6FStmBkxq96vMga2nG8YUyGu1S0Fqrp0c3ipK5fOPRg8VvueJsKRGsDaL0+2fo3za/Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4b7a967a990so20301661cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 00:04:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758870255; x=1759475055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vjQDtyvvVNH5A+YlQavoDIDNO01bRK+FCcEXT++J39I=;
        b=oAT01e0DiKLA/AaUEFkR+iomROL5IcL+COXZIFytECohVOJOV01vL9Uho0rygzexPT
         oLHBL7GnmvTUIirgXUVlpDXuFgduhd5UOWe7DwQ7ma8TrnPNj8VK/BgI4lSSoT9f8yAX
         a6Ky63/pIgycU/UILz/oK0l4ivgaQY8RLtq8tLkME8OedkZRakbLXAshcSveKXJ4TYXS
         S503fw3OX88/fr18SR3xI9rLzXe77wzTmYKlkOQjAi7WPMT30YswAtK1Sj//edqKMFR4
         qjroFr4ERWsMsz42nV5mydNV1AWkD2hsz9Ed4YIqilxFhf0sXlucDVo/tklMjXZsL2da
         XedA==
X-Forwarded-Encrypted: i=1; AJvYcCUX+okCEQX7K7MnwxgkxST1y1z+2jyV10wxkyto6zquDMooTAcZig7sZVg0DmCV6AAbDrUeoUQIq2CW38w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw34f8zaWRg9cat7HsdyLdEqLtQnqTtgxLH7UagTXdsdcnYWOyF
	HYw56u8F6QAfFdVb9srB11YeMDeQh+GfkvYSxQnHP2jN4O1n655e+YPoGmdYTr5p
X-Gm-Gg: ASbGncuRPWsmMP8NTQm+FDGDKuSXKU/S/5XdJFVWiWxxpRlUGGr2tnfojNk3Zv3pklX
	pNNAlQ8LV4xMOdMdTHypnyP8eCSuNzZCZVjKNRb9uaYH28SR0yN0fH9mSwZRMwAbcBp2eub4vwi
	m0yk2ioeUx2HayQ7OLX6UxnmfYWmiY42SCMTEcmBLFd/QwKD2MN+B9HbSzGwaOudSCfy4Lqwraq
	TBdRisbkPPHGFk84DoEfF9MBe/esi6G3dRARc6V3LFauG6ab1qf5IAwe5VJGi90p+1nHU2/jlo0
	nypaFq/m4jYUdyj3VglzGo4M66je4Ztj1xg40lsMm0Ed99dLEda3qz1Paler5VCSDgBCm31PUW0
	wEzw34o+FykpLztBruduB8jqnGKaX30aVB4waX23T1ldue7ceNjSVe1w5XjlehdlD7aPtEnYDJi
	c=
X-Google-Smtp-Source: AGHT+IFyGQrGZ8BNBRBZjNAj8ScS0gD6mBlgps6+tVwAmJQeL7w9RALlkpSOgjQy9TrpoAGnhyBC0g==
X-Received: by 2002:a05:6214:242a:b0:7a6:a9a4:c1a9 with SMTP id 6a1803df08f44-7fc440079cdmr67548726d6.64.1758870255270;
        Fri, 26 Sep 2025 00:04:15 -0700 (PDT)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com. [209.85.160.174])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-801f4df8a4csm22098276d6.49.2025.09.26.00.04.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Sep 2025 00:04:15 -0700 (PDT)
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4b7a967a990so20301421cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 00:04:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU1SK1aP3SRCIeOVue1yf4ATT2tVMcLbhA8nD1fl0Qss7fE88XDfuzic2CKJGOh20dSj2Ck1UmrRnmgppU=@vger.kernel.org
X-Received: by 2002:a05:6102:442c:b0:5a3:6a6f:21ad with SMTP id
 ada2fe7eead31-5acd0182a34mr2333473137.30.1758869876161; Thu, 25 Sep 2025
 23:57:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701114733.636510-1-ulf.hansson@linaro.org>
 <CAPDyKFr=u0u2ijczExkntHK1miWZ6hRrEWBMiyUwShS3m6c29g@mail.gmail.com>
 <CAMuHMdX1BacUfqtmV8g7NpRnY9aTdL=fh+jC7OryMLz4ijaOCg@mail.gmail.com>
 <CAPDyKFqANQZmGXd8ccA5qWiGrCor2N=W_7dmV+OK8hMd_+zmmw@mail.gmail.com>
 <CAMuHMdVrkr56XsRsbG7H-tLHVzmP+g-7=5Nrv9asC25ismwiYA@mail.gmail.com> <CAGETcx-L-KypYZEkdKRBfZHDhFMTUuwKEGVQ-7QPv=++6uwLSw@mail.gmail.com>
In-Reply-To: <CAGETcx-L-KypYZEkdKRBfZHDhFMTUuwKEGVQ-7QPv=++6uwLSw@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 26 Sep 2025 08:57:45 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWjhXjjw9wFw5Me-wAX0nA+gK2mdGxLyBJJCWDHZ58LeQ@mail.gmail.com>
X-Gm-Features: AS18NWD2sqCNW31Hr76xpW5m_kx80ye1q9D4_pFDoOhvkwDietXEmUuVKInRsEY
Message-ID: <CAMuHMdWjhXjjw9wFw5Me-wAX0nA+gK2mdGxLyBJJCWDHZ58LeQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/24] pmdomain: Add generic ->sync_state() support to genpd
To: Saravana Kannan <saravanak@google.com>
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

Hi Saravana,

On Fri, 26 Sept 2025 at 00:41, Saravana Kannan <saravanak@google.com> wrote=
:
> On Thu, Aug 7, 2025 at 2:43=E2=80=AFAM Geert Uytterhoeven <geert@linux-m6=
8k.org> wrote:
> > On Wed, 30 Jul 2025 at 12:29, Ulf Hansson <ulf.hansson@linaro.org> wrot=
e:
> > > On Wed, 30 Jul 2025 at 11:56, Geert Uytterhoeven <geert@linux-m68k.or=
g> wrote:
> > > > BTW, the "pending due to"-messages look weird to me.
> > > > On R-Car M2-W (r8a7791.dtsi) I see e.g.:
> > > >
> > > >     genpd_provider ca15-cpu0: sync_state() pending due to e6020000.=
watchdog
> > > >     renesas-cpg-mssr e6150000.clock-controller: sync_state() pendin=
g
> > > > due to e6020000.watchdog
> > > >
> > > > ca15-cpu0 is the PM Domain holding the first CPU core, while
> > > > the watchdog resides in the always-on Clock Domain, and uses the
> > > > clock-controller for PM_CLK handling.
> >
> > Unfortunately the first PM Domain is "ca15-cpu0", which is blocked on
> > these bogus pending states, and no PM Domain is powered off.
>
> Can you explain why you call these as bogus? Sorry if you already
> explained it. But the reason I'm asking is to see if you can set a
> flag for the watchdog device so fw_devlink will completely ignore it.

"bogus" refers to "1." below.

Furthermore, devices that are located in an alway-on domain should
not block the sync state.

> It looks like there's a driver for this watchdog node? Why is it not
> probing then?

Because this particular revision of the SoC has a hardware bug that
prevents the watchdog timer from rebooting the system, and the driver
detects that.

Anyway, if the driver is not available, unused power domains should
still be powered down, like before.

> > If I remove the "sync_state =3D false" above, genpd_provider_sync_state=
()
> > considers all domains, and does power down all unused domains (even
> > multiple times, as expected).
> >
> > Upon closer look, all "pending due to" messages I see claim that the
> > first (index 0) PM Domain is pending on some devices, while all of
> > these devices are part of a different domain (usually the always-on
> > domain, which is always the last (32 or 64) on R-Car).
> >
> > So I think there are two issues:
> >   1. Devices are not attributed to the correct PM Domain using
> >      fw_devlink sync_state,
>
> Is it a fw_devlink issue? Or is this a multi-domain controller?

This is a multi-domain controller.

> >   2. One PM Domain of a multi-domain controller being blocked should
> >      not block all other domains handled by the same controller.
>
> This is going to take a while to sort out. But the current behavior is
> the safest. How grumpy will you be if we don't fix this :)

Depending on your definition of "safe".  Keeping all power domains on
increases power consumption and heat generation, and may cause e.g. CPU
frequency throttling to kick in, slowing down operation of the system.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

