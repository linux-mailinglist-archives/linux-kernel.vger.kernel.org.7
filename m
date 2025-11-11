Return-Path: <linux-kernel+bounces-895217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C7718C4D450
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 12:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8D13C4FCC5F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D75358D31;
	Tue, 11 Nov 2025 10:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b="oqBD5zV6"
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B272A3587D7;
	Tue, 11 Nov 2025 10:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762858295; cv=none; b=t/hJRIvsYERHDa7PylWEWJ8odkuNI7u8gRR7s7os1vYcK9k4U/dvl0n1k5HENXXpc1hxTh+27vv8yx3gLQ+2mi+b7Putc6k1p88SUYnMav9Pg0If++RRYPC9uKn87fT5OHm5L1NIj9hSNxSf37BVqecJaF5OthEkg6F41l5AzYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762858295; c=relaxed/simple;
	bh=UYBXRUGpsPucbSnyCek2T6kQGAmNcIEArFxOg+A85iE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=NE4YCHiU8FN77B/En54Qs2UYhuVuFqFtugaCmPo48bVXORFEc2t5IUyx21M8qk00/JYYlxDnPKhJ1x6rLlUghZ0PsGKvp3LKcy5lBxLEIcyf1LEVHJW0/eS68qEIeoV8SURjhtwTZfhwJesUDQ2yL91OWhZVbPAg2wmiAFbDWYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com; spf=pass smtp.mailfrom=airkyi.com; dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b=oqBD5zV6; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airkyi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
	s=altu2504; t=1762858290;
	bh=pFI7M+6j2JewnD4BwkGRc0QPG+RPFm6rGXiCORxPrVE=;
	h=From:To:Subject:Date:Message-Id;
	b=oqBD5zV6YJO40Zi/mJaQijusrScK02HgaGHpiM9DDpi5h964WQ0WaRGZbQ90HbNFt
	 zk1DITH3UujVUhptbnY4M3+JbWYmZd5l+izjdW5bRthGujjzd0EXVhgw8k2Me47ar6
	 hK2mOXUtpWbelpfvEBdRXl9PzGAT+DACiiJQNDKw=
X-QQ-mid: zesmtpsz9t1762858287t5941ed20
X-QQ-Originating-IP: oggRwoMydKBDH0LmcR8KzliYg47YhSd7rMeyclg9ztc=
Received: from DESKTOP-8BT1A2O.localdomain ( [58.22.7.114])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 11 Nov 2025 18:51:24 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15062605320672791780
From: Chaoyi Chen <kernel@airkyi.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Peter Chen <hzpeterchen@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Sandy Huang <hjc@rock-chips.com>,
	Andy Yan <andy.yan@rock-chips.com>,
	Yubing Zhang <yubing.zhang@rock-chips.com>,
	Frank Wang <frank.wang@rock-chips.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Amit Sunil Dhamne <amitsd@google.com>,
	Chaoyi Chen <chaoyi.chen@rock-chips.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Johan Jonker <jbx6244@gmail.com>,
	Diederik de Haas <didi.debian@cknow.org>,
	Peter Robinson <pbrobinson@gmail.com>
Cc: linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v9 09/10] arm64: dts: rockchip: Add missing dp_out port for RK3399 CDN-DP
Date: Tue, 11 Nov 2025 18:50:39 +0800
Message-Id: <20251111105040.94-10-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251111105040.94-1-kernel@airkyi.com>
References: <20251111105040.94-1-kernel@airkyi.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:airkyi.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OUksgP1p7wvYcTmCIbAbgPqsFwkz5TEDssB8YMyii1AcuwEqA61bxWOY
	PLpodXsKH0cvKY/rqj5YXK5Ps3mCuFV2MFOrt+hr5BqnpYqAbiafjfk6gRrhCoY9mIO9Pes
	IEoLIBHAGOFqo+FosLKsl0qtG6eoGLY1d5EMXZwzddoETlQu8vWNTbCg0j7WyrBlNkmM5k5
	lxVzH/xJmR65o2tPK+C+C6Uw+Mwjzv2/mjGCpVM4N0wVqGYl2Grz+gmKPMNVery5BCuC+y9
	v/IGZmo9UzjHsNOIr7jtjK3G+Hvbg64KwjO2z7ZZsZE3tizOWrp8oW+itxmZXzO2JNPzR4x
	ug+cecIrZIa7raPkhQchWLz211ONqkOEdf2cLsy4VKIAv+pa2uHLhFzUgaY64NQGv4x0iO0
	2RZ3m1gleLWYP9X7+5XOhXEvWT9RNbd/E127RltXQwQ3f2rGIlzO295tNne25y0eJenKFwd
	fM1x+zxycqUG7zVFZymzLGYX4E0uMXE67khu9sb6s50wJy0RtillqcxFH508NS91+dk+QJq
	1zGM6BVEzfnaVwXMpSsChWbFCXFAvaKJYXeUTIkg0NZK3WzKQUzlMb2MoWMe9qZ+fcHP4Re
	ScemEVA3ypjiBYmg3KdLOcjAB5r97YKygzo9LEfgRhpM3WEirCe1JGJbN0qVgbgTBrK1V5t
	/faT/giwM9up2njBBw4mNP0zf2T506kYUPVZ9dlMl5Jc5mioprm25Dmwy2MmumNZGahOkQ3
	7bJ4Zoc76ScFiE2nUDkILJyepQ0tO/ypjKAf7EesHPyumSLeCHnb6Ed+kABhM5h3PtQ5h8A
	mLupmb9xbrP7XYtIc3hIauAoUfAP+KrO6C7+qfwdy1HdgDmEvVcfYzZMpnTw6OItEbID1JH
	Fom9OYyUmeOiR5idOkOHyqToc1w3wHVlC2pn7gxncdu0SBv0ThzwJo2oIk49yX+33oC4Ri1
	Dh4AMyL1GMAITlUDDzL2eJxmcS7ESVLwL3rTLFiKBw+Z/2p1cKdi5LXtdm9o3Lb7HBbtNnv
	GkE4Ushg==
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

(no changes since v5)

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
2.51.1


