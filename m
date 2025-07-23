Return-Path: <linux-kernel+bounces-742482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27773B0F234
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 14:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA8197B7DE0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 12:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1A02E88B4;
	Wed, 23 Jul 2025 12:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="fhqWaWVH"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9162E888D
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 12:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753273464; cv=none; b=WfDkrcJpdt8fDpPIe5tucFP6Sz39sd23FxGgeh9QR1GHJvin3R6ZA3P2wgQ2GQiI3c0bZHt8dhC4ddh0p/IKQNb7nPa7zkNI8AYX178pwaJCbqE7fOX9HPJaqomeVIvdDYoe/HqZYWuw09ye5+t3vnE+qDd/MzPXec9pPMJ4qT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753273464; c=relaxed/simple;
	bh=rbyRUPemFNuT0idxlCLLaRMPMx4aMqZM99/KabqakBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S+4C7h4nY83+HaMUc0LoplOo7BjmNu5rmvHyKc2Ud6y36UL6OQ6GnI8LubmrlATry45llHpUFSRGaBkf1BDC2Wzy+Ug3jUNKAGWF+8JUv7vi3IC0pYHbzp5zZpcjBP0zSE2gpH6fisszB8fHS/b5//b9Bn0Rqay5Q59V8QdsUZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=fhqWaWVH; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1753273462; bh=paq99is5Qpo1XMY5/kQFG7Fqw0m5oXKo6BQg0A6slJo=;
 b=fhqWaWVHzlxL4OlR1mf3gGBON94esKifncCWkyjaqwHzzDFpZVMxe/BFcIgEV1EloufWZ3gTK
 wFgPqHkWb+KlRg/7LMQM4frAIHPf7brcwfFcpj9jw2Pi876HlM+sj9Dwuapg/MLoC9sZ9kFT1po
 8+WrvFqb947AMCqemlJdFu4ot/6HqBGVsZqYYZ0Tqva7JrYhTECqmb55ac7fjPk5nrcAq6XsZ/K
 TMuFHJv8CA1DH/rwAxuM0Ptgx+9YdZ3epvAylh85Adb9tOInqDj2RvZyhcokJre+XHTz5/VcP7R
 K3lzjQcZMvctbmQU1OitkNZw9h0LqOh24EgmSRq1lWkQ==
X-Forward-Email-ID: 6880d46dcb0ee86f9731a134
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.1.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Heiko Stuebner <heiko@sntech.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Yao Zi <ziyao@disroot.org>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 10/11] arm64: dts: rockchip: Enable USB 2.0 ports on ArmSoM Sige1
Date: Wed, 23 Jul 2025 12:23:08 +0000
Message-ID: <20250723122323.2344916-11-jonas@kwiboo.se>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250723122323.2344916-1-jonas@kwiboo.se>
References: <20250723122323.2344916-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ArmSoM Sige1 has two USB 2.0 Type-A HOST ports behind an onboard
USB hub, and one USB 2.0 Type-C OTG port.

Add support for using the USB 2.0 ports on ArmSoM Sige1.

The onboard USB hub handles OHCI so only the EHCI controller is enabled.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 .../boot/dts/rockchip/rk3528-armsom-sige1.dts | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3528-armsom-sige1.dts b/arch/arm64/boot/dts/rockchip/rk3528-armsom-sige1.dts
index 6e21579365a5..d981c07a0a77 100644
--- a/arch/arm64/boot/dts/rockchip/rk3528-armsom-sige1.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3528-armsom-sige1.dts
@@ -434,6 +434,18 @@ &sdmmc {
 	status = "okay";
 };
 
+&u2phy {
+	status = "okay";
+};
+
+&u2phy_host {
+	status = "okay";
+};
+
+&u2phy_otg {
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0m0_xfer>;
@@ -462,3 +474,15 @@ bluetooth {
 		vddio-supply = <&vcc_1v8>;
 	};
 };
+
+&usb_host0_ehci {
+	status = "okay";
+};
+
+&usb_host0_xhci {
+	extcon = <&u2phy>;
+	maximum-speed = "high-speed";
+	phys = <&u2phy_otg>;
+	phy-names = "usb2-phy";
+	status = "okay";
+};
-- 
2.50.1


