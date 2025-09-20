Return-Path: <linux-kernel+bounces-825586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5403DB8C45B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 11:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9B707A3E2A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 09:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A1E239E65;
	Sat, 20 Sep 2025 09:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="VWXIucSX"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FDD279917
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 09:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758359978; cv=none; b=g4cVlhBMUwqP6Uy075ci7nhXussUolvohN4uSbzmgyWMnmhf0uutqQ+CBd2gapudto3mLvbXQgiyOJJPmx3kkAHAFM1yBIRKP7F/7Zs+bf0ApsWc09wbjKUt6bYRcI1M2MfkZCUrAOQ1F1vIdZsUTRLdZ0mzr9/QwCFIKJ5ZMpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758359978; c=relaxed/simple;
	bh=v4EzDPDtrG+DlkRSCpgtAGH9I8PWWh4be/oejkHtTcU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZUprA6NAh35Mk6wruc8+oNYaUS7wjPkigUTzQaLzWmgS1HoHjV+qvdvQjKnos9gq+U9hUyfk0EGc5szExx3N3Yxz9Np1nEXQfFW4RlLbX/RuWXm/G+NS/SWwBuTg8wXpsJN/BAyGb1YCtcU+qGpghy1XYDCP5sYIbaXm4KGmyPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=VWXIucSX; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1758359968; x=1758964768; i=wahrenst@gmx.net;
	bh=Yb6gFxYaLGICcsDJlakwRMUFZzIx/1ulgsB5/u+DjiU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=VWXIucSXBPnSy3Dfxd/RtOdRUVA7jz4IVWMSOqGvVFs6hDgQKD96i9xKpR9qDHDD
	 jgDSM/Mi002HVrVv9t7bgjuAWDTv3Q6LBMx24QhVzVaFhTLcdG2bg4M19G07a1qzA
	 7GtD7iRiHBsX9eaJgtqYn/qwbJgIKSLIQ7zAxE+JPVkmZTGqXmWxZTRI7h6npwfri
	 xjVQUW82SnrPu4DCMOcK2QQ1asU80wVKxfHTUuH5tn88aQ+pbYBzZmmv7Z7reR03K
	 0bJU32mdpWx9jr7g3kobeLOat6s9JYT43/8hSvHwDaTHzl3qxMkWChI8abnlJQRdz
	 fPL1bvkfVSsLw++8Ig==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.105] ([79.235.128.112]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Ml6mE-1uWJci2siy-00q4nh; Sat, 20
 Sep 2025 11:19:28 +0200
Message-ID: <2f7f2fe7-a6db-4bc3-891e-8097a650d849@gmx.net>
Date: Sat, 20 Sep 2025 11:19:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] platform/broadcom: Destage VCHIQ MMAL driver
To: Jai Luthra <jai.luthra@ideasonboard.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>
Cc: linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, kernel-list@raspberrypi.com,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <20250907-vchiq-destage-v2-0-6884505dca78@ideasonboard.com>
 <20250907-vchiq-destage-v2-5-6884505dca78@ideasonboard.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
Autocrypt: addr=wahrenst@gmx.net; keydata=
 xjMEZ1dOJBYJKwYBBAHaRw8BAQdA7H2MMG3q8FV7kAPko5vOAeaa4UA1I0hMgga1j5iYTTvN
 IFN0ZWZhbiBXYWhyZW4gPHdhaHJlbnN0QGdteC5uZXQ+wo8EExYIADcWIQT3FXg+ApsOhPDN
 NNFuwvLLwiAwigUCZ1dOJAUJB4TOAAIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEG7C8svCIDCK
 JQ4BAP4Y9uuHAxbAhHSQf6UZ+hl5BDznsZVBJvH8cZe2dSZ6AQCNgoc1Lxw1tvPscuC1Jd1C
 TZomrGfQI47OiiJ3vGktBc44BGdXTiQSCisGAQQBl1UBBQEBB0B5M0B2E2XxySUQhU6emMYx
 f5QR/BrEK0hs3bLT6Hb9WgMBCAfCfgQYFggAJhYhBPcVeD4Cmw6E8M000W7C8svCIDCKBQJn
 V04kBQkHhM4AAhsMAAoJEG7C8svCIDCKJxoA/i+kqD5bphZEucrJHw77ujnOQbiKY2rLb0pE
 aHMQoiECAQDVbj827W1Yai/0XEABIr8Ci6a+/qZ8Vz6MZzL5GJosAA==
In-Reply-To: <20250907-vchiq-destage-v2-5-6884505dca78@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8gPlqACnf8OQVP6rX209zmVlpQYLHQXNJx+1ZiFlsZFZTSkqHFP
 TMVbn50rKTlw26Z+DoLUZs2IaHummdfr0N4Ne8xodBSJMPTjwqFh1aErD4ritJDo6acvaGc
 DSNqn5503xFCVGcrpYB4xN8JT5cMZIzUJ7XOgOE05knp8MnsQpO/ji8kyCnFlJRis9y9zHe
 WKrFvR4Un+9luq2Onq/Sw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MIIMLaz6IHQ=;91/qmOzD50EOyzIBiLxaE6oE7uM
 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

Hi Jai,

Am 07.09.25 um 10:56 schrieb Jai Luthra:
> Destage the VCHIQ MMAL driver to drivers/platform/broadcom.
>
> Signed-off-by: Jai Luthra <jai.luthra@ideasonboard.com>
> ---
>   MAINTAINERS                                                           =
  | 2 +-
>   drivers/platform/raspberrypi/Kconfig                                  =
  | 2 ++
>   drivers/platform/raspberrypi/Makefile                                 =
  | 1 +
>   .../{staging/vc04_services =3D> platform/raspberrypi}/vchiq-mmal/Kconf=
ig  | 0
>   .../{staging/vc04_services =3D> platform/raspberrypi}/vchiq-mmal/Makef=
ile | 0
>   .../vc04_services =3D> platform/raspberrypi}/vchiq-mmal/mmal-common.h =
    | 0
>   .../vc04_services =3D> platform/raspberrypi}/vchiq-mmal/mmal-encodings=
.h  | 0
>   .../vc04_services =3D> platform/raspberrypi}/vchiq-mmal/mmal-msg-commo=
n.h | 0
>   .../vc04_services =3D> platform/raspberrypi}/vchiq-mmal/mmal-msg-forma=
t.h | 0
>   .../vc04_services =3D> platform/raspberrypi}/vchiq-mmal/mmal-msg-port.=
h   | 0
>   .../vc04_services =3D> platform/raspberrypi}/vchiq-mmal/mmal-msg.h    =
    | 0
>   .../vc04_services =3D> platform/raspberrypi}/vchiq-mmal/mmal-parameter=
s.h | 0
>   .../vc04_services =3D> platform/raspberrypi}/vchiq-mmal/mmal-vchiq.c  =
    | 0
>   .../vc04_services =3D> platform/raspberrypi}/vchiq-mmal/mmal-vchiq.h  =
    | 0
>   drivers/staging/vc04_services/Kconfig                                 =
  | 2 --
>   drivers/staging/vc04_services/Makefile                                =
  | 1 -
>   16 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fc74a9e2e5a47b8c82cf68ef7c1fe3d37e2fe89b..856a2a489afbc95780769a70=
8540444aa5aa983a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4753,7 +4753,7 @@ S:	Maintained
>   T:	git https://github.com/broadcom/stblinux.git
>   F:	Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
>   F:	drivers/pci/controller/pcie-brcmstb.c
> -F:	drivers/platform/raspberrypi/vchiq-interface
> +F:	drivers/platform/raspberrypi/vchiq-*
could you please apply this pattern already in patch 3, so we don't have=
=20
to modify the MAINTAINER file here?

Best regards
>   F:	drivers/staging/vc04_services
>   F:	include/linux/raspberrypi/vchiq*
>   N:	bcm2711
> diff --git a/drivers/platform/raspberrypi/Kconfig b/drivers/platform/ras=
pberrypi/Kconfig
> index 9085e7464ec348fce5ec9f41a9019ab12eee964b..2c928440a47c08e4d452fe83=
8fe4105c608995a4 100644
> --- a/drivers/platform/raspberrypi/Kconfig
> +++ b/drivers/platform/raspberrypi/Kconfig
> @@ -47,4 +47,6 @@ config VCHIQ_CDEV
>  =20
>   endif
>  =20
> +source "drivers/platform/raspberrypi/vchiq-mmal/Kconfig"
> +
>   endif
> diff --git a/drivers/platform/raspberrypi/Makefile b/drivers/platform/ra=
spberrypi/Makefile
> index a807571c59a47bb418cbb1dfcc389219d0d0ff22..2a7c9511e5d8bbe11c05680e=
ea016ef40796b648 100644
> --- a/drivers/platform/raspberrypi/Makefile
> +++ b/drivers/platform/raspberrypi/Makefile
> @@ -12,3 +12,4 @@ ifdef CONFIG_VCHIQ_CDEV
>   vchiq-objs +=3D vchiq-interface/vchiq_dev.o
>   endif
>  =20
> +obj-$(CONFIG_BCM2835_VCHIQ_MMAL)	+=3D vchiq-mmal/
> diff --git a/drivers/staging/vc04_services/vchiq-mmal/Kconfig b/drivers/=
platform/raspberrypi/vchiq-mmal/Kconfig
> similarity index 100%
> rename from drivers/staging/vc04_services/vchiq-mmal/Kconfig
> rename to drivers/platform/raspberrypi/vchiq-mmal/Kconfig
> diff --git a/drivers/staging/vc04_services/vchiq-mmal/Makefile b/drivers=
/platform/raspberrypi/vchiq-mmal/Makefile
> similarity index 100%
> rename from drivers/staging/vc04_services/vchiq-mmal/Makefile
> rename to drivers/platform/raspberrypi/vchiq-mmal/Makefile
> diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-common.h b/dr=
ivers/platform/raspberrypi/vchiq-mmal/mmal-common.h
> similarity index 100%
> rename from drivers/staging/vc04_services/vchiq-mmal/mmal-common.h
> rename to drivers/platform/raspberrypi/vchiq-mmal/mmal-common.h
> diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-encodings.h b=
/drivers/platform/raspberrypi/vchiq-mmal/mmal-encodings.h
> similarity index 100%
> rename from drivers/staging/vc04_services/vchiq-mmal/mmal-encodings.h
> rename to drivers/platform/raspberrypi/vchiq-mmal/mmal-encodings.h
> diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-msg-common.h =
b/drivers/platform/raspberrypi/vchiq-mmal/mmal-msg-common.h
> similarity index 100%
> rename from drivers/staging/vc04_services/vchiq-mmal/mmal-msg-common.h
> rename to drivers/platform/raspberrypi/vchiq-mmal/mmal-msg-common.h
> diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-msg-format.h =
b/drivers/platform/raspberrypi/vchiq-mmal/mmal-msg-format.h
> similarity index 100%
> rename from drivers/staging/vc04_services/vchiq-mmal/mmal-msg-format.h
> rename to drivers/platform/raspberrypi/vchiq-mmal/mmal-msg-format.h
> diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-msg-port.h b/=
drivers/platform/raspberrypi/vchiq-mmal/mmal-msg-port.h
> similarity index 100%
> rename from drivers/staging/vc04_services/vchiq-mmal/mmal-msg-port.h
> rename to drivers/platform/raspberrypi/vchiq-mmal/mmal-msg-port.h
> diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-msg.h b/drive=
rs/platform/raspberrypi/vchiq-mmal/mmal-msg.h
> similarity index 100%
> rename from drivers/staging/vc04_services/vchiq-mmal/mmal-msg.h
> rename to drivers/platform/raspberrypi/vchiq-mmal/mmal-msg.h
> diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-parameters.h =
b/drivers/platform/raspberrypi/vchiq-mmal/mmal-parameters.h
> similarity index 100%
> rename from drivers/staging/vc04_services/vchiq-mmal/mmal-parameters.h
> rename to drivers/platform/raspberrypi/vchiq-mmal/mmal-parameters.h
> diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/dri=
vers/platform/raspberrypi/vchiq-mmal/mmal-vchiq.c
> similarity index 100%
> rename from drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
> rename to drivers/platform/raspberrypi/vchiq-mmal/mmal-vchiq.c
> diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.h b/dri=
vers/platform/raspberrypi/vchiq-mmal/mmal-vchiq.h
> similarity index 100%
> rename from drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.h
> rename to drivers/platform/raspberrypi/vchiq-mmal/mmal-vchiq.h
> diff --git a/drivers/staging/vc04_services/Kconfig b/drivers/staging/vc0=
4_services/Kconfig
> index b9e6f369f54c3af6225f181e08ac14e3de044062..2f6d1aaffdb2c1f11ec27e0f=
b8050fef56e6a875 100644
> --- a/drivers/staging/vc04_services/Kconfig
> +++ b/drivers/staging/vc04_services/Kconfig
> @@ -3,7 +3,5 @@ if BCM_VIDEOCORE
>  =20
>   source "drivers/staging/vc04_services/bcm2835-audio/Kconfig"
>  =20
> -source "drivers/staging/vc04_services/vchiq-mmal/Kconfig"
> -
>   endif
>  =20
> diff --git a/drivers/staging/vc04_services/Makefile b/drivers/staging/vc=
04_services/Makefile
> index 7a716a5c781530b673027b9f82ec94ebfd615f8a..ba15ec663af0fabaf0060456=
fc997deb5e5e0533 100644
> --- a/drivers/staging/vc04_services/Makefile
> +++ b/drivers/staging/vc04_services/Makefile
> @@ -1,4 +1,3 @@
>   # SPDX-License-Identifier: GPL-2.0
>   obj-$(CONFIG_SND_BCM2835)		+=3D bcm2835-audio/
> -obj-$(CONFIG_BCM2835_VCHIQ_MMAL)	+=3D vchiq-mmal/
>  =20
>


