Return-Path: <linux-kernel+bounces-844895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DC1BC302B
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 01:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C37AF4F280D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 23:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A842765E6;
	Tue,  7 Oct 2025 23:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eud1QblD"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BD22765DC
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 23:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759881160; cv=none; b=FF1+pPHOkXGHVI0foFxjEGsUS1mmy6CIsELC6RwBJemLe4nj5uRNPGIAZ3Wk3gqGmwDoenVuPf5Is0rKf2R2GDt5EvtJX288rovuVv65zSBhT8pXJKW5vNeQxdCpgOpDlkAbne22pIxcVgNpimioXI0C1KXyE4INswkpcSdmGVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759881160; c=relaxed/simple;
	bh=ROKWiGHnPPZZuzWKSI1uklaF8ixeRvtjKDd9kS9OjSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NJFIDrKqkxL+CZnkA9uksfmVylpH5n7NRVkKm+BjNnrXlAwATd3fBe1wauTQDk9Y3kmtyE/fBEFFcXbdpCAB6d/f2gLdbfKB8N28cXjwIzTw7yYGgoQ4/J0fIEKOhZxkSHuiBJRvKCgr/j3KpuznruGzXUG9OWLjCmcy+K2BOxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eud1QblD; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-269af38418aso82333875ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 16:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759881158; x=1760485958; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EV0jNBd+78rpPCRxrDmQHJY6Y0YsbxaPHZL4vUaqMjk=;
        b=eud1QblD5KXefKNmiueAcNVunpDqgNzFpQ+yRtfHVAWUl8Z50NkmygNch1DJR77L/1
         4fdLi7xcpp/M5f+D5ikZahtS+B636lqgFno59jtYt1h8vSPiX5kw/3MUfXh9qeClp5LN
         vJMzdt2fkGGkI2edo1IALip+5j/Q4kbIq/vCl8f/C4BmtmkdM1EwR1Cc0WyCw8RsPUIe
         otGHx/WXUSKX3qQFIR/hWk47yosZBUkaOxvWa5msQoWv3MRV8YnSNNgnuRdGq2YtZxko
         LWWwBMVZO4zkRmEW4MBm1x8JLdcsK6UQ1FWK1puS87a/tGmBJ6UOJk+dYlg0NzwZKsav
         Yesg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759881158; x=1760485958;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EV0jNBd+78rpPCRxrDmQHJY6Y0YsbxaPHZL4vUaqMjk=;
        b=flFIVouEtKx43Zgy4rHCVXZR8ieUQKOmpSEoHKPYG2z7hrzI4w51i5w3PYpkl/CSj2
         R0Dmt3sZ77x79hYf5psdhoXDML4ZJOp7I/YHIw2WxkGB1WmE7xri792FpJzhobiwbLr4
         vpoTr5tnagq3Ie9kjzXZQPmcpyyCCnCeir1APo+pzvkl0XxEfiAyRKPrMicrOZEb10kK
         mrEuXnS/v0jSPHn0pnfgAxntvPvSJ7kP4Qb+rgW9Nr0/2pd7UR+5gbRX7USCXXgC1AXl
         9qq4IOHdz7zzzM7kazre5xiDCdXZGDIVjUMxAUuc0c6l2RLOUrDBbn0WjN/A/O27QGi1
         f40A==
X-Forwarded-Encrypted: i=1; AJvYcCU7R3667YzMzb8iv3C8qeqMVZN0WRT6E515sovsWySg2N/rmYUfQFTMsECGoERMbDaNn8OeiYaVZ2v3Q14=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxslLPJEmXacZ72+bBJ/P+u/16NGcX4CsMbXg0lDH6FL45K1I2
	sNMtDrAMrIIdYbc6Vwm15SbKyCQME8ic3Opp/1sZK4C4SgynlILygbYXc7bSrFPa4g==
X-Gm-Gg: ASbGncs0b4S5ZoNh72o8f7BsYRawa7cHIZX4vNVYWORUNmkJr0Z+oaHEAMjAbTDk1eq
	0duL3YXjOStPewa5vmbRoAc+9dDhKcalH7U8ce9oCveDbUAaXfA1qiDLSC9+4tYqnJ2L6eO2noB
	A9j0Yw/v70mzc5snwrfS8AR44lPmoBE3vrsOt5XDlCabZRFgw8jqpu/wfSonermTI04cP8qJ+ZH
	RMs9Hxg6n//lTWxg13f1JKXdeuTJ54WASScjcnTnAOre5T1gttPLXrcHZGW6513UKuiBvN92Rht
	d+899spIRkfwJHWM9QEGdQJP8kDJkgaWnCHhqtJDaMGYM6LHjNsBQF5N/8HGfa7+HXbWnJ3ZM4E
	JRlzOxns4reie57rnnsMTibbjbYH+SlDE9vWL4VSvDV3lgtuJ6sczGHyP0XdNHCzJBz0SH1Ci8r
	FuuLphblWSVwfKmzIW/eF1
X-Google-Smtp-Source: AGHT+IHGqfMRANz7qdKFPY1GP0G7VEmvv0tnHHdAojhTEJuBXFf5EupmTiYmDs83Yy0+ILJ3POIhcA==
X-Received: by 2002:a17:903:247:b0:24c:ea17:e322 with SMTP id d9443c01a7336-29027356511mr19002275ad.3.1759881157519;
        Tue, 07 Oct 2025 16:52:37 -0700 (PDT)
Received: from google.com (232.92.83.34.bc.googleusercontent.com. [34.83.92.232])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1d24aesm178372845ad.118.2025.10.07.16.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 16:52:36 -0700 (PDT)
Date: Tue, 7 Oct 2025 23:52:33 +0000
From: Benson Leung <bleung@google.com>
To: Jameson Thies <jthies@google.com>
Cc: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, dmitry.baryshkov@oss.qualcomm.com,
	bleung@chromium.org, gregkh@linuxfoundation.org,
	akuchynski@chromium.org, abhishekpandit@chromium.org,
	sebastian.reichel@collabora.com, linux-pm@vger.kernel.org
Subject: Re: [PATCH 4/6] usb: typec: ucsi: Report power supply change on sink
 path change
Message-ID: <aOWnwa1MJeir2yfZ@google.com>
References: <20251007000007.3724229-1-jthies@google.com>
 <20251007000007.3724229-5-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Sxbt9OfvGJLK6C2i"
Content-Disposition: inline
In-Reply-To: <20251007000007.3724229-5-jthies@google.com>


--Sxbt9OfvGJLK6C2i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 07, 2025 at 12:00:05AM +0000, Jameson Thies wrote:
> Update the UCSI interface driver to report a power supply change when
> the PPM sets the Sink Path Change bit.
>=20
> Signed-off-by: Jameson Thies <jthies@google.com>

Reviewed-by: Benson Leung <bleung@chromium.org>


> ---
>  drivers/usb/typec/ucsi/ucsi.c | 2 +-
>  drivers/usb/typec/ucsi/ucsi.h | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index 7b718049d0d1..1a7d850b11ea 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -1293,7 +1293,7 @@ static void ucsi_handle_connector_change(struct wor=
k_struct *work)
>  	if (change & UCSI_CONSTAT_CAM_CHANGE)
>  		ucsi_partner_task(con, ucsi_check_altmodes, 1, HZ);
> =20
> -	if (change & UCSI_CONSTAT_BC_CHANGE)
> +	if (change & UCSI_CONSTAT_BC_CHANGE || change & UCSI_CONSTAT_SINK_PATH_=
CHANGE)
>  		ucsi_port_psy_changed(con);
> =20
>  	if (con->ucsi->version >=3D UCSI_VERSION_2_1 &&
> diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
> index cce93af7461b..35993bc34d4d 100644
> --- a/drivers/usb/typec/ucsi/ucsi.h
> +++ b/drivers/usb/typec/ucsi/ucsi.h
> @@ -382,6 +382,7 @@ struct ucsi_cable_property {
>  #define UCSI_CONSTAT_BC_CHANGE			BIT(9)
>  #define UCSI_CONSTAT_PARTNER_CHANGE		BIT(11)
>  #define UCSI_CONSTAT_POWER_DIR_CHANGE		BIT(12)
> +#define UCSI_CONSTAT_SINK_PATH_CHANGE		BIT(13)
>  #define UCSI_CONSTAT_CONNECT_CHANGE		BIT(14)
>  #define UCSI_CONSTAT_ERROR			BIT(15)
> =20
> --=20
> 2.51.0.618.g983fd99d29-goog
>=20

--Sxbt9OfvGJLK6C2i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCaOWnwAAKCRBzbaomhzOw
wl1ZAQCuEVVyxljuR3qDCWaEQfsjePsmSuW7gR277le5YuGU/wD+LvAaG5c7C5EY
YQkMRPfdTja02BZOOVpX3H+kaBwH3wU=
=62iI
-----END PGP SIGNATURE-----

--Sxbt9OfvGJLK6C2i--

