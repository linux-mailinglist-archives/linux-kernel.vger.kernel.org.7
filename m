Return-Path: <linux-kernel+bounces-837661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 736DBBACDAB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 14:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ED0D16BE3C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 12:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5012DFA39;
	Tue, 30 Sep 2025 12:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RrPEP5IF"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A0C2D9491
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 12:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759235722; cv=none; b=s2NqUn5CVRZcXgzdNNPExu1vSEcIkXQDeHS1G93wQEs7EEcH58mS+FdfQI87lmtQSStbtHiF7TFzuarhwiVbHjG2ysdF+hexb55XPn7VYNlGb58iNIVRf6WhNdJU6spMkvKi2iA0AunsAzM7xkCI/8xUojKJmE8W/GeBaPNMI40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759235722; c=relaxed/simple;
	bh=OLaaAtsGKrDmRCk1hZRgZKq1NLE41t7p401pA47PGFc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dP//cV+4aZTsTLf8xKkU3Plq2nrmvqfOGeaxp1YTDosREcRzIG5BmpLb5wC+Ebl4HxHdqY/AuC96DeqvpBO0fe7uJmh5v/cZLe+zcHSYdJJWRd6n9gkKXj3d0fC0dvP0B9lE3JQydSUuEKupZsH4F2dXV1D0n/V+ZQGzW1GMevI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RrPEP5IF; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46b303f7469so40573665e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 05:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759235718; x=1759840518; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NBIyAliecesuj9+oIEMmhe2lazP4PYGUOdW+EV4Vomg=;
        b=RrPEP5IFP29cUrTMSO87KSi5yQiPup+0NjOnxOUS4ayj2nIRoK8GslpuVJZHuqW+BJ
         lDlNd2za15fedIBfrhFaX7LGh3Xc9iybF7SG49pqmEwMjl4qvKZnLIowh8G5/X3CJuAx
         nvNOoUkmUem5EURbX80lw1vE6i29nXPEuFN0V8HaBxWCVKXPAm+va4k6I9b9q46X8ir5
         fmCP2g1D+YwSusnaZ2jONKQwarh1L5aRghDyo3JilEpJ6uHWF0IecCX/nFnWd2SjjFN2
         37pa2pkduK8VsduRuDgiS5XnQnEeqWB7wwIdYdgVPCqHkrq5NLgJ0xk8OFiEoXAZqd0O
         IzlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759235718; x=1759840518;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NBIyAliecesuj9+oIEMmhe2lazP4PYGUOdW+EV4Vomg=;
        b=VnvIfaRKj3QrI6VQBElK2BRQLEgl5FokHQfrjePpECCmCZBFdy4bOngF75ODZuplR8
         9ObzkW9YK7qSoPfDct0qiLR0Ja5lrcT3AwEfV0ZEJPC1DKSyelHUuRtjZfOgeBKskawb
         LnYUtM9qn88Du6yQMgi4G4JFkwrujZO70qtu9DbIzu+mPN0Gesls4SBF0KVZOEm4eHla
         iso1TH9RcREP58YFZfAe079gTqHa1oT7eYAU4XD2Rn1814lDkvAdoXvIhDeWdPJzFA4e
         heHddODGt+Jvspn6tSJVe8osA1eN76yda83Ckh+Qy7HnyIzXKtSnikYx2vq0JHsaCHNC
         ZJLg==
X-Forwarded-Encrypted: i=1; AJvYcCVkRO3s2UftSQAU/MptRyzLuq2u94OEuVl8QLVmPjE47C9JVtLkj0yGH9MBkQK40jMhtmVRdcDoPL/2Ocg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKlL5RGLcaZYSdltsq37iwDdtrUTV/mHC5j1zyQtzRhrapAcQY
	75Qjx2MXVpMCyVv2dMacvL/WI5obP0BObiLz/pmo1wWcR3LT84UkEa/J
X-Gm-Gg: ASbGncv7SXSrLoIYXROulP3ol4i9NkJJ3GQnxEoILaUBBGizfBkXTnyJzGsquXE4Vs2
	xnVMPlgJ92aun8HZuXZTBOrYbL7kBBmD6NuEK0H2YJu181IPKbF/rxzzcZfkP/vGXQsdfFXruJl
	MloQGsU0WvOEzEewop+9hV3JuEtNjfcGrjCzAHsuA8QxE1UG9ww5XNrvhVRwTgGNY+4vOAzTu37
	p9u6rDn2T6w+w+IoVouvHGcugcr4F8EStp0XDA9+qryR9HwR++QK/DynVhy3POHag3MDW0zrPrz
	ik4rxV8sSaO9kdO0fDeeBgn5nEYyg9nmJ4V5UDoGM0PyGKjI0ziTLmmGp0IKMt8bBDZHbCEduRx
	VUHJJuNetqMbhGRF4YPHS/vZubSJvqx78+YDDgw91yhmLN9MJ4+XQeCsJ9mfGZkucJA==
X-Google-Smtp-Source: AGHT+IGRWpX/HQdAmTKxVyk3t2itUZYUi+he02ZFj0UFND6bEyolg1KIKdz4mv07nGqyDg6HmApvcg==
X-Received: by 2002:a05:600c:4192:b0:468:4350:c84d with SMTP id 5b1f17b1804b1-46e329ab0bamr122521485e9.7.1759235718087;
        Tue, 30 Sep 2025 05:35:18 -0700 (PDT)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e5b577c87sm14230425e9.0.2025.09.30.05.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 05:35:17 -0700 (PDT)
Message-ID: <3c959b42a01d3af75fdf536fc3e3289a076953c3.camel@gmail.com>
Subject: Re: [PATCH v2 1/6] iio: adc: ad4080: fix chip identification
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org, 
	robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Date: Tue, 30 Sep 2025 13:35:46 +0100
In-Reply-To: <20250930103229.28696-1-antoniu.miclaus@analog.com>
References: <20250930103229.28696-1-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.0 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Antoniu,

I think that for a series like this you should include a cover letter...

On Tue, 2025-09-30 at 10:32 +0000, Antoniu Miclaus wrote:
> Fix AD4080 chip identification by using the correct 16-bit product ID
> (0x0050) instead of GENMASK(2, 0). Update the chip reading logic to
> use regmap_bulk_read to read both PRODUCT_ID_L and PRODUCT_ID_H
> registers and combine them into a 16-bit value.
>=20
> The original implementation was incorrectly reading only 3 bits,
> which would not correctly identify the AD4080 chip.
>=20
> Fixes: 6b31ba1811b6 ("iio: adc: ad4080: add driver support")
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> changes in v2:
> =C2=A0- add the chip id handling into a separate commit.
> =C2=A0- use regmap_bulk_read.
> =C2=A0drivers/iio/adc/ad4080.c | 5 +++--
> =C2=A01 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad4080.c b/drivers/iio/adc/ad4080.c
> index 6e61787ed321..b80560aebe2d 100644
> --- a/drivers/iio/adc/ad4080.c
> +++ b/drivers/iio/adc/ad4080.c
> @@ -125,7 +125,7 @@
> =C2=A0
> =C2=A0/* Miscellaneous Definitions */
> =C2=A0#define
> AD4080_SPI_READ						BIT(7)
> -#define AD4080_CHIP_ID						GENMASK(2, 0)
> +#define AD4080_CHIP_ID						0x0050
> =C2=A0
> =C2=A0#define AD4080_LVDS_CNV_CLK_CNT_MAX				7
> =C2=A0
> @@ -458,10 +458,11 @@ static int ad4080_setup(struct iio_dev *indio_dev)
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> -	ret =3D regmap_read(st->regmap, AD4080_REG_CHIP_TYPE, &id);
> +	ret =3D regmap_bulk_read(st->regmap, AD4080_REG_PRODUCT_ID_L, &id, 2);
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> +	id =3D get_unaligned_le16(&id);

Being id an 'unsigned int' I'm not really sure the above will work on big e=
ndian
machines as we should only populate the 2 MSB, right? But independent of th=
at,
id is only being used in here so I would use proper __le16 (and u16) and
le16_to_cpu().

- Nuno S=C3=A1

> =C2=A0	if (id !=3D AD4080_CHIP_ID)
> =C2=A0		dev_info(dev, "Unrecognized CHIP_ID 0x%X\n", id);
> =C2=A0

