Return-Path: <linux-kernel+bounces-715972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70455AF804D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jul 2025 20:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68DF71CA2F8A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jul 2025 18:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881982F364B;
	Thu,  3 Jul 2025 18:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fbu0Pmtu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56E12F2C7B;
	Thu,  3 Jul 2025 18:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751567717; cv=none; b=U8xt2Q2lBS7aD4gNYMrXcZn62ui8XjvkCorWpVNmgzg1Xun4kVWDHKNis1cBblvhk68kPRF50yqHKDcB1aAokMj2zDyolMoXLryz3v57nVFVenMcsQqdmFQiTOv9H6OnbEffEs12dpP5q499sCFGXNgDMHthmDbmpbDVBqvOFJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751567717; c=relaxed/simple;
	bh=9jb2HLI9HrPZc5LhaUHkznBv5LXACEW22xeTnBLCoi0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FDOxhjKQYzf7NjldbI7edrsjlC0naNmNs7EIo6GCe7W95MhkHtvoOE8W8IJVxB7qM5gCbBVkAiYm+OYdCo1gJhKcM/xjXR48gKMFc9D5fYXRjHhFbb99HTuqvqvZP4Oi4wjago7/xAVXlqO2WefFHJAPQdDFQ1IAeTWwmRMfYl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fbu0Pmtu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88A50C4CEE3;
	Thu,  3 Jul 2025 18:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751567717;
	bh=9jb2HLI9HrPZc5LhaUHkznBv5LXACEW22xeTnBLCoi0=;
	h=From:To:Cc:Subject:Date:From;
	b=fbu0PmtuWC2GHVZSZNyBmOQD1mxvq6kYdXkW2FM1JSYB+I+vH9ljZS16YYVZIj2vD
	 aDL6ezVHjRe/XjOBeBR6NNZcT1fokxdggvz2MOCFomJS4wyk/soWy9H3ydAnxM8fzt
	 v9bXUvP3dMKjX2hdjfbRc7G3QWQtcTBDGn1KeLASvZobFtIRCRZq9TWxLsyYY6Dcma
	 MydtI83vGfDLFvj+Er9QgOncX+cHKdCZPzsTXu39CivQistF+pTPIU+Ml29OAuRg2h
	 mrCilhUS92/eDOLb7cyx7OuqTDlYFGtvefyTrhENHgJqMAzZ+hjNx8ScEd8OBMTdMH
	 qaCqoc6qmT1fA==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>,
	Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fbdev: simplefb: Use of_reserved_mem_region_to_resource() for "memory-region"
Date: Thu,  3 Jul 2025 13:35:13 -0500
Message-ID: <20250703183514.2074928-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the newly added of_reserved_mem_region_to_resource() function to
handle "memory-region" properties.

The error handling is a bit different. "memory-region" is optional, so
failed lookup is not an error. But then an error in
of_address_to_resource() is treated as an error. However, that
distinction is not really important. Either the region is available
and usable or it is not. So now, it is just
of_reserved_mem_region_to_resource() which is checked for an error.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/video/fbdev/simplefb.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/video/fbdev/simplefb.c b/drivers/video/fbdev/simplefb.c
index be95fcddce4c..1893815dc67f 100644
--- a/drivers/video/fbdev/simplefb.c
+++ b/drivers/video/fbdev/simplefb.c
@@ -21,9 +21,9 @@
 #include <linux/platform_device.h>
 #include <linux/clk.h>
 #include <linux/of.h>
-#include <linux/of_address.h>
 #include <linux/of_clk.h>
 #include <linux/of_platform.h>
+#include <linux/of_reserved_mem.h>
 #include <linux/parser.h>
 #include <linux/pm_domain.h>
 #include <linux/regulator/consumer.h>
@@ -134,7 +134,7 @@ struct simplefb_params {
 static int simplefb_parse_dt(struct platform_device *pdev,
 			   struct simplefb_params *params)
 {
-	struct device_node *np = pdev->dev.of_node, *mem;
+	struct device_node *np = pdev->dev.of_node;
 	int ret;
 	const char *format;
 	int i;
@@ -174,19 +174,10 @@ static int simplefb_parse_dt(struct platform_device *pdev,
 		return -EINVAL;
 	}
 
-	mem = of_parse_phandle(np, "memory-region", 0);
-	if (mem) {
-		ret = of_address_to_resource(mem, 0, &params->memory);
-		if (ret < 0) {
-			dev_err(&pdev->dev, "failed to parse memory-region\n");
-			of_node_put(mem);
-			return ret;
-		}
-
+	ret = of_reserved_mem_region_to_resource(np, 0, &params->memory);
+	if (!ret) {
 		if (of_property_present(np, "reg"))
 			dev_warn(&pdev->dev, "preferring \"memory-region\" over \"reg\" property\n");
-
-		of_node_put(mem);
 	} else {
 		memset(&params->memory, 0, sizeof(params->memory));
 	}
-- 
2.47.2


