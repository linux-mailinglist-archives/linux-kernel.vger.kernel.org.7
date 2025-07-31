Return-Path: <linux-kernel+bounces-752245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C60DB172E9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 16:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 523D61884C43
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 14:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BB52D1F61;
	Thu, 31 Jul 2025 14:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0WN6CHmZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EEJGy1cR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F25B21CC5B
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 14:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753971144; cv=none; b=nPzJzjcdtEAnY3snfQMS/f3kXulfP0GAynnyMDma7l51U5ds6/ekfOBW0kbdctRwPfkDEwfDeT15a3EJhDvFHSAsozrRMDsCOKZbxHlo6Xwx1iy0erwdHe6JPVT//QXriGIrratCVchFIJn9TqROFKmri5zie/x7xgAs3hX7ynA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753971144; c=relaxed/simple;
	bh=jFDjYpX8Wpic/NULK6oZcKbJ+utTB3WBayihdW+c5BA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=njfD5XnDxDbux68XpCMc+fEmmurE4Hhd09AlmUDI61nNILlsysHt+D7IH7rrQdg0SPwyrW9C048nbW/OwoSv0MC5RFF3Ezs0q2PkoVxG0XfyC6+JPetH1jrOcDcOwIzPjp8LS4ufXTYYnm416N5cDULjdnzkKq4zS11jIndUoCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0WN6CHmZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EEJGy1cR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753971140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=ZNv0LIz/6anTiIWtFnSJEcwWfmJmIFwP36hCRM6tLfY=;
	b=0WN6CHmZbLge7xxrFC/TYp8PLQaaKx/ZtsHbTNCmzOuRl3/9kz0sHthJmyj0WN0xSiYLEx
	WQhrPAnmuDLpokODuGGBIqCmKLBCmxU0DkuxfSiRXAo3+nfhSLoUuRaqxww2w/64p9Cp8a
	59EjgzCdPPSiCrsMxJ5XO1rF0wMOMFxPaFkh1xp9NoCdSyYRqY0eGmwrfkvpSLcWzS6exb
	bCiuUtWSKT147s2svhs8DRWOqS/yl4uhqDYVQjKS0KTM+4JhmGf9wHjATZ0+8KqYCDjy5G
	g4GiTmrJVjSd0onAbqUFQwE4u03JPzWnHHnEX7xFRMURBtaEAxHfqvyI/KWMiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753971140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=ZNv0LIz/6anTiIWtFnSJEcwWfmJmIFwP36hCRM6tLfY=;
	b=EEJGy1cRIw4OormPYjVGT8+hJ95RSK/5FFVIZh9nQDhvsvgEHXy1VykUB0pEgm5u1RvOWH
	LGplj/LSVBkfAvAg==
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86/apic: Make the ISR clearing sane
Date: Thu, 31 Jul 2025 16:12:19 +0200
Message-ID: <871ppwih4s.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

apic_pending_intr_clear() is fundamentally voodoo programming. It's primary
purpose is to clear stale ISR bits in the local APIC, which would otherwise
lock the corresponding interrupt priority level.

The comments and the implementation claim falsely that after clearing the
stale ISR bits, eventually stale IRR bits would be turned into ISR bits and
can be cleared as well. That's just wishful thinking because:

  1) If interrupts are disabled, the APIC does not propagate a IRR bit to
     ISR.

  2) If interrupts are enabled, then the APIC propagates the IRR bit to ISR
     and raises the interrupt in the CPU, which means that code _cannot_
     observe the ISR bit for any of those IRR bits.

Rename the function to reflect the purpose and make exactly _one_ attempt
to EOI the pending ISR bits and add comments why traversing the pending bit
map in low to high priority order is correct.

Instead of trying to "clear" IRR bits, simply print a warning message when
the IRR is not empty.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/apic/apic.c |   77 +++++++++++++++++++++-----------------------
 1 file changed, 37 insertions(+), 40 deletions(-)

--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1428,63 +1428,61 @@ union apic_ir {
 	u32		regs[APIC_IR_REGS];
 };
 
-static bool apic_check_and_ack(union apic_ir *irr, union apic_ir *isr)
+static bool apic_check_and_eoi_isr(union apic_ir *isr)
 {
 	int i, bit;
 
-	/* Read the IRRs */
-	for (i = 0; i < APIC_IR_REGS; i++)
-		irr->regs[i] = apic_read(APIC_IRR + i * 0x10);
-
 	/* Read the ISRs */
 	for (i = 0; i < APIC_IR_REGS; i++)
 		isr->regs[i] = apic_read(APIC_ISR + i * 0x10);
 
+	/* If the ISR map empty, nothing to do here. */
+	if (bitmap_empty(isr->map, APIC_IR_BITS))
+		return true;
+
 	/*
-	 * If the ISR map is not empty. ACK the APIC and run another round
-	 * to verify whether a pending IRR has been unblocked and turned
-	 * into a ISR.
+	 * There can be multiple ISR bits set when a high priority
+	 * interrupt preempted a lower priority one. Issue an EOI for each
+	 * set bit. The priority traversal order does not matter as there
+	 * can't be new ISR bits raised at this point. What matters is that
+	 * an EOI is issued for each ISR bit.
 	 */
-	if (!bitmap_empty(isr->map, APIC_IR_BITS)) {
-		/*
-		 * There can be multiple ISR bits set when a high priority
-		 * interrupt preempted a lower priority one. Issue an ACK
-		 * per set bit.
-		 */
-		for_each_set_bit(bit, isr->map, APIC_IR_BITS)
-			apic_eoi();
-		return true;
-	}
+	for_each_set_bit(bit, isr->map, APIC_IR_BITS)
+		apic_eoi();
 
-	return !bitmap_empty(irr->map, APIC_IR_BITS);
+	/* Reread the ISRs, they should be empty now */
+	for (i = 0; i < APIC_IR_REGS; i++)
+		isr->regs[i] = apic_read(APIC_ISR + i * 0x10);
+
+	return bitmap_empty(isr->map, APIC_IR_BITS);
 }
 
 /*
- * After a crash, we no longer service the interrupts and a pending
- * interrupt from previous kernel might still have ISR bit set.
+ * If a CPU services an interrupt and crashes before issuing EOI to the
+ * local APIC, the corresponding ISR bit is still set when the crashing CPU
+ * jumps into a crash kernel. Read the ISR and issue an EOI for each set
+ * bit to acknowledge it as otherwise these slots would be locked forever
+ * waiting for an EOI.
  *
- * Most probably by now the CPU has serviced that pending interrupt and it
- * might not have done the apic_eoi() because it thought, interrupt
- * came from i8259 as ExtInt. LAPIC did not get EOI so it does not clear
- * the ISR bit and cpu thinks it has already serviced the interrupt. Hence
- * a vector might get locked. It was noticed for timer irq (vector
- * 0x31). Issue an extra EOI to clear ISR.
+ * If there are pending bits in the IRR, then they won't be converted into
+ * ISR bits as the CPU has interrupts disabled. They will be delivered once
+ * the CPU enables interrupts and there is nothing which can prevent that.
  *
- * If there are pending IRR bits they turn into ISR bits after a higher
- * priority ISR bit has been acked.
+ * In the worst case this results in spurious interrupt warnings.
  */
-static void apic_pending_intr_clear(void)
+static void apic_clear_isr(void)
 {
-	union apic_ir irr, isr;
+	union apic_ir ir;
 	unsigned int i;
 
-	/* 512 loops are way oversized and give the APIC a chance to obey. */
-	for (i = 0; i < 512; i++) {
-		if (!apic_check_and_ack(&irr, &isr))
-			return;
-	}
-	/* Dump the IRR/ISR content if that failed */
-	pr_warn("APIC: Stale IRR: %256pb ISR: %256pb\n", irr.map, isr.map);
+	if (!apic_check_and_eoi_isr(&ir))
+		pr_warn("APIC: Stale ISR: %256pb\n", ir.map);
+
+	for (i = 0; i < APIC_IR_REGS; i++)
+		ir.regs[i] = apic_read(APIC_IRR + i * 0x10);
+
+	if (!bitmap_empty(ir.map, APIC_IR_BITS))
+		pr_warn("APIC: Stale IRR: %256pb\n", ir.map);
 }
 
 /**
@@ -1541,8 +1539,7 @@ static void setup_local_APIC(void)
 	value |= 0x10;
 	apic_write(APIC_TASKPRI, value);
 
-	/* Clear eventually stale ISR/IRR bits */
-	apic_pending_intr_clear();
+	apic_clear_isr();
 
 	/*
 	 * Now that we are all set up, enable the APIC

