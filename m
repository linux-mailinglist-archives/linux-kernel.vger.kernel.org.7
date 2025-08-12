Return-Path: <linux-kernel+bounces-764066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 850B3B21D97
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 07:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61BA31AA1777
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 05:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A252D8798;
	Tue, 12 Aug 2025 05:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="S+v8NTpX"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97FD2D46B3
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 05:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754977686; cv=none; b=Pjs9vZ9TfPZr8uFJ3QAWh8KigAEADV90Qs7GCjnbB5UpiGTxRCVSxBZsGWFhB91lx31blQcZoXaRpzZ3zcqSI/eIxWAMcYI0tXJDX0c8YrkVbV73kwo53T0FY99WgPMEt/GNlbdLZQYeNgV81AMshPTey8boYOB+Mhk3o65147w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754977686; c=relaxed/simple;
	bh=jO+IVzo3YAMCTJto5kIWS0+ylU9YXHD9qWaBlsMVx6g=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=JoGHcz3nHUoRYvPM2tuiAbyXLuda8wLw5JVeI6FeBE6uu1n87kbcSGo8eEX4yrkC0tFgRXLHfsV4OVR0lTvWCKVqjQsRvO9K3fkIq5YfjJT4L/gL/igt/D7ePPbOe6OBElQf/1HrpXmbRy8eh/0Yv6rs5+VMlUAPiEG/pVhcDeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=S+v8NTpX; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from mail.ideasonboard.com (unknown [IPv6:2401:4900:1c66:bd1a:669e:3dcb:5a6b:a905])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 810083A4;
	Tue, 12 Aug 2025 07:47:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1754977628;
	bh=jO+IVzo3YAMCTJto5kIWS0+ylU9YXHD9qWaBlsMVx6g=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=S+v8NTpX1xLrmvzy9mlWxQ3TmWy36wXMt66fHZ+wOGiKTbu9gHKybPhxZPpa3nsUk
	 HbzrRtyNqNc3IIkyjkYL0IYZtQShSWsMI1v3KMZ+3EVS/tfkAvrMBEn3t/Fi8ActTs
	 6nqssOD6mLnCWpZqWm5R8ovhEGA6F32ZUT7iHABc=
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250224-cdns_phy_pm-v1-1-0fe2c544cc87@ideasonboard.com>
References: <20250224-cdns_phy_pm-v1-1-0fe2c544cc87@ideasonboard.com>
Subject: Re: [PATCH] phy: cadence: cdns-dphy-rx: Add runtime PM support
From: Jai Luthra <jai.luthra@ideasonboard.com>
Cc: linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, Devarsh Thakkar <devarsht@ti.com>, Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
To: Kishon Vijay Abraham I <kishon@kernel.org>, Vinod Koul <vkoul@kernel.org>
Date: Tue, 12 Aug 2025 11:17:56 +0530
Message-ID: <175497767648.8696.3021844845686596634@freya>
User-Agent: alot/0.12.dev28+gd2c823fe

Hi Vinod, Kishon,

Quoting Jai Luthra (2025-02-24 18:10:05)
> Enable runtime power management for the device. The PHY framework
> handles calling pm_runtime_(get|put)_sync when powering on/off this
> device.
>=20

Can this patch get picked for the next merge window?

The CSI PM series is already reviewed [1], and it would be good to have
runtime PM for cameras working in 6.18, which needs both the PHY and CSI
IPs to be powered off.

[1]: https://lore.kernel.org/linux-media/20250224-ti_csi_pm-v1-0-8f8c29ef64=
6d@ideasonboard.com/

> Signed-off-by: Jai Luthra <jai.luthra@ideasonboard.com>
> ---
>  drivers/phy/cadence/cdns-dphy-rx.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/phy/cadence/cdns-dphy-rx.c b/drivers/phy/cadence/cdn=
s-dphy-rx.c
> index 7729cf80a9bd892c3e5db6cdbdc4ece9ada2d99f..3ac80141189c4c8c350b67899=
8e5dec7a15c3892 100644
> --- a/drivers/phy/cadence/cdns-dphy-rx.c
> +++ b/drivers/phy/cadence/cdns-dphy-rx.c
> @@ -12,6 +12,7 @@
>  #include <linux/phy/phy.h>
>  #include <linux/phy/phy-mipi-dphy.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/sys_soc.h>
> =20
>  #define DPHY_PMA_CMN(reg)              (reg)
> @@ -265,7 +266,7 @@ static int cdns_dphy_rx_probe(struct platform_device =
*pdev)
>                 return PTR_ERR(provider);
>         }
> =20
> -       return 0;
> +       return devm_pm_runtime_enable(dev);
>  }
> =20
>  static const struct of_device_id cdns_dphy_rx_of_match[] =3D {
>=20
> ---
> base-commit: d082ecbc71e9e0bf49883ee4afd435a77a5101b6
> change-id: 20250224-cdns_phy_pm-b2b7d472835d
>=20
> Best regards,
> --=20
> Jai Luthra <jai.luthra@ideasonboard.com>
>=20

Thanks,
Jai

