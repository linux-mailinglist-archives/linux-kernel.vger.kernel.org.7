Return-Path: <linux-kernel+bounces-844897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F30BC3037
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 01:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01A4319E0043
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 23:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6BC21D58B;
	Tue,  7 Oct 2025 23:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tLKpnfz3"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB4F26F296
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 23:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759881319; cv=none; b=GCGQaiaaY2A+jmLMWlUrjDWqwr4LgNDQ0b8MxRT0BPRxRfxN94yzzuwpIka1toJYOhF6qhwTcxMBWA04ctn3K0Ze+EYP3TnUkQxsXy3DuAlHl4RMNhoU/4jHA+55gDPR4eEs/PUi/80UuGHedl0pey4aWzHOEHun4oqzpY2s2Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759881319; c=relaxed/simple;
	bh=aueIMlR5mVedWi0fjNVCibzll+DI67XEJP+YBMNLg9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sid5DFV2qmSar6oTmQdwbi4/V9oAU/ONkNV0oekkUhxf6JCvaCwvihKU7Oh9Nq5uNFtBp7aGLAGDGvU9UhmiQLIgPOgy6BrmU4ot81qgKr8oXqj7ouXw20cL1hmF1BiENWhj5OrdsrrY9HUbdJa18xlIeOPzWFc28bX5FWCpqDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tLKpnfz3; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-33274fcf5c1so7354761a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 16:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759881317; x=1760486117; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RoPS4zG7i/w1UUCX0a6YHqijn613l2SV4IiIRvG6TwA=;
        b=tLKpnfz36siqnmt5Uw2nZd3fFoWRm5pBZ5fOxthddgdaAssFNt4V4x608tGwWgXnO6
         CAZJ55OiYVeWeXWH7sl6z9wWVEos5P3elARtTbDdFcCRsqJBe1RWo7u88RirxlpXmQpv
         88vYKDQVIr0WWtJBo1aWffmhpduypSb1TOecRxSW5y4r1Sv33kasv93YzOklncw45cZ5
         1WD5ggtlkf34oQ2DbkTpUY4/3Zdm3LpGbrBiNk8ixRmTBieb8a7XMQjdCGcQ7t/nmImz
         VZHEey/mtPBOSmX7JbzIqFMcjURK7lP4Y7jnUns3kUFADsCOkJBkR3cmumHM9VDD1K+3
         +slg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759881317; x=1760486117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RoPS4zG7i/w1UUCX0a6YHqijn613l2SV4IiIRvG6TwA=;
        b=IlsmngA5++yEBGQ67f9PN6AmyeCL82PDNelp6vC3HP1jXcC/3KYDfRgoWKk+8aAuBA
         J7iAHan9kCbujhmA5MNUxiLSmooQoajQ+dQ2QLKP4VK3h246IrEL2u7jivpHq+p2vrXI
         r7rK6YVAbDj6ObysXie/h8jKkrcATd8MkK5PXsb0OMI8ow28qULIzymeNYB8Kj2svhYT
         8y3LSgSCmzCDGWQoFJbSAXCAgR+5Rod8nvHfJJ3Da9O8zztGMS859ps3zhUlxLMstY6F
         sOPh/3VD/7nWslnAyvRn+e70ows3BHlKpbSxGpau/Ubpkvt3DNm9f6ZgikBL29TMPM3D
         ve9w==
X-Forwarded-Encrypted: i=1; AJvYcCUw5vaBc6yVmn2HDMGAFI6gcsD/ZHg+XVidN3y/lu+MxNjposop5wrai304GoA1nA+g7ILrRFCZQdkISko=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpRsI8vcc9krvAbU0xX3t9PkWEBpgmNQkSmBlKfSoTSHaPCXol
	snMA0OiPwm9nK1ydYdKwYC2j4PG90E5J12TTW21hC1ic/wNyJ+gLeWD40zqkS3V1fg==
X-Gm-Gg: ASbGnctgehGhbXGbv2b42gwOKBPI2UO+qyugB/MMqo5ziWYib73fxqslwYstlCELEZ6
	W5ZM7aYLt7uV8k0CYrAOn5L8XAzxMlFTkVpz6Hc+9/M6BprHv2dxm4C9IWGVsTkAw/e3kSr3BrN
	k+AfsFX9Nekfzg2E8uapeksW8tP0lhRiy3LQXdkZswElYs76IlPWTE1i57K9HAK+Zz2xkygQTyV
	h+mUpOZH3pBZ/TU/4TitM9t7ga9Y6Vf3eQYK36p3UdnSoMEWrcesiAubHkzwqfgB+3jWQbitceV
	CGYpIXbvuAJ0dDZHiUyBp5dmYSw2Na/pYA89SHQsTf3qa8HXrQm8Bx5i3AFJyBe9MjxU6WOJDa1
	7FsYd5srsFPA4el2HXQ9y385n/jz1nvZBHko6GNEqHQzP2CcgOG3D9EBsfzWsOWWXdHQNYl6kN/
	cMiKp8m2b1aqoQtRbHIlp6
X-Google-Smtp-Source: AGHT+IFyYA4phHap66RvdBt2TrgOq56Z64xSXysMkk6/t4JddY43lUaDViy2aDcxIzhYwOjo1UQo3g==
X-Received: by 2002:a17:90b:3882:b0:32e:7270:94a1 with SMTP id 98e67ed59e1d1-33b51375992mr1682915a91.17.1759881316103;
        Tue, 07 Oct 2025 16:55:16 -0700 (PDT)
Received: from google.com (232.92.83.34.bc.googleusercontent.com. [34.83.92.232])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6099d4d324sm16922776a12.27.2025.10.07.16.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 16:55:14 -0700 (PDT)
Date: Tue, 7 Oct 2025 23:55:11 +0000
From: Benson Leung <bleung@google.com>
To: Jameson Thies <jthies@google.com>
Cc: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, dmitry.baryshkov@oss.qualcomm.com,
	bleung@chromium.org, gregkh@linuxfoundation.org,
	akuchynski@chromium.org, abhishekpandit@chromium.org,
	sebastian.reichel@collabora.com, linux-pm@vger.kernel.org
Subject: Re: [PATCH 5/6] usb: typec: ucsi: psy: Set max current to zero when
 disconnected
Message-ID: <aOWoX4cqg3fN-pN1@google.com>
References: <20251007000007.3724229-1-jthies@google.com>
 <20251007000007.3724229-6-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fUC004gocSAkhC+0"
Content-Disposition: inline
In-Reply-To: <20251007000007.3724229-6-jthies@google.com>


--fUC004gocSAkhC+0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 07, 2025 at 12:00:06AM +0000, Jameson Thies wrote:
> The ucsi_psy_get_current_max function defaults to 0.1A when it is not
> clear how much current the partner device can support. But this does
> not check the port is connected, and will report 0.1A max current when
> nothing is connected. Update ucsi_psy_get_current_max to report 0A when
> there is no connection.
>=20
> Signed-off-by: Jameson Thies <jthies@google.com>

Reviewed-by: Benson Leung <bleung@chromium.org>


> ---
>  drivers/usb/typec/ucsi/psy.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/usb/typec/ucsi/psy.c b/drivers/usb/typec/ucsi/psy.c
> index 985a90d3f898..3a209de55c14 100644
> --- a/drivers/usb/typec/ucsi/psy.c
> +++ b/drivers/usb/typec/ucsi/psy.c
> @@ -169,6 +169,11 @@ static int ucsi_psy_get_current_max(struct ucsi_conn=
ector *con,
>  {
>  	u32 pdo;
> =20
> +	if (!UCSI_CONSTAT(con, CONNECTED)) {
> +		val->intval =3D 0;
> +		return 0;
> +	}
> +
>  	switch (UCSI_CONSTAT(con, PWR_OPMODE)) {
>  	case UCSI_CONSTAT_PWR_OPMODE_PD:
>  		if (con->num_pdos > 0) {
> --=20
> 2.51.0.618.g983fd99d29-goog
>=20

--fUC004gocSAkhC+0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCaOWoXwAKCRBzbaomhzOw
wm9jAQDyn4DTkW9BlmrjPEHHrT83cCw7VhufXQoU38YBUFUiXwEAvyLumfxm0ovV
6bf7rx+85yCgcDBJOgUpY3k5KoXtGAY=
=UKip
-----END PGP SIGNATURE-----

--fUC004gocSAkhC+0--

