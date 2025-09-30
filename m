Return-Path: <linux-kernel+bounces-837839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D01F7BAD695
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 17:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C169174127
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 14:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB26306489;
	Tue, 30 Sep 2025 14:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FmAuOSob"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071F130597A
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 14:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759244374; cv=none; b=RxuK/EEk9+CXfXdMh+c7bk68q1Uqn3W21+SYCneZJC+HU88mFlSHnH9Ovp7HYPEmuEnovxptelu3kpxb97FolnBE1pVgyoiwVN0gczPxyc5LQo25cLBeHmydcyvq81O7qfhngIim1rAPUHLSliS4ZoLV8T1SvKES4jyiD8/LqH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759244374; c=relaxed/simple;
	bh=ChfNU9FvF2cIQ/RryZeB9UnFuqodq6HvJ8lwY8BZ/AU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UO4FLo4k7G+QoH+RDY1G2vMwbv8VcTl/bmpa4Jl0l8CJl1BzfBTqTh1PAWqwgBNdczEIngX2x75okUNXMvkuKZ1O8yTJDK+9jylA1+frJRXMCKu0I2FtZNx/RNLI/qzKk+Wvw/NKAhGa21wkqBTxb1EiOOeINgTObfAIwzA6c2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FmAuOSob; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-78125ed4052so4349434b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1759244371; x=1759849171; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YSc3erqR+m9Cq3XMrwel4zg9jxga5W34DHU66LfGEqk=;
        b=FmAuOSobf8b3nuTrzb2xDASLhESzWfGQ4Qjnp5ePKXUgm/y7bz6eoq8wIQkDE1RYxx
         j3dVh2nwUb81qwaGeTDvttt7navzoiACwU61OEgX8xal6W2sz8ROa1q0QRAV/KYcn12c
         HGWwAOikqv9PB/nx9Hb+Q1o/bzJXUCk6y1kZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759244371; x=1759849171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YSc3erqR+m9Cq3XMrwel4zg9jxga5W34DHU66LfGEqk=;
        b=OWywYeVK97Qu3Fy2DgKqUw/vMEJi1+0dZOPa/BGuGWfxzd/9PMjHQx+rrkHf97dUqA
         h3Hr478VQFVvfEEhK/V3YhthvuC2nU5VEI6yMJX/73Al/1E25WACiL2Eo22yOdaK1P1Y
         V1GWpQZDzLYuPwTuBtlwQl8dJq6BpMH1ce5T0hO0NT11tb9WdmHoqSswLw+paDr6bVSJ
         pJ/ruYEwUj5R5VB9Nf2W6PtdQ8GsWWRF5eAgQ7DQZ9VHHRIqeqvsywIGZMmqNXvioJYE
         a5aCg41F8NtVxeAjruHyYZNBRPNOoUXGYP3if6Px5qOXCVvv7VjI2h4hUPtCcY3DRE+t
         hfoA==
X-Forwarded-Encrypted: i=1; AJvYcCXyq1RlwYvo5GIgd+LeL1agy9o/aTqr4i3Tk5FP8/t3rzhaPam5hPJqpek9DLjqkZ5k2AK4fjYYrt/ngDA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrinFMqo35MBxenDoXlUgO4TGENiKETQYYWoxu1zM/9afjj7sw
	zOLP5ClVsGTmuVEHyknhe6vS8xfcu0lr5Mf80EGQroNRCYD+BHAXLqe1PEt/ZXGnHnQ5WRhAVNk
	8Ro4=
X-Gm-Gg: ASbGnctmmfhvtaGOe+4FsVSh0ubzrdqexXIYwVd5XCzxuBo8Wb4GE+xLvxySMhcTOAF
	P5yvQs0RMSJ03IqtonnZnJl3K8pIu9pirfhYijtUgCAtWFMFE2hW30cr35DGAx7ZWmmi0FBG/i1
	4ZuvvjZlHnAGmxTV4/yQoKqn7nHa8MmAMX0cGQ4pvhzyrvgVM4CFpcEX6Ibk4x288uN1IaFgT08
	cEnHOmTZUMLLSEZlFZGxTssLEPBPyu7OnVYYhdJkPK9Rx5Ch2mL7xBEB5dJKcy1IYbr2HDeYMTo
	acny0zBWQjazLLPLVEl+9hBmlaNtfwBnDXt14qaoixddHlaSjS7rQDBiidZEfKvSnXy4UjqQe5J
	5fTDOKPkE6JgInHZB/6dck++dzrscoXLLjTPE+81hX/Ocp5ULAFTJuvMjiI5RIx1b0W5XvLoKi+
	D5suUjBkLWIUTXtg==
X-Google-Smtp-Source: AGHT+IEfiZ92tt2Vrclt4Lxwd18Irj9W38SfWvuAWnxQB7cp37lBceL/wEh2gGEvK5GxPPBE/RT4sw==
X-Received: by 2002:a05:6a00:2e1a:b0:781:1484:fb2c with SMTP id d2e1a72fcca58-7811484ff39mr16049322b3a.10.1759244371285;
        Tue, 30 Sep 2025 07:59:31 -0700 (PDT)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com. [209.85.214.169])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7810238d321sm13966906b3a.17.2025.09.30.07.59.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 07:59:30 -0700 (PDT)
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-27c369f898fso65495305ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:59:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXUx9JklTAhQ1SMQ3PR5PVM2IcLLsYJq4QgSv+1u8PxFEJZeuTz4PMqsGNOakieYYbKpaUcdYhMzX3jurg=@vger.kernel.org
X-Received: by 2002:a17:902:fc8f:b0:267:9e3d:9b6e with SMTP id
 d9443c01a7336-28e7f442a78mr193225ad.51.1759244369479; Tue, 30 Sep 2025
 07:59:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929142455.24883-1-clamor95@gmail.com> <20250929142455.24883-3-clamor95@gmail.com>
 <CAD=FV=WH5rsQR0vnsdZqfA-K-4AWSyOOfbe3g1H7pYCG0AigZw@mail.gmail.com>
 <CAPVz0n2Prw0ZoQhrodobmSpAu7XV6aX=NV=2ee0RwL3H5hWARg@mail.gmail.com>
 <CAD=FV=XD=L=otnj+YsQ1qEtrO_+wBD-ZYpDNmickcD1tb+6OoA@mail.gmail.com> <CAPVz0n1y86mKKvViG9dVN4gkqkbsjcZrFraTtKQ+Tvf4DBJCVw@mail.gmail.com>
In-Reply-To: <CAPVz0n1y86mKKvViG9dVN4gkqkbsjcZrFraTtKQ+Tvf4DBJCVw@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 30 Sep 2025 07:59:17 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UzVGE88k6kmN+BxO_SV4H9JDM=96E1Mco3K2mofRbnGA@mail.gmail.com>
X-Gm-Features: AS18NWAy2O8-X47mCuul_Hv6w1Ke6zCRmOjrUq428DdWDjkLHW5ffnJ8B6LXgeQ
Message-ID: <CAD=FV=UzVGE88k6kmN+BxO_SV4H9JDM=96E1Mco3K2mofRbnGA@mail.gmail.com>
Subject: Re: [PATCH v1 2/8] gpu/drm: panel: add support for LG LD070WX3-SL01
 MIPI DSI panel
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Sam Ravnborg <sam@ravnborg.org>, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Sep 30, 2025 at 7:48=E2=80=AFAM Svyatoslav Ryhel <clamor95@gmail.co=
m> wrote:
>
> =D0=B2=D1=82, 30 =D0=B2=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 17:34 Do=
ug Anderson <dianders@chromium.org> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > Hi,
> >
> > On Mon, Sep 29, 2025 at 10:13=E2=80=AFPM Svyatoslav Ryhel <clamor95@gma=
il.com> wrote:
> > >
> > > > > +static int lg_ld070wx3_unprepare(struct drm_panel *panel)
> > > > > +{
> > > > > +       struct lg_ld070wx3 *priv =3D to_lg_ld070wx3(panel);
> > > > > +       struct mipi_dsi_multi_context ctx =3D { .dsi =3D priv->ds=
i };
> > > > > +
> > > > > +       mipi_dsi_dcs_enter_sleep_mode_multi(&ctx);
> > > > > +
> > > >
> > > > Maybe add some comment about ignoring the accumulated error in the
> > > > context and still doing the sleeps?
> > > >
> > >
> > > Isn't that obvious? Regardless of what command returns power supply
> > > should be turned off, preferably with a set amount of delays (delays
> > > are taken from datasheet) to avoid leaving panel in uncertain state
> > > with power on.
> >
> > I won't insist, though IMO any time an error return is purposely
> > ignored a comment about why can be justified.
> >
> >
> > > > > +       msleep(50);
> > > > > +
> > > > > +       regulator_bulk_disable(ARRAY_SIZE(priv->supplies), priv->=
supplies);
> > > > > +
> > > > > +       /* power supply must be off for at least 1s after panel d=
isable */
> > > > > +       msleep(1000);
> > > >
> > > > Presumably it would be better to keep track of the time you turned =
it
> > > > off and then make sure you don't turn it on again before that time?
> > > > Otherwise you've got a pretty wasteful delay here.
> > > >
> > >
> > > And how do you propose to implement that? Should I use mutex?
> > > Datasheet is clear regarding this, after supply is turned off there
> > > MUST be AT LEAST 1 second of delay before supplies can be turned back
> > > on.
> >
> > You don't really need a mutex since the DRM core will make sure that
> > prepare and unprepare can't be called at the same time. panel-edp
> > implements this. See `unprepared_time` I believe.
> >
> > NOTE: if you want to get really deep into this, it's actually a bit of
> > a complicated topic and I would also encourage you to add an
>
> Please spare me of this, I have enough stuff to work with and have no
> capacity to delve into depth of drm any deeper. In case this panel had
> a reset I would not care about regulators too much, but it already
> gave me too much pain and caused partially reversible damage to itself
> that I am not willing to risk.

I won't insist. It's not much code, but it could always be done later.

-Doug

