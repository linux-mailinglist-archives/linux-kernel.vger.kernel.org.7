Return-Path: <linux-kernel+bounces-848725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B5CBCE6F9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 21:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7774D4E24CF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 19:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33073019BA;
	Fri, 10 Oct 2025 19:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WoOTehJ8"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747D3301718
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 19:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760126149; cv=none; b=QEqrdhJVCbcHvJA0DyQ6wVGk8IiqWCYxcFkHBOgwWIhUnRoehVvsbYB+THwM6EHiHV+Jk14Z3c7iivY5Dz8Jj2ZbcOS41bt5mL1qw2wsKqU+IzF40OUS/raS9z7LtJpiqYYaYtxoxkX6Z/+fIN2WO7BV6Uqg/vgDUp++7Hy7MZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760126149; c=relaxed/simple;
	bh=9PS7F/m4n1uAkBYWPryVi2hX01WNFFT8P5czGODVaI0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A8hkTRF623Szyax12iRGJrXpfC24QmvzBIYJ5/6dkj/0XM4Z7BZguxZ9TpQN6UXdZFPD7d7Rft0EZYpm080L5bsiwOxQzk6YjRV6ziJzne+Z4qawdS1ogLjNCZaxTrL4SuozuepP8PjWEOkGmcf+nvDI4tp3E6DjtZmUpYzOhf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WoOTehJ8; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-46e6ba26c50so15235415e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 12:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760126146; x=1760730946; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WlPTxxGqUeSR2lZkjJtan7WE7z8YmM6/O314vANG+hE=;
        b=WoOTehJ8ZIkVn5KybLL1WjDwxXHekgqlHfszjSWVfabSv6MMLS1rkll9MqiUPO62bF
         YG+3c036NgWKmyj2Dh/1XJ+bMuTXoPEKAil+YyNqz9+xH6CLrKa+iSgYVtTKkuCdVRSG
         99iEMe61IxbDPdpm/6FoQpcMygsb6AF/PicxL501BSRH0oNAgmcfhHF9cq3whuG9s4WW
         KOUozpokXZlfF4QsWKgehZ/7JW/TnhKvL3uFcCYDsiOXC2wZD4z1HODQbSwHiuA4SqG7
         wzs+KDzRFKQA8dIwE6gy3JGtuHsDibXGtghO9Iaex8q+V5LKIoslO95B0vtKvMrtMYHa
         68uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760126146; x=1760730946;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WlPTxxGqUeSR2lZkjJtan7WE7z8YmM6/O314vANG+hE=;
        b=vY3dOdRxJB1MspSoLeI2UY7GD6cJGXOgedxC0+Z77jyV4vDgwVPhW/x8teVquWpR6T
         IkDdd4qgNeG709pcUhFfOjAwddNIvhj7tuvRKKuWTCECLIB4i6k9E27Pxf9LmbVVmt12
         YI4/HFLHfq2o9cKkLVlyCKXTgkuBFSCqV/JPiaoWT6jH08ZcKY8p/Iq1CHWbDi7s64K2
         rO4kPNKsmAENFto/dOhfJppACXfBkU4wMi/pOqj7SbQlnQP0PK0hRSq5E88Pe9QGljaX
         PXjhOOKct9id7HskM/gci+hayTzeY4xAPsSL4z6dzVJwbRwWKs+ZfmY+JPjLnKNzL+DW
         QdQA==
X-Gm-Message-State: AOJu0YzcdZUs45gZbCrxBXPIlk4faIMY7qG8+ErwZl0G4JDwSsHcybQ2
	O8eNvDOCIrVOXb50nNqQimr+uaUwIKDSBKayCBRnCz92r8DGSuuZYoI/
X-Gm-Gg: ASbGncuCxsSiW9tkaB/OjqmbxCEPRAz5xfktMnNT0n4J+AicTUisppPxyGZ58p4MpCL
	+rBxuWOo9zrSQMowRViIp9mvlm5/JQ86NvYUp06+ay45Nx2RxJpohpLFgNkxdn3CgFsm2+WnkE6
	DOr3rDv8iPVAz4VYXLoMSEcPOAWXs2iOxTK6gXHg092d4qxzzFBlcyFlHZ5xApT4CSpHgbvqeM7
	991b/BQVXdKMr4JjKhJiKibOOhCViat9KzhmvN5KWuIHAsPHNOvJ2jC3scN0LsSV/d+frWbARdu
	0DCf538ORb07qB1eZ9V9dOldd0Hc9lUh8PVU0Ww7nJS4GEes0AaLBJw1/bUQ4C7Hs6ZhI5FX1TX
	rhiOcrgDyxqibmTT2g7RZEal3o4qLH/qsQWBmBQSSVq+F4qo4Xrk8rk7+bXu9MHdutipHo05hc3
	TsG/40NWBH+uYHNuu+MDzKVx2V
X-Google-Smtp-Source: AGHT+IHaWYI9QvKReNHkAaSbov4hjc2gUESetJC4TFK/yM1c7gn97K56ZqGizY/MOi2ZOYx+SBgt6w==
X-Received: by 2002:a05:600c:529a:b0:46e:3e25:1626 with SMTP id 5b1f17b1804b1-46fa9aefe15mr92408175e9.19.1760126145632;
        Fri, 10 Oct 2025 12:55:45 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:94c4:fb0e:28f:2a8d? ([2001:818:ea56:d000:94c4:fb0e:28f:2a8d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb489af92sm70551775e9.17.2025.10.10.12.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 12:55:45 -0700 (PDT)
Message-ID: <3e91c2a282499f862ed7d27842d5bc2ee461ebf8.camel@gmail.com>
Subject: Re: [PATCH] iio:common:ssp_sensors: Fix an error handling path
 ssp_probe()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Jonathan Cameron
	 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Kyungmin Park
	 <kyungmin.park@samsung.com>, Karol Wrona <k.wrona@samsung.com>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	linux-iio@vger.kernel.org
Date: Fri, 10 Oct 2025 19:56:41 +0100
In-Reply-To: <6fdd39e3763a6e0e700982ac6ed63a5748a4ce67.1760122717.git.christophe.jaillet@wanadoo.fr>
References: 
	<6fdd39e3763a6e0e700982ac6ed63a5748a4ce67.1760122717.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-10-10 at 20:58 +0200, Christophe JAILLET wrote:
> If an error occurs after a successful mfd_add_devices() call, it should b=
e
> undone by a corresponding mfd_remove_devices() call, as already done in t=
he
> remove function.
>=20
> Fixes: 50dd64d57eee ("iio: common: ssp_sensors: Add sensorhub driver")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/common/ssp_sensors/ssp_dev.c | 4 +++-
> =C2=A01 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/common/ssp_sensors/ssp_dev.c
> b/drivers/iio/common/ssp_sensors/ssp_dev.c
> index 1e167dc673ca..da09c9f3ceb6 100644
> --- a/drivers/iio/common/ssp_sensors/ssp_dev.c
> +++ b/drivers/iio/common/ssp_sensors/ssp_dev.c
> @@ -503,7 +503,7 @@ static int ssp_probe(struct spi_device *spi)
> =C2=A0	ret =3D spi_setup(spi);
> =C2=A0	if (ret < 0) {
> =C2=A0		dev_err(&spi->dev, "Failed to setup spi\n");
> -		return ret;
> +		goto err_setup_spi;
> =C2=A0	}
> =C2=A0
> =C2=A0	data->fw_dl_state =3D SSP_FW_DL_STATE_NONE;
> @@ -568,6 +568,8 @@ static int ssp_probe(struct spi_device *spi)
> =C2=A0err_setup_irq:
> =C2=A0	mutex_destroy(&data->pending_lock);
> =C2=A0	mutex_destroy(&data->comm_lock);
> +err_setup_spi:
> +	mfd_remove_devices(&spi->dev);
> =C2=A0
> =C2=A0	dev_err(&spi->dev, "Probe failed!\n");
> =C2=A0

