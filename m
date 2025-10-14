Return-Path: <linux-kernel+bounces-851893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6A7BD78BE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 08:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DF93234E203
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 06:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49C42BEC45;
	Tue, 14 Oct 2025 06:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="aBKQvV9n"
Received: from mx-relay48-hz3.antispameurope.com (mx-relay48-hz3.antispameurope.com [94.100.134.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3172080C1
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 06:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=94.100.134.237
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760422425; cv=pass; b=ZJCLKiExWPKEh5jrYqagxFExS1yeYUiYBNpTNEDYa2o3w52A5jO4fweI4b0MM4xOc3K65AfRF6WMQCKnDDQ5V5QzcZdmKfnCvrQCerXqYF6ylB+o9G+D+z5SztQNG2NL3oqC04aPKk62XLtSx689JrVVi+LJpCG6wLtmabrqGfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760422425; c=relaxed/simple;
	bh=yFz4PdyqYJFhzQVEuFKOr6f/AIwY10aAgN3b8pVVr2I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bjSLcvoxIDr0JD2oC1g39+lmbo5HUKpPTd6TAFgI7WHTM61dh24Zlh8vL1HALgRPM2vaJlcTmnK2B9tyjKf1++b6xNxjTwFMb5JWhn8YOqhrrHrNfvfXhnudp8l8Qv1HQG3070su01sZYPSJNEdm4E3Fw6Dx4KT3D9b/FmSeYXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=aBKQvV9n; arc=pass smtp.client-ip=94.100.134.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate48-hz3.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com
 smtp.helo=hmail-p-smtp01-out03-hz1.hornetsecurity.com; dmarc=pass
 header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=PpsJpdZ6guT9xK7H6Qj9swfceklHrTMmKM0p/QOrK04=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1760422403;
 b=Tz5RdLbTueKt/vib1DbNZ8hjQvrQiUZjslExisijY8GYRshdBw+BTMF7eQ/C74j0zvYB6d/k
 FH3yD74HKH795TDUdLDppOUoukxVpxEnMEsuA8o2xi5+Tn1xzPdtGmxMgn/mSmVc02FYC2oUpVx
 L2ouNIayyyy9JHC0sTXoq/4BXEhbpwKhl6+W+bZuVCODUoOBMZhvHSf0oFNLHilVU/Iqf0uMiRA
 8QBFxMzkD5/Q9qWVhHAgXa1HCG8WESSqZHqxKe54GJnzRA9aqs551qZDeVW155+VfroxMzsS3DW
 CGqrcxJ01uX7JgtWq75Htc+ORldtHB+aZ/4PnjmcqMrqw==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1760422403;
 b=IpMMPaN7IkaLdj2sjio0DETEDmdoC+K5hLYQb/qIvcyW5yzez2sPFn4sDoz0Kna09UbB8RM4
 0UBYGeKiIczQoZQUJYu9NaPy16fbqohdvivsgoLY8enP3oyaicD+5eLws0KNi10HEzO2McfcZ6B
 8uJLFPfEy9OkN/pz97kZ97qkIgCMJjpunyJip2lypAp/lUeKkkvK/v5EuRIpZ5SnOvYzxiZU1P9
 h08Y6pHoRvjx7en8PhC7oFPkDB87bHNForUzVAICLTC4zgMyF+3SYb0WsWYfiVKoUkxqNiqhG2n
 78xXS6rL/dJSblCVTZ6CaWllU7zOSYWlGC5cPueThKqxw==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay48-hz3.antispameurope.com;
 Tue, 14 Oct 2025 08:13:23 +0200
Received: from steina-w.tq-net.de (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: alexander.stein@ew.tq-group.com)
	by hmail-p-smtp01-out03-hz1.hornetsecurity.com (Postfix) with ESMTPSA id C106CCC0E51;
	Tue, 14 Oct 2025 08:13:12 +0200 (CEST)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Lizhi Hou <lizhi.hou@amd.com>,
	Brian Xu <brian.xu@amd.com>,
	Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>,
	Vinod Koul <vkoul@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Max Zhen <max.zhen@amd.com>,
	Sonal Santan <sonal.santan@amd.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] dmaengine: xilinx: xdma: Fix regmap init error handling
Date: Tue, 14 Oct 2025 08:13:08 +0200
Message-ID: <20251014061309.283468-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-cloud-security-sender:alexander.stein@ew.tq-group.com
X-cloud-security-recipient:linux-kernel@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: alexander.stein@ew.tq-group.com
X-cloud-security-Mailarchivtype:outbound
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay48-hz3.antispameurope.com with 4cm3mn3JBlz1kP5x8
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest:76f8f5f97ba878a3b36a039ba441326e
X-cloud-security:scantime:2.082
DKIM-Signature: a=rsa-sha256;
 bh=PpsJpdZ6guT9xK7H6Qj9swfceklHrTMmKM0p/QOrK04=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1760422403; v=1;
 b=aBKQvV9nLtfJviPCpVJ4kVxon2fZhy64w78XF0C3pf5qP+rCl27PZOudGq6ZFoPc+0sjUcb9
 abCYURtJ8tJneedBz745/0uvXZxtIff4s7tN8yldlWYutwZyZOFzRUw2p+AZVbA6L+0PAI9nIO/
 JTLvM2czpeBX0tq522xHVnFTug7v5bIXDc8wuGNdwUSU9xw4oKF9NR1q3Yz9z5N5W0CSdrHtKqD
 pKXCHVII96SQQdiqZs+FCCuW0pxVON6+HoVoLWqWb2f9keY8kbJXfftwywbQ2eSbu0S4UkaDIsy
 D6eelTAqFLEJ0/PwEkmcgGEHpH26eomZSneXQo+intuOA==

devm_regmap_init_mmio returns an ERR_PTR() upon error, not NULL.
Fix the error check and also fix the error message. Use the error code
from ERR_PTR() instead of the wrong value in ret.

Fixes: 17ce252266c7 ("dmaengine: xilinx: xdma: Add xilinx xdma driver")
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 drivers/dma/xilinx/xdma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
index 3d9e92bbc9bb0..c5fe69b98f61d 100644
--- a/drivers/dma/xilinx/xdma.c
+++ b/drivers/dma/xilinx/xdma.c
@@ -1325,8 +1325,8 @@ static int xdma_probe(struct platform_device *pdev)
 
 	xdev->rmap = devm_regmap_init_mmio(&pdev->dev, reg_base,
 					   &xdma_regmap_config);
-	if (!xdev->rmap) {
-		xdma_err(xdev, "config regmap failed: %d", ret);
+	if (IS_ERR(xdev->rmap)) {
+		xdma_err(xdev, "config regmap failed: %pe", xdev->rmap);
 		goto failed;
 	}
 	INIT_LIST_HEAD(&xdev->dma_dev.channels);
-- 
2.43.0


