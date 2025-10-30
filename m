Return-Path: <linux-kernel+bounces-878067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 538C2C1FB37
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74DED3B7643
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 11:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A96285CAD;
	Thu, 30 Oct 2025 11:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zTPfs4F/"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6D53595B
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 11:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761822245; cv=none; b=IwNTQl87i2DYAElS0WAc1kxLaV9B0oP5GWy9vprBQ6Sc2novfvSFhz6B9ZMlVChoohrlyIiwIM3KDhk7fq/mmupLHr8MCvupa9BqRxzALTLYHRI4v2PKrLMSyNV/D0D5UYTF/V/8X9tNTg/7y83t/9uD2MWNwoyLjOjiDc5mGxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761822245; c=relaxed/simple;
	bh=opKl6kmBemfDcUkCGVEI46l4JB65Z8o+cIBF8NIHkvU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e3vV6Q8Pg4iCw/4ALsOzBmCU0d5cm3iP38B8gculcnMmpl7Rnm3RnxjNX1JpPxJI7THns/A+ib7D/FXK4ZLmmjGNpr7LTBQd8egDQEwI+t/9auF/FzR6UdBJoOF6xorJONKnVKkp/a4OeFuLplIqY+0Fi+NLaTII/nxPAkUwRTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zTPfs4F/; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-63c09ff13aeso1593399a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 04:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761822241; x=1762427041; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=opKl6kmBemfDcUkCGVEI46l4JB65Z8o+cIBF8NIHkvU=;
        b=zTPfs4F//zwTDWAdhNl4v9jxPlKOZ1xJMbZERh4Y8DY6J5U6cS/YoqrzFz+s4UiCQq
         byZT5xfujIJXlwCuVlNOJEdYb9oc7irg4358yqySVInrNoSTcYAfU8bxikHTklpNUs0v
         wdhV5daofa5lKO/BGgMegJjegVL+Ztr8AsFOQ2F5NC4m7GA1j63VsvFyKgo3D3WPB2Py
         A7cJFs4oiBoaQ/b1aquKVYVlAGVFga/mi5+t09RLeZEJ4RmLtM2MkLz4WCCREawoCIEp
         JnnYAFygYio8j8QnwkDRqAlvdwbMdlJMoiQbI04+/M/Ho/lxp0siroqsoCv5i4s0AVVA
         P6aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761822241; x=1762427041;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=opKl6kmBemfDcUkCGVEI46l4JB65Z8o+cIBF8NIHkvU=;
        b=C8y7urrAdq2SpPCln6mJPOWDuH+7vhnoyB47FEAfgvh+dJnzeOPe3irxgXdsOlXorJ
         Vn2ozqsdIqdkA1IVQFW1AM3ALvB++oXEokVfG0ovE5qmOo0zmxNQwTwIxuLx0OYAHG5F
         dgL7DNNiz4obJ8QyLXY7+5LHxuhEGO8mAhZXcfy9oQ4OUc6Ug8fi+yF5S83/+KawB+jN
         FowlaBzo6Kpmsm7XAmYeM47mfP9sHee8+n/6XMsWO7Chn6G9CbLtqMSRl3IYRCynGb1R
         4YZz7mM+43INC4sZBs0SScbVfN2Gas5JTcnml/bhhxi7btdbUXaDJPF/qZOpRl96b9OH
         kB3A==
X-Forwarded-Encrypted: i=1; AJvYcCVp4B6OXOKCV5bR5sVwQ7NYE818hAjpe5ewzjHByiRX+zqGgZlzojmqWI+xh/h8cC+ltHyeL9lIq5MNMww=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx69mmEbUSZWWAoGkE23njRieB+F9blbzULc8tiFEVD9HZaAc6d
	a9Wp7y9Z3p9ToFvFxkUnj2rshArh0baXMlZ2v8rVdOqqcKO49aGX+/SwsEJO1F9d3sM=
X-Gm-Gg: ASbGncsZ7ECUvvLqaZm+TY6CyHgSg5yIz+S4Vgxw+9cbtZmXUz6IYl3nMteRJq5LCxX
	cWuOeANArzMuEd6RZhUCWCfogVZ1fnno7DqjXiiIZ8In7PNXxWBr1bb4KKQq38aYmQmQFx6wNFD
	omt5YJVFTurL7cDY5+EL+8PdW0mP+jd+xQFf72H/KcPoEFEdwCNHwMBCZD163xw471b1rr+1h26
	LKnWsy1m6gbtUTVjcqc6zSehZlZ0GcER4jYbvtUlwpgLufmPs1QDP2UJVQtRaOG5uxXneP8hOYB
	fDFpxJs7GRoYkDc2vZ9ZEZL6MnadebD0JwKc/vcERQIXHhU0F5+YMxIDAcndGzLg53E/04X0exn
	d/uv7gF1KzbLAZlEJ1LXE+ILqXGXoFwCDfMbKGMdjQRloOvzge+0JTfY973zno1I0uWGmmaQvGB
	JJPVofzLDq9GclUr0LRzbdQoPDPGm4spHJPs3SXA==
X-Google-Smtp-Source: AGHT+IGeQ2Ezm3o99pmcKhos9+4NPwwGz5pdokBVRuYPLAzu+QsHbjEWcixgW6rArMmx/CWNIJxFcA==
X-Received: by 2002:a17:906:fe45:b0:b3f:f207:b754 with SMTP id a640c23a62f3a-b703d4ae08dmr699500066b.30.1761822240780;
        Thu, 30 Oct 2025 04:04:00 -0700 (PDT)
Received: from [10.203.83.89] (mob-176-247-57-96.net.vodafone.it. [176.247.57.96])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d853e5138sm1725243566b.44.2025.10.30.04.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 04:04:00 -0700 (PDT)
Message-ID: <6ce5ba44403d2fddbcd35384ce6444f9719c788e.camel@baylibre.com>
Subject: Re: [PATCH 1/9] iio: imu: st_lsm6dsx: dynamically initialize
 iio_chan_spec data
From: Francesco Lavra <flavra@baylibre.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Jonathan Cameron
 <jic23@kernel.org>,  David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 30 Oct 2025 12:03:58 +0100
In-Reply-To: <aQMaaHWjgC2GMGmj@smile.fi.intel.com>
References: <20251030072752.349633-1-flavra@baylibre.com>
	 <20251030072752.349633-2-flavra@baylibre.com>
	 <aQMaaHWjgC2GMGmj@smile.fi.intel.com>
Organization: BayLibre
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-10-30 at 09:57 +0200, Andy Shevchenko wrote:
> On Thu, Oct 30, 2025 at 08:27:44AM +0100, Francesco Lavra wrote:
> > Using the ST_LSM6DSX_CHANNEL_ACC() macro as a static initializer
> > for the iio_chan_spec struct arrays makes all sensors advertise
> > channel event capabilities regardless of whether they actually
> > support event generation. And if userspace tries to configure
> > accelerometer wakeup events on a sensor device that does not
> > support them (e.g. LSM6DS0), st_lsm6dsx_write_event() dereferences
> > a NULL pointer when trying to write to the wakeup register.
> > Replace usage of the ST_LSM6DSX_CHANNEL_ACC() and
> > ST_LSM6DSX_CHANNEL() macros with dynamic allocation and
> > initialization of struct iio_chan_spec arrays, where the
> > st_lsm6dsx_event structure is only used for sensors that support
> > wakeup events; besides fixing the above bug, this serves as a
> > preliminary step for adding support for more event types.
>=20
>=20
> Sounds like a bug fix. Fixes tag?

Will add

>=20
> > +static int st_lsm6dsx_chan_init(struct iio_chan_spec *channels, struct
> > st_lsm6dsx_hw *hw,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0enum st_lsm6dsx_sensor_id id, int
> > index)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct iio_chan_spec *chan =
=3D &channels[index];
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0chan->type =3D (id =3D=3D ST=
_LSM6DSX_ID_ACC) ? IIO_ACCEL :
> > IIO_ANGL_VEL;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0chan->address =3D hw->settin=
gs->chan_addr_base[id] + index *
> > ST_LSM6DSX_CHAN_SIZE;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0chan->modified =3D 1;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0chan->channel2 =3D IIO_MOD_X=
 + index;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0chan->info_mask_separate =3D=
 BIT(IIO_CHAN_INFO_RAW);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0chan->info_mask_shared_by_ty=
pe =3D BIT(IIO_CHAN_INFO_SCALE);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0chan->info_mask_shared_by_al=
l =3D BIT(IIO_CHAN_INFO_SAMP_FREQ);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0chan->scan_index =3D index;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0chan->scan_type.sign =3D 's'=
;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0chan->scan_type.realbits =3D=
 16;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0chan->scan_type.storagebits =
=3D 16;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0chan->scan_type.endianness =
=3D IIO_LE;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0chan->ext_info =3D st_lsm6ds=
x_ext_info;
>=20
> + blank line
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (id =3D=3D ST_LSM6DSX_ID_=
ACC) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0if (hw->settings->event_settings.wakeup_reg.addr) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0chan->=
event_spec =3D &st_lsm6dsx_event;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0chan->=
num_event_specs =3D 1;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0}
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>=20
> if (foo) { if (bar) {}=C2=A0 } =3D=3D if (foo && bar).
>=20
> Based on this I'm in doubt what to suggest here as to me sounds like
> those
> couple of lines might deserve for a helper.
>=20
> Hence two options:
> 1) do an equivalent conditional and reduce indentation level;
> 2) do a helper with the inner conditional.

Will do a helper with the inner conditional.

> + blank line
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> > +}
>=20
> ...
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0channels =3D devm_kzalloc(hw=
->dev, sizeof(*channels) *
> > ST_LSM6DSX_CHAN_COUNT, GFP_KERNEL);
>=20
> devm_kcalloc()
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!channels)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return NULL;
>=20
> I would expect comment here...

This function returns a pointer to the struct iio_dev it allocates and
initializes; if there are any errors, it returns NULL. What kind of comment
do you expect here? It seems obvious that it's returning NULL because of an
allocation error.

>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0for (i =3D 0; i < 3; i++) {
>=20
> 3 might need to be defined.

Will make an enum to replace the ST_LSM6DSX_CHAN_COUNT #define, and use an
enum value instead of 3.

>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0if (st_lsm6dsx_chan_init(channels, hw, id, i) < 0)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return=
 NULL;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>=20
> + blank line
>=20
> ...and perhaps here to explain what's going on here.

Same here, what comment do you expect?

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0channels[3].type =3D IIO_TIM=
ESTAMP;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0channels[3].channel =3D -1;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0channels[3].scan_index =3D 3=
;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0channels[3].scan_type.sign =
=3D 's';
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0channels[3].scan_type.realbi=
ts =3D 64;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0channels[3].scan_type.storag=
ebits =3D 64;
>=20
> + blank line.
>=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0iio_dev->modes =3D INDI=
O_DIRECT_MODE;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0iio_dev->available_scan=
_masks =3D
> > st_lsm6dsx_available_scan_masks;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0iio_dev->channels =3D hw->se=
ttings->channels[id].chan;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0iio_dev->num_channels =3D hw=
->settings->channels[id].len;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0iio_dev->channels =3D channe=
ls;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0iio_dev->num_channels =3D ST=
_LSM6DSX_CHAN_COUNT;
>=20


