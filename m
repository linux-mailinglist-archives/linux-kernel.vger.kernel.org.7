Return-Path: <linux-kernel+bounces-802946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD845B458AC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8B9E17E385
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 13:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78790343D94;
	Fri,  5 Sep 2025 13:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="PpaRUePr"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE233191F98;
	Fri,  5 Sep 2025 13:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757078490; cv=none; b=jdKM+5Rl+V1cJYwgArhm3J5FRhgddf2+T91IZL8/lSARKIW94KLNrMQGzyzkK8CZSSu4HIoQG45Jgy+D9qXmDaYVz4SBFCa0kQORj7x94PHiJJbSTeuvH0sBsv3FFAVBp9gVh9sYrRae2NY9hyCvawrbK3D06HhvnfJUJE+HfMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757078490; c=relaxed/simple;
	bh=5LzAHgCUGNowNZG8+zWWeAtPEjv3HfW+vL/OBN9utHY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=E9G3JPRmVvLiI7wsVqc5EcYdYIHahA1QvqfoO+xQ57JatdQP5wDmjW7vB7vMZiMHIuOwJKa6twqohfCXHKhBm2F91CXh/zMSYYYbKu5d7LVIbkDGC7gPvq4dCYnyyQpWZLqhF2AfRLvtsQ/qo+rd+eGie7yGW/UTKkzTzA1HAmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=PpaRUePr; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1757078480;
	bh=5LzAHgCUGNowNZG8+zWWeAtPEjv3HfW+vL/OBN9utHY=;
	h=From:Date:Subject:To:Cc:From;
	b=PpaRUePreKEpkpL6JsC0+yrr9JQmvmZAOm5EU2habrc+2slwPpcYIwLj3JKBwil2s
	 V0PAiuQRybZeZULK7jN8px3xw7IMcS2c1DrDH1oBo4EVJR4fxtxgogrXfA2dTRpaL6
	 u41DAmTJx6PeXvRpXTGTOVgvYJB/2+MYhhNrpqKuUMa0MlFQEYg/n/h2+wREtUwvhN
	 VhOlGeBXti6T29O6uiBcOIakEPNYbQOTp/+IpW4nrBq9VuU8dAgQJotXgwom4lsSuA
	 XjZWNTaUBPtNm6UAhSPv1jsZDqSjuSQkBYw7IoPEBDHXSfTcCLX7wnWG/NzIUF7P5l
	 ffI50ZCV8BFlg==
Received: from localhost-live.home (2a01cb0892F2D600c8f85cF092d4AF51.ipv6.abo.wanadoo.fr [IPv6:2a01:cb08:92f2:d600:c8f8:5cf0:92d4:af51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jmassot)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DB0FF17E0B85;
	Fri,  5 Sep 2025 15:21:19 +0200 (CEST)
From: Julien Massot <julien.massot@collabora.com>
Date: Fri, 05 Sep 2025 15:21:19 +0200
Subject: [PATCH] arm64: dts: mediatek: mt8395-nio-12l: Enable UFS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-radxa-nio-12l-ufs-v1-1-e2468bfd2c69@collabora.com>
X-B4-Tracking: v=1; b=H4sIAM7jumgC/x3MTQqAIBBA4avIrBtQ6ce6SrQwG2sgNJQiiO6et
 PwW7z2QKTFlGMQDiS7OHEOBqgS4zYaVkJdi0FI3spcNJrvcFgNHVHrH02d0RnXWtLWfaw2lOxJ
 5vv/nOL3vB3UglfJjAAAA
X-Change-ID: 20250905-radxa-nio-12l-ufs-c817a864fb42
To: kernel@collabora.com, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Julien Massot <julien.massot@collabora.com>
X-Mailer: b4 0.14.2

UFS is the primary storage for the Radxa NIO 12L. Enable it
now that the ufshci and ufsphy nodes are available in the
common mt8195 dtsi.

Signed-off-by: Julien Massot <julien.massot@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts b/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts
index 329c60cc6a6be0b4be8c0b8bb033b32d35302804..4cbd78c126f6b56f1833d220f7a7fbc7e4320cbb 100644
--- a/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts
@@ -990,6 +990,16 @@ &uart1 {
 	status = "okay";
 };
 
+&ufshci {
+	vcc-supply = <&mt6359_vemc_1_ldo_reg>;
+	vccq2-supply = <&mt6359_vufs_ldo_reg>;
+	status = "okay";
+};
+
+&ufsphy {
+	status = "okay";
+};
+
 &ssusb0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&usb3_port0_pins>;

---
base-commit: 6c68f4c0a147c025ae0b25fab688c7c47964a02f
change-id: 20250905-radxa-nio-12l-ufs-c817a864fb42

Best regards,
-- 
Julien Massot <julien.massot@collabora.com>


