Return-Path: <linux-kernel+bounces-738200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 785EFB0B5B7
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 14:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D18CE177F52
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 12:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88481F4E59;
	Sun, 20 Jul 2025 12:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="IqyvQLA+"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B838117741;
	Sun, 20 Jul 2025 12:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753013003; cv=none; b=BQ1Pb+8CX1WCCp9Pwo1cJ0BLJs2YDqxJ0yO2EhcgWhEiImv5yHefCxs4J+dEmSO++tCRuGYF6A4p1Ekg9KkKn3GD4t9HXjHyDCX36yUlivnzF7FlQ+oYokKF+MkyVer5qkqE2jI2B/x3nIdC4GGW5qTBDA+XJWtbuANikrtD/60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753013003; c=relaxed/simple;
	bh=ULdfird/m3H0CCGaifQbfebWcqhBC7x7CngqCLoQy4o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pwnwojpNe/2h/85FG9wWbj8Y/xyEsYgC5hhb9jhkhC5UIYrh3wqMgEXu/xgfQ/oihXLBggfHkgkb4yvcA+DtRrTfr3Mb8Xzb/H2v6hrEX22OAPZkxyK1YmIAVQqwT8vFRoctwJOgsZ1XzuuQC0fZBc4shWWpRv0rQd/S81YvD3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=IqyvQLA+; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 73FD725DF5;
	Sun, 20 Jul 2025 14:03:20 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2HPPUv9AKyU6; Sun, 20 Jul 2025 14:03:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1753012999; bh=ULdfird/m3H0CCGaifQbfebWcqhBC7x7CngqCLoQy4o=;
	h=From:Subject:Date:To:Cc;
	b=IqyvQLA+wHyIT6D2O+Ig41B6VYFalqAdIk7iONKx7lBDc/naarqUh9DVPoyWRgdcE
	 dIFb/eJc9G6v9W4YEhgijFYb0qtlI9PuwoVA52NLFTGdEYDNUdV9bDnMPtfNXapaCv
	 ZNUUWeQCMN/I1bBWdQ5W983LfAAbWTzqpfnYkeBj/aCzXIYogWqZ7lVyzAXo55uVyE
	 bvQKfGds0t5OQgTKdgfzAlnudV7KSh+tJVDJm72rTAmbrYgpnJRvHCqpdT0h00VxLQ
	 DpAP6MDJbJ85PMj8jePLcfSvxYREMGygW1fugte0AZumRITg5UvcdG20lxo/DvPFwM
	 ywmR0g+ERNz/A==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Subject: [PATCH v4 0/2] Add driver for Samsung AMS561RA01 panel with
 S6E8AA5X01 controller
Date: Sun, 20 Jul 2025 17:33:06 +0530
Message-Id: <20250720-panel-samsung-s6e8aa5x01-v4-0-7d9258fa3f4a@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPrafGgC/43NQQ6CMBCF4auQrq1ph7aAK+9hXAx0wCZKSYsEY
 7i7VTcao3H5v2S+ubJIwVFkm+zKAk0uOt+nUKuMNQfsO+LOpmYgQAsNOR+wpyOPeIrnvuPRUIm
 oZyE5IajKELZkkaXzIVDr5ge926c+uDj6cHl8muR9faJGwnd0klxwYWxToygkodlaF4P349qHj
 t3ZCV4o0D8oSJSydQF1WaBG9Unl/1J5oiqUqlItmUaLd2pZlhvpjXz6WAEAAA==
X-Change-ID: 20250523-panel-samsung-s6e8aa5x01-ea2496eafeda
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753012994; l=2027;
 i=kauschluss@disroot.org; s=20250202; h=from:subject:message-id;
 bh=ULdfird/m3H0CCGaifQbfebWcqhBC7x7CngqCLoQy4o=;
 b=xJKYpWcV3ovB1SRGIywakEPOd/bOMibryIBH6vckS/wsZ+3k37q+c0O6O17U3xWSBI0Vt4mrW
 2MdCMWOAsSbCYFbhgbefTxYW3vejT2Y1n2kQ8fNlXjFPxpYKnuHxRVm
X-Developer-Key: i=kauschluss@disroot.org; a=ed25519;
 pk=h2xeR+V2I1+GrfDPAhZa3M+NWA0Cnbdkkq1bH3ct1hE=

This patch series introduces a driver for Samsung AMS561RA01, which is
an AMOLED panel using the Samsung S6E8AA5X01 panel controller. This
panel is found in several (mostly Samsung) phones, it is a ~5.6 inch
720x1480 panel.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
Changes in v4:
- tweaked commit description of [v3 1/2] to reference the hardware.
- utilized devm_drm_panel_alloc() and devm_regulator_bulk_get_const()
  (neil.armstrong)
- redid patches to mention both panel and controller (dmitry.baryshkov)
- Link to v3: https://lore.kernel.org/r/20250625-panel-samsung-s6e8aa5x01-v3-0-9a1494fe6c50@disroot.org

Changes in v3:
- added brightness values for upto 500 nits.
- removed unused mutex object from panel code.
- Link to v2: https://lore.kernel.org/r/20250625-panel-samsung-s6e8aa5x01-v2-0-4db72b87a5a4@disroot.org

Changes in v2:
- fixed various dt_binding_check errors (conor)
- simplified panel enable sequencing (tzimmermann)
- did s/s6e8aa5x01_update_brightness/s6e8aa5x01_update_status (tzimmermann)
- added check for panel enable in s6e8aa5x01_update_status() (tzimmermann)
- used backlight_get_brightness() in appropriate places (tzimmermann)
- Link to v1: https://lore.kernel.org/r/20250612-panel-samsung-s6e8aa5x01-v1-0-06dcba071ea6@disroot.org

---
Kaustabh Chakraborty (2):
      dt-bindings: display: panel: document Samsung AMS561RA01 panel with S6E8AA5X01 controller
      drm: panel: add support for Samsung AMS561RA01 panel with S6E8AA5X01 controller

 .../panel/samsung,s6e8aa5x01-ams561ra01.yaml       |  55 ++
 drivers/gpu/drm/panel/Kconfig                      |  11 +
 drivers/gpu/drm/panel/Makefile                     |   1 +
 .../panel/panel-samsung-s6e8aa5x01-ams561ra01.c    | 981 +++++++++++++++++++++
 4 files changed, 1048 insertions(+)
---
base-commit: d086c886ceb9f59dea6c3a9dae7eb89e780a20c9
change-id: 20250523-panel-samsung-s6e8aa5x01-ea2496eafeda

Best regards,
-- 
Kaustabh Chakraborty <kauschluss@disroot.org>


