Return-Path: <linux-kernel+bounces-883558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 865DAC2DC07
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 19:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3EF154F4FCB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 18:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D225831B131;
	Mon,  3 Nov 2025 18:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBRtzkA0"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D90428DB52
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 18:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762195964; cv=none; b=RP371vCaARIs4fTCkq7Ruh/2WdOXAZaHrbwunzwHGJ1lOflGqtYmSCOzP0KrQbw7Xryz2/Kr3TKktTU+5Bsnk9H9tnLD7dTlJxqIed7l22+arkS8NcKDHbT/FTdHclnFwQkvx5R+6St9IegWMbYvrfdjSYdjAWXdokQQ1Lvp1DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762195964; c=relaxed/simple;
	bh=UOcAQjRYQgeODXS9XznehsWkYh3dJv0MvXkkzFWKyzw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SvY5qItQcXVHQWjikelhzBKs/7FiCPNf9Tuvg6YEYCra/avCVkLn/Zmt678jj1hK7e51Em9pMrwD4qxG/tBUPjMg12blzWjuOfM6KhesQ3Eyvl+7UFL7HEFkXEaw45U28B0HY0YQuwufdnmCXJAZHhHFs3kvAxOrE2zL+IPx4bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nBRtzkA0; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-34029cee97fso4872674a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 10:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762195962; x=1762800762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4bTLrYcdGviHL8Gi8iTccxKPkHb0A01pNfuP/UlxY48=;
        b=nBRtzkA0Na0+cSSfmhS05leIC8VmJG8EMpqh8HL1FsWJ0pu281dm80zlqHriqX3deJ
         e5ttIvVT+/HGf6EJ6RCf2Z0Q0/ejLfvN/9odKuHviw9KRoNvpEFXXZGuexw6JE9yFKrE
         BIsYVpQVuxVd8+vNwExbq8hMszXEFlZr/SPQILMUfzOXr7aWi1Q3VcCDNbT625zrvK/y
         nNigqdG1KChhvmtRtPhCJknU9eJK560lwjk+wir4Lj0LcpBjFXhr78WwijWKBA9jgTxQ
         zWpI4dz0s6K0s6EtXrHe1j647/Jf/RsM60XZYauTknRU5Jn0C+78PLgvi8a+xmtxzZ9I
         GDMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762195962; x=1762800762;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4bTLrYcdGviHL8Gi8iTccxKPkHb0A01pNfuP/UlxY48=;
        b=Gor3W7BLrBIcI+9lL9kdMMl+xw26TiYz5GUzelfhQHFy4DH3hRPwdpgJyKtiIGuoXp
         Klx+HsP9hzGmgAIDUColUW4hPZhFgkc7nyNEXevOp9nU/91U3ZTRkZpb2tRp5QgfH2tj
         VNiS+Bc22hXtlsaWqZbtKxW59KWTAyPqJjk6WKOdj+dK8lsnDao4BtBAR5l71ZwPlxYt
         e3QyIIioIO8ymCDrGqWO0zzy0ULxCSTWVvptFKZzxMBIr1o8byWd0w2TbYfR5GJ0uL5L
         j5mbJ8FID84hY7rjOrOzumNNTFYTEUQJ3JFb1zKjfcvtVFPOiUohwgeXpbAJhilfg4Ue
         Ng1Q==
X-Forwarded-Encrypted: i=1; AJvYcCW2Jw/YV6mxDS9oOE0wKHk+PjGTDGhVUzB3MODCN2Rp7jjD0t/qJXZqrk2qqrkVyPpoFrfAJO1CwIIIa5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK4hNnYv6aqEzE0zs87lDWSI/aN6tGAUdKtGSdWjrxegRipreR
	S7+uiL2NJfsGnDu5SYbAwTqA45hz+8CiISYARXPElmn1C9U/0nlQKmwv
X-Gm-Gg: ASbGncsZIaLmFARgz7DgRLtq0WrqxhNqQNk3RFSF7Sj9+xB3ng7fTMek8UmMt3fthC2
	HdcxDcIPCq2jv5h3pQlsv1BzaEuIpeF9DFw4XnOWbEyqrMti1EaYoJjdYIVVn7svZdLqM9mOOP2
	CaZIMytPnPagsRj7X3uTwCRBdajuINWKG97Ur8eiTtDmosGwzIww3+FdfG5vjKcXEpoK+QhWUrG
	CCIlxpsEogQSUq4hmlcTjF3RvxMzu3Zfh3jU6LWMBT2nFyEwjEgmZPEV1+VGvzAKmyaMHJx1ukE
	YMGgeokuqFjJWNjFRs23ZT5PLonmYPjX7f2rQmua4JPIKE3Pqsuq2qkBzv7Ehr+5C/ws0mupctj
	JnzroHOSZhJi0mLkqqJDS9NCCeZOo0FjiJeJeHog6OX9YvKZp1tbCZGmRjeJkh90dfEvxVf3PHM
	9DgLy0/2VtEvNmhmiFQZBm8vKEpIji
X-Google-Smtp-Source: AGHT+IEoJGgdDYDkKXdr+CYpLYlhkWn/9DscVQmfV05umliaGx7nf5rDXxZHqyJxi65KxiLM+AdQJw==
X-Received: by 2002:a17:90a:c2cc:b0:33b:d74b:179 with SMTP id 98e67ed59e1d1-3408308ccebmr15462822a91.27.1762195961473;
        Mon, 03 Nov 2025 10:52:41 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:4::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b93bf44e233sm11232213a12.34.2025.11.03.10.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 10:52:41 -0800 (PST)
From: Ben Niu <niuben003@gmail.com>
X-Google-Original-From: Ben Niu <benniu@meta.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	tytso@mit.edu,
	Jason@zx2c4.com,
	Ben Niu <benniu@meta.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] tracing: Enable kprobe for selected Arm64 assembly
Date: Mon,  3 Nov 2025 10:52:35 -0800
Message-ID: <20251103185237.2284456-1-benniu@meta.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When ftrace is enabled, a function can only be kprobe'd if
  (1) the function has proper nops inserted at the beginning
  (2) the first inserted nop's address is added in section
      __patchable_function_entries.

See function within_notrace_func in kernel/trace/trace_kprobe.c
for more details.

This patch adds a new asm function macro SYM_FUNC_START_TRACE
that makes an asm funtion satisfy the above two conditions so that
it can be kprobe'd. In addition, the macro is applied to
__arch_copy_to_user and __arch_copy_from_user, which were found
to be hot in certain workloads.

Note: although this patch unblocks kprobe tracing, fentry is still
broken because no BTF info gets generated from assembly files. A
separate patch is needed to fix that.

This patch was built with different combos of the following
features and kprobe tracing for asm functions __arch_copy_to_user
and __arch_copy_from_user worked in all cases:

CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS
CONFIG_DYNAMIC_FTRACE_WITH_ARGS
CONFIG_ARM64_BTI_KERNEL

Signed-off-by: Ben Niu <benniu@meta.com>
---
v2: only opt-in __arch_copy_from_user and __arch_copy_to_user for
    tracing since tracing asm functions in general may be unsafe

v1: aQOpd14RXnyQLOWR@meta.com
---
 arch/arm64/include/asm/linkage.h | 91 ++++++++++++++++++++++++--------
 arch/arm64/lib/copy_from_user.S  |  2 +-
 arch/arm64/lib/copy_to_user.S    |  2 +-
 3 files changed, 70 insertions(+), 25 deletions(-)

diff --git a/arch/arm64/include/asm/linkage.h b/arch/arm64/include/asm/linkage.h
index d3acd9c87509..b9a7513dc7d9 100644
--- a/arch/arm64/include/asm/linkage.h
+++ b/arch/arm64/include/asm/linkage.h
@@ -5,8 +5,47 @@
 #include <asm/assembler.h>
 #endif
 
-#define __ALIGN		.balign CONFIG_FUNCTION_ALIGNMENT
-#define __ALIGN_STR	".balign " #CONFIG_FUNCTION_ALIGNMENT
+#define __ALIGN .balign CONFIG_FUNCTION_ALIGNMENT
+#define __ALIGN_STR ".balign " #CONFIG_FUNCTION_ALIGNMENT
+
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS
+
+#define PRE_FUNCTION_NOPS                                                   \
+	ALIGN;                                                              \
+	nops CONFIG_FUNCTION_ALIGNMENT / 4 - 2;                             \
+	.pushsection __patchable_function_entries, "awo", @progbits, .text; \
+	.p2align 3;                                                         \
+	.8byte 1f;                                                          \
+	.popsection;                                                        \
+	1 :;                                                                \
+	nops 2;
+
+#define PRE_PROLOGUE_NOPS nops 2;
+
+#elif defined(CONFIG_DYNAMIC_FTRACE_WITH_ARGS)
+
+#define PRE_FUNCTION_NOPS
+
+#define PRE_PROLOGUE_NOPS                                                   \
+	.pushsection __patchable_function_entries, "awo", @progbits, .text; \
+	.p2align 3;                                                         \
+	.8byte 1f;                                                          \
+	.popsection;                                                        \
+	1 :;                                                                \
+	nops 2;
+
+#else
+
+#define PRE_FUNCTION_NOPS
+#define PRE_PROLOGUE_NOPS
+
+#endif
+
+#ifdef CONFIG_ARM64_BTI_KERNEL
+#define BTI_C bti c;
+#else
+#define BTI_C
+#endif
 
 /*
  * When using in-kernel BTI we need to ensure that PCS-conformant
@@ -15,32 +54,38 @@
  * everything, the override is done unconditionally so we're more
  * likely to notice any drift from the overridden definitions.
  */
-#define SYM_FUNC_START(name)				\
-	SYM_START(name, SYM_L_GLOBAL, SYM_A_ALIGN)	\
-	bti c ;
+#define SYM_FUNC_START_TRACE(name)                 \
+	PRE_FUNCTION_NOPS                          \
+	SYM_START(name, SYM_L_GLOBAL, SYM_A_ALIGN) \
+	BTI_C                                      \
+	PRE_PROLOGUE_NOPS
+
+#define SYM_FUNC_START(name)                       \
+	SYM_START(name, SYM_L_GLOBAL, SYM_A_ALIGN) \
+	BTI_C
 
-#define SYM_FUNC_START_NOALIGN(name)			\
-	SYM_START(name, SYM_L_GLOBAL, SYM_A_NONE)	\
-	bti c ;
+#define SYM_FUNC_START_NOALIGN(name)              \
+	SYM_START(name, SYM_L_GLOBAL, SYM_A_NONE) \
+	BTI_C                                     \
 
-#define SYM_FUNC_START_LOCAL(name)			\
-	SYM_START(name, SYM_L_LOCAL, SYM_A_ALIGN)	\
-	bti c ;
+#define SYM_FUNC_START_LOCAL(name)                \
+	SYM_START(name, SYM_L_LOCAL, SYM_A_ALIGN) \
+	BTI_C                                     \
 
-#define SYM_FUNC_START_LOCAL_NOALIGN(name)		\
-	SYM_START(name, SYM_L_LOCAL, SYM_A_NONE)	\
-	bti c ;
+#define SYM_FUNC_START_LOCAL_NOALIGN(name)       \
+	SYM_START(name, SYM_L_LOCAL, SYM_A_NONE) \
+	BTI_C                                    \
 
-#define SYM_FUNC_START_WEAK(name)			\
-	SYM_START(name, SYM_L_WEAK, SYM_A_ALIGN)	\
-	bti c ;
+#define SYM_FUNC_START_WEAK(name)                \
+	SYM_START(name, SYM_L_WEAK, SYM_A_ALIGN) \
+	BTI_C                                    \
 
-#define SYM_FUNC_START_WEAK_NOALIGN(name)		\
-	SYM_START(name, SYM_L_WEAK, SYM_A_NONE)		\
-	bti c ;
+#define SYM_FUNC_START_WEAK_NOALIGN(name)       \
+	SYM_START(name, SYM_L_WEAK, SYM_A_NONE) \
+	BTI_C                                   \
 
-#define SYM_TYPED_FUNC_START(name)				\
-	SYM_TYPED_START(name, SYM_L_GLOBAL, SYM_A_ALIGN)	\
-	bti c ;
+#define SYM_TYPED_FUNC_START(name)                       \
+	SYM_TYPED_START(name, SYM_L_GLOBAL, SYM_A_ALIGN) \
+	BTI_C                                            \
 
 #endif
diff --git a/arch/arm64/lib/copy_from_user.S b/arch/arm64/lib/copy_from_user.S
index 400057d607ec..07b6d6c9573f 100644
--- a/arch/arm64/lib/copy_from_user.S
+++ b/arch/arm64/lib/copy_from_user.S
@@ -61,7 +61,7 @@
 
 end	.req	x5
 srcin	.req	x15
-SYM_FUNC_START(__arch_copy_from_user)
+SYM_FUNC_START_TRACE(__arch_copy_from_user)
 	add	end, x0, x2
 	mov	srcin, x1
 #include "copy_template.S"
diff --git a/arch/arm64/lib/copy_to_user.S b/arch/arm64/lib/copy_to_user.S
index 819f2e3fc7a9..e7e663aea8ca 100644
--- a/arch/arm64/lib/copy_to_user.S
+++ b/arch/arm64/lib/copy_to_user.S
@@ -60,7 +60,7 @@
 
 end	.req	x5
 srcin	.req	x15
-SYM_FUNC_START(__arch_copy_to_user)
+SYM_FUNC_START_TRACE(__arch_copy_to_user)
 	add	end, x0, x2
 	mov	srcin, x1
 #include "copy_template.S"
-- 
2.47.3


