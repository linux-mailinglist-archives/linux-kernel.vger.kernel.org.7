Return-Path: <linux-kernel+bounces-793119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85965B3CED7
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 20:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BD851B26287
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 18:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438671DC9B1;
	Sat, 30 Aug 2025 18:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="fp9xgnDj"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3A8145A05;
	Sat, 30 Aug 2025 18:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756579548; cv=none; b=Y19dc2p8AVn5lGySL7vHZJh4FCDhincjt24AHiIeyv34IXSBBONWsQe48aVoI+uU+kdnXtpv7IV44JRX7ex6x7IIFcWZ0G1qGcMpEeB81EjkXgP3FPtfCgzg4dMhtK0Q4weUDzEmuoKY68ClGeI7FrCGTdvPm0ttul2cy8Ys4Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756579548; c=relaxed/simple;
	bh=MPDhb7Li7CvPxwSyGZOt/9WkLyTsL5w5wJ2qPvZWxJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DV4NWRSoY6/LGia32hBZLbcn8otAX/6hh8b+AxrtOJ19PiGnjOo5heEKeVteJ5uNsCrjwlvPnbYtdaoEA7gvkEr03QXaFcZSXQOzVNIWCwP8lVSZlahBpQNe+bjusBnLPntRtjScrmQBqglxZzQV9BIc00ELZQudxVqmlJzDHtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=fp9xgnDj; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=56eixtQM6IBrEm/5Jwsst/ouQ2m/s5sQIb2TIKo+iAg=; b=fp9xgnDj2TWtvFuECWHixYHZR3
	2gft0+POSW1l9LkOv4Cq5kRn2FVCBU6kFr871g2Ee4Pr0aJiT2kBFEA6MS94OnstnO7pH8EBLSo7J
	nO/M2OvoPr5XKgpDcR22/RJRBHfPhQUQDVvNjp2zwjQHum0CAptdjd4lQ1XbBUmDEWqkKeDLFp/hm
	hn3HP1B3BrWpBoCAY8X987K5jbYNthsyXpa1BwJpEEsvlLABqtp1++ryvUXi+HXUjCFAvFK5Y6QmY
	m1rWo2ySWJaTpi5I15KGr/xNHAOKrFnor48JMsh9YGosQIPew3qr6fQc1+AHp72yv8Nxpx+OIr1fB
	xtiWcCYA==;
Received: from [88.128.88.73] (helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1usQZz-0005MT-66; Sat, 30 Aug 2025 20:45:35 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Yao Zi <ziyao@disroot.org>,
 Chukun Pan <amadeus@jmu.edu.cn>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/6] arm64: dts: rockchip: Add ROCK 2A/2F,
 Sige1 and NanoPi Zero2
Date: Sat, 30 Aug 2025 20:45:34 +0200
Message-ID: <7632976.8F6SAcFxjW@phil>
In-Reply-To: <6cf1cf2d-50cb-413d-93c6-79ecd6b0788e@kwiboo.se>
References:
 <20250717103720.2853031-1-jonas@kwiboo.se>
 <6cf1cf2d-50cb-413d-93c6-79ecd6b0788e@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi Jonas,

Am Dienstag, 26. August 2025, 10:31:07 Mitteleurop=C3=A4ische Sommerzeit sc=
hrieb Jonas Karlman:
> Hi Heiko,
>=20
> On 7/17/2025 12:37 PM, Jonas Karlman wrote:
> > This series adds dt-bindings and initial device tree for the following
> > Rockchip RK3528A boards:
> > - Radxa ROCK 2A/2F
> > - ArmSoM Sige1
> > - FriendlyElec NanoPi Zero2
> >=20
> > The bt/wifi_reg_on pins are described in the device tree using
> > rfkill-gpio nodes.
> >=20
> > Changes in v4:
> > - Remove disable-wp prop from sdio0
> > - Collect r-b and t-b tags
> >=20
> > Changes in v3:
> > - Rename led nodes to led-0/led-1
> > - Remove pinctrl* props from sdio0
> > - Collect a-b tags
> >=20
> > Changes in v2:
> > - Limit sdmmc max-frequency to 100 MHz on ROCK 2A/2F
> > - Drop clock-output-names prop from rtc node on Sige1 and NanoPi Zero2
> > - Drop regulator-boot-on from usb 2.0 host regulators on Sige1
> > - Add bluetooth and wifi nodes on Sige1
> > - Collect t-b tag for NanoPi Zero2
> >=20
> > These boards can be booted from emmc or sd-card using the U-Boot 2025.07
> > generic-rk3528 target or work-in-progress patches for these boards [1].
> >=20
> > For working bluetooth on ArmSoM Sige1 the patch "arm64: dts: rockchip:
> > Fix UART DMA support for RK3528" [2] is required.
> >=20
> > [1] https://source.denx.de/u-boot/contributors/kwiboo/u-boot/-/commits/=
rk3528
> > [2] https://lore.kernel.org/r/20250709210831.3170458-1-jonas@kwiboo.se
> >=20
> > Jonas Karlman (6):
> >   dt-bindings: arm: rockchip: Add Radxa ROCK 2A/2F
> >   arm64: dts: rockchip: Add Radxa ROCK 2A/2F
> >   dt-bindings: arm: rockchip: Add ArmSoM Sige1
> >   arm64: dts: rockchip: Add ArmSoM Sige1
> >   dt-bindings: arm: rockchip: Add FriendlyElec NanoPi Zero2
> >   arm64: dts: rockchip: Add FriendlyElec NanoPi Zero2
> >=20
> >  .../devicetree/bindings/arm/rockchip.yaml     |  17 +
> >  arch/arm64/boot/dts/rockchip/Makefile         |   4 +
> >  .../boot/dts/rockchip/rk3528-armsom-sige1.dts | 464 ++++++++++++++++++
> >  .../boot/dts/rockchip/rk3528-nanopi-zero2.dts | 340 +++++++++++++
> >  .../boot/dts/rockchip/rk3528-rock-2.dtsi      | 293 +++++++++++
> >  .../boot/dts/rockchip/rk3528-rock-2a.dts      |  82 ++++
> >  .../boot/dts/rockchip/rk3528-rock-2f.dts      |  10 +
> >  7 files changed, 1210 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-armsom-sige1.dts
> >  create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-nanopi-zero2.dts
> >  create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-rock-2.dtsi
> >  create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-rock-2a.dts
> >  create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-rock-2f.dts
>=20
> Any thoughts on this series? Rebased patches for a possible re-send v5
> contained no changes compared to this v4.
>=20
> I would like to send a v2 on the follow up "rockchip: Add USB 2.0
> support for RK3528" [3] series and was unsure about the state of this
> series before sending that.
>=20
> [3] https://lore.kernel.org/r/20250723122323.2344916-1-jonas@kwiboo.se

it was pretty far down in my inbox, so I hadn't gotten to it yet,
picked up now and the patches indeed look good as they are.

Thanks for the ping though.
Heiko




