Return-Path: <linux-kernel+bounces-876128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 246DBC1B105
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CAF45885B3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89FFF253B64;
	Wed, 29 Oct 2025 13:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qsFnIIJA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GY77bgrK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D3C34F461
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761743372; cv=none; b=usgIUgGeewWDhz//I9aJquTKqJYL7rD/lSEwxPE8NnxGg3/4i6WvbYogEc/src1eE6pCvT58tsjSBBZzvGBLtLEo07EcGW/zusx2OOMgacP66hRMPxYxv8ZMiHcqFE5vJyFIYXgIuWxg8HKwMZBi9HU8Kg2Bgttq0E8YoXQ2QmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761743372; c=relaxed/simple;
	bh=GoiRX33kGm2vsBAgraaQ2dJcbW0n5konRrbN4aG3wfk=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=t/PG4TrogG59CiqGingtcE0mAaaGqGg76FuCy5Pqh4Mk05LJ1xne2FQMR3kMz8XoVkSd4F4Tl9Lh0vhXRW7qWYY3Va09Eptevoyt9rl65YyjrwdKG1JpU4TK3ivjGepX1iSblZSupQQMZ9sODaVNf/1d8psQUcLZlVwINC938M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qsFnIIJA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GY77bgrK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251029124516.404582236@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761743369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=LDQh6T+IJXDzKvHhdN2SgGNv5hIdajiORp6yTi65eas=;
	b=qsFnIIJArOjQXoREGvVKttC09JRBas3MY12hAgpjeAvKr/qiXpWDYhWFoDOtd8/o/DSIbZ
	Or0D0Pgxo9dGq/nb//bHgbxCuKVGinDiKt9ffENmTs/KLPzx/2vu0mGeR6jxSksyGfDlGK
	plo2xKbJxEr4MEewFrrILcDq2ZBJ3k8ejHHbR+lCXmhB1s8cItI74dSRjDxS4tr9E97GqW
	zNKMQ2BHyUujGmxXEXp/SQJatrG6lutMxodzQAbXIUt0UJVAw7piefTeOAKBkRigsb+JHo
	4NiIU0Wci5BKN4tCPuz+DQDpSBRUDbmVCo19ZevXvffTTACxKnmAGW3B3cAJ/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761743369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=LDQh6T+IJXDzKvHhdN2SgGNv5hIdajiORp6yTi65eas=;
	b=GY77bgrKVXo8e0ydQToSpA+rutSqj3XHSaCMAAMwxASKzUKQHUrydic8LkR3ZY365uBK8r
	gQJsEC90Ngqq3fBA==
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
 Yury Norov <yury.norov@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: [patch V3 18/20] irqwork: Move data struct to a types header
References: <20251029123717.886619142@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Oct 2025 14:09:28 +0100 (CET)

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


