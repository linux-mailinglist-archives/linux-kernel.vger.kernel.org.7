Return-Path: <linux-kernel+bounces-859543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 60631BEDEEC
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 08:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 357E54E62C8
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 06:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2908522B5AD;
	Sun, 19 Oct 2025 06:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBPpnrxb"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D489F226D17
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 06:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760854619; cv=none; b=PNSverXZdF2rmT+yIi1jjNIANTUdzoUXz/U1UgfP3TaqCTHLYJdLf+2g6dzM7a2qs+ifH2cgHYU4t+QptkhF5m9FB3ujNtzv/+0GBUaYdtTLvu1lNtXERCmWYvAAfekT6l2nyYmEsV2OK6oNPFF7pJ5qpybxP9k2XlefRJtJuII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760854619; c=relaxed/simple;
	bh=lhrblwAj2S8u50W6se7xH46F0vsfn85WIorx/b5ZeLw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b6x6bt6CnpOmWLJ5ydJsJotbkeWCt1FY27nJbRYIPv7JS8YexHCzCgSqFGbbJNQiSLZR/kTQ0gsv0jFvv4U6YaqM5+5GYSser0ryYZ76zK5tvfK95gBJa/qQ91Rs1voP5FX8PzrWQxm/anzjKSQfrVWkLNZJBKUbE2E8/UEur+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QBPpnrxb; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-290cd62acc3so27174135ad.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 23:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760854617; x=1761459417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ex4M6nG0U6c9sFi4kmswWQOXivj8cIJW5ADLbJTHFZo=;
        b=QBPpnrxbB3z2OqHb0Sw2e5EEZxEsphENZpjNxyHWgdV8cc4TwWYQ20I4Z3BIkTCUFW
         m2mgL72OdA/ZEOnj5X8QTtnHhhX+Lw0ib7q3iUffkyWcbFavItGUVM5M/4knT+tgJnaY
         7hCLB+7p2mzsLSAshvXjrikvvD6sv73El8Vsh3us6O8kxble1ylZLAIH4vUYNUJB5Pf8
         kUeZVNL9TR/q9HjrBRuVJ3qOh8wWutXs1RWogdoGi+IQ42P4ZrmpNXA4xs3mfHUByyH/
         EYgp2R2WvFPipxsnb7Kz4G1BxuDghT99kZklV/VmJHv/TdceclsL7iQ9lLZ4zzKScWVP
         bDGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760854617; x=1761459417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ex4M6nG0U6c9sFi4kmswWQOXivj8cIJW5ADLbJTHFZo=;
        b=rHzY1S9gz8bu0jV5pqJ2CnuA+C8LcNwJMT09kfFWBR16WHmDvOV0Z4xQwck7a8GY0a
         3RD0et3MC4vckOb3VQGXgBs81D93WK1XM9PhCNoQrPfag7G+Hk3B6MtA5Rg9f1oCyNpS
         irJVD/iCCEUW46Qxw7O8L8xfvAnjutxxluiTMrU6hQMEWK7c6/luLtmF3GlUawKnkqS0
         Q6wzSedzoAqRBLHXHekxVy/wMO8aH52O7DNl8ZaCWWQMVkMkiQHBjhwQu0t5Wc5rgKDN
         6yqfCzeeIHpM5DPrMy5PPmkExB5PfIZTfiezvsc24HV70DdVYQ09OIup1PY4E2NgGizk
         WrPQ==
X-Gm-Message-State: AOJu0YyxhRXEm96BKwAHDAG/Knblfs4J2KZ9oCq24SCIYfAsHXzw+vTM
	3NoIf4NSRApgFr4UleucmGV/Jo8hMeJvfbFH0pt7Ad6iiXyu+qn+ZAYXo5xjLw==
X-Gm-Gg: ASbGncvP1WMRyPlfk1+XgUlzNpjfBoxYE+u4nhhsWKxPk3wIgVl7PeztR6kloA4bHMn
	/jAlAM5FDuIn2kKxjBwCqooZRN9oKs42dLctO8lKXYySuqvH0i/My7fNU92TbxSgOYFz73x1OwL
	4gAjE5rr+nD6AYc1v0yYmhQpPl09Oh9SmRrTC7F5RqdpVyuh+/uYHd9adeeua4U11PCJlpfXkR+
	uaTRpLuCyunGshSFUoGI8Yps6mONdZ42cWuuZKajuUhge85HTpve35ijLvBrpdQnzvCDts4ytoq
	4QGMOEWnu1TGILKZFJSlfE0i/mvJH4lrvnWpAC6692S68iW94sT4lMdQUdjptUOmUhValaKTMXX
	LHv13TTFyrqw/JyCe64FXlbZ3hFXJcSpVPQMdHEvXqVpORbLuap2YCk3FaO/utZOJbbwxxJlcOG
	KqIQ2V
X-Google-Smtp-Source: AGHT+IEdPOvrEIcU1/OzXiLpdHh1uco8zhVpvekF8s3i7IZl2imw6bwzc3Kl4EuPcI0uzTvVtI4atA==
X-Received: by 2002:a17:902:d508:b0:28a:2e51:9272 with SMTP id d9443c01a7336-290cbc3f200mr124673875ad.48.1760854616812;
        Sat, 18 Oct 2025 23:16:56 -0700 (PDT)
Received: from pop-os.. ([2601:647:6881:9060:bc87:d8fe:3e55:7ffb])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76b6f302sm4332032a12.38.2025.10.18.23.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 23:16:56 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: jiri@resnulli.us,
	stefanha@redhat.com,
	multikernel@lists.linux.dev,
	pasha.tatashin@soleen.com,
	Cong Wang <cwang@multikernel.io>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org
Subject: [RFC Patch v2 04/16] x86: Introduce MULTIKERNEL_VECTOR for inter-kernel communication
Date: Sat, 18 Oct 2025 23:16:18 -0700
Message-Id: <20251019061631.2235405-5-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251019061631.2235405-1-xiyou.wangcong@gmail.com>
References: <20251019061631.2235405-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cong Wang <cwang@multikernel.io>

This patch adds a dedicated IPI vector (0xea) for multikernel
communication, enabling different kernel instances running on
separate CPUs to send interrupts to each other.

The implementation includes:

- MULTIKERNEL_VECTOR definition at interrupt vector 0xea
- IDT entry declaration and registration for sysvec_multikernel
- Interrupt handler sysvec_multikernel() with proper APIC EOI
  and IRQ statistics tracking
- Placeholder generic_multikernel_interrupt() function for
  extensible multikernel interrupt handling

This vector provides the foundational interrupt mechanism required
for implementing inter-kernel communication protocols in multikernel
environments, where heterogeneous kernel instances coordinate while
maintaining CPU-level isolation.

Signed-off-by: Cong Wang <cwang@multikernel.io>
---
 arch/x86/include/asm/idtentry.h    | 3 +++
 arch/x86/include/asm/irq_vectors.h | 1 +
 arch/x86/kernel/idt.c              | 3 +++
 arch/x86/kernel/smp.c              | 8 ++++++++
 4 files changed, 15 insertions(+)

diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index abd637e54e94..d2c3f1ca481a 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -703,6 +703,9 @@ DECLARE_IDTENTRY(RESCHEDULE_VECTOR,			sysvec_reschedule_ipi);
 DECLARE_IDTENTRY_SYSVEC(REBOOT_VECTOR,			sysvec_reboot);
 DECLARE_IDTENTRY_SYSVEC(CALL_FUNCTION_SINGLE_VECTOR,	sysvec_call_function_single);
 DECLARE_IDTENTRY_SYSVEC(CALL_FUNCTION_VECTOR,		sysvec_call_function);
+# ifdef CONFIG_MULTIKERNEL
+DECLARE_IDTENTRY_SYSVEC(MULTIKERNEL_VECTOR,			sysvec_multikernel);
+# endif
 #else
 # define fred_sysvec_reschedule_ipi			NULL
 # define fred_sysvec_reboot				NULL
diff --git a/arch/x86/include/asm/irq_vectors.h b/arch/x86/include/asm/irq_vectors.h
index 47051871b436..478e2e2d188a 100644
--- a/arch/x86/include/asm/irq_vectors.h
+++ b/arch/x86/include/asm/irq_vectors.h
@@ -102,6 +102,7 @@
  * the host kernel.
  */
 #define POSTED_MSI_NOTIFICATION_VECTOR	0xeb
+#define MULTIKERNEL_VECTOR		0xea
 
 #define NR_VECTORS			 256
 
diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index f445bec516a0..5e6d03bb18b5 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -135,6 +135,9 @@ static const __initconst struct idt_data apic_idts[] = {
 	INTG(RESCHEDULE_VECTOR,			asm_sysvec_reschedule_ipi),
 	INTG(CALL_FUNCTION_VECTOR,		asm_sysvec_call_function),
 	INTG(CALL_FUNCTION_SINGLE_VECTOR,	asm_sysvec_call_function_single),
+#ifdef CONFIG_MULTIKERNEL
+	INTG(MULTIKERNEL_VECTOR,		asm_sysvec_multikernel),
+#endif
 	INTG(REBOOT_VECTOR,			asm_sysvec_reboot),
 #endif
 
diff --git a/arch/x86/kernel/smp.c b/arch/x86/kernel/smp.c
index b014e6d229f9..59658fcd9037 100644
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -272,6 +272,14 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_call_function_single)
 	trace_call_function_single_exit(CALL_FUNCTION_SINGLE_VECTOR);
 }
 
+#ifdef CONFIG_MULTIKERNEL
+DEFINE_IDTENTRY_SYSVEC(sysvec_multikernel)
+{
+	apic_eoi();
+	inc_irq_stat(irq_call_count);
+}
+#endif /* CONFIG_MULTIKERNEL */
+
 static int __init nonmi_ipi_setup(char *str)
 {
 	smp_no_nmi_ipi = true;
-- 
2.34.1


