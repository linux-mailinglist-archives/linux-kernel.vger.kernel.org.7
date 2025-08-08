Return-Path: <linux-kernel+bounces-760555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22615B1ECC8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 18:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B248B189F605
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 16:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9AB2877D5;
	Fri,  8 Aug 2025 16:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZCsKZdlz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D48E2877D0
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 16:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754668942; cv=none; b=EoLS2KUpBA/jTOEr0mP5WbS3jOiqtcZ6UJs4rbAEHohnvs3XF/AYtJKU3/oXPMsT80oExdDQfkBIaSMTdt4nJFZLM9+ERkCv/UN9FBKBmEg/AAEbLK8ERV7A9U8xpq4n6xEOARTyU2qEuj68QxgR4es4HFJ1DrmdwV9BR2Vuk3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754668942; c=relaxed/simple;
	bh=CRY0+GnaBWrlfpe8iXJlxsyVpbGWBfiDOGycoYwQiYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rvk37rPg2uXZFBjGR+xlTmbmP8aIUiylQkhvIZLEBlsiCPWvLXEihhfsOl5J0sMA/qvh668cyFAhruUiiJpW/Jns7Yxn42hzzV1nEavpzcD7gwtq+6496vy9v/ChfvyrDU7klzJGzNOCDY0S+CDXsjOFB24JqMOGTMHcCxUqqpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZCsKZdlz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754668940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c/4Yb/ZEMmy5bdm/K/cc0fxTqmOnDgZxgOXUTfhox3U=;
	b=ZCsKZdlz3BOrdOe9nruORgAbCqjNgyfa154dGv/FGl/6X6AApOwd154JgXe9vfsc8O3w+I
	qd5BfD3s67bR+3WKyASCjx5MlHlSPfLSOgQ4dinFzRbesZJu86/gAehTaTZWF8WZ4ZG3IL
	fh1ayyKYzrrk/VSkblwpMoHWgRCdjkY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-59-KNcoY9opOqW9kwe3nGYI9w-1; Fri,
 08 Aug 2025 12:02:16 -0400
X-MC-Unique: KNcoY9opOqW9kwe3nGYI9w-1
X-Mimecast-MFC-AGG-ID: KNcoY9opOqW9kwe3nGYI9w_1754668935
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CBA3E18002D1;
	Fri,  8 Aug 2025 16:02:15 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.45.224.121])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 13A0A19560AD;
	Fri,  8 Aug 2025 16:02:12 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH v11 7/8] cgroup/cpuset: Fail if isolated and nohz_full don't leave any housekeeping
Date: Fri,  8 Aug 2025 18:01:41 +0200
Message-ID: <20250808160142.103852-8-gmonaco@redhat.com>
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

Currently the user can set up isolated cpus via cpuset and nohz_full in
such a way that leaves no housekeeping CPU (i.e. no CPU that is neither
domain isolated nor nohz full). This can be a problem for other
subsystems (e.g. the timer wheel imgration).

Prevent this configuration by blocking any assignation that would cause
the union of domain isolated cpus and nohz_full to covers all CPUs.

Acked-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 kernel/cgroup/cpuset.c | 57 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 6e3f44ffaa21..7b66ccedbc53 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1275,6 +1275,19 @@ static void isolated_cpus_update(int old_prs, int new_prs, struct cpumask *xcpus
 		cpumask_andnot(isolated_cpus, isolated_cpus, xcpus);
 }
 
+/*
+ * isolated_cpus_should_update - Returns if the isolated_cpus mask needs update
+ * @prs: new or old partition_root_state
+ * @parent: parent cpuset
+ * Return: true if isolated_cpus needs modification, false otherwise
+ */
+static bool isolated_cpus_should_update(int prs, struct cpuset *parent)
+{
+	if (!parent)
+		parent = &top_cpuset;
+	return prs != parent->partition_root_state;
+}
+
 /*
  * partition_xcpus_add - Add new exclusive CPUs to partition
  * @new_prs: new partition_root_state
@@ -1339,6 +1352,36 @@ static bool partition_xcpus_del(int old_prs, struct cpuset *parent,
 	return isolcpus_updated;
 }
 
+/*
+ * isolcpus_nohz_conflict - check for isolated & nohz_full conflicts
+ * @new_cpus: cpu mask for cpus that are going to be isolated
+ * Return: true if there is conflict, false otherwise
+ *
+ * If nohz_full is enabled and we have isolated CPUs, their combination must
+ * still leave housekeeping CPUs.
+ */
+static bool isolcpus_nohz_conflict(struct cpumask *new_cpus)
+{
+	cpumask_var_t full_hk_cpus;
+	int res = false;
+
+	if (!housekeeping_enabled(HK_TYPE_KERNEL_NOISE))
+		return false;
+
+	if (!alloc_cpumask_var(&full_hk_cpus, GFP_KERNEL))
+		return true;
+
+	cpumask_and(full_hk_cpus, housekeeping_cpumask(HK_TYPE_KERNEL_NOISE),
+		    housekeeping_cpumask(HK_TYPE_DOMAIN));
+	cpumask_andnot(full_hk_cpus, full_hk_cpus, isolated_cpus);
+	cpumask_and(full_hk_cpus, full_hk_cpus, cpu_online_mask);
+	if (!cpumask_weight_andnot(full_hk_cpus, new_cpus))
+		res = true;
+
+	free_cpumask_var(full_hk_cpus);
+	return res;
+}
+
 static void update_exclusion_cpumasks(bool isolcpus_updated)
 {
 	int ret;
@@ -1464,6 +1507,9 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
 	if (!cpumask_intersects(tmp->new_cpus, cpu_active_mask) ||
 	    cpumask_subset(top_cpuset.effective_cpus, tmp->new_cpus))
 		return PERR_INVCPUS;
+	if (isolated_cpus_should_update(new_prs, NULL) &&
+	    isolcpus_nohz_conflict(tmp->new_cpus))
+		return PERR_HKEEPING;
 
 	spin_lock_irq(&callback_lock);
 	isolcpus_updated = partition_xcpus_add(new_prs, NULL, tmp->new_cpus);
@@ -1563,6 +1609,9 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *xcpus,
 		else if (cpumask_intersects(tmp->addmask, subpartitions_cpus) ||
 			 cpumask_subset(top_cpuset.effective_cpus, tmp->addmask))
 			cs->prs_err = PERR_NOCPUS;
+		else if (isolated_cpus_should_update(prs, NULL) &&
+			 isolcpus_nohz_conflict(tmp->addmask))
+			cs->prs_err = PERR_HKEEPING;
 		if (cs->prs_err)
 			goto invalidate;
 	}
@@ -1914,6 +1963,12 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 			return err;
 	}
 
+	if (deleting && isolated_cpus_should_update(new_prs, parent) &&
+	    isolcpus_nohz_conflict(tmp->delmask)) {
+		cs->prs_err = PERR_HKEEPING;
+		return PERR_HKEEPING;
+	}
+
 	/*
 	 * Change the parent's effective_cpus & effective_xcpus (top cpuset
 	 * only).
@@ -2934,6 +2989,8 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 		 * Need to update isolated_cpus.
 		 */
 		isolcpus_updated = true;
+		if (isolcpus_nohz_conflict(cs->effective_xcpus))
+			err = PERR_HKEEPING;
 	} else {
 		/*
 		 * Switching back to member is always allowed even if it
-- 
2.50.1


