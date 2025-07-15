Return-Path: <linux-kernel+bounces-731727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD82B058B0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 13:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CA061A65801
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 11:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C116A2D837D;
	Tue, 15 Jul 2025 11:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b="tjkZBLTq"
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB39F2D94BB;
	Tue, 15 Jul 2025 11:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752578724; cv=none; b=GAnuoLshZsHGHkB6AzSxTu82V0JWJ98AgjXjbDMHDmkMHN8kBay5KB6xJ/rxN5/Z6DqzOHvcqe+qgFUtyROrrC2GO2K8/kRyUiuCsFnxCdHC8Ie0/n8bu9Lt3MJs9A8JuYp7zTgSGhE5oUxGxZEjoZ4oApKrb4b3i3++AHTzgoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752578724; c=relaxed/simple;
	bh=6Vvux8Vkg6PuVx115aocWutY2yl43wJ2D3fmJL+rdDI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=btWzkeEVGljU6SpIpNukcuPFd7nyGUmgqJumWcLb4Z10mRI4mWG7oJOh5LhmVqPfVIJR1tTCfWrTIKn/NO3jgHgu4LA/H4bmpkGx0MwkJudluZbfHq04gnxL82FOZx/xahlO8yh/PfS+pCxd0EkdUtLAasgOTxrGlV8Lb0TWJmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com; spf=pass smtp.mailfrom=airkyi.com; dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b=tjkZBLTq; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airkyi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
	s=altu2504; t=1752578710;
	bh=6Q8tj7y2fVh1DqqXLpoIzvx75MH7E6vfXU9jWGAciCk=;
	h=From:To:Subject:Date:Message-Id;
	b=tjkZBLTqMYIHD96FGr/Vv43hg++2HyCw7I8wfwkhCsog2CrTb11uJHLpqiIJS5ps7
	 AoXeu+tIVTOkl2bHvx+9flHU0L2wzImOXxRd+N+fp4Uqkz8Q7QgLobhJKR3LH7M+Sx
	 rpw638otNRTM2zAmwKnw5t9F3DhiVwqxukLE5HBM=
X-QQ-mid: zesmtpsz3t1752578709t1424522d
X-QQ-Originating-IP: Y2jgY0DzpsnsowblI/Y8vYsFKW2TRFdQuFkynBZV9Zs=
Received: from DESKTOP-8BT1A2O.localdomain ( [58.22.7.114])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 15 Jul 2025 19:25:07 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6650864007286814184
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
	Diederik de Haas <didi.debian@cknow.org>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 1/5] dt-bindings: connector: Add displayport connector for hotplug notify
Date: Tue, 15 Jul 2025 19:24:52 +0800
Message-Id: <20250715112456.101-2-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250715112456.101-1-kernel@airkyi.com>
References: <20250715112456.101-1-kernel@airkyi.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:airkyi.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: MIXpHopat2IaCfng877wRqNTO5c3xi2P54dqj20cjkahUzF0YO1gIovH
	u0DuCL67cE+L9dcr7GNkd1ApfeTpt48RkCO1kROkVss6vJSqjwH2tFvc4GAA6RmYLY5l77n
	4RgJ2rTmZeHUviqWNtXkBxCLT6TeolFUSU1GgCLMFbhnqmgOOJ+ccBidL+ODZ4tOPFydb8A
	Cif19thA4/JsZi5OBDtioja1O6gPWQXI6jQX7MiUI02IClP7qbR2HslVgzJYEEvsonlP6nB
	Xxv8B/t1m2/DQbH8ByLBgdqJJZX5w2ntjQ7laMJG7ptECad4zInfGTXuifBJfalEMxha233
	6PAXyARSqvZZRNqvqMoidk3UjKiuOgSfXkbxZ5D1LPkueCNnHJZKNoIpo7d75DGaeK1RLsu
	+iBcXxtwanBMVwCxAjk9bW4m0mvlxaflqn4dIkhDLSmT6pwtpaU7GPDoPvx4zlvkB8S3G5v
	DER52OgnP6u7isgC+tOZYoDrPpZuLylPIp0t8+EixsYkECDqmcYsvhZZXl7kK0RDbrRkWtC
	AOV9PqzS/QJEfbLp/X0lfM3vGlM1NrZZDOFLrQi3l/i7v/Av185fpgbatjNVzYJJSpbtr8J
	6ChShJVxhgM2MfC2XLTBmaR4S9Nlf6NXExQdy1FOhLwenMQS1NTKGmSYJOmr1QYy8ke305F
	kWoOjlRaoTFNYBdwDVfQbBefPZue72d9VgAwFlUQafi4qBswnZLvV8ItEjY6Q+tQYfa44au
	v7gbo/nwJOujuJWfp9EZXF4J0lgxBp83Q/rzEagweiIA+p0xPpZfa41owSLBRgr31ZhmYQQ
	E8BoISwSVwAlHMXgMp326pDvV1/ctFwgNoL+9K3z3MwugIUWCwTlkFimNgUgvBnMM4L1pjm
	ebfsIOS0aeH77EhCqSHSmaWJNtqmpC64drmw8Q+gniZGyiJdP/Z2XPVupl9+fH1AulolMpH
	V01DPkgc70TEsJ993p3ZWcmDIMWDO8sOGbbwTlxEf3eMiUOh4lab4o9luCANQ2xqZa4KUf5
	q47g0G5Q==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Chaoyi Chen <chaoyi.chen@rock-chips.com>

The USB Type-C DisplayPort alternate mode driver will find
"displayport" property for DRM hotplug event notify[0].

[0]: https://lore.kernel.org/all/20210817215201.795062-9-hdegoede@redhat.com/

Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
---
 .../devicetree/bindings/connector/usb-connector.yaml          | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
index 11e40d225b9f..ccb258972cd6 100644
--- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
+++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
@@ -300,6 +300,10 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint8-array
     maxItems: 4
 
+  displayport:
+    description: A phandle to displayport connector for DRM hotplug event notify.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
 dependencies:
   sink-vdos-v1: [ sink-vdos ]
   sink-vdos: [ sink-vdos-v1 ]
-- 
2.49.0



