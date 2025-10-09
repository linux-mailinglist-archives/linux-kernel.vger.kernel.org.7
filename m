Return-Path: <linux-kernel+bounces-847415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DFEBCAC5C
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 22:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3645F1A639BA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 20:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE4D26C399;
	Thu,  9 Oct 2025 20:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="IREbUvkA"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349A124166E;
	Thu,  9 Oct 2025 20:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760040936; cv=pass; b=KTQpPR2AfNniHG6R2WQ6UDm0YJ+58PT+O5S1VyrhxEUlAGijBudHz4j3bw0wnUj5h/UmlGKBJDamhI8Jk/6SeZtYrERDUGLKbW2TV7VTnpgzwb5381loW0WEJI/7OGx569TT/4mh4/+x/nUKgIzgqn6V16r8HWCYTgmD/COw5CM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760040936; c=relaxed/simple;
	bh=72EZR+r0ivMrIkxmk5d2mq/G1nq0RxfAF643qbO76go=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AmdWkZKDaKa+KCQeyEHmhUFyO7eAF/+3ca7nv3n7hFrI9dZ9UoJV02DkNlc/w/uDcWfEGZxxuNnRCqRn0MNgTVR0fVppsBWDQ4w6gQpPeSqtnuIPKmdpVqnn9mxNK3Z1LIpbUGZVpEZ396o61nJkmS/VyipJdXCu17wqavocOr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=IREbUvkA; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1760040913; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=bUWbL/cbdYkJTVmJ/Ol4gXBFFOtUjIChX1rQYBVzQ+ybQSn5FjVpe8WwDFV4wxBirRm1AtyCwkzfvhrbWgbOU4avyQKHwewc2gG8u9Kye2OurxHN0SSnjZS5UEY4YgdPXoevlcBuPkcI88rZXqWm3mBQHlMyMsJy/cgBy1jJ/7E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760040913; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=m8IQGlvE0B/h1nhDsu/zo01pRlwkuXubZg9MqyCi1WQ=; 
	b=VPsvC9byf0knFT2/3fkR6VQ8fMPDHOk6/yh6BX3L/1cJSJnMqinRCDTsO8CPHIB4RCKpA8rxnQa0+DQxg1Aciq1V1vflLwn2MA7iA/zTgHddanaFYwqOJak93C/js48S/wilM7uT3Tai51OBO6wYCj1/PikTRZHHjaZ5ql0pW7g=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760040912;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=m8IQGlvE0B/h1nhDsu/zo01pRlwkuXubZg9MqyCi1WQ=;
	b=IREbUvkASyuJRRlJKCxFgy+8vM2XJYSaxRGe0c2fcHRLn26ofrTkacnwB+/DOp7c
	ia+TEJ7nCIV1WbnZducwJLlm+IzPXTwxLsBumFm1c8gnJXxM8djjaJXQms5dHWaqWUG
	RUnFlCta3Pkxp/zjK8t8/+86UeIy24pB4Imwc7PQ=
Received: by mx.zohomail.com with SMTPS id 1760040910661484.0419438507935;
	Thu, 9 Oct 2025 13:15:10 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: linux-mediatek@lists.infradead.org,
 angelogioacchino.delregno@collabora.com
Cc: lee@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
 wenst@chromium.org, igor.belwon@mentallysanemainliners.org,
 =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject:
 Re: [PATCH v8 9/9] drivers: mfd: Add support for MediaTek SPMI PMICs and
 MT6363/73
Date: Thu, 09 Oct 2025 22:15:01 +0200
Message-ID: <14451186.uLZWGnKmhe@workhorse>
In-Reply-To: <20251003091158.26748-10-angelogioacchino.delregno@collabora.com>
References:
 <20251003091158.26748-1-angelogioacchino.delregno@collabora.com>
 <20251003091158.26748-10-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Friday, 3 October 2025 11:11:58 Central European Summer Time AngeloGioac=
chino Del Regno wrote:
> This driver adds support for the MediaTek SPMI PMICs and their
> interrupt controller (which is present in 95% of the cases).
>=20
> Other than probing all of the sub-devices of a SPMI PMIC, this
> sets up a regmap from the relevant SPMI bus and initializes an
> interrupt controller with its irq domain and irqchip to handle
> chained interrupts, with the SPMI bus itself being its parent
> irq controller, and the PMIC being the outmost device.
>=20
> This driver hence holds all of the information about a specific
> PMIC's interrupts and will properly handle them, calling the
> ISR for any subdevice that requested an interrupt.
>=20
> As for the interrupt spec, this driver wants 3 interrupt cells,
> but ignores the first one: this is because of how this first
> revision of the MediaTek SPMI 2.0 Controller works, which does
> not hold irq number information in its register, but delegates
> that to the SPMI device - it's possible that this will change
> in the future with a newer revision of the controller IP, and
> this is the main reason for that.
>=20
> To make use of this implementation, this driver also adds the
> required bits to support MediaTek MT6363 and MT6373 SPMI PMICs.
>=20
> Reviewed-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---
>  drivers/mfd/Kconfig         |  17 ++
>  drivers/mfd/Makefile        |   1 +
>  drivers/mfd/mtk-spmi-pmic.c | 410 ++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/mt6363.h  |  26 +++
>  include/linux/mfd/mt6373.h  |  21 ++
>  5 files changed, 475 insertions(+)
>  create mode 100644 drivers/mfd/mtk-spmi-pmic.c
>  create mode 100644 include/linux/mfd/mt6363.h
>  create mode 100644 include/linux/mfd/mt6373.h

Hi Angelo, came across something suspicious here while debugging why
I ran into IRQ parsing from DT issues here.

>
> [...]
> diff --git a/drivers/mfd/mtk-spmi-pmic.c b/drivers/mfd/mtk-spmi-pmic.c
> new file mode 100644
> index 000000000000..512b53bdb0d1
> --- /dev/null
> +++ b/drivers/mfd/mtk-spmi-pmic.c
> [...]
> +
> +static int mtk_spmi_pmic_irq_xlate(struct irq_domain *d, struct device_n=
ode *ctrlr,
> +				  const u32 *intspec, unsigned int intsize,
> +				  unsigned long *out_hwirq, unsigned int *out_type)
> +{
> +	struct mtk_spmi_pmic *pmic =3D d->host_data;
> +	struct device *dev =3D pmic->dev;
> +	struct irq_fwspec fwspec;
> +
> +	of_phandle_args_to_fwspec(ctrlr, intspec, intsize, &fwspec);
> +	if (WARN_ON(fwspec.param_count < 3))
> +		return -EINVAL;

What's the point of fwspec here? The caller in
irqdomain.c::irq_domain_translate has an fwspec, converts it to an
of_node with the intsize/intspec args, then passes it to this function,
which builds it back into an fwspec just to check fwspec.param_count,
which is equal intsize.

fwspec is then never used again.

Just check intsize instead, it's precisely that value.

spmi-mtk-pmif.c::mtk_spmi_rcs_irq_xlate does the same thing, which also
seems pointless.

> +
> +	/*
> +	 * The IRQ number in intspec[0] is ignored on purpose here!
> +	 *
> +	 * This is because of how at least the first revision of the SPMI 2.0
> +	 * controller works in MediaTek SoCs: the controller will raise an
> +	 * interrupt for each SID (but doesn't know the details!), and the
> +	 * specific IRQ number that got raised must be read from the PMIC or
> +	 * its sub-device driver.
> +	 * It's possible that this will change in the future with a newer
> +	 * revision of the SPMI controller, and this is why the devicetree
> +	 * holds the full intspec.
> +	 */
> +	*out_hwirq =3D intspec[1];
> +	*out_type =3D intspec[2] & IRQ_TYPE_SENSE_MASK;
> +
> +	dev_dbg(dev, "Found device IRQ %u chained from SPMI IRQ %x (map: 0x%lx)=
\n",
> +		intspec[1], intspec[0], *out_hwirq);
> +
> +	return 0;
> +}
> +
> +static const struct irq_domain_ops mtk_spmi_pmic_irq_domain_ops =3D {
> +	.map =3D mtk_spmi_pmic_irq_domain_map,
> +	.xlate =3D mtk_spmi_pmic_irq_xlate,
> +};
> +
> [...]

Kind regards,
Nicolas Frattaroli





