Return-Path: <linux-kernel+bounces-744571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC095B10E97
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 17:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A673DAE77F6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 15:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38872ECD38;
	Thu, 24 Jul 2025 15:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HWrR+C/R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A262E9EC6;
	Thu, 24 Jul 2025 15:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753370614; cv=none; b=QzqD917I0HAwLPXSmM5owPvHj7d5KVkciYVY244tx4VUqQ3j9uJUBUPdjFkpKlITqX9l8sXntrEYi9U8Lb9sM1NQ29jFA6fOIX05XeMfSrKfpqMu5UEF+Xg/WhCbLBGuLarF+JMiUewse6WTGjyCB1DsP7wwaIdbNad6KIXsJ1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753370614; c=relaxed/simple;
	bh=85HzHo47vOUHna4UDN0T4I9bLn5T1XOYIFyNrwd/L84=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J4XWi2hF2zKZAF0IROiAZIh9HX8wtxtpbYGHGfAA7pU7cQnR2RDA7zlPwLou7ssXTZytJeiFtj0WZYFFnBd3Hv2dUbZTUFewV3XOpGBfspYBJNaSGCUMeWQ+lBnbW410YONXce4DOylXFhzFGOuHytJWQrqICfqXwS23ygrrZJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HWrR+C/R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 69F48C4CEEF;
	Thu, 24 Jul 2025 15:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753370614;
	bh=85HzHo47vOUHna4UDN0T4I9bLn5T1XOYIFyNrwd/L84=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=HWrR+C/Rs/M81SlBKNjW5HEulUKpldt8aeVBg1X1QjJ9xW1ckQJH0AYzto7QHMeIV
	 jHduXA35mGrpBLuQGzJWzIUsVkHzVOPpyN1gpvlji1RVFew+H4juoaJJB1H870qyB6
	 +s7jkWA3UUe3RnciejtPRYWfj62o9KpHESkypePYXxEmlmqbav4E2h/SRGWrV6F/UG
	 pE+6ann+mXSMVwMoLx/bT9UK21HIome3gB5XAvsJEHwOOizTp1UICKjKmH9A1s7V6b
	 ASz+CJFdYifT4//0MWLjWMZIHv/GYe2iR9QyE5qptMAhZWWzOdRgJOEYIX6/kwdgeB
	 l4DbyJIs7CAmQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 624D0C87FCD;
	Thu, 24 Jul 2025 15:23:34 +0000 (UTC)
From: Aleksa Paunovic via B4 Relay <devnull+aleksa.paunovic.htecgroup.com@kernel.org>
Date: Thu, 24 Jul 2025 17:23:28 +0200
Subject: [PATCH v5 4/7] riscv: hwprobe: Add MIPS vendor extension probing
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250724-p8700-pause-v5-4-a6cbbe1c3412@htecgroup.com>
References: <20250724-p8700-pause-v5-0-a6cbbe1c3412@htecgroup.com>
In-Reply-To: <20250724-p8700-pause-v5-0-a6cbbe1c3412@htecgroup.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Jonathan Corbet <corbet@lwn.net>
Cc: Palmer Dabbelt <palmer@sifive.com>, Conor Dooley <conor@kernel.org>, 
 Djordje Todorovic <djordje.todorovic@htecgroup.com>, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Aleksa Paunovic <aleksa.paunovic@htecgroup.com>, 
 Alexandre Ghiti <alexghiti@rivosinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753370612; l=6066;
 i=aleksa.paunovic@htecgroup.com; s=20250514; h=from:subject:message-id;
 bh=QfC9zi2/T1SUAxGgkJqc5i6ZRIr13aG1ijbFUOCCN2M=;
 b=fnRnfbCIrUFBIOK7wOrzcitEmXnCEzhinHFESKc+8QaFnWasY3kX6BERqDTbdHhpYAT3kRKSY
 WNtbqFoIS4FClAwFOYmUTQr8RfSNtsgLGqoxbVfOwVcM9UHyKJ+GRuF
X-Developer-Key: i=aleksa.paunovic@htecgroup.com; a=ed25519;
 pk=gFVSVYLKAgJiS5qCnDyUMGOFuczv8C6o0UmRs+fgisA=
X-Endpoint-Received: by B4 Relay for aleksa.paunovic@htecgroup.com/20250514
 with auth_id=403
X-Original-From: Aleksa Paunovic <aleksa.paunovic@htecgroup.com>
Reply-To: aleksa.paunovic@htecgroup.com

From: Aleksa Paunovic <aleksa.paunovic@htecgroup.com>

Add a new hwprobe key "RISCV_HWPROBE_KEY_VENDOR_EXT_MIPS_0" which allows
userspace to probe for the new xmipsexectl vendor extension.

Signed-off-by: Aleksa Paunovic <aleksa.paunovic@htecgroup.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/include/asm/hwprobe.h                   |  3 ++-
 .../include/asm/vendor_extensions/mips_hwprobe.h   | 22 +++++++++++++++++++++
 arch/riscv/include/uapi/asm/hwprobe.h              |  1 +
 arch/riscv/include/uapi/asm/vendor/mips.h          |  3 +++
 arch/riscv/kernel/sys_hwprobe.c                    |  4 ++++
 arch/riscv/kernel/vendor_extensions/Makefile       |  1 +
 arch/riscv/kernel/vendor_extensions/mips_hwprobe.c | 23 ++++++++++++++++++++++
 7 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/hwprobe.h b/arch/riscv/include/asm/hwprobe.h
index 7fe0a379474ae2c64d300d6fee4a012173f6a6d7..948d2b34e94e84e4c2c351ffe91f4b3afcefc3f7 100644
--- a/arch/riscv/include/asm/hwprobe.h
+++ b/arch/riscv/include/asm/hwprobe.h
@@ -8,7 +8,7 @@
 
 #include <uapi/asm/hwprobe.h>
 
-#define RISCV_HWPROBE_MAX_KEY 13
+#define RISCV_HWPROBE_MAX_KEY 14
 
 static inline bool riscv_hwprobe_key_is_valid(__s64 key)
 {
@@ -22,6 +22,7 @@ static inline bool hwprobe_key_is_bitmask(__s64 key)
 	case RISCV_HWPROBE_KEY_IMA_EXT_0:
 	case RISCV_HWPROBE_KEY_CPUPERF_0:
 	case RISCV_HWPROBE_KEY_VENDOR_EXT_THEAD_0:
+	case RISCV_HWPROBE_KEY_VENDOR_EXT_MIPS_0:
 	case RISCV_HWPROBE_KEY_VENDOR_EXT_SIFIVE_0:
 		return true;
 	}
diff --git a/arch/riscv/include/asm/vendor_extensions/mips_hwprobe.h b/arch/riscv/include/asm/vendor_extensions/mips_hwprobe.h
new file mode 100644
index 0000000000000000000000000000000000000000..e63f664b6b1766e5fc3e68fc696607bcf3e31776
--- /dev/null
+++ b/arch/riscv/include/asm/vendor_extensions/mips_hwprobe.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2025 MIPS.
+ */
+
+#ifndef _ASM_RISCV_VENDOR_EXTENSIONS_MIPS_HWPROBE_H_
+#define _ASM_RISCV_VENDOR_EXTENSIONS_MIPS_HWPROBE_H_
+
+#include <linux/cpumask.h>
+#include <uapi/asm/hwprobe.h>
+
+#ifdef CONFIG_RISCV_ISA_VENDOR_EXT_MIPS
+void hwprobe_isa_vendor_ext_mips_0(struct riscv_hwprobe *pair, const struct cpumask *cpus);
+#else
+static inline void hwprobe_isa_vendor_ext_mips_0(struct riscv_hwprobe *pair,
+						 const struct cpumask *cpus)
+{
+	pair->value = 0;
+}
+#endif
+
+#endif // _ASM_RISCV_VENDOR_EXTENSIONS_MIPS_HWPROBE_H_
diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
index aaf6ad97049931381f9542bb9316c873ec6ab9f6..5d30a4fae37a82ef4d968d20b187420772ad8946 100644
--- a/arch/riscv/include/uapi/asm/hwprobe.h
+++ b/arch/riscv/include/uapi/asm/hwprobe.h
@@ -106,6 +106,7 @@ struct riscv_hwprobe {
 #define RISCV_HWPROBE_KEY_VENDOR_EXT_THEAD_0	11
 #define RISCV_HWPROBE_KEY_ZICBOM_BLOCK_SIZE	12
 #define RISCV_HWPROBE_KEY_VENDOR_EXT_SIFIVE_0	13
+#define RISCV_HWPROBE_KEY_VENDOR_EXT_MIPS_0	14
 /* Increase RISCV_HWPROBE_MAX_KEY when adding items. */
 
 /* Flags */
diff --git a/arch/riscv/include/uapi/asm/vendor/mips.h b/arch/riscv/include/uapi/asm/vendor/mips.h
new file mode 100644
index 0000000000000000000000000000000000000000..11d41651178233a5f06ab9541ea0506d9883aa19
--- /dev/null
+++ b/arch/riscv/include/uapi/asm/vendor/mips.h
@@ -0,0 +1,3 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+
+#define RISCV_HWPROBE_VENDOR_EXT_XMIPSEXECTL	(1 << 0)
diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index 3e9259790816e46092d893df6321deaac3dd9795..000f4451a9d873d5f068986a14615de3a2a5601d 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -15,6 +15,7 @@
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
 #include <asm/vector.h>
+#include <asm/vendor_extensions/mips_hwprobe.h>
 #include <asm/vendor_extensions/sifive_hwprobe.h>
 #include <asm/vendor_extensions/thead_hwprobe.h>
 #include <vdso/vsyscall.h>
@@ -307,6 +308,9 @@ static void hwprobe_one_pair(struct riscv_hwprobe *pair,
 	case RISCV_HWPROBE_KEY_VENDOR_EXT_THEAD_0:
 		hwprobe_isa_vendor_ext_thead_0(pair, cpus);
 		break;
+	case RISCV_HWPROBE_KEY_VENDOR_EXT_MIPS_0:
+		hwprobe_isa_vendor_ext_mips_0(pair, cpus);
+		break;
 
 	/*
 	 * For forward compatibility, unknown keys don't fail the whole
diff --git a/arch/riscv/kernel/vendor_extensions/Makefile b/arch/riscv/kernel/vendor_extensions/Makefile
index ccad4ebafb43412e72e654da3bdb9face53b80c6..bf116c82b6bdb3aee23e27fc0b2a69be7c7a5ccb 100644
--- a/arch/riscv/kernel/vendor_extensions/Makefile
+++ b/arch/riscv/kernel/vendor_extensions/Makefile
@@ -2,6 +2,7 @@
 
 obj-$(CONFIG_RISCV_ISA_VENDOR_EXT_ANDES)	+= andes.o
 obj-$(CONFIG_RISCV_ISA_VENDOR_EXT_MIPS)  	+= mips.o
+obj-$(CONFIG_RISCV_ISA_VENDOR_EXT_MIPS)  	+= mips_hwprobe.o
 obj-$(CONFIG_RISCV_ISA_VENDOR_EXT_SIFIVE)	+= sifive.o
 obj-$(CONFIG_RISCV_ISA_VENDOR_EXT_SIFIVE)	+= sifive_hwprobe.o
 obj-$(CONFIG_RISCV_ISA_VENDOR_EXT_THEAD)	+= thead.o
diff --git a/arch/riscv/kernel/vendor_extensions/mips_hwprobe.c b/arch/riscv/kernel/vendor_extensions/mips_hwprobe.c
new file mode 100644
index 0000000000000000000000000000000000000000..de7aa4a7ff668e18778efcdef77b994178ca85c3
--- /dev/null
+++ b/arch/riscv/kernel/vendor_extensions/mips_hwprobe.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025 MIPS.
+ */
+
+#include <asm/vendor_extensions.h>
+#include <asm/vendor_extensions/mips.h>
+#include <asm/vendor_extensions/mips_hwprobe.h>
+#include <asm/vendor_extensions/vendor_hwprobe.h>
+
+#include <linux/cpumask.h>
+#include <linux/types.h>
+
+#include <uapi/asm/hwprobe.h>
+#include <uapi/asm/vendor/mips.h>
+
+void hwprobe_isa_vendor_ext_mips_0(struct riscv_hwprobe *pair,
+				   const struct cpumask *cpus)
+{
+	VENDOR_EXTENSION_SUPPORTED(
+		pair, cpus, riscv_isa_vendor_ext_list_mips.per_hart_isa_bitmap,
+		{ VENDOR_EXT_KEY(XMIPSEXECTL); });
+}

-- 
2.34.1



