Return-Path: <linux-kernel+bounces-867204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA38C01DF7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 16:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A94663B74D2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 14:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A9E32D448;
	Thu, 23 Oct 2025 14:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rLebnEoi"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1EA3074B1
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 14:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761230252; cv=none; b=Uw38XJBUkHmZP22LHTzXiEiDZdEmwquPiepdBrFuNFiBxmg3z94r/mfbCSMlvA3RwhOTQw63E214q20B1uYQ8nwYkP/m9LA9xOgcvQW4BPl/cv+RP+ddf22WUcjXfNRl7DT4YEpjlXbjK6n4BHRdLfnaCCQbqR0323vCgH8Sl94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761230252; c=relaxed/simple;
	bh=nmuhkbmYIHwlo0bTfpa+yRu9VeKXePgg3mUVlnPW/hk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SkkEqYL9naAPsot6FH6twAWN6XFCLnOJz6oZ9ow+EVdO3Okz1k79JUt6ux8Uug5qPOLIO1MncFwNklX7/tNp92J9Da4if215LUY1sBUzNztGCt+q5sp6xR23e3VZYA/aLWIswuMpwkkQR0SHN4vTeYn77NvUDOCm/TDnEHTdcXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rLebnEoi; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-63c556b4e0cso1837350a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 07:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761230249; x=1761835049; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ee6AwS0Oh4FU6B7RPC1MCPwDY310ZfKGYiiyM7hDKvU=;
        b=rLebnEoi3xAthwvzlwYlMIp+nhcTKXkzb9pNLATNIEs800jS4/28MdR9dyENRY2owv
         q7lbFDtUtZsmz6cfTdsy2EvVhSLjTFXLca+O9RehRzrUYCY0ZxbQ+U9BLD25rkKVj02B
         Mpp+qGmY46hwujcGpBHFfc9R5nOXb8BaGW993QK6lHC9Q+bpAFQSfc9tV4i2jENH6n2Y
         TFydqP6qzOtPJQbi4wp4rQ0NZUVkWd9RNqZ7vAm8veLrNRvWbKHK99LRRT+yZaeKlpOb
         8Cc/EGUN+KxrVpUmzepIrXvkXD3eba/azHI0KEoLcfrnKFLEm4Q3ltnKMMxC+lCZQMqI
         qPLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761230249; x=1761835049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ee6AwS0Oh4FU6B7RPC1MCPwDY310ZfKGYiiyM7hDKvU=;
        b=uuXSuGnWfrgfjBByBwQor/xNeD2MAeqHeKSk1tQr+iIZOv4MbDi7fk/kwb6ZuGCwhk
         zehjzO9Miv6Qg4hR6PwK7/3RVl3/VjPYgaS2lKn+3V4rlwyycLaLtPRkk12SUmQi7rip
         ZaOOmfKvu0szfETTxJnHSf/r/k4QNZ7QDDt2XptQVg7pKCS+XEOcYe79ErBecL9RmdqC
         kXH4SBViXLHPLaIY5cLvo1L94yrB5zTkx/yUFBoVSstIsIK5W54EJMXAhUGTeO/PotKY
         UOZRLPKpW+X4TLsJX6TkkJIIriFUjZd2lkB8TGh2HkBruaTgT0Olv3AVcR2DN30AiLOY
         2VJw==
X-Forwarded-Encrypted: i=1; AJvYcCWxtWxhvAQE5lTiJQjIM47OYaWSGZv3kdO4sWHPapsUGv854BRQXCxSLV3lZSoDHR06Ar1NFZ9nZTAqCq8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVl0JvuxiNsKKQc2y6u/pmWTP2AYedLtRWWchEkJo55iSNnXdH
	DdgcoYD0Rja4bnVZDn7VP1pWhJwVXvxikSMdUrf/4p6cfs+e7I07erwqCOG+N6LQLaBbRHxuIiY
	+tXAIcrhdaweYlIKK5o+JY52b+CRL9DFnfJsCjnZZ
X-Gm-Gg: ASbGnctplb+JyQilGST2oo579A7NrPACDBvy7xWrpB5BLVzhD3GeaIHLu+CHikPSAp8
	l7n+lSS0tsBgWdscBTp0U175hwEAbN6Y+JQjJ4CWS607UrhOvZ4KpP0qspWhyPIKhO/EHcEBT8V
	CLl/sZhH6XDAXcX61PU0kmTYYDZfaoDJYfdWOA7Iy1Au2ylCjz2Ce5rafhysXYXQzapldvr1hQ7
	xz63rJ7GSvJZz7Qb/1Cq+4BVCgKfgQ/iMTFgmUb8UiTu8Bk1ll2x5Z98VI7jJSWTxcpQTxd
X-Google-Smtp-Source: AGHT+IFbp9ZMt0Cy9ClZs0lHFOJ9QBTf1Z2cJvn57Dc7ncVUrW+Ms8Oh3ADagb0PL+IsUmXpI99hN+aEX8b0luZ9bjY=
X-Received: by 2002:a05:6402:5656:b0:637:8faa:9df7 with SMTP id
 4fb4d7f45d1cf-63c1f6cefdamr18256821a12.29.1761230248590; Thu, 23 Oct 2025
 07:37:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002113404.3117429-1-srosek@google.com> <20251002113404.3117429-5-srosek@google.com>
 <CAJZ5v0is66vO05fbxooRxkn_wAZr_g9Wr-D-RtFH32gNzE726A@mail.gmail.com>
In-Reply-To: <CAJZ5v0is66vO05fbxooRxkn_wAZr_g9Wr-D-RtFH32gNzE726A@mail.gmail.com>
From: =?UTF-8?Q?S=C5=82awomir_Rosek?= <srosek@google.com>
Date: Thu, 23 Oct 2025 16:37:16 +0200
X-Gm-Features: AS18NWCacGG2PPS7_pVbR5EN39z6gluv3FRZP2OC0tyFulfV8k4iQblvSkQOwk8
Message-ID: <CAF3aWvFwJqMK7sGY97Wy=Ja7+=CnWnS3yDS4M4G4mEPZNSeL=A@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] ACPI: DPTF: Remove not supported INT340X IDs
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

On Wed, Oct 22, 2025 at 8:48=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Thu, Oct 2, 2025 at 1:34=E2=80=AFPM Slawomir Rosek <srosek@google.com>=
 wrote:
> >
> > Remove not supported INT340X and Wildcat Lake ACPI device IDs
> > from scan handler.
>
> I guess "not supported" means "no driver binds to them".

Right, I will clarify this.

>
> > Fixes: 3230bbfce8a9 ("ACPI: introduce ACPI int340x thermal scan handler=
")
> > Fixes: 9cf45756a4b9 ("ACPI: DPTF: Support for Wildcat Lake")
> > Signed-off-by: Slawomir Rosek <srosek@google.com>
> > ---
> >  drivers/acpi/dptf/int340x_thermal.c | 6 ------
> >  1 file changed, 6 deletions(-)
> >
> > diff --git a/drivers/acpi/dptf/int340x_thermal.c b/drivers/acpi/dptf/in=
t340x_thermal.c
> > index 26522ddfcbaa..7d1308b1f513 100644
> > --- a/drivers/acpi/dptf/int340x_thermal.c
> > +++ b/drivers/acpi/dptf/int340x_thermal.c
> > @@ -21,12 +21,6 @@ static const struct acpi_device_id int340x_thermal_d=
evice_ids[] =3D {
> >         ACPI_INT3406_DEVICE_IDS,
> >         ACPI_INT3407_DEVICE_IDS,
> >         ACPI_PCH_FIVR_DEVICE_IDS,
> > -       {"INT3408"},
> > -       {"INT3409"},
> > -       {"INT340A"},
> > -       {"INT340B"},
> > -       {"INTC10FF"},
> > -       {"INTC1102"},
> >         {""},
> >  };
> >
> > --
> > 2.51.0.618.g983fd99d29-goog
> >

