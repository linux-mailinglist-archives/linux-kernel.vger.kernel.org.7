Return-Path: <linux-kernel+bounces-812090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70814B532C8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 14:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DE2A1C81F66
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 12:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB6F322A22;
	Thu, 11 Sep 2025 12:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hPX2kgov"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AECC32252A
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 12:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757595125; cv=none; b=QfewM8Y/V2fARnZJgQ4Ie1skfScRenpM7XGS9cgE8LFZke/zhYMCPY5BTj+3buno4bjgLbE5yuC63mJ2jL6DmnW+WbKavh58SY06xn/rmByBF1m320hBt7kq9hrVkatnHYH5z31sN/IbTG/YoM5DXVywnLw1bDnJ0F/+tofCmZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757595125; c=relaxed/simple;
	bh=5p/zS4lP41e2pD4xGW0+TuQeawK0/VWCW7E1bV8uYPw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KXhLa1M8iUrMNM/3L/8+5S0KUUfQAvigEtkjNZOsWM8vb5L8y1X9W/mDU4jtmpdy/4Ya+8b8+3vB0ROyUcwFic1fO73niT5oejj3G0sb21ZGu0fnpSfYEf0Y9+cTGFKOuy3WeARo8n3jDAN/wyIuZQggLPWC5BPwu2r/b3pIp08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hPX2kgov; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757595120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2Jen2glJvsL1zeTu2Lyjg5IcVv3okUbisL9PfS0foS8=;
	b=hPX2kgovC0cfVHUI5LjvqZ4sjj9un+Vv3JgFzMQFqAnazDElQzAFM7qjkar4hIPA6WE/I4
	WvTu8j1OCFHIne85f5oRIkZqGypjYPfNctYsCpSJaC7u8NKtOZvZauja6KAwtUcgFrI/pQ
	iNVPWs7U/LlguRf9FtRkjbw4IrOKFoE=
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
Subject: [PATCH v3] srcu/tiny: Remove preempt_disable/enable() in srcu_gp_start_if_needed()
Date: Thu, 11 Sep 2025 20:51:55 +0800
Message-ID: <20250911125155.680960-1-qiang.zhang@linux.dev>
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
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutiny.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
index b52ec45698e8..3450c3751ef7 100644
--- a/kernel/rcu/srcutiny.c
+++ b/kernel/rcu/srcutiny.c
@@ -181,10 +181,9 @@ static void srcu_gp_start_if_needed(struct srcu_struct *ssp)
 {
 	unsigned long cookie;
 
-	preempt_disable();  // Needed for PREEMPT_LAZY
+	lockdep_assert_preemption_disabled(); // Needed for PREEMPT_LAZY
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


