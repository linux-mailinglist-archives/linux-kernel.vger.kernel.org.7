Return-Path: <linux-kernel+bounces-825872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE93BB8D000
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 21:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C60861B22B51
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 19:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796C8268690;
	Sat, 20 Sep 2025 19:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bryanhinton.com header.i=@bryanhinton.com header.b="ig3ymr+Z"
Received: from outbound.mr.icloud.com (p-west2-cluster6-host2-snip4-10.eps.apple.com [57.103.70.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E51B266B46
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 19:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.70.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758397945; cv=none; b=Dn1BXdPoe+Tuj0m++08yqJBoKCDAMj8lUYevjl3MTiuVWRCoEN87kv+atGC+Cp1F3ImaBVqGCJ8unSB6pOraA1aU3diG1jycB6X00jqctJDL7z9sBjXduWCr9e+v7Ky3DP2l+sa8tHh9qztYCgzS9sHxPt/r/9uSfp5kODPzSqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758397945; c=relaxed/simple;
	bh=ViD4GKMVXKySJQcP0zyWy9TjfV3P4PO6ey/osoRjoKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qsoUWMvPIFo8lXqXPO2NC2mT/AQql8yC/5cbIJNeFZNwDfAKfj9TGqGgL9qXQVnHRiyAkENYnpkug4YsUvBLFR5G3tGPI00+Gp++Sg+epSGXLy5yGu4Boe23VLZZutcnCPpbJpH4qN8RKvHhV6dEpz0/82vKtJAbuDkzULr059k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bryanhinton.com; spf=pass smtp.mailfrom=bryanhinton.com; dkim=pass (2048-bit key) header.d=bryanhinton.com header.i=@bryanhinton.com header.b=ig3ymr+Z; arc=none smtp.client-ip=57.103.70.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bryanhinton.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bryanhinton.com
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-2a-20-percent-0 (Postfix) with UTF8SMTPS id 948721801B24;
	Sat, 20 Sep 2025 19:52:22 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bryanhinton.com; s=sig1; bh=ARNulbwujzqTC6TBIyUcN+Sxg1gArb1tBFDYw0Up1wE=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=ig3ymr+Z+eqzf5M5oemHs6qSw2bHI6kP9uNx6KcgXQa9r74tfZp94pp1bRmrlAM9GQGn1sJcw02QgWy2w6NDexI5TEZ4X8O8eLfI+G1CUt4z4XdTjufcGzweuuwvB9IAfNPdqTF1ieychu7P12NHEsxbjMQ++qktZQo9OEjK8eM+TVdLir13vjvVPQWbeCItwTeMqmq7AhjGauprOuQS/F1lhbu4YBqbdxhrofGtgQDtqh2yVoEIyq4FjvMNAupuVx8+PFII2lGpkEZL1gGVYY9nCa31m8g+hWAeLQb7RKY0tk9UvMl87wJwNWYEKQqfZR+BDIVlKbxYmeTKAcTUSw==
mail-alias-created-date: 1643268037438
Received: from localhost (mr-asmtp-me-k8s.p00.prod.me.com [17.57.152.38])
	by p00-icloudmta-asmtp-us-west-2a-20-percent-0 (Postfix) with UTF8SMTPSA id 2449718001A2;
	Sat, 20 Sep 2025 19:52:22 +0000 (UTC)
From: Bryan Hinton <bryan@bryanhinton.com>
To: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Cc: angelogioacchino.delregno@collabora.com,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	matthias.bgg@gmail.com,
	robh@kernel.org,
	daniel@makrotopia.org,
	Bryan Hinton <bryan@bryanhinton.com>
Subject: [PATCH v2 2/2] arm64: dts: mediatek: mt7981b: OpenWrt One: set console UART to 115200
Date: Sat, 20 Sep 2025 14:50:51 -0500
Message-ID: <20250920195102.2733949-3-bryan@bryanhinton.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250920195102.2733949-1-bryan@bryanhinton.com>
References: <20250920195102.2733949-1-bryan@bryanhinton.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 43BJrrDByWVIPkQyTa670jQr2J9PN48K
X-Proofpoint-ORIG-GUID: 43BJrrDByWVIPkQyTa670jQr2J9PN48K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDE5NCBTYWx0ZWRfXxZxI4GWXbEsL
 Pin0amTzsu+Gfn5Yh1yU3KuNzcd0LQeLbaN2gUx5RQ+VO5p8Qwxfx59XeEeL2S4WhYC3n7faxVI
 xOYkgY7bUntNjSApyOMsc0xUfTwhv4FgpEJmuHpe+q0DnRWC12yH1kPaZqVKMBguWBO8XhOckMd
 WeKn1j7xiovRJfSCfhVggxDSAv4ejbgIF/yZRlMF2FyVbSbXPrAbYuFKlqWmbm6/8hbVkNgL4LE
 1JmwvuTD3KG9rmc9j88fNoZe08nGcAmYrk11CnU2ULyHeEOf4SsCzwWzFMDyK57hMiq1mxYFQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-20_07,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999 clxscore=1030 bulkscore=0 mlxscore=0 suspectscore=0
 phishscore=0 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2509200194
X-JNJ: AAAAAAABZyS4qkue9UJqaMuEO9aLsllPNgsr19EgF0o6Go+lbA0OpU/ZdC7ZCpg0WtAKEpSMlAzriZ0PC2hEffbbKoIZRkmByvbzpFEBIGaY5NlGP2x/5WqylzT8mSZ7cuCUl6+LDd5rj88xIHaxv7Hh+Va62O+RbPu53nYWkqiFa92qtMZBlqqyaCauGEqgW5LDi+T9KHCxffUtdcowshQfUH6K96XbaGyeARnIkYF8izk4CpQVHTv+imtsoucY8njD5axLO3dNnMX+wwGLaCnOyBIOliTeD9iRG45M/H1dpAeL3xwhCvGhl+9W78PLYlCtYz0GH5qAPvAko7eGbGFxzdYPbVqRP4UojdfW51VRJ+7v82TWw2Z/Wu9t8RQcAHlWnvSsmGbKMm7ZX6O2ioGjjrszlbz40lTLDV6UUCb0fgP/aj8YWTndujDH+t3Dh9oDhMRafybne5Eb/dq64k9wfQMnSCc44LYd/XH8G8QKWkHNzhjuoZF1XdgC2fZl7uFqnDWsVvd43SigHkjBY7NGyNVjb2j/ZJsW/Ly6Pt6pP4PnK50ikDfpw7wzfXtsNe9XUsBg7DdpQ2y1VbB9i6HUAlUE42t2eQqy8PnaueTDU8M8hLwsrwEfvRs1pKlPMVyQUCzRv6rs8MoIv0D40bbNe3f8Hl1zChqQCjbgR8zSdbKLL5IRqpVFSQdg6QV/CfuM8WbNdGmyB+G/eq4XDB9oMu0SiQRCE9CFb8xUIYUXtei5q+mx

Use the new uart0 label for the console and make the speed explicit by
adding current-speed = <115200>. This keeps the DTS OS-agnostic: no
bootargs or distribution-specific properties are added.

Verification: Boot-tested with mainline Image+DTB via U-Boot on OpenWrt
One (MT7981B). Serial console active at 115200 baud, and DTB decompile
confirms serial0 alias and stdout-path set correctly.

Changes in v2:
  - Dropped redundant hex value comment on current-speed (review feedback).

Signed-off-by: Bryan Hinton <bryan@bryanhinton.com>
---
 .../arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts b/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts
index 4f6cbb491287..638ed76107e3 100644
--- a/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts
@@ -8,8 +8,21 @@ / {
 	compatible = "openwrt,one", "mediatek,mt7981b";
 	model = "OpenWrt One";
 
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
 	memory@40000000 {
 		reg = <0 0x40000000 0 0x40000000>;
 		device_type = "memory";
 	};
 };
+
+&uart0 {
+	status = "okay";
+	current-speed = <115200>;
+};
-- 
2.51.0


