Return-Path: <linux-kernel+bounces-808495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB377B50084
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 17:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C5485E4774
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04ED9350D5A;
	Tue,  9 Sep 2025 15:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="adX4XKgl"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E76343D9E
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 15:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757430090; cv=none; b=UxsAmtCq/7ZlutWFPgJh/EmrOVdeM7OqvmMqvquGiz7OPdRShHwU+Ggtt7sSAktT5HP7bpRFFz0reW93JBbLLHThjDs0UOGD36DhAp9a307T75Wy6dn+/NnqgAKKATTc0ze2q9sWk6/LeQFthz7/pittvSGkfW+egpyyp1xOvhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757430090; c=relaxed/simple;
	bh=PGs7vjYd8rYyzwAYvYDRUyeAJRynaK4QGuGr+OUHhzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bgUGXCD8DydiD1RpNA7gNoXMg1LR5Uuwh6K9PhfOEp8Z29IGXWh+qpxTW1dtdM8wUDiCuerE0aRCKy78gltUwZAaG/TdxMkiw4ZLZwg7tczU7AMCblq+Njg7p3A+wiAdBqFyBbtz725lbI6Tp3f3vE7CvFl4/wvYlgr8Wnc8VIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=adX4XKgl; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45de6490e74so21974815e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 08:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757430087; x=1758034887; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Oo2GzS1BKFjAKT93aaJtCs9JdrjrvpKho+/Kv3PPXfs=;
        b=adX4XKgl1TNA+xb5W2UPwoWqZwh0+TQ5cgIASwkirhf0qUzDneyTjAEu3eMr7jaXpp
         +cfskihKIMKaiGi177B8G7YIvrDUoN2gQ/HQbfpQK7z5poQdYGwkoyCppVx9sra2abGm
         VCCcabGGOzpB2QsV+naDMhXU1P6I5dvOhDV/Bhudmb1oyq6JoO8Cm51ITd3YEXBKS22G
         PPN4lKEU2Lhmj1On0SD2AsBdSVkomaojrLvgVvSx56OnbuS+gQgmgavPxhuEsBVA982X
         Sm0u97qOWoUi1hwWy28gAeWkZKKBBcotDlNIhYI6j7wmK0RFNlrzVuTQg7yKD3JjK1Mx
         WW4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757430087; x=1758034887;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oo2GzS1BKFjAKT93aaJtCs9JdrjrvpKho+/Kv3PPXfs=;
        b=a60vtoh2RBqa8H2QlNv7nNeIXxZ/Q7A9rsgkob6QRlTE38P9mKCKt7jgQZQX1G6hBT
         OZ36D0WvXQR+jNhM22ISS53/Bds+OvaSpTDnjhVJ0GWG/bz4GVICFUQH3Wj0/5vPhwb5
         7+VKW4NQ+VRVRjGoIPFnaxnQj7CIEWkyocHeMDzTGrnRZXum1XHEmWsGHvqXtnScJ5NM
         IDC3himRtSZtn0CeKkDnsqh73lJKoWOht6HXcpU3dHuMjZKLuUg1s1HnOKoTvwPm01bX
         p42Wxs0dmpPbLPwbtKJAABLFxHaM61q8wyYg8SlgKer5zYyOz5QGVrOM1HbdbKg7f4Wl
         ehiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNlhpR4/s2rw9iBdtC95VdWhNM0mf/+rUfyR41aYprnvJsyxotCNg753za9SI6Rao8hgCOU9xW+2z1nhE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwurotMgI094VWUEDVyXtSYnSahI2bS3xxgrKoFWgaMtroDw9h/
	xKIfYQh5GzOF5EEt+ccKfCFhx9FWGriDhwyZVTc7HPOP19734Zhoh/Ga
X-Gm-Gg: ASbGncs5moiSIEIyBAfJdhYS3Fz6VQa1+c+iqukTZ2R8Y2sIF7dKNGRaIi5Ze/jxKzC
	KEK8gZR9WPCYeOrLmxUyerNcZwAkxedjJVW0iMUuinkq9bJPF4Eh4aRMb7Nl9FJmj/zbKK30+jS
	P68IjRnj6R+pmLyx1mx8LkHPWAXv7+Ic6F7sBWr+uKahsnmXWq+bzlVOO6i+wBThhcbm6RCnW2n
	GeLAIZXTW8Ibq3E4T5+VHol4pMVOhtgB/liJ+jwSMVa3J3YWGCDD3Qe5HWwuWV0xZJg6fitlZTH
	X7AGHrTcrhbrdSDgJMPCwfJ0tyk0hX00FdRtAY9F7n7Xpeu3xIdyZ8Bkjsdv1xeDnO0TJbihWjZ
	aAgzbGm987EzXcdDUVyubgXKKHef+4XiO2WKiv19CdLEV5FwtFBJF0Y/98yl/rjE0sJYsylwktH
	4KKlv2SyvuenoyT4R1z/U=
X-Google-Smtp-Source: AGHT+IErW2TZyqEDQbDkvq+unnrPg8Fy3yPvW1vBfInEWh2VajAX7rKgQG01C3JB6r+lA0fLdV97AA==
X-Received: by 2002:a05:600c:474a:b0:45b:7d77:b592 with SMTP id 5b1f17b1804b1-45dddea4cccmr117427075e9.12.1757430082541;
        Tue, 09 Sep 2025 08:01:22 -0700 (PDT)
Received: from orome (p200300e41f1c4d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:4d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7521bfdc6sm2963648f8f.8.2025.09.09.08.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 08:01:20 -0700 (PDT)
Date: Tue, 9 Sep 2025 17:01:18 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Akhil R <akhilrajeev@nvidia.com>, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, digetx@gmail.com, jonathanh@nvidia.com, krzk+dt@kernel.org, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, 
	ldewangan@nvidia.com, robh@kernel.org
Subject: Re: [PATCH RESEND 0/2] i2c: tegra: Add Tegra256 I2C controller
 support
Message-ID: <22ucj42wvcqr5trsv75hbb6uj4y5zhjigs46w7mxtckisodcr5@77pgwttvycpl>
References: <20250818043345.65899-1-akhilrajeev@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hbpzp3jncbfi5eid"
Content-Disposition: inline
In-Reply-To: <20250818043345.65899-1-akhilrajeev@nvidia.com>


--hbpzp3jncbfi5eid
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RESEND 0/2] i2c: tegra: Add Tegra256 I2C controller
 support
MIME-Version: 1.0

On Mon, Aug 18, 2025 at 10:03:43AM +0530, Akhil R wrote:
> This series adds support for Tegra256 I2C controllers to the Tegra I2C dr=
iver.
>=20
> Tegra256 consists of 8 generic I2C controllers similar to previous Tegra =
generations,
> but with a different parent clock frequency requiring adjusted timing par=
ameters.
>=20
> The changes add the "nvidia,tegra256-i2c" compatible string to device tre=
e bindings
> and implement the corresponding hardware feature structure with appropria=
te timing
> parameters and clock divisors.
>=20
> Akhil R (2):
>   dt-bindings: i2c: nvidia,tegra20-i2c: Add Tegra256 I2C
>   i2c: tegra: Add Tegra256 support
>=20
>  .../bindings/i2c/nvidia,tegra20-i2c.yaml      |  6 +++++
>  drivers/i2c/busses/i2c-tegra.c                | 26 +++++++++++++++++++
>  2 files changed, 32 insertions(+)

Hi Andi, Wolfram,

Do you want me to pick up the DT bindings patch? There's currently no DT
files that require this, so taking both through the I2C tree is fine,
but either way works for me.

Thanks,
Thierry

--hbpzp3jncbfi5eid
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmjAQTsACgkQ3SOs138+
s6EeMBAAsb5QCvjIKGY18l8TqFMoUCTksq+dfSlHJJM+4LVgi4IoEq+FSwEopNk3
YDSVQuiqvURiv8PV2rptvO966RYxrywgDXUlmpWcQS+9C4EUAhEB9SKHKOWb2tJq
oL4LdO7NkaaC+AKWADz/WER1hrYFj71kKN9aQXfPmoBVtTCCfMijKpTSjCJ+aoVF
6vvLvYG/018WLCfU1iB6gUG9rKFFfMDvDEV+Q2WWxbAm0xFn80jJjnTxS36A6eOS
kzg/w4gcwvMHTIDqt33fjY4XE6dX/e+ttP8sTXFgK9ocNINKY03/MMJ+9n/c31jW
kaBLwqxiZ0HdEImf5451WyaOKzvjaaFedqvBM5XXIeFDQ+mHXJDdtvwhYDr2d4QU
py3nWWycW/pduNwqzlgkLJqxPTClmGjbG1xNfMVJk0NZVmobi4mIZyyph7PqkJwq
2wEE5Kvs2ny+k8ZGaim1ZHiqTvbdYgC1A4UaU87fqx/sYbMF5QQuw0EBsZ5nMZvp
GsIyitpvblYgXAMq3Ow3SN7IlgpOEMATRUDxkzO3iN/gpLihspvElAEUTYi012Ft
tlR6O7V5nV8GWuylcF8XuhQEQJNsIhoQVJk4zaMpTwllSXsA7N1w7hey39lQoALv
B+lCAFcr0SCT2o8UpXVWpOumY54UpQRiZFhk8F9DPHHTv1grZfA=
=Eq6T
-----END PGP SIGNATURE-----

--hbpzp3jncbfi5eid--

