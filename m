Return-Path: <linux-kernel+bounces-891010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FB8C4196A
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 21:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B19F41889308
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 20:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6626289374;
	Fri,  7 Nov 2025 20:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="PzTW9Vq9"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E560F285CA2
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 20:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762547421; cv=none; b=WkI8Sa3ttBy55YB6fKQ3ehgNgMRftLUAzZHXzGs58whUhmkQryYaxX/WpjW/KTLak44aWgxu77tm5AkGT4uBL2iXHfRg1gEBrvFguE1Vc3wcpHTqHbDik7YzShpbfo+gLrcnt9QgjhCUojGzM5u7a2GXBg7p1dHuZccFob8dMtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762547421; c=relaxed/simple;
	bh=1RMj1PijAoUCInZJAwYJc++Vsy8WPvb340ysZA76GSw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BjckA4YsSSr4wLNOPnR3eTPblNl3RcMj+NRbw3gZOm+Iiu/MUwontosHgg2l6tMSYjeAJVqiI5cYMkDzyUBFqSd217oHFsytA8edMzZsrrC6AG2pue3DsLXDfkMG26jzWhaR8zA2ZY8+I9m4etJV4s0ywRBJ2EIHh3Dc3KG3vC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca; spf=pass smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=PzTW9Vq9; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndufresne.ca
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8801e4da400so12130216d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 12:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1762547419; x=1763152219; darn=vger.kernel.org;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bDUTuqIm1mC7bv4+LL+huhJyC8iiKtLcTtZF/qxPnqw=;
        b=PzTW9Vq9Ui82rZwBXYmyJPWI+QMoojJ+8ulqHQsZbr8vmI8syge5URRjJcZpp6fbQV
         Gf02sSlsFBFH+ZgZ5mYwLMF8Lef8uIcdO3K5J0Hqg3UGP2QCrf9ycGsUylAbs93sYwp6
         IOYWFAj+CZ6iaKCuJmwgNTzE+Ytq2oQ+Aify7qgi+aVi8PlUaE9sHgh0qUC3GsakvMBC
         oxWSW10Ewvo+3oxdVijkWx1qovQ6RB4wQHtSkWbpPX///QJVNAUKD23Jm4/5ccuqLbP4
         e/4+IogXDwdLJrTzZlASHqYKxPG1hWhtja6vU0qqgN+YS8xuoeEA+JtAi6vRCGSKr1XX
         EmSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762547419; x=1763152219;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bDUTuqIm1mC7bv4+LL+huhJyC8iiKtLcTtZF/qxPnqw=;
        b=RlbIo3bsmMd2jRYGxawOIN/6KpXwPJvh+SAmo6EBfRQumV83Q/9oTpdzuBT8R+gg7N
         mt1MwIkw8fAFLZgr1ASR0+P2t6585Xtlu6WlhU3FVUGbkZ6kncstzA4khwt3rg5ystXH
         r6GJ++F+c1tzpZDgEm/A54Eb0YoiFNQcR2VDNT8THAyLeGjg87OamXxkMoE5AcD6x5mn
         xGczPmZAdAz2Jia6GcFkBiNcflwhu4QxN9QF1fbQEW7ceDskqFyoCPfRTHuAafjKBYQb
         fhSXpXpuBajmLRsq07ZXRPJVFhNAZ89AW8d/cKZ9cvlPUSq8z01qSRAzwZkxhu9P6VXR
         bmXA==
X-Gm-Message-State: AOJu0YzYh3lcDJaq7mAIvoMEpgNhs6nI0YqYxku7apMv95KxyFPOeYwc
	XkSI7r8F4zWWTGCkxqBBy7CE0tiQPZL7OyOy11fcl8OuUcNGvb8mBi+RVb5O0L+G0cA=
X-Gm-Gg: ASbGncu+o2IXLSPVmY3B6L8RQWxfbgIMSC6IQisrznS7RE6z8g1hefMBzdX7EburPNo
	Y6ycvcwLtzm3391dMI7XkPvu5+NMhly92xbuMTnomR1TZ6Fc8+rdYIEEU7d+i2R5dLnANexKXvH
	L/Q6ucuP7i2StM7A8yPg5OBQQTHTNpUvJL7RoWGhYGwhdMv2AJE29o+MCLFp9GETwgjXCR5FNLd
	xIEe1GjynJOnKKoppptDxevYSEbdKCbYnc8Uo5bHfCNkMCD5Jb1Hjd9KN+DYPd9y7Rl0IMf0Bht
	nEB4BGljn+MJlLsgwXXO80NWdInnN2isXrODCbPta389fSAvh2H0j1zQGo5lAJ9YuFpkWnHgXUE
	U0B1mp6meo81mGwS4pL0L8LZ+nZ7NYlxN78No/GjBLciRCEeB9Id/iQgpVWnO3qsNGX+IUm7BRf
	r5758Sr1PViIvF50y0
X-Google-Smtp-Source: AGHT+IE9+bUnPNb+D1GoECSagGgXpcy/iSFjYsJia7JIfqLUwPkrl0EwAL48d7DeRv+bzbrI2oATHQ==
X-Received: by 2002:a05:6214:dc4:b0:880:5001:17d1 with SMTP id 6a1803df08f44-8823871e956mr4781436d6.37.1762547418122;
        Fri, 07 Nov 2025 12:30:18 -0800 (PST)
Received: from ?IPv6:2606:6d00:11:ef24::c41? ([2606:6d00:11:ef24::c41])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eda578532csm1296591cf.19.2025.11.07.12.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 12:30:16 -0800 (PST)
Message-ID: <65c923cda564f308eae5f24191afc1c15c500ea9.camel@ndufresne.ca>
Subject: Re: [PATCH v4 1/4] media: allegro-dvt: Move the current driver to a
 subdirectory
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: yassine.ouaissa@allegrodvt.com, Mauro Carvalho Chehab
 <mchehab@kernel.org>,  Michael Tretter <m.tretter@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, Michal Simek	
 <michal.simek@amd.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski	
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Date: Fri, 07 Nov 2025 15:30:15 -0500
In-Reply-To: <20250716-allegro_dvt_al300_dec_driver-v4-1-f87c01c9f7b5@allegrodvt.com>
References: 
	<20250716-allegro_dvt_al300_dec_driver-v4-0-f87c01c9f7b5@allegrodvt.com>
	 <20250716-allegro_dvt_al300_dec_driver-v4-1-f87c01c9f7b5@allegrodvt.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-ticGmTQqqGJykJCTcdtU"
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-ticGmTQqqGJykJCTcdtU
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le mercredi 16 juillet 2025 =C3=A0 14:55 +0000, Yassine Ouaissa via B4 Rela=
y a =C3=A9crit=C2=A0:
> From: Yassine Ouaissa <yassine.ouaissa@allegrodvt.com>
>=20
> In preparation for the upcoming driver update, we need to relocate the
> current driver.
> This will help ensure a clean transition and avoid any potential
> conflicts with the new driver.
> This patch is crucial for keeping our directory organized and
> facilitating a smooth integration of the new driver.
>=20
> Signed-off-by: Yassine Ouaissa <yassine.ouaissa@allegrodvt.com>
> ---
> =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> =C2=A0drivers/media/platform/allegro-dvt/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 16 +--------------=
-
> =C2=A0drivers/media/platform/allegro-dvt/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 5 +----
> =C2=A0drivers/media/platform/allegro-dvt/zynqmp/Kconfig=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 17 +++++++++++++++++
> =C2=A0drivers/media/platform/allegro-dvt/zynqmp/Makefile=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 6 ++++++
> =C2=A0.../platform/allegro-dvt/{ =3D> zynqmp}/allegro-core.c=C2=A0=C2=A0=
=C2=A0 |=C2=A0 0
> =C2=A0.../platform/allegro-dvt/{ =3D> zynqmp}/allegro-mail.c=C2=A0=C2=A0=
=C2=A0 |=C2=A0 0
> =C2=A0.../platform/allegro-dvt/{ =3D> zynqmp}/allegro-mail.h=C2=A0=C2=A0=
=C2=A0 |=C2=A0 0
> =C2=A0.../media/platform/allegro-dvt/{ =3D> zynqmp}/nal-h264.c=C2=A0 |=C2=
=A0 0
> =C2=A0.../media/platform/allegro-dvt/{ =3D> zynqmp}/nal-h264.h=C2=A0 |=C2=
=A0 0
> =C2=A0.../media/platform/allegro-dvt/{ =3D> zynqmp}/nal-hevc.c=C2=A0 |=C2=
=A0 0
> =C2=A0.../media/platform/allegro-dvt/{ =3D> zynqmp}/nal-hevc.h=C2=A0 |=C2=
=A0 0
> =C2=A0.../media/platform/allegro-dvt/{ =3D> zynqmp}/nal-rbsp.c=C2=A0 |=C2=
=A0 0
> =C2=A0.../media/platform/allegro-dvt/{ =3D> zynqmp}/nal-rbsp.h=C2=A0 |=C2=
=A0 0
> =C2=A014 files changed, 26 insertions(+), 20 deletions(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 60bba48f5479a025f9da3eaf9dbacb67a194df07..2cea337bd426f203a8dd8f5f2=
689f8091137175e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -817,7 +817,7 @@ R:	Pengutronix Kernel Team <kernel@pengutronix.de>
> =C2=A0L:	linux-media@vger.kernel.org
> =C2=A0S:	Maintained
> =C2=A0F:	Documentation/devicetree/bindings/media/allegro,al5e.yaml
> -F:	drivers/media/platform/allegro-dvt/
> +F:	drivers/media/platform/allegro-dvt/zynqmp

If you can get Micheal approval, you can then carry over this for the follo=
wup versions:

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

cheers,
Nicolas

> =C2=A0
> =C2=A0ALLIED VISION ALVIUM CAMERA DRIVER
> =C2=A0M:	Tommaso Merciai <tomm.merciai@gmail.com>
> diff --git a/drivers/media/platform/allegro-dvt/Kconfig b/drivers/media/p=
latform/allegro-dvt/Kconfig
> index 2182e1277568a407f51a23ea437811c50b1183c8..e9008614c27b9490d1cd29fab=
887977a1918ede4 100644
> --- a/drivers/media/platform/allegro-dvt/Kconfig
> +++ b/drivers/media/platform/allegro-dvt/Kconfig
> @@ -2,18 +2,4 @@
> =C2=A0
> =C2=A0comment "Allegro DVT media platform drivers"
> =C2=A0
> -config VIDEO_ALLEGRO_DVT
> -	tristate "Allegro DVT Video IP Core"
> -	depends on V4L_MEM2MEM_DRIVERS
> -	depends on VIDEO_DEV
> -	depends on ARCH_ZYNQMP || COMPILE_TEST
> -	select V4L2_MEM2MEM_DEV
> -	select VIDEOBUF2_DMA_CONTIG
> -	select REGMAP_MMIO
> -	help
> -	=C2=A0 Support for the encoder video IP core by Allegro DVT. This core =
is
> -	=C2=A0 found for example on the Xilinx ZynqMP SoC in the EV family and =
is
> -	=C2=A0 called VCU in the reference manual.
> -
> -	=C2=A0 To compile this driver as a module, choose M here: the module
> -	=C2=A0 will be called allegro.
> +source "drivers/media/platform/allegro-dvt/zynqmp/Kconfig"
> diff --git a/drivers/media/platform/allegro-dvt/Makefile b/drivers/media/=
platform/allegro-dvt/Makefile
> index 66108a3037747020d549bc0a427881e0667a3f0a..d2aa6875edcf7760901996aac=
4d5ac98282cce20 100644
> --- a/drivers/media/platform/allegro-dvt/Makefile
> +++ b/drivers/media/platform/allegro-dvt/Makefile
> @@ -1,6 +1,3 @@
> =C2=A0# SPDX-License-Identifier: GPL-2.0
> =C2=A0
> -allegro-objs :=3D allegro-core.o allegro-mail.o
> -allegro-objs +=3D nal-rbsp.o nal-h264.o nal-hevc.o
> -
> -obj-$(CONFIG_VIDEO_ALLEGRO_DVT) +=3D allegro.o
> +obj-y +=3D zynqmp/
> diff --git a/drivers/media/platform/allegro-dvt/zynqmp/Kconfig b/drivers/=
media/platform/allegro-dvt/zynqmp/Kconfig
> new file mode 100644
> index 0000000000000000000000000000000000000000..0a0a697c420da47f87f05153a=
2dbfbe5d3ccf988
> --- /dev/null
> +++ b/drivers/media/platform/allegro-dvt/zynqmp/Kconfig
> @@ -0,0 +1,17 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +config VIDEO_ALLEGRO_DVT
> +	tristate "Allegro DVT Video IP Core for ZynqMP"
> +	depends on V4L_MEM2MEM_DRIVERS
> +	depends on VIDEO_DEV
> +	depends on ARCH_ZYNQMP || COMPILE_TEST
> +	select V4L2_MEM2MEM_DEV
> +	select VIDEOBUF2_DMA_CONTIG
> +	select REGMAP_MMIO
> +	help
> +	=C2=A0 Support for the encoder video IP core by Allegro DVT. This core =
is
> +	=C2=A0 found for example on the Xilinx ZynqMP SoC in the EV family and =
is
> +	=C2=A0 called VCU in the reference manual.
> +
> +	=C2=A0 To compile this driver as a module, choose M here: the module
> +	=C2=A0 will be called allegro.
> diff --git a/drivers/media/platform/allegro-dvt/zynqmp/Makefile b/drivers=
/media/platform/allegro-dvt/zynqmp/Makefile
> new file mode 100644
> index 0000000000000000000000000000000000000000..66108a3037747020d549bc0a4=
27881e0667a3f0a
> --- /dev/null
> +++ b/drivers/media/platform/allegro-dvt/zynqmp/Makefile
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +allegro-objs :=3D allegro-core.o allegro-mail.o
> +allegro-objs +=3D nal-rbsp.o nal-h264.o nal-hevc.o
> +
> +obj-$(CONFIG_VIDEO_ALLEGRO_DVT) +=3D allegro.o
> diff --git a/drivers/media/platform/allegro-dvt/allegro-core.c b/drivers/=
media/platform/allegro-dvt/zynqmp/allegro-core.c
> similarity index 100%
> rename from drivers/media/platform/allegro-dvt/allegro-core.c
> rename to drivers/media/platform/allegro-dvt/zynqmp/allegro-core.c
> diff --git a/drivers/media/platform/allegro-dvt/allegro-mail.c b/drivers/=
media/platform/allegro-dvt/zynqmp/allegro-mail.c
> similarity index 100%
> rename from drivers/media/platform/allegro-dvt/allegro-mail.c
> rename to drivers/media/platform/allegro-dvt/zynqmp/allegro-mail.c
> diff --git a/drivers/media/platform/allegro-dvt/allegro-mail.h b/drivers/=
media/platform/allegro-dvt/zynqmp/allegro-mail.h
> similarity index 100%
> rename from drivers/media/platform/allegro-dvt/allegro-mail.h
> rename to drivers/media/platform/allegro-dvt/zynqmp/allegro-mail.h
> diff --git a/drivers/media/platform/allegro-dvt/nal-h264.c b/drivers/medi=
a/platform/allegro-dvt/zynqmp/nal-h264.c
> similarity index 100%
> rename from drivers/media/platform/allegro-dvt/nal-h264.c
> rename to drivers/media/platform/allegro-dvt/zynqmp/nal-h264.c
> diff --git a/drivers/media/platform/allegro-dvt/nal-h264.h b/drivers/medi=
a/platform/allegro-dvt/zynqmp/nal-h264.h
> similarity index 100%
> rename from drivers/media/platform/allegro-dvt/nal-h264.h
> rename to drivers/media/platform/allegro-dvt/zynqmp/nal-h264.h
> diff --git a/drivers/media/platform/allegro-dvt/nal-hevc.c b/drivers/medi=
a/platform/allegro-dvt/zynqmp/nal-hevc.c
> similarity index 100%
> rename from drivers/media/platform/allegro-dvt/nal-hevc.c
> rename to drivers/media/platform/allegro-dvt/zynqmp/nal-hevc.c
> diff --git a/drivers/media/platform/allegro-dvt/nal-hevc.h b/drivers/medi=
a/platform/allegro-dvt/zynqmp/nal-hevc.h
> similarity index 100%
> rename from drivers/media/platform/allegro-dvt/nal-hevc.h
> rename to drivers/media/platform/allegro-dvt/zynqmp/nal-hevc.h
> diff --git a/drivers/media/platform/allegro-dvt/nal-rbsp.c b/drivers/medi=
a/platform/allegro-dvt/zynqmp/nal-rbsp.c
> similarity index 100%
> rename from drivers/media/platform/allegro-dvt/nal-rbsp.c
> rename to drivers/media/platform/allegro-dvt/zynqmp/nal-rbsp.c
> diff --git a/drivers/media/platform/allegro-dvt/nal-rbsp.h b/drivers/medi=
a/platform/allegro-dvt/zynqmp/nal-rbsp.h
> similarity index 100%
> rename from drivers/media/platform/allegro-dvt/nal-rbsp.h
> rename to drivers/media/platform/allegro-dvt/zynqmp/nal-rbsp.h

--=-ticGmTQqqGJykJCTcdtU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaQ5W1wAKCRDZQZRRKWBy
9LquAP4vrhxbrcsa2NVRSdgDGr1S60g6GOJFRtdYIYHSkGdo0AEAm0E/gtv2/K/S
yEhiuHijQF7Oy/mcG+Fguwx5A8DoVAg=
=tUk5
-----END PGP SIGNATURE-----

--=-ticGmTQqqGJykJCTcdtU--

