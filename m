Return-Path: <linux-kernel+bounces-867378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E9EC0271C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 18:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65F5519A4520
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 16:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93BC2F1FD2;
	Thu, 23 Oct 2025 16:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Prdk/SBo"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746A92D6401
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 16:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761236858; cv=none; b=AkNuOFSkL1zwofZsv/J9Bsa6y6I9UY/kZ+wFzOp+kyHqmDF5pnA51p8Qw3sTAsvDyWGf1Oo7ANC+O5h69vw3VbXi7Lpr/6HRnwgLEErrwP27RL0nL4kiCY6OcTaX+4BIvLToJtjeIcwOaFhdGS/JssNZTSGJoQ5bwe1VWGLB+Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761236858; c=relaxed/simple;
	bh=97MO41jRSpevZOQY5X/s6jqv4fmMPnX3F7sJNNlsleo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fi9m+kbvFOpLeIHLjlyt4TzpBZBKfKbJxjHKvaA0LrkCBj0JFl+tDCIT7MujVlCRMcbAa4w9Y6AMJDvYRwAFxX2sjG2kuNvo/7JOM1eyK3ytiqqbEbpBZ5ww4sDh29hYJxvqCsslPdfzNiPsR2VPLWizWobLTPug4Gk70D3tr+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Prdk/SBo; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-63c21467e5bso1840773a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 09:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761236855; x=1761841655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=97MO41jRSpevZOQY5X/s6jqv4fmMPnX3F7sJNNlsleo=;
        b=Prdk/SBofghIdtzCeMBtAvJyI7nlROk7g2TwGmQ3o5R9VZEILaksGldZ+H2+iWi+s6
         l9FTfZS16hPTzScJA8prerCGLoP8y5i0SMRHOavog3f5yLoguaOY27V0bQjIYLQxzDPB
         YRNs1PweZsaccigXXB26VDi6eTdwxqA7xvgL6sJJ3JJVbW/L5weyVsJ86S5NOj5LPNfU
         lBnesfC7nyGsGXVmCIbuR2WyESddOYcgzF+I2kXb/RjmVSVad6+BvHP7phcphn3ElSUx
         WGg/iCfqqncmWwMLn/dLnmM7aK69LVSCwJrok4e+iWRH+mv24SY0z8jy461KcIaPov0O
         Kp/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761236855; x=1761841655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=97MO41jRSpevZOQY5X/s6jqv4fmMPnX3F7sJNNlsleo=;
        b=E5hxfUVUo36xsJSGMIWblP8NkQqAA9LffUolUide1jfeBrKU9KfJLloJtKeTG+jKBF
         f58SXfL2v7lM5KnMYJmQ7F60XtMMK2blqXDSJJtC5VWcICK+P5UOmxmmMxsQZp3ThxqT
         XEAO6JI3cGS7ecp8ybVwjpTsgN+6S/naZTQ0wtvSH9ecvsZj431YTQ9t4dLSTaIRkhNE
         r/BOLGDtfNSzXLUmPv3FfrPGxIT2zbreF6LUzSsr4n784yA4gY9062KN4Eqkb+yA6QBw
         Urebt08Nsg861bz8eFHPqyHjVlwQw/5Wycan4zMXDNimWBl2C6z+rzc897reNiNihrAR
         HhIw==
X-Forwarded-Encrypted: i=1; AJvYcCUL19NbLeRyje3WF5tWUJSUkbsGGFR03+csm0GpBAWIvF5wvGHPurvvykbRhPnasTbXerHnIqcaasTPPqk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2vr1SEGpBpSFibG/1o2T/wTP6DClMXnFNRT9w24K0RlBJe8Hx
	rqlPIImgH3fZz5ByyhhlSnKRO4btQf+bl78b8M5OPo6oqYs9EBN9vxpF7Ne81mbwOjlgtgrfcR6
	ClNHM+aBlLhLW249sqc63PJmyHAuqC2HsjUF1pDcS
X-Gm-Gg: ASbGncsuKZSun9/r78V6y5ymI7X2tggk4mXu4pMWTt75FaUZ2FNj0nN4y1FQPogv4Gt
	PsowkYOb7JSz0HYK4BAsxMOVgG1hgpB+SgmRb3tCb6MlND6l55gfjuWkRF4n3ni+TVGNb1osv8/
	GOQ+ugvqEaamt09m2iHhwYJHkw7TZulTXW1CBk9H1jeujGX+IK8Eg4dmRvX/Dk0pPlSv2yJmv+G
	eA9M+aOEPiZweXQIcBETHRQVI8AHi5d3sx+sLGgGYuzAYx/Ey+483VQlO9WM7jmmMXZ5ceHlzF0
	seHWffc305LinNGQsvVqK7d8OA==
X-Google-Smtp-Source: AGHT+IGRu6yI1emkCCw3nvVlzdH/6fU0sebXYjptgLv/4PO9Xk3ol/HgZ5f+hbDRyxJrRiKEy/KfoNbWzUlcluN7VUM=
X-Received: by 2002:a50:9e2a:0:b0:639:e9a4:a5f1 with SMTP id
 4fb4d7f45d1cf-63c1f6cef09mr20904049a12.27.1761236854479; Thu, 23 Oct 2025
 09:27:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002113404.3117429-1-srosek@google.com> <20251002113404.3117429-3-srosek@google.com>
 <CAJZ5v0iQToOkedruYqsowSm8=fxpnyJf86JJHB36E8+aCSZ5Hw@mail.gmail.com>
 <CAF3aWvFSomq+cm2sj+KjkYw=WODsrwH-VLDL=yOc6o9dqc5hWA@mail.gmail.com> <CAJZ5v0g72U3+u_KedKpZh2TuN-iYbXPcnZhN16oDvi4UqUTr7Q@mail.gmail.com>
In-Reply-To: <CAJZ5v0g72U3+u_KedKpZh2TuN-iYbXPcnZhN16oDvi4UqUTr7Q@mail.gmail.com>
From: =?UTF-8?Q?S=C5=82awomir_Rosek?= <srosek@google.com>
Date: Thu, 23 Oct 2025 18:27:23 +0200
X-Gm-Features: AWmQ_blF7s0d_2rpPBOJV_yCAuUzVG3-BC5mVNgcU7WAEA9ki3dMFD97y8RMCx8
Message-ID: <CAF3aWvFc5ZZo3VaJSr68FwGuCFYJU=tXsJ6Fm1vmNLs4B=+8dg@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] ACPI: DPTF: Move INT340X device IDs to header
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Alex Hung <alexhung@gmail.com>, Hans de Goede <hansg@kernel.org>, 
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, AceLan Kao <acelan.kao@canonical.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Zhang Rui <rui.zhang@intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Tomasz Nowicki <tnowicki@google.com>, 
	Stanislaw Kardach <skardach@google.com>, Michal Krawczyk <mikrawczyk@google.com>, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 5:11=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Thu, Oct 23, 2025 at 4:41=E2=80=AFPM S=C5=82awomir Rosek <srosek@googl=
e.com> wrote:
> >
> > On Wed, Oct 22, 2025 at 8:46=E2=80=AFPM Rafael J. Wysocki <rafael@kerne=
l.org> wrote:
> > >
> > > On Thu, Oct 2, 2025 at 1:34=E2=80=AFPM Slawomir Rosek <srosek@google.=
com> wrote:
> > > >
> > > > The ACPI INT340X device IDs are shared between the DPTF core
> > > > and thermal drivers, thus they are moved to the common header.
> > > >
> > > > Signed-off-by: Slawomir Rosek <srosek@google.com>
> > >
> > > I've actually started to wonder if int340x_thermal_handler is needed =
at all.
> > >
> > > It just creates a platform device if the given ACPI device ID is in
> > > its list,
> >
> > That's true. It creates platform device for the given ACPI device ID,
> > but only if CONFIG_INT340X_THERMAL is enabled.
> >
> > > but acpi_default_enumeration() would do that too with the
> > > caveat that it would also be done for CONFIG_INT340X_THERMAL unset.
> >
> > Not exactly. scan handler returns ret=3D1, so device is marked as enume=
rated
> > https://elixir.bootlin.com/linux/v6.18-rc2/source/drivers/acpi/scan.c#L=
2314
> >
> > > That should not be a problem though because if CONFIG_INT340X_THERMAL=
,
> > > there are no drivers that will bind to those platform devices, so the
> > > net outcome should be the same.
> >
> > If CONFIG_INT340X_THERMAL is not set and there are no drivers to attach
> > to platform devices and int340x_thermal_handler is removed then you are
> > right, acpi_default_enumeration() will enumerate ACPI bus anyway and
> > create platform devices for all ACPI device IDs. However, for me it loo=
ks
> > like it was intentional to prevent this behaviour unless INT340X driver=
s
> > are "present" in the system (were enabled for build so should be).
> > I am not sure how DPTF works and what may happen if platform devices ar=
e
> > visible in sysfs while drivers are not loaded.
>
> Such a dependency would be unexpected and confusing.
>
> Also, I'm not sure why it would be useful because the lack of drivers
> means that the devices in question are not handled, so no
> functionality related to them is provided by the kernel.
>
> > >
> > > Thus I'm wondering if the way to go might be to drop
> > > int340x_thermal_handler and simply keep the device IDs in the drivers
> > > that use them for device binding.
> >
> > Even better. If it's not required for DPTF to prevent enumeration
> > on the platform bus I can simply remove the scan handler.
>
> I would at least try to do that.

Makes sense, so I'll give it a try. Removing handler will result with
only two patches, one to update dts_doc_thermal kconfig and second
to remove the dptf scan handler, the rest won't be needed for a new
patchset. Should I send it as v4?

