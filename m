Return-Path: <linux-kernel+bounces-848727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AD8BCE70B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 22:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C177406DFF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 20:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F4C30148D;
	Fri, 10 Oct 2025 20:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cy+cXTKl"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B593D1E260A
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 20:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760126512; cv=none; b=OS9aJOun6wUskR6CKkwjvxKLpOl9mPkpxWng3qMotbreIo82fwEQssw7qEzoz6DWFi/TDLiVhOxphbsk5m9+SdPrng/GK0Pw71bDtOmjQcvQTZ5xKsI0U2ZHBrVj+6rpuJtU+7PRa/400lR24FrPpfgW/QriV9a1EIMAaR6vhyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760126512; c=relaxed/simple;
	bh=v83TZneUwIbHURqBLBUftZnuT49NHmKFDtDnU+8K10c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iv9OpPXlxfrfiuEhzF2t4gb/6ahrSFLHhCDRG369mWD0aAPiNfr5Cblw0L+Z9nnQ9mXHdcPC8yxMkg7MrbBr+HjLpMHYrZQtTxlf3T5PL/dwCrzwsa4b0H1Uoa1Tq1fw+48IvXbdsqnYnJY9dChZWI/RViM6/WZfyLuPJdqlxfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cy+cXTKl; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-46e2c3b6d4cso17825885e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 13:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760126509; x=1760731309; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zZfPC9OqRt3Pko14zqSSfdQDkti8kHbrjDGGNF/Jl+4=;
        b=Cy+cXTKlZPvYxmTrSFcFNp4DEwW1sX4jZMpr7yDVdo75G7w/nqcqxn9tYIfxLyXyWd
         qKo2kG+knca/THYjP0fqHUHNjOXpxWfaOtaGW+7A8e9cxUmgxDVbeRjYbw+sKkdvX+Jl
         AHoBd2t5tm5+HrhyT62O9P9NKD5kK6ZRptlWlbWSFqcx+L4NpFwD4Ft/g3rLUIJ3zRf2
         dIZN9H61QT5QJc4JATUaBXmDNoxQcieX/YOC1+Og6d/gttzGLo30xm4feYYjQykJ2hYZ
         9m7n/tysyUGT1Y+vu1DLBlxizW3G3OCSPa/Ru6m4JyGtF8AZa42rIUejHwrogY/5Rud2
         lN9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760126509; x=1760731309;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zZfPC9OqRt3Pko14zqSSfdQDkti8kHbrjDGGNF/Jl+4=;
        b=JZ0H61ev4nHrR7y7H7fw3WKhuNSwfC5IE/mGAVzd3UEhP5YphEmAus4GH9NObXLbil
         R9hc/B3OjXC1T6BEX6YAYb9eA+It/z0jLVzh8zOEYg1fu2wOaCaGetiD7ttQQDFYmoH3
         S3cOFrZ3AMs+VtQWfx9U9+JDqbIRqyNpnGNe78TzzFwQHQABnMWOrqOPRAag8fLVnO3G
         mek9lUCkVbV2TRATs7+U0OQrXOtOO9nwq//+3TkyRdaPGl30EaatAK7uRbI1S1oFUgWQ
         kXE3mpgSxOdf2WznsFO9PaHbja5RP/DxXWG9CX4oVp/wymet1Dveg5u9oucu//6xn9ES
         NamQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhzma24HTR+BEtL5n1I63NoKR/Za0k0yBUXOQnVPOH6eXcLbWPqOSTu9VGObGbqDo8CMACo3pX7Udw1dE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVibAsYkfecLUtda8eQmQs2sNztJVCoYB+P2PC4Pbht2/9ObsD
	70pdv/sPKjcJ6x9QeYcBc1Ft4IyCE80t1NP/SCZVEWpSK+Vq4L4SNsbw
X-Gm-Gg: ASbGncuUmHV1DONRujNh4PEP0TeW9HoKHl0epoGtSSq7Cmvq+UwkrZb5clV7+ycZRB0
	6runyFgrUD7Qsk1JxS2Vq6VUWmDDEHel/xA9quUvtIcmnDF55+GsrQypKAbRA86YAmhblaapjXo
	lq0tjTYF0h90ynOtKQw025g3oOUGt6Y1TLyB6JBMqmiVhQm1DC5TuU9Ez7ccMWYud/S3G5B/tLD
	d/aAkJPjQZRdBhDJyUFZDt79D1Jxf5uTb9GGPbLWDOsbRhTZFl3ga05S+X2bGlAm/xbpGyyA+fg
	WMlTHXTTG18nb5YznfbpbmB30Y2G9Q4oF7nRjwhVkuCdKmyL7TxuZT8AWya4Mh8Dt7T1Bya7Df1
	Vi+creFBeYREBQs2XoJo0cyVTuhruwxhnuxwihT6sr/bH7KMFaB8LYxX3E5F8G8omSEehHJiuhe
	f+NRFb6w/1XsueGI385pjrCGebI0nYopHAxRY=
X-Google-Smtp-Source: AGHT+IF08fno/6+c+hT7zPA/nd21lbMJVoyQ+kHnEhcG+gDzSp6aFl2IoErRcP/YuiRklbfCtO/rkg==
X-Received: by 2002:a05:600c:1e86:b0:46e:4581:6634 with SMTP id 5b1f17b1804b1-46fa9b018e1mr92934245e9.29.1760126508907;
        Fri, 10 Oct 2025 13:01:48 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:94c4:fb0e:28f:2a8d? ([2001:818:ea56:d000:94c4:fb0e:28f:2a8d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5cf71dsm5393260f8f.29.2025.10.10.13.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 13:01:48 -0700 (PDT)
Message-ID: <efeeda046354cabd7da93d5afa64417260fa7c82.camel@gmail.com>
Subject: Re: [PATCH] iio: adc: ad7280a: fix ad7280_store_balance_timer()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>,  Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Nuno =?ISO-8859-1?Q?S=E1?=	
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Marcelo Schmitt	
 <marcelo.schmitt1@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Fri, 10 Oct 2025 20:02:44 +0100
In-Reply-To: <20251010-iio-adc-ad7280a-fix-ad7280_store_balance_timer-v1-1-e11746735192@baylibre.com>
References: 
	<20251010-iio-adc-ad7280a-fix-ad7280_store_balance_timer-v1-1-e11746735192@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-10-10 at 10:44 -0500, David Lechner wrote:
> Use correct argument to iio_str_to_fixpoint() to parse 3 decimal places.
>=20
> iio_str_to_fixpoint() has a bit of an unintuitive API where the
> fract_mult parameter is the multiplier of the first decimal place as if
> it was already an integer.=C2=A0 So to get 3 decimal places, fract_mult m=
ust
> be 100 rather than 1000.
>=20
> Fixes: 96ccdbc07a74 ("staging:iio:adc:ad7280a: Standardize extended ABI n=
aming")
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad7280a.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/adc/ad7280a.c b/drivers/iio/adc/ad7280a.c
> index
> dda2986ccda075fbfa04851a1ceac7a186b47537..50a6ff7c8b1c73905fabdef119d4120=
4c32b590c
> 100644
> --- a/drivers/iio/adc/ad7280a.c
> +++ b/drivers/iio/adc/ad7280a.c
> @@ -541,7 +541,7 @@ static ssize_t ad7280_store_balance_timer(struct iio_=
dev
> *indio_dev,
> =C2=A0	int val, val2;
> =C2=A0	int ret;
> =C2=A0
> -	ret =3D iio_str_to_fixpoint(buf, 1000, &val, &val2);
> +	ret =3D iio_str_to_fixpoint(buf, 100, &val, &val2);
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
>=20
> ---
> base-commit: a9682f53c2d1678b93a123cdaa260e955430bc5c
> change-id: 20251010-iio-adc-ad7280a-fix-ad7280_store_balance_timer-126bc5=
b4ee90
>=20
> Best regards,

