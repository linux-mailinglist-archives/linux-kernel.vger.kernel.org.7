Return-Path: <linux-kernel+bounces-788826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C09B38ACE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 22:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2CDA7C6A30
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 20:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7553D2F0692;
	Wed, 27 Aug 2025 20:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vwvuU6hk"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360C81DE4CA;
	Wed, 27 Aug 2025 20:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756326249; cv=none; b=fGoVt+XY8VzsK6urslpkJhZ3motDT38sELh4Btmq4S/Wx1Vcrr2I8QF3x4x1ONR5xaWG8OBnim9pnO8ZnU3gxYM+fW7ctHQLpDt91hhTAxlQiThrm87xeLXDq5iKh+0WLGPj2/1gQiUdpVa/VK5r9YnJ99hPIvwN7nK1St8B1qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756326249; c=relaxed/simple;
	bh=JNKkgtl3Oq7m+WMuKwi3qp03Go2xVgJ00nFgbtqWNXw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fnMNOTP+7Iu0fazq7oIc2LzgHXaBB7hPCpaX0ebQY7IphLAgibv830T1o0b5/Ixaa6ZZsK2xx9xDEGjM63xJEBihX0QuZ4NtsvmWCzmk8ZXzQNKuY5PHodt/agoLVJNv6M+O3UR65pupPlc4ZQwnaj7+sdh8G3WcPojsB3VkpTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=vwvuU6hk; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57RKNvl81825101;
	Wed, 27 Aug 2025 15:23:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756326237;
	bh=n21umJ49TC+htP1odhxAT26FoC5frxXZhZvqEYwIH48=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=vwvuU6hkHzDTacwnVr9XLAHXeE7ilVhxRmdcp+qVl8isYlFEYSiWyPY5RsdQAUsPh
	 JjmxWNmkK2OQUZRnRGWMtgocBjDMIrJ+O36ibZ1t3DVro57CpPgNvet9uaIOXhfPuc
	 5wIp9FZOsYAnVqU+RO01HLIPnz4ChWGJweN1fl/U=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57RKNvJb2950685
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 27 Aug 2025 15:23:57 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 27
 Aug 2025 15:23:57 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 27 Aug 2025 15:23:56 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57RKNvVA3367091;
	Wed, 27 Aug 2025 15:23:57 -0500
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
        <dmitry.baryshkov@oss.qualcomm.com>, Nishanth Menon <nm@ti.com>
Subject: [PATCH V5 3/5] drm/bridge: it66121: Sort the compatibles
Date: Wed, 27 Aug 2025 15:23:52 -0500
Message-ID: <20250827202354.2017972-4-nm@ti.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250827202354.2017972-1-nm@ti.com>
References: <20250827202354.2017972-1-nm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Keep the compatibles sorted alpha-numerically.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
Changes since V4:
None

V4: https://lore.kernel.org/all/20250819130807.3322536-4-nm@ti.com/

 drivers/gpu/drm/bridge/ite-it66121.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
index 9b8ed2fae2f4..cd74f3966560 100644
--- a/drivers/gpu/drm/bridge/ite-it66121.c
+++ b/drivers/gpu/drm/bridge/ite-it66121.c
@@ -1619,15 +1619,15 @@ static const struct it66121_chip_info it6610_chip_info = {
 };
 
 static const struct of_device_id it66121_dt_match[] = {
-	{ .compatible = "ite,it66121", &it66121_chip_info },
 	{ .compatible = "ite,it6610", &it6610_chip_info },
+	{ .compatible = "ite,it66121", &it66121_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, it66121_dt_match);
 
 static const struct i2c_device_id it66121_id[] = {
-	{ "it66121", (kernel_ulong_t) &it66121_chip_info },
-	{ "it6610", (kernel_ulong_t) &it6610_chip_info },
+	{ "it6610", (kernel_ulong_t)&it6610_chip_info },
+	{ "it66121", (kernel_ulong_t)&it66121_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, it66121_id);
-- 
2.47.0


