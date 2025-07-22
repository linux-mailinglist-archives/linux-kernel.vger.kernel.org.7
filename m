Return-Path: <linux-kernel+bounces-740117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80569B0D02A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 05:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 335B91AA2570
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 03:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B46429E0F4;
	Tue, 22 Jul 2025 03:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="d4XR+Knt"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1710F28D83B
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 03:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753154135; cv=none; b=s4WCN+YTLvhcX28geVlAdsLiqXdw9mZHKOKo9jPJyjI3NGhLAAMVHRPKi1sSnzZv6KuQBqRD7tOgN9ka7JzY+EwtQliHuO9I6iZncLfvEQq82QuBsV0gTFMwAog9e8rJlNTsPNT7Ij12WKAN3Xcqmz/ep3D3dalVOkJz2iVdn0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753154135; c=relaxed/simple;
	bh=v6S2VfqVeBS/FwUN3sX2qA4Qo7NlLhImwGJEW5/a4E0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fDVCg2i7v8zhY1cWHYHx1/EjAgS8sKIOr1g5krpRMnZFZHLwG081XUPI9ZbD3fp3aHuqd0a4rCFyWbGqCgpJIkVnDRcYdvQbY63Ln+3Uz8WRGbcpEuUfWcR7nZWgQ5/D+ffCSlvgUrGNfncS05Rd+RCyjMwn/jxK+7Hi2OnufGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=d4XR+Knt; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b34a6d0c9a3so5083032a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 20:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1753154133; x=1753758933; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LNWjjR5K8ESMPCBOjPDxpC1mFayqfXlLuYgjg0J+sww=;
        b=d4XR+KntSRpcYufPzmPlupfpv3Z+VpHNkfjScMcXIqgxFSIgbGTW3zqnn5IcCYBIm1
         viXyr+5f3neVFNgKmDCEN3ZEInHbeeSHQD2eCyqT9zmPIx16f9pPLfmK5BvWmqm5vq1J
         ifT9dKI1WdR2UZrW+Y9X9TLM/EUghDocnzx2o9bl9+s9/VwPb4jJKZajsUSwwvhxOXmy
         64SX7KXTESBTa0QtkoYk2q/OBSJ/5kK22srHi56COTiyEpgqQg3CvXPjGyDDmcD+sYlW
         2N2abu7P3a+T1sC39F3iTWuryHXDEzr4gGofJ0tr6THbQ2ppxeB2rtci0W46+F7qIrAn
         U48g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753154133; x=1753758933;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LNWjjR5K8ESMPCBOjPDxpC1mFayqfXlLuYgjg0J+sww=;
        b=w4W7xIheHg4hw3+fCl9m8EhqZoIR/e/v/HdDZIFeGfXHnaWnglhkBrHQRcs4xaXMGs
         c0tR9sEAyrJhTTFAdA2LD6z+By6MiMq2HyLPdynsUW2HvBp57fsYAopqqB9+XtcSYDKI
         rlr21L8Tjcv8lYbffNKBMvgrXLY/EnryKvEkBBrWq9QlgF+2AUgEtPOiKP9jzYlrWOzd
         wwq/Zu1TCMN3Bez4MdXMcPxXlMndri+6vCWgnnWYnp43Vvcq4RRM1lc6eT8miFsbsoch
         epfQOg1b1DMiRNCQloTV6b/uVYQj//kfwsCcCNbLToA7d4BcfDQKBFTP/SZjHg2HcLjk
         ZoLg==
X-Forwarded-Encrypted: i=1; AJvYcCW1B3H/fg9eIHjcSNCZJfXBW+iySYX9G89PmdPVpctsYpdhaA39w88/mQXhaA3NrErhUzJV9mpENjiP970=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcv60PMiI0Goa1w95hsOigUpRTczYcFlk0ap5J2N0K812YaJ/0
	pByl2OC+Z5wjj5Sh33G4Dg3PGRnH5bmD/+kGLYEvVUXYj75HOOZCocATYr5vF1BFZds=
X-Gm-Gg: ASbGncvhYJq4qn9ILEBVbP2rBRIz23vYAfRsuxM4WG4+C8tAzOkrkIwlXombWeddFLf
	IamsP0XLgYV5cKeiiHdr97U70dCnO4I7XUlaTLRzC8AjCRY7G2Sq4Hty6Lqjq2yAwMYsSY2fvTG
	XzbpJJhg6CLf+Ma0cr8zhvge5WSnW8ytTb36tzKIZPJh8mOE8oJlZzZeX2SlCZ8YYGxX+qDs6SB
	h/nDEZnm9szuQ0U10BuruV6nyU6bOP+1HGrueAuBIw+CstJYnAtbTqSz7gkTE0stc+8j7tUw+qd
	RUw4lMjANZrqXV7azut1ilOYCCdZ3H/Wd+wNfPXTLIIgiJLpMosxlP4uAinZMB1KqwJgE8TTT56
	QNjdGAi00TugkRbWbRFt8FYGHhnADWPHF398=
X-Google-Smtp-Source: AGHT+IFlRcqyUqzUESij9IbKtqtTK+LGpo7DYk//VPdyGweTn0oqQsSsmoM0vc3xGcaHFEJntaSgwQ==
X-Received: by 2002:a17:90b:2650:b0:311:baa0:89ce with SMTP id 98e67ed59e1d1-31c9f3fc33bmr32891641a91.12.1753154133418;
        Mon, 21 Jul 2025 20:15:33 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f2feac065sm6027612a12.33.2025.07.21.20.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 20:15:33 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
Date: Mon, 21 Jul 2025 20:15:24 -0700
Subject: [PATCH v4 8/9] RISC-V: KVM: Implement get event info function
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-pmu_event_info-v4-8-ac76758a4269@rivosinc.com>
References: <20250721-pmu_event_info-v4-0-ac76758a4269@rivosinc.com>
In-Reply-To: <20250721-pmu_event_info-v4-0-ac76758a4269@rivosinc.com>
To: Anup Patel <anup@brainfault.org>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>
Cc: linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 kvm-riscv@lists.infradead.org, Atish Patra <atishp@rivosinc.com>
X-Mailer: b4 0.15-dev-42535

The new get_event_info funciton allows the guest to query the presence
of multiple events with single SBI call. Currently, the perf driver
in linux guest invokes it for all the standard SBI PMU events. Support
the SBI function implementation in KVM as well.

Reviewed-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/kvm_vcpu_pmu.h |  3 ++
 arch/riscv/kvm/vcpu_pmu.c             | 66 +++++++++++++++++++++++++++++++++++
 arch/riscv/kvm/vcpu_sbi_pmu.c         |  3 ++
 3 files changed, 72 insertions(+)

diff --git a/arch/riscv/include/asm/kvm_vcpu_pmu.h b/arch/riscv/include/asm/kvm_vcpu_pmu.h
index 1d85b6617508..9a930afc8f57 100644
--- a/arch/riscv/include/asm/kvm_vcpu_pmu.h
+++ b/arch/riscv/include/asm/kvm_vcpu_pmu.h
@@ -98,6 +98,9 @@ void kvm_riscv_vcpu_pmu_init(struct kvm_vcpu *vcpu);
 int kvm_riscv_vcpu_pmu_snapshot_set_shmem(struct kvm_vcpu *vcpu, unsigned long saddr_low,
 				      unsigned long saddr_high, unsigned long flags,
 				      struct kvm_vcpu_sbi_return *retdata);
+int kvm_riscv_vcpu_pmu_event_info(struct kvm_vcpu *vcpu, unsigned long saddr_low,
+				  unsigned long saddr_high, unsigned long num_events,
+				  unsigned long flags, struct kvm_vcpu_sbi_return *retdata);
 void kvm_riscv_vcpu_pmu_deinit(struct kvm_vcpu *vcpu);
 void kvm_riscv_vcpu_pmu_reset(struct kvm_vcpu *vcpu);
 
diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
index 163bd4403fd0..70a6bdfc42f5 100644
--- a/arch/riscv/kvm/vcpu_pmu.c
+++ b/arch/riscv/kvm/vcpu_pmu.c
@@ -453,6 +453,72 @@ int kvm_riscv_vcpu_pmu_snapshot_set_shmem(struct kvm_vcpu *vcpu, unsigned long s
 	return 0;
 }
 
+int kvm_riscv_vcpu_pmu_event_info(struct kvm_vcpu *vcpu, unsigned long saddr_low,
+				  unsigned long saddr_high, unsigned long num_events,
+				  unsigned long flags, struct kvm_vcpu_sbi_return *retdata)
+{
+	struct riscv_pmu_event_info *einfo;
+	int shmem_size = num_events * sizeof(*einfo);
+	gpa_t shmem;
+	u32 eidx, etype;
+	u64 econfig;
+	int ret;
+
+	if (flags != 0 || (saddr_low & (SZ_16 - 1))) {
+		ret = SBI_ERR_INVALID_PARAM;
+		goto out;
+	}
+
+	shmem = saddr_low;
+	if (saddr_high != 0) {
+		if (IS_ENABLED(CONFIG_32BIT)) {
+			shmem |= ((gpa_t)saddr_high << 32);
+		} else {
+			ret = SBI_ERR_INVALID_ADDRESS;
+			goto out;
+		}
+	}
+
+	if (kvm_vcpu_validate_gpa_range(vcpu, shmem, shmem_size, true)) {
+		ret = SBI_ERR_INVALID_ADDRESS;
+		goto out;
+	}
+
+	einfo = kzalloc(shmem_size, GFP_KERNEL);
+	if (!einfo)
+		return -ENOMEM;
+
+	ret = kvm_vcpu_read_guest(vcpu, shmem, einfo, shmem_size);
+	if (ret) {
+		ret = SBI_ERR_FAILURE;
+		goto free_mem;
+	}
+
+	for (int i = 0; i < num_events; i++) {
+		eidx = einfo[i].event_idx;
+		etype = kvm_pmu_get_perf_event_type(eidx);
+		econfig = kvm_pmu_get_perf_event_config(eidx, einfo[i].event_data);
+		ret = riscv_pmu_get_event_info(etype, econfig, NULL);
+		if (ret > 0)
+			einfo[i].output = 1;
+		else
+			einfo[i].output = 0;
+	}
+
+	kvm_vcpu_write_guest(vcpu, shmem, einfo, shmem_size);
+	if (ret) {
+		ret = SBI_ERR_FAILURE;
+		goto free_mem;
+	}
+
+free_mem:
+	kfree(einfo);
+out:
+	retdata->err_val = ret;
+
+	return 0;
+}
+
 int kvm_riscv_vcpu_pmu_num_ctrs(struct kvm_vcpu *vcpu,
 				struct kvm_vcpu_sbi_return *retdata)
 {
diff --git a/arch/riscv/kvm/vcpu_sbi_pmu.c b/arch/riscv/kvm/vcpu_sbi_pmu.c
index e4be34e03e83..a020d979d179 100644
--- a/arch/riscv/kvm/vcpu_sbi_pmu.c
+++ b/arch/riscv/kvm/vcpu_sbi_pmu.c
@@ -73,6 +73,9 @@ static int kvm_sbi_ext_pmu_handler(struct kvm_vcpu *vcpu, struct kvm_run *run,
 	case SBI_EXT_PMU_SNAPSHOT_SET_SHMEM:
 		ret = kvm_riscv_vcpu_pmu_snapshot_set_shmem(vcpu, cp->a0, cp->a1, cp->a2, retdata);
 		break;
+	case SBI_EXT_PMU_EVENT_GET_INFO:
+		ret = kvm_riscv_vcpu_pmu_event_info(vcpu, cp->a0, cp->a1, cp->a2, cp->a3, retdata);
+		break;
 	default:
 		retdata->err_val = SBI_ERR_NOT_SUPPORTED;
 	}

-- 
2.43.0


