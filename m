Return-Path: <linux-kernel+bounces-840840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8D9BB58A4
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 00:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E20DC19271D3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 22:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1642737E6;
	Thu,  2 Oct 2025 22:28:48 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD5D245023
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 22:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759444128; cv=none; b=JlLC07gaBkp4USRmW9UPcl6GmJn/g0kz8QXFne3eQMKM4Chos6LhRTecyYQet+IQqoQlHc77QS+EAX8tAOTlXTWPeDOYvNrqhe7JYTa/SbGbo6WZxyEZU8Vv+t27pv2cKuW+1G2KABhbpnbGw+cfsS3UQwP4j9EfkBuCe7dyiNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759444128; c=relaxed/simple;
	bh=6yIWmQVBkdeo4k9A/ET9hcLPkqL9LMtgmxAzQSDoUHE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WyQig9HAX8BgGS9l+IHYYSX1FJsFdNDEraoNKmcuYT3FhZMCh1qNS7F9cjvXZRCIzqTtMSFfn/PDtYHWoHeIfP183vLQoWYtNz2jxsDfwpK0V5cotmu/1uvzhZroGqFxIdoAIeuS50W+hDN+2ScneWncdEoINZ2JW+uGLmlqxzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C7841655;
	Thu,  2 Oct 2025 15:28:36 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B6DC3F5A1;
	Thu,  2 Oct 2025 15:28:43 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] reset: core: reset-gpio: Suppress registration error for optional resets
Date: Thu,  2 Oct 2025 23:28:26 +0100
Message-ID: <20251002222826.16516-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For reset controllers that are marked as optional, we should skip errors
during probing and return NULL, to avoid unnecessary failures. The
reset-gpio controller does this mostly, but returns the true error in
case the __reset_add_reset_gpio_device() call fails. Treat this call the
same as the other registration errors, and consider the optional flag.

One could argue that at this point it's a proper error that should not
be ignored anymore, but in case of the reset-gpio controller this is not
entirely true, since the code at the moment does not support GPIO
controllers with three #gpio-cells - there is a TODO comment about this
in that said function. So to avoid unnecessary probe fails for devices
using reset-gpios (it's an optional reset after all), let's treat an
error as still optional at this point.

This fixes operation of WiFi chips on Allwinner boards, where some use
reset-gpios, and which currently fail because all Allwinner SoCs use
GPIO controllers with 3 cells.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/reset/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index 22f67fc77ae53..c2ccd08fb36e1 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -1044,7 +1044,7 @@ __of_reset_control_get(struct device_node *node, const char *id, int index,
 
 		ret = __reset_add_reset_gpio_device(&args);
 		if (ret) {
-			rstc = ERR_PTR(ret);
+			rstc = optional ? NULL : ERR_PTR(ret);
 			goto out_put;
 		}
 	}
-- 
2.46.4


