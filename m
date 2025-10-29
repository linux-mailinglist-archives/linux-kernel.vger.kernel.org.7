Return-Path: <linux-kernel+bounces-875299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD99C18A63
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 20F6E343A82
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 07:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA0F31352C;
	Wed, 29 Oct 2025 07:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b="ZP0potWU"
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777E630F542
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761722181; cv=none; b=i0CX7tu7RmIaJm+tg3a9B1ZGSKF1KB5pqsE6EaXg3ffbmGHR3oaa1SmbSD+c7MNzZx9bvJjXegSEC0nS+VlL5uFAXvaETMoGVsPQrvhV0eiNcSmkdgpfbLrPp/T3+gqMTBRGIab96BMlwdStCna0+CKR1EgpqB+HTq4I1xEt89g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761722181; c=relaxed/simple;
	bh=JkC2n3cUcgwqX4mM3+Lhi39ig/OE1/fWWocxtgBRO8k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=V2ZZ6qUa3cz4eixwn+Mrldv/SxoaSwWoXov6gOL/8DFdc+LVHaBqmnYygxwOUMKJiYfPfl2QxF3Nxb+N7G6jf7rP0nzdqE1ZaBTPjOmr+GOiGu+4QJ1Bg0n0SbRKOrmrx+xfiwqAMRWAh2E8F7WB/sceSIMyIV/YBXfdlO7zXkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com; spf=pass smtp.mailfrom=airkyi.com; dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b=ZP0potWU; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airkyi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
	s=altu2504; t=1761722105;
	bh=YHT4Mxhe+zSodIVHd2qzlGnysBWHBxMufel41tGudBs=;
	h=From:To:Subject:Date:Message-Id;
	b=ZP0potWUGEJJnJlGR0dpTvyFnp+9HW5m8eBLSzghIm1BMioCwhr99HXC/coVmaCMa
	 HtxkBOqqvDRRNkXj5VRArWuZhbBD+Jo1Ueb0oNmyEFWCq952svOf6Aj4RSiDA+p4up
	 R3Lk3O7boUzjw4hYgDYBWUnWT7qvtPl0A06J1Adg=
X-QQ-mid: zesmtpsz6t1761722103tee7fa66f
X-QQ-Originating-IP: Ik7AVVI+4BnZaf1rl0zVbH4aG4jaNbSh2N+2iERqELk=
Received: from DESKTOP-8BT1A2O.localdomain ( [58.22.7.114])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 29 Oct 2025 15:15:00 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6689497526499472264
From: Chaoyi Chen <kernel@airkyi.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
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
Subject: [PATCH v8 04/10] dt-bindings: phy: rockchip: rk3399-typec-phy: Support mode-switch
Date: Wed, 29 Oct 2025 15:14:29 +0800
Message-Id: <20251029071435.88-5-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251029071435.88-1-kernel@airkyi.com>
References: <20251029071435.88-1-kernel@airkyi.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:airkyi.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: NNgTDNpHPdfoSadMONWltYKZnnLo9D5gXeruG5XLO8PXo4YdZ3JDGtAE
	2N9VIyPNwwHpVdBAJI2cqrO5UHF+TtEZKj95bVVA8lvWkiI+FCUogw4wtzhlbKu/rtcm2rD
	P+IDwVvQH1haTBPusFg0Yh1Wb0x/zuq+uUT+xKS3bzzjZ19Dxn9MIdfAGw0KHb+3NDJTeLE
	kAhfhVCaRp6Ffu9NChKK6nKWB2tPgG/HuO/aCcwMQiYtWl/0LOSpZcdTX/knzMAH1lVyXuh
	fO5T+2tgCji/7cMjaPQwKsc6ICgf96396B5YCJmEp7ox2eskYZ7ccqYqB1WKQ9cPcOeXpTa
	oRArcN8mIZc3mvPepo1KHJ/N3kJhZqe5HJLI6w78LJor6B83Mnjw14Yu6IiGUVpO//3bU3s
	DIg/zkPCz5SzFSIGFm+5OTAMyDIWUryvcJ/7sxLDVpOEEN/Mf0Fk4h4o7+3mJ7vW0pkSQFa
	vwLnIAlgOs1H9TY64pv8bLFdD0bZgwtnlnsFaNfjPp+RxBXT3kGB2JBqOSE89CWpQpgEJzj
	kz7yaVr65mQ6bySG6qDGF1mf+ffYGUne5zZq08Jki5PLpyWCOMPf+sH6uisY0XLfULhZpYt
	O0MfvDKBh/FjeOrc4SANyS28m0+sVyTmZCzkI8uoZlOQ3iqaHxfAlpPH65XkZYfeF+7wy62
	0sNWEgRGWG436TyAoaCoajme//38vIG4zjJ1vu4o9RPxMdD/hC07anjw+8Vbb7dklVyR3dO
	4aO6W5k4S1bkWZZFfU1/JkxzIEjtUrDcZxhsdf7Ce0VDZsjnXGN1fYC4jYHbrLgfU5cbVUH
	ODbGGCh3Hl91WoFd4j6f50AfhKLKt7A6OXn2p5RYsDC5Fz+k5hr/KBAqb2u/YY43GsGJ4v7
	Q+wwjNhR/xc/YQPUf/IT47d6DhROonJLs8Gdvpkli0CGsxUX4JmmBj+VlfWofu6wBBgaRX7
	8VjUzMvdvKpRjN97+CzlL704WOXcGSJjjEecs61XN68YxdoDQzEF4N52wYOnHY55+OZGM0Z
	5OSEbw4A==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
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


