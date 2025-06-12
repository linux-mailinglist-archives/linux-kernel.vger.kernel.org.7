Return-Path: <linux-kernel+bounces-683154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2B1AD69A6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jun 2025 09:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5700C3AD2EC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jun 2025 07:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D1021D5BC;
	Thu, 12 Jun 2025 07:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="O2hdrRWt"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0972D2036EC
	for <linux-kernel@vger.kernel.org>; Thu, 12 Jun 2025 07:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749714992; cv=none; b=CtchH+oK42C2tXcIdxEyZ4Bze75kAJhXdh+kmjVT7ZS5exGkI1HVdQ59voXLBBUYRt+KyYeA7JH9EAiEf+FvYIUlGUpNV9dTH/rY48tO5v9jwC1RRdmJ8nvS1flQ0+cqiGfwVij8j52d47z6QkHLup4HvJ8Vt6ElosjcajYqBCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749714992; c=relaxed/simple;
	bh=wa3NJsPEjZo2b/QKbicW0EiI4fSq+OLPcvk7PO4wrSQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fJyRRKAiRMW3dcDnQuPyCWY7P7MN59ckazj/cRhel5+zyMC2TkLipA5PDBngSBNmMfZjvp03II1xjiSwTixcN+jNQ784fFsNQNRksYXUXa6DhEX+aBANBMYU3Do6uXsrwKANpvu/QkaI+/8BL0tMY+/2+MAIeQ/mVcRiO85NEq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=O2hdrRWt; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749714989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1+SMqaJRr2gw7tiajb6Lxu2Z2z8tbEjCcRQA4pFVOF8=;
	b=O2hdrRWtE8/GveWZM54ufI3rPq0hQOWJ8G77Z1Ob6wyYMYuxePNRwh3W+zSjjl848iCY27
	S/TuCEzT4w8GJ7alvZAz54OVcs5si6E0DDs4WEIhTvJI7qApSDxez2UVNKYfJTuo6tm535
	1f3kgueW3pa5qBGel5l4wA6MohnbXWM=
From: Hao Ge <hao.ge@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Mike Rapoport <rppt@kernel.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linux-s390@vger.kernel.org,
	Hao Ge <hao.ge@linux.dev>,
	Hao Ge <gehao@kylinos.cn>
Subject: [PATCH 2/5] alpha: Modify the definition logic of WEAK_PER_CPU
Date: Thu, 12 Jun 2025 15:54:25 +0800
Message-Id: <5b5d8f51fbf51aefaab0fb36db05ad24a63b3e3e.1749702889.git.gehao@kylinos.cn>
In-Reply-To: <cover.1749702889.git.gehao@kylinos.cn>
References: <cover.1749702889.git.gehao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Hao Ge <gehao@kylinos.cn>

As stated in the first patch of this patch series,
we make ARCH_NEEDS_WEAK_PER_CPU a Kconfig option,
and replace all instances of ARCH_NEEDS_WEAK_PER_CPU
in the kernel code with MODULE_NEEDS_WEAK_PER_CPU,
gated by #ifdef CONFIG_ARCH_NEEDS_WEAK_PER_CPU.

We'll make corresponding changes for the alpha
architecture.

Suggested-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Hao Ge <gehao@kylinos.cn>
---
 arch/alpha/Kconfig              | 1 +
 arch/alpha/include/asm/percpu.h | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index 109a4cddcd13..ce9bc842e384 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -7,6 +7,7 @@ config ALPHA
 	select ARCH_HAS_DMA_OPS if PCI
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_MIGHT_HAVE_PC_SERIO
+	select ARCH_NEEDS_WEAK_PER_CPU
 	select ARCH_NO_PREEMPT
 	select ARCH_NO_SG_CHAIN
 	select ARCH_USE_CMPXCHG_LOCKREF
diff --git a/arch/alpha/include/asm/percpu.h b/arch/alpha/include/asm/percpu.h
index 6923249f2d49..5d8b75ec3bf2 100644
--- a/arch/alpha/include/asm/percpu.h
+++ b/arch/alpha/include/asm/percpu.h
@@ -10,8 +10,8 @@
  *
  * Always use weak definitions for percpu variables in modules.
  */
-#if defined(MODULE) && defined(CONFIG_SMP)
-#define ARCH_NEEDS_WEAK_PER_CPU
+#if defined(MODULE) && defined(CONFIG_SMP) && defined(CONFIG_ARCH_NEEDS_WEAK_PER_CPU)
+#define MODULE_NEEDS_WEAK_PER_CPU
 #endif
 
 #include <asm-generic/percpu.h>
-- 
2.25.1


