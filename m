Return-Path: <linux-kernel+bounces-847484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D52DBCAF46
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 23:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 656B519E7CDD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 21:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1D927A929;
	Thu,  9 Oct 2025 21:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXt6JbDG"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D139253F12
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 21:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760046027; cv=none; b=lt3zWRZr5MK2cpxFkTsaJq3di57y8o+hKfURaQMbur4vs5RnXI/+fTpo0rDH76S97anwTbwNci5eDz697x4RhhYlhO9JjH9YASTgxJ5vWhfH7lUZ+siaO4kd0JD/DZSwSFkDQnSlUjikVPslQP09edWNCZXLbnGeyXX/VFoeVVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760046027; c=relaxed/simple;
	bh=SFcZLfqEdlVZiN8fzcWkv8ofo/vQGnHGqTA4Ew+5NrY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FcOPXALZSd6UU1OXSz2HUV6PVLddqFF56CqeHZSDxEGmlK1hbnFf8zfcpobsl/t6RsCgtCAueyInfRAu4ylz5GZX1xKs/DRGCZjUkACZeEhGzDcTR42r2+OJcaR7RuJkM2Lj+u21LfYKa/6TGJGH91Opngbcb7R8WqEPmJtCwTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VXt6JbDG; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3324fdfd54cso1608508a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 14:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760046025; x=1760650825; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fsXu8E/zxrsszSMAnsLE4IzVi2sOh4hhreBruYhjhZ0=;
        b=VXt6JbDGJUts0AP5gpPInx9ATv44HEPS5VuF5GoNnURFowotgje+u0l+oXcUdUs/rC
         OLB8vJdw93DzMTIlXjnz/VP3cSRWYgz4l3Ci5t5tj/vPw18cAo/BxkwrnKhYYy88e1Tw
         ISZunuPxCeDU+oihT6ab1pSjfZx+1T4YtmqgrK+aiYRWDjSf30LCVml5yuSQW1s58ZlS
         RAoEl5kT1HghN3tRmFet9VNqkmXromN/pixvZOTNvb+P2aeIfv8sXDGNFlTjehiZyjLg
         q2AgVmWCLCXc9RvzHdi8s1+RPey9hH6qz1pJTj3p0UmA5K6oRszMw4fTpwXpeFz5J5wy
         Hn3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760046025; x=1760650825;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fsXu8E/zxrsszSMAnsLE4IzVi2sOh4hhreBruYhjhZ0=;
        b=DxCwghkZBoNBoX+82StirsX3S/5d2tiKJ1H3psPOEhBC28AZUM8yLEXPJoWu/6eF60
         L/GhGaOpXm8o0fyeEGGtrpvf2iCG+AyCCKSoYfCPHVZZ0qc+caKRzcbhpnqxnJwCDjw4
         opLmWqLMF7+iPOnLHH4sbXPbTXfPSmeAKx8Rf5Ib4Whc52q+hiY9Zh6OBMKEP6nRko0u
         CqHYasJQsxT8ffqQjD50/KlYWan35jUdwEIwtQZRNE+7rUWj+4JWI6iCf6QJtTTAzahn
         Z/oEAXSj8uBeOzgbuaKQNceXmMu3fWR0SvU6nG+TsSLoHUHSNzctoNADwGNaiWT19ptF
         PO0w==
X-Forwarded-Encrypted: i=1; AJvYcCWo9LkRXbWbdwG7M/fA0mMMAchJEMtv7e+v0si4v5JNL3nLjej/4pUZYaDLG4QcCMlUjr+scX+k5bk7r54=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0oDCoo0Lu9R69umObs6F1Y0QadthZvVPO71JxyFlCUwYtTDBX
	D7V1jcpkLpj2o1fcFgn7CzEaBoMSgqKkX5/erPvG6zGNKfs1TZWRiZ64dNHF+WOrpsZiFmRXdGM
	5Zb/mfv5rHI4uB4eqO2pD2tZz47gsVrI=
X-Gm-Gg: ASbGncsE46qunC+QFHGZuPMQ1NmhQd8BlYSpBkxoEaG/RFy0DCr9a4M1YCX/txuUzKi
	sIGKDWQK4e3fl/tScKRrq5mWqQ3DXmFkLmnjtNsWY6ag8NOmtE1VtyNK0iglUGMDkUQrJ6G2sDT
	E1Wp80ZmserLVCz9yy0J3MBQb1kWncHI7rxEYKWGdmZTmSoaDHfps5KvxWsfNKUG4Dv3OKAkCyR
	ygx9g1I8lmxZk2etGsfk8IBdrzxqFEhp/MYwd+V
X-Google-Smtp-Source: AGHT+IFuyysCgeoHc2eKdp7pwqyz/aMmKl6mTh26Ym/Ip0FadeQSceFpDgODfzO48H+nrSERpahgmUbRxjCJkCGIcOc=
X-Received: by 2002:a17:90b:4f4e:b0:338:3789:6c60 with SMTP id
 98e67ed59e1d1-33b513eb6a6mr11782833a91.36.1760046024882; Thu, 09 Oct 2025
 14:40:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618204400.21808-1-gert.wollny@collabora.com>
 <20250630202703.13844-1-gert.wollny@collabora.com> <20250630202703.13844-5-gert.wollny@collabora.com>
In-Reply-To: <20250630202703.13844-5-gert.wollny@collabora.com>
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Date: Thu, 9 Oct 2025 23:40:13 +0200
X-Gm-Features: AS18NWCcLXKq5DI12bX6G3B_1m5n8NJHUooi5c2xo-HfW6-Q8wPaQrSFbb-e5Sw
Message-ID: <CAH9NwWdNabvh+FJATuD=0KxHvQv77OuYpLgd5iQAcSNNPbS4ew@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] drm/etnaviv: Add PPU flop reset
To: Gert Wollny <gert.wollny@collabora.com>
Cc: Lucas Stach <l.stach@pengutronix.de>, Russell King <linux+etnaviv@armlinux.org.uk>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, etnaviv@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Gert,

>
> The PPU flop reset is required on some hardware to clear the
> temporary registers. This code follows the implementation
> of the PPU flop reset as found in the public galcore kernel
> module. Compared to that code some superfluous parts were
> removed and only the code path for SoC chip_model = 0x8000
> and revision = 0x6205 is implemented and tested.
>
> v2: - Move flop reset data to etnaviv_drm_private and initialize it
>       from etnaviv_gpu_bind (Lucas)
>     - Prepare code for more chip IDs and other flop reset types
>     - Do some cleanups and rename some functions
>
> v3: - Move initialization of flop reset data to etnaviv_gpu_init (Lucas)
>     - Free PPU data suballocation (Lucas)
>
> Signed-off-by: Gert Wollny <gert.wollny@collabora.com>
> ---
>  drivers/gpu/drm/etnaviv/Makefile             |   1 +
>  drivers/gpu/drm/etnaviv/etnaviv_buffer.c     |   6 +
>  drivers/gpu/drm/etnaviv/etnaviv_drv.c        |   3 +
>  drivers/gpu/drm/etnaviv/etnaviv_drv.h        |   3 +
>  drivers/gpu/drm/etnaviv/etnaviv_flop_reset.c | 206 +++++++++++++++++++
>  drivers/gpu/drm/etnaviv/etnaviv_flop_reset.h |  25 +++
>  drivers/gpu/drm/etnaviv/etnaviv_gpu.c        |   5 +
>  7 files changed, 249 insertions(+)
>  create mode 100644 drivers/gpu/drm/etnaviv/etnaviv_flop_reset.c
>  create mode 100644 drivers/gpu/drm/etnaviv/etnaviv_flop_reset.h
>
> diff --git a/drivers/gpu/drm/etnaviv/Makefile b/drivers/gpu/drm/etnaviv/Makefile
> index 46e5ffad69a6..903101e8751a 100644
> --- a/drivers/gpu/drm/etnaviv/Makefile
> +++ b/drivers/gpu/drm/etnaviv/Makefile
> @@ -14,6 +14,7 @@ etnaviv-y := \
>         etnaviv_iommu.o \
>         etnaviv_mmu.o \
>         etnaviv_perfmon.o \
> +       etnaviv_flop_reset.o \
>         etnaviv_sched.o
>
>  obj-$(CONFIG_DRM_ETNAVIV)      += etnaviv.o
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_buffer.c b/drivers/gpu/drm/etnaviv/etnaviv_buffer.c
> index 9e007d977efe..a2da3212592f 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_buffer.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_buffer.c
> @@ -18,6 +18,8 @@
>  #include "state_3d.xml.h"
>  #include "cmdstream.xml.h"
>
> +#include "etnaviv_flop_reset.h"
> +
>  static void etnaviv_cmd_select_pipe(struct etnaviv_gpu *gpu,
>         struct etnaviv_cmdbuf *buffer, u8 pipe)
>  {
> @@ -100,6 +102,10 @@ u16 etnaviv_buffer_init(struct etnaviv_gpu *gpu)
>         /* initialize buffer */
>         buffer->user_size = 0;
>
> +       /* Queue in PPU flop reset */
> +       if (etnaviv_flop_reset_ppu_require(&gpu->identity))
> +               etnaviv_flop_reset_ppu_run(gpu);
> +
>         CMD_WAIT(buffer, gpu->fe_waitcycles);
>         CMD_LINK(buffer, 2,
>                  etnaviv_cmdbuf_get_va(buffer, &gpu->mmu_context->cmdbuf_mapping)
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> index 3e91747ed339..0e916e6785c8 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> @@ -600,6 +600,9 @@ static void etnaviv_unbind(struct device *dev)
>
>         component_unbind_all(dev, drm);
>
> +       etnaviv_cmdbuf_free(priv->flop_reset_data_ppu);
> +       kfree(priv->flop_reset_data_ppu);
> +
>         etnaviv_cmdbuf_suballoc_destroy(priv->cmdbuf_suballoc);
>
>         xa_destroy(&priv->active_contexts);
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.h b/drivers/gpu/drm/etnaviv/etnaviv_drv.h
> index b3eb1662e90c..20dad16fd554 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_drv.h
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.h
> @@ -48,6 +48,9 @@ struct etnaviv_drm_private {
>         /* list of GEM objects: */
>         struct mutex gem_lock;
>         struct list_head gem_list;
> +
> +       /* ppu flop reset data */
> +       struct etnaviv_cmdbuf *flop_reset_data_ppu;
>  };
>
>  int etnaviv_ioctl_gem_submit(struct drm_device *dev, void *data,
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_flop_reset.c b/drivers/gpu/drm/etnaviv/etnaviv_flop_reset.c
> new file mode 100644
> index 000000000000..138af3c33b5d
> --- /dev/null
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_flop_reset.c
> @@ -0,0 +1,206 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2025 Etnaviv Project
> + */
> +
> +#include "asm-generic/int-ll64.h"

I think you want to use #include <linux/types.h>


> +#include "etnaviv_buffer.h"
> +#include "etnaviv_cmdbuf.h"
> +#include "state_3d.xml.h"
> +
> +#include "etnaviv_flop_reset.h"
> +
> +enum etnaviv_flop_reset_type {
> +       flop_reset_ppu = 1 << 0,
> +       flop_reset_nn = 1 << 1,
> +       flop_reset_tp = 1 << 2
> +};

As this patch series only adds support for flop_reset_ppu I think we should
drop this enum for now.

> +
> +#define PPU_IMAGE_STRIDE 64
> +#define PPU_IMAGE_XSIZE 64
> +#define PPU_IMAGE_YSIZE 6
> +
> +#define PPU_FLOP_RESET_INSTR_DWORD_COUNT 16
> +
> +static void
> +etnaviv_emit_flop_reset_state_ppu(struct etnaviv_cmdbuf *cmdbuf,

Return type on separate line is unusual in kernel code - found in
multiple places.


> +                                 u32 buffer_base,
> +                                 u32 input_offset,
> +                                 u32 output_offset,
> +                                 u32 shader_offset,
> +                                 u32 shader_size,
> +                                 u32 shader_register_count)
> +{
> +       CMD_LOAD_STATE(cmdbuf, VIVS_GL_API_MODE,
> +                              VIVS_GL_API_MODE_OPENCL);
> +       CMD_SEM(cmdbuf, SYNC_RECIPIENT_FE, SYNC_RECIPIENT_PE);
> +       CMD_STALL(cmdbuf, SYNC_RECIPIENT_FE, SYNC_RECIPIENT_PE);
> +
> +       CMD_LOAD_STATES_START(cmdbuf, VIVS_SH_HALTI5_UNIFORMS(0), 4);
> +
> +       OUT(cmdbuf, buffer_base + input_offset);
> +       OUT(cmdbuf, PPU_IMAGE_STRIDE);
> +       OUT(cmdbuf, PPU_IMAGE_XSIZE | (PPU_IMAGE_YSIZE  << 16));
> +       OUT(cmdbuf, 0x444051f0);
> +       OUT(cmdbuf, 0xffffffff);
> +
> +       CMD_LOAD_STATES_START(cmdbuf, VIVS_SH_HALTI5_UNIFORMS(4), 4);
> +       OUT(cmdbuf, buffer_base + output_offset);
> +       OUT(cmdbuf, PPU_IMAGE_STRIDE);
> +       OUT(cmdbuf, PPU_IMAGE_XSIZE | (PPU_IMAGE_YSIZE  << 16));
> +       OUT(cmdbuf, 0x444051f0);
> +       OUT(cmdbuf, 0xffffffff);
> +
> +       CMD_LOAD_STATE(cmdbuf, VIVS_CL_CONFIG,
> +                              VIVS_CL_CONFIG_DIMENSIONS(2) |
> +                              VIVS_CL_CONFIG_VALUE_ORDER(3));
> +       CMD_LOAD_STATE(cmdbuf, VIVS_VS_ICACHE_INVALIDATE, 0x1f);
> +       CMD_LOAD_STATE(cmdbuf, VIVS_PS_VARYING_NUM_COMPONENTS(0), 0);
> +       CMD_LOAD_STATE(cmdbuf, VIVS_PS_TEMP_REGISTER_CONTROL,
> +                              shader_register_count);
> +       CMD_LOAD_STATE(cmdbuf, VIVS_PS_SAMPLER_BASE, 0x0);
> +       CMD_LOAD_STATE(cmdbuf, VIVS_PS_UNIFORM_BASE, 0x0);
> +       CMD_LOAD_STATE(cmdbuf, VIVS_PS_NEWRANGE_LOW, 0x0);
> +       CMD_LOAD_STATE(cmdbuf, VIVS_PS_NEWRANGE_HIGH,
> +                              shader_size / 16);
> +       CMD_LOAD_STATE(cmdbuf, VIVS_PS_INST_ADDR,
> +                              buffer_base + shader_offset);
> +       CMD_LOAD_STATE(cmdbuf, VIVS_SH_CONFIG,
> +                              VIVS_SH_CONFIG_RTNE_ROUNDING);
> +       CMD_LOAD_STATE(cmdbuf, VIVS_VS_ICACHE_CONTROL,
> +                              VIVS_VS_ICACHE_CONTROL_ENABLE);
> +       CMD_LOAD_STATE(cmdbuf, VIVS_PS_ICACHE_COUNT,
> +                              shader_size / 16 - 1);
> +       CMD_LOAD_STATE(cmdbuf, VIVS_PS_INPUT_COUNT, 0x1f01);
> +       CMD_LOAD_STATE(cmdbuf, VIVS_VS_HALTI5_UNK008A0, 0x0);
> +       CMD_LOAD_STATE(cmdbuf, VIVS_PA_VS_OUTPUT_COUNT, 0x0);
> +       CMD_LOAD_STATE(cmdbuf, VIVS_GL_VARYING_TOTAL_COMPONENTS, 0x0);
> +       CMD_LOAD_STATE(cmdbuf, VIVS_PS_CONTROL_EXT, 0x0);
> +       CMD_LOAD_STATE(cmdbuf, VIVS_VS_OUTPUT_COUNT, 0x1);
> +       CMD_LOAD_STATE(cmdbuf, VIVS_GL_HALTI5_SH_SPECIALS, 0x0);
> +       CMD_LOAD_STATE(cmdbuf, VIVS_PS_ICACHE_PREFETCH, 0x0);
> +       CMD_LOAD_STATE(cmdbuf, VIVS_CL_UNK00924, 0x0);
> +       CMD_LOAD_STATE(cmdbuf, VIVS_CL_THREAD_ALLOCATION, 0x1);
> +
> +       CMD_LOAD_STATE(cmdbuf, VIVS_CL_GLOBAL_WORK_OFFSET_X, 0x0);
> +       CMD_LOAD_STATE(cmdbuf, VIVS_CL_GLOBAL_WORK_OFFSET_Y, 0x0);
> +       CMD_LOAD_STATE(cmdbuf, VIVS_CL_GLOBAL_WORK_OFFSET_Z, 0x0);
> +
> +       CMD_LOAD_STATES_START(cmdbuf, VIVS_CL_WORKGROUP_COUNT_X, 9);
> +       OUT(cmdbuf, 0xf);
> +       OUT(cmdbuf, 0x5);
> +       OUT(cmdbuf, 0xffffffff);
> +       OUT(cmdbuf, 0x0);
> +       OUT(cmdbuf, 0x0);
> +       OUT(cmdbuf, 0x3ff);
> +       OUT(cmdbuf, 0x0);
> +       OUT(cmdbuf, 0x4);
> +       OUT(cmdbuf, 0x1);
> +       OUT(cmdbuf, 0x0);
> +
> +       CMD_LOAD_STATE(cmdbuf, VIVS_CL_KICKER, 0xbadabeeb);
> +       CMD_LOAD_STATE(cmdbuf, VIVS_GL_FLUSH_CACHE,
> +                              VIVS_GL_FLUSH_CACHE_SHADER_L1 |
> +                              VIVS_GL_FLUSH_CACHE_UNK10 |
> +                              VIVS_GL_FLUSH_CACHE_UNK11);
> +}
> +
> +static void
> +etnaviv_flop_reset_ppu_fill_input(u32 *buffer, u32 size)
> +{
> +       for (int i = 0; i < size/4; ++i, ++buffer)
> +               *buffer = 0x01010101;

Maybe just use memset32(..)?

> +}
> +
> +static void
> +etnaviv_flop_reset_ppu_set_shader(u8 *dest)
> +{
> +       const u32 inst[PPU_FLOP_RESET_INSTR_DWORD_COUNT] = {

static const

> +               /* img_load.u8 r1, c0, r0.xy */
> +               0x78011779, 0x39000804, 0x00A90050, 0x00000000,
> +               /* img_load.u8 r2, c0, r0.xy */
> +               0x78021779, 0x39000804, 0x00A90050, 0x00000000,
> +               /* dp2x8 r1, r1, r2, c3_512 */
> +               0xB8017145, 0x390018FC, 0x01C90140, 0x40390028,
> +               /* img_store.u8 r1, c2, r0.xy, r1 */
> +               0x380007BA, 0x39001804, 0x00A90050, 0x00390018,
> +       };
> +       memcpy(dest, inst, sizeof(inst));
> +}
> +
> +static struct etnaviv_flop_reset_entry {

static const

> +       u16 chip_model;
> +       u16 revision;
> +       u32 flags;
> +} etnaviv_flop_reset_db [] = {
> +       {
> +               .chip_model = 0x8000,
> +               .revision = 0x6205,
> +               .flags = flop_reset_ppu
> +       },
> +};
> +
> +bool
> +etnaviv_flop_reset_ppu_require(const struct etnaviv_chip_identity *chip_id)
> +{
> +       const struct etnaviv_flop_reset_entry *e = etnaviv_flop_reset_db;
> +
> +       for (int i = 0; i < ARRAY_SIZE(etnaviv_flop_reset_db); ++i, ++e) {
> +               if (chip_id->model == e->chip_model &&
> +                   chip_id->revision == e->revision)
> +                       return (e->flags & flop_reset_ppu) != 0;
> +       }
> +
> +       return false;
> +}
> +
> +static const u32 image_data_size = PPU_IMAGE_STRIDE * PPU_IMAGE_YSIZE;
> +static const u32 output_offset = ALIGN(image_data_size, 64);
> +static const u32 shader_offset = ALIGN(output_offset + image_data_size, 64);
> +static const u32 shader_size = PPU_FLOP_RESET_INSTR_DWORD_COUNT * sizeof(u32);
> +static const u32 shader_register_count = 3;
> +static const u32 buffer_size = shader_offset + shader_size;
> +
> +void
I think we need to return an error here - so let's go with an int.

> +etnaviv_flop_reset_ppu_init(struct etnaviv_drm_private *priv)
> +{
> +       /* Get some space from the rung buffer to put the payload
> +        * (input and output image, and shader), we keep this buffer
> +        * for the whole life time the driver is bound
> +        */
> +       priv->flop_reset_data_ppu =
> +         kzalloc(sizeof(*priv->flop_reset_data_ppu), GFP_KERNEL);
> +

Missing NULL check for priv->flop_reset_data_ppu.

> +       etnaviv_cmdbuf_init(priv->cmdbuf_suballoc,
> +                           priv->flop_reset_data_ppu, buffer_size);
> +

etnaviv_cmdbuf_init can fail too.


> +       void *buffer_base = priv->flop_reset_data_ppu->vaddr;
> +
> +       u32 *input_data = (u32 *)buffer_base;
> +       etnaviv_flop_reset_ppu_fill_input(input_data, image_data_size);
> +
> +       u8 *shader_data = (u8 *)buffer_base + shader_offset;
> +       etnaviv_flop_reset_ppu_set_shader(shader_data);
> +}
> +
> +void
> +etnaviv_flop_reset_ppu_run(struct etnaviv_gpu *gpu)
> +{
> +       struct etnaviv_drm_private *priv = gpu->drm->dev_private;
> +
> +       if (!priv->flop_reset_data_ppu) {
> +               pr_err("Flop reset data was not initialized, skipping\n");

dev_err(gpu->dev, "Flop reset data was not initialized, skipping\n");


> +               return;
> +       }

How can this happen?

> +
> +       u32 buffer_base = etnaviv_cmdbuf_get_va(priv->flop_reset_data_ppu,
> +                                               &gpu->mmu_context->cmdbuf_mapping);
> +
> +       etnaviv_emit_flop_reset_state_ppu(&gpu->buffer,
> +                                         buffer_base,
> +                                         0,
> +                                         output_offset,
> +                                         shader_offset,
> +                                         shader_size,
> +                                         shader_register_count);
> +}
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_flop_reset.h b/drivers/gpu/drm/etnaviv/etnaviv_flop_reset.h
> new file mode 100644
> index 000000000000..f51cece75507
> --- /dev/null
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_flop_reset.h
> @@ -0,0 +1,25 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2025 Etnaviv Project
> + */
> +
> +
> +#ifndef etnaviv_flop_reset_h
> +#define etnaviv_flop_reset_h

To keep the style consistent: __ETNAVIV_FLOP_RESET_H__

> +
> +#include <linux/types.h>
> +
> +struct etnaviv_chip_identity;
> +struct etnaviv_drm_private;
> +struct etnaviv_gpu;
> +
> +bool
> +etnaviv_flop_reset_ppu_require(const struct etnaviv_chip_identity *chip_id);
> +
> +void
> +etnaviv_flop_reset_ppu_init(struct etnaviv_drm_private *priv);
> +
> +void
> +etnaviv_flop_reset_ppu_run(struct etnaviv_gpu *gpu);
> +
> +#endif
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> index cf0d9049bcf1..0aac01c1021c 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> @@ -18,6 +18,7 @@
>
>  #include "etnaviv_cmdbuf.h"
>  #include "etnaviv_dump.h"
> +#include "etnaviv_flop_reset.h"
>  #include "etnaviv_gpu.h"
>  #include "etnaviv_gem.h"
>  #include "etnaviv_mmu.h"
> @@ -837,6 +838,10 @@ int etnaviv_gpu_init(struct etnaviv_gpu *gpu)
>                 goto fail;
>         }
>
> +       if (etnaviv_flop_reset_ppu_require(&gpu->identity) &&
> +           !priv->flop_reset_data_ppu)
> +               etnaviv_flop_reset_ppu_init(priv);
> +
>         if (gpu->identity.nn_core_count > 0)
>                 dev_warn(gpu->dev, "etnaviv has been instantiated on a NPU, "
>                                     "for which the UAPI is still experimental\n");
> --
> 2.49.0
>

I am not sure about the overall code style - you did run checkpatch.pl ?

-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy

