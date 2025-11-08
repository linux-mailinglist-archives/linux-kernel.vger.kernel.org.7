Return-Path: <linux-kernel+bounces-891459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B07CC42B46
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 11:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B65E734A389
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 10:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEBE32FCC10;
	Sat,  8 Nov 2025 10:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RmwRP73j"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BE12FC024
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 10:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762597525; cv=none; b=j+z8a/ILaR04pnMSQC32q6wDZo7EzIENrz/15LyWjkXM1Pllz32Q4ihlx01eT8rBjNJR50Remfjq5y0Egi4uFU653VV9tbdfDfoiGAA3Td7cwIJ0hB2uRnqDrEiDezlDbi4LambsbV2p0H8fttO86/9XjFJy89YusvSS8OVHvWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762597525; c=relaxed/simple;
	bh=edkeFamHGMtqmzoxgm5+GBH8lS9BaJlzt9lOLcAyeAE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZRYl1RFEQucdn8R2A0qTn6BxK+ZTaIwnGUM85PfBuuo0ih1bEDCeRnCg9EwbdNDPfc18/f/3ovSaJ9BX4RtsBXYpYaCiVtlF2YtNnRQEKNnt96GuCpkMp9bQ3d6SK3OC39k69VXzozaUSeuhsjthO5o/dK4vM24Eut+uDYSDeSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RmwRP73j; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3ed20bdfdffso1429688f8f.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 02:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762597521; x=1763202321; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kXDYd3AFiu0SkxyPJ9uzyD3xwRVj9J1Ie5FJD40k2zU=;
        b=RmwRP73j0sU7SrHek5Vjpor9mI4FoCm/vKw7EZRfQhxMutkeHWh/GK/t9ZhhbdiKJJ
         lIv2frStX4AExaItPsI4C597E4VH4O7WA1p+TUNR4max5QnXcLHTLqHdIZgq6F/YODeS
         K5K5HJ6A/A4ygyrGj7iJeNZVs8Mc4oJf9U8MXbbNxS9SM7fmgLsvS+0zbTIuUGxT2UKM
         572chj7AAGI/WgoxjLcCAz6AynOTEEWKEa8yhkk+Fx/5W7ul84uBOacd1CsaOV5v5igJ
         F5uOyctc6pxIreJsHdrh04qJnGNACpTMyFIwaa24ZyUEDVTY/SOMXmVoThrR1wp+A9Y2
         wVvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762597521; x=1763202321;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kXDYd3AFiu0SkxyPJ9uzyD3xwRVj9J1Ie5FJD40k2zU=;
        b=brxCPNhoQUoGUK2HOFJPlK+xiZUkotHnAFY34B8RCb/iBOrodPuSsbcTLjy733hgvg
         qqZD/Ufyb+7bwrhrV+AueTuA9KJhNsRKDThnT7KxiQyKvFS21uWAQI5lbZKkT3+pCvSg
         5ByC4xQiah3M0IltSotgaQWs4JmH5lqiDP91n3dkUft/Ix39OxrBaY7h00+qw23vkKrl
         v7dYeH0+b/kBpBjcDzcCsViCsF9C27DbNDAst31cumt/ugKVCigIkR+lXOckD1ojtm8m
         Ki5TUSAMwnVNNh+vPK5/QmNQqMBqBdGij0VDrF/CbqwhxOxLDqDs3kZk6qEP2tk4oePH
         JONQ==
X-Forwarded-Encrypted: i=1; AJvYcCWF3koPB626/x09GPBbqe+9Rg6aQhDscmhwAYJsRbygnFWBa6VxNy5pLY4v+lSiIkQW+sRX5xmu+0hcYoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyakGCODTvizEUJZZC+SPbrnkaauYPu+YdUPRmXt25JO6pF4Um0
	5nFwqcJvrjZY+UrgBc0mCblKi1JVjanzrhnrfQvoNU3Qp7YuAdWQbNwQ
X-Gm-Gg: ASbGnctAOv0bz/dadOyNb8hzGmIAlQfEt10XL1nctX9cRX1KVLBR/sKPZgH9qhWcYNP
	SXgYssFvw5iX4dofEUCdBCzahcUfmqiN+WzfNbSyrJ8w3cPIxYUt9KwNI2KWikNoeSSyevW6/uY
	/hIQ+rv7Vr8pyK93cWzKgvPlAU8NA+4La/AmCo+uNLIRTOR1c8VTuO1POTXFwaHD+drYMuYM4Xx
	AvwB9c826W+NcPFZ6089fXPXMYyB8Jw3hoER0rHPKt9W02/Xzz+LqmENBotSjBqmtL36XsG/crw
	STR55Tqvx92/xvxJ2ZoiJIrYuL1tVcWprXSQ3Fj1n1WUcjK2IiHRfZArTNtl//1QIgkSbGBnzQ3
	qK4t3TZ3grQHeIazWSQWrwTjO4TOUSppMwIi2wXl9PIGsCA3rCtrgUV9mSv6/BFDM0lc15h8p0N
	qW6JT62zyyNJan2Kn+SlVlqwUiwNK1kic4/zGq7Bk/1yJubujHrM8XjI7q9Uw=
X-Google-Smtp-Source: AGHT+IEl3DAiqgThvVJsW3h9LsNQGzlRKJ42h6whlt9K3mExQg0fRMpo96Hnr13+gl2KdwzafZ1+vA==
X-Received: by 2002:a05:6000:40cb:b0:429:cf88:f7aa with SMTP id ffacd0b85a97d-42b2dc16d26mr1303521f8f.9.1762597521308;
        Sat, 08 Nov 2025 02:25:21 -0800 (PST)
Received: from ?IPv6:2001:818:ea56:d000:94c4:fb0e:28f:2a8d? ([2001:818:ea56:d000:94c4:fb0e:28f:2a8d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42abe62b23csm10571649f8f.10.2025.11.08.02.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 02:25:20 -0800 (PST)
Message-ID: <b6d9db5e17bb3400888ee6e5934cfbe5fa2251e2.camel@gmail.com>
Subject: Re: [PATCH v3] iio: trigger: Fix error handling in
 viio_trigger_alloc
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Ma Ke <make24@iscas.ac.cn>, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Date: Sat, 08 Nov 2025 10:26:21 +0000
In-Reply-To: <aQ44IB1b7AXun_qN@smile.fi.intel.com>
References: <20251107020200.6285-1-make24@iscas.ac.cn>
	 <9aac9a66c02c691e073043f918fef055dca888e9.camel@gmail.com>
	 <aQ3NHnL2rF0wkqeo@smile.fi.intel.com>
	 <9e96f49f3903f704e16e8dde540507b10a978951.camel@gmail.com>
	 <aQ44IB1b7AXun_qN@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-11-07 at 20:19 +0200, Andy Shevchenko wrote:
> On Fri, Nov 07, 2025 at 04:48:03PM +0000, Nuno S=C3=A1 wrote:
> > On Fri, 2025-11-07 at 12:42 +0200, Andy Shevchenko wrote:
> > > On Fri, Nov 07, 2025 at 10:26:10AM +0000, Nuno S=C3=A1 wrote:
> > > > On Fri, 2025-11-07 at 10:02 +0800, Ma Ke wrote:
> > > > > viio_trigger_alloc() initializes the device with device_initializ=
e()
> > > > > but uses kfree() directly in error paths, which bypasses the devi=
ce's
> > > > > release callback iio_trig_release(). This could lead to memory le=
aks
> > > > > and inconsistent device state.
>=20
> ...
>=20
> > > > > -free_descs:
> > > > > -	irq_free_descs(trig->subirq_base,
> > > > > CONFIG_IIO_CONSUMERS_PER_TRIGGER);
> > > > > =C2=A0free_trig:
> > > > > -	kfree(trig);
> > > > > +	put_device(&trig->dev);
> > > >=20
> > > > Yes, device_initialize() docs do say that we should give the refere=
nce
> > > > instead of
> > > > freeing the device but I'm not see how that helps in here. Maybe in=
itializing
> > > > the
> > > > device should be done only after all the resources are allocated so=
 the code
> > > > is a
> > > > bit
> > > > more clear... But doing it like you're doing just means that we mig=
ht get
> > > > into
> > > > the
> > > > release function with things that might or might not be allocated w=
hich is a
> > > > pattern
> > > > I would prefer to avoid.
> > >=20
> > > The put_device() here is the correct (and must) thing to do independe=
ntly on
> > > the preferences. The problem is that device_initialise() and followed=
 calls
> > > may do much more than just some initialisation.
> >=20
> > Well, I would argue against that (at least in the context the function =
is now
> > implemented). To me, the right thing to do would be to move the device
> > initialization
> > code to this point:
> >=20
> > https://elixir.bootlin.com/linux/v6.17.7/source/drivers/iio/industriali=
o-trigger.c#L594
> >=20
> > trig->dev.parent =3D parent;
> > trig->dev.type =3D &iio_trig_type;
> > trig->dev.bus =3D &iio_bus_type;
> > device_initialize(&trig->dev);
> >=20
> > Then we would not even need to think about put_device(). Like it is, us=
ing it,
> > it's
> > just prone to errors (I did mentioned a couple of things this patch int=
roduced If
> > I'm
> > not overseeing it) or we do need to have lots of care in the release fu=
nction to
> > make
> > sure we don't mess up. To me that's a bad sign on how the code is archi=
tectured.=20
> >=20
> > FWIW, the pattern you find for example in SPI is the natural one for me=
:
> >=20
> > You have a spi_alloc_device() [1] that initialises struct device right =
in the
> > end.
> > Above it, kfree() as usual. Then the callers, will indeed use put_devic=
e() in
> > their
> > error paths.
> >=20
> > So the pattern to me is to do device_initialize() after all resources o=
f your
> > device
> > are allocated. So that after that point put_device() does not get you i=
nto some
> > odd
> > handling in the release callback.
>=20
> Sure, this can be another approach. Whatever you, folks, prefer. But at l=
east
> the mutex_destroy() (separate) patch can be issued and accepted independe=
ntly.
>=20

Sure, agreed on that.

> The bottom line is:
> 1) the current code has an issue;
> 2) the proposed fix has its own flaws;
> 3) but the idea in the current approach at least small (if implemented
> correctly) and makes sure that any new allocations won't be forgotten in
> the error patch, nor in the ->release() callback.
>=20
> > [1]: https://elixir.bootlin.com/linux/v6.17.7/source/drivers/spi/spi.c#=
L568

FWIW and unless I'm missing something there's nothing fundamentally wrong i=
n the
current code (i.e any real bug). That said, I would ack a change that moved=
 the
device initialization code to it's natural place (at least in the way I see=
 it).

- Nuno S=C3=A1

