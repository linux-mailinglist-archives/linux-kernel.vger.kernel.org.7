Return-Path: <linux-kernel+bounces-870721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C350C0B873
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 01:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C5D994EF6C9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 00:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68DFC22A4E1;
	Mon, 27 Oct 2025 00:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RPgmt2Zq"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8ABF224AF7
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 00:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761524338; cv=none; b=pwDeFruPf4pbE7q8gh6ds7Lj1BzvM1jhHPCraV1i9/P/BiCb0a8iNu0tx+Imkp5/KMFmdFyyYviDw/OjkcMogWQ9qJcMdESq2kh1R84bUd8LBAlUNvSbC+BGI14Ul6vj7X4lI+WZ790kL6Wr9VLKEbaXB4Jc2nuv08C0ngyMgLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761524338; c=relaxed/simple;
	bh=gQC8pzFStzV9HCUhKstI64TzErxvRdTVTp4p2D5OXC0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AJj67nd/gqOZ37rPHLDoRe/IWPTWDAJJLR1oeNrJB6pjkrzAb7BX11hzI2Z/pwTEB2aY9mV4PiUOdvT6nsShnbP2Vp0of/FY5ZZ7fUZOFq0hbI1nkAczXWxkSs6CVFeJESxHxMyuE/mucx7djOqwauhvMQ0IYia2KsL/KWJC1aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RPgmt2Zq; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761524334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5PrMNLYQkZylc5n1vPcSLoxov+KMpq+EjdZMAgd4fn0=;
	b=RPgmt2Zq6/tx29vMni0i4vk0rs03J2goYZRIH8kXNfJhbpqasu7y1B0zMn8hKwCXEPeRP2
	qwDRg3vvxoovXEYMOlt9+n+Z0yig9GffQJYFsm/34VSXyt2CPF9HjxN5bm4nQXrTs1vluh
	LWujaIofUYT619yAVrtIlDeTgGBqcJw=
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
Subject: [PATCH v4 8/8] um: Enable SMP support on x86
Date: Mon, 27 Oct 2025 08:18:15 +0800
Message-Id: <20251027001815.1666872-9-tiwei.bie@linux.dev>
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


