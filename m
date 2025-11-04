Return-Path: <linux-kernel+bounces-883945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B4DC2EE28
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 02:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D310318908AD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 01:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B4623EA95;
	Tue,  4 Nov 2025 01:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ukJVPvGh";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Nz0/zpV2"
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB54237180;
	Tue,  4 Nov 2025 01:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762221042; cv=none; b=e/jfTQDIDtsfWu9LRHsazT0YBASGM7+O1yzsHu4ZiSyUewhTeEEBNU7iLGpgYU8E7MlWG4xp5fM3k9+zL8g+OZlsM9L/rNghs9RuE9P1CRtU718WvF/AoGytIaOosjBtWuvUphLX5wbgk0c9fhOtje4z1PU+BKlgzOKlorceOnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762221042; c=relaxed/simple;
	bh=SAgtMFsubG/8VFAlFqC1sgnxtzgYTVufuKhUVFsu2ts=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d8n9Sv2Kf5ATihS9JYWCi1n3bxH505ABzxrOfUeLtUcYNDDBEumgp2RO99Fg2iCHjL1av5RRZNzZrHQ8/ClIv7ZLVQ8ji1Hpc1dYQrroxvkrjZ5dnlcmQq4d8E5Q7PsJbdHDgUqg1qjQx3r161sf9Ofw5sRq1lrJ+jjI08qm3CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=ukJVPvGh; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Nz0/zpV2; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4d0ry56v23z9srX;
	Tue,  4 Nov 2025 02:50:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1762221038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vUDHSpaYhTM0MBeAOADgsVN/8YIxpgXSREgpli9VDxQ=;
	b=ukJVPvGh+jPAzd2bTJM3eVvURU44gCZP64EThJ2NRe4oMxdWMz2Rbsn/MjNztsTKjVWYEx
	oDzzNfVo4WxMvt+WUAy35xZT8ABUEAZcdysCVTnZbnHWTgemkbqKtBVgAs33cLBlvyh8B7
	BLRqHb90xE3HuF0abJZNO8L+ec3n/6P2M1nxzXe/zRW6VgaJLGAHqxQ9e8jb3t8ihvUvym
	opB5SI4auDxm3szd9iUCYAMZYn9oWYQT41kTYaMxyuzeYM05nplqqsVX85gOA939JUN5IB
	ZcLHUlv/NM0kQiznvblVcfj6JvUBaHWpKcEXRptPcL/q8YsPzKcDGpufiai8PQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b="Nz0/zpV2";
	spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=marek.vasut@mailbox.org
From: Marek Vasut <marek.vasut@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1762221036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vUDHSpaYhTM0MBeAOADgsVN/8YIxpgXSREgpli9VDxQ=;
	b=Nz0/zpV2VQ8MgfMYtlSwdN3MtmMNXbZWWCs7Na3VxwDqQWNNUzmsvSWzkY0PXgOZElGZKK
	1eoqvJspPTAUyEzoFv8U3HIzTzo/bKbiBiLIen/eUZ5xNdZ4viALN1Ow9f/jlkkGFkMtKL
	tYpWtT8E1emmoWDmSSQXYcFMfB/EETCat25k0HKnJYit80h3wwogHn7AbgNOxQDoS5W/AE
	Ylw0F/K7EoVfg+RlVhBd8wetjya0e4gv25dHH+CWqR8alt2X0gXQadlKTNRR/TTExT85zn
	DHI8SWyozPIY2azVYU5ZRtgnQ4lE0gVFSCmdRw1anCBde25I5TUZSqWjgMY4vA==
To: linux-arm-kernel@lists.infradead.org
Cc: Marek Vasut <marek.vasut@mailbox.org>,
	Christoph Niedermaier <cniedermaier@dh-electronics.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	kernel@dh-electronics.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: imx8mp: Add missing LED enumerators for DH electronics i.MX8M Plus DHCOM on PDK2
Date: Tue,  4 Nov 2025 02:50:13 +0100
Message-ID: <20251104015031.219863-1-marek.vasut@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: d7f6xkzgu6my1hhenurh89d46ohba76d
X-MBO-RS-ID: b536646df4ffa1c32ed
X-Rspamd-Queue-Id: 4d0ry56v23z9srX

The LED enumerators are missing, which prevents the LEDs from being
accurately told apart by label. Fill in the enumerators the same way
they are already present on PDK3.

Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
---
Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Rob Herring <robh@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: imx@lists.linux.dev
Cc: kernel@dh-electronics.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 arch/arm64/boot/dts/freescale/imx8mp-dhcom-pdk2.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-dhcom-pdk2.dts b/arch/arm64/boot/dts/freescale/imx8mp-dhcom-pdk2.dts
index ebdf13e97b4e2..3d18c964a22cd 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-dhcom-pdk2.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-dhcom-pdk2.dts
@@ -88,6 +88,7 @@ led-0 {
 			color = <LED_COLOR_ID_GREEN>;
 			default-state = "off";
 			function = LED_FUNCTION_INDICATOR;
+			function-enumerator = <0>;
 			gpios = <&gpio5 22 GPIO_ACTIVE_HIGH>; /* GPIO E */
 			pinctrl-0 = <&pinctrl_dhcom_e>;
 			pinctrl-names = "default";
@@ -97,6 +98,7 @@ led-1 {
 			color = <LED_COLOR_ID_GREEN>;
 			default-state = "off";
 			function = LED_FUNCTION_INDICATOR;
+			function-enumerator = <1>;
 			gpios = <&gpio5 23 GPIO_ACTIVE_HIGH>; /* GPIO F */
 			pinctrl-0 = <&pinctrl_dhcom_f>;
 			pinctrl-names = "default";
@@ -106,6 +108,7 @@ led-2 {
 			color = <LED_COLOR_ID_GREEN>;
 			default-state = "off";
 			function = LED_FUNCTION_INDICATOR;
+			function-enumerator = <2>;
 			gpios = <&gpio1 11 GPIO_ACTIVE_HIGH>; /* GPIO H */
 			pinctrl-0 = <&pinctrl_dhcom_h>;
 			pinctrl-names = "default";
@@ -115,6 +118,7 @@ led-3 {
 			color = <LED_COLOR_ID_GREEN>;
 			default-state = "off";
 			function = LED_FUNCTION_INDICATOR;
+			function-enumerator = <3>;
 			gpios = <&gpio1 5 GPIO_ACTIVE_HIGH>; /* GPIO I */
 			pinctrl-0 = <&pinctrl_dhcom_i>;
 			pinctrl-names = "default";
-- 
2.51.0


