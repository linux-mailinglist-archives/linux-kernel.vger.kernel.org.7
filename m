Return-Path: <linux-kernel+bounces-779290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2ED3B2F19F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 10:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47A21AA5CA7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 08:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DD62ECD1B;
	Thu, 21 Aug 2025 08:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G0z2UVaA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE3E2EBDE2
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 08:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755764494; cv=none; b=cmD7DbRi/YJSPmDNJHtw6w+p2+MxoShm/kdup3pkaPr3/6ilLbPtci1004KzoRdYoydlNnRqQGPPSkkmN8BxwLj9XbRzOHWd9LzTLm8CQxLbYBlDUjajYzYBomoU1aEdwgd2bhwwPJumHHT2jaPjXn0ZaGAV4aSLilaZYXgHGEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755764494; c=relaxed/simple;
	bh=gsPkgondZqNZ3zv3wi160jDYzcl7tmfPKoSuRF2dQ8E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ioSEMoQRBHkCMc+goFL6kFt6egVpWrhTDg6qMoVlpArPGip9TKg1LRVnJXMHwy5WAnrpjr12FubZhJQIVkgBz/TmFNBdK5stQaWtsZjzVsAkxpT/9a5zA5NFx5gZhqQHSRg4VXL7vBKMTfsKJ4cSJVxQZnfgoiUhYrtvSxXBnFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G0z2UVaA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755764491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Jv1EWdTVKoQB2UIrwR5Bxw/HnavmSMgATQkvIMMwW0Q=;
	b=G0z2UVaApUYyCEdGhkh91TYufHkvnali6Gye27BEBv45VWkoUOBMLq3PrbLqpFPOsrnWkb
	NURkaioeKBULui5u+MZaUQHFZkXacyfQ0dWqprXv56qihQdCUL9S9/E9kFBa570Rxa0wG2
	+UQv57LAaS+5E9sboAokjQBvqc6z7o8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-K-DLGLGgNLWtHrX8OCuhHA-1; Thu,
 21 Aug 2025 04:21:28 -0400
X-MC-Unique: K-DLGLGgNLWtHrX8OCuhHA-1
X-Mimecast-MFC-AGG-ID: K-DLGLGgNLWtHrX8OCuhHA_1755764487
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 20861180034B;
	Thu, 21 Aug 2025 08:21:27 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.45.224.126])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 414AE19560B0;
	Thu, 21 Aug 2025 08:21:23 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Qais Yousef <qais.yousef@arm.com>,
	Phil Auld <pauld@redhat.com>,
	Vincent Donnefort <vincent.donnefort@arm.com>
Subject: [PATCH] sched: Export hidden tracepoints to modules
Date: Thu, 21 Aug 2025 10:21:08 +0200
Message-ID: <20250821082108.71339-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The tracepoints sched_entry, sched_exit and sched_set_need_resched
are not exported to tracefs as trace events, this allows only kernel
code to access them. Helper modules like [1] can be used to still have
the tracepoints available to ftrace for debugging purposes, but they do
rely on the tracepoints being exported.

Export the 3 not exported tracepoints.
Note that sched_set_state is already exported as the macro is called
from modules.

[1] - https://github.com/qais-yousef/sched_tp.git

Cc: Qais Yousef <qais.yousef@arm.com>
Cc: Phil Auld <pauld@redhat.com>
Cc: Vincent Donnefort <vincent.donnefort@arm.com>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 kernel/sched/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index be00629f0ba4..d3321a5f69cc 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -117,6 +117,9 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_util_est_cfs_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_util_est_se_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_update_nr_running_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_compute_energy_tp);
+EXPORT_TRACEPOINT_SYMBOL_GPL(sched_entry_tp);
+EXPORT_TRACEPOINT_SYMBOL_GPL(sched_exit_tp);
+EXPORT_TRACEPOINT_SYMBOL_GPL(sched_set_need_resched_tp);
 
 DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
 

base-commit: c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9
-- 
2.50.1


