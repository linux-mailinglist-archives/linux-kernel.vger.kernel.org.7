Return-Path: <linux-kernel+bounces-844676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D0077BC278A
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 21:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 499CD4EE108
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 19:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7101E223715;
	Tue,  7 Oct 2025 19:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VynVlLQz"
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD29945C0B
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 19:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759864028; cv=none; b=fbShI8F29PhiRTWwrzwufwFeU80HnNl/rrvnXJYCUI4mx6CL2e8sOuvrz86Y7EHognetYkTZo5DAsGL68/zPnlBiv7iMjsIXMO9GH7+kY+tgXK5bEbZdOXTgIySLeSutkIFMXMNdWuSTKI2NqzZh4QteWv3yGcSqZACrJz9iFQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759864028; c=relaxed/simple;
	bh=oW4P1sn0WRvjSmxNJBgf4iF9/kJoF6IXu574tDnahP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dOMv/Bv/asOO+05RHb6DpavaDaIbWPmWQKjc1e9jWzWKBpBK22CwtHYLncG/t3oGuxgUuIfSuFUeKDGZgfrfhiCKKEzmzQmam3CUThT4EyTnFMAXsIH3b/3ZDlKooZP6AmWdD5aHHtcXsGadJn6VYV9gfP71ZIni1sxXRR48X4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VynVlLQz; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-6353ff1a78dso6307810d50.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 12:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759864026; x=1760468826; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7iUti3RModmlHi7jtpIcdt26BPjskgCGc5piTAZQzxA=;
        b=VynVlLQztGZVyIckPrhuQJ++lotTVbgQFIvI1wrUd18F61wEJ1s1HChMnFKOJAdl9f
         XZmUCUJS64DSwV2wBstrKLf9ckM+78R6kXVjvhQ+if9bDs51iW6u9xs8/3eskZc45Vxt
         PGYzi6dekcFrcDKUef1zdOXn4IdExMTnj4/N5MP9bI2KLjftrGpYxwLs3ScPEGMNJlp+
         pZGIvQP+QGhsRuVroF46sjVTd4mOdCdwjUO/hc1BiH7+mlJ75D84tnxIJTAr5/7AIeSK
         V/YgG+SlxFifFkDLjb+x9tmklqbGw+G+cjU/E5N7x1QkPhbc5p9QmnOl21uuUTNri/0x
         tp/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759864026; x=1760468826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7iUti3RModmlHi7jtpIcdt26BPjskgCGc5piTAZQzxA=;
        b=a2nxOEVbeeju7b+5+WsJb/pXecto3YmOJk5AwXSASshNtcdPVUQ0SvY2IanlWvTT+x
         4b09m64l9TNS99+I3GjlpO3a2lhM7pADLVOR5LPJQmZ+MbCK3YhxCuqL3Qb7ihT+VaOW
         HfB9kM6cu8sUaHHtj7qZMkcW7IDGHNzO19xsca3jO0uA7aeMLGngRazFKz0TmxcHU4KE
         IoRf6qJoUjLVB0pz0W1grAlcteQjyrPH21SxcBjMYibcfdYfriQ/TCdehwSL7hjoewyh
         nIwCFjFqbcWYV1WNbINark2O1YZZ8CAPJs35deD7mC8AmXEytjjWEduMTnEH0MsaZ/jJ
         XNtw==
X-Forwarded-Encrypted: i=1; AJvYcCUTcWRDsc9hFiZH+idWuuDJ3Wi7MO2Yh4WGu0+ijvF9QBOXpUPN82giNAvgBBz58r/GYccWErTb60GR7vI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8TOLN6ukt97AS28HX28WHZXw2ztKmAKiWJiiGsrNMxNtALMmC
	QKUaa+ZSzJRX2wmlkSenP+wH8Wlvy0a1MFaChskOQpwnV2Esr5k5qcgVEIm58o/QTk+U2vKNBrm
	w2VJ55BOXe/SBL/t0kV1288HoOb/eeWp5aHIEiGAcFA==
X-Gm-Gg: ASbGncuD0WJTNartD93epiD9Lc3mLCEtm/JyUAWsY3g3d38dafT5NksGC9Qh8gzG/vJ
	WhbNuy/M1XHzbTGP39FAzgLYCvFcncCccX6yHkxJTwtUnIEt050cU9FsrsWKXtgQRg6SWMJyMoB
	js54cnIVLBrQNFxwM4pxE0jmVEZaQOauf1VOukLryZiKdfVv0QoU7WYTJSh30x3ZPc+psBG56MY
	VwOsxMMW0GhpIG+lXlt7qjJzYEsAbah4g==
X-Google-Smtp-Source: AGHT+IHGabCWkJ+CSgQuNpDDGJm5CBq1o8eRFzjGkU0N7AFW1WICocRBQKTnUVXzNlv6ZZDS/IDRlDvAToOZJFwsXgE=
X-Received: by 2002:a53:c64b:0:b0:629:ec90:c446 with SMTP id
 956f58d0204a3-63ccb8240e3mr675987d50.12.1759864025589; Tue, 07 Oct 2025
 12:07:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002-gs101-pmu-regmap-tables-v1-0-1f96f0920eb3@linaro.org>
 <20251002-gs101-pmu-regmap-tables-v1-3-1f96f0920eb3@linaro.org>
 <CAPLW+4nvuGd8AoDKK1VdF2pabCHzjgYHRJkYrcncRt4s=qt8Dw@mail.gmail.com> <2c36d66dc3eaf8f0f9778dd6a1d45806e7d9bcdd.camel@linaro.org>
In-Reply-To: <2c36d66dc3eaf8f0f9778dd6a1d45806e7d9bcdd.camel@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 7 Oct 2025 14:06:54 -0500
X-Gm-Features: AS18NWBO7FvM4SL8eDmLZftkdQk-t8hGwCLxZkF8ye__N3jbcGABazPA6EkFfAk
Message-ID: <CAPLW+4mmbtFvdyijMQ+xG1S_FQeZyHt+cYJgycWTmpsnNNmamg@mail.gmail.com>
Subject: Re: [PATCH 3/3] soc: samsung: gs101-pmu: implement access tables for
 read and write
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Peter Griffin <peter.griffin@linaro.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 2:06=E2=80=AFAM Andr=C3=A9 Draszik <andre.draszik@li=
naro.org> wrote:
>
> On Fri, 2025-10-03 at 13:24 -0500, Sam Protsenko wrote:
> > On Thu, Oct 2, 2025 at 5:33=E2=80=AFAM Andr=C3=A9 Draszik <andre.draszi=
k@linaro.org> wrote:
> > >
> > > Accessing non-existent PMU registers causes an SError, halting the
> > > system.
> > >
> > > Implement read and write access tables for the gs101-PMU to specify
> > > which registers are read- and/or writable to avoid that SError.
> > >
> > > Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> >
> > I think having "Fixes:" tag would be justified here?
>
> I decided against, because IMHO it's not a bug fix as such, it's a new fe=
ature.
> >
>
> > > ---
> > > Note there are checkpatch warnings 'Macros with complex values should
> > > be enclosed in parentheses' and 'Macro argument reuse' for macros lik=
e
> > > CLUSTER_CPU_RANGE(). Since they are used in an initialiser, the only
> > > way to get rid of the warnings is to avoid the macros and duplicate a=
ll
> > > the related register ranges I believe, which I'd rather not due to th=
e
> > > sheer amount of similar blocks.
> > > ---
> > >  drivers/soc/samsung/gs101-pmu.c             | 306 ++++++++++++++++++=
++++++-
> > >  include/linux/soc/samsung/exynos-regs-pmu.h | 343 ++++++++++++++++++=
+++++++++-
> > >  2 files changed, 640 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/drivers/soc/samsung/gs101-pmu.c b/drivers/soc/samsung/gs=
101-pmu.c
> > > index b5a535822ec830b751e36a33121e2a03ef2ebcb2..5be1cbfa58c95e466bbdf=
954923f324f74460783 100644
> > > --- a/drivers/soc/samsung/gs101-pmu.c
> > > +++ b/drivers/soc/samsung/gs101-pmu.c
> > > @@ -8,6 +8,7 @@
> > >  #include <linux/array_size.h>
> > >  #include <linux/soc/samsung/exynos-pmu.h>
> > >  #include <linux/soc/samsung/exynos-regs-pmu.h>
> > > +#include <linux/regmap.h>
> >
> > If you decide to add this line to exynos-pmu.h (as I commented in the
> > preceding patch), it can then be omitted here.
> >
> > >
> > >  #include "exynos-pmu.h"
> > >
> > > @@ -19,9 +20,312 @@
> > >  #define TENSOR_PMUREG_WRITE            1
> > >  #define TENSOR_PMUREG_RMW              2
>
> [...]
>
> > > +#define CLUSTER_NONCPU_RANGE(cl)                                    =
   \
> > > +       regmap_reg_range(GS101_CLUSTER_NONCPU_IN(cl),                =
   \
> > > +                        GS101_CLUSTER_NONCPU_IN(cl)),               =
   \
> > > +       regmap_reg_range(GS101_CLUSTER_NONCPU_INT_IN(cl),            =
   \
> > > +                        GS101_CLUSTER_NONCPU_INT_IN(cl)),           =
   \
> > > +       regmap_reg_range(GS101_CLUSTER_NONCPU_DUALRAIL_CTRL_IN(cl),  =
   \
> > > +                        GS101_CLUSTER_NONCPU_DUALRAIL_CTRL_IN(cl))
> > > +
> > > +       CLUSTER_NONCPU_RANGE(0),
> > > +       CLUSTER_NONCPU_RANGE(1),
> > > +       CLUSTER_NONCPU_RANGE(2),
> > > +       regmap_reg_range(GS101_CLUSTER_NONCPU_INT_EN(2),
> > > +                        GS101_CLUSTER_NONCPU_INT_DIR(2)),
> > > +#undef CLUSTER_NONCPU_RANGE
> > > +
> > > +#define SUBBLK_RANGE(blk)                                           =
   \
> >
> > Reusing the same names for different macros seems a bit confusing. But
> > that might be just a matter of my taste, so no strong opinion.
>
> And I OTOH explicitly picked the same name because it's the same block, j=
ust
> for r/o instead of r/w :-)
>
> [...]
>
> >
> > That's quite an extensive list of registers! Does this PMU driver
> > really have to cover all of those?
>
> That's what all Samsung PMU drivers do, it's the PMU region after all. Al=
so,
> in the gs101 case, only the PMU driver knows how to do the secure access:=
 Various
> other drivers have references to this PMU regmap, e.g. phy drivers for is=
olation
> (USB & UFS) and upcoming PD driver will do too. We don't want to reimplem=
ent
> secure access in all of those.
>

Ok, thanks for explaining this.

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

> Cheers,
> Andre'

