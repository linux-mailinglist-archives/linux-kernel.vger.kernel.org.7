Return-Path: <linux-kernel+bounces-639901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D32AAFDE9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 May 2025 16:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E820502193
	for <lists+linux-kernel@lfdr.de>; Thu,  8 May 2025 14:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E83278E60;
	Thu,  8 May 2025 14:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LuENHE88"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FBA278775
	for <linux-kernel@vger.kernel.org>; Thu,  8 May 2025 14:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746716077; cv=none; b=IlhWbzg0uZl3+9vxK8HDNTuXT8WhlV58EQ6c/C6JX8TLD/X1HluZWBLyWlhGWwrMyZKhEOVIq0mgybLmpyk2O1hVCLykaxbtOTH6Qpy5CkBTEbOaYvon2vmnvEyTADz+JTXCIfRXjPXCCNCU8OrRpXnPYNGrrDR0/Zlgc0CU0rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746716077; c=relaxed/simple;
	bh=jNHMUBieUxpJlfmVY/0xEnSqiAS37ZoXzrWTEDIVNxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A4Gu5GcKfSZuS8JjOpfn67Fv9e+EKxCbeIYtOe4uuIdYSj4lCd5Pwb5Dt+gCJWCYIpK4MrxKisUGCt01H8x01WiVl5udm6FTKlSBOCRCjJuHXcFAqmRQLIWdl3BNbGGrtDWmrPEyYby6xqzQGJ1jxZPIgBSrrhsDRmaZcEY7QNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LuENHE88; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746716074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xYurpaPkHLcArYh8ObWHXDz5BuMX5nBYx1TSFC5ANS8=;
	b=LuENHE88/fhVNhHDBoPH5WtudyVlRlfa1mAo1bVxNs7uxL1uiP8YblkPf2kTWMM2Bc8Lid
	k1wwY+/pxUerSJbtiF1SB8nG2lXZ8Hzh0U3X1yR2osI2SXD+XSvhlHHC3ogrzOKq76F3Xq
	EOvfJA4wrZOOCFtN2t1fXA9McTrBWI4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-58-vvSmxnc-PtmqlNQN29l4Gw-1; Thu,
 08 May 2025 10:54:30 -0400
X-MC-Unique: vvSmxnc-PtmqlNQN29l4Gw-1
X-Mimecast-MFC-AGG-ID: vvSmxnc-PtmqlNQN29l4Gw_1746716068
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B8547180048E;
	Thu,  8 May 2025 14:54:28 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.44.32.32])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 084F619560B3;
	Thu,  8 May 2025 14:54:25 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH v5 3/6] cgroup/cpuset: Rename update_unbound_workqueue_cpumask() to update_exclusion_cpumasks()
Date: Thu,  8 May 2025 16:53:23 +0200
Message-ID: <20250508145319.97794-11-gmonaco@redhat.com>
In-Reply-To: <20250508145319.97794-8-gmonaco@redhat.com>
References: <20250508145319.97794-8-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

update_unbound_workqueue_cpumask() updates unbound workqueues settings
when there's a change in isolated CPUs, but it can be used for other
subsystems requiring updated when isolated CPUs change.

Generalise the name to update_exclusion_cpumasks() to prepare for other
functions unrelated to workqueues to be called in that spot.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 kernel/cgroup/cpuset.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 306b60430091..95316d39c282 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1323,7 +1323,7 @@ static bool partition_xcpus_del(int old_prs, struct cpuset *parent,
 	return isolcpus_updated;
 }
 
-static void update_unbound_workqueue_cpumask(bool isolcpus_updated)
+static void update_exclusion_cpumasks(bool isolcpus_updated)
 {
 	int ret;
 
@@ -1454,7 +1454,7 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
 	list_add(&cs->remote_sibling, &remote_children);
 	cpumask_copy(cs->effective_xcpus, tmp->new_cpus);
 	spin_unlock_irq(&callback_lock);
-	update_unbound_workqueue_cpumask(isolcpus_updated);
+	update_exclusion_cpumasks(isolcpus_updated);
 	cpuset_force_rebuild();
 	cs->prs_err = 0;
 
@@ -1495,7 +1495,7 @@ static void remote_partition_disable(struct cpuset *cs, struct tmpmasks *tmp)
 	compute_effective_exclusive_cpumask(cs, NULL, NULL);
 	reset_partition_data(cs);
 	spin_unlock_irq(&callback_lock);
-	update_unbound_workqueue_cpumask(isolcpus_updated);
+	update_exclusion_cpumasks(isolcpus_updated);
 	cpuset_force_rebuild();
 
 	/*
@@ -1563,7 +1563,7 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *xcpus,
 	if (xcpus)
 		cpumask_copy(cs->exclusive_cpus, xcpus);
 	spin_unlock_irq(&callback_lock);
-	update_unbound_workqueue_cpumask(isolcpus_updated);
+	update_exclusion_cpumasks(isolcpus_updated);
 	if (adding || deleting)
 		cpuset_force_rebuild();
 
@@ -1906,7 +1906,7 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 		WARN_ON_ONCE(parent->nr_subparts < 0);
 	}
 	spin_unlock_irq(&callback_lock);
-	update_unbound_workqueue_cpumask(isolcpus_updated);
+	update_exclusion_cpumasks(isolcpus_updated);
 
 	if ((old_prs != new_prs) && (cmd == partcmd_update))
 		update_partition_exclusive_flag(cs, new_prs);
@@ -2931,7 +2931,7 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 	else if (isolcpus_updated)
 		isolated_cpus_update(old_prs, new_prs, cs->effective_xcpus);
 	spin_unlock_irq(&callback_lock);
-	update_unbound_workqueue_cpumask(isolcpus_updated);
+	update_exclusion_cpumasks(isolcpus_updated);
 
 	/* Force update if switching back to member & update effective_xcpus */
 	update_cpumasks_hier(cs, &tmpmask, !new_prs);
-- 
2.49.0


