Return-Path: <linux-kernel+bounces-875621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B508CC19727
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C100C466E39
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7305C3321C6;
	Wed, 29 Oct 2025 09:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AnPzfyrn"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90473321A6;
	Wed, 29 Oct 2025 09:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761730781; cv=none; b=epeak2rK1M3/8kUZ7ASbmrjGX74zH3JoNR2c4dopiFgydtgkfGLfrBCxmuGKIcVRqNb7UjQrUKCY+lLU732ALbzpHHZerkMwqnhKss291wsxGIKBNJb091z/LkTYaXmdXNIswyDBgMR2U5bhbFjlTD/ViCfXVARAjQKxfnPfiik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761730781; c=relaxed/simple;
	bh=IVDScBKmFFaCLSQrllzQaCmJgM4AfNhIPlPvVyFW2yM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c9jP+kTZAhvzJB0wT0EflXS1iULvhEnr42KJnvhrEU2uA9O3eIy1BTfosK/QTsMgIjV432gFuUpyIa7PytHKFxKisB1OQotf7nBlsoB0Pxh4lJ8jIq5ClObN+WsUY1vKcreDuJKsUsLcz20DqHqSct8eaTCvuv4KL4RnQQG80tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AnPzfyrn; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 4AC551A1730;
	Wed, 29 Oct 2025 09:39:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 215C0606E8;
	Wed, 29 Oct 2025 09:39:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1C514117F19DC;
	Wed, 29 Oct 2025 10:39:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761730777; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=LcbzbbFlItjrhGLz15qb3R8NFa0q0DWjO/2UGxU62ww=;
	b=AnPzfyrnVBgV0R7LaWb+IPN73q/msOqJwyeCtr9uhqnaIBMYxeF4Cd+y3cVxrH0t9IeScX
	2GakTgMLe+zy0QFWuBjNyNV6ZZzOmSdpz8x7TXo/xfxuse+y0JITlMRb9w4LAPK2CYjFuh
	YrIITgAKsjDV3ks9h5xI8vqm4YiHDqfpKNQ/UDb4XkFlea9aRNcsdMWFoZLaMYFzfKaOIe
	30PO3JYx47S0duhEDAvRVEsUOoNb+YeotSL01Pq6yAE8wF7hso6uBprArw2W1xuExB5zeP
	6L0WmMaRKiVUkrLh+t63Dywb7IWrrv0+gZTIuvXZ8YkVrda7TaDqqk9AUBSKxA==
From: Herve Codina <herve.codina@bootlin.com>
To: David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Nikita Shubin <nikita.shubin@maquefel.me>,
	Axel Lin <axel.lin@ingics.com>,
	Brian Austin <brian.austin@cirrus.com>
Cc: linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 3/4] ASoC: dt-bindings: cirrus,cs4271: Document mclk clock
Date: Wed, 29 Oct 2025 10:39:19 +0100
Message-ID: <20251029093921.624088-4-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029093921.624088-1-herve.codina@bootlin.com>
References: <20251029093921.624088-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The Cirrus CS4271 codec can use an external clock as an input Master
Clock. When no crystal is used, the CS4271 component considers its MCLK
pin as an input pin and expects the external clock connected to provide
the Master Clock.

This clock is not documented in the binding.

Add the missing clock.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/sound/cirrus,cs4271.yaml       | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/cirrus,cs4271.yaml b/Documentation/devicetree/bindings/sound/cirrus,cs4271.yaml
index 68fbf5cc208f..d286eb169915 100644
--- a/Documentation/devicetree/bindings/sound/cirrus,cs4271.yaml
+++ b/Documentation/devicetree/bindings/sound/cirrus,cs4271.yaml
@@ -25,6 +25,16 @@ properties:
   reg:
     maxItems: 1
 
+  clocks:
+    items:
+      - description:
+          Master clock connected to the MCLK pin if MCLK is an input (i.e. no
+          crystal used).
+
+  clock-names:
+    items:
+      - const: mclk
+
   spi-cpha: true
 
   spi-cpol: true
-- 
2.51.0


