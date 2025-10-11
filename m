Return-Path: <linux-kernel+bounces-848979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A9BBCEF33
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 05:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B0B34253CD
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 03:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A96323956E;
	Sat, 11 Oct 2025 03:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b="eAZdjRzq"
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.124.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055F0233723;
	Sat, 11 Oct 2025 03:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.124.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760153634; cv=none; b=A7YtQv+IXpySWX7FOSk35miZUIxZ/rmgpVFXIV01qJiH/WRg07bvZ2lqACEzA8VD5XtTwZ1DnFeDKS3B1388pFWZp4buXjCtCf7qUZ5IfEOyWfEXAqMAn+JuSII+WKNDY1qXzBbHmpuYwFUcskWlJnSVCin6NjaqXm8Ic6vJB1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760153634; c=relaxed/simple;
	bh=JkC2n3cUcgwqX4mM3+Lhi39ig/OE1/fWWocxtgBRO8k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=U5pTqPXm0u0GiJmW2thFq++b3ncT3oMckat9mk/hGWRVbHHIGhUic0t1cvJ0VNQCto3qouei4NH3E74OzrsPnk1Y6rcLP98UXZ4OU1myheJovVjvdcv3xNoShKke2lqN4EEY3H9z56K7xm5lwyj1f+zJEVu9/PbvGj5I9k9HHbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com; spf=pass smtp.mailfrom=airkyi.com; dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b=eAZdjRzq; arc=none smtp.client-ip=114.132.124.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airkyi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
	s=altu2504; t=1760153572;
	bh=YHT4Mxhe+zSodIVHd2qzlGnysBWHBxMufel41tGudBs=;
	h=From:To:Subject:Date:Message-Id;
	b=eAZdjRzq8dkC8MjRwwfEFHoqMzsD6rEzVUjLRaDrh3WTlcfu5gRaKXW/J4/VPsbxY
	 s+EbWmjXhHJXvLwe3y3UGmV8l7IjobooxXsjH6s5AjPXTVTf3o4u6CVJjDW4XfSHdF
	 xMIwWQgusXouVhDejSIW1Yxg/fYO1t1rHU62baOw=
X-QQ-mid: zesmtpgz4t1760153570tb665ba7a
X-QQ-Originating-IP: N1HyOBHa563KXTPq0mhcMxR81EsdSSnrp/MTia0/DuE=
Received: from DESKTOP-8BT1A2O.localdomain ( [58.22.7.114])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 11 Oct 2025 11:32:48 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4803160291737759115
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
Subject: [PATCH v5 2/8] dt-bindings: phy: rockchip: rk3399-typec-phy: Support mode-switch
Date: Sat, 11 Oct 2025 11:32:27 +0800
Message-Id: <20251011033233.97-3-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251011033233.97-1-kernel@airkyi.com>
References: <20251011033233.97-1-kernel@airkyi.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:airkyi.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: MQb3KhmQP37Ml86MGeEmVVITPcjQR+6p7LqDZiZ0SlsmB2c8+x3Avtjk
	fwRXpuNTLwFz360NLGLLCpgD6F4tnEJc1gLowYqtzh/u6sVEVer6QvVqpnQwulshhlweB5g
	LG7PrC4K1lib8tCnJd2Q0PER5+vu/coFG9CRo1LpQjbgR9/B7iqzLXiw0PpwGSjvLUABChu
	jSanHfDQTbmmVw8Qdv1bQ26HYagcrF7mglPypnmUK5/svXpoqGeJ6YFs0CI2p0iaHZTG8JP
	aR/FR1iRRtf2pvQ/zRV22xjlBVVnhtZyUrCZhqbSto0Rn8lwXJYaL0F8RpMYJ9CTY1hi9H8
	jDifwzjn9TXeiILEaQbOGUR05cehhf7LWa8cpxE0PvnBZv3vpjmY0B2VCnifIvinc0ytQLv
	Im2i/rYx8cW/TBg0Cm51nU9Dh04CKaQF4evZ7pmpHSBwOCPEfSPSxKFeFpCCmUsrrUq1SHh
	qRuh4A5L9JbUD2+bwE2U7l+oEzH/QLhQVX/3qoXi4r0DVJlNkEYtCsKTlVnD9oUvbAp4icN
	hvgt8aQV3AIDhamuv+SONlw3GUM+00V+quETNSVbNi/HCxkUtJh0c815Q6MTkU1GZgzWwIv
	ZWFBSc34N5x56MdE+Peb/gdzSLo5rDJLgZ2zsuprZ4UQJF3ENaB7hTwYgy3+Z+VhipR9mDN
	ShXEsCLYYei3orr9uopZmk/iYI7KY7GuYuN10bCbjkQUodHRn3E781cN+vo1uM/+tkAfEHd
	3hoVIlhKL5W8fKWIaDCPYFOfWLIslAy7iy78AGkKYlkWugYlRkIzJzrMhmFzw4dayWu458t
	n21zDeiCu3cjTxW8SdtGGql37B6K6t3m4U82+EGgF0xns2n7LWdEBzCSagheHrrmj4QOhL3
	cQo9wKHzXngPY7UUMDe2JO86hnNg7B3RPparp84oatJnRyz6Cb56dxFb3tt3UqhIA1uRTba
	uTCZzCIaQaRQD78z/TQ5A3XAZcdSl/fYWAOS+b2R3/fIIu8w/lPBVqk8/asHlqhJFjT8=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
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

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

(no changes since v5)

Changes in v4:
- Remove "|" in description.

Changes in v3:
- Add more descriptions to clarify the role of the PHY in switching.

Changes in v2:
- Reuse dp-port/usb3-port in rk3399-typec-phy binding.

 .../devicetree/bindings/phy/rockchip,rk3399-typec-phy.yaml  | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/rockchip,rk3399-typec-phy.yaml b/Documentation/devicetree/bindings/phy/rockchip,rk3399-typec-phy.yaml
index 91c011f68cd0..83ebcde096ea 100644
--- a/Documentation/devicetree/bindings/phy/rockchip,rk3399-typec-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/rockchip,rk3399-typec-phy.yaml
@@ -51,6 +51,12 @@ properties:
       '#phy-cells':
         const: 0
 
+      mode-switch:
+        description:
+          Indicates the PHY can handle altmode switching. In this case,
+          requires an external USB Type-C controller to report USB PD message.
+        type: boolean
+
       port:
         $ref: /schemas/graph.yaml#/properties/port
         description: Connection to USB Type-C connector
-- 
2.49.0


