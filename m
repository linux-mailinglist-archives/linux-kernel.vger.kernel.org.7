Return-Path: <linux-kernel+bounces-865392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3846BFCF4C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A69C9188CD67
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC9733EAF3;
	Wed, 22 Oct 2025 15:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JqoxQvvJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F72274671
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 15:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761147768; cv=none; b=ZB8mQr+10cBQ7kamZmiKlWlP4m83WOG7LL5j/WBT4Obb06tNs8ZOemmgF62Ny38HtqvQx1jvDZdqTsvW6MJb6In0lptm3Dav9rwAfACsoC3Oet5Ser/jIN6+3oRn5BS989mfdoUr6QjvJjn0YVuFDqReCegpxoXD7vEVrtbvUSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761147768; c=relaxed/simple;
	bh=zpq+frkaWkGFhm7sD4YmyhlmTVBMPNiMsR1mFQXsGnE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MO7JQ/JWuk3JQqD4CHIeR2ljGjZog18yqUsTb0LlUASiqiqygj2pVWll0wU3b+OT8LvUBNbC+dmhGKfArXcxBY+sEdJigYKlAk4sdB7eHVfJjL/1hk8AOgD1TqqxSeV0uXRmAIEsn1b8E4TTSj6A42Ccug+XK1c2U/IolVbeUWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JqoxQvvJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761147765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=XNzIGKng0s5XJ8SXHNbf3vgCUxHR9mnoRulXMB/+axs=;
	b=JqoxQvvJRbU+rP7D8W/vWMNvki0lwJRtXLLz0u67/ocD51t2yHRa3WR1kXOze0LiADgEZL
	wdoQbB0ytcLm1CjmcWGZHNuHIdtn8sPBjbvZmEUZdtnPb5G3Odk99gLKsLmIbx6WZNvgzO
	k+mSsQ8xsvm9uEkFHCNE0rbrRzAPKvQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-318-FffOXERiOGq2gDVaRc_l3w-1; Wed,
 22 Oct 2025 11:42:39 -0400
X-MC-Unique: FffOXERiOGq2gDVaRc_l3w-1
X-Mimecast-MFC-AGG-ID: FffOXERiOGq2gDVaRc_l3w_1761147758
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 07CC3195609D;
	Wed, 22 Oct 2025 15:42:38 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.19])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id CF0C719560B4;
	Wed, 22 Oct 2025 15:42:35 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 22 Oct 2025 17:41:19 +0200 (CEST)
Date: Wed, 22 Oct 2025 17:41:15 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	John Ogness <john.ogness@linutronix.de>,
	Petr Mladek <pmladek@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] printk_legacy_map: use LD_WAIT_CONFIG instead of
 LD_WAIT_SLEEP
Message-ID: <20251022154115.GA22400@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

printk_legacy_map is used on !PREEMPT_RT to avoid false positives from
CONFIG_PROVE_RAW_LOCK_NESTING about raw_spinlock/spinlock nesting.

However, LD_WAIT_SLEEP is not exactly right; it fools lockdep as if it
is fine to acquire a sleeping lock.

Change DEFINE_WAIT_OVERRIDE_MAP(printk_legacy_map) to use LD_WAIT_CONFIG.

(We can also make printk_legacy_allow_spinlock_enter/exit() depend on
 !PREEMPT_RT && CONFIG_PROVE_RAW_LOCK_NESTING)

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/printk/printk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 5aee9ffb16b9..f11b2f31999b 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3007,7 +3007,7 @@ bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
  * false positive. For PREEMPT_RT the false positive condition does not
  * occur.
  *
- * This map is used to temporarily establish LD_WAIT_SLEEP context for the
+ * This map is used to temporarily establish LD_WAIT_CONFIG context for the
  * console write() callback when legacy printing to avoid false positive
  * lockdep complaints, thus allowing lockdep to continue to function for
  * real issues.
@@ -3016,7 +3016,7 @@ bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
 static inline void printk_legacy_allow_spinlock_enter(void) { }
 static inline void printk_legacy_allow_spinlock_exit(void) { }
 #else
-static DEFINE_WAIT_OVERRIDE_MAP(printk_legacy_map, LD_WAIT_SLEEP);
+static DEFINE_WAIT_OVERRIDE_MAP(printk_legacy_map, LD_WAIT_CONFIG);
 
 static inline void printk_legacy_allow_spinlock_enter(void)
 {
-- 
2.25.1.362.g51ebf55



