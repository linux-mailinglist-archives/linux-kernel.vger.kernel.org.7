Return-Path: <linux-kernel+bounces-891072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 135E0C41C46
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 22:18:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 749F3189C58B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 21:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAED72EA154;
	Fri,  7 Nov 2025 21:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="K+ceAzwJ"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F312EA732
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 21:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762550302; cv=none; b=Pclatshve7fPdA7Ph8yZlCFHV7QwHgizdZQJumY3voqhZwUVpTzvA62nCDFCnqeYib6G84QhtdNX7Ay+ah+7WLzh4+kt2nhhPEW437tX7XUtk/Iirh04VUw7Hofc9RBqwxXYAIMLamOl9qGrSsM2mwYPd+WmPWy8nUkMVD6iigc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762550302; c=relaxed/simple;
	bh=ng8P9w0HxcUfJvryzMdu3RNxjwYKJBo9OQUBseZjtn4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NXQKEwYS+n7hWgvKiWEOzpmUJaViNQ9D/UG2t5TPqhZac7CPy1AkiXqiWldTYH0nQmxElJCryXPq9znb1e4cS+YS/+UWBwBP+WzOLvyT5/IVPnNSowH29QRefxdQMqHeeQK4d7GRrhqi8cv30nSYpZinazbc3yRgCBbAdIyUvwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca; spf=pass smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=K+ceAzwJ; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndufresne.ca
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8b1f2fbaed7so113921085a.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 13:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1762550295; x=1763155095; darn=vger.kernel.org;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yiTz3b8xXMTNjCxDBL44/Z3nwr23Yvjp0G7c7k4VcKw=;
        b=K+ceAzwJ2p/LkGFbG0X/+EZ32WCZGPk31PadJwHZGITScU0AUJ7+VoGHCIBpYnKvmK
         x0OQk3Qp49oNEaIiV1tdHPqi2M/5vUUh2X3i5xPl8/EbBGvsu5aqziwrJwZ2+vll47Ov
         lziJApu+fpQSvjqQWARQmJPDvQp1imgF3Z7hGzVnSO+yf9OYaTJydYDt646eBgNsIDsb
         gq5BEl4BQL1YlJOBGykrX660U7KMIBt4EcpTXo04oaxWT3gx5mmqXCAO02+P78+bbZUw
         UX6D7V6L31Rs28wPTkMmvoLsIQmHLVI9IOI2NNRGB1JDgx24Qu8pXeWxvOMRy5mQII2z
         tvzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762550295; x=1763155095;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yiTz3b8xXMTNjCxDBL44/Z3nwr23Yvjp0G7c7k4VcKw=;
        b=NqMjGFhBWILkYrygvyfPbSBXVqEtRAGTBwUdWoQeBB/YhyX2yUEUm4jtn0lun/ab3l
         3hC6ha4lJC5VBHVfDwCyH+l5RJakESSi15IdKwKciH8i8s20ikidzIlXsac8hQ38W4gA
         0T47sXhtdlypBjPRTehGdDTAX2V5W0UaFVmEIwZ9w3xdNpVxzoVm/CNxJiwri1K8EVT4
         ICFW95Ql/8rMN6+ZcPos73kYyncIKA1X0wN+uF8JR2x612gKdWij3aTk6l9wdLqjw/8E
         iALX6KNC6bsihunzupwCF8Ek0tbx6n7/vOCYR+OrnTsAlzCRxl1k4QGwUcnQ0Nj5vBtk
         F6xA==
X-Gm-Message-State: AOJu0YycLlrpWH8cGgreTpLusAV5zuFunb1Xzel37mwaMBGnu9pJqr9Q
	JgCDe3I6LSyexqx9lJa9vyBlaGyske7mq1igsZ0G05JaJXvwx20Nt5EhRtlzVGWNFbQ=
X-Gm-Gg: ASbGncuKr2Juc2WAYJd8XDRA7jDIE9+S9dc9OnM07HrxIYbeV5nCE5kj8HBCuImTVhh
	22CgnBU1lvPtr5VRL+aJb4KbhPO2QjiPUr0OMIaecU5IPuG/WADRu/S93kfvLHXQNtyzzijH3u+
	2gtQFGSL2q7Q2LBqsfWvJs3To5Krgo0Lc+1YjFr4Ey6THqK3lWzx34AyoKWsU742r6MtRr6+kHJ
	BU8CmLgFXKbRqy0Z+9rIkHOx99HrvnR2ufq4C0zOuxB4wcf2dqrSP0FHj1M850G0uIcH47k+qCh
	mStkHQ4oHw58nCZdh7Fzx0fflu1MXEwQ7mqZ8vsVU0YinVpDPOVjrlWg7DVTUG06JOynEtbGoVv
	XEm5G/uXWcDAZ4EoBQ3wlGIu7cnKbJ7b631nlw6VBtHpMBBTlkTnz8WT6QUl2DzqgdGeE6XAsIt
	KTnb6bBFVr2n/jJLdvxEk6dMwLSTM=
X-Google-Smtp-Source: AGHT+IHyFkqPECWKNgyPnyuXjJismZCgmZAoCf1/5bkABT9PoR1uqAjDIqelyXsTqYgctSuRuKT0nA==
X-Received: by 2002:a05:620a:4488:b0:8b1:2fab:30cd with SMTP id af79cd13be357-8b257f4d214mr108798785a.52.1762550294139;
        Fri, 07 Nov 2025 13:18:14 -0800 (PST)
Received: from ?IPv6:2606:6d00:11:ef24::c41? ([2606:6d00:11:ef24::c41])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2355c24f6sm494049785a.6.2025.11.07.13.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 13:18:13 -0800 (PST)
Message-ID: <51a1974ebeed5d7fda49f05545ac4c86f7ec85b6.camel@ndufresne.ca>
Subject: Re: [PATCH v4 4/4] media: allegro-dvt: Add Gen 3 IP stateful
 decoder driver
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: yassine.ouaissa@allegrodvt.com, Mauro Carvalho Chehab
 <mchehab@kernel.org>,  Michael Tretter <m.tretter@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, Michal Simek	
 <michal.simek@amd.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski	
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Date: Fri, 07 Nov 2025 16:18:11 -0500
In-Reply-To: <20250716-allegro_dvt_al300_dec_driver-v4-4-f87c01c9f7b5@allegrodvt.com>
References: 
	<20250716-allegro_dvt_al300_dec_driver-v4-0-f87c01c9f7b5@allegrodvt.com>
	 <20250716-allegro_dvt_al300_dec_driver-v4-4-f87c01c9f7b5@allegrodvt.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-Nss7NBe2u0IN0E+GPyZQ"
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-Nss7NBe2u0IN0E+GPyZQ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

took a long time, but I got to it.

Le mercredi 16 juillet 2025 =C3=A0 14:55 +0000, Yassine Ouaissa via B4 Rela=
y a =C3=A9crit=C2=A0:
> From: Yassine Ouaissa <yassine.ouaissa@allegrodvt.com>
>=20
> This commit introduces a new allegro-dvt V4L2 stateful decoder driverfor

driverfor -> driver for

> the Gen 3 IP with support for:
> - AVC (H.264), HEVC (H.265), and JPEG decoding
> - Output formats: NV12, NV16, I420, and P010 for capture
>=20
> Signed-off-by: Yassine Ouaissa <yassine.ouaissa@allegrodvt.com>
> ---
> =C2=A0drivers/media/platform/allegro-dvt/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 1 +
> =C2=A0drivers/media/platform/allegro-dvt/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 1 +
> =C2=A0drivers/media/platform/allegro-dvt/al300/Kconfig=C2=A0=C2=A0 |=C2=
=A0=C2=A0 23 +
> =C2=A0drivers/media/platform/allegro-dvt/al300/Makefile=C2=A0 |=C2=A0=C2=
=A0=C2=A0 9 +
> =C2=A0.../platform/allegro-dvt/al300/al_codec_common.c=C2=A0=C2=A0 |=C2=
=A0 747 ++++++++++
> =C2=A0.../platform/allegro-dvt/al300/al_codec_common.h=C2=A0=C2=A0 |=C2=
=A0 251 ++++
> =C2=A0.../platform/allegro-dvt/al300/al_codec_dbgfs.c=C2=A0=C2=A0=C2=A0 |=
=C2=A0 229 +++
> =C2=A0.../platform/allegro-dvt/al300/al_codec_dbgfs.h=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 71 +
> =C2=A0.../platform/allegro-dvt/al300/al_codec_util.c=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 180 +++
> =C2=A0.../platform/allegro-dvt/al300/al_codec_util.h=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 194 +++
> =C2=A0.../media/platform/allegro-dvt/al300/al_vdec_drv.c | 1515 +++++++++=
+++++++++++
> =C2=A0.../media/platform/allegro-dvt/al300/al_vdec_drv.h |=C2=A0=C2=A0 98=
 ++
> =C2=A012 files changed, 3319 insertions(+)
>=20
> diff --git a/drivers/media/platform/allegro-dvt/Kconfig b/drivers/media/p=
latform/allegro-dvt/Kconfig
> index e9008614c27b9490d1cd29fab887977a1918ede4..0d01ed0ad08ab3bf63fc6bc60=
ac6c8ad9b31c9ab 100644
> --- a/drivers/media/platform/allegro-dvt/Kconfig
> +++ b/drivers/media/platform/allegro-dvt/Kconfig
> @@ -2,4 +2,5 @@
> =C2=A0
> =C2=A0comment "Allegro DVT media platform drivers"
> =C2=A0
> +source "drivers/media/platform/allegro-dvt/al300/Kconfig"
> =C2=A0source "drivers/media/platform/allegro-dvt/zynqmp/Kconfig"
> diff --git a/drivers/media/platform/allegro-dvt/Makefile b/drivers/media/=
platform/allegro-dvt/Makefile
> index d2aa6875edcf7760901996aac4d5ac98282cce20..c70ca19a47fb7a50a568b37ce=
519bbedbefe670d 100644
> --- a/drivers/media/platform/allegro-dvt/Makefile
> +++ b/drivers/media/platform/allegro-dvt/Makefile
> @@ -1,3 +1,4 @@
> =C2=A0# SPDX-License-Identifier: GPL-2.0
> =C2=A0
> +obj-y +=3D al300/
> =C2=A0obj-y +=3D zynqmp/
> diff --git a/drivers/media/platform/allegro-dvt/al300/Kconfig b/drivers/m=
edia/platform/allegro-dvt/al300/Kconfig
> new file mode 100644
> index 0000000000000000000000000000000000000000..0bc3d7a79f14038a4f497f736=
b14a7fc7cca0aeb
> --- /dev/null
> +++ b/drivers/media/platform/allegro-dvt/al300/Kconfig
> @@ -0,0 +1,23 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +config VIDEO_ALLEGRO_DVT_D300
> +	tristate "Allegro DVT Video IP Decode Gen 3"
> +	depends on V4L_MEM2MEM_DRIVERS
> +	depends on VIDEO_DEV && OF && HAS_DMA
> +	select V4L2_MEM2MEM_DEV
> +	select VIDEOBUF2_DMA_CONTIG
> +	help
> +	=C2=A0 This is a video4linux2 driver for the Allegro DVT IP Decode Gen =
3,
> +	=C2=A0 that support codecs : AVC (H.264), HEVC (H.265), and JPEG.
> +
> +	=C2=A0 The driver provides hardware acceleration for video decoding ope=
rations,
> +	=C2=A0 enabling efficient processing of compressed video streams on pla=
tforms
> +	=C2=A0 featuring this IP block. It handles memory management, buffer al=
location,
> +	=C2=A0 and decoder command sequencing to deliver optimized performance.
> +
> +	=C2=A0 The driver integrates with the V4L2 framework and videobuf2 subs=
ystem
> +	=C2=A0 to provide a standard interface for applications requiring video
> +	=C2=A0 decoding capabilities.
> +
> +	=C2=A0 To compile this driver as a module, choose M here. The module
> +	=C2=A0 will be called al300-vdec.
> diff --git a/drivers/media/platform/allegro-dvt/al300/Makefile b/drivers/=
media/platform/allegro-dvt/al300/Makefile
> new file mode 100644
> index 0000000000000000000000000000000000000000..e5bc317ee2a76963ff8bfe4a5=
84ce5bde1a98fb7
> --- /dev/null
> +++ b/drivers/media/platform/allegro-dvt/al300/Makefile
> @@ -0,0 +1,9 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +al300-vdec-objs :=3D al_codec_common.o al_codec_util.o al_vdec_drv.o
> +
> +ifneq ($(CONFIG_DEBUG_FS),)
> +al300-vdec-objs +=3D al_codec_dbgfs.o
> +endif
> +
> +obj-$(CONFIG_VIDEO_ALLEGRO_DVT_D300) +=3D al300-vdec.o
> diff --git a/drivers/media/platform/allegro-dvt/al300/al_codec_common.c b=
/drivers/media/platform/allegro-dvt/al300/al_codec_common.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..cfd0f24e7d0279423573c0881=
6f8c6761b95a691
> --- /dev/null
> +++ b/drivers/media/platform/allegro-dvt/al300/al_codec_common.c
> @@ -0,0 +1,747 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Core MCU functionality including firmware loading,
> + * memory allocation, and general MCU interaction interfaces
> + *
> + * Copyright (c) 2025 Allegro DVT.
> + * Author: Yassine OUAISSA <yassine.ouaissa@allegrodvt.fr>
> + */
> +
> +#include <linux/cleanup.h>
> +#include <linux/clk.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/firmware.h>
> +#include <linux/interrupt.h>
> +#include <linux/of_reserved_mem.h>
> +#include <linux/slab.h>
> +#include <linux/types.h>
> +
> +#include "al_codec_common.h"
> +
> +#define AL_CODEC_UID 0x0000
> +#define AL_CODEC_RESET 0x0010
> +#define AL_CODEC_IRQ_MASK 0x0014
> +#define AL_CODEC_IRQ_STATUS_CLEAR 0x0018
> +#define AL_CODEC_MCU_CLK 0x0400
> +#define AL_CODEC_MCU_RST 0x0404
> +#define AL_CODEC_MCU_IRQ 0x040C
> +#define AL_CODEC_MCU_BOOT_ADDR_HI 0x0410
> +#define AL_CODEC_MCU_BOOT_ADDR_LO 0x0414
> +#define AL_CODEC_MCU_IP_START_ADDR_HI 0x0418
> +#define AL_CODEC_MCU_IP_START_ADDR_LO 0x041C
> +#define AL_CODEC_MCU_IP_END_ADDR_HI 0x0420
> +#define AL_CODEC_MCU_IP_END_ADDR_LO 0x0424
> +#define AL_CODEC_MCU_PERIPH_ADDR_HI 0x0428
> +#define AL_CODEC_MCU_PERIPH_ADDR_LO 0x042C
> +#define AL_CODEC_MCU_IRQ_MASK 0x0440
> +#define AL_CODEC_INST_OFFSET_HI 0x0450
> +#define AL_CODEC_INST_OFFSET_LO 0x0454
> +#define AL_CODEC_DATA_OFFSET_HI 0x0458
> +#define AL_CODEC_DATA_OFFSET_LO 0x045C
> +
> +#define AL_CODEC_UID_ID 0x30AB6E51
> +#define AL_CODEC_IRQ_MCU_2_CPU BIT(30)
> +#define AL_CODEC_IP_OFFSET GENMASK(26, 25)
> +#define AL_CODEC_APB_MASK GENMASK(26, 0)
> +
> +#define AL_CODEC_MCU_BOOT_RESET_WAIT 2 /* in ms */
> +#define AL_CODEC_REG_ENABLE BIT(0)
> +#define AL_CODEC_REG_DISABLE 0
> +
> +/*
> + * struct codec_dma_buf - Allocated dma buffer
> + *
> + * @list: list head for buffer queue
> + * @paddr: physical address of the allcated DMA buffer
> + * @vaddr: virtual address of the allocated DMA buffer
> + * @size: Size of allocated dma memory
> + */
> +struct codec_dma_buf {
> +	void *vaddr;
> +	dma_addr_t paddr;
> +	u32 size;
> +	struct list_head list;
> +};
> +
> +struct mb_header {
> +	u64 start;
> +	u64 end;
> +} __packed;
> +
> +struct boot_header {
> +	u32 bh_version;
> +	u32 fw_version;
> +	char model[16];
> +	u64 vaddr_start;
> +	u64 vaddr_end;
> +	u64 vaddr_boot;
> +	struct mb_header h2m;
> +	struct mb_header m2h;
> +	u64 machine_id;
> +	/* fill by driver before fw boot */
> +	u64 ip_start;
> +	u64 ip_end;
> +	u64 mcu_clk_rate;
> +} __packed;
> +
> +static u32 al_common_read(struct al_codec_dev *codec, u32 offset)
> +{
> +	return readl(codec->regs + offset);
> +}
> +
> +static void al_common_write(struct al_codec_dev *codec, u32 offset, u32 =
val)
> +{
> +	writel(val, codec->regs + offset);
> +}
> +
> +static void al_common_trigger_mcu_irq(void *arg)
> +{
> +	struct al_codec_dev *codec =3D arg;
> +
> +	al_common_write(codec, AL_CODEC_MCU_IRQ, BIT(0));
> +}
> +
> +static inline void al_common_reset(struct al_codec_dev *codec)
> +{
> +	/* reset ip */
> +	al_common_write(codec, AL_CODEC_RESET, AL_CODEC_REG_ENABLE);
> +
> +	/* reset and stop mcu */
> +	al_common_write(codec, AL_CODEC_MCU_CLK, AL_CODEC_REG_ENABLE);
> +	al_common_write(codec, AL_CODEC_MCU_RST, AL_CODEC_REG_ENABLE);
> +	/* time to reset the mct */
> +	mdelay(AL_CODEC_MCU_BOOT_RESET_WAIT);
> +	al_common_write(codec, AL_CODEC_MCU_CLK, AL_CODEC_REG_DISABLE);
> +
> +	al_common_write(codec, AL_CODEC_MCU_IRQ, AL_CODEC_REG_DISABLE);
> +	al_common_write(codec, AL_CODEC_MCU_IRQ_MASK, AL_CODEC_REG_DISABLE);
> +
> +	mdelay(AL_CODEC_MCU_BOOT_RESET_WAIT * 5);
> +	al_common_write(codec, AL_CODEC_MCU_RST, AL_CODEC_REG_DISABLE);
> +}
> +
> +/**
> + * Check if physical address exceeds 40-bit addressing capability
> + * @param phys_addr: Physical address to check
> + * @return: Offset beyond (40-bit - 1) limit, or 0 if within limit
> + */
> +static inline uint64_t get_phys_offset(uint64_t paddr)
> +{
> +	const uint64_t ADDR_40BIT_MAX =3D GENMASK(39, 0); // (2^40 - 1)
> +
> +	return (paddr > ADDR_40BIT_MAX) ? (paddr - ADDR_40BIT_MAX - 1) : 0;
> +}
> +
> +static int al_common_setup_hw_regs(struct al_codec_dev *codec)
> +{
> +	u64 reg_start, reg_end;
> +	dma_addr_t boot_addr;
> +	u64 fw_offset;
> +	unsigned int id;
> +
> +	id =3D al_common_read(codec, AL_CODEC_UID);
> +
> +	if (id !=3D AL_CODEC_UID_ID) {
> +		al_codec_err(codec,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 "bad device id, expected 0x%08x, got 0x%08x"=
,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 AL_CODEC_UID_ID, id);
> +		return -ENODEV;
> +	}
> +
> +	fw_offset =3D get_phys_offset(codec->firmware.phys);
> +	boot_addr =3D codec->firmware.phys + codec->firmware.bin_data.offset -
> +		=C2=A0=C2=A0=C2=A0 fw_offset;
> +
> +	/* Reset MCU step */
> +	al_common_reset(codec);
> +
> +	/* Configure the MCU*/
> +	al_common_write(codec, AL_CODEC_IRQ_MASK, AL_CODEC_IRQ_MCU_2_CPU);
> +	/* Set Instruction and data offset */
> +	al_common_write(codec, AL_CODEC_INST_OFFSET_HI,
> +			upper_32_bits(fw_offset));
> +	al_common_write(codec, AL_CODEC_INST_OFFSET_LO,
> +			lower_32_bits(fw_offset));
> +	al_common_write(codec, AL_CODEC_DATA_OFFSET_HI,
> +			upper_32_bits(fw_offset));
> +	al_common_write(codec, AL_CODEC_DATA_OFFSET_LO,
> +			lower_32_bits(fw_offset));
> +
> +	reg_start =3D codec->regs_info->start;
> +	reg_end =3D reg_start + resource_size(codec->regs_info);
> +	al_common_write(codec, AL_CODEC_MCU_IP_START_ADDR_HI,
> +			upper_32_bits(reg_start));
> +	al_common_write(codec, AL_CODEC_MCU_IP_START_ADDR_LO,
> +			lower_32_bits(reg_start));
> +	al_common_write(codec, AL_CODEC_MCU_IP_END_ADDR_HI,
> +			upper_32_bits(reg_end));
> +	al_common_write(codec, AL_CODEC_MCU_IP_END_ADDR_HI,
> +			lower_32_bits(reg_end));
> +
> +	al_common_write(codec, AL_CODEC_MCU_PERIPH_ADDR_HI,
> +			upper_32_bits(codec->apb));
> +	al_common_write(codec, AL_CODEC_MCU_PERIPH_ADDR_LO,
> +			lower_32_bits(codec->apb));
> +
> +	al_common_write(codec, AL_CODEC_MCU_BOOT_ADDR_HI,
> +			upper_32_bits(boot_addr));
> +	al_common_write(codec, AL_CODEC_MCU_BOOT_ADDR_LO,
> +			lower_32_bits(boot_addr));
> +
> +	return 0;
> +}
> +
> +static void al_common_dma_buf_insert(struct al_codec_dev *codec,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 struct codec_dma_buf *buf)
> +{
> +	guard(mutex)(&codec->buf_lock);
> +	list_add(&buf->list, &codec->alloc_buffers);
> +}
> +
> +static void al_common_dma_buf_remove(struct al_codec_dev *codec,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 struct codec_dma_buf *buf)
> +{
> +	struct device *dev =3D &codec->pdev->dev;
> +
> +	guard(mutex)(&codec->buf_lock);
> +	dma_free_coherent(dev, buf->size, buf->vaddr, buf->paddr);
> +	list_del(&buf->list);
> +	kfree(buf);
> +}
> +
> +static struct codec_dma_buf *
> +al_common_dma_buf_lookup(struct al_codec_dev *codec, dma_addr_t buf_padd=
r)
> +{
> +	struct codec_dma_buf *buf =3D NULL;
> +
> +	guard(mutex)(&codec->buf_lock);
> +	list_for_each_entry(buf, &codec->alloc_buffers, list)
> +		if (likely(buf->paddr =3D=3D buf_paddr))
> +			break;
> +
> +	return list_entry_is_head(buf, &codec->alloc_buffers, list) ? NULL :
> +								=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 buf;
> +}
> +
> +static void al_common_dma_buf_cleanup(struct al_codec_dev *codec)
> +{
> +	struct device *dev =3D &codec->pdev->dev;
> +	struct codec_dma_buf *buf, *tmp;
> +
> +	guard(mutex)(&codec->buf_lock);
> +	list_for_each_entry_safe(buf, tmp, &codec->alloc_buffers, list) {
> +		dma_free_coherent(dev, buf->size, buf->vaddr, buf->paddr);
> +		list_del(&buf->list);
> +		kfree(buf);
> +	}
> +}
> +
> +static int al_common_setup_dma(struct al_codec_dev *codec)
> +{
> +	struct device *dev =3D &codec->pdev->dev;
> +	int ret;
> +
> +	/* setup dma memory mask */
> +	if (!dev->coherent_dma_mask) {
> +		ret =3D dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(64));
> +		if (ret) {
> +			al_codec_err(codec, "Failed to set dma mask %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
> +	/* Try to use reserved memory if we got one */
> +	ret =3D of_reserved_mem_device_init(dev);
> +	if (ret && ret !=3D ENODEV)
> +		dev_warn(dev, "No reserved memory, use cma instead\n");
> +
> +	return 0;
> +}
> +
> +void al_common_remove(struct al_codec_dev *codec)
> +{
> +	/* Cleanup allocated internal buffers used by the mcu*/
> +	al_common_dma_buf_cleanup(codec);
> +
> +	/* reset codecice */
> +	al_common_reset(codec);
> +	clk_disable_unprepare(codec->clk);
> +	/* Free the allocated memory for the firmware */
> +	dma_free_coherent(&codec->pdev->dev, codec->firmware.size,
> +			=C2=A0 codec->firmware.virt, codec->firmware.phys);
> +
> +	if (codec->firmware.firmware)
> +		release_firmware(codec->firmware.firmware);
> +}
> +
> +static void handle_alloc_memory_req(struct al_codec_dev *codec,
> +				=C2=A0=C2=A0=C2=A0 struct msg_itf_header *hdr)
> +{
> +	struct device *dev =3D &codec->pdev->dev;
> +	struct msg_itf_alloc_mem_req req;
> +	struct msg_itf_alloc_mem_reply_full reply =3D {
> +		.reply.phyAddr =3D 0,
> +		.hdr.type =3D MSG_ITF_TYPE_ALLOC_MEM_REPLY,
> +		.hdr.drv_ctx_hdl =3D hdr->drv_ctx_hdl,
> +		.hdr.drv_cmd_hdl =3D hdr->drv_cmd_hdl,
> +		.hdr.payload_len =3D sizeof(struct msg_itf_alloc_mem_reply),
> +	};
> +	struct codec_dma_buf *buf;
> +	int ret;
> +
> +	ret =3D al_common_get_data(codec, (char *)&req, hdr->payload_len);
> +	if (ret) {
> +		al_codec_err(codec, "Unable to get cma req %d", ret);
> +		return;
> +	}
> +
> +	buf =3D kmalloc(sizeof(*buf), GFP_KERNEL);
> +	if (!buf)
> +		goto send_reply;
> +
> +	buf->size =3D req.uSize;
> +	buf->vaddr =3D
> +		dma_alloc_coherent(dev, buf->size, &buf->paddr, GFP_KERNEL);
> +	if (!buf->vaddr) {
> +		dev_warn(dev, "Failed to allocate DMA buffer\n");
> +		goto send_reply;
> +	}
> +
> +	reply.reply.phyAddr =3D (u64)buf->paddr;
> +	al_common_dma_buf_insert(codec, buf);
> +
> +send_reply:
> +	ret =3D al_common_send(codec, &reply.hdr);
> +	if (ret) {
> +		al_codec_err(codec, "Unable to reply to cma alloc");
> +		al_common_dma_buf_remove(codec, buf);
> +	}
> +}
> +
> +static void handle_free_memory_req(struct al_codec_dev *codec,
> +				=C2=A0=C2=A0 struct msg_itf_header *hdr)
> +{
> +	struct msg_itf_free_mem_req req;
> +	struct msg_itf_free_mem_reply_full reply =3D {
> +		.hdr.type =3D MSG_ITF_TYPE_FREE_MEM_REPLY,
> +		.hdr.drv_ctx_hdl =3D hdr->drv_ctx_hdl,
> +		.hdr.drv_cmd_hdl =3D hdr->drv_cmd_hdl,
> +		.hdr.payload_len =3D sizeof(struct msg_itf_free_mem_reply),
> +		.reply.ret =3D -1,
> +	};
> +	struct codec_dma_buf *buf;
> +	int ret;
> +
> +	ret =3D al_common_get_data(codec, (char *)&req, hdr->payload_len);
> +	if (ret) {
> +		al_codec_err(codec, "Unable to put cma req");
> +		return;
> +	}
> +
> +	buf =3D al_common_dma_buf_lookup(codec, req.phyAddr);
> +	if (!buf) {
> +		al_codec_err(codec, "Unable to get dma handle for %p",
> +			=C2=A0=C2=A0=C2=A0=C2=A0 (void *)(long)req.phyAddr);
> +		reply.reply.ret =3D -EINVAL;
> +		goto send_reply;
> +	}
> +
> +	al_codec_dbg(codec, "Free memory %p, size %d",
> +		=C2=A0=C2=A0=C2=A0=C2=A0 (void *)(long)req.phyAddr, buf->size);
> +
> +	al_common_dma_buf_remove(codec, buf);
> +	reply.reply.ret =3D 0;
> +
> +send_reply:
> +	ret =3D al_common_send(codec, &reply.hdr);
> +	if (ret)
> +		al_codec_err(codec, "Unable to reply to cma free");
> +}
> +
> +static void handle_mcu_console_print(struct al_codec_dev *codec,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 struct msg_itf_header *hdr)
> +{
> +	struct msg_itf_write_req *req;
> +	int ret;
> +
> +	/* one more byte to be sure to have a zero terminated string */
> +	req =3D kzalloc(hdr->payload_len + 1, GFP_KERNEL);
> +	if (!req) {
> +		al_common_skip_data(codec, hdr->payload_len);
> +		al_codec_err(codec, "Unable to alloc memory");
> +		return;
> +	}
> +
> +	ret =3D al_codec_msg_get_data(&codec->mb_m2h, (char *)req,
> +				=C2=A0=C2=A0=C2=A0 hdr->payload_len);
> +	if (ret) {
> +		al_codec_err(codec, "Unable to get request");
> +		kfree(req);
> +		return;
> +	}
> +
> +	/* Print the mcu logs */
> +	al_mcu_dbg(codec, "%s", (char *)(req + 1));
> +	kfree(req);
> +}
> +
> +static void process_one_message(struct al_codec_dev *codec,
> +				struct msg_itf_header *hdr)
> +{
> +	switch (hdr->type) {
> +	case MSG_ITF_TYPE_ALLOC_MEM_REQ:
> +		handle_alloc_memory_req(codec, hdr);
> +		break;
> +	case MSG_ITF_TYPE_FREE_MEM_REQ:
> +		handle_free_memory_req(codec, hdr);
> +		break;
> +	case MSG_ITF_TYPE_WRITE_REQ:
> +		handle_mcu_console_print(codec, hdr);
> +		break;
> +	case MSG_ITF_TYPE_MCU_ALIVE:
> +		complete(&codec->completion);
> +		break;
> +	default:
> +		codec->process_msg_cb(codec->cb_arg, hdr);
> +		break;
> +	}
> +}
> +
> +static irqreturn_t al_common_irq_handler(int irq, void *data)
> +{
> +	struct al_codec_dev *codec =3D data;
> +	struct msg_itf_header hdr;
> +
> +	/* poll all messages */
> +	while (al_codec_msg_get_header(&codec->mb_m2h, &hdr) =3D=3D 0)
> +		process_one_message(codec, &hdr);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t al_common_hardirq_handler(int irq, void *data)
> +{
> +	struct al_codec_dev *codec =3D data;
> +
> +	if (al_common_read(codec, AL_CODEC_IRQ_STATUS_CLEAR) =3D=3D 0)
> +		return IRQ_NONE;
> +
> +	al_common_write(codec, AL_CODEC_IRQ_STATUS_CLEAR,
> +			AL_CODEC_IRQ_MCU_2_CPU);
> +
> +	return IRQ_WAKE_THREAD;
> +}
> +
> +static int al_common_start_fw(struct al_codec_dev *codec)
> +{
> +	/* Enable the MCU clock */
> +	al_common_write(codec, AL_CODEC_MCU_CLK, AL_CODEC_REG_ENABLE);
> +
> +	return !wait_for_completion_timeout(&codec->completion, 2 * HZ);
> +}
> +
> +static void al_common_copy_firmware_image(struct al_codec_dev *codec)
> +{
> +	const struct firmware *firmware =3D codec->firmware.firmware;
> +	u32 *virt =3D codec->firmware.virt;
> +
> +	/* copy the whole thing taking into account endianness */
> +	for (size_t i =3D 0; i < firmware->size / sizeof(u32); i++)
> +		virt[i] =3D le32_to_cpu(((__le32 *)firmware->data)[i]);
> +}
> +
> +static int al_common_read_firmware(struct al_codec_dev *codec, const cha=
r *name)
> +{
> +	struct device *dev =3D &codec->pdev->dev;
> +	const struct boot_header *bh;
> +	int err;
> +
> +	/* request_firmware prints error if it fails */
> +	err =3D request_firmware(&codec->firmware.firmware, name, dev);
> +	if (err < 0)
> +		return err;
> +
> +	bh =3D (struct boot_header *)codec->firmware.firmware->data;
> +	codec->firmware.size =3D bh->vaddr_end - bh->vaddr_start;
> +
> +	return 0;
> +}
> +
> +static int al_common_parse_firmware_image(struct al_codec_dev *codec)
> +{
> +	struct boot_header *bh =3D (void *)codec->firmware.virt;
> +
> +	if (bh->bh_version < AL_BOOT_VERSION(2, 0, 0) ||
> +	=C2=A0=C2=A0=C2=A0 bh->bh_version >=3D AL_BOOT_VERSION(3, 0, 0)) {
> +		al_codec_err(codec, "Unsupported firmware version");
> +		return -EINVAL;
> +	}
> +
> +	codec->firmware.bin_data.offset =3D bh->vaddr_boot - bh->vaddr_start;
> +	codec->firmware.bin_data.size =3D bh->vaddr_end - bh->vaddr_start;
> +
> +	codec->firmware.mb_h2m.offset =3D bh->h2m.start - bh->vaddr_start;
> +	codec->firmware.mb_h2m.size =3D bh->h2m.end - bh->h2m.start;
> +	codec->firmware.mb_m2h.offset =3D bh->m2h.start - bh->vaddr_start;
> +	codec->firmware.mb_m2h.size =3D bh->m2h.end - bh->m2h.start;
> +
> +	/* Override some data */
> +	bh->ip_start =3D codec->apb + AL_CODEC_IP_OFFSET;
> +	bh->ip_end =3D bh->ip_start + resource_size(codec->regs_info);
> +	bh->mcu_clk_rate =3D clk_get_rate(codec->clk);
> +
> +	al_codec_dbg(codec, "bh version=C2=A0=C2=A0=C2=A0=C2=A0 =3D 0x%08x", bh=
->bh_version);
> +	al_codec_dbg(codec, "fw version=C2=A0=C2=A0=C2=A0=C2=A0 =3D 0x%08x", bh=
->fw_version);
> +	al_codec_dbg(codec, "fw model=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D %=
s", bh->model);
> +	al_codec_dbg(codec, "vaddress start =3D 0x%016llx", bh->vaddr_start);
> +	al_codec_dbg(codec, "vaddress end=C2=A0=C2=A0 =3D 0x%016llx", bh->vaddr=
_end);
> +	al_codec_dbg(codec, "boot address=C2=A0=C2=A0 =3D 0x%016llx", bh->vaddr=
_boot);
> +	al_codec_dbg(codec, "machineid=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D %lld",=
 bh->machine_id);
> +	al_codec_dbg(codec, "periph address =3D 0x%016llx", codec->apb);
> +	al_codec_dbg(codec, "ip start=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 0=
x%016llx", bh->ip_start);
> +	al_codec_dbg(codec, "ip end=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 =3D 0x%016llx", bh->ip_end);
> +	al_codec_dbg(codec, "mcu clk	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D %llu", =
bh->mcu_clk_rate);
> +
> +	return 0;
> +}
> +
> +static int al_common_load_firmware_start(struct al_codec_dev *codec,
> +					 const char *name)
> +{
> +	struct device *dev =3D &codec->pdev->dev;
> +	dma_addr_t phys;
> +	size_t size;
> +	void *virt;
> +	int err;
> +
> +	if (codec->firmware.virt)
> +		return 0;
> +
> +	err =3D al_common_read_firmware(codec, name);
> +	if (err)
> +		return err;
> +
> +	size =3D codec->firmware.size;
> +
> +	virt =3D dma_alloc_coherent(dev, size, &phys, GFP_KERNEL);
> +	err =3D dma_mapping_error(dev, phys);
> +	if (err < 0)
> +		return err;
> +
> +	codec->firmware.virt =3D virt;
> +	codec->firmware.phys =3D phys;
> +
> +	al_common_copy_firmware_image(codec);
> +	err =3D al_common_parse_firmware_image(codec);
> +	if (err) {
> +		al_codec_err(codec, "failed to parse firmware image");
> +		goto cleanup;
> +	}
> +
> +	err =3D al_common_setup_hw_regs(codec);
> +	if (err) {
> +		al_codec_err(codec, "Unable to setup hw registers");
> +		goto cleanup;
> +	}
> +
> +	al_codec_mb_init(&codec->mb_h2m, virt + codec->firmware.mb_h2m.offset,
> +			 codec->firmware.mb_h2m.size, MB_IFT_MAGIC_H2M);
> +
> +	al_codec_mb_init(&codec->mb_m2h, virt + codec->firmware.mb_m2h.offset,
> +			 codec->firmware.mb_m2h.size, MB_IFT_MAGIC_M2H);
> +
> +	err =3D al_common_start_fw(codec);
> +	if (err) {
> +		al_codec_err(codec, "fw start has failed");
> +		goto cleanup;
> +	}
> +
> +	al_codec_dbg(codec, "mcu has boot successfully !");
> +	codec->fw_ready_cb(codec->cb_arg);
> +
> +	release_firmware(codec->firmware.firmware);
> +	codec->firmware.firmware =3D NULL;
> +
> +	return 0;
> +
> +cleanup:
> +	dma_free_coherent(dev, size, virt, phys);
> +
> +	return err;
> +}
> +
> +static u64 al_common_get_periph_addr(struct al_codec_dev *codec)
> +{
> +	struct resource *res;
> +
> +	res =3D platform_get_resource_byname(codec->pdev, IORESOURCE_MEM, "apb"=
);
> +	if (!res) {
> +		al_codec_err(codec, "Unable to find APB start address");
> +		return 0;
> +	}
> +
> +	if (res->start & AL_CODEC_APB_MASK) {
> +		al_codec_err(codec, "APB start address is invalid");
> +		return 0;
> +	}
> +
> +	return res->start;
> +}
> +
> +int al_common_probe(struct al_codec_dev *codec, const char *name)
> +{
> +	struct platform_device *pdev =3D codec->pdev;
> +	int irq;
> +	int ret;
> +
> +	mutex_init(&codec->buf_lock);
> +	INIT_LIST_HEAD(&codec->alloc_buffers);
> +	init_completion(&codec->completion);
> +
> +	/* setup dma memory */
> +	ret =3D al_common_setup_dma(codec);
> +	if (ret)
> +		return ret;
> +
> +	/* Hw registers */
> +	codec->regs_info =3D
> +		platform_get_resource_byname(pdev, IORESOURCE_MEM, "top");
> +	if (!codec->regs_info) {
> +		al_codec_err(codec, "regs resource missing from device tree");
> +		return -EINVAL;
> +	}
> +
> +	codec->regs =3D devm_ioremap_resource(&pdev->dev, codec->regs_info);
> +	if (!codec->regs) {
> +		al_codec_err(codec, "failed to map registers");
> +		return -ENOMEM;
> +	}
> +
> +	codec->apb =3D al_common_get_periph_addr(codec);
> +	if (!codec->apb)
> +		return -EINVAL;
> +
> +	/* The MCU has already default clock value */
> +	codec->clk =3D devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(codec->clk)) {
> +		al_codec_err(codec, "failed to get MCU core clock");
> +		return PTR_ERR(codec->clk);
> +	}
> +
> +	ret =3D clk_prepare_enable(codec->clk);
> +	if (ret) {
> +		al_codec_err(codec, "Cannot enable MCU clock: %d\n", ret);
> +		return ret;
> +	}
> +
> +	irq =3D platform_get_irq(pdev, 0);
> +	if (irq < 0) {
> +		al_codec_err(codec, "Failed to get IRQ");
> +		ret =3D -EINVAL;
> +		goto disable_clk;
> +	}
> +
> +	ret =3D devm_request_threaded_irq(&pdev->dev, irq,
> +					al_common_hardirq_handler,
> +					al_common_irq_handler, IRQF_SHARED,
> +					dev_name(&pdev->dev), codec);
> +	if (ret) {
> +		al_codec_err(codec, "Unable to register irq handler");
> +		goto disable_clk;
> +	}
> +
> +	/* ok so request the fw */
> +	ret =3D al_common_load_firmware_start(codec, name);
> +	if (ret) {
> +		al_codec_err(codec, "failed to load firmware : %s", name);
> +		goto disable_clk;
> +	}
> +
> +	return 0;
> +
> +disable_clk:
> +	clk_disable_unprepare(codec->clk);
> +
> +	return ret;
> +}
> +
> +int al_common_send(struct al_codec_dev *codec, struct msg_itf_header *hd=
r)
> +{
> +	return al_codec_msg_send(&codec->mb_h2m, hdr, al_common_trigger_mcu_irq=
,
> +				 codec);
> +}
> +
> +int al_common_send_req_reply(struct al_codec_dev *codec,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 struct list_head *cmd_list,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 struct msg_itf_header *hdr,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 struct al_common_mcu_req *req)
> +{
> +	struct al_codec_cmd *cmd =3D NULL;
> +	int ret;
> +
> +	hdr->drv_cmd_hdl =3D 0;
> +
> +	if (req->reply_size && req->reply) {
> +		cmd =3D al_codec_cmd_create(req->reply_size);
> +		if (!cmd)
> +			return -ENOMEM;
> +
> +		hdr->drv_cmd_hdl =3D al_virt_to_phys(cmd);
> +	}
> +
> +	hdr->drv_ctx_hdl =3D req->pCtx;
> +	hdr->type =3D req->req_type;
> +	hdr->payload_len =3D req->req_size;
> +
> +	/* Add the list to the cmd list */
> +	if (cmd)
> +		list_add(&cmd->list, cmd_list);
> +
> +	ret =3D al_common_send(codec, hdr);
> +	if (ret)
> +		goto remove_cmd;
> +
> +	al_codec_dbg(codec, "Send req to mcu %d : %ld ", req->req_type,
> +		=C2=A0=C2=A0=C2=A0=C2=A0 req->req_size);
> +
> +	if (!cmd)
> +		return 0;
> +
> +	ret =3D wait_for_completion_timeout(&cmd->done, 5 * HZ);
> +	if (ret <=3D 0) {
> +		al_codec_err(codec, "cmd %p has %d (%s)", cmd, ret,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 (ret =3D=3D 0) ? "failed" : "timedout");
> +		ret =3D -ETIMEDOUT;
> +		goto remove_cmd;
> +	}
> +
> +	ret =3D 0;
> +	memcpy(req->reply, cmd->reply, req->reply_size);
> +
> +remove_cmd:
> +
> +	if (cmd) {
> +		list_del(&cmd->list);
> +		al_codec_cmd_put(cmd);
> +	}
> +	return ret;
> +}
> +
> +bool al_common_mcu_is_alive(struct al_codec_dev *codec)
> +{
> +	static const struct msg_itf_header hdr =3D {
> +		.type =3D MSG_ITF_TYPE_MCU_ALIVE,
> +		.payload_len =3D 0,
> +	};
> +	int ret;
> +
> +	ret =3D al_common_send(codec, (struct msg_itf_header *)&hdr);
> +	if (ret)
> +		return false;
> +
> +	ret =3D wait_for_completion_timeout(&codec->completion, 5 * HZ);
> +	if (ret <=3D 0)
> +		return false;
> +
> +	return true;
> +}
> diff --git a/drivers/media/platform/allegro-dvt/al300/al_codec_common.h b=
/drivers/media/platform/allegro-dvt/al300/al_codec_common.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..2664ffb659a2e8a6a4cf86b51=
811119639f2bbef
> --- /dev/null
> +++ b/drivers/media/platform/allegro-dvt/al300/al_codec_common.h
> @@ -0,0 +1,251 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (c) 2025 Allegro DVT.
> + * Author: Yassine OUAISSA <yassine.ouaissa@allegrodvt.fr>
> + */
> +
> +#ifndef __AL_CODEC_COMMON__
> +#define __AL_CODEC_COMMON__
> +
> +#include <linux/cleanup.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <media/v4l2-device.h>
> +
> +#include "al_codec_dbgfs.h"
> +#include "al_codec_util.h"
> +
> +#define fh_to_ctx(ptr, type) container_of(ptr, type, fh)
> +
> +enum {
> +	MSG_ITF_TYPE_CREATE_INST_REQ =3D MSG_ITF_TYPE_NEXT_REQ,
> +	MSG_ITF_TYPE_DESTROY_INST_REQ,
> +	MSG_ITF_TYPE_PUSH_BITSTREAM_BUFFER_REQ,
> +	MSG_ITF_TYPE_PUT_DISPLAY_PICTURE_REQ,
> +	MSG_ITF_TYPE_FLUSH_REQ,
> +	MSG_ITF_TYPE_INFO_REQ,
> +	MSG_ITF_TYPE_CREATE_INST_REPLY =3D MSG_ITF_TYPE_NEXT_REPLY,
> +	MSG_ITF_TYPE_DESTROY_INST_REPLY,
> +	MSG_ITF_TYPE_PUSH_BITSTREAM_BUFFER_REPLY,
> +	MSG_ITF_TYPE_PUT_DISPLAY_PICTURE_REPLY,
> +	MSG_ITF_TYPE_FLUSH_REPLY,
> +	MSG_ITF_TYPE_INFO_REPLY,
> +	MSG_ITF_TYPE_EVT_ERROR =3D MSG_ITF_TYPE_NEXT_EVT,
> +};
> +
> +struct msg_itf_write_req {
> +	u32 fd;
> +	u32 len;
> +	/* payload follow */
> +} __packed;
> +DECLARE_FULL_REQ(msg_itf_write_req);
> +
> +struct msg_itf_free_mem_req {
> +	phys_addr_t phyAddr;

No camel please.

> +} __packed;

A bit off to have struct with a single fixes size member, was this wrapper
needed ?

> +DECLARE_FULL_REQ(msg_itf_free_mem_req);
> +
> +struct msg_itf_alloc_mem_req {
> +	u64 uSize;
> +} __packed;
> +DECLARE_FULL_REQ(msg_itf_alloc_mem_req);
> +
> +struct msg_itf_alloc_mem_reply {
> +	phys_addr_t phyAddr;
> +} __packed;
> +DECLARE_FULL_REPLY(msg_itf_alloc_mem_reply);
> +
> +struct msg_itf_free_mem_reply {
> +	s64 ret;
> +};
> +DECLARE_FULL_REPLY(msg_itf_free_mem_reply);
> +
> +struct msg_itf_create_codec_reply {
> +	phys_addr_t hCodec;

Same, no came. Usually we allow this only if it match a publicly available =
spec
(such as USB).

> +	s32 ret;
> +} __packed;
> +DECLARE_FULL_REPLY(msg_itf_create_codec_reply);
> +
> +struct msg_itf_destroy_codec_req {
> +	phys_addr_t hCodec;
> +} __packed;
> +DECLARE_FULL_REQ(msg_itf_destroy_codec_req);
> +
> +/*
> + * Note : no need to know the status of this request
> + * The codec should be destroyed, in case of the mcu
> + * hasn't received any request with the codec handler
> + */
> +struct msg_itf_destroy_codec_reply {
> +	u32 unused;
> +} __packed;
> +DECLARE_FULL_REPLY(msg_itf_destroy_codec_reply);
> +
> +struct al_buffer_meta {
> +	u64 timestamp;
> +	struct v4l2_timecode timecode;
> +	bool last;
> +};
> +
> +struct msg_itf_push_src_buf_req {
> +	phys_addr_t hCodec;
> +	phys_addr_t bufferHandle;
> +	phys_addr_t phyAddr;
> +	u64 size;
> +	struct al_buffer_meta meta;
> +} __packed;
> +DECLARE_FULL_REQ(msg_itf_push_src_buf_req);
> +
> +struct msg_itf_push_dst_buf_req {
> +	phys_addr_t hCodec;
> +	phys_addr_t bufferHandle;
> +	phys_addr_t phyAddr;
> +	u64 size;
> +} __packed;
> +DECLARE_FULL_REQ(msg_itf_push_dst_buf_req);
> +
> +struct msg_itf_push_buffer_req {
> +	phys_addr_t hCodec;
> +	phys_addr_t bufferHandle;
> +	phys_addr_t phyAddr;
> +	u64 size;
> +} __packed;
> +DECLARE_FULL_REQ(msg_itf_push_buffer_req);
> +
> +struct msg_itf_push_buffer_reply {
> +	s32 res;
> +} __packed;
> +DECLARE_FULL_REPLY(msg_itf_push_buffer_reply);
> +
> +struct msg_itf_info_req {
> +	u64 unused;
> +} __packed;
> +DECLARE_FULL_REQ(msg_itf_info_req);
> +
> +struct msg_itf_flush_req {
> +	phys_addr_t hCodec;
> +} __packed;
> +DECLARE_FULL_REQ(msg_itf_flush_req);
> +
> +struct msg_itf_flush_reply {
> +	int32_t unused;
> +} __packed;
> +DECLARE_FULL_REPLY(msg_itf_flush_reply);
> +
> +struct msg_itf_evt_error {
> +	uint32_t errno;
> +} __packed;
> +DECLARE_FULL_EVENT(msg_itf_evt_error);
> +
> +struct al_match_data {
> +	const char *fw_name;
> +};
> +
> +struct al_common_mcu_req {
> +	phys_addr_t pCtx;
> +	int req_type;
> +	size_t req_size;
> +	size_t reply_size;
> +	void *reply;
> +} __packed;
> +
> +struct al_firmware_section {
> +	u64 offset;
> +	size_t size;
> +};
> +
> +struct al_firmware {
> +	/* Firmware after it is read but not loaded */
> +	const struct firmware *firmware;
> +
> +	/* Raw firmware data */
> +	dma_addr_t phys;
> +	void *virt;
> +	size_t size;
> +
> +	/* Parsed firmware information */
> +	struct al_firmware_section bin_data;
> +	struct al_firmware_section mb_m2h;
> +	struct al_firmware_section mb_h2m;
> +};
> +
> +struct al_codec_dev {
> +	struct platform_device *pdev;
> +	struct v4l2_device v4l2_dev;
> +	struct v4l2_m2m_dev *m2m_dev;
> +	struct video_device video_dev;
> +
> +	/* Firmware */
> +	struct al_firmware firmware;
> +	dma_addr_t apb;
> +
> +	struct clk *clk;
> +	void __iomem *regs;
> +	struct resource *regs_info;
> +
> +	/* Mailbox structs */
> +	struct al_codec_mb mb_h2m;
> +	struct al_codec_mb mb_m2h;
> +
> +	/* list of buffers used by the MCU */
> +	struct list_head alloc_buffers;
> +	struct mutex buf_lock;
> +
> +	/* mutex protecting vb2_queue structure */
> +	struct mutex lock;
> +
> +	/* list of ctx (aka decoder) */
> +	struct mutex ctx_mlock;
> +	struct list_head ctx_q_list;
> +	struct al_codec_dbgfs dbgfs;
> +	u64 ctx_counter;
> +	bool init_done;
> +
> +	/* list of cap/out supported formats */
> +	struct list_head codec_q_list;
> +	struct al_codec_cmd *codec_info_cmd;
> +
> +	/* Command completion */
> +	struct completion completion;
> +	/* Resolution found completion */
> +	struct completion res_done;
> +
> +	/* callbacks set by client before common_probe */
> +	void *cb_arg;
> +	void (*process_msg_cb)(void *cb_arg, struct msg_itf_header *hdr);
> +	void (*fw_ready_cb)(void *cb_arg);
> +};
> +
> +static inline int al_common_get_header(struct al_codec_dev *codec,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct msg_itf_header *hdr)
> +{
> +	return al_codec_msg_get_header(&codec->mb_m2h, hdr);
> +}
> +
> +static inline int al_common_get_data(struct al_codec_dev *codec, char *d=
ata,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 int len)
> +{
> +	return al_codec_msg_get_data(&codec->mb_m2h, data, len);
> +}
> +
> +static inline int al_common_skip_data(struct al_codec_dev *codec, int le=
n)
> +{
> +	return al_common_get_data(codec, NULL, len);
> +}
> +
> +int al_common_send(struct al_codec_dev *codec, struct msg_itf_header *hd=
r);
> +int al_common_send_req_reply(struct al_codec_dev *codec,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 struct list_head *cmd_list,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 struct msg_itf_header *hdr,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 struct al_common_mcu_req *req);
> +bool al_common_mcu_is_alive(struct al_codec_dev *codec);
> +
> +int al_common_probe(struct al_codec_dev *codec, const char *name);
> +void al_common_remove(struct al_codec_dev *codec);
> +
> +#endif /*__AL_CODEC_COMMON__*/
> diff --git a/drivers/media/platform/allegro-dvt/al300/al_codec_dbgfs.c b/=
drivers/media/platform/allegro-dvt/al300/al_codec_dbgfs.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..9a9264d2aa22ebdc21945e429=
0c744491974b692
> --- /dev/null
> +++ b/drivers/media/platform/allegro-dvt/al300/al_codec_dbgfs.c
> @@ -0,0 +1,229 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2025 Allegro DVT.
> + * Author: Yassine OUAISSA <yassine.ouaissa@allegrodvt.fr>
> + */
> +
> +#include <linux/debugfs.h>
> +
> +#include "al_codec_dbgfs.h"
> +#include "al_vdec_drv.h"
> +#include "al_codec_util.h"
> +
> +static void al_vdec_dbgfs_get_format_type(struct al_dec_ctx *ctx, char *=
buf,
> +					=C2=A0 int *used, int total)
> +{
> +	struct al_frame *frame =3D &ctx->src;
> +	int curr_len;
> +
> +	switch (frame->fmt->pixelformat) {
> +	case V4L2_PIX_FMT_H264:
> +		curr_len =3D snprintf(buf + *used, total - *used,
> +				=C2=A0=C2=A0=C2=A0 "\toutput format: h264\n");
> +		break;
> +	case V4L2_PIX_FMT_HEVC:
> +		curr_len =3D snprintf(buf + *used, total - *used,
> +				=C2=A0=C2=A0=C2=A0 "\toutput format: hevc\n");
> +		break;
> +	case V4L2_PIX_FMT_JPEG:
> +		curr_len =3D snprintf(buf + *used, total - *used,
> +				=C2=A0=C2=A0=C2=A0 "\toutput format: jpeg\n");
> +		break;
> +	default:
> +		curr_len =3D snprintf(buf + *used, total - *used,
> +				=C2=A0=C2=A0=C2=A0 "\tunsupported output format: 0x%x\n",
> +				=C2=A0=C2=A0=C2=A0 frame->fmt->pixelformat);
> +	}
> +	*used +=3D curr_len;
> +	frame =3D &ctx->dst;
> +
> +	switch (frame->fmt->pixelformat) {
> +	case V4L2_PIX_FMT_NV12:
> +		curr_len =3D snprintf(buf + *used, total - *used,
> +				=C2=A0=C2=A0=C2=A0 "\tcapture format: NV12\n");
> +		break;
> +	case V4L2_PIX_FMT_NV16:
> +		curr_len =3D snprintf(buf + *used, total - *used,
> +				=C2=A0=C2=A0=C2=A0 "\tcapture format: NV16\n");
> +		break;
> +	case V4L2_PIX_FMT_P010:
> +		curr_len =3D snprintf(buf + *used, total - *used,
> +				=C2=A0=C2=A0=C2=A0 "\tcapture format: P010\n");
> +		break;
> +	case V4L2_PIX_FMT_YUV420:
> +		curr_len =3D snprintf(buf + *used, total - *used,
> +				=C2=A0=C2=A0=C2=A0 "\tcapture format: YUV420\n");
> +		break;
> +	case V4L2_PIX_FMT_YVU420:
> +		curr_len =3D snprintf(buf + *used, total - *used,
> +				=C2=A0=C2=A0=C2=A0 "\tcapture format: YVU420\n");
> +		break;
> +	default:
> +		curr_len =3D snprintf(buf + *used, total - *used,
> +				=C2=A0=C2=A0=C2=A0 "\tunsupported capture format: 0x%x\n",
> +				=C2=A0=C2=A0=C2=A0 frame->fmt->pixelformat);
> +	}
> +	*used +=3D curr_len;
> +}
> +
> +static void al_vdec_dbgfs_get_help(char *buf, int *used, int total)
> +{
> +	int curr_len;
> +
> +	curr_len =3D snprintf(buf + *used, total - *used,
> +			=C2=A0=C2=A0=C2=A0 "help: (1: echo -'info' > dec 2: cat dec)\n");
> +	*used +=3D curr_len;
> +
> +	curr_len =3D snprintf(buf + *used, total - *used,
> +			=C2=A0=C2=A0=C2=A0 "\t-picinfo: get resolution\n");
> +	*used +=3D curr_len;
> +
> +	curr_len =3D snprintf(buf + *used, total - *used,
> +			=C2=A0=C2=A0=C2=A0 "\t-format: get output & capture queue format\n");
> +	*used +=3D curr_len;
> +}
> +
> +static ssize_t al_vdec_dbgfs_write(struct file *filp, const char __user =
*ubuf,
> +				=C2=A0=C2=A0 size_t count, loff_t *ppos)
> +{
> +	struct al_codec_dev *codec =3D filp->private_data;
> +	struct al_codec_dbgfs *dbgfs =3D &codec->dbgfs;
> +
> +	mutex_lock(&dbgfs->lock);
> +	dbgfs->size =3D simple_write_to_buffer(dbgfs->buf, sizeof(dbgfs->buf),
> +					=C2=A0=C2=A0=C2=A0=C2=A0 ppos, ubuf, count);
> +	mutex_unlock(&dbgfs->lock);
> +	if (dbgfs->size > 0)
> +		return count;
> +
> +	return dbgfs->size;
> +}
> +
> +static ssize_t al_vdec_dbgfs_read(struct file *filp, char __user *ubuf,
> +				=C2=A0 size_t count, loff_t *ppos)
> +{
> +	struct al_codec_dev *codec =3D filp->private_data;
> +	struct al_codec_dbgfs *dbgfs =3D &codec->dbgfs;
> +	struct al_codec_dbgfs_ctx *dbgfs_ctx;
> +	struct al_dec_ctx *ctx;
> +	struct al_frame *frame;
> +	int total_len =3D 200 * (dbgfs->ctx_count =3D=3D 0 ? 1 : dbgfs->ctx_cou=
nt);
> +	int used_len =3D 0, curr_len, ret;
> +	bool dbgfs_index[AL_VDEC_DBGFS_MAX] =3D { 0 };
> +	char *buf =3D kmalloc(total_len, GFP_KERNEL);
> +
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	if (strstr(dbgfs->buf, "-help") || dbgfs->size =3D=3D 1) {

This parser is a bit weak at first sight. I didn't get introduce to this de=
bug
fs interface, is there some doc ?

> +		al_vdec_dbgfs_get_help(buf, &used_len, total_len);
> +		goto read_buffer;
> +	}
> +
> +	if (strstr(dbgfs->buf, "-picinfo"))
> +		dbgfs_index[AL_VDEC_DBGFS_PICINFO] =3D true;
> +
> +	if (strstr(dbgfs->buf, "-format"))
> +		dbgfs_index[AL_VDEC_DBGFS_FORMAT] =3D true;
> +
> +	mutex_lock(&dbgfs->lock);
> +	list_for_each_entry(dbgfs_ctx, &dbgfs->dbgfs_head, node) {
> +		ctx =3D dbgfs_ctx->dec_ctx;
> +		frame =3D &ctx->src;
> +
> +		curr_len =3D snprintf(buf + used_len, total_len - used_len,
> +				=C2=A0=C2=A0=C2=A0 "inst[%lld]:\n ", ctx->id);
> +		used_len +=3D curr_len;
> +
> +		if (dbgfs_index[AL_VDEC_DBGFS_PICINFO]) {
> +			curr_len =3D snprintf(buf + used_len,
> +					=C2=A0=C2=A0=C2=A0 total_len - used_len,
> +					=C2=A0=C2=A0=C2=A0 "\tOUTPUT: %dx%d\n", frame->width,
> +					=C2=A0=C2=A0=C2=A0 frame->height);
> +			used_len +=3D curr_len;
> +			frame =3D &ctx->dst;
> +
> +			curr_len =3D snprintf(buf + used_len,
> +					=C2=A0=C2=A0=C2=A0 total_len - used_len,
> +					=C2=A0=C2=A0=C2=A0 "\tCAPTURE: %dx%d\n", frame->width,
> +					=C2=A0=C2=A0=C2=A0 frame->height);
> +			used_len +=3D curr_len;
> +		}
> +
> +		if (dbgfs_index[AL_VDEC_DBGFS_FORMAT])
> +			al_vdec_dbgfs_get_format_type(ctx, buf, &used_len,
> +						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 total_len);
> +	}
> +	mutex_unlock(&dbgfs->lock);
> +read_buffer:
> +	ret =3D simple_read_from_buffer(ubuf, count, ppos, buf, used_len);
> +	kfree(buf);
> +	return ret;
> +}
> +
> +static const struct file_operations vdec_fops =3D {
> +	.open =3D simple_open,
> +	.write =3D al_vdec_dbgfs_write,
> +	.read =3D al_vdec_dbgfs_read,
> +};
> +
> +void al_codec_dbgfs_create(struct al_dec_ctx *ctx)
> +{
> +	struct al_codec_dbgfs_ctx *dbgfs_ctx;
> +	struct al_codec_dev *codec =3D ctx->codec;
> +
> +	dbgfs_ctx =3D kzalloc(sizeof(*dbgfs_ctx), GFP_KERNEL);
> +	if (!dbgfs_ctx)
> +		return;
> +
> +	list_add_tail(&dbgfs_ctx->node, &codec->dbgfs.dbgfs_head);
> +
> +	codec->dbgfs.ctx_count++;
> +
> +	dbgfs_ctx->ctx_id =3D ctx->id;
> +	dbgfs_ctx->dec_ctx =3D ctx;
> +}
> +
> +void al_codec_dbgfs_remove(struct al_codec_dev *codec, int ctx_id)
> +{
> +	struct al_codec_dbgfs_ctx *dbgfs_ctx;
> +
> +	list_for_each_entry(dbgfs_ctx, &codec->dbgfs.dbgfs_head, node) {
> +		if (dbgfs_ctx->ctx_id =3D=3D ctx_id) {
> +			codec->dbgfs.ctx_count--;
> +			list_del(&dbgfs_ctx->node);
> +			kfree(dbgfs_ctx);
> +			return;
> +		}
> +	}
> +}
> +
> +static void al_codec_dbgfs_vdec_init(struct al_codec_dev *codec)
> +{
> +	struct dentry *vcodec_root;
> +
> +	codec->dbgfs.vcodec_root =3D debugfs_create_dir("al-vdec", NULL);
> +	if (IS_ERR(codec->dbgfs.vcodec_root))
> +		dev_err(&codec->pdev->dev, "create al-vdec dir err:%ld\n",
> +			PTR_ERR(codec->dbgfs.vcodec_root));
> +
> +	vcodec_root =3D codec->dbgfs.vcodec_root;
> +	debugfs_create_x32("al_v4l2_dbg_level", 0644, vcodec_root,
> +			=C2=A0=C2=A0 &al_v4l2_dbg_level);
> +	debugfs_create_x32("al_codec_dbg", 0644, vcodec_root, &al_codec_dbg);
> +
> +	codec->dbgfs.ctx_count =3D 0;
> +	INIT_LIST_HEAD(&codec->dbgfs.dbgfs_head);
> +	debugfs_create_file("vdec", 0200, vcodec_root, codec, &vdec_fops);
> +	mutex_init(&codec->dbgfs.lock);
> +}
> +
> +void al_codec_dbgfs_init(void *codec)
> +{
> +	al_codec_dbgfs_vdec_init(codec);
> +}
> +
> +void al_codec_dbgfs_deinit(struct al_codec_dbgfs *dbgfs)
> +{
> +	debugfs_remove_recursive(dbgfs->vcodec_root);
> +}
> diff --git a/drivers/media/platform/allegro-dvt/al300/al_codec_dbgfs.h b/=
drivers/media/platform/allegro-dvt/al300/al_codec_dbgfs.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..0f205e50530822371203126d1=
d3632f8429a6de9
> --- /dev/null
> +++ b/drivers/media/platform/allegro-dvt/al300/al_codec_dbgfs.h
> @@ -0,0 +1,71 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (c) 2025 Allegro DVT.
> + * Author: Yassine OUAISSA <yassine.ouaissa@allegrodvt.fr>
> + */
> +
> +#ifndef __AL_CODEC_DBGFS_H__
> +#define __AL_CODEC_DBGFS_H__
> +
> +struct al_codec_dev;
> +struct al_dec_ctx;
> +
> +/*
> + * enum al_vdec_dbgfs_log_index=C2=A0 - used to get different debug info=
rmation
> + */
> +enum al_vdec_dbgfs_log_index {
> +	AL_VDEC_DBGFS_PICINFO,
> +	AL_VDEC_DBGFS_FORMAT,
> +	AL_VDEC_DBGFS_MAX,
> +};
> +
> +/**
> + * struct al_codec_dbgfs_ctx=C2=A0 - debugfs information for each contex=
t
> + * @node:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list node for each inst
> + * @dec_ctx:	struct al_dec_ctx
> + * @ctx_id:=C2=A0=C2=A0=C2=A0=C2=A0 index of the context that the same w=
ith ctx->id
> + */
> +struct al_codec_dbgfs_ctx {
> +	struct list_head node;
> +	struct al_dec_ctx *dec_ctx;
> +	int ctx_id;
> +};
> +
> +/**
> + * struct al_codec_dbgfs=C2=A0 - dbgfs information
> + * @dbgfs_head:=C2=A0 list head used to link each context
> + * @vcodec_root: codec dbgfs entry
> + * @lock:	 lock used to protect dbgfs_buf
> + * @buf:	 dbgfs buf used to store dbgfs cmd
> + * @size:	 dbgfs buffer size
> + * @ctx_count:=C2=A0=C2=A0 the count of total context
> + */
> +struct al_codec_dbgfs {
> +	struct list_head dbgfs_head;
> +	struct dentry *vcodec_root;
> +	struct mutex lock;
> +	char buf[1024];
> +	int size;
> +	int ctx_count;
> +};
> +
> +#if defined(CONFIG_DEBUG_FS)
> +void al_codec_dbgfs_create(struct al_dec_ctx *ctx);
> +void al_codec_dbgfs_remove(struct al_codec_dev *codec, int ctx_id);
> +void al_codec_dbgfs_init(void *codec);
> +void al_codec_dbgfs_deinit(struct al_codec_dbgfs *dbgfs);
> +#else
> +static inline void al_codec_dbgfs_create(struct al_dec_ctx *ctx)
> +{
> +}
> +static inline void al_codec_dbgfs_remove(struct al_codec_dev *codec, int=
 ctx_id)
> +{
> +}
> +static inline void al_codec_dbgfs_init(void *codec)
> +{
> +}
> +static inline void al_codec_dbgfs_deinit(struct al_codec_dbgfs *dbgfs)
> +{
> +}
> +#endif /* CONFIG_DEBUG_FS */
> +#endif /* __AL_CODEC_DBGFS_H__ */
> diff --git a/drivers/media/platform/allegro-dvt/al300/al_codec_util.c b/d=
rivers/media/platform/allegro-dvt/al300/al_codec_util.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..f59fedae0491f9384052b80f9=
bc19a22a3efe2a3
> --- /dev/null
> +++ b/drivers/media/platform/allegro-dvt/al300/al_codec_util.c
> @@ -0,0 +1,180 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Mailbox communication utilities for command creation
> + * and message exchange with the MCU
> + *
> + * Copyright (c) 2025 Allegro DVT.
> + * Author: Yassine OUAISSA <yassine.ouaissa@allegrodvt.fr>
> + */
> +
> +#include <asm-generic/errno.h>
> +#include <linux/errno.h>
> +#include <linux/jiffies.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/string.h>
> +
> +#include "al_codec_util.h"
> +
> +#if defined(CONFIG_DEBUG_FS)
> +/* Log level */
> +int al_v4l2_dbg_level;
> +int al_codec_dbg;
> +#endif
> +
> +static int al_get_used_space(struct al_codec_mb *mb)
> +{
> +	u32 head =3D mb->hdr->head;
> +	u32 tail =3D mb->hdr->tail;
> +
> +	return head >=3D tail ? head - tail : mb->size - (tail - head);
> +}
> +
> +static int al_get_free_space(struct al_codec_mb *mb)
> +{
> +	return mb->size - al_get_used_space(mb) - 1;
> +}
> +
> +static int al_has_enough_space(struct al_codec_mb *mb, int len)
> +{
> +	return al_get_free_space(mb) >=3D len;
> +}
> +
> +static inline void al_copy_to_mb(struct al_codec_mb *mb, char *data, int=
 len)
> +{
> +	u32 head =3D mb->hdr->head;
> +	int copy_len =3D min(mb->size - head, (unsigned int)len);
> +	int copied_len =3D len;
> +
> +	memcpy(&mb->data[head], data, copy_len);
> +	len -=3D copy_len;
> +	if (len)
> +		memcpy(&mb->data[0], &data[copy_len], len);
> +
> +	/* Make sure that all messages are written before updating the head */
> +	dma_wmb();
> +	mb->hdr->head =3D (head + copied_len) % mb->size;
> +	/* Make sure that the head is updated in DDR instead of cache */
> +	dma_wmb();
> +}
> +
> +static inline void al_copy_from_mb(struct al_codec_mb *mb, char *data, i=
nt len)
> +{
> +	u32 tail =3D mb->hdr->tail;
> +	int copy_len =3D min(mb->size - tail, (unsigned int)len);
> +	int copied_len =3D len;
> +
> +	if (!data)
> +		goto update_tail;
> +
> +	memcpy(data, &mb->data[tail], copy_len);
> +	len -=3D copy_len;
> +	if (len)
> +		memcpy(&data[copy_len], &mb->data[0], len);
> +
> +update_tail:
> +	mb->hdr->tail =3D (tail + copied_len) % mb->size;
> +	/* Make sure that the head is updated in DDR instead of cache */
> +	dma_wmb();
> +}
> +
> +static int al_codec_mb_send(struct al_codec_mb *mb, char *data, int len)
> +{
> +	if (!al_has_enough_space(mb, len))
> +		return -ENOMEM;
> +
> +	al_copy_to_mb(mb, data, len);
> +
> +	return 0;
> +}
> +
> +static int al_codec_mb_receive(struct al_codec_mb *mb, char *data, int l=
en)
> +{
> +	if (al_get_used_space(mb) < len)
> +		return -ENOMEM;
> +
> +	al_copy_from_mb(mb, data, len);
> +
> +	return 0;
> +}
> +
> +void al_codec_mb_init(struct al_codec_mb *mb, char *addr, int size, u32 =
magic)
> +{
> +	mb->hdr =3D (struct al_mb_itf *)addr;
> +	mb->hdr->magic =3D magic;
> +	mb->hdr->version =3D MB_IFT_VERSION;
> +	mb->hdr->head =3D 0;
> +	mb->hdr->tail =3D 0;
> +	mb->data =3D addr + sizeof(struct al_mb_itf);
> +	mb->size =3D size - sizeof(struct al_mb_itf);
> +	mutex_init(&mb->lock);
> +}
> +
> +int al_codec_msg_get_header(struct al_codec_mb *mb, struct msg_itf_heade=
r *hdr)
> +{
> +	return al_codec_mb_receive(mb, (char *)hdr, sizeof(*hdr));
> +}
> +
> +int al_codec_msg_get_data(struct al_codec_mb *mb, char *data, int len)
> +{
> +	return al_codec_mb_receive(mb, data, len);
> +}
> +
> +int al_codec_msg_send(struct al_codec_mb *mb, struct msg_itf_header *hdr=
,
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void (*trigger)(void *), void *trigger_=
arg)
> +{
> +	const unsigned long timeout =3D jiffies + HZ;
> +	int ret;
> +
> +	guard(mutex)(&mb->lock);
> +	do {
> +		if (time_after(jiffies, timeout))
> +			return -ETIMEDOUT;
> +
> +		ret =3D al_codec_mb_send(mb, (char *)hdr,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hdr->payload_len +
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sizeof(struct msg_itf_header))=
;
> +
> +	} while (ret);
> +
> +	trigger(trigger_arg);
> +
> +	return 0;
> +}
> +
> +static void al_codec_cmd_cleanup(struct kref *ref)
> +{
> +	struct al_codec_cmd *cmd =3D container_of(ref, typeof(*cmd), refcount);
> +
> +	kfree(cmd->reply);
> +	kfree(cmd);
> +}
> +
> +void al_codec_cmd_put(struct al_codec_cmd *cmd)
> +{
> +	if (WARN_ON(!cmd))
> +		return;
> +
> +	kref_put(&cmd->refcount, al_codec_cmd_cleanup);
> +}
> +
> +struct al_codec_cmd *al_codec_cmd_create(int reply_size)
> +{
> +	struct al_codec_cmd *cmd;
> +
> +	cmd =3D kmalloc(sizeof(*cmd), GFP_KERNEL);
> +	if (!cmd)
> +		return NULL;
> +
> +	cmd->reply =3D kmalloc(reply_size, GFP_KERNEL);
> +	if (!cmd->reply) {
> +		kfree(cmd);
> +		return NULL;
> +	}
> +
> +	kref_init(&cmd->refcount);
> +	cmd->reply_size =3D reply_size;
> +	init_completion(&cmd->done);
> +
> +	return cmd;
> +}
> diff --git a/drivers/media/platform/allegro-dvt/al300/al_codec_util.h b/d=
rivers/media/platform/allegro-dvt/al300/al_codec_util.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..e5541dd11c4cc46b6ef0ea22d=
10d08c85fa6c75a
> --- /dev/null
> +++ b/drivers/media/platform/allegro-dvt/al300/al_codec_util.h
> @@ -0,0 +1,194 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (c) 2025 Allegro DVT.
> + * Author: Yassine OUAISSA <yassine.ouaissa@allegrodvt.fr>
> + */
> +
> +#ifndef __AL_CODEC_UTIL__
> +#define __AL_CODEC_UTIL__
> +
> +#include <linux/mutex.h>
> +#include <linux/types.h>
> +#include <linux/v4l2-common.h>
> +
> +#define MB_IFT_MAGIC_H2M 0xabcd1230
> +#define MB_IFT_MAGIC_M2H 0xabcd1231
> +#define MB_IFT_VERSION 0x00010000
> +
> +#define MAJOR_SHIFT 20
> +#define MAJOR_MASK 0xfff
> +#define MINOR_SHIFT 8
> +#define MINOR_MASK 0xfff
> +#define PATCH_SHIFT 0
> +#define PATCH_MASK 0xff
> +
> +/*
> + * AL_BOOT_VERSION() - Version format 32-bit, 12 bits for the major,
> + * the same for minor, 8bits for the patch
> + */
> +#define AL_BOOT_VERSION(major, minor, patch)=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 \
> +	((((major) & MAJOR_MASK) << MAJOR_SHIFT) | \
> +	 (((minor) & MINOR_MASK) << MINOR_SHIFT) | \
> +	 (((patch) & PATCH_MASK) << PATCH_SHIFT))
> +
> +#define al_phys_to_virt(x) ((void *)(uintptr_t)x)
> +#define al_virt_to_phys(x) ((phys_addr_t)(uintptr_t)x)
> +
> +#define DECLARE_FULL_REQ(s)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> +	struct s##_full {=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> +		struct msg_itf_header hdr; \
> +		struct s req;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 \
> +	} __packed
> +
> +#define DECLARE_FULL_REPLY(s)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> +	struct s##_full {=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> +		struct msg_itf_header hdr; \
> +		struct s reply;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 \
> +	} __packed
> +
> +#define DECLARE_FULL_EVENT(s)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> +	struct s##_full {=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> +		struct msg_itf_header hdr; \
> +		struct s event;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 \
> +	} __packed
> +
> +struct al_mb_itf {
> +	u32 magic;
> +	u32 version;
> +	u32 head;
> +	u32 tail;
> +} __packed;
> +
> +struct al_codec_mb {
> +	struct al_mb_itf *hdr;
> +	struct mutex lock;
> +	char *data;
> +	int size;
> +};
> +
> +struct al_codec_cmd {
> +	struct kref refcount;
> +	struct list_head list;
> +	struct completion done;
> +	int reply_size;
> +	void *reply;
> +};
> +
> +#define al_codec_err(codec, fmt, args...)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> +	dev_err(&(codec)->pdev->dev, "[ALG_CODEC][ERROR] %s():%d: " fmt "\n", \
> +		__func__, __LINE__, ##args)
> +
> +#define al_v4l2_err(codec, fmt, args...)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> +	dev_err(&(codec)->pdev->dev, "[ALG_V4L2][ERROR] %s():%d: " fmt "\n", \
> +		__func__, __LINE__, ##args)
> +
> +#if defined(CONFIG_DEBUG_FS)
> +/* Log level */
> +extern int al_v4l2_dbg_level;
> +extern int al_codec_dbg;
> +
> +/* V4L2 logs */
> +#define al_v4l2_dbg(codec, level, fmt, args...)=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> +	do {=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 \
> +		if (al_v4l2_dbg_level >=3D level)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> +			dev_dbg(&(codec)->pdev->dev,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 \
> +				"[ALG_V4L2] level=3D%d %s(),%d: " fmt "\n", \
> +				level, __func__, __LINE__, ##args);=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 \
> +	} while (0)
> +
> +/* Codec logs */
> +#define al_codec_dbg(codec, fmt, args...)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 \
> +	do {=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 \
> +		if (al_codec_dbg)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> +			dev_dbg(&(codec)->pdev->dev,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 \
> +				"[ALG_CODEC] %s(),%d: " fmt "\n", __func__, \
> +				__LINE__, ##args);=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> +	} while (0)
> +
> +#define al_mcu_dbg(codec, fmt, args...)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 \
> +	do {=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 \
> +		if (al_codec_dbg)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> +			dev_dbg(&(codec)->pdev->dev,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 \
> +				"[ALG_MCU] %s(),%d: " fmt "\n", __func__, \
> +				__LINE__, ##args);=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 \
> +	} while (0)
> +
> +#else
> +
> +#define al_v4l2_dbg(codec, level, fmt, args...)=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 \
> +	do {=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> +		(void)level;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 \
> +		dev_dbg(&(codec)->pdev->dev, "[ALG_V4L2]: " fmt "\n", ##args); \
> +	} while (0)
> +
> +#define al_codec_dbg(codec, fmt, args...) \
> +	dev_dbg(&(codec)->pdev->dev, "[ALG_CODEC]: " fmt "\n", ##args)
> +
> +#define al_mcu_dbg(codec, fmt, args...) \
> +	dev_dbg(&(codec)->pdev->dev, "[ALG_MCU]: " fmt "\n", ##args)
> +
> +#endif
> +
> +#define MSG_ITF_TYPE_LIMIT BIT(10)
> +
> +/* Message types host <-> mcu */
> +enum {
> +	MSG_ITF_TYPE_MCU_ALIVE =3D 0,
> +	MSG_ITF_TYPE_WRITE_REQ =3D 2,
> +	MSG_ITF_TYPE_FIRST_REQ =3D 1024,
> +	MSG_ITF_TYPE_NEXT_REQ,
> +	MSG_ITF_TYPE_FIRST_REPLY =3D 2048,
> +	MSG_ITF_TYPE_NEXT_REPLY,
> +	MSG_ITF_TYPE_ALLOC_MEM_REQ =3D 3072,
> +	MSG_ITF_TYPE_FREE_MEM_REQ,
> +	MSG_ITF_TYPE_ALLOC_MEM_REPLY =3D 4096,
> +	MSG_ITF_TYPE_FREE_MEM_REPLY,
> +	MSG_ITF_TYPE_FIRST_EVT =3D 5120,
> +	MSG_ITF_TYPE_NEXT_EVT =3D MSG_ITF_TYPE_FIRST_EVT
> +};
> +
> +struct msg_itf_header {
> +	u64 drv_ctx_hdl;
> +	u64 drv_cmd_hdl;
> +	u16 type;
> +	u16 payload_len;
> +	u16 padding[2];
> +} __packed;
> +
> +void al_codec_mb_init(struct al_codec_mb *mb, char *addr, int size, u32 =
magic);
> +int al_codec_msg_get_header(struct al_codec_mb *mb, struct msg_itf_heade=
r *hdr);
> +int al_codec_msg_get_data(struct al_codec_mb *mb, char *data, int len);
> +int al_codec_msg_send(struct al_codec_mb *mb, struct msg_itf_header *hdr=
,
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void (*trigger)(void *), void *trigger_=
arg);
> +
> +static inline bool is_type_reply(uint16_t type)
> +{
> +	return type >=3D MSG_ITF_TYPE_FIRST_REPLY &&
> +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 type < MSG_ITF_TYPE_FIRST_REPLY + =
MSG_ITF_TYPE_LIMIT;
> +}
> +
> +static inline bool is_type_event(uint16_t type)
> +{
> +	return type >=3D MSG_ITF_TYPE_FIRST_EVT &&
> +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 type < MSG_ITF_TYPE_FIRST_EVT + MS=
G_ITF_TYPE_LIMIT;
> +}
> +
> +void al_codec_cmd_put(struct al_codec_cmd *cmd);
> +
> +struct al_codec_cmd *al_codec_cmd_create(int reply_size);
> +
> +static inline struct al_codec_cmd *al_codec_cmd_get(struct list_head *cm=
d_list,
> +						=C2=A0=C2=A0=C2=A0 uint64_t hdl)
> +{
> +	struct al_codec_cmd *cmd =3D NULL;
> +
> +	list_for_each_entry(cmd, cmd_list, list) {
> +		if (likely(cmd =3D=3D al_phys_to_virt(hdl))) {
> +			kref_get(&cmd->refcount);
> +			break;
> +		}
> +	}
> +	return list_entry_is_head(cmd, cmd_list, list) ? NULL : cmd;
> +}
> +
> +#endif /* __AL_CODEC_UTIL__ */
> diff --git a/drivers/media/platform/allegro-dvt/al300/al_vdec_drv.c b/dri=
vers/media/platform/allegro-dvt/al300/al_vdec_drv.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..eed037b7e8ca920c26928a6ca=
4cf012f0fed0563
> --- /dev/null
> +++ b/drivers/media/platform/allegro-dvt/al300/al_vdec_drv.c
> @@ -0,0 +1,1515 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2025 Allegro DVT.
> + * Author: Yassine OUAISSA <yassine.ouaissa@allegrodvt.fr>
> + *
> + * Allegro DVT stateful video decoder driver for the IP Gen 3
> + */
> +
> +#include <asm-generic/errno-base.h>
> +#include <linux/list.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/string.h>
> +#include <linux/v4l2-controls.h>
> +#include <media/v4l2-device.h>
> +#include <media/v4l2-event.h>
> +#include <media/v4l2-ioctl.h>
> +#include <media/videobuf2-dma-contig.h>
> +
> +#include "al_codec_dbgfs.h"
> +#include "al_vdec_drv.h"
> +
> +/* default decoder params */
> +#define DECODER_WIDTH_DEFAULT 640
> +#define DECODER_HEIGHT_DEFAULT 480
> +#define DECODER_WIDTH_MAX 3840
> +#define DECODER_HEIGHT_MAX 2160
> +#define DECODER_WIDTH_MIN 16
> +#define DECODER_HEIGHT_MIN 16
> +#define DEC_REQ_TIMEOUT msecs_to_jiffies(1000)
> +#define DEC_RES_EVT_TIMEOUT DEC_REQ_TIMEOUT
> +
> +/* Supported formats */
> +static const struct al_fmt al_src_formats[] =3D {
> +	{
> +		.pixelformat =3D V4L2_PIX_FMT_H264,
> +		.bpp =3D 20,

bpp applied to H.264 ? Isn't zero a better value ?

> +	},
> +	{
> +		.pixelformat =3D V4L2_PIX_FMT_HEVC,
> +		.bpp =3D 20,
> +	},
> +	{
> +		.pixelformat =3D V4L2_PIX_FMT_JPEG,
> +		.bpp =3D 8,
> +	}
> +};
> +
> +static const struct al_fmt al_dst_formats[] =3D {
> +	{
> +		.pixelformat =3D V4L2_PIX_FMT_NV12,
> +		.bpp =3D 12,
> +	},
> +	{
> +		.pixelformat =3D V4L2_PIX_FMT_P010,
> +		.bpp =3D 12,
> +	},
> +	{
> +		.pixelformat =3D V4L2_PIX_FMT_NV16,
> +		.bpp =3D 16,
> +	},
> +	{
> +		.pixelformat =3D V4L2_PIX_FMT_YUV420, /* YUV 4:2:0 */
> +		.bpp =3D 12,
> +	},
> +	{
> +		.pixelformat =3D V4L2_PIX_FMT_YVU420, /* YVU 4:2:0 */
> +		.bpp =3D 12,
> +	},
> +};
> +
> +/* Default format */
> +static const struct al_frame al_default_fmt =3D {
> +
> +	.width =3D DECODER_WIDTH_DEFAULT,
> +	.height =3D DECODER_HEIGHT_DEFAULT,
> +	.bytesperline =3D DECODER_WIDTH_MAX * 4,
> +	.sizeimage =3D DECODER_WIDTH_DEFAULT * DECODER_HEIGHT_DEFAULT * 4,
> +	.nbuffers =3D 1,
> +	.fmt =3D &al_dst_formats[0],
> +	.field =3D V4L2_FIELD_NONE,
> +	.colorspace =3D V4L2_COLORSPACE_REC709,
> +	.ycbcr_enc =3D V4L2_YCBCR_ENC_DEFAULT,
> +	.quantization =3D V4L2_QUANTIZATION_DEFAULT,
> +	.xfer_func =3D V4L2_XFER_FUNC_DEFAULT
> +};
> +
> +static struct al_frame *al_get_frame(struct al_dec_ctx *ctx,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 enum v4l2_buf_type type)
> +{
> +	if (WARN_ON(!ctx))
> +		return ERR_PTR(-EINVAL);
> +
> +	if (type =3D=3D V4L2_BUF_TYPE_VIDEO_OUTPUT)
> +		return &ctx->src;
> +	else if (type =3D=3D V4L2_BUF_TYPE_VIDEO_CAPTURE)
> +		return &ctx->dst;
> +
> +	al_v4l2_err(ctx->codec, "Unsupported type (%d)", type);
> +
> +	return ERR_PTR(-EINVAL);
> +}
> +
> +static const struct al_fmt *al_find_fmt(u32 pixelformat)
> +{
> +	const struct al_fmt *fmt;
> +	unsigned int i;
> +
> +	/* check if the pixelformat exist in the src formats list */
> +	for (i =3D 0; i < ARRAY_SIZE(al_src_formats); i++) {
> +		fmt =3D &al_src_formats[i];
> +		if (fmt->pixelformat =3D=3D pixelformat)
> +			return fmt;
> +	}
> +
> +	/* check if the pixelformat exist in the dst formats list */
> +	for (i =3D 0; i < ARRAY_SIZE(al_dst_formats); i++) {
> +		fmt =3D &al_dst_formats[i];
> +		if (fmt->pixelformat =3D=3D pixelformat)
> +			return fmt;
> +	}
> +
> +	return NULL;
> +}
> +
> +static int dec_fw_create_decoder(struct al_dec_ctx *ctx)
> +{
> +	struct msg_itf_create_decoder_req_full req;
> +	struct msg_itf_create_codec_reply reply;
> +	const struct al_frame *frame =3D &ctx->src;
> +	struct al_common_mcu_req mreq =3D {
> +		.pCtx =3D al_virt_to_phys(ctx),
> +		.req_type =3D MSG_ITF_TYPE_CREATE_INST_REQ,
> +		.req_size =3D sizeof(req.req),
> +		.reply_size =3D sizeof(reply),
> +		.reply =3D &reply,
> +	};
> +	int ret;
> +
> +	if (ctx->hDec) {
> +		al_v4l2_dbg(ctx->codec, 3, "fw decoder already exist\n");
> +		return 0;
> +	}
> +
> +	req.req.codec =3D frame->fmt->pixelformat;
> +
> +	ret =3D al_common_send_req_reply(ctx->codec, &ctx->cmd_q_list, &req.hdr=
,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &mreq);
> +
> +	if (!ret && !reply.ret)
> +		ctx->hDec =3D reply.hCodec;
> +	else if (reply.ret)
> +		ret =3D -ENODEV;
> +
> +	return ret;
> +}
> +
> +static void dec_fw_destroy_decoder(struct al_dec_ctx *ctx)
> +{
> +	struct msg_itf_destroy_codec_req_full req;
> +	struct msg_itf_destroy_codec_reply reply;
> +	struct al_common_mcu_req mreq =3D {
> +		.req_type =3D MSG_ITF_TYPE_DESTROY_INST_REQ,
> +		.pCtx =3D al_virt_to_phys(ctx),
> +		.req_size =3D sizeof(req.req),
> +		.reply_size =3D sizeof(reply),
> +		.reply =3D &reply,
> +	};
> +	int ret;
> +
> +	if (WARN(!ctx->hDec, "NULL Decoder to destroy !"))
> +		return;
> +
> +	al_v4l2_dbg(ctx->codec, 3, "Destroy decoder %lld ", ctx->hDec);
> +
> +	req.req.hCodec =3D ctx->hDec;
> +
> +	ret =3D al_common_send_req_reply(ctx->codec, &ctx->cmd_q_list, &req.hdr=
,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &mreq);
> +
> +	if (!ret)
> +		ctx->hDec =3D 0;
> +}
> +
> +static int al_dec_fw_push_frame_buf(struct al_dec_ctx *ctx,
> +				=C2=A0=C2=A0=C2=A0 struct vb2_v4l2_buffer *vbuf)
> +{
> +	struct msg_itf_push_dst_buf_req_full req;
> +	struct v4l2_m2m_buffer *m2m_buf;
> +	struct al_common_mcu_req mreq =3D {
> +		.req_type =3D MSG_ITF_TYPE_PUT_DISPLAY_PICTURE_REQ,
> +		.pCtx =3D al_virt_to_phys(ctx),
> +		.req_size =3D sizeof(req.req),
> +	};
> +	int ret;
> +
> +	if (WARN(!vbuf, "NULL frame Buffer to push!!"))
> +		return -EINVAL;
> +
> +	m2m_buf =3D container_of(vbuf, struct v4l2_m2m_buffer, vb);
> +	req.req.hCodec =3D ctx->hDec;
> +	req.req.bufferHandle =3D al_virt_to_phys(m2m_buf);
> +	req.req.phyAddr =3D vb2_dma_contig_plane_dma_addr(&vbuf->vb2_buf, 0);
> +	req.req.size =3D vb2_plane_size(&vbuf->vb2_buf, 0);
> +
> +	ret =3D al_common_send_req_reply(ctx->codec, &ctx->cmd_q_list, &req.hdr=
,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &mreq);
> +	if (ret)
> +		al_v4l2_err(ctx->codec, "Failed to push frame buffer %p %d",
> +			=C2=A0=C2=A0=C2=A0 m2m_buf, ret);
> +
> +	return ret;
> +}
> +
> +static int al_dec_fw_push_bitstream_buf(struct al_dec_ctx *ctx,
> +					struct vb2_v4l2_buffer *vbuf)
> +{
> +	struct msg_itf_push_src_buf_req_full req;
> +	struct v4l2_m2m_buffer *m2m_buf;
> +	struct al_common_mcu_req mreq =3D {
> +		.req_type =3D MSG_ITF_TYPE_PUSH_BITSTREAM_BUFFER_REQ,
> +		.pCtx =3D al_virt_to_phys(ctx),
> +		.req_size =3D sizeof(req.req),
> +	};
> +	int ret;
> +
> +	if (WARN(!vbuf, "NULL Buffer to push!!"))
> +		return -EINVAL;
> +
> +	m2m_buf =3D container_of(vbuf, struct v4l2_m2m_buffer, vb);
> +	req.req.hCodec =3D ctx->hDec;
> +	req.req.bufferHandle =3D al_virt_to_phys(m2m_buf);
> +	req.req.phyAddr =3D vb2_dma_contig_plane_dma_addr(&vbuf->vb2_buf, 0);
> +	req.req.size =3D vb2_plane_size(&vbuf->vb2_buf, 0);
> +
> +	/* Fill the v4l2 metadata*/
> +	req.req.meta.timestamp =3D vbuf->vb2_buf.timestamp;
> +	req.req.meta.timecode =3D vbuf->timecode;
> +	req.req.meta.last =3D vbuf->flags & V4L2_BUF_FLAG_LAST;
> +
> +	ret =3D al_common_send_req_reply(ctx->codec, &ctx->cmd_q_list, &req.hdr=
,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &mreq);
> +	if (ret)
> +		al_v4l2_err(ctx->codec, "Failed to push bitstream buffer %p %d",
> +			=C2=A0=C2=A0=C2=A0 m2m_buf, ret);
> +
> +	return ret;
> +}
> +
> +static int dec_fw_flush_req(struct al_dec_ctx *ctx)
> +{
> +	struct msg_itf_flush_req_full req;
> +	struct msg_itf_flush_reply reply;
> +	struct al_common_mcu_req mreq =3D {
> +		.req_type =3D MSG_ITF_TYPE_FLUSH_REQ,
> +		.pCtx =3D al_virt_to_phys(ctx),
> +		.req_size =3D sizeof(req.req),
> +		.reply_size =3D sizeof(reply),
> +		.reply =3D &reply,
> +	};
> +	int ret;
> +
> +	req.req.hCodec =3D ctx->hDec;
> +
> +	ret =3D al_common_send_req_reply(ctx->codec, &ctx->cmd_q_list, &req.hdr=
,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &mreq);
> +
> +	if (ret)
> +		al_v4l2_err(ctx->codec, "Failed to flush the decoder %d", ret);
> +
> +	return ret;
> +}
> +
> +static struct vb2_v4l2_buffer *al_dec_dequeue_buf(struct al_dec_ctx *ctx=
,
> +						=C2=A0 uint64_t hdl,
> +						=C2=A0 struct list_head *buffer_list)
> +{
> +	struct v4l2_m2m_buffer *buf, *tmp;
> +	struct vb2_v4l2_buffer *ret =3D NULL;
> +
> +	guard(mutex)(&ctx->buf_q_mlock);
> +	list_for_each_entry_safe(buf, tmp, buffer_list, list) {
> +		if (buf =3D=3D al_phys_to_virt(hdl)) {
> +			list_del(&buf->list);
> +			ret =3D &buf->vb;
> +			break;
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static struct vb2_v4l2_buffer *al_dec_dequeue_src_buf(struct al_dec_ctx =
*ctx,
> +						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t hdl)
> +{
> +	return al_dec_dequeue_buf(ctx, hdl, &ctx->stream_q_list);
> +}
> +
> +static struct vb2_v4l2_buffer *al_dec_dequeue_dst_buf(struct al_dec_ctx =
*ctx,
> +						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t hdl)
> +{
> +	return al_dec_dequeue_buf(ctx, hdl, &ctx->frame_q_list);
> +}
> +
> +static void al_ctx_cleanup(struct kref *ref)
> +{
> +	struct al_dec_ctx *ctx =3D container_of(ref, struct al_dec_ctx, refcoun=
t);
> +
> +	kfree(ctx);
> +}
> +
> +static struct al_dec_ctx *al_ctx_get(struct al_codec_dev *codec, uint64_=
t hdl)
> +{
> +	struct al_dec_ctx *ctx;
> +	struct al_dec_ctx *ret =3D NULL;
> +
> +	guard(mutex)(&codec->ctx_mlock);
> +	list_for_each_entry(ctx, &codec->ctx_q_list, list) {
> +		if (ctx =3D=3D al_phys_to_virt(hdl)) {
> +			kref_get(&ctx->refcount);
> +			ret =3D ctx;
> +			break;
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static void al_ctx_put(struct al_dec_ctx *ctx)
> +{
> +	kref_put(&ctx->refcount, al_ctx_cleanup);
> +}
> +
> +static int al_dec_start_streaming(struct vb2_queue *q, unsigned int coun=
t)
> +{
> +	struct al_dec_ctx *ctx =3D vb2_get_drv_priv(q);
> +	struct al_codec_dev *codec =3D ctx->codec;
> +
> +	v4l2_m2m_update_start_streaming_state(ctx->fh.m2m_ctx, q);
> +
> +	if (V4L2_TYPE_IS_OUTPUT(q->type)) {
> +		struct v4l2_m2m_buffer *buf;
> +		int ret;
> +
> +		if (list_empty(&ctx->stream_q_list)) {
> +			al_v4l2_err(codec, "Empty stream list.");
> +			return -EINVAL;
> +		}
> +
> +		if (!al_common_mcu_is_alive(codec)) {
> +			al_v4l2_err(codec, "Unable to ping the mcu");
> +			return -ENODEV;
> +		}
> +
> +		ret =3D dec_fw_create_decoder(ctx);
> +		if (ret) {
> +			al_v4l2_err(codec, "Unable to create the fw decoder %d",
> +				=C2=A0=C2=A0=C2=A0 ret);
> +			return ret;
> +		}
> +
> +		/* Get the first vid-out queued buffer */
> +		buf =3D list_first_entry(&ctx->stream_q_list,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct v4l2_m2m_buffer, list);
> +
> +		if (al_dec_fw_push_bitstream_buf(ctx, &buf->vb)) {
> +			al_v4l2_err(codec,
> +				=C2=A0=C2=A0=C2=A0 "Unable to push the bitstream buffer");
> +			return -EINVAL;
> +		}
> +
> +		/* Wait until the mcu detect the resolution of the stream */
> +		ret =3D wait_for_completion_timeout(&ctx->res_done,
> +						=C2=A0 DEC_RES_EVT_TIMEOUT);
> +		if (!ret) {
> +			al_v4l2_err(codec, "unsupported stream");
> +			ctx->aborting =3D true;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static void al_dec_stop_streaming_cap(struct al_dec_ctx *ctx)
> +{
> +	struct vb2_v4l2_buffer *vbuf;
> +	struct v4l2_m2m_buffer *entry, *tmp;
> +
> +	mutex_lock(&ctx->buf_q_mlock);
> +	if (!list_empty(&ctx->frame_q_list))
> +		list_for_each_entry_safe(entry, tmp, &ctx->frame_q_list, list) {
> +			list_del(&entry->list);
> +			vbuf =3D &entry->vb;
> +			vb2_set_plane_payload(&vbuf->vb2_buf, 0, 0);
> +			v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_ERROR);
> +		}
> +	mutex_unlock(&ctx->buf_q_mlock);
> +
> +	while (v4l2_m2m_num_dst_bufs_ready(ctx->fh.m2m_ctx)) {
> +		vbuf =3D v4l2_m2m_dst_buf_remove(ctx->fh.m2m_ctx);
> +		if (vbuf) {
> +			vb2_set_plane_payload(&vbuf->vb2_buf, 0, 0);
> +			v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_ERROR);
> +		}
> +	}
> +
> +	v4l2_m2m_mark_stopped(ctx->fh.m2m_ctx);
> +}
> +
> +static void al_dec_stop_streaming_out(struct al_dec_ctx *ctx)
> +{
> +	struct vb2_v4l2_buffer *vbuf;
> +	struct v4l2_m2m_buffer *entry, *tmp;
> +
> +	mutex_lock(&ctx->buf_q_mlock);
> +	if (!list_empty(&ctx->stream_q_list))
> +		list_for_each_entry_safe(entry, tmp, &ctx->stream_q_list,
> +					 list) {
> +			list_del(&entry->list);
> +			v4l2_m2m_buf_done(&entry->vb, VB2_BUF_STATE_ERROR);
> +		}
> +	mutex_unlock(&ctx->buf_q_mlock);
> +
> +	if (v4l2_m2m_num_src_bufs_ready(ctx->fh.m2m_ctx)) {
> +		while ((vbuf =3D v4l2_m2m_src_buf_remove(ctx->fh.m2m_ctx)))
> +			if (vbuf->vb2_buf.state =3D=3D VB2_BUF_STATE_ACTIVE)
> +				v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_ERROR);
> +	}
> +
> +	dec_fw_destroy_decoder(ctx);
> +}
> +
> +static void al_dec_stop_streaming(struct vb2_queue *q)
> +{
> +	struct al_dec_ctx *ctx =3D vb2_get_drv_priv(q);
> +
> +	v4l2_m2m_update_stop_streaming_state(ctx->fh.m2m_ctx, q);
> +
> +	/* Releasing the dst and src buffers */
> +	ctx->stopped =3D true;
> +
> +	if (V4L2_TYPE_IS_OUTPUT(q->type))
> +		al_dec_stop_streaming_out(ctx);
> +	else
> +		al_dec_stop_streaming_cap(ctx);
> +}
> +
> +static int al_dec_queue_setup(struct vb2_queue *vq, unsigned int *nbuffe=
rs,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int *nplanes, unsigned int si=
zes[],
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct device *alloc_devs[])
> +{
> +	struct al_dec_ctx *ctx =3D vb2_get_drv_priv(vq);
> +	struct al_frame *format =3D al_get_frame(ctx, vq->type);
> +
> +	if (IS_ERR(format)) {
> +		al_v4l2_err(ctx->codec, "Invalid format %p", format);
> +		return PTR_ERR(format);
> +	}
> +
> +	if (*nplanes)
> +		return ((sizes[0] < format->sizeimage) ? -EINVAL : 0);
> +
> +	/* update queue num buffers */
> +	format->nbuffers =3D max(*nbuffers, format->nbuffers);
> +
> +	*nplanes =3D 1;
> +	sizes[0] =3D format->sizeimage;
> +	*nbuffers =3D format->nbuffers;
> +
> +	al_v4l2_dbg(ctx->codec, 2, "%s: Get %d buffers of size %d each ",
> +		=C2=A0=C2=A0=C2=A0 (vq->type =3D=3D V4L2_BUF_TYPE_VIDEO_OUTPUT) ? "OUT=
" : "CAP",
> +		=C2=A0=C2=A0=C2=A0 *nbuffers, sizes[0]);
> +
> +	return 0;
> +}
> +
> +static int al_dec_buf_prepare(struct vb2_buffer *vb)
> +{
> +	struct al_dec_ctx *ctx =3D vb2_get_drv_priv(vb->vb2_queue);
> +	struct vb2_v4l2_buffer *vbuf =3D to_vb2_v4l2_buffer(vb);
> +
> +	if (ctx->aborting)
> +		return -EINVAL;
> +
> +	if (V4L2_TYPE_IS_CAPTURE(vb->type)) {
> +		if (vbuf->field =3D=3D V4L2_FIELD_ANY)
> +			vbuf->field =3D V4L2_FIELD_NONE;
> +		if (vbuf->field !=3D V4L2_FIELD_NONE)
> +			return -EINVAL;
> +	}
> +
> +	al_v4l2_dbg(ctx->codec, 3, "%s : Buffer (%p) prepared ",
> +		=C2=A0=C2=A0=C2=A0 (V4L2_TYPE_IS_OUTPUT(vb->type) ? "OUT" : "CAP"), vb=
uf);
> +
> +	return 0;
> +}
> +
> +static inline void al_dec_fill_bitstream(struct al_dec_ctx *ctx)
> +{
> +	struct vb2_v4l2_buffer *src_buf;
> +	struct v4l2_m2m_buffer *m2m_buf;
> +	struct vb2_queue *src_vq;
> +
> +	lockdep_assert_held(&ctx->buf_q_mlock);
> +
> +	if (v4l2_m2m_num_src_bufs_ready(ctx->fh.m2m_ctx) > 0) {
> +		src_buf =3D v4l2_m2m_next_src_buf(ctx->fh.m2m_ctx);
> +		if (!src_buf)
> +			return;
> +
> +		/* Dump empty buffers */
> +		if (!vb2_get_plane_payload(&src_buf->vb2_buf, 0)) {
> +			src_buf =3D v4l2_m2m_src_buf_remove(ctx->fh.m2m_ctx);
> +			v4l2_m2m_buf_done(src_buf, VB2_BUF_STATE_DONE);
> +			return;
> +		}
> +
> +		src_vq =3D v4l2_m2m_get_src_vq(ctx->fh.m2m_ctx);
> +		src_buf =3D v4l2_m2m_src_buf_remove(ctx->fh.m2m_ctx);
> +
> +		if (src_buf) {
> +			src_buf->sequence =3D ctx->osequence++;
> +
> +			if (vb2_is_streaming(src_vq) &&
> +			=C2=A0=C2=A0=C2=A0 al_dec_fw_push_bitstream_buf(ctx, src_buf)) {
> +				v4l2_m2m_buf_done(src_buf, VB2_BUF_STATE_ERROR);
> +				return;
> +			}
> +
> +			m2m_buf =3D container_of(src_buf, struct v4l2_m2m_buffer,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vb);
> +			list_add_tail(&m2m_buf->list, &ctx->stream_q_list);
> +		}
> +	}
> +}
> +
> +static void al_dec_buf_queue(struct vb2_buffer *vb)
> +{
> +	struct al_dec_ctx *ctx =3D vb2_get_drv_priv(vb->vb2_queue);
> +	struct vb2_v4l2_buffer *vbuf =3D to_vb2_v4l2_buffer(vb);
> +
> +	v4l2_m2m_buf_queue(ctx->fh.m2m_ctx, vbuf);
> +
> +	if (V4L2_TYPE_IS_OUTPUT(vb->type)) {
> +		mutex_lock(&ctx->buf_q_mlock);
> +		al_dec_fill_bitstream(ctx);
> +		mutex_unlock(&ctx->buf_q_mlock);
> +	}
> +
> +	al_v4l2_dbg(ctx->codec, 3, "%s queued (%p) - (%d)",
> +		=C2=A0=C2=A0=C2=A0 V4L2_TYPE_IS_OUTPUT(vb->type) ? "OUT" : "CAP", vbuf=
,
> +		=C2=A0=C2=A0=C2=A0 vb->num_planes);
> +}
> +
> +static const struct vb2_ops dec_queue_ops =3D {
> +	.queue_setup =3D al_dec_queue_setup,
> +	.buf_prepare =3D al_dec_buf_prepare,
> +	.buf_queue =3D al_dec_buf_queue,
> +	.start_streaming =3D al_dec_start_streaming,
> +	.stop_streaming =3D al_dec_stop_streaming,
> +	.wait_prepare =3D vb2_ops_wait_prepare,
> +	.wait_finish =3D vb2_ops_wait_finish,
> +};
> +
> +static int al_dec_queue_init(void *priv, struct vb2_queue *src_vq,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 struct vb2_queue *dst_vq)
> +{
> +	struct al_dec_ctx *ctx =3D priv;
> +	struct al_codec_dev *codec =3D ctx->codec;
> +	int ret;
> +
> +	src_vq->dev =3D &codec->pdev->dev;
> +	src_vq->type =3D V4L2_BUF_TYPE_VIDEO_OUTPUT;
> +	src_vq->io_modes =3D VB2_MMAP | VB2_DMABUF;
> +	src_vq->non_coherent_mem =3D false;
> +	src_vq->dma_attrs |=3D DMA_ATTR_FORCE_CONTIGUOUS;

I don't think you need that with the dma contig ops. And if someone integra=
te an
IOMMU, this will get in the way.

> +	src_vq->mem_ops =3D &vb2_dma_contig_memops;
> +	src_vq->drv_priv =3D ctx;
> +	src_vq->timestamp_flags =3D V4L2_BUF_FLAG_TIMESTAMP_COPY;
> +	src_vq->ops =3D &dec_queue_ops;
> +	src_vq->buf_struct_size =3D sizeof(struct v4l2_m2m_buffer);
> +	src_vq->lock =3D &ctx->codec->lock;
> +	ret =3D vb2_queue_init(src_vq);
> +	if (ret)
> +		return ret;
> +
> +	dst_vq->dev =3D &codec->pdev->dev;
> +	dst_vq->type =3D V4L2_BUF_TYPE_VIDEO_CAPTURE;
> +	dst_vq->io_modes =3D VB2_MMAP | VB2_DMABUF;
> +	dst_vq->non_coherent_mem =3D false;
> +	dst_vq->dma_attrs |=3D DMA_ATTR_FORCE_CONTIGUOUS;
> +	dst_vq->mem_ops =3D &vb2_dma_contig_memops;
> +	dst_vq->drv_priv =3D ctx;
> +	dst_vq->timestamp_flags =3D V4L2_BUF_FLAG_TIMESTAMP_COPY;
> +	dst_vq->ops =3D &dec_queue_ops;
> +	dst_vq->buf_struct_size =3D sizeof(struct v4l2_m2m_buffer);
> +	dst_vq->lock =3D &ctx->codec->lock;
> +	ret =3D vb2_queue_init(dst_vq);
> +	if (ret) {
> +		vb2_queue_release(src_vq);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int al_dec_querycap(struct file *file, void *fh,
> +			=C2=A0=C2=A0 struct v4l2_capability *cap)
> +{
> +	struct al_codec_dev *codec =3D video_drvdata(file);
> +
> +	strscpy(cap->driver, KBUILD_MODNAME, sizeof(cap->driver));
> +	strscpy(cap->card, "Allegro DVT Video Decoder", sizeof(cap->card));
> +	snprintf(cap->bus_info, sizeof(cap->bus_info), "platform:%s",
> +		 dev_name(&codec->pdev->dev));
> +
> +	return 0;
> +}
> +
> +static int al_dec_enum_fmt(struct file *file, void *fh, struct v4l2_fmtd=
esc *f)
> +{
> +	const struct al_fmt *fmt;
> +
> +	if (f->type !=3D V4L2_BUF_TYPE_VIDEO_OUTPUT &&
> +	=C2=A0=C2=A0=C2=A0 f->type !=3D V4L2_BUF_TYPE_VIDEO_CAPTURE)
> +		return -EINVAL;
> +
> +	if (V4L2_TYPE_IS_OUTPUT(f->type)) {
> +		if (f->index >=3D ARRAY_SIZE(al_src_formats))
> +			return -EINVAL;
> +
> +		fmt =3D &al_src_formats[f->index];
> +	} else {
> +		if (f->index >=3D ARRAY_SIZE(al_dst_formats))
> +			return -EINVAL;
> +
> +		fmt =3D &al_dst_formats[f->index];
> +	}
> +
> +	f->pixelformat =3D fmt->pixelformat;
> +	return 0;
> +}
> +
> +static int al_dec_try_fmt(struct file *file, void *fh, struct v4l2_forma=
t *f)
> +{
> +	struct al_dec_ctx *ctx =3D fh_to_ctx(fh, struct al_dec_ctx);
> +	struct v4l2_pix_format *pix =3D &f->fmt.pix;
> +	struct al_frame *pix_fmt;
> +
> +	pix_fmt =3D al_get_frame(ctx, f->type);
> +	if (IS_ERR(pix_fmt)) {
> +		al_v4l2_err(ctx->codec, "Invalid frame (%p)", pix_fmt);
> +		return PTR_ERR(pix_fmt);
> +	}
> +
> +	pix_fmt->fmt =3D al_find_fmt(pix->pixelformat);
> +	if (!pix_fmt->fmt) {
> +		al_v4l2_err(ctx->codec, "Unknown format 0x%x",
> +			=C2=A0=C2=A0=C2=A0 pix->pixelformat);
> +		return -EINVAL;
> +	}
> +	pix->field =3D V4L2_FIELD_NONE;
> +	pix->width =3D clamp_t(__u32, pix->width, DECODER_WIDTH_MIN,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 DECODER_WIDTH_MAX);
> +	pix->height =3D clamp_t(__u32, pix->height, DECODER_HEIGHT_MIN,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DECODER_HEIGHT_MAX);
> +
> +	pix->bytesperline =3D pix->width;
> +	pix->sizeimage =3D (pix->width * pix->height * pix_fmt->fmt->bpp) / 8;

Please, use v4l2_apply_frmsize_constraints() from v4l2-common, and aremove =
hand
made alignement, bytesperline and sizeimage calculation. Check other driver=
s for
example, you can integrate the struct v4l2_fmtdesc to you static table abov=
e.

> +
> +	if (V4L2_TYPE_IS_CAPTURE(f->type))
> +		if (pix->sizeimage < pix_fmt->sizeimage)
> +			pix->sizeimage =3D pix_fmt->sizeimage;
> +
> +	al_v4l2_dbg(
> +		ctx->codec, 3,
> +		"%s : width (%d) , height (%d), bytesperline (%d), sizeimage (%d) ",
> +		(f->type =3D=3D V4L2_BUF_TYPE_VIDEO_CAPTURE) ? "CAP" : "OUT",
> +		pix->width, pix->height, pix->bytesperline, pix->sizeimage);

There is also logging of the VIDOC_S_FMT output, that seems redundant, remo=
ve.

	echo 0xff  > /sys/class/video4linux2/videoN/dev_debug

> +
> +	return 0;
> +}
> +
> +static int al_dec_g_fmt(struct file *file, void *fh, struct v4l2_format =
*f)
> +{
> +	struct al_dec_ctx *ctx =3D fh_to_ctx(fh, struct al_dec_ctx);
> +	struct al_frame *pix_fmt =3D al_get_frame(ctx, f->type);
> +	struct v4l2_pix_format *pix;
> +
> +	if (IS_ERR(pix_fmt)) {
> +		al_v4l2_err(ctx->codec, "Invalid pixel format %p", pix_fmt);
> +		return PTR_ERR(pix_fmt);
> +	}
> +
> +	if (!pix_fmt->fmt) {
> +		al_v4l2_err(ctx->codec, "Unknown format for %d", f->type);
> +		return -EINVAL;
> +	}
> +
> +	pix =3D &f->fmt.pix;
> +	pix->width =3D pix_fmt->width;
> +	pix->height =3D pix_fmt->height;
> +	pix->bytesperline =3D pix_fmt->bytesperline;
> +	pix->sizeimage =3D pix_fmt->sizeimage;
> +	pix->pixelformat =3D pix_fmt->fmt->pixelformat;
> +	pix->field =3D V4L2_FIELD_NONE;
> +
> +	if (f->type =3D=3D V4L2_BUF_TYPE_VIDEO_OUTPUT)
> +		pix->bytesperline =3D 0;
> +
> +	pix->ycbcr_enc =3D pix_fmt->ycbcr_enc;
> +	pix->quantization =3D pix_fmt->quantization;
> +	pix->xfer_func =3D pix_fmt->xfer_func;
> +	pix->colorspace =3D pix_fmt->colorspace;
> +
> +	al_v4l2_dbg(
> +		ctx->codec, 3,
> +		"%s : width (%d) , height (%d), bytesperline (%d) , sizeimage (%d)",
> +		(f->type =3D=3D V4L2_BUF_TYPE_VIDEO_CAPTURE) ? "CAP" : "OUT",
> +		pix->width, pix->height, pix->bytesperline, pix->sizeimage);

Drop.

> +
> +	return 0;
> +}
> +
> +static int al_dec_s_fmt(struct file *file, void *fh, struct v4l2_format =
*f)
> +{
> +	struct al_dec_ctx *ctx =3D fh_to_ctx(fh, struct al_dec_ctx);
> +	struct v4l2_pix_format *pix;
> +	struct al_frame *frame;
> +	struct vb2_queue *vq;
> +	int ret;
> +
> +	ret =3D al_dec_try_fmt(file, fh, f);
> +	if (ret) {
> +		al_v4l2_err(ctx->codec, "Cannot set format (%d)", f->type);
> +		return ret;
> +	}
> +
> +	frame =3D (f->type =3D=3D V4L2_BUF_TYPE_VIDEO_OUTPUT) ? &ctx->src : &ct=
x->dst;
> +
> +	pix =3D &f->fmt.pix;
> +	frame->fmt =3D al_find_fmt(pix->pixelformat);
> +	if (!frame->fmt) {
> +		al_v4l2_err(ctx->codec, "Unknown format for %d",
> +			=C2=A0=C2=A0=C2=A0 pix->pixelformat);
> +		return -EINVAL;
> +	}

This cannot happen, it was already checked in try_fmt.

> +
> +	vq =3D v4l2_m2m_get_vq(ctx->fh.m2m_ctx, f->type);
> +	if (vb2_is_streaming(vq)) {
> +		al_v4l2_err(ctx->codec, "queue %d busy", f->type);
> +		return -EBUSY;
> +	}
> +
> +	frame->width =3D pix->width;
> +	frame->height =3D pix->height;
> +	frame->bytesperline =3D pix->bytesperline;
> +	frame->sizeimage =3D pix->sizeimage;
> +	frame->field =3D pix->field;
> +
> +	frame->ycbcr_enc =3D pix->ycbcr_enc;
> +	frame->quantization =3D pix->quantization;
> +	frame->xfer_func =3D pix->xfer_func;
> +	frame->colorspace =3D pix->colorspace;
> +
> +	al_v4l2_dbg(
> +		ctx->codec, 3,
> +		" %s : width (%d) , height (%d), bytesperline (%d), sizeimage (%d)",
> +		(f->type =3D=3D V4L2_BUF_TYPE_VIDEO_CAPTURE) ? "CAP" : "OUT",
> +		pix->width, pix->height, pix->bytesperline, pix->sizeimage);

Drop.

> +
> +	return 0;
> +}
> +
> +static void al_queue_eos_event(struct al_dec_ctx *ctx)
> +{
> +	const struct v4l2_event eos_event =3D {
> +		.id =3D 0,
> +		.type =3D V4L2_EVENT_EOS,
> +	};
> +
> +	v4l2_event_queue_fh(&ctx->fh, &eos_event);
> +}
> +
> +static void al_queue_res_chg_event(struct al_dec_ctx *ctx)
> +{
> +	static const struct v4l2_event ev_src_ch =3D {
> +		.id =3D 0,
> +		.type =3D V4L2_EVENT_SOURCE_CHANGE,
> +		.u.src_change.changes =3D V4L2_EVENT_SRC_CH_RESOLUTION,
> +	};
> +
> +	v4l2_event_queue_fh(&ctx->fh, &ev_src_ch);
> +}
> +
> +static int al_dec_decoder_cmd(struct file *file, void *fh,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct v4l2_decoder_cmd *dcmd)
> +{
> +	struct al_dec_ctx *ctx =3D fh_to_ctx(fh, struct al_dec_ctx);
> +	struct v4l2_m2m_ctx *m2m_ctx =3D ctx->fh.m2m_ctx;
> +	struct vb2_v4l2_buffer *vbuf;
> +	struct vb2_queue *dst_vq;
> +	int ret;
> +
> +	ret =3D v4l2_m2m_ioctl_try_decoder_cmd(file, fh, dcmd);
> +	if (ret)
> +		return ret;
> +
> +	/* Get the vb2 queue for the Capture */
> +	dst_vq =3D v4l2_m2m_get_dst_vq(m2m_ctx);
> +
> +	switch (dcmd->cmd) {
> +	case V4L2_DEC_CMD_START:
> +		vb2_clear_last_buffer_dequeued(dst_vq);
> +		break;
> +	case V4L2_DEC_CMD_STOP:
> +		vbuf =3D v4l2_m2m_last_src_buf(m2m_ctx);
> +		if (vbuf) {
> +			al_v4l2_dbg(ctx->codec, 1,
> +				=C2=A0=C2=A0=C2=A0 "marking last pending buffer");
> +
> +			vbuf->flags |=3D V4L2_BUF_FLAG_LAST;
> +			if (v4l2_m2m_num_src_bufs_ready(m2m_ctx) =3D=3D 0) {
> +				al_v4l2_dbg(ctx->codec, 1,
> +					=C2=A0=C2=A0=C2=A0 "all remaining buffers queued");
> +				v4l2_m2m_try_schedule(m2m_ctx);
> +			}
> +		}
> +		dec_fw_flush_req(ctx);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int al_dec_enum_framesizes(struct file *file, void *fh,
> +				=C2=A0 struct v4l2_frmsizeenum *fsize)
> +{
> +	if (!al_find_fmt(fsize->pixel_format))
> +		return -EINVAL;
> +
> +	/* FIXME : check step size */
> +	fsize->type =3D V4L2_FRMSIZE_TYPE_STEPWISE;
> +	fsize->stepwise.min_width =3D DECODER_WIDTH_MIN;
> +	fsize->stepwise.max_width =3D DECODER_WIDTH_MAX;
> +	fsize->stepwise.step_width =3D 8;
> +	fsize->stepwise.min_height =3D DECODER_HEIGHT_MIN;
> +	fsize->stepwise.max_height =3D DECODER_HEIGHT_MAX;
> +	fsize->stepwise.step_height =3D 8;
> +
> +	return 0;
> +}
> +
> +static int al_dec_subscribe_event(struct v4l2_fh *fh,
> +				=C2=A0 const struct v4l2_event_subscription *sub)
> +{
> +	switch (sub->type) {
> +	case V4L2_EVENT_EOS:
> +		return v4l2_event_subscribe(fh, sub, 0, NULL);
> +	case V4L2_EVENT_SOURCE_CHANGE:
> +		return v4l2_src_change_event_subscribe(fh, sub);
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int al_dec_log_status(struct file *file, void *fh)
> +{
> +	struct al_codec_dev *codec =3D video_drvdata(file);
> +
> +	v4l2_device_call_all(&codec->v4l2_dev, 0, core, log_status);
> +	return 0;
> +}
> +
> +static const struct v4l2_ioctl_ops al_dec_ioctl_ops =3D {
> +	.vidioc_querycap =3D al_dec_querycap,
> +	.vidioc_enum_fmt_vid_cap =3D al_dec_enum_fmt,
> +	.vidioc_enum_fmt_vid_out =3D al_dec_enum_fmt,
> +	.vidioc_g_fmt_vid_cap =3D al_dec_g_fmt,
> +	.vidioc_g_fmt_vid_out =3D al_dec_g_fmt,
> +	.vidioc_try_fmt_vid_cap =3D al_dec_try_fmt,
> +	.vidioc_try_fmt_vid_out =3D al_dec_try_fmt,
> +	.vidioc_s_fmt_vid_cap =3D al_dec_s_fmt,
> +	.vidioc_s_fmt_vid_out =3D al_dec_s_fmt,
> +
> +	.vidioc_create_bufs =3D v4l2_m2m_ioctl_create_bufs,
> +	.vidioc_reqbufs =3D v4l2_m2m_ioctl_reqbufs,
> +
> +	.vidioc_expbuf =3D v4l2_m2m_ioctl_expbuf,
> +	.vidioc_querybuf =3D v4l2_m2m_ioctl_querybuf,
> +	.vidioc_qbuf =3D v4l2_m2m_ioctl_qbuf,
> +	.vidioc_dqbuf =3D v4l2_m2m_ioctl_dqbuf,
> +	.vidioc_prepare_buf =3D v4l2_m2m_ioctl_prepare_buf,
> +
> +	.vidioc_streamon =3D v4l2_m2m_ioctl_streamon,
> +	.vidioc_streamoff =3D v4l2_m2m_ioctl_streamoff,
> +	.vidioc_log_status =3D al_dec_log_status,
> +
> +	.vidioc_try_decoder_cmd =3D v4l2_m2m_ioctl_try_decoder_cmd,
> +	.vidioc_decoder_cmd =3D al_dec_decoder_cmd,
> +	.vidioc_enum_framesizes =3D al_dec_enum_framesizes,
> +
> +	.vidioc_subscribe_event =3D al_dec_subscribe_event,
> +	.vidioc_unsubscribe_event =3D v4l2_event_unsubscribe,
> +};
> +
> +static void al_device_run(void *priv)
> +{
> +	struct al_dec_ctx *ctx =3D priv;
> +	struct vb2_v4l2_buffer *dst_buf;
> +	struct v4l2_m2m_buffer *m2m_buf;
> +
> +	if (unlikely(!ctx))
> +		return;
> +
> +	if (ctx->aborting) {
> +		vb2_queue_error(v4l2_m2m_get_src_vq(ctx->fh.m2m_ctx));
> +		vb2_queue_error(v4l2_m2m_get_dst_vq(ctx->fh.m2m_ctx));
> +		return;
> +	}
> +
> +	if (!v4l2_m2m_num_dst_bufs_ready(ctx->fh.m2m_ctx))
> +		goto job_finish;
> +
> +	dst_buf =3D v4l2_m2m_dst_buf_remove(ctx->fh.m2m_ctx);
> +	if (!dst_buf)
> +		goto job_finish;
> +
> +	if (!al_common_mcu_is_alive(ctx->codec) ||
> +	=C2=A0=C2=A0=C2=A0 al_dec_fw_push_frame_buf(ctx, dst_buf)) {
> +		vb2_set_plane_payload(&dst_buf->vb2_buf, 0, 0);
> +		v4l2_m2m_buf_done(dst_buf, VB2_BUF_STATE_ERROR);
> +		goto job_finish;
> +	}
> +
> +	mutex_lock(&ctx->buf_q_mlock);
> +	m2m_buf =3D container_of(dst_buf, struct v4l2_m2m_buffer, vb);
> +	list_add_tail(&m2m_buf->list, &ctx->frame_q_list);
> +	mutex_unlock(&ctx->buf_q_mlock);
> +
> +job_finish:
> +	v4l2_m2m_job_finish(ctx->codec->m2m_dev, ctx->fh.m2m_ctx);
> +}
> +
> +static const struct v4l2_m2m_ops al_dec_m2m_ops =3D {
> +	.device_run =3D al_device_run,
> +};
> +
> +static int al_dec_open(struct file *file)
> +{
> +	struct video_device *vdev =3D video_devdata(file);
> +	struct al_codec_dev *codec =3D video_get_drvdata(vdev);
> +	struct al_dec_ctx *ctx =3D NULL;
> +	int ret;
> +
> +	if (mutex_lock_interruptible(&codec->ctx_mlock))
> +		return -ERESTARTSYS;

This is a bit of over-locking ...

> +
> +	/* Aloocate memory for the dec ctx */
> +	ctx =3D kzalloc(sizeof(*ctx), GFP_KERNEL);
> +	if (!ctx) {
> +		ret =3D -ENOMEM;
> +		goto unlock;
> +	}
> +
> +	ctx->codec =3D codec;
> +	/* Init ctx mutex */
> +	mutex_init(&ctx->buf_q_mlock);
> +	/* Init ctx LISTHEADs*/
> +	INIT_LIST_HEAD(&ctx->cmd_q_list);
> +	INIT_LIST_HEAD(&ctx->frame_q_list);
> +	INIT_LIST_HEAD(&ctx->stream_q_list);
> +
> +	/* Init the irq queue */
> +	init_completion(&ctx->res_done);
> +
> +	v4l2_fh_init(&ctx->fh, vdev);
> +
> +	v4l2_ctrl_handler_init(&ctx->ctrl_handler, 0);
> +	if (ctx->ctrl_handler.error) {
> +		ret =3D ctx->ctrl_handler.error;
> +		al_v4l2_err(codec, "Failed to create control %d", ret);
> +		goto handler_error;
> +	}
> +
> +	ctx->fh.ctrl_handler =3D &ctx->ctrl_handler;
> +	v4l2_ctrl_handler_setup(&ctx->ctrl_handler);
> +
> +	file->private_data =3D &ctx->fh;
> +	v4l2_fh_add(&ctx->fh);
> +
> +	/* Set default formats */
> +	ctx->src =3D ctx->dst =3D al_default_fmt;
> +	ctx->csequence =3D ctx->osequence =3D 0;
> +
> +	ctx->stopped =3D false;
> +	ctx->aborting =3D false;
> +	ctx->id =3D codec->ctx_counter++;
> +
> +	/* Setup the ctx for m2m mode */
> +	ctx->fh.m2m_ctx =3D
> +		v4l2_m2m_ctx_init(codec->m2m_dev, ctx, al_dec_queue_init);
> +	if (IS_ERR(ctx->fh.m2m_ctx)) {
> +		ret =3D PTR_ERR(ctx->fh.m2m_ctx);
> +		al_v4l2_err(codec, "Failed to initialize m2m mode %d", ret);
> +		goto error_ctrls;
> +	}
> +
> +	v4l2_m2m_set_src_buffered(ctx->fh.m2m_ctx, true);
> +
> +	/* Add ctx to the LIST */
> +	kref_init(&ctx->refcount);

You really just need to lock this call. Be aware you can use scoped_guard()=
 too.

> +	list_add(&ctx->list, &codec->ctx_q_list);
> +	al_codec_dbgfs_create(ctx);
> +
> +	mutex_unlock(&codec->ctx_mlock);
> +
> +	return 0;
> +
> +error_ctrls:
> +	v4l2_fh_del(&ctx->fh);
> +handler_error:
> +	v4l2_ctrl_handler_free(&ctx->ctrl_handler);
> +	v4l2_fh_exit(&ctx->fh);
> +	kfree(ctx);
> +
> +unlock:
> +	mutex_unlock(&codec->ctx_mlock);
> +	return ret;
> +}
> +
> +static int al_dec_release(struct file *file)
> +{
> +	struct al_dec_ctx *ctx =3D
> +		fh_to_ctx(file->private_data, struct al_dec_ctx);
> +	struct al_codec_dev *codec =3D ctx->codec;
> +
> +	guard(mutex)(&codec->ctx_mlock);
> +
> +	/* It is important to do this before removing ctx from dev list.
> +	 * Those commands will trigger some traffic towards fw and so we
> +	 * need completion to avoid deadlock if cmds can't find ctx.
> +	 */
> +	v4l2_m2m_ctx_release(ctx->fh.m2m_ctx);
> +	v4l2_ctrl_handler_free(&ctx->ctrl_handler);
> +	v4l2_fh_del(&ctx->fh);
> +	v4l2_fh_exit(&ctx->fh);
> +
> +	list_del(&ctx->list);
> +	al_codec_dbgfs_remove(codec, ctx->id);
> +	al_ctx_put(ctx);

I'd scope the lock to the list_del, and move it first so that ctx is comple=
tely
detached.

> +
> +	return 0;
> +}
> +
> +static inline bool al_mark_last_dst_buf(struct al_dec_ctx *ctx)
> +{
> +	struct vb2_v4l2_buffer *buf;
> +	struct vb2_buffer *dst_vb;
> +	struct vb2_queue *dst_vq;
> +	unsigned long flags;
> +
> +	al_v4l2_dbg(ctx->codec, 1, "marking last capture buffer");
> +
> +	dst_vq =3D v4l2_m2m_get_vq(ctx->fh.m2m_ctx, V4L2_BUF_TYPE_VIDEO_CAPTURE=
);
> +	spin_lock_irqsave(&dst_vq->done_lock, flags);
> +	if (list_empty(&dst_vq->done_list)) {
> +		spin_unlock_irqrestore(&dst_vq->done_lock, flags);
> +		return false;
> +	}
> +
> +	dst_vb =3D list_last_entry(&dst_vq->done_list, struct vb2_buffer,
> +				 done_entry);
> +	buf =3D to_vb2_v4l2_buffer(dst_vb);
> +	buf->flags |=3D V4L2_BUF_FLAG_LAST;

In my experience, this approach isn't reliable. Other driver simply add som=
e
hook into queue_buf, and flag that buffer when userspace queue back a free
buffer.

> +
> +	spin_unlock_irqrestore(&dst_vq->done_lock, flags);
> +	return true;
> +}
> +
> +static const struct v4l2_file_operations al_dec_file_ops =3D {
> +	.owner =3D THIS_MODULE,
> +	.open =3D al_dec_open,
> +	.release =3D al_dec_release,
> +	.poll =3D v4l2_m2m_fop_poll,
> +	.unlocked_ioctl =3D video_ioctl2,
> +	.mmap =3D v4l2_m2m_fop_mmap,
> +};
> +
> +static void handle_error_evt(struct al_dec_ctx *ctx, struct msg_itf_head=
er *hdr)
> +{
> +	struct al_codec_dev *codec =3D ctx->codec;
> +	struct msg_itf_evt_error evt;
> +	struct v4l2_m2m_buffer *vbuf;
> +
> +	if (al_common_get_data(codec, (char *)&evt, hdr->payload_len)) {
> +		al_v4l2_err(codec, "Unable to get resolution found event");
> +		return;
> +	}
> +
> +	al_v4l2_err(codec, "Decoding error=C2=A0 %d", evt.errno);
> +
> +	guard(mutex)(&ctx->buf_q_mlock);
> +	if (!list_empty(&ctx->stream_q_list)) {
> +		vbuf =3D list_last_entry(&ctx->frame_q_list,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct v4l2_m2m_buffer, list);
> +		list_del(&vbuf->list);
> +		v4l2_m2m_buf_done(&vbuf->vb, VB2_BUF_STATE_ERROR);
> +	}
> +}
> +
> +static void handle_resolution_found_evt(struct al_dec_ctx *ctx,
> +					struct msg_itf_header *hdr)
> +{
> +	struct msg_itf_evt_resolution_found evt;
> +	struct al_codec_dev *codec =3D ctx->codec;
> +	struct al_frame *frame;
> +	struct vb2_queue *dst_vq;
> +
> +	if (al_common_get_data(codec, (char *)&evt, hdr->payload_len)) {
> +		al_v4l2_err(codec, "Unable to get resolution found event");
> +		return;
> +	}
> +
> +	frame =3D &ctx->dst;
> +
> +	if (frame->width !=3D evt.width || frame->height !=3D evt.height ||
> +	=C2=A0=C2=A0=C2=A0 frame->nbuffers < evt.buffer_nb) {
> +		/* Update frame properties */
> +		frame->width =3D evt.width;
> +		frame->height =3D evt.height;
> +		frame->bytesperline =3D evt.bytesperline;
> +		frame->sizeimage =3D evt.sizeimage;
> +		frame->nbuffers =3D evt.buffer_nb;
> +		frame->fmt =3D al_find_fmt(evt.pixelformat);
> +
> +		/* This has to be changed */
> +		if (!frame->fmt)
> +			return;
> +
> +		al_queue_res_chg_event(ctx);
> +	}
> +
> +	dst_vq =3D v4l2_m2m_get_dst_vq(ctx->fh.m2m_ctx);
> +	if (!vb2_is_streaming(dst_vq))
> +		complete(&ctx->res_done);
> +
> +	al_v4l2_dbg(
> +		codec, 3,
> +		"width(%d) , height(%d), bytesperline(%d), sizeimage(%d), n_bufs(%d)",
> +		frame->width, frame->height, frame->bytesperline,
> +		frame->sizeimage, frame->nbuffers);
> +}
> +
> +static void handle_bitstream_buffer_release_evt(struct al_dec_ctx *ctx,
> +						struct msg_itf_header *hdr)
> +{
> +	struct msg_itf_evt_bitstream_buffer_release evt;
> +	struct al_codec_dev *codec =3D ctx->codec;
> +	struct vb2_v4l2_buffer *vbuf;
> +
> +	if (al_common_get_data(codec, (char *)&evt, hdr->payload_len)) {
> +		al_v4l2_err(codec, "Unable to get buffer release event");
> +		return;
> +	}
> +
> +	if (ctx->stopped)
> +		return;
> +
> +	vbuf =3D al_dec_dequeue_src_buf(ctx, evt.bufferHandle);
> +	if (!vbuf) {
> +		al_v4l2_err(codec, "Unable to find bitsream buffer 0x%llx",
> +			=C2=A0=C2=A0=C2=A0 evt.bufferHandle);
> +		return;
> +	}
> +
> +	al_v4l2_dbg(codec, 3, "Release bitstream buffer %p", vbuf);
> +	v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_DONE);
> +}
> +
> +static void handle_eos_evt(struct al_dec_ctx *ctx, struct msg_itf_header=
 *hdr)
> +{
> +	struct msg_itf_evt_frame_buffer_decode evt;
> +	struct al_codec_dev *codec =3D ctx->codec;
> +
> +	if (al_common_get_data(codec, (char *)&evt, hdr->payload_len)) {
> +		al_v4l2_err(codec, "Unable to get frame buffer event");
> +		return;
> +	}
> +
> +	/* set LAST_FLAG to the last done CAPTURE buffer*/
> +	al_mark_last_dst_buf(ctx);
> +	/* Set eos event */
> +	al_queue_eos_event(ctx);
> +}
> +
> +static void handle_frame_buffer_decode_evt(struct al_dec_ctx *ctx,
> +					=C2=A0=C2=A0 struct msg_itf_header *hdr)
> +{
> +	struct msg_itf_evt_frame_buffer_decode evt;
> +	struct al_codec_dev *codec =3D ctx->codec;
> +	struct vb2_v4l2_buffer *vbuf;
> +	struct al_buffer_meta *meta;
> +
> +	if (al_common_get_data(codec, (char *)&evt, hdr->payload_len)) {
> +		al_v4l2_err(codec, "Unable to get frame buffer event");
> +		return;
> +	}
> +
> +	vbuf =3D al_dec_dequeue_dst_buf(ctx, evt.bufferHandle);
> +	if (!vbuf) {
> +		al_v4l2_err(codec, "Unable to find frame buffer 0x%llx",
> +			=C2=A0=C2=A0=C2=A0 evt.bufferHandle);
> +		return;
> +	}
> +
> +	meta =3D &evt.meta;
> +	al_v4l2_dbg(codec, 3, "Decoded frame done for buffer %p (%d) (%lld)",
> +		=C2=A0=C2=A0=C2=A0 vbuf, meta->last, evt.size);
> +
> +	vb2_set_plane_payload(&vbuf->vb2_buf, 0, evt.size);
> +	vbuf->field =3D V4L2_FIELD_NONE;
> +	vbuf->sequence =3D ctx->csequence++;
> +	vbuf->timecode =3D meta->timecode;
> +	vbuf->vb2_buf.timestamp =3D meta->timestamp;
> +
> +	if (meta->last || (vbuf->flags & V4L2_BUF_FLAG_LAST)) {
> +		vbuf->flags |=3D V4L2_BUF_FLAG_LAST;
> +		v4l2_m2m_mark_stopped(ctx->fh.m2m_ctx);
> +	}
> +
> +	v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_DONE);
> +}
> +
> +static int al_handle_cmd_reply(struct al_codec_dev *codec,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct msg_itf_header *hdr)
> +{
> +	struct al_dec_ctx *ctx;
> +	struct al_codec_cmd *cmd =3D NULL;
> +	int ret =3D 0;
> +
> +	ctx =3D al_ctx_get(codec, hdr->drv_ctx_hdl);
> +	if (IS_ERR_OR_NULL(ctx)) {
> +		al_v4l2_err(codec, "Unable to find ctx %p for reply %d",
> +			=C2=A0=C2=A0=C2=A0 al_phys_to_virt(hdr->drv_ctx_hdl), hdr->type);
> +		return -EINVAL;
> +	}
> +
> +	cmd =3D al_codec_cmd_get(&ctx->cmd_q_list, hdr->drv_cmd_hdl);
> +	if (!cmd) {
> +		al_v4l2_err(codec, "Unable to find command %p for reply %d",
> +			=C2=A0=C2=A0=C2=A0 al_phys_to_virt(hdr->drv_cmd_hdl), hdr->type);
> +		ret =3D -EINVAL;
> +		goto ctx_put;
> +	}
> +
> +	if (cmd->reply_size !=3D hdr->payload_len) {
> +		al_v4l2_err(codec, "mismatch size %d %d", cmd->reply_size,
> +			=C2=A0=C2=A0=C2=A0 hdr->payload_len);
> +		ret =3D -EINVAL;
> +		goto cmd_put;
> +	}
> +
> +	ret =3D al_common_get_data(codec, cmd->reply, hdr->payload_len);
> +	if (ret)
> +		al_v4l2_err(codec, "Unable to copy reply");
> +
> +	complete(&cmd->done);
> +	ret =3D 0;
> +
> +cmd_put:
> +	al_codec_cmd_put(cmd);
> +ctx_put:
> +	al_ctx_put(ctx);
> +
> +	return ret;
> +}
> +
> +static int al_handle_cmd_evt(struct al_codec_dev *dev,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 struct msg_itf_header *hdr, int type)
> +{
> +	static u32 evt_sizes[] =3D {
> +		sizeof(struct msg_itf_evt_error),
> +		sizeof(struct msg_itf_evt_resolution_found),
> +		sizeof(struct msg_itf_evt_bitstream_buffer_release),
> +		sizeof(struct msg_itf_evt_frame_buffer_decode),
> +		sizeof(struct msg_itf_evt_eos),
> +	};
> +
> +	u32 evt_size;
> +	struct al_dec_ctx *ctx =3D NULL;
> +	int ret =3D 0;
> +
> +	if (type < MSG_ITF_TYPE_NEXT_EVT || type > MSG_ITF_TYPE_END_EVT) {
> +		al_v4l2_err(dev, "Unsupporting event type %d", type);
> +		return -EINVAL;
> +	}
> +
> +	ctx =3D al_ctx_get(dev, hdr->drv_ctx_hdl);
> +	if (!ctx) {
> +		al_v4l2_err(dev, "Unable to find ctx %p for evt %d",
> +			=C2=A0=C2=A0=C2=A0 al_phys_to_virt(hdr->drv_ctx_hdl), type);
> +		return -EINVAL;
> +	}
> +
> +	// Check the received event size and the expected one
> +	evt_size =3D evt_sizes[type - MSG_ITF_TYPE_NEXT_EVT];
> +	if (hdr->payload_len !=3D evt_size) {
> +		al_v4l2_err(
> +			dev,
> +			"Invalid event size for client (%p) for evt (%d) : Got (%d), expected=
 (%d)",
> +			al_phys_to_virt(hdr->drv_ctx_hdl), type,
> +			hdr->payload_len, evt_size);
> +		ret =3D -EINVAL;
> +		goto clean_ctx;
> +	}
> +
> +	al_v4l2_dbg(dev, 3, "Event received from MCU (%d)", type);
> +
> +	switch (type) {
> +	case MSG_ITF_TYPE_EVT_ERROR:
> +		handle_error_evt(ctx, hdr);
> +		break;
> +	case MSG_ITF_TYPE_EVT_RESOLUTION_FOUND:
> +		handle_resolution_found_evt(ctx, hdr);
> +		break;
> +	case MSG_ITF_TYPE_EVT_BITSTREAM_BUFFER_RELEASE:
> +		handle_bitstream_buffer_release_evt(ctx, hdr);
> +		break;
> +	case MSG_ITF_TYPE_EVT_FRAME_BUFFER_DECODE:
> +		handle_frame_buffer_decode_evt(ctx, hdr);
> +		break;
> +	case MSG_ITF_TYPE_EVT_EOS:
> +		handle_eos_evt(ctx, hdr);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +clean_ctx:
> +	al_ctx_put(ctx);
> +	return ret;
> +}
> +
> +static void al_dec_process_msg(void *cb_arg, struct msg_itf_header *hdr)
> +{
> +	struct al_codec_dev *dev =3D cb_arg;
> +	int ret;
> +
> +	if (is_type_reply(hdr->type))
> +		ret =3D al_handle_cmd_reply(dev, hdr);
> +	else if (is_type_event(hdr->type))
> +		ret =3D al_handle_cmd_evt(dev, hdr, hdr->type);
> +	else {
> +		al_v4l2_err(dev, "Unsupported message type %d", hdr->type);
> +		ret =3D -EINVAL;
> +	}
> +
> +	if (ret) {
> +		al_v4l2_err(dev, "Skip received data");
> +		al_common_skip_data(dev, hdr->payload_len);
> +	}
> +}
> +
> +static const struct video_device al_videodev =3D {
> +	.name =3D "allegro-decoder",
> +	.fops =3D &al_dec_file_ops,
> +	.ioctl_ops =3D &al_dec_ioctl_ops,
> +	.minor =3D -1,
> +	.release =3D video_device_release_empty,
> +	.vfl_dir =3D VFL_DIR_M2M,
> +	.device_caps =3D V4L2_CAP_VIDEO_M2M | V4L2_CAP_STREAMING,
> +};
> +
> +static void al_dec_register_v4l2(void *cb_arg)
> +{
> +	struct al_codec_dev *dev =3D cb_arg;
> +	struct video_device *video_dev =3D NULL;
> +	int ret;
> +
> +	ret =3D v4l2_device_register(&dev->pdev->dev, &dev->v4l2_dev);
> +	if (ret) {
> +		al_v4l2_err(dev, "Unable to register v4l2 device %d", ret);
> +		return;
> +	}
> +
> +	dev->m2m_dev =3D v4l2_m2m_init(&al_dec_m2m_ops);
> +	if (IS_ERR(dev->m2m_dev)) {
> +		ret =3D PTR_ERR(dev->m2m_dev);
> +		al_v4l2_err(dev, "failed to init mem2mem device %d", ret);
> +		goto v4l2_m2m_init_error;
> +	}
> +
> +	video_dev =3D &dev->video_dev;
> +	*video_dev =3D al_videodev;
> +
> +	video_dev->lock =3D &dev->lock;
> +	video_dev->v4l2_dev =3D &dev->v4l2_dev;
> +
> +	video_set_drvdata(video_dev, dev);
> +	ret =3D video_register_device(video_dev, VFL_TYPE_VIDEO, -1);
> +	if (ret) {
> +		al_v4l2_err(dev, "failed to register video device %d", ret);
> +		goto video_register_device_error;
> +	}
> +
> +	v4l2_info(&dev->v4l2_dev, "registered as /dev/video%d\n",
> +		=C2=A0 dev->video_dev.num);
> +
> +	dev->init_done =3D true;
> +
> +	return;
> +
> +video_register_device_error:
> +	v4l2_m2m_release(dev->m2m_dev);
> +v4l2_m2m_init_error:
> +	v4l2_device_unregister(&dev->v4l2_dev);
> +}
> +
> +static int al_dec_probe(struct platform_device *pdev)
> +{
> +	struct al_codec_dev *codec;
> +	struct device *dev =3D &pdev->dev;
> +	struct device_node *np =3D dev->of_node;
> +	const struct al_match_data *match_data;
> +	const char *firmware;
> +	int ret;
> +
> +	dev_info(dev, "Probing ...\n");

Drop, this provide no information.

> +
> +	match_data =3D device_get_match_data(dev);
> +	if (!match_data) {
> +		dev_err(dev, "Missing device match data\n");
> +		return -EINVAL;
> +	}
> +
> +	codec =3D devm_kzalloc(dev, sizeof(*codec), GFP_KERNEL);
> +	if (!codec)
> +		return -ENOMEM;
> +
> +	codec->pdev =3D pdev;
> +	codec->init_done =3D false;
> +	codec->ctx_counter =3D 0;
> +	mutex_init(&codec->lock);
> +	mutex_init(&codec->ctx_mlock);
> +	INIT_LIST_HEAD(&codec->ctx_q_list);
> +
> +	codec->cb_arg =3D codec;
> +	codec->process_msg_cb =3D al_dec_process_msg;
> +	codec->fw_ready_cb =3D al_dec_register_v4l2;
> +
> +	/* firmware-name is optional in DT */
> +	of_property_read_string(np, "firmware-name", &firmware);
> +	if (!firmware)
> +		firmware =3D match_data->fw_name;
> +
> +	ret =3D al_common_probe(codec, firmware);
> +	if (ret)
> +		return ret;
> +
> +	platform_set_drvdata(pdev, codec);
> +	al_codec_dbgfs_init(codec);
> +	dev_info(dev, "Probing done successfully %p\n", codec);

Drop, its not really successful until fw_ready_cb is called. This one nicel=
y
give the video node in the trace.

> +
> +	return 0;
> +}
> +
> +static void al_dec_remove(struct platform_device *pdev)
> +{
> +	struct al_codec_dev *dev =3D platform_get_drvdata(pdev);
> +
> +	dev_info(&pdev->dev, "remove %p\n", dev);

At best debug, this isn't valuable info.

> +
> +	if (dev->init_done) {
> +		video_unregister_device(&dev->video_dev);
> +		if (dev->m2m_dev)
> +			v4l2_m2m_release(dev->m2m_dev);
> +		v4l2_device_unregister(&dev->v4l2_dev);
> +	}
> +	al_codec_dbgfs_deinit(&dev->dbgfs);
> +	al_common_remove(dev);
> +}
> +
> +static const struct al_match_data ald300_data =3D {
> +	.fw_name =3D "al300-vdec.fw",
> +};
> +
> +static const struct of_device_id v4l2_al_dec_dt_match[] =3D {
> +	{ .compatible =3D "allegro,al300-vdec", .data =3D &ald300_data },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, v4l2_al_dec_dt_match);
> +
> +static struct platform_driver al300_vdec_drv =3D {
> +	.probe =3D al_dec_probe,
> +	.remove =3D al_dec_remove,
> +	.driver =3D {
> +		.name =3D "al300_vdec",
> +		.of_match_table =3D of_match_ptr(v4l2_al_dec_dt_match),
> +	},
> +};
> +
> +module_platform_driver(al300_vdec_drv);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:al300-vdec");
> +MODULE_AUTHOR("Yassine OUAISSA <yassine.ouaissa@allegrodvt.com>");
> +MODULE_DESCRIPTION("Allegro DVT V4l2 decoder driver gen 3");
> diff --git a/drivers/media/platform/allegro-dvt/al300/al_vdec_drv.h b/dri=
vers/media/platform/allegro-dvt/al300/al_vdec_drv.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..a9f4818bcc94114c02614328c=
6c6edec33702556
> --- /dev/null
> +++ b/drivers/media/platform/allegro-dvt/al300/al_vdec_drv.h
> @@ -0,0 +1,98 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (c) 2025 Allegro DVT.
> + * Author: Yassine OUAISSA <yassine.ouaissa@allegrodvt.fr>
> + */
> +
> +#ifndef __AL_VDEC_DRV__
> +#define __AL_VDEC_DRV__
> +
> +#include <media/v4l2-ctrls.h>
> +#include <media/videobuf2-core.h>
> +#include <media/v4l2-mem2mem.h>
> +
> +#include "al_codec_common.h"
> +
> +enum {
> +	MSG_ITF_TYPE_EVT_RESOLUTION_FOUND =3D MSG_ITF_TYPE_NEXT_EVT + 1,
> +	MSG_ITF_TYPE_EVT_BITSTREAM_BUFFER_RELEASE,
> +	MSG_ITF_TYPE_EVT_FRAME_BUFFER_DECODE,
> +	MSG_ITF_TYPE_EVT_EOS,
> +	/* Mark the end of the events list.*/
> +	MSG_ITF_TYPE_END_EVT,
> +};
> +
> +struct msg_itf_create_decoder_req {
> +	unsigned int codec;
> +} __packed;
> +DECLARE_FULL_REQ(msg_itf_create_decoder_req);
> +
> +struct msg_itf_evt_resolution_found {
> +	u16 buffer_nb;
> +	u16 width;
> +	u16 height;
> +	u32 pixelformat;
> +	u32 sizeimage;
> +	u32 bytesperline;
> +} __packed;
> +DECLARE_FULL_EVENT(msg_itf_evt_resolution_found);
> +
> +struct msg_itf_evt_bitstream_buffer_release {
> +	u64 bufferHandle;
> +} __packed;
> +DECLARE_FULL_EVENT(msg_itf_evt_bitstream_buffer_release);
> +
> +struct msg_itf_evt_frame_buffer_decode {
> +	u64 bufferHandle;
> +	u64 size;
> +	struct al_buffer_meta meta;
> +} __packed;
> +DECLARE_FULL_EVENT(msg_itf_evt_frame_buffer_decode);
> +
> +struct msg_itf_evt_eos {
> +	u32 unused;
> +} __packed;
> +DECLARE_FULL_EVENT(msg_itf_evt_eos);
> +
> +struct al_fmt {
> +	u32 pixelformat;
> +	u8 bpp;
> +};
> +
> +struct al_frame {
> +	u32 width;
> +	u32 height;
> +	u32 bytesperline;
> +	u32 sizeimage;
> +	u32 nbuffers;
> +	const struct al_fmt *fmt;
> +	enum v4l2_field field;
> +	enum v4l2_colorspace colorspace;
> +	enum v4l2_ycbcr_encoding ycbcr_enc;
> +	enum v4l2_quantization quantization;
> +	enum v4l2_xfer_func xfer_func;
> +};
> +
> +struct al_dec_ctx {
> +	struct al_codec_dev *codec;
> +	struct v4l2_fh fh;
> +	struct v4l2_ctrl_handler ctrl_handler;
> +	struct kref refcount;
> +	struct list_head list;
> +	/* CAP and OUT frames */
> +	struct al_frame src;
> +	struct al_frame dst;
> +	struct completion res_done; /* Resolution found event */
> +	struct list_head cmd_q_list; /* Store active commands */
> +	struct mutex buf_q_mlock;
> +	struct list_head frame_q_list;
> +	struct list_head stream_q_list;
> +	u64 hDec;
> +	u32 csequence;
> +	u32 osequence;
> +	u64 id;
> +	bool stopped;
> +	bool aborting;
> +};
> +
> +#endif /*__AL_VDEC_DRV__*/

This is getting into good shape, looking forward v4.

Nicolas

--=-Nss7NBe2u0IN0E+GPyZQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaQ5iEwAKCRDZQZRRKWBy
9Hy+AP4kvBR6IaT9s3JPZeKVcZILNdUjM0LtpiHbSzDut3l84AD/Sy7u72tFAi4O
c3rvlQ3MN3bi9vYtKStTIvhNABGYLwI=
=9VcS
-----END PGP SIGNATURE-----

--=-Nss7NBe2u0IN0E+GPyZQ--

