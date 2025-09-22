Return-Path: <linux-kernel+bounces-826500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C87EB8EADA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 03:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E550189B4BF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 01:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A537B1D5CC6;
	Mon, 22 Sep 2025 01:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b="u0yxSLlS"
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9990618DB35;
	Mon, 22 Sep 2025 01:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758504098; cv=none; b=aJx4gtjHqjfA47mJRRJ5Hg21ruDRLff2RoqvpGQBLRXv4fB80J10LrQQqzmmmtYh0xVSlk2IWZqOb1Ym6qa3jcF0x2gBRC6UZZTuAKV0I0OyE92PBPnqI1HTceZbCLi8c6TILb2GrjrdQFgVdhCu8Xhn5zsSmD0t9Gw8h9N4Alc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758504098; c=relaxed/simple;
	bh=jKgMxEif1Rvy22x6B1k063dU/ySK1MoA1J6lxiTaUmY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=T3+tleyipj8DzLL7LVrsZ/SEKlNM+JMdP/PCU7xRi+gItXV0CmeOFBsTIb1lXMtyRlcUUuRWk02mDNp9+d0Zs6sLZuAsPHAxpjlbaMxcAjffYFpjsy8HhNDm9+QUR4eufKbs8NWfbkaQlG8Cjr2g9PUml0rI09eAL8dvIHPaEew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com; spf=pass smtp.mailfrom=airkyi.com; dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b=u0yxSLlS; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airkyi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
	s=altu2504; t=1758504072;
	bh=FQiFCRapN/3mwb02ZP+dTFVgTrcEVb7y08IjRSvyuIY=;
	h=From:To:Subject:Date:Message-Id;
	b=u0yxSLlSwOATLLm30XMbWjPLBFDpyvoP2neidc+XQMfGEYWq3H5x1vzW5cWOAhydC
	 Nn9CL4SK5uOmvEoLdZ8Vh9+U5MnkyToL6w/ufUa+aU32ptKsuIwg6fpf0dtreQteFF
	 A/Dw9SfKJaM2iYtBkkivy6Yw4G5K5xxO+QXNkjCI=
X-QQ-mid: zesmtpgz1t1758504070tb08ab248
X-QQ-Originating-IP: irFhF1T+2Su/4ccgz1o9QWkx8RvanKgMn5pFCBUgAAg=
Received: from DESKTOP-8BT1A2O.localdomain ( [58.22.7.114])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 22 Sep 2025 09:21:08 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16934661695937755636
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
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Chaoyi Chen <chaoyi.chen@rock-chips.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Johan Jonker <jbx6244@gmail.com>,
	Diederik de Haas <didi.debian@cknow.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Peter Robinson <pbrobinson@gmail.com>
Cc: linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v4 6/7] arm64: dts: rockchip: Add missing dp_out port for RK3399 CDN-DP
Date: Mon, 22 Sep 2025 09:20:38 +0800
Message-Id: <20250922012039.323-7-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250922012039.323-1-kernel@airkyi.com>
References: <20250922012039.323-1-kernel@airkyi.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:airkyi.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: NyTsQ4JOu2J27F0cQTRa45HVw4w+kK5tj4V0OnKDXBe5mvppmncfP6qp
	45qLPwsmsJlTLz4jnSTS/RmllHiiinuwjHdH+oQf67NEm/tWkBZaIv7i5Uk4bYd6ID5Y8Hf
	mbApHF0PaxKxlSsJsMX28cm14O55JBFyyx1zvR+CLG+k6mS84cZsnNjxrcyc1RVgEzXVmR4
	EIWvP1Pn4ncxHDbXb+2ysJmG91JEJZap8djcdA4zy5FqQCguX4XC2a1fgYg9o+z85vbabqk
	d9URqDtt4Y0ZAuAPiHk5uIhg7DaLkzT1zHO5CrqOZEvwbrBVg1eT0dY5jTr4qwrTx4YxEQ+
	Ggo1zNrJxcP0iJjNe3B1XmnMKVdu/3tl5x+99TUlneD6rXKHuCyGLbADpYX7alzTWmKRb+I
	zfKUmztv2zdXbonRR8cHcm54C5/jUeLXkUEwlxNFNGT+23w8NXD3/0WNhK90YQaA9DNYDFY
	WHKfFBAVULS5uRQLDjegE0K0J0K7Md7VMjBrLxBXNw/Pv7NC1byeuyoxAajailPMSA6rugN
	dWUeRcP81GQlyDD2mDnxL3n7TfF+71EbZcPCTcNTVOiJqkRknPoIOW40e1+/TZkkz+q9dDJ
	hD0FUq7Ztfy1psggi98LzfXqrS3gQw+KygR1TdUgdLWYhQhVBNg71DFG6OMkVjxFO1D9Ozl
	uPF/r7r6H5bSfSn9IBLhyLcH/ShOYD3h1rixqXQzRyNObU5JRULJxabR5U5+viMhi4H+qkJ
	CGkemdZ72dadThq4dTFqD/q73mvYehM4bpiSvD3FrAO7hOfRlKSkm3gsrVA7gJ/h/3zpW/Q
	Zb482AzvsNXiWccewpPXb5ggZ7IO3U/hVbyByvLLMQpKo/I/y1cICWRg8djsfv9CmnD9szQ
	02l9T0gz0h1WFPXEcTIKqJ1nKxJ4dbBSk/dA5z/R0iIBHwvue15BklpLU3T3CX8cKcVmUMh
	q/LYZQvSVw2kjEAMxUd3v/UBU41J4WUgUmR8MUThM7sythR/ZRn9S5EavMRzyXR2++dgdEN
	NC85ZIbPE4dJ4lDJI/
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
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

Changes in v4:
- Remove unnecessary #address/#size-cells

(no changes since v1)

 arch/arm64/boot/dts/rockchip/rk3399-base.dtsi | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-base.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-base.dtsi
index 4dcceb9136b7..93b42820998f 100644
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
 
@@ -632,6 +636,10 @@ dp_in_vopl: endpoint@1 {
 					remote-endpoint = <&vopl_out_dp>;
 				};
 			};
+
+			dp_out: port@1 {
+				reg = <1>;
+			};
 		};
 	};
 
-- 
2.49.0


