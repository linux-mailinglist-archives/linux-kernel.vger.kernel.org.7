Return-Path: <linux-kernel+bounces-883682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DDEEC2E104
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 21:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D9BA189093A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 20:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE75C2BEC59;
	Mon,  3 Nov 2025 20:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=defranco.dev.br header.i=@defranco.dev.br header.b="UWcGzk1h"
Received: from mail-05.mail-europe.com (mail-05.mail-europe.com [85.9.206.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5A4218AB9
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 20:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.206.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762202892; cv=none; b=ox4tg/NDdagknNvZcnZNaUSdB9l3y3NUdAI0fvyriJShxMMI7uAByc1x2Fx1GLH2xyfnIElJNOmVBA9kfnbyzHZT8/vByvIy9dkmNct3qNqFL3mYpms13XHy672zOspIjSuQQI3EDlquowwBieno/JbcFOGFYjVQtQCStp0B5fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762202892; c=relaxed/simple;
	bh=N+JiD1rO4TadcRXtyM+p8UvSgmDnE/ymMRMjE5ca/fQ=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=uwiirjj4ccKEL2kXkWyNkJEeEZJzVJHA3fdzuzDtdam4ZzfcPKGAaaui7VnizN9qIEYAeoA/U+sUt84iEIhGhQTA2Km6gmR71KdAnZWIYF8hxbeM21i44rH6ZeggFGT/Z/I93eraB+gPoGxjrn1QjM76aVlAB1RMeRLAA7NLrfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=defranco.dev.br; spf=pass smtp.mailfrom=defranco.dev.br; dkim=pass (2048-bit key) header.d=defranco.dev.br header.i=@defranco.dev.br header.b=UWcGzk1h; arc=none smtp.client-ip=85.9.206.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=defranco.dev.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=defranco.dev.br
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defranco.dev.br;
	s=protonmail; t=1762202868; x=1762462068;
	bh=wU9IWXqC4dESjWm1H0SxwHsTARPMBcPAE1wY/KsJQwg=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=UWcGzk1hfTgSGlDELWUEDRfSLAsZPfPjO0juYwKwqFdFDMbS3zeFmkq2r4I5CZ2Id
	 KRZ/F2xPkgL2lhQ8Sb2yJtbmfy5Z8/4SeQhLbuiFNOJkYXYh24XudvQVUxsY4sTIoy
	 zfxwDOoxb0Nr+WqANcBnzzVDAZJ0yvse3HzxFQCtmxq9Q4Sk8m7A8TCHF07bqItJy1
	 xiuk2+KRKeARtP0x8HzayeTfrcRebkBbbJrKydK/NMJGuhRJ+C0hlA8BgE3csCXs8K
	 weYo9N7rDfjDdTn5IuZBQ103L90/MdM81qq6K3w/V2wOUiTRssx/cOPEDdi1mEcVuB
	 T9WO5PrA6ogpA==
Date: Mon, 03 Nov 2025 20:47:41 +0000
To: Beleswar Padhi <b-padhi@ti.com>
From: Hiago De Franco <hiago@defranco.dev.br>
Cc: jassisinghbrar@gmail.com, linux-kernel@vger.kernel.org, hiago.franco@toradex.com, francesco.dolcini@toradex.com, afd@ti.com, hnagalla@ti.com, u-kumar1@ti.com, nm@ti.com, vigneshr@ti.com
Subject: Re: [PATCH v2] mailbox: omap-mailbox: Check for pending msgs only when mbox is exclusive
Message-ID: <tuyd2fp7rtt6ijufeb5ma6xxu4rgijuigrb345o5yuso22eqbw@ijies6ceyfcd>
Feedback-ID: 160619648:user:proton
X-Pm-Message-ID: 6e92723e81f194395ad2f5befa23d824d5348ebc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04.11.2025 01:41, Beleswar Padhi wrote:
> On TI K3 devices, the mailbox resides in the Always-On power domain
> (LPSC_main_alwayson) and is shared among multiple processors. The
> mailbox is not solely exclusive to Linux.
>=20
> Currently, the suspend path checks all FIFO queues for pending messages
> and blocks suspend if any are present. This behavior is unnecessary for
> K3 devices, since some of the FIFOs are used for RTOS<->RTOS
> communication and are independent of Linux.
>=20
> For FIFOs used in Linux<->RTOS communication, any pending message would
> trigger an interrupt, which naturally prevents suspend from completing.
> Hence, there is no need for the mailbox driver to explicitly check for
> pending messages on K3 platforms.
>=20
> Introduce a device match flag to indicate whether the mailbox instance
> is exclusive to Linux, and skip the pending message check for
> non-exclusive instances (such as in K3).
>=20
> Fixes: a49f991e740f ("arm64: dts: ti: k3-am62-verdin: Add missing cfg for=
 TI IPC Firmware")
> Closes: https://lore.kernel.org/all/sid7gtg5vay5qgicsl6smnzwg5mnneoa35cem=
pt5ddwjvedaio@hzsgcx6oo74l/

Thanks for the patch, I tested on both Verdin AM62 and AM62P and looks
like everything is good, I can enter suspend without the error
previously reported.

Tested-by: Hiago De Franco <hiago.franco@toradex.com> # Verdin AM62/AM62P

Regards,
Hiago.

> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> ---
> Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
> Cc: Hiago De Franco <hiago.franco@toradex.com>
> Please help in testing the patch on Toradex platforms.
>=20
> Testing Done:
> 1. Tested Boot across all TI K3 EVM/SK boards.
> 2. Tested IPC on all TI K3 J7* EVM/SK boards (& AM62x SK).
> 3. Tested mbox driver probe & device boot on AM57x-evm (OMAP5 based).
> 4. Tested that the patch generates no new warnings/errors.
>=20
> Changes since v1:
> 1. Use device_get_match_data() in probe and store result for re-use.
>=20
> Link to v1:
> https://lore.kernel.org/all/20251103075920.2611642-1-b-padhi@ti.com/
>=20
> Changes since RFC:
> 1. Skip checking pending messages instead of flushing
> them explicitly for K3 devices.
>=20
> Link to RFC Version:
> https://lore.kernel.org/all/20251022102015.1345696-1-b-padhi@ti.com/
>=20
>  drivers/mailbox/omap-mailbox.c | 35 +++++++++++++++++++---------------
>  1 file changed, 20 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/mailbox/omap-mailbox.c b/drivers/mailbox/omap-mailbo=
x.c
> index 680243751d62..17fe6545875d 100644
> --- a/drivers/mailbox/omap-mailbox.c
> +++ b/drivers/mailbox/omap-mailbox.c
> @@ -68,6 +68,7 @@ struct omap_mbox_fifo {
> =20
>  struct omap_mbox_match_data {
>  =09u32 intr_type;
> +=09bool is_exclusive;
>  };
> =20
>  struct omap_mbox_device {
> @@ -78,6 +79,7 @@ struct omap_mbox_device {
>  =09u32 num_users;
>  =09u32 num_fifos;
>  =09u32 intr_type;
> +=09const struct omap_mbox_match_data *mbox_data;
>  };
> =20
>  struct omap_mbox {
> @@ -341,11 +343,13 @@ static int omap_mbox_suspend(struct device *dev)
>  =09if (pm_runtime_status_suspended(dev))
>  =09=09return 0;
> =20
> -=09for (fifo =3D 0; fifo < mdev->num_fifos; fifo++) {
> -=09=09if (mbox_read_reg(mdev, MAILBOX_MSGSTATUS(fifo))) {
> -=09=09=09dev_err(mdev->dev, "fifo %d has unexpected unread messages\n",
> -=09=09=09=09fifo);
> -=09=09=09return -EBUSY;
> +=09if (mdev->mbox_data->is_exclusive) {
> +=09=09for (fifo =3D 0; fifo < mdev->num_fifos; fifo++) {
> +=09=09=09if (mbox_read_reg(mdev, MAILBOX_MSGSTATUS(fifo))) {
> +=09=09=09=09dev_err(mdev->dev, "fifo %d has unexpected unread messages\n=
",
> +=09=09=09=09=09fifo);
> +=09=09=09=09return -EBUSY;
> +=09=09=09}
>  =09=09}
>  =09}
> =20
> @@ -378,8 +382,9 @@ static const struct dev_pm_ops omap_mbox_pm_ops =3D {
>  =09SET_SYSTEM_SLEEP_PM_OPS(omap_mbox_suspend, omap_mbox_resume)
>  };
> =20
> -static const struct omap_mbox_match_data omap2_data =3D { MBOX_INTR_CFG_=
TYPE1 };
> -static const struct omap_mbox_match_data omap4_data =3D { MBOX_INTR_CFG_=
TYPE2 };
> +static const struct omap_mbox_match_data omap2_data =3D { MBOX_INTR_CFG_=
TYPE1, true };
> +static const struct omap_mbox_match_data omap4_data =3D { MBOX_INTR_CFG_=
TYPE2, true };
> +static const struct omap_mbox_match_data am654_data =3D { MBOX_INTR_CFG_=
TYPE2, false };
> =20
>  static const struct of_device_id omap_mailbox_of_match[] =3D {
>  =09{
> @@ -396,11 +401,11 @@ static const struct of_device_id omap_mailbox_of_ma=
tch[] =3D {
>  =09},
>  =09{
>  =09=09.compatible=09=3D "ti,am654-mailbox",
> -=09=09.data=09=09=3D &omap4_data,
> +=09=09.data=09=09=3D &am654_data,
>  =09},
>  =09{
>  =09=09.compatible=09=3D "ti,am64-mailbox",
> -=09=09.data=09=09=3D &omap4_data,
> +=09=09.data=09=09=3D &am654_data,
>  =09},
>  =09{
>  =09=09/* end */
> @@ -449,7 +454,6 @@ static int omap_mbox_probe(struct platform_device *pd=
ev)
>  =09struct omap_mbox_fifo *fifo;
>  =09struct device_node *node =3D pdev->dev.of_node;
>  =09struct device_node *child;
> -=09const struct omap_mbox_match_data *match_data;
>  =09struct mbox_controller *controller;
>  =09u32 intr_type, info_count;
>  =09u32 num_users, num_fifos;
> @@ -462,11 +466,6 @@ static int omap_mbox_probe(struct platform_device *p=
dev)
>  =09=09return -ENODEV;
>  =09}
> =20
> -=09match_data =3D of_device_get_match_data(&pdev->dev);
> -=09if (!match_data)
> -=09=09return -ENODEV;
> -=09intr_type =3D match_data->intr_type;
> -
>  =09if (of_property_read_u32(node, "ti,mbox-num-users", &num_users))
>  =09=09return -ENODEV;
> =20
> @@ -483,6 +482,12 @@ static int omap_mbox_probe(struct platform_device *p=
dev)
>  =09if (!mdev)
>  =09=09return -ENOMEM;
> =20
> +=09mdev->mbox_data =3D device_get_match_data(&pdev->dev);
> +=09if (!mdev->mbox_data)
> +=09=09return -ENODEV;
> +
> +=09intr_type =3D mdev->mbox_data->intr_type;
> +
>  =09mdev->mbox_base =3D devm_platform_ioremap_resource(pdev, 0);
>  =09if (IS_ERR(mdev->mbox_base))
>  =09=09return PTR_ERR(mdev->mbox_base);
> --=20
> 2.34.1
>=20


