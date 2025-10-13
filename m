Return-Path: <linux-kernel+bounces-850961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D61E4BD4F5A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B036E544049
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D354130B51F;
	Mon, 13 Oct 2025 15:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XXaEKoOV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8601230AD0C
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 15:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760370841; cv=none; b=fmsV5yKtrJac7RbsCmX1AJgro9s+SEeGX1ZDFVcWaehXA0oWYJnI9mSvfOD5QgLTiRCbBInLB99Ye5Dlz7vnmlJ/2bZKYpR21oCRddVmJIfrRIaq7N+CDPf41zeedDCfRxAc5Xb5NVH+NCickU+24xh/c8fVQVsVecqRFXw6RqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760370841; c=relaxed/simple;
	bh=ZpSKpSwSgy2+bZiInyaF9yiqXJC5kaf+6/28l0BJf8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oA2wbgKE30Xt1ESo7CQhTsyva5JmENnM6MkukX5CAmujkBdjjyfNK7EWA7Rg4mwP/z+60zQpJ7WCNpopFrw3n8FR2eIpFMGAkO5FkP0pQedf1Y0j7WPt4bk9bTsAjtz3b9mlJjgXeaD0zam9cMsUJPaUY1Yfybzg9S6OgfmXeVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XXaEKoOV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760370838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qkKuLomsboIzRmpMuA/8oznn1T53sfJ8Aky18psSQVc=;
	b=XXaEKoOVV+lCWIsyeLTEQGscZ6eg2oNmVTl0chJP/rDUJnPaG0DtGciVWeKFawhW4oJTtb
	0OLz2HSgzr+9yvMGypdqDm5j4KV9Ztnp0+MsH91SB/og6GzhQ4taFjcPFA5hIMr4oqkIZn
	mluEr+lDy08LUbnItJB0yRe+PSui2iI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-142-qDYfbeCNPdWHUsnBK6SilA-1; Mon,
 13 Oct 2025 11:53:53 -0400
X-MC-Unique: qDYfbeCNPdWHUsnBK6SilA-1
X-Mimecast-MFC-AGG-ID: qDYfbeCNPdWHUsnBK6SilA_1760370831
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 86FDA19560B5;
	Mon, 13 Oct 2025 15:53:51 +0000 (UTC)
Received: from chopper.lan (unknown [10.22.81.1])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 215E730002D0;
	Mon, 13 Oct 2025 15:53:47 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: rust-for-linux@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Boqun Feng <boqun.feng@gmail.com>,
	linux-kernel@vger.kernel.org,
	Daniel Almeida <daniel.almeida@collabora.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Subject: [PATCH v13 02/17] preempt: Reduce NMI_MASK to single bit and restore HARDIRQ_BITS
Date: Mon, 13 Oct 2025 11:48:04 -0400
Message-ID: <20251013155205.2004838-3-lyude@redhat.com>
In-Reply-To: <20251013155205.2004838-1-lyude@redhat.com>
References: <20251013155205.2004838-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

From: Joel Fernandes <joelagnelf@nvidia.com>

Now that NMI nesting is tracked in a separate per-CPU variable
(nmi_nesting), we no longer need multiple bits in preempt_count
for NMI tracking. Reduce NMI_BITS from 3 to 1, using it only to
detect if we're in an NMI.

Signed-off-by: Joel Fernandes <joelaf@google.com>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 include/linux/preempt.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index 102202185d7a2..9580b972e1545 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -17,6 +17,7 @@
  *
  * - bits 0-7 are the preemption count (max preemption depth: 256)
  * - bits 8-15 are the softirq count (max # of softirqs: 256)
+ * - bit 28 is the NMI flag (no nesting count, tracked separately)
  *
  * The hardirq count could in theory be the same as the number of
  * interrupts in the system, but we run all interrupt handlers with
@@ -24,16 +25,19 @@
  * there are a few palaeontologic drivers which reenable interrupts in
  * the handler, so we need more than one bit here.
  *
+ * NMI nesting depth is tracked in a separate per-CPU variable
+ * (nmi_nesting) to save bits in preempt_count.
+ *
  *         PREEMPT_MASK:	0x000000ff
  *         SOFTIRQ_MASK:	0x0000ff00
  *         HARDIRQ_MASK:	0x000f0000
- *             NMI_MASK:	0x00f00000
+ *             NMI_MASK:	0x10000000
  * PREEMPT_NEED_RESCHED:	0x80000000
  */
 #define PREEMPT_BITS	8
 #define SOFTIRQ_BITS	8
 #define HARDIRQ_BITS	4
-#define NMI_BITS	4
+#define NMI_BITS	1
 
 #define PREEMPT_SHIFT	0
 #define SOFTIRQ_SHIFT	(PREEMPT_SHIFT + PREEMPT_BITS)
-- 
2.51.0


