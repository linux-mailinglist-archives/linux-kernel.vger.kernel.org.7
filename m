Return-Path: <linux-kernel+bounces-760554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F1FB1ECC6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 18:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83D963B94BB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 16:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA2D286D40;
	Fri,  8 Aug 2025 16:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jt3Be6qr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB25F28750B
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 16:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754668938; cv=none; b=kOGPl1tOHQDRaCM5D6UtiQasbziAuAGPQcHzrb8WS5g03o1HxoRgooXbTo2JKJ9526fDyTR/QXbNvhxY5npoYFqLxfAcXdM2vPrp4NpA5M51tTyG8lAcVaQafW/qOOrGLsX++wuKj1D8J5fjQJnSUBWaTWKuYu1MG7S9WU50/wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754668938; c=relaxed/simple;
	bh=0igDZzlW0iV5Lt358l6O6/QX6T811XQ+E/buzrqRWSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DoN/1d9EP4Ss1VqADsDYQP1D2gpHqG7byQPxlPcL43o3HyuFULbnN3YEblpowyXyrEpRVe0/cMgtJTZp73D9NdB8kckHxFKfkbKVJ4BVWXCyKSvAdw5os9/UNZfAAn1spO/XCiEHxsRSMym+UwkpYyVon+oMz9AQ/6AXZyHMYow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jt3Be6qr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754668935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1ulW/lmrycYW9lhqeQ2+xNDQ6jHyaCqHq11Okk42F/k=;
	b=Jt3Be6qrp0wZeiIx6ga4oL9UYUuTsjSgRM/6vA28by8xUdNViS7I/Ltfx72F3exHj08nrb
	8mk2EVlMZRl+uScXffz7STBC1smz2TV7siZYJlb68LUGS4amquSlMn7MhafEEB21PWT69g
	TDlp+o4D53W03VzLoNTrYXiMaXueQWM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-171-_i736elEOkOllMjbX70SGQ-1; Fri,
 08 Aug 2025 12:02:14 -0400
X-MC-Unique: _i736elEOkOllMjbX70SGQ-1
X-Mimecast-MFC-AGG-ID: _i736elEOkOllMjbX70SGQ_1754668932
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 62922180048E;
	Fri,  8 Aug 2025 16:02:12 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.45.224.121])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3E17119560AD;
	Fri,  8 Aug 2025 16:02:08 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH v11 6/8] sched/isolation: Force housekeeping if isolcpus and nohz_full don't leave any
Date: Fri,  8 Aug 2025 18:01:40 +0200
Message-ID: <20250808160142.103852-7-gmonaco@redhat.com>
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

Currently the user can set up isolcpus and nohz_full in such a way that
leaves no housekeeping CPU (i.e. no CPU that is neither domain isolated
nor nohz full). This can be a problem for other subsystems (e.g. the
timer wheel imgration).

Prevent this configuration by invalidating the last setting in case the
union of isolcpus (domain) and nohz_full covers all CPUs.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 kernel/sched/isolation.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index a4cf17b1fab0..3ad0d6df6a0a 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -167,6 +167,29 @@ static int __init housekeeping_setup(char *str, unsigned long flags)
 			}
 		}
 
+		/*
+		 * Check the combination of nohz_full and isolcpus=domain,
+		 * necessary to avoid problems with the timer migration
+		 * hierarchy. managed_irq is ignored by this check since it
+		 * isn't considered in the timer migration logic.
+		 */
+		iter_flags = housekeeping.flags & (HK_FLAG_KERNEL_NOISE | HK_FLAG_DOMAIN);
+		type = find_first_bit(&iter_flags, HK_TYPE_MAX);
+		/*
+		 * Pass the check if none of these flags were previously set or
+		 * are not in the current selection.
+		 */
+		iter_flags = flags & (HK_FLAG_KERNEL_NOISE | HK_FLAG_DOMAIN);
+		first_cpu = (type == HK_TYPE_MAX || !iter_flags) ? 0 :
+			    cpumask_first_and_and(cpu_present_mask,
+				    housekeeping_staging, housekeeping.cpumasks[type]);
+		if (first_cpu >= min(nr_cpu_ids, setup_max_cpus)) {
+			pr_warn("Housekeeping: must include one present CPU "
+				"neither in nohz_full= nor in isolcpus=domain, "
+				"ignoring setting %s\n", str);
+			goto free_housekeeping_staging;
+		}
+
 		iter_flags = flags & ~housekeeping.flags;
 
 		for_each_set_bit(type, &iter_flags, HK_TYPE_MAX)
-- 
2.50.1


