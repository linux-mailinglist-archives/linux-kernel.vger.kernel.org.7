Return-Path: <linux-kernel+bounces-757990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE646B1C964
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 17:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C615E1748DA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 15:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC85293B5F;
	Wed,  6 Aug 2025 15:57:19 +0000 (UTC)
Received: from baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC581B040B
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 15:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754495839; cv=none; b=Q3cKfi/eo19nrRJncGoNFvCb1KGK/O8/8o+npKnyoOyOHrlwUv93/WvxA3KlFf753I2RkhN0lecau9fU0DDKoxUyDifOVu2a3vC6BWLwlG5bkOC9MCbp7VnneZo0gQiQ4chy2YMorxQUfOsmeZ4xAmNHtPVgUEXjGcoIAejkKtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754495839; c=relaxed/simple;
	bh=2nVU5PwuIL29+F1jgg3rp77asR55/ez/tKz1J7VjRr8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aS+fMJ/owXBiI/1Ca1UBsOFXHrano8Uw6rzy0lBC1YA23Uq5CgTSyxUX1CaTSxc+hcXVHb3WdQsFgNKZxGhWHEtU2MTnf136XtAzCQwefkg+RFWB1iOunfAG3Dcl1mXO2/6tNwYHjTUtAHeZ7W9Rs9GtECYRI0qH3HGY/fQ8Mt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: Fushuai Wang <wangfushuai@baidu.com>
To: <linux-kernel@vger.kernel.org>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<peterz@infradead.org>, <xin@zytor.com>, Fushuai Wang <wangfushuai@baidu.com>
Subject: [PATCH] x86/tsc: Use cpumask_next_wrap() in tsc_sync_check_timer_fn()
Date: Wed, 6 Aug 2025 23:55:35 +0800
Message-ID: <20250806155535.34338-1-wangfushuai@baidu.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc3.internal.baidu.com (172.31.3.13) To
 bjhj-exc17.internal.baidu.com (172.31.4.15)
X-FEAS-Client-IP: 172.31.4.15
X-FE-Policy-ID: 52:10:53:SYSTEM

Replace the manual sequence of cpumask_next() and cpumask_first()
with a single call to cpumask_next_wrap() in tsc_sync_check_timer_fn().

Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
---
 arch/x86/kernel/tsc_sync.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/kernel/tsc_sync.c b/arch/x86/kernel/tsc_sync.c
index ec3aa340d351..ef6ebf2bf7aa 100644
--- a/arch/x86/kernel/tsc_sync.c
+++ b/arch/x86/kernel/tsc_sync.c
@@ -99,9 +99,7 @@ static void tsc_sync_check_timer_fn(struct timer_list *unused)
 	tsc_verify_tsc_adjust(false);
 
 	/* Run the check for all onlined CPUs in turn */
-	next_cpu = cpumask_next(raw_smp_processor_id(), cpu_online_mask);
-	if (next_cpu >= nr_cpu_ids)
-		next_cpu = cpumask_first(cpu_online_mask);
+	next_cpu = cpumask_next_wrap(raw_smp_processor_id(), cpu_online_mask);
 
 	tsc_sync_check_timer.expires += SYNC_CHECK_INTERVAL;
 	add_timer_on(&tsc_sync_check_timer, next_cpu);
-- 
2.36.1


