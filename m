Return-Path: <linux-kernel+bounces-884122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE4BC2F685
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 06:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2458F4F09D2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 05:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17562D9498;
	Tue,  4 Nov 2025 05:51:18 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD392C0F8E;
	Tue,  4 Nov 2025 05:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762235478; cv=none; b=McpteOJTiPTr/j3QE6GVZg+SzLuYh16ABjGh37t07c0GC70Gt2NCzCzO8a4k24gOgKzD24pujGDi9o+PpLAGW+9pjgZeXl30Tg0PfNzrmcSt4E5s0uQ2y5U7FQfnKPjxU+tLkgwuAhK//UbldgfC+/YH5BM5CaAGNlbUsIIllOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762235478; c=relaxed/simple;
	bh=FQY5LIHQ0lHHXMQmBtrO7lLlYspnnXPcW63KcxCH1Y8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qUO7FGXKWmAoRMdcilRMqCc2JdV4cqd7jnLRCb0LoKBGbxmnQZVyOzLre8x3DjMlEvnPu66u3QMorRcqiE5Jze9U6twCcIfE74fw3WNZwXIEWx31HlkQNH2QbhaYcSilgwkOolsQHlJyoyDryp4Ch2RbQI62a6Mn75jbJOAR0hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 4 Nov
 2025 13:51:12 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 4 Nov 2025 13:51:12 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
To: <linux@roeck-us.net>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<billy_tsai@aspeedtech.com>, <linux-hwmon@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 2/2] hwmon: (aspeed-g6-pwm-tach): Add AST2700 compatible string
Date: Tue, 4 Nov 2025 13:51:12 +0800
Message-ID: <20251104055112.2679087-2-billy_tsai@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251104055112.2679087-1-billy_tsai@aspeedtech.com>
References: <20251104055112.2679087-1-billy_tsai@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Extends device tree support to include the AST2700 chip variant by
adding its compatible string to the device match table.

The AST2700 PWM/TACH hardware is compatible with the existing driver
implementation used for AST2600.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 drivers/hwmon/aspeed-g6-pwm-tach.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hwmon/aspeed-g6-pwm-tach.c b/drivers/hwmon/aspeed-g6-pwm-tach.c
index 4174b129d1fc..44e1ecba205d 100644
--- a/drivers/hwmon/aspeed-g6-pwm-tach.c
+++ b/drivers/hwmon/aspeed-g6-pwm-tach.c
@@ -528,6 +528,9 @@ static const struct of_device_id aspeed_pwm_tach_match[] = {
 	{
 		.compatible = "aspeed,ast2600-pwm-tach",
 	},
+	{
+		.compatible = "aspeed,ast2700-pwm-tach",
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, aspeed_pwm_tach_match);
-- 
2.25.1


