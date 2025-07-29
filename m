Return-Path: <linux-kernel+bounces-749142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFAFB14AA2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 11:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39F0F188C95F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 09:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122ED287247;
	Tue, 29 Jul 2025 09:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b="hIsNOol5"
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D7226AAA3;
	Tue, 29 Jul 2025 09:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753779673; cv=none; b=P+aq/SNTTvHYcMruR7Q21m82ay+O22rpD0+USpN6dHnfE3lQ2rZ/oeL1uPQ6P5hFA5nNTpH+Rxe22DS1spEmLlD/ZBleM5zPaI1eSoYYCEj9FIN4QA7WKkNX2xKZg+JP8XuLAF6P/VyusulyMq7osUuhorHDbMWWYio1EVT6BCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753779673; c=relaxed/simple;
	bh=qNjYCOVOV/XUwDVyW04FsvLwserCLzsN46WobMalTaU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=m8qX8aYL1NsqlZgormx66modwmnWR7/O2qp9FUdUyvO60n5mnIabGCyx3HEa1YXgWVIwZoCpCZQ1yDPr12VdMgQAgGzZOoRNMT8HtzqVV7Q7P5TOKSywnN3ZKWb7kz9RPpRh8Jkc0HBRBNcf4t8JrDu5w9nNKm3QEFW1R0Hj6gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com; spf=pass smtp.mailfrom=airkyi.com; dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b=hIsNOol5; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airkyi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
	s=altu2504; t=1753779649;
	bh=q6Q48lBZu83JxJ63QhH8HxOwFpopi36sswkLOu+jOhU=;
	h=From:To:Subject:Date:Message-Id;
	b=hIsNOol5j3UGAjzxDvCTIaIDA2btMirXq9eqU35vy3GOscnGHIFVR7wG4LINp4xSe
	 dsRr9je9Iog1LVTid2ygHRJJjhUP4PNCbiTp9pjMx1hk+wm27smNGm2ILejI6BxJkq
	 CO8WTKmPhSgtyVisIx0SnhH5LGl+0+88ih5RX+gU=
X-QQ-mid: zesmtpgz1t1753779643t83ca4cf2
X-QQ-Originating-IP: GNy0TVRpqK5gjjPPYnOaHZTZmyoTUAn1duABOXp26z8=
Received: from DESKTOP-8BT1A2O.localdomain ( [58.22.7.114])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 29 Jul 2025 17:00:40 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17940541300271697831
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
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Peter Robinson <pbrobinson@gmail.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v3 1/5] dt-bindings: phy: rockchip: rk3399-typec-phy: Support mode-switch
Date: Tue, 29 Jul 2025 17:00:28 +0800
Message-Id: <20250729090032.97-2-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250729090032.97-1-kernel@airkyi.com>
References: <20250729090032.97-1-kernel@airkyi.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:airkyi.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: N3I7nP72NaLr7+34hVSZDA2zeUJQJdKl9AVwV4+SNR1baRF8giAMKHD8
	W15zzNdzoY4s0LRL89pJ9P+G18UDKher2/NbQCcGzGKrktbmnpzOD/ThwFEE1zCkg7fCYK6
	NXJQSSfJ52e7neoElrMchE4N9/MfobZV7jzPzQw4yw2MwcVrFkm8huoDYZfL/lr3KtCSmXK
	w+8ZELnVLRTThb6qKRPmmS9cZDYerKceAzbaa6KkQqzMZmpCDrhgTNJmpnTeG1MUt/3aG8L
	Qxr+UXw+WliOklJZ/PTBBL5kZScwbHnCPnXigB1iqF/9+rxH9sZhHPEMsTuUnkRoRint/S8
	ezSDmQoWtapyklKboqM4XHm5UE5cbVr6XU9tUMBehZc4K7LVjm6Eymv0lrUkgkHE0go1Dcg
	7Nfj4TOKDu917tvRNS/G0BDvEgWRksAv1uzfl1Udk3WV0ZYFgTyqS3xizrZeHp+XCg6zAvD
	FSiwVbEHF5xU4IIXrPBSl/2BVq/MomDrFUAvxW/ohqsMifadEyG2p2rQ4PWGCXI4I4NDevB
	5dPF4Or/D8zXT1TJGz7VG3+0pbi1a49vQnrjE0X8KtmflzYqjJiXqGxrHszKcO2mopb9FbU
	OgdqtCuLMoMM90UUO/UeUlgW+husl2clW6/hI624ojcbLXzbOLJI85hNA/xJnOJ4aS55Ddc
	TxGvyCYazL8Wmd5zvvwB1eJ0vBNwSz/naCwGrdyAhQgkBrpCsbJQ5a2jBNcDRQiSwOmqY4c
	G9qkG76GTvugSP4ckMBoLBx/kCOXx93AJiH3odOjcqsld8+ZWsbuqxwt8+d2xr41sAX2/EV
	cc9IyG/NwAV8cyBxIJMsGGTVTQ9mzL1lH/36FObbEpHyAP1lHMJZxLr528gORZKU1E2Tro2
	mK9+PcO7xHFCoG9v2JYZODPFH+6MXU7vTrxMd2DSERCiBhE1XSPJUKI+k+YeA46TwUI9/ra
	kytwwLlQkMdJU4Rt3hhgj4rGlOAiY31BRqmU=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Chaoyi Chen <chaoyi.chen@rock-chips.com>

The RK3399 SoC integrates two USB/DP combo PHYs, each of which
supports software-configurable pin mapping and DisplayPort lane
assignment. These capabilities enable the PHY itself to handle both
mode switching and orientation switching, based on the Type-C plug
orientation and USB PD negotiation results.

While an external Type-C controller is still required to detect cable
attachment and report USB PD events, the actual mode and orientation
switching is performed internally by the PHY through software
configuration. This allows the PHY to act as a Type-C multiplexer for
both data role and DP altmode configuration.

To reflect this hardware design, this patch introduces a new
"mode-switch" property for the dp-port node in the device tree bindings.
This property indicates that the connected PHY is capable of handling
Type-C mode switching itself.

Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
---

Changes in v3:
- Add more descriptions to clarify the role of the PHY in switching.

Changes in v2:
- Reuse dp-port/usb3-port in rk3399-typec-phy binding.

 .../devicetree/bindings/phy/rockchip,rk3399-typec-phy.yaml  | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/rockchip,rk3399-typec-phy.yaml b/Documentation/devicetree/bindings/phy/rockchip,rk3399-typec-phy.yaml
index 91c011f68cd0..ccbe1c9cb0bf 100644
--- a/Documentation/devicetree/bindings/phy/rockchip,rk3399-typec-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/rockchip,rk3399-typec-phy.yaml
@@ -51,6 +51,12 @@ properties:
       '#phy-cells':
         const: 0
 
+      mode-switch:
+        description: |
+          Indicates the PHY can handle altmode switching. In this case,
+          requires an external USB Type-C controller to report USB PD message.
+        type: boolean
+
       port:
         $ref: /schemas/graph.yaml#/properties/port
         description: Connection to USB Type-C connector
-- 
2.49.0


