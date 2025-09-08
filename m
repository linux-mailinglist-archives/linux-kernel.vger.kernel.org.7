Return-Path: <linux-kernel+bounces-805032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE5EB4833D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 06:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 994021732B5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 04:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7E720D4FC;
	Mon,  8 Sep 2025 04:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="KIwHQu87"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696591E990E
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 04:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757305165; cv=none; b=cDkFiZkPIXpKguIE7qogsECG1r/N3WL9TVEj+nda/Kp7W10EL2fRqHM/e6zRSLM42VC6C+tr8YQocoou8Q7wVvo2NiMVRBm6Z4D6XVFgktPUHJnkNglK8ZoavFeaAExbL0K70kKd4d6R6181Lol8wIzRV9MdhqwYs9QCwuLNfXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757305165; c=relaxed/simple;
	bh=/jDIWK7i1bkbhteZhSWWZQoiGd9c1D9oHm8aowMZKQs=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=ESzx7afdZmrkhtZ7cOAd+dAplSZT625YRqUOZfwxbQTAvZhOSgcGfj0aQUw251SWa9o+Dz/WmqDYq5nPzOoHqjQo9mU63aSwZdtcwuZ3LOMHRVPIHVsgyV3rhL/D8lNxBxYeFXXEcvtmFwy6d3td8jyqqIp9xphBWTgC+1i1rwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=KIwHQu87; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from mail.ideasonboard.com (unknown [223.190.86.44])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 15649596;
	Mon,  8 Sep 2025 06:18:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1757305086;
	bh=/jDIWK7i1bkbhteZhSWWZQoiGd9c1D9oHm8aowMZKQs=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=KIwHQu87tkytX4QAfTXQG65ys8jzqvsky4JMDCf1MsVUeTzX+EveGlueSFAPkO+Z9
	 YYf8loivxA4+msF6a2SBb/IG3myckK7LRGO+yGINw3TbJ0JUwQHhWMninpgaAPhSDH
	 HI+9ecTX4XLjoduTpr+6KAFosE6iGeljPbSQ3vxc=
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250907-vchiq-destage-v2-5-6884505dca78@ideasonboard.com>
References: <20250907-vchiq-destage-v2-0-6884505dca78@ideasonboard.com> <20250907-vchiq-destage-v2-5-6884505dca78@ideasonboard.com>
Subject: Re: [PATCH v2 5/5] platform/broadcom: Destage VCHIQ MMAL driver
From: Jai Luthra <jai.luthra@ideasonboard.com>
Cc: linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, kernel-list@raspberrypi.com, Stefan Wahren <wahrenst@gmx.net>, Dave Stevenson <dave.stevenson@raspberrypi.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Florian Fainelli <florian.fainelli@broadcom.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>
Date: Mon, 08 Sep 2025 09:49:03 +0530
Message-ID: <175730514393.8095.11390976339304146285@freya>
User-Agent: alot/0.12.dev28+gd2c823fe

Quoting Jai Luthra (2025-09-07 14:26:25)
> Destage the VCHIQ MMAL driver to drivers/platform/broadcom.

s/broadcom/raspberrypi in the commit description and title as well

Will fix in next version

>=20
> Signed-off-by: Jai Luthra <jai.luthra@ideasonboard.com>
> ---
>  MAINTAINERS                                                             =
| 2 +-
>  drivers/platform/raspberrypi/Kconfig                                    =
| 2 ++
>  drivers/platform/raspberrypi/Makefile                                   =
| 1 +
>  .../{staging/vc04_services =3D> platform/raspberrypi}/vchiq-mmal/Kconfig=
  | 0
>  .../{staging/vc04_services =3D> platform/raspberrypi}/vchiq-mmal/Makefil=
e | 0
>  .../vc04_services =3D> platform/raspberrypi}/vchiq-mmal/mmal-common.h   =
  | 0
>  .../vc04_services =3D> platform/raspberrypi}/vchiq-mmal/mmal-encodings.h=
  | 0
>  .../vc04_services =3D> platform/raspberrypi}/vchiq-mmal/mmal-msg-common.=
h | 0
>  .../vc04_services =3D> platform/raspberrypi}/vchiq-mmal/mmal-msg-format.=
h | 0
>  .../vc04_services =3D> platform/raspberrypi}/vchiq-mmal/mmal-msg-port.h =
  | 0
>  .../vc04_services =3D> platform/raspberrypi}/vchiq-mmal/mmal-msg.h      =
  | 0
>  .../vc04_services =3D> platform/raspberrypi}/vchiq-mmal/mmal-parameters.=
h | 0
>  .../vc04_services =3D> platform/raspberrypi}/vchiq-mmal/mmal-vchiq.c    =
  | 0
>  .../vc04_services =3D> platform/raspberrypi}/vchiq-mmal/mmal-vchiq.h    =
  | 0
>  drivers/staging/vc04_services/Kconfig                                   =
| 2 --
>  drivers/staging/vc04_services/Makefile                                  =
| 1 -
>  16 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fc74a9e2e5a47b8c82cf68ef7c1fe3d37e2fe89b..856a2a489afbc95780769a708=
540444aa5aa983a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4753,7 +4753,7 @@ S:        Maintained
>  T:     git https://github.com/broadcom/stblinux.git
>  F:     Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
>  F:     drivers/pci/controller/pcie-brcmstb.c
> -F:     drivers/platform/raspberrypi/vchiq-interface
> +F:     drivers/platform/raspberrypi/vchiq-*
>  F:     drivers/staging/vc04_services
>  F:     include/linux/raspberrypi/vchiq*
>  N:     bcm2711
> diff --git a/drivers/platform/raspberrypi/Kconfig b/drivers/platform/rasp=
berrypi/Kconfig
> index 9085e7464ec348fce5ec9f41a9019ab12eee964b..2c928440a47c08e4d452fe838=
fe4105c608995a4 100644
> --- a/drivers/platform/raspberrypi/Kconfig
> +++ b/drivers/platform/raspberrypi/Kconfig
> @@ -47,4 +47,6 @@ config VCHIQ_CDEV
> =20
>  endif
> =20
> +source "drivers/platform/raspberrypi/vchiq-mmal/Kconfig"
> +
>  endif
> diff --git a/drivers/platform/raspberrypi/Makefile b/drivers/platform/ras=
pberrypi/Makefile
> index a807571c59a47bb418cbb1dfcc389219d0d0ff22..2a7c9511e5d8bbe11c05680ee=
a016ef40796b648 100644
> --- a/drivers/platform/raspberrypi/Makefile
> +++ b/drivers/platform/raspberrypi/Makefile
> @@ -12,3 +12,4 @@ ifdef CONFIG_VCHIQ_CDEV
>  vchiq-objs +=3D vchiq-interface/vchiq_dev.o
>  endif
> =20
> +obj-$(CONFIG_BCM2835_VCHIQ_MMAL)       +=3D vchiq-mmal/
> diff --git a/drivers/staging/vc04_services/vchiq-mmal/Kconfig b/drivers/p=
latform/raspberrypi/vchiq-mmal/Kconfig
> similarity index 100%
> rename from drivers/staging/vc04_services/vchiq-mmal/Kconfig
> rename to drivers/platform/raspberrypi/vchiq-mmal/Kconfig
> diff --git a/drivers/staging/vc04_services/vchiq-mmal/Makefile b/drivers/=
platform/raspberrypi/vchiq-mmal/Makefile
> similarity index 100%
> rename from drivers/staging/vc04_services/vchiq-mmal/Makefile
> rename to drivers/platform/raspberrypi/vchiq-mmal/Makefile
> diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-common.h b/dri=
vers/platform/raspberrypi/vchiq-mmal/mmal-common.h
> similarity index 100%
> rename from drivers/staging/vc04_services/vchiq-mmal/mmal-common.h
> rename to drivers/platform/raspberrypi/vchiq-mmal/mmal-common.h
> diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-encodings.h b/=
drivers/platform/raspberrypi/vchiq-mmal/mmal-encodings.h
> similarity index 100%
> rename from drivers/staging/vc04_services/vchiq-mmal/mmal-encodings.h
> rename to drivers/platform/raspberrypi/vchiq-mmal/mmal-encodings.h
> diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-msg-common.h b=
/drivers/platform/raspberrypi/vchiq-mmal/mmal-msg-common.h
> similarity index 100%
> rename from drivers/staging/vc04_services/vchiq-mmal/mmal-msg-common.h
> rename to drivers/platform/raspberrypi/vchiq-mmal/mmal-msg-common.h
> diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-msg-format.h b=
/drivers/platform/raspberrypi/vchiq-mmal/mmal-msg-format.h
> similarity index 100%
> rename from drivers/staging/vc04_services/vchiq-mmal/mmal-msg-format.h
> rename to drivers/platform/raspberrypi/vchiq-mmal/mmal-msg-format.h
> diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-msg-port.h b/d=
rivers/platform/raspberrypi/vchiq-mmal/mmal-msg-port.h
> similarity index 100%
> rename from drivers/staging/vc04_services/vchiq-mmal/mmal-msg-port.h
> rename to drivers/platform/raspberrypi/vchiq-mmal/mmal-msg-port.h
> diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-msg.h b/driver=
s/platform/raspberrypi/vchiq-mmal/mmal-msg.h
> similarity index 100%
> rename from drivers/staging/vc04_services/vchiq-mmal/mmal-msg.h
> rename to drivers/platform/raspberrypi/vchiq-mmal/mmal-msg.h
> diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-parameters.h b=
/drivers/platform/raspberrypi/vchiq-mmal/mmal-parameters.h
> similarity index 100%
> rename from drivers/staging/vc04_services/vchiq-mmal/mmal-parameters.h
> rename to drivers/platform/raspberrypi/vchiq-mmal/mmal-parameters.h
> diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/driv=
ers/platform/raspberrypi/vchiq-mmal/mmal-vchiq.c
> similarity index 100%
> rename from drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
> rename to drivers/platform/raspberrypi/vchiq-mmal/mmal-vchiq.c
> diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.h b/driv=
ers/platform/raspberrypi/vchiq-mmal/mmal-vchiq.h
> similarity index 100%
> rename from drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.h
> rename to drivers/platform/raspberrypi/vchiq-mmal/mmal-vchiq.h
> diff --git a/drivers/staging/vc04_services/Kconfig b/drivers/staging/vc04=
_services/Kconfig
> index b9e6f369f54c3af6225f181e08ac14e3de044062..2f6d1aaffdb2c1f11ec27e0fb=
8050fef56e6a875 100644
> --- a/drivers/staging/vc04_services/Kconfig
> +++ b/drivers/staging/vc04_services/Kconfig
> @@ -3,7 +3,5 @@ if BCM_VIDEOCORE
> =20
>  source "drivers/staging/vc04_services/bcm2835-audio/Kconfig"
> =20
> -source "drivers/staging/vc04_services/vchiq-mmal/Kconfig"
> -
>  endif
> =20
> diff --git a/drivers/staging/vc04_services/Makefile b/drivers/staging/vc0=
4_services/Makefile
> index 7a716a5c781530b673027b9f82ec94ebfd615f8a..ba15ec663af0fabaf0060456f=
c997deb5e5e0533 100644
> --- a/drivers/staging/vc04_services/Makefile
> +++ b/drivers/staging/vc04_services/Makefile
> @@ -1,4 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_SND_BCM2835)              +=3D bcm2835-audio/
> -obj-$(CONFIG_BCM2835_VCHIQ_MMAL)       +=3D vchiq-mmal/
> =20
>=20
> --=20
> 2.50.1
>

