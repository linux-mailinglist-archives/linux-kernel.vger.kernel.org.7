Return-Path: <linux-kernel+bounces-862318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D98CBF4FC5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 01548351F2B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 07:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675B327FD71;
	Tue, 21 Oct 2025 07:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="f3czzneb"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC95B280338
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 07:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761032076; cv=none; b=Kixlqru5jYGKkTM6E3jnon4gtWtyesSMvY32MoH8nkTT2stFQLMf/P6sAHgRnd2GbDqge1nwXuIz9R5ObDp1U3faDgMUXnaJl9BqEBbW3COlsx+osoTjH09vBlL2YlY8RG4urKnIArniMphV9S459RtzHnIWLKe+ox+QVO2ga/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761032076; c=relaxed/simple;
	bh=YW0R0NtmnB+rkKsKUVxv3YRWaYftyMEbw1I/7DN4Uu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BoBd5PPhGfpTr+WaR6dYNyUgMMozuhaGcppDfEIQeSkBM+6YWK2IxdKuPhLWLn1kTFHy9Sr95+EioN/iZo8cVk3rYXWezy+W90jTjC8L+rYMTGDEJ18+jsXZE3akZdcbYzUut+RVTDooCmdTzvi5sfv56vfsyCYqzVlHnKwLD90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=f3czzneb; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 9BABFC0B888;
	Tue, 21 Oct 2025 07:34:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 438DD606DC;
	Tue, 21 Oct 2025 07:34:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3855D102F23EB;
	Tue, 21 Oct 2025 09:34:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761032072; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=PC1XUfSkoPiTXud5UN9nIFVCHobGYNyM/zT3+Sp+npI=;
	b=f3czzneb3UJgh9z21GwhRV9zsGQc+FNmc0MG4ULvwukt7duajd9c+w9XCI908HDpqt85zW
	tHwx/vcmq/QsTupk2+EL7PoTtfgJmsn7KzieuqVEnoYHcjFeawFoFwW30oJzTtKV8+eRcV
	Lk8BHa7YfAhR5vJyJ/wSwv81byM7goiB0Y7ZItbZClq8zX+VTwZjOFjaAQYvVAjxT2sEPn
	eOCB3rfGYrfDI84GOXWzJWmlVAqPsVLJN6pkqsp36zzqzflrTozuHeUSgRM3SUQABE78Fs
	HH7sJDk/LrKMAdeOW1tsmWN3sQhO0zm5+Y87aQkSV4GPfY7j8ndGJVrYNxWQmA==
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
Subject: [PATCH 3/3] MAINTAINERS: Add the Leadtek LTK028QV25BYL panel driver entry
Date: Tue, 21 Oct 2025 09:34:05 +0200
Message-ID: <20251021073408.195959-4-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021073408.195959-1-herve.codina@bootlin.com>
References: <20251021073408.195959-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

After contributing the driver, add myself as the maintainer for the
Leadtek LTK028QV25BYL panel driver.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 46126ce2f968..67c085cd1dae 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7811,6 +7811,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/display/panel/jadard,jd9365da-h3.yaml
 F:	drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
 
+DRM DRIVER FOR LEADTEK LTK028QV25BYL PANELS
+M:	Herve Codina <herve.codina@bootlin.com>
+S:	Maintained
+T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
+F:	Documentation/devicetree/bindings/display/panel/leadtek,ltk028qv25byl.yaml
+F:	drivers/gpu/drm/panel/panel-leadtek-ltk028qv25byl.c
+
 DRM DRIVER FOR LG SW43408 PANELS
 M:	Sumit Semwal <sumit.semwal@linaro.org>
 M:	Casey Connolly <casey.connolly@linaro.org>
-- 
2.51.0


