Return-Path: <linux-kernel+bounces-820103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 031B2B7F53B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E5315811B3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 07:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0501F2D480D;
	Wed, 17 Sep 2025 07:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ndf2w8Mr"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9D92C2361
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 07:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758092735; cv=none; b=PfPRrWa3mGYlcrQ0dCq+YNIm2OZ1tY4EpsfiiM3qNJo08WzUfVoYGEW5ApO9cLsvSGueNEVz6/5Jb27XyC7V48bEtpoJsOVE26fbEAaEy9xulcrYsoLqbcOwsv9WGAuqUfE/9d/lj5T/3FhCZ5lhCyNUYnSjot/HoFZFl08JGPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758092735; c=relaxed/simple;
	bh=qel+sB8eI+vw5fI+IXJcuamEgWVr7FnrIkhWQFmMCoo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BzUvcfVtLCg5NtrxzGUjA9cV9NMGyylknnuPY2vFdQIxTHSJ2s1rFXX90ayF0ELiYkVpcQoYYq3zZOJC4OgXiyuopw0Nj1Sd4YCpf/ibrJVq5qWixhOczappWoyrwuehecs+SB0XPbeZ++xE9D5jppsNMHngHHkKFg42BY35jEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ndf2w8Mr; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45f2acb5f42so4633505e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 00:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758092732; x=1758697532; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1lELm1XWpGTgxI5pP/LWBGwSZ4uAGIlOCNe7xRYuVz0=;
        b=Ndf2w8MrDvJ09zTwEX2ML8CNBujrVNHGYSU/PnDx6U8Aoru2ujsMEzmJtcDe8nVIz1
         tlfK/o0UtBRVX4r+3hFEsD8Oi08bCJLMy6labEwqR+xGxzVjs9oaM8IAJzbz3gtl0auF
         jGFa+u72GOadt93x7GkZFe/645O48ZApieVvkgreOOU6FVjJv2xPLEcqhyAUpHgyznPD
         cZl/zndOsKelCUQhuLBx6K8LMwZrHy3yw+CmnApk2D9s/gARlZAMOp5Hhek07E8CH/5d
         LxqlA3NwhoXbzSCC4Qm2m5OyL9nh6+tI4wHKhD7l4/ileTz+5h2ovp3JUEO8W99n8pc7
         0XOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758092732; x=1758697532;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1lELm1XWpGTgxI5pP/LWBGwSZ4uAGIlOCNe7xRYuVz0=;
        b=FkZLkwRkRvJZ5FZ3OD47oma5DrWX448xrBUxhl8AKp2I8C1mazqTEJltJMotenBHCU
         ycfmFoPB0nQ875z1b5YQwluD27mLClPYRVi6gR6AupZ1GmnengpXB0hsEZgsMizF5KeD
         MfSv4BhrZzLl6FYTigv5Mtsb3lXdESXT9URK35xSwYbZKC+KBU+eDEg306vlANH+fJlN
         R4pextGhp+SDxftSS6hvsdewTunOhgi6BWNylrNJmX4EY4znmzp++yiGxbAGqlNbXDHt
         pHSRVBtZqQJqDu4ap/h31h5IQJ2NoLehYod4A0neBAc8566+tl3aLHQWGWu7QSmrfN8E
         cjXA==
X-Forwarded-Encrypted: i=1; AJvYcCVet4Hb7rpthY6NgLAN833DOErd6fIumkGHXTaV47qTq3wSspNOOYXB+KblKBt1JlnnG39kaDHTQ2KDCUY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMPzMt3lh1Dv6QHaMS4G5FemaBvdeJK2iRUa2ffm3Ghqqv2iIs
	meoTLbPSVUxDkT00RAsGxeUuVRQcnMQ8Oo/V3Xk1wVDU4nbp1e+UJrG4
X-Gm-Gg: ASbGnctHqpkzy+bOT75DuDQmhLL8EIAVKmCYDGIOyC+BxyJnfd9H+QZ6gAlqV2Vis9+
	44UmCoff/W+6+4UXMrBtQx4hJovzXAmo/W6AzoDzbjSOz+83RyBv9V3IjRQPqb2RFAyjorzyW8H
	4LHiCVEraozU05Tg9n84iZ95hO4Nwzwk7LihmmXkhMjL5mIai91L7jQGNQWPl2c23nXw86hRF7a
	e/Vpnd2sOg4N21E5sCi11RoR45LqrphXiXjTIH5L96UbMuvu9rhM93KO0wbMm0nNTwm1xZO1gMu
	KfsI0MTiceOH9o5MSFjuGHMfFxInhbyIOQx9boHp2E5/aZ+ej6QOA+ucC0n5tmOpR7bw7wuTTup
	PFu58qKJHhmj3EBZ9rV0rHg==
X-Google-Smtp-Source: AGHT+IFlPuJM7gO5ArkZaq21I+GH1aAzibNklb9hk65tHGxbHIZmR7Qv5O6d6pSrCpHsc9ccC0z1IQ==
X-Received: by 2002:a05:600c:4f54:b0:45f:2d7b:7953 with SMTP id 5b1f17b1804b1-461fa02bc5emr9192095e9.18.1758092731465;
        Wed, 17 Sep 2025 00:05:31 -0700 (PDT)
Received: from [10.5.0.2] ([45.94.208.90])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4613dccb4fesm23735855e9.16.2025.09.17.00.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 00:05:31 -0700 (PDT)
Message-ID: <ce724693ffd6bc8f3f10cb8d753fd69191a19d8d.camel@gmail.com>
Subject: Re: [PATCH] drivers: iio: adc: ad7124: remove __ad7124_set_channel()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Michael Hennerich
	 <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, Nuno
 =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 17 Sep 2025 08:05:57 +0100
In-Reply-To: <20250916-iio-adc-ad7124-remove-__ad7124_set_channel-v1-1-aa7a2cbec8a0@baylibre.com>
References: 
	<20250916-iio-adc-ad7124-remove-__ad7124_set_channel-v1-1-aa7a2cbec8a0@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-09-16 at 16:39 -0500, David Lechner wrote:
> Remove __ad7124_set_channel() wrapper function. This just added an
> unnecessary layer of indirection with an extra call to container_of().
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> Just a small cleanup while I continue to work on this driver.
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad7124.c | 11 ++---------
> =C2=A01 file changed, 2 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
> index
> 910b40393f77de84afc77d406c17c6e5051a02cd..c24f3d5127cb83eeab0cf37882446fc=
99417
> 3274 100644
> --- a/drivers/iio/adc/ad7124.c
> +++ b/drivers/iio/adc/ad7124.c
> @@ -657,20 +657,13 @@ static int ad7124_prepare_read(struct ad7124_state =
*st,
> int address)
> =C2=A0	return ad7124_enable_channel(st, &st->channels[address]);
> =C2=A0}
> =C2=A0
> -static int __ad7124_set_channel(struct ad_sigma_delta *sd, unsigned int
> channel)
> -{
> -	struct ad7124_state *st =3D container_of(sd, struct ad7124_state, sd);
> -
> -	return ad7124_prepare_read(st, channel);
> -}
> -
> =C2=A0static int ad7124_set_channel(struct ad_sigma_delta *sd, unsigned i=
nt
> channel)
> =C2=A0{
> =C2=A0	struct ad7124_state *st =3D container_of(sd, struct ad7124_state, =
sd);
> =C2=A0	int ret;
> =C2=A0
> =C2=A0	mutex_lock(&st->cfgs_lock);
> -	ret =3D __ad7124_set_channel(sd, channel);
> +	ret =3D ad7124_prepare_read(st, channel);
> =C2=A0	mutex_unlock(&st->cfgs_lock);
> =C2=A0
> =C2=A0	return ret;
> @@ -965,7 +958,7 @@ static int ad7124_update_scan_mode(struct iio_dev
> *indio_dev,
> =C2=A0	for (i =3D 0; i < st->num_channels; i++) {
> =C2=A0		bit_set =3D test_bit(i, scan_mask);
> =C2=A0		if (bit_set)
> -			ret =3D __ad7124_set_channel(&st->sd, i);
> +			ret =3D ad7124_prepare_read(st, i);
> =C2=A0		else
> =C2=A0			ret =3D ad7124_spi_write_mask(st, AD7124_CHANNEL(i),
> AD7124_CHANNEL_ENABLE,
> =C2=A0						=C2=A0=C2=A0=C2=A0 0, 2);
>=20
> ---
> base-commit: df76e03e8127f756f314418d683bad24b460c61f
> change-id: 20250916-iio-adc-ad7124-remove-__ad7124_set_channel-d8e5c30ec7=
c6
>=20
> Best regards,

