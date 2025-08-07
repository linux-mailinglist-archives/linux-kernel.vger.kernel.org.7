Return-Path: <linux-kernel+bounces-758575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F188B1D0F4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 04:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD0E716346C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 02:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692881DED5C;
	Thu,  7 Aug 2025 02:35:32 +0000 (UTC)
Received: from baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502451E520C
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 02:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754534132; cv=none; b=PPL6X8v7L7YGeWHe+Ks777MFiR0SeimXYTkm1RFHBUshZQV4F34+Nc2HlHuUcOBacM/qlpT3y8SCXKNzXzSf+W8lSIOAylydYjcN+Y0hJEldzH/lzqGyGTdVRNH+3jgrEDtjc5sgaPIoXWvQ0j5R3EHzRrNX1+ZQAi9oyMYX1jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754534132; c=relaxed/simple;
	bh=z99aCMwN/aknwcVp7diAQuH1jPHEbZxRhhFiFHmLqS4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZXp1+KAJnaiuvqLzDL65FvscXRyCuU0i4DiB2mluKRU3kcAJFLzGeW6MDLZnBzTsp4q4j5waFbXbl/lxQR4Q3Dleuvyw9brmkXU+i3QWqzJxNbx9qQyUhqdrwf3i/YOl8IxUtp9bino0Ziob8LSBeYdxURw/wsvXfvtQhu7F1Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: Fushuai Wang <wangfushuai@baidu.com>
To: <linux-kernel@vger.kernel.org>
CC: <tytso@mit.edu>, <Jason@zx2c4.com>, Fushuai Wang <wangfushuai@baidu.com>
Subject: [PATCH] random: Use cpumask_next_wrap() in try_to_generate_entropy()
Date: Thu, 7 Aug 2025 10:35:10 +0800
Message-ID: <20250807023510.38502-1-wangfushuai@baidu.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc5.internal.baidu.com (172.31.50.49) To
 bjhj-exc17.internal.baidu.com (172.31.4.15)
X-FEAS-Client-IP: 172.31.4.15
X-FE-Policy-ID: 52:10:53:SYSTEM

Replace the manual sequence of cpumask_next() and cpumask_first()
with a single call to cpumask_next_wrap() in try_to_generate_entropy().

Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
---
 drivers/char/random.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index b8b24b6ed3fe..f85f35777c9b 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1336,9 +1336,7 @@ static void __cold try_to_generate_entropy(void)
 
 			/* Basic CPU round-robin, which avoids the current CPU. */
 			do {
-				cpu = cpumask_next(cpu, &timer_cpus);
-				if (cpu >= nr_cpu_ids)
-					cpu = cpumask_first(&timer_cpus);
+				cpu = cpumask_next_wrap(cpu, &timer_cpus);
 			} while (cpu == smp_processor_id() && num_cpus > 1);
 
 			/* Expiring the timer at `jiffies` means it's the next tick. */
-- 
2.36.1


