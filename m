Return-Path: <linux-kernel+bounces-813031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBDAB53FEA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 03:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 049F91BC718D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 01:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7E8153BD9;
	Fri, 12 Sep 2025 01:36:11 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFED2AE66
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 01:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757640971; cv=none; b=lI74XIderudbG7PKhYfryWl42rqbaFjOxhmW0JD4uA021OLix+fAY4L/clcL6fdaRskaluntS4CYyemZOuinFQUkVS2O34WlkovAaEF8BOxzDiNHZnAyqYqp4SBBUusDcdeGfQck1fYKuwpwjtKCnOVrbAqRupRexAukYdEYD2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757640971; c=relaxed/simple;
	bh=rs0TbikHw8NnqPMKNvYnGWe2gOX0qz7/vtiosXW92ro=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZLavGPvw4Ts+UXQn1tEg5QaNSa4eHfVQAWGKY5ME9FWeiLg1341Tg8xS7l1ZIfjPNJ2ZHWu5GPGXlFVtvukA6+N2nPjujhOk/zrHEKKM0iAgrHvv/38dmS62rB8vRkwbipwM+0C9ny0hVCIs3J4zcH80rYZSyMnB7Oicqkef9g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4cNH2X2slVz2Cghx;
	Fri, 12 Sep 2025 09:31:32 +0800 (CST)
Received: from dggpemf500016.china.huawei.com (unknown [7.185.36.197])
	by mail.maildlp.com (Postfix) with ESMTPS id 5C7D51A016C;
	Fri, 12 Sep 2025 09:36:05 +0800 (CST)
Received: from huawei.com (10.50.159.234) by dggpemf500016.china.huawei.com
 (7.185.36.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 12 Sep
 2025 09:36:04 +0800
From: Wang Liang <wangliang74@huawei.com>
To: <dave@stgolabs.net>, <paulmck@kernel.org>, <josh@joshtriplett.org>,
	<frederic@kernel.org>
CC: <yuehaibing@huawei.com>, <zhangchangzhong@huawei.com>,
	<wangliang74@huawei.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] locktorture: Fix memory leak in param_set_cpumask()
Date: Fri, 12 Sep 2025 09:57:37 +0800
Message-ID: <20250912015737.1209143-1-wangliang74@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500016.china.huawei.com (7.185.36.197)

When setting the locktorture module parameter 'bind_writers', the variable
'cpumask_var_t bind_writers' is allocated in param_set_cpumask(). But it
is not freed, when removing module or setting the parameter again.

Below kmemleak trace is seen for this issue:

unreferenced object 0xffff888100aabff8 (size 8):
  comm "bash", pid 323, jiffies 4295059233
  hex dump (first 8 bytes):
    07 00 00 00 00 00 00 00                          ........
  backtrace (crc ac50919):
    __kmalloc_node_noprof+0x2e5/0x420
    alloc_cpumask_var_node+0x1f/0x30
    param_set_cpumask+0x26/0xb0 [locktorture]
    param_attr_store+0x93/0x100
    module_attr_store+0x1b/0x30
    kernfs_fop_write_iter+0x114/0x1b0
    vfs_write+0x300/0x410
    ksys_write+0x60/0xd0
    do_syscall_64+0xa4/0x260
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

This issue can be reproduced by:
  insmod locktorture.ko
  echo 0-2 > /sys/module/locktorture/parameters/bind_writers
  rmmod locktorture

or:
  insmod locktorture.ko
  echo 0-2 > /sys/module/locktorture/parameters/bind_writers
  echo 0-2 > /sys/module/locktorture/parameters/bind_writers

The parameter 'bind_readers' also has the same problem. Free the memory
when removing module or setting the parameter.

Fixes: 73e341242483 ("locktorture: Add readers_bind and writers_bind module parameters")
Signed-off-by: Wang Liang <wangliang74@huawei.com>
---
 kernel/locking/locktorture.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index ce0362f0a871..cad80c050502 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -70,6 +70,9 @@ static int param_set_cpumask(const char *val, const struct kernel_param *kp)
 	int ret;
 	char *s;
 
+	free_cpumask_var(*cm_bind);
+	*cm_bind = NULL;
+
 	if (!alloc_cpumask_var(cm_bind, GFP_KERNEL)) {
 		s = "Out of memory";
 		ret = -ENOMEM;
@@ -1211,6 +1214,12 @@ static void lock_torture_cleanup(void)
 			cxt.cur_ops->exit();
 		cxt.init_called = false;
 	}
+
+	free_cpumask_var(bind_readers);
+	free_cpumask_var(bind_writers);
+	bind_readers = NULL;
+	bind_writers = NULL;
+
 	torture_cleanup_end();
 }
 
-- 
2.34.1


