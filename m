Return-Path: <linux-kernel+bounces-744336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A3BB10B30
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 15:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2B5D3AC3D9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 13:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2599F264F9C;
	Thu, 24 Jul 2025 13:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQSIPIgy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E5E4400
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 13:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753363014; cv=none; b=Sf6SpesfhYXTqn6fYep/4WAoaC4pooyerb5SHmk3SOq9rd1E20cas9Z2KWaedgJ/KGpqXAJipLlQ8G6mamHYT6N8wiK39Dg6h/5alsneS/jW7d/TmCkPGHZFFb74DrHIo1xd3rTbxTQZGVeAXFLxRvIS25wTl66PjG8PTYQjSwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753363014; c=relaxed/simple;
	bh=Ufb4I9b7UbOJb/LBEgBQ4eDXX/Lr+n8V8X82kt0qXmI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=up5Z04EY2eEIVRPzmJyajW9T/KYr/mxZkbNJ+QCLeRyOD6Dk6hYCgQ7Meb6pBtvwoyTh1rWFSC4OroAZ7LbD0+FTsS6ltX2akA4cCgLvyg/mz9XtJ3byxeAmRLEbUUvZK5PY95QtI7Mz8Oe5P7+D0XLs9RaId7wKUnYtDSPUmEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQSIPIgy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35BCEC4CEED;
	Thu, 24 Jul 2025 13:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753363014;
	bh=Ufb4I9b7UbOJb/LBEgBQ4eDXX/Lr+n8V8X82kt0qXmI=;
	h=From:To:Cc:Subject:Date:From;
	b=hQSIPIgy/xA0yrHq2ilpQJniwFRpmjynlGvKCgYvPL7Ijumr4oFgdF4hEfIGZQqWB
	 sFQKL+8hU7mlQ9yJTK36jLq+ZeFtr7zY/gO1appgWFUbYc3JovCklufsrA22syupeU
	 8BzbhUvdryV7IwU6KZ1GEwcUBA7/ytMU5LKzelcTAEO8JyC8hFJXq/DogZDaOdEIXG
	 w5p0x+mGPD9dkENKCQoXs9kPaXa6ILWnnc9sQCpFD3h5kiC6VQzN4sQiDT0rHwrGLQ
	 Y4vD3LEbCNmE+GzVyg31TzCpyiDRbCMKDM/rQenA5KUVBk51aiG556axy4X+OKDasj
	 9QhpOEajWkI6A==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1uevoX-000000000hf-368V;
	Thu, 24 Jul 2025 15:16:49 +0200
From: Johan Hovold <johan@kernel.org>
To: Vinod Koul <vkoul@kernel.org>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH] phy: ti: omap-usb2: enable compile testing
Date: Thu, 24 Jul 2025 15:16:23 +0200
Message-ID: <20250724131623.2662-1-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Nothing seems to prevent the driver from being built on non-TI platforms
so enable compile testing for wider build coverage.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/phy/ti/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/ti/Kconfig b/drivers/phy/ti/Kconfig
index b905902d5750..b40f28019131 100644
--- a/drivers/phy/ti/Kconfig
+++ b/drivers/phy/ti/Kconfig
@@ -62,7 +62,7 @@ config OMAP_CONTROL_PHY
 
 config OMAP_USB2
 	tristate "OMAP USB2 PHY Driver"
-	depends on ARCH_OMAP2PLUS || ARCH_K3
+	depends on ARCH_OMAP2PLUS || ARCH_K3 || COMPILE_TEST
 	depends on USB_SUPPORT
 	select GENERIC_PHY
 	select USB_PHY
-- 
2.49.1


