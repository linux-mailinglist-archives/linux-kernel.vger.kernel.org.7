Return-Path: <linux-kernel+bounces-823702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2B7B8739B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 00:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D2527E08F2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 22:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169C130CB2F;
	Thu, 18 Sep 2025 22:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICq8C5Iw"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD68D3009F7
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 22:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758234388; cv=none; b=q6tkceGC8OCnWlmna0ZSpxUgeCRER3IAJyPU7qZOE/DvK9g/ltqXZw4V9yCH1tHXfb2wS5h3Ks5CRZFmG1xqhw8mC/hXqmoberXLZHpmC9qGXV2z90qewN2COLJKQCJutp7PeHbbUpyBHciYz2I+gpkei+qeHrT5bS8lVifDH/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758234388; c=relaxed/simple;
	bh=Act+beKdM1cR3FlnZ6neLM9so3BVgfZf1Rj+jP1FSIU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ctkTz+Va8+r3z6P5M9KO4olTfhAOY+A1JvZXlQIyIeBr1qk8jiRascT1DSF0BiqFxxgE70GEAXFcvRclHtLcXG8+rFsE1vmWG7/V65zn+vL7ap65FaOJLjJfGXvcWvuZgbLp8HHLLi7sN8Q/lAGglu5YrJbN+GWZQDv2KUhQQsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ICq8C5Iw; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7728815e639so1055745b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 15:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758234386; x=1758839186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZYY6rFeiN3Nd63QlR7gbViGMQddkJPo4uSa23B5h294=;
        b=ICq8C5Iwn4+wmYkZ2yDgHMkFjbmSEhoq1xGP1iaQ3AxnHbhtvLndYKRQ5PIVONHZae
         gtg5tc33gKA6FKKUjOL6+DjsLi6q3hNK03QxrPTAqr9jOhom1adz0HHWRhVw769wYpFu
         8iv5Nem4HWR/r5uU4Rhu+U1HYm0t2utV9ZWK6MpM7jxWMQoUXJuKuh/Scw/lzcQhIRjN
         NlLM3W8bk0a294GYxwl5lpfDKH/WI+AgaWNn6SHxCi9+ldfCwaPYMvHeB/a6p1mwEzaZ
         u9zbvc6J3M7yR5FbULeWcIde1zE3edcfXL+TQcmuY2GmM1rM5KpCmuBg7uK5SB8i/ORf
         xgMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758234386; x=1758839186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZYY6rFeiN3Nd63QlR7gbViGMQddkJPo4uSa23B5h294=;
        b=aEWW3uccaw8+ad0eKzII+XeSMOQbUqrFL+RmZ+3yUxOHl94XYie7WQSdzqor3QzxDt
         T1+7LOXExuk0NaPsEYpBKy33oh2NcvO/BWfi/kqazoKTUahPDeXi+O7qETeH2wvEKqYU
         Db6qPyWHl+guOL+nm8ejpvpi0mpiLfXPA421rvwMQe+sA796wlcZjSF9frWL7zaUl0+e
         6bNuVeeA21gWZrXiPFpMSLscTyrSpyva0BHdxhq2u3WS0ibOPRzaYS725y2LyywQD/K3
         sk20rHuqW8zK4EXAJMjzbEWf6iRWlRq7bOcOvR/bWB4C5CAMqma2V2IAEc3YTNisSbjA
         eocw==
X-Gm-Message-State: AOJu0YyU2U46ShOBaY7xG/dxIp+FegyR8/ZYdsjvhAcegmIKzHjsf4uY
	JEi30V+4eNp0Q9fjK7UClAbh3hdCCoWOAHiLPTJkI8doOxm5R84ZvZBaDKUm4Q==
X-Gm-Gg: ASbGncvf/ffQr/B6l4g/4dqJg3GV1tohnf53/Fy+wMbttQBosNaPpK658/wqDR1EypJ
	Iw30D1u7+Yo5PGVve/u8ayymtLbyqnb6rg/twibyYcsDAbki5wy9qZIFvDIaO3NFloRnxE5mG24
	OFrbqgPxVXFnoU4FmmDNxT5zayEdA797QE7iVxJ3bmEaLuPD1kbxiFNmQEQAA5KSnI69+aX0yql
	kgb5TEpiebT0jQsCaIB44s9PugAjc9StVIe3BTcBZ12BfcwURAL1W7sFb8XxzII16uQYRKLj7S/
	rQDg/9kvEvccB9Tt+ju21c5bZ0gmhCckz/B/EsBcrmvAEHo4lJv7XDZnmojEh08A0HrVFDsvjpy
	cjSlK90eEcHvK6c18ZOCqVimYn/KyC4ldsDXQ1X+b49N3dFyAh09C/YgAug==
X-Google-Smtp-Source: AGHT+IHTdANHonYuStw4Z+dxwvWzRAP6qfwbsiUcPsTKHk0WpS2t8kUHQdGqTWKF8i2+XxV1lSVzNg==
X-Received: by 2002:a05:6a00:3c94:b0:772:871c:1e49 with SMTP id d2e1a72fcca58-77e4f48ee3fmr1082246b3a.29.1758234385633;
        Thu, 18 Sep 2025 15:26:25 -0700 (PDT)
Received: from pop-os.. ([2601:647:6881:9060:c5c1:2e33:6cf2:beed])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77e5fe6de75sm407542b3a.19.2025.09.18.15.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 15:26:25 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: pasha.tatashin@soleen.com,
	Cong Wang <cwang@multikernel.io>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org
Subject: [RFC Patch 3/7] x86: Introduce MULTIKERNEL_VECTOR for inter-kernel communication
Date: Thu, 18 Sep 2025 15:26:02 -0700
Message-Id: <20250918222607.186488-4-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918222607.186488-1-xiyou.wangcong@gmail.com>
References: <20250918222607.186488-1-xiyou.wangcong@gmail.com>
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
 arch/x86/include/asm/idtentry.h    |  1 +
 arch/x86/include/asm/irq_vectors.h |  1 +
 arch/x86/kernel/idt.c              |  1 +
 arch/x86/kernel/smp.c              | 12 ++++++++++++
 4 files changed, 15 insertions(+)

diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index a4ec27c67988..219ee36def33 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -708,6 +708,7 @@ DECLARE_IDTENTRY(RESCHEDULE_VECTOR,			sysvec_reschedule_ipi);
 DECLARE_IDTENTRY_SYSVEC(REBOOT_VECTOR,			sysvec_reboot);
 DECLARE_IDTENTRY_SYSVEC(CALL_FUNCTION_SINGLE_VECTOR,	sysvec_call_function_single);
 DECLARE_IDTENTRY_SYSVEC(CALL_FUNCTION_VECTOR,		sysvec_call_function);
+DECLARE_IDTENTRY_SYSVEC(MULTIKERNEL_VECTOR,			sysvec_multikernel);
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
index f445bec516a0..063b330d9fbf 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -135,6 +135,7 @@ static const __initconst struct idt_data apic_idts[] = {
 	INTG(RESCHEDULE_VECTOR,			asm_sysvec_reschedule_ipi),
 	INTG(CALL_FUNCTION_VECTOR,		asm_sysvec_call_function),
 	INTG(CALL_FUNCTION_SINGLE_VECTOR,	asm_sysvec_call_function_single),
+	INTG(MULTIKERNEL_VECTOR,		asm_sysvec_multikernel),
 	INTG(REBOOT_VECTOR,			asm_sysvec_reboot),
 #endif
 
diff --git a/arch/x86/kernel/smp.c b/arch/x86/kernel/smp.c
index b014e6d229f9..028cc423a772 100644
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -272,6 +272,18 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_call_function_single)
 	trace_call_function_single_exit(CALL_FUNCTION_SINGLE_VECTOR);
 }
 
+static void generic_multikernel_interrupt(void)
+{
+	pr_info("Multikernel interrupt\n");
+}
+
+DEFINE_IDTENTRY_SYSVEC(sysvec_multikernel)
+{
+	apic_eoi();
+	inc_irq_stat(irq_call_count);
+	generic_multikernel_interrupt();
+}
+
 static int __init nonmi_ipi_setup(char *str)
 {
 	smp_no_nmi_ipi = true;
-- 
2.34.1


