Return-Path: <linux-kernel+bounces-896394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDCBC50416
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 02:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF49D3A9D34
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 01:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19906296BA7;
	Wed, 12 Nov 2025 01:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="VXAtPa2a"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EA815E5C2;
	Wed, 12 Nov 2025 01:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762912683; cv=none; b=O0NyPyO3JHZnfwnf6a6PEWx+pGeGSq50yq6xSxjTO+ChM2Vi9Ye1Jkin0Oul+fs5dlvgLaAhNgUhT4+PIhTrHVDDJp/j618IAqMzOufti8koBF4wMH6lTbJw+/z9/0ZEChPioMcXLjIsfetcnN6THtfCjoXJkHmjeTW2fD+4NBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762912683; c=relaxed/simple;
	bh=QoNG17ZTsvdz0HbmuqGj28dacv/YzlZsnnYAorZS1mQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GPV53hSwdi/ZXMFiU4dsmksPK5FXkdxxvO0M/AAd/gwln/VU/J3AiVPHNzI45k2SgduhZK/pPGIsqnISOiO3QHLUpurZniCjJ7/nkMiwuDTsJAYhZYYbThkMy2SCSWvEJxfJeMG4629pK35qLRxpkkjAFK0sknwPxeUutRLm30k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=VXAtPa2a; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=b+
	M7qIMhBgTxamxFWUrUIMov0Az4ujaq+gMVb2rAdz0=; b=VXAtPa2arMXJU/rYk2
	2sgb/c0u0aJldm8/XwVP7D0FvLQ6SvBg/P4b1drRRv9F/iAZ7hVmdCeoci/9sOgE
	/x1mLRyol0s7TJr2jvHGZYq1B1N9CU73mJ1Q/6UerT369LDHoyMLXCNignzHc4NS
	J6yFvkTWDfP4+/jCJNsGCCkLY=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wCX7f6R6RNpFvgsDQ--.1198S2;
	Wed, 12 Nov 2025 09:57:39 +0800 (CST)
From: luoqing <l1138897701@163.com>
To: cryolitia@uniontech.com
Cc: linux@roeck-us.net,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	luoqing@kylinos.cn
Subject: [PATCH] hwmon: (gpd-fan) Fix the compilation error
Date: Wed, 12 Nov 2025 09:57:37 +0800
Message-Id: <20251112015737.948693-1-l1138897701@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCX7f6R6RNpFvgsDQ--.1198S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtFyxKF1kWr18Gr1kWr4fGrg_yoWDWrbEkw
	nruws7uryUG3W5tF9Y9FZ5u342yw4UWF48Z3Z293s5CrnrZ39xt393A348Aw1UGry5tFyF
	vw4Dtw48Cry3ZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbQ6ptUUUUU==
X-CM-SenderInfo: jorrjmiyzxliqr6rljoofrz/1tbiSAIERGkT4l+qBgAAsh

From: luoqing <luoqing@kylinos.cn>

drivers/hwmon/gpd-fan.c: in the function 'gpd_ecram_read' :
drivers/hwmon/gpd-fan.c:231:9: Error: implicit declaration function 'outb' [-Werror= implrecental-function-declaration]
231 |         outb(0x2E, addr_port);
^~~~
drivers/hwmon/gpd-fan.c:244:16: Error: implicit declaration function 'inb' [-Werror= implrecental-function-declaration]
244 |         *val = inb(data_port);
^~~
cc1: All warnings were regarded as errors

Signed-off-by: luoqing <luoqing@kylinos.cn>
---
 drivers/hwmon/gpd-fan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwmon/gpd-fan.c b/drivers/hwmon/gpd-fan.c
index 321794807e8d..57d4ee683f0d 100644
--- a/drivers/hwmon/gpd-fan.c
+++ b/drivers/hwmon/gpd-fan.c
@@ -19,6 +19,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/io.h>
 
 #define DRIVER_NAME "gpdfan"
 #define GPD_PWM_CTR_OFFSET 0x1841
-- 
2.25.1


