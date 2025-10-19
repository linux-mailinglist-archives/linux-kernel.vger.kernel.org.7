Return-Path: <linux-kernel+bounces-859544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C29FBEDEF0
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 08:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4F6CC4E8DC7
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 06:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C7121FF4A;
	Sun, 19 Oct 2025 06:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Je43SvPS"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C67222584
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 06:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760854622; cv=none; b=gF5N1aP35HsFpuji9r9BUBo80W6zmhOlnTJJ7TIvJbAd2RdiklHkBT5SpvCj0wzT/6HYLVvUYdWqVEodIdpCBHSxMj7MVn8qenD5IT4beYYawqvi5lB7PtoAsmBIdt815MSSOcH+WVTCGmIBYtj7ZXfrZbbTQcndwfvzdgI/tfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760854622; c=relaxed/simple;
	bh=8gSY4OPB3fIJfme7Dcjc1WhgAIFyf2Ln/I5OAXl3i+4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nlkXyW/LEWKjbCw8uYm6pD8DRgYRdiC1WYp6id4+Ho81M+sBJSbIkUZeneQ72P77AJeW/z6l8S8yPvAfpaDip2r/r75IyDtgz4LjLwbphERolOThAegJR+dD9jvea+pgZEDsf9eikmzP86ferYbetaEX2o4Yz00H8WU+WJgOo9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Je43SvPS; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-290d4d421f6so20238175ad.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 23:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760854619; x=1761459419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zvmrmv3hPe2oQTJQT8OKmJhhNCe47YQRwxqYt3ifUEE=;
        b=Je43SvPSmihqDCQJb7wKql6k2u98WCeDYwCer7lEmNba2opn1/2jfaCPt8M16MISGa
         ulDulvxW5Cfoj/Epqdi1o9p8rghsSdSYdsDxI8mPxCZsqMCSMuhaA5kQ6K9eu5KiwClV
         Vb2j/+GVQ5ok4x1xHXr4XCe0HnkCEmCrE0fCAOoxQt8A8UL0POP4+rxrBYICC3OEAvgr
         5cuI3krUrS58LJkMV7cwVVWHKKM4GYfSyv8Tpx79KYnrnTg2A0afngt4jCtAh1T5fQpl
         PO7DrDoANiQfNbgi8Y4cvCG4RK/LOQA0QsroLpDpuLa/rFSU2K1ql9oJxICTP7JgSJBe
         iDCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760854619; x=1761459419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zvmrmv3hPe2oQTJQT8OKmJhhNCe47YQRwxqYt3ifUEE=;
        b=bbkzQprGVK7St2w/9vgrzoaAx5Z8b2IbkKCUBT4U1D1sDsnyzvL8a0DwSSnvYCkSh1
         CbnqIioWO0mWLDMoXRmVscmEjyrbdsTsVT63zfLstnOddfwaYi0PKXpHXAtaJ5FoJoaX
         42hVkJd1ftEGBqY00UkYMgDXGwGl7DvbrIcQS4e/dVRjiYy6Ia0fpQafrPssLy5Q6t0/
         MvkYKbUVDrbL83DdOvIPjJA2ABGwJupXla8ZKXkcrLwgi/radEfxwEum1C2RPRoyNTZB
         M1on9qDzzAVHVn8eGrGJ0StKHC6urqE0yL0/EU/QhrSryTh2a94evkX02Hv2c6LKNKNg
         2x6A==
X-Gm-Message-State: AOJu0Yzg0K0pmZYmrpmnu6BpuLOQSNYqO37U+qj74q4s0FvGLTNIJ6WA
	AxwhBLoBioSxelWXTJWxsaUB/HZk7diE7n/r9YIse0+VaMomM5DBTJzQXr3oCQ==
X-Gm-Gg: ASbGnct0AuiLvKcafC9c30VezjKFZPIoAInijlV8KohUZcwF4HqRxJKrlfzcmQbfbwN
	emNiWtLxRkn+BKF/KVmXvXeDNJkuTPqJf2M5eIphgQnJc+bg+fQgetjSzybu0b1mKQRhQ59DQG7
	LaQNDOEpcBF0xKUWxK0MYKAHzzt/JXfM0hAFVAtDktDJMos+ncolgBiQvCmEM5L2UsW+GHjms0K
	e0OuG6OqYLS84pRVDXHr3JhpMjtZkOFs4ziYnzg7Wqzd8GJa3hCeZA+X0xBtAoNRIFkb8IVTGXT
	eRAdtln7Iduzlb8cx4SEGOxaK+B5TmUAa9bH+nUZCEI6LoDQsHFk7F2uNUbZuCOw9Pc3fum0xaQ
	lpYWaAzMctzz/G5oS492K4rqXv7l4Kv7GupHq3DG466jo5gJUEDgbIwFi6XDB0x4Agme3ZU5WST
	otzBp357w3eub9xOo=
X-Google-Smtp-Source: AGHT+IGr/O8zk+3lAXEyhTOS21GeRIQ7WsMW/dXKVowLJ0bFIrZpOFcNFSeyeDuMLrkyPKnaIvg3BA==
X-Received: by 2002:a17:903:298c:b0:27e:eabd:4b41 with SMTP id d9443c01a7336-290c9c89eabmr108602405ad.7.1760854618954;
        Sat, 18 Oct 2025 23:16:58 -0700 (PDT)
Received: from pop-os.. ([2601:647:6881:9060:bc87:d8fe:3e55:7ffb])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76b6f302sm4332032a12.38.2025.10.18.23.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 23:16:58 -0700 (PDT)
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
Subject: [RFC Patch v2 05/16] x86: Introduce arch_cpu_physical_id() to obtain physical CPU ID
Date: Sat, 18 Oct 2025 23:16:19 -0700
Message-Id: <20251019061631.2235405-6-xiyou.wangcong@gmail.com>
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

The tranditional smp_processor_id() is a software-defined CPU ID which
is only unique within the same kernel. With Multikernel architecture, we
run multiple Linux kernels on different CPU's, hence the host kernel
needs a globally unique CPU ID to manage the CPU's. The physical CPU ID
is perfect for this case.

This API will be used to globally distinguish CPU's among different
multikernels.

Signed-off-by: Cong Wang <cwang@multikernel.io>
---
 arch/x86/include/asm/smp.h | 6 ++++++
 arch/x86/kernel/smp.c      | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index 1a59fd0de759..378be65ceafa 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -40,6 +40,7 @@ struct smp_ops {
 
 	void (*send_call_func_ipi)(const struct cpumask *mask);
 	void (*send_call_func_single_ipi)(int cpu);
+	int (*cpu_physical_id)(int cpu);
 };
 
 /* Globals due to paravirt */
@@ -100,6 +101,11 @@ static inline void arch_send_call_function_ipi_mask(const struct cpumask *mask)
 	smp_ops.send_call_func_ipi(mask);
 }
 
+static inline int arch_cpu_physical_id(int cpu)
+{
+	return smp_ops.cpu_physical_id(cpu);
+}
+
 void cpu_disable_common(void);
 void native_smp_prepare_boot_cpu(void);
 void smp_prepare_cpus_common(void);
diff --git a/arch/x86/kernel/smp.c b/arch/x86/kernel/smp.c
index 59658fcd9037..e2eba09da7fc 100644
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -288,6 +288,11 @@ static int __init nonmi_ipi_setup(char *str)
 
 __setup("nonmi_ipi", nonmi_ipi_setup);
 
+static int native_cpu_physical_id(int cpu)
+{
+	return cpu_physical_id(cpu);
+}
+
 struct smp_ops smp_ops = {
 	.smp_prepare_boot_cpu	= native_smp_prepare_boot_cpu,
 	.smp_prepare_cpus	= native_smp_prepare_cpus,
@@ -305,6 +310,7 @@ struct smp_ops smp_ops = {
 
 	.send_call_func_ipi	= native_send_call_func_ipi,
 	.send_call_func_single_ipi = native_send_call_func_single_ipi,
+	.cpu_physical_id	= native_cpu_physical_id,
 };
 EXPORT_SYMBOL_GPL(smp_ops);
 
-- 
2.34.1


