Return-Path: <linux-kernel+bounces-728689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA99B02BE0
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 18:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA71D1C20ED8
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 16:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3870F287265;
	Sat, 12 Jul 2025 16:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="t/QCW3+O"
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3461A2BAF4
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 16:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752337071; cv=none; b=SygMFfmfDcY6Hd55idMuiiCFSRjXlAio0tYoJ88lg+V4RYBobKBBrbMhOpKFed+itm42hgdvFrVgdULRVavOPs1Qg1hW+eWSrgpczlj0nyH0y8amR3h7/4ziQRQxmLyDkSQChsA8RlXqJPXOmv7Zbjuku1jUUCt6lbEUYkm2wyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752337071; c=relaxed/simple;
	bh=skSChtEzeBlvdjOZrJD8k59Y8JnUnMGTVqOSqxe5eTA=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=UVZXVmc0+lXtFHsApRjU/liUnftKB/PUlrPwygOf1/ESvU/mAJZffPCIpdXQ9uA2ereMq0ssiinMgHIHPOT6cpQn/CJ9yrpTsM0nQjC6RgFtoziM3UFoZvzC/z9C6asaC6GHOJivIUrmxQxWbVE6JR8BS+5S0GtRlyfMtU1Gg7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=t/QCW3+O; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1752337058;
	bh=HB1hz+ricoDCLB7RNvWCnPHdSK4a0MIDQPyM96qZLrk=;
	h=From:To:Cc:Subject:Date;
	b=t/QCW3+O8aQr4Feqn1Imz53qKs0sCh5krBc2JXdXXPJRKQNUYV2viofvYJFkvGGjG
	 TdvT2rNDcW9PoJFNwNjw/QJRnGEH3nkSsyl+iF+r1+gIaQqJ4rE4vqZjNQMJvmxS0t
	 B01fokWlMA4yUzVZypIl5P/f+uLvCzdkpkAXGm8k=
Received: from KernelDevBox.byted.org ([115.190.40.10])
	by newxmesmtplogicsvrszc16-0.qq.com (NewEsmtp) with SMTP
	id 419B4E38; Sun, 13 Jul 2025 00:16:25 +0800
X-QQ-mid: xmsmtpt1752336985tmnmdg17y
Message-ID: <tencent_22664B08ACDCE35DE10E5546C2FB26B59605@qq.com>
X-QQ-XMAILINFO: M84Ob7gbJGBWc01xJ7vkYkFSoybpZ2krgmPfjVOYXJ91Ln8jjLUHzFW0alz+Oj
	 X2oy1OQm8f+cdzMidft6pl81ZjcmuCSuDXpQcWuPMfG2Pi2YWF62hfR0OiwNYK1f7e2gYmxXErba
	 OV7OBlODTowdCIiY16gYCTeGutRSKz75a2MSsjGe2GuEwNMeHPrJf6ijIQrbxB+qneOp9rPMFuDx
	 xcdRQx1RZe+Ekc740wBdVOhxVWHe0qBhGqDIsjPpjSOLzbCyBqxKMP3gtxLSDRLSbqH8I6/TFqCo
	 BWwrR/FKIVeOdAXRCzVNlpckbMWjW3TyePIoo+NeTLN4uFLh0LWzJPY9JihqVXqXozr8F3+kjqLQ
	 ZS8LqGw8tsRGY2c8bQgMsWCLd11LSKtu86Us787fVGi15F06adnHgjGoqyI1eHf3w1R+eqI4yZv9
	 oUHyhMrOvUE/YVSrRIhSD5kx0fXU/yhTjDHmCr3bv3GTgZP1xxt2pGWlzs1nFuubEX+XsdL35YWz
	 ArVv+QR8Jd4psGTurfjNH85xlAbGM94TSc/noMf++dyXNYkJG0uqEx0EhyhziY8IqW94DRAz9WLH
	 /9YhpQ08Zqff0uiR07UbAhSk0/7e/yhdSMx5bvn7FXO5N7lBpJ7d5CAnae6f8zSKfOQz8Tpn2bJp
	 ik268Hs2psc9pqOYzKvZ2KXDq0jW+LADhrBC3VcObXcynvpXJULaDGFvTSGplHjgmDW+TEmlKVRQ
	 2tyyasOsfVRwFBxTTav88lw4fARkWW7obuGmqd+ZXMXCqgDUOMcY+OVathhVzp6hZAjTqKqZnHPW
	 14P+87DYKbw8xD5xTDA/vqRsrX5AnyCh37RnTcaRVQL75pHe76/lK79rcxcaLVY2qFpUlDbvPrgP
	 eWImY5bNSZaiKsuvIglIVgaR9O9Cp5il0GBWmx+5SQd2wHSJfu+07Y59c/FSrT1QiAZ6k8z3Hcos
	 7EKs10ZOvXHhB8BD2Mqiwtx6e/WACgJ+PxuA6Wwx+51uX+WPJvwl/HXTt1dSBsVChhma/vFTg/Cg
	 MtibJS5w==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Zhang Shurong <zhang_shurong@foxmail.com>
To: sven@kernel.org
Cc: j@jannau.net,
	alyssa@rosenzweig.io,
	neal@gompa.dev,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Zhang Shurong <zhang_shurong@foxmail.com>
Subject: [PATCH] iommu/dart: add missing put_device() call in apple_dart_of_xlate
Date: Sun, 13 Jul 2025 00:16:24 +0800
X-OQ-MSGID: <20250712161624.1850171-1-zhang_shurong@foxmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The apple_dart_of_xlate() function obtains a platform device reference
via of_find_device_by_node() but doesn't release it with put_device().
This patch adds proper device reference handling to prevent memory
leaks.

Fixes: 46d1fb072e76 ("iommu/dart: Add DART iommu driver")
Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
---
 drivers/iommu/apple-dart.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index 190f28d76615..811bf5176568 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -796,8 +796,10 @@ static int apple_dart_of_xlate(struct device *dev,
 
 	if (!cfg) {
 		cfg = kzalloc(sizeof(*cfg), GFP_KERNEL);
-		if (!cfg)
+		if (!cfg)  {
+			put_device(&iommu_pdev->dev);
 			return -ENOMEM;
+		}
 		/* Will be ANDed with DART capabilities */
 		cfg->supports_bypass = true;
 	}
@@ -805,8 +807,10 @@ static int apple_dart_of_xlate(struct device *dev,
 
 	cfg_dart = cfg->stream_maps[0].dart;
 	if (cfg_dart) {
-		if (cfg_dart->pgsize != dart->pgsize)
+		if (cfg_dart->pgsize != dart->pgsize) {
+			put_device(&iommu_pdev->dev);
 			return -EINVAL;
+		}
 	}
 
 	cfg->supports_bypass &= dart->supports_bypass;
@@ -825,6 +829,8 @@ static int apple_dart_of_xlate(struct device *dev,
 		}
 	}
 
+
+	put_device(&iommu_pdev->dev);
 	return -EINVAL;
 }
 
-- 
2.39.5


