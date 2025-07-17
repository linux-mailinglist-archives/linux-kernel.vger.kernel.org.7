Return-Path: <linux-kernel+bounces-736031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17877B096FB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 00:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 643D6176D7D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 22:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A9223ABBE;
	Thu, 17 Jul 2025 22:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="f/BNN3xx"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64701192598;
	Thu, 17 Jul 2025 22:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752792031; cv=pass; b=UvZZs/mCfOC4Rv2EAA2gTKXaVlpIndXltSGqFYcQbGOVfqfBFYdTo6aScEUMoC4WVsVCwnuTUlMtmio5LDetG3mqwKwCs01edC4xquDh+3Q57SxFPVNONd9hlaRO41gQEA7eOviASP3oInvf2dwRezPJNsb9HL/2zQ2uaHAYHsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752792031; c=relaxed/simple;
	bh=JHf35hQMYgOffISnzimgraOVDvhjMv3/Fe4Uaj/HVLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YhcD9/0hu0FfX1sL4vnEOycGJwvCgsaOzw7vFbRKxiX6s/IWTLMtI0P3c92OfY1th+EImcObL+QgF+fGFV2ZmOVOf240riSdCX0pCkRCuYGMcY8Ly4fq6dB5HLL3iWup64f/P3kupI3R3R9f4gVE+20e7UjzO8JRX4cRtzDtW5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=f/BNN3xx; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1752792015; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=UsEOGaGvB3EKPEyvF2u2D3k2dFZgUTAVHDsQyi5PP3N+M7P2sJ/oRmdu/bYVmMa2Hx6guSsUG7CoCi8nY5umUGp2n831fWF7XnG+NuYSvYy41iNzEpDoue9m31LGlA4yqHnQzflWq1y/f/BjWQ7X2YpiEsR8dYwwoima0zBooIM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752792015; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=vjNEruYR/iPSO8m1BGn8O04KKQr5T5JiBxQ8MbY0HIk=; 
	b=NeiF/3kBCra4qEEfTN6VM0Qe7osAevPcHA4LkM72P2uxqwP2kdbqVdfqqNc8MW6zqS+OhC312R/wUB8UOWCGugjY2n93iMAYafeIBZvYKgAoBSjfDBgvIXw/eKQtc+gXgk1TZDjs/kwDggYYJyi7N7aKXE5+/uh2vjxCaLAxyak=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752792015;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=vjNEruYR/iPSO8m1BGn8O04KKQr5T5JiBxQ8MbY0HIk=;
	b=f/BNN3xxhsi9L7H4pzFguRutxM4pmzoYYB3SGhdWzPtm7GXXcqBcLnhHf3E3BYCy
	GxYSDo4CQkLOd5vquettZzA1Q/0WL+9UVNfe2ElIle+RL0sWwca7Y5XCO3JTx1O06zr
	wPkzx/Vo81p4nDn6PCa/bb3qa+i+x1Y52tEiO8as=
Received: by mx.zohomail.com with SMTPS id 1752792013109881.8382268042914;
	Thu, 17 Jul 2025 15:40:13 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id CD0DF180753; Fri, 18 Jul 2025 00:40:08 +0200 (CEST)
Date: Fri, 18 Jul 2025 00:40:08 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Benson Leung <bleung@chromium.org>
Cc: heikki.krogerus@linux.intel.com, jthies@google.com, 
	gregkh@linuxfoundation.org, hansg@kernel.org, dmitry.baryshkov@oss.qualcomm.com, 
	madhu.m@intel.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bleung@google.com
Subject: Re: [PATCH] usb: typec: ucsi: psy: Set current max to 100mA for BC
 1.2 and Default
Message-ID: <j37jfvod6qe6k3rmzafjtoqvppx7tpwmtkrqzlrzpo23sowzux@2hialjmlcu32>
References: <20250717200805.3710473-1-bleung@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gjw5n2glwd5sp3ww"
Content-Disposition: inline
In-Reply-To: <20250717200805.3710473-1-bleung@chromium.org>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.2/252.767.34
X-ZohoMailClient: External


--gjw5n2glwd5sp3ww
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] usb: typec: ucsi: psy: Set current max to 100mA for BC
 1.2 and Default
MIME-Version: 1.0

Hi,

On Thu, Jul 17, 2025 at 08:08:05PM +0000, Benson Leung wrote:
> ucsi_psy_get_current_max would return 0mA as the maximum current if
> UCSI detected a BC or a Default USB Power sporce.

sporce?

> The comment in this function is true that we can't tell the difference
> between DCP/CDP or SDP chargers, but we can guarantee that at least 1-unit
> of USB 1.1/2.0 power is available, which is 100mA, which is a better
> fallback value than 0, which causes some userspaces, including the Chrome=
OS
> power manager, to regard this as a power source that is not providing
> any power.
>=20
> In reality, 100mA is guaranteed from all sources in these classes.
>=20
> Signed-off-by: Benson Leung <bleung@chromium.org>
> ---

Otherwise patch LGTM.

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  drivers/usb/typec/ucsi/psy.c  | 2 +-
>  drivers/usb/typec/ucsi/ucsi.h | 7 ++++---
>  2 files changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/usb/typec/ucsi/psy.c b/drivers/usb/typec/ucsi/psy.c
> index 62ac69730405..62a9d68bb66d 100644
> --- a/drivers/usb/typec/ucsi/psy.c
> +++ b/drivers/usb/typec/ucsi/psy.c
> @@ -164,7 +164,7 @@ static int ucsi_psy_get_current_max(struct ucsi_conne=
ctor *con,
>  	case UCSI_CONSTAT_PWR_OPMODE_DEFAULT:
>  	/* UCSI can't tell b/w DCP/CDP or USB2/3x1/3x2 SDP chargers */
>  	default:
> -		val->intval =3D 0;
> +		val->intval =3D UCSI_TYPEC_DEFAULT_CURRENT * 1000;
>  		break;
>  	}
>  	return 0;
> diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
> index b711e1ecc378..ebd7c27c2cc7 100644
> --- a/drivers/usb/typec/ucsi/ucsi.h
> +++ b/drivers/usb/typec/ucsi/ucsi.h
> @@ -483,9 +483,10 @@ struct ucsi {
>  #define UCSI_MAX_SVID		5
>  #define UCSI_MAX_ALTMODES	(UCSI_MAX_SVID * 6)
> =20
> -#define UCSI_TYPEC_VSAFE5V	5000
> -#define UCSI_TYPEC_1_5_CURRENT	1500
> -#define UCSI_TYPEC_3_0_CURRENT	3000
> +#define UCSI_TYPEC_VSAFE5V		5000
> +#define UCSI_TYPEC_DEFAULT_CURRENT	 100
> +#define UCSI_TYPEC_1_5_CURRENT		1500
> +#define UCSI_TYPEC_3_0_CURRENT		3000
> =20
>  struct ucsi_connector {
>  	int num;
> --=20
> 2.50.0.727.gbf7dc18ff4-goog
>=20

--gjw5n2glwd5sp3ww
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmh5e8QACgkQ2O7X88g7
+poX3w/8DO6s24a/uoJvcrKJmwDW1cN/qFPQQLP4HstLj+MvvVOHH/Uak3jBLJYk
YIZAncJn166StWxft6m9+MhzKhz+oYCVkqtmgFXb8yn1C50YF5II9yRkD6ZtYOOM
zP2dpOPVTYyHg4lW52N0Lna4myIbQurhPyv5nExEmBCrRa7U9wLJtcSEf61ZBntq
+Ia1ZioyhtLfHalIU8xVUa/gvyvs2pUXaCj3aXJMZ6NgoRLurq7Kk4f1E5N3v76/
MaBdLRCi5I8OEuMb5zSzi9mfuawy3eGUOe6juCKQq4WFsAXyGWCQnW2fnB094+Gp
PGRsuupHACNMfXSXQN0V9ZULdk4W6LyON1CEOTm1L41G+hG+ckb2K6Nf1GpAx/sB
OLQdDicT8bZ3qAqj0TsPhi8ip7PCtqPt1o7GZ2KHTayGP8dK+vCcPgRGr1/tC7Fl
b6hn5009Eqvbq8IqDSEp+OsoSYNf6NOE0z3Q5EklD70cSnZncilqeQDoeoHGy3+w
Vb4F8YqK3VLz5pXuj3+pqj0vMEU+6SzoW6HpuFjjyDX7/w0sZi+097mjiB5qCrWT
CABHwCeZZPV56PobkHRe1MfIZK8AldtcbmoQOA0KW4Hgws5Gt7TDuL6lHXR2B9Wa
oREM6rXudqb0TDTEI05b/ZcxWx4Q1+V6/Ck3jfCMDZgYOSkQ+WM=
=10Kp
-----END PGP SIGNATURE-----

--gjw5n2glwd5sp3ww--

