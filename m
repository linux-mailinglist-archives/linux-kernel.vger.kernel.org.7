Return-Path: <linux-kernel+bounces-880748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F93CC2676D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 18:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFD72407235
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 17:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E97308F1A;
	Fri, 31 Oct 2025 17:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XtNJBG+z"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465CA302151
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 17:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761932560; cv=none; b=lGuPiM7KwQ4oUw77v6nuVcyi1yrsLPGofyCODEIsVwTluTQT9bn+R+9nhxBJbFp9IoLfTXIfFB4MDgdsAJ1TS/kD5QSDHrYc0BtgAC1JLZ0AF9uSr9snlNPYqbhFWlAf9gFpWmNL7LHZKl+1QgOyDWjbN3YzmXuxy3tLic0sgFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761932560; c=relaxed/simple;
	bh=eCYShfRX0rHI6sx8cr4A4kN5N77l6dX/sdpeOCW1NVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OD9NFj7tOal1y8rLrFNHc6o7F0Ps9O7jtCe0U1+yB6/8uHLsRqBEKq9y9Zfu2U+P/cvGNbgu38MWJbB0dgF4W9/V+t50H+jqFsh6kgGmsDQvgkMEfBVQ1D8PS3Z/J7L2Bo3/c8C7bKux8ShFTsaEfCVvu4bqRqoO0Pt867QKlS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XtNJBG+z; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4711810948aso18798925e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761932556; x=1762537356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/JFfpBNltudBh1dcawvKJ9buR3KdRpsYCaA9EH+988I=;
        b=XtNJBG+zq/eb8mLDXbsh48azjhXUeHWDCxawc+rT/MWGnG7ZWPX+/Rwria25WJECTS
         DjMtXWk1KyyPxvONvxc7NP1eoG5QbN4BvqzJm6hQj5nq2UER3CyajMdZF1DqyRt91mY8
         YfWB/KacRhL8c0RYJmRYm+O40bL/anjDGaPwQZ8DYUSjzpj9BrB/1f7u24Jj0BNkolnv
         OshqoODm/SEpzBoRqYpcu8gkFJYt6IyVSpijdJ7IW1KFZZpG7jyNSCUBCW4LEQgOAcna
         FjVa8Vc4vRHSDqlqCo9IhuQ6Bp4DFj7PrClXeFsb3ZNB72elh7hReScbH+JQ2dbIV0CR
         iusg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761932556; x=1762537356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/JFfpBNltudBh1dcawvKJ9buR3KdRpsYCaA9EH+988I=;
        b=SybRbkIsfx40Vml/GiSsyKpAhsOj8hGUz8ZJdkgAIXt5sR+OOolqngIi0NxHbqBo49
         9RyWac88fdyTYDPI9s3N1cGixsoD25+tlu+tTJDOVwoaAEjWroiylBDciIxLprZwyOjL
         jsmBmuU7EaFEUR2nm4b9IWP3egwadX3cHcsHH7Ex7idBtDNkWKdMis3u/JL3MIpPVL4B
         kJzWL0mFWF/pmkno16n9n3Ugjvz20KvSfmoG8qoV7OK0Zh14JbY+w95k++iqfP9gSUmZ
         IMCXYpdnucfRSLFebTfch3b/vZfvSbiHlfbN55GMDE1bn/eu2hceQuODQ7PeF7bdsSjn
         94AQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxKvHuuPFw9dg65Z/barIgN3Y/nrFzf7w02bJAi4Ai+JLb/m6vGg/xbHtP3yC2bk1HmOcUkdSkQ9cFF2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBaf8qtXRZdwvvD1gwbWttNaW6AlXlmpn9JJyqr2AERWIWKZpR
	Mme9QZcBDl4+z/EVsN2FvUg6sCZ4nSkiSYWVq5zEvyAB21mYhFk1ll5m
X-Gm-Gg: ASbGnctCHuc1ohZnyDA8FOx6C1yBfOzHW+1vgpIHJm5qL6h/UmoszCZcn1BHc3IL/0O
	yFB6wQXXtVzDuB4b6Kr9/XcrcTcK/Mp1jZQdrVdsSXtlsbqu+hgfpS727vFXDB9/M3n0w6vKKwN
	GbDQQ3Tr+idW6EvaAXWh3c5y0duUinBbenKUl5YQOBagFPuT9fQyRlDUkUrtJoidXyAWLpo6Ft7
	DoAkPDzTpSvIOwGx5dqgfUZ8pjh94J7F+1gl8HrdssDojmG7MnEefVv1qwweRdXfGb0pJ2TsXEA
	08LOwdiqwiXRfOeTHZlh9s40ny1vtuW1sF4SKf/fVOXvwQ78QzVZ4OqGCF5Nhkhc88c7/41qp3A
	eERSXf8ChxpTLynQu3e5mGqHMScAK+/R5AdpRkwBMtj/yN2fQdOdT2sTIubSKTauCJcXte8dPeo
	t0ZHj32Cj1RqZnnorsMpDuPajDLMmK7rOnPgyGRtFfQER5XvQolvRTjAGCesQ=
X-Google-Smtp-Source: AGHT+IFbNYPa3KcCa7VpnDiT2uVnaGmXVOevywcNwvqIGQkDf6aVOLWVM/y4XkNRP6N+RMNcb2Nb7g==
X-Received: by 2002:a05:600d:6359:b0:475:de14:db1e with SMTP id 5b1f17b1804b1-477346ec27emr19014905e9.24.1761932556254;
        Fri, 31 Oct 2025 10:42:36 -0700 (PDT)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c53eafbsm6728865e9.12.2025.10.31.10.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 10:42:35 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: torvalds@linux-foundation.org
Cc: brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	tglx@linutronix.de,
	pfalcato@suse.de,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH 2/3] runtime-const: split headers between accessors and fixup; disable for modules
Date: Fri, 31 Oct 2025 18:42:19 +0100
Message-ID: <20251031174220.43458-3-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031174220.43458-1-mjguzik@gmail.com>
References: <CAHk-=wjRA8G9eOPWa_Njz4NAk3gZNvdt0WAHZfn3iXfcVsmpcA@mail.gmail.com>
 <20251031174220.43458-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

risv and x86 covered as a POC
---
 .../include/asm/runtime-const-accessors.h     | 151 ++++++++++++++++++
 arch/riscv/include/asm/runtime-const.h        | 142 +---------------
 .../x86/include/asm/runtime-const-accessors.h |  45 ++++++
 arch/x86/include/asm/runtime-const.h          |  38 +----
 4 files changed, 200 insertions(+), 176 deletions(-)
 create mode 100644 arch/riscv/include/asm/runtime-const-accessors.h
 create mode 100644 arch/x86/include/asm/runtime-const-accessors.h

diff --git a/arch/riscv/include/asm/runtime-const-accessors.h b/arch/riscv/include/asm/runtime-const-accessors.h
new file mode 100644
index 000000000000..5b8e0349ee0d
--- /dev/null
+++ b/arch/riscv/include/asm/runtime-const-accessors.h
@@ -0,0 +1,151 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_RISCV_RUNTIME_CONST_ACCESSORS_H
+#define _ASM_RISCV_RUNTIME_CONST_ACCESSORS_H
+
+#ifdef MODULE
+#error "this functionality is not available for modules"
+#endif
+
+#ifdef CONFIG_32BIT
+#define runtime_const_ptr(sym)					\
+({								\
+	typeof(sym) __ret;					\
+	asm_inline(".option push\n\t"				\
+		".option norvc\n\t"				\
+		"1:\t"						\
+		"lui	%[__ret],0x89abd\n\t"			\
+		"addi	%[__ret],%[__ret],-0x211\n\t"		\
+		".option pop\n\t"				\
+		".pushsection runtime_ptr_" #sym ",\"a\"\n\t"	\
+		".long 1b - .\n\t"				\
+		".popsection"					\
+		: [__ret] "=r" (__ret));			\
+	__ret;							\
+})
+#else
+/*
+ * Loading 64-bit constants into a register from immediates is a non-trivial
+ * task on riscv64. To get it somewhat performant, load 32 bits into two
+ * different registers and then combine the results.
+ *
+ * If the processor supports the Zbkb extension, we can combine the final
+ * "slli,slli,srli,add" into the single "pack" instruction. If the processor
+ * doesn't support Zbkb but does support the Zbb extension, we can
+ * combine the final "slli,srli,add" into one instruction "add.uw".
+ */
+#define RISCV_RUNTIME_CONST_64_PREAMBLE				\
+	".option push\n\t"					\
+	".option norvc\n\t"					\
+	"1:\t"							\
+	"lui	%[__ret],0x89abd\n\t"				\
+	"lui	%[__tmp],0x1234\n\t"				\
+	"addiw	%[__ret],%[__ret],-0x211\n\t"			\
+	"addiw	%[__tmp],%[__tmp],0x567\n\t"			\
+
+#define RISCV_RUNTIME_CONST_64_BASE				\
+	"slli	%[__tmp],%[__tmp],32\n\t"			\
+	"slli	%[__ret],%[__ret],32\n\t"			\
+	"srli	%[__ret],%[__ret],32\n\t"			\
+	"add	%[__ret],%[__ret],%[__tmp]\n\t"			\
+
+#define RISCV_RUNTIME_CONST_64_ZBA				\
+	".option push\n\t"					\
+	".option arch,+zba\n\t"					\
+	".option norvc\n\t"					\
+	"slli	%[__tmp],%[__tmp],32\n\t"			\
+	"add.uw %[__ret],%[__ret],%[__tmp]\n\t"			\
+	"nop\n\t"						\
+	"nop\n\t"						\
+	".option pop\n\t"					\
+
+#define RISCV_RUNTIME_CONST_64_ZBKB				\
+	".option push\n\t"					\
+	".option arch,+zbkb\n\t"				\
+	".option norvc\n\t"					\
+	"pack	%[__ret],%[__ret],%[__tmp]\n\t"			\
+	"nop\n\t"						\
+	"nop\n\t"						\
+	"nop\n\t"						\
+	".option pop\n\t"					\
+
+#define RISCV_RUNTIME_CONST_64_POSTAMBLE(sym)			\
+	".option pop\n\t"					\
+	".pushsection runtime_ptr_" #sym ",\"a\"\n\t"		\
+	".long 1b - .\n\t"					\
+	".popsection"						\
+
+#if defined(CONFIG_RISCV_ISA_ZBA) && defined(CONFIG_TOOLCHAIN_HAS_ZBA)	\
+	&& defined(CONFIG_RISCV_ISA_ZBKB)
+#define runtime_const_ptr(sym)						\
+({									\
+	typeof(sym) __ret, __tmp;					\
+	asm_inline(RISCV_RUNTIME_CONST_64_PREAMBLE			\
+		ALTERNATIVE_2(						\
+			RISCV_RUNTIME_CONST_64_BASE,			\
+			RISCV_RUNTIME_CONST_64_ZBA,			\
+			0, RISCV_ISA_EXT_ZBA, 1,			\
+			RISCV_RUNTIME_CONST_64_ZBKB,			\
+			0, RISCV_ISA_EXT_ZBKB, 1			\
+		)							\
+		RISCV_RUNTIME_CONST_64_POSTAMBLE(sym)			\
+		: [__ret] "=r" (__ret), [__tmp] "=r" (__tmp));		\
+	__ret;								\
+})
+#elif defined(CONFIG_RISCV_ISA_ZBA) && defined(CONFIG_TOOLCHAIN_HAS_ZBA)
+#define runtime_const_ptr(sym)						\
+({									\
+	typeof(sym) __ret, __tmp;					\
+	asm_inline(RISCV_RUNTIME_CONST_64_PREAMBLE			\
+		ALTERNATIVE(						\
+			RISCV_RUNTIME_CONST_64_BASE,			\
+			RISCV_RUNTIME_CONST_64_ZBA,			\
+			0, RISCV_ISA_EXT_ZBA, 1				\
+		)							\
+		RISCV_RUNTIME_CONST_64_POSTAMBLE(sym)			\
+		: [__ret] "=r" (__ret), [__tmp] "=r" (__tmp));		\
+	__ret;								\
+})
+#elif defined(CONFIG_RISCV_ISA_ZBKB)
+#define runtime_const_ptr(sym)						\
+({									\
+	typeof(sym) __ret, __tmp;					\
+	asm_inline(RISCV_RUNTIME_CONST_64_PREAMBLE			\
+		ALTERNATIVE(						\
+			RISCV_RUNTIME_CONST_64_BASE,			\
+			RISCV_RUNTIME_CONST_64_ZBKB,			\
+			0, RISCV_ISA_EXT_ZBKB, 1			\
+		)							\
+		RISCV_RUNTIME_CONST_64_POSTAMBLE(sym)			\
+		: [__ret] "=r" (__ret), [__tmp] "=r" (__tmp));		\
+	__ret;								\
+})
+#else
+#define runtime_const_ptr(sym)						\
+({									\
+	typeof(sym) __ret, __tmp;					\
+	asm_inline(RISCV_RUNTIME_CONST_64_PREAMBLE			\
+		RISCV_RUNTIME_CONST_64_BASE				\
+		RISCV_RUNTIME_CONST_64_POSTAMBLE(sym)			\
+		: [__ret] "=r" (__ret), [__tmp] "=r" (__tmp));		\
+	__ret;								\
+})
+#endif
+#endif
+
+#define runtime_const_shift_right_32(val, sym)			\
+({								\
+	u32 __ret;						\
+	asm_inline(".option push\n\t"				\
+		".option norvc\n\t"				\
+		"1:\t"						\
+		SRLI " %[__ret],%[__val],12\n\t"		\
+		".option pop\n\t"				\
+		".pushsection runtime_shift_" #sym ",\"a\"\n\t"	\
+		".long 1b - .\n\t"				\
+		".popsection"					\
+		: [__ret] "=r" (__ret)				\
+		: [__val] "r" (val));				\
+	__ret;							\
+})
+
+#endif /* _ASM_RISCV_RUNTIME_CONST_ACCESSORS_H */
diff --git a/arch/riscv/include/asm/runtime-const.h b/arch/riscv/include/asm/runtime-const.h
index d766e2b9e6df..14994be81487 100644
--- a/arch/riscv/include/asm/runtime-const.h
+++ b/arch/riscv/include/asm/runtime-const.h
@@ -11,147 +11,7 @@
 
 #include <linux/uaccess.h>
 
-#ifdef CONFIG_32BIT
-#define runtime_const_ptr(sym)					\
-({								\
-	typeof(sym) __ret;					\
-	asm_inline(".option push\n\t"				\
-		".option norvc\n\t"				\
-		"1:\t"						\
-		"lui	%[__ret],0x89abd\n\t"			\
-		"addi	%[__ret],%[__ret],-0x211\n\t"		\
-		".option pop\n\t"				\
-		".pushsection runtime_ptr_" #sym ",\"a\"\n\t"	\
-		".long 1b - .\n\t"				\
-		".popsection"					\
-		: [__ret] "=r" (__ret));			\
-	__ret;							\
-})
-#else
-/*
- * Loading 64-bit constants into a register from immediates is a non-trivial
- * task on riscv64. To get it somewhat performant, load 32 bits into two
- * different registers and then combine the results.
- *
- * If the processor supports the Zbkb extension, we can combine the final
- * "slli,slli,srli,add" into the single "pack" instruction. If the processor
- * doesn't support Zbkb but does support the Zbb extension, we can
- * combine the final "slli,srli,add" into one instruction "add.uw".
- */
-#define RISCV_RUNTIME_CONST_64_PREAMBLE				\
-	".option push\n\t"					\
-	".option norvc\n\t"					\
-	"1:\t"							\
-	"lui	%[__ret],0x89abd\n\t"				\
-	"lui	%[__tmp],0x1234\n\t"				\
-	"addiw	%[__ret],%[__ret],-0x211\n\t"			\
-	"addiw	%[__tmp],%[__tmp],0x567\n\t"			\
-
-#define RISCV_RUNTIME_CONST_64_BASE				\
-	"slli	%[__tmp],%[__tmp],32\n\t"			\
-	"slli	%[__ret],%[__ret],32\n\t"			\
-	"srli	%[__ret],%[__ret],32\n\t"			\
-	"add	%[__ret],%[__ret],%[__tmp]\n\t"			\
-
-#define RISCV_RUNTIME_CONST_64_ZBA				\
-	".option push\n\t"					\
-	".option arch,+zba\n\t"					\
-	".option norvc\n\t"					\
-	"slli	%[__tmp],%[__tmp],32\n\t"			\
-	"add.uw %[__ret],%[__ret],%[__tmp]\n\t"			\
-	"nop\n\t"						\
-	"nop\n\t"						\
-	".option pop\n\t"					\
-
-#define RISCV_RUNTIME_CONST_64_ZBKB				\
-	".option push\n\t"					\
-	".option arch,+zbkb\n\t"				\
-	".option norvc\n\t"					\
-	"pack	%[__ret],%[__ret],%[__tmp]\n\t"			\
-	"nop\n\t"						\
-	"nop\n\t"						\
-	"nop\n\t"						\
-	".option pop\n\t"					\
-
-#define RISCV_RUNTIME_CONST_64_POSTAMBLE(sym)			\
-	".option pop\n\t"					\
-	".pushsection runtime_ptr_" #sym ",\"a\"\n\t"		\
-	".long 1b - .\n\t"					\
-	".popsection"						\
-
-#if defined(CONFIG_RISCV_ISA_ZBA) && defined(CONFIG_TOOLCHAIN_HAS_ZBA)	\
-	&& defined(CONFIG_RISCV_ISA_ZBKB)
-#define runtime_const_ptr(sym)						\
-({									\
-	typeof(sym) __ret, __tmp;					\
-	asm_inline(RISCV_RUNTIME_CONST_64_PREAMBLE			\
-		ALTERNATIVE_2(						\
-			RISCV_RUNTIME_CONST_64_BASE,			\
-			RISCV_RUNTIME_CONST_64_ZBA,			\
-			0, RISCV_ISA_EXT_ZBA, 1,			\
-			RISCV_RUNTIME_CONST_64_ZBKB,			\
-			0, RISCV_ISA_EXT_ZBKB, 1			\
-		)							\
-		RISCV_RUNTIME_CONST_64_POSTAMBLE(sym)			\
-		: [__ret] "=r" (__ret), [__tmp] "=r" (__tmp));		\
-	__ret;								\
-})
-#elif defined(CONFIG_RISCV_ISA_ZBA) && defined(CONFIG_TOOLCHAIN_HAS_ZBA)
-#define runtime_const_ptr(sym)						\
-({									\
-	typeof(sym) __ret, __tmp;					\
-	asm_inline(RISCV_RUNTIME_CONST_64_PREAMBLE			\
-		ALTERNATIVE(						\
-			RISCV_RUNTIME_CONST_64_BASE,			\
-			RISCV_RUNTIME_CONST_64_ZBA,			\
-			0, RISCV_ISA_EXT_ZBA, 1				\
-		)							\
-		RISCV_RUNTIME_CONST_64_POSTAMBLE(sym)			\
-		: [__ret] "=r" (__ret), [__tmp] "=r" (__tmp));		\
-	__ret;								\
-})
-#elif defined(CONFIG_RISCV_ISA_ZBKB)
-#define runtime_const_ptr(sym)						\
-({									\
-	typeof(sym) __ret, __tmp;					\
-	asm_inline(RISCV_RUNTIME_CONST_64_PREAMBLE			\
-		ALTERNATIVE(						\
-			RISCV_RUNTIME_CONST_64_BASE,			\
-			RISCV_RUNTIME_CONST_64_ZBKB,			\
-			0, RISCV_ISA_EXT_ZBKB, 1			\
-		)							\
-		RISCV_RUNTIME_CONST_64_POSTAMBLE(sym)			\
-		: [__ret] "=r" (__ret), [__tmp] "=r" (__tmp));		\
-	__ret;								\
-})
-#else
-#define runtime_const_ptr(sym)						\
-({									\
-	typeof(sym) __ret, __tmp;					\
-	asm_inline(RISCV_RUNTIME_CONST_64_PREAMBLE			\
-		RISCV_RUNTIME_CONST_64_BASE				\
-		RISCV_RUNTIME_CONST_64_POSTAMBLE(sym)			\
-		: [__ret] "=r" (__ret), [__tmp] "=r" (__tmp));		\
-	__ret;								\
-})
-#endif
-#endif
-
-#define runtime_const_shift_right_32(val, sym)			\
-({								\
-	u32 __ret;						\
-	asm_inline(".option push\n\t"				\
-		".option norvc\n\t"				\
-		"1:\t"						\
-		SRLI " %[__ret],%[__val],12\n\t"		\
-		".option pop\n\t"				\
-		".pushsection runtime_shift_" #sym ",\"a\"\n\t"	\
-		".long 1b - .\n\t"				\
-		".popsection"					\
-		: [__ret] "=r" (__ret)				\
-		: [__val] "r" (val));				\
-	__ret;							\
-})
+#include <asm/runtime-const-accessors.h>
 
 #define runtime_const_init(type, sym) do {			\
 	extern s32 __start_runtime_##type##_##sym[];		\
diff --git a/arch/x86/include/asm/runtime-const-accessors.h b/arch/x86/include/asm/runtime-const-accessors.h
new file mode 100644
index 000000000000..4c411bc3cb32
--- /dev/null
+++ b/arch/x86/include/asm/runtime-const-accessors.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_RUNTIME_CONST_ACCESSORS_H
+#define _ASM_RUNTIME_CONST_ACCESSORS_H
+
+#ifdef MODULE
+#error "this functionality is not available for modules"
+#endif
+
+#ifdef __ASSEMBLY__
+
+.macro RUNTIME_CONST_PTR sym reg
+	movq	$0x0123456789abcdef, %\reg
+	1:
+	.pushsection runtime_ptr_\sym, "a"
+	.long	1b - 8 - .
+	.popsection
+.endm
+
+#else /* __ASSEMBLY__ */
+
+#define runtime_const_ptr(sym) ({				\
+	typeof(sym) __ret;					\
+	asm_inline("mov %1,%0\n1:\n"				\
+		".pushsection runtime_ptr_" #sym ",\"a\"\n\t"	\
+		".long 1b - %c2 - .\n"				\
+		".popsection"					\
+		:"=r" (__ret)					\
+		:"i" ((unsigned long)0x0123456789abcdefull),	\
+		 "i" (sizeof(long)));				\
+	__ret; })
+
+// The 'typeof' will create at _least_ a 32-bit type, but
+// will happily also take a bigger type and the 'shrl' will
+// clear the upper bits
+#define runtime_const_shift_right_32(val, sym) ({		\
+	typeof(0u+(val)) __ret = (val);				\
+	asm_inline("shrl $12,%k0\n1:\n"				\
+		".pushsection runtime_shift_" #sym ",\"a\"\n\t"	\
+		".long 1b - 1 - .\n"				\
+		".popsection"					\
+		:"+r" (__ret));					\
+	__ret; })
+
+#endif /* __ASSEMBLY__ */
+#endif
diff --git a/arch/x86/include/asm/runtime-const.h b/arch/x86/include/asm/runtime-const.h
index 8d983cfd06ea..15d67e2bfc96 100644
--- a/arch/x86/include/asm/runtime-const.h
+++ b/arch/x86/include/asm/runtime-const.h
@@ -2,41 +2,9 @@
 #ifndef _ASM_RUNTIME_CONST_H
 #define _ASM_RUNTIME_CONST_H
 
-#ifdef __ASSEMBLY__
-
-.macro RUNTIME_CONST_PTR sym reg
-	movq	$0x0123456789abcdef, %\reg
-	1:
-	.pushsection runtime_ptr_\sym, "a"
-	.long	1b - 8 - .
-	.popsection
-.endm
-
-#else /* __ASSEMBLY__ */
-
-#define runtime_const_ptr(sym) ({				\
-	typeof(sym) __ret;					\
-	asm_inline("mov %1,%0\n1:\n"				\
-		".pushsection runtime_ptr_" #sym ",\"a\"\n\t"	\
-		".long 1b - %c2 - .\n"				\
-		".popsection"					\
-		:"=r" (__ret)					\
-		:"i" ((unsigned long)0x0123456789abcdefull),	\
-		 "i" (sizeof(long)));				\
-	__ret; })
-
-// The 'typeof' will create at _least_ a 32-bit type, but
-// will happily also take a bigger type and the 'shrl' will
-// clear the upper bits
-#define runtime_const_shift_right_32(val, sym) ({		\
-	typeof(0u+(val)) __ret = (val);				\
-	asm_inline("shrl $12,%k0\n1:\n"				\
-		".pushsection runtime_shift_" #sym ",\"a\"\n\t"	\
-		".long 1b - 1 - .\n"				\
-		".popsection"					\
-		:"+r" (__ret));					\
-	__ret; })
+#include <asm/runtime-const-accessors.h>
 
+#ifndef __ASSEMBLY__
 #define runtime_const_init(type, sym) do {		\
 	extern s32 __start_runtime_##type##_##sym[];	\
 	extern s32 __stop_runtime_##type##_##sym[];	\
@@ -70,5 +38,5 @@ static inline void runtime_const_fixup(void (*fn)(void *, unsigned long),
 	}
 }
 
-#endif /* __ASSEMBLY__ */
+#endif /* !__ASSEMBLY__ */
 #endif
-- 
2.34.1


