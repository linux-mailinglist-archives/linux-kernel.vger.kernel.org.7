Return-Path: <linux-kernel+bounces-750795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A02B16121
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 15:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D0A87ACA1D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 13:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D1C29B208;
	Wed, 30 Jul 2025 13:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ejDqiO0l"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D391429ACF9
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 13:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753881158; cv=none; b=uitXMx7zeiHZmlynEOkXV6ILta0b5PoYL5P1lPSpDH0w4nUa8c2lqTrbqd5AI8NLWlgH8EEoZl254ctaJENQb77D7XRNkODDZUKQLCtoLz6clCSzRh96qeYWK1+s32STD+dXP5D+eDnDXlZ9qVfvqKB8pDhEyZa+SnY420M9EkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753881158; c=relaxed/simple;
	bh=reWgS9RUObNEsF/lZY7XBsCrlm+lIeDHni+JUOC+Zb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XgETXI5sd7Tk9vYRwa1fbOp7ScKPnVVHbdgCOBNmOooIN3hcM137UWApjIG8BliX7XL68HMvhy9WzprR5Cyrh3K07LF6C8bH1tGe5g8XsXRloTLmdk2cHE6Fv+uEXJAZmTadmSfUTBq/Qde7rl4iK29XAjifDdNWqDTzvJZVvTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ejDqiO0l; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753881155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GqZBtyD7Mqgk+C8qfOHTUrfJJw6zvJ1DQPHGjsrMFf8=;
	b=ejDqiO0l4X3+Cn06Zm61iifRd2awyhqbO3BvRH4X1skubPlteMf0Rmm7rkuHrDU36BSHXs
	W3mP1UCp6fU7NU+tO846FSXQ7qwwAqJWk+UBnlbdyzJumshyajtm1Qk7G26bRTde8PkFSm
	QPIvYjwiQhjETnncZLLIFZe5O+1m6a0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-599-h3K7AaBNMdKeySN3iREt-A-1; Wed,
 30 Jul 2025 09:12:34 -0400
X-MC-Unique: h3K7AaBNMdKeySN3iREt-A-1
X-Mimecast-MFC-AGG-ID: h3K7AaBNMdKeySN3iREt-A_1753881152
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E6E7F18001CA;
	Wed, 30 Jul 2025 13:12:31 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.44.33.26])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ECA3419560A2;
	Wed, 30 Jul 2025 13:12:28 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH v9 6/8] sched/isolation: Force housekeeping if isolcpus and nohz_full don't leave any
Date: Wed, 30 Jul 2025 15:11:56 +0200
Message-ID: <20250730131158.101668-7-gmonaco@redhat.com>
In-Reply-To: <20250730131158.101668-1-gmonaco@redhat.com>
References: <20250730131158.101668-1-gmonaco@redhat.com>
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
index 93b038d48900..0019d941de68 100644
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


