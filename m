Return-Path: <linux-kernel+bounces-823062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A87F7B856A4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8D9F64E33D3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08815AD23;
	Thu, 18 Sep 2025 15:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V4yV3ogY"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A376B22D4DD
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 15:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758207669; cv=none; b=vE4j+UgTqwKnBA4vPePaVbPJUAFV6D55Chyl+iLa6RiSRsCAnFGsqw+sr4TThiuzSf7/Y/JGvl0Ug4q+QxLzaCU1Zb+JHQ/WvKiZqRTWIMa/9qlK+/yZgnFf9vxMMlQHXz7puMD98oxL4HqNpMhUb5HXRlO+egl96CQT0Z8ZdlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758207669; c=relaxed/simple;
	bh=BomCHCyONkZvBHRX7fF/vadDHImLxvWcM85cE0w357Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ERDspn9HBirJ5dNKdrmtj3DC8RIE6h3nXPg11zplX7BSUZ+KGCpdOhVTDNnCzB8OPrH2b4M04eEE9RRP992OB7dvK+dMGE6/aUbJmixUEJFkzEs7wqzntmppsRx707+lGjWWl0jWcVkWQzLHrnkZRA24fNYxx+s1uKY7gUPCDO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V4yV3ogY; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7761b83fd01so1106273b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 08:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758207667; x=1758812467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DenQSoys7kFN1y2c+XZsOBbsB+gNsAG+pNB/ZQfFlnk=;
        b=V4yV3ogYSdOIJqwLNPxarnD0xpA1bdYwMk6kmWOGiKzYFXd6GGBTZy5ua+M2aoTJyZ
         XFOJLo6/WkBANTEMuWqUmssFqulrsIEZ10K6YxRRxYnKHr5RnTY++eIJdc/UQQXHAwFI
         QZdL1lTrDUd/CPWDIJEmzumqeKMEua5g31qCUpBZ2pcugQGTi/TWZL/ddv8rthnONgLq
         ECWxntgKvdPXZfxNrboHQpVjb0XRn4AsJmlnN73RouPEvdFy7qmTpDJ5lMoeGmZNWLSQ
         pZbeNALOLht/z9c8QEjv4UJKoIhqQ0cPdQF/WQUz15TqyqX6vJ3RiuB4HZ79hoIm3/Dm
         onEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758207667; x=1758812467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DenQSoys7kFN1y2c+XZsOBbsB+gNsAG+pNB/ZQfFlnk=;
        b=b5Tj4jD9ZrWqgFV+e2ydP1gLXpfs2WjXOEDyWtEHAo2YdUXNw2QA4lPPa9PIM+lpMb
         EwBlFuzfrEoOlBTmslcfzltscWOoAjLQYjqpafZ/vxRXoWHTf/hNC54BwO50IKLz9fKd
         uDGnNdKKcY0NGu4G5+VxTuDqbCGxShu2ML5bI4V1BWQNuLA1Nxwi4xg8AqxCtj7y70fg
         3wOit74GVPSznQReEgQmRo8rrOkPR12iaiZ/MKRn8hsLwbp4He43a8pVhVcoFlyYJYI4
         3AqbUCFTyxKfZEou9erKkheHiwMoKnXS6Ul9oC+cLsTLVAkC2CSDJVgPtlpe0DzOCgk/
         SF1g==
X-Forwarded-Encrypted: i=1; AJvYcCVwY5KQyyVjVTwJCVOvVpyMR5JmjywoftVsliiyaX602zrhb+mDBYNXSgI/hFLuzFlvCw78OtMBgl/vX/A=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd4zdpAxEu0qGB2q9qyoWLTqmGSEIDqELqrMiBR2xXjjSFoB/5
	dFQcjNXaZ6glWuFtDM5SU9bhb0TT8WsCDGfoP6KoRbkyYd/URRyNircg
X-Gm-Gg: ASbGncvSxGKt9SHu6S9vWRicXORZoOlW0RDHpYmDjFAOEQ+laPp56ko36SE5XqdyB93
	gcvh9ViqRQ6naId3IYrzohx1v3WCXQr1g6oK/CvPENSyWS1UWZSy6BVT9bAA758nCMhYO6CBkDJ
	zp0v7WcrA5Ys7mXQt86sVoTS2UWUQ4ReTGSQUna2mmkz+EHbww8a54HPSQsVSSvWVKoIop4m+23
	Uj33PAjZv+2kRAMIc4CMYcrdeeS5iax6oqVXK7KkBKrWecX3bsht0unXdU5SpU1KPtuCH7GvZFn
	W/FGzVpRwEgpEc2e/ugqI8RDI1MtFIjFD55Oo7QIYctJX8qneB+ip1I9jrk+5qIWsRTRc8DNQA4
	wY/NZ1Hv1ySdHRqxOQHEbf6tDQBeDfxWk1DsrRaAqG/gPZRdB+WZW4aBFRona9LKkkXAg0xrBhE
	TW
X-Google-Smtp-Source: AGHT+IE54DeGcjfuPrZxTsO8vNoW4uR5ohID4013e2OR7rn5+mNz+y3PAtrWVyE5FJja8m2BaQ/5oA==
X-Received: by 2002:a17:902:d2ca:b0:264:5c06:4d7b with SMTP id d9443c01a7336-26813903208mr75482905ad.32.1758207666525;
        Thu, 18 Sep 2025 08:01:06 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.mshome.net ([70.37.26.59])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980302b20sm28425005ad.101.2025.09.18.08.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 08:01:05 -0700 (PDT)
From: Tianyu Lan <ltykernel@gmail.com>
X-Google-Original-From: Tianyu Lan <tiala@microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	arnd@arndb.de,
	Neeraj.Upadhyay@amd.com,
	tiala@microsoft.com,
	kvijayab@amd.com,
	romank@linux.microsoft.com
Cc: linux-arch@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Kelley <mhklinux@outlook.com>
Subject: [PATCH 2/5] drivers: hv: Allow vmbus message synic interrupt injected from Hyper-V
Date: Thu, 18 Sep 2025 11:00:20 -0400
Message-Id: <20250918150023.474021-3-tiala@microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250918150023.474021-1-tiala@microsoft.com>
References: <20250918150023.474021-1-tiala@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When Secure AVIC is enabled, VMBus driver should
call x2apic Secure AVIC interface to allow Hyper-V
to inject VMBus message interrupt.

Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Reviewed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
 arch/x86/hyperv/hv_apic.c      | 5 +++++
 drivers/hv/hv.c                | 2 ++
 drivers/hv/hv_common.c         | 5 +++++
 include/asm-generic/mshyperv.h | 1 +
 4 files changed, 13 insertions(+)

diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
index e669053b637d..a8de503def37 100644
--- a/arch/x86/hyperv/hv_apic.c
+++ b/arch/x86/hyperv/hv_apic.c
@@ -53,6 +53,11 @@ static void hv_apic_icr_write(u32 low, u32 id)
 	wrmsrq(HV_X64_MSR_ICR, reg_val);
 }
 
+void hv_enable_coco_interrupt(unsigned int cpu, unsigned int vector, bool set)
+{
+	apic_update_vector(cpu, vector, set);
+}
+
 static u32 hv_apic_read(u32 reg)
 {
 	u32 reg_val, hi;
diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index b14c5f9e0ef2..ec5d10839e0f 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -307,6 +307,7 @@ void hv_synic_enable_regs(unsigned int cpu)
 	}
 
 	hv_set_msr(HV_MSR_SIEFP, siefp.as_uint64);
+	hv_enable_coco_interrupt(cpu, vmbus_interrupt, true);
 
 	/* Setup the shared SINT. */
 	if (vmbus_irq != -1)
@@ -350,6 +351,7 @@ void hv_synic_disable_regs(unsigned int cpu)
 	/* Need to correctly cleanup in the case of SMP!!! */
 	/* Disable the interrupt */
 	hv_set_msr(HV_MSR_SINT0 + VMBUS_MESSAGE_SINT, shared_sint.as_uint64);
+	hv_enable_coco_interrupt(cpu, vmbus_interrupt, false);
 
 	simp.as_uint64 = hv_get_msr(HV_MSR_SIMP);
 	/*
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 49898d10faff..0f024ab3d360 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -716,6 +716,11 @@ u64 __weak hv_tdx_hypercall(u64 control, u64 param1, u64 param2)
 }
 EXPORT_SYMBOL_GPL(hv_tdx_hypercall);
 
+void __weak hv_enable_coco_interrupt(unsigned int cpu, unsigned int vector, bool set)
+{
+}
+EXPORT_SYMBOL_GPL(hv_enable_coco_interrupt);
+
 void hv_identify_partition_type(void)
 {
 	/* Assume guest role */
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index a729b77983fa..7907c9878369 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -333,6 +333,7 @@ bool hv_is_isolation_supported(void);
 bool hv_isolation_type_snp(void);
 u64 hv_ghcb_hypercall(u64 control, void *input, void *output, u32 input_size);
 u64 hv_tdx_hypercall(u64 control, u64 param1, u64 param2);
+void hv_enable_coco_interrupt(unsigned int cpu, unsigned int vector, bool set);
 void hyperv_cleanup(void);
 bool hv_query_ext_cap(u64 cap_query);
 void hv_setup_dma_ops(struct device *dev, bool coherent);
-- 
2.25.1


