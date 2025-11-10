Return-Path: <linux-kernel+bounces-892320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BE4C44D89
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 04:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72BCB3AB565
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 03:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A3F29C321;
	Mon, 10 Nov 2025 03:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+VQKoA4"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E4529BD8C
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 03:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762745595; cv=none; b=sCEeeJDZhZIobWkLHzIGRzs1DAOyY5+goBz3jlVMoVPR5CaRj56aUKfByfg0ZD1/9uZuD+XoSOHmediNZmRe0vDpDeeHZ4Ph613ylXMIuuOdk0ICZfRUQKvQwAWfE0IgbctNOtUyW0FoiVk9HrJUmvVrlgCden5sFpVXV0MYSFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762745595; c=relaxed/simple;
	bh=AgDAzUdg+SaLte7CqAVvGATj4ZUCqMIUJ5UviEwZxnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aOQ/pTdxRTAKZlXL1fBjJkA80hBtqn8IfqYt3otSA1pung+5JBk0vt8uSqEyZb2jvaDWJ38YCiYTuCupG6zoMRf8kskFT7LOhu6pqFnPmt7K2vNhWqrQ51Q+R+CetY56J6xmSAFLnwkIM2oHgoCb9oU4HYLO36YxKcvqUT23woM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J+VQKoA4; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3436a97f092so2056867a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 19:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762745593; x=1763350393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PUaeSNQcivBLj1RPgLBfG7y+iCnCseUMHvxeI3I0QGs=;
        b=J+VQKoA48Ce64F4HbyxJZgMvEWzI4Ks0h4EiC6eJqEktSfMRDIyUbNUV+99uauuIvj
         AK3ZOumUv9fOjKxnEHvi+Y1rTuVp61QC3BUcz9jpGDEm+rpu0ZCSvr8/KN46rCpt4u46
         IisgbgAm+f2Fw75+2I+hE0EWs39gXS4vnsMXJJaO7ZtYteBvZV0v7rUWJEiZQ7NPfWjO
         We5771CyE7Z6ZGQ1URCyo9l/mjTD0tYXJVmTKXToYzhUlHUXzp/lg2+hgbJFFzY1HVjr
         9NMjdRXX9BE72O2f6ZnrT1fCNewoaplF4vsH7lXKNK9tyf2h1lcq7fXs+8dKNu552eDr
         GOXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762745593; x=1763350393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PUaeSNQcivBLj1RPgLBfG7y+iCnCseUMHvxeI3I0QGs=;
        b=cli0QIZ4w6JQx9moxU+k753w1D21/FWEyKHH5zLY8gapQHTPXVZ0fxofPMTqRMNg9F
         4QYxrX0MR3/Jxw2BmJ+VT9yKhQoD6NTTghG+IcoXMaGHluEjCTbkbN/6kpyNQN/XdtJ8
         esswNsayx8mi2CJCarF7Z69mMwIR3g8RQFo5G9qmgOLg6wlX3N3PmmYdgeiijtMx2cQ0
         R03VnZpH8NVuvF0tfBh9vV1m5E4e9IaBKeymk2fQ1N75MyHTOiqajo2zUt/94g7PS9mv
         Eni0bEmEa+TuHShGFv1jfY/2joMO0pisRERS95HWMiLIbZ/8ZMFRtJlrIdCloi9PdZRQ
         ngTg==
X-Forwarded-Encrypted: i=1; AJvYcCVCnOYmr9KtskSSrme63MJ0eXz55l+A1HsEGFs/CyxjIPqiDY0MCf8boLPqbJaCXIE6zK7knBF8k/XMOGo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2gU8jtvfYlQ8OQI85uhxDh7SIw1cOL5joOqTRsfsaaiUusVhu
	gummEqXmQjOsDAOCK5FnTWbDc818pf6+eSctuA5CS2Kw4hBRUmbKVxwR
X-Gm-Gg: ASbGncsEAs7EwmKwrQnLKOkRZbQCYjv7Wm0PNQ2EiF3OP372a5h43fByf0jTZTX6iAT
	FyXZw+lcwqtaV7fH1eCojggqQcVmGK1ra1n0IxiVb8rx1FmttMvm73YUaT98Oz853MvA4BSWkDY
	zGJlcTYR+inGhf68/224BoxHETaS1LCIARIE8ZAJQWa3uf+BPMubvGhkAweSWToRLMbFduoPRZ2
	T7Jl9ggeF1DOqCSsKnzHHSMF31Vq6HcaxMp+Th0lt3LVX63+tkD5Cgx+jBoXLWmlEhxkeAjXJvX
	4u21le1U/WJD+FFnl3EX/rb85oM+EWIwi87p1U16sf4lwX92k1NIJWmKNq2XzTKhaS211sIyIrH
	CNeLAKFxR+VqOk5NB4UyDmHZwYy0tJ4Yu62d1fpNAD3K5Gf3219C6qHA/5Lf+TeJxKCFQLYd2aA
	==
X-Google-Smtp-Source: AGHT+IGneSsO29/OFlMVcRrdPIGOGb1MTjabk3LmWe9/4garbnC9hW44ZxV84CyN5mxzd+phtLE4FA==
X-Received: by 2002:a17:90b:55c4:b0:343:5f43:933e with SMTP id 98e67ed59e1d1-3436cbb3b58mr8661608a91.19.1762745592826;
        Sun, 09 Nov 2025 19:33:12 -0800 (PST)
Received: from wanpengli.. ([124.93.80.37])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-ba900fa571esm10913877a12.26.2025.11.09.19.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 19:33:12 -0800 (PST)
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
Subject: [PATCH 09/10] KVM: Implement IPI-aware directed yield candidate selection
Date: Mon, 10 Nov 2025 11:32:30 +0800
Message-ID: <20251110033232.12538-10-kernellwp@gmail.com>
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

Integrate IPI tracking with directed yield to improve scheduling when
vCPUs spin waiting for IPI responses.

Implement priority-based candidate selection in kvm_vcpu_on_spin()
with three tiers: Priority 1 uses kvm_vcpu_is_ipi_receiver() to
identify confirmed IPI targets within the recency window, addressing
lock holders spinning on IPI acknowledgment. Priority 2 leverages
existing kvm_arch_dy_has_pending_interrupt() for compatibility with
arch-specific fast paths. Priority 3 falls back to conventional
preemption-based logic when yield_to_kernel_mode is requested,
providing a safety net for non-IPI scenarios.

Add kvm_vcpu_is_good_yield_candidate() helper to consolidate these
checks, preventing over-aggressive boosting while enabling targeted
optimization when IPI patterns are detected.

Performance testing (16 pCPUs host, 16 vCPUs/VM):

Dedup (simlarge):
  2 VMs: +47.1% throughput
  3 VMs: +28.1% throughput
  4 VMs:  +1.7% throughput

VIPS (simlarge):
  2 VMs: +26.2% throughput
  3 VMs: +12.7% throughput
  4 VMs:  +6.0% throughput

Gains stem from effective directed yield when vCPUs spin on IPI
delivery, reducing synchronization overhead. The improvement is most
pronounced at moderate overcommit (2-3 VMs) where contention reduction
outweighs context switching cost.

Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
 virt/kvm/kvm_main.c | 52 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 43 insertions(+), 9 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 495e769c7ddf..9cf44b6b396d 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3968,6 +3968,47 @@ bool __weak kvm_vcpu_is_ipi_receiver(struct kvm_vcpu *sender, struct kvm_vcpu *r
 	return false;
 }
 
+/*
+ * IPI-aware candidate selection for directed yield
+ *
+ * Priority order:
+ *  1) Confirmed IPI receiver of 'me' within a short window (always boost)
+ *  2) Arch-provided fast pending interrupt (user-mode boost)
+ *  3) Kernel-mode yield: preempted-in-kernel vCPU (traditional boost)
+ *  4) Otherwise, be conservative
+ */
+static bool kvm_vcpu_is_good_yield_candidate(struct kvm_vcpu *me, struct kvm_vcpu *vcpu,
+					     bool yield_to_kernel_mode)
+{
+	/* Priority 1: recently targeted IPI receiver */
+	if (kvm_vcpu_is_ipi_receiver(me, vcpu))
+		return true;
+
+	/* Priority 2: fast pending-interrupt hint (arch-specific). */
+	if (kvm_arch_dy_has_pending_interrupt(vcpu))
+		return true;
+
+	/*
+	 * Minimal preempted gate for remaining cases:
+	 * - If the target is neither a confirmed IPI receiver nor has a fast
+	 *   pending interrupt, require that the target has been preempted.
+	 * - If yielding to kernel mode is requested, additionally require
+	 *   that the target was preempted while in kernel mode.
+	 *
+	 * This avoids expanding the candidate set too aggressively and helps
+	 * prevent overboost in workloads where the IPI context is not
+	 * involved.
+	 */
+	if (!READ_ONCE(vcpu->preempted))
+		return false;
+
+	if (yield_to_kernel_mode &&
+	    !kvm_arch_vcpu_preempted_in_kernel(vcpu))
+		return false;
+
+	return true;
+}
+
 void kvm_vcpu_on_spin(struct kvm_vcpu *me, bool yield_to_kernel_mode)
 {
 	int nr_vcpus, start, i, idx, yielded;
@@ -4015,15 +4056,8 @@ void kvm_vcpu_on_spin(struct kvm_vcpu *me, bool yield_to_kernel_mode)
 		if (kvm_vcpu_is_blocking(vcpu) && !vcpu_dy_runnable(vcpu))
 			continue;
 
-		/*
-		 * Treat the target vCPU as being in-kernel if it has a pending
-		 * interrupt, as the vCPU trying to yield may be spinning
-		 * waiting on IPI delivery, i.e. the target vCPU is in-kernel
-		 * for the purposes of directed yield.
-		 */
-		if (READ_ONCE(vcpu->preempted) && yield_to_kernel_mode &&
-		    !kvm_arch_dy_has_pending_interrupt(vcpu) &&
-		    !kvm_arch_vcpu_preempted_in_kernel(vcpu))
+		/* IPI-aware candidate selection */
+		if (!kvm_vcpu_is_good_yield_candidate(me, vcpu, yield_to_kernel_mode))
 			continue;
 
 		if (!kvm_vcpu_eligible_for_directed_yield(vcpu))
-- 
2.43.0


