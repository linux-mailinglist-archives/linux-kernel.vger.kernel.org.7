Return-Path: <linux-kernel+bounces-722494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 389AAAFDB4C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 00:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84800175BAD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 22:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977262253E1;
	Tue,  8 Jul 2025 22:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="ODXAp3FM"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3B3203710
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 22:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752014980; cv=none; b=l/r0wcIM/VSBmIi7N00eNXqF9ASZf9P+Cu/w5D1NOhEdDC3bVW6ndpy2bM7qi6xjljZp0/c7MbpmFKzs9K41bnlCZajtYxe8RJyd9IqP7QgoWcQENCxSOx/uNh8/w2XgJKDooFbGFOItAmQxZzxMfbi2ueBWiIYLdfwXoe3DRZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752014980; c=relaxed/simple;
	bh=JaJ/Yjz6aQRadzmPIEwbSN2GxrPFRXj+N6F1ehjWG8M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mxCco8sHDDUVmZw4AneMkhEWjj/o3Wpx3804RP5weyEdpmHFCyDuuVIz4KnEV861CphqBT7NDEZ0SV0zjygwv2gqb7tr20PBMo1HtMHarCCbYbvMjLSli7pZvFUBqIGcaJm6uUTm0ZjSv/jj1T/CMG4NP7tF/3IXx4rE69/7v0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=ODXAp3FM; arc=none smtp.client-ip=121.127.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1752014971;
 bh=UvbgoGgrmXP3B5uQ+cywVTSDeS9uHHY5U7o4ME++MHI=;
 b=ODXAp3FMDk1GGm+hgUlv5zyOAM5zx220P73ox/ayfDmkNF1SsD6Btw2Y2DFvifphvvBzpNsgu
 qjYx0RoaBaalItpnC0/PhsOayQairTWCGztBihoLHcFK3x3MfGbC1Bw8ZXwtfC3xcvrhJF5Heww
 Rs7a4jffbUtKTOijcuHu7tMbjow2bHFbB6hbJI5gP/3Gj+QSlB2Xbvceluy14xceaDaTmJlM4i7
 CQEN8JBV+uU9SE2s1OS4O+T7SlMQ0v9lIoyMj0AeBAo0ygmGu9hoEuZUMUeVvXM5d38omdbU3YO
 uXqRGCTe6YJbFSx6E0DCLiYPsRawnGVNKUI/8CDhmAEA==
X-Forward-Email-ID: 686da07775317ad3cfdad39e
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.1.3
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Heiko Stuebner <heiko@sntech.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Yao Zi <ziyao@disroot.org>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 0/6] arm64: dts: rockchip: Add ROCK 2A/2F, Sige1 and NanoPi Zero2
Date: Tue,  8 Jul 2025 22:48:50 +0000
Message-ID: <20250708224921.2254116-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds dt-bindings and initial device tree for the following
Rockchip RK3528A boards:
- Radxa ROCK 2A/2F
- ArmSoM Sige1
- FriendlyElec NanoPi Zero2

The bt/wifi_reg_on pins are described in the device tree using
rfkill-gpio nodes.

These boards can be booted from emmc or sd-card using the U-Boot 2025.07
generic-rk3528 target.

The patch "arm64: dts: rockchip: Fix pinctrl node names for RK3528" [1]
is recommended to remove a few CHECK_DTBS=y W=2 node_name_chars_strict
warnings for these boards.

[1] https://lore.kernel.org/r/20250621113859.2146400-1-jonas@kwiboo.se

Jonas Karlman (6):
  dt-bindings: arm: rockchip: Add Radxa ROCK 2A/2F
  arm64: dts: rockchip: Add Radxa ROCK 2A/2F
  dt-bindings: arm: rockchip: Add ArmSoM Sige1
  arm64: dts: rockchip: Add ArmSoM Sige1
  dt-bindings: arm: rockchip: Add FriendlyElec NanoPi Zero2
  arm64: dts: rockchip: Add FriendlyElec NanoPi Zero2

 .../devicetree/bindings/arm/rockchip.yaml     |  17 +
 arch/arm64/boot/dts/rockchip/Makefile         |   4 +
 .../boot/dts/rockchip/rk3528-armsom-sige1.dts | 449 ++++++++++++++++++
 .../boot/dts/rockchip/rk3528-nanopi-zero2.dts | 341 +++++++++++++
 .../boot/dts/rockchip/rk3528-rock-2.dtsi      | 292 ++++++++++++
 .../boot/dts/rockchip/rk3528-rock-2a.dts      |  82 ++++
 .../boot/dts/rockchip/rk3528-rock-2f.dts      |  10 +
 7 files changed, 1195 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-armsom-sige1.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-nanopi-zero2.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-rock-2.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-rock-2a.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-rock-2f.dts

-- 
2.49.0


