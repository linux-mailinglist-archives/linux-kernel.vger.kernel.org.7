Return-Path: <linux-kernel+bounces-820168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C152B7DDC2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D682582AC5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 07:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D645E27A468;
	Wed, 17 Sep 2025 07:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z2bA9PIi"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8551A1369B4
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 07:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758095158; cv=none; b=o/TQIC/f20vFI1PImWMOH5Bi4wT+Ex/djY6hpvnlnfLDHG18SKDkG/N73sAdc3WzbDUpdpZfJs6ORu+tKWBiKCjkesbPMA+KJ//LvwHkhVsSw4xxjdwu+Zd5PAvZBk6cwZZ2KQIvC/wenTXzw+brNmjOKn1WhacVDAZaEoe4ILI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758095158; c=relaxed/simple;
	bh=SlDlinNGQSd4RKi+Cnb+PiszIRO+bkn3SZ1hom0FQ/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EIN14Dndlz+puKNq0pmrTExU1JM/ZgTbeyIShCHtCJgQEQEB4p/dqROafRmIeWW2/K9T72LiiyDEr9SLNRezoVyN8peIxAHd02px1VAP+1Qwc88EeWKHUTEvRrI+NJ4PVDNw+KkQ1L0JLsoCngnCiTyQT9Otht99l4diY6oXv9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z2bA9PIi; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-62ec5f750f7so11472532a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 00:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758095155; x=1758699955; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w/PV3sQX3P2aZwX4RWrb0glEbtXd1xtTrstBqiLxQHM=;
        b=Z2bA9PIiL8GrdzEus/SWx08BwSEjAJQIN+1c3/BShmtv3WbO/mh3elFr+i9ZolKs+i
         alsLMzd6uiwNUUHhNQTb5plrpj/nB/AmuD86O5+CDYO+rW4CIKAcFksGUZsf2BQgMwFp
         c3kRy2R9GZnoYg1tfREdg4tMET3ZebNkiDylvHmSrGBtcxwHJVGbOr851GX37GFt0vGw
         NMv1QIdARyPCzZhdOFtckwB0Vm/DDOq/+y7kqNs0VI8by5CGNRAqL9SGl+ke83ndq6Kf
         W/xWszcYOAzZktXImJCNZvN48P3mdcJTH0hKI2fHcoX0tTEzAm0ibelI/kH27JlIRsKm
         ElzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758095155; x=1758699955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w/PV3sQX3P2aZwX4RWrb0glEbtXd1xtTrstBqiLxQHM=;
        b=I9bdlZbw2RRNjOJaPzVQDIRGE27sN3ByNl/QqazTnGR2ByRhcuWOp8dhno6mtNgPff
         /TA4MyBHdGK6XyotC598UCDKjmwFVONCoONKvcYtiewJbKVXnVuTgWd+MbbXmZ80b4FP
         ebRVR6X4t+fKDCQJ7Hl7oAemGkbBk/0zAiiGGI2oiPPo6+EZ3N+eNs3AznYsWRT7fsA3
         ZU14g3ElvtG9DzKD9DuxVskw2wTFY6mlumFWt57htWRxOJ4xQE7baljCsZyh39gBdDEj
         vT2mVQ/ZCLjXZRr/G9kTx0+KiDAxojY1TFWorsnzlupgMiLrhfGrbTFZCepwXM2Hqunn
         RVYA==
X-Forwarded-Encrypted: i=1; AJvYcCUW1d0zU22vpmd+pbL0lxsBzvikz/RoZmaLEujTPWhfc18aEukwGGqt/tM/YuzD0Gi1UFP/nbhVJnHyJus=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+J3vrGrfNEI6C44MSB/kmQfRAD1OB4Kw8rbYw9rlDRPzGE+wa
	dR6mcfnmvKea2I78sVBrlGGdYpRMx/86qIM7hikZrTnU0kmaPBB8NDex4lA2Jie5EY2R/56/2rn
	GoIvY20WwAe+8cgwjyXRnqmY79hUO+wY=
X-Gm-Gg: ASbGncvhTQnIa4YBddAWyb6tSck9EUEpbGTqUzp9BaumPgrA44jEKVIoFTqVbvLG/mt
	5UjUh4J1CIAa4XTPwkWQBg/U25+v7HGMfwZaN2NSwrkzXZfrcCnRmP2wDQ9qrBnb1uYZD0ECTmQ
	9ii93OdBpaFiWKrwJkZuLo8T2STv0+A71HHaojgjIkcLX5aXEbNbnzQShT0W3rNKDTIdRnHuazQ
	1oaWQ==
X-Google-Smtp-Source: AGHT+IE9zwmB6T7HEwi/+2ayzNjx1SmehnWY6rCgBsjF2Nwg90YsxIP+l4GYaGbvKGpfrd7ZhTKSZ48vhQWnDoaNQa8=
X-Received: by 2002:a17:906:f59b:b0:b07:c6ad:9e4a with SMTP id
 a640c23a62f3a-b1bb216c252mr145352066b.15.1758095154712; Wed, 17 Sep 2025
 00:45:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250831190055.7952-1-linux.amoon@gmail.com> <20250831190055.7952-3-linux.amoon@gmail.com>
 <23013855.EfDdHjke4D@senjougahara>
In-Reply-To: <23013855.EfDdHjke4D@senjougahara>
From: Anand Moon <linux.amoon@gmail.com>
Date: Wed, 17 Sep 2025 13:15:38 +0530
X-Gm-Features: AS18NWCJA1J4Xmz0s7LUPixHFdxkhk-KMYeQL9MPiR3KsxNtmZnw_0SMpEnwE18
Message-ID: <CANAwSgT615R32WTBzi2-8FYntmaxbmVRLmA3yi+=4ryH43aaWQ@mail.gmail.com>
Subject: Re: [RFC v1 2/2] PCI: tegra: Use readl_poll_timeout() for link status polling
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, 
	"open list:PCI DRIVER FOR NVIDIA TEGRA" <linux-tegra@vger.kernel.org>, 
	"open list:PCI DRIVER FOR NVIDIA TEGRA" <linux-pci@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mikko,

Thanks for your review comments.

On Wed, 17 Sept 2025 at 08:51, Mikko Perttunen <mperttunen@nvidia.com> wrot=
e:
>
> On Monday, September 1, 2025 4:00=E2=80=AFAM Anand Moon wrote:
> > Replace the manual `do-while` polling loops with the readl_poll_timeout=
()
> > helper when checking the link DL_UP and DL_LINK_ACTIVE status bits
> > during link bring-up. This simplifies the code by removing the open-cod=
ed
> > timeout logic in favor of the standard, more robust iopoll framework.
> > The change improves readability and reduces code duplication.
> >
> > Cc: Thierry Reding <thierry.reding@gmail.com>
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> >  drivers/pci/controller/pci-tegra.c | 38 ++++++++++++------------------
> >  1 file changed, 15 insertions(+), 23 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controlle=
r/pci-tegra.c
> > index 3841489198b64..8e850f7c84e40 100644
> > --- a/drivers/pci/controller/pci-tegra.c
> > +++ b/drivers/pci/controller/pci-tegra.c
> > @@ -24,6 +24,7 @@
> >  #include <linux/irqchip/chained_irq.h>
> >  #include <linux/irqchip/irq-msi-lib.h>
> >  #include <linux/irqdomain.h>
> > +#include <linux/iopoll.h>
>
> There is already an iopoll.h include in this file, so this adds a duplica=
te.
>
Opps, I missed this in rebasing my code.

> >  #include <linux/kernel.h>
> >  #include <linux/init.h>
> >  #include <linux/module.h>
> > @@ -2157,37 +2158,28 @@ static bool tegra_pcie_port_check_link(struct t=
egra_pcie_port *port)
> >       value |=3D RP_PRIV_MISC_PRSNT_MAP_EP_PRSNT;
> >       writel(value, port->base + RP_PRIV_MISC);
> >
> > -     do {
> > -             unsigned int timeout =3D TEGRA_PCIE_LINKUP_TIMEOUT;
> > -
> > -             do {
> > -                     value =3D readl(port->base + RP_VEND_XP);
> > -
> > -                     if (value & RP_VEND_XP_DL_UP)
> > -                             break;
> > -
> > -                     usleep_range(1000, 2000);
> > -             } while (--timeout);
> > +     while (retries--) {
> > +             int err;
> >
> > -             if (!timeout) {
> > +             err =3D readl_poll_timeout(port->base + RP_VEND_XP, value=
,
> > +                                      value & RP_VEND_XP_DL_UP,
> > +                                      1000,
> > +                                      TEGRA_PCIE_LINKUP_TIMEOUT * 1000=
);
>
> The logic change here looks OK to me. This makes the timeout 200ms (TEGRA=
_PCIE_LINKUP_TIMEOUT is 200). Previously, the code looped 200 times with a =
1 to 2ms sleep on each iteration. So the timeout could have been longer tha=
n 200ms previously, but not in a way that could be relied on.

You're right; the original usleep_range(1000, 2000) had a variable sleep ti=
me.
To replicate the worst-case behavior of the old loop, the
readl_poll_timeout should
use a delay_us of 1000 and a timeout_us that matches the original
maximum duration.
Since the previous code looped 200 times with a maximum 2ms sleep,
the correct timeout is 400ms, so update (TEGRA_PCIE_LINKUP_TIMEOUT * 2000).
or increase TEGRA_PCIE_LINKUP_TIMEOUT to 400.

Are these changes ok with you?

Thank
-Anand

