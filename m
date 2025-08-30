Return-Path: <linux-kernel+bounces-793175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8DFB3CFCB
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 00:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55B065E5178
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 22:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3FEB259CAF;
	Sat, 30 Aug 2025 22:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tahomasoft.com header.i=@tahomasoft.com header.b="hwKdG4Z/"
Received: from chumsalmon.baetis.net (chumsalmon.baetis.net [209.222.21.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9D554758;
	Sat, 30 Aug 2025 22:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.222.21.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756592466; cv=none; b=e6ztMIov/avv+1RPqyPuox9ts/1BaU8ToNVGiIEjvfZIyOl2RnAnuwwfeGz7FpJc1tHcizbBWUw4xPPFLhcUvTJMHYNYje3/Bblxl/p6f2XR4dzZqSVULRwJnboxXUGahgnFwfWrVlzhZ6bZmU5EpYCX3cJjUJb8cFjWRGUEGNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756592466; c=relaxed/simple;
	bh=7k6q+f86ghK/n5B2VunwMH6m8MBXQ8m4bSBSm/fUtbo=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=FNiHIMUPrwfuNo5UAL5l9Jlus/9KxhNrv2Gi48jLZWfpNGg5m09U5xrAAb7wsEcevTuT6IBGxcs3v2ZmbLeLDactAzmZT+P04XgTqyN4wKYYObB+0i64141Wj1FDSJm2s0uXlZzG1z6/oFBMNzXdeScjkEFuBSXArzc0EKOpgeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tahomasoft.com; spf=pass smtp.mailfrom=tahomasoft.com; dkim=pass (2048-bit key) header.d=tahomasoft.com header.i=@tahomasoft.com header.b=hwKdG4Z/; arc=none smtp.client-ip=209.222.21.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tahomasoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tahomasoft.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tahomasoft.com;
	s=default; t=1756592461;
	bh=7k6q+f86ghK/n5B2VunwMH6m8MBXQ8m4bSBSm/fUtbo=;
	h=From:Subject:Date:References:Cc:In-Reply-To:To:From;
	b=hwKdG4Z/bj7zMZIaxP+nL9Fm2QP6YdbTrxIg5YsgAXPLzNhhlbb1AfXosHe0tDz+b
	 p9D87AZO+rS8K6n78LaIvLa1MLTeufK+GEAFGi5fV8q8IIkpe64Lnfwml3IDpArcUH
	 Bty9g3c156i8nJAHu+8UoZp/cPWSjjIlyh9nF7UnoEtjSdS7rp6UD6c343X/6vgnSa
	 9hZbdJU4sM3GhhHvU4LGt3ysGab5TpqWvvTmnW652+JmTm3FUNw5SQlxArvHOMQzRG
	 DGdMwYPBW1IRlnjbiOC/xGYu7XcJyyVeuHQA8lXJvVMoF3LxpiEDq5zIsiUA+tqSjH
	 fZUMZ6K3P68CA==
Received: from smtpclient.apple (unknown [IPv6:2600:1000:b0ec:e674:574:f959:86e5:7770])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by chumsalmon.baetis.net (Postfix) with ESMTPSA id 547F427E468;
	Sat, 30 Aug 2025 22:21:01 +0000 (UTC)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Erik Beck <xunil@tahomasoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 0/4] arm64: dts: rockchip: Add HINLINK H66K/H68K
Date: Sat, 30 Aug 2025 18:20:50 -0400
Message-Id: <AAEEDECA-1419-487E-B018-E0590ED532D1@tahomasoft.com>
References: <2803b3d8-332e-4ada-a28f-eeba8285b7ec@lunn.ch>
Cc: Heiko Stuebner <heiko@sntech.de>, Chukun Pan <amadeus@jmu.edu.cn>,
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <2803b3d8-332e-4ada-a28f-eeba8285b7ec@lunn.ch>
To: Andrew Lunn <andrew@lunn.ch>
X-Mailer: iPhone Mail (22G100)



> On Aug 30, 2025, at 17:30, Andrew Lunn <andrew@lunn.ch> wrote:
>=20
> =EF=BB=BF
>>=20
>> As I worked on my dts, I discovered that the 1Gb ethernet ports, using an=

>> RTL8211, don't support rgmii-id mode; only rgmii.
>> (https://www.realtek.com/Product/Index?id=3D3976&cate_id=3D786).
>=20
> Which exact RTL8211 does the board use? You link to information for
> the RTL8211FD(I)-CG, which i assume is supported in Linux as RTL8211F.

Thanks Andrew; It isn't clear to me which specific variation it has. I'll ta=
ke another look at the boot logs and see. The silkscreen on the chips are fa=
int, but will look there too.
>=20
> https://elixir.bootlin.com/linux/v6.16.3/source/drivers/net/phy/realtek/re=
altek_main.c#L519
>=20
> This indicates it supports all four RGMII modes. And in general, all
> PHY drivers in Linux for RGMII PHYs support all four RGMII modes.
>=20
>> Changing this makes a huge difference in the ethernet throughput speed. W=
ith
>> rgmii-id mode specified, throughput is about 6.5 Mbs. Changing this to rg=
mii
>> mode increases throughput to about 960 Mbs.
>=20
> Here is some more information about that the four RGMII modes mean,
> and how you should use them in Linux:
>=20
> https://elixir.bootlin.com/linux/v6.16.3/source/Documentation/devicetree/b=
indings/net/ethernet-controller.yaml#L264
>=20
>    Andrew

Thank you!
>=20
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip

