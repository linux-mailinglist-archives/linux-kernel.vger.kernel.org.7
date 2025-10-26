Return-Path: <linux-kernel+bounces-870421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5EEC0ABE8
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 16:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 585393B36A3
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 15:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892642248A8;
	Sun, 26 Oct 2025 15:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D9BNrrBn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A323419539F
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 15:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761491338; cv=none; b=SZH8p3HaUqp8u5OVD+t4e62dn+9xD2CRUPRrZOFjt1HneWrKbbVC72Z2AizHdbosrpxINCrDZ9yv/VYlYlxogX7GoOwNWIL6OtQIToyxR+VZvnZeiGC96pPOy9nzvaizdi7b+eh/ai6D/qb96J2GCqCJd5e6BerMcbiI1y9jS0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761491338; c=relaxed/simple;
	bh=8QqlNsWxMGusxwhFzOGTwxeXq9tu63XdnfOtAIkkjtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pVkVdPkziMfwy/k3cSZQSy3upTLsLSRO0VyM7IQJMselOVIFRYWhx4mKgACPqQgXgHDCFYEbKrVimogjc82j0O0nvQjq/6DlcQ7ymJvH4SFLHSxIFttWwrtd9oUxMKHdYgEqFgYT8VHW3AxQt3MlW2ee5ybjSoc1HKK2q0HUPfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D9BNrrBn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761491334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2cGtepgDIf4Hlej34axUjCqLPyYvUumKvXFFkuy+GtA=;
	b=D9BNrrBnjtTZH+mZKyPvv1xP3y1hOXHwophhOiNbWNtEsYow+vX9vdP7piDjwM+Gju9JUR
	vdsXih9zsvGZMcd3kr+sMAou3CGYL6lqkanJRFRbq3HaH0Q24CFOMrROAHJWJLtTWnJvxA
	fcIEdxZNbLwdSHJ9rXRwNQQpNl5Zg/k=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-626-5zW86O_MMC-XonEeeXViaQ-1; Sun,
 26 Oct 2025 11:08:48 -0400
X-MC-Unique: 5zW86O_MMC-XonEeeXViaQ-1
X-Mimecast-MFC-AGG-ID: 5zW86O_MMC-XonEeeXViaQ_1761491327
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 89F901955EFA;
	Sun, 26 Oct 2025 15:08:47 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.61])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 796AD30002DB;
	Sun, 26 Oct 2025 15:08:45 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 26 Oct 2025 16:07:29 +0100 (CET)
Date: Sun, 26 Oct 2025 16:07:26 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v3] printk_legacy_map: use LD_WAIT_CONFIG instead of
 LD_WAIT_SLEEP
Message-ID: <20251026150726.GA23223@redhat.com>
References: <20251022154115.GA22400@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022154115.GA22400@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

printk_legacy_map is used to hide lock nesting violations caused by
legacy drivers and is using the wrong override type. LD_WAIT_SLEEP is
for always sleeping lock types such as mutex_t. LD_WAIT_CONFIG is for
lock type which are sleeping while spinning on PREEMPT_RT such as
spinlock_t.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/printk/printk.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 5aee9ffb16b9..e9e65228f1ac 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3002,21 +3002,18 @@ bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
 }
 
 /*
- * Legacy console printing from printk() caller context does not respect
- * raw_spinlock/spinlock nesting. For !PREEMPT_RT the lockdep warning is a
- * false positive. For PREEMPT_RT the false positive condition does not
- * occur.
- *
- * This map is used to temporarily establish LD_WAIT_SLEEP context for the
- * console write() callback when legacy printing to avoid false positive
- * lockdep complaints, thus allowing lockdep to continue to function for
- * real issues.
- */
+ * The legacy console always acquires a spinlock_t from its printing
+ * callback. This violates lock nesting if the caller acquired an always
+ * spinning lock (raw_spinlock_t) while invoking printk(). This is not a
+ * problem on PREEMPT_RT because legacy consoles print always from a
+ * dedicated thread and never from within printk(). Therefore we tell
+ * lockdep that a sleeping spin lock (spinlock_t) is valid here.
+*/
 #ifdef CONFIG_PREEMPT_RT
 static inline void printk_legacy_allow_spinlock_enter(void) { }
 static inline void printk_legacy_allow_spinlock_exit(void) { }
 #else
-static DEFINE_WAIT_OVERRIDE_MAP(printk_legacy_map, LD_WAIT_SLEEP);
+static DEFINE_WAIT_OVERRIDE_MAP(printk_legacy_map, LD_WAIT_CONFIG);
 
 static inline void printk_legacy_allow_spinlock_enter(void)
 {
-- 
2.25.1.362.g51ebf55



