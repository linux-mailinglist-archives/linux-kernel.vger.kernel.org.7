Return-Path: <linux-kernel+bounces-834588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C33BA5033
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 21:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C54EE3B10A2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 19:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F1F23BD1F;
	Fri, 26 Sep 2025 19:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fDrjnqbK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4868E27702D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 19:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758916617; cv=none; b=ia+RWW2dLoy05asZgSCNE7/LxVEguqof1JnD2dSNFP1mfRwm41fOC4xL2l6gk65bFE+YE+UvGq4Xt3ZEe4gFYN+pWod6eP+xL0fJvdHHxi8ki9hzkP5euuUuXrJs3ROoutyRexxSD9lwkO9inZRO/zIjPfuNLBxRoww0A/dQ+F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758916617; c=relaxed/simple;
	bh=gcGsUnTOZFpinJGpNbdgg0OIj3E+Jfes84YS3x9qtxQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fgcTEym7JOhnS7GNXqNL9xevf8rIaCdM3VryQ+5bDPNkcIgLck/cTtdmFuj1tqVudueL8vpDrV995y2Uyi1ZKmNMuS5IeVybz75PbGSwnfhLY/DJetzZ6CDcA0DOSEwkKqySMp1w3BpJHK5rglMOMgCsN+TmCEkewlz1tZeX7/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fDrjnqbK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEF39C4CEF4
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 19:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758916617;
	bh=gcGsUnTOZFpinJGpNbdgg0OIj3E+Jfes84YS3x9qtxQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fDrjnqbKi1REwGPLuCqk77aQ+mPJ2PId/3ZbmQ6+0kMlSIBe89HSdM/Kv1MSijTvB
	 qH6Ntla8LBHWxNKdVxCohIImXbtkpCtGouJslVo4HyiMdi6cLBnv5fWQBhnM4n54/P
	 E+40G0XFWSaPJJVEqLxGbFIb9pCXuw07yEjBwPjKs79Bro+FIt4eUA5PLOyE9arHEA
	 pPGaASQ5L6GRepRHTxKtiQW0z3TLxopjpvzvMENzplXhyVCgbp5Rianc4aZkzugx8X
	 anZY/f/LN2fktTyBQ/d+y3GTXWi28v9olrpDlqSSckQsIpe4JocUWU+ACKK5L+hxJ0
	 U656V8rb1OrmQ==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-30cce534a91so1229208fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 12:56:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUWdPbnci7T3+vVI+Jw7yxMwkz+DtlQRst8ynxS2/kvDrj79Q3EcZIGN8+kPhEYs8ORIwO4JTM1KzAjieQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxiFIqYhEh6NSYU7DR9Fa2ZzCuZZoe7WfQBJIYNbn9jPSJg8k0
	Bz3epR5sAxTGiAqzwnka7k2YQ1u5Qb1pNjiT5L9+LuAz0F1nCP4hSCLlRn1IikVf0sdJbpJhWQr
	4pXZvInk1Dv8D56CQdQpDP6Zih7sx6So=
X-Google-Smtp-Source: AGHT+IGJ/TxHhBSCdFSnxsLS7fZGkjdX7dT0D8z+pBuvh59HzTsZmy6A7jugzekGBS2nliL1lV4cbhsldt5sqg9JmMk=
X-Received: by 2002:a05:6870:a79f:b0:2ff:a27f:9c67 with SMTP id
 586e51a60fabf-35ee91f95f8mr4352546fac.30.1758916616241; Fri, 26 Sep 2025
 12:56:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6196611.lOV4Wx5bFT@rafael.j.wysocki> <2238241.irdbgypaU6@rafael.j.wysocki>
 <68d6edf1cab3b_10520100a5@dwillia2-mobl4.notmuch>
In-Reply-To: <68d6edf1cab3b_10520100a5@dwillia2-mobl4.notmuch>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 26 Sep 2025 21:56:45 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iaEyW743NePaVvZnshpRFtxq3QnCrRb7nJ9oNAJnvVdA@mail.gmail.com>
X-Gm-Features: AS18NWCYJqFIPAhDtZnyW3qMyNTZNTsvssMQGk-05hTXXDWPyxwVHVeNg4owybg
Message-ID: <CAJZ5v0iaEyW743NePaVvZnshpRFtxq3QnCrRb7nJ9oNAJnvVdA@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] PM: runtime: Add auto-cleanup macros for "resume
 and get" operations
To: dan.j.williams@intel.com
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Takashi Iwai <tiwai@suse.de>, 
	LKML <linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, 
	Alex Williamson <alex.williamson@redhat.com>, Bjorn Helgaas <helgaas@kernel.org>, 
	Zhang Qilong <zhangqilong3@huawei.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Frank Li <Frank.Li@nxp.com>, Dhruva Gole <d-gole@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 9:48=E2=80=AFPM <dan.j.williams@intel.com> wrote:
>
> Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > It is generally useful to be able to automatically drop a device's
> > runtime PM usage counter incremented by runtime PM operations that
> > resume a device and bump up its usage counter [1].
> >
> > To that end, add guard definition macros allowing pm_runtime_put()
> > and pm_runtime_put_autosuspend() to be used for the auto-cleanup in
> > those cases.
> >
> > Simply put, a piece of code like below:
> >
> >       pm_runtime_get_sync(dev);
> >       .....
> >       pm_runtime_put(dev);
> >       return 0;
> >
> > can be transformed with guard() like:
> >
> >       guard(pm_runtime_active)(dev);
> >       .....
> >       return 0;
> >
> > (see the pm_runtime_put() call is gone).
> >
> > However, it is better to do proper error handling in the majority of
> > cases, so doing something like this instead of the above is recommended=
:
> >
> >       ACQUIRE(pm_runtime_active_try, pm)(dev);
> >       if (ACQUIRE_ERR(pm_runtime_active_try, &pm))
> >               return -ENXIO;
> >       .....
> >       return 0;
> >
> > In all of the cases in which runtime PM is known to be enabled for the
> > given device or the device can be regarded as operational (and so it ca=
n
> > be accessed) with runtime PM disabled, a piece of code like:
> >
> >       ret =3D pm_runtime_resume_and_get(dev);
> >       if (ret < 0)
> >               return ret;
> >       .....
> >       pm_runtime_put(dev);
> >       return 0;
> >
> > can be changed as follows:
> >
> >       ACQUIRE(pm_runtime_active_try, pm)(dev);
> >       ret =3D ACQUIRE_ERR(pm_runtime_active_try, &pm);
> >       if (ret < 0)
> >               return ret;
> >       .....
> >       return 0;
> >
> > (again, see the pm_runtime_put() call is gone).
> >
> > Still, if the device cannot be accessed unless runtime PM has been
> > enabled for it, the CLASS(pm_runtime_get_active_enabled) variant
>
> Leftover from CLASS() approach?

Yup.

> s/CLASS(pm_runtime_get_active_enabled)/ACQUIRE(pm_runtime_active_try_enab=
led)/

I'll fix this when applying.

> > needs to be used, that is (in the context of the example above):
> >
> >       ACQUIRE(pm_runtime_active_try_enabled, pm)(dev);
> >       ret =3D ACQUIRE_ERR(pm_runtime_active_try_enabled, &pm);
> >       if (ret < 0)
> >               return ret;
> >       .....
> >       return 0;
> >
> > When the original code calls pm_runtime_put_autosuspend(), use one
> > of the "auto" guard variants, pm_runtime_active_auto/_try/_enabled,
> > so for example, a piece of code like:
> >
> >       ret =3D pm_runtime_resume_and_get(dev);
> >       if (ret < 0)
> >               return ret;
> >       .....
> >       pm_runtime_put_autosuspend(dev);
> >       return 0;
> >
> > will become:
> >
> >       ACQUIRE(pm_runtime_active_auto_try_enabled, pm)(dev);
> >       ret =3D ACQUIRE_ERR(pm_runtime_active_auto_try_enabled, &pm);
> >       if (ret < 0)
> >               return ret;
> >       .....
> >       return 0;
> >
> > Note that the cases in which the return value of pm_runtime_get_sync()
> > is checked can also be handled with the help of the new class macros.
>
> s/class/guard/

Right, thanks!

> > For example, a piece of code like:
> >
> >       ret =3D pm_runtime_get_sync(dev);
> >       if (ret < 0) {
> >               pm_runtime_put(dev);
> >               return ret;
> >       }
> >       .....
> >       pm_runtime_put(dev);
> >       return 0;
> >
> > can be rewritten as:
> >
> >       ACQUIRE(pm_runtime_active_auto_try_enabled, pm)(dev);
> >       ret =3D ACQUIRE_ERR(pm_runtime_active_auto_try_enabled, &pm);
> >       if (ret < 0)
> >               return ret;
> >       .....
> >       return 0;
>
> I like that this appears to unify the pm_runtime_resume_and_get() and
> pm_runtime_get_sync() usages into common pattern.

That's intentional.

> > or pm_runtime_get_active_try can be used if transparent handling of
> > disabled runtime PM is desirable.
>
> Do you think the above should go in Documentation too?

It will, when early adopters tell me that they are happy with it.

> Either way, for the usage of ACQUIRE(), looks good to me.
>
> Acked-by: Dan Williams <dan.j.williams@intel.com>

Thank you!

