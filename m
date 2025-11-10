Return-Path: <linux-kernel+bounces-893851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C57C487F5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 19:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBD353AC3BE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 18:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8AF31AF25;
	Mon, 10 Nov 2025 18:12:01 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9914315D44;
	Mon, 10 Nov 2025 18:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762798321; cv=none; b=r5icXLU1XCdfjP+HRn4CJhLgHLq+YNicfsqT0T5drcI8ClhmlnLtO1hIcqP4pZ51vb2xMOY/eBX11AMiFNfv4V9Jrx4Z9s3KcDVcTaq6fHmGNd4HxmhPoScGen5RJJphAPeLXR1BAp5R/aiLxM3VBJyjYa0Z0tz561gSZ8DmaR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762798321; c=relaxed/simple;
	bh=rGfCgVL9ZJldBhkZ4lO+foI46AXWNIP+YjE+vFy6v7s=;
	h=From:To:Cc:Subject:Message-Id:Date; b=NBUXGYlbxPgxTWOO6KhBzthS98lGbessS5v4EYUtFzcsS+zSpv6ZkgfBn1tdkAw5yL4t2pmNr8su2FwpGpMfAV2x0QDIeBvkZyb7zaWwESnkl1KRq4VfJck1ZHALNDQmJBTW5dHa0JOXzjxM/rK3Mrr7d8bwxMgQbJvZ8YXKaME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2005)
	id CC62B6732A; Mon, 10 Nov 2025 19:11:53 +0100 (CET)
From: Torsten Duwe <duwe@lst.de>
To: Heiko Stuebner <heiko@sntech.de>, Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
    Rob Herring <robh@kernel.org>, Jianfeng Liu <liujianfeng1994@gmail.com>, Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH] devicetree rk3588: enable HDMI audio on Rock 5 ITX
Message-Id: <20251110181153.CC62B6732A@verein.lst.de>
Date: Mon, 10 Nov 2025 19:11:53 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The Rock 5 ITX only needs enablement for 2 nodes in order to send audio
on HDMI1, the connector closer to the 12V barrel jack and farther from
S/PDIF.  It is sufficient to declare the audio injection as okay, and
to activate I2S6.

Note that for the other HDMI output it is not that trivial, as the video
data there originates from the SoC's DisplayPort output DP1 and is only
converted to HDMI in U7 (an RA620).

Signed-off-by: Torsten Duwe <duwe@lst.de>

---
 arch/arm64/boot/dts/rockchip/rk3588-rock-5-itx.dts |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/src/arm64/rockchip/rk3588-rock-5-itx.dts b/src/arm64/rockchip/rk3588-rock-5-itx.dts
index bc8140883d..c824727cf4 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5-itx.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5-itx.dts
@@ -345,6 +345,10 @@
 	};
 };
 
+&hdmi1_sound {
+	status = "okay";
+};
+
 &hdptxphy1 {
 	status = "okay";
 };
@@ -546,6 +550,11 @@
 	};
 };
 
+/* HDMI1 ("HDMI TX1 8K") audio */
+&i2s6_8ch {
+	status = "okay";
+};
+
 &package_thermal {
 	polling-delay = <1000>;
 

