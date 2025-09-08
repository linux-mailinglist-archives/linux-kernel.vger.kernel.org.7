Return-Path: <linux-kernel+bounces-806327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F96B49519
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 18:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 746E2167886
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915373101B1;
	Mon,  8 Sep 2025 16:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fb6MBuAY"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5765030FF33;
	Mon,  8 Sep 2025 16:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757348479; cv=none; b=VfnH6Fd984jHNP+6B6ttEhpYTrcxX37rmXIvOpXKbdYnADlU2HvU6uVU+GWs+KdVsW1sKr4mthLwinTVmagKMHBwhbznxoEHXmjZ1LL/dX5/7Ee7TYOvuIEPYRoguq9TFT1/YnQYvm6dyDcE3ZbzbdKgLTYjtSf255Gf4fuYi+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757348479; c=relaxed/simple;
	bh=ObIz+zp4lgzgox/7k1WlzLLzMcg9mj+QVGcH9Gr3WV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r9otK4+Acc37YCyDw9wHnZVx6OxsjUe46S2ORu5MFZvgrXMpgEa0ncZIffVGNKr4EidOx3PQki5Ly+ej91MrEoLAiMWJrzQo1wuCFitTTaffHLIDgOU+mK+j1eWngc9wC43TgQjhVf8GmCYW+xoQfPoF3oz2WrQi5t5d5EgX+Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fb6MBuAY; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id CB5CD4E40BFB;
	Mon,  8 Sep 2025 16:21:15 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A03D66061A;
	Mon,  8 Sep 2025 16:21:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4F428102F23A0;
	Mon,  8 Sep 2025 18:21:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757348475; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=5UhibPtQVINFYBbqXWLMG4UxJzAoW2vDCrPuqBZnckk=;
	b=fb6MBuAYKGgiKvyw1GlL2AM9X+MT2/NIV9LiTB9fspBia5AIVHnZ4lOyjGimoTP5JXAIjb
	EXXt714Xl6CXh7PtfUC69+Pj/qsbLqm1v3r0ImtAZ17kdIBR3pMvvzXPpliKmCQNqIuGht
	ESL1cdO3Xk3CNmgfABqfzdYNOFBGPJM0uI8wGgRr2WUToAeuPGlATNcnolL10L6lT3Hxaj
	/SY43Q06F+8cRcVuLjPO3MWfzLfN+ZDkybW1AneAKhxIcSjJRpMQDGlbT05nn/IvA7ANHU
	aKtzaSPHw/OB+aNAGw0q5z5nfFcaUrUxqmGcmk8txfCQHU64TmtUsOVkT6OdMQ==
From: Richard Genoud <richard.genoud@bootlin.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Aswath Govindraju <a-govindraju@ti.com>,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Richard Genoud <richard.genoud@bootlin.com>
Subject: [PATCH 2/2] usb: dwc3-am62: support ti,lane-reverse property
Date: Mon,  8 Sep 2025 18:20:52 +0200
Message-ID: <20250908162052.355341-3-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250908162052.355341-1-richard.genoud@bootlin.com>
References: <20250908162052.355341-1-richard.genoud@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Support the ti,lane-reverse property by setting the
USBSS_PHY_LANE_REVERSE bit.
This way, D+ line become D- and vice and versa.

Tested on am625 SoC.

Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
---
 drivers/usb/dwc3/dwc3-am62.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/dwc3/dwc3-am62.c b/drivers/usb/dwc3/dwc3-am62.c
index 9db8f3ca493d..9437d2246ee9 100644
--- a/drivers/usb/dwc3/dwc3-am62.c
+++ b/drivers/usb/dwc3/dwc3-am62.c
@@ -119,6 +119,7 @@ struct dwc3_am62 {
 	struct regmap *syscon;
 	unsigned int offset;
 	unsigned int vbus_divider;
+	unsigned int lane_reverse;
 	u32 wakeup_stat;
 	void __iomem *phy_regs;
 };
@@ -203,6 +204,9 @@ static int dwc3_ti_init(struct dwc3_am62 *am62)
 	if (am62->vbus_divider)
 		reg |= 1 << USBSS_PHY_VBUS_SEL_SHIFT;
 
+	if (am62->lane_reverse)
+		reg |= USBSS_PHY_LANE_REVERSE;
+
 	dwc3_ti_writel(am62, USBSS_PHY_CONFIG, reg);
 
 	clk_prepare_enable(am62->usb2_refclk);
@@ -264,6 +268,7 @@ static int dwc3_ti_probe(struct platform_device *pdev)
 	}
 
 	am62->vbus_divider = device_property_read_bool(dev, "ti,vbus-divider");
+	am62->lane_reverse = device_property_read_bool(dev, "ti,lane-reverse");
 
 	ret = dwc3_ti_init(am62);
 	if (ret)

