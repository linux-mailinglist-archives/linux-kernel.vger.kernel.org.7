Return-Path: <linux-kernel+bounces-877540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D93C1E634
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 06:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 104B54E1726
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 05:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66F7233140;
	Thu, 30 Oct 2025 05:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="fcyCZgxF"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0FA37A3CC
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 05:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761800432; cv=none; b=j/AwZC54GzW9jBX90N1ZDkZGXWOdHAKj7RmPtefcZgnOpC4Khixah2EePYg1ATbVmxb1URXqDxZDY4GiyIPONcRnLfLcWJz6qLDokbkQjeBrnghwS54tvmg7v9T8BHNyoewNKuOXjI5RHtJT6iydQ+q9IFqwTuNPi/HANXuPZJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761800432; c=relaxed/simple;
	bh=aIIDMY3AHK5dw1R7m3doBiBvTy/DW6Af897s/1Y0FmM=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=VVzsXi4wQfhhvrXN4g+20WOMf56WQC4FfXxkXqneKX4L0LWMriTD95xSFT9M18QoZ9ct6kaE8wPJJ9JlfDtm5Qy0Nxu4gHYckR4iWbNclXypQyY4Kd601rbhwDj4n7wVLoK6Ng0hVEp/VimzC/fb7gh2PluIRkof52MwaEG6K9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=fcyCZgxF; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from mail.ideasonboard.com (unknown [IPv6:2401:4900:1c69:314e:ee86:ae6e:30:9d13])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8765B6DF;
	Thu, 30 Oct 2025 05:58:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1761800316;
	bh=aIIDMY3AHK5dw1R7m3doBiBvTy/DW6Af897s/1Y0FmM=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=fcyCZgxF4TpjFmwHBuC4i48DKDr4kJjvw70dSw9AgEwoEjzO8tnC/CvDyArO0N7Ar
	 yzi8VhGp38/iGMgzZIld8SGzlLgZlse3SMyA52aoZ08v6zImE4FWA+atzoXveV6lIV
	 R2Nd8Jf3wXg6+EnhYwU99ZdvYJ4nFlq+ibaYeSTg=
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <aQIEOJUHdVMriz7S@stanley.mountain>
References: <20251029-vchiq-destage-v3-0-da8d6c83c2c5@ideasonboard.com> <aQIEOJUHdVMriz7S@stanley.mountain>
Subject: Re: [PATCH v3 0/7] staging: Destage VCHIQ interface and MMAL
From: Jai Luthra <jai.luthra@ideasonboard.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, kernel-list@raspberrypi.com, Stefan Wahren <wahrenst@gmx.net>, Dave Stevenson <dave.stevenson@raspberrypi.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Kieran Bingham <kieran.bingham@ideasonboard.com>, Phil Elwell <phil@raspberrypi.com>, Umang Jain <uajain@igalia.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Date: Thu, 30 Oct 2025 10:30:22 +0530
Message-ID: <176180042213.8690.16888216388545206511@freya>
User-Agent: alot/0.12.dev28+gd2c823fe

Hi Dan,

Thanks for the review.

Quoting Dan Carpenter (2025-10-29 17:40:32)
> I did a review of some Smatch warnings.  These aren't published because
> they generate too many false positives.  Only number 3 and number 7
> are actual issues the rest are style nit-picks.

3 - 8 are for bcm2835-camera, which is altogether dropped from staging in
PATCH 1/7.

>=20
> 1. drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c:2728 vc=
hiq_add_service_internal() info: returning a literal zero is cleaner
> s/return service;/return NULL;/
>=20
> 2. drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:408 vchi=
q_shutdown() info: returning a literal zero is cleaner
> Delete the "ret" variable.
>=20
> 3. drivers/staging/vc04_services/bcm2835-camera/controls.c:198 ctrl_set_i=
so() warn: array off by one? 'iso_values[ctrl->val]'
> There seems to be a mixup between iso_qmenu[] and iso_values[].  The one
> is only used for ARRAY_SIZE() and the other is never checked for
> ARRAY_SIZE().
>=20
> 4. drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c:337 buff=
er_cb() warn: can 'buf' even be NULL?
> Delete the NULL check.
>=20
> 5. drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c:513 star=
t_streaming() pedantic: propagate return from 'enable_camera' instead of re=
turning '-EINVAL'
> -       if (enable_camera(dev) < 0) {
> +       ret =3D enable_camera(dev);
> +       if (ret) {
>                 v4l2_err(&dev->v4l2_dev, "Failed to enable camera\n");
> -               return -EINVAL;
> +               return ret;
>         }
> 6. drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c:576 star=
t_streaming() pedantic: propagate return from 'disable_camera' instead of r=
eturning '-EINVAL'
> Same.
>=20
> 7. drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c:881 vidi=
oc_querycap() error: uninitialized symbol 'major'.
>    drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c:881 vidi=
oc_querycap() error: uninitialized symbol 'minor'.
> No error checking on vchiq_mmal_version()
>=20
> 8. drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c:1276 mma=
l_setup_components() info: returning a literal zero is cleaner
> s/return ret;/return 0;/
>=20
> regards,
> dan carpenter

Thanks,
Jai

