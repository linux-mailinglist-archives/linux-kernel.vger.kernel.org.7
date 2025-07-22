Return-Path: <linux-kernel+bounces-741214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4522EB0E187
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 18:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A3501C85F22
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 16:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A31835973;
	Tue, 22 Jul 2025 16:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Uv81kqhS"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA46D1E260D
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 16:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753201102; cv=none; b=WA6FUwF/rmBu/h2l9qhrBeRvCFb5AyWTDc8LznHTqj2rFqiDkwZ7BNk1U5YHr6bnYRqKGLuCvc6+BQFlqdr4409dd0Jm5Frz1jsPmgKnzM+qrJ4CJFVgLBAdbd5RlX64a+ouTZlXq2jP1PekXvBdURohDiB6sQmNS2xfi5dBiAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753201102; c=relaxed/simple;
	bh=W0Hjd+nD6QBjbYvVuJ7XtnSidQ4YqAm3Q5qm40kHCVw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=aHVQpOD/XY8DGOD9+vtwKTulyuXMVRGQ70Fjnn0z3iTLjiy3a71F+nxx2w72C2lLFvIBsq6nsktR8Wm1CHCL4qznVqtOFUIsAG5FMHOSCFm1NVlip2w6Rd2t9JaL2iDOgUsrUegNXUtd3R3hKzaj/Ujy2GrJDge+ZAV5EkjSYD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Uv81kqhS; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 249BE2126893;
	Tue, 22 Jul 2025 09:18:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 249BE2126893
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1753201100;
	bh=JjdOrnQa/RNmFaXEBjcxahxOOKX66gMrLGzSMQyUetQ=;
	h=From:To:Subject:Date:From;
	b=Uv81kqhSYonTJNZQVIvE1Zyg52j4pxaRdlJ6F1b+uJbGf6noXOYrtt+Pa2iA/SuCG
	 O3RWfBijf6xni54Nno6lpXfghSSNKir0dlXcT7dcgF54wlEYzRlu33szz60eA5+GAt
	 l72gVtFhRS8JAmEI0MNUhnx6hV8zENld2kIgnyX0=
From: Roman Kisel <romank@linux.microsoft.com>
To: mathieu.desnoyers@efficios.com,
	mingo@kernel.org,
	neeraj.upadhyay@kernel.org,
	paulmck@kernel.org,
	riel@surriel.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] smp: Fix spelling in on_each_cpu_cond_mask()'s doc-comment
Date: Tue, 22 Jul 2025 09:18:18 -0700
Message-ID: <20250722161818.6139-1-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"boolean" is spelt as "blooean". Fix that.

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
---
 kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index 974f3a3962e8..631183ea55d5 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -1026,7 +1026,7 @@ void __init smp_init(void)
  * @cond_func:	A callback function that is passed a cpu id and
  *		the info parameter. The function is called
  *		with preemption disabled. The function should
- *		return a blooean value indicating whether to IPI
+ *		return a boolean value indicating whether to IPI
  *		the specified CPU.
  * @func:	The function to run on all applicable CPUs.
  *		This must be fast and non-blocking.

base-commit: 89be9a83ccf1f88522317ce02f854f30d6115c41
-- 
2.43.0


