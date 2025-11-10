Return-Path: <linux-kernel+bounces-892322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC3DC44D95
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 04:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 020693B0D81
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 03:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D282857CF;
	Mon, 10 Nov 2025 03:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XgnCPLtC"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD1228505E
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 03:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762746002; cv=none; b=q40xVqnPdjEzpBIIhNPR2ruHfzS7ZX79kKs19zvPovqhsApHxYPYPSr+sOOzjn6livEHAiVX7XKAuI7RJ0wfMDZfc6oeO4YlSmvOdbqldKG2pyKU2CjLAbOlGs3puZQohadzHljk8mhjp5D+mNn3UBvmNhwKAV/w4LsSlJmV6fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762746002; c=relaxed/simple;
	bh=9fSVaG1uC1BiaaraAMlQRxKUAMgCSO5mz0dNmTqscUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ehYlHMS/8eZxvdZErL2qGFQPlPEcKrErTstnkQpDZsWCWcdq7cwyOS0dINs2Nn3z+N2vyTclA4qw1ORAICyzSufiW7tGzCDBndXcqUpYAbkjOnlFqt3rZ7eMaVjwsfrYr9DPMAqRXH/XIaAQ/GM/v7t+YNO0Qqj4ibODvKpqG0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XgnCPLtC; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b98983bae8eso1273867a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 19:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762746000; x=1763350800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kyHdinwOK0g1o44QvaD951QSRNsd3g9ZIX/MxVLDNPY=;
        b=XgnCPLtCVigIljv8y+CSnw6JNOAamiWNdKO4Ol8P2mtKBOaVp8MBzm+EZ7i918jvKq
         YTnHmQiph8wgKqHDTTUAwzEfwm1SBgbLSrrbvUWOA4xP2MDZVVY9wr2kIkom+bmEiOtQ
         2UyJw+740wRIYAqnFYU3qKRhx4Bp+AG2G5lMt+/5Eec63hL9augL67Z90FZe5W63zgDb
         mEagfuRbUmJM6OuGR74nMSV/pYVZ5skO/c01xSNl6x+wCHmrd3+L2dRt3z3kVQ7zLgBG
         ZRAVpnbYrTC4pi3zPw1ClKtYj+43c/EvSaoINaKpV5wuDX5XS6L/BsDeQYjnk2S5pPiG
         6+pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762746000; x=1763350800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kyHdinwOK0g1o44QvaD951QSRNsd3g9ZIX/MxVLDNPY=;
        b=F1rq99LM7RWvQbrShJKWl8a1J6Tz46hkYc8RIe0w8fjFYKGd2tt06UwTjBzzv1b6im
         giHOQm0mhdyvJ0W4QGgc7mzOn5CwL7bsKDkikyJtAry5ev8/CAG1Hdp/tGCcsrTKfTIC
         QiJ/o2X3FVzMlq9pvYqTiGkFTMu/h2i7W0wCRYWVhRuyH0WnXoEyDD26vGeGJsO5HLcc
         qvSrr2a1Ojc8zPxbmycVTmjuQkDbAbUu5jyirIo1b14S8xhBEH8xqfBxQSe1lYkS/TxG
         aYetGrgEm9ShibCY7OWQsg61K1lO+YjVmCq3X7HJwFG4mJVfXqQVtVli+q1JzhTiOXAb
         FDxQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4dTdh7CrPM3i0VDuIxikO3Jat0pfkzz1yCPKl9fFxrR+nU/gSPrs5g3Y/APV0tYuASMKkNr5cDMV7Xk0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2sQwlTUTKmy7FakBGjAI2IvsQ997cWPrfYfd1o4bsAnRXdd1r
	Njl91HtwDXrbVVJ2D2qf5wy0IaO5YA95yvf3pZkVd7j4Tlj9Hi8St/p3
X-Gm-Gg: ASbGncujlhJT87RhUby2LBkwrLPB6pRw9MVVoBL2TAn9qAQRI17piTnT7wiFTMEqHBZ
	u/Kbmb+RnQW/wf6tQfvb+yv2qv5nwfMno3ZoarXaV/UQJ3HFoKbCrfP62Q8+TS9T8C9YHW3Wkyv
	hPovljypeEXmlBMukolGrqE+Dcfy/FOD7aAVq23k2i627bqNlDFnnhh3vK2ve0mBd9OoBn7DfrA
	wb/lTjpIfNwQB2aVeR/H+JjnGwlSLFDEsoYS5uohLtkRwNtU9doGp9QkNhkGPGsjTfsFUenqriu
	bKKNQ8eygvMXkmKV+eGv+2o+GrU+gY2sn+dPBKCdLg/m0J7Vx75F1l/kUJvRz+a7zhwpvANdbNV
	2+TQLOjpY7/gEj/jYmP/KO0m6H+yH5GUl5/8lb7SFzjKLGlKrpdJP4UbQXsWBAT0lie533/mtRI
	W3LkK3vVXI
X-Google-Smtp-Source: AGHT+IFpEw2uaxPZOv2frrYrOOFzZim7qBgUpLz1BMg7jwJmYB9wgwu99U615UVe3F+N/pX5E14Y6Q==
X-Received: by 2002:a17:903:1a0c:b0:297:fc22:3a9f with SMTP id d9443c01a7336-297fc223c26mr50766735ad.38.1762746000290;
        Sun, 09 Nov 2025 19:40:00 -0800 (PST)
Received: from wanpengli.. ([124.93.80.37])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2964f2a9716sm131118915ad.0.2025.11.09.19.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 19:39:59 -0800 (PST)
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
Subject: [PATCH 10/10] KVM: Relaxed boost as safety net
Date: Mon, 10 Nov 2025 11:39:54 +0800
Message-ID: <20251110033954.13524-1-kernellwp@gmail.com>
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

Add a minimal two-round fallback mechanism in kvm_vcpu_on_spin() to
avoid pathological stalls when the first round finds no eligible
target.

Round 1 applies strict IPI-aware candidate selection (existing
behavior). Round 2 provides a relaxed scan gated only by preempted
state as a safety net, addressing cases where IPI context is missed or
the runnable set is transient.

The second round is controlled by module parameter enable_relaxed_boost
(bool, 0644, default on) to allow easy disablement by distributions if
needed.

Introduce the enable_relaxed_boost parameter, add a first_round flag,
retry label, and reset of yielded counter. Gate the IPI-aware check in
round 1 and use preempted-only gating in round 2. Keep churn minimal
by reusing the same scan logic while preserving all existing
heuristics, tracing, and bookkeeping.

Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
 virt/kvm/kvm_main.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 9cf44b6b396d..b03be8d9ae4c 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -101,6 +101,9 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(halt_poll_ns_shrink);
 static bool allow_unsafe_mappings;
 module_param(allow_unsafe_mappings, bool, 0444);
 
+static bool enable_relaxed_boost = true;
+module_param(enable_relaxed_boost, bool, 0644);
+
 /*
  * Ordering of locks:
  *
@@ -4015,6 +4018,7 @@ void kvm_vcpu_on_spin(struct kvm_vcpu *me, bool yield_to_kernel_mode)
 	struct kvm *kvm = me->kvm;
 	struct kvm_vcpu *vcpu;
 	int try = 3;
+	bool first_round = true;
 
 	nr_vcpus = atomic_read(&kvm->online_vcpus);
 	if (nr_vcpus < 2)
@@ -4025,6 +4029,9 @@ void kvm_vcpu_on_spin(struct kvm_vcpu *me, bool yield_to_kernel_mode)
 
 	kvm_vcpu_set_in_spin_loop(me, true);
 
+retry:
+	yielded = 0;
+
 	/*
 	 * The current vCPU ("me") is spinning in kernel mode, i.e. is likely
 	 * waiting for a resource to become available.  Attempt to yield to a
@@ -4057,7 +4064,12 @@ void kvm_vcpu_on_spin(struct kvm_vcpu *me, bool yield_to_kernel_mode)
 			continue;
 
 		/* IPI-aware candidate selection */
-		if (!kvm_vcpu_is_good_yield_candidate(me, vcpu, yield_to_kernel_mode))
+		if (first_round &&
+			!kvm_vcpu_is_good_yield_candidate(me, vcpu, yield_to_kernel_mode))
+			continue;
+
+		/* Minimal preempted gate for second round */
+		if (!first_round && !READ_ONCE(vcpu->preempted))
 			continue;
 
 		if (!kvm_vcpu_eligible_for_directed_yield(vcpu))
@@ -4071,6 +4083,16 @@ void kvm_vcpu_on_spin(struct kvm_vcpu *me, bool yield_to_kernel_mode)
 			break;
 		}
 	}
+
+	/*
+	 * Second round: relaxed boost as safety net, with preempted gate.
+	 * Only execute when enabled and when the first round yielded nothing.
+	 */
+	if (enable_relaxed_boost && first_round && yielded <= 0) {
+		first_round = false;
+		goto retry;
+	}
+
 	kvm_vcpu_set_in_spin_loop(me, false);
 
 	/* Ensure vcpu is not eligible during next spinloop */
-- 
2.43.0


