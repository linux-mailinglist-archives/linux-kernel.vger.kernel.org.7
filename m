Return-Path: <linux-kernel+bounces-895212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E47C4D432
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 12:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AFB534FA781
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A58E35770F;
	Tue, 11 Nov 2025 10:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b="HMScYYcS"
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE68E350D6D;
	Tue, 11 Nov 2025 10:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762858285; cv=none; b=KkjY4igc1Oc7UzwEJejKKsEq43uX8gOZHFg2WHXyo4y0HPLdLTtQQOLBST+6r3jbXzpCSjkGJwoZypnfZ5HONL7PryDNYrVZ+HPwIMjs0jB7OSCcvThQV9CoYn5Wr+Eps5nfoQVM/RLJVvvpOH+Y1pDBBq1404KSol8xQhj/GQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762858285; c=relaxed/simple;
	bh=5m35kASviK5Hv89NSiZimFN3XlqevmaILeqOugiZOLI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=mLGd+irYYq/VZc0+LpEY3qc2HyeFJ2fu/DELfH3JzMc0pDBvBSAqs1dtnrEzgRtF4Ljw2noOlzVdETkEbtE3toUqHFWy21fXfPfyo2L+EauPPZVaoXXHvOhqLxNHIkd2svelxNAWwEDzdqEoIkhMN0Twc5T/z8Y8h9Jncr8rppE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com; spf=pass smtp.mailfrom=airkyi.com; dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b=HMScYYcS; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airkyi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
	s=altu2504; t=1762858270;
	bh=1fj6I5WadX9tXddUihY9i9o+TqzOQO5XPHyy3i2XmCM=;
	h=From:To:Subject:Date:Message-Id;
	b=HMScYYcS5YCdsXGaeEm2T9zjUw5qFsdae7Uh3+CmxNRuAAM3SeKlEgjNtwSwhIQvl
	 Md9okgIjNbsqmkcHSooliVZJmfT+gdV0NNURJ/mL6TjJpIN7rub3JgooRCJoYV8y+b
	 1iTxXtQyVA3vdN7R/oyeN8hF36a0i5+pMz65PeVM=
X-QQ-mid: zesmtpsz9t1762858265tfbae2009
X-QQ-Originating-IP: uJyi1b7YJXrK+cM8L16DabO0ulPWhVW0NrJkWY9juG0=
Received: from DESKTOP-8BT1A2O.localdomain ( [58.22.7.114])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 11 Nov 2025 18:51:02 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13153881317845399117
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
Subject: [PATCH v9 04/10] dt-bindings: phy: rockchip: rk3399-typec-phy: Support mode-switch
Date: Tue, 11 Nov 2025 18:50:34 +0800
Message-Id: <20251111105040.94-5-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251111105040.94-1-kernel@airkyi.com>
References: <20251111105040.94-1-kernel@airkyi.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:airkyi.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NOc1LUZ0GKQa3KhKs0ZBpKawp9/yUaHk3thzv8shSomqovd5WCqOIqMW
	Z5JyytJF3ZKEWGOZ8uHcL84nbz3kbQVSPoS+BRD/+1KNwh97qJ5963LrzVyQCPf5wMpDkjr
	ZfjQmeYyyHe5iJ/2L+wZW2NH2xQajJ+1+GQX4VVVp6CpnKEeeL5G7tjvRpQdeDtKu6QoYtr
	Q7NLsbIJgn7boG0kw6Uo1NnBOZ4NHoOqTg4gKs+J28YFM1HXL8ZxMLyoaMF6+BbFgsDhFMC
	IqlL5uB9GKGav9IqHS9v2UA50CEazH7zmfyiOZ0hliYv4a1cn/RBXPYHtWQjP8evlSkeQP5
	7LlRlmjZy11B8LE7zOb1/AXMi8M0peR1IGZ2cAZ9LEfx99IrH+SjPenR7w0OaPEKndtcyYu
	ueyqlZ3J82Ki1aaPOcShqgP+Wx8loUf1SpVggvDH/Ktwe+Ew1XstiuPU9Ukinb0rmrqrr9q
	OS3Ixv6wC+P1K38Wmj8/2jI2KovbnG0MrvwYn4I6NtI+9zulUHeYN4W8duBW4kMWelcg+vt
	M3qJHJvAHLSizkSBQHvxX4L9nlIHV+66PQb19IGyb2vZnr9oTflRyZQ1Q20FrTIV17IBbMP
	ol9s3RoBsHEkFMy5LJjy5VZphy7BWD00Jrl+xJjew5TkvRG3chekGSxv682yuF3bCIRPmS6
	VFTn0iNza/WCY6jXV+HYB8MsG7a2O71yDvWjWVZ6rdcQZSRmocBnWzRa1wvEUcVVcluZblL
	kG//F3/fs4YZMbDre5u9u9W3KEE/JZ5jlMzKssxHZ3tzinN3Uxm6SGorwMXq2ntyXYrXQ0u
	4V+7yylAwU1cuoiiiZrOH+2AOWgcF8G83c4urjfRdooKijAaOh7ZcPHbYRme71DnCT4azFT
	RuVRrKv2C9pYUfOSJrJIxoMpfo0WpwTMdPUmjwkdQBbk6niywI4kgcFUDlVZG0qiVeqTnTy
	wc7yAjajKYk+o2IfnH29xwTchmBAnt1wCsNNdn+JktWclVEbetOY+dJJ+jczd3TnjVksrQ/
	tXmHvHYoRYRdSz5et/+ar6VFrOctuOZ6XDwLgNzg==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
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
2.51.1


