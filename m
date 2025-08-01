Return-Path: <linux-kernel+bounces-753048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 868B7B17E1E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 10:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED01D1C24D72
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 08:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DBBB21B185;
	Fri,  1 Aug 2025 08:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KQLhEs8W"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685DB1F4180
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 08:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754036424; cv=none; b=UZ/FH0tFsbcXc064YA6uhXwtq0Ub4omBZCMSkkZpzlgJmgm7Aoymr2AfB92WmdUL2YwW6K8oAGRaJ0NZzmGybouwEjIB6W5/qdZrXpUo32phCc3EK0CoIIRptQQCjINk9Nn55Q6Npjzqmf3quxXP3jI9jdiAnW5m637/JALg3m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754036424; c=relaxed/simple;
	bh=28rTm7elf5I3iI5sfkXLtcHE/JFVyjsRw745ajixTAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MybZbSvRtG5TfSbVZ28l9cYRmS744Me4qdWi+Rraf8YLBRaM355dpEPbJgXQHRsa6Kc5bXkFBmZIdbXEG4CYMh0dNVoAUOQUb3Upqu6BaEJFjmtDSYGT6bpP0ILMBzJWxWq21k81pRz37oJVmQwQwhvzlEUiO9z0fxI2Kfq+zF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KQLhEs8W; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754036420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gWQhtP12MeNr0dILWoc51TUT95//3bChXiCig9X7yoU=;
	b=KQLhEs8WvXr00lQ0b+TxP2tI16/crASGfvnySjJEyvfB9PdMHhDemdaPUbE3h4eOrb2yC3
	ehumlPzQPImKs7/PLoNvZxbYyd3nT9I+5Z13vhXXWdbsonJl9asgbuVKhOjgJrhVdZCEGh
	EpLj4ykcm71GzAiqK7JcpAtHH10jClY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-445-L7fWMev8NVWa3QSMQ-0ZXA-1; Fri,
 01 Aug 2025 04:20:17 -0400
X-MC-Unique: L7fWMev8NVWa3QSMQ-0ZXA-1
X-Mimecast-MFC-AGG-ID: L7fWMev8NVWa3QSMQ-0ZXA_1754036416
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B4C841956089;
	Fri,  1 Aug 2025 08:20:15 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.225.137])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 419791800D8D;
	Fri,  1 Aug 2025 08:20:12 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: linuxppc-dev@lists.ozlabs.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] powerpc: Replace __ASSEMBLY__ with __ASSEMBLER__ in uapi headers
Date: Fri,  1 Aug 2025 10:20:06 +0200
Message-ID: <20250801082007.32904-2-thuth@redhat.com>
In-Reply-To: <20250801082007.32904-1-thuth@redhat.com>
References: <20250801082007.32904-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

From: Thomas Huth <thuth@redhat.com>

__ASSEMBLY__ is only defined by the Makefile of the kernel, so
this is not really useful for uapi headers (unless the userspace
Makefile defines it, too). Let's switch to __ASSEMBLER__ which
gets set automatically by the compiler when compiling assembler
code.

This is a completely mechanical patch (done with a simple "sed -i"
statement).

Acked-by: Segher Boessenkool <segher@kernel.crashing.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 arch/powerpc/include/uapi/asm/opal-prd.h |  4 ++--
 arch/powerpc/include/uapi/asm/ptrace.h   | 12 ++++++------
 arch/powerpc/include/uapi/asm/types.h    |  4 ++--
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/uapi/asm/opal-prd.h b/arch/powerpc/include/uapi/asm/opal-prd.h
index 1869cf83a870e..11abcf0192ca1 100644
--- a/arch/powerpc/include/uapi/asm/opal-prd.h
+++ b/arch/powerpc/include/uapi/asm/opal-prd.h
@@ -40,7 +40,7 @@
 #define OPAL_PRD_SCOM_READ		_IOR('o', 0x02, struct opal_prd_scom)
 #define OPAL_PRD_SCOM_WRITE		_IOW('o', 0x03, struct opal_prd_scom)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 struct opal_prd_info {
 	__u64	version;
@@ -54,6 +54,6 @@ struct opal_prd_scom {
 	__s64	rc;
 };
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _UAPI_ASM_POWERPC_OPAL_PRD_H */
diff --git a/arch/powerpc/include/uapi/asm/ptrace.h b/arch/powerpc/include/uapi/asm/ptrace.h
index 7004cfea3f5ff..01e630149d48e 100644
--- a/arch/powerpc/include/uapi/asm/ptrace.h
+++ b/arch/powerpc/include/uapi/asm/ptrace.h
@@ -27,7 +27,7 @@
 
 #include <linux/types.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #ifdef __KERNEL__
 struct user_pt_regs
@@ -57,7 +57,7 @@ struct pt_regs
 	unsigned long result;		/* Result of a system call */
 };
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 
 /*
@@ -200,7 +200,7 @@ struct pt_regs
 #define PPC_PTRACE_SETHWDEBUG	0x88
 #define PPC_PTRACE_DELHWDEBUG	0x87
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 struct ppc_debug_info {
 	__u32 version;			/* Only version 1 exists to date */
@@ -212,7 +212,7 @@ struct ppc_debug_info {
 	__u64 features;
 };
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 /*
  * features will have bits indication whether there is support for:
@@ -224,7 +224,7 @@ struct ppc_debug_info {
 #define PPC_DEBUG_FEATURE_DATA_BP_DAWR		0x0000000000000010
 #define PPC_DEBUG_FEATURE_DATA_BP_ARCH_31	0x0000000000000020
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 struct ppc_hw_breakpoint {
 	__u32 version;		/* currently, version must be 1 */
@@ -236,7 +236,7 @@ struct ppc_hw_breakpoint {
 	__u64 condition_value;	/* contents of the DVC register */
 };
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 /*
  * Trigger Type
diff --git a/arch/powerpc/include/uapi/asm/types.h b/arch/powerpc/include/uapi/asm/types.h
index 327616fb70e44..9dbf55e38ea58 100644
--- a/arch/powerpc/include/uapi/asm/types.h
+++ b/arch/powerpc/include/uapi/asm/types.h
@@ -28,14 +28,14 @@
 # include <asm-generic/int-ll64.h>
 #endif
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 
 typedef struct {
 	__u32 u[4];
 } __attribute__((aligned(16))) __vector128;
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 
 #endif /* _UAPI_ASM_POWERPC_TYPES_H */
-- 
2.50.1


