Return-Path: <linux-kernel+bounces-757057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B083B1BD19
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 01:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C21118A6F06
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 23:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F13C2BE03A;
	Tue,  5 Aug 2025 23:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U3BrmVN/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F922BDC3D;
	Tue,  5 Aug 2025 23:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754436330; cv=none; b=n9lp35FQE/3Qi9Y0Lel7X13Mf7IcJ2aULhUzUivTCGp2hhLbXTMX1aLvsbC4iAXM3Z1IPduc5KcwUBqr+h4klH9agq3IeRdu1rHcdqj6ePUo5rxCybtS/weWtaXNiueR4gBw0A4LojoGPHHwLVyq+C7i2pD83qq2dVDNSWwkM7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754436330; c=relaxed/simple;
	bh=8O1t4GcNNQJ+9+rv4EOXP/qKQx9JxTdazTJ0tkj+WmY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k3wbhqT4zvPqF4/OrARTwZnwIMhZgJxsstCQM8l0a54ICoGyRDT+sS62frECYfG0erWsFA5/tFQKs18aOcQ2GbXez+s/iNll2AqptvIsW7EEoAcGFHXgc42fHecpkePOoBWME2evkvTY4GcT6cWWBw69UukrSrFm3KYWxwImEr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U3BrmVN/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81958C4CEF0;
	Tue,  5 Aug 2025 23:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754436329;
	bh=8O1t4GcNNQJ+9+rv4EOXP/qKQx9JxTdazTJ0tkj+WmY=;
	h=From:To:Cc:Subject:Date:From;
	b=U3BrmVN/M3cwf0DjtQacC8wtZomGEAJ0EUOInZ0PkDJzDi2U/LS9sKWotnEU8v99+
	 eFN0V7PK1BGlGA+9GwyeiuPNAgodqj8noncM3QqEh2XNaIbqm4c57srxTiecHwhOBS
	 IpX6dwgmXqSqavhPl2oG7oG24BiUd91wi0whiZCEG6l757ftBvZUehRThq3F48HgKG
	 h1KTmFfeKWKd/XMCchCw7KGKh9KrcDP/04DRXcPpZeH3iYqNg8zdxMxD9uBOSO30WM
	 2DNeVvhU2FrO8q/TvY2YPWFiHhF3qvqkNTe9M+8wWYh/4m5VhjdYBL9qG2kikQBxpi
	 1p2HER+IFFdBQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: arm: marvell: Convert marvell,kirkwood boards to DT schema
Date: Tue,  5 Aug 2025 18:25:25 -0500
Message-ID: <20250805232527.2828521-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert Marvell Kirkwood based boards to DT schema format.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/arm/marvell/kirkwood.txt         |  27 --
 .../bindings/arm/marvell/marvell,kirkwood.txt | 105 -------
 .../arm/marvell/marvell,kirkwood.yaml         | 266 ++++++++++++++++++
 3 files changed, 266 insertions(+), 132 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/marvell/kirkwood.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/marvell/marvell,kirkwood.txt
 create mode 100644 Documentation/devicetree/bindings/arm/marvell/marvell,kirkwood.yaml

diff --git a/Documentation/devicetree/bindings/arm/marvell/kirkwood.txt b/Documentation/devicetree/bindings/arm/marvell/kirkwood.txt
deleted file mode 100644
index 98cce9a653eb..000000000000
--- a/Documentation/devicetree/bindings/arm/marvell/kirkwood.txt
+++ /dev/null
@@ -1,27 +0,0 @@
-Marvell Kirkwood Platforms Device Tree Bindings
------------------------------------------------
-
-Boards with a SoC of the Marvell Kirkwood
-shall have the following property:
-
-Required root node property:
-
-compatible: must contain "marvell,kirkwood";
-
-In order to support the kirkwood cpufreq driver, there must be a node
-cpus/cpu@0 with three clocks, "cpu_clk", "ddrclk" and "powersave",
-where the "powersave" clock is a gating clock used to switch the CPU
-between the "cpu_clk" and the "ddrclk".
-
-Example:
-
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		cpu@0 {
-		      device_type = "cpu";
-		      compatible = "marvell,sheeva-88SV131";
-		      clocks = <&core_clk 1>, <&core_clk 3>, <&gate_clk 11>;
-		      clock-names = "cpu_clk", "ddrclk", "powersave";
-		};
diff --git a/Documentation/devicetree/bindings/arm/marvell/marvell,kirkwood.txt b/Documentation/devicetree/bindings/arm/marvell/marvell,kirkwood.txt
deleted file mode 100644
index 7d28fe4bf654..000000000000
--- a/Documentation/devicetree/bindings/arm/marvell/marvell,kirkwood.txt
+++ /dev/null
@@ -1,105 +0,0 @@
-Marvell Kirkwood SoC Family Device Tree Bindings
-------------------------------------------------
-
-Boards with a SoC of the Marvell Kirkwook family, eg 88f6281
-
-* Required root node properties:
-compatible: must contain "marvell,kirkwood"
-
-In addition, the above compatible shall be extended with the specific
-SoC. Currently known SoC compatibles are:
-
-"marvell,kirkwood-88f6192"
-"marvell,kirkwood-88f6281"
-"marvell,kirkwood-88f6282"
-"marvell,kirkwood-88f6283"
-"marvell,kirkwood-88f6702"
-"marvell,kirkwood-98DX4122"
-
-And in addition, the compatible shall be extended with the specific
-board. Currently known boards are:
-
-"buffalo,linkstation-lsqvl"
-"buffalo,linkstation-lsvl"
-"buffalo,linkstation-lswsxl"
-"buffalo,linkstation-lswxl"
-"buffalo,linkstation-lswvl"
-"buffalo,lschlv2"
-"buffalo,lsxhl"
-"buffalo,lsxl"
-"cloudengines,pogo02"
-"cloudengines,pogoplugv4"
-"dlink,dns-320"
-"dlink,dns-320-a1"
-"dlink,dns-325"
-"dlink,dns-325-a1"
-"dlink,dns-kirkwood"
-"excito,b3"
-"globalscale,dreamplug-003-ds2001"
-"globalscale,guruplug"
-"globalscale,guruplug-server-plus"
-"globalscale,sheevaplug"
-"globalscale,sheevaplug"
-"globalscale,sheevaplug-esata"
-"globalscale,sheevaplug-esata-rev13"
-"iom,iconnect"
-"iom,iconnect-1.1"
-"iom,ix2-200"
-"keymile,km_kirkwood"
-"lacie,cloudbox"
-"lacie,inetspace_v2"
-"lacie,laplug"
-"lacie,nas2big"
-"lacie,netspace_lite_v2"
-"lacie,netspace_max_v2"
-"lacie,netspace_mini_v2"
-"lacie,netspace_v2"
-"marvell,db-88f6281-bp"
-"marvell,db-88f6282-bp"
-"marvell,mv88f6281gtw-ge"
-"marvell,rd88f6281"
-"marvell,rd88f6281"
-"marvell,rd88f6281-a0"
-"marvell,rd88f6281-a1"
-"mpl,cec4"
-"mpl,cec4-10"
-"netgear,readynas"
-"netgear,readynas"
-"netgear,readynas-duo-v2"
-"netgear,readynas-nv+-v2"
-"plathome,openblocks-a6"
-"plathome,openblocks-a7"
-"raidsonic,ib-nas6210"
-"raidsonic,ib-nas6210-b"
-"raidsonic,ib-nas6220"
-"raidsonic,ib-nas6220-b"
-"raidsonic,ib-nas62x0"
-"seagate,dockstar"
-"seagate,goflexnet"
-"synology,ds109"
-"synology,ds110jv10"
-"synology,ds110jv20"
-"synology,ds110jv30"
-"synology,ds111"
-"synology,ds209"
-"synology,ds210jv10"
-"synology,ds210jv20"
-"synology,ds212"
-"synology,ds212jv10"
-"synology,ds212jv20"
-"synology,ds212pv10"
-"synology,ds409"
-"synology,ds409slim"
-"synology,ds410j"
-"synology,ds411"
-"synology,ds411j"
-"synology,ds411slim"
-"synology,ds413jv10"
-"synology,rs212"
-"synology,rs409"
-"synology,rs411"
-"synology,rs812"
-"usi,topkick"
-"usi,topkick-1281P2"
-"zyxel,nsa310"
-"zyxel,nsa310a"
diff --git a/Documentation/devicetree/bindings/arm/marvell/marvell,kirkwood.yaml b/Documentation/devicetree/bindings/arm/marvell/marvell,kirkwood.yaml
new file mode 100644
index 000000000000..120784066833
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/marvell/marvell,kirkwood.yaml
@@ -0,0 +1,266 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/marvell/marvell,kirkwood.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell Kirkwood SoC Family
+
+maintainers:
+  - Andrew Lunn <andrew@lunn.ch>
+  - Gregory Clement <gregory.clement@bootlin.com>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - qnap,ts219
+              - qnap,ts419
+              - synology,ds110
+              - synology,ds111
+              - synology,ds209
+              - synology,ds409slim
+              - synology,ds411j
+              - synology,ds411slim
+              - synology,rs212
+              - synology,rs409
+          - const: marvell,kirkwood
+
+      - items:
+          - const: synology,ds109
+          - const: synology,ds110jv20
+          - const: synology,ds110
+          - const: marvell,kirkwood
+
+      - items:
+          - const: synology,ds110jv10
+          - const: synology,ds110jv30
+          - const: marvell,kirkwood
+
+      - items:
+          - const: synology,ds210jv10
+          - const: synology,ds210jv20
+          - const: synology,ds210jv30
+          - const: synology,ds211j
+          - const: marvell,kirkwood
+
+      - items:
+          - const: synology,ds212jv10
+          - const: synology,ds212jv20
+          - const: marvell,kirkwood
+
+      - items:
+          - const: synology,ds212
+          - const: synology,ds212pv10
+          - const: synology,ds212pv10
+          - const: synology,ds212pv20
+          - const: synology,ds213airv10
+          - const: synology,ds213v10
+          - const: marvell,kirkwood
+
+      - items:
+          - const: synology,ds409
+          - const: synology,ds410j
+          - const: marvell,kirkwood
+
+      - items:
+          - const: synology,ds411
+          - const: synology,ds413jv10
+          - const: marvell,kirkwood
+
+      - items:
+          - const: synology,rs411
+          - const: synology,rs812
+          - const: marvell,kirkwood
+
+      - items:
+          - enum:
+              - cloudengines,pogoplugv4
+              - lacie,laplug
+              - lacie,netspace_lite_v2
+              - lacie,netspace_mini_v2
+              - marvell,rd88f6192
+              - seagate,blackarmor-nas220
+          - enum:
+              - marvell,kirkwood-88f6192
+          - const: marvell,kirkwood
+
+      - items:
+          - enum:
+              - buffalo,lswsxl
+              - buffalo,lswxl
+              - checkpoint,l-50
+              - cloudengines,pogoe02
+              - ctera,c200-v1
+              - dlink,dir-665
+              - endian,4i-edge-200
+              - excito,b3
+              - globalscale,sheevaplug
+              - hp,t5325
+              - iom,ix2-200
+              - lacie,inetspace_v2
+              - lacie,netspace_v2
+              - lacie,netspace_max_v2
+              - marvell,db-88f6281-bp
+              - marvell,mv88f6281gtw-ge
+              - seagate,dockstar
+              - seagate,goflexnet
+              - zyxel,nsa310
+              - zyxel,nsa320
+          - const: marvell,kirkwood-88f6281
+          - const: marvell,kirkwood
+
+      - items:
+          - enum:
+              - buffalo,lschlv2
+              - buffalo,lsxhl
+          - const: buffalo,lsxl
+          - const: marvell,kirkwood-88f6281
+          - const: marvell,kirkwood
+
+      - items:
+          - const: dlink,dns-320-a1
+          - const: dlink,dns-320
+          - const: dlink,dns-kirkwood
+          - const: marvell,kirkwood-88f6281
+          - const: marvell,kirkwood
+
+      - items:
+          - const: dlink,dns-325-a1
+          - const: dlink,dns-325
+          - const: dlink,dns-kirkwood
+          - const: marvell,kirkwood-88f6281
+          - const: marvell,kirkwood
+
+      - items:
+          - const: globalscale,dreamplug-003-ds2001
+          - const: globalscale,dreamplug
+          - const: marvell,kirkwood-88f6281
+          - const: marvell,kirkwood
+
+      - items:
+          - const: globalscale,guruplug-server-plus
+          - const: globalscale,guruplug
+          - const: marvell,kirkwood-88f6281
+          - const: marvell,kirkwood
+
+      - items:
+          - const: globalscale,sheevaplug-esata-rev13
+          - const: globalscale,sheevaplug-esata
+          - const: globalscale,sheevaplug
+          - const: marvell,kirkwood-88f6281
+          - const: marvell,kirkwood
+
+      - items:
+          - const: iom,iconnect-1.1
+          - const: iom,iconnect
+          - const: marvell,kirkwood-88f6281
+          - const: marvell,kirkwood
+
+      - items:
+          - const: lacie,d2net_v2
+          - const: lacie,netxbig
+          - const: marvell,kirkwood-88f6281
+          - const: marvell,kirkwood
+      - items:
+          - enum:
+              - lacie,net2big_v2
+              - lacie,net5big_v2
+          - const: lacie,netxbig
+          - const: marvell,kirkwood-88f6281
+          - const: marvell,kirkwood
+
+      - items:
+          - enum:
+              - marvell,openrd-base
+              - marvell,openrd-client
+              - marvell,openrd-ultimate
+          - const: marvell,openrd
+          - const: marvell,kirkwood-88f6281
+          - const: marvell,kirkwood
+
+      - items:
+          - enum:
+              - marvell,rd88f6281-a
+              - marvell,rd88f6281-z0
+          - const: marvell,rd88f6281
+          - const: marvell,kirkwood-88f6281
+          - const: marvell,kirkwood
+
+      - items:
+          - const: mpl,cec4-10
+          - const: mpl,cec4
+          - const: marvell,kirkwood-88f6281
+          - const: marvell,kirkwood
+
+      - items:
+          - const: raidsonic,ib-nas6210-b
+          - const: raidsonic,ib-nas6220-b
+          - const: raidsonic,ib-nas6210
+          - const: raidsonic,ib-nas6220
+          - const: raidsonic,ib-nas62x0
+          - const: marvell,kirkwood-88f6281
+          - const: marvell,kirkwood
+
+      - items:
+          - const: zyxel,nsa310a
+          - const: zyxel,nsa310
+          - const: marvell,kirkwood-88f6281
+          - const: marvell,kirkwood
+
+      - items:
+          - enum:
+              - buffalo,lsqvl
+              - buffalo,lsvl
+              - buffalo,lswvl
+              - linksys,viper
+              - marvell,db-88f6282-bp
+              - zyxel,nsa325
+          - const: marvell,kirkwood-88f6282
+          - const: marvell,kirkwood
+
+      - items:
+          - const: lacie,nas2big
+          - const: lacie,netxbig
+          - const: marvell,kirkwood-88f6282
+          - const: marvell,kirkwood
+
+      - items:
+          - enum:
+              - netgear,readynas-duo-v2
+              - netgear,readynas-nv+-v2
+          - const: netgear,readynas
+          - const: marvell,kirkwood-88f6282
+          - const: marvell,kirkwood
+
+      - items:
+          - const: usi,topkick-1281P2
+          - const: usi,topkick
+          - const: marvell,kirkwood-88f6282
+          - const: marvell,kirkwood
+
+      - items:
+          - enum:
+              - plathome,openblocks-a6
+              - plathome,openblocks-a7
+          - const: marvell,kirkwood-88f6283
+          - const: marvell,kirkwood
+
+      - items:
+          - enum:
+              - lacie,cloudbox
+              - zyxel,nsa310s
+          - const: marvell,kirkwood-88f6702
+          - const: marvell,kirkwood
+
+      - items:
+          - enum:
+              - keymile,km_fixedeth
+              - keymile,km_kirkwood
+          - const: marvell,kirkwood-98DX4122
+          - const: marvell,kirkwood
+
+additionalProperties: true
-- 
2.47.2


