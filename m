Return-Path: <linux-kernel+bounces-824529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 764D1B897E6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 14:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B44F27BB6F5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 12:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F9020C461;
	Fri, 19 Sep 2025 12:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vp3gn7bA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC85E1FF61E
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 12:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758285625; cv=none; b=ubyuyt4vxQTS7FbyZtBhN2tQRH2bNfFRwyjdNDm9+CFOwvlo+B6GUPBkSrR0S2gLrO2Md0WAqf7bem4DWLTcN7GLUkE4zpK4VbRMp3wosy/4che+fhJy8LevapCfhfUDQ+Ix9QIqBAttSLRUeXZe6AF1K57tzqsnUjZHB7HwUA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758285625; c=relaxed/simple;
	bh=IkhiQvxSVJBNEXYwVrCccUG3TFRY4PESJjnaQR6FiqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LAE/WhxrSrKfOrP2BFM0HUvL5SoJNUWhjxAZTvCYWwl7gMakTnlZNbb6OcO9bwHv63DMrEReKcD94YO4zzfOxKpQF4cnHVFA5jb+nlcaEzfOGDcPc+F2KpflLaZYLGJX7KDFo3MVinBmPvTXL4nPRf08lX1Earw+wzL1lYElI4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vp3gn7bA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80117C4CEF0
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 12:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758285624;
	bh=IkhiQvxSVJBNEXYwVrCccUG3TFRY4PESJjnaQR6FiqY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Vp3gn7bAQCSFP2rTtO+Egh2VmMfniuDrPcFxR0zdw5I2kIMjAUXHmvMEjS3VaHT3R
	 RqFy8DlqsE2OMKIIalednDbl4IU/jAOc8gWHKHsEU9GScuRDdaO1du4nzcqr77WN67
	 W01FPkbfe/NFk6GlFAtCtB9Df0KkbVjZchfkS6+615JJyHxJb2GfWwF+kPMyF27/6w
	 NyYUnln7r63Z05ado5w/AO5TxA0pKJW+xB2XoIaJqJWdggw8cD5Uip0H+xyGWaU+it
	 IUX4sfX9+WamWCuaaxX7uB0bODccJtEa3oaOiKiF2wgCWf6hJLPCL9FnR1uvcwFDlo
	 Sz2NIgE+Ci+3Q==
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-75871cd9228so1778679a34.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 05:40:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUyinl1nSTboKJEj/6G0+flJdNCQZrDkkaN6o2JAIkPC5EgbY2Dr+wTSIH8Qg942HL9W0xeN4ytpkfo2vM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj9arZz34cyHgTy3lMjYOO2xTcol1HceQ9eYOR7ftDhokiRLnE
	oIYOU6zMtoJjqHTO0fkgqzn//qYfjJXnbFXzKOH8/Z7PUhYYUBYw92QcJiulhMxHx3v10imW343
	fzo6KeVA/14/WYpV565PEVInNiE2WpvU=
X-Google-Smtp-Source: AGHT+IGN6yKheRKFWPzTBebZECqkVSf5jQ9sRYeDfhkyJi3xILFaY9CJLuH+Txi2bawvjGDTvzV+EzhA/dpIsY+2+nk=
X-Received: by 2002:a05:6808:bc8:b0:438:257d:6663 with SMTP id
 5614622812f47-43d6c2bd39amr1474905b6e.48.1758285623777; Fri, 19 Sep 2025
 05:40:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12749587.O9o76ZdvQC@rafael.j.wysocki> <20250919113922.7tozmbts6cs3y5va@lcpd911>
In-Reply-To: <20250919113922.7tozmbts6cs3y5va@lcpd911>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 19 Sep 2025 14:40:11 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0himPgJrg7s0G7HbgFTtawEMRCJBXiuvaZnT1z9MB_mqw@mail.gmail.com>
X-Gm-Features: AS18NWD3a-WCHk-dCiI2bNf5gF2oTgLdUlcM3Mm6h19fD9EBjsdnibTPASziZu8
Message-ID: <CAJZ5v0himPgJrg7s0G7HbgFTtawEMRCJBXiuvaZnT1z9MB_mqw@mail.gmail.com>
Subject: Re: [PATCH v2] cpuidle: Fail cpuidle device registration if there is
 one already
To: Dhruva Gole <d-gole@ti.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 1:39=E2=80=AFPM Dhruva Gole <d-gole@ti.com> wrote:
>
> Hi Rafael,
>
> On Sep 19, 2025 at 13:22:20 +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Refuse to register a cpuidle device if the given CPU has a cpuidle
> > device already and print a message regarding it.
> >
> > Without this, an attempt to register a new cpuidle device without
> > unregistering the existing one leads to the removal of the existing
> > cpuidle device without removing its sysfs interface.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > v1 -> v2:
> >    * Add the new check before the driver module reference counting (Dhr=
uva).
>
> Thanks for addressing!
>
> >
> > ---
> >  drivers/cpuidle/cpuidle.c |    8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > --- a/drivers/cpuidle/cpuidle.c
> > +++ b/drivers/cpuidle/cpuidle.c
> > @@ -635,8 +635,14 @@ static void __cpuidle_device_init(struct
> >  static int __cpuidle_register_device(struct cpuidle_device *dev)
> >  {
> >       struct cpuidle_driver *drv =3D cpuidle_get_cpu_driver(dev);
> > +     unsigned int cpu =3D dev->cpu;
> >       int i, ret;
> >
> > +     if (per_cpu(cpuidle_devices, cpu)) {
> > +             pr_info("CPU%d: cpuidle device already registered\n", cpu=
);
>
> Sorry for not pointing this earlier,
> perhaps pr_err makes more sense?

No, this need not mean a functional issue.

