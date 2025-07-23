Return-Path: <linux-kernel+bounces-741935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDB5B0EAEC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 08:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 049853A7A53
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 06:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE88926FA59;
	Wed, 23 Jul 2025 06:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Dtg8dBZE"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7E2191493;
	Wed, 23 Jul 2025 06:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753253182; cv=none; b=WBu6Or3hI2agdV8mq8e8B6CqHk+wgTkt/AiHaVfpTDbag+J3MQNbQWN7bROjp05CDTe2pPvO2vVWQBHkNHyAcnEGHp0KkZKTGPO1iad42asacuD176t9s46MtaupB/d85kXImTOPwit2CknxrurO2Rpp+x+xSug2uiLYRy6lShY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753253182; c=relaxed/simple;
	bh=Viiejit+4wpmSf+d9B590lGDr4NMWF238qcEb8bf44c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nWc3Km7AUIJtXE+w4CU3tbIlQj1N3pEYo9HWb3tJu233Yw9IZKxfQVWFq6efbXKLdHuYbmemNS/rRrVndYRi1x+mMhiex5jC47vUmPUqy99D44Ok+oMboemah+yVh3FvTScb1xXyD4WYS+ggIGtWc0/3O4kDdzC4efv1gRZakwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Dtg8dBZE; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753253170; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=He9DDUO0xCzGw/bWMC1Vjhk8wpHXB42pGLbNtz3o6OQ=;
	b=Dtg8dBZEMrpfMXTsdZy3EMrThDSg9E55x/5SfO5DFYWPH7UCbiSlzeLWhYPwKgvc/N3m41tH5qS+HnDxhOrPc4xCtR4hPieGTi/bYP+W36ALwWSvNxrNLl9X6WNzsxoN99dFWpKafFAUGYn89X3Rlt6dksK2ocHDBVaKv0D4AhU=
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0WjatQyL_1753253169 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 23 Jul 2025 14:46:10 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: linus.walleij@linaro.org,
	brgl@bgdev.pl
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] gpio: cadence: Remove duplicated include in gpio-cadence.c
Date: Wed, 23 Jul 2025 14:46:08 +0800
Message-ID: <20250723064608.2178024-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The header files linux/gpio/driver.h is included twice in gpio-cadence.c,
so one inclusion of each can be removed.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=22931
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/gpio/gpio-cadence.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpio/gpio-cadence.c b/drivers/gpio/gpio-cadence.c
index 8243eddcd5bb..c647953521c7 100644
--- a/drivers/gpio/gpio-cadence.c
+++ b/drivers/gpio/gpio-cadence.c
@@ -12,7 +12,6 @@
 #include <linux/clk.h>
 #include <linux/gpio/driver.h>
 #include <linux/interrupt.h>
-#include <linux/gpio/driver.h>
 #include <linux/gpio/generic.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-- 
2.43.5


