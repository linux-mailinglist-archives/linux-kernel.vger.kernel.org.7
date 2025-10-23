Return-Path: <linux-kernel+bounces-866734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC54C00864
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96FDF1A031EB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8AA9305E3A;
	Thu, 23 Oct 2025 10:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q//I31H2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121012DE6ED
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761215642; cv=none; b=JgaWW7wZYKPFwa8EexSM5BDa7rQYpa4MDk4lC+wCCrfk7w6xRxzOIrBJvfPaUiOtdPIrXh8dVUy2vVlPFpxvVOoEcKCnBqousIb93YBbXKWLAIkQ6bsIzRP+5HtDUyGQwzIJzdCQaBPhPJtpR58f09Ub/CieuKN5ag5n11jxnEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761215642; c=relaxed/simple;
	bh=5eWsSjFW8xczabfmVP//tNv9Y06ZocfN0lwf5fXeuwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NAbYi/PoYFNkq44E/8cCuOvXpzbUvYpQEeFqv+MWOiw5y3I1wz6BMHT4rTatB0Fcb53QFB98yUJfdT13nHZhH8ocfzUP2fifOE530iD/n972iGYAzTKs/1NYirc2Cv1MKPcUw4oePk3jPb3d5/rDJSyy/J6aVXGtO92Zm4BKLOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q//I31H2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761215638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OYOdr4cULBSQPXy324IWrwQOOlTa2yjFEl6Kz+DWhW0=;
	b=Q//I31H2lMgaLiHdWHRjO3q5zs1mopPhHjo5n2xssNThN3dM4mmMPaxJ+qLP34zwTTNV11
	lVSi4nKPS38Tj29DpR6C4y5tin4G4lujdtd2Djc7s469F/9aca2ZCKJc23cxbky/B2hy7t
	+oAXm9z5881UfTldCBtwtouuYLdqYgY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-465-nE57CyV_PXek7mME8YYGeA-1; Thu,
 23 Oct 2025 06:33:57 -0400
X-MC-Unique: nE57CyV_PXek7mME8YYGeA-1
X-Mimecast-MFC-AGG-ID: nE57CyV_PXek7mME8YYGeA_1761215636
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6D4A3195420F;
	Thu, 23 Oct 2025 10:33:56 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.19])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 9262E180045B;
	Thu, 23 Oct 2025 10:33:54 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 23 Oct 2025 12:32:37 +0200 (CEST)
Date: Thu, 23 Oct 2025 12:32:34 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2] printk_legacy_map: use LD_WAIT_CONFIG instead of
 LD_WAIT_SLEEP
Message-ID: <20251023103234.GA27415@redhat.com>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

printk_legacy_map is used on !PREEMPT_RT to avoid false positives from
CONFIG_PROVE_RAW_LOCK_NESTING about raw_spinlock/spinlock nesting.

However, LD_WAIT_SLEEP is not exactly right; it fools lockdep as if it
is fine to acquire a sleeping lock.

Change DEFINE_WAIT_OVERRIDE_MAP(printk_legacy_map) to use LD_WAIT_CONFIG.

Also, update the comment to make it more clear as suggested by Petr.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Reviewed-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 5aee9ffb16b9..80f0bedf5cb7 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3003,11 +3003,12 @@ bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
 
 /*
  * Legacy console printing from printk() caller context does not respect
- * raw_spinlock/spinlock nesting. For !PREEMPT_RT the lockdep warning is a
- * false positive. For PREEMPT_RT the false positive condition does not
- * occur.
+ * raw_spinlock/spinlock nesting. However, on PREEMPT_RT the printing
+ * path from atomic context is always avoided and the console driver
+ * is always invoked from a dedicated thread. Thus the lockdep splat
+ * on !PREEMPT_RT is a false positive.
  *
- * This map is used to temporarily establish LD_WAIT_SLEEP context for the
+ * This map is used to temporarily establish LD_WAIT_CONFIG context for the
  * console write() callback when legacy printing to avoid false positive
  * lockdep complaints, thus allowing lockdep to continue to function for
  * real issues.
@@ -3016,7 +3017,7 @@ bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
 static inline void printk_legacy_allow_spinlock_enter(void) { }
 static inline void printk_legacy_allow_spinlock_exit(void) { }
 #else
-static DEFINE_WAIT_OVERRIDE_MAP(printk_legacy_map, LD_WAIT_SLEEP);
+static DEFINE_WAIT_OVERRIDE_MAP(printk_legacy_map, LD_WAIT_CONFIG);
 
 static inline void printk_legacy_allow_spinlock_enter(void)
 {
-- 
2.25.1.362.g51ebf55



