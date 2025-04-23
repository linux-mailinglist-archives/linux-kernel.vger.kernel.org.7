Return-Path: <linux-kernel+bounces-615309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 418F8A97B89
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 02:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48C947AB93F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 00:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369AFA934;
	Wed, 23 Apr 2025 00:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gianis.ca header.i=@gianis.ca header.b="Dtyycq5u"
Received: from mail-4323.protonmail.ch (mail-4323.protonmail.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD84E7464
	for <linux-kernel@vger.kernel.org>; Wed, 23 Apr 2025 00:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745367077; cv=none; b=tPSaeX6kLOcitObGUgzZN5U3IW7vZFT17UyGn8j2MP8sSeRO85aOFtDm481nrFxfqPrgHS5NDf1cSLa9kPCXWZsxxWfsV3LUyXlOQWjxr3WTGNpQYuNrBJiZ0Y9UKlqTaFRT/MaHND7aMvSpx2ANySltA3jtWl/yuCguDYAZVYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745367077; c=relaxed/simple;
	bh=ncYF7mQ18ku9avEz0s0V9Bi1M8/iFnVAJ2r7P4YLiB8=;
	h=Date:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TTuMPJ13zdrnndNqAfSddQgwXMnLfjW6ujGF81u9DvxgqouN++swPbqDaei69Fhvi2SIJO98EXTH/WjqoXKTHwZN2U6mbBL/T1iPeDNedQzUO0BvzDYPbmr1FPTOsceWmRPFGwU2sEO/wM19J63CNA0Xy25mQ+BYOqioRMF5kjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gianis.ca; spf=pass smtp.mailfrom=gianis.ca; dkim=pass (2048-bit key) header.d=gianis.ca header.i=@gianis.ca header.b=Dtyycq5u; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gianis.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gianis.ca
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gianis.ca;
	s=protonmail; t=1745367073; x=1745626273;
	bh=cD3P74vF51V9I6kK3R4QQw3nCNaKIo/xfLpioobLPYk=;
	h=Date:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=Dtyycq5uoQQRjZrGMlENiqpfEz3PHKfaic17gA60f3molvkqk6qy1RB99XzF7sj82
	 B6Y2jflS5Wh5IWoMxpBaxDQtg0SFsrNUBbEV9byEFxlNMKJVmHVJRdIZeHlt9jISVv
	 IbChIxqEh017bn1UV0Tb7PzaXT8G4a7qJ5K5ZlDyGUQkxbp2y1eVpx78MbuYj63lET
	 XL11NXW5N0Y7mQ0R6to3/hxesciWjss+zoaa8kH3P3YDb8R2VtiTy/Q5SqlS4ljmJi
	 vmHW/pxrOxuy0ipLRJOTACsdL+Fp6iaZ/HhYSE6TmOesFdsMq8fAZYZrJ62EIXfWgU
	 N2bIZt2i7l99Q==
Date: Wed, 23 Apr 2025 00:11:07 +0000
From: "Dhaval Giani (AMD)" <dhaval@gianis.ca>
Cc: linux-kernel@vger.kernel.org, Dhaval Giani <dhaval.giani@amd.com>, Gautham Shenoy <gautham.shenoy@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>, "Dhaval Giani (AMD)" <dhaval@gianis.ca>
Subject: [PATCH 2/3] sched/fair: Add a test to test that a task selected to run has positive lag
Message-ID: <20250422-b4-eevdf-tests-v1-post-v1-2-d005d1c7cf61@gianis.ca>
In-Reply-To: <20250422-b4-eevdf-tests-v1-post-v1-0-d005d1c7cf61@gianis.ca>
References: <20250422-b4-eevdf-tests-v1-post-v1-0-d005d1c7cf61@gianis.ca>
Feedback-ID: 128275035:user:proton
X-Pm-Message-ID: 97966b307d62f686dac772d5a60b8f924fbaa7c7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Lemma 1 from the original EEVDF paper says that any task that
has a positive lag is eligible to run.

This test tests the opposite - any task that is picked to run must
have a positive lag for it to be eligible to run.

Signed-off-by: Dhaval Giani (AMD) <dhaval@gianis.ca>
---
 kernel/sched/eevdf-tests.c | 41 +++++++++++++++++++++++++++++++++++++++++
 kernel/sched/fair.c        |  2 ++
 kernel/sched/sched.h       |  2 ++
 3 files changed, 45 insertions(+)

diff --git a/kernel/sched/eevdf-tests.c b/kernel/sched/eevdf-tests.c
index 3bc016d3025733e53f586e30fcd31f650156d47e..8532330769bcc93dbf9cd98ebba=
75c838f62c045 100644
--- a/kernel/sched/eevdf-tests.c
+++ b/kernel/sched/eevdf-tests.c
@@ -18,10 +18,51 @@
=20
 #ifdef CONFIG_SCHED_EEVDF_TESTING
=20
+/*
+ * Test parameters
+ */
+bool eevdf_positive_lag_test;
+u8 eevdf_positive_lag_count =3D 10;
+
 static struct dentry *debugfs_eevdf_testing;
 void debugfs_eevdf_testing_init(struct dentry *debugfs_sched)
 {
 =09debugfs_eevdf_testing =3D debugfs_create_dir("eevdf-testing", debugfs_s=
ched);
=20
+=09debugfs_create_bool("eevdf_positive_lag_test", 0700,
+=09=09=09=09debugfs_eevdf_testing, &eevdf_positive_lag_test);
+=09debugfs_create_u8("eevdf_positive_lag_test_count", 0600,
+=09=09=09=09debugfs_eevdf_testing, &eevdf_positive_lag_count);
+
 }
+
+void test_eevdf_positive_lag(struct cfs_rq *cfs, struct sched_entity *se)
+{
+=09static int eevdf_positive_lag_test_counter;
+=09u64 eevdf_average_vruntime;
+
+=09if (!eevdf_positive_lag_test)
+=09=09return;
+
+=09if (!se || !cfs)
+=09=09return;
+
+=09eevdf_average_vruntime =3D avg_vruntime(cfs);
+=09eevdf_positive_lag_test_counter++;
+
+=09if (se->vruntime > eevdf_average_vruntime) {
+=09=09trace_printk("FAIL: Lemma 1 failed - selected task has negative lag\=
n");
+=09=09eevdf_positive_lag_test =3D 0;
+=09=09eevdf_positive_lag_test_counter =3D 0;
+=09=09return;
+=09}
+
+=09if (eevdf_positive_lag_test_counter > eevdf_positive_lag_count) {
+=09=09eevdf_positive_lag_test =3D 0;
+=09=09eevdf_positive_lag_test_counter =3D 0;
+=09=09trace_printk("PASS: At least %u selected tasks had positive lag\n",
+=09=09=09=09=09=09=09eevdf_positive_lag_count);
+=09}
+}
+
 #endif /* CONFIG_SCHED_EEVDF_TESTING */
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index eb5a2572b4f8b6b5517befc299312b6ae7476e88..924d9d35c2aa937bc0f4ca9565b=
a774397b90f77 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -980,6 +980,8 @@ static struct sched_entity *pick_eevdf(struct cfs_rq *c=
fs_rq)
 =09if (!best || (curr && entity_before(curr, best)))
 =09=09best =3D curr;
=20
+=09test_eevdf_positive_lag(cfs_rq, best);
+
 =09return best;
 }
=20
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 09cefe2aa871bbd533a413c76026895e969a58e7..5ad5e033e1c81167b712ab176d4=
d55e6b5d82d06 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3990,8 +3990,10 @@ void sched_enq_and_set_task(struct sched_enq_and_set=
_ctx *ctx);
=20
 #ifdef CONFIG_SCHED_EEVDF_TESTING
 void debugfs_eevdf_testing_init(struct dentry *debugfs_sched);
+void test_eevdf_positive_lag(struct cfs_rq *cfs, struct sched_entity *se);
 #else /* CONFIG_SCHED_EEVDF_TESTING */
 static inline void init_eevdf_testing_debugfs(struct dentry *debugfs_sched=
) {}
+static inline void test_eevdf_positive_lag(struct cfs_rq *cfs, struct sche=
d_entity *se) {}
 #endif /* CONFIG_SCHED_EEVDF_TESTING */
=20
 #endif /* _KERNEL_SCHED_SCHED_H */

--=20
2.49.0



