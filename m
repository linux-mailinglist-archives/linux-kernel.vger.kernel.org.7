Return-Path: <linux-kernel+bounces-892319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C19C44D80
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 04:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9828B4E6BD6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 03:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7478E29B777;
	Mon, 10 Nov 2025 03:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AB1d/TuL"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CDD286422
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 03:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762745591; cv=none; b=CYbgboY8swAvbiaCE8EY2J7SB8q54EBS/CqQg7jVVKPYoX8xRi8L4RkebZRjQ9Iz0Pr1GQTSfvSjhKtKTkdnXttaq8aeiL9pjb9i0rp7frgrU+d8uV1GbyPBouimD1bVLRWeuzrXNncZCBBhKiI+4kxhycLwXHR+LJ3hzg5EbeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762745591; c=relaxed/simple;
	bh=09b+vbHhrBOEYNn8FA0xT6XTomv/Hy0JapSdFE/zeY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u5a4uQdGy+3SqfzN/H0aFPS4/WhqvZDdHZydtCGIPhCTMV8I0EDepswyxEnikrzJ4tZZdwKiv/qsvp2XMa+ELbbgVZ7ufn0HOI5LMJJHcMcL0/vx382CuzMjUoUSxE8n14H21DkUA8QgUKQ5y8cpp9XTj4364WL/pRBc2THTtas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AB1d/TuL; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7afd7789ccdso2327188b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 19:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762745589; x=1763350389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zoVSVco95aSsZ+WLRPu1rVoCQZWRoP65wsu+BZxzmJo=;
        b=AB1d/TuLHoxQ8Y9Uw7hmzGxySoawRICP9MXhQ3be1p7BJVndkvO+17sTVGOjbNDvQ7
         YaUVuPDyoMAATM9vl2SOKIhxPIZgjMG+kZwf4IPiiCYX7Lbd9KtaVB5rAcESk65BNNIa
         LqKnEI8ZnlL5n2s09o5e+sftpKB7bTu52UYVHZcGV2tJ/92tugGaXahvf9vs3DV3yR9Y
         pBB2pUVlMKggOolXyD1oByQvXsTjEPsBGd6dLiV0vetmLg0UmvtQqEKT2HfqeRk1r41X
         8sxnk5WCiTBbagJf/40RhnyvYisEbXvM/2pW2kXNdTrSSjPooaDHqm3ugi5DdXP/i67q
         X/dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762745589; x=1763350389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zoVSVco95aSsZ+WLRPu1rVoCQZWRoP65wsu+BZxzmJo=;
        b=XDEzcfLQZewcd9QGJnHJyZBGGeElKl9OUsy2b0idci0Ogcq2GlGAaa5H03rczn8dnM
         ZeDqA8oR5aVTUGmeuIt9565iF3qO6+EuT8h5MWyk/dWH+aBzBPlidf/UevL6lq7WxCug
         OAPEubOwbcYajgOoKB+hgsIp8wFGz6NvuP6LKLFEA1e2DV7UGy2fOE0KC7/9jNy37SlA
         yi+js/MPBe2OtgzCkd51MufWJzmROE7YlgxnWV1SxZKmGOcRcFylMVpKnOeUnoGZvA3I
         wJRvaiSj46hIJmWwWxmpxQTAOTvGhXeNlZKYjJllq6HOBVaMSpxSBz1GYo0eaUkRdmXl
         AcKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAxCUBzKU4AeZFemH+hFXeuxS3UqVMtYYUTyVvf8+hkbfMI4PZmd2czjDjreM2ZpCyfbjMIRl5foSmXI8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL/ylTD4ZfsWQCseeGRDXUjWsk7FTnwtCt0V6TgvWX0hZ5kq9m
	l+NHj4Bx1/l9qG1/iV4UlVrRF983gbTLS89IfWBqKpXAED9gxuqMZmqa
X-Gm-Gg: ASbGncsRjLXZHzyEKveerD9iyIMVZB/7ELo6H+/yYgfCMQjta9Y/rw/g+EQljDx23Tn
	5fmFXuk02A4QwOHoFSKm2etwKPtv8I/SzEFIVP3aFXtqQ2ltiidGGExpifMyZnjGveTkoiCfJpP
	k4xWQ6FJ8nISLuevRmFIW+81+GMNmCbPRaqHajhoN9KLyv1sOfLiiFFGeKwyGGsVPifxjdH6iKu
	8pAvSGwEtudpO8wuRGk2A8i565rx2AWf3YAnV3Sx9Gt+k975+GM6lEbpImV7uozDJW7EPCVktkq
	JF/48tNXHtQCBgY8fas5/zbc4AAPNTNw9TXTJqu+h4J+YX/UxFX2plY9G5/wA8yHFWkzzMHAIR/
	RNsP3sLOipWWC0h+0Wp9wf2TY8EfxDZIMgpbagWps1i8t6AdaYQeyDSk6zi+vrLKQTW0KEZJCfi
	sFHYAZkAbZ
X-Google-Smtp-Source: AGHT+IEzdOGW9LWlgg85G8xU5GsMwAx7axVYpwr4bSwlgM2m5DSuAh0+Gpq6gNufx4C6g/hc7Bclzg==
X-Received: by 2002:a05:6a21:6d9d:b0:33e:eb7a:4465 with SMTP id adf61e73a8af0-353a1ddf726mr8793770637.22.1762745589091;
        Sun, 09 Nov 2025 19:33:09 -0800 (PST)
Received: from wanpengli.. ([124.93.80.37])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-ba900fa571esm10913877a12.26.2025.11.09.19.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 19:33:08 -0800 (PST)
From: Wanpeng Li <kernellwp@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	Wanpeng Li <wanpengli@tencent.com>
Subject: [PATCH 08/10] KVM: x86/lapic: Integrate IPI tracking with interrupt delivery
Date: Mon, 10 Nov 2025 11:32:29 +0800
Message-ID: <20251110033232.12538-9-kernellwp@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251110033232.12538-1-kernellwp@gmail.com>
References: <20251110033232.12538-1-kernellwp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wanpeng Li <wanpengli@tencent.com>

From: Wanpeng Li <wanpengli@tencent.com>

Integrate IPI tracking with LAPIC interrupt delivery and EOI handling.

Hook into kvm_irq_delivery_to_apic() after destination resolution to
record sender/receiver pairs when the interrupt is LAPIC-originated,
APIC_DM_FIXED mode, with exactly one destination vCPU. Use counting
for efficient single-destination detection.

Add kvm_clear_ipi_on_eoi() called from both EOI paths to ensure
complete IPI context cleanup:

1. apic_set_eoi(): Software-emulated EOI path (traditional/non-APICv)
2. kvm_apic_set_eoi_accelerated(): Hardware-accelerated EOI path
   (APICv/AVIC)

Without dual-path cleanup, APICv/AVIC-enabled guests would retain
stale IPI state, causing directed yield to rely on obsolete sender/
receiver information and potentially boosting the wrong vCPU. Both
paths must call kvm_clear_ipi_on_eoi() to maintain consistency across
different virtual interrupt delivery modes.

The cleanup implements two-stage logic to avoid premature clearing:
unconditionally clear the receiver's IPI context, and conditionally
clear the sender's pending flag only when the sender exists,
last_ipi_receiver matches, and the IPI is recent. This prevents
unrelated EOIs from disrupting valid IPI tracking state.

Use lockless accessors for minimal overhead. The tracking only
activates for unicast fixed IPIs where directed yield provides value.

Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
 arch/x86/kvm/lapic.c | 107 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 103 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 98ec2b18b02c..d38e64691b78 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -1178,6 +1178,47 @@ void kvm_vcpu_reset_ipi_context(struct kvm_vcpu *vcpu)
 	WRITE_ONCE(vcpu->arch.ipi_context.ipi_time_ns, 0);
 }
 
+/*
+ * Clear IPI context on EOI at receiver side; clear sender's pending
+ * only when matches and is fresh.
+ *
+ * This function implements precise cleanup to avoid stale IPI boosts:
+ * 1) Always clear the receiver's IPI context (unconditional cleanup)
+ * 2) Conditionally clear the sender's pending flag only when:
+ *    - The sender vCPU still exists and is valid
+ *    - The sender's last_ipi_receiver matches this receiver
+ *    - The IPI was sent recently (within ~window)
+ */
+static void kvm_clear_ipi_on_eoi(struct kvm_lapic *apic)
+{
+	struct kvm_vcpu *receiver;
+	int sender_idx;
+	u64 then, now;
+
+	if (unlikely(!READ_ONCE(ipi_tracking_enabled)))
+		return;
+
+	receiver = apic->vcpu;
+	sender_idx = READ_ONCE(receiver->arch.ipi_context.last_ipi_sender);
+
+	/* Step 1: Always clear receiver's IPI context */
+	kvm_vcpu_clear_ipi_context(receiver);
+
+	/* Step 2: Conditionally clear sender's pending flag */
+	if (sender_idx >= 0) {
+		struct kvm_vcpu *sender = kvm_get_vcpu(receiver->kvm, sender_idx);
+
+		if (sender &&
+		    READ_ONCE(sender->arch.ipi_context.last_ipi_receiver) ==
+		    receiver->vcpu_idx) {
+			then = READ_ONCE(sender->arch.ipi_context.ipi_time_ns);
+			now = ktime_get_mono_fast_ns();
+			if (now - then <= ipi_window_ns)
+				WRITE_ONCE(sender->arch.ipi_context.pending_ipi, false);
+		}
+	}
+}
+
 /* Return true if the interrupt can be handled by using *bitmap as index mask
  * for valid destinations in *dst array.
  * Return false if kvm_apic_map_get_dest_lapic did nothing useful.
@@ -1259,6 +1300,10 @@ bool kvm_irq_delivery_to_apic_fast(struct kvm *kvm, struct kvm_lapic *src,
 	struct kvm_lapic **dst = NULL;
 	int i;
 	bool ret;
+	/* Count actual delivered targets to identify a unique recipient. */
+	int targets = 0;
+	int delivered = 0;
+	struct kvm_vcpu *unique = NULL;
 
 	*r = -1;
 
@@ -1280,8 +1325,26 @@ bool kvm_irq_delivery_to_apic_fast(struct kvm *kvm, struct kvm_lapic *src,
 		for_each_set_bit(i, &bitmap, 16) {
 			if (!dst[i])
 				continue;
-			*r += kvm_apic_set_irq(dst[i]->vcpu, irq, dest_map);
+			delivered = kvm_apic_set_irq(dst[i]->vcpu, irq, dest_map);
+			*r += delivered;
+			/* Fast path may still fan out; count delivered targets. */
+			if (delivered > 0) {
+				targets++;
+				unique = dst[i]->vcpu;
+			}
 		}
+
+		/*
+		 * Record unique recipient for IPI-aware boost:
+		 * only for LAPIC-originated APIC_DM_FIXED without
+		 * shorthand, and when exactly one recipient was
+		 * delivered; ignore self-IPI.
+		 */
+		if (src &&
+		    irq->delivery_mode == APIC_DM_FIXED &&
+		    irq->shorthand == APIC_DEST_NOSHORT &&
+		    targets == 1 && unique && unique != src->vcpu)
+			kvm_track_ipi_communication(src->vcpu, unique);
 	}
 
 	rcu_read_unlock();
@@ -1366,6 +1429,13 @@ int kvm_irq_delivery_to_apic(struct kvm *kvm, struct kvm_lapic *src,
 	struct kvm_vcpu *vcpu, *lowest = NULL;
 	unsigned long i, dest_vcpu_bitmap[BITS_TO_LONGS(KVM_MAX_VCPUS)];
 	unsigned int dest_vcpus = 0;
+	/*
+	 * Count actual delivered targets to identify a unique recipient
+	 * for IPI tracking in the slow path.
+	 */
+	int targets = 0;
+	int delivered = 0;
+	struct kvm_vcpu *unique = NULL;
 
 	if (kvm_irq_delivery_to_apic_fast(kvm, src, irq, &r, dest_map))
 		return r;
@@ -1389,7 +1459,13 @@ int kvm_irq_delivery_to_apic(struct kvm *kvm, struct kvm_lapic *src,
 		if (!kvm_lowest_prio_delivery(irq)) {
 			if (r < 0)
 				r = 0;
-			r += kvm_apic_set_irq(vcpu, irq, dest_map);
+			delivered = kvm_apic_set_irq(vcpu, irq, dest_map);
+			r += delivered;
+			/* Slow path can deliver to multiple vCPUs; count them. */
+			if (delivered > 0) {
+				targets++;
+				unique = vcpu;
+			}
 		} else if (kvm_apic_sw_enabled(vcpu->arch.apic)) {
 			if (!vector_hashing_enabled) {
 				if (!lowest)
@@ -1410,8 +1486,28 @@ int kvm_irq_delivery_to_apic(struct kvm *kvm, struct kvm_lapic *src,
 		lowest = kvm_get_vcpu(kvm, idx);
 	}
 
-	if (lowest)
-		r = kvm_apic_set_irq(lowest, irq, dest_map);
+	if (lowest) {
+		delivered = kvm_apic_set_irq(lowest, irq, dest_map);
+		r = delivered;
+		/*
+		 * Lowest-priority / vector-hashing paths ultimately deliver to
+		 * a single vCPU.
+		 */
+		if (delivered > 0) {
+			targets = 1;
+			unique = lowest;
+		}
+	}
+
+	/*
+	 * Record unique recipient for IPI-aware boost only for LAPIC-
+	 * originated APIC_DM_FIXED without shorthand, and when exactly
+	 * one recipient was delivered; ignore self-IPI.
+	 */
+	if (src && irq->delivery_mode == APIC_DM_FIXED &&
+	    irq->shorthand == APIC_DEST_NOSHORT &&
+	    targets == 1 && unique && unique != src->vcpu)
+		kvm_track_ipi_communication(src->vcpu, unique);
 
 	return r;
 }
@@ -1632,6 +1728,7 @@ void kvm_apic_set_eoi_accelerated(struct kvm_vcpu *vcpu, int vector)
 	trace_kvm_eoi(apic, vector);
 
 	kvm_ioapic_send_eoi(apic, vector);
+	kvm_clear_ipi_on_eoi(apic);
 	kvm_make_request(KVM_REQ_EVENT, apic->vcpu);
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_apic_set_eoi_accelerated);
@@ -2424,6 +2521,8 @@ static int kvm_lapic_reg_write(struct kvm_lapic *apic, u32 reg, u32 val)
 
 	case APIC_EOI:
 		apic_set_eoi(apic);
+		/* Precise cleanup for IPI-aware boost */
+		kvm_clear_ipi_on_eoi(apic);
 		break;
 
 	case APIC_LDR:
-- 
2.43.0


