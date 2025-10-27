Return-Path: <linux-kernel+bounces-870719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C134C0B870
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 01:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12D7D3BC33A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 00:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92A82206AC;
	Mon, 27 Oct 2025 00:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eOZuMP3Y"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C2D21D00A
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 00:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761524334; cv=none; b=POI7gncXpqx5ANg7xFWEWkmnRAZ1Q6geH8PRkrG12D4UJh58s/xEcvmdE2rhyuT18ngL6dCz/w8KfXSLRexdACO99gM2d4RAz5a2XzkRkpwdWPBYrxXII/ZqT/2qK9uJDgL+hmbTdGu8xI5Ec16fpcp49ppAgpaVvwMU87oHM30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761524334; c=relaxed/simple;
	bh=3BGzPF/5VpNXrRT172DmrvHLqGBDLyHCCXwQhR82DVQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kvM+Ses/wHmHTOGEdioK+X0UHBOv4AtEBb7gIXySoVJuJYymNIZ2iIV++tq1PqJSInnm6MfbZz5AvdR5JKCinf+jPoIiHf2bXcid15G86sqk5w0B+16sJo1RknEo8xExCqmtq3lFMJ/Sn2n985rMQrN/UXnE2DhCpJJAKcvKlvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eOZuMP3Y; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761524329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bl37ymUxPOSh0uADw//c0j6dKMZwyMMccmkvzyDx4iM=;
	b=eOZuMP3YnOEWGFWVtF/ftO+8SRUHWmHScyHnXOlOguZMARhIFfjX6sqmO47lRG+itvrsHM
	VJbcALMJ2V6BS3ViFqh6zBNwGFDtmBMcmAwdyTK1+X8+MWv4ww2WP3ptm+SvR80zQMPiss
	GaKUK0KelWKyr+AlBBknSDXoK/f99HM=
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
Subject: [PATCH v4 6/8] um: vdso: Remove getcpu support on x86
Date: Mon, 27 Oct 2025 08:18:13 +0800
Message-Id: <20251027001815.1666872-7-tiwei.bie@linux.dev>
In-Reply-To: <20251027001815.1666872-1-tiwei.bie@linux.dev>
References: <20251027001815.1666872-1-tiwei.bie@linux.dev>
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


