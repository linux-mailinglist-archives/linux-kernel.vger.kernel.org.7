Return-Path: <linux-kernel+bounces-761327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 903F1B1F87E
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 07:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABF35177D2F
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 05:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6491F4C89;
	Sun, 10 Aug 2025 05:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TjlKVcG/"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5FE1F1505
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 05:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754805130; cv=none; b=MeLFRaONEYgT2gmkGSAb4BZWypcfypE35VEHHT7cgju6WKWzgTO0IFmQ02i9zR96BTGeRiJwfy/n9RUznU8K7Fs1I9hVoXdhpyOWMHmMhzFYdKRNbXz3XEZZeeSO10WoHJ2nUAGZyXasiEIProDmq5w/a2Dx7ljYesk89jceEXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754805130; c=relaxed/simple;
	bh=WPhk9hHw3oCWaM0EiyBcpIHcJ1quNtPltAXxQki2vm0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eolLhNIy4rrsZguKfg1l5eS/Okrr7VE9zD4pn9tGYj3BFq0ZWggHoqpoANrkqe6ED40Mxw1xuugBnbqv25NN4kazaVA2HfMfkkpDhi5pvwM4XPXIBE0x2lPTWVfpkPR93UhoQ7Ker00y5htYdPlPsYm7QN+9ZYUSkp4gJqsjVrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TjlKVcG/; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754805126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7hkA9J0yJ6LYuwj61ZyOGv+Xl/BzsgcrZZJOuPyYgKM=;
	b=TjlKVcG/tJ4JYkK7b+zLRsRRF3QxXSglX+I80xS/tup7DNJ/eOvwUhrQEdInLiTOWpTH2p
	yWFHNVWQnjEvjS/zlkr6cu7Sk01px/6vjXZcNYsBw+G0jsXb7HChKX8mOIEHPAVSZG7/vh
	3KWCYUf0nJsvagBXiIdaldN2sIZjEkU=
From: Tiwei Bie <tiwei.bie@linux.dev>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	benjamin@sipsolutions.net,
	arnd@arndb.de,
	tiwei.btw@antgroup.com,
	tiwei.bie@linux.dev
Subject: [PATCH v2 03/10] um: vdso: Implement __vdso_getcpu() via syscall
Date: Sun, 10 Aug 2025 13:51:29 +0800
Message-Id: <20250810055136.897712-4-tiwei.bie@linux.dev>
In-Reply-To: <20250810055136.897712-1-tiwei.bie@linux.dev>
References: <20250810055136.897712-1-tiwei.bie@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Tiwei Bie <tiwei.btw@antgroup.com>

We are going to support SMP in UML, so we can not hard code
the CPU and NUMA node in __vdso_getcpu() anymore.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/x86/um/vdso/um_vdso.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/x86/um/vdso/um_vdso.c b/arch/x86/um/vdso/um_vdso.c
index cbae2584124f..ee40ac446c1c 100644
--- a/arch/x86/um/vdso/um_vdso.c
+++ b/arch/x86/um/vdso/um_vdso.c
@@ -17,7 +17,7 @@
 int __vdso_clock_gettime(clockid_t clock, struct __kernel_old_timespec *ts);
 int __vdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz);
 __kernel_old_time_t __vdso_time(__kernel_old_time_t *t);
-long __vdso_getcpu(unsigned int *cpu, unsigned int *node, struct getcpu_cache *unused);
+long __vdso_getcpu(unsigned int *cpu, unsigned int *node, struct getcpu_cache *tcache);
 
 int __vdso_clock_gettime(clockid_t clock, struct __kernel_old_timespec *ts)
 {
@@ -60,18 +60,16 @@ __kernel_old_time_t __vdso_time(__kernel_old_time_t *t)
 __kernel_old_time_t time(__kernel_old_time_t *t) __attribute__((weak, alias("__vdso_time")));
 
 long
-__vdso_getcpu(unsigned int *cpu, unsigned int *node, struct getcpu_cache *unused)
+__vdso_getcpu(unsigned int *cpu, unsigned int *node, struct getcpu_cache *tcache)
 {
-	/*
-	 * UML does not support SMP, we can cheat here. :)
-	 */
+	long ret;
 
-	if (cpu)
-		*cpu = 0;
-	if (node)
-		*node = 0;
+	asm volatile("syscall"
+		: "=a" (ret)
+		: "0" (__NR_getcpu), "D" (cpu), "S" (node), "d" (tcache)
+		: "rcx", "r11", "memory");
 
-	return 0;
+	return ret;
 }
 
 long getcpu(unsigned int *cpu, unsigned int *node, struct getcpu_cache *tcache)
-- 
2.34.1


