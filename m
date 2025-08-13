Return-Path: <linux-kernel+bounces-767464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F78DB254A1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 22:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 126F94E2F37
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 20:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F241D2D0274;
	Wed, 13 Aug 2025 20:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="M0EFtFBG"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0EE2EB5A7;
	Wed, 13 Aug 2025 20:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755117683; cv=none; b=FDpgY7tOf5b3uvwvUGfQg6k+yPqAdYZN9aGE4NdGFuLWFf2vFG9K/97MThPZrOLgNsIbZFmIegXV+HqMOLGODf0Zn8qzIoqPeXiblDiNaNY4/5LMfAYBrE0d+oxfqFxF4+grzHvu++axMqhHIG0EGPHZGc/1/onOqp4/dl11new=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755117683; c=relaxed/simple;
	bh=mfeV0GjQVO5Iqal7RqhGXZMja8tOufh3RJ9GwxYFwm0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NUz81QsT53W/OK2UJcCcwEROLy/ff2e88dgAGzt8ZtxzwwmxzSAPzTxv26wxopfoQOxH5PhIxw3ZAY7z4Z491LeG32owVoHdNOH8fc23mgFwZtvlAoWjUi5HTwzO4+aqEBJvimeBtK4iiEMx9JKHL03Gx/xAAvsbiQGX/3s3rCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=M0EFtFBG; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57DKfAWI1779738;
	Wed, 13 Aug 2025 15:41:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755117670;
	bh=vFvShJKmb9MFgjZhNt/VbQnwnmM/LO1s48lIt5T65+U=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=M0EFtFBGuR/l7EG5+al4fp4bCx0a2yAkkkMpy4HRgAKCsOLQQNNtDXafCQTp3sUyw
	 PvSJkDzoPzf/DbhWXdS4Mxx6tHFrjRf3+sex4cSVIxGS8FQHQBfkjd7aLBgVoRle1U
	 8fwZNpAQYWfuvrbtCG/ek4BGzmVc5uSSUSZQuKZw=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57DKfA7v644855
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 13 Aug 2025 15:41:10 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 13
 Aug 2025 15:41:09 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 13 Aug 2025 15:41:09 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57DKf9TN2853526;
	Wed, 13 Aug 2025 15:41:09 -0500
From: Nishanth Menon <nm@ti.com>
To: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, David Airlie
	<airlied@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Laurent Pinchart
	<Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong
	<neil.armstrong@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        Robert Nelson <robertcnelson@gmail.com>,
        Jason Kridner <jkridner@beagleboard.org>, <afd@ti.com>,
        Nishanth Menon
	<nm@ti.com>
Subject: [PATCH V2 3/3] drm/bridge: it66121: Add it66122 support
Date: Wed, 13 Aug 2025 15:41:06 -0500
Message-ID: <20250813204106.580141-4-nm@ti.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250813204106.580141-1-nm@ti.com>
References: <20250813204106.580141-1-nm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

The IT66122 is a drop in replacement for the IT66122. The part is
register compatible with what we use of the IT66121. The only relevant
change being the PID is now 0x0622 vs 0x0612. Add this extra PID so
probe does not fail during the PID check with these new parts.

For new platforms that do explicitly use IT66122, they can use the
appropriate compatible as well.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
Changes since V1:
- I think this is a more pragmatic approach with both compatibles
  functional and the option of being able to split this up at a later
  point if required in driver.

NOTE: I still retain the checkpatch --strict warning as v1 here.

V1: https://lore.kernel.org/all/20250813190835.344563-3-nm@ti.com/

 drivers/gpu/drm/bridge/ite-it66121.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
index 208e118df0e2..dcbbf7578046 100644
--- a/drivers/gpu/drm/bridge/ite-it66121.c
+++ b/drivers/gpu/drm/bridge/ite-it66121.c
@@ -1625,6 +1625,7 @@ static const struct it66121_chip_info it66121_chip_info = {
 	.id = ID_IT66121,
 	.device_id = {
 		{.vid = 0x4954, .pid = 0x0612 },
+		{.vid = 0x4954, .pid = 0x0622 },
 		{ }
 	},
 };
@@ -1639,6 +1640,7 @@ static const struct it66121_chip_info it6610_chip_info = {
 
 static const struct of_device_id it66121_dt_match[] = {
 	{ .compatible = "ite,it66121", &it66121_chip_info },
+	{ .compatible = "ite,it66122", &it66121_chip_info },
 	{ .compatible = "ite,it6610", &it6610_chip_info },
 	{ }
 };
@@ -1646,6 +1648,7 @@ MODULE_DEVICE_TABLE(of, it66121_dt_match);
 
 static const struct i2c_device_id it66121_id[] = {
 	{ "it66121", (kernel_ulong_t) &it66121_chip_info },
+	{ "it66122", (kernel_ulong_t) &it66121_chip_info },
 	{ "it6610", (kernel_ulong_t) &it6610_chip_info },
 	{ }
 };
-- 
2.47.0


