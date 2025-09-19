Return-Path: <linux-kernel+bounces-824442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90AE0B89372
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 13:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5147C7C063A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 11:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8901E30CB30;
	Fri, 19 Sep 2025 11:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DfM4BSy+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43C830C100
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 11:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758280468; cv=none; b=EbbbXKW1a9CsWnAoKEf2Q6En/1hUPZpEknHz84VkdcaI07LWxgHTHVTyXrJTFq8VtODTSnn0Sl4NZ53CVJ9VjDMAL52H/c9IrTCNBAQqYJoDpUD4UKwMm2U9NGUjiiIAeWlWMN7fHbG1ZkOgx4v7+hck6muzAZamzQZjNa0mStk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758280468; c=relaxed/simple;
	bh=3oHB5M17fAPCaUOWIy7staPxRqP0sgNkjBo8MB8iCs0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QoIbM1sVWKie2JVrMnUDAI1yPVTXpo72y1JauTych+O5eA+5fDHHHXVzYpz2dtQxu0kWRBfLIaS6/trYhWDGIlIbGA2VNkhic0h2JPp4yk7p3JrZJcY2DWMGqh5hOGqQvYZgwzjzXLRHSDcZEJIG/wFyzGxvOaRPyx7TlYujNRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DfM4BSy+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82A03C4CEF0
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 11:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758280467;
	bh=3oHB5M17fAPCaUOWIy7staPxRqP0sgNkjBo8MB8iCs0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DfM4BSy+QSCC6rMmSA/D99tHgU9QKq2v2SSL3ogrmPtwbw9X85Lxc4XRLp7e5LorE
	 /Nu/TtylwU3/qNN3pTVSuKfI9Lknp1+9c7IcwE6SAwoySmEzqjdiog81888bXG0iob
	 viz/Ylyw8fvwG/24ETNC5yk1dLqk4Gs/jn86IQ70NZVfJbbarKkUoji/WNEXqhuOBM
	 an31vr4q43dYnDtzcGw0WlfFK84ETFxTjrWCc8hq3Qm2thAcjIn+sxbl+g/pq9N9nv
	 VfIU+xTrPbbfl+AkrGxUT6BOtznxp+n/o4VosQ6FpHvpynXSfGbaaGnu1Vf7jHfC+f
	 rFasugLZouMqQ==
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-750c5378b96so1067337a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 04:14:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWr8mFaPVHvWvOgPZAAPnfkmr7aB8y2FNWm5GZXZT25yAhAdudVsyEdwpM2hmZw3rn0BIPJ1L3Cuvbvnak=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZeFaOEYyGiC84GnfHBYKGB3CcYajPm0DEdxMoplLicLtZ2mDv
	EvdoNn9Bi5HdAR9GNMswAINunlNVoR9SrUcPSjMSw5MygheISZkQSycfp7er1zWvGpb4F8Ft5l1
	2IvdQFu2KYxjdjBz1eTdklmUCS1IVAJo=
X-Google-Smtp-Source: AGHT+IGLpj/lQRwBPOEbZHrxrK3WqjA8s9QwnWqC1dbMSAnpOxnRlgLPlZlXUMZqO7PDq4hzKwhSrE/rAfQ02rJ74jM=
X-Received: by 2002:a05:6830:631b:b0:756:d6ab:e7a9 with SMTP id
 46e09a7af769-76902d5b77fmr3868391a34.13.1758280461874; Fri, 19 Sep 2025
 04:14:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3374815.aeNJFYEL58@rafael.j.wysocki> <20250919050928.6sprmdpz2pwgydcc@lcpd911>
In-Reply-To: <20250919050928.6sprmdpz2pwgydcc@lcpd911>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 19 Sep 2025 13:14:10 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hCaLebTwtm36dxxG0NBOc1DVPj9cjYHKOWm5kApNa1TQ@mail.gmail.com>
X-Gm-Features: AS18NWBzT6h889TaE7l6WW4Iz6YZGG6Dk_VjK05Co-aXWxzmQI-FiRCRfLLeNjU
Message-ID: <CAJZ5v0hCaLebTwtm36dxxG0NBOc1DVPj9cjYHKOWm5kApNa1TQ@mail.gmail.com>
Subject: Re: [PATCH v1] cpuidle: Fail cpuidle device registration if there is
 one already
To: Dhruva Gole <d-gole@ti.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Sep 19, 2025 at 7:09=E2=80=AFAM Dhruva Gole <d-gole@ti.com> wrote:
>
> Hi Rafael,
>
> On Sep 18, 2025 at 23:19:20 +0200, Rafael J. Wysocki wrote:
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
> >  drivers/cpuidle/cpuidle.c |    8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > --- a/drivers/cpuidle/cpuidle.c
> > +++ b/drivers/cpuidle/cpuidle.c
> > @@ -635,11 +635,17 @@ static void __cpuidle_device_init(struct
> >  static int __cpuidle_register_device(struct cpuidle_device *dev)
> >  {
> >       struct cpuidle_driver *drv =3D cpuidle_get_cpu_driver(dev);
> > +     unsigned int cpu =3D dev->cpu;
> >       int i, ret;
> >
> >       if (!try_module_get(drv->owner))
> >               return -EINVAL;
> >
> > +     if (per_cpu(cpuidle_devices, cpu)) {
> > +             pr_info("CPU%d: cpuidle device already registered\n", cpu=
);
> > +             return -EEXIST;
>
> Here we return prematurely after a try_module_get right?
> Do we need a module_put() similar to how you do it later by calling
> unregister_device function by checking ret =3D cpuidle_coupled_register_d=
evice ?

Good catch, thanks!

I need to move the new check above the driver module reference counting.

