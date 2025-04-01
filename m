Return-Path: <linux-kernel+bounces-583861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9681A780C5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 18:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A19757A45AB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 16:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D54721505E;
	Tue,  1 Apr 2025 16:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yKTYDGFw"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D12C2144CF
	for <linux-kernel@vger.kernel.org>; Tue,  1 Apr 2025 16:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743525805; cv=none; b=JmbC8WdyT8dUyz4qLJTgAcH/vu1vDY/RAEl9TD3C2WYyx+lJraHdDZI8pHBe1a9I17azpQ+aN1Cv4EICbbYzLh9TVlQ/FHvpfrq/162GMQg4i8hSsNTkR2QVMgBXn2DXV+aaBKBTalFnsDFcf0w9QOhgGIGLhAqZHJvPKdcUEpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743525805; c=relaxed/simple;
	bh=0mb7W2KJR+X1+iO3XRU17z9B6gV64MNgKjj7DrBL3rQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Zq53z4uowIdV/kDf39b86wDUxyMrHNcKXGUuy0LabEKw824G0R5JyZt8kmovbbZVN7KMWccyGahcmuaU1S07sIBVhviznIH2b3FFog4K685yasCv9TW3j5cF18PoowZNS1F0/J/Gk41ywQdhbb7a/aB2ebFAJcz0MdFXzJFaNSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yKTYDGFw; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff6af1e264so735736a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Apr 2025 09:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743525803; x=1744130603; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=JvMZfz//CfX9sBYOfMJB+q+wsvNCB9UZGeb1vhxbwqc=;
        b=yKTYDGFw7VHBl+U+Jw+Xp1PqBR+1bhJZkrct3n/fRHAeZAqn8xA30ig0dm58liStjJ
         0HI0d0hdELhixyO8n+di9f2jPcc8HHu/PCNKJ3k+aZFWZDapAnmOhEiOb1nj/YAgTdEs
         KLBbjsgK0HauVh0/vERpOcvBgPeNChm7TPvHrrjPAdJKtpZgGFiD+KvP4QJhKsMkzGLZ
         N6qRoNYFjVc36dLSirXnEVPYfV8m8lW48gFarwsJB1BLqzFS8NwEke1vK2whTWooWi7J
         TKKDOH1clXCd/1FTmkQWNvRoCykjVeYGBr+9gV1eH5B8zcWwhSKWkSgGkexkgrkdxKU0
         rmGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743525803; x=1744130603;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JvMZfz//CfX9sBYOfMJB+q+wsvNCB9UZGeb1vhxbwqc=;
        b=GYLQtxMXfe5pTw4EDdtv5BHKgNBigxjp8Gxzppe/uVnwL9W9iaBwKtm6ZMKRoOhFRN
         LSeJuu9uRIva0x4mFUoXDfNm5EMUlk0Ub/utBkGyK8jddrH562oRQyA589I7Mdf+iWIG
         JAa1suhaefjLNbv0jrhdQ2KPbLCO7XHShz2+v01zyUAnFA0WHMmz2POswSr0NJC92/RE
         t/duTGHK3UJ9Dcz3NcDQGAgVaD09QNSs2QXXLgNtAOXb+LVcgDm1mcSuLmnV2fBksG+L
         SN+vfoGvJelgmI2Rpd0qArSTHNoGiz6TXJEtg/I/lvguXfKmRmoezSJ1T6ukgZi6H3su
         GcpQ==
X-Gm-Message-State: AOJu0YyrrROLwcoBdCKgca6BBF46TP6MPNeSwlO/R/BFEQ0myaZU0h51
	UEueeegI2TQ9CJleALgTBiMMZ/fbOZmIGFiTc+G2SPkEx0hd7NN4RDmY3PzuhvD3c2AB6PfRt3o
	ARA==
X-Google-Smtp-Source: AGHT+IFappA+693mpg8zPDSbFvdj433IwkFt3wteT5TPuG94UFq5oeeszFM3n1+NCGeGHcm5eLfjft4ZDV0=
X-Received: from pfbhh11.prod.google.com ([2002:a05:6a00:868b:b0:739:485f:c33e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:9f47:b0:1f5:67e2:7790
 with SMTP id adf61e73a8af0-2009f606767mr20650362637.17.1743525803622; Tue, 01
 Apr 2025 09:43:23 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  1 Apr 2025 09:34:45 -0700
In-Reply-To: <20250401163447.846608-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250401163447.846608-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec-goog
Message-ID: <20250401163447.846608-7-seanjc@google.com>
Subject: [PATCH v2 6/8] KVM: VMX: Isolate pure loads from atomic XCHG when
 processing PIR
From: Sean Christopherson <seanjc@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Rework KVM's processing of the PIR to use the same algorithm as posted
MSIs, i.e. to do READ(x4) => XCHG(x4) instead of (READ+XCHG)(x4).  Given
KVM's long-standing, sub-optimal use of 32-bit accesses to the PIR, it's
safe to say far more thought and investigation was put into handling the
PIR for posted MSIs, i.e. there's no reason to assume KVM's existing
logic is meaningful, let alone superior.

Matching the processing done by posted MSIs will also allow deduplicating
the code between KVM and posted MSIs.

See the comment for handle_pending_pir() added by commit 1b03d82ba15e
("x86/irq: Install posted MSI notification handler") for details on
why isolating loads from XCHG is desirable.

Suggested-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/lapic.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index e4f182ee9340..0463e89376fb 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -657,7 +657,7 @@ static u8 count_vectors(void *bitmap)
 
 bool __kvm_apic_update_irr(unsigned long *pir, void *regs, int *max_irr)
 {
-	unsigned long pir_vals[NR_PIR_WORDS];
+	unsigned long pir_vals[NR_PIR_WORDS], pending = 0;
 	u32 *__pir = (void *)pir_vals;
 	u32 i, vec;
 	u32 irr_val, prev_irr_val;
@@ -668,6 +668,13 @@ bool __kvm_apic_update_irr(unsigned long *pir, void *regs, int *max_irr)
 
 	for (i = 0; i < NR_PIR_WORDS; i++) {
 		pir_vals[i] = READ_ONCE(pir[i]);
+		pending |= pir_vals[i];
+	}
+
+	if (!pending)
+		return false;
+
+	for (i = 0; i < NR_PIR_WORDS; i++) {
 		if (!pir_vals[i])
 			continue;
 
-- 
2.49.0.472.ge94155a9ec-goog


