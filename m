Return-Path: <linux-kernel+bounces-823704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92EC5B8739E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 00:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95CA91C27F11
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 22:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5BB331A804;
	Thu, 18 Sep 2025 22:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZjp53pp"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E5D313290
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 22:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758234391; cv=none; b=k4Mku+G/zG2OuXNcyWrcopm+HRMT/a36dekFyfvi8HxOt9GBovuGk7tpD9nnLnh3Tl5TFW21HdvoumEM56xZRazGQ+Ca2hxIqThlBhaMVXzUDqsmIrVyXEtZOADq1sgKnCASAY5n2Ac9IGYOaumKV0FyNojeDKTGSmqZBoxfAC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758234391; c=relaxed/simple;
	bh=XZ1DoEgvqQUQR498R4YYqLRTrrOnCDYL9OikAtCa8cU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qTOL4QrD3d9k/O0wnxExm13LxhXkJBvrAkqLoGAAhOZo2pfQ8nHaUAINRB806sw7sMzdzOdcoq6gVOBsMh8rkGPXmJIRn+Cps0X6d8ERjWrWo0/mfqis2vnRe5et4R0E7hvPU6Sqp9RV/L0B15xHo7eGIu+Z7WYJhcsGr3afANA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iZjp53pp; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7761a8a1dbcso1458941b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 15:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758234389; x=1758839189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7tZ1awk6SoUQIOVQF3O5Wg32Zi3pcSNXGfmdT++muNE=;
        b=iZjp53ppjwbF1k/BvAVdcMIcpyzF4hfsESk6wixZcgZzcXuLvNeBvOGXPzE/UBMt0c
         WE2EWBO/pDi+KViqvYrdsG14FJP3ZzTlmKJZjoRrEj1FHPks95kU27BD84+zOzgPigaG
         6AGgLxs3rkEiqbIe552qhPsT4vyVLLgqL0UEVimQ9jAK753UyXWmjVyk/GirP+xiCwH1
         s5d0QCTOBoTpEirXK78FoUTXzizx4mZSgbk9GcpdGOuA3sSF7rIav8A+t5UIW4qSNltv
         pCASRMpkmS85KB5pxOlVaW8pMQGk/44m4Zf3PaCwnvIi66dHEvzG2ckOhdjvkpJTsu6c
         z0FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758234389; x=1758839189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7tZ1awk6SoUQIOVQF3O5Wg32Zi3pcSNXGfmdT++muNE=;
        b=FBBxg1z+iLS3bXiaiifCbTq8L2pwlouIEioOJlmvpekjFSTqrbK3grpEDn3dT7yA7V
         fJ2uavdgOrysouQSM4mkS3ltArF5SnQaVWJALGhz+lA74eJT+QRvx8RJjSlimLWAU7VG
         vTpqKTfKHBY7GursbHdRtAvvrSdSZYSiI5KyiQZ94fikV1f/QE4+/QYK52L5kDkhskgF
         2WTppxraIdAZbECR6ZNwh9/yLLTsJpfs40gZE6OfWQhiJh9FXuJgpGxgDHFD4NKdoZj/
         9erkbSB3vIer1VYGMy6YgKpj+0pY/MGG4912IlvNYhnz9oBXunQpU3+UscgDIMEpQc6g
         wGeQ==
X-Gm-Message-State: AOJu0Yy6k+WAcRfcntm8RwuSdGDhZrW2SDGhTuNp7gFc9kZzImXt/qqL
	oQRDBlNoU5J8nnAFQx8ASFCOHZOPrmBTt8noNJoR0SEY5W0lr36770zyuWDmmA==
X-Gm-Gg: ASbGnctpR9/QbRXZtj3ah+9AD1zy7ME3r4LmyA5niNoiBcBRcth4LmPZ5pvQjJuk8t+
	3Bwyhv5H6tDTgHZiB9xReBuleMGtvbFLGmVPjVBX/h7kZOqsbXEcgutpTxhc2jo7n5i9To6AQus
	7LUre5pQ0EGlgUOM8tunLubWbdUdEEPGOS5TZEz0835e1sPypKS40g4I8eIzdXhhI+7ODi/neOB
	INXYe3I8+RUCd4RVBwnjfxfqE4aaHVDTKQEYD2pUBjZTzIxMPHU/I8+j7/M9uq33URXKu0ZPkh5
	xZOWB/rLEN0pmrGNBStFDje6m1FD4RtH0103NC+9jI+W3LZjaxr0bXY68xZQfxqmPDbfBSJNhQ3
	B60sN8YvxNmllBtNlMJh49J4rROTqKUbCPt52b7n76xdsJTI=
X-Google-Smtp-Source: AGHT+IEWFbh2aOOMKw7ejiTJRJw8lOcG5jy15DL2xMCbkrQw2DZczjpxb6lHP6fuCOtxt7Ts0n9cBA==
X-Received: by 2002:a05:6a00:1250:b0:77d:6a00:1cd1 with SMTP id d2e1a72fcca58-77e4d031e97mr1237987b3a.12.1758234389331;
        Thu, 18 Sep 2025 15:26:29 -0700 (PDT)
Received: from pop-os.. ([2601:647:6881:9060:c5c1:2e33:6cf2:beed])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77e5fe6de75sm407542b3a.19.2025.09.18.15.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 15:26:28 -0700 (PDT)
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
Subject: [RFC Patch 5/7] x86: Introduce arch_cpu_physical_id() to obtain physical CPU ID
Date: Thu, 18 Sep 2025 15:26:04 -0700
Message-Id: <20250918222607.186488-6-xiyou.wangcong@gmail.com>
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
 kernel/multikernel.c       | 9 +++++----
 3 files changed, 17 insertions(+), 4 deletions(-)

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
index 3ee515e32383..face9f80e05c 100644
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -289,6 +289,11 @@ static int __init nonmi_ipi_setup(char *str)
 
 __setup("nonmi_ipi", nonmi_ipi_setup);
 
+static int native_cpu_physical_id(int cpu)
+{
+	return cpu_physical_id(cpu);
+}
+
 struct smp_ops smp_ops = {
 	.smp_prepare_boot_cpu	= native_smp_prepare_boot_cpu,
 	.smp_prepare_cpus	= native_smp_prepare_cpus,
@@ -306,6 +311,7 @@ struct smp_ops smp_ops = {
 
 	.send_call_func_ipi	= native_send_call_func_ipi,
 	.send_call_func_single_ipi = native_send_call_func_single_ipi,
+	.cpu_physical_id	= native_cpu_physical_id,
 };
 EXPORT_SYMBOL_GPL(smp_ops);
 
diff --git a/kernel/multikernel.c b/kernel/multikernel.c
index 74e2f84b7914..7f6f90485876 100644
--- a/kernel/multikernel.c
+++ b/kernel/multikernel.c
@@ -150,7 +150,7 @@ int multikernel_send_ipi_data(int cpu, void *data, size_t data_size, unsigned lo
 
 	/* Set header information */
 	target->data_size = data_size;
-	target->sender_cpu = smp_processor_id();
+	target->sender_cpu = arch_cpu_physical_id(smp_processor_id());
 	target->type = type;
 
 	/* Copy the actual data into the buffer */
@@ -175,6 +175,7 @@ static void multikernel_interrupt_handler(void)
 	struct mk_ipi_data *data;
 	struct mk_ipi_handler *handler;
 	int current_cpu = smp_processor_id();
+	int current_physical_id = arch_cpu_physical_id(current_cpu);
 
 	/* Ensure shared memory is initialized */
 	if (!mk_shared_mem) {
@@ -183,10 +184,10 @@ static void multikernel_interrupt_handler(void)
 	}
 
 	/* Get this CPU's data area from shared memory */
-	data = &mk_shared_mem->cpu_data[current_cpu];
+	data = &mk_shared_mem->cpu_data[current_physical_id];
 
-	pr_debug("Multikernel IPI received on CPU %d from CPU %d, type=%u\n",
-		 current_cpu, data->sender_cpu, data->type);
+	pr_info("Multikernel IPI received on CPU %d (physical id %d) from CPU %d type=%u\n",
+		 current_cpu, current_physical_id, data->sender_cpu, data->type);
 
     raw_spin_lock(&mk_handlers_lock);
     for (handler = mk_handlers; handler; handler = handler->next) {
-- 
2.34.1


