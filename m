Return-Path: <linux-kernel+bounces-824435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C997EB89330
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 13:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 795023BD9FF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 11:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D35A30AD0D;
	Fri, 19 Sep 2025 11:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="goYh3ibz"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1942527E041
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 11:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758280186; cv=none; b=tP6dUTPUgtrRoaK8nokuFjmgo2MtIXn3NHHQa2GroiDX0Un/jHySmEeJN2XqWYPgggaSDbIDq6AGkDongWr71WTJGEHIJWJyzgjUZ2Rds9iikGxG6ufHwQRWotE6uRmDH25mXX/e+/P1v1d1d2qxQ5iDXxKCITmELncVieHGGgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758280186; c=relaxed/simple;
	bh=9xlhMZfruFIUN/c9mBI96kt2FDAl13Np7TQH6oEppSg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AVDVudn50styUqMaiPWpp2mnmKGx1xnOmryUu5u1rZY0Ew4HwmD9vcOejz/dUfVWQ/Q+ADaoFxzylEQ7uNPYeIcrqHhyjZFOSjahaaSUOJZ9/a6XiXkzktxL0GzMQ88VAggE0zGXkancATLtggp4CFFP9ok8vLeoJf3NaxQNz0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=goYh3ibz; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3c68ac7e18aso1076639f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 04:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758280183; x=1758884983; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9xlhMZfruFIUN/c9mBI96kt2FDAl13Np7TQH6oEppSg=;
        b=goYh3ibz4OrxLoJcnBu68YUK7G0ViIO8Nk9kT2V2kym/gu8Ekqb3PRGU7Tt8ZIDpUY
         wyJMVGR2HfKhF90mNpMYB8/VtB4xVF8HbDastAo1Ug3XyOGs+cOPw7n5hGlX1QGzCWz4
         RWq1t17vdBpruqwhcStC/CQGKGVvi6iSwyRH6rvqyJUz/zTztX2Ver97Ann/KUkhnD6L
         qKL1HAOF0msMGz4IczxwQAhpErOoUlOOSCp7yxQGqHAZG1UUbC1DHlh3dxKF6HtBoqCS
         mBHFfaPHV7DG9cZdoC3JlpAnb47sAKAYs7t9OmkRittZ8XZ1UeikCajAPNWpQBus/bqY
         ijMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758280183; x=1758884983;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9xlhMZfruFIUN/c9mBI96kt2FDAl13Np7TQH6oEppSg=;
        b=PdYC4cBPuxrlxIt3xVtKASgflIlbX9Ph0iB68CbykPDe03yTnVICYBWo9coHxzt7y2
         Y4mBJn9g2TDZjo0T2JOmDaJYypvSxCFCm0naej/e4QTc6RaEeQ4WzV+9tJxwr9rUAUD3
         W+p0fhCnUaVNM7nERwco7N4yfpYzkDkkYUdgLft5BZEjpmPxagabrmB4OwT2ODeXix/R
         oV9JGpBnNQOXcWO/R/2NGSK8oD3Mz57Moz61Q8FhUZpwKiMMZynaez0+Xke2hYwCJwKX
         QK7zcASODszbYU93iGTn3NloiQR7mVRGxFbHckiqQdOSvIfKOAzzoTEkogo/UsYmv8yt
         9QIA==
X-Forwarded-Encrypted: i=1; AJvYcCVPxtPjqoN7cYGuvtK3tTfoauBJdcNj6xRVxQC5zYsE+CFm3e28aRpqWgazryT8yRYOdEeordz74dDOIGE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr5jFcN9jbhW9Ca/ogDa+dV3oA3PbqqXhs5RWokUUzm2B0kBky
	zBpzJG2BqFZWtUvUz3reSIbp7rE7Njbmsm7E/BnKGIHtDFOonaoLoa+L
X-Gm-Gg: ASbGncs4L5oVuXMhEWkouK3Z42aM2cZIY+6d33HBXF19pHci7U0qrZIRmAn4m0KIkwl
	EKjzHTIPCK0BqiLwT3YdJB1i/brfO69N9zVHJBk3T0ytYLHoeCp1pl7xs7P+yHRPcDXeejFmsH0
	bm6ZSBoNVKJOmE4TFCk1Fwb8kJN68s76pU/GZrBjPm+7Vxc+sZUYITc8UW55qG4gkP1W2KJIx7r
	FUDnAPFvkj+yDEHVFMZZNlJe0rRXu/521IEQz1+TB1GWdOySlcLIhW1c9Ub7iK5N3TKD4GVkINM
	/C2hXLWp8LA8Xr38OnW6bFNvFVn7XudHJgRC37Q6Qqzx/D5EOKVziguSUV2wa3zDfaSx673BM2a
	Lj/rWmi+CBFUSn7U6rC3c2f8=
X-Google-Smtp-Source: AGHT+IFNNb0AJfOAIWWdn4eT+r/+4MiYY9bLpe+1qxQe4AgTnluF+MQf1Xo79UT6mJHHUYc1AWu5NQ==
X-Received: by 2002:a05:6000:2dc3:b0:3ea:6680:8fa3 with SMTP id ffacd0b85a97d-3ee851afab7mr2139719f8f.42.1758280183029;
        Fri, 19 Sep 2025 04:09:43 -0700 (PDT)
Received: from [10.5.0.2] ([45.94.208.147])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3f00cc58b91sm1849128f8f.1.2025.09.19.04.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 04:09:42 -0700 (PDT)
Message-ID: <9331e7064c6e6b4224e5ad50e1673e9c0c966ae0.camel@gmail.com>
Subject: Re: [PATCH] iio: imu: lsm6dsx: Add shutdown callback support for
 I3C interface
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: "Guntupalli, Manikanta" <manikanta.guntupalli@amd.com>, Andy Shevchenko
	 <andriy.shevchenko@intel.com>
Cc: "git (AMD-Xilinx)" <git@amd.com>, "Simek, Michal"
 <michal.simek@amd.com>,  "lorenzo@kernel.org"	 <lorenzo@kernel.org>,
 "jic23@kernel.org" <jic23@kernel.org>,  "dlechner@baylibre.com"	
 <dlechner@baylibre.com>, "nuno.sa@analog.com" <nuno.sa@analog.com>, 
 "andy@kernel.org"	 <andy@kernel.org>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>,  "linux-kernel@vger.kernel.org"	
 <linux-kernel@vger.kernel.org>, "Pandey, Radhey Shyam"	
 <radhey.shyam.pandey@amd.com>, "Goud, Srinivas" <srinivas.goud@amd.com>, 
 "manion05gk@gmail.com"	 <manion05gk@gmail.com>
Date: Fri, 19 Sep 2025 12:10:08 +0100
In-Reply-To: <DM4PR12MB6109997B928B39D878B12FB68C5CA@DM4PR12MB6109.namprd12.prod.outlook.com>
References: <20250721110741.2380963-1-manikanta.guntupalli@amd.com>
	 <aH4mwkh80TUTNXtS@smile.fi.intel.com> <aH4m84n5UbCsktCM@smile.fi.intel.com>
	 <DM4PR12MB6109997B928B39D878B12FB68C5CA@DM4PR12MB6109.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-07-22 at 07:19 +0000, Guntupalli, Manikanta wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
>=20
> Hi @Andy Shevchenko,
>=20
> > -----Original Message-----
> > From: Andy Shevchenko <andriy.shevchenko@intel.com>
> > Sent: Monday, July 21, 2025 5:10 PM
> > To: Guntupalli, Manikanta <manikanta.guntupalli@amd.com>
> > Cc: git (AMD-Xilinx) <git@amd.com>; Simek, Michal <michal.simek@amd.com=
>;
> > lorenzo@kernel.org; jic23@kernel.org; dlechner@baylibre.com;
> > nuno.sa@analog.com; andy@kernel.org; linux-iio@vger.kernel.org; linux-
> > kernel@vger.kernel.org; Pandey, Radhey Shyam
> > <radhey.shyam.pandey@amd.com>; Goud, Srinivas <srinivas.goud@amd.com>;
> > manion05gk@gmail.com
> > Subject: Re: [PATCH] iio: imu: lsm6dsx: Add shutdown callback support f=
or
> > I3C
> > interface
> >=20
> > On Mon, Jul 21, 2025 at 02:38:42PM +0300, Andy Shevchenko wrote:
> > > On Mon, Jul 21, 2025 at 04:37:41PM +0530, Manikanta Guntupalli wrote:
> > > > Add a shutdown handler for the ST LSM6DSx I3C driver to perform a
> > > > hardware reset during system shutdown. This ensures the sensor is
> > > > placed in a well-defined reset state, preventing issues during
> > > > subsequent reboots, such as kexec, where the device may fail to
> > > > respond correctly during enumeration.
> > >=20
> > > Do you imply that tons of device drivers missing this? I don't think
> > > we have even 5% of the drivers implementing the feature.
> > >=20
> > > > To support this, the previously static st_lsm6dsx_reset_device()
> > > > function is now exported via EXPORT_SYMBOL_NS() under the
> > > > IIO_LSM6DSX namespace, allowing it to be invoked from the I3C-speci=
fic
> > > > driver.
> > >=20
> > > Why system suspend callback can't do this?
> >=20
> > Ah, and why only I3C is important? Doesn't I2C or SPI also broken in th=
is
> > sense?
>=20
> There is no device enumeration process involved for I2C and SPI, so they =
are
> not impacted.
>=20
> However, for I3C, device enumeration does occur. During this process, the
> device PID and BCR/DCR values are compared against the entries defined in=
 the
> driver:
>=20
> static const struct i3c_device_id st_lsm6dsx_i3c_ids[] =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 I3C_DEVICE(0x0104, 0x006C, (vo=
id *)ST_LSM6DSO_ID),
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 I3C_DEVICE(0x0104, 0x006B, (vo=
id *)ST_LSM6DSR_ID),
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { }
> };
>=20
> Only if there is a match, the probe function will be called.
>=20
> Additionally, the sensor reset logic is implemented inside the probe.
> Therefore, to ensure the sensor responds correctly during device enumerat=
ion
> after a reboot (such as after kexec), it is necessary to reset the sensor
> during the shutdown phase.
>=20

Hmm I see. I was going to ask why can't we just do this during probe().

- Nuno S=C3=A1

> Thanks,
> Manikanta.

