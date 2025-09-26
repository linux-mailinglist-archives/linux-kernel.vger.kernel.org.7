Return-Path: <linux-kernel+bounces-834229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3991BA438C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 16:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30D2B7BEE08
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 14:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E8D202C30;
	Fri, 26 Sep 2025 14:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HpusbPte"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88151199385;
	Fri, 26 Sep 2025 14:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758897107; cv=none; b=EQaqIdthTdZIVrxf1Wrk8n+yjHkziYdda4LoAScUjtdJ0kN1nQTeBTsxoNBirhVcXViGPO9UUNcRa490USinHDQC1vyI59B1BYzTjKJ2DU+pth/4MEM1Ta6dvD737RECchqwj4VRBsagDLyXQXOFVlMpBFZBifFmsbXg6xD4fJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758897107; c=relaxed/simple;
	bh=OQcO92jUkLnjsTNz9W4cXXplFNHIhPbu+0qASGU4+x4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C2rhYHc1bbL1X1tHzkP1HszIy7XCinLNiYJAGKTjaQamhEXjy7rvIb0nucfHbodlnixd+xF813Jsf8m4sCr2hYy6v0O6rHDfRf8ZVZX4Gmqt8v7WS6ndKtNSQ0vNnEnRy4b+Fw9hUOTzqVlXs0dTa3LJ5x4j7+Pu3cf+znH5RkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HpusbPte; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41CE4C4CEF7;
	Fri, 26 Sep 2025 14:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758897107;
	bh=OQcO92jUkLnjsTNz9W4cXXplFNHIhPbu+0qASGU4+x4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HpusbPtegyRF5tS8YuUiVvGWFIJicNUJq3x6YhZetZ8ptCOa3egk8fLAE2VL102VQ
	 Zn2/swzkDo6FqLgl+8S7IyWZSLZBnmCITWgV+ecTCFywWcOwF3nVuofmZzqSL8Cdk1
	 jvYYMeYsr1kV5/Zl+2JlEHCr86h+FtKPV0NDJN6FVUeHwFFTLbYm4ThxdCicV+6gnM
	 rvymrdAE80e7NzjGYL36F+NbIGnBM110cio8Fj2LVsXaD1hZvApbZxNPReajdFaJGt
	 6nbf8eLNni3vQZgSHla2j6PR0XD6OVbnBP2SnOntb6dMXIJ233GXdNkkI5CKtFSXeT
	 9kbaKPqTK7XxA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v29U4-000000001g4-3fXP;
	Fri, 26 Sep 2025 16:31:40 +0200
From: Johan Hovold <johan@kernel.org>
To: Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>
Cc: Neal Gompa <neal@gompa.dev>,
	asahi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 2/2] soc: apple: sart: drop device reference after lookup
Date: Fri, 26 Sep 2025 16:31:32 +0200
Message-ID: <20250926143132.6419-3-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20250926143132.6419-1-johan@kernel.org>
References: <20250926143132.6419-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Holding a reference to a device does not prevent its driver data from
going away so there is no point in keeping the reference after looking
up the sart device.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/soc/apple/sart.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/soc/apple/sart.c b/drivers/soc/apple/sart.c
index afa111736899..6952afc41308 100644
--- a/drivers/soc/apple/sart.c
+++ b/drivers/soc/apple/sart.c
@@ -164,17 +164,11 @@ static int apple_sart_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static void apple_sart_put_device(void *dev)
-{
-	put_device(dev);
-}
-
 struct apple_sart *devm_apple_sart_get(struct device *dev)
 {
 	struct device_node *sart_node;
 	struct platform_device *sart_pdev;
 	struct apple_sart *sart;
-	int ret;
 
 	sart_node = of_parse_phandle(dev->of_node, "apple,sart", 0);
 	if (!sart_node)
@@ -192,14 +186,11 @@ struct apple_sart *devm_apple_sart_get(struct device *dev)
 		return ERR_PTR(-EPROBE_DEFER);
 	}
 
-	ret = devm_add_action_or_reset(dev, apple_sart_put_device,
-				       &sart_pdev->dev);
-	if (ret)
-		return ERR_PTR(ret);
-
 	device_link_add(dev, &sart_pdev->dev,
 			DL_FLAG_PM_RUNTIME | DL_FLAG_AUTOREMOVE_SUPPLIER);
 
+	put_device(&sart_pdev->dev);
+
 	return sart;
 }
 EXPORT_SYMBOL_GPL(devm_apple_sart_get);
-- 
2.49.1


