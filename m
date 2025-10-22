Return-Path: <linux-kernel+bounces-865018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 092A1BFC02F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AAC8A350C75
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD02351FD0;
	Wed, 22 Oct 2025 12:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gFsoVfmm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mFqQQYMD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9055351FAA
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 12:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137745; cv=none; b=C8i9UUPvjX79cOcJ7Z6MOK6zacIqK0cVCUQOpIvA1b+bji7GOCaxIDuUpsJJMH8yLHP9R0QHZ95qHyKFqmohms8+6z+BeEQs2cCC91e8FCKwPqlP5dTnbkQm2KG3TCCxbKjwTx/Mk883zRBwxLisPFM/DUiqIfxPKposS50NzcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137745; c=relaxed/simple;
	bh=GoiRX33kGm2vsBAgraaQ2dJcbW0n5konRrbN4aG3wfk=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=RW0tBxIqke0ZgZHbhv8zrZ3OBfkhcuYgrCYMgW7wJMb47jzELSyps9Dlu9qpG38cVBS0QUuyoV1WLiTq9/ecJvDp+I1lFmkHOQWe5RZWGnDvO1brCvmobOA5toZOU8/wRPCGEfRniVUMWd3Uxak8lcs/MtGYNbKWsNPiZN6HDPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gFsoVfmm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mFqQQYMD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251022110556.519886095@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761137742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=LDQh6T+IJXDzKvHhdN2SgGNv5hIdajiORp6yTi65eas=;
	b=gFsoVfmmRq3GWhxcbZs7laD4gw5X90fGN+rOxv+rFHHboO6XZzd8i2KG7ZQJs+X3aytmO+
	dviJ3fbdmhFOxYca8ol3K6s/sxg+rvub+e0HqW9Y63XG83+ukGhV0w1X1pYnNWdH+DC6/X
	Oti9kqPmXNfUJI5HdXA6U1sZxs6w6OQm572eCjOWR+SjbRAyLqkcFpLhppnJRPFTitQxow
	zsYb5OLolMsFVmPUaKhzyuPeEfeYzpmmuN81OfzxBAVS9OYDJ6VkS7OnKIxuWEVWsDIeKT
	M/IZgT1I5lhFzmNMaLBl/5fXlO7BU4ymugkrktoRBpd57VD4x8lrX1IEQ8VX+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761137742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=LDQh6T+IJXDzKvHhdN2SgGNv5hIdajiORp6yTi65eas=;
	b=mFqQQYMDHq3QQixlYsaqL/UYaXGqgslXeQt/odryVnji555209YcwQLqbr5KVOCRK2QQ+p
	8rcxxn2Y0gVbW3Aw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Gabriele Monaco <gmonaco@redhat.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Michael Jeanson <mjeanson@efficios.com>,
 Jens Axboe <axboe@kernel.dk>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Florian Weimer <fweimer@redhat.com>,
 Tim Chen <tim.c.chen@intel.com>,
 Yury Norov <yury.norov@gmail.com>
Subject: [patch V2 18/20] irqwork: Move data struct to a types header
References: <20251022104005.907410538@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Oct 2025 14:55:41 +0200 (CEST)

... to avoid header recursion hell.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/irq_work.h       |    9 ++-------
 include/linux/irq_work_types.h |   14 ++++++++++++++
 2 files changed, 16 insertions(+), 7 deletions(-)

--- a/include/linux/irq_work.h
+++ b/include/linux/irq_work.h
@@ -2,8 +2,9 @@
 #ifndef _LINUX_IRQ_WORK_H
 #define _LINUX_IRQ_WORK_H
 
-#include <linux/smp_types.h>
+#include <linux/irq_work_types.h>
 #include <linux/rcuwait.h>
+#include <linux/smp_types.h>
 
 /*
  * An entry can be in one of four states:
@@ -14,12 +15,6 @@
  * busy      NULL, 2 -> {free, claimed} : callback in progress, can be claimed
  */
 
-struct irq_work {
-	struct __call_single_node node;
-	void (*func)(struct irq_work *);
-	struct rcuwait irqwait;
-};
-
 #define __IRQ_WORK_INIT(_func, _flags) (struct irq_work){	\
 	.node = { .u_flags = (_flags), },			\
 	.func = (_func),					\
--- /dev/null
+++ b/include/linux/irq_work_types.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_IRQ_WORK_TYPES_H
+#define _LINUX_IRQ_WORK_TYPES_H
+
+#include <linux/smp_types.h>
+#include <linux/types.h>
+
+struct irq_work {
+	struct __call_single_node	node;
+	void				(*func)(struct irq_work *);
+	struct rcuwait			irqwait;
+};
+
+#endif


