Return-Path: <linux-kernel+bounces-744610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A816B10F22
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 17:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A7701895EA1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 15:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9376F2EAB6B;
	Thu, 24 Jul 2025 15:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hb/1MRBi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735D62EAB9F
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 15:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753372125; cv=none; b=c9W4DMYm/VAka82pNQIlLBn3v5qyDj4M5Zvh6QUsB0th2nWxZYA/rN9jQccVuYcmNdYeeM+rkkWET22HTMEuvaEmmjYMIpTit6Xcp21eeic5Bs01TfT1I2OpjaG53CRPiNR6ZqSHAtKptC3JQR3Dt7zQoUVpQ746q74CFGRNyiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753372125; c=relaxed/simple;
	bh=NiMKzSoVYLJjavdo8qXJq1+RdQstjWGNZ4ttCvs08NU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=usH3CtgoVC3OHiRckY3rrvS8x+l2Tnh3TQ6SezAsZ14B4I0pwuBsPq1/TGCLpHr2FBkrx05gYCqE+iEiUuLoLk2uD6lk/w1DwFquAIx10WUhxMmzACct6SeC4R2LeGMKTF/aYEDYUZtDibjRKp7w3oL9TP1xkv7ngdSwDQN7vNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hb/1MRBi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 145AAC4CEFA;
	Thu, 24 Jul 2025 15:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753372125;
	bh=NiMKzSoVYLJjavdo8qXJq1+RdQstjWGNZ4ttCvs08NU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hb/1MRBiTLFVqTJXS4nqgzkxQHXUaPhvZv8H/RzfHV0OcbodCIXXsfmx+t4lXRWBK
	 +cx5EdCdPCIyZo9dXLLHQ3zZ4YQaPJS0ruAJTwbRFYC2PFuIdiGoEcpaz3JI0C36dd
	 1Ar1CWOqJh2X6lHtVbS2aqOxONZiwrIvi1vuYAXYaGwLzKYdvYNkwWhOnt48zyCXQO
	 OVFwOP/79pBMmRTrZOAg6dqOgsT85zu7hmys3e63u6faPpgm5fhkNV9Pp5yVf29z6s
	 kKlmiE5hlWyRdC9/ozst5NhbZo/D7/MKaG61gapfgAzfO3gnEC8f+y1ORFyFKUr2y4
	 8aIf5c1Fd9kBg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1ueyBU-000000004BF-3qeJ;
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
Subject: [PATCH 08/11] phy: ti: omap-usb2: drop unused module alias
Date: Thu, 24 Jul 2025 17:48:20 +0200
Message-ID: <20250724154823.15998-9-johan@kernel.org>
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

Since commit 478b6c7436c2 ("usb: phy: omap-usb2: Don't use
omap_get_control_dev()") the driver only supports OF probe so drop the
unused platform module alias.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/phy/ti/phy-omap-usb2.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/phy/ti/phy-omap-usb2.c b/drivers/phy/ti/phy-omap-usb2.c
index c444bb2530ca..1eb252604441 100644
--- a/drivers/phy/ti/phy-omap-usb2.c
+++ b/drivers/phy/ti/phy-omap-usb2.c
@@ -533,7 +533,6 @@ static struct platform_driver omap_usb2_driver = {
 
 module_platform_driver(omap_usb2_driver);
 
-MODULE_ALIAS("platform:omap_usb2");
 MODULE_AUTHOR("Texas Instruments Inc.");
 MODULE_DESCRIPTION("OMAP USB2 phy driver");
 MODULE_LICENSE("GPL v2");
-- 
2.49.1


