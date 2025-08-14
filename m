Return-Path: <linux-kernel+bounces-769243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D74B26BDA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 18:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BCC6AC15A0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D9125291F;
	Thu, 14 Aug 2025 15:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="pMktD8Mo"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510C723C4F4
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 15:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755186973; cv=none; b=WN1Z2G3G80dBT0T81ZviyDK9esttCLtay9asaWc845JIoWzj3/ielt1Eg7c1jmpjwhr70BKc7sd5Jv2zuIQdqNsCJwAQWctgzq7mIoMUPnkh9dvN30G4ClomqyhL+h9NmrH7PqVMajqcFuyYFjklGmjx0A6vy38WArGpiez+Mzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755186973; c=relaxed/simple;
	bh=OAG+rNqDoUjd+RELKmOJev7nbWr03ivllHVNaYObMaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rybwIbTLSF4zWFLHzCDh7+k8qIhw+/Cu3MdnxXVVhQbHX0PzzFVQGQntMHeMhwc/7RTBW7BdahIfK7ubbXpYZsoPFE4SVdMDO3Ja3nCZ+AD0o/+ejromrdfvlT+P2HmG0R4ZD9id3TNGvnhIBmqeJ9Hfvn+QmP5liA7w+a4cyZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=pMktD8Mo; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-323267b7dfcso1151335a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 08:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755186972; x=1755791772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OQNPbIdIHYbwO34hliHe+Dii/8OaWGaAGknLYtaJxxA=;
        b=pMktD8MouJMxo1PUfAaF8LwL+zPcEnU6aEoOkbLnL6s/wlBJpCrRc06YCdT2wHw3kt
         ad7hIkubt4AX2LaAnQOCPIxuxaDxAM5xSVoYkHyUqC9cG05v8h/91QwGWuy+E3KGf8Sw
         KnLBkYUsGjx/o5WQCeBmBb7XD4vNMSFAHKwUHYXJo1Ula7XPC/uhRMBlpVs773rDx7NF
         aJTmc4rQe2Ktyaqa9qs6FD8Xcn0Liy7xob1RUPGeP+i8sXTQxj/9DUUOSorYb/yXWrO4
         9uiV2a3CIJZ5NAGv88OoQxY4HkHfaRDyHSE1cEOBx16S+Rw130XsvE7EI9kKS3WCNUzR
         kCJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755186972; x=1755791772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OQNPbIdIHYbwO34hliHe+Dii/8OaWGaAGknLYtaJxxA=;
        b=LbuoosiEkcz3+lUkJH4OVQlUUUPFMCyE9/Ut6WOJ6iirGBUaVy5r9Sj7zF02ZsumXE
         RM4hWgFoZcdMOXiqyk5xp42bCCwtHBeSpZ9r2ldwNcXbihal+IONlmwGBK0kwCsp2YM6
         ufQFBKFjKJurifF2y37vZwkZ8t73hLj3X8X0DdCOJraDTOjrcHz5utv/OOYf4JfpP9IY
         aFe1GKWDYzvq5d+lgDrrGrePraY9CJaSUGSWcijxvr9hIKp2R433qWLZ9yRAqeeWqmm4
         ICmTzlJ+LNBDIPmZw+CJR7jf00U9myxNfSUsL81itQRRyUM6wtJL1m0tw/cdUfYr8vld
         W2uA==
X-Forwarded-Encrypted: i=1; AJvYcCXDnisr2zH6FV6kRFbnvYnfdRdw6ySUEPiV21PJkqzP4cALKFtcJQCsffb9z5CEYH6/UjoUzLz5FnPCEVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSVzJcY6Jz7vGOr4Tn82Q6j/HWb+guTO2R1oLyzka4gl2Alze5
	4El7ZTboCrMig6cdo2Khc9wE387ztPQf61++ACpJr9vNXkX4INlXvYLAlQgZ1X9gBpHQAYupIml
	llScP
X-Gm-Gg: ASbGncsmqJPpZZPtfK19joNcaZbDXL7rPIk7Qv4darOjp5lMQmzkhrmJJXzPbck5WAW
	/8yvsFfvGGay2J8iUtFtacLCVLULqHxkMgemvxKcrJ/Vp5VIzoa4iwsqa03pJ19OmYP12d+aYfO
	nVcQiUBXJdAoI7aehzqOlnBtB3Mcr8tqGX+lyOJqS9uwpcuO9TTovhoiS/b8888Y4Zp1m5Ciuxe
	4sv5KmWnr8kynYq27x5NIrNC2HVJezQvGVtSYayCwZm/vJDDF2+iWbdzss2c0v/yewTORbPqhF4
	2OVtV9l8oi/89shLYH6EM6Wyk62lvH5cuVOcrjyaiV334LFdPfV3nF14H6uXYcP9CaoKKzsiqnk
	FiMT5DgVibM76Mkr/YyNLYfURGaPHs8l9l7QSvvem9tPAVp6+C1BSTlViP+8b9g==
X-Google-Smtp-Source: AGHT+IEH2lHONmY7yOykbcxyMlWHAYogmXhk5h922kUnrQe0tO8VefaBP+3/9ekNxpfG4JCDWaX1hA==
X-Received: by 2002:a17:90b:5303:b0:312:1c83:58e9 with SMTP id 98e67ed59e1d1-3232795877emr5105743a91.5.1755186971369;
        Thu, 14 Aug 2025 08:56:11 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.166.196])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3233108e1d9sm2225500a91.29.2025.08.14.08.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 08:56:10 -0700 (PDT)
From: Anup Patel <apatel@ventanamicro.com>
To: Atish Patra <atish.patra@linux.dev>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH 2/6] RISC-V: KVM: Introduce feature specific reset for SBI FWFT
Date: Thu, 14 Aug 2025 21:25:44 +0530
Message-ID: <20250814155548.457172-3-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814155548.457172-1-apatel@ventanamicro.com>
References: <20250814155548.457172-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SBI FWFT feature values must be reset upon VCPU reset so
introduce feature specific reset callback for this purpose.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/kvm/vcpu_sbi_fwft.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kvm/vcpu_sbi_fwft.c b/arch/riscv/kvm/vcpu_sbi_fwft.c
index 164a01288b0a..5a3bad0f9330 100644
--- a/arch/riscv/kvm/vcpu_sbi_fwft.c
+++ b/arch/riscv/kvm/vcpu_sbi_fwft.c
@@ -30,6 +30,13 @@ struct kvm_sbi_fwft_feature {
 	 */
 	bool (*supported)(struct kvm_vcpu *vcpu);
 
+	/**
+	 * @reset: Reset the feature value irrespective whether feature is supported or not
+	 *
+	 * This callback is mandatory
+	 */
+	void (*reset)(struct kvm_vcpu *vcpu);
+
 	/**
 	 * @set: Set the feature value
 	 *
@@ -75,6 +82,13 @@ static bool kvm_sbi_fwft_misaligned_delegation_supported(struct kvm_vcpu *vcpu)
 	return misaligned_traps_can_delegate();
 }
 
+static void kvm_sbi_fwft_reset_misaligned_delegation(struct kvm_vcpu *vcpu)
+{
+	struct kvm_vcpu_config *cfg = &vcpu->arch.cfg;
+
+	cfg->hedeleg &= ~MIS_DELEG;
+}
+
 static long kvm_sbi_fwft_set_misaligned_delegation(struct kvm_vcpu *vcpu,
 					struct kvm_sbi_fwft_config *conf,
 					unsigned long value)
@@ -124,6 +138,11 @@ static bool kvm_sbi_fwft_pointer_masking_pmlen_supported(struct kvm_vcpu *vcpu)
 	return fwft->have_vs_pmlen_7 || fwft->have_vs_pmlen_16;
 }
 
+static void kvm_sbi_fwft_reset_pointer_masking_pmlen(struct kvm_vcpu *vcpu)
+{
+	vcpu->arch.cfg.henvcfg &= ~ENVCFG_PMM;
+}
+
 static long kvm_sbi_fwft_set_pointer_masking_pmlen(struct kvm_vcpu *vcpu,
 						   struct kvm_sbi_fwft_config *conf,
 						   unsigned long value)
@@ -180,6 +199,7 @@ static const struct kvm_sbi_fwft_feature features[] = {
 	{
 		.id = SBI_FWFT_MISALIGNED_EXC_DELEG,
 		.supported = kvm_sbi_fwft_misaligned_delegation_supported,
+		.reset = kvm_sbi_fwft_reset_misaligned_delegation,
 		.set = kvm_sbi_fwft_set_misaligned_delegation,
 		.get = kvm_sbi_fwft_get_misaligned_delegation,
 	},
@@ -187,6 +207,7 @@ static const struct kvm_sbi_fwft_feature features[] = {
 	{
 		.id = SBI_FWFT_POINTER_MASKING_PMLEN,
 		.supported = kvm_sbi_fwft_pointer_masking_pmlen_supported,
+		.reset = kvm_sbi_fwft_reset_pointer_masking_pmlen,
 		.set = kvm_sbi_fwft_set_pointer_masking_pmlen,
 		.get = kvm_sbi_fwft_get_pointer_masking_pmlen,
 	},
@@ -321,11 +342,16 @@ static void kvm_sbi_ext_fwft_deinit(struct kvm_vcpu *vcpu)
 
 static void kvm_sbi_ext_fwft_reset(struct kvm_vcpu *vcpu)
 {
-	int i;
 	struct kvm_sbi_fwft *fwft = vcpu_to_fwft(vcpu);
+	const struct kvm_sbi_fwft_feature *feature;
+	int i;
 
-	for (i = 0; i < ARRAY_SIZE(features); i++)
+	for (i = 0; i < ARRAY_SIZE(features); i++) {
 		fwft->configs[i].flags = 0;
+		feature = &features[i];
+		if (feature->reset)
+			feature->reset(vcpu);
+	}
 }
 
 const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_fwft = {
-- 
2.43.0


