Return-Path: <linux-kernel+bounces-848661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A84ADBCE4A0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 20:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 09467352022
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 18:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22FC2FE066;
	Fri, 10 Oct 2025 18:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qZE2tDmn"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F7920A5DD
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 18:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760122232; cv=none; b=c7++TPIJJLLBCXwq5Disjegu5MG2MPk7YvfOT1jABeL+t1T2AsRI9bQ040rkT1hq948n0SxRjBuTa/2giZycpcBZ1s7ZzmafaAXpYU49jRJFt3ZuAG5vz7nNwZYt+fDFBqhbTyAlkkNcxzLp55ew92eSp7mIgR4Ao2W/HUphE8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760122232; c=relaxed/simple;
	bh=T4Budy1jXSLlercgtrn4PbOz6eQtpWNlY7M/FC5LWFI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=okbfPTb+o9iNZCg4QZxG/8aIdb9lG+Dnl62gwI6uzBbsafNmMgkLZgt54GB6aE8ISdymPifXekvE9bf0GCwBFPs9ZWUljxDB40k499eOZyoPJnUqAu91g3HBNxT9nd7iPGySykT2Vu1urL/9L7X2G4o1QNU9wG9ZU5Q4y09g1Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qZE2tDmn; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-631df7b2dffso5569969a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 11:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1760122228; x=1760727028; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T4Budy1jXSLlercgtrn4PbOz6eQtpWNlY7M/FC5LWFI=;
        b=qZE2tDmnSRsMSbF083bpNH0mcYXKzTXQZN4tdhYme5HTQ3E4g6qEBSALtNNrpmiZYU
         oMeyhuGz0WPUGbOZQWL/gKG0VSsDClICv4F2Vkbb7cSFJnaBPnizmYSz+10pc8FU6ktb
         E0icd4JmSWbQRwLf8QBHsfJFTNahfN/vlnGov0b66ZJ75KJUSh1k7JQKFa3rmtgmJNTn
         Y77HAz2sDoV0++L0mK89mbvWkgRCjBHGTLlMUlUdQnuGB8yJg9cczMsVhY5HY+H+WOtk
         VQw63AYYLxB+Y4hVmCl28w31CVCsQ6cn/PPvl+qT6dvbs5QjcE3JnlSYCldcxAkeNreL
         9Daw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760122228; x=1760727028;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T4Budy1jXSLlercgtrn4PbOz6eQtpWNlY7M/FC5LWFI=;
        b=RZM491qPQ2EVMznfPp9O8Anovsbz+BcNsIqjkwA+YfmQZFSGGQuUnxts0S1PFCIyTO
         i+m3aPmT7o07jZSY/vEtnZCghFGo/onn4ytIYoeyJgNxltYEXEAnuwOeMDJxTp06qxxt
         7k10j1rv4KRb+uh8ZTO1XqgqSMoJ7Kvon/KVf5lsT2nt4HFgtFcMFFLqtIg2jGT+Ak5n
         NhaKmMJ92PGwD83pgDaKv9e7iJ+v0wh6KLCX3so3drd0YiduyqOTtME0GYpi4t/LJ8Ln
         ch5swS6mUM9ARhcoiHalCfgu2jRzj5WSzT9QDLAZM8ueQ/VLkKmNOBRN1hb97uyqblwq
         EeXw==
X-Forwarded-Encrypted: i=1; AJvYcCV5Z9nhkEBjDK+e3FWSd7SC32NE4IipqF5OwlQY2hZ2r/n0+SPousI7kEj8jko8QSUMynDdUhF7NT0+Oag=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDa67B9ht9rxTYXoW1UlqidzHFRVnkdobdjvBwUzixqTkt8NsJ
	HjSQAV88tOYzqf+SLzIWLTwzR0QZECBd8IVx6rZT8ppnTnkfTqT8zaIqbtNUA/uL4Hk=
X-Gm-Gg: ASbGnctF0phWrVbDiUMwxU98OCuVug+jU/RgZkXkITtVg/oS/pc45QXJ57U1DT/220B
	B14KDZQgDQT4/T/IrCY2As5105/Pq7uNUSKSkN7HwzRPirSm6I/3Jd5odc99ViEDviV2htJa0Or
	xinwV00SvEpx+kscKNX/y9cHEOZj2d9KtUJlMlmZtDitcQhsgybeQKuPqYzNkHZaLCJ1UeIXZGG
	fAemp5AZb+wfbA/ShGmbPqT64JV9YtjNrVOj/0+i8NLpL52A/KsspZDEaMS9ylrjEW0GeFWyS2d
	LWjvSP5QwrW7gqklAJkKzR8qtG0yia25M68TlCsbAS37z/pR2UlvoPHa19/19chOzFnekjOxBhF
	K5L09Nzem43pmUGqtL7iF72ipTC6LwKGgX6TVjgw+KfCawupHEd5nfJXHmD7QDvZQdgk152iNMh
	8RPQjlaiggEHaqNYAxRg==
X-Google-Smtp-Source: AGHT+IEs4wWKx5z1QRM58/zXYGHVUOzWtKzxDvdrvor11N+CdK+Hl2hrziDoP4wdeSOKgb5Ne70+3A==
X-Received: by 2002:aa7:d996:0:b0:62f:9091:ff30 with SMTP id 4fb4d7f45d1cf-639ba74c4dbmr13949390a12.3.1760122228145;
        Fri, 10 Oct 2025 11:50:28 -0700 (PDT)
Received: from [10.203.83.193] (mob-176-247-62-200.net.vodafone.it. [176.247.62.200])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a5235e7ebsm2886737a12.1.2025.10.10.11.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 11:50:27 -0700 (PDT)
Message-ID: <95fb4340ac66244dad71a38ae221211a871ccbef.camel@baylibre.com>
Subject: Re: [PATCH 2/2] iio: imu: st_lsm6dsx: Decouple sensor ODR from FIFO
 batch data rate
From: Francesco Lavra <flavra@baylibre.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Jonathan Cameron
 <jic23@kernel.org>,  David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 10 Oct 2025 20:50:26 +0200
In-Reply-To: <20251010184437.00004428@huawei.com>
References: <20251009173609.992452-1-flavra@baylibre.com>
	 <20251009173609.992452-3-flavra@baylibre.com>
	 <20251010184437.00004428@huawei.com>
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

On Fri, 2025-10-10 at 18:44 +0100, Jonathan Cameron wrote:
> On Thu,=C2=A0 9 Oct 2025 19:36:09 +0200
> Francesco Lavra <flavra@baylibre.com> wrote:
>=20
> > The rate at which accelerometer or gyroscope sensor samples are fed
> > to the hardware FIFO (batch data rate, or BDR) does not have to
> > coincide with the sensor sampling frequency (output data rate, or
> > ODR); the only requirement is for the BDR to not be greater than
> > the ODR. Having a BDR lower than the ODR is useful in cases where
> > an application requires a high sampling rate for accurate detection
> > of motion events (e.g. wakeup events), but wants to read sensor
> > sample values from the device buffer at a lower data rate.
> > To support the above use case, add a sampling_frequency sysfs
> > attribute to the buffer directory of st_lsm6dsx IIO devices, which
> > controls the BDR for a given sensor independently from the "main"
> > sampling_frequency attribute (which controls the ODR); introduce a
> > new `bdr` field in struct st_lsm6dsx_sensor to keep track of the
> > current BDR value, and use this field instead of the `odr` field in
> > the code that deals with the FIFO data rate. In the sensor hub
> > driver, make the bdr value always mirror the odr value, since there
> > is no separate configuration setting to control the BDR for data
> > produced by the sensor hub functionality.
> >=20
> > Signed-off-by: Francesco Lavra <flavra@baylibre.com>
>=20
> A few additional trivial things from me.=C2=A0 In general this looks fine=
.
> Whilst that buffer/sampling_frequency isn't common it's been part
> of the ABI for a while for this sort of thing.
>=20
> My only slight concern is backwards compatibility.=20
> Perhaps you can add something on what happens if main sampling_frequency
> is modified by a user who doesn't know anything about
> buffer/sampling_frequency?
>=20
> Given that's a new interface and the ABI always allows a write to one
> value to change any other maybe we have to say the main sampling
> frequency
> write updates the buffer one and a write to the buffer one after that is
> needed
> to set it to a different value?
>=20
> That is a bit ugly but it is backwards compatible I think.

Yes, for backwards compatibility it makes sense to update the buffer
frequency whenever the main frequency is set. Will do.

OK also for the cosmetic changes below.

> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > index 8a9d2593576a..5912ea76d493 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > @@ -56,6 +56,7 @@
> > =C2=A0#include <linux/iio/kfifo_buf.h>
> > =C2=A0#include <linux/iio/iio.h>
> > =C2=A0#include <linux/iio/buffer.h>
> > +#include <linux/iio/sysfs.h>
> > =C2=A0#include <linux/regmap.h>
> > =C2=A0#include <linux/bitfield.h>
> > =C2=A0
> > @@ -105,7 +106,7 @@ static int
> > =C2=A0st_lsm6dsx_get_decimator_val(struct st_lsm6dsx_sensor *sensor, u3=
2
> > max_odr)
> > =C2=A0{
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const int max_size =3D =
ARRAY_SIZE(st_lsm6dsx_decimator_table);
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 decimator =3D=C2=A0 max_=
odr / sensor->odr;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 decimator =3D=C2=A0 max_=
odr / sensor->bdr;
>=20
> No idea why there is a bonus space after =3D but good to cleanup whilst y=
ou
> are
> here.
>=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int i;
>=20
> > +static ssize_t st_lsm6dsx_bdr_store(struct device *dev,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct device_=
attribute *attr,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *bu=
f, size_t len)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct iio_dev *iio_dev =3D =
dev_to_iio_dev(dev);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct st_lsm6dsx_sensor *se=
nsor =3D iio_priv(iio_dev);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int integer, fract;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int ret;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 bdr;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u8 data;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D iio_str_to_fixpoint(=
buf, 100, &integer, &fract);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ret)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return ret;
>=20
> Add blank line after this sort of error handling return.=C2=A0 Slightly h=
elps
> with readability.
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bdr =3D integer * 1000 + fra=
ct;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D st_lsm6dsx_check_odr=
(sensor, bdr, &data);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ret < 0)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return ret;
> Here as well.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bdr =3D ret;
>=20
> Probably here as well.
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!iio_device_claim_direct=
(iio_dev))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return -EBUSY;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* the batch data rate must =
not exceed the sensor output data
> > rate */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (bdr <=3D sensor->odr)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0sensor->bdr =3D bdr;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0ret =3D -EINVAL;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0iio_device_release_direct(ii=
o_dev);
> Add one before the final return.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return (ret < 0) ? ret : len=
;
> > +}

