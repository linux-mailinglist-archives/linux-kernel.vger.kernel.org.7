Return-Path: <linux-kernel+bounces-776353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B855B2CC4F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 20:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F109F7AFC13
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 18:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABFAA30FF06;
	Tue, 19 Aug 2025 18:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="gcR8kMD9"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E8424DD00;
	Tue, 19 Aug 2025 18:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755629076; cv=none; b=hkAAtWjxPPz+hig2JoiM5I/8UUj3fitFnsaK88JxYBPUJktm5qxk6s2XdEjYGga350CPnkKHvu/0VjLICgDUrR7VeMM3hS8jcTP3YA0iiqF7cEb8LakPTaXoa6aAYZPP01cI9uxZ8tLibxogHDeT6mErVQy1BS6XKZ5r8HGil5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755629076; c=relaxed/simple;
	bh=RmsQrLezQ4PGv/pwO6swVIm4CUDiWKhqSVbXOvQFtls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lvMeb9A2FWhQjH4SlUnK0YpqkVJAshoiUukTpfR6NGw5pvLhU8edi2PwsGR2zuDOs/iEoxEfSiEaIQfjagb6VR51lkz0VBN9A+TP7e2FgEk1z8u/oDFYQkBuZ1iGmGGg2R10SCl+jkUgxoo6V9o6G40fuhTU0Y+vsLvMRcxiJ/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=gcR8kMD9; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=8l89w4bHTJH83H28ZxlWSCRMM0V8+br4qkqPy5/xjd0=; b=gcR8kMD9Q71A7ezSFp0EEPQhem
	TJqW4ftDjs3qSqnC8AZ0XXhgHZn9wkOD+bwUNPMEn9JTbWOm4DsgbMES6CmD5dWREc3BFGop2eJBH
	+TEB01ubMjD8uJ0/T1fiSq4Kz5l21rKXWIGHnvm7CgRquGhL6v9H3ZimHeWfL86D6drVCh++UxjGF
	+dln30WIYeoic3imgQ0tnzjIhzqNBvTtJzfsn0kbKxQD0VKHwsevGtMvh9gsvX/jTdh5wiYHs1bO+
	g4+6KZTKeWf93whbuJErQgPevIuN1gl77doOV9YB98XI5+YjJoVzD/v5nVw9he7hC0hMegIiAgzGU
	pZuimlAQ==;
Received: from i53875a31.versanet.de ([83.135.90.49] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uoRJq-0004Ru-TA; Tue, 19 Aug 2025 20:44:26 +0200
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Dongjin Kim <tobetter@gmail.com>, Andrew Lunn <andrew@lunn.ch>
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH] arm64: dts: rockchip: Change ethernet TXD timing delay value
Date: Tue, 19 Aug 2025 20:44:26 +0200
Message-ID: <2821088.9PvXe5no7K@diego>
In-Reply-To: <4d25c642-d457-4cb7-8bc1-587edd4f1d75@lunn.ch>
References:
 <20250819045018.2094282-1-tobetter@gmail.com>
 <4d25c642-d457-4cb7-8bc1-587edd4f1d75@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Dienstag, 19. August 2025, 18:03:47 Mitteleurop=C3=A4ische Sommerzeit sc=
hrieb Andrew Lunn:
> On Tue, Aug 19, 2025 at 01:50:17PM +0900, Dongjin Kim wrote:
> > Very poor network performance is observed on the ODROID-M1 Board
> > (REV 1.0 20220613) when running iperf3 (under 200Mbits/sec), and
> > this problem can be resolved after changing the value of TXD
> > timing to 0x35 from 0x4f.
>=20
> How did you decide on 0x35?

just because I accidentially stumbled over that recently, Rockchip has
some scanning functionality in their vendor-kernel to get possible
delay values for a board.

Described in a document called "Rockchip GMAC RGMII Delayline Guide" [0]
and one code location is for example the armbian tree [1]

At least that is one possible source of per-board delay values :-)


Heiko


[0] https://lo01.g77k.com/aeb/docs/en/Common/GMAC/Rockchip_Developer_Guide_=
Linux_GMAC_RGMII_Delayline_EN.pdf
(random internet source Google found me)
[1] https://github.com/armbian/linux-rockchip/blob/rk-6.1-rkr5.1/drivers/ne=
t/ethernet/stmicro/stmmac/dwmac-rk-tool.c


>=20
> ~/linux/arch/arm64$ grep -hr "tx_delay =3D " | sort | uniq -c
>       4 	tx_delay =3D <0x10>;
>       1 	tx_delay =3D <0x1a>;
>       1 	tx_delay =3D <0x21>;
>       2 	tx_delay =3D <0x22>;
>       4 	tx_delay =3D <0x24>;
>       2 	tx_delay =3D <0x26>;
>      14 	tx_delay =3D <0x28>;
>       1 	tx_delay =3D <0x2a>;
>       6 	tx_delay =3D <0x30>;
>       1 	tx_delay =3D <0x3a>;
>       3 	tx_delay =3D <0x3c>;
>       2 	tx_delay =3D <0x42>;
>       5 	tx_delay =3D <0x43>;
>       2 	tx_delay =3D <0x44>;
>       1 	tx_delay =3D <0x46>;
>       6 	tx_delay =3D <0x4f>;
>=20
> The numbers are all over the place, but it is clear that 0x28 is the
> most popular for some reason. But since this delay values are magic,
> i've no idea why.
>=20
>      Andrew
>=20





