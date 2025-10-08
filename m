Return-Path: <linux-kernel+bounces-845421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5177CBC4D07
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 14:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B71919E25FF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 12:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A15C23D7C2;
	Wed,  8 Oct 2025 12:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gm4yheLG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532111E47A5
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 12:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759926740; cv=none; b=UQiY1ZSANEJGgO5osP1jY6Gx7MF/1eRCo4J2Zzz+r7rQqFvOje0MPRTiCu1AQwUJn6Y43znezSHQpr096YCDm3cigmznbBT1SanC6NAcV+iAUYLoJMsf7WZT1PLHmUC126EsmcZ/Ms3qiSahTo5yQf61vts1r7c1p2rvGie0z9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759926740; c=relaxed/simple;
	bh=uHqksmuJLKSt+GdkWV/u3ycsK4AeSgh5FUnv2EVyyqY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=VdyiUPjo+L2aLvnxbZGItAd6gnOR8STbG0/N89mEF4OABun1DHlVTKLyanH4683gQBogqrk55/cZ2CCnCQLheW/GDDbnV8LC4+db16w6h+iIhXx4plr6Ga6cPBwztBYEkIixLzx5+OyOPHyfm0xssVSHYHcKxQqEm9SvKDcKexY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gm4yheLG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759926737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=0Ag5D+pguf9nHfO9uoXExb7dGwEZzjEQQ2eIuAoJM0g=;
	b=gm4yheLGF0lntM7cqwssxNQxwwDhTK7yfxKwyIhtIctBRgIJA1+BT2PMWf6pGjUAZKYvCg
	sU/dZjZKuKu9Tgk86zjrsVLpB1klmrjbT5xhpyVsuwstEsMOjqtosavn5I28uvJfbd86xA
	PnjUwihmrn2K+anyTebo66EgpSYaEps=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-322-RblnqmgiPrym8XO7raAsXQ-1; Wed,
 08 Oct 2025 08:32:14 -0400
X-MC-Unique: RblnqmgiPrym8XO7raAsXQ-1
X-Mimecast-MFC-AGG-ID: RblnqmgiPrym8XO7raAsXQ_1759926732
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4C0111800451;
	Wed,  8 Oct 2025 12:32:12 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.227.6])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 110961956056;
	Wed,  8 Oct 2025 12:32:07 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  8 Oct 2025 14:30:51 +0200 (CEST)
Date: Wed, 8 Oct 2025 14:30:45 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Boqun Feng <boqun.feng@gmail.com>,
	David Howells <dhowells@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Li RongQing <lirongqing@baidu.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] seqlock: introduce scoped_seqlock_read() and
 scoped_seqlock_read_irqsave()
Message-ID: <20251008123045.GA20440@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251008123014.GA20413@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

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
 include/linux/seqlock.h | 64 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 5ce48eab7a2a..fa8d73668f4b 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -1209,4 +1209,68 @@ done_seqretry_irqrestore(seqlock_t *lock, int seq, unsigned long flags)
 	if (seq & 1)
 		read_sequnlock_excl_irqrestore(lock, flags);
 }
+
+/* internal helper for scoped_seqlock_read/scoped_seqlock_read_irqsave */
+static inline bool
+__scoped_seqlock_read_retry(seqlock_t *lock, int *seq, unsigned long *flags)
+{
+	bool retry = false;
+
+	if (*seq & 1) {
+		if (flags)
+			read_sequnlock_excl_irqrestore(lock, *flags);
+		else
+			read_sequnlock_excl(lock);
+	} else if (read_seqretry(lock, *seq)) {
+		*seq = 1;
+		retry = true;
+		if (flags)
+			read_seqlock_excl_irqsave(lock, *flags);
+		else
+			read_seqlock_excl(lock);
+	}
+
+	return retry;
+}
+
+#define __scoped_seqlock_read(lock, s)	\
+	for (struct { bool lockless; int seq; }					\
+		s = { .lockless = true, .seq = read_seqbegin(lock) };		\
+	     s.lockless || __scoped_seqlock_read_retry(lock, &s.seq, NULL);	\
+	     s.lockless = false)
+
+#define __scoped_seqlock_read_irqsave(lock, s)	\
+	for (struct { bool lockless; int seq; unsigned long flags; }		\
+		s = { .lockless = true, .seq = read_seqbegin(lock) };		\
+	     s.lockless || __scoped_seqlock_read_retry(lock, &s.seq, &s.flags);	\
+	     s.lockless = false)
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
+	__scoped_seqlock_read(lock, __UNIQUE_ID(s))
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


