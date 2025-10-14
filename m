Return-Path: <linux-kernel+bounces-852457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A9FBD90A2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 13:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 157C01920CB7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6BB30CD80;
	Tue, 14 Oct 2025 11:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MFJvYsc6"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E40223AB8D
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 11:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760441483; cv=none; b=P+XR81yZNm1scQ2a+tT+1Q20CUszUdNh/U/HQFF+m7Pa6WU8QvJPZnfD8TeU5V/TJQ9lfA71aKqy5ShEMXPK36uzf7l6PJMTPcggB6VOW2gq86QMeXk7jz8ny7zZjUjS2KJkW4eI2pYWr66jr9y3bAX7E2a4cFECEv3jTf963Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760441483; c=relaxed/simple;
	bh=X5O4OuxN4PPu5H+pq82wHNI8XN+5YsztxwuTWtmrORk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rZDr3ocEKCDtxQxSchZ7DgcV+ySOUDdeuc4QbExf/lGxhKhVYd35Lad/mlCLAb6lQo+J+3tTTt3cQ81X8lXqGMBYA1LqgXYINsQSb8VgSwPLY5vK/EktSnKMcSa/KTfkamgbDU6sB+09RF6trBHbcT0O6qwMxwKAhrRsdrbr/kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MFJvYsc6; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 7507C1A136A;
	Tue, 14 Oct 2025 11:31:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 48E46606EC;
	Tue, 14 Oct 2025 11:31:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 16468102F2298;
	Tue, 14 Oct 2025 13:31:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760441475; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=6p8WMfmPS/2ENAV2cQiuR3uNGwiPH4kh/nqLPv36UjI=;
	b=MFJvYsc63DmUpUkpCKHQjuI/RLnMI17jrS5/jJUT8DRfNGXMIzmthheE7w4LzLqwHC3IMm
	y7R4pOQTiMiChEj5glwZ4fHyPYaJvgdBpIiSzC20ONyWYDFRZbl82IyUUzPJ7EYns56TdV
	xdFsFSXr25J3Rzqlob7LrEjEVqq2E/SOlv8rQo4yDJKFPFgPV3G92CcrYOhCobjJZaHzgV
	b9TSxh8rOwq5tgkxjEndTgluNftA6FDVSGmpI50WESXJqZEN9zdayy7LvACxIrIxhHNOIj
	k34PxeHOYjOX7Ww2NDHhXL7B1Y1DPgf5g1vBaSHuvld4DDIjVqydaF7QFsBruQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH 0/2] drm/imx: parallel-display: fix drm/panel/panel-simple
 v6.17 WARNING regression
Date: Tue, 14 Oct 2025 13:30:50 +0200
Message-Id: <20251014-drm-bridge-alloc-imx-ipuv3-v1-0-a1bb1dcbff50@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGo07mgC/x3MSQqAMAxA0atI1gZsnahXERfaphpwIkURine3u
 Hx8+BECCVOALosgdHPgY09QeQZ2GfeZkF0y6ELXqlAVOtlwEnapjOt6WOTtQT6vu0QztUb7pjb
 WG0iDU8jz88/74X0/M86X3mwAAAA=
X-Change-ID: 20251014-drm-bridge-alloc-imx-ipuv3-9b792f659cf9
To: Ernest Van Hoecke <ernestvanhoecke@gmail.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

This series fixes the WARNING regressions reported by Ernest [0] and due to
the missing conversion of the DRM_IMX driver to the new
devm_drm_bridge_alloc() API.

The second patch also adds drm_bridge_add(), which is a good practice and
proposed to become mandatory [1].

[0] https://lore.kernel.org/all/hlf4wdopapxnh4rekl5s3kvoi6egaga3lrjfbx6r223ar3txri@3ik53xw5idyh/
[1] https://lore.kernel.org/lkml/20251003-b4-drm-bridge-alloc-add-before-attach-v1-0-92fb40d27704@bootlin.com/

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
Luca Ceresoli (2):
      drm/imx: parallel-display: convert to devm_drm_bridge_alloc() API
      drm/imx: parallel-display: add the bridge before attaching it

 drivers/gpu/drm/imx/ipuv3/parallel-display.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)
---
base-commit: 48a710760e10a4f36e11233a21860796ba204b1e
change-id: 20251014-drm-bridge-alloc-imx-ipuv3-9b792f659cf9

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


