Return-Path: <linux-kernel+bounces-862316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9868ABF4FBF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E801E4F01E0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 07:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA34D280A5A;
	Tue, 21 Oct 2025 07:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZGmpJuog"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64887269AEE
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 07:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761032074; cv=none; b=i4ilN3IABr1cMGv84zRmcxLD4bbtmUAho8ftQPEMF1UOIaGIKLgAwt0IRQyc33ir4VCtfD9t/0oybPvn8Ui5+1ppO6j44VF9q++vGZxvFEIKTjMaqTh/Fs7MokWzADETdshx1pYUyBcMZJLk9ZciGg1qBncCtsfSWWTiz0vaFxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761032074; c=relaxed/simple;
	bh=Vvzttjl7tjT80pVkw2Q3B38I9Z2O/vYbEAO91Ciss1E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uHf9j0K7T5bEnwWIDf4A1/qYd114+g21futlc3h2YBYEdCr5OgIOXfo0g3m2dpFCQkOGg2Pj/ClBmAITk3u5pI70jT8JIV/KO/r1uI/sg1R/XIsvnaXB1kk4R+m8o+V0DGt53AkouS5QD5rhXa6LOVXRW0UQ7aiv5BgSUkNFbzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZGmpJuog; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 7686BC0B885;
	Tue, 21 Oct 2025 07:34:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1CC1A606DC;
	Tue, 21 Oct 2025 07:34:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 402C5102F23EB;
	Tue, 21 Oct 2025 09:34:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761032067; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=k8izWHbKqzUmMmmsOINNCS8K5Jl2Km69X2C2UUxs0cg=;
	b=ZGmpJuogJrl8d9hqJ14Da08yy4HUxuO2dbr85y1EEu7gyS6qJ3TJJasWI7GJ2F/1UG4YlP
	BnNz0nC1iZ7tyS0weufg11hOWdu0WV9Q+APgCPU8zTPd/SmIGvDbPkeAujbLb5QNPud+F5
	fyWh8O3C+Dp7Ic8ZFatjSxxovCCAzSlP/fncP0kHu0Wuxm6B42uAjSdoAlOqGJh2U3ZQsc
	JAALIU/etH8jVqPmB45g5i82QrAz6ktvRSDYHRXsm0i3GA4bujNZvCrH8ANlIAJmgrHgyA
	Da48R0IGjFrYHsxOHyVDir1Ct5dQoEti4CendgvBVrKCbWHrtrEub2RiH3MJ2w==
From: Herve Codina <herve.codina@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 0/3] Add support for the Leadtek LTK028QV25BYL display panel
Date: Tue, 21 Oct 2025 09:34:02 +0200
Message-ID: <20251021073408.195959-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

The Leadtek LTK08QV25BYL is a 2.8" 240x320 DSI display.

This series adds support for this device.

Best regards,
Hervé

Herve Codina (3):
  dt-bindings: display: panel: Add the Leadtek LTK08QV25BYL panel
  drm/panel: Add support for the Leadtek LTK08QV25BYL panel
  MAINTAINERS: Add the Leadtek LTK028QV25BYL panel driver entry

 .../display/panel/leadtek,ltk028qv25byl.yaml  |  55 ++++
 MAINTAINERS                                   |   7 +
 drivers/gpu/drm/panel/Kconfig                 |  12 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 .../drm/panel/panel-leadtek-ltk028qv25byl.c   | 304 ++++++++++++++++++
 5 files changed, 379 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/leadtek,ltk028qv25byl.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-leadtek-ltk028qv25byl.c

-- 
2.51.0


