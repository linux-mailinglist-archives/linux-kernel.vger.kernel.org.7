Return-Path: <linux-kernel+bounces-846411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E870BC7F17
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 10:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7CADA4FA1D8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 08:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2512D23BD;
	Thu,  9 Oct 2025 08:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b="Ql1GYl33"
Received: from ironport.ite.com.tw (60-251-196-230.hinet-ip.hinet.net [60.251.196.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B321025D202;
	Thu,  9 Oct 2025 08:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.251.196.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759997055; cv=none; b=V8Zaz7ENNghoQVC0hnPqoME1rlrxrtvLrlYOyM+ByGo6loH3W3QiJ4Js98r5dGQ8O2ejbajmIpSXE3eEbqCZ/CsGyZxt6vHT32janver0TkOSrKv69S0h9WNO/GuUoBl7QVxFh6387BqTIMb+QCwuHTvbPftowS1Sgs21/iHR0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759997055; c=relaxed/simple;
	bh=rpD4sPSLaH1a3BjRNKBpRKei67pNGc2zXt6pOgi3QW8=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=l1AeqmspUqkpWU7xPoGlq94TYr81ou7QnXWA40DN0pJqsOHp67DLn35XYylzfy7v1HrV5ClNCL4reNBoWPXHc95+D3MuoDp2pd/Npq3jdBRkkN0bGgGYv2h9Ry5mznIR1S7bmzEykFwLAgyUx5H+k5zhM+Lt+JDirWDG9DiZBFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw; spf=pass smtp.mailfrom=ite.com.tw; dkim=pass (2048-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b=Ql1GYl33; arc=none smtp.client-ip=60.251.196.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ite.com.tw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=ite.com.tw; s=dkim;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=6Yq/qLQ14gKSYvsG82tsg8dB7qbDonfawvPgibNmxCc=;
  b=Ql1GYl33K6U6vWmgLHUenacDUjX7Lmw24uhSZLdvQZwpBSUUvk47i4Sv
   hz4qTefviqDssn0K5uQA/lr7qCLJepx3woYNnn8+f5+6DsfnxJXBCYPpB
   Kt5Cg8j2U5+uPk6CEfHvUGEx/zcYQfy6ZqlS6u9aFRGOUUnzT9DGdvWY2
   MA2qIGcdUJIPjd/7vBV0aUXptjwAAEM4/N65GJwJ3kbATdYnbhCEYC39b
   +p3VHEpiSm9MgfQWfb+a6Kshs008ui+J5tcNHLcKOwmVCg1W1yPxnUo0O
   MudpLmzsDwXvPdX735Z91NNCPLqvANIKoyKS1Qo7q3i+GLEJC89uP3UZk
   Q==;
X-CSE-ConnectionGUID: 13WKSksZS/GlA2D+YHOGLQ==
X-CSE-MsgGUID: lIEcOF9gR26i2+vtwOFZBA==
Received: from unknown (HELO mse.ite.com.tw) ([192.168.35.30])
  by ironport.ite.com.tw with ESMTP; 09 Oct 2025 16:03:02 +0800
Received: from hscmail1.internal.ite.com.tw (HSCMAIL1.internal.ite.com.tw [192.168.35.58])
	by mse.ite.com.tw with ESMTP id 59982vik072677;
	Thu, 9 Oct 2025 16:02:57 +0800 (+08)
	(envelope-from Pet.Weng@ite.com.tw)
Received: from [127.0.1.1] (192.168.72.40) by HSCMAIL1.internal.ite.com.tw
 (192.168.35.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Thu, 9 Oct
 2025 16:02:57 +0800
From: Pet Weng <pet.weng@ite.com.tw>
Subject: [PATCH v3 0/3] Add ITE IT61620 MIPI DSI to HDMI bridge driver
Date: Thu, 9 Oct 2025 16:02:33 +0800
Message-ID: <20251009-it61620-0714-v3-0-5d682d028441@ite.com.tw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABls52gC/3WMyw7CIBBFf6WZtTQwBUpd+R/GRR9gZ2FrgKCm6
 b9LuzGamNzNuck5CwTryQY4Fgt4myjQPGWoDgX0YztdLaMhMyBHxWshGUUtNHK2Q9vJvN46hw1
 k5e6to+eeO18yjxTi7F97PYnt/RNKgnFW1VoILQfeNeZE0Zb9fCvjA7ZSwo9t0PzYmG1ltFNNJ
 Qflvu11Xd+OTtuE5wAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759996977; l=3681;
 i=pet.weng@ite.com.tw; s=20250702; h=from:subject:message-id;
 bh=rpD4sPSLaH1a3BjRNKBpRKei67pNGc2zXt6pOgi3QW8=;
 b=YBrsbXgd0vm5QjMllmzkLm9xadqsxc9IXpJGizi2A+6UVhsDoHZDqsoiTYI4xZz+XHNKd5REE
 CwYV94MVu/xCqfCBUN5+lOJ9XME8aKU5GQLbIwwaaKZn/dECqNhTEqQ
X-Developer-Key: i=pet.weng@ite.com.tw; a=ed25519;
 pk=wd08uBtTLb93x2ixbKVNsxiZPdMh1Ov4z5klodh2bqo=
X-ClientProxiedBy: CSBMAIL1.internal.ite.com.tw (192.168.65.58) To
 HSCMAIL1.internal.ite.com.tw (192.168.35.58)
X-TM-SNTS-SMTP:
	7929882D9F380320A7E2CE4D7B026C95314BD75D18C2473BC15B86C51CFA2ACD2002:8
X-MAIL:mse.ite.com.tw 59982vik072677

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
Changes in v3:
- Wrapped description lines to comply with 80-character line length limit
  in patch 1.								[Rob]
- Renamed node from "it61620@58" to "bridge@58" in patch 1.		[Rob]
- Add port@2 for I2S audio input in patch 1.				[Dmitry]
- Updated the Kconfig dependency from CRYPTO and CRYPTO_HASH to 
  CRYPTO_LIB_SHA1 in patch 2.						[Eric]
- In patch 2								[Dmitry]
 1. Audio and InfoFrame
   - Rename audfmt to i2s_input_format for clarity.
   - Remove unused infoframe[HDMI_INFOFRAME_SIZE(AUDIO)].
 2. Platform data and structure
   - Drop platform data usage; migrate members into struct it61620
 3. Code organization
   - Reorder functions to avoid the need for forward declarations.
   - Add static inline to small helper functions
     (e.g. bridge_to_it61620()).
 4. HDCP handling
   - Make HDCP enable/disable conditional on conn_state->content_protection.
   - Report authentication result using drm_hdcp_update_content_protection().
 5. Error handling
   - Replace manual error path with dev_err_probe().
 6. Power management
   - Inline suspend/resume callbacks.
   - Use DEFINE_RUNTIME_DEV_PM_OPS() instead of explicit struct definition.
 7. Bridge callbacks
   - Drop empty bridge_detach().
   - Inline it61620_bridge_mode_valid().
 8. EDID handling
   - Remove unnecessary cached EDID duplication.
 9. Mode set and pixel clock
   - Move mode handling to atomic_enable().
   - Keep only pixelclock for future N/CTS audio calculations.
 10. Logging
    - Replace noisy drm_err() calls with drm_dbg().
 11. InfoFrame support
    - Add support for SPD and Vendor InfoFrames.
- Link to v2: https://lore.kernel.org/r/20250828-it61620-0714-v2-0-586f5934d5f8@ite.com.tw

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

 .../bindings/display/bridge/ite,it61620.yaml       |  155 +
 MAINTAINERS                                        |    8 +
 drivers/gpu/drm/bridge/Kconfig                     |   18 +
 drivers/gpu/drm/bridge/Makefile                    |    1 +
 drivers/gpu/drm/bridge/ite-it61620.c               | 2998 ++++++++++++++++++++
 5 files changed, 3180 insertions(+)
---
base-commit: f601d2db7229dc5ca0e840d0c2279ea765551aee
change-id: 20250714-it61620-0714-ab4ab4ceff29

Best regards,
-- 
Pet Weng <pet.weng@ite.com.tw>


