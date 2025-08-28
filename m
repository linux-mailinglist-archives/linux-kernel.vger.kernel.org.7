Return-Path: <linux-kernel+bounces-789221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0338B3925D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 06:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F8A57C048D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 04:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993E123BD1F;
	Thu, 28 Aug 2025 04:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b="NXsN2ifY"
Received: from ironport.ite.com.tw (219-87-157-213.static.tfn.net.tw [219.87.157.213])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6066113957E;
	Thu, 28 Aug 2025 04:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.87.157.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756353806; cv=none; b=DRqpG9oUWxRRX6JvSyeTu0j+QtTz9MuEMVa11UnQUsqpgqFsZB8gpREPkJHoZsmRcyVro/ZSyWsIN5HwO5UjhOL+TuiXqGACxZAy8NudJRRQT1BKZvL5KgFmHeXJ9Rs7OBrDl+xj8MWArkCDBmU7cUJK2EUJ27mHxFBlRTESo/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756353806; c=relaxed/simple;
	bh=ZiCpOPIDp8CIyXPezc/kfJZESu91544+TFydq1LGiDk=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=V11GANafqLWdOsK8Ru39WFN7Mtxbb2IZr2FxBpzCSzkNdp0Gk52/vPxP3I/z8mmyvNd7FCj9JpANZ4C5Iq5vaf6aCJpJpRLkzM6teSZVbtlremr8cxg443HGYuGVdej+vXsvm1v0Yda7cjg90y1fcHgLKvnPcSe1rsfjBCzGp3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw; spf=pass smtp.mailfrom=ite.com.tw; dkim=pass (2048-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b=NXsN2ifY; arc=none smtp.client-ip=219.87.157.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ite.com.tw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=ite.com.tw; s=dkim;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=sBxzpMj4gtCGPy2USEQt4AlBG9MoUUY80bEM/tcQSeU=;
  b=NXsN2ifYe3bBEovmuJpAIaunoAQ3dBFaatwmuiuWM1ogyPkgg1nbFjCr
   vbEAdOHgxcJW3NWtRa2xsTeFnYQGJoGh8EbAoc2hrzWr22sKvDsCCDYsg
   Kg+UCsflemxKYdToaE3moRygWKfub59q+dSalxx7rXiGEiBRlKGG2Nx0b
   b+Dgc+XJq3H9sWMUAkBz+jaOnEb4FXfxGtsJ38K2ToK2Bn8agJi+5QqAm
   2P05rDOy8JFVTCxIHdpeSg+AdvBnqdZmOQw+JfLyx9BkqD5glltJpceeI
   y+PjbaoQksOmhafNOC5HmTVlEUCQQ0Wu9mGk+ITiQ4eK9lmgHWK4OrDpk
   A==;
X-CSE-ConnectionGUID: 4Kbe1zDfTIyv5PT/lgWhMw==
X-CSE-MsgGUID: ixMMyBRzSrCTfHFkp2INGw==
Received: from unknown (HELO mse.ite.com.tw) ([192.168.35.30])
  by ironport.ite.com.tw with ESMTP; 28 Aug 2025 12:02:12 +0800
Received: from CSBMAIL1.internal.ite.com.tw (CSBMAIL1.internal.ite.com.tw [192.168.65.58])
	by mse.ite.com.tw with ESMTP id 57S428ct028000;
	Thu, 28 Aug 2025 12:02:08 +0800 (+08)
	(envelope-from Pet.Weng@ite.com.tw)
Received: from [127.0.1.1] (192.168.72.40) by CSBMAIL1.internal.ite.com.tw
 (192.168.65.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 28 Aug
 2025 12:02:07 +0800
From: Pet Weng <pet.weng@ite.com.tw>
Subject: [PATCH v2 0/3] Add ITE IT61620 MIPI DSI to HDMI bridge driver
Date: Thu, 28 Aug 2025 12:01:17 +0800
Message-ID: <20250828-it61620-0714-v2-0-586f5934d5f8@ite.com.tw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI3Ur2gC/3XMQQ7CIBCF4as0s5aGQaTWlfcwXbR0sLOwGCBV0
 3B3kb3JbL5J3r9DpMAU4dLsEGjjyH4tUIcG7DKudxI8F4OS6iQ71IKTQaOkqBgnXc6Sc6qHMnk
 GcvyuudtQvHBMPnxqfcPf909oQyHFsTOIRs9y6s9XTtRa/2jTC4ac8xdcbzSXqQAAAA==
X-Change-ID: 20250714-it61620-0714-ab4ab4ceff29
To: Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong
	<neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart
	<Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej
 Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Hermes Wu <hermes.Wu@ite.com.tw>,
        Kenneth
 Hung <kenneth.Hung@ite.com.tw>,
        Pet Weng <pet.weng@ite.com.tw>, Pin-yen Lin
	<treapking@google.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756353731; l=1955;
 i=pet.weng@ite.com.tw; s=20250702; h=from:subject:message-id;
 bh=ZiCpOPIDp8CIyXPezc/kfJZESu91544+TFydq1LGiDk=;
 b=f8vNAqg7ftRLxlQWMj81RlR0KSSrfPViSmxa8L2ZyCceuf8gW9/p0DP58RdW+vzhu5Lnu00a9
 miEBMZvzpCQDAYTfMN6Q9XFfGBSgzvjS6BpYSWpZhzOwYDf9MZvwNcU
X-Developer-Key: i=pet.weng@ite.com.tw; a=ed25519;
 pk=wd08uBtTLb93x2ixbKVNsxiZPdMh1Ov4z5klodh2bqo=
X-ClientProxiedBy: CSBMAIL1.internal.ite.com.tw (192.168.65.58) To
 CSBMAIL1.internal.ite.com.tw (192.168.65.58)
X-TM-SNTS-SMTP:
	323AFBC42FEAB12407C38FBEDEF9EF64357E22719BEC9D6B83D36B23E47712F52002:8
X-MAIL:mse.ite.com.tw 57S428ct028000

This patch series adds support for the ITE IT61620 MIPI DSI to HDMI 
bridge chip.

The IT61620 is an I2C-controlled bridge that receives MIPI DSI input 
and outputs HDMI signals. A single-port MIPI DSI input is converted to 
an HDMI 1.4 output. This series introduces:
- A device tree binding YAML file describing the hardware
- A new DRM bridge driver implementing the basic functionality
- A MAINTAINERS entry for the driver

Signed-off-by: Pet Weng <pet.weng@ite.com.tw>
---
Changes in v2:
- Call the sha1() library function instead of using the crypto_shash
  "sha1" in patch 2.
- Rewrite it61620_hdmi_ddc_wait() with readx_poll_timeout() in patch 2.	[Pin-yen]
- Rewrite it61620_hdmi_hdcp_wait_ksv_list() with readx_poll_timeout() in
  patch 2.
- Replace interrupts-extended with interrupts in patch 1.		[Rob]
- Replace dsi-lanes with the standard property data-lanes from the graph
  binding.								[Rob]
- Replace "#/$defs/port-base" with "#/properties/port" in patch 1.	[Rob]
- Drop unused labels and "hdmi" for the node name.			[Rob]
- Drop status in patch 1.						[Rob]
- Link to v1: https://lore.kernel.org/r/20250714-it61620-0714-v1-0-3761164d0b98@ite.com.tw

---
Pet Weng (3):
      dt-binding: display: Add ITE IT61620 MIPI DSI to HDMI bridge
      drm/bridge: Add ITE IT61620 MIPI DSI to HDMI bridge driver
      MAINTAINERS: Add entry for ITE IT61620 MIPI to HDMI bridge driver

 .../bindings/display/bridge/ite,it61620.yaml       |  143 +
 MAINTAINERS                                        |    8 +
 drivers/gpu/drm/bridge/Kconfig                     |   19 +
 drivers/gpu/drm/bridge/Makefile                    |    1 +
 drivers/gpu/drm/bridge/ite-it61620.c               | 2944 ++++++++++++++++++++
 5 files changed, 3115 insertions(+)
---
base-commit: 2862348dd4f8d9271ad4fd195fa9b81546db95f3
change-id: 20250714-it61620-0714-ab4ab4ceff29

Best regards,
-- 
Pet Weng <pet.weng@ite.com.tw>


