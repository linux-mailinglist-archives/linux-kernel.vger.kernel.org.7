Return-Path: <linux-kernel+bounces-815731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19308B56A65
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 17:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79AB1420CF4
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 15:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C4E2DF152;
	Sun, 14 Sep 2025 15:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lK2a0T27"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5174F2DF6FA
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 15:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757865480; cv=none; b=dVcer+AwwAtnSn2BwWRGPgk6QC0GadB1FkyJAF+A2+4C5Acix7em6/wjA33xHUeSK+ka8uWc2e0eecOdaBw8ZNDdiOwKYIDspqWEaGd8e0ebyoMUUY2Vw+bU70sicJLnjAYpqOh0zGNKE9XesT4tIKjOEpOIL/x1WD7IGX1nYuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757865480; c=relaxed/simple;
	bh=3BGzPF/5VpNXrRT172DmrvHLqGBDLyHCCXwQhR82DVQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OkzqL92l8DyZluPz6ExzTuspwjiGIJr+t7a3IHoKKUtHdZMzo2FL94e7KEQD+O61jrIw4+F2H40T8mUPHZmNcX9XZDw4EI3M+CLD89szXEpg/eBfxromcl6BIMx2r+wsh2KEp3gBS9WIImds4+xiQNsqn5ffXNWc7iHlzaH6q68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lK2a0T27; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757865475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bl37ymUxPOSh0uADw//c0j6dKMZwyMMccmkvzyDx4iM=;
	b=lK2a0T27ImIAd64YS6JxypBOEQfNoimxQualhdSIiev7c+rytN7wkxz3/5Fmpq73iYLLqr
	QW9051fiWMumZdp3pAYd3PQ61ZoHKpTvymxppol7TfnArpz1OYNwtGadmPxUmXBo+auODG
	P/BawdH0x9b1hRtuZR1U8oIJoQcvfdw=
From: Tiwei Bie <tiwei.bie@linux.dev>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	benjamin@sipsolutions.net,
	arnd@arndb.de,
	tiwei.btw@antgroup.com,
	tiwei.bie@linux.dev,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v3 5/7] um: vdso: Remove getcpu support on x86
Date: Sun, 14 Sep 2025 23:56:56 +0800
Message-Id: <20250914155658.1028790-6-tiwei.bie@linux.dev>
In-Reply-To: <20250914155658.1028790-1-tiwei.bie@linux.dev>
References: <20250914155658.1028790-1-tiwei.bie@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Tiwei Bie <tiwei.btw@antgroup.com>

We are going to support SMP on UML/x86, so we can't hard code
the CPU and NUMA node in __vdso_getcpu() anymore. Let's just
remove it and let applications fall back to the syscall.

Suggested-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/x86/um/vdso/um_vdso.c  | 20 --------------------
 arch/x86/um/vdso/vdso.lds.S |  2 --
 2 files changed, 22 deletions(-)

diff --git a/arch/x86/um/vdso/um_vdso.c b/arch/x86/um/vdso/um_vdso.c
index cbae2584124f..43a5ffcc7158 100644
--- a/arch/x86/um/vdso/um_vdso.c
+++ b/arch/x86/um/vdso/um_vdso.c
@@ -10,14 +10,12 @@
 #define DISABLE_BRANCH_PROFILING
 
 #include <linux/time.h>
-#include <linux/getcpu.h>
 #include <asm/unistd.h>
 
 /* workaround for -Wmissing-prototypes warnings */
 int __vdso_clock_gettime(clockid_t clock, struct __kernel_old_timespec *ts);
 int __vdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz);
 __kernel_old_time_t __vdso_time(__kernel_old_time_t *t);
-long __vdso_getcpu(unsigned int *cpu, unsigned int *node, struct getcpu_cache *unused);
 
 int __vdso_clock_gettime(clockid_t clock, struct __kernel_old_timespec *ts)
 {
@@ -58,21 +56,3 @@ __kernel_old_time_t __vdso_time(__kernel_old_time_t *t)
 	return secs;
 }
 __kernel_old_time_t time(__kernel_old_time_t *t) __attribute__((weak, alias("__vdso_time")));
-
-long
-__vdso_getcpu(unsigned int *cpu, unsigned int *node, struct getcpu_cache *unused)
-{
-	/*
-	 * UML does not support SMP, we can cheat here. :)
-	 */
-
-	if (cpu)
-		*cpu = 0;
-	if (node)
-		*node = 0;
-
-	return 0;
-}
-
-long getcpu(unsigned int *cpu, unsigned int *node, struct getcpu_cache *tcache)
-	__attribute__((weak, alias("__vdso_getcpu")));
diff --git a/arch/x86/um/vdso/vdso.lds.S b/arch/x86/um/vdso/vdso.lds.S
index 73c508587a98..401600effc0a 100644
--- a/arch/x86/um/vdso/vdso.lds.S
+++ b/arch/x86/um/vdso/vdso.lds.S
@@ -22,8 +22,6 @@ VERSION {
 		__vdso_clock_gettime;
 		gettimeofday;
 		__vdso_gettimeofday;
-		getcpu;
-		__vdso_getcpu;
 		time;
 		__vdso_time;
 	local: *;
-- 
2.34.1


