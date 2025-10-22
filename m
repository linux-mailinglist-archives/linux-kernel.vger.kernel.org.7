Return-Path: <linux-kernel+bounces-865301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C46DDBFCBD9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5A76B4F6131
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139FE34B678;
	Wed, 22 Oct 2025 15:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5fwJX9L"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20EF347BC9
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 15:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761145298; cv=none; b=bYU5sHBA3AqavFn8neCqNxpBNtuB/Q3ZBDm1dq75N/WdwI8Dh99i/BnCg1w12NLcuGADi7ANEGdoxoZQ8SaiYmCAQ/E85OXGl/awBpTMBltlbcD+P/hEXUnUQ3cnkEZE7XvIdxCteCw6/AB0XFa90sY1r2m5YsjCTUJZtCowwRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761145298; c=relaxed/simple;
	bh=HqZK9FK31xUcTHOGeovXnR3k6rsNamjMy9oCewtnq2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZGMYWxoLYHQ+jUYb3Tmz4/fAqnZjB3XnNwg9p1C+xndJkNVtnKsXyrK8fdYJO9cCs4KMKMdUhsZZcjT28LeW/zywvs1Xw4ItZc9qp1aQ0+ETjIF+WowGNgAA5h3cncQHJO+yrggF0eKUkJ8Y5W6UqrWhPcNJyZSMAlAENjiWOfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l5fwJX9L; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-33082c95fd0so7042863a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761145296; x=1761750096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gElp4KIF8VYeQaILzzzMZvdUU8mJFRmHLG+SIVbwPDw=;
        b=l5fwJX9LEKBO0Kpc8cHohJRGcoLcQP7+clOZtvvn3mTZIAG7PrwnMTaN6bpEFzHR9k
         Zj3nuKFit7nA22lN9GkCDRKNG2cXO9TfKyFH9xpQ22tZIgQh0SGX2hLc0BeklNtDr3qN
         SDy9mUocgWUANiwGnA8Bs+Z9bM61siorwPonzjmc8zEXWH6GzcQd0HTFcMSRrX6UcguV
         b/mqpRRKnYl/lAdbwjgW/XBNT9q3mFwSazdekbiC67VN7/w74HfJ7W9l/HdeRzTSCMzA
         1pf1mEWFaxyiUZKuCMBsQ4T8JxiyKSnjxUEaGgJUBtiaHZYJR0eywMYb+3Pbkq82IEla
         G+xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761145296; x=1761750096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gElp4KIF8VYeQaILzzzMZvdUU8mJFRmHLG+SIVbwPDw=;
        b=teN6qxWpYV2Gk6A2n9Anc5mYipYZAM4gaF/J8IgpiXC/eGpxcnJJhq66r4V3kjWIlx
         SvjrCiNiUqDuRLreq0Uf27dKsrORaEPhEFhhJu5semtuaXqIy42QNCiElMSGyb8EVR12
         d9eyDGSWXZSX0EYzN4EkUuAHQtCGPf2OJIhYpqwbGJ5uB6b1Euoe+1PA4IQPeNG1yG/S
         AILFvUaGrk2k4PY4hWPz/2UpoTQNMQzY1yKQptLaujvLECSXLa5kniLICgmryBUJvir0
         /k9FDyBHOvmSH9cDN9CKBT05pPsDuipBEl98SD5RCaPpERDlLnjLDXGtaeANaTiRxaJX
         PPUA==
X-Forwarded-Encrypted: i=1; AJvYcCXiEuA5Mc0YDm+ZQKu6Miy6wh/aHJsthyhK2EHmUjenHtNLaXkiVMWcgU/P223nMj96/q+JV9GW57hRT8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBxCafc5gnmENcpnNNTZTQKMD7inm9r/INlV2BKkg5X2uvV6yy
	u9O/Rw10wpVi4cSnzf9TH87hUrOHnBebpGE/FSBIX0ek1uhtK/2IH7rJ
X-Gm-Gg: ASbGncujDpslCuzz2hqdpruPhddzaeSiOHQS8fU3XQY8VWZ7mJeSLNUt+k/RuIxfb6n
	0ERnNSoFWC4VCf9Kt0d9XWE5PF9hy9QCnyzmCMDUk58KycILL17Tp/tpk3tgCJONpyRe8u53tQQ
	2mkMBXOG9vcVQyFGaytsXblpfxSQHSBv5reIrAAAILpjtKRVXqfzoFcXYRlW1Dp1uiiaiO93jDr
	u3XONMjKYiiv4X+cHCM91raOhY13xuf4WAlVKX3JJisxp8RB4J/ymWgD9WADEGjEzVk1hp9U4I/
	mmkEECzuyLNFoXwzvNdvj3Rr1kFemSpGQQF1dufdEi/ARvrnnM99lZt/unkLkIfM6aJPYq1CAVy
	wEDN/cE3/dAfB47Fu0731axfcmWOp8uQsN0ryqYu5Qi7EhlX9RZmM/qB03pqHyO84FizJSBgY9W
	OdZOexcqmnyW+qZ/WHx8zKMFbE3cuzUK/DW1gr/WqwTfNqblM=
X-Google-Smtp-Source: AGHT+IEI8NM6eerSg7O9PVoccAbCBDR+/0TZEfc94ERPhhBgd8KxbPs/KdgxDYfPXFvQatu8ZnH43g==
X-Received: by 2002:a17:90b:28c4:b0:336:b563:993a with SMTP id 98e67ed59e1d1-33bcf8e72f4mr30503562a91.23.1761145295825;
        Wed, 22 Oct 2025 08:01:35 -0700 (PDT)
Received: from localhost.localdomain ([2408:80e0:41fc:0:8685:174d:2a07:e639])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e3125a3afsm1973624a91.6.2025.10.22.08.01.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 22 Oct 2025 08:01:35 -0700 (PDT)
From: fuqiang wang <fuqiang.wng@gmail.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Maxim Levitsky <mlevitsk@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: fuqiang wang <fuqiang.wng@gmail.com>,
	yu chen <33988979@163.com>,
	dongxu zhang <xu910121@sina.com>
Subject: [PATCH v3 1/2] avoid hv timer fallback to sw timer if delay exceeds period
Date: Wed, 22 Oct 2025 23:00:54 +0800
Message-ID: <20251022150055.2531-2-fuqiang.wng@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20251022150055.2531-1-fuqiang.wng@gmail.com>
References: <20251022150055.2531-1-fuqiang.wng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the guest uses the APIC periodic timer, if the next period has already
expired, e.g. due to the period being smaller than the delay in processing
the timer, the delta will be negative.  nsec_to_cycles() may then convert
this delta into an absolute value larger than guest_l1_tsc, resulting in a
negative tscdeadline. Since the hv timer supports a maximum bit width of
cpu_preemption_timer_multi + 32, this causes the hv timer setup to fail and
switch to the sw timer.

Moreover, due to the commit 98c25ead5eda ("KVM: VMX: Move preemption timer
<=> hrtimer dance to common x86"), if the guest is using the sw timer
before blocking, it will continue to use the sw timer after being woken up,
and will not switch back to the hv timer until the relevant APIC timer
register is reprogrammed.  Since the periodic timer does not require
frequent APIC timer register programming, the guest may continue to use the
software timer for an extended period.

Fixes: d8f2f498d9ed ("x86/kvm: fix LAPIC timer drift when guest uses periodic mode")
Signed-off-by: fuqiang wang <fuqiang.wng@gmail.com>
---
 arch/x86/kvm/lapic.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 0ae7f913d782..fa07a303767c 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2131,18 +2131,26 @@ static void advance_periodic_target_expiration(struct kvm_lapic *apic)
 	ktime_t delta;
 
 	/*
-	 * Synchronize both deadlines to the same time source or
-	 * differences in the periods (caused by differences in the
-	 * underlying clocks or numerical approximation errors) will
-	 * cause the two to drift apart over time as the errors
-	 * accumulate.
+	 * Use kernel time as the time source for both deadlines so that they
+	 * stay synchronized.  Computing each deadline independently will cause
+	 * the two deadlines to drift apart over time as differences in the
+	 * periods accumulate, e.g. due to differences in the underlying clocks
+	 * or numerical approximation errors.
 	 */
 	apic->lapic_timer.target_expiration =
 		ktime_add_ns(apic->lapic_timer.target_expiration,
 				apic->lapic_timer.period);
 	delta = ktime_sub(apic->lapic_timer.target_expiration, now);
-	apic->lapic_timer.tscdeadline = kvm_read_l1_tsc(apic->vcpu, tscl) +
-		nsec_to_cycles(apic->vcpu, delta);
+
+	/*
+	 * Don't adjust the tscdeadline if the next period has already expired,
+	 * e.g. due to software overhead resulting in delays larger than the
+	 * period.  Blindly adding a negative delta could cause the deadline to
+	 * become excessively large due to the deadline being an unsigned value.
+	 */
+	apic->lapic_timer.tscdeadline = kvm_read_l1_tsc(apic->vcpu, tscl);
+	if (delta > 0)
+		apic->lapic_timer.tscdeadline += nsec_to_cycles(apic->vcpu, delta);
 }
 
 static void start_sw_period(struct kvm_lapic *apic)
-- 
2.47.0


