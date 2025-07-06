Return-Path: <linux-kernel+bounces-712502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7DBAF0A80
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jul 2025 07:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B68D16A6B6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jul 2025 05:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E3D231853;
	Wed,  2 Jul 2025 05:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hB/aWu0P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7FB230BDB;
	Wed,  2 Jul 2025 05:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751433370; cv=none; b=JS+KBCrj6Qppm19ubAhNplYyM9XyADCLma7FJtiTlROVrS9zrKpiurSLCwxbRVDQypUZrRDUnpct5Kzx/rOV7MDQKJ/rqqyo2hpVA20ehixIzntauB79YzBSZyV012hblqKJ6MrLtx4K4hssaGNWZaNUEdhYAtYvBqqCLUVx4bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751433370; c=relaxed/simple;
	bh=kjOKLngDzUss3QPXY3L0jEKHeiRx/Y/BDT/FqW73VxA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pRaSrtfGvuQXnyDjiOkeXHsGOeSID9C3SmlUSo1nqvX+bUBGyDV4umpJrXX2PNpdpDzHfyfmJNZJdYaWGYsLTYZTRYd5NeaDgERRr941f5MM1VeEIQ/dJN1ZPN8PtxpvxAL3snCkEh18s6DXkR7DF7roWb5ZBG2K3DkuRVfJH10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hB/aWu0P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 619ECC4CEEF;
	Wed,  2 Jul 2025 05:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751433369;
	bh=kjOKLngDzUss3QPXY3L0jEKHeiRx/Y/BDT/FqW73VxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hB/aWu0PDtilZ2yyBwYjUwd8F6AcCItRGZx79SiTF12/UpeiXhimy2oNRR2TPl3lH
	 qP62xHGhPKmjEN1oIP2COfX3wQ1hi/cS3x9P31iTY67V05+3XDNBSAozEas5tNEdAA
	 eCbeIBe5PvbuWKit7MvY8AqpQdk1e3BPJqeeawAbV08uuTY2YJVMRLETQn1I+yy8Qf
	 qd5SetjmmacHUL1vAqDqkSZJMzp0Ug4k7Gv1F9iXJi2hXaVEYbgCTVDh6dxV07laCB
	 zyQnP85hfLSfGkIGCuRv+WhzKPdjfbc7Xai00r6TZjLQdXMxC3Kr9t8T/vMmB8wtp6
	 9/BIgu4DWjG3A==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bijan Tabatabai <bijan311@gmail.com>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 3/6] mm/damon/sysfs-schemes: implement DAMOS action destinations directory
Date: Tue,  1 Jul 2025 22:15:55 -0700
Message-Id: <20250702051558.54138-4-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250702051558.54138-1-sj@kernel.org>
References: <20250702051558.54138-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMOS_MIGRATE_{HOT,COLD} can have multiple action destinations and their
weights.  Implement sysfs directory named 'dests' under each scheme
directory to let DAMON sysfs ABI users utilize the feature.  The
interface is similar to other multiple parameters directory like
kdamonds or filters.  The directory contains only nr_dests file
initially.  Writing a number of desired destinations to nr_dests creates
directories of the number.  Each of the created directories has two
files named id and weight.  Users can then write the destination's
identifier (node id in case of DAMOS_MIGRATE_*) and weight to the files.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 225 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 224 insertions(+), 1 deletion(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 601360e9b521..b9434cdaacdc 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1655,6 +1655,204 @@ static const struct kobj_type damon_sysfs_access_pattern_ktype = {
 	.default_groups = damon_sysfs_access_pattern_groups,
 };
 
+/*
+ * dest (action destination) directory
+ */
+
+struct damos_sysfs_dest {
+	struct kobject kobj;
+	unsigned int id;
+	unsigned int weight;
+};
+
+static struct damos_sysfs_dest *damos_sysfs_dest_alloc(void)
+{
+	return kzalloc(sizeof(struct damos_sysfs_dest), GFP_KERNEL);
+}
+
+static ssize_t id_show(
+		struct kobject *kobj, struct kobj_attribute *attr, char *buf)
+{
+	struct damos_sysfs_dest *dest = container_of(kobj,
+			struct damos_sysfs_dest, kobj);
+
+	return sysfs_emit(buf, "%u\n", dest->id);
+}
+
+static ssize_t id_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damos_sysfs_dest *dest = container_of(kobj,
+			struct damos_sysfs_dest, kobj);
+	int err = kstrtouint(buf, 0, &dest->id);
+
+	return err ? err : count;
+}
+
+static ssize_t weight_show(
+		struct kobject *kobj, struct kobj_attribute *attr, char *buf)
+{
+	struct damos_sysfs_dest *dest = container_of(kobj,
+			struct damos_sysfs_dest, kobj);
+
+	return sysfs_emit(buf, "%u\n", dest->weight);
+}
+
+static ssize_t weight_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damos_sysfs_dest *dest = container_of(kobj,
+			struct damos_sysfs_dest, kobj);
+	int err = kstrtouint(buf, 0, &dest->weight);
+
+	return err ? err : count;
+}
+
+static void damos_sysfs_dest_release(struct kobject *kobj)
+{
+	struct damos_sysfs_dest *dest = container_of(kobj,
+			struct damos_sysfs_dest, kobj);
+	kfree(dest);
+}
+
+static struct kobj_attribute damos_sysfs_dest_id_attr =
+		__ATTR_RW_MODE(id, 0600);
+
+static struct kobj_attribute damos_sysfs_dest_weight_attr =
+		__ATTR_RW_MODE(weight, 0600);
+
+static struct attribute *damos_sysfs_dest_attrs[] = {
+	&damos_sysfs_dest_id_attr.attr,
+	&damos_sysfs_dest_weight_attr.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(damos_sysfs_dest);
+
+static const struct kobj_type damos_sysfs_dest_ktype = {
+	.release = damos_sysfs_dest_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = damos_sysfs_dest_groups,
+};
+
+/*
+ * dests (action destinations) directory
+ */
+
+struct damos_sysfs_dests {
+	struct kobject kobj;
+	struct damos_sysfs_dest **dests_arr;
+	int nr;
+};
+
+static struct damos_sysfs_dests *
+damos_sysfs_dests_alloc(void)
+{
+	return kzalloc(sizeof(struct damos_sysfs_dests), GFP_KERNEL);
+}
+
+static void damos_sysfs_dests_rm_dirs(
+		struct damos_sysfs_dests *dests)
+{
+	struct damos_sysfs_dest **dests_arr = dests->dests_arr;
+	int i;
+
+	for (i = 0; i < dests->nr; i++)
+		kobject_put(&dests_arr[i]->kobj);
+	dests->nr = 0;
+	kfree(dests_arr);
+	dests->dests_arr = NULL;
+}
+
+static int damos_sysfs_dests_add_dirs(
+		struct damos_sysfs_dests *dests, int nr_dests)
+{
+	struct damos_sysfs_dest **dests_arr, *dest;
+	int err, i;
+
+	damos_sysfs_dests_rm_dirs(dests);
+	if (!nr_dests)
+		return 0;
+
+	dests_arr = kmalloc_array(nr_dests, sizeof(*dests_arr),
+			GFP_KERNEL | __GFP_NOWARN);
+	if (!dests_arr)
+		return -ENOMEM;
+	dests->dests_arr = dests_arr;
+
+	for (i = 0; i < nr_dests; i++) {
+		dest = damos_sysfs_dest_alloc();
+		if (!dest) {
+			damos_sysfs_dests_rm_dirs(dests);
+			return -ENOMEM;
+		}
+
+		err = kobject_init_and_add(&dest->kobj,
+				&damos_sysfs_dest_ktype,
+				&dests->kobj, "%d", i);
+		if (err) {
+			kobject_put(&dest->kobj);
+			damos_sysfs_dests_rm_dirs(dests);
+			return err;
+		}
+
+		dests_arr[i] = dest;
+		dests->nr++;
+	}
+	return 0;
+}
+
+static ssize_t nr_dests_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damos_sysfs_dests *dests = container_of(kobj,
+			struct damos_sysfs_dests, kobj);
+
+	return sysfs_emit(buf, "%d\n", dests->nr);
+}
+
+static ssize_t nr_dests_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damos_sysfs_dests *dests;
+	int nr, err = kstrtoint(buf, 0, &nr);
+
+	if (err)
+		return err;
+	if (nr < 0)
+		return -EINVAL;
+
+	dests = container_of(kobj, struct damos_sysfs_dests, kobj);
+
+	if (!mutex_trylock(&damon_sysfs_lock))
+		return -EBUSY;
+	err = damos_sysfs_dests_add_dirs(dests, nr);
+	mutex_unlock(&damon_sysfs_lock);
+	if (err)
+		return err;
+
+	return count;
+}
+
+static void damos_sysfs_dests_release(struct kobject *kobj)
+{
+	kfree(container_of(kobj, struct damos_sysfs_dests, kobj));
+}
+
+static struct kobj_attribute damos_sysfs_dests_nr_attr =
+		__ATTR_RW_MODE(nr_dests, 0600);
+
+static struct attribute *damos_sysfs_dests_attrs[] = {
+	&damos_sysfs_dests_nr_attr.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(damos_sysfs_dests);
+
+static const struct kobj_type damos_sysfs_dests_ktype = {
+	.release = damos_sysfs_dests_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = damos_sysfs_dests_groups,
+};
+
 /*
  * scheme directory
  */
@@ -1672,6 +1870,7 @@ struct damon_sysfs_scheme {
 	struct damon_sysfs_stats *stats;
 	struct damon_sysfs_scheme_regions *tried_regions;
 	int target_nid;
+	struct damos_sysfs_dests *dests;
 };
 
 struct damos_sysfs_action_name {
@@ -1762,6 +1961,22 @@ static int damon_sysfs_scheme_set_access_pattern(
 	return err;
 }
 
+static int damos_sysfs_set_dests(struct damon_sysfs_scheme *scheme)
+{
+	struct damos_sysfs_dests *dests = damos_sysfs_dests_alloc();
+	int err;
+
+	if (!dests)
+		return -ENOMEM;
+	err = kobject_init_and_add(&dests->kobj, &damos_sysfs_dests_ktype,
+			&scheme->kobj, "dests");
+	if (err)
+		kobject_put(&dests->kobj);
+	else
+		scheme->dests = dests;
+	return err;
+}
+
 static int damon_sysfs_scheme_set_quotas(struct damon_sysfs_scheme *scheme)
 {
 	struct damon_sysfs_quotas *quotas = damon_sysfs_quotas_alloc();
@@ -1894,9 +2109,12 @@ static int damon_sysfs_scheme_add_dirs(struct damon_sysfs_scheme *scheme)
 	err = damon_sysfs_scheme_set_access_pattern(scheme);
 	if (err)
 		return err;
-	err = damon_sysfs_scheme_set_quotas(scheme);
+	err = damos_sysfs_set_dests(scheme);
 	if (err)
 		goto put_access_pattern_out;
+	err = damon_sysfs_scheme_set_quotas(scheme);
+	if (err)
+		goto put_dests_out;
 	err = damon_sysfs_scheme_set_watermarks(scheme);
 	if (err)
 		goto put_quotas_access_pattern_out;
@@ -1927,6 +2145,9 @@ static int damon_sysfs_scheme_add_dirs(struct damon_sysfs_scheme *scheme)
 put_quotas_access_pattern_out:
 	kobject_put(&scheme->quotas->kobj);
 	scheme->quotas = NULL;
+put_dests_out:
+	kobject_put(&scheme->dests->kobj);
+	scheme->dests = NULL;
 put_access_pattern_out:
 	kobject_put(&scheme->access_pattern->kobj);
 	scheme->access_pattern = NULL;
@@ -1937,6 +2158,8 @@ static void damon_sysfs_scheme_rm_dirs(struct damon_sysfs_scheme *scheme)
 {
 	damon_sysfs_access_pattern_rm_dirs(scheme->access_pattern);
 	kobject_put(&scheme->access_pattern->kobj);
+	kobject_put(&scheme->dests->kobj);
+	damos_sysfs_dests_rm_dirs(scheme->dests);
 	damon_sysfs_quotas_rm_dirs(scheme->quotas);
 	kobject_put(&scheme->quotas->kobj);
 	kobject_put(&scheme->watermarks->kobj);
-- 
2.39.5

