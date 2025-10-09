Return-Path: <linux-kernel+bounces-847180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9873EBCA2A9
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 18:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1910E3AA7F7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 16:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3E92236F0;
	Thu,  9 Oct 2025 16:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="GjyqaBta"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8848821C17D;
	Thu,  9 Oct 2025 16:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760027108; cv=none; b=EmTMBFSW3tOK9QA/wWMaYTlOdYggYIRVId0ejLnYm/6sDhX6+nGDggTrqwTm69DnpkUzdKtwg+p0l4iGPd0zv/ZOfROVswgCsnaMa5FWmdPijqlLGM08OclQFx2rgsMQhJbIug+0pYGwUOTrI2YR/Y9B9sH7sG6uJCoIcK23sw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760027108; c=relaxed/simple;
	bh=+fmM1LXL5j8cHsgbj61uU+OuNanXHVoMioQvqNc3PKg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XKOzTggX+WKKJZ6dTg0++0EmPgkD2nMtyOBBgVOAX+f470UbH93m5VLXzwvhp0p3K8PQiKYs7t/pBE7/yzVxIzn+zRkupG9Bjudvy5JNwTKo3jUmYbWbsFF69X0F39N0eHISyFaFYBMrUwi6iP4QHQtEiqaxg/pUo3F9/c2R6kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=GjyqaBta; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id CBE2925E07;
	Thu,  9 Oct 2025 18:24:57 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KpWwws5WmY3q; Thu,  9 Oct 2025 18:24:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1760027096; bh=+fmM1LXL5j8cHsgbj61uU+OuNanXHVoMioQvqNc3PKg=;
	h=From:Subject:Date:To:Cc;
	b=GjyqaBtanIGyo2bxuPk+X4E98uNUOwdiYPKQ/Ds4Q7n+I6gqghFxQiatF3wGPoq9c
	 znHWxdKRtj6muYTO6++i78gaYG1MzXyp6qJJX7T/DG4Nv3SFYPspRLpI5FWwcFIcXi
	 opqw+pJdIhg12AOKXr8X6u9XIoJeEwH02YegYyLldMxSHKPaCyjlKDcIIyMc+LdEik
	 qVQ6E/m6AFmnEIu5bbh+KzmFQ4jULyW9twhNFaj43C25LIlNPrzdxT1zEp36KCokOI
	 8a3Eejal2OWimrBqV4lKp+EiGNvTYMcPiNKzOYJK6mkI6+2n3U36/whbphuahXwQqT
	 rvRp5tETXMa1A==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Subject: [PATCH RESEND v5 0/2] Support for Synaptics TDDI series panels
Date: Thu, 09 Oct 2025 21:52:09 +0530
Message-Id: <20251009-panel-synaptics-tddi-v5-0-59390997644e@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760027068; l=2374;
 i=kauschluss@disroot.org; s=20250202; h=from:subject:message-id;
 bh=+fmM1LXL5j8cHsgbj61uU+OuNanXHVoMioQvqNc3PKg=;
 b=CjIhkvVXri8z127/rTuGYE1IvsAcweFcRWglC+cSNhXB20PUtF9TYbL/km6zJf2ls8U+kVAzh
 20+kBgR9m9rB0PLIPwTA0QMEMB/BmFWMUKVetRfI/r1LqnR9hE5LmRB
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
Changes in v5:
- added missing Reviewed-by tag from Krzysztof in [v3 1/2]
- Link to v4: https://lore.kernel.org/r/20250819-panel-synaptics-tddi-v4-0-448f466d16a6@disroot.org

Changes in v4:
- utilized drm_connector_helper_get_modes_fixed() (dmitry.baryshkov)
- constified backlight properties (dmitry.baryshkov)
- Link to v3: https://lore.kernel.org/r/20250720-panel-synaptics-tddi-v3-0-43a5957f4b24@disroot.org

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
 drivers/gpu/drm/panel/panel-synaptics-tddi.c       | 276 +++++++++++++++++++++
 4 files changed, 377 insertions(+)
---
base-commit: 5303936d609e09665deda94eaedf26a0e5c3a087
change-id: 20250523-panel-synaptics-tddi-0b0b3f07f814

Best regards,
-- 
Kaustabh Chakraborty <kauschluss@disroot.org>


