Return-Path: <linux-kernel+bounces-879086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F09F2C223D2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 21:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D11E53A94B7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 20:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9353D223DD4;
	Thu, 30 Oct 2025 20:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FgkqRxfM"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5951B173
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 20:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761855780; cv=none; b=QvY8bsO3LMonx8aIIoWkIpGMQFwmDueD4Qv6ZOAd63obpVma7eZSBN2rFvcG56zUraNwaK4NPo9z5kNLvcOVJO2khEXyACbQgeZTN8oNNBjUUlm3x/wlZ+GoQSWHsKpL2OrlSnSAw3W5u++P+zV21KQZYxKzsBEm1JUd3/lQR8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761855780; c=relaxed/simple;
	bh=cfhHMOfNjevmyHvD/oCQ9inxlGzQLoRgTSqIuWo8eHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DPP0MMm5iVa8tiCiB+v5KHMVwyc6UZGi3uSFdd+m4mM0IScZ98GoBdmKR4tnrB/muVrD26U8C05ydcHBOdcc6G5W/C9ovewnZizUPfTorkDiKchlukaS6ynCaOSYovChrw7zyr+YFU96yBW60mSeIhABdqAErVtNH+QQHG3aAEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FgkqRxfM; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-290ab379d48so14788365ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 13:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761855778; x=1762460578; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x/vVU4Df2ozvtXxUgCd8mZJ2CDfvtPv8jSi6/d8MOys=;
        b=FgkqRxfMXhbTuKw25VvGXSRRhyHNDhPJtRkulB6FMNTXdxdZ/UgitZydnadQNme+d/
         d6Z7ZiSLOzDfSlbjSRdkPa30FqwY0hVR7YKT+ImuSlPAnbWAlb/ts+UIQ9aUFI2KHDYm
         UdH/MVcwMAv0KsygPVB4uy7wpv0yg4yZ3tRO/BKVJGhBUaaMR2LRRN4DK5tnjOJniQpD
         m/i+KojZ9NwwRI3BLc/58QQKGVt6xQvspqzBzwhcAitt6aWv33t8m+itpAxJCDCPyfmC
         nbq9SuzXDfA96YHDAGuX16G5P3+AZZp1rvwM7VsLNSopO8jm70VZW+QLypf4wwB1rcSx
         wRNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761855778; x=1762460578;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x/vVU4Df2ozvtXxUgCd8mZJ2CDfvtPv8jSi6/d8MOys=;
        b=cZDPvvp8pnu0OlRImdclnMZ0iQeDxr1utCEzK78yaPuyfQMQ0Yk3x9nDPa9hC0fBRw
         9O/dsdeCwr6ZBlRp2rkgv1vzvTj7NtQ0DfypFsumRaS/rjyd1MMSxFu0HKCWCaimqlx6
         3R7PGfZnfNfspqsVfz8Kz/3/5fRRVvMxvciMibggaM28uPfGYRKu6faLAgVSdMlmocwc
         P7+5vmA+YFipE/eOkCE4Au/fsgArditCpV/8VH1B/j2C8j7SjF7+kOZ0U01X8bSH6Mwt
         0Th3OnAiZmGWhoxNoeijJ4xDYtNe/oofpVDVo+KAlNPMU29bxhlxIAAS4t4XfNeiBxsv
         XNdQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/ytPTKk35sHx4HkdDSpZySELh5ebSYAdzY3EfPiCcjgIkoJMR9p2GXMo+6K+KyfmEa9eoxC5Rp6mmV/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMh3S8GKDDWv84Ggn7EBxss/KzmdAD4JK5kten1L7ZYnARVc6q
	fZdZB6Vaaxr++9MxrpUnsDeyfGtY6AYTNHJPoNmfQiiJnawhuGQGepx+3q2mbuiUpg==
X-Gm-Gg: ASbGncvvitI7GU+rbk3YhalWI3IqpsfHFdCd9EzaxpyIEJDTgN0iDw/3c8swmg7UMaZ
	VUE7NiBB1MHGkRVASBfRXE29dSSV7Aol9GiWSR3H/r5VolyQ+xigmutXcOUskMk/QCyjqf1k2QV
	BUPUBtL2PHv0Hs8FH5R/0jWFExxZmMBMfS2TJ0XumsXgKCCbxyW0Z8qxT/Q2c7zcBztEpRIyo2b
	DXBZoSUcNYguzPETHsahfr1x1XNnmEZMxSt5WKO1+tZhZoGNLgqo68bUmPwWBVGQNN/UskOgWId
	CSKRrW59zWHWLjwoOXFVBfkujXxQZTalhNILVr+ys4yqyGLWHFnjWokMKlbfcVR+Qiw5bHKsrpl
	Hh6nJlBSzBNIZblwA4RnZxuLKoMcSF7gEGl6Fi3bjIWGby7xBE/wBmYLFCDi5AywauwdQUqF2fb
	L5DRPavXw7f8KYIEEprrzkIIkXZqc3qXPRiT/ck9z3b5M=
X-Google-Smtp-Source: AGHT+IGSPsJU7324IKH66yjFys/HafmZv0MH5748eAne4tLXZM3PCM4QkUg8/m/9D+BrnD3BVoAmqw==
X-Received: by 2002:a17:902:eccc:b0:295:2276:66f8 with SMTP id d9443c01a7336-29522766ea7mr2803545ad.54.1761855778106;
        Thu, 30 Oct 2025 13:22:58 -0700 (PDT)
Received: from google.com (232.92.83.34.bc.googleusercontent.com. [34.83.92.232])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d230basm196520445ad.46.2025.10.30.13.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 13:21:59 -0700 (PDT)
Date: Thu, 30 Oct 2025 20:21:55 +0000
From: Benson Leung <bleung@google.com>
To: Brady Norander <bradynorander@gmail.com>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH v2] platform/chrome: cros_ec_lightbar: Check if ec
 supports suspend commands
Message-ID: <aQPI4y-S5oN8sqWU@google.com>
References: <20251030195910.8625-2-bradynorander@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vbb82ZDnwpATQbIz"
Content-Disposition: inline
In-Reply-To: <20251030195910.8625-2-bradynorander@gmail.com>


--vbb82ZDnwpATQbIz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 03:59:11PM -0400, Brady Norander wrote:
> The Chromebook Pixel 2013 (Link)'s ec does not support the lightbar manua=
l suspend commands.
> As a result, attempting to suspend the device fails and prints the follow=
ing error:
>=20
>     cros-ec-lightbar cros-ec-lightbar.3.auto: PM: dpm_run_callback(): pla=
tform_pm_suspend returns -22
>     cros-ec-lightbar cros-ec-lightbar.3.auto: PM: failed to suspend: erro=
r -22
>     PM: Some devices failed to suspend, or early wake event detected
>=20
> Check the return value of lb_manual_suspend_ctrl in cros_ec_lightbar_prob=
e and disable manual
> suspend control if -EINVAL is returned.
>=20
> Signed-off-by: Brady Norander <bradynorander@gmail.com>

Reviewed-by: Benson Leung <bleung@chromium.org>


> ---
>=20
> v2:
> - Only catch -EINVAL from lb_manual_suspend_ctrl()
>=20
>  drivers/platform/chrome/cros_ec_lightbar.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/platform/chrome/cros_ec_lightbar.c b/drivers/platfor=
m/chrome/cros_ec_lightbar.c
> index 87634f6921b7..893d269f6384 100644
> --- a/drivers/platform/chrome/cros_ec_lightbar.c
> +++ b/drivers/platform/chrome/cros_ec_lightbar.c
> @@ -30,6 +30,13 @@ static unsigned long lb_interval_jiffies =3D 50 * HZ /=
 1000;
>   */
>  static bool userspace_control;
> =20
> +/*
> + * Whether or not the lightbar supports the manual suspend commands.
> + * The Pixel 2013 (Link) does not while all other devices with a
> + * lightbar do.
> +*/
> +static bool has_manual_suspend;
> +
>  static ssize_t interval_msec_show(struct device *dev,
>  				  struct device_attribute *attr, char *buf)
>  {
> @@ -550,7 +557,7 @@ static int cros_ec_lightbar_probe(struct platform_dev=
ice *pd)
>  		return -ENODEV;
> =20
>  	/* Take control of the lightbar from the EC. */
> -	lb_manual_suspend_ctrl(ec_dev, 1);
> +	has_manual_suspend =3D (lb_manual_suspend_ctrl(ec_dev, 1) !=3D -EINVAL);
> =20
>  	ret =3D sysfs_create_group(&ec_dev->class_dev.kobj,
>  				 &cros_ec_lightbar_attr_group);
> @@ -569,14 +576,15 @@ static void cros_ec_lightbar_remove(struct platform=
_device *pd)
>  			   &cros_ec_lightbar_attr_group);
> =20
>  	/* Let the EC take over the lightbar again. */
> -	lb_manual_suspend_ctrl(ec_dev, 0);
> +	if (has_manual_suspend)
> +		lb_manual_suspend_ctrl(ec_dev, 0);
>  }
> =20
>  static int __maybe_unused cros_ec_lightbar_resume(struct device *dev)
>  {
>  	struct cros_ec_dev *ec_dev =3D dev_get_drvdata(dev->parent);
> =20
> -	if (userspace_control)
> +	if (userspace_control || !has_manual_suspend)
>  		return 0;
> =20
>  	return lb_send_empty_cmd(ec_dev, LIGHTBAR_CMD_RESUME);
> @@ -586,7 +594,7 @@ static int __maybe_unused cros_ec_lightbar_suspend(st=
ruct device *dev)
>  {
>  	struct cros_ec_dev *ec_dev =3D dev_get_drvdata(dev->parent);
> =20
> -	if (userspace_control)
> +	if (userspace_control || !has_manual_suspend)
>  		return 0;
> =20
>  	return lb_send_empty_cmd(ec_dev, LIGHTBAR_CMD_SUSPEND);
> --=20
> 2.51.0
>=20

--vbb82ZDnwpATQbIz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCaQPI4wAKCRBzbaomhzOw
whlyAQDI4hhncz2W9jDRg/A9M7GIAwRs/Co+1e51mSCoyrzMGQD/cMM+Pp8h+SjP
laY4QySVe9IcJ+HUE9Q0qpGZ65aJGAQ=
=pyYL
-----END PGP SIGNATURE-----

--vbb82ZDnwpATQbIz--

