Return-Path: <linux-kernel+bounces-730088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0E2B0401F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E0AC3AF2C5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 13:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39B9254AF5;
	Mon, 14 Jul 2025 13:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KXVu7P1+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9318246BC7
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 13:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752499907; cv=none; b=EzNJxTBYZWPn2qyxST+5Ej1/xetgvJseQJXhQ7V4flmT11IWBx6GiHRmSXQr7LAmH1DQ4iK+WLUMNdf1Kl6AjRXqynSuWsSbjkTmzh5ab4f0qvyFtWzrAHmMLZWdYWeJx2tOKq83GcVMgaQbRi+G1atrnRXTAz7/2AonmT3CiEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752499907; c=relaxed/simple;
	bh=/ngu1X8UAcAMW7nQ2qwEe/BTxf9ufDDdWdwrHIOq2LI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E0Sx1WhVDlwm1YJIwHNK5IPfZgwQiCAzHF2iVeb9g391qEqaLHeuvf4TAnwhEQ42PPI1RxsRg+3rJXmuVCWqKBKrhGmjM9YWsdYdoz9JEbYf9mH3H7JngYqVafvRHAN7pVDx5vFFcQiVOiFhwMKkCLDI4YKuFOWfXpqfRQjD0es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KXVu7P1+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752499904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zLism8EftLMfGY2XtmjU5c/SH0PZGP9bCy9WaqH4dis=;
	b=KXVu7P1+twDnWbbUjUv/Te1dmBmu2MD2x9QFu43eEbX0ExbpXjasFeuUCRTiOeSx5m+DP0
	fDu5LWUpurfd2qZeUwMlztFXhBka+HtvxM6zoU3Uxq8usfxc+yl/8U4LwXsLaqA7j2t7gs
	z3GoR2dldmugmmVm0fjqwDaeRn8JQlU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-319-vd7WD3rdMsWLCrswPOQ82g-1; Mon,
 14 Jul 2025 09:31:43 -0400
X-MC-Unique: vd7WD3rdMsWLCrswPOQ82g-1
X-Mimecast-MFC-AGG-ID: vd7WD3rdMsWLCrswPOQ82g_1752499902
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1E0AF180A8FA;
	Mon, 14 Jul 2025 13:31:42 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.45.225.215])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1FBDA19560A3;
	Mon, 14 Jul 2025 13:31:38 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH v8 5/7] sched/isolation: Force housekeeping if isolcpus and nohz_full don't leave any
Date: Mon, 14 Jul 2025 15:30:56 +0200
Message-ID: <20250714133050.193108-14-gmonaco@redhat.com>
In-Reply-To: <20250714133050.193108-9-gmonaco@redhat.com>
References: <20250714133050.193108-9-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Currently the user can set up isolcpus and nohz_full in such a way that
leaves no housekeeping CPU (i.e. no CPU that is neither domain isolated
nor nohz full). This can be a problem for other subsystems (e.g. the
timer wheel imgration).

Prevent this configuration by invalidating the last setting in case the
union of isolcpus and nohz_full covers all CPUs.

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 kernel/sched/isolation.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 93b038d48900a..0019d941de683 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -165,6 +165,18 @@ static int __init housekeeping_setup(char *str, unsigned long flags)
 			}
 		}
 
+		/* Check in combination with the previously set cpumask */
+		type = find_first_bit(&housekeeping.flags, HK_TYPE_MAX);
+		first_cpu = cpumask_first_and_and(cpu_present_mask,
+						  housekeeping_staging,
+						  housekeeping.cpumasks[type]);
+		if (first_cpu >= nr_cpu_ids || first_cpu >= setup_max_cpus) {
+			pr_warn("Housekeeping: must include one present CPU neither "
+				"in nohz_full= nor in isolcpus=, ignoring setting %s\n",
+				str);
+			goto free_housekeeping_staging;
+		}
+
 		iter_flags = flags & ~housekeeping.flags;
 
 		for_each_set_bit(type, &iter_flags, HK_TYPE_MAX)
-- 
2.50.1


