Return-Path: <linux-kernel+bounces-743671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2FEFB1019D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 09:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76FC558713D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 07:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A9623A993;
	Thu, 24 Jul 2025 07:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FDoqiymV"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE6D230BC2
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 07:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753341824; cv=none; b=Mz62epjQS1ymci+YpmmM9bkfWsaKKz3S2s0KffFdqbsnlyRcn+nXQs3cnStpHKaw5u0h6bdhmk/837ZKd0Oz200+6vwirEb9tJipPkqZqCx2+c4fW73fMfYpppuw6sEwyOBGxXyj/tgMin7BYfmXYYKnAr3unEdJyZI7qywR974=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753341824; c=relaxed/simple;
	bh=MhwmY5oCovTktCZhD2FvbQIwH9vw5U48ccVoEmj8iJs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=csq82nxM8vo7SqyzuFtdX/pQQTTRg9cEqFkuqF2bf2PT1Yb+55Jifj3frgFWN1o8SWHlFag/hGZB9dK2Y3z+D8N0uqLth5HYIRCbagc7qtabDYaALUyHxbdvMK0iHD/HJIbILijaU+SDYboXS8i+qKgBVH23JNBOdMcolnVWZ+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FDoqiymV; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753341820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rQLcskP7Mc4cBi1p44VAN09dqMpW/GjatBYVUVneLIw=;
	b=FDoqiymVzCY/2VKz1qvMzUC5vwIJKZaHxzREX00rHfJJm4EC5Mlk+80Btsb2esp4sm2h6S
	+mW9htUp2VZdWLF2q/41wWecetraP13iEKDIe1Dqii6dMWj0LNZEkO0U1D9EaG1I1nUU5X
	NOkqleLN2NE6EN0MpnX/iMuKONghQyM=
From: Ye Liu <ye.liu@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Ye Liu <liuye@kylinos.cn>,
	Lance Yang <lance.yang@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] hung_task: Add detection count to hung task warning message
Date: Thu, 24 Jul 2025 15:23:25 +0800
Message-ID: <20250724072326.2031432-1-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Ye Liu <liuye@kylinos.cn>

Add [#N] to hung task warnings to show occurrence count.
This helps quickly identify warning order when multiple
messages appear in logs.

Signed-off-by: Ye Liu <liuye@kylinos.cn>

Changes in v2:
- Directly use sysctl_hung_task_detect_count.
- Link to v1:https://lore.kernel.org/all/20250721031755.1418556-1-ye.liu@linux.dev/
---
 kernel/hung_task.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index 8708a1205f82..231afdb68bb2 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -232,8 +232,9 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
 	if (sysctl_hung_task_warnings || hung_task_call_panic) {
 		if (sysctl_hung_task_warnings > 0)
 			sysctl_hung_task_warnings--;
-		pr_err("INFO: task %s:%d blocked for more than %ld seconds.\n",
-		       t->comm, t->pid, (jiffies - t->last_switch_time) / HZ);
+		pr_err("INFO: task %s:%d blocked for more than %ld seconds. [#%ld]\n",
+		       t->comm, t->pid, (jiffies - t->last_switch_time) / HZ,
+		       sysctl_hung_task_detect_count);
 		pr_err("      %s %s %.*s\n",
 			print_tainted(), init_utsname()->release,
 			(int)strcspn(init_utsname()->version, " "),
-- 
2.43.0


