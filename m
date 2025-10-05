Return-Path: <linux-kernel+bounces-842336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B09BB9891
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 16:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54BA93B506A
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 14:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C82F289E16;
	Sun,  5 Oct 2025 14:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dGwC4h63"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7A81F936
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 14:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759675910; cv=none; b=MfaZs8cV1T8ij/ChsbCQAmCEZNUAszk0eQ60FHKdXZvmR8NicG6TwNO8P77BWtxOrKpOqdzOVcyQnnfgOR6D96SUilI0MqLd868UxJwM9+88TDSMBVJrR7ueJaZFUnAandQFm6zAfsTi60V7gE1iosk52dElFbHil3FOryxgkW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759675910; c=relaxed/simple;
	bh=sR+rFnluFtUzgZr7eCVi6YuN2uuLOaVxxTpLNJGEFrw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ZZxmhK1YQmERgcP/sKNsknmtNfn87bIwIU7AkICUlj2M2CdU1C7mmjETfueNACbkWTCm4JcwoOHLcrZugqhyxnjzSfz9FPdOcWITw/3YdTxuiDneFqlSKhrh1mPX3BfJg/cgsxMrl/b+ziG7onewUvxiOQ07ZeIlQlHrVS1HjOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dGwC4h63; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759675908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=ZZOtTWQVxlJ4YcwEW6vJpq0v/jJHuqx77CpDcZgUiZE=;
	b=dGwC4h63ZVRBIxrG2qp2r5tThxzLBCJ3SwHqGUDB40heZlAUc03N5vIo/4cXsRHzNexADL
	knPDlDxNVujC+A1Eizphfn8miuRRbU/6kmA2G+QlCMqwQXPzQ5eppjHpT5OxP+nwjcrhK0
	WjJOFNKm8nOWapruf5rgLusLAN1/vCc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-283-7oP693EkMh2dU_tPBq7v2g-1; Sun,
 05 Oct 2025 10:51:45 -0400
X-MC-Unique: 7oP693EkMh2dU_tPBq7v2g-1
X-Mimecast-MFC-AGG-ID: 7oP693EkMh2dU_tPBq7v2g_1759675903
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 980581800365;
	Sun,  5 Oct 2025 14:51:43 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.5])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 341903000198;
	Sun,  5 Oct 2025 14:51:38 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun,  5 Oct 2025 16:50:22 +0200 (CEST)
Date: Sun, 5 Oct 2025 16:50:16 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Boqun Feng <boqun.feng@gmail.com>,
	David Howells <dhowells@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Li RongQing <lirongqing@baidu.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] seqlock: introduce SEQLOCK_READ_SECTION()
Message-ID: <20251005145016.GA1254@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251005144929.GB1188@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

The read_seqbegin/need_seqretry/done_seqretry API is cumbersome and
error prone. With the new helper the "typical" code like

	nextseq = 0;
	do {
		seq = nextseq;
		flags = read_seqbegin_or_lock_irqsave(&seqlock, &seq);

		// read-side critical section

		nextseq = 1;
	} while (need_seqretry(&seqlock, seq));
	done_seqretry_irqrestore(&seqlock, seq, flags);

can be rewritten as

	SEQLOCK_READ_SECTION(&seqlock, &flags) {
		// read-side critical section
	}

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 include/linux/seqlock.h | 49 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 5ce48eab7a2a..8cd36a7c1638 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -1209,4 +1209,53 @@ done_seqretry_irqrestore(seqlock_t *lock, int seq, unsigned long flags)
 	if (seq & 1)
 		read_sequnlock_excl_irqrestore(lock, flags);
 }
+
+/* internal helper for SEQLOCK_READ_SECTION() */
+static inline int
+seqlock_read_section_retry(seqlock_t *lock, int *seq, unsigned long *flags)
+{
+	int retry = 0;
+
+	if (*seq & 1) {
+		if (flags)
+			read_sequnlock_excl_irqrestore(lock, *flags);
+		else
+			read_sequnlock_excl(lock);
+	} else if (read_seqretry(lock, *seq)) {
+		retry = *seq = 1;
+		if (flags)
+			read_seqlock_excl_irqsave(lock, *flags);
+		else
+			read_seqlock_excl(lock);
+	}
+
+	return retry;
+}
+
+#define __SEQLOCK_READ_SECTION(lock, lockless, seq, flags)	\
+	for (int lockless = 1, seq = read_seqbegin(lock);		\
+	     lockless || seqlock_read_section_retry(lock, &seq, flags);	\
+	     lockless = 0)
+
+/**
+ * SEQLOCK_READ_SECTION(lock, flags) - execute the read side critical section
+ *                                     without manual sequence counter handling
+ *                                     or calls to other helpers
+ * @lock: pointer to the seqlock_t protecting the data
+ * @flags: pointer to unsigned long for irqsave/irqrestore or NULL
+ *
+ * Example:
+ *
+ *	SEQLOCK_READ_SECTION(&lock, &flags) {
+ *		// read-side critical section
+ *	}
+ *
+ * Starts with a lockless pass first. If it fails, restarts the critical section
+ * with the lock held and, if @flags != NULL, with irqs disabled.
+ *
+ * The critical section must not contain control flow that escapes the loop.
+ */
+#define SEQLOCK_READ_SECTION(lock, flags)	\
+	__SEQLOCK_READ_SECTION(lock, __UNIQUE_ID(lockless), __UNIQUE_ID(seq), flags)
+
 #endif /* __LINUX_SEQLOCK_H */
-- 
2.25.1.362.g51ebf55


