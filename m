Return-Path: <linux-kernel+bounces-879301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 38335C22C8B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 01:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E0B514EFF90
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 00:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5731F3B85;
	Fri, 31 Oct 2025 00:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nIknIISg"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBCA1DF75B
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 00:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761870651; cv=none; b=p0gewX5mKDiYAJeLu58sYjByADhNkOhdssCMhraBPDxhegQUDb8F/jbF6TlmpRXPBAI4ZtZWOnmRh7Ym8rnfbfZ7H0rh1aS/14xXGBNPo7qwsmx9DLm7xtTsc1ISc8jF+C0x8Ahyzze3llHLVIdKQsAiLNeXCYH6iCqezyFQQOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761870651; c=relaxed/simple;
	bh=tzp/3ROGUKURX5Xj0fHJRpM3UGAca2Jw3N2xjixt3lk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ljYu1DPrld/TeW1QyOdQhhDSPQuLe0EPIVVaLdla4RLg/7P3/ReN41unnR0jhmY+LDrXmtiIm+bIXZO9DOjlNZemOPFOBjLX6lYx2TGGVXOQEAMwla41cb1iGKdxU3BDueV7ACqTjwIeMw0Viw4kLn2B1ErQ+CJJkukbQCCJGqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nIknIISg; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-29085106b99so16038735ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 17:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761870649; x=1762475449; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=oMHlsC7c5oD7CcKApKn4I2mv/vdAEywap/hlKVGWtz8=;
        b=nIknIISglhnnq0uMna6VfX6hRFucnzuozAOyZryeM3DIABIV3dsGc5pgd5ZxiYF8Nu
         KASXx3/aYVb/o/rhpXab+5nBkyYfoe/oOhMXupQHK/VWrC3qn0ZAcH2D7+R1TrRBazr0
         jXCpkQ3Q7+00S8TMe7K2NG26sAPTh4z2K9U9c+g2Xt5g21SbD5sXmFqk0Pq8DFHzi9aA
         X2hiivKQxa/9Nx5wdYAHMq9fEu77Z6QWzASX5ZxKTqZoTdMX8xMu/h7gnHXdEezPneAU
         el99+7OQsZlDcvbVuox1kT04/k6nuCjU3/FefkTUjxddaxHbgwt7PwnLvQSTQIk8XQPy
         /6OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761870649; x=1762475449;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oMHlsC7c5oD7CcKApKn4I2mv/vdAEywap/hlKVGWtz8=;
        b=m7FExuogg1uR1rR/ksTdRnS9GBtra0fnWJeAX6uMu7rubsUg2eOQOV4UFGckvj1ty8
         e6quz8hu5ENXRPyyyg33J3PBFij4SoSpXHzuSKg3WkB9xpnPlWuBSN1whN56XW1HAKg9
         1Lr9PoZ3U7v4G99eJlDpui6nPQjAGwIuaUaBtNBiV+8BdIlqWYyG4CrAq7RT1Gm//B7t
         FOw62GvZnJiCRUh196cPjn84lBoTfRn8+DWwaf83tsG4MXR8MLCbMm1cN7VyKkCGeVn+
         +nozuTHOPBJjgR/IT8h7sDhZMyOsCot+ohWKcQP+Msq120rKCxYTtEM5rIlXP+5rp2a+
         /FIA==
X-Forwarded-Encrypted: i=1; AJvYcCU54zxywvwHJIBXW43AP6UCw+4esfAeMJAOtewmRq5QdhCTkDj79nA+0ha7Lr84JqamYGb9g4YMn/pX2RM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyag/XfVAOnMXs+z+ljKAC9or4/zHkTXo4IVlS+oFgElGcLcb/
	NBqxP0mKaN5d5TOip+qbXhwKJZilY3LWovuHRbi6ksqwPwm73VNXAdoApCBhDohsd83IiJI8eSq
	doDCbjQ==
X-Google-Smtp-Source: AGHT+IGdP5TX31n5prdQmUnY/ypxyo2o3kyqL3wOPAaMrWLK7PKvetILEtk7QXVibBOmaJMZNn/wzFqvOCM=
X-Received: from pjo12.prod.google.com ([2002:a17:90b:566c:b0:33b:ba24:b204])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:da8e:b0:290:52aa:7291
 with SMTP id d9443c01a7336-2951a51e6a1mr23311235ad.53.1761870649510; Thu, 30
 Oct 2025 17:30:49 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 30 Oct 2025 17:30:34 -0700
In-Reply-To: <20251031003040.3491385-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251031003040.3491385-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
Message-ID: <20251031003040.3491385-3-seanjc@google.com>
Subject: [PATCH v4 2/8] x86/bugs: Decouple ALTERNATIVE usage from VERW macro definition
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="UTF-8"

Decouple the use of ALTERNATIVE from the encoding of VERW to clear CPU
buffers so that KVM can use ALTERNATIVE_2 to handle "always clear buffers"
and "clear if guest can access host MMIO" in a single statement.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/nospec-branch.h | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 08ed5a2e46a5..923ae21cbef1 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -308,24 +308,23 @@
  * CFLAGS.ZF.
  * Note: Only the memory operand variant of VERW clears the CPU buffers.
  */
-.macro __CLEAR_CPU_BUFFERS feature
 #ifdef CONFIG_X86_64
-	ALTERNATIVE "", "verw x86_verw_sel(%rip)", \feature
+#define CLEAR_CPU_BUFFERS_SEQ	verw x86_verw_sel(%rip)
 #else
-	/*
-	 * In 32bit mode, the memory operand must be a %cs reference. The data
-	 * segments may not be usable (vm86 mode), and the stack segment may not
-	 * be flat (ESPFIX32).
-	 */
-	ALTERNATIVE "", "verw %cs:x86_verw_sel", \feature
+/*
+ * In 32bit mode, the memory operand must be a %cs reference. The data segments
+ * may not be usable (vm86 mode), and the stack segment may not be flat (ESPFIX32).
+ */
+#define CLEAR_CPU_BUFFERS_SEQ	verw %cs:x86_verw_sel
 #endif
-.endm
+
+#define __CLEAR_CPU_BUFFERS	__stringify(CLEAR_CPU_BUFFERS_SEQ)
 
 #define CLEAR_CPU_BUFFERS \
-	__CLEAR_CPU_BUFFERS X86_FEATURE_CLEAR_CPU_BUF
+	ALTERNATIVE "", __CLEAR_CPU_BUFFERS, X86_FEATURE_CLEAR_CPU_BUF
 
 #define VM_CLEAR_CPU_BUFFERS \
-	__CLEAR_CPU_BUFFERS X86_FEATURE_CLEAR_CPU_BUF_VM
+	ALTERNATIVE "", __CLEAR_CPU_BUFFERS, X86_FEATURE_CLEAR_CPU_BUF_VM
 
 #ifdef CONFIG_X86_64
 .macro CLEAR_BRANCH_HISTORY
-- 
2.51.1.930.gacf6e81ea2-goog


