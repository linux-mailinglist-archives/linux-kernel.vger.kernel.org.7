Return-Path: <linux-kernel+bounces-764713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BAC8B22657
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 14:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11A663A8E8A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6422EE61D;
	Tue, 12 Aug 2025 12:10:00 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA642C21D7
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 12:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755000599; cv=none; b=IuG0o1TWijh4lxbJw3B+PIEA+UzyHr5aVAmpSiSr0SAUIea8xeMjizl8M0FPtWWEm5qF+fUoxfDSqwhGUopniLTysbVNSNNwQwULaQeDnS3l63k8ZwYbSLbWt+p795HTWipdrFsVLV7v7jCew2g5tHEzpEr3KWTWFRqnEgPRZYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755000599; c=relaxed/simple;
	bh=DL4hvqH1vF9/nc1wQqzmGirQB0i2yrmDoQEGr9fQiiQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JMoAuvN3ERUehPtbL2ADzW9cTRKoxowRzLulkhy0m1HnZe2q8Pc7NZBcvwaA6BG/DOMVrg0nF4ggaPY+uLmnPRX1j9x/ZkKNmlKYnVH4E3PSanBwX6/QYXTKM/b2MX2ADsE+NqOkwwZmXuBAQDJNpnpskSiEcTcYDFrNnXnhbIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1ulnYf-0001BT-Ce; Tue, 12 Aug 2025 13:52:49 +0200
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1ulnYd-00DBuR-16;
	Tue, 12 Aug 2025 13:52:47 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1ulnYd-000Fv3-0q;
	Tue, 12 Aug 2025 13:52:47 +0200
Message-ID: <cad00fbcb5dc69bb76358d495cef08dad56306a5.camel@pengutronix.de>
Subject: Re: [PATCH v10 2/2] memory: mtk-smi: mt8188: Add SMI reset and
 clamp for MT8188
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Friday Yang <friday.yang@mediatek.com>, Yong Wu <yong.wu@mediatek.com>, 
	Krzysztof Kozlowski
	 <krzk@kernel.org>, Rob Herring <robh@kernel.org>, Conor Dooley
	 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Project_Global_Chrome_Upstream_Group@mediatek.com
Date: Tue, 12 Aug 2025 13:52:47 +0200
In-Reply-To: <20250806085946.11383-3-friday.yang@mediatek.com>
References: <20250806085946.11383-1-friday.yang@mediatek.com>
	 <20250806085946.11383-3-friday.yang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Mi, 2025-08-06 at 16:59 +0800, Friday Yang wrote:
> To prevent handling glitch signals during MTCMOS on/off transitions,
> SMI requires clamp and reset operations. Parse the reset settings for
> SMI LARBs and the clamp settings for the SMI Sub-Common. Register
> genpd callback for the SMI LARBs located in image, camera and IPE
> subsystems, and apply reset and clamp operations within the callback.
>=20
> Signed-off-by: Friday Yang <friday.yang@mediatek.com>
> ---
>  drivers/memory/mtk-smi.c | 129 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 129 insertions(+)
>=20
> diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> index 733e22f695ab..acc8904dd117 100644
> --- a/drivers/memory/mtk-smi.c
> +++ b/drivers/memory/mtk-smi.c
> @@ -10,11 +10,15 @@
>  #include <linux/err.h>
>  #include <linux/io.h>
>  #include <linux/iopoll.h>
> +#include <linux/mfd/syscon.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_domain.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +#include <linux/reset.h>
>  #include <linux/soc/mediatek/mtk_sip_svc.h>
>  #include <soc/mediatek/smi.h>
>  #include <dt-bindings/memory/mt2701-larb-port.h>
> @@ -34,6 +38,8 @@
>  #define SMI_FIFO_TH1			0x238
>  #define SMI_FIFO_TH2			0x23c
>  #define SMI_DCM				0x300
> +#define SMI_COMMON_CLAMP_EN_SET		0x3c4
> +#define SMI_COMMON_CLAMP_EN_CLR		0x3c8
>  #define SMI_DUMMY			0x444
> =20
>  /* SMI LARB */
> @@ -134,6 +140,7 @@ struct mtk_smi_larb_gen {
>  	unsigned int			larb_direct_to_common_mask;
>  	unsigned int			flags_general;
>  	const u8			(*ostd)[SMI_LARB_PORT_NR_MAX];
> +	const u8			*clamp_port;
>  };
> =20
>  struct mtk_smi {
> @@ -150,6 +157,7 @@ struct mtk_smi {
>  };
> =20
>  struct mtk_smi_larb { /* larb: local arbiter */
> +	struct device			*dev;
>  	struct mtk_smi			smi;
>  	void __iomem			*base;
>  	struct device			*smi_common_dev; /* common or sub-common dev */
> @@ -157,6 +165,10 @@ struct mtk_smi_larb { /* larb: local arbiter */
>  	int				larbid;
>  	u32				*mmu;
>  	unsigned char			*bank;
> +	struct regmap			*smi_comm_syscon; /* smi-comm or sub-comm */
> +	u8				smi_comm_in_port_id; /* smi-comm or sub-comm */
> +	struct notifier_block		nb;
> +	struct reset_control		*rst_con;
>  };
> =20
>  static int
> @@ -478,6 +490,19 @@ static const u8 mtk_smi_larb_mt8195_ostd[][SMI_LARB_=
PORT_NR_MAX] =3D {
>  	[28] =3D {0x1a, 0x0e, 0x0a, 0x0a, 0x0c, 0x0e, 0x10,},
>  };
> =20
> +static const u8 mtk_smi_larb_clamp_port_mt8188[MTK_LARB_NR_MAX] =3D {
> +	[9]	=3D BIT(1), /* larb10 */
> +	[10]	=3D BIT(2), /* larb11a */
> +	[11]	=3D BIT(2), /* larb11b */
> +	[12]	=3D BIT(3), /* larb11c */
> +	[13]	=3D BIT(0), /* larb12 */
> +	[16]	=3D BIT(1), /* larb15 */
> +	[17]	=3D BIT(2), /* larb16a */
> +	[18]	=3D BIT(2), /* larb16b */
> +	[19]	=3D BIT(3), /* larb17a */
> +	[20]	=3D BIT(3), /* larb17b */
> +};
> +
>  static const struct mtk_smi_larb_gen mtk_smi_larb_mt2701 =3D {
>  	.port_in_larb =3D {
>  		LARB0_PORT_OFFSET, LARB1_PORT_OFFSET,
> @@ -531,6 +556,7 @@ static const struct mtk_smi_larb_gen mtk_smi_larb_mt8=
188 =3D {
>  	.flags_general	            =3D MTK_SMI_FLAG_THRT_UPDATE | MTK_SMI_FLAG_=
SW_FLAG |
>  				      MTK_SMI_FLAG_SLEEP_CTL | MTK_SMI_FLAG_CFG_PORT_SEC_CTL,
>  	.ostd		            =3D mtk_smi_larb_mt8188_ostd,
> +	.clamp_port                 =3D mtk_smi_larb_clamp_port_mt8188,
>  };
> =20
>  static const struct mtk_smi_larb_gen mtk_smi_larb_mt8192 =3D {
> @@ -582,6 +608,45 @@ static void mtk_smi_larb_sleep_ctrl_disable(struct m=
tk_smi_larb *larb)
>  	writel_relaxed(0, larb->base + SMI_LARB_SLP_CON);
>  }
> =20
> +static int mtk_smi_larb_clamp_protect_enable(struct device *dev, bool en=
able)
> +{
> +	struct mtk_smi_larb *larb =3D dev_get_drvdata(dev);
> +	u32 reg;
> +	int ret;
> +
> +	/* smi_comm_syscon may be NULL if the subsys doesn't have bus glitch is=
sues */
> +	if (!larb->smi_comm_syscon)
> +		return -EINVAL;
> +
> +	reg =3D enable ? SMI_COMMON_CLAMP_EN_SET : SMI_COMMON_CLAMP_EN_CLR;
> +
> +	ret =3D regmap_write(larb->smi_comm_syscon, reg, larb->smi_comm_in_port=
_id);
> +	if (ret)
> +		dev_err(dev, "Unable to %s clamp for input port %d: %d\n",
> +			enable ? "enable" : "disable",
> +			larb->smi_comm_in_port_id, ret);
> +
> +	return ret;
> +}
> +
> +static int mtk_smi_genpd_callback(struct notifier_block *nb,
> +				  unsigned long flags, void *data)
> +{
> +	struct mtk_smi_larb *larb =3D container_of(nb, struct mtk_smi_larb, nb)=
;
> +	struct device *dev =3D larb->dev;
> +
> +	if (flags =3D=3D GENPD_NOTIFY_PRE_ON || flags =3D=3D GENPD_NOTIFY_PRE_O=
FF) {
> +		/* disable related SMI sub-common port */
> +		mtk_smi_larb_clamp_protect_enable(dev, true);
> +	} else if (flags =3D=3D GENPD_NOTIFY_ON) {
> +		/* enable related SMI sub-common port */
> +		reset_control_reset(larb->rst_con);
> +		mtk_smi_larb_clamp_protect_enable(dev, false);
> +	}
> +
> +	return NOTIFY_OK;
> +}
> +
>  static int mtk_smi_device_link_common(struct device *dev, struct device =
**com_dev)
>  {
>  	struct platform_device *smi_com_pdev;
> @@ -638,6 +703,51 @@ static int mtk_smi_dts_clk_init(struct device *dev, =
struct mtk_smi *smi,
>  	return ret;
>  }
> =20
> +static int mtk_smi_larb_parse_clamp_optional(struct mtk_smi_larb *larb)
> +{
> +	struct device *dev =3D larb->dev;
> +	const struct mtk_smi_larb_gen *larb_gen =3D larb->larb_gen;
> +	u32 larb_id;
> +	int ret;
> +
> +	/*
> +	 * Only SMI LARBs in camera, image and IPE subsys need to
> +	 * apply clamp and reset operations, others can be skipped.
> +	 */
> +	ret =3D of_property_read_u32(dev->of_node, "mediatek,larb-id", &larb_id=
);
> +	if (ret || !larb_gen->clamp_port || !larb_gen->clamp_port[larb_id])
> +		return 0;
> +
> +	larb->smi_comm_in_port_id =3D larb_gen->clamp_port[larb_id];
> +	larb->smi_comm_syscon =3D syscon_regmap_lookup_by_phandle(dev->of_node,
> +								"mediatek,smi");
> +	if (IS_ERR(larb->smi_comm_syscon)) {
> +		larb->smi_comm_syscon =3D NULL;
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Unknown clamp port for larb %d\n", larb_id);
> +	}
> +
> +	return 0;
> +}
> +
> +static int mtk_smi_larb_parse_reset_optional(struct mtk_smi_larb *larb)
> +{
> +	struct device *dev =3D larb->dev;
> +	int ret;
> +
> +	larb->rst_con =3D devm_reset_control_get_optional_exclusive(dev, "larb"=
);
> +	if (!larb->rst_con)
> +		return 0;

Please don't ignore errors.

regards
Philipp

