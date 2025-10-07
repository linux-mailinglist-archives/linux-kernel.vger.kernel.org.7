Return-Path: <linux-kernel+bounces-844367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CECCBC1B3E
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 16:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 278803B1541
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 14:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB4A288C2D;
	Tue,  7 Oct 2025 14:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JTuwphzx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA87C8E6
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 14:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759846965; cv=none; b=ii3fTzP1nIAOKUez1yu0nHLkjNmoLiTK8rJY+5yFW60c5xyKj7GmiB7unKO24ZyTOJHhYuMuFVYePilbEFjl6FCDKRKqaDxnZ9bQW2gmWAMj1E7itJJAZsBFg1lTbyBGQeRDzjk+2qDpQCE0YfO7XEGQTHx7XQFhv3ulaOaYN6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759846965; c=relaxed/simple;
	bh=MagsYnyO/PngDp5RikRyfZ3ShJ0QzpuVsDa7007xqBo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ROWGkJRv8a6jMz1S8H3NjhskKqCfz5KP5V57/Ylodlyvl92ufGvxSPUYNBKdLxgP0MYqTiZEioOHRjHB0YXzLJvAYW+uudwuU9eao/lK8aLSjSJ2F7vO8guaJGAyPoJ4/GIFyxuImtPLq422x7cG4PLu/L7Gm2BBX9o3fz6w2Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JTuwphzx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759846962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=9pMYuQ2QGrbIhRcGVh9ovw0uGVViHx8S0lvJ3ldsv7I=;
	b=JTuwphzxn32FE80Fmid2RY0eWLMbyU0Stbhs2U5W1PzZnX293V4kSy2GoOi1jo2m2/DvWH
	dF5qjo/7uTm1VvM1rVEy3BGd2Wv9CPv644tlCBDSlEyaub1FZ9ayXA51bnWx5tl5wGYJaF
	Hc+pJtmSkW+i89QBKxoWv4R3vTzP2SU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-255-ETD93PPiNDC-W_Mu3v8LMA-1; Tue,
 07 Oct 2025 10:22:41 -0400
X-MC-Unique: ETD93PPiNDC-W_Mu3v8LMA-1
X-Mimecast-MFC-AGG-ID: ETD93PPiNDC-W_Mu3v8LMA_1759846960
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 68F4A1955F3C;
	Tue,  7 Oct 2025 14:22:39 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.227.6])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 472D4180141D;
	Tue,  7 Oct 2025 14:22:34 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue,  7 Oct 2025 16:21:18 +0200 (CEST)
Date: Tue, 7 Oct 2025 16:21:13 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Boqun Feng <boqun.feng@gmail.com>,
	David Howells <dhowells@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Li RongQing <lirongqing@baidu.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] seqlock: introduce scoped_seqlock_read() and
 scoped_seqlock_read_irqsave()
Message-ID: <20251007142113.GA17118@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007142043.GA17089@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The read_seqbegin/need_seqretry/done_seqretry API is cumbersome and
error prone. With the new helper the "typical" code like

	int seq, nextseq;
	unsigned long flags;

	nextseq = 0;
	do {
		seq = nextseq;
		flags = read_seqbegin_or_lock_irqsave(&seqlock, &seq);

		// read-side critical section

		nextseq = 1;
	} while (need_seqretry(&seqlock, seq));
	done_seqretry_irqrestore(&seqlock, seq, flags);

can be rewritten as

	scoped_seqlock_read_irqsave (&seqlock) {
		// read-side critical section
	}

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 include/linux/seqlock.h | 61 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 5ce48eab7a2a..9012702fd0a8 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -1209,4 +1209,65 @@ done_seqretry_irqrestore(seqlock_t *lock, int seq, unsigned long flags)
 	if (seq & 1)
 		read_sequnlock_excl_irqrestore(lock, flags);
 }
+
+/* internal helper for scoped_seqlock_read/scoped_seqlock_read_irqsave */
+static inline int
+scoped_seqlock_read_retry(seqlock_t *lock, int *seq, unsigned long *flags)
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
+#define __scoped_seqlock_read(lock, lockless, seq)	\
+	for (int lockless = 1, seq = read_seqbegin(lock);		\
+	     lockless || scoped_seqlock_read_retry(lock, &seq, NULL);	\
+	     lockless = 0)
+
+/**
+ * scoped_seqlock_read(lock) - execute the read side critical section
+ *                             without manual sequence counter handling
+ *                             or calls to other helpers
+ * @lock: pointer to the seqlock_t protecting the data
+ *
+ * Example:
+ *
+ *	scoped_seqlock_read(&lock) {
+ *		// read-side critical section
+ *	}
+ *
+ * Starts with a lockless pass first. If it fails, restarts the critical
+ * section with the lock held.
+ *
+ * The critical section must not contain control flow that escapes the loop.
+ */
+#define scoped_seqlock_read(lock)	\
+	__scoped_seqlock_read(lock, __UNIQUE_ID(lockless), __UNIQUE_ID(seq))
+
+#define __scoped_seqlock_read_irqsave(lock, s)	\
+	for (struct { int lockless, seq; ulong flags; } s = { 1, read_seqbegin(lock) }; \
+	     s.lockless || scoped_seqlock_read_retry(lock, &s.seq, &s.flags);		\
+	     s.lockless = 0)
+
+/**
+ * scoped_seqlock_read_irqsave(lock) - same as scoped_seqlock_read() but
+ *                                     disables irqs on a locking pass
+ * @lock: pointer to the seqlock_t protecting the data
+ */
+#define scoped_seqlock_read_irqsave(lock)	\
+	__scoped_seqlock_read_irqsave(lock, __UNIQUE_ID(s))
+
 #endif /* __LINUX_SEQLOCK_H */
-- 
2.25.1.362.g51ebf55


