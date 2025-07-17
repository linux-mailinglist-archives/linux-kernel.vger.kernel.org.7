Return-Path: <linux-kernel+bounces-735827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C20B0943C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 20:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB2D03AA53D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 18:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A896A2FF46D;
	Thu, 17 Jul 2025 18:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YQu10t8l"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7968E20E715
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 18:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752777852; cv=none; b=h9jF2oc61G/BRdMGGBjdr0fjC37/weyJL3vcf0O5qQzK/btwgvFAPum9a6zFY6LrM3Sxy+ofNqLIAuw/blUWVHaVAteepdSWdtmaLKiCLVwotW13RyOm+OzpVQqpUbvbItIRU2hWj0/tpvMFWQO9wiKxtskN1oXZ8gPhN4A0CwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752777852; c=relaxed/simple;
	bh=AQjfxbsSgQ8+bGIul9QQBchw8w+/CSLDQXtKReefy8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=keQgh3u2Txg7b8G7s3F45TH+22ERW9u9JdMvVXLXqzPsQ/aJmEh9YDOAF8mMLLnn/Z0Pp5G4YKxByi47DVkvTW0lFZt3FMNYw41sRWRhgZAREbHFC2UHyu3QtJyeX3F2wlS982V6GlBFWm5Xo5Ku9tfnI9+MHCBWOm5NLKts0z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YQu10t8l; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752777849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mcbr8RjxL0YRdjmqQIHNJc4faWeT43mIH6O75G3Vvbw=;
	b=YQu10t8llELX2sgl/F+vq/SZOZknDtEmZYQZjhpgk/ECsCOjxXJ32dgkOhFFn+h/eKnaHv
	2o1OpgpZ1qSRE9yRnHIHKYv2jNuMC2ch4Kfg4RrV1MGMzJnyejimxCDfVrcLPYuwijDfF0
	a88CJfpL/QeqA2Bt+QrEQtomZpGSiFU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-195-idqioOuHOvyPbzxE4VeyBw-1; Thu,
 17 Jul 2025 14:44:06 -0400
X-MC-Unique: idqioOuHOvyPbzxE4VeyBw-1
X-Mimecast-MFC-AGG-ID: idqioOuHOvyPbzxE4VeyBw_1752777844
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 359DC1800368;
	Thu, 17 Jul 2025 18:44:04 +0000 (UTC)
Received: from chopper.redhat.com (unknown [10.22.66.69])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CFD6230001B1;
	Thu, 17 Jul 2025 18:44:01 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: rust-for-linux@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Boqun Feng <boqun.feng@gmail.com>,
	linux-kernel@vger.kernel.org,
	Daniel Almeida <daniel.almeida@collabora.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev (open list:Real-time Linux (PREEMPT_RT):Keyword:PREEMPT_RT)
Subject: [PATCH v11 14/14] locking: Switch to _irq_{disable,enable}() variants in cleanup guards
Date: Thu, 17 Jul 2025 14:38:06 -0400
Message-ID: <20250717184055.2071216-15-lyude@redhat.com>
In-Reply-To: <20250717184055.2071216-1-lyude@redhat.com>
References: <20250717184055.2071216-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

From: Boqun Feng <boqun.feng@gmail.com>

The semantics of various irq disabling guards match what
*_irq_{disable,enable}() provide, i.e. the interrupt disabling is
properly nested, therefore it's OK to switch to use
*_irq_{disable,enable}() primitives.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Lyude Paul <lyude@redhat.com>

---
V10:
* Add PREEMPT_RT build fix from Guangbo Cui

---
 include/linux/spinlock.h | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index b21da4bd51a42..7ff11c893940b 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -605,10 +605,10 @@ DEFINE_LOCK_GUARD_1(raw_spinlock_nested, raw_spinlock_t,
 		    raw_spin_unlock(_T->lock))
 
 DEFINE_LOCK_GUARD_1(raw_spinlock_irq, raw_spinlock_t,
-		    raw_spin_lock_irq(_T->lock),
-		    raw_spin_unlock_irq(_T->lock))
+		    raw_spin_lock_irq_disable(_T->lock),
+		    raw_spin_unlock_irq_enable(_T->lock))
 
-DEFINE_LOCK_GUARD_1_COND(raw_spinlock_irq, _try, raw_spin_trylock_irq(_T->lock))
+DEFINE_LOCK_GUARD_1_COND(raw_spinlock_irq, _try, raw_spin_trylock_irq_disable(_T->lock))
 
 DEFINE_LOCK_GUARD_1(raw_spinlock_bh, raw_spinlock_t,
 		    raw_spin_lock_bh(_T->lock),
@@ -617,12 +617,11 @@ DEFINE_LOCK_GUARD_1(raw_spinlock_bh, raw_spinlock_t,
 DEFINE_LOCK_GUARD_1_COND(raw_spinlock_bh, _try, raw_spin_trylock_bh(_T->lock))
 
 DEFINE_LOCK_GUARD_1(raw_spinlock_irqsave, raw_spinlock_t,
-		    raw_spin_lock_irqsave(_T->lock, _T->flags),
-		    raw_spin_unlock_irqrestore(_T->lock, _T->flags),
-		    unsigned long flags)
+		    raw_spin_lock_irq_disable(_T->lock),
+		    raw_spin_unlock_irq_enable(_T->lock))
 
 DEFINE_LOCK_GUARD_1_COND(raw_spinlock_irqsave, _try,
-			 raw_spin_trylock_irqsave(_T->lock, _T->flags))
+			 raw_spin_trylock_irq_disable(_T->lock))
 
 DEFINE_LOCK_GUARD_1(spinlock, spinlock_t,
 		    spin_lock(_T->lock),
@@ -631,11 +630,11 @@ DEFINE_LOCK_GUARD_1(spinlock, spinlock_t,
 DEFINE_LOCK_GUARD_1_COND(spinlock, _try, spin_trylock(_T->lock))
 
 DEFINE_LOCK_GUARD_1(spinlock_irq, spinlock_t,
-		    spin_lock_irq(_T->lock),
-		    spin_unlock_irq(_T->lock))
+		    spin_lock_irq_disable(_T->lock),
+		    spin_unlock_irq_enable(_T->lock))
 
 DEFINE_LOCK_GUARD_1_COND(spinlock_irq, _try,
-			 spin_trylock_irq(_T->lock))
+			 spin_trylock_irq_disable(_T->lock))
 
 DEFINE_LOCK_GUARD_1(spinlock_bh, spinlock_t,
 		    spin_lock_bh(_T->lock),
@@ -645,12 +644,11 @@ DEFINE_LOCK_GUARD_1_COND(spinlock_bh, _try,
 			 spin_trylock_bh(_T->lock))
 
 DEFINE_LOCK_GUARD_1(spinlock_irqsave, spinlock_t,
-		    spin_lock_irqsave(_T->lock, _T->flags),
-		    spin_unlock_irqrestore(_T->lock, _T->flags),
-		    unsigned long flags)
+		    spin_lock_irq_disable(_T->lock),
+		    spin_unlock_irq_enable(_T->lock))
 
 DEFINE_LOCK_GUARD_1_COND(spinlock_irqsave, _try,
-			 spin_trylock_irqsave(_T->lock, _T->flags))
+			 spin_trylock_irq_disable(_T->lock))
 
 DEFINE_LOCK_GUARD_1(read_lock, rwlock_t,
 		    read_lock(_T->lock),
-- 
2.50.0


