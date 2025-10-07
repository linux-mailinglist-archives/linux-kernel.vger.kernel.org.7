Return-Path: <linux-kernel+bounces-844898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6537BC3043
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 01:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 768F119E056B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 23:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18D02798ED;
	Tue,  7 Oct 2025 23:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ph5XqRAg"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D716246799
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 23:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759881395; cv=none; b=uRoZJQMaRQmRmDyRZV+np2IRqUjKlBlC7l+cFbu8hEBVwHtqTK4jcM6rCUylR2Ur0oDoIdAnHBWPKFmYIA8OTeyVpqRBCa9xorToa53aTbU1hyg6wxiQYQIx8WxZN1bMZZRGxvcMM3tpfVtvIP2aw+FX+B/V7x3CSfRntawb5EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759881395; c=relaxed/simple;
	bh=zJKXXBSciI+h6+weMkophpbj4m53g4DgXzbXDfHC1CA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y44wFx5fqr3tjF54R/Wm3+33Stxr+5ZYgcpVPyQbVLBieEcOjQ33hU6O6T1IuZ/HzGLqbbepcDr4Q5JzHrhK09f6xw9TSSD1HtQ5ZIMyLy9TTxh4KTzNpByrJdpI/tUgSn22LEyxOxJCEJefEGG34ileSjdR3NWSvJJLVVb7VLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ph5XqRAg; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b57d93ae3b0so4618069a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 16:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759881393; x=1760486193; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=39zXg6tilCKGf5UjV6+AnvBZd7qB5qMcffVx1lnmOy4=;
        b=Ph5XqRAgll+e6M/Lqj3ievlJMylXOlmyWtmRt/G+ST6KCFsOEm9+yvbTqKpxKOIcrp
         SQJzIBP1DwV9JpAgVBxIT14jcfSGy1hFIgINzOG4Nc31UobgVsB2KR7n+YyJ53o3KdLf
         QND01WX+7xCWd5T9ePj4oDrZIM5XwH+kKwZymAkMaMLT/9AEM6xfSoiH1MhV86skx8EV
         d1vd9SkRROux7JlM4kjT8eoasm0YLwBMmZ9L3pzYXDan+zEsjFt+yfITIh1+CsSUkkti
         vMEOu/eWEe7hRiqyEAIEJtIZoXs1fl6ClTW6WmjMM2lZuYOQhP3Dzs9H7VKN2634bCL2
         8Bpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759881393; x=1760486193;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=39zXg6tilCKGf5UjV6+AnvBZd7qB5qMcffVx1lnmOy4=;
        b=VnXH6XtUh7236hG0HDvNVPz6L8IOaFGqX5BW2L96rZsHAHSHTodJZ8BgUVh9l4WTxY
         7ofgpiJiYGJdRcfemwyQMqQ70djTPVOhR7+ZQUOGrnL9oiI8qbsgn1wpxYBmqg5xk75N
         reF0uxexMZtYn5nlv9/9pFy2dcnpsyEaPbw74WqD5zM+6KQ+NZTbo07+/sJTtyaBRIfx
         MzyydcCvSFj1AyIPEOrB2D/SV8EunW4cE1/tHsL0E33w6IzKSd/HLM+TidVsFcvzBVUg
         DZl3fH0ACO94ltMTSW1huLh5yrBpmXMMZb+NcQEXQ07eetHxNN3mVuPAw2pefW3thcGj
         Lkww==
X-Forwarded-Encrypted: i=1; AJvYcCXDbFahpfzNEaQ9vMFYpPKYCjuCUdX/rwqPwmwt8kd04HFEYfjinhIXxfx779k3E94sGSs1xyQWkJZGINM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+isSiFK1jZhEEIejXzn8QMRurDhgVAUB9QCbsq3Bi93LndB3r
	Bpkr90Io1VC7F8QUUGekq0+6F7Ql+nGDyonohzHyyL07iUMv2RNukXObSjhproBhIt+srkD7f+8
	PXZwi2g==
X-Gm-Gg: ASbGncuwjZptfRd7/BZbpTFHWSM0Lfkpo7+MolBrV6OakTXsHBMw8gl48rv+wWoZx8O
	dGtaTURFlHl6tqakxnSFMxgsbRoMCjcwHgAKlBgDN8Wwhg55MjitIPV1jWAzwgC3hg54oflvlug
	ErwKj9O3roRIx6ydoFC0sS2Y50fscQElzVljt+RbHd59Y6Xk2hTouI7pCp6TsCKZe6ABro6SCe9
	ccWwRvbOHF2YS+DQEF/jZ6M7colnx0Q9P0jDuuSBZI7dZgMrwa22N/1BrXevxQc8W7gxn0wNDMO
	ZEFtiZK93Fz08tSxPLWxcp5VgRqZUp3FH71zc1SvRDN8hJdeANYNcuN922mWD4SskAWynzKKziw
	CPPepAEdu//IEk83He0wEbKwO9KbKGprytCY2omsRioko/+0/1TeHNGje103/8cJYbkANix7+W3
	dtpL/lH2mpy8Bz90w+q8wF
X-Google-Smtp-Source: AGHT+IHMC7A37U/WEv3rhyxJXeKzOCdfHy3VqxOSC3aiXgnbwRn0y15wH9ycq+L3ZktBWltzSlIMFQ==
X-Received: by 2002:a17:90b:3843:b0:334:18f9:8008 with SMTP id 98e67ed59e1d1-33b511174e6mr1562113a91.8.1759881392356;
        Tue, 07 Oct 2025 16:56:32 -0700 (PDT)
Received: from google.com (232.92.83.34.bc.googleusercontent.com. [34.83.92.232])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b51395229sm944821a91.17.2025.10.07.16.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 16:56:30 -0700 (PDT)
Date: Tue, 7 Oct 2025 23:56:27 +0000
From: Benson Leung <bleung@google.com>
To: Jameson Thies <jthies@google.com>
Cc: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, dmitry.baryshkov@oss.qualcomm.com,
	bleung@chromium.org, gregkh@linuxfoundation.org,
	akuchynski@chromium.org, abhishekpandit@chromium.org,
	sebastian.reichel@collabora.com, linux-pm@vger.kernel.org
Subject: Re: [PATCH 6/6] usb: typec: ucsi: pr_swap should check
 connector_status
Message-ID: <aOWoq08H-3F66Ozg@google.com>
References: <20251007000007.3724229-1-jthies@google.com>
 <20251007000007.3724229-7-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3vepBb5P5u0ERoW1"
Content-Disposition: inline
In-Reply-To: <20251007000007.3724229-7-jthies@google.com>


--3vepBb5P5u0ERoW1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 07, 2025 at 12:00:07AM +0000, Jameson Thies wrote:
> From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
>=20
> Power role swaps initiated by the host system doesn't generate
> connection status change notifications.
>=20
> From UCSIv3.0 spec, section 6.5.10 Set Power Direction Role:
>=20
> The execution of this command might require PPM to initiate a power
> role swap. If the power role swap fails for any reason, the command
> returns, and error and the power direction should remain unchanged.
> Note that if the execution of the command resulted in a successful
> power role swap, it should not result in a connector status change
> notification.
>=20
> Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> Signed-off-by: Jameson Thies <jthies@google.com>

Reviewed-by: Benson Leung <bleung@chromium.org>


> ---
>  drivers/usb/typec/ucsi/ucsi.c | 30 +++++++++++++++++++++++++-----
>  1 file changed, 25 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index 1a7d850b11ea..6e3797d7a144 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -1526,20 +1526,40 @@ static int ucsi_pr_swap(struct typec_port *port, =
enum typec_role role)
>  	if (ret < 0)
>  		goto out_unlock;
> =20
> -	mutex_unlock(&con->lock);
> +	command =3D UCSI_GET_CONNECTOR_STATUS | UCSI_CONNECTOR_NUMBER(con->num);
> +	ret =3D ucsi_send_command(con->ucsi, command, &con->status, sizeof(con-=
>status));
> +	if (ret < 0)
> +		goto out_unlock;
> =20
> -	if (!wait_for_completion_timeout(&con->complete,
> -					 msecs_to_jiffies(UCSI_SWAP_TIMEOUT_MS)))
> -		return -ETIMEDOUT;
> +	cur_role =3D !!UCSI_CONSTAT(con, PWR_DIR);
> =20
> -	mutex_lock(&con->lock);
> +	/* Execution of SET_PDR should not result in connector status
> +	 * notifications. However, some legacy implementations may still defer
> +	 * the actual role swap and return immediately. Thus, check the
> +	 * connector status in case it immediately succeeded or wait for a later
> +	 * connector status change.
> +	 */
> +	if (cur_role !=3D role) {
> +		mutex_unlock(&con->lock);
> +
> +		if (!wait_for_completion_timeout(
> +			    &con->complete,
> +			    msecs_to_jiffies(UCSI_SWAP_TIMEOUT_MS)))
> +			return -ETIMEDOUT;
> +
> +		mutex_lock(&con->lock);
> +	}
> =20
>  	/* Something has gone wrong while swapping the role */
>  	if (UCSI_CONSTAT(con, PWR_OPMODE) !=3D UCSI_CONSTAT_PWR_OPMODE_PD) {
>  		ucsi_reset_connector(con, true);
>  		ret =3D -EPROTO;
> +		goto out_unlock;
>  	}
> =20
> +	/* Indicate successful power role swap */
> +	typec_set_pwr_role(con->port, role);
> +
>  out_unlock:
>  	mutex_unlock(&con->lock);
> =20
> --=20
> 2.51.0.618.g983fd99d29-goog
>=20

--3vepBb5P5u0ERoW1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCaOWoqwAKCRBzbaomhzOw
ws1vAQCb90DdZAg6y6j6gxeiXtb3EGaDB+3GnPoYDww9vdtaYQD/ayZXFW+x+d+E
M5yCHWN8me1+9sGUjPAZlnVttMLEWAg=
=BpLg
-----END PGP SIGNATURE-----

--3vepBb5P5u0ERoW1--

