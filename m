Return-Path: <linux-kernel+bounces-761334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA435B1F887
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 07:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 180BE3B9A53
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 05:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4A51F463C;
	Sun, 10 Aug 2025 05:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Kb2KC3PV"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C90620F070
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 05:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754805155; cv=none; b=BgrAlgyLpH1unfGhGbElnAV0mqWGuqnkm0/9BAZWllPSZjPRTskDuYo3TjEvp7o2FoHnvLnRHbjKtsGbj7/tAGhWEAaZNnoyDSVJ4ln6hULhOi1dW0qRaMTlxmGZGrenEUCXZlqJMnRFC+ITDftPOnIXd04LocCzpwnq+0vlztU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754805155; c=relaxed/simple;
	bh=gQC8pzFStzV9HCUhKstI64TzErxvRdTVTp4p2D5OXC0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lhkos37kpZqTOEP/OSKJUfEB6rGFfI+dSB+42uh9SiKLQ+YAq6ocnqR8iamr3REA728tg2NGw+LfgR5a4R3dqZ57GwlZ+7U63cyQa/RCcOosLHjrVlKPr8E9NpeIJfPZjbsewVnK2QcgYoA2yY2gG+rF1npOO+DQfoIh66egGAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Kb2KC3PV; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754805151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5PrMNLYQkZylc5n1vPcSLoxov+KMpq+EjdZMAgd4fn0=;
	b=Kb2KC3PVfC5+Y4xRje9+OI6lyUNIZNtAUhwTlkX968k56y0QGz/BrSlMRaXhuoSc3bKDdK
	mC1TigcPenI510LxtP5Ar01tNk2sCgaiNhhhzQIIiuxseuUC0ClE+N+f6eNOtw3NLCapSz
	WxYgQJPajgG3aL5Sa9lK9EPRXvmWapo=
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
Subject: [PATCH v2 10/10] um: Enable SMP support on x86
Date: Sun, 10 Aug 2025 13:51:36 +0800
Message-Id: <20250810055136.897712-11-tiwei.bie@linux.dev>
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


