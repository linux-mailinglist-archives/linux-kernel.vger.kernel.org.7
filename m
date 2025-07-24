Return-Path: <linux-kernel+bounces-744611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BE7B10F20
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 17:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32EA77BB7CE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 15:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B8E2EAB91;
	Thu, 24 Jul 2025 15:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sb4Z/RDZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B14F2EACEA
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 15:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753372125; cv=none; b=W06yRGnc2izWLOg4gyyPN1C3LaDmrAwS2jS4JbGyCHCpr+bkujeCXngvYrySvKJCBmui/VtVAGFOzO9pnLt4J0/VuYre14jexaDzdWmf6DcXdb9D362GPtu2EFb5hT8DdBEW0SwqfJKCGt6cSOTw/QT6vjPjcgy86dxBJ1DfIQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753372125; c=relaxed/simple;
	bh=I2v3Lw2r5yEjMULVac1C6vqKyPU+wNFZIWjH5WpdpCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CDIzgqt3kLk5BBkqZ2KfHQpjMsLevNb/Bl9NdloJOGPmhCdJ2kaUQA8g3F1D9ONCcEY0XeqH9WumPsWzqczMpD/bYdU/v71AaUD/MOKfBeDjPshFwuamJmm1h+OPJTTwoUkU0ZQf9HwubfApSCd3z2F5fH/+sIteqpLvlfVvgtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sb4Z/RDZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57DEDC4CEFC;
	Thu, 24 Jul 2025 15:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753372125;
	bh=I2v3Lw2r5yEjMULVac1C6vqKyPU+wNFZIWjH5WpdpCI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sb4Z/RDZ8VF6gbEmvAxAnPMC9W8guU1u+EzmO/+2JInBo1wnyaMoUbl1TgdRFMuoo
	 kB5rFJ9O2c7ZeSSO5Dj5TYOtGNPXzNdAzZ2XcOPJJ0pd5UxWaUhruip+kbvU7/qWMZ
	 P9qqsmYDZu8uaRtnpunjIh0xfEor+/scTO3P+27Zza/7xwnMlse9fpcie7beqtSlqj
	 MXm9bEpG+WJtDneS4qB5nnzlPyKskobP7xF5XbXRTeVQ50T+2uaYomnGqKolVy01ls
	 MGsFU2w6A4PJ6b8+CwXdK8CJOUkrnitViiIIF/1S1hDo+wkBxBYAvdiQJCNt1nCpsL
	 kooLEZZxbwetQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1ueyBV-000000004BO-0gnH;
	Thu, 24 Jul 2025 17:48:41 +0200
From: Johan Hovold <johan@kernel.org>
To: Vinod Koul <vkoul@kernel.org>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>,
	Justin Chen <justin.chen@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 11/11] phy: ti: omap-control: drop unused module alias
Date: Thu, 24 Jul 2025 17:48:23 +0200
Message-ID: <20250724154823.15998-12-johan@kernel.org>
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

Since commit 4fd06af96b93 ("usb: phy: omap-control: Get rid of platform
data") the driver only supports OF probe so drop the unused platform
module alias.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/phy/ti/phy-omap-control.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/phy/ti/phy-omap-control.c b/drivers/phy/ti/phy-omap-control.c
index 2fdb8f4241c7..4968434312f8 100644
--- a/drivers/phy/ti/phy-omap-control.c
+++ b/drivers/phy/ti/phy-omap-control.c
@@ -334,7 +334,6 @@ static void __exit omap_control_phy_exit(void)
 }
 module_exit(omap_control_phy_exit);
 
-MODULE_ALIAS("platform:omap_control_phy");
 MODULE_AUTHOR("Texas Instruments Inc.");
 MODULE_DESCRIPTION("OMAP Control Module PHY Driver");
 MODULE_LICENSE("GPL v2");
-- 
2.49.1


