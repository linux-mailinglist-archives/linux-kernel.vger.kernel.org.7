Return-Path: <linux-kernel+bounces-615316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F83FA97B98
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 02:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC0697A7BA1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 00:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E45618859B;
	Wed, 23 Apr 2025 00:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gianis.ca header.i=@gianis.ca header.b="Mw3kicoE"
Received: from mail-24421.protonmail.ch (mail-24421.protonmail.ch [109.224.244.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620CF188CAE
	for <linux-kernel@vger.kernel.org>; Wed, 23 Apr 2025 00:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745367365; cv=none; b=DuM2+Su2voZBG+veP5SoIyZOMOPEbu6K++AZdg9fcqG4wmM+mOQG5W6akJ6cXr5b8+OCDnxYpUF7zRjgohZKKKEHh393y2LrcGA/T5+vzpci+8K6UVhtO6q7NNrqzhr58GTbKPycNthhL/jsxdmi9BiSkz8/GbzNRiN/fZcQKVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745367365; c=relaxed/simple;
	bh=u8Z5R0QA4gItc9VX2wxRVn8XV9zaRgxbHz9FK6zpW+k=;
	h=Date:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=YFmtkXpqENGZGc9rGHasUec1/PmiOI3tqjZlbAyyLS1ggsKN2CDFyk9pApduDa8a5/RGvkvQXAaYI/wXHxljbduLZU2xk3l3Vd3JyoqI8iLALuLGkIaB6qN20UWRKRh2NKKoxjI11qxL4SK8wnUU6d39FFqHwnwolS3Yz2yK0hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gianis.ca; spf=pass smtp.mailfrom=gianis.ca; dkim=pass (2048-bit key) header.d=gianis.ca header.i=@gianis.ca header.b=Mw3kicoE; arc=none smtp.client-ip=109.224.244.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gianis.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gianis.ca
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gianis.ca;
	s=protonmail; t=1745367355; x=1745626555;
	bh=H2o6FRPw4nBwVmK3A51l5DQULJnyJvDpaxpbpGU1ZuA=;
	h=Date:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=Mw3kicoExM0Q6I4wzqMTwdUn44JVLe4UwVe1nqtT2eekGu0HoqV0swTXgD5YAYUu9
	 VwwBHQuDHTkySAEJD1rqq6k2vjiHL0RQf9f75H6gYxibZ2/9IQ92Gde6d11frs87ZM
	 YDeUoE03H6EwYxAcmTYvCf2SRr6Qiayngt7egJxqENRpAiP6lkL/nZ7YW+7gXIIcDa
	 sYStxdW5G8nEzzYRu5DCANECUJzj9g0A4lTQpeT/V2j5zamyIKZCErtwtFqIo2kGCL
	 81R68wcBgN9oSWz+gmrNZuHaaLjJ5ail+oqg2oVHtDVViNKZzvaw9CUabNoLrFT58B
	 +GsTxoq1hPljg==
Date: Wed, 23 Apr 2025 00:15:50 +0000
From: "Dhaval Giani (AMD)" <dhaval@gianis.ca>
Cc: linux-kernel@vger.kernel.org, Dhaval Giani <dhaval.giani@amd.com>, Gautham Shenoy <gautham.shenoy@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>, "Dhaval Giani (AMD)" <dhaval@gianis.ca>
Subject: [PATCH 3/3] sched/fair: Test that the average lag across the system is zero
Message-ID: <20250422-b4-eevdf-tests-v1-post-v1-3-5b174f040f55@gianis.ca>
Feedback-ID: 128275035:user:proton
X-Pm-Message-ID: bd0775d2d78db8e93f46e35f71438858638fb6af
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Lemma 2 of the EEVDF paper says that the sum of lags of all the
tasks in the system is zero.

The test is slightly different - the sum of lag across a runqueue is
zero.

The linux EEVDF implementation doesn't track a global vruntime.
Instead it tracks the "zero-lag" vruntime. This can be obtained by
calling avg_vruntime(cfs_rq).

Walk through every single CFS runqueue (per CPU as well as per-cgroup),
and add up the vruntimes. The average should be the same as
avg_vruntime.

Signed-off-by: Dhaval Giani (AMD) <dhaval@gianis.ca>
---
 include/linux/sched.h      |   7 ++
 kernel/sched/eevdf-tests.c | 174 +++++++++++++++++++++++++++++++++++++++++=
++++
 kernel/sched/fair.c        |   3 +
 3 files changed, 184 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index f96ac198289349199b9c671240a20fc7826228ad..72788d51912657919adfad7f451=
983e80be4fa39 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -610,6 +610,13 @@ struct sched_entity {
 =09 */
 =09struct sched_avg=09=09avg;
 #endif
+#ifdef CONFIG_SCHED_EEVDF_TESTING
+=09/*
+=09 * Add a list element so that we don't recurse
+=09 * in the EEVDF unit test
+=09 */
+=09struct list_head tg_entry;
+#endif
 };
=20
 struct sched_rt_entity {
diff --git a/kernel/sched/eevdf-tests.c b/kernel/sched/eevdf-tests.c
index 8532330769bcc93dbf9cd98ebba75c838f62c045..c343e94b9a44ad32d01a0eedcb6=
1c1bbf5fdbaf6 100644
--- a/kernel/sched/eevdf-tests.c
+++ b/kernel/sched/eevdf-tests.c
@@ -24,6 +24,35 @@
 bool eevdf_positive_lag_test;
 u8 eevdf_positive_lag_count =3D 10;
=20
+static int test_total_zero_lag(void *);
+static void launch_test_zero_lag(void);
+
+static int eevdf_zero_lag_show(struct seq_file *m, void *v)
+{
+=09return 0;
+}
+
+static int eevdf_zero_lag_open(struct inode *inode, struct file *filp)
+{
+=09return single_open(filp, eevdf_zero_lag_show, NULL);
+}
+
+static ssize_t eevdf_zero_lag_write(struct file *filp, const char __user *=
ubuf,
+=09=09=09=09   size_t cnt, loff_t *ppos)
+{
+=09launch_test_zero_lag();
+=09return 1;
+
+}
+
+static const struct file_operations eevdf_zero_lag_fops =3D {
+=09.open=09=09=3D eevdf_zero_lag_open,
+=09.write=09=09=3D eevdf_zero_lag_write,
+=09.read=09=09=3D seq_read,
+=09.llseek=09=09=3D seq_lseek,
+=09.release=09=3D single_release,
+};
+
 static struct dentry *debugfs_eevdf_testing;
 void debugfs_eevdf_testing_init(struct dentry *debugfs_sched)
 {
@@ -33,6 +62,8 @@ void debugfs_eevdf_testing_init(struct dentry *debugfs_sc=
hed)
 =09=09=09=09debugfs_eevdf_testing, &eevdf_positive_lag_test);
 =09debugfs_create_u8("eevdf_positive_lag_test_count", 0600,
 =09=09=09=09debugfs_eevdf_testing, &eevdf_positive_lag_count);
+=09debugfs_create_file("eevdf_zero_lag_test", 0700, debugfs_eevdf_testing,
+=09=09=09=09NULL, &eevdf_zero_lag_fops);
=20
 }
=20
@@ -65,4 +96,147 @@ void test_eevdf_positive_lag(struct cfs_rq *cfs, struct=
 sched_entity *se)
 =09}
 }
=20
+/*
+ * we do, what we need to do
+ */
+#define __node_2_se(node) \
+=09rb_entry((node), struct sched_entity, run_node)
+
+static bool test_eevdf_cfs_rq_zero_lag(struct cfs_rq *cfs, struct list_hea=
d *tg_se)
+{
+=09u64 cfs_avg_vruntime;
+=09u64 calculated_avg_vruntime;
+
+=09u64 total_vruntime =3D 0;
+=09u64 nr_tasks =3D 0;
+
+=09struct sched_entity *se;
+=09struct rb_node *node;
+=09struct rb_root *root;
+
+=09cfs_avg_vruntime =3D avg_vruntime(cfs);
+
+=09/*
+=09 * Walk through the rb tree -> look at the se->vruntime value and add i=
t
+=09 */
+
+=09total_vruntime =3D 0;
+=09nr_tasks =3D 0;
+
+=09root =3D &cfs->tasks_timeline.rb_root;
+
+=09for (node =3D rb_first(root); node; node =3D rb_next(node)) {
+=09=09se =3D __node_2_se(node);
+=09=09WARN_ON_ONCE(__builtin_add_overflow(total_vruntime,
+=09=09=09=09=09se->vruntime, &total_vruntime));
+=09=09/*
+=09=09 * if it is a task group, add to a list to look at later
+=09=09 */
+=09=09if (!entity_is_task(se))
+=09=09=09list_add_tail(&se->tg_entry, tg_se);
+=09=09nr_tasks++;
+=09}
+
+=09if (cfs->curr) {
+=09=09WARN_ON_ONCE(__builtin_add_overflow(total_vruntime,
+=09=09=09=09=09cfs->curr->vruntime, &total_vruntime));
+=09=09nr_tasks++;
+=09}
+
+=09/* If there are no tasks, there is no lag :-) */
+=09if (!nr_tasks)
+=09=09return true;
+
+=09calculated_avg_vruntime =3D total_vruntime / nr_tasks;
+
+=09return (calculated_avg_vruntime =3D=3D cfs_avg_vruntime);
+
+}
+
+/*
+ * Call with rq lock held
+ *
+ * return false on failure
+ */
+static bool test_eevdf_zero_lag(struct cfs_rq *cfs)
+{
+=09struct list_head tg_se =3D LIST_HEAD_INIT(tg_se);
+=09struct list_head *se_entry;
+
+=09/*
+=09 * The base CFS runqueue will always have sched entities queued.
+=09 * Test it, and start populating the tg_se list.
+=09 *
+=09 * If it fails, short circuit and return fail.
+=09 */
+
+=09if (!test_eevdf_cfs_rq_zero_lag(cfs, &tg_se))
+=09=09return false;
+
+=09/*
+=09 * We made it here, let's walk through the list. Since it is
+=09 * setup as a queue, as we continue calling the rq test, it
+=09 * will add new task_groups to the list. Once drained, if we
+=09 * haven't failed, we will return true.
+=09 */
+
+=09list_for_each(se_entry, &tg_se) {
+=09=09struct sched_entity *se =3D list_entry(se_entry, struct sched_entity=
, tg_entry);
+
+=09=09if (!test_eevdf_cfs_rq_zero_lag(group_cfs_rq(se), &tg_se))
+=09=09=09return false;
+=09}
+
+=09/*
+=09 * WOOT! We succeeded!
+=09 */
+=09return true;
+
+}
+
+/*
+ * The average vruntime of the entire cfs_rq should be equal
+ * to the avg_vruntime(cfs_rq)
+ */
+static int test_total_zero_lag(void *data)
+{
+=09int cpu;
+=09struct rq *rq;
+=09struct cfs_rq *cfs;
+=09bool success =3D false;
+
+=09for_each_online_cpu(cpu) {
+
+=09=09rq =3D cpu_rq(cpu);
+=09=09guard(rq_lock_irq)(rq);
+
+=09=09cfs =3D &rq->cfs;
+
+=09=09success =3D test_eevdf_zero_lag(cfs);
+
+=09=09if (!success)
+=09=09=09break;
+=09}
+=09if (!success) {
+=09=09trace_printk("FAILED: tracked average vruntime doesn't match calcula=
ted average vruntime\n");
+=09=09return -1;
+=09}
+=09trace_printk("PASS: Tracked average runtime matches calculated average =
vruntime\n");
+=09return 0;
+}
+
+static void launch_test_zero_lag(void)
+{
+=09struct task_struct *kt;
+
+=09kt =3D kthread_create(&test_total_zero_lag, NULL, "eevdf-tester-%d",
+=09=09=09=09=09smp_processor_id());
+=09if (!kt) {
+=09=09trace_printk("Failed to launch kthread\n");
+=09=09return;
+=09}
+
+=09wake_up_process(kt);
+}
+
 #endif /* CONFIG_SCHED_EEVDF_TESTING */
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 924d9d35c2aa937bc0f4ca9565ba774397b90f77..858c4e1b8fac661996d879a8dca=
b2776db09d1c8 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -13473,6 +13473,9 @@ void init_tg_cfs_entry(struct task_group *tg, struc=
t cfs_rq *cfs_rq,
 =09/* guarantee group entities always have weight */
 =09update_load_set(&se->load, NICE_0_LOAD);
 =09se->parent =3D parent;
+#ifdef CONFIG_SCHED_EEVDF_TESTING
+=09INIT_LIST_HEAD(&(se->group_node));
+#endif
 }
=20
 static DEFINE_MUTEX(shares_mutex);

--=20
2.49.0



