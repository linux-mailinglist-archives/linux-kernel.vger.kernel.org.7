Return-Path: <linux-kernel+bounces-855446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9B4BE140E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 04:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85FF419C6221
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 02:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB5222424C;
	Thu, 16 Oct 2025 02:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b="t1uSJlCh"
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35EA15D5B6;
	Thu, 16 Oct 2025 02:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760581729; cv=none; b=VPpQ4UQQOOqUKTlrPcGJ3IsLAo/VQ1443cWnT6MxADf7x43eVVluHTP1M/Q6mJakz2+ayQ11Z4p/m/lkh3YN+9WfN2Wl+oxOp28hD805cdfyHWy2QSpF0P0oq6PtL95VR0OBKcbsk6vqM4KTmICwLmesupjgMimDLnfgt2wduXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760581729; c=relaxed/simple;
	bh=JkC2n3cUcgwqX4mM3+Lhi39ig/OE1/fWWocxtgBRO8k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=GnbDtDac++rOf4tJd52WXXJXsjHW9GFmz45m9886wQ/LkE2bPMTwzWFAUpY+Xly0muj6fXXLVFyhG9NeEOVUm4j+eJTMDBvQFIRmru1xCuK1GQ61e/sf5x0WVKcL+yOsYi8SN8MvSOZXw8NVXO39fY8Y7dpnx0bYUfBC+lgNCEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com; spf=pass smtp.mailfrom=airkyi.com; dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b=t1uSJlCh; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airkyi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
	s=altu2504; t=1760581688;
	bh=YHT4Mxhe+zSodIVHd2qzlGnysBWHBxMufel41tGudBs=;
	h=From:To:Subject:Date:Message-Id;
	b=t1uSJlCh6BKui0tSWCB4a5j/1fjlPSegptuGjd0kHLT4U15hlYxGxPZFuIKlp+phR
	 AK0ukJLrBUvej52ujlnMIjCyQwjQyezqBVCBELYgRgdzCYn8VSEbRe7bqUa1xXc1vX
	 iP5p1RZCoHof+7iUyYKTtjzmW4BpF3iEQ88QrHT4=
X-QQ-mid: zesmtpgz1t1760581686t5a2ab742
X-QQ-Originating-IP: Br9MCe7LW7Ki5BF9qcSTZOmwdKejc+6aFdxKCmwAYcg=
Received: from DESKTOP-8BT1A2O.localdomain ( [58.22.7.114])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 16 Oct 2025 10:28:04 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 18423012065782556951
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
Subject: [PATCH v6 2/8] dt-bindings: phy: rockchip: rk3399-typec-phy: Support mode-switch
Date: Thu, 16 Oct 2025 10:27:35 +0800
Message-Id: <20251016022741.91-3-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251016022741.91-1-kernel@airkyi.com>
References: <20251016022741.91-1-kernel@airkyi.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:airkyi.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: NFzQ23lyTybaJuTmj8KGjQOpMbVaG8xJuoB4qgry0OKY8aYRsbgI0RyM
	r2whhdbJBMP8IWWrtuHKqk2hX5IMgA8kYGcvO8F2ZmTUWDOBiZ+iOPtJJHGUX30h4UOuX7M
	2WhrB/H8/OA68OggCVjy/CdLTTeAgYEva+ZknsPIsgIV3ELNs6h06e++X5Xk0H2XLBLJ9e0
	0WYxS4u3H48UiSXlm2MIXpk2hA9kSzMeWPk4TojWh7KfSPaTeFljyJc7UYqBBNd1Q8xKLm3
	FyaGgB2fqpZ3LAIBbJUzhBXJzmW595I6XrQHSInogXQulnb7xOVni4kiBdFhYr5QVGrQDYj
	QzJroEnhg+sZ0OgcSjjZMyZJS76zZL2hI3pJBFNAlALw6pqIkeInFR3b9fPFd2jF+6QGixg
	utZQvEAXKnBRS+Zln0p2wTm8UL/NqXAhoV++ImP7YiNANNkpxg+ft6EYVcDsPO7MXBF0Jvy
	uC1JM7T7brTdOK6Qkb+9OObwdSqOmUMyM204RLX6evvHfJoHmptGpZt2tGiHEwIgry/gUiw
	MJK/DVv1rJDqCb/jAWejf07h9hRhOlnm6OmnkfDdIQ0tnWuKlc5HiBN0zrAVXoGYMXhIiCp
	roL81eLxZQmFeQPQAs9uyuYoaYoNlV+7L2VmKHTqg11pWaKE8fwuom3ArBX9+a0+/JlQ8Ui
	6utWmIxAHJxs78nE+nqZuzOjK4G5WewYmKX2Xjv28oA895oOlmROTmt71t0ZGqBFVRIcHqf
	faI2Rh2jUJ9ly88CYL9VGVSLvcbFZzph5bLKTmhgVQDh+21Sx7uZGBty3Yx9AhliAznRPoq
	0HOhDjfCkYcBRXkBjyyqnAFHBQfG2fn6c0DJgSp0YNHoS2lzkwFKTE6y9Qab25yes28imXz
	vwHetVmwEHUxAKaTe/Ir30+//0E/nC+PmgHynTaq432j3fOj+Ajfbam49MWLNi0r8QsDX9u
	FKCYBWj4IfaH3z2A4vPTXny8/HfW1DDgHjgRSQaVEUZvq5GP7oTALLi2/SibaLtgbXwX42J
	JUt06X8g==
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


