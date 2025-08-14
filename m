Return-Path: <linux-kernel+bounces-768688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 855B3B2642D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 13:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CF439E72CF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A4F2F3C11;
	Thu, 14 Aug 2025 11:25:17 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9B42BCF6C
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 11:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755170717; cv=none; b=r0FVqgTmpW7OXxlvIjbl2lRWPq+hVoJI/8ZMxtAdtXy9lO208YIpkz/CylOvx56JHxaw18q2IiG9nz2Aq0bvShwLZaRAhTwb73mYak3en1Izlu5o0sNGxPLN1iKVpxzdaihjLkUfVY20Hbz8Czxu8BQhRVaJi02NNqPwDWPuvh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755170717; c=relaxed/simple;
	bh=Dym3AigYZnVrcbC3pWJy5w5ItCrJMvVKhC8G0fiaXCM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I+z3vRaSOAAH0IUh5x2Zp06SegP9x9x32/E3cGIu0wwjIwut2sfS4Nlpkyl+LeYY7JBTtP4k5P3Y1E/Gwpb3LyAxLt1CUK0YxSvrHVX67SucsBFSePlekKah1TpfQznW9j2DkwKCi7LjIUZ5aA/IUdyrH9MtEQ5W2gRZ4/ixLoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4c2jWq0R16z2TT8X;
	Thu, 14 Aug 2025 19:22:31 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 9856E1800B2;
	Thu, 14 Aug 2025 19:25:12 +0800 (CST)
Received: from kwepemq200012.china.huawei.com (7.202.194.183) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 14 Aug 2025 19:25:12 +0800
Received: from huawei.com (10.175.112.208) by kwepemq200012.china.huawei.com
 (7.202.194.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 14 Aug
 2025 19:25:11 +0800
From: Wang Wensheng <wangwensheng4@huawei.com>
To: <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <dakr@kernel.org>,
	<tglx@linutronix.de>, <saravanak@google.com>, <robh@kernel.org>,
	<broonie@kernel.org>, <linux-kernel@vger.kernel.org>
CC: <chenjun102@huawei.com>, <wangwensheng4@huawei.com>
Subject: [PATCH 2/3] driver core: Introduce fw_devlink_relax_consumers helper
Date: Thu, 14 Aug 2025 19:10:22 +0800
Message-ID: <20250814111023.2693-3-wangwensheng4@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20250814111023.2693-1-wangwensheng4@huawei.com>
References: <20250814111023.2693-1-wangwensheng4@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemq200012.china.huawei.com (7.202.194.183)

Some devices are added during its parent's probe and will never get
bound to a driver. In this case, with fw_devlink set to "rpm",
which is the default value, its consumers will be deferred probe
until deferred_probe_timeout when fw_devlink_drivers_done() would
relax the devlinks to the suplier.

Use this function to relax the consumer devlinks, just like what we
do for the unmatched devices in fw_devlink_drivers_done(), so that
the consumer devices would be probed not that later.

Signed-off-by: Wang Wensheng <wangwensheng4@huawei.com>
---
 drivers/base/core.c    | 22 ++++++++++++++++++++++
 include/linux/device.h |  1 +
 2 files changed, 23 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index d22d6b23e758..2f7101ad9d11 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1754,6 +1754,28 @@ static void fw_devlink_relax_link(struct device_link *link)
 		dev_name(link->supplier));
 }
 
+/**
+ * fw_devlink_relax_consumers - Relax the devlinks with all its consumers
+ * @dev: Device whose consumer devlinks will be relaxed
+ *
+ * Some devices are added during its parent's probe and will never get bound
+ * to a driver. In this case its consumers will be deferred probe until
+ * deferred_probe_timeout.
+ *
+ * Use this function to relax the consumer devlinks so that the consumers
+ * device would be probed not that later.
+ */
+void fw_devlink_relax_consumers(struct device *dev)
+{
+	struct device_link *link;
+
+	device_links_write_lock();
+	list_for_each_entry(link, &dev->links.consumers, s_node)
+		fw_devlink_relax_link(link);
+	device_links_write_unlock();
+}
+EXPORT_SYMBOL_GPL(fw_devlink_relax_consumers);
+
 static int fw_devlink_no_driver(struct device *dev, void *data)
 {
 	struct device_link *link = to_devlink(dev);
diff --git a/include/linux/device.h b/include/linux/device.h
index 0470d19da7f2..a451c0eb2ffa 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1201,6 +1201,7 @@ void device_link_remove(void *consumer, struct device *supplier);
 void device_links_supplier_sync_state_pause(void);
 void device_links_supplier_sync_state_resume(void);
 void device_link_wait_removal(void);
+void fw_devlink_relax_consumers(struct device *dev);
 
 static inline bool device_link_test(const struct device_link *link, u32 flags)
 {
-- 
2.22.0


