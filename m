Return-Path: <linux-kernel+bounces-721861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97ABFAFCED6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 17:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99690562C7D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C914B2E11B3;
	Tue,  8 Jul 2025 15:17:14 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7322DECA8;
	Tue,  8 Jul 2025 15:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751987834; cv=none; b=pZ+InahPAoIzOAPq5xjpwRlaJLunU+ZQujvxAaJ95QLEHUhK6dJZSo1lv8eQicKM4TLQc8EgaCAyT+RC9tY5VzOJSf4Ze5bco0mIkPRe4PMguRF3p1qsLpXSqgZ4p1GdKxHgMMxNHgMwe2ZNN0IoqqkO9tkXLdgm9WEp6Sjtf1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751987834; c=relaxed/simple;
	bh=AznY2zb6vloAg+re3GKgRRgegg6t9h4ttc8jZm+nJb0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZXY8lVweT4tb1+rv9pfEYrCpq/jEmPn7lUfep9hQmU6VCLrGJ3IwctTQGwmbqV5D4d+AxrofhqtzZNvYTiOsqa8lE/LObgBMObucOua+hvdh8RvxA5P+Tt5dtsTjvd8oqhuiFVjM9KkbIBCXrvJ58xvk4RhcF+KDbZQqJKJTDi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bc4SQ47Mtz6GF8d;
	Tue,  8 Jul 2025 23:16:06 +0800 (CST)
Received: from frapeml500003.china.huawei.com (unknown [7.182.85.28])
	by mail.maildlp.com (Postfix) with ESMTPS id AE9071402A5;
	Tue,  8 Jul 2025 23:17:10 +0800 (CST)
Received: from a2303103017.china.huawei.com (10.203.177.99) by
 frapeml500003.china.huawei.com (7.182.85.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 8 Jul 2025 17:17:09 +0200
From: Alireza Sanaee <alireza.sanaee@huawei.com>
To: <krzk@kernel.org>, <robh@kernel.org>
CC: <coresight@lists.linaro.org>, <devicetree@vger.kernel.org>,
	<dianders@chromium.org>, <james.clark@linaro.org>,
	<jonathan.cameron@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
	<linuxarm@huawei.com>, <mark.rutland@arm.com>, <mike.leach@linaro.org>,
	<ruanjinjie@huawei.com>, <saravanak@google.com>,
	<shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v2 4/5] coresight: Use of_cpu_phandle_to_id for grabbing CPU id
Date: Tue, 8 Jul 2025 16:15:01 +0100
Message-ID: <20250708151502.561-5-alireza.sanaee@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250708151502.561-1-alireza.sanaee@huawei.com>
References: <20250708151502.561-1-alireza.sanaee@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 frapeml500003.china.huawei.com (7.182.85.28)

Use the newly created API to grab CPU id.

Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
---
 drivers/hwtracing/coresight/coresight-platform.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
index 0db64c5f4995..95d46ea08936 100644
--- a/drivers/hwtracing/coresight/coresight-platform.c
+++ b/drivers/hwtracing/coresight/coresight-platform.c
@@ -167,20 +167,7 @@ of_coresight_get_output_ports_node(const struct device_node *node)
 
 static int of_coresight_get_cpu(struct device *dev)
 {
-	int cpu;
-	struct device_node *dn;
-
-	if (!dev->of_node)
-		return -ENODEV;
-
-	dn = of_parse_phandle(dev->of_node, "cpu", 0);
-	if (!dn)
-		return -ENODEV;
-
-	cpu = of_cpu_node_to_id(dn);
-	of_node_put(dn);
-
-	return cpu;
+	return of_cpu_phandle_to_id(dev->of_node, NULL, 0);
 }
 
 /*
-- 
2.43.0


