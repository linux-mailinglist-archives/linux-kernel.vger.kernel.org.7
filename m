Return-Path: <linux-kernel+bounces-805039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C708B48354
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 06:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9E327A3547
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 04:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A38121D596;
	Mon,  8 Sep 2025 04:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kj+OdWpP"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A64D1B87F2
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 04:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757306650; cv=none; b=ncftQ2IYCdqpJSE8pxPRMX3MB9qvr0cIJYQCA825h4uy4j9TdDpTT1sUUEM8lF2MhtSkufs9D8gr96dI4+y7H1JT+sm4x/xwE9fQHyW8oTZtst/FJILr+YKGwWlGMH/DXApGFG07EQdFsGm939zrzYG6rRkQBMN5lR4UMY2p3Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757306650; c=relaxed/simple;
	bh=fiTshjH0OpRnli85QCvwaBeHrIw83h8O238HTJIpU/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mv3izt2lRYlbbrkerqKRh1SHOpj6MyxPyDhtZqSTmgTHDcI1t/YFLcs6M3QT6zFkoT730ApuLWCvAPQj7MLyNNx+3wMk57EfEa5H3hs6THht5LZvn67mxp7xgaOTsrFztSKd+QpmCfn7+zDJswNpNKH5rQYttCKoleCZDE9U8fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kj+OdWpP; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b4717543ed9so2551628a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 21:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757306649; x=1757911449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+xbE3C5wFV+o/JT6/YEPlxnk3f9fN47mPZGkai6aV5E=;
        b=kj+OdWpPMQfMU/ZxCqmlDMAvylFD4/v8g2G+wTC6Cc8IPYKPNKwJzylza/AZw1Oy1i
         iq9TdEEKk4vKd/sz52ns1IKEr9mtI4u61+E9i23JixvBkCPS8IYDcOICDfOte/0HyY4C
         SrTxh3JMo67Dw4GlcNEhfilcLr/lhYrjmeQ0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757306649; x=1757911449;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+xbE3C5wFV+o/JT6/YEPlxnk3f9fN47mPZGkai6aV5E=;
        b=SxMN+f0mJwrL9kG8JMSlG7zI9VH4KF3tXogKU/cN1jKpJk4533cZiWwpq3eyhJtgvp
         hDYwBRN0CfH3PUKU6+q0U+AYf4WqjqqLuK5fe2vg7vG77VKTykcFuwlsfhLy6idNdm8T
         hd7jyy0kIfbIyeytWgLMlrEw9T8NMmsG2GBZlyrexfOzYbDBRLzv1anu4y5gXcNTTz/O
         U62DRLwhXkmgaEud49V/GMZMLw+vfCwG4OdMDshTlx2TtZTzSjdG3ibiz1vQHFOzQpUO
         ZVVlr+4tdsP+BJtfO5KfwnSOK4D7JfRWT/o4mlb0F1Gg9kkAkEPih4BmXSM0me2rmOQW
         997A==
X-Forwarded-Encrypted: i=1; AJvYcCUj3vMMpR+jJWfC1H12fJdBhE4y0rBMSIaEXjtGj3wwMmdwa4aV5Lc7KzGJLQ5FPkLIxyeCRRECAhxwgUg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz895VqvFolblZ2+GIT5KvqwUfXNxMb2tvstNSvOEQ5+ZFbMjqE
	eNqbibnu45951Cu+Mn5ykAHuOw6KwjB0MnPFbAU3W0OJrIVwBEm0vFwmpnatAvYtEw==
X-Gm-Gg: ASbGncsa4/6x4X/Y7AexNno7lA2CkuYnx9KLiy5Q4YX96AjmU5IlxMkYtqjHIAXMy1l
	Ex0ndYmkYG9JnZjPsJ7atRHwq/4kpMFeNSm9josB4iGEqUu50lP29YhLwM9qniDMyI0vm+nQYgE
	6wKmEyCE5K0EjBD9fGfhgBoRfz0Pc1jVxiWBU5Q9W5kLDHeyxclrF9ce8mrFHr/Kam7bi4l+w0x
	HEGU+jdZNdgRlHjiKuEpj7PLi8t560j9OCzQcfyVtCVlrValVJJKiikjBcYUziZjQgCKY51zvvZ
	qTiqQVzIK1FTKG0zKfIqkyobF2LDLyD3kGmlwws+3S4bYCITEheYwEnc9H5pByoqPP7ysT/kJTD
	5sETMjznnC1gsdNeO3/bYiEwAuPF+355Te+hN/y52xYpDCLUb8tvt1C+tcURJ3vJKXtxOeYYTi7
	HRQnfultlvUWR3XsNDQp9jSRai
X-Google-Smtp-Source: AGHT+IF6EqSsNgeRlOG14nqU9rpBfRr7iTBMf+lspK57Oo06mCVbJuf9Ry2wvH4TilganydG5n2WLA==
X-Received: by 2002:a17:903:f8b:b0:24c:d342:7616 with SMTP id d9443c01a7336-25173118d31mr75029465ad.57.1757306648632;
        Sun, 07 Sep 2025 21:44:08 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2a00:79e0:201d:8:d9c6:a89:402f:11c7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24b1ba1718bsm153320605ad.39.2025.09.07.21.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 21:44:08 -0700 (PDT)
From: Fei Shao <fshao@chromium.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>
Cc: Fei Shao <fshao@chromium.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-remoteproc@vger.kernel.org
Subject: [PATCH] remoteproc: mediatek: Use for_each_available_child_of_node_scoped()
Date: Mon,  8 Sep 2025 12:43:25 +0800
Message-ID: <20250908044348.2402981-1-fshao@chromium.org>
X-Mailer: git-send-email 2.51.0.355.g5224444f11-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use scoped for_each_available_child_of_node_scoped() to remove manual
of_node_put() calls from early returns.

Signed-off-by: Fei Shao <fshao@chromium.org>
---

 drivers/remoteproc/mtk_scp.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
index 8206a1766481..b123698feb52 100644
--- a/drivers/remoteproc/mtk_scp.c
+++ b/drivers/remoteproc/mtk_scp.c
@@ -1234,7 +1234,6 @@ static int scp_add_multi_core(struct platform_device *pdev,
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev_of_node(dev);
 	struct platform_device *cpdev;
-	struct device_node *child;
 	struct list_head *scp_list = &scp_cluster->mtk_scp_list;
 	const struct mtk_scp_of_data **cluster_of_data;
 	struct mtk_scp *scp, *temp;
@@ -1243,11 +1242,10 @@ static int scp_add_multi_core(struct platform_device *pdev,
 
 	cluster_of_data = (const struct mtk_scp_of_data **)of_device_get_match_data(dev);
 
-	for_each_available_child_of_node(np, child) {
+	for_each_available_child_of_node_scoped(np, child) {
 		if (!cluster_of_data[core_id]) {
 			ret = -EINVAL;
 			dev_err(dev, "Not support core %d\n", core_id);
-			of_node_put(child);
 			goto init_fail;
 		}
 
@@ -1255,7 +1253,6 @@ static int scp_add_multi_core(struct platform_device *pdev,
 		if (!cpdev) {
 			ret = -ENODEV;
 			dev_err(dev, "Not found platform device for core %d\n", core_id);
-			of_node_put(child);
 			goto init_fail;
 		}
 
@@ -1264,14 +1261,12 @@ static int scp_add_multi_core(struct platform_device *pdev,
 		if (IS_ERR(scp)) {
 			ret = PTR_ERR(scp);
 			dev_err(dev, "Failed to initialize core %d rproc\n", core_id);
-			of_node_put(child);
 			goto init_fail;
 		}
 
 		ret = rproc_add(scp->rproc);
 		if (ret) {
 			dev_err(dev, "Failed to add rproc of core %d\n", core_id);
-			of_node_put(child);
 			scp_free(scp);
 			goto init_fail;
 		}
-- 
2.51.0.355.g5224444f11-goog


