Return-Path: <linux-kernel+bounces-835135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55916BA659C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 03:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D61D179C48
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 01:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E131CEAD6;
	Sun, 28 Sep 2025 01:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ydSFDA2k"
Received: from out199-7.us.a.mail.aliyun.com (out199-7.us.a.mail.aliyun.com [47.90.199.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DB8190685
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 01:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.199.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759023415; cv=none; b=WqCuruu+zqSXsPb6EtIrzG5COmDx/Cak7qWtL94u6kr+39j0SqSSBkETE1/BtVg01YOUsKAeS+jWA5+8pkOEJG+AwmO2MmidAC1Wo04LYhuePeQ1vPtceitDzgIAXshIjAwG7mcge8Y/nmypmrg5aJBeBOdVcMF9wBmu0ttbmPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759023415; c=relaxed/simple;
	bh=wiVx8Eh8sdquqL75jnMJSQvFD99gEpPAxNZxBJFxFfo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YlgFMtrUMBATqWftI0FGmMQhCREXtmCk9N+40XHn5zU75CjQYQNmBlzE3iePvbukjo7+BO7/SZMpwA2vuQHiD1OitudPLPA3paOcHs1/oIGsbVCqquuU93ld56NHoPvARqHDRxGns1HlDzIdjvMhSG/tbDubM4IXffkQwXbzxw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ydSFDA2k; arc=none smtp.client-ip=47.90.199.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1759023396; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=w7qIFaXWsgPPDvlUWsVnBfr1Mt30/fBDJ089QcbsNk0=;
	b=ydSFDA2kcrDPKkQ35XwBXVaFlm/DUEPF1LBLVDgpeOUSpLNLITsrAoMdJSlaKTfq8k9Daz35aHbLYOgO1D7Kxa2wRRpMFA8hBdb6plEH9p1bT5r47AXO6BQz8djZMtdKP11nGOY6cfT4Krg65q4rdjvCBm+rjsZZo2Uf8V0KuIw=
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0WowaYS9_1759023071 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 28 Sep 2025 09:31:19 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: dan.j.williams@intel.com
Cc: vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	ira.weiny@intel.com,
	nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] nvdimm: Remove duplicate linux/slab.h header
Date: Sun, 28 Sep 2025 09:31:10 +0800
Message-ID: <20250928013110.1452090-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

./drivers/nvdimm/bus.c: linux/slab.h is included more than once.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=25516
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/nvdimm/bus.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
index ad3a0493f474..87178a53ff9c 100644
--- a/drivers/nvdimm/bus.c
+++ b/drivers/nvdimm/bus.c
@@ -13,7 +13,6 @@
 #include <linux/async.h>
 #include <linux/ndctl.h>
 #include <linux/sched.h>
-#include <linux/slab.h>
 #include <linux/cpu.h>
 #include <linux/fs.h>
 #include <linux/io.h>
-- 
2.43.5


