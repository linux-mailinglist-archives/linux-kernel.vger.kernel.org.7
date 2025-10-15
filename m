Return-Path: <linux-kernel+bounces-853827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0C6BDCAFC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 08:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68F3719A6508
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 06:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05D530FC0C;
	Wed, 15 Oct 2025 06:19:47 +0000 (UTC)
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E8630F7E0
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 06:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760509183; cv=none; b=kv6PtFuHMAY2gmE31HE014YUeuvpQRBNiLPccCMcIHdOBCIjq6rctkD+6udYAuD/6WQD+ObTE/HsVz+pSdAJoNmgaD5CDuYrF34NT4nVyY5MniElGXL07drVxZj2w6BSMngh15jE0AcmmRJw/DUHul4XTOhnvXRlE9hDXgZm3CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760509183; c=relaxed/simple;
	bh=mxpuMiUTRYCSgSeahpphZP0KRUV5gJ7/k69WdZ4eDk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dJPuOUEkTqwjVIhoJvCKXSPOr4hEtYj1MFJalzmFC+SgVxmM29rBcn1DFeyXH2HPAT44npCZpwwEFWqf6q1wbQP1LAb9tj46z88uKTCG/dIRtRdEnYJdiurFoKO9ISCoycJo524VKJOM7We8moXIs+z/oZN7ahNqfhCnB8NC1Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tinylab.org; spf=pass smtp.mailfrom=tinylab.org; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tinylab.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tinylab.org
X-QQ-mid: zesmtpsz6t1760509173te78262a4
X-QQ-Originating-IP: u3H1w+MhVp5h6FxUuPEeE01YpOSGlM/XWUOC3g4qmu4=
Received: from GPU-Server-A6000.. ( [202.201.1.132])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 15 Oct 2025 14:19:29 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16704342638795234820
EX-QQ-RecipientCnt: 14
From: Yuan Tan <tanyuan@tinylab.org>
To: arnd@arndb.de,
	masahiroy@kernel.org,
	nathan@kernel.org,
	palmer@dabbelt.com,
	linux-kbuild@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	i@maskray.me,
	tanyuan@tinylab.org,
	falcon@tinylab.org,
	ronbogo@outlook.com,
	z1652074432@gmail.com,
	lx24@stu.ynu.edu.cn
Subject: [PATCH v2 6/8] compiler.h: introduce PUSHSECTION macro to establish proper references
Date: Wed, 15 Oct 2025 14:19:20 +0800
Message-ID: <40854460DE090346+c30007da67d26ae0e8651732f32a8ede4926db14.1760463245.git.tanyuan@tinylab.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1760463245.git.tanyuan@tinylab.org>
References: <cover.1760463245.git.tanyuan@tinylab.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: MIAHdi1iQo+zb/iDccdWUpVB7EbuHr3toOuW65BieR63dUem0CUKS9LM
	QAkJY+VfeKT72HzXNHbBZuruwtBvgp/Y2ZXHpWkSFcBT8kDJRuZL/hoh3UMdwVKjDc0oL5i
	aeuXp6FJrRWicNDESHueSz/xwK/lkRBzw0vJm0d9NxHSvM2JHGKOj1qOTRHz1Bq6kidP236
	J4QKaf1GsOjchGl86QIgk5JUjqXor1UkVbdKuKPaSiwSow6Hsmk1ocAyFtxSsErJnQolT07
	8ajT/xUARChBkiL3HcaHhDOKr1z0NPXp87VCPmODKI8OmcOqaoyZd8epl90a9G33W2Anbpg
	FmiTyFO+rJ4qy6gXXqc94EVkNrtv+XoOOIC3wWVVtaQoeBylkRHJuuMJjz6KpTZosgLQ5GS
	3M53+AkUbvSzFq6sSFlVRAPkc/J0+YmQusZ8X6asSUoRc+4V1/+tJDEZfXhBJUxO+CyqnxR
	F7QUtPaz/W5X1tZ3eaFMlDhbMZaW5qoQi6bW6SwVhpuO4dZyk8Z5KEtn1P6U/9p5KHVbLnp
	OPoBCTvF0Eu0Qo9ce6VhDuRYQ3wggDdxuBolc/JZ68RQ8KlxngyPOGLOQO4XpUcoq/UZSy6
	zeFsLmqulkmTq9SWcvkpDTm9a2LBjSKdFkQUgBYYy35fgYUSgV9clMviPkJ4I7ZQOcreQc9
	vh22jVPAvpcobp4r68WFvgeP47i4O6qjocOHGOjGdanhD5KH5gAE64cjUrHb6+92J6PicZN
	hbgVPJL4gvQNDpgxZUAiiUCyOvxrMLsE2iKrtEUB7jN2qYA8rV4ddfTl/qnynf1EeSrnCMe
	ryeVSgR7932pJZde+irVR47gx0ZOhVEmJWTpb2k/nb4xBBy8yIJ/HG7gaESSieHUt+xbWrM
	XT5srw9uHmXuzXlWH1hcTr6o292EF/5IaTlRAafSt8hp2371V54IbN9ViqkeO4e6gKmYWyh
	+3HkCkSXxaXarUg8AmX3OFzq5RWarBpODSTgwRb4lKwXZQpCxrhULr+NJyuNckQp2kObN1E
	v07y6OSu/F/YooPhWU
X-QQ-XMRINFO: M8wFrcb6n6Ii4I6kYxweyY8=
X-QQ-RECHKSPAM: 0

When a section is created by .pushsection in assembly, there is no
reference between the caller function and the newly created section. As a
result, --gc-sections may incorrectly discard the newly created section.

To prevent such incorrect garbage collection, kernel code often wraps these
sections with KEEP() in linker scripts. While this guarantees that the
sections are retained, it introduces a dependency inversion: unused
sections are kept unnecessarily, and any sections they reference are also
forcibly retained. This prevents the linker from eliminating truly unused
code or data.

Introduce a new PUSHSECTION macro in include/linux/compiler.h to create a
proper reference between the .pushsection caller and the generated section.
The macro is fully compatible with all existing .pushsection parameters and
has no side effects, making it safe to replace all current .pushsection
usages with this version.

PUSHSECTION works by emitting a unique label inside the new section, and
adding a relocation from the caller function to that label. This ensures
the linker recognizes the dependency and keeps both sections alive
together. So we don't need to wrap the section with KEEP() in linker
anymore.

To guarantee uniqueness of the section and label names, both __COUNTER__
and %= are used:
Either alone is insufficient:
  - __COUNTER__ alone fails when the function containing PUSHSECTION is
    inlined multiple times, causing duplicate labels.
  - %= alone fails when multiple PUSHSECTION directives appear within a
    single inline assembly block.

In assembly code, a separate definition is provided because the C macro
cannot ensure unique section/label names when expanded inside an assembler
macro (.macro).

Signed-off-by: Yuan Tan <tanyuan@tinylab.org>
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
Signed-off-by: Xiao Liu <lx24@stu.ynu.edu.cn>
Signed-off-by: Peihan Liu <ronbogo@outlook.com>
---
 include/linux/compiler.h | 43 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 5b45ea7dff3e..bba79cedbe24 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -3,6 +3,7 @@
 #define __LINUX_COMPILER_H
 
 #include <linux/compiler_types.h>
+#include <linux/stringify.h>
 
 #ifndef __ASSEMBLY__
 
@@ -267,7 +268,47 @@ static inline void *offset_to_ptr(const int *off)
 	return (void *)((unsigned long)off + *off);
 }
 
-#endif /* __ASSEMBLY__ */
+#ifdef CONFIG_PUSHSECTION_WITH_RELOC
+#define __PUSHSECTION_RELOC(lbl) ".reloc ., BFD_RELOC_NONE, " lbl "\n\t"
+#define __PUSHSECTION_HELPER(prefix) __stringify(prefix.%=) "_" __stringify(__COUNTER__)
+#define __PUSHSECTION_LABEL(lbl) lbl ":\n\t"
+#else
+#define __PUSHSECTION_RELOC(lbl)
+#define __PUSHSECTION_HELPER(prefix) __stringify(prefix)
+#define __PUSHSECTION_LABEL(lbl)
+#endif
+
+#define _PUSHSECTION(lbl, sec, ...)					\
+	__PUSHSECTION_RELOC(lbl)					\
+	".pushsection " sec ", " #__VA_ARGS__ "\n\t" __PUSHSECTION_LABEL(lbl)
+
+#define PUSHSECTION(sec, ...)						\
+	_PUSHSECTION(__PUSHSECTION_HELPER(.Lsec), __PUSHSECTION_HELPER(sec), __VA_ARGS__)
+
+#else /* __ASSEMBLY__ */
+
+#ifdef CONFIG_PUSHSECTION_WITH_RELOC
+#define __PUSHSECTION_RELOC .reloc ., BFD_RELOC_NONE, \label
+#define __PUSHSECTION_HELPER(prefix) prefix\().\@
+#define __PUSHSECTION_LABEL \label:
+#else
+#define __PUSHSECTION_RELOC
+#define __PUSHSECTION_HELPER(prefix) prefix
+#define __PUSHSECTION_LABEL
+#endif
+
+.macro  _PUSHSECTION label:req, section:req, args:vararg
+	__PUSHSECTION_RELOC
+	.pushsection __PUSHSECTION_HELPER(\section), \args
+	__PUSHSECTION_LABEL
+.endm
+
+.macro  PUSHSECTION section:req, args:vararg
+	_PUSHSECTION .Lsec\@, \section, \args
+.endm
+
+#endif /* !__ASSEMBLY__ */
+
 
 #ifdef CONFIG_64BIT
 #define ARCH_SEL(a,b) a
-- 
2.43.0


