Return-Path: <linux-kernel+bounces-770132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 020F2B27722
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 05:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC61D7BE4B3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 03:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44FAB2BD5B0;
	Fri, 15 Aug 2025 03:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VESgFop9"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E242E1A9F8D
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 03:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755229861; cv=none; b=Dtd+T3h608zPCue15z8YGrKb4bKH61tJo33bRt3nARONaduU7VakMTRwnMudYGuQN8tjaf9I1HwNxMCzlGkz832av020Hf8nQ3Me+XGWRcYjmZPxlmrtQDUXK5iTbzdSGzPL9OcXOhPpQaAGf3QyhhcfctNLWrMR3hCF5dhMk9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755229861; c=relaxed/simple;
	bh=c2pC85ElO+tZ8p0q9KcefHan237MX0I5q5DFQRsj70M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gHMQompdWFAhUK0AhoMA9o9dedSnf25xKQZrvHgUJuId9EKpTbHXgpJbn/ePAhel9IvN2jzBhVl0XECM4VJyzy6yY45qjZ06o2zaPIfn/uPlvp4eEckMmimC/Nk9ApZYc9M+TEKQR4aior+clck4YejxVuvBv+IAE+aVSYbeTYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VESgFop9; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-55ce5284d63so1452215e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 20:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755229857; x=1755834657; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mNCpJgQjq+GS4YzNy98cq9BJV9qzo09+hdPjGhITOTw=;
        b=VESgFop9JXpWUWdR9s3k1FiQgAjftZp2l0yfa8NmqS5SmyE7zyCIsLYxSO6Rx/0Ka1
         ZtH/yp4SfNDz5THsdsdQ3BEMRlfqwbLTScOXan3jcYhhrI6Vx2xaaD07zuxGVNyDmfyC
         s9g3iCUH1r8iHRuBA+NSd1O1VJZZVd29cK3RY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755229857; x=1755834657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mNCpJgQjq+GS4YzNy98cq9BJV9qzo09+hdPjGhITOTw=;
        b=VF7wDrrUt3fgV0Iu1kekJmxkbYmELJlZDYFKUkKLGPy8N/J5MoYkHhikErahAE7ldq
         h8vytON8xekSDJNxNZhzsF24u2ZOKTowBylDN0C8492NL4n5SbUMCE8Fuv/isd7Oye00
         /4oQszYtONz3f801oy9inyfee0uj1CrWV47Tt/0nZhgNc0bX4o5H4sqRRaF4cQQl+m4x
         u1rqvHbns9oujmPv5+d8zRiejBFCG81QYt1ZmShR8R6g514VY88z93/yVMbv6ClVxDot
         KQlcY76cjKtORqSOa4dxAGz1xgcMI7D5veMx0vrVOUQFVmzTe2syeKpT28Pl24PnAuVb
         9G7w==
X-Forwarded-Encrypted: i=1; AJvYcCWOVSNbBysEjI04yRFJ5L2JQ0pky05UCqU6qjPHXMINZSaz2AXe4O2F+mbOLDWxcuIr8Zvfz4adUWR8oVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY6Tc1ngl5I5SPxwVFSMQjr6h95GsuvQKNe38UE0O2vYarqoYm
	zBBHgNcBlrVthALH8GaTtXgLPZMHjSsiSTn87uVA2ofMmpCQ5yT6lLSQpAu0Yyj3RVfARTbDh9a
	8BrTbz54k5IeC3flbwAI2SlxgJ/rS4xwZgTYF0ZUC
X-Gm-Gg: ASbGncsULS1OLiz0iUOGqiI1UDga/HkLAsQuyqNQf/7zX334pKt+yG5G/sqBvBTasuD
	e6f3MtNOyZDyl1yKoUA4IgK/cM1iXyCAE4fLojPVWJ9N8UP9j4Avby/3WD99XWUpDBqFbGOhmCL
	lNy9GCEpG4CUXn7yRbF6PXfjN40jT2bEczJLP6kHfFGQviFrepxP4+IXi/RvEOefI1Y/nTU7g++
	2WQY5wf4PBSAY0Y7OVjzt/uuslLXzGchhNCcw==
X-Google-Smtp-Source: AGHT+IHanR5W4aT2CMpF63TjQl6R4IN1HWWDRZ1tieU0aIdSV3su7803eNqcJODnfoQ+Iaia8tnU4ymR0P29h1PYZxw=
X-Received: by 2002:a05:6512:110c:b0:55b:814a:a7fa with SMTP id
 2adb3069b0e04-55ce6276b14mr1674516e87.8.1755229857008; Thu, 14 Aug 2025
 20:50:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250805135447.149231-1-laura.nao@collabora.com> <20250805135447.149231-16-laura.nao@collabora.com>
In-Reply-To: <20250805135447.149231-16-laura.nao@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 15 Aug 2025 12:50:46 +0900
X-Gm-Features: Ac12FXwHRx7C4fyOWZyt0EB-zyYHFrLdTdYy_27o2coqKVBHEp62jlgbsZo1EGQ
Message-ID: <CAGXv+5GH6ypcuXn9+XED7du_CJaeDs3M1ODjtN7pDH_FA0gmjg@mail.gmail.com>
Subject: Re: [PATCH v4 15/27] clk: mediatek: Add MT8196 ufssys clock support
To: Laura Nao <laura.nao@collabora.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, p.zabel@pengutronix.de, 
	richardcochran@gmail.com, guangjie.song@mediatek.com, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
	kernel@collabora.com, =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= <nfraprado@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 5, 2025 at 10:55=E2=80=AFPM Laura Nao <laura.nao@collabora.com>=
 wrote:
>
> Add support for the MT8196 ufssys clock controller, which provides clock
> gate control for UFS.
>
> Reviewed-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> Co-developed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@co=
llabora.com>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> ---
>  drivers/clk/mediatek/Kconfig             |   7 ++
>  drivers/clk/mediatek/Makefile            |   1 +
>  drivers/clk/mediatek/clk-mt8196-ufs_ao.c | 109 +++++++++++++++++++++++
>  3 files changed, 117 insertions(+)
>  create mode 100644 drivers/clk/mediatek/clk-mt8196-ufs_ao.c
>
> diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
> index 1e0c6f177ecd..d99c39a7f10e 100644
> --- a/drivers/clk/mediatek/Kconfig
> +++ b/drivers/clk/mediatek/Kconfig
> @@ -1010,6 +1010,13 @@ config COMMON_CLK_MT8196
>         help
>           This driver supports MediaTek MT8196 basic clocks.
>
> +config COMMON_CLK_MT8196_UFSSYS
> +       tristate "Clock driver for MediaTek MT8196 ufssys"
> +       depends on COMMON_CLK_MT8196
> +       default COMMON_CLK_MT8196
> +       help
> +         This driver supports MediaTek MT8196 ufssys clocks.
> +
>  config COMMON_CLK_MT8365
>         tristate "Clock driver for MediaTek MT8365"
>         depends on ARCH_MEDIATEK || COMPILE_TEST
> diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefil=
e
> index 8888ffd3d7ba..1a497de00846 100644
> --- a/drivers/clk/mediatek/Makefile
> +++ b/drivers/clk/mediatek/Makefile
> @@ -153,6 +153,7 @@ obj-$(CONFIG_COMMON_CLK_MT8195_WPESYS) +=3D clk-mt819=
5-wpe.o
>  obj-$(CONFIG_COMMON_CLK_MT8196) +=3D clk-mt8196-apmixedsys.o clk-mt8196-=
topckgen.o \
>                                    clk-mt8196-topckgen2.o clk-mt8196-vlpc=
kgen.o \
>                                    clk-mt8196-peri_ao.o
> +obj-$(CONFIG_COMMON_CLK_MT8196_UFSSYS) +=3D clk-mt8196-ufs_ao.o
>  obj-$(CONFIG_COMMON_CLK_MT8365) +=3D clk-mt8365-apmixedsys.o clk-mt8365.=
o
>  obj-$(CONFIG_COMMON_CLK_MT8365_APU) +=3D clk-mt8365-apu.o
>  obj-$(CONFIG_COMMON_CLK_MT8365_CAM) +=3D clk-mt8365-cam.o
> diff --git a/drivers/clk/mediatek/clk-mt8196-ufs_ao.c b/drivers/clk/media=
tek/clk-mt8196-ufs_ao.c
> new file mode 100644
> index 000000000000..858706b3ba6f
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt8196-ufs_ao.c
> @@ -0,0 +1,109 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2025 MediaTek Inc.
> + *                    Guangjie Song <guangjie.song@mediatek.com>
> + * Copyright (c) 2025 Collabora Ltd.
> + *                    Laura Nao <laura.nao@collabora.com>
> + */
> +#include <dt-bindings/clock/mediatek,mt8196-clock.h>
> +#include <dt-bindings/reset/mediatek,mt8196-resets.h>

Nit: add empty line here for separation.

> +#include <linux/clk-provider.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +
> +#include "clk-gate.h"
> +#include "clk-mtk.h"
> +
> +#define MT8196_UFSAO_RST0_SET_OFFSET   0x48
> +#define MT8196_UFSAO_RST1_SET_OFFSET   0x148
> +
> +static const struct mtk_gate_regs ufsao0_cg_regs =3D {
> +       .set_ofs =3D 0x108,
> +       .clr_ofs =3D 0x10c,
> +       .sta_ofs =3D 0x104,
> +};
> +
> +static const struct mtk_gate_regs ufsao1_cg_regs =3D {
> +       .set_ofs =3D 0x8,
> +       .clr_ofs =3D 0xc,
> +       .sta_ofs =3D 0x4,
> +};
> +
> +#define GATE_UFSAO0(_id, _name, _parent, _shift) {     \
> +               .id =3D _id,                              \
> +               .name =3D _name,                          \
> +               .parent_name =3D _parent,                 \
> +               .regs =3D &ufsao0_cg_regs,                \
> +               .shift =3D _shift,                        \
> +               .flags =3D CLK_OPS_PARENT_ENABLE,         \

This probably doesn't work correctly, since not every clock defined
below has the "ufs" clock as its parent. If the requirement is that
the "ufs" clock be enabled for accessing this register, it is going
to fail (badly).

ChenYu

> +               .ops =3D &mtk_clk_gate_ops_setclr,        \
> +       }
> +
> +#define GATE_UFSAO1(_id, _name, _parent, _shift) {     \
> +               .id =3D _id,                              \
> +               .name =3D _name,                          \
> +               .parent_name =3D _parent,                 \
> +               .regs =3D &ufsao1_cg_regs,                \
> +               .shift =3D _shift,                        \
> +               .flags =3D CLK_OPS_PARENT_ENABLE,         \
> +               .ops =3D &mtk_clk_gate_ops_setclr,        \
> +       }
> +
> +static const struct mtk_gate ufsao_clks[] =3D {
> +       /* UFSAO0 */
> +       GATE_UFSAO0(CLK_UFSAO_UFSHCI_UFS, "ufsao_ufshci_ufs", "ufs", 0),
> +       GATE_UFSAO0(CLK_UFSAO_UFSHCI_AES, "ufsao_ufshci_aes", "aes_ufsfde=
", 1),
> +       /* UFSAO1 */
> +       GATE_UFSAO1(CLK_UFSAO_UNIPRO_TX_SYM, "ufsao_unipro_tx_sym", "clk2=
6m", 0),
> +       GATE_UFSAO1(CLK_UFSAO_UNIPRO_RX_SYM0, "ufsao_unipro_rx_sym0", "cl=
k26m", 1),
> +       GATE_UFSAO1(CLK_UFSAO_UNIPRO_RX_SYM1, "ufsao_unipro_rx_sym1", "cl=
k26m", 2),
> +       GATE_UFSAO1(CLK_UFSAO_UNIPRO_SYS, "ufsao_unipro_sys", "ufs", 3),
> +       GATE_UFSAO1(CLK_UFSAO_UNIPRO_SAP, "ufsao_unipro_sap", "clk26m", 4=
),
> +       GATE_UFSAO1(CLK_UFSAO_PHY_SAP, "ufsao_phy_sap", "clk26m", 8),
> +};
> +
> +static u16 ufsao_rst_ofs[] =3D {
> +       MT8196_UFSAO_RST0_SET_OFFSET,
> +       MT8196_UFSAO_RST1_SET_OFFSET
> +};
> +
> +static u16 ufsao_rst_idx_map[] =3D {
> +       [MT8196_UFSAO_RST0_UFS_MPHY] =3D 8,
> +       [MT8196_UFSAO_RST1_UFS_UNIPRO] =3D 1 * RST_NR_PER_BANK + 0,
> +       [MT8196_UFSAO_RST1_UFS_CRYPTO] =3D 1 * RST_NR_PER_BANK + 1,
> +       [MT8196_UFSAO_RST1_UFSHCI] =3D 1 * RST_NR_PER_BANK + 2,
> +};
> +
> +static const struct mtk_clk_rst_desc ufsao_rst_desc =3D {
> +       .version =3D MTK_RST_SET_CLR,
> +       .rst_bank_ofs =3D ufsao_rst_ofs,
> +       .rst_bank_nr =3D ARRAY_SIZE(ufsao_rst_ofs),
> +       .rst_idx_map =3D ufsao_rst_idx_map,
> +       .rst_idx_map_nr =3D ARRAY_SIZE(ufsao_rst_idx_map),
> +};
> +
> +static const struct mtk_clk_desc ufsao_mcd =3D {
> +       .clks =3D ufsao_clks,
> +       .num_clks =3D ARRAY_SIZE(ufsao_clks),
> +       .rst_desc =3D &ufsao_rst_desc,
> +};
> +
> +static const struct of_device_id of_match_clk_mt8196_ufs_ao[] =3D {
> +       { .compatible =3D "mediatek,mt8196-ufscfg-ao", .data =3D &ufsao_m=
cd },
> +       { /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, of_match_clk_mt8196_ufs_ao);
> +
> +static struct platform_driver clk_mt8196_ufs_ao_drv =3D {
> +       .probe =3D mtk_clk_simple_probe,
> +       .remove =3D mtk_clk_simple_remove,
> +       .driver =3D {
> +               .name =3D "clk-mt8196-ufs-ao",
> +               .of_match_table =3D of_match_clk_mt8196_ufs_ao,
> +       },
> +};
> +
> +module_platform_driver(clk_mt8196_ufs_ao_drv);
> +MODULE_DESCRIPTION("MediaTek MT8196 ufs_ao clocks driver");
> +MODULE_LICENSE("GPL");
> --
> 2.39.5
>

