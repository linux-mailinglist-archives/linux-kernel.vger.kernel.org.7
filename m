Return-Path: <linux-kernel+bounces-854983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D9343BDFDF0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7D90C355458
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 17:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE36A3431F0;
	Wed, 15 Oct 2025 17:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="usKH+/RX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mP+RV8jN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986503431EC
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 17:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760549400; cv=none; b=nBPascpoK4oFE5AWbuAs40FMFWs5X0yMkiZwqIG2Ap9oWGGNNMMVwE0MNG6NXAjRBzuAPOgswWRFfyWmx+R9PTIlsCBd8EMgWnxcs41hH/IDd0rlYcGfDAUQeq49WXtj6CKZRtXFl+UIXwSU04uoolbouKDY15amJBZ3ILHODyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760549400; c=relaxed/simple;
	bh=GoiRX33kGm2vsBAgraaQ2dJcbW0n5konRrbN4aG3wfk=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=gXHj4om0kADN7HHNU5Q4idwaPaJcMOJWe4T4yR36lNbzukfXdg6O25r/4teEToiJlBi6mNSBszlOzXqSXy44aX4jH4XiabupRjT21pzxyeN0jQcSliSRwnZmjNHGI4Zxeyh6SgehdTJBz43XyhQrJOYPfyXV4rUNptHwtxRFP68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=usKH+/RX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mP+RV8jN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251015172835.375051021@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760549397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=LDQh6T+IJXDzKvHhdN2SgGNv5hIdajiORp6yTi65eas=;
	b=usKH+/RXLPIIvyP1GS6/Ru+Gs1SswWxXnRA1ctkvTLqCCW2pGOEl3HxNeyvAONsB6EU01M
	xe9J5J5SqHzmWKucLk8vjslhgaiCWYqQ3TOHln1Z6EFh5zF2aXWTiAw5nxsrWvpTb4sQVD
	j8/6OsYmhWfM4JflucoXMnEI7ewjiU1ry0ICfaHqL/FWn5FHG+hqGryhyC3rNNUvtyPNG5
	3Y3K06X+4zqOKpvZc8hi5UUE3nI7pu1WxRq5pm+nR8X06yxRtg/0nmM3wxE15E6Djng1xC
	Su0ipKgnVe8H+zB+2crIiWydJsBoKcPvWlF7Va6j9q6vH7A/7qA6khJuT+wScQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760549397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=LDQh6T+IJXDzKvHhdN2SgGNv5hIdajiORp6yTi65eas=;
	b=mP+RV8jNphx7SBSCgad8Cv+49YpD6JJnI0UKh/wj9w61BdOieN8/9lHlQ47HT/nGATxW9C
	F1Eiwh8efXK4wWDw==
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
 TCMalloc Team <tcmalloc-eng@google.com>
Subject: [patch 17/19] irqwork: Move data struct to a types header
References: <20251015164952.694882104@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Oct 2025 19:29:56 +0200 (CEST)

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


