Return-Path: <linux-kernel+bounces-867262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40116C0205E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 17:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 887361A6665E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 15:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A373370FD;
	Thu, 23 Oct 2025 15:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cQFAk4o9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83AE3370FB
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 15:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761232289; cv=none; b=qQerJn7hEFVEq7ak6lCh0hvwZkOzwSQVpVMLFkhHqwXgJ0QW9uEOC6DBqmhX5g6wwhhwBYY66tE10aG7B6OLv88qE1CcUCZSLC1WqOkNccNnxsuoFCE0Y4HFQkvo37VQMfd1wfH2ObJr/dHzY4GO6BwEPeYOLnGsyhQHny2ieo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761232289; c=relaxed/simple;
	bh=HbjhGK0G5pGUlhH8u9kmGZx/g9Y6CmyLtzSy7KvwPN4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M0fr8RZKmUCGOsTi7Fsis9Q4Ww9Oa5LJlSJ6vseoMzlvm+sQeenHxyIR9nAERfVa/5uDyTdm1Wa71ArnCadTmEJKW9/q9bRaeICPUFE4m+vtt7JbKqLOVzlHl2bxIXQMeE9TcCjN3i12oErGepttxMQWlfaYl68dCbShyQq5FlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cQFAk4o9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76B24C4AF09
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 15:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761232289;
	bh=HbjhGK0G5pGUlhH8u9kmGZx/g9Y6CmyLtzSy7KvwPN4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cQFAk4o9U+xyOAJNykyTj5Eox2DeAu40D3rBnMNjkreYj4CoQdoln/3ZtajD9fSoI
	 rlbInngI6r0mu04oelkhMxWxRMQMCFOsia9r3aK9pEEjtvVy5/tpFDqn7XkEyct7q7
	 mbi7QEn3MmChtO2wU14Dc9s78AuSrgGSDvmoVZS8h80qU2SyZHYevpmlpfNfJsWIBu
	 hC2NQvWjjxIlTxdtTo5u80GEFQEJXU7IF3q5lankAO22pVGS+YG55OLJH7PnyW6UY7
	 F8e37kOdQTs+qjAGjoCpSRgV20pOXjrqpkUNQY45LK/GsCx/0gd/UO7z609Yis6bly
	 x7y5v1zba+fLg==
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7c0e357ab51so852377a34.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:11:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXqXBww9QcrG4OXpQrsyY/al6roFMO10RGxo6H4sMvnfV6/38OUptL5FlDUMfgbEV2Q7u9whsyDtwrkevw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvzSTaXGTfKnLIlYfAiW7PuoHwf57OMsksGYM9s/20EHtLc0wb
	WcCY/OkhCeoXPr3Tsk+HJeBGPjWjWTM2spOoyujpBs93ItKyY2CHUxe7jCuu6uMiAU0NI9X/ko0
	70envIj56ZFamlsawrCdFQ6gbm7E9dVY=
X-Google-Smtp-Source: AGHT+IEEIqXqLWdKxaISo2plnHeWBU7F4XnnYvFesimjPGTiUUnWaB+9I8ytYhWNwjgu8abqtQKl6S2MMWeJRT3YG6s=
X-Received: by 2002:a05:6808:181e:b0:441:8f74:f0b with SMTP id
 5614622812f47-443a30e0ab6mr9053954b6e.53.1761232288746; Thu, 23 Oct 2025
 08:11:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002113404.3117429-1-srosek@google.com> <20251002113404.3117429-3-srosek@google.com>
 <CAJZ5v0iQToOkedruYqsowSm8=fxpnyJf86JJHB36E8+aCSZ5Hw@mail.gmail.com> <CAF3aWvFSomq+cm2sj+KjkYw=WODsrwH-VLDL=yOc6o9dqc5hWA@mail.gmail.com>
In-Reply-To: <CAF3aWvFSomq+cm2sj+KjkYw=WODsrwH-VLDL=yOc6o9dqc5hWA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 23 Oct 2025 17:11:17 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g72U3+u_KedKpZh2TuN-iYbXPcnZhN16oDvi4UqUTr7Q@mail.gmail.com>
X-Gm-Features: AS18NWBHGY-eaK7GVSIrVckhmfz8bbUTGxn5FaIfLLu6uQlgSHMtDQwK9-F2IfE
Message-ID: <CAJZ5v0g72U3+u_KedKpZh2TuN-iYbXPcnZhN16oDvi4UqUTr7Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] ACPI: DPTF: Move INT340X device IDs to header
To: =?UTF-8?Q?S=C5=82awomir_Rosek?= <srosek@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Alex Hung <alexhung@gmail.com>, 
	Hans de Goede <hansg@kernel.org>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, 
	AceLan Kao <acelan.kao@canonical.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Zhang Rui <rui.zhang@intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Tomasz Nowicki <tnowicki@google.com>, 
	Stanislaw Kardach <skardach@google.com>, Michal Krawczyk <mikrawczyk@google.com>, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 4:41=E2=80=AFPM S=C5=82awomir Rosek <srosek@google.=
com> wrote:
>
> On Wed, Oct 22, 2025 at 8:46=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.=
org> wrote:
> >
> > On Thu, Oct 2, 2025 at 1:34=E2=80=AFPM Slawomir Rosek <srosek@google.co=
m> wrote:
> > >
> > > The ACPI INT340X device IDs are shared between the DPTF core
> > > and thermal drivers, thus they are moved to the common header.
> > >
> > > Signed-off-by: Slawomir Rosek <srosek@google.com>
> >
> > I've actually started to wonder if int340x_thermal_handler is needed at=
 all.
> >
> > It just creates a platform device if the given ACPI device ID is in
> > its list,
>
> That's true. It creates platform device for the given ACPI device ID,
> but only if CONFIG_INT340X_THERMAL is enabled.
>
> > but acpi_default_enumeration() would do that too with the
> > caveat that it would also be done for CONFIG_INT340X_THERMAL unset.
>
> Not exactly. scan handler returns ret=3D1, so device is marked as enumera=
ted
> https://elixir.bootlin.com/linux/v6.18-rc2/source/drivers/acpi/scan.c#L23=
14
>
> > That should not be a problem though because if CONFIG_INT340X_THERMAL,
> > there are no drivers that will bind to those platform devices, so the
> > net outcome should be the same.
>
> If CONFIG_INT340X_THERMAL is not set and there are no drivers to attach
> to platform devices and int340x_thermal_handler is removed then you are
> right, acpi_default_enumeration() will enumerate ACPI bus anyway and
> create platform devices for all ACPI device IDs. However, for me it looks
> like it was intentional to prevent this behaviour unless INT340X drivers
> are "present" in the system (were enabled for build so should be).
> I am not sure how DPTF works and what may happen if platform devices are
> visible in sysfs while drivers are not loaded.

Such a dependency would be unexpected and confusing.

Also, I'm not sure why it would be useful because the lack of drivers
means that the devices in question are not handled, so no
functionality related to them is provided by the kernel.

> >
> > Thus I'm wondering if the way to go might be to drop
> > int340x_thermal_handler and simply keep the device IDs in the drivers
> > that use them for device binding.
>
> Even better. If it's not required for DPTF to prevent enumeration
> on the platform bus I can simply remove the scan handler.

I would at least try to do that.

