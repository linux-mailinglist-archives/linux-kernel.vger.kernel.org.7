Return-Path: <linux-kernel+bounces-783162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DACBFB32A37
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 18:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A1FC1898D8C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 16:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4802ECD28;
	Sat, 23 Aug 2025 16:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="iErhGixq"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42D12EBDD6
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 16:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755964840; cv=none; b=SzZCVu8cAA7yVSEusMyrNEvNx+nbBQhUX3Al6C8FeOwboqeoHIVetxcbZ4SGyQARFx9unINtWTNPQIBNM7yNGtP7QtzG3m0fddz1XsHe3sKiLkfcvBw92B2KbXvMWMw/heMcEMsIH0LUuP9UEwPX4OTR9Lo1VB8WlO12th8Y0js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755964840; c=relaxed/simple;
	bh=IOHDAmGMxm381khKNgntV4mSN6PoSOfSod9gcS5L2q4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ikr0vuYUcU3tAbNYKCEjy7tvdplrUNFDaoiVJ07wRLPE74YVkpUuKvjJAOJLLMLL1JdcxoMOrvbNDRRQtSOm14X7AtHCPT8vqju0UdafZBsCfemKFGLTRYR4CEmKUp41OlTDN5ggSCSH94zSf4NFhexqYJAZ+0FW8jOtYxnwNao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=iErhGixq; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-76e1fc69f86so3126883b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 09:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755964838; x=1756569638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T0xPrnmX6+2RsTiExCa2v2uPE7DfF6VVPGIu9AltgG0=;
        b=iErhGixqKlX0QNpUrKoDoAwB/HtRNF71ZWP27qClcIk20kLeKufP+L4KvgqmczMU2M
         kpkA3TPENghX8ZnxAciN9gdUauqCPKqqQFZerlyqFtQ43CWPD83u30vAGecVQLn+8uBY
         brWfAyjCVOednip7JS3N792NmotYScHKolQfm5dC4qs1CQyNUwMg4CI7czZq3qEI1W01
         RCQPrIoS1CBT8p5n/rGX/hZ2k/7oYzMtli2kxCuhbBoej1NKHy71Z126ZfoUtYUrJ3Qi
         vnrSsAxZ0kKlSVUVBUhW9LZOpKTFO446qsCU7BC1/mw38a7oUjbgWWolSlAc27FO+ZdX
         rFUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755964838; x=1756569638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T0xPrnmX6+2RsTiExCa2v2uPE7DfF6VVPGIu9AltgG0=;
        b=PeKCl8iSze1YYR10rnz7FqdHql3KseB9OlTjROoXGIbccI3XpXuMqu07Uad/kRgMMi
         0k2UcoXirSKU2cjcG/BL8XTejl4mRxNhTPk1qsMFzwAkNudhv2ut9wpa+DGgQZRSV+x2
         5zn7W6+qRpnj+rX3qcJDgWSrI0xO5mjwF/l0TM1mokit10tDeb3rNXkezyKLYR5Z8gXN
         J6HHAMx8VsJY3d75PtW9yuUZ+tY/H32s+Q7FNRAj1Gz09Ng0DIRZkSzpkbfX3qAVTBq1
         WDcxDjhpwV1kZB5mivVeCSUOy5xg1a4uUrPP859Jvpy2IcFFW6Lq+2E/qRnpyoZEf1VD
         a7og==
X-Forwarded-Encrypted: i=1; AJvYcCWyKSDSOpXZWJz/VtFyYD6fY22YzWxmz0v27EFUxr+JJ22IYLLjStQCoQeriMNj/kg9lVchINS/Qkp4mSU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV9MGGEU7HEQNVjluZLW4+REb/iO3t5eRtPcckTeSBP5mmunkQ
	BJGLRaZVxx6ASxoaMwZgn7iPOrCNYSf8GLjC2HTv8gZ2ZoBCKp/VvlrL7FrAzs/ttds=
X-Gm-Gg: ASbGncv7nJiLG4H1piS0Han9FASS8xgsCMFjrliWq8SMeWd0Xkbff+VxnSsEN733Yk6
	UQsA9Gkn9STCIjRlFIwOIUqWXB6/1n4jhMRrsUXjcXACubm47pKUzc5Rap5OvJ+7HZttZ1jgQDn
	O/WVtvt/35/o1xci9NrdOHdu2dwFJR2gczWt10lZ47SrhOG4hbT3EF6Z9r7AFAtIXnJRvhuXPH8
	0WkHRaSJLLu1jOvZT1EXkduf1fQsTCHfahpJ/91KxX0km71Ticy1vhKqoQK9jrR3gpdNW6JxTdR
	028+9Ckad9wUXXZJERlVCk1V2/6rb6SAr/X6K0K1rIpbsEPbK74WlXm1+t1faKVUFOAtrY7XUp3
	hvDAqoa6mTpYurUobS70tRyde764W3SLUH2ocuA1LmG7AU24j0i985VSXlblOrw==
X-Google-Smtp-Source: AGHT+IH9mKQKRpTK3LLajQ4vwhqlhidY8LOQ/odhBzLI9lEp+MRXqzPETW2FWn9n7jmiaNJ6zP2jsg==
X-Received: by 2002:a05:6a20:430f:b0:220:898b:2ca1 with SMTP id adf61e73a8af0-24340ddec04mr9054802637.21.1755964837962;
        Sat, 23 Aug 2025 09:00:37 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.166.196])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77040214b81sm2804464b3a.93.2025.08.23.09.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Aug 2025 09:00:37 -0700 (PDT)
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
Subject: [PATCH v3 6/6] KVM: riscv: selftests: Add SBI FWFT to get-reg-list test
Date: Sat, 23 Aug 2025 21:29:47 +0530
Message-ID: <20250823155947.1354229-7-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250823155947.1354229-1-apatel@ventanamicro.com>
References: <20250823155947.1354229-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KVM RISC-V now supports SBI FWFT, so add it to the get-reg-list test.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 .../selftests/kvm/riscv/get-reg-list.c        | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
index 34456e8cba02..705ab3d7778b 100644
--- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
+++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
@@ -132,6 +132,7 @@ bool filter_reg(__u64 reg)
 	case KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_DBCN:
 	case KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_SUSP:
 	case KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_STA:
+	case KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_FWFT:
 	case KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_EXPERIMENTAL:
 	case KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_VENDOR:
 		return true;
@@ -637,6 +638,7 @@ static const char *sbi_ext_single_id_to_str(__u64 reg_off)
 		KVM_SBI_EXT_ARR(KVM_RISCV_SBI_EXT_DBCN),
 		KVM_SBI_EXT_ARR(KVM_RISCV_SBI_EXT_SUSP),
 		KVM_SBI_EXT_ARR(KVM_RISCV_SBI_EXT_STA),
+		KVM_SBI_EXT_ARR(KVM_RISCV_SBI_EXT_FWFT),
 		KVM_SBI_EXT_ARR(KVM_RISCV_SBI_EXT_EXPERIMENTAL),
 		KVM_SBI_EXT_ARR(KVM_RISCV_SBI_EXT_VENDOR),
 	};
@@ -693,6 +695,19 @@ static const char *sbi_sta_id_to_str(__u64 reg_off)
 	return strdup_printf("KVM_REG_RISCV_SBI_STA | %lld /* UNKNOWN */", reg_off);
 }
 
+static const char *sbi_fwft_id_to_str(__u64 reg_off)
+{
+	switch (reg_off) {
+	case 0: return "KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(misaligned_deleg.enable)";
+	case 1: return "KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(misaligned_deleg.flags)";
+	case 2: return "KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(misaligned_deleg.value)";
+	case 3: return "KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(pointer_masking.enable)";
+	case 4: return "KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(pointer_masking.flags)";
+	case 5: return "KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(pointer_masking.value)";
+	}
+	return strdup_printf("KVM_REG_RISCV_SBI_FWFT | %lld /* UNKNOWN */", reg_off);
+}
+
 static const char *sbi_id_to_str(const char *prefix, __u64 id)
 {
 	__u64 reg_off = id & ~(REG_MASK | KVM_REG_RISCV_SBI_STATE);
@@ -705,6 +720,8 @@ static const char *sbi_id_to_str(const char *prefix, __u64 id)
 	switch (reg_subtype) {
 	case KVM_REG_RISCV_SBI_STA:
 		return sbi_sta_id_to_str(reg_off);
+	case KVM_REG_RISCV_SBI_FWFT:
+		return sbi_fwft_id_to_str(reg_off);
 	}
 
 	return strdup_printf("%lld | %lld /* UNKNOWN */", reg_subtype, reg_off);
@@ -872,6 +889,16 @@ static __u64 sbi_sta_regs[] = {
 	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_STATE | KVM_REG_RISCV_SBI_STA | KVM_REG_RISCV_SBI_STA_REG(shmem_hi),
 };
 
+static __u64 sbi_fwft_regs[] = {
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_FWFT,
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_STATE | KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(misaligned_deleg.enable),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_STATE | KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(misaligned_deleg.flags),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_STATE | KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(misaligned_deleg.value),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_STATE | KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(pointer_masking.enable),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_STATE | KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(pointer_masking.flags),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_STATE | KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(pointer_masking.value),
+};
+
 static __u64 zicbom_regs[] = {
 	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CONFIG | KVM_REG_RISCV_CONFIG_REG(zicbom_block_size),
 	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZICBOM,
@@ -1028,6 +1055,9 @@ static __u64 vector_regs[] = {
 #define SUBLIST_SBI_STA \
 	{"sbi-sta", .feature_type = VCPU_FEATURE_SBI_EXT, .feature = KVM_RISCV_SBI_EXT_STA, \
 	 .regs = sbi_sta_regs, .regs_n = ARRAY_SIZE(sbi_sta_regs),}
+#define SUBLIST_SBI_FWFT \
+	{"sbi-fwft", .feature_type = VCPU_FEATURE_SBI_EXT, .feature = KVM_RISCV_SBI_EXT_FWFT, \
+	 .regs = sbi_fwft_regs, .regs_n = ARRAY_SIZE(sbi_fwft_regs),}
 #define SUBLIST_ZICBOM \
 	{"zicbom", .feature = KVM_RISCV_ISA_EXT_ZICBOM, .regs = zicbom_regs, .regs_n = ARRAY_SIZE(zicbom_regs),}
 #define SUBLIST_ZICBOP \
@@ -1112,6 +1142,7 @@ KVM_SBI_EXT_SUBLIST_CONFIG(sta, STA);
 KVM_SBI_EXT_SIMPLE_CONFIG(pmu, PMU);
 KVM_SBI_EXT_SIMPLE_CONFIG(dbcn, DBCN);
 KVM_SBI_EXT_SIMPLE_CONFIG(susp, SUSP);
+KVM_SBI_EXT_SUBLIST_CONFIG(fwft, FWFT);
 
 KVM_ISA_EXT_SUBLIST_CONFIG(aia, AIA);
 KVM_ISA_EXT_SUBLIST_CONFIG(fp_f, FP_F);
@@ -1191,6 +1222,7 @@ struct vcpu_reg_list *vcpu_configs[] = {
 	&config_sbi_pmu,
 	&config_sbi_dbcn,
 	&config_sbi_susp,
+	&config_sbi_fwft,
 	&config_aia,
 	&config_fp_f,
 	&config_fp_d,
-- 
2.43.0


