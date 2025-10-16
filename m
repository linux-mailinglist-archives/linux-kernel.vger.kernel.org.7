Return-Path: <linux-kernel+bounces-855449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0558DBE142F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 04:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7DA03AEA01
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 02:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC55233149;
	Thu, 16 Oct 2025 02:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b="oKKTeL2s"
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136F1227563;
	Thu, 16 Oct 2025 02:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760581738; cv=none; b=NMzaNP4FqCqEcCi1r3KxOuXGmZ+xrCw445nC7tQ46Ql45J5s4x/XtcpfflGdXEJPDP29/C8SERoWfasz27c2HJq8XEIBGeDdiyYjnZ2lgy78OBV5ShkGBZicwpFn1N/5V2qtfQgwOCFn2sPSNUp0Ps4OASMBKRGFYV5G2VOLpwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760581738; c=relaxed/simple;
	bh=3OiqcRrs7DLfC1hTPje6cpCre8EW3o9TnIIexoI2iuY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Trl11AV5ws/SdGjuHVNtQXukyTVGNjOD02z8H+wmxZBkBCxX0L2RjikSJG+icAkG4Jx5Q60/afHmjg2Oj6LjDTHDsqnRdi0Z8pkgAJYmsoEUDqLtCCZ68ZSmDxYeHt+G+Rg365UnKj7Q/+jf3BeDrQobZTQrNiTkNAEDADW8iDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com; spf=pass smtp.mailfrom=airkyi.com; dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b=oKKTeL2s; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airkyi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
	s=altu2504; t=1760581705;
	bh=cDiOxEFqYuonRjIga1t9o2u02p12TN3hXALWFcjKD9c=;
	h=From:To:Subject:Date:Message-Id;
	b=oKKTeL2sZnJ/Ra/KO+JjtpEeovUL9rnSUI9xNdOU7MXVLO+02xrqkYfqglXFiuye9
	 plGCwzspO5dTpRr/XFyPeBfxLTMrRavjxJiEXgwbR5F9J6osU18irF3J8+odbwQnlX
	 p/ZaIGb1UlhwQdARY4WYIAhfvNYGPY8YJ/jAghH0=
X-QQ-mid: zesmtpgz1t1760581704t48b93ab9
X-QQ-Originating-IP: jspWVOP8OQq1eMaljl9zTAS2LWtC6NlYZsKyhlsXums=
Received: from DESKTOP-8BT1A2O.localdomain ( [58.22.7.114])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 16 Oct 2025 10:28:21 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14690965305072094161
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
Subject: [PATCH v6 7/8] arm64: dts: rockchip: Add missing dp_out port for RK3399 CDN-DP
Date: Thu, 16 Oct 2025 10:27:40 +0800
Message-Id: <20251016022741.91-8-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251016022741.91-1-kernel@airkyi.com>
References: <20251016022741.91-1-kernel@airkyi.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:airkyi.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: NvH2zBBgt3uT9PzPxFcjF3BkEwQclaeJHAX6xV1xiqe0SjTx4fFeWK1M
	M7zsCeSt6x+bbc0envVq3xGYBCBbWKHxqLxtorjJHb1C9UPgZaPjTYOdcA/yiulDv3PiXVB
	q80ytDfdtcHqbS0ghStldGmkwbpGS5ui1cQWMcjo00lYLtMoFqD6S4Go7Y+Fkb2JjVnJzPL
	UWDvB+vUP33cPYwpfuqa7xYzC81U2p+sMZPGayzQPHfMlRUpCIuhBWrgOQfMTiFueBsGuBV
	7MjerWqSEEohbfa/swTwgVnqGoiyezcUYpf2sz0qad1wr8IpFufHBpcUCMdMca4iCHjDc+I
	WKcYqGsJ/+PipZDWBv2sBaZANPvcuB286muAzacWF2JTVoLOptY2C9jTi4EQni1RL//Smaq
	/VKDcjAVpL/F31LGKYwbb0J0n5tMs1tKHGBui3yhLL1o52aZZLQBMz1LAnskXakidQa01ci
	FaP/StCaqr6kFP3fkysMo/P1ZhUbcsZg7UwM64eQbxaCXPB5N5OrWXiTaeNGgvTd6nEfAVy
	gl6kFo4Z7QcRgUPfXW5FIwLxOldvZ3GcnmX8LenlCJHNH5IluYdZJazf0u1cpC4mEFOLv+w
	Kf0jYUMKrHYdzPIg6wvxVF4bPJ1gOr+j5+m9EXp/3kIE1o3emBCX2d6llWKiMFRvSPZazIO
	gqZyYLmNz7DfLqSc9dUHlonqWJhDdafsikhYeOPh+DYS7FV/XWM5ePTu4JtPVu5eNIsQ1ir
	xShy87+HRWgSqmIB/sav7WBDhPMktrU2VHvELEYTpi+ZOcwW4Lk0sYcDG9Yv2tRt1uMCJXM
	RmtMp8myYvMgoMOFi8MztMu55a2x6VO573D86obdc7XO+oYLsbDo9tuVQa5nlj3Bh5BpwCi
	fP7ovVfvm3POfBGWDI96XQXSL2IYJGKTWXfLJo5vIPKoalsUHswO0u15iI9WTJTSDqMZ6di
	4s6R1c7BAfSQn+SnxvSBBtL+UeFN/i7fDI8xPPh5DBLE/9/0lz0AsPorDq6Fd1JRZ6v78VK
	G+osvW6HHqjnco+R+cOofoOHSBqrbJbqsYOUjCEw==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
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
2.49.0


