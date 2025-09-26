Return-Path: <linux-kernel+bounces-834669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A51BA53B2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 23:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 486B33A8A6D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 21:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA67272803;
	Fri, 26 Sep 2025 21:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KXtPabY1"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A151817BA6
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 21:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758922503; cv=none; b=P/LD35hVBS/FLlS3ua9EqAlL9FqoUonGg8pyLNdek7aa+jsD0wPFsQM+ZKhkT3HzgoGAV5UFBnwaHJHAuhObzq9TELoUrif8aJiyQ1iBCJ8eff8eTCvF6pkG3wJmV88T/IB1S+Hz8CYaoYeW8NWyrUTpDMyHaZriMfHmSH+oXjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758922503; c=relaxed/simple;
	bh=CuhyMLcUTJVMoZM8X/pPFZcmKWe7ZzT8bRCR9N/QlQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KAHiCjnZq03797d7Iav74eKgRkkbmpRdHiGfuTVBlE9H+SC8M+lNVZTRkeVFcxOyOxCHZWi1MqVun4FzhSzOjIpKu9QVJ2Iyz5CLZG6CbDeSsWXvKh0qnKfJRG+Rzza9VGlE11XiCNpnqXQG2xjmjDBwFSEjzAYWaePsNkA7DSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KXtPabY1; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3307de086d8so2451336a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 14:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758922501; x=1759527301; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZEtNbUaDsC70pZbi6UNhEORE7Q8iZgqKHtWH7qzvc7E=;
        b=KXtPabY1yriGsx7WNClL6sEVfWylp/gUZbeuL1qnXhn5Qq+32tBJ10MOMpPrDXcFKr
         cSRX50IgpIhM5mxe+Lv+7wImT4A0gj+S81qOb6AFC+x+iKWCY5vKw/CHz8o/a/SprHpm
         aIye/o6JrxwOExJozJlKpNhDMRFGANeIngoK+1tZVXd/DRo+MExXEtAwM5xqLz2zTR0i
         tF5lNVYZ3O+vEGby5YSM2dnTb6s5Dotth9H/XEN6AtYqjly+3PrgNe+a7lvXRwS0Dcwr
         VWRo6E6GAXBGV8aiqcc/jBlmKEOc5MmEM9abofDiOpmY3gwBfs084VJki7QlbGuiPxO1
         BK6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758922501; x=1759527301;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZEtNbUaDsC70pZbi6UNhEORE7Q8iZgqKHtWH7qzvc7E=;
        b=PRYrQWr5vznLQtL7+LKH7NHXWs0n6Nw5kZ5TkfDZX1ErJJ5td5MJi0LK+ZH7KrhODv
         ECTBQ/ixjnUXz55KavJWhmz/UkqJUBLGNyxQ9Ysg/5GHkt7rfiaTvoG7DpxpAhvb7l4z
         5aIgMHCg+kRgSwu7UHuUMTbrhCSld9CzA3+7mqFTQhPz3d4MbB8DVwXdye8tgGfVIqgI
         6u6+kyVNuIsPsWaBmGtcYhWyf9IXHrRp6rRGmXpyyFyIyEuhWNaBt0+gQqFQ1xDIgQDT
         NQIu+lleYo7MbG+A10DVzM5uATl4X/sk3wi2kmgZ8lNtwiWLERNJLk+GsYZldGhrQI9e
         rodA==
X-Forwarded-Encrypted: i=1; AJvYcCXm/NvhI/BiITHGImP9mccdL6+NliH+L2mz3zD/HQPnzqoREsLrnE2rqXsQF71o5GR89epaSw2JDPhmb+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YySEICrRsjB6K0zM3ASErf0ofhdLHqsQunn5YRBo5yWz6L8LzdM
	pthLqXfAAvdwtkGZjV4LSNta6WcMJk8x8f+ev2yU9VvUpiMvoTssZsY5PF7iy0ZQBg==
X-Gm-Gg: ASbGncvuoLVkyYmClcXXvrBmMJh1KnOCYNYMX+ngXVipyBl2RaBaQD9NntlU+t6m/MX
	9dNSF8irbgu8c5fM7Yv4G0r8hxO8DQwKlEjXYxyb+L7UOmkSwpLru8RTJ6k/Q6xD/pFghWCW7JM
	T/40z6UWNNcJ+ZPFvA79Oz67YG4NTPAPYlAuIgFLT7gvSvj1+BQnVXAWFPIySC5cPMrTrvCOqtd
	U8DujE9KQPndpGo0occzak6FkZp92gm0ULVdDJFI6jEqPI9Bik6xJwFuVFDV1mwR3NlggoGTefA
	XNmiXQh0Lxtpp9vkN8I7YacTnlJZujLzppo37k6T4mNeXdWtP77/crBJWhe4oVmq3VPKvixSWLI
	XOo0txEl/zOS8WTL82st23tMlaA03cHxdUM4s3Cohp5PQXi7vXoIlR+sIkJF1zsrNWm3/XBCy
X-Google-Smtp-Source: AGHT+IE0IQntdW0RMNRR6iYb0bv6GJIoHFJIwWi2tFa6+D4C0gs3Bm57aWR8mTol9EAr3NW5YEoP9A==
X-Received: by 2002:a17:90b:3d0d:b0:335:21bf:3b99 with SMTP id 98e67ed59e1d1-33521bf3e0dmr6035196a91.32.1758922500610;
        Fri, 26 Sep 2025 14:35:00 -0700 (PDT)
Received: from google.com (36.19.127.34.bc.googleusercontent.com. [34.127.19.36])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3341bda12eesm9634391a91.7.2025.09.26.14.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 14:34:59 -0700 (PDT)
Date: Fri, 26 Sep 2025 21:34:55 +0000
From: Benson Leung <bleung@google.com>
To: Jameson Thies <jthies@google.com>
Cc: akuchynski@chromium.org, bleung@chromium.org,
	abhishekpandit@chromium.org, tzungbi@kernel.org,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] platform/chrome: cros_usbpd_notify: defer probe when
 parent EC driver isn't ready
Message-ID: <aNcG_3_eBHX8Q0bl@google.com>
References: <20250926202234.3064386-1-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6AFJdRw8RKMCXLY7"
Content-Disposition: inline
In-Reply-To: <20250926202234.3064386-1-jthies@google.com>


--6AFJdRw8RKMCXLY7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jameson,

On Fri, Sep 26, 2025 at 08:22:34PM +0000, Jameson Thies wrote:
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
> index 313d2bcd577b..2681bf9d0159 100644
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
> +		parent_fwnode =3D fwnode_call_ptr_op(dev->fwnode, get_parent);
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

--6AFJdRw8RKMCXLY7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCaNcG/wAKCRBzbaomhzOw
wm89AP9E/FYHxEtt1/NnX8XvJnCoxHEU2t9EDTS6TVAs90BjYQEA/kSSEDpTCdjE
EKAB+Yq3VhIcS2lR6wbkdfrXvSSVEwU=
=mcNw
-----END PGP SIGNATURE-----

--6AFJdRw8RKMCXLY7--

