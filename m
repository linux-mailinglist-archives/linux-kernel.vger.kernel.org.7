Return-Path: <linux-kernel+bounces-760553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5492B1ECC2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 18:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6D021896222
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 16:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37C2287501;
	Fri,  8 Aug 2025 16:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jtmjrrz6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD48286D69
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 16:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754668935; cv=none; b=fiK3URz99oyfc/mi3CDHcPrXZZ5lboo2dfoUfvWWkmZ+PUI5JNb4/NujLtCSSO1jjHTXQr6GR6rdNsOjE+jiN3p6qJpqCOXjJlU+6N+rbWF0GdHW7RuALPY7h2kAQtfcI3Rir4Ks6yqAq9mY1p+1s+oJhVvzPgVjWG07vhJQZns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754668935; c=relaxed/simple;
	bh=KRV1uXGYcZHkF1428JaQE47itvL659ZCiDzud4k4Es8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BDe3KqQeaFXrbDosu2DXXEyy1ijJ9lYwVSEgSge9+yLwZjsT9WdKNWcqd9SZtdFC73n232IGuWYS2QylNBLcWbaQdmrTSjumjoO2Z2aDf620g1mw9o+ZmCajuOA8hU0Ekssa3k0G1Bh9EtU48wVF+ew2Ax/5pHkOmx/Rc4Q2nxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jtmjrrz6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754668932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OVLkMLH39nJ6vOhn8AQhGRkWMGBi+XodCwJjcIzIfGw=;
	b=Jtmjrrz6KEl/qtodmwcFlE3OzoFZavU96HcDBiXPcqWCEbQS0zFZY2GM8dOGZGf/QI/U6s
	M4r4GUe8+y89Nn/uBhzI6FIZKYDlMLA/KXUVTPHsnndgmKAiqjQF4sn6l/f9Lmkr+vYBhw
	CeIQjMPJGXwVr6ThWqpCHULGv4i1vvA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-6-q13J7bCsMGOHUrYIyPKQIQ-1; Fri,
 08 Aug 2025 12:02:09 -0400
X-MC-Unique: q13J7bCsMGOHUrYIyPKQIQ-1
X-Mimecast-MFC-AGG-ID: q13J7bCsMGOHUrYIyPKQIQ_1754668928
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8980A180035C;
	Fri,  8 Aug 2025 16:02:08 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.45.224.121])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 91AFD19560B0;
	Fri,  8 Aug 2025 16:02:05 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH v11 5/8] cgroup/cpuset: Rename update_unbound_workqueue_cpumask() to update_exclusion_cpumasks()
Date: Fri,  8 Aug 2025 18:01:39 +0200
Message-ID: <20250808160142.103852-6-gmonaco@redhat.com>
In-Reply-To: <20250808160142.103852-1-gmonaco@redhat.com>
References: <20250808160142.103852-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

update_unbound_workqueue_cpumask() updates unbound workqueues settings
when there's a change in isolated CPUs, but it can be used for other
subsystems requiring updated when isolated CPUs change.

Generalise the name to update_exclusion_cpumasks() to prepare for other
functions unrelated to workqueues to be called in that spot.

Acked-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Waiman Long <longman@redhat.com>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 kernel/cgroup/cpuset.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 3bc4301466f3..6e3f44ffaa21 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1339,7 +1339,7 @@ static bool partition_xcpus_del(int old_prs, struct cpuset *parent,
 	return isolcpus_updated;
 }
 
-static void update_unbound_workqueue_cpumask(bool isolcpus_updated)
+static void update_exclusion_cpumasks(bool isolcpus_updated)
 {
 	int ret;
 
@@ -1470,7 +1470,7 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
 	list_add(&cs->remote_sibling, &remote_children);
 	cpumask_copy(cs->effective_xcpus, tmp->new_cpus);
 	spin_unlock_irq(&callback_lock);
-	update_unbound_workqueue_cpumask(isolcpus_updated);
+	update_exclusion_cpumasks(isolcpus_updated);
 	cpuset_force_rebuild();
 	cs->prs_err = 0;
 
@@ -1511,7 +1511,7 @@ static void remote_partition_disable(struct cpuset *cs, struct tmpmasks *tmp)
 	compute_effective_exclusive_cpumask(cs, NULL, NULL);
 	reset_partition_data(cs);
 	spin_unlock_irq(&callback_lock);
-	update_unbound_workqueue_cpumask(isolcpus_updated);
+	update_exclusion_cpumasks(isolcpus_updated);
 	cpuset_force_rebuild();
 
 	/*
@@ -1580,7 +1580,7 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *xcpus,
 	if (xcpus)
 		cpumask_copy(cs->exclusive_cpus, xcpus);
 	spin_unlock_irq(&callback_lock);
-	update_unbound_workqueue_cpumask(isolcpus_updated);
+	update_exclusion_cpumasks(isolcpus_updated);
 	if (adding || deleting)
 		cpuset_force_rebuild();
 
@@ -1943,7 +1943,7 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 		WARN_ON_ONCE(parent->nr_subparts < 0);
 	}
 	spin_unlock_irq(&callback_lock);
-	update_unbound_workqueue_cpumask(isolcpus_updated);
+	update_exclusion_cpumasks(isolcpus_updated);
 
 	if ((old_prs != new_prs) && (cmd == partcmd_update))
 		update_partition_exclusive_flag(cs, new_prs);
@@ -2968,7 +2968,7 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 	else if (isolcpus_updated)
 		isolated_cpus_update(old_prs, new_prs, cs->effective_xcpus);
 	spin_unlock_irq(&callback_lock);
-	update_unbound_workqueue_cpumask(isolcpus_updated);
+	update_exclusion_cpumasks(isolcpus_updated);
 
 	/* Force update if switching back to member & update effective_xcpus */
 	update_cpumasks_hier(cs, &tmpmask, !new_prs);
-- 
2.50.1


