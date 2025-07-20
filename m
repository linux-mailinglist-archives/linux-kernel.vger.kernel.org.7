Return-Path: <linux-kernel+bounces-738197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF92CB0B5AE
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 14:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93922189391B
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 12:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36FBB1F4C84;
	Sun, 20 Jul 2025 12:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="KBOyZuH4"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CD817741;
	Sun, 20 Jul 2025 12:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753012942; cv=none; b=INU2t0ow+VnPOnJ/QqZolHIVxf9nLzp5ENfya0F+4b8SsdosjjVWbfvGNvsrDjmAGl5gl42rX5VjSHRpK+RDnhM+gPa80TvSnHwsOQco8mZU1J6USIY6DYI0guF3v0p8xcmSTE+EimvKIBNhHXeFlWU6KV4+0SxxAmOTJOTy6Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753012942; c=relaxed/simple;
	bh=z7UInY2V+5A/AzQtYe31EauuP8QWRTvlpkfW8x62dEQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QinpoGNNVEDFu8dDjkIQGwf2GmaYIQfKkLf9WIODDTL6DCwAsmyIbhQ7HrQN9w/gnnie6kdL542NWPU0nWXfNbfiYcMBLpdQUQgpBmDAoxgZkPU0K8cuS4zJtZGk5K1KewPMbYVwfGbVF4xITtMAee7NAzRt8hwWabfcDygWnOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=KBOyZuH4; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 640D325DA1;
	Sun, 20 Jul 2025 14:02:12 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iwt8Xl3-yt6y; Sun, 20 Jul 2025 14:02:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1753012931; bh=z7UInY2V+5A/AzQtYe31EauuP8QWRTvlpkfW8x62dEQ=;
	h=From:Subject:Date:To:Cc;
	b=KBOyZuH4Ecm7kqnX0sWekVAqNY0FyqQUW4taiOQE4oMyYvIaH4xFtUSqp+ek1qJR7
	 zerS1pzUw9BOXAZ7Jp+DCzsk+02ScTJpBdSS8VtTlgw1I2qlvW5gZV34UcYVGIrWu7
	 8B62MZEKOPJ8N7bysML0txUqLajcGfxuZAVyNTTXwRUQn0UtEuRuaXR+AFZwroH9Z8
	 F+/NapKFyhucBX3M5lOdZTGSWd8mLbTKD9zTAuqHKyTw7cj9lYdTV/YflzAY7egD4H
	 W92uNkiv2+RqRjJQg2sz+KC5gvw/Ez+TXvKedGaM3VBrNZWCXi13/P3EYV2GHEq14g
	 4DiLipCptdt8Q==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Subject: [PATCH v3 0/2] Support for Synaptics TDDI series panels
Date: Sun, 20 Jul 2025 17:31:53 +0530
Message-Id: <20250720-panel-synaptics-tddi-v3-0-43a5957f4b24@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALHafGgC/3XNTQqDMBCG4atI1k1JJsZIV71H6SK/OlCMJCIV8
 e6NdtNCu3w/mGdWkn1Cn8mlWknyM2aMQwlxqojt9dB5iq40AQaSSRB01IN/0LwMepzQZjo5h5Q
 ZZkRgKrS8JuV0TD7g82Bv99I95imm5fgy8319gw2H3+DMKaMumFbXIINq7NVhTjFO55g6spMzf
 DAg/zBQGKUb0IY7Lqz6ZrZtewFjhD9kAQEAAA==
X-Change-ID: 20250523-panel-synaptics-tddi-0b0b3f07f814
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kaustabh Chakraborty <kauschluss@disroot.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753012923; l=1952;
 i=kauschluss@disroot.org; s=20250202; h=from:subject:message-id;
 bh=z7UInY2V+5A/AzQtYe31EauuP8QWRTvlpkfW8x62dEQ=;
 b=g1zKgQ1Y+6w3mlITGjx3sHpmfGU82CJFK8NEX2y40l0Q//jEZpCURnKYU5h7da5MOQcFpGaES
 I7EzK91pmTmAy+jCDj0IJ5tdUBh4ZtQ7LDhtjvxi50ITvIN1CpgGW3M
X-Developer-Key: i=kauschluss@disroot.org; a=ed25519;
 pk=h2xeR+V2I1+GrfDPAhZa3M+NWA0Cnbdkkq1bH3ct1hE=

Synaptics' Touch and Display Driver Integration (TDDI) technology [1]
employs a single chip for both touchscreen and display capabilities.
Such designs reportedly help reducing costs and power consumption.

Although the touchscreens, which are powered by Synaptics'
Register-Mapped Interface 4 (RMI4) touch protocol via I2C or SPI have
driver support in the kernel, the MIPI DSI display panels don't.

This series introduces a rudimentary driver for controlling said display
panels, which supports TD4101 and TD4300 panels.

[1] https://www.synaptics.com/technology/display-integration

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
Changes in v3:
- fixed various dt_binding_check errors (robh's bot)
- adjusted commit description of [v2 1/2] (robh)
- utilized devm_drm_panel_alloc() and devm_regulator_bulk_get_const()
- Link to v2: https://lore.kernel.org/r/20250625-panel-synaptics-tddi-v2-0-7a62ab1d13c7@disroot.org

Changes in v2:
- fixed various dt_binding_check errors (conor)
- did s/tddi_update_brightness/tddi_update_status
- added check for panel enable in tddi_update_status()
- used backlight_get_brightness() in appropriate places
- Link to v1: https://lore.kernel.org/r/20250612-panel-synaptics-tddi-v1-0-dfb8a425f76c@disroot.org

---
Kaustabh Chakraborty (2):
      dt-bindings: display: panel: document Synaptics TDDI panel
      drm: panel: add support for Synaptics TDDI series DSI panels

 .../display/panel/synaptics,td4300-panel.yaml      |  89 +++++++
 drivers/gpu/drm/panel/Kconfig                      |  11 +
 drivers/gpu/drm/panel/Makefile                     |   1 +
 drivers/gpu/drm/panel/panel-synaptics-tddi.c       | 289 +++++++++++++++++++++
 4 files changed, 390 insertions(+)
---
base-commit: d086c886ceb9f59dea6c3a9dae7eb89e780a20c9
change-id: 20250523-panel-synaptics-tddi-0b0b3f07f814

Best regards,
-- 
Kaustabh Chakraborty <kauschluss@disroot.org>


