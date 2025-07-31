Return-Path: <linux-kernel+bounces-751663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B82B16C0D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 08:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03EA3580B1B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 06:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2029253925;
	Thu, 31 Jul 2025 06:29:06 +0000 (UTC)
Received: from mail-m49231.qiye.163.com (mail-m49231.qiye.163.com [45.254.49.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E327A29
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 06:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753943346; cv=none; b=jO4utN16KqATrg/K/hQHBYoRiyzAn9qZTEhLgQabGelpy1qqVu1drjXcWONty33smEUSyrtw7zFOrL+zRmby/Khg1R61iUtRtIoyIAjFdcdD+SfzK6DE5qUflueO3cSkKueVAC+CXVZZ0VqnK9ARpba+B/7NTtW7XtcqOUZevUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753943346; c=relaxed/simple;
	bh=Adn8ptz33Pet6PRsBql0QwYIEZ9QPSBzVnCAKiyfjp4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HPIokFTEMvPBhn6cA8pe3d5muOrMsgqSQqEFjSYysuczgUDCPbQZuNu+HMsOqMmOiOAPUYK/kaCEc5o7PIDpl5B4BAWCgZqE2E+2OplZ/oDpHv5W+4C1WU2hX01220n6+hcvM9HMQ4CMSZWjY4BFtdhn8G9BdeuU1NPD8TwyXtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn; spf=pass smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=45.254.49.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from localhost.localdomain (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTP id deadf5d3;
	Thu, 31 Jul 2025 14:23:41 +0800 (GMT+08:00)
From: Zhen Ni <zhen.ni@easystack.cn>
To: daniel.lezcano@linaro.org,
	tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org,
	Zhen Ni <zhen.ni@easystack.cn>
Subject: [PATCH] clocksource: clps711x: Fix resource leaks in error paths
Date: Thu, 31 Jul 2025 14:23:31 +0800
Message-Id: <20250731062331.1041773-1-zhen.ni@easystack.cn>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a985f2698c00229kunmefaa3bcabe120
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVlCQh1NVkhMHx9LGU1CSE8YTFYVFAkWGhdVGRETFh
	oSFyQUDg9ZV1kYEgtZQVlJSkNVQk9VSkpDVUJLWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
	VKQktLWQY+

The current implementation of clps711x_timer_init() has multiple error
paths that directly return without releasing the base I/O memory mapped
via of_iomap(). This leads to resource leaks when:
1. irq_of_parse_and_map() fails
2. of_clk_get() returns an error
3. _clps711x_clkevt_init() fails for CLOCKEVENT alias
4. An unrecognized timer alias is provided

Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>
---
 drivers/clocksource/clps711x-timer.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/clocksource/clps711x-timer.c b/drivers/clocksource/clps711x-timer.c
index e95fdc49c226..f803d694c7a4 100644
--- a/drivers/clocksource/clps711x-timer.c
+++ b/drivers/clocksource/clps711x-timer.c
@@ -78,24 +78,34 @@ static int __init clps711x_timer_init(struct device_node *np)
 	unsigned int irq = irq_of_parse_and_map(np, 0);
 	struct clk *clock = of_clk_get(np, 0);
 	void __iomem *base = of_iomap(np, 0);
+	int ret = 0;
 
 	if (!base)
 		return -ENOMEM;
-	if (!irq)
-		return -EINVAL;
-	if (IS_ERR(clock))
-		return PTR_ERR(clock);
+	if (!irq) {
+		ret = -EINVAL;
+		goto out;
+	}
+	if (IS_ERR(clock)) {
+		ret = PTR_ERR(clock);
+		goto out;
+	}
 
 	switch (of_alias_get_id(np, "timer")) {
 	case CLPS711X_CLKSRC_CLOCKSOURCE:
 		clps711x_clksrc_init(clock, base);
 		break;
 	case CLPS711X_CLKSRC_CLOCKEVENT:
-		return _clps711x_clkevt_init(clock, base, irq);
+		ret =  _clps711x_clkevt_init(clock, base, irq);
+		break;
 	default:
-		return -EINVAL;
+		ret = -EINVAL;
+		break;
 	}
 
-	return 0;
+out:
+	if (base)
+		iounmap(base);
+	return ret;
 }
 TIMER_OF_DECLARE(clps711x, "cirrus,ep7209-timer", clps711x_timer_init);
-- 
2.20.1


