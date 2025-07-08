Return-Path: <linux-kernel+bounces-721221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 802A6AFC645
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 10:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3298174372
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 08:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F338E2C08AB;
	Tue,  8 Jul 2025 08:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sNmt8Y22"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3992BEFE8;
	Tue,  8 Jul 2025 08:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751964870; cv=none; b=byexNOozPRwydFD1yowCQF+TLxaFiwFKEt5eUib3nIn+zrZeWnCzpezag51HDClWjQK8L9A28GwSFen+cVHotRa8whqaW/Jcq4MpLbz2wnErpQEelcGiETlANN+fBjYhblDveTaQic0wFN6u9n7NI9BnmA5gPMmHCtbttRT7xFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751964870; c=relaxed/simple;
	bh=XbuRMxQszhiv3xuk8dB4cUp9wbNNFGyDjDesNag3FoY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zcx+j6/RpUboNabaDPMhMuKrOwA4mKXd3Te+NZq90GMRNsqcAjsb4xmPnsGVFcvj7OXwUyPuvjb0PnEtTmG+O1vU4CiNlsVZReRQjyOi4YugSEI09COAwkehLr6gqgP2113rYC2dSTbVwsdIIgBqqeCVb8yNvDXoAFzmHZVpFrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sNmt8Y22; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED399C4CEF7;
	Tue,  8 Jul 2025 08:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751964870;
	bh=XbuRMxQszhiv3xuk8dB4cUp9wbNNFGyDjDesNag3FoY=;
	h=From:To:Cc:Subject:Date:From;
	b=sNmt8Y22MalcTjvlEaToG2T/BpQHFr6NsiTdBSEZilde6BMezpEMF4M1iEEo3A7fS
	 GDeQRi/btho+rh2I7wxKc6UJyNJ76tVfrZIAWdHIFmXg0Rc0uWFyLpE+QN8HYenzvf
	 mBhsZ2knKgH/YFqc9X2Qxq2InoqvmqxarAcrvlasweTaPHxaOyrv26TD129KSkrSgE
	 wXQ/QgqSEliAIYY1gNqx5kd+V2XWnMR4iUl2TM2uND1PqI2t1Ptdp94Stify3fEyHL
	 YtDv65wNGrQLwXJnXYbt82rawXGi8UiS6Gv6atnafbPxnI1MDK5hGU1Qbp+2uosqRc
	 YtAL+s45z7x8A==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1uZ45m-00000000450-0a1f;
	Tue, 08 Jul 2025 10:54:22 +0200
From: Johan Hovold <johan@kernel.org>
To: Pengyu Luo <mitltlatltl@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Bryan ODonoghue" <bryan.odonoghue@linaro.org>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH] platform: arm64: huawei-gaokun-ec: fix OF node leak
Date: Tue,  8 Jul 2025 10:53:58 +0200
Message-ID: <20250708085358.15657-1-johan@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to drop the OF node reference taken when creating the Gaokun
auxiliary devices when the devices are later released.

Fixes: 7636f090d02e ("platform: arm64: add Huawei Matebook E Go EC driver")
Cc: Pengyu Luo <mitltlatltl@gmail.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/platform/arm64/huawei-gaokun-ec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/platform/arm64/huawei-gaokun-ec.c b/drivers/platform/arm64/huawei-gaokun-ec.c
index 7e5aa7ca2403..7170f8eb76f7 100644
--- a/drivers/platform/arm64/huawei-gaokun-ec.c
+++ b/drivers/platform/arm64/huawei-gaokun-ec.c
@@ -662,6 +662,7 @@ static void gaokun_aux_release(struct device *dev)
 {
 	struct auxiliary_device *adev = to_auxiliary_dev(dev);
 
+	of_node_put(dev->of_node);
 	kfree(adev);
 }
 
@@ -693,6 +694,7 @@ static int gaokun_aux_init(struct device *parent, const char *name,
 
 	ret = auxiliary_device_init(adev);
 	if (ret) {
+		of_node_put(adev->dev.of_node);
 		kfree(adev);
 		return ret;
 	}
-- 
2.49.0


