Return-Path: <linux-kernel+bounces-808296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0980AB4FDB0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 676EA544E8A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9908342C88;
	Tue,  9 Sep 2025 13:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DmAHSxJG"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7242342C9B
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 13:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757425189; cv=none; b=dxDU0M81Zzio/TNErUSAos6TPQCL9RhTWXF+dibMWbraaDpDXpdiU3IEI06Jce+Qh27VMHm5qFbG/ZwTkVw4cp0iYgtft+54+Lt0eBr+DV1RDBhTAGPoVz6IrYduAcikF+R+HJECauuN6u7LzpNHB3dhNyHxAIQm6tlv9I9x2FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757425189; c=relaxed/simple;
	bh=eYuJ6qNBw3nt+6Ow7BNqZLeRtH+uFXn8TAZK1TjPSfI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G++ERmkXEbpeWLbyqVSynUzSEmMqX7h2v4Lr9oqb+4WhkWeDx9FpantHAH8BjDkpJqtqxhkfql9mDnid2hbuHB0UZxKxIO+4DlH0D1joN1F/SlXL5JDFSD5cHOT9TUm0hCy6wyb5ziuBazIUowQFEP2p0nMIGHfz8LOzXacPAZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DmAHSxJG; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757425174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OVTocMfKvqb5kZ+ACRAbircLYYL3Zc6f5Wp7dUPPYz0=;
	b=DmAHSxJGB7hs9UUVEmSmch88SUKoIqreLh60OlVVQCdDPQv0+//IjXY6gvexes515TB/jD
	gNngdC5D7B7SzIt/PE0W4kxV2T83oNOb2RsSV9FpijRTa4FmSsV3bQAsbmIg5FxmqYETeD
	8PH3JGJ+6rH6nYUTBqchUudSZTnBmdY=
From: Zqiang <qiang.zhang@linux.dev>
To: paulmck@kernel.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com,
	boqun.feng@gmail.com,
	urezki@gmail.com
Cc: qiang.zhang@linux.dev,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] srcu/tiny: Remove preempt_disable/enable() in srcu_gp_start_if_needed()
Date: Tue,  9 Sep 2025 21:39:28 +0800
Message-ID: <20250909133928.615218-1-qiang.zhang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Currently, the srcu_gp_start_if_needed() is always be invoked in
preempt disable's critical section, this commit therefore remove
redundant preempt_disable/enable() in srcu_gp_start_if_needed()
and adds a call to lockdep_assert_preemption_disabled() in order
to enable lockdep to diagnose mistaken invocations of this function
from preempts-enabled code.

Fixes: 65b4a59557f6 ("srcu: Make Tiny SRCU explicitly disable preemption")
Signed-off-by: Zqiang <qiang.zhang@linux.dev>
---
 kernel/rcu/srcutiny.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
index b52ec45698e8..b2da188133fc 100644
--- a/kernel/rcu/srcutiny.c
+++ b/kernel/rcu/srcutiny.c
@@ -181,10 +181,9 @@ static void srcu_gp_start_if_needed(struct srcu_struct *ssp)
 {
 	unsigned long cookie;
 
-	preempt_disable();  // Needed for PREEMPT_LAZY
+	lockdep_assert_preemption_disabled();
 	cookie = get_state_synchronize_srcu(ssp);
 	if (ULONG_CMP_GE(READ_ONCE(ssp->srcu_idx_max), cookie)) {
-		preempt_enable();
 		return;
 	}
 	WRITE_ONCE(ssp->srcu_idx_max, cookie);
@@ -194,7 +193,6 @@ static void srcu_gp_start_if_needed(struct srcu_struct *ssp)
 		else if (list_empty(&ssp->srcu_work.entry))
 			list_add(&ssp->srcu_work.entry, &srcu_boot_list);
 	}
-	preempt_enable();
 }
 
 /*
-- 
2.48.1


