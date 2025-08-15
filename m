Return-Path: <linux-kernel+bounces-770473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1510BB27B44
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 10:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DF6C1CC2C4C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 08:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC9A2D0C74;
	Fri, 15 Aug 2025 08:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IpWuSp5S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFD723A9BE;
	Fri, 15 Aug 2025 08:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755247062; cv=none; b=jI1IqGr9no4/T5sW+Bpg9YHFFGqXuDYfsYe5oQ6rmcpSsiYudQaMSMTlbzTNxH/hNhgOh5yJvHohYHezVqAxtvMoszaNM0kmplr5ZgRrqVdb2BHVcBFtF31znlvYyRr6uCU4N00nxlUwinQpwFoNvC2hqqo+rfxDbgD6+iY3tCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755247062; c=relaxed/simple;
	bh=qCUEoMcSiv4EArKcB1FLhUfsB2WEWl13SCaUpaPkLZI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hoZuFcfkbkrV9Ih/y9AZ1adWObqHBMllJscH5NBt9TkxRS2OFhjhECqe4v5g28sfyleNB5TKreGDQrm5JVhkrWKf7IZL2vTbMIPRi4r9M1j6Kc62uZ11WAWbRfXUimY/M4/w+/8FteAsgVS+BAvC4PEOqVDobmWj7MwXBcvrAfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IpWuSp5S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 75ED5C4CEFE;
	Fri, 15 Aug 2025 08:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755247061;
	bh=qCUEoMcSiv4EArKcB1FLhUfsB2WEWl13SCaUpaPkLZI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=IpWuSp5SoLQJe/9tIsFQHf0gmPvzBJRZL4k8Em73ETJV3LVsFPpr5m2/5O91ngKmX
	 QHZpmjsNQyFlsHQGTPzhRubSg9sUVuB1DxUNebOZlyjU4+t5NpmFkDVes7+HF7fZG1
	 ohvl00r9NRaobfsbXDSi0HGm4XVkaa7Ed8W+vWJD5K2eEEr/ufNqxTy+aQZvVVAAuk
	 8OzBgj0xFIuNGzQ0DQacQMubpnNVI2UJp0rQdBm2KFRRrhyRZvqnPxfZjVk50txNgK
	 n8qyF8AuDcKJfbEqhKsJPoSic3Fc7p6/tdhReHAKerVrwc77FukyFcpGzSuELa9rNx
	 k/dFZre/MYyoA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2C7CA0EE4;
	Fri, 15 Aug 2025 08:37:41 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Date: Fri, 15 Aug 2025 16:37:32 +0800
Subject: [PATCH 06/13] soc: amlogic: clk-measure: Unify the compatible
 property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-add-more-socs-to-support-clk_measure-v1-6-59f04ba67457@amlogic.com>
References: <20250815-add-more-socs-to-support-clk_measure-v1-0-59f04ba67457@amlogic.com>
In-Reply-To: <20250815-add-more-socs-to-support-clk_measure-v1-0-59f04ba67457@amlogic.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Chuan Liu <chuan.liu@amlogic.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755247057; l=1243;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=0eEPVOYjuBKHP/v29Jhs15ySgwAKkYRM0UAoAkVVptI=;
 b=w5p2xKfbh6z56WSYU5ZafMzFPC+EGumxKh+Ixvc4DqIg3NuGpxaEkMcSlMCGGj8XeqMlAmup6
 tvRqqTQbYEjD0o6iaUTAx+p1HW8LJoy1QBm9o9TPulukjmKQ89dnunU
X-Developer-Key: i=chuan.liu@amlogic.com; a=ed25519;
 pk=fnKDB+81SoWGKW2GJNFkKy/ULvsDmJZRGBE7pR5Xcpo=
X-Endpoint-Received: by B4 Relay for chuan.liu@amlogic.com/20240902 with
 auth_id=203
X-Original-From: Chuan Liu <chuan.liu@amlogic.com>
Reply-To: chuan.liu@amlogic.com

From: Chuan Liu <chuan.liu@amlogic.com>

The clk-measure IPs across Amlogic SoCs have minimal differences, so
they can be managed with a unified compatible property.

Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
---
 drivers/soc/amlogic/meson-clk-measure.c | 23 +----------------------
 1 file changed, 1 insertion(+), 22 deletions(-)

diff --git a/drivers/soc/amlogic/meson-clk-measure.c b/drivers/soc/amlogic/meson-clk-measure.c
index 4d91d463d2a5..6927f87b99cc 100644
--- a/drivers/soc/amlogic/meson-clk-measure.c
+++ b/drivers/soc/amlogic/meson-clk-measure.c
@@ -292,28 +292,7 @@ static int meson_msr_probe(struct platform_device *pdev)
 
 static const struct of_device_id meson_msr_match_table[] = {
 	{
-		.compatible = "amlogic,meson-gx-clk-measure",
-	},
-	{
-		.compatible = "amlogic,meson8-clk-measure",
-	},
-	{
-		.compatible = "amlogic,meson8b-clk-measure",
-	},
-	{
-		.compatible = "amlogic,meson-axg-clk-measure",
-	},
-	{
-		.compatible = "amlogic,meson-g12a-clk-measure",
-	},
-	{
-		.compatible = "amlogic,meson-sm1-clk-measure",
-	},
-	{
-		.compatible = "amlogic,c3-clk-measure",
-	},
-	{
-		.compatible = "amlogic,s4-clk-measure",
+		.compatible = "amlogic,clk-measure",
 	},
 	{ /* sentinel */ }
 };

-- 
2.42.0



