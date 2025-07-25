Return-Path: <linux-kernel+bounces-745403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54191B1196B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 09:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D490AA3C94
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 07:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78EC22DA1F;
	Fri, 25 Jul 2025 07:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXXmRdsG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A8C41A8F
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 07:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753430111; cv=none; b=mpvcSzelVl7n8vXTN856DfhmaEzueCF8QE71oKPZpug3T5rRINVtYW6iiEvHY1exg+WSOzXtZFKw1H2X6MXjeUQDFjjCE5V1r1vCgSduu+finVG2qYIbH2SN1ngdUXpg3SmlTqeaz5GEgE1TF4DpLjf0ZH90t9W58hXsZsKLdeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753430111; c=relaxed/simple;
	bh=6sEXsOfdWVGGj5F39V0ZHf78vtaUbBB/yBw30lKrfGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=akC9TUzBk5wrNabLhlKctS+CxMLzjofxzlBlQTnaziS3d5GMYkTDTFpxcTVCfLalyUZhrK/YY9qmJKFouwdyWq933yrMmbrfigNRuKw0RiEIdzISW0Xu/J1rg8R8MmtLbHPCXpaaTDf9cSp/+jdpf1c9bMRxDaP48TOU5tbH76I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AXXmRdsG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7273C4CEE7;
	Fri, 25 Jul 2025 07:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753430111;
	bh=6sEXsOfdWVGGj5F39V0ZHf78vtaUbBB/yBw30lKrfGQ=;
	h=From:To:Cc:Subject:Date:From;
	b=AXXmRdsGFXGsAcJWxNS+Ix2SBpVmuMx71uOzSggGbg6p+hQVLmHz6+vyL+Ca8zUR+
	 DUD4mm+Mtsmgvm9d2a2/chBC2IsC0c6NnVlFoDSwydV6rVIu8Tm1WxLU+INggNVlEc
	 ooF9jAD1pp3d2xs0NpRaF1E6EpFiMJWDK6QJ43MwpYYQDVaw9LtJpON64+Yfp4p3Xp
	 TEJru9KiLFMjSAM1ppneXtOt1QgtSet+eFslHqpCEBQhdhYE1Yl+ozq24pKXOsZahR
	 8r8qAxGvr5AaQ7rgsaPXAyoblIaJyD3erZfTKhNWqyoanrnWYZEuy0FqkrCgJ5d4Pq
	 /TW/lpXwBBbZQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1ufDGk-000000002cy-3CzA;
	Fri, 25 Jul 2025 09:55:06 +0200
From: Johan Hovold <johan@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Carlo Caione <ccaione@baylibre.com>,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH] firmware: firmware: meson-sm: fix compile-test default
Date: Fri, 25 Jul 2025 09:54:29 +0200
Message-ID: <20250725075429.10056-1-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enabling compile testing should not enable every individual driver (we
have "allyesconfig" for that).

Fixes: 4a434abc40d2 ("firmware: meson-sm: enable build as module")
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/firmware/meson/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/meson/Kconfig b/drivers/firmware/meson/Kconfig
index f2fdd3756648..179f5d46d8dd 100644
--- a/drivers/firmware/meson/Kconfig
+++ b/drivers/firmware/meson/Kconfig
@@ -5,7 +5,7 @@
 config MESON_SM
 	tristate "Amlogic Secure Monitor driver"
 	depends on ARCH_MESON || COMPILE_TEST
-	default y
+	default ARCH_MESON
 	depends on ARM64_4K_PAGES
 	help
 	  Say y here to enable the Amlogic secure monitor driver
-- 
2.49.1


