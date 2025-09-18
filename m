Return-Path: <linux-kernel+bounces-781595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82999B31469
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CA301D032C8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A067B2FB61F;
	Fri, 22 Aug 2025 09:48:18 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBA02F6180
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 09:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755856095; cv=none; b=URrVs14GzNXw+qvolvjkesfU0Aha+f75tmrSTMuh1dFfc1PTm0jVMhjHwiywKG1Ak1NKa49EdhVhQaAWS01VHQ+PhI+vv4XQdRkuf6d8To99CgGu1RMzA22HhG0kjN3Gv42uZWUfQ0ZwS0Ld18GbTSvkHdD04eXxAvUO9Ibo3mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755856095; c=relaxed/simple;
	bh=H1sl/RRi+p5LzK40S3KU9YwqXYMPBq98JUgmJ7rTEdc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DzSwTa732ULEEhaVPnvfHjyVHw73bC3yYXdZSJjFas/UwcQvF4V3tJ4Suk4U6QSu4KAHffgFnfDShKz8TXTQYUsMc29DAkWIt0qgo/wotQXaKRWa0beMWGd3n/4IL8hDShSbYxtKJrDhMQdUo/ll9/vKTMeeIE2+9jbidDwYynQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4c7b4W6ts5z27jJ3;
	Fri, 22 Aug 2025 17:49:15 +0800 (CST)
Received: from dggpemf200018.china.huawei.com (unknown [7.185.36.31])
	by mail.maildlp.com (Postfix) with ESMTPS id 40FED1401F1;
	Fri, 22 Aug 2025 17:48:10 +0800 (CST)
Received: from huawei.com (10.50.85.135) by dggpemf200018.china.huawei.com
 (7.185.36.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 22 Aug
 2025 17:48:09 +0800
From: Quanmin Yan <yanquanmin1@huawei.com>
To: <sj@kernel.org>
CC: <akpm@linux-foundation.org>, <damon@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<yanquanmin1@huawei.com>, <wangkefeng.wang@huawei.com>, <zuoze1@huawei.com>
Subject: [PATCH v2 07/11] mm/damon/sysfs: implement addr_unit file under context dir
Date: Fri, 22 Aug 2025 17:34:15 +0800
Message-ID: <20250822093420.2103803-8-yanquanmin1@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250822093420.2103803-1-yanquanmin1@huawei.com>
References: <20250822093420.2103803-1-yanquanmin1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf200018.china.huawei.com (7.185.36.31)

From: SeongJae Park <sj@kernel.org>

Only DAMON kernel API callers can use addr_unit parameter.  Implement a
sysfs file to let DAMON sysfs ABI users use it.

Additionally, addr_unit must be set to a non-zero value.

Signed-off-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Quanmin Yan <yanquanmin1@huawei.com>
Reviewed-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 6d2b0dab50cb..98bf15d403b2 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -834,6 +834,7 @@ static const struct damon_sysfs_ops_name damon_sysfs_ops_names[] = {
 struct damon_sysfs_context {
 	struct kobject kobj;
 	enum damon_ops_id ops_id;
+	unsigned long addr_unit;
 	struct damon_sysfs_attrs *attrs;
 	struct damon_sysfs_targets *targets;
 	struct damon_sysfs_schemes *schemes;
@@ -849,6 +850,7 @@ static struct damon_sysfs_context *damon_sysfs_context_alloc(
 		return NULL;
 	context->kobj = (struct kobject){};
 	context->ops_id = ops_id;
+	context->addr_unit = 1;
 	return context;
 }
 
@@ -997,6 +999,32 @@ static ssize_t operations_store(struct kobject *kobj,
 	return -EINVAL;
 }
 
+static ssize_t addr_unit_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_context *context = container_of(kobj,
+			struct damon_sysfs_context, kobj);
+
+	return sysfs_emit(buf, "%lu\n", context->addr_unit);
+}
+
+static ssize_t addr_unit_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_context *context = container_of(kobj,
+			struct damon_sysfs_context, kobj);
+	unsigned long input_addr_unit;
+	int err = kstrtoul(buf, 0, &input_addr_unit);
+
+	if (err)
+		return err;
+	if (!input_addr_unit)
+		return -EINVAL;
+
+	context->addr_unit = input_addr_unit;
+	return count;
+}
+
 static void damon_sysfs_context_release(struct kobject *kobj)
 {
 	kfree(container_of(kobj, struct damon_sysfs_context, kobj));
@@ -1008,9 +1036,13 @@ static struct kobj_attribute damon_sysfs_context_avail_operations_attr =
 static struct kobj_attribute damon_sysfs_context_operations_attr =
 		__ATTR_RW_MODE(operations, 0600);
 
+static struct kobj_attribute damon_sysfs_context_addr_unit_attr =
+		__ATTR_RW_MODE(addr_unit, 0600);
+
 static struct attribute *damon_sysfs_context_attrs[] = {
 	&damon_sysfs_context_avail_operations_attr.attr,
 	&damon_sysfs_context_operations_attr.attr,
+	&damon_sysfs_context_addr_unit_attr.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(damon_sysfs_context);
@@ -1397,6 +1429,7 @@ static int damon_sysfs_apply_inputs(struct damon_ctx *ctx,
 	err = damon_select_ops(ctx, sys_ctx->ops_id);
 	if (err)
 		return err;
+	ctx->addr_unit = sys_ctx->addr_unit;
 	err = damon_sysfs_set_attrs(ctx, sys_ctx->attrs);
 	if (err)
 		return err;
-- 
2.43.0


