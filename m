Return-Path: <linux-kernel+bounces-844639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0EEBC264F
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 20:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DE2914E9ED8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 18:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584E02E9737;
	Tue,  7 Oct 2025 18:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N28iI1Ic"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF26205E25
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 18:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759862156; cv=none; b=RCBYpW8gxriL8I+Ben+sk1LlKeApoSJELAg+y4PCNvtBQfLOKN4Etlix0gcJWEP15REwHOPyz1YElLS4YXI2JtaKT0wgBRLwS6BOY68fzP/hIoZEfO9KRRIPsmVu2xTgvprfSTSoFUBrzIPgX9lhHjTINFsB0WKGiT/g17zJo2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759862156; c=relaxed/simple;
	bh=4JT/QULipmJSuak3v2YGIjJbR5SBESiMORm3G/f9XSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SLk91Qb/GUbzRqi+mYMEuaby1igjFcHUpLhwwQ+QFDT1TBjOzMZZdw8XyT2+u/9+uSyGLz9LTZecEX5OM4rLMjf0f/7gc6qCOOLWTKSIPf10CcxFjJ2MYYxoAVmNiQj5qc44+u6Eqal5wk2/mfmg+PPT9ohASzitYv10hQxdQkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N28iI1Ic; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-781010ff051so4654704b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 11:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759862154; x=1760466954; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7C2SoEPm9B9jK8sU90jS5ZDxJhsIg3KL3H032u/5uNQ=;
        b=N28iI1Icc0vGWhy2XFqE8Si1o1BGgr82MtzOG025D58eQvVpkqNSStmBcXqxUmj5Hq
         eb+ldNvm7GW2E1zx2uCBS/etCs+h41FWfAscT+tIwpYeIb5xA7VayG7DEDeI9wVtTIJE
         K0RGOIbqcXBv4FzyE9jgkpEz+pMMXBnyr0JLKBfddHqzTy7e3Q8v1GPaoAYfELK2djkc
         NtWmeJme2iVJg5yU1reu/XzMveEhYOGYKEfO7DLKHXORHuJOHypqgvsMvyTOPGLiNsgn
         riNVCGZhe0ggzZgbXYf6WKUHlEFSL2AWZ2THhxVlP8MZE5Xtji/ejX93V5LvdpRqiriM
         tM7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759862154; x=1760466954;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7C2SoEPm9B9jK8sU90jS5ZDxJhsIg3KL3H032u/5uNQ=;
        b=mdBOPZ79NQSSTMTHoltsGOatJAt5LtGtTPbTdQe0D7EbKJopjnMljCwdMKxkgsbaxg
         UZ0u5ww8tOciRx0NzDOERSkmd5xuwX0SQ1bmoU5Q1TdfI4W+ybPum/lEO07PbQdGArWx
         PPsMMJZe1Nrs4sYwWhXqluxplQz8ZsJd2C/aCO6VD/xwOrRdyOjom4aqo85ABPnwOzhL
         Z9RAqRafkfecdbtaPJ8d5OFwHF7x+y28RJzieOefr+gZFLGzjzWKwu3nQ+DBitMvnbjZ
         oOoCaVHH4lYUlf9zX5aP3nTfrCSgpBnL6T+bOHb1zL6vDwx8ldWOHq9sztK4v+qcszjl
         NW7g==
X-Forwarded-Encrypted: i=1; AJvYcCUUMT+77xBsKUvmu+R8ymOy+ZknnZyLMlxW0RFdjaIq8aCN3bwW8LfviEgdVu78wU0VqtYzAPUIeO2ctzg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7c6XOwO8Y7gyfeJ6rPs3mfYkNDgISXmDK9O0NzcNo+f1RbQte
	lWJEUulOmLYO5h6Tiav6LpUfiOHxU6TY8S3m5KVJyWZHY7fp1l5YgVdXjoel4aRYfg==
X-Gm-Gg: ASbGnctX++Lwsk1904RbczWbvIaKpNV1HotfMK8pbGE72RBFflE/jG49aJ22lPg/L9G
	yoTy67Pa056RS0Zbhn+OJYhSAPct5ekacYLgudh2iu0E8JC7QqmJW0aJeq9hTXqRbXS814S2Ky/
	YHRQ6j26GYCYP11/wcHViGoHMCF+7afNNZyLYS0sHiLAqh/mjcoS+8jtTbSkTYdCrfKAGAk1pTE
	a6VT+JiPY6+7ECgAKwkt8TGLBh1a+omeWjlLW0ETvcAvsRy9wYV3rvv5LtVZKmBErKN5IMMNFyG
	54bXZWVmsautJyKGwmgTb7lRohdQ5DkaWky2R+phxE9uHRa93mAf87xQpnABabZhtQlG4dYtqHl
	w3GrUIhn6+/j9ntyx5cSRVSfZHypu0Ux3g7DIvT1o6X7CWABN2qQXs+KhDmOeRKqvzWc6uSosQq
	ZTbWGnBJutcYaWD2HEqN9VqHC6urkLL2A=
X-Google-Smtp-Source: AGHT+IFR7pcMvNAZM4pc9ANqYSFpgUbp4tdFKKtCYXX8gVUIZT7dsSt6Ae5g7sCeSROI8LDmUD6EzQ==
X-Received: by 2002:a05:6a21:32a3:b0:303:b64b:e44 with SMTP id adf61e73a8af0-32da83e38bemr550247637.43.1759862153880;
        Tue, 07 Oct 2025 11:35:53 -0700 (PDT)
Received: from google.com (232.92.83.34.bc.googleusercontent.com. [34.83.92.232])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b62ce55205csm13318218a12.18.2025.10.07.11.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 11:35:52 -0700 (PDT)
Date: Tue, 7 Oct 2025 18:35:49 +0000
From: Benson Leung <bleung@google.com>
To: Jameson Thies <jthies@google.com>
Cc: akuchynski@chromium.org, bleung@chromium.org,
	abhishekpandit@chromium.org, tzungbi@kernel.org,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] platform/chrome: cros_usbpd_notify: defer probe when
 parent EC driver isn't ready
Message-ID: <aOVdhVEvbmO08sRO@google.com>
References: <20251007004043.4109957-1-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9nd5cbOCazPp9GCo"
Content-Disposition: inline
In-Reply-To: <20251007004043.4109957-1-jthies@google.com>


--9nd5cbOCazPp9GCo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jameson,

Minor nit, please provide a summary of differences since v1 below the --- in
the future.

On Tue, Oct 07, 2025 at 12:40:43AM +0000, Jameson Thies wrote:
> The cros-usbpd-notify-acpi probe currently does not exit when it fails
> to get a pointer to the ChromeOS EC device. It is expected behavior on
> older devices, where GOOG0004 is not a parent of GOOG0003.
>=20
> Update the cros-usbpd-notify-acpi probe to check for a GOOG0004 parent
> fwnode. If the device has correct device hierarchy and fails to get an
> EC device pointer, defer the probe function.
>=20
> Signed-off-by: Jameson Thies <jthies@google.com>

Reviewed-by: Benson Leung <bleung@chromium.org>


> ---
>  drivers/platform/chrome/cros_usbpd_notify.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/platform/chrome/cros_usbpd_notify.c b/drivers/platfo=
rm/chrome/cros_usbpd_notify.c
> index 313d2bcd577b..c90174360004 100644
> --- a/drivers/platform/chrome/cros_usbpd_notify.c
> +++ b/drivers/platform/chrome/cros_usbpd_notify.c
> @@ -6,6 +6,7 @@
>   */
> =20
>  #include <linux/acpi.h>
> +#include <linux/fwnode.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/platform_data/cros_ec_proto.h>
> @@ -15,6 +16,7 @@
>  #define DRV_NAME "cros-usbpd-notify"
>  #define DRV_NAME_PLAT_ACPI "cros-usbpd-notify-acpi"
>  #define ACPI_DRV_NAME "GOOG0003"
> +#define CREC_DRV_NAME "GOOG0004"
> =20
>  static BLOCKING_NOTIFIER_HEAD(cros_usbpd_notifier_list);
> =20
> @@ -98,8 +100,9 @@ static int cros_usbpd_notify_probe_acpi(struct platfor=
m_device *pdev)
>  {
>  	struct cros_usbpd_notify_data *pdnotify;
>  	struct device *dev =3D &pdev->dev;
> -	struct acpi_device *adev;
> +	struct acpi_device *adev, *parent_adev;
>  	struct cros_ec_device *ec_dev;
> +	struct fwnode_handle *parent_fwnode;
>  	acpi_status status;
> =20
>  	adev =3D ACPI_COMPANION(dev);
> @@ -114,8 +117,18 @@ static int cros_usbpd_notify_probe_acpi(struct platf=
orm_device *pdev)
>  		/*
>  		 * We continue even for older devices which don't have the
>  		 * correct device heirarchy, namely, GOOG0003 is a child
> -		 * of GOOG0004.
> +		 * of GOOG0004. If GOOG0003 is a child of GOOG0004 and we
> +		 * can't get a pointer to the Chrome EC device, defer the
> +		 * probe function.
>  		 */
> +		parent_fwnode =3D fwnode_get_parent(dev->fwnode);
> +		if (parent_fwnode) {
> +			parent_adev =3D to_acpi_device_node(parent_fwnode);
> +			if (parent_adev &&
> +			    acpi_dev_hid_match(parent_adev, CREC_DRV_NAME)) {
> +				return -EPROBE_DEFER;
> +			}
> +		}
>  		dev_warn(dev, "Couldn't get Chrome EC device pointer.\n");
>  	}
> =20
>=20
> base-commit: 48633acccf38d706d7b368400647bb9db9caf1ae
> --=20
> 2.51.0.618.g983fd99d29-goog
>=20

--9nd5cbOCazPp9GCo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCaOVdhQAKCRBzbaomhzOw
wpZdAP4+NwGYtyo6TrPhGDCmSHTaVNVV5YcF2Hukb49L7QrLxwEA/nxtp0oBH+KU
nGwgVvMvWyfD49Ls92gS8t2juKMUcg4=
=qeKA
-----END PGP SIGNATURE-----

--9nd5cbOCazPp9GCo--

