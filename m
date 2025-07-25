Return-Path: <linux-kernel+bounces-745429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF78B119CB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 10:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 445B14E1E49
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 08:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7605B2BEC44;
	Fri, 25 Jul 2025 08:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Jd1J/teX"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E5E29E0F8;
	Fri, 25 Jul 2025 08:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753432071; cv=none; b=rhNW6ieHdYvNwTKOroq1T+AsB8Da6M0wcBgF84XBmS4lbnkIMFTKU6Q+ROSe+wFnT4pGOYSkwpQIK4ClnYWwJ7vWTLcGUxvMmYRuGbCNyNQyvaQR10QInkG7MPM7cj1LOIDfmvnCy2R3Xxt7tHAyFLaIIHo6DzcTusieBg7rHV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753432071; c=relaxed/simple;
	bh=49TVuvql4VEJqV6yyhUeh6whKEGAbSplCz2B+HfAFL8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LbkOkvW6DibHolqswWCo4T+vRIF9YTVFnuygqceVsc5nhe6Y8B5lKjxNfHWiXAo0/0qLvCcMs4iGoENjUCn1mZDDDVflKJeEmVHzgcAiXDRi6pVsmjgAJ9/8O/6Fer5Ld/6bB/4hwxV0RD67JRUxyn4YmA1lHLUlnXw9QLOmq9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Jd1J/teX; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753432063; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=VCY1yLiZqhG/kFflPmhcwhApQv/kjy2hf+dR2iCkQDg=;
	b=Jd1J/teXvvxTX0BaxI0Asgi9ZGD2Yk28NOhskSIa8vULxzaFiyZp4cuD6pVUscSPNAMhyhfoFiFNxr1nuWSyQcZVWp8S+1leLzspbujvsc4jvl9ePV1a5f63FSS1DsOKCAWKrSe+apApXVFT4DaNtIP+FXohy20FahIFC06HTzE=
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0WjwrjEy_1753432057 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 25 Jul 2025 16:27:43 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: mario.limonciello@amd.com
Cc: perry.yuan@amd.com,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] platform/x86: hfi: Remove unnecessary .owner for amd_hfi_driver
Date: Fri, 25 Jul 2025 16:27:35 +0800
Message-ID: <20250725082735.2005040-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove .owner field if calls are used which set it automatically.

./drivers/platform/x86/amd/hfi/hfi.c:512:3-8: No need to set .owner here. The core will do it.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=22940
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/platform/x86/amd/hfi/hfi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
index 4f56149b3774..b633363ebf70 100644
--- a/drivers/platform/x86/amd/hfi/hfi.c
+++ b/drivers/platform/x86/amd/hfi/hfi.c
@@ -509,7 +509,6 @@ static int amd_hfi_probe(struct platform_device *pdev)
 static struct platform_driver amd_hfi_driver = {
 	.driver = {
 		.name = AMD_HFI_DRIVER,
-		.owner = THIS_MODULE,
 		.pm = &amd_hfi_pm_ops,
 		.acpi_match_table = ACPI_PTR(amd_hfi_platform_match),
 	},
-- 
2.43.5


