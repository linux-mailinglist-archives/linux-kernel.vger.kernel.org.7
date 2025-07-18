Return-Path: <linux-kernel+bounces-736310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E05B09B5F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 08:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE3DB5A4CC2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 06:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE9121A92F;
	Fri, 18 Jul 2025 06:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b="l4mIGL+F"
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9386A213E74;
	Fri, 18 Jul 2025 06:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752820017; cv=none; b=tCZejIqiw/6DXuUhGCXk+Mr0JUBKUKqzs+DkGeAKADL23oCj/IeLkx1c7H5Wsw3/rJjGGjw1dbI3JIOJTlkmdmtBeyKYhWwbQH8lpayqi1BqdjnVoDoZ6pufXiT76nV14kUFajIid9oy+fOefaE8GVw0fNipE1f2kCeMKCx3b4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752820017; c=relaxed/simple;
	bh=IFjBh/IsLkSBy3BP+55MVOlJYanvu03dU7s+TFtZgr4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=kybqrsuq4SnOcLb6/LqisWeE5oALnreWNNqU1jxsy381GVmekygG4yPvK9jLGcBkZtx+YFa/rA1Hf2mb/at1/5u1MMXKX4EnIcTAv2UXUAqf6cMhzIR0zYhS0JuwoPHjJaLDQ6vGT5bo0xY10ymWSa8RfyFydXwrxe2Dyo61rVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com; spf=pass smtp.mailfrom=airkyi.com; dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b=l4mIGL+F; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airkyi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
	s=altu2504; t=1752820004;
	bh=cVsfyWOIHeXBsAv/pI+LuirkOLN75phRnl2QMAl6n60=;
	h=From:To:Subject:Date:Message-Id;
	b=l4mIGL+F6y8UuFoyzqQfhL1bxsyUOc9qsEey6Ekc8hEi7X5HWbN5OulmZ4e/HDONn
	 PYfHII8iQ8emmwJZ8OvfqPypCSnhZnSsfAmmaKdSMHbMhLPHaDbCqVWxMKT/p3LHIb
	 WNj7I7qDsCasYpcqzf9EzLr5KK8jaVTmT5i59FCM=
X-QQ-mid: zesmtpgz7t1752820000tf3acf635
X-QQ-Originating-IP: 3Esvg81Z8Km/8FLlclkdOlva9JVeBii6w+oXvk+xVbQ=
Received: from DESKTOP-8BT1A2O.localdomain ( [58.22.7.114])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 18 Jul 2025 14:26:37 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15425296164838630341
From: Chaoyi Chen <kernel@airkyi.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Sandy Huang <hjc@rock-chips.com>,
	Andy Yan <andy.yan@rock-chips.com>,
	Yubing Zhang <yubing.zhang@rock-chips.com>,
	Frank Wang <frank.wang@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Amit Sunil Dhamne <amitsd@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Chaoyi Chen <chaoyi.chen@rock-chips.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Johan Jonker <jbx6244@gmail.com>,
	Diederik de Haas <didi.debian@cknow.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v2 4/5] arm64: dts: rockchip: Add missing dp_out port for RK3399 CDN-DP
Date: Fri, 18 Jul 2025 14:26:18 +0800
Message-Id: <20250718062619.99-5-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250718062619.99-1-kernel@airkyi.com>
References: <20250718062619.99-1-kernel@airkyi.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:airkyi.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: OE2SNMSfMbmORXJFDxgWUZpy1G24zUdJJv8O1MCVDzCHzFQ6gH26sYAI
	iSuMmxklI1OPRYsn8wanpC9cOzHAUHKtjaNIrFi2v3LLTNjNhtBfjk4qWBvk3fFSMdNO2by
	zVZ7Hxq/v60RT9aAqAGGxmpkIRGnpTzHRCBNEDGwB3F06xN6Q83dyfAVCsp5vpl63o500M3
	8gRp2YfQwcQYLrUdf4iyN2o3S3YPaRMmmvs9mB/ZPqZ9J8zI0C0z/WtP9Gxt5VpJMn8zkvq
	GedSi7Q0p0WvnXUYGz74iauEAiBcPFvKh1TT6zKWjF/UC4NKybxV4qG5uVJGbawa7MviNYr
	ZWxMUwKxl2+bcnGX0P6s6inUrXFmBpyrs3OsZaM8h1bNGbPvO+oW/tl2Gxa45psc82+Dwgu
	ZUmBA03lN/3LAPZfJjWMFirF57AX74HQWIDr0nR1XEpmqUaYh8bFfIfCYdHhKZGewwnKUko
	WNkbxOzMGFif7A/S/Eo/1ETDMeBdtRsESGWatvWjqsl8YOxsEXSLag1Wus+ajuOz8dC45KQ
	mdI6QzYUbCAsbIJIAhzmnZqE1RjMReLqI29yx/IgP2szC97wV/ekHkk9jDaryaoLJSxUCGo
	MVHYTQdZ4DqN0J2bsYS6dlTdip5//nz+HN+KzP1PBChcPiN1nEx5EoBIWN1y8BlzgOkpMjK
	fnKxEJAsDRsiXpBmKhK5vyBque2nJXaEgbUvCE7FmSTW7O6a0XUzZgUD68o/CZUNEv+P8X6
	SXG75c+v/2m7NGvERr0VY1Cg2Lulevf8n/Tqtzp58CochtgLUu2tXhyow0Ad8wahAKvuM3V
	cqhWbth/Kyn2gp07YoPyTtqAZ26PzH3EuYK1k1UFMHvV1xJnzH3ou6al3siAz3UnKK5JyY2
	fTRx6judLz5hKdWmAxkN9JklxSBSbp1jvg9pMcDYyqSKejd3wNkSpXtp/LTP4yRKWLUERiD
	ioDH2961frAVTKBO+9Wml/FRsglrB7P5mDrcdKO9OJeBK7cvYRDj33Qm6741eRnsMpDg=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Chaoyi Chen <chaoyi.chen@rock-chips.com>

Let's make the ports nodes of cdn_dp in the same style as the other
display interface, and match the style of ports's yaml.

Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-base.dtsi | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-base.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-base.dtsi
index 9d5f5b083e3c..edeb177bc433 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-base.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-base.dtsi
@@ -618,7 +618,11 @@ cdn_dp: dp@fec00000 {
 		status = "disabled";
 
 		ports {
-			dp_in: port {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			dp_in: port@0 {
+				reg = <0>;
 				#address-cells = <1>;
 				#size-cells = <0>;
 
@@ -632,6 +636,12 @@ dp_in_vopl: endpoint@1 {
 					remote-endpoint = <&vopl_out_dp>;
 				};
 			};
+
+			dp_out: port@1 {
+				reg = <1>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
 		};
 	};
 
-- 
2.49.0


