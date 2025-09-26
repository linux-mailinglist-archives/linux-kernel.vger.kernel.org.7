Return-Path: <linux-kernel+bounces-833583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4790BA257B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 05:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3B39188B0D1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 03:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF19D26F2AB;
	Fri, 26 Sep 2025 03:36:29 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E600616A956
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 03:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758857789; cv=none; b=XV3ER9dRpIMX4GfZ6Y9a5ZZe1c+t7KLXKY7XgTGR1RQv5klIiOuVQnZ8yllslT1RVdH7ouYib86dVTl2HoK8or5vYvH5kX7nsmH+0N9OlJCcBy0F8AqRmLmoxWY6uXFYN2uI8l2RcUTZphx1q0KPbV9C2xhuIkYCr5lWJKUKDPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758857789; c=relaxed/simple;
	bh=sfuv7tJC1vWj8+qQLuaAwljfTBgkRnyvtVr/ss2lGs0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lsXoJZpbzU3C7yA0aaCe3Oxth5ggaIyobyVGd2+y9iPxIyiEdbZrB+VGdZldz3xocJOhNa4B4wIgIYCPIT0STcGC8jHSbfg65/pwNBtn1pKpwm20Hi365545lcXL0UzPWf5u3LtACezH5/zbmYaIrKdjxrzc//IZvj5SiZtl2hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4cXx4T1tngz1R9Cm;
	Fri, 26 Sep 2025 11:33:13 +0800 (CST)
Received: from dggpemf500016.china.huawei.com (unknown [7.185.36.197])
	by mail.maildlp.com (Postfix) with ESMTPS id EBB61180044;
	Fri, 26 Sep 2025 11:36:22 +0800 (CST)
Received: from huawei.com (10.50.159.234) by dggpemf500016.china.huawei.com
 (7.185.36.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 26 Sep
 2025 11:36:22 +0800
From: Wang Liang <wangliang74@huawei.com>
To: <dave@stgolabs.net>, <paulmck@kernel.org>, <josh@joshtriplett.org>,
	<frederic@kernel.org>
CC: <yuehaibing@huawei.com>, <zhangchangzhong@huawei.com>,
	<wangliang74@huawei.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] locktorture: Fix memory leak in param_set_cpumask()
Date: Fri, 26 Sep 2025 11:57:17 +0800
Message-ID: <20250926035717.1025444-1-wangliang74@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500016.china.huawei.com (7.185.36.197)

With CONFIG_CPUMASK_OFFSTACK=y, the 'bind_writers' buffer is allocated via
alloc_cpumask_var() in param_set_cpumask(). But it is not freed, when
setting the module parameter multiple times by sysfs interface or removing
module.

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
  insmod locktorture.ko bind_writers=1
  rmmod locktorture

or:
  insmod locktorture.ko bind_writers=1
  echo 2 > /sys/module/locktorture/parameters/bind_writers

Considering that setting the module parameter 'bind_writers' or
'bind_readers' by sysfs interface has no real effect, set the parameter
permissions to 0444. To fix the memory leak when removing module, free
'bind_writers' and 'bind_readers' memory in lock_torture_cleanup().

Fixes: 73e341242483 ("locktorture: Add readers_bind and writers_bind module parameters")
Suggested-by: Zhang Changzhong <zhangchangzhong@huawei.com>
Signed-off-by: Wang Liang <wangliang74@huawei.com>
---
 kernel/locking/locktorture.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index ce0362f0a871..6567e5eeacc0 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -103,8 +103,8 @@ static const struct kernel_param_ops lt_bind_ops = {
 	.get = param_get_cpumask,
 };
 
-module_param_cb(bind_readers, &lt_bind_ops, &bind_readers, 0644);
-module_param_cb(bind_writers, &lt_bind_ops, &bind_writers, 0644);
+module_param_cb(bind_readers, &lt_bind_ops, &bind_readers, 0444);
+module_param_cb(bind_writers, &lt_bind_ops, &bind_writers, 0444);
 
 long torture_sched_setaffinity(pid_t pid, const struct cpumask *in_mask, bool dowarn);
 
@@ -1211,6 +1211,10 @@ static void lock_torture_cleanup(void)
 			cxt.cur_ops->exit();
 		cxt.init_called = false;
 	}
+
+	free_cpumask_var(bind_readers);
+	free_cpumask_var(bind_writers);
+
 	torture_cleanup_end();
 }
 
-- 
2.34.1


