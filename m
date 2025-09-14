Return-Path: <linux-kernel+bounces-815733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5A0B56A6D
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 18:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EE84420E6F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 15:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC02F2E040D;
	Sun, 14 Sep 2025 15:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AQEHU1/b"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0875A2DE6F4
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 15:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757865486; cv=none; b=UUjwm0s4KzHYvQ20yMYxJ+FqRw+bx9Q6KMyatWQgknzwpPWwjE5LMDmxEOjjd+Iwb5tCG3vpD0kEHz68Ly5OOJ2pmId5tAtiR/U5cyoweiM0WlC1rr1OroY8i7tyk7rq/AUFia0w9yL4pbTEAiIEmIx+gjyI7h7d5c3ublKYMKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757865486; c=relaxed/simple;
	bh=gQC8pzFStzV9HCUhKstI64TzErxvRdTVTp4p2D5OXC0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d/wfgQbFxMYtZfcxQW/+s91v7Y7loC7vEToiHxWn9oTG7Cuj4+AO6VeuVqlUKXiS+0nqXlhNIL285XXWX/p0k8Rf0UxQz8rfAXqgmN8Q9ymbMvtVIyDNosL88aFSW61h3vilaAMN69B18sRqXRsGiAum9lJONTrFzOuMs1nzrqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AQEHU1/b; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757865481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5PrMNLYQkZylc5n1vPcSLoxov+KMpq+EjdZMAgd4fn0=;
	b=AQEHU1/baTn8QuB1DSckGM3cwWO89rF4kAwbX4r+tW6Q0DC2FY0yEBuUz4mL7wO1pGMeCL
	NsU9Wm9VDYsnU4Jd7S7oWB++LBOu8TNMjIk9v1IafKctN4gLO4eVPQLe+Nf/2aUs1VJL5W
	qlRHqU2oz/xIQk4SF1NpdRbXDuQJDRQ=
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
Subject: [PATCH v3 7/7] um: Enable SMP support on x86
Date: Sun, 14 Sep 2025 23:56:58 +0800
Message-Id: <20250914155658.1028790-8-tiwei.bie@linux.dev>
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

Implement spinlock support for SMP on UML/x86, leveraging x86's
spinlock implementation. In addition, to support SMP on CPUs that
do not support CX8, some additional work is required. However,
considering that such CPUs are already very outdated, and x86 is
also removing support for them [1], let's enable SMP support only
on CPUs that support CX8.

[1] https://lore.kernel.org/lkml/20250515085708.2510123-1-mingo@kernel.org/

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/x86/um/Kconfig        | 3 +++
 arch/x86/um/asm/spinlock.h | 8 ++++++++
 2 files changed, 11 insertions(+)
 create mode 100644 arch/x86/um/asm/spinlock.h

diff --git a/arch/x86/um/Kconfig b/arch/x86/um/Kconfig
index 986045d5e638..c52fb5cb8d21 100644
--- a/arch/x86/um/Kconfig
+++ b/arch/x86/um/Kconfig
@@ -9,8 +9,11 @@ endmenu
 config UML_X86
 	def_bool y
 	select ARCH_BINFMT_ELF_EXTRA_PHDRS if X86_32
+	select ARCH_USE_QUEUED_RWLOCKS
+	select ARCH_USE_QUEUED_SPINLOCKS
 	select DCACHE_WORD_ACCESS
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
+	select UML_SUBARCH_SUPPORTS_SMP if X86_CX8
 
 config 64BIT
 	bool "64-bit kernel" if "$(SUBARCH)" = "x86"
diff --git a/arch/x86/um/asm/spinlock.h b/arch/x86/um/asm/spinlock.h
new file mode 100644
index 000000000000..20fc77514214
--- /dev/null
+++ b/arch/x86/um/asm/spinlock.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_UM_SPINLOCK_H
+#define __ASM_UM_SPINLOCK_H
+
+#include <asm/qspinlock.h>
+#include <asm/qrwlock.h>
+
+#endif /* __ASM_UM_SPINLOCK_H */
-- 
2.34.1


