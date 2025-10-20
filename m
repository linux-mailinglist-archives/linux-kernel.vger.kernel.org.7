Return-Path: <linux-kernel+bounces-860744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F9DBF0D56
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 13:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D1524050AF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6EBF2FB997;
	Mon, 20 Oct 2025 11:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dFVsB7aF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F07B2FB984
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 11:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760959710; cv=none; b=EfRzcZi4lnVPNN7Rmca4EPRSTmVgzC4ukkiUk3uXMgyz0ICA5SKYcXL3H0muspwmQlpjoQKlSkKI2zWLfIoeHy7FV/zwic+nYbCu8zdtWyOP3ehbPTeWCQBU4gUGB7sKoZSulLRgbFIwp9dTiXkqQJN2GEA2vKTJsvRQqJ0rlSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760959710; c=relaxed/simple;
	bh=qqL0xd5Ths2kxQKtBZXK4wNnssAEk1Gg9J+kbi3xqLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g33uyn2gTgL12aHuM5JuVPiO6iZCqbUt/g4CZvrP1lahkAke5zCuSqPw5kMdmrIgXIkDdZzkIB5CWjxY8l9fzUSxZfRt3aCXvDENhK0gNJ4JuQXm5++v0eKblyX8SbM9vx8osvrqXRtJ9+Z3Gwh6WAk59/A5yhUF7XtP6AZUVxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dFVsB7aF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760959707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qWFkbrZNMKAxx/Qbp/4Qg2hhNcpaHFzseFMl2p+1Nc8=;
	b=dFVsB7aFIW98adaIZkSNVWA7C4l47xEz+GL+HWQHW2kVTwSamTxdmsoWRQ9TFI1Umv/vr4
	MIqG7u81MNwVlBTrhGzKfCBYgRdX/mUybSrrGEWekDYLEmtRKNz8XhslzddqPM/FW3z8bw
	YQf4X1cVKkzHb75nWIUByul8q09JPa4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-67-UPgIXhB0MyqouokjPzqiKA-1; Mon,
 20 Oct 2025 07:28:25 -0400
X-MC-Unique: UPgIXhB0MyqouokjPzqiKA-1
X-Mimecast-MFC-AGG-ID: UPgIXhB0MyqouokjPzqiKA_1760959704
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1BB221956048;
	Mon, 20 Oct 2025 11:28:24 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.44.34.114])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9B7871955F1B;
	Mon, 20 Oct 2025 11:28:21 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>
Subject: [RESEND PATCH v13 5/9] cgroup/cpuset: Rename update_unbound_workqueue_cpumask() to update_exclusion_cpumasks()
Date: Mon, 20 Oct 2025 13:27:58 +0200
Message-ID: <20251020112802.102451-6-gmonaco@redhat.com>
In-Reply-To: <20251020112802.102451-1-gmonaco@redhat.com>
References: <20251020112802.102451-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

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
index 52468d2c178a..217480e01be6 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1391,7 +1391,7 @@ static bool partition_xcpus_del(int old_prs, struct cpuset *parent,
 	return isolcpus_updated;
 }
 
-static void update_unbound_workqueue_cpumask(bool isolcpus_updated)
+static void update_exclusion_cpumasks(bool isolcpus_updated)
 {
 	int ret;
 
@@ -1555,7 +1555,7 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
 	list_add(&cs->remote_sibling, &remote_children);
 	cpumask_copy(cs->effective_xcpus, tmp->new_cpus);
 	spin_unlock_irq(&callback_lock);
-	update_unbound_workqueue_cpumask(isolcpus_updated);
+	update_exclusion_cpumasks(isolcpus_updated);
 	cpuset_force_rebuild();
 	cs->prs_err = 0;
 
@@ -1596,7 +1596,7 @@ static void remote_partition_disable(struct cpuset *cs, struct tmpmasks *tmp)
 	compute_excpus(cs, cs->effective_xcpus);
 	reset_partition_data(cs);
 	spin_unlock_irq(&callback_lock);
-	update_unbound_workqueue_cpumask(isolcpus_updated);
+	update_exclusion_cpumasks(isolcpus_updated);
 	cpuset_force_rebuild();
 
 	/*
@@ -1665,7 +1665,7 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *xcpus,
 	if (xcpus)
 		cpumask_copy(cs->exclusive_cpus, xcpus);
 	spin_unlock_irq(&callback_lock);
-	update_unbound_workqueue_cpumask(isolcpus_updated);
+	update_exclusion_cpumasks(isolcpus_updated);
 	if (adding || deleting)
 		cpuset_force_rebuild();
 
@@ -2023,7 +2023,7 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 		WARN_ON_ONCE(parent->nr_subparts < 0);
 	}
 	spin_unlock_irq(&callback_lock);
-	update_unbound_workqueue_cpumask(isolcpus_updated);
+	update_exclusion_cpumasks(isolcpus_updated);
 
 	if ((old_prs != new_prs) && (cmd == partcmd_update))
 		update_partition_exclusive_flag(cs, new_prs);
@@ -3043,7 +3043,7 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 	else if (isolcpus_updated)
 		isolated_cpus_update(old_prs, new_prs, cs->effective_xcpus);
 	spin_unlock_irq(&callback_lock);
-	update_unbound_workqueue_cpumask(isolcpus_updated);
+	update_exclusion_cpumasks(isolcpus_updated);
 
 	/* Force update if switching back to member & update effective_xcpus */
 	update_cpumasks_hier(cs, &tmpmask, !new_prs);
-- 
2.51.0


