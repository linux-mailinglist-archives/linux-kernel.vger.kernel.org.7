Return-Path: <linux-kernel+bounces-836543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 15964BA9F97
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 18:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8B6DA4E1DDE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 16:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B58309F1C;
	Mon, 29 Sep 2025 16:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c1dUyX8h"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2A0302CC3
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 16:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759162375; cv=none; b=nQ1R1KiGo+XEAeSCZ7b0LdeUcgRx7R8VSvKrmr4pC+QR6Mvm/LfaCmuzg/OI0lBM5GD08LVQkdjzAkUZksfxfI8ByrLNIvvj9lwbVTabIZcEs3O2ZFM4PrRvMN6dqfqafJcRlZHY5t9doOfln9cXHTa1thgePbAHapropXAxLLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759162375; c=relaxed/simple;
	bh=Tg4GHAGSujxf07p3BKLBHupxzDzRxA4YhwnGHXjIWqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YghX/KclhwdBKKUcJLBOZx6OG0MuMBkGwt4yU4c1Hm4bqfwH4RE1eyVABRjS4L49OAzt6vokhxsIS0UAJmfqGUG5uWBNuOyeBddr0AfzSkz+EHThrm7M4vv+AEXCkfGDov1IkJVHUatJiyute4GBnSsRPtYruOpEw3sHRT3aA2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c1dUyX8h; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-631df7b2dffso1445868a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 09:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759162372; x=1759767172; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WKbIiyOJGnPtewg2XGQmyuDm4Je77/TR9Lj2L/HdtYA=;
        b=c1dUyX8hhJSYyGYODEZJNq541ZKuCw/Gdz7nPQEv/xxNam6/fqe07/DWYBL7kEC3dD
         EXqzZlE7dPBQT5g3rtAqSJGV1ZiYvgc4lu7IV7GLHHj0kZIjYjIQSF4+9/KP0y2QWiuP
         2LlFfSPu6WtLuvy7qDyG76i9nDVWNA7cnKynvmukfpOJvIIZUDWmmnAZp0agIUq5QyCC
         hnjK7f8n0iWjotqiwEQGMwem5PD+yZU/1fcJQDuJQ9b6lYc5A1QfMFc0qLbv7K1w0r/N
         4gPJW1+MriX792QkKWGr934qmGWJ8fYrUHeg/W07ZQfr6JScdZAQCW0o6H9jxFoka5BT
         iJaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759162372; x=1759767172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WKbIiyOJGnPtewg2XGQmyuDm4Je77/TR9Lj2L/HdtYA=;
        b=VPxQUHxTI1LV5iHB9x/nQYNr9mdDrcK2Z/29glYJ+KkX6mwHWkLNg0E/OJd3iPi6IV
         JCgOs1TbLIQzNoLE/TfpMgzdcTYshO0d1G8/5fjOhaQhxyAJUPl9c7oDoqtDyLCFQp1+
         UjPRSGfUUtBKVJXDwkSrj8CALpX0W3dP8KfCGjdo6YR6TiJdZbTgtQmXdzRFTGV+/6cE
         oo3reFQKIzsSYgKhn2VOiPaIFj5Rli/FHbh1FNbLYuqav+An1RTfonvJTS827G0O92IF
         /M8apVnK0MAl2reJ3BXO+5Bm44/OzpbSISmmoi2unWizmbbZ4nyamiPm4TzuhpiKGCbZ
         arsg==
X-Forwarded-Encrypted: i=1; AJvYcCXzVdQWEaq2QEnkq7JM2Eb962mqkrU97jBQtrrnxj3HZLGy4ePHQ/Ey0Nrc0QLlDtljtwQzcpHcBYJBAt4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHveP9Mui+xAcwXgd6TefugYGLcxIiOw7zugZO2uz7AXykuchv
	U7HcYBg6/FV9SZVvXGqc6jEsphux2/+x5ZYUd988WODL1d655otXrKomgBPWiuisR7RkIjEeWRA
	Pwq5ipl6ehcvul9VQHjt4BIKsfH7RZtU=
X-Gm-Gg: ASbGnctVUy6poBAj5460RML8zyhGmTpzFuloJ36wwlS+NAFFme9pqHNuaxHeZ1fw36/
	fRJNk3jlFJsI2+x0pj0nJOFy3La6FH3IsUZE9IDx5USyxT/Ww/Dr3PCRFe9gePoMGXQ4DlTJtBV
	ziLg0otLFCFd7TzXXmYdjO//eWO6R6Lb8ZcsN7R4+v/hvfhESbMDHssH7HjDaP8WwHMFe9pCQI7
	zPGS8pRYfdgyOWC
X-Google-Smtp-Source: AGHT+IE0lqGvuA/Xz523aRKIL9hmjXUK7+0u8AEeVGECM/7avOtLvinLYTseWMgOs08RG2BDuA8KXOfxxvlTzVs/fE8=
X-Received: by 2002:a05:6402:3508:b0:61a:7385:29e3 with SMTP id
 4fb4d7f45d1cf-6365af5adecmr1127595a12.18.1759162372397; Mon, 29 Sep 2025
 09:12:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926072905.126737-1-linux.amoon@gmail.com>
 <20250926072905.126737-3-linux.amoon@gmail.com> <aNbXdFPrDr8V2a+1@lizhi-Precision-Tower-5810>
 <CANAwSgT3inDQZ40uFtXwFze2m4hZUvnyKTek3PQ9jb6picgi-A@mail.gmail.com> <aw3flahx3g4exezj5245cgrixasshvf26yibctxsd3l42ygwke@equdzipwspvx>
In-Reply-To: <aw3flahx3g4exezj5245cgrixasshvf26yibctxsd3l42ygwke@equdzipwspvx>
From: Anand Moon <linux.amoon@gmail.com>
Date: Mon, 29 Sep 2025 21:42:35 +0530
X-Gm-Features: AS18NWB4VW7y7yX6xXK-2yBG9rF9CezN0Xp1TVzzbBM3LHGAaoA03PQWsyQH6Vg
Message-ID: <CANAwSgR-sq_jRp7ZQyWxrW_o6vRnCsu7FW77odDzY5xPcMuwEw@mail.gmail.com>
Subject: Re: [PATCH v1 2/5] PCI: tegra: Simplify clock handling by using
 clk_bulk*() functions
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Frank Li <Frank.li@nxp.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, 
	"open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Manivannan, Jon,

On Mon, 29 Sept 2025 at 19:31, Manivannan Sadhasivam <mani@kernel.org> wrot=
e:
>
> On Sat, Sep 27, 2025 at 11:20:10AM +0530, Anand Moon wrote:
> > Hi Frank,
> >
> > On Fri, 26 Sept 2025 at 23:42, Frank Li <Frank.li@nxp.com> wrote:
> > >
> > > On Fri, Sep 26, 2025 at 12:57:43PM +0530, Anand Moon wrote:
> > > > Currently, the driver acquires clocks and prepare/enable/disable/un=
prepare
> > > > the clocks individually thereby making the driver complex to read.
> > > >
> > > > The driver can be simplified by using the clk_bulk*() APIs.
> > > >
> > > > Use:
> > > >   - devm_clk_bulk_get() API to acquire all the clocks
> > > >   - clk_bulk_prepare_enable() to prepare/enable clocks
> > > >   - clk_bulk_disable_unprepare() APIs to disable/unprepare them in =
bulk
> > > >
> > > > Following change also removes the legacy has_cml_clk flag and its a=
ssociated
> > > > conditional logic. Instead, the driver now relies on the clock defi=
nitions from
> > > > the device tree to determine the correct clock sequencing.
> > > > This reduces hardcoded dependencies and improves the driver's maint=
ainability.
> > > >
> > > > Cc: Thierry Reding <thierry.reding@gmail.com>
> > > > Cc: Jon Hunter <jonathanh@nvidia.com>
> > > > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > > > ---
> > > > v1: Switch from devm_clk_bulk_get_all() -> devm_clk_bulk_get() with
> > > >       fix clks array.
> > >
> > > why not use devm_clk_bulk_get_all()?
> > >
> > My RFC used this devm_clk_bulk_get_all() which could work for all the S=
oC,
> > However, Jon recommended switching to named clocks, following the
> > approach used in .
> > but Jon suggested to use clock names as per dwmac-tegra.c driver.
> >
>
> The concern was with validating the DTS files with binding. Since it was =
in .txt
> format, validation was not possible. But you are converting it to .yaml, =
so you
> can safely use devm_clk_bulk_get_all().
>
Yes I would also like to use the previous approach.

> - Mani
Thanks
-Anand
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D

