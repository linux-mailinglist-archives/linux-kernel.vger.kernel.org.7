Return-Path: <linux-kernel+bounces-884121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D459DC2F673
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 06:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45CE63BF8A6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 05:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D862C21CB;
	Tue,  4 Nov 2025 05:51:16 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0B034D3B0;
	Tue,  4 Nov 2025 05:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762235476; cv=none; b=nuEZC1GTTcVk9mSO58hAZklcwhuusiV9khPL4wvatJ7rBHLKgf3N7nVxWB0e17pxZJBscjudheK4F5W76LS2YL62wKqV61edvs6Jch6O85LzzS9S28SVVWLXvhwMi86u7NyYnwionF4h1p8xElV+iPAFQbtOZAqg+jmFfVlerqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762235476; c=relaxed/simple;
	bh=hpgA+YRHXc6fvLb5gsgLIet88dZivJTwiQCVpMCkXO0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AKplS5DDXwnR7pREUOZf/4ZSMvDv5370lRkMW8eA6Bl3bDKWVfM88ur0Yuro6LhgUeH5JBWHr3eA1GNcGYhdwunjMRx/nzXPrZ7T1tD28bsJdZQ4rXeNfkmil5BSGCavzDoBDE0mQGuUlR6JEITtdKmQ6h/2Ln8FQ/LgsNcuZAU=
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
Subject: [PATCH v1 1/2] dt-bindings: hwmon: Add AST2700 compatible
Date: Tue, 4 Nov 2025 13:51:11 +0800
Message-ID: <20251104055112.2679087-1-billy_tsai@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Adds support for the AST2700 PWM/Tach controller by extending the
compatible string enumeration in the device tree binding.

The AST2700 PWM/Tach hardware is compatible with the existing binding
schema and requires no additional properties or modifications beyond
the new compatible string.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml b/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml
index 9e5ed901ae54..d6ff4182085e 100644
--- a/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml
+++ b/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml
@@ -20,6 +20,7 @@ properties:
   compatible:
     enum:
       - aspeed,ast2600-pwm-tach
+      - aspeed,ast2700-pwm-tach
 
   reg:
     maxItems: 1
-- 
2.25.1


