Return-Path: <linux-kernel+bounces-627765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FFDAA54DC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 21:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F09050284D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 19:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7A11EFFA3;
	Wed, 30 Apr 2025 19:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="rpGpd2OM"
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F07A1EF394;
	Wed, 30 Apr 2025 19:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746042140; cv=none; b=eKYN5ye3TIrmubnf0tfK/Tojvo1GB9VRVEo/hRhUe3Ubsi9qJgTWwv+YbCRak3oORPL69gvD0H5thyS4PBJlExkus4fFlH+yURDDW/ULMM39BlU0cK+p3ZDNBxSanKJPsA1AGeX/PhPygCzw5RJ0EmxyWTSOGRsDXD+G+nlT7Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746042140; c=relaxed/simple;
	bh=2+4SRA/9LdSjPheH4Q8cDuja6UpLq8wSEuPOPddLIak=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bVbnaa5rbZIUtXcYArxzNh0c/M7oG/bYBTOMfVfGCbQRqK4/qmX1NoJ0YireH/zWmlbocAP/CBb5U6c5wxtDVXhbmLpAkFPi7u0mxGblHiPfsDSSfGreh/XAFz4yScGGtuuR3M5PF/Bbzs52N8ZfqRNYG+Dl4FU7GU6mKtNRGaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=rpGpd2OM; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from [192.168.78.162] (254C22F1.nat.pool.telekom.hu [37.76.34.241])
	by mail.mainlining.org (Postfix) with ESMTPSA id 75B95BBAD2;
	Wed, 30 Apr 2025 19:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1746042136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tBaCp7GDrjHsX8Pvl09Fu1jU77VZa/OZKfdlMSUymeM=;
	b=rpGpd2OMEt4bWkB64hWOQpbQSsdAXVUKM1BbzfXg90kBABvnAsVcOwuF6LcEzZhvIki36+
	Qjzn83yS01GTrtss482s4p1veWWmF5hshGcW0M9v2c5JKhFjy6zdVNzJFOoU6xCESdQNZy
	udS1HIQR8uGEcg9a1qpJPx1M2RR33P/vxhsxxCcJFnMMVd/B+wJ4gCLK9OWcWR1lzbs/Qs
	mlkuiiINQYXWEf8CAaffx7ZfrpjNDlyjSRWY8JT3dujnXGl0meaeSupJBetmaZWqYAIeu1
	2qBYuWQ2qUCA4xRDb+/WdqAQMN5klZQJpdjfFjsz9chZILRGolVKtxbPpUWZoA==
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Subject: [PATCH v3 0/2] BOE TD4320 panel
Date: Wed, 30 Apr 2025 21:42:11 +0200
Message-Id: <20250430-lavender-panel-v3-0-7625e62d62b2@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABN9EmgC/2XMQQrCMBCF4auUrI10xpiqK+8hLpJ20g7UtCQSl
 NK7mxYEscv/wfsmESkwRXEpJhEoceTB5zjsClF3xrckucktsMRjqVDL3iTyDQU5Gk+9RAdKKTz
 XNViRT2Mgx68VvN1zdxyfQ3ivfoJl/VLVP5VAltKiBtCVAq3r68Ow79mzb/dDaMXiJfw1zhsDs
 +Gs0pVzJ7Bma8zz/AGAXARg9QAAAA==
X-Change-ID: 20250426-lavender-panel-2f144429cc1b
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 phone-devel@vger.kernel.org, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746042135; l=1101;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=2+4SRA/9LdSjPheH4Q8cDuja6UpLq8wSEuPOPddLIak=;
 b=WxSfvaN2kZQkf+1xudZszr2+e3fl9FgMPY+Ts+d0J2LM8jNUxPgxMedQk6Bf6YQVYt5JvdHjh
 wfcnt5TDYvyCTzgtcy2evJokURj5NmCEIrZpqqzqGSbF02mnn7rjymd
X-Developer-Key: i=barnabas.czeman@mainlining.org; a=ed25519;
 pk=TWUSIGgwW/Sn4xnX25nw+lszj1AT/A3bzkahn7EhOFc=

Add driver for BOE TD4320 DSI panel, used in Xiaomi Redmi Note 7
smartphones.

Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
---
Changes in v3:
- Convert to use devm_drm_panel_alloc
- Fix vsn, vsp supplies description.
- Link to v2: https://lore.kernel.org/r/20250429-lavender-panel-v2-0-fb467ff81bac@mainlining.org

Changes in v2:
- Add supplies
- Link to v1: https://lore.kernel.org/r/20250427-lavender-panel-v1-0-b2611674166c@mainlining.org

---
Barnabás Czémán (2):
      dt-bindings: display: panel: Add BOE TD4320
      drivers: gpu: drm: panel: Add BOE TD4320

 .../bindings/display/panel/boe,td4320.yaml         |  65 ++++++
 drivers/gpu/drm/panel/Kconfig                      |   9 +
 drivers/gpu/drm/panel/Makefile                     |   1 +
 drivers/gpu/drm/panel/panel-boe-td4320.c           | 247 +++++++++++++++++++++
 4 files changed, 322 insertions(+)
---
base-commit: 393d0c54cae31317deaa9043320c5fd9454deabc
change-id: 20250426-lavender-panel-2f144429cc1b

Best regards,
-- 
Barnabás Czémán <barnabas.czeman@mainlining.org>


