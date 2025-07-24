Return-Path: <linux-kernel+bounces-743825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1231CB103C0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 10:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D74A8AC0A0F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 08:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0283274FED;
	Thu, 24 Jul 2025 08:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="XcbR6SGG"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5345727144C;
	Thu, 24 Jul 2025 08:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753346354; cv=none; b=sajumKQG858+ZqaXZ0f6EM+1HhyuGu2/daltORHeD41hCgT1paUy8kmTT/ON9ijMzFP9f1jSMzs4ndZPcTEEmHYIAySm5lESEM5U4lyQ6vCu17lrs54g5CLIopyJhzeHMfUNGKitv7R9H1YcIwh0/G2utDHFK1sOf3pxHGQ0eEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753346354; c=relaxed/simple;
	bh=UpI8W9Kvq+tlAPwkA1q2e9J/sYFjFWemYloJYK9MbHw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TdxncRUYrLF8LWFimFDeLwo+TMp/f0MJT9f7oH5N7hDDT+JORDYfUjpZ2WqVcyIb3rdkk0RmkKwCYx3LmOcel4OoGYRhyKd0HbGzsEsq0+YvXaOBCsQ3s6+0+AT2ZIqojdzHdN6Lb+ojZTIdikL21cYRqeWA0BVW3PpCDAYBe3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=XcbR6SGG; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753346350;
	bh=UpI8W9Kvq+tlAPwkA1q2e9J/sYFjFWemYloJYK9MbHw=;
	h=From:To:Cc:Subject:Date:From;
	b=XcbR6SGGbV4KWfCGLnSjJiqjso3xW6s4zKFOBJLJYJys0FgUk9O0GeNN1IK9ArYwO
	 n27vGLPgYIJ5Qrt/s1MdbQK44wLaOIJtVbGVIOXvX4aeedd5Y6A1bIrW1dy64WOQnW
	 yOhzmaGt+qkEMf/JfjnjwD/snGiDCl2HraVglvCOvx0V1GcHLTD5Migzu8wjZgJTlK
	 SAcBjEpHZPlg+z8GEb6TDHGX+1pVcNOyLURiWyfBMwJjoPGFEP9Bby6DLzlFpDGFuJ
	 cBl2YOhbdpNkq3d4MPoDLfiYOuRPo69UPi3d8nYNh+q34G49dmkj0E+wo2gnngHSuO
	 qifcyID/BWowg==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A8F8117E1062;
	Thu, 24 Jul 2025 10:39:09 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: robh@kernel.org
Cc: krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	geert+renesas@glider.be,
	u.kleine-koenig@baylibre.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-clk@vger.kernel.org,
	kernel@collabora.com
Subject: [PATCH 1/3] dt-bindings: clock: mt7622: Add AFE_MRGIF clock
Date: Thu, 24 Jul 2025 10:39:05 +0200
Message-ID: <20250724083907.61313-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the missing AFE Merge Interface clock to MT7622 to make use of
it in the audio subsystem.

While at it, also remove the useless CLK_AUDIO_NR_CLK definition.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 include/dt-bindings/clock/mt7622-clk.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/dt-bindings/clock/mt7622-clk.h b/include/dt-bindings/clock/mt7622-clk.h
index c12e7eab0788..a173eb132892 100644
--- a/include/dt-bindings/clock/mt7622-clk.h
+++ b/include/dt-bindings/clock/mt7622-clk.h
@@ -228,7 +228,7 @@
 #define CLK_AUDIO_MEM_ASRC4		44
 #define CLK_AUDIO_MEM_ASRC5		45
 #define CLK_AUDIO_AFE_CONN		46
-#define CLK_AUDIO_NR_CLK		47
+#define CLK_AUDIO_AFE_MRGIF		47
 
 /* SSUSBSYS */
 
-- 
2.50.1


