Return-Path: <linux-kernel+bounces-724382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31234AFF1F3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 21:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76AE74A71BA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 19:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5505524166C;
	Wed,  9 Jul 2025 19:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ys0Defwv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B51923B63F
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 19:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752089985; cv=none; b=kRs2zdfBMQYdafBtvb2MBKG4DoONKiJu1DCBI1JoFNapDkURmP06ftScwGvmAj18+hk6Ddqel0xg5pSX5ya//I6A7Yzo51h66yAvOiH2TsEj4aEqq2g0SHJdz2UeHPRnT4VNn6ty77R+DErHg6gQcEc8PbQEqql0H65xgM7JJrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752089985; c=relaxed/simple;
	bh=xQmqtV4zXROUvBMyx8D5+vopFugAPgCMxe+Tm2Xy/HU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W00mAIV0q4CWhRv1JAG95sZfVMMIJ6Uvpc0efsOw/jO5sE9deJsE9R+wA2eyh6X3f86EIuOtJGiz686fsnQAUFh7Ou9PmqTJMbImWljnl3f/r7zEfr22O6RinBA7FF4Hu0NRagkpSzHiNYiYId36Ar+poiZppruopiihkpuC7ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ys0Defwv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752089982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0Kjp4dtO3cYg0h03/QTNGu9stsbADNCQTwhiOZ51uFw=;
	b=Ys0DefwvSt8DfWclhKlkPcKo7hxaZdeD5kat0CuNFAQrA3Zm3K2Kvca3DQeNP+GuyEfHu6
	fzuKWpJywpr31FfuUOU9hPuo5TSsFQOsxaVegh+b1mJNW329ki7Re2h0uin/PJ9KD+0bFA
	/9eF2j/s+jx9FmBsXv/wvV9b2FCYvHc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-67-5rPYQh7CPIiOnGva9JnOng-1; Wed,
 09 Jul 2025 15:39:39 -0400
X-MC-Unique: 5rPYQh7CPIiOnGva9JnOng-1
X-Mimecast-MFC-AGG-ID: 5rPYQh7CPIiOnGva9JnOng_1752089978
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ED2751955ED5;
	Wed,  9 Jul 2025 19:39:37 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.65.224])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0C28218002B5;
	Wed,  9 Jul 2025 19:39:35 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jann Horn <jannh@google.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH] locking/mutex: Add debug code to help catching violation of mutex lifetime rule
Date: Wed,  9 Jul 2025 15:39:10 -0400
Message-ID: <20250709193910.151497-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Callers of mutex_lock/unlock() must ensure the validity of the memory
objects holding mutexes until after the return of all outstanding
and upcoming mutex_unlock() calls. Add a cond_resched() call in
__mutex_unlock_slowpath() to help KASAN catch a violation of this
rule. This will enforce a context switch if another runnable task is
present and the CPU is not in an atomic context.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/mutex.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index a39ecccbd106..dd107fb9dad7 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -931,6 +931,17 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 		}
 	}
 
+#if defined(CONFIG_KASAN) && defined(CONFIG_DEBUG_MUTEXES)
+	/*
+	 * Mutex users must ensure that the memory object holding the mutex
+	 * remains valid until after the return of all the outstanding and
+	 * upcoming mutex_unlock() calls. Enforce a context switch here if
+	 * another runnable task is present and this CPU is not in an atomic
+	 * context to increase the chance that KASAN can catch a violation of
+	 * this rule.
+	 */
+	cond_resched();
+#endif
 	raw_spin_lock_irqsave(&lock->wait_lock, flags);
 	debug_mutex_unlock(lock);
 	if (!list_empty(&lock->wait_list)) {
-- 
2.50.0


