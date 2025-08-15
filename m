Return-Path: <linux-kernel+bounces-770119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6DB5B276FA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 05:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A8503B82E7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 03:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D982BEC2B;
	Fri, 15 Aug 2025 03:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ku8606TQ"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8982BD036;
	Fri, 15 Aug 2025 03:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755229280; cv=none; b=dlonNBLN262UamCGNE/j/i/oWBS6PcBtdKZw/ULZ8AOleRVlwGThc3/EylGqShdlTe+JnBT/lifqFRgMFlTaNBIB6n7yocO2V2zyV7wV/XhxavlEmeP29HFpeH4pcR6qwNyMPierrKQZdzV0pcgOuUDZDOUmM3o1Ymr8KcGWMcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755229280; c=relaxed/simple;
	bh=+KU6s7tl9gT9+nYznVg/VenN8mmXVQnVYfq1Z4LTC6U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E8yhwJ83mMY1CzWecbjttN5YYtIsIVmTXeAiAMrTj/WfrYCwp1wBdD/ODk/qme/8bgL0pA0hK2Tcd+OybxvSELvSiMEZbGNqq2EY3mtXH7AaYBghIZMXF0u//kvxFyaJp5hTO/+VGD3E8XJ9SPHOSQTNPN0ERqlpD4XtylbNAnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ku8606TQ; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57F3f9Oh2020870;
	Thu, 14 Aug 2025 22:41:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755229269;
	bh=LO5HxuXALDqfyHHXLVDosjnwOK7dNZOgW400xHdjvXo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=ku8606TQsSHeM/ASzK58n3kNtEq8eQ0Lq3qyRkbh5JrTfCUcV0OJ6fUpvObvZocVo
	 Z1aa2Kn2t8AEGDnRZp/+i5MAU5eDAyrnUwOdrEaDiS36XJLHHP1AHH43diCyk9GHzS
	 CfcE8VHc4dyyhdUeIDQBzlwlXbSvyXF3AyQzc9bc=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57F3f8wL1320963
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 14 Aug 2025 22:41:09 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 14
 Aug 2025 22:41:08 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 14 Aug 2025 22:41:08 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57F3f8Pl727654;
	Thu, 14 Aug 2025 22:41:08 -0500
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
        <tomi.valkeinen@ideasonboard.com>, <devarsht@ti.com>,
        Nishanth Menon
	<nm@ti.com>
Subject: [PATCH V3 2/4] drm/bridge: it66121: Drop ftrace like dev_dbg() prints
Date: Thu, 14 Aug 2025 22:41:03 -0500
Message-ID: <20250815034105.1276548-3-nm@ti.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250815034105.1276548-1-nm@ti.com>
References: <20250815034105.1276548-1-nm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Drop the ftrace like dev_dbg() that checkpatch --strict complains about:

WARNING: Unnecessary ftrace-like logging - prefer using ftrace
+	dev_dbg(dev, "%s\n", __func__);

WARNING: Unnecessary ftrace-like logging - prefer using ftrace
+	dev_dbg(dev, "%s\n", __func__);

WARNING: Unnecessary ftrace-like logging - prefer using ftrace
+	dev_dbg(dev, "%s\n", __func__);

Signed-off-by: Nishanth Menon <nm@ti.com>
---
Changes in V3:
* New patch

 drivers/gpu/drm/bridge/ite-it66121.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
index aa7b1dcc5d70..9b8ed2fae2f4 100644
--- a/drivers/gpu/drm/bridge/ite-it66121.c
+++ b/drivers/gpu/drm/bridge/ite-it66121.c
@@ -1384,8 +1384,6 @@ static int it66121_audio_startup(struct device *dev, void *data)
 	int ret;
 	struct it66121_ctx *ctx = dev_get_drvdata(dev);
 
-	dev_dbg(dev, "%s\n", __func__);
-
 	mutex_lock(&ctx->lock);
 	ret = it661221_audio_output_enable(ctx, true);
 	if (ret)
@@ -1401,8 +1399,6 @@ static void it66121_audio_shutdown(struct device *dev, void *data)
 	int ret;
 	struct it66121_ctx *ctx = dev_get_drvdata(dev);
 
-	dev_dbg(dev, "%s\n", __func__);
-
 	mutex_lock(&ctx->lock);
 	ret = it661221_audio_output_enable(ctx, false);
 	if (ret)
@@ -1479,8 +1475,6 @@ static int it66121_audio_codec_init(struct it66121_ctx *ctx, struct device *dev)
 		.no_capture_mute = 1,
 	};
 
-	dev_dbg(dev, "%s\n", __func__);
-
 	if (!of_property_present(dev->of_node, "#sound-dai-cells")) {
 		dev_info(dev, "No \"#sound-dai-cells\", no audio\n");
 		return 0;
-- 
2.47.0


