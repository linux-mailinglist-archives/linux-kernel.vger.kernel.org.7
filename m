Return-Path: <linux-kernel+bounces-793461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA3BB3D3C4
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 15:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 546D5189BE05
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 13:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B1B26CE26;
	Sun, 31 Aug 2025 13:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tahomasoft.com header.i=@tahomasoft.com header.b="D37S7zqU"
Received: from chumsalmon.baetis.net (chumsalmon.baetis.net [209.222.21.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F0A26CE03;
	Sun, 31 Aug 2025 13:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.222.21.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756648546; cv=none; b=qN4BC3a7ItFZKYY5cO+brIFo9Xdx+nVOZwl9bDma0w1Ci5IuCqyzfXj5GBg99cYBeLoC2r7I7zOUfVEJRak1LBu8sqCqCeaUPjTjLHCY/YWMbnl6m8Q+9NIaTlWMYRl6j4zobF9NpWcWbuJyUPmbrZ/bKPpe1Btb/LnE0qD4kFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756648546; c=relaxed/simple;
	bh=0JG/R7bAPQm+MlZqDUVOJ+JY4WzqiuAbKuf2QpGCbFA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QSu2Hqkq3WBLgiX1L2omm1uBnCnSR1XtvS9Z7CZFNWSoFYbI8dnCCFYY+7z32NGtELOh43IHpCgEEZn86F0+IXDCZkxtXeMweFq8P565SZ5gEDCegbgWGKZn54wXR/8ut4rOMFO+eHrYmMLiFQPqWlQ3Rsar6Pi0OY7C+WrHqCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tahomasoft.com; spf=pass smtp.mailfrom=tahomasoft.com; dkim=pass (2048-bit key) header.d=tahomasoft.com header.i=@tahomasoft.com header.b=D37S7zqU; arc=none smtp.client-ip=209.222.21.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tahomasoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tahomasoft.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tahomasoft.com;
	s=default; t=1756648542;
	bh=0JG/R7bAPQm+MlZqDUVOJ+JY4WzqiuAbKuf2QpGCbFA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D37S7zqU2/F08JIqFoIrL8DJEcIUVIgB/zPrNVJpOp5BSM2nUvb4LXkuIPWOrB2z7
	 GESW0lUajM8e6O0kd6lP+B2T4nG9MsvkXfmzGSKDcGjvtxCPjt5A0qPe2t6IlFOsjW
	 Tyq3lcDuJgySMWmzr4MY5ZmPlmp/WEDZCRlOmqrPQuO6flF/9L1IWbdKn7gpOL4WVr
	 6fikEV0C85y/GSryytNG06kKqqv0/mXN4I1CFFpcuyQhfSBxaMbg7cK1TExGSbaA/9
	 6bblqQ2A/iyL26sH4pl1XJCtE5HxCZ7q14uza8Dag5AG0hHMAfxVV6PMiwH1psrUzW
	 1d2XiN8gzeS+Q==
Received: from WahpenayoPeak.tahoma.link (unknown [IPv6:2600:4040:50be:5a04:7b87:89ea:8410:bae3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by chumsalmon.baetis.net (Postfix) with ESMTPSA id 78C2D27E468;
	Sun, 31 Aug 2025 13:55:42 +0000 (UTC)
Date: Sun, 31 Aug 2025 09:55:41 -0400
From: Erik Beck <xunil@tahomasoft.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiko Stuebner <heiko@sntech.de>, Chukun Pan <amadeus@jmu.edu.cn>, Rob
 Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH 0/4] arm64: dts: rockchip: Add HINLINK H66K/H68K
Message-ID: <20250831095541.49568044.xunil@tahomasoft.com>
In-Reply-To: <AAEEDECA-1419-487E-B018-E0590ED532D1@tahomasoft.com>
References: <2803b3d8-332e-4ada-a28f-eeba8285b7ec@lunn.ch>
	<AAEEDECA-1419-487E-B018-E0590ED532D1@tahomasoft.com>
Organization: Tahoma Soft
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 30 Aug 2025 18:20:50 -0400
Erik Beck <xunil@tahomasoft.com> wrote:

> > On Aug 30, 2025, at 17:30, Andrew Lunn <andrew@lunn.ch> wrote:
> >=20
> > =EF=BB=BF =20
> >>=20
> >> As I worked on my dts, I discovered that the 1Gb ethernet ports, using=
 an
> >> RTL8211, don't support rgmii-id mode; only rgmii.
> >> (https://www.realtek.com/Product/Index?id=3D3976&cate_id=3D786). =20
> >=20
> > Which exact RTL8211 does the board use? You link to information for
> > the RTL8211FD(I)-CG, which i assume is supported in Linux as RTL8211F. =
=20
>=20
> Thanks Andrew; It isn't clear to me which specific variation it has. I'll
> take another look at the boot logs and see. The silkscreen on the chips a=
re
> faint, but will look there too.

dmesg reports it is an RTL8211F.

> >=20
> > https://elixir.bootlin.com/linux/v6.16.3/source/drivers/net/phy/realtek=
/realtek_main.c#L519
> >=20
> > This indicates it supports all four RGMII modes. And in general, all
> > PHY drivers in Linux for RGMII PHYs support all four RGMII modes.
> >  =20
> >> Changing this makes a huge difference in the ethernet throughput speed.
> >> With rgmii-id mode specified, throughput is about 6.5 Mbs. Changing th=
is
> >> to rgmii mode increases throughput to about 960 Mbs. =20
> >=20
> > Here is some more information about that the four RGMII modes mean,
> > and how you should use them in Linux:
> >=20
> > https://elixir.bootlin.com/linux/v6.16.3/source/Documentation/devicetre=
e/bindings/net/ethernet-controller.yaml#L264
> >=20
> >    Andrew =20
>=20
> Thank you!
> >=20
> > _______________________________________________
> > Linux-rockchip mailing list
> > Linux-rockchip@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-rockchip =20


