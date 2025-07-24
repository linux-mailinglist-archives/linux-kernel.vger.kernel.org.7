Return-Path: <linux-kernel+bounces-744601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8823CB10F18
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 17:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40F9A541CBC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 15:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CB62EACF4;
	Thu, 24 Jul 2025 15:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="atcrX1Ge"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22D72EA491
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 15:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753372125; cv=none; b=jMs3LJ3thmEkFlVxRz0E3RhJ/Ex7rDJAzW8FPWB+zCYMqsKYXfitjZSSxFvOY6F6yu91TiTCJRfMGsDxo2Hl1v+qvWm2fX6KncTVd7NU2ScAfLZsjQl++IUkZJyhjovwJFT5nFrrv9CRBadxxmSTBSiFK1YIKgf+z+oS/JpW3zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753372125; c=relaxed/simple;
	bh=Bq2r2hveffpY5PXSTNXKCnxw/gMsdsoG6aIVMHQlAIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QIaB2bFUCQVrX22xPzSdvcwb9ofxKVGjXMD/2Yo71Fi7mKYs1wihBqEpfv41n938J8pdEj70hmxKofx8r39roGdpFlY/BvDt1yJI+G585Nd6RtFbV3cAV+z/ZMjeZZGhvJ6ea8eWof3kk8zPpyl+joyVuBlOMYPD7BE3lDu603Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=atcrX1Ge; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABC13C4CEF7;
	Thu, 24 Jul 2025 15:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753372124;
	bh=Bq2r2hveffpY5PXSTNXKCnxw/gMsdsoG6aIVMHQlAIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=atcrX1Ger+zMzUxQK50yM1K74N5XcrTpJG2sCS5I6msMeyQfCKeL3T9bKFZ9NlhPp
	 kaSbUts6BbI4Bsfvlcpu4UVcD1E/Qs6FCxWfgd83TkaTSr9S0BFQylVaoAlqvQZCAE
	 pmdNM+zQChjGYOnyblFt+G5LsQcgWeg84aHlD+XnUQnmTFOaj00ijusqvEO8QQ4RJS
	 b/fAoiqOlapRLaUjwRGnuG/ysbIYK8YLnQdgVeX1wRHkLwtOE6JqUMy8i++/xssy0j
	 qk+lLjEFcyaI2EvFaoXDu3yRjp5dFycy+BHY+zAFDzgoaDMVaqyXGk1OnsVviTMkZM
	 FAX2p4qXbT4yQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1ueyBU-000000004Ay-1gdX;
	Thu, 24 Jul 2025 17:48:40 +0200
From: Johan Hovold <johan@kernel.org>
To: Vinod Koul <vkoul@kernel.org>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>,
	Justin Chen <justin.chen@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 02/11] phy: broadcom: brcm-usb: drop unused module alias
Date: Thu, 24 Jul 2025 17:48:14 +0200
Message-ID: <20250724154823.15998-3-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20250724154823.15998-1-johan@kernel.org>
References: <20250724154823.15998-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 9d5f51dcdb64 ("phy: usb: Add support for new Synopsys USB
controller on the 7211b0") the driver only supports OF probe so drop the
unused platform module alias.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/phy/broadcom/phy-brcm-usb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/phy/broadcom/phy-brcm-usb.c b/drivers/phy/broadcom/phy-brcm-usb.c
index 0666864c2f77..59d756a10d6c 100644
--- a/drivers/phy/broadcom/phy-brcm-usb.c
+++ b/drivers/phy/broadcom/phy-brcm-usb.c
@@ -691,7 +691,6 @@ static struct platform_driver brcm_usb_driver = {
 
 module_platform_driver(brcm_usb_driver);
 
-MODULE_ALIAS("platform:brcmstb-usb-phy");
 MODULE_AUTHOR("Al Cooper <acooper@broadcom.com>");
 MODULE_DESCRIPTION("BRCM USB PHY driver");
 MODULE_LICENSE("GPL v2");
-- 
2.49.1


