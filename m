Return-Path: <linux-kernel+bounces-853551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D7ABDBF46
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 03:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BD22E353922
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 01:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272FD2F5A11;
	Wed, 15 Oct 2025 01:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OlytvY8D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4B81F4CB7
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 01:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760490386; cv=none; b=A3qtxN6xT9n3n0Ec1Lb8bpXto3ExolnCloLn4VGKWiaAc4GrmFObDISxisSl7pkUlELi+e/ND0ouX1vi6kGtbiSFp93yRorz4/P7LRiBCBM0tUU2rTlI2VRhxk1YFXoiG3GKFDnmJMxIE/G/IbhcI0874aogjLpTWjP5JQSl/Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760490386; c=relaxed/simple;
	bh=Vk1lrgPurXAknx6HrWG/oTlNSpwnWyUers21qLRD/3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NBtThX/OPMovuJxj1q8ONJHDHWXa5Yt6GpuyOB5fW5bQd2WYMwC1LVkqFkHbfyh9a6zWZnvuTNUeXknpJHecsbxVbzTijbzYeCnicugYwTZ7h47HVzQn8WE1+B8LbplmeRHsOw5KPUAjURkQmS4kkKmMij5cG1zfkOwg2mkBtdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OlytvY8D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D60DDC4CEE7
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 01:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760490386;
	bh=Vk1lrgPurXAknx6HrWG/oTlNSpwnWyUers21qLRD/3o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OlytvY8DCGQHNwNGViqrG14+BgGCnwMOx1HF/c13PUyOrqroR0jjt2fRNkGR464bJ
	 j9KlibkuxCi6HkwOSarfmq4uDClGy+gb99q10/ALluu9vnALbUOIPyFBB9UQWhggZ8
	 n+025zf7nvYrJ3CsgOhGD+Jkh9qQ63R+pPGtW0ZN8KkYaQQrs2GQnThFk1zEddIT69
	 nIWC+PleNKHsKEdmXNr8ZA8LyjIrcjQXP29t7oed5BV3qyYYJhYpdzzOcwhzqRQCBB
	 km5lkbjJhTa5d+ybO9q1Jnf9kNV+6GxCfJjUHhPTW+nMZGQiGB+5+TcPwORUgpqyPE
	 2M3Su+4GF/Lnw==
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-46e34052bb7so69149795e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 18:06:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX8dwWWvNQ6rWXFjGb93ZLuDW/I30w9KwiTZ8Ru1gsvELqX6wwHrA1KzcSHrUJUiiDvRpPN9kerEUqdyc0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTeYt1mryNTzoRyVovZpfawyzOS6lhr69rf4Va07vywZXBf0l1
	wHl6Tj+yQbfDdZQ9qWfnAL+4q+KvIlDcAs2DMM+ENGaSwPcO9JJUajGDIv0LzWlxWbhjhqvhr3m
	D5liAYHbqNn/h39xyNmZC67nEf7WeDkA=
X-Google-Smtp-Source: AGHT+IFvlJdJ5ZemJ2mSMLr50Z3vP8yBvP5X6SzwsTDjk1XfhZ0VfxH/ZDZzV+SK22oH6TNYSbR8d+qJlMoRlbC8mWM=
X-Received: by 2002:a05:600c:1c23:b0:45b:6b57:5308 with SMTP id
 5b1f17b1804b1-46fa9a892a0mr193082905e9.7.1760490384395; Tue, 14 Oct 2025
 18:06:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014131032.49616-1-ziyao@disroot.org> <20251014131032.49616-5-ziyao@disroot.org>
In-Reply-To: <20251014131032.49616-5-ziyao@disroot.org>
From: Guo Ren <guoren@kernel.org>
Date: Wed, 15 Oct 2025 09:06:11 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQs41jhgwANjHHgDx__w4+5Oz2aLrJn4k+11gUc6k8sCA@mail.gmail.com>
X-Gm-Features: AS18NWDETor3dr3MULxaWJJAKtT5InIH2LCqTA8s_I7h9Q5D4vFtEPTv0drKJu8
Message-ID: <CAJF2gTQs41jhgwANjHHgDx__w4+5Oz2aLrJn4k+11gUc6k8sCA@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] reset: th1520: Support reset controllers in more subsystems
To: Yao Zi <ziyao@disroot.org>
Cc: Drew Fustini <fustini@kernel.org>, Fu Wei <wefu@redhat.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Michal Wilczynski <m.wilczynski@samsung.com>, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Icenowy Zheng <uwu@icenowy.me>, Han Gao <rabenda.cn@gmail.com>, Han Gao <gaohan@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 9:12=E2=80=AFPM Yao Zi <ziyao@disroot.org> wrote:
>
> Introduce reset controllers for AP, MISC, VI, VP and DSP subsystems and
> add their reset signal mappings.
>
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---
>  drivers/reset/reset-th1520.c | 793 +++++++++++++++++++++++++++++++++++
>  1 file changed, 793 insertions(+)
>
> diff --git a/drivers/reset/reset-th1520.c b/drivers/reset/reset-th1520.c
> index 2b65a95ed021..fd32e991c4cb 100644
> --- a/drivers/reset/reset-th1520.c
> +++ b/drivers/reset/reset-th1520.c
> @@ -11,6 +11,85 @@
>
>  #include <dt-bindings/reset/thead,th1520-reset.h>
>
> + /* register offset in RSTGEN_R */
> +#define TH1520_BROM_RST_CFG            0x0
> +#define TH1520_C910_RST_CFG            0x4
> +#define TH1520_CHIP_DBG_RST_CFG                0xc
> +#define TH1520_AXI4_CPUSYS2_RST_CFG    0x10
> +#define TH1520_X2H_CPUSYS_RST_CFG      0x18
> +#define TH1520_AHB2_CPUSYS_RST_CFG     0x1c
> +#define TH1520_APB3_CPUSYS_RST_CFG     0x20
> +#define TH1520_MBOX0_RST_CFG           0x24
> +#define TH1520_MBOX1_RST_CFG           0x28
> +#define TH1520_MBOX2_RST_CFG           0x2c
> +#define TH1520_MBOX3_RST_CFG           0x30
> +#define TH1520_WDT0_RST_CFG            0x34
> +#define TH1520_WDT1_RST_CFG            0x38
> +#define TH1520_TIMER0_RST_CFG          0x3c
> +#define TH1520_TIMER1_RST_CFG          0x40
> +#define TH1520_PERISYS_AHB_RST_CFG     0x44
> +#define TH1520_PERISYS_APB1_RST_CFG    0x48
> +#define TH1520_PERISYS_APB2_RST_CFG    0x4c
> +#define TH1520_GMAC0_RST_CFG           0x68
> +#define TH1520_UART0_RST_CFG           0x70
> +#define TH1520_UART1_RST_CFG           0x74
> +#define TH1520_UART2_RST_CFG           0x78
> +#define TH1520_UART3_RST_CFG           0x7c
> +#define TH1520_UART4_RST_CFG           0x80
> +#define TH1520_UART5_RST_CFG           0x84
> +#define TH1520_QSPI0_RST_CFG           0x8c
> +#define TH1520_QSPI1_RST_CFG           0x90
> +#define TH1520_SPI_RST_CFG             0x94
> +#define TH1520_I2C0_RST_CFG            0x98
> +#define TH1520_I2C1_RST_CFG            0x9c
> +#define TH1520_I2C2_RST_CFG            0xa0
> +#define TH1520_I2C3_RST_CFG            0xa4
> +#define TH1520_I2C4_RST_CFG            0xa8
> +#define TH1520_I2C5_RST_CFG            0xac
> +#define TH1520_GPIO0_RST_CFG           0xb0
> +#define TH1520_GPIO1_RST_CFG           0xb4
> +#define TH1520_GPIO2_RST_CFG           0xb8
> +#define TH1520_PWM_RST_CFG             0xc0
> +#define TH1520_PADCTRL0_APSYS_RST_CFG  0xc4
> +#define TH1520_CPU2PERI_X2H_RST_CFG    0xcc
> +#define TH1520_CPU2AON_X2H_RST_CFG     0xe4
> +#define TH1520_AON2CPU_A2X_RST_CFG     0xfc
> +#define TH1520_NPUSYS_AXI_RST_CFG      0x128
> +#define TH1520_CPU2VP_X2P_RST_CFG      0x12c
> +#define TH1520_CPU2VI_X2H_RST_CFG      0x138
> +#define TH1520_BMU_C910_RST_CFG                0x148
> +#define TH1520_DMAC_CPUSYS_RST_CFG     0x14c
> +#define TH1520_SPINLOCK_RST_CFG                0x178
> +#define TH1520_CFG2TEE_X2H_RST_CFG     0x188
> +#define TH1520_DSMART_RST_CFG          0x18c
> +#define TH1520_GPIO3_RST_CFG           0x1a8
> +#define TH1520_I2S_RST_CFG             0x1ac
> +#define TH1520_IMG_NNA_RST_CFG         0x1b0
> +#define TH1520_PERI_APB3_RST_CFG       0x1dc
> +#define TH1520_VP_SUBSYS_RST_CFG       0x1ec
> +#define TH1520_PERISYS_APB4_RST_CFG    0x1f8
> +#define TH1520_GMAC1_RST_CFG           0x204
> +#define TH1520_GMAC_AXI_RST_CFG                0x208
> +#define TH1520_PADCTRL1_APSYS_RST_CFG  0x20c
> +#define TH1520_VOSYS_AXI_RST_CFG       0x210
> +#define TH1520_VOSYS_X2X_RST_CFG       0x214
> +#define TH1520_MISC2VP_X2X_RST_CFG     0x218
> +#define TH1520_SUBSYS_RST_CFG          0x220
> +
> + /* register offset in DSP_REGMAP */
> +#define TH1520_DSPSYS_RST_CFG          0x0
> +
> + /* register offset in MISCSYS_REGMAP */
> +#define TH1520_EMMC_RST_CFG            0x0
> +#define TH1520_MISCSYS_AXI_RST_CFG     0x8
> +#define TH1520_SDIO0_RST_CFG           0xc
> +#define TH1520_SDIO1_RST_CFG           0x10
> +#define TH1520_USB3_DRD_RST_CFG                0x14
> +
> + /* register offset in VISYS_REGMAP */
> +#define TH1520_VISYS_RST_CFG           0x0
> +#define TH1520_VISYS_2_RST_CFG         0x4
> +
>   /* register offset in VOSYS_REGMAP */
>  #define TH1520_GPU_RST_CFG             0x0
>  #define TH1520_GPU_RST_CFG_MASK                GENMASK(1, 0)
> @@ -18,6 +97,8 @@
>  #define TH1520_DSI0_RST_CFG            0x8
>  #define TH1520_DSI1_RST_CFG            0xc
>  #define TH1520_HDMI_RST_CFG            0x14
> +#define TH1520_AXI4_VO_DW_AXI_RST_CFG  0x18
> +#define TH1520_X2H_X4_VOSYS_DW_RST_CFG 0x20
>
>  /* register values */
>  #define TH1520_GPU_SW_GPU_RST          BIT(0)
> @@ -29,6 +110,13 @@
>  #define TH1520_HDMI_SW_MAIN_RST                BIT(0)
>  #define TH1520_HDMI_SW_PRST            BIT(1)
>
> + /* register offset in VPSYS_REGMAP */
> +#define TH1520_AXIBUS_RST_CFG          0x0
> +#define TH1520_FCE_RST_CFG             0x4
> +#define TH1520_G2D_RST_CFG             0x8
> +#define TH1520_VDEC_RST_CFG            0xc
> +#define TH1520_VENC_RST_CFG            0x10
> +
>  struct th1520_reset_map {
>         u32 bit;
>         u32 reg;
> @@ -82,6 +170,681 @@ static const struct th1520_reset_map th1520_resets[]=
 =3D {
>                 .bit =3D TH1520_HDMI_SW_PRST,
>                 .reg =3D TH1520_HDMI_RST_CFG,
>         },
> +       [TH1520_RESET_ID_VOAXI] =3D {
> +               .bit =3D BIT(0),
> +               .reg =3D TH1520_AXI4_VO_DW_AXI_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_VOAXI_APB] =3D {
> +               .bit =3D BIT(1),
> +               .reg =3D TH1520_AXI4_VO_DW_AXI_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_X2H_DPU_AXI] =3D {
> +               .bit =3D BIT(0),
> +               .reg =3D TH1520_X2H_X4_VOSYS_DW_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_X2H_DPU_AHB] =3D {
> +               .bit =3D BIT(1),
> +               .reg =3D TH1520_X2H_X4_VOSYS_DW_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_X2H_DPU1_AXI] =3D {
> +               .bit =3D BIT(2),
> +               .reg =3D TH1520_X2H_X4_VOSYS_DW_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_X2H_DPU1_AHB] =3D {
> +               .bit =3D BIT(3),
> +               .reg =3D TH1520_X2H_X4_VOSYS_DW_RST_CFG,
> +       },
> +};
> +
> +static const struct th1520_reset_map th1520_ap_resets[] =3D {
> +       [TH1520_RESET_ID_BROM] =3D {
> +               .bit =3D BIT(0),
> +               .reg =3D TH1520_BROM_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_C910_TOP] =3D {
> +               .bit =3D BIT(0),
> +               .reg =3D TH1520_C910_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_NPU] =3D  {
> +               .bit =3D BIT(0),
> +               .reg =3D TH1520_IMG_NNA_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_WDT0] =3D {
> +               .bit =3D BIT(0),
> +               .reg =3D TH1520_WDT0_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_WDT1] =3D {
> +               .bit =3D BIT(0),
> +               .reg =3D TH1520_WDT1_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_C910_C0] =3D {
> +               .bit =3D BIT(1),
> +               .reg =3D TH1520_C910_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_C910_C1] =3D {
> +               .bit =3D BIT(2),
> +               .reg =3D TH1520_C910_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_C910_C2] =3D {
> +               .bit =3D BIT(3),
> +               .reg =3D TH1520_C910_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_C910_C3] =3D {
> +               .bit =3D BIT(4),
> +               .reg =3D TH1520_C910_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_CHIP_DBG_CORE] =3D {
> +               .bit =3D BIT(0),
> +               .reg =3D TH1520_CHIP_DBG_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_CHIP_DBG_AXI] =3D {
> +               .bit =3D BIT(1),
> +               .reg =3D TH1520_CHIP_DBG_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_AXI4_CPUSYS2_AXI] =3D {
> +               .bit =3D BIT(0),
> +               .reg =3D TH1520_AXI4_CPUSYS2_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_AXI4_CPUSYS2_APB] =3D {
> +               .bit =3D BIT(1),
> +               .reg =3D TH1520_AXI4_CPUSYS2_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_X2H_CPUSYS] =3D {
> +               .bit =3D BIT(0),
> +               .reg =3D TH1520_X2H_CPUSYS_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_AHB2_CPUSYS] =3D {
> +               .bit =3D BIT(0),
> +               .reg =3D TH1520_AHB2_CPUSYS_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_APB3_CPUSYS] =3D {
> +               .bit =3D BIT(0),
> +               .reg =3D TH1520_APB3_CPUSYS_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_MBOX0_APB] =3D {
> +               .bit =3D BIT(0),
> +               .reg =3D TH1520_MBOX0_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_MBOX1_APB] =3D {
> +               .bit =3D BIT(0),
> +               .reg =3D TH1520_MBOX1_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_MBOX2_APB] =3D {
> +               .bit =3D BIT(0),
> +               .reg =3D TH1520_MBOX2_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_MBOX3_APB] =3D {
> +               .bit =3D BIT(0),
> +               .reg =3D TH1520_MBOX3_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_TIMER0_APB] =3D {
> +               .bit =3D BIT(0),
> +               .reg =3D TH1520_TIMER0_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_TIMER0_CORE] =3D {
> +               .bit =3D BIT(1),
> +               .reg =3D TH1520_TIMER0_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_TIMER1_APB] =3D {
> +               .bit =3D BIT(0),
> +               .reg =3D TH1520_TIMER1_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_TIMER1_CORE] =3D {
> +               .bit =3D BIT(1),
> +               .reg =3D TH1520_TIMER1_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_PERISYS_AHB] =3D {
> +               .bit =3D BIT(0),
> +               .reg =3D TH1520_PERISYS_AHB_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_PERISYS_APB1] =3D {
> +               .bit =3D BIT(0),
> +               .reg =3D TH1520_PERISYS_APB1_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_PERISYS_APB2] =3D {
> +               .bit =3D BIT(0),
> +               .reg =3D TH1520_PERISYS_APB2_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_GMAC0_APB] =3D {
> +               .bit =3D BIT(0),
> +               .reg =3D TH1520_GMAC0_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_GMAC0_AHB] =3D {
> +               .bit =3D BIT(1),
> +               .reg =3D TH1520_GMAC0_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_GMAC0_CLKGEN] =3D {
> +               .bit =3D BIT(2),
> +               .reg =3D TH1520_GMAC0_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_GMAC0_AXI] =3D {
> +               .bit =3D BIT(3),
> +               .reg =3D TH1520_GMAC0_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_UART0_APB] =3D {
> +               .bit =3D BIT(0),
> +               .reg =3D TH1520_UART0_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_UART0_IF] =3D {
> +               .bit =3D BIT(1),
> +               .reg =3D TH1520_UART0_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_UART1_APB] =3D {
> +               .bit =3D BIT(0),
> +               .reg =3D TH1520_UART1_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_UART1_IF] =3D {
> +               .bit =3D BIT(1),
> +               .reg =3D TH1520_UART1_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_UART2_APB] =3D {
> +               .bit =3D BIT(0),
> +               .reg =3D TH1520_UART2_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_UART2_IF] =3D {
> +               .bit =3D BIT(1),
> +               .reg =3D TH1520_UART2_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_UART3_APB] =3D {
> +               .bit =3D BIT(0),
> +               .reg =3D TH1520_UART3_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_UART3_IF] =3D {
> +               .bit =3D BIT(1),
> +               .reg =3D TH1520_UART3_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_UART4_APB] =3D {
> +               .bit =3D BIT(0),
> +               .reg =3D TH1520_UART4_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_UART4_IF] =3D {
> +               .bit =3D BIT(1),
> +               .reg =3D TH1520_UART4_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_UART5_APB] =3D {
> +               .bit =3D BIT(0),
> +               .reg =3D TH1520_UART5_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_UART5_IF] =3D {
> +               .bit =3D BIT(1),
> +               .reg =3D TH1520_UART5_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_QSPI0_IF] =3D {
> +               .bit =3D BIT(0),
> +               .reg =3D TH1520_QSPI0_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_QSPI0_APB] =3D {
> +               .bit =3D BIT(1),
> +               .reg =3D TH1520_QSPI0_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_QSPI1_IF] =3D {
> +               .bit =3D BIT(0),
> +               .reg =3D TH1520_QSPI1_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_QSPI1_APB] =3D {
> +               .bit =3D BIT(1),
> +               .reg =3D TH1520_QSPI1_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_SPI_IF] =3D {
> +               .bit =3D BIT(0),
> +               .reg =3D TH1520_SPI_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_SPI_APB] =3D {
> +               .bit =3D BIT(1),
> +               .reg =3D TH1520_SPI_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_I2C0_APB] =3D {
> +               .bit =3D BIT(0),
> +               .reg =3D TH1520_I2C0_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_I2C0_CORE] =3D {
> +               .bit =3D BIT(1),
> +               .reg =3D TH1520_I2C0_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_I2C1_APB] =3D {
> +               .bit =3D BIT(0),
> +               .reg =3D TH1520_I2C1_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_I2C1_CORE] =3D {
> +               .bit =3D BIT(1),
> +               .reg =3D TH1520_I2C1_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_I2C2_APB] =3D {
> +               .bit =3D BIT(0),
> +               .reg =3D TH1520_I2C2_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_I2C2_CORE] =3D {
> +               .bit =3D BIT(1),
> +               .reg =3D TH1520_I2C2_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_I2C3_APB] =3D {
> +               .bit =3D BIT(0),
> +               .reg =3D TH1520_I2C3_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_I2C3_CORE] =3D {
> +               .bit =3D BIT(1),
> +               .reg =3D TH1520_I2C3_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_I2C4_APB] =3D {
> +               .bit =3D BIT(0),
> +               .reg =3D TH1520_I2C4_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_I2C4_CORE] =3D {
> +               .bit =3D BIT(1),
> +               .reg =3D TH1520_I2C4_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_I2C5_APB] =3D {
> +               .bit =3D BIT(0),
> +               .reg =3D TH1520_I2C5_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_I2C5_CORE] =3D {
> +               .bit =3D BIT(1),
> +               .reg =3D TH1520_I2C5_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_GPIO0_DB] =3D {
> +               .bit =3D BIT(0),
> +               .reg =3D TH1520_GPIO0_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_GPIO0_APB] =3D {
> +               .bit =3D BIT(1),
> +               .reg =3D TH1520_GPIO0_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_GPIO1_DB] =3D {
> +               .bit =3D BIT(0),
> +               .reg =3D TH1520_GPIO1_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_GPIO1_APB] =3D {
> +               .bit =3D BIT(1),
> +               .reg =3D TH1520_GPIO1_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_GPIO2_DB] =3D {
> +               .bit =3D BIT(0),
> +               .reg =3D TH1520_GPIO2_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_GPIO2_APB] =3D {
> +               .bit =3D BIT(1),
> +               .reg =3D TH1520_GPIO2_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_PWM_COUNTER] =3D {
> +               .bit =3D BIT(0),
> +               .reg =3D TH1520_PWM_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_PWM_APB] =3D {
> +               .bit =3D BIT(1),
> +               .reg =3D TH1520_PWM_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_PADCTRL0_APB] =3D {
> +               .bit =3D BIT(0),
> +               .reg =3D TH1520_PADCTRL0_APSYS_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_CPU2PERI_X2H] =3D {
> +               .bit =3D BIT(1),
> +               .reg =3D TH1520_CPU2PERI_X2H_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_CPU2AON_X2H] =3D {
> +               .bit =3D BIT(0),
> +               .reg =3D TH1520_CPU2AON_X2H_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_AON2CPU_A2X] =3D {
> +               .bit =3D BIT(0),
> +               .reg =3D TH1520_AON2CPU_A2X_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_NPUSYS_AXI] =3D {
> +               .bit =3D BIT(0),
> +               .reg =3D TH1520_NPUSYS_AXI_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_NPUSYS_AXI_APB] =3D {
> +               .bit =3D BIT(1),
> +               .reg =3D TH1520_NPUSYS_AXI_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_CPU2VP_X2P] =3D {
> +               .bit =3D BIT(0),
> +               .reg =3D TH1520_CPU2VP_X2P_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_CPU2VI_X2H] =3D {
> +               .bit =3D BIT(0),
> +               .reg =3D TH1520_CPU2VI_X2H_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_BMU_AXI] =3D {
> +               .bit =3D BIT(0),
> +               .reg =3D TH1520_BMU_C910_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_BMU_APB] =3D {
> +               .bit =3D BIT(1),
> +               .reg =3D TH1520_BMU_C910_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_DMAC_CPUSYS_AXI] =3D {
> +               .bit =3D BIT(0),
> +               .reg =3D TH1520_DMAC_CPUSYS_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_DMAC_CPUSYS_AHB] =3D {
> +               .bit =3D BIT(1),
> +               .reg =3D TH1520_DMAC_CPUSYS_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_SPINLOCK] =3D {
> +               .bit =3D BIT(0),
> +               .reg =3D TH1520_SPINLOCK_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_CFG2TEE] =3D {
> +               .bit =3D BIT(0),
> +               .reg =3D TH1520_CFG2TEE_X2H_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_DSMART] =3D {
> +               .bit =3D BIT(0),
> +               .reg =3D TH1520_DSMART_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_GPIO3_DB] =3D {
> +               .bit =3D BIT(0),
> +               .reg =3D TH1520_GPIO3_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_GPIO3_APB] =3D {
> +               .bit =3D BIT(1),
> +               .reg =3D TH1520_GPIO3_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_PERI_I2S] =3D {
> +               .bit =3D BIT(0),
> +               .reg =3D TH1520_I2S_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_PERI_APB3] =3D {
> +               .bit =3D BIT(0),
> +               .reg =3D TH1520_PERI_APB3_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_PERI2PERI1_APB] =3D {
> +               .bit =3D BIT(1),
> +               .reg =3D TH1520_PERI_APB3_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_VPSYS_APB] =3D {
> +               .bit =3D BIT(0),
> +               .reg =3D TH1520_VP_SUBSYS_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_PERISYS_APB4] =3D {
> +               .bit =3D BIT(0),
> +               .reg =3D TH1520_PERISYS_APB4_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_GMAC1_APB] =3D {
> +               .bit =3D BIT(0),
> +               .reg =3D TH1520_GMAC1_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_GMAC1_AHB] =3D {
> +               .bit =3D BIT(1),
> +               .reg =3D TH1520_GMAC1_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_GMAC1_CLKGEN] =3D {
> +               .bit =3D BIT(2),
> +               .reg =3D TH1520_GMAC1_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_GMAC1_AXI] =3D {
> +               .bit =3D BIT(3),
> +               .reg =3D TH1520_GMAC1_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_GMAC_AXI] =3D {
> +               .bit =3D BIT(0),
> +               .reg =3D TH1520_GMAC_AXI_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_GMAC_AXI_APB] =3D {
> +               .bit =3D BIT(1),
> +               .reg =3D TH1520_GMAC_AXI_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_PADCTRL1_APB] =3D {
> +               .bit =3D BIT(0),
> +               .reg =3D TH1520_PADCTRL1_APSYS_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_VOSYS_AXI] =3D {
> +               .bit =3D BIT(0),
> +               .reg =3D TH1520_VOSYS_AXI_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_VOSYS_AXI_APB] =3D {
> +               .bit =3D BIT(1),
> +               .reg =3D TH1520_VOSYS_AXI_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_VOSYS_AXI_X2X] =3D {
> +               .bit =3D BIT(0),
> +               .reg =3D TH1520_VOSYS_X2X_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_MISC2VP_X2X] =3D {
> +               .bit =3D BIT(0),
> +               .reg =3D TH1520_MISC2VP_X2X_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_DSPSYS] =3D {
> +               .bit =3D BIT(0),
> +               .reg =3D TH1520_SUBSYS_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_VISYS] =3D {
> +               .bit =3D BIT(1),
> +               .reg =3D TH1520_SUBSYS_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_VOSYS] =3D {
> +               .bit =3D BIT(2),
> +               .reg =3D TH1520_SUBSYS_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_VPSYS] =3D {
> +               .bit =3D BIT(3),
> +               .reg =3D TH1520_SUBSYS_RST_CFG,
> +       },
> +};
> +
> +static const struct th1520_reset_map th1520_dsp_resets[] =3D {
> +       [TH1520_RESET_ID_X2X_DSP1] =3D {
> +               .bit =3D BIT(0),
> +               .reg =3D TH1520_DSPSYS_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_X2X_DSP0] =3D {
> +               .bit =3D BIT(1),
> +               .reg =3D TH1520_DSPSYS_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_X2X_SLAVE_DSP1] =3D {
> +               .bit =3D BIT(2),
> +               .reg =3D TH1520_DSPSYS_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_X2X_SLAVE_DSP0] =3D {
> +               .bit =3D BIT(3),
> +               .reg =3D TH1520_DSPSYS_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_DSP0_CORE] =3D {
> +               .bit =3D BIT(8),
> +               .reg =3D TH1520_DSPSYS_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_DSP0_DEBUG] =3D {
> +               .bit =3D BIT(9),
> +               .reg =3D TH1520_DSPSYS_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_DSP0_APB] =3D {
> +               .bit =3D BIT(10),
> +               .reg =3D TH1520_DSPSYS_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_DSP1_CORE] =3D {
> +               .bit =3D BIT(12),
> +               .reg =3D TH1520_DSPSYS_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_DSP1_DEBUG] =3D {
> +               .bit =3D BIT(13),
> +               .reg =3D TH1520_DSPSYS_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_DSP1_APB] =3D {
> +               .bit =3D BIT(14),
> +               .reg =3D TH1520_DSPSYS_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_DSPSYS_APB] =3D {
> +               .bit =3D BIT(16),
> +               .reg =3D TH1520_DSPSYS_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_AXI4_DSPSYS_SLV] =3D {
> +               .bit =3D BIT(20),
> +               .reg =3D TH1520_DSPSYS_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_AXI4_DSPSYS] =3D {
> +               .bit =3D BIT(24),
> +               .reg =3D TH1520_DSPSYS_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_AXI4_DSP_RS] =3D {
> +               .bit =3D BIT(26),
> +               .reg =3D TH1520_DSPSYS_RST_CFG,
> +       },
> +};
> +
> +static const struct th1520_reset_map th1520_misc_resets[] =3D {
> +       [TH1520_RESET_ID_EMMC_SDIO_CLKGEN] =3D {
> +               .bit =3D BIT(0),
> +               .reg =3D TH1520_EMMC_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_EMMC] =3D {
> +               .bit =3D BIT(1),
> +               .reg =3D TH1520_EMMC_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_MISCSYS_AXI] =3D {
> +               .bit =3D BIT(0),
> +               .reg =3D TH1520_MISCSYS_AXI_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_MISCSYS_AXI_APB] =3D {
> +               .bit =3D BIT(1),
> +               .reg =3D TH1520_MISCSYS_AXI_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_SDIO0] =3D {
> +               .bit =3D BIT(0),
> +               .reg =3D TH1520_SDIO0_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_SDIO1] =3D {
> +               .bit =3D BIT(1),
> +               .reg =3D TH1520_SDIO1_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_USB3_APB] =3D {
> +               .bit =3D BIT(0),
> +               .reg =3D TH1520_USB3_DRD_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_USB3_PHY] =3D {
> +               .bit =3D BIT(1),
> +               .reg =3D TH1520_USB3_DRD_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_USB3_VCC] =3D {
> +               .bit =3D BIT(2),
> +               .reg =3D TH1520_USB3_DRD_RST_CFG,
> +       },
> +};
> +
> +static const struct th1520_reset_map th1520_vi_resets[] =3D {
> +       [TH1520_RESET_ID_ISP0] =3D {
> +               .bit =3D BIT(0),
> +               .reg =3D TH1520_VISYS_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_ISP1] =3D {
> +               .bit =3D BIT(4),
> +               .reg =3D TH1520_VISYS_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_CSI0_APB] =3D {
> +               .bit =3D BIT(16),
> +               .reg =3D TH1520_VISYS_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_CSI1_APB] =3D {
> +               .bit =3D BIT(17),
> +               .reg =3D TH1520_VISYS_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_CSI2_APB] =3D {
> +               .bit =3D BIT(18),
> +               .reg =3D TH1520_VISYS_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_MIPI_FIFO] =3D {
> +               .bit =3D BIT(20),
> +               .reg =3D TH1520_VISYS_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_ISP_VENC_APB] =3D {
> +               .bit =3D BIT(24),
> +               .reg =3D TH1520_VISYS_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_VIPRE_APB] =3D {
> +               .bit =3D BIT(28),
> +               .reg =3D TH1520_VISYS_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_VIPRE_AXI] =3D {
> +               .bit =3D BIT(29),
> +               .reg =3D TH1520_VISYS_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_DW200_APB] =3D {
> +               .bit =3D BIT(31),
> +               .reg =3D TH1520_VISYS_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_VISYS3_AXI] =3D {
> +               .bit =3D BIT(8),
> +               .reg =3D TH1520_VISYS_2_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_VISYS2_AXI] =3D {
> +               .bit =3D BIT(9),
> +               .reg =3D TH1520_VISYS_2_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_VISYS1_AXI] =3D {
> +               .bit =3D BIT(10),
> +               .reg =3D TH1520_VISYS_2_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_VISYS_AXI] =3D {
> +               .bit =3D BIT(12),
> +               .reg =3D TH1520_VISYS_2_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_VISYS_APB] =3D {
> +               .bit =3D BIT(16),
> +               .reg =3D TH1520_VISYS_2_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_ISP_VENC_AXI] =3D {
> +               .bit =3D BIT(20),
> +               .reg =3D TH1520_VISYS_2_RST_CFG,
> +       },
> +};
> +
> +static const struct th1520_reset_map th1520_vp_resets[] =3D {
> +       [TH1520_RESET_ID_VPSYS_AXI_APB] =3D {
> +               .bit =3D BIT(0),
> +               .reg =3D TH1520_AXIBUS_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_VPSYS_AXI] =3D {
> +               .bit =3D BIT(1),
> +               .reg =3D TH1520_AXIBUS_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_FCE_APB] =3D {
> +               .bit =3D BIT(0),
> +               .reg =3D TH1520_FCE_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_FCE_CORE] =3D {
> +               .bit =3D BIT(1),
> +               .reg =3D TH1520_FCE_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_FCE_X2X_MASTER] =3D {
> +               .bit =3D BIT(4),
> +               .reg =3D TH1520_FCE_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_FCE_X2X_SLAVE] =3D {
> +               .bit =3D BIT(5),
> +               .reg =3D TH1520_FCE_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_G2D_APB] =3D {
> +               .bit =3D BIT(0),
> +               .reg =3D TH1520_G2D_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_G2D_ACLK] =3D {
> +               .bit =3D BIT(1),
> +               .reg =3D TH1520_G2D_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_G2D_CORE] =3D {
> +               .bit =3D BIT(2),
> +               .reg =3D TH1520_G2D_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_VDEC_APB] =3D {
> +               .bit =3D BIT(0),
> +               .reg =3D TH1520_VDEC_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_VDEC_ACLK] =3D {
> +               .bit =3D BIT(1),
> +               .reg =3D TH1520_VDEC_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_VDEC_CORE] =3D {
> +               .bit =3D BIT(2),
> +               .reg =3D TH1520_VDEC_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_VENC_APB] =3D {
> +               .bit =3D BIT(0),
> +               .reg =3D TH1520_VENC_RST_CFG,
> +       },
> +       [TH1520_RESET_ID_VENC_CORE] =3D {
> +               .bit =3D BIT(1),
> +               .reg =3D TH1520_VENC_RST_CFG,
> +       },
>  };
>
>  static inline struct th1520_reset_priv *
> @@ -170,8 +933,38 @@ static const struct th1520_reset_data th1520_reset_d=
ata =3D {
>         .num =3D ARRAY_SIZE(th1520_resets),
>  };
>
> +static const struct th1520_reset_data th1520_ap_reset_data =3D {
> +       .resets =3D th1520_ap_resets,
> +       .num =3D ARRAY_SIZE(th1520_ap_resets),
> +};
> +
> +static const struct th1520_reset_data th1520_dsp_reset_data =3D {
> +       .resets =3D th1520_dsp_resets,
> +       .num =3D ARRAY_SIZE(th1520_dsp_resets),
> +};
> +
> +static const struct th1520_reset_data th1520_misc_reset_data =3D {
> +       .resets =3D th1520_misc_resets,
> +       .num =3D ARRAY_SIZE(th1520_misc_resets),
> +};
> +
> +static const struct th1520_reset_data th1520_vi_reset_data =3D {
> +       .resets =3D th1520_vi_resets,
> +       .num =3D ARRAY_SIZE(th1520_vi_resets),
> +};
> +
> +static const struct th1520_reset_data th1520_vp_reset_data =3D {
> +       .resets =3D th1520_vp_resets,
> +       .num =3D ARRAY_SIZE(th1520_vp_resets),
> +};
> +
>  static const struct of_device_id th1520_reset_match[] =3D {
>         { .compatible =3D "thead,th1520-reset", .data =3D &th1520_reset_d=
ata },
> +       { .compatible =3D "thead,th1520-reset-ap", .data =3D &th1520_ap_r=
eset_data },
> +       { .compatible =3D "thead,th1520-reset-dsp", .data =3D &th1520_dsp=
_reset_data },
> +       { .compatible =3D "thead,th1520-reset-misc", .data =3D &th1520_mi=
sc_reset_data },
> +       { .compatible =3D "thead,th1520-reset-vi", .data =3D &th1520_vi_r=
eset_data },
> +       { .compatible =3D "thead,th1520-reset-vp", .data =3D &th1520_vp_r=
eset_data },
>         { /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, th1520_reset_match);
> --
> 2.50.1
>
LGTM!

Acked-by: Guo Ren <guoren@kernel.org>

--=20
Best Regards
 Guo Ren

