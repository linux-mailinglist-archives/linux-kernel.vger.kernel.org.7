Return-Path: <linux-kernel+bounces-857077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C255BE5DB5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 02:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55493402A23
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 00:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E95752F99;
	Fri, 17 Oct 2025 00:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IjgxsJ2m"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97F314A91
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 00:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760659753; cv=none; b=UVjCzN+Lf6yb0MZREGxZ4gdZLnv99gFrciDBe0VgDCZ7v4GhQLk+t5dXSuC98TNLLFLqZLjEn7RYmiyZQ2N9d4my27VT3iHiykPSWRryFHOFD10gumQN/21gfNvh8hJTY8Zf22h1g/lAJqdR2haRRucEFhBL0VfyH7M+v7e8KIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760659753; c=relaxed/simple;
	bh=VSl0JaiEc0HWJb/hlVJi0cWip5mVlh9mlKtsFZaIYWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BYuNnB4Hz/0E5QHLIHMPOXgsf6tpKsS6hS1vqLO1YEUp9hyJzG7XeMhCgK2GsvD9yaB8pS9z93ohpJjMpESNm/7aUowPDUHg5RYfQX+4JJrjjtwZQ2BzjrMsOxD6bkgzubAOTK+IvhUV4iREz+hsNkvKT1lFF27axv/2oBv+160=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IjgxsJ2m; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b550a522a49so1054246a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 17:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760659751; x=1761264551; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NXnDH8yeXEI7/Kj3lSKr3kIGNlgj2iQ7E3EGf2Rbg74=;
        b=IjgxsJ2mxMKbDwD1GQvxFMAt1aW/jL+ZVYM7ju2WervEYDaeRV5RVlTab5LPIZZ8Tf
         zdf5rhZU/CpAlAsngVAMq4L2OaWWYhBDpi6BVnwpUTLMeRkKugcbEt5RhchwPTadWkXV
         GgPoSSz8g0+bqq8I/y8Fq2fuyChm8tGC+QXyXIR+Qd7LUXBt9RSE2otk0V6UWEY5BYwd
         fvUqwmXoDC3arWDBwIYHmJnn+gxdjNHSSY5sH67/O674yL0zz4uQRRSu1LvS7L87GnZl
         luLYFZLQjBPXbIZn3XwD6oH6/IZBnwiFPWnZToKDch7+HG/ktm+wucOXkiplJSMh/4m/
         wqfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760659751; x=1761264551;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NXnDH8yeXEI7/Kj3lSKr3kIGNlgj2iQ7E3EGf2Rbg74=;
        b=EE3tJL2cVpMbUfXEjaDzTDoUvxbXSaCZr6l7RtXz3tH/h86pJvwWzQhgGmRH7zG18s
         h7dzi8QFiVVifA8tvnhNJ7prekTN3JutQeBtKPItawY0E0Qwip4Zf7Q/iYIKuJwtEXrn
         sg5sDoxzvDE0OwR9PagSLuZgB13fzOdD0eZrGLT0RG17pQ7M8b2iInEUIbGmSWdTDlp9
         xV4TfpgFxzDmfZUXs9UrSEj/RmNV4bVBZYAUJAnqxoJw9JwITt9z6Puvor6/K46i0FvX
         pEHsHrgOJ1lfQs2PmOJAt6vJA+AjFbhLDFFW0ErrYzcdmvfNF4bTDWSsRFVHGOerpTyD
         +muA==
X-Forwarded-Encrypted: i=1; AJvYcCWdu5DY/Pfwc5QBdeDEr/Xi7UlBV268EA2qlLB/ZCQpw+oxlYFHk8U/WNX0yX8fHr7CZ7CwihX4pGFULXU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWrl0nnsxpOWLl5WFLCgUyDzeLymn3XpdvjgrOIBDk0ZaaqPt5
	PxQXLREiJ7oZjnOFeOaGpFUzbSP2qoyyJI8C13Pii6IwrLls4GsDnEHIgOebOL8jaQ==
X-Gm-Gg: ASbGncvroeYHWD7njx1TNHYkohaUBP6FuNlb1yKksYksWZx9Yh1oirjxOliDE59O5Zw
	j2C8uteyBbp+G/jVQIoYOGvQjIXsXkCVT4hyiG4cqQfNbyP/LHIsiHFlGDh+AcN7o5lspdiovgP
	+OEi6Wa479CuLN73CyfNu9XSUlmHy47K65kG4niMNq5eRe9c5JMbwyb9x5Ys68yLe/gA7rNuYqL
	X8Hp+gYv7dWTryi663x1LUvo+te6jKTYSYZDT2fU6p89DIhjlCtjQeYPCaVemVGaPYCU3xbzxU1
	T/llv8IwAQL8RNPYBfamz8H7F2JOYwj7akpdn5oAVKiO28C6tbi09VlTthXDiTndqYnbdpoWq7w
	YbO7OZ/SCvY9ZJues1d5syk0rgVonxcNtIykESMLyc8DuePeMqJM0DMTAQYSoQVvMMx08JJOiKR
	i8/3SAanylF4iwY5p/WOb3iyfhOdWf6EDMgL4OLPG1ZAM=
X-Google-Smtp-Source: AGHT+IGG75zRnExiCUHFLBI4WVBweds66/l9+7yNf2K5kk/4fpgNKkbEvIry2xyN+92Prx/hDFAm7Q==
X-Received: by 2002:a05:6a20:1588:b0:334:a710:14a with SMTP id adf61e73a8af0-334a8630420mr2228597637.42.1760659750743;
        Thu, 16 Oct 2025 17:09:10 -0700 (PDT)
Received: from google.com (232.92.83.34.bc.googleusercontent.com. [34.83.92.232])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d096527sm23605651b3a.44.2025.10.16.17.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 17:09:09 -0700 (PDT)
Date: Fri, 17 Oct 2025 00:09:06 +0000
From: Benson Leung <bleung@google.com>
To: Jameson Thies <jthies@google.com>
Cc: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, dmitry.baryshkov@oss.qualcomm.com,
	bleung@chromium.org, gregkh@linuxfoundation.org,
	akuchynski@chromium.org, abhishekpandit@chromium.org,
	sebastian.reichel@collabora.com, kenny@panix.com,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/3] usb: typec: ucsi: psy: Add power supply status
Message-ID: <aPGJImOPx4yCWQnv@google.com>
References: <20251016235909.2092917-1-jthies@google.com>
 <20251016235909.2092917-2-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3t8E6xx6LIwij4Qm"
Content-Disposition: inline
In-Reply-To: <20251016235909.2092917-2-jthies@google.com>


--3t8E6xx6LIwij4Qm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 11:59:07PM +0000, Jameson Thies wrote:
> Add support for power supply status. If a port is acting as a sink
> with the sink path enabled, report it is charging. If a port is
> source, report it is discharging. If there is no connection or the
> port hasn't enabled the sink path, report not charging.
>=20
> Signed-off-by: Jameson Thies <jthies@google.com>
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Reviewed-by: Benson Leung <bleung@chromium.org>


> ---
>  drivers/usb/typec/ucsi/psy.c  | 26 ++++++++++++++++++++++++++
>  drivers/usb/typec/ucsi/ucsi.h |  3 +++
>  2 files changed, 29 insertions(+)
>=20
> diff --git a/drivers/usb/typec/ucsi/psy.c b/drivers/usb/typec/ucsi/psy.c
> index 62a9d68bb66d..2b0225821502 100644
> --- a/drivers/usb/typec/ucsi/psy.c
> +++ b/drivers/usb/typec/ucsi/psy.c
> @@ -29,6 +29,7 @@ static enum power_supply_property ucsi_psy_props[] =3D {
>  	POWER_SUPPLY_PROP_CURRENT_MAX,
>  	POWER_SUPPLY_PROP_CURRENT_NOW,
>  	POWER_SUPPLY_PROP_SCOPE,
> +	POWER_SUPPLY_PROP_STATUS,
>  };
> =20
>  static int ucsi_psy_get_scope(struct ucsi_connector *con,
> @@ -51,6 +52,29 @@ static int ucsi_psy_get_scope(struct ucsi_connector *c=
on,
>  	return 0;
>  }
> =20
> +static int ucsi_psy_get_status(struct ucsi_connector *con,
> +			       union power_supply_propval *val)
> +{
> +	bool is_sink =3D UCSI_CONSTAT(con, PWR_DIR) =3D=3D TYPEC_SINK;
> +	bool sink_path_enabled =3D true;
> +
> +	val->intval =3D POWER_SUPPLY_STATUS_NOT_CHARGING;
> +
> +	if (con->ucsi->version >=3D UCSI_VERSION_2_0)
> +		sink_path_enabled =3D
> +			UCSI_CONSTAT(con, SINK_PATH_STATUS_V2_0) =3D=3D
> +			UCSI_CONSTAT_SINK_PATH_ENABLED;
> +
> +	if (UCSI_CONSTAT(con, CONNECTED)) {
> +		if (is_sink && sink_path_enabled)
> +			val->intval =3D POWER_SUPPLY_STATUS_CHARGING;
> +		else if (!is_sink)
> +			val->intval =3D POWER_SUPPLY_STATUS_DISCHARGING;
> +	}
> +
> +	return 0;
> +}
> +
>  static int ucsi_psy_get_online(struct ucsi_connector *con,
>  			       union power_supply_propval *val)
>  {
> @@ -245,6 +269,8 @@ static int ucsi_psy_get_prop(struct power_supply *psy,
>  		return ucsi_psy_get_current_now(con, val);
>  	case POWER_SUPPLY_PROP_SCOPE:
>  		return ucsi_psy_get_scope(con, val);
> +	case POWER_SUPPLY_PROP_STATUS:
> +		return ucsi_psy_get_status(con, val);
>  	default:
>  		return -EINVAL;
>  	}
> diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
> index e301d9012936..cce93af7461b 100644
> --- a/drivers/usb/typec/ucsi/ucsi.h
> +++ b/drivers/usb/typec/ucsi/ucsi.h
> @@ -360,6 +360,9 @@ struct ucsi_cable_property {
>  #define   UCSI_CONSTAT_BC_SLOW_CHARGING		2
>  #define   UCSI_CONSTAT_BC_TRICKLE_CHARGING	3
>  #define UCSI_CONSTAT_PD_VERSION_V1_2		UCSI_DECLARE_BITFIELD_V1_2(70, 16)
> +#define UCSI_CONSTAT_SINK_PATH_STATUS_V2_0	UCSI_DECLARE_BITFIELD_V2_0(87=
, 1)
> +#define   UCSI_CONSTAT_SINK_PATH_DISABLED   0
> +#define   UCSI_CONSTAT_SINK_PATH_ENABLED    1
>  #define UCSI_CONSTAT_PWR_READING_READY_V2_1	UCSI_DECLARE_BITFIELD_V2_1(8=
9, 1)
>  #define UCSI_CONSTAT_CURRENT_SCALE_V2_1		UCSI_DECLARE_BITFIELD_V2_1(90, =
3)
>  #define UCSI_CONSTAT_PEAK_CURRENT_V2_1		UCSI_DECLARE_BITFIELD_V2_1(93, 1=
6)
> --=20
> 2.51.0.858.gf9c4a03a3a-goog
>=20

--3t8E6xx6LIwij4Qm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCaPGJIQAKCRBzbaomhzOw
wvV/AP9vZAs9Ieb0KT0LGXMlgmdu4qmENimGJXONN5zpi2P4JAD+IjsmMhhPrOXT
g7OzMTo8KghmmICaK71xlcZP+4zBUA0=
=M9iU
-----END PGP SIGNATURE-----

--3t8E6xx6LIwij4Qm--

