Return-Path: <linux-kernel+bounces-878362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19160C20697
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18BB64223D7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0A3230BF8;
	Thu, 30 Oct 2025 13:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="W6uFPFPW"
Received: from mx-relay49-hz3.antispameurope.com (mx-relay49-hz3.antispameurope.com [94.100.134.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493941A9FAB
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 13:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=94.100.134.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761832434; cv=pass; b=lCyNjCsP0gUuFYg4u6AVcazmmtHLySxZDu+O7Y5/ozTanaHtvGWytuq7n3pKK/M42eSa0ZdCHe4TONjp49aANremxfPMfzx0k60aM5ocmQS4pPxZ4hY+yLDyozGBbdiw7lu0yJpS6xnBYfdsuPLSJ1RJHEHbQPim/yNk+p8jG8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761832434; c=relaxed/simple;
	bh=vSEt8sKRMJkJ7G1x852UGcOe5J/Jb3KgwI4p2Vj8AwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CnRoxkJ21fECGfgEtWTwjjj1EC/P5As3L8BrVJ6rVvm9rkggf3d4EeqqtdddG6fz+3c+5VvqSiV97JhGvu2iOhmjY0js1JKHA+1Xzt6BmxfmkzbaA52FMTHYln/vGtZiKYQV27mjktjIDi/GUgeVBSuW4LIXwyqropVLRXaBDI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=W6uFPFPW; arc=pass smtp.client-ip=94.100.134.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate49-hz3.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com smtp.helo=smtp-out02-hz1.hornetsecurity.com;
 dmarc=pass header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=kOaQn4zUTWP9GdeQhCdCgUXwFC1T+DHJft+KqyFqp3A=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1761832423;
 b=RfTkOzxbjX6aHL3+ECFPrcggvRlLAmoIJU9GwcN0fvgEiaN58j+/bublTh+65hk/4xfgjYCs
 Uo4h8DTZkBlfd6epypukXo9nzDw6zjhpbYnOQKrdpTJ43hfBNfbrEYqA7QTiDfWJaCvi9bxYg+p
 zrIouLrmcYKOiKLCaHeBgsQfV34RvGUqe4UIRleAg6S2TzHBPuytMZr2s1/6MdMz810hvOjfHD8
 +N6dF3PDF6h0rZ/GYZoiiMWnbrmUmAN4aLHImXg5tj7m3CLzp52fkm3Rkgy08lygZeUOX8zx3Y0
 wVd8wrrec3Co3ds0qppNd85o/qK4BiFwTTU1//Y2DLskw==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1761832423;
 b=F0FIsw6dVIuGnxZ5ETpCZSenLusonVLcoVw6VZScqV2M8qfoOIA7wgWk2X8H625kdRw9A4AM
 YkEfwpojiiuYvRRsnY4yxbc5OAcIWHc7nTe+czhubQUoKyvsZhr136SsW1Ombq7uT87FrHmE+Od
 yAsRq6zgxyMJmjSUpERTf9kbqBDn5ssmsySF0H/R/+/le9hrcej/fISBgFQ82fqN9yyhuvW4eAR
 lpfgbXw3L8a5AoLt8NwDCICLB0y7r75YpZP+dKM1k2svGab0Qs7UkhkcGfkfkmooOypjOYwZZF3
 jJ7uOpAJtOl+CgUPQY8kq5c/WNPapH966VQ4GA/ZHxfdg==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay49-hz3.antispameurope.com;
 Thu, 30 Oct 2025 14:53:42 +0100
Received: from steina-w.tq-net.de (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: alexander.stein@ew.tq-group.com)
	by smtp-out02-hz1.hornetsecurity.com (Postfix) with ESMTPSA id 50BEE5A0994;
	Thu, 30 Oct 2025 14:53:15 +0100 (CET)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Markus Niebel <Markus.Niebel@ew.tq-group.com>,
	linux@ew.tq-group.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 15/19] arm64: dts: imx95-tqma9596sa: add EEPROM pagesize
Date: Thu, 30 Oct 2025 14:52:57 +0100
Message-ID: <20251030135306.1421154-5-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251030135306.1421154-1-alexander.stein@ew.tq-group.com>
References: <20251030124936.1408152-1-alexander.stein@ew.tq-group.com>
 <20251030135306.1421154-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-cloud-security-sender:alexander.stein@ew.tq-group.com
X-cloud-security-recipient:linux-kernel@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: alexander.stein@ew.tq-group.com
X-cloud-security-Mailarchivtype:outbound
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay49-hz3.antispameurope.com with 4cy5DP37Jqz3ybG9
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest:1c794a8416528de567ccb6017bd72231
X-cloud-security:scantime:2.053
DKIM-Signature: a=rsa-sha256;
 bh=kOaQn4zUTWP9GdeQhCdCgUXwFC1T+DHJft+KqyFqp3A=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1761832422; v=1;
 b=W6uFPFPWhx0Y49pSUvS4mgFz++J4FLSqjJrfm95OJkpp6AsDzhTRAU7xyoauQAGZQp87pNsb
 g3rrP7eLZBRSlFjhCylAzvE3Yw/q3gP7bmuwq7EsctuaL6pWN+R3hagqRZgBl2o0PNewl8j9Wu5
 2J56/6cogNXfu4mjxXshu4pYDRodjfVZkSBHqsX2sshtRpZ0UzQnDyK1oZz3W6gcSCGrGpmM/wt
 uGr2Q0va74SmujGwhBiAq4DjaE9GiJLfmpDMFC+0by3TZ5suvi4DoccfTztD4xHalGgR/OAVRCN
 IHbukU/wP7xXml7VFfEjpJpMIDwHek6ziSHAdWvW6tMTg==

From: Markus Niebel <Markus.Niebel@ew.tq-group.com>

The special ID device of the EEPROMS needs pagesize, too.
Otherwise only slow byte write is possible.

Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm64/boot/dts/freescale/imx95-tqma9596sa.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95-tqma9596sa.dtsi b/arch/arm64/boot/dts/freescale/imx95-tqma9596sa.dtsi
index a4c6083ab43b1..43418844701b1 100644
--- a/arch/arm64/boot/dts/freescale/imx95-tqma9596sa.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95-tqma9596sa.dtsi
@@ -203,6 +203,7 @@ m24c64: eeprom@54 {
 	eeprom@58 {
 		compatible = "atmel,24c64d-wl";
 		reg = <0x58>;
+		pagesize = <32>;
 		vcc-supply = <&reg_1v8>;
 	};
 
@@ -210,6 +211,7 @@ eeprom@58 {
 	eeprom@5c {
 		compatible = "atmel,24c64d-wl";
 		reg = <0x5c>;
+		pagesize = <32>;
 		vcc-supply = <&reg_1v8>;
 	};
 
-- 
2.43.0


