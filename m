Return-Path: <linux-kernel+bounces-695576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F13AE1B41
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jun 2025 14:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4814D3BC9D2
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jun 2025 12:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CEF328B40A;
	Fri, 20 Jun 2025 12:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f2L1orqi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEB2289E25
	for <linux-kernel@vger.kernel.org>; Fri, 20 Jun 2025 12:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750423938; cv=none; b=TD+9cQa77U/x+j+ng9vCqyQQkoCmpUMzNwPy7fqZdmsitWk75twMK/DeABtsQI3OCu8uQxw9obuBJKoYyTd5T3GpzMSmun9DUbQA9qKmQTJoCu5KIe6wRmPbW/q3WVzULmz5SplB1pXxKZ3w/RayADQwV2jGFXQMTO3YoQyLGXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750423938; c=relaxed/simple;
	bh=rN1ooU/vgwiM7qKfNGgfrMEc5Uuses/VTRaZdMJ+VWc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q4tYxhBdnF9KyTH+JWILagCYNroGbD0ehsBmyeUnVkSLmncttsh5ghq8EiKuyraOQPsu6CdruGwDn8w+EIyJhFmZ4sEiOXpA13Id+PMwfMrhL1PnNRA9EgiSQm1/lN3NWVHN+V8A5wNvnz12KDkfEetrHjQWQeQyx3ulfHYVONM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f2L1orqi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750423936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WdDZ6z+nY5bkBJ/Zc38cvy69vch4xTVz4tRvVbwqk+c=;
	b=f2L1orqiuGLA1jYg2mAimdvkO3gUwHej+FCSvLV6wkvd7SrrrliqQ0Fo3FlGLKNI6vmj0j
	HujnH22vStqe/5uBoJTUmfX3JDs/ar/y7i0aQO3ksxc098yNRjU/p0p93CYU/Z0stO8VHd
	zBl8dONjvdVNMJja/velhFJ4MjKexUI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-464-NAhqTwdcOVKVaxKZOR2Nyw-1; Fri,
 20 Jun 2025 08:52:11 -0400
X-MC-Unique: NAhqTwdcOVKVaxKZOR2Nyw-1
X-Mimecast-MFC-AGG-ID: NAhqTwdcOVKVaxKZOR2Nyw_1750423929
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 753C51800296;
	Fri, 20 Jun 2025 12:52:09 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.45.226.37])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 67ABA19560A3;
	Fri, 20 Jun 2025 12:52:05 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Andy Lutomirski <luto@kernel.org>,
	Ingo Molnar <mingo@kernel.org>
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] lockdep: Fix inconsistency in irq tracking on NMIs
Date: Fri, 20 Jun 2025 14:51:13 +0200
Message-ID: <20250620125112.33978-2-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

The irq_enable/irq_disable tracepoints fire only when there's an actual
transition (enabled->disabled and vice versa), this needs special care
in NMIs, as they could potentially start with IRQs already disabled.
The current implementation takes care of this by tracking the lockdep
state before the NMI (on nmi_entry) and not tracing on nmi_exit in case
IRQs were already disabled, we don't trace on nmi_entry following the
tracing_irq_cpu variable, which can be racy:

 local_irq_enable()
   void trace_hardirqs_on(void)
   {
   	if (tracing_irq_cpu) {
   		trace(irq_enable);
   		tracing_irq_cpu = 0;
   	}

                /*
                 * NMI here
                 * tracing_irq_cpu == 0 (done tracing)
                 * lockdep_hardirqs_enabled == 0 (IRQs still disabled)
                 */

                                   irqentry_nmi_enter()
                                       irq_state.lockdep = 0
                                       trace(irq_disable);

                                   irqentry_nmi_exit()
                                       // irq_state.lockdep == 0
                                       // do not trace(irq_enable)
   	lockdep_hardirqs_on();
   }

The error is visible with the sncid RV monitor and particularly likely
on machines with the following setup:
- x86 bare-metal with 40+ CPUs
- tuned throughput-performance (activating regular perf NMIs)
- workload: stress-ng --cpu-sched 21 --timer 11 --signal 11

The presence of the RV monitor is useful to see the error but it is not
necessary to trigger it.

Prevent this scenario by checking lockdep_hardirqs_enabled to trace also
on nmi_entry.

Fixes: ba1f2b2eaa2a ("x86/entry: Fix NMI vs IRQ state tracking")
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 kernel/entry/common.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index a8dd1f27417cf..7369132c00ba4 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -326,13 +326,15 @@ irqentry_state_t noinstr irqentry_nmi_enter(struct pt_regs *regs)
 	irq_state.lockdep = lockdep_hardirqs_enabled();
 
 	__nmi_enter();
-	lockdep_hardirqs_off(CALLER_ADDR0);
+	if (irq_state.lockdep)
+		lockdep_hardirqs_off(CALLER_ADDR0);
 	lockdep_hardirq_enter();
 	ct_nmi_enter();
 
 	instrumentation_begin();
 	kmsan_unpoison_entry_regs(regs);
-	trace_hardirqs_off_finish();
+	if (irq_state.lockdep)
+		trace_hardirqs_off_finish();
 	ftrace_nmi_enter();
 	instrumentation_end();
 

base-commit: 75f5f23f8787c5e184fcb2fbcd02d8e9317dc5e7
-- 
2.49.0


