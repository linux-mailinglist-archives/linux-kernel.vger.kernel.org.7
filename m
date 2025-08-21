Return-Path: <linux-kernel+bounces-779186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A7CB2F041
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 09:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53DC47B7076
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 07:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58BB42E9739;
	Thu, 21 Aug 2025 07:56:07 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A5328315A
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 07:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755762966; cv=none; b=Tx+WrxgjZmdBKty3gJiGCY9vI5vLakH2X42txdZZ2MuQgqBm6JV4bbzOyPg8HYl7UL0lEYGqHXACaKRJrosmVRxkTGkboL68VEZiKcNQq6pymxylFNtN+rPH4tBWoxbzksIGyVNBnDrknFZvJvqenBjNYUDNOgJTbyuCbebrqf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755762966; c=relaxed/simple;
	bh=gsyten1zTmdRLZG/miyOmU+qjPkqD3/N6UHUPzjkqIg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IpAkEZIAJph2hgvg+xde0zVVWlsO9RSv2/Rt/Ca0v1d5ofB+aW9ZPsyOmgUoLh5E01y1VC8BcBlB+/RbHPoaPU2/NF22MboPd7+4bHVpiSKHEjfXPCKTxSxmNVPAdnv6ZtD20kkwA33qOe8kkNwgytw2fucMpYZn3UJwrZrY3rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=ratatoskr.trumtrar.info)
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <s.trumtrar@pengutronix.de>)
	id 1up099-00073K-08; Thu, 21 Aug 2025 09:55:43 +0200
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Date: Thu, 21 Aug 2025 09:55:29 +0200
Subject: [PATCH 2/5] dt-bindings: display: simple: Add JuTouch JT101TM023
 panel
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-v6-17-topic-imx8mp-skov-dts-jutouch-10inch-v1-2-b492ef807d12@pengutronix.de>
References: <20250821-v6-17-topic-imx8mp-skov-dts-jutouch-10inch-v1-0-b492ef807d12@pengutronix.de>
In-Reply-To: <20250821-v6-17-topic-imx8mp-skov-dts-jutouch-10inch-v1-0-b492ef807d12@pengutronix.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, 
 Steffen Trumtrar <s.trumtrar@pengutronix.de>
X-Mailer: b4 0.14.2
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: s.trumtrar@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Add the JuTouch Technology Co. 10" JT101TM023 LVDS panel.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 Documentation/devicetree/bindings/display/panel/panel-simple.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index 1ac1f02190790cbff00c9f977d5c1a4420ed9f27..8107dc60e19695d56cd7302e7af7c808575df491 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -182,6 +182,8 @@ properties:
       - innolux,n156bge-l21
         # Innolux Corporation 7.0" WSVGA (1024x600) TFT LCD panel
       - innolux,zj070na-01p
+        # JuTouch Technology Co.. 10" JT101TM023 WXGA (1280 x 800) LVDS panel
+      - jutouch,jt101tm023
         # Kaohsiung Opto-Electronics Inc. 5.7" QVGA (320 x 240) TFT LCD panel
       - koe,tx14d24vm1bpa
         # Kaohsiung Opto-Electronics. TX31D200VM0BAA 12.3" HSXGA LVDS panel

-- 
2.49.0


