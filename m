Return-Path: <linux-kernel+bounces-844890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F106ABC3001
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 01:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5E0514F3061
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 23:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26FE0263889;
	Tue,  7 Oct 2025 23:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SHoTmqPV"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBE4262FFF
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 23:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759881064; cv=none; b=udbtpPQbCGou869TmYN8WG6MGa4Y3d/pQzhDnRIT6jiOveNZaISvLVv5UY8Sv6eCwDqn6CGEWLdYap6i42JyO3RLCI4y6pV55s2lJ52Hx14twwgcJ9EhFqzSg2+dmFlrbbyxiUyiTtk1l7KD9YoPgxjVjKQYEA8eu8XwJ7wbW78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759881064; c=relaxed/simple;
	bh=5snFbqs9sNarJZC39yaVhbzXUsPxHolYK0vW3IIQUdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HKfu43RRtJrGlH1Q61i8375WZ92U8WPB09eJtRoxumQdRWoDyDl190+Nxffjnt9afLDodHxBBvIYBFPUOh25EtSfTT/d9st/yyCeLriq6tIUfghEhxG0V8KJ3h2zwHf8FXmgv7rAccnRhsn9kuyCU2M8L6aG5R9v6yxSqmMRQyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SHoTmqPV; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-33255011eafso7083215a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 16:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759881062; x=1760485862; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UwxCAWp60Swhqd/BFgzyBjFjBfIzgDWX3D186GvjvJo=;
        b=SHoTmqPVJwOY/MczFusJ9kxQjE9ylTx1BCOtRGLEAbtEuqoERIWPfGme8D1sc1DJb6
         M5dKIrDElg/yHZOcdV1ZRAI3xnGbrFTTFX41yny6r+MJEW6dr2dDmxkHfWtOGJChfU2A
         v8CHge/vE5S51WZ7oweXQ40w29Q3Ydho5PHXXNKICJ5JhSuoyM+7mFKD2KWc43vyrSWC
         5Vba8qGHD1DyoT1lIY7fb4vmyebUSj0wxhkyccDb1uNYPJ0f0P7wZyPp4W0L73J+WWDp
         pDCy+56XNtbeDWwXXGuX0o8WKTT21mQgkoLETWoiZWne4aTHqTE8RhE717aN0dsdGyhs
         AhOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759881062; x=1760485862;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UwxCAWp60Swhqd/BFgzyBjFjBfIzgDWX3D186GvjvJo=;
        b=gZDRdIqmqArm3ZAJZm4lhishKelniMwQTbZa5cvHUlzxaY4U4oS5rmN8kXFqakhMF7
         1v8MJgvGuq1bof8otNhARVCglpVsBPdRoXGctBS++t7+mHwmNPEgsWTw18Babx6Rz7Fi
         yrED6zC+Zd5SMVCzjIzSDWnQ53Jh9sEIvnTTexICfrYfR0Mf91vfKKO6ZeSckS1xtkrI
         76WBYFX2bP2qS52I+aXYy0u9PFBI8gpVo35OGUkB9WfgEstx5+L/cFr6KplwLfBuhhOD
         znCspFktfYVDWOfvxIaigLIqITd68MR5nyQK3Rfoi8kupMhD61Ax+KvBISscEPFTdoTz
         ojTw==
X-Forwarded-Encrypted: i=1; AJvYcCU+XawNeo7H4V1d1l699MVEQ9CnnUGV5Z5Vqlv80WQ6ThHD/Tlqj1LkBXOQC6GOiKBDmxAKWqupmzXRQKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfXDyeRNQ46wrKnLsRyEPTiXNCmZ+U54FSz9bwxVtPgzxmCq0p
	Y9Ujzf7x2zVsUdWq6k88gfKJWBjMI/9AqdDunjXAPEehgTvWbRWhZj7E5q5L/IA6Og==
X-Gm-Gg: ASbGncvc7W0cQA1oIKV2+4ZLd9OtjadcVJj+6JNfTC0/Zh2ppoANRuU89dcp64C10u7
	cqYDb3W6NPHtFLPnPfCLG/JjrYFleTJt5eCLf6wtoIUzpqTNwP4H2V/dwMqwHq9by9fWoU4ntAD
	dSM3df2jnodSPq+n6Ae8Pm83v8pQE5cCMrTDlepSMMDWLb5dkcti707PebZlJTClggn29kh/2s8
	uTTrwifqAZEXaZZza/aiBi2iMqyslxKPUMT6Qdx72sunJZ13aigcXL8Z2tf+eHkEBMmN00mZgpI
	8KJ7ZuaVCREB55z8flgI3/gLiYDrc88v1CPREsQEiYKVubXOO1HszKwyYR1XF7hJn7weovPuazw
	Tw/A8Lbfb1/Mz7i/UBZGfOhlWV8YZhsLen0ppESm6DK7f9X+qW1ATGcx/HUndoWfBgcGjIQ5ubE
	C2GuQSURGsW8twLkMkagWu
X-Google-Smtp-Source: AGHT+IFODTGIMvljHAxxdJZTomgkuu6gzIcghH6BwbpURjwECae/HdoaIV7/qT1ZAuBXv+MNdG2xrw==
X-Received: by 2002:a17:90b:4d10:b0:32e:ae12:9d32 with SMTP id 98e67ed59e1d1-33b51169e5emr1600933a91.11.1759881061472;
        Tue, 07 Oct 2025 16:51:01 -0700 (PDT)
Received: from google.com (232.92.83.34.bc.googleusercontent.com. [34.83.92.232])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b5288eae7sm152559a91.0.2025.10.07.16.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 16:51:00 -0700 (PDT)
Date: Tue, 7 Oct 2025 23:50:57 +0000
From: Benson Leung <bleung@google.com>
To: Jameson Thies <jthies@google.com>
Cc: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, dmitry.baryshkov@oss.qualcomm.com,
	bleung@chromium.org, gregkh@linuxfoundation.org,
	akuchynski@chromium.org, abhishekpandit@chromium.org,
	sebastian.reichel@collabora.com, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/6] usb: typec: ucsi: psy: Add support for DRP USB type
Message-ID: <aOWnYeke5BM-TlXX@google.com>
References: <20251007000007.3724229-1-jthies@google.com>
 <20251007000007.3724229-3-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3o10Fcvuh6mTIMAL"
Content-Disposition: inline
In-Reply-To: <20251007000007.3724229-3-jthies@google.com>


--3o10Fcvuh6mTIMAL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jameson,

Quick nit about looking through and finding the Dual-Role Power bit.

On Tue, Oct 07, 2025 at 12:00:03AM +0000, Jameson Thies wrote:
> The USB Type registered with the power supply class is based on the
> current power operation mode of the port. When the port is using USB
> PD and is connected to a DRP partner, report that the power supply's
> USB type is USB PD DRP.
>=20
> Signed-off-by: Jameson Thies <jthies@google.com>
> ---
>  drivers/usb/typec/ucsi/psy.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/usb/typec/ucsi/psy.c b/drivers/usb/typec/ucsi/psy.c
> index 2b0225821502..985a90d3f898 100644
> --- a/drivers/usb/typec/ucsi/psy.c
> +++ b/drivers/usb/typec/ucsi/psy.c
> @@ -209,8 +209,16 @@ static int ucsi_psy_get_usb_type(struct ucsi_connect=
or *con,
>  {
>  	val->intval =3D POWER_SUPPLY_USB_TYPE_C;
>  	if (UCSI_CONSTAT(con, CONNECTED) &&
> -	    UCSI_CONSTAT(con, PWR_OPMODE) =3D=3D UCSI_CONSTAT_PWR_OPMODE_PD)
> +	    UCSI_CONSTAT(con, PWR_OPMODE) =3D=3D UCSI_CONSTAT_PWR_OPMODE_PD) {
> +		for (int i =3D 0; i < con->num_pdos; i++) {

Do you really need to iterate through the whole list of pdos to find this?

The DRP bit is guaranteed to be always in the 5V PDO, which is guaranteed to
be the 0th one.

See USB PD R3.2 V1.1 Section 6.4.1.3.1 Sink Fixed Supply Power Data Object

"Since all USB Consumers support vSafe5V, the required vSafe5V Fixed Supply
Power Data Object is also used to convey additional information that is
returned in bits 29 through 20. All other Fixed Supply Power Data Objects
Shall set bits 29=E2=80=A620 to zero."

> +			if (pdo_type(con->src_pdos[i]) =3D=3D PDO_TYPE_FIXED &&
> +			    con->src_pdos[i] & PDO_FIXED_DUAL_ROLE) {
> +				val->intval =3D POWER_SUPPLY_USB_TYPE_PD_DRP;
> +				return 0;
> +			}
> +		}
>  		val->intval =3D POWER_SUPPLY_USB_TYPE_PD;
> +	}
> =20
>  	return 0;
>  }
> --=20
> 2.51.0.618.g983fd99d29-goog
>=20

--3o10Fcvuh6mTIMAL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCaOWnYAAKCRBzbaomhzOw
whS7AQDjspjExNjGT1BgFskiJsp3x4iaIMS84WEPwbCjCcXmJAEA24GamYl7sQ8B
nzBKxqmb3f1V1PuoMkNKd3p2QP1idA8=
=1ksC
-----END PGP SIGNATURE-----

--3o10Fcvuh6mTIMAL--

