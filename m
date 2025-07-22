Return-Path: <linux-kernel+bounces-740116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B184BB0D028
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 05:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B86A054638A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 03:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6BD291889;
	Tue, 22 Jul 2025 03:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="AXDuL73Q"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69A228D8DA
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 03:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753154134; cv=none; b=Q9zK3GG9dHTPv5SFev15CptxkL7dm1gJ+ySAs0KBEHvHIdUeLPUXiz80TbZ0yLr3Z/sqFJZDxl+ne6mBisYLpUtrxof6RC7Dz8vdw/QippEK+15Lxqex+pUeiLyfvpr2pd54Ajbdqh353datHijN/Nb5x4brUOBGmPXdW5fZpXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753154134; c=relaxed/simple;
	bh=n7ot1ZDrapxOuuoKWAWNChBQRBahYk/5sPYJuIjMo04=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hm+pznMwA6vIE9a6R/iTex0OnZ2mfHWRs3Ku8/A3HuxS7963NG1O4j77zIZCoNffSMzvabnmDLXyN9CX4K9S3IGZ05100OLyXTq0tJNqq7kQ/Bq8FiUkuaG21/9BkUOW1S6Iti5HjBh0KU5KWR4ajLefMmflmUxfiYirweeOHPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=AXDuL73Q; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7494999de5cso3396617b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 20:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1753154132; x=1753758932; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jhkogpIzLqmuw+J4yXbDtFu/+vtMV2ME5+zsyZigSm8=;
        b=AXDuL73Qib4HNSK8RzQZ0ZiMvr6QRbQKaeVj1FN4dJdKasgawDFqmRcD6bC0jucWEF
         XM4TO2wzXWsG41JCZUx3ycSLKhb+eNY8tjO4UPkPONtphjY40y7Nv1sJp/nhpYigNJ/g
         VqD9Hq+0QAwQ8iVG861hVSX8hralGkNEYMAr8bxWEerGRhiC6NU7Fa4qGCSbn3vMaDUd
         RisE050OpjHOxTaaGS86mAMpMZlkjRwktFW3VuSgF7oEVVa5d/rY4i+AMMmwg21KFFQd
         6Gyl/wt967+fC3cR2RWWCQjYOSwbPAO/Egu9Do7uwvatUG6N6GNs9cgkZuZsE5vkgpkm
         3b3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753154132; x=1753758932;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jhkogpIzLqmuw+J4yXbDtFu/+vtMV2ME5+zsyZigSm8=;
        b=YFAX5qFePiVS7+rfELxQh9ZhxdKeh13nikVnFzHcDz3wIOHp6kj329nW9iQ1Q8FOqE
         VUae+lAoCANMZSHbRKlvNBBhovfYjn/XKnYE9w9Q1et7FyMtDW9rdf5LLixTtYyOrRJT
         943JOgxzNTVRwHsj/i4/Ocw4ldrfWyeruLWCAdXUhUqAqJwn2ncGEm9ReNW4IEwTbCzB
         2F6MvLzO8kAWO6liwZEJsJIESylPkaxQbFhFuii71rB2ufQtelzgH0FpXxo7Q6L0Gv/q
         ULvef4igvesiquRxPaxBi4FeDCkILL0IBn+jKqeh9d8IA8VS4bLt+QR9tM26OpJnE4Bi
         9CzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBkjaTnxA6zkCHZm3+2YlOYqkgq1qdckqi6Rgjq1o4JeeL07qZD4gIlHeTxdzlJgmjXylqynqC9TuxwYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbOdeilsZ8oGQeSnbp0ji19eH0c5J0F/uHutxjhQ3QQZXzu0Ol
	7D05nmaO2O6vkc3lFl0NAbTcxeY3olUBh77Y89f7XM+2pbz5/WHwGDPqBK7NftcKbqs=
X-Gm-Gg: ASbGnculHyhaM9r4crXCV981EVfyGHgdNxfYkH2AAB9PZgw2nOhJq7ZJJQJ5pnryAUQ
	lLj1S41AbFF+UGzacmogOSo+wtW+L1ZX7O4Q043+YRQtrbrp8+4Sw/ciLQ7vBEMR4cP5MymjMM+
	Uq9n+969+zvJC2UyTKUtimmfxITlr0W8IgtlZ/2H/ln0onY55Aon6GoV0Q+LRYydAdAYTc8wWs6
	o+hQqf+iAgJ+j25J75uvmgLCT+emwwfK9O+FvFEDZirlASgRNYpX9ZN//iIbh21iPNJZw48ovDt
	zFnYIMPpZrsKNKMXKKH4M9Ur6HpP6UeewOawXkG9KeMA6d/KzVazZTeMkFiZNdGzSsrnVX0dd47
	XnQLeohrC2h3TFtizXqB/95eIR1MfjiHHRgnfgQOpF/HrrQ==
X-Google-Smtp-Source: AGHT+IFymBDNRC6n0aOx6RiDMH5WWpmPfPiOTR2NPfmMJh6ymjUAaxXLpsltj/PI9MkAWHdOyBXsLA==
X-Received: by 2002:a05:6a20:7d8b:b0:220:5c12:efa3 with SMTP id adf61e73a8af0-237d89607dcmr37332092637.38.1753154132341;
        Mon, 21 Jul 2025 20:15:32 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f2feac065sm6027612a12.33.2025.07.21.20.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 20:15:32 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
Date: Mon, 21 Jul 2025 20:15:23 -0700
Subject: [PATCH v4 7/9] RISC-V: KVM: Use the new gpa range validate helper
 function
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-pmu_event_info-v4-7-ac76758a4269@rivosinc.com>
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

Remove the duplicate code and use the new helper function to validate
the shared memory gpa address.

Reviewed-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/kvm/vcpu_pmu.c     | 5 +----
 arch/riscv/kvm/vcpu_sbi_sta.c | 6 ++----
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
index 15d71a7b75ba..163bd4403fd0 100644
--- a/arch/riscv/kvm/vcpu_pmu.c
+++ b/arch/riscv/kvm/vcpu_pmu.c
@@ -409,8 +409,6 @@ int kvm_riscv_vcpu_pmu_snapshot_set_shmem(struct kvm_vcpu *vcpu, unsigned long s
 	int snapshot_area_size = sizeof(struct riscv_pmu_snapshot_data);
 	int sbiret = 0;
 	gpa_t saddr;
-	unsigned long hva;
-	bool writable;
 
 	if (!kvpmu || flags) {
 		sbiret = SBI_ERR_INVALID_PARAM;
@@ -432,8 +430,7 @@ int kvm_riscv_vcpu_pmu_snapshot_set_shmem(struct kvm_vcpu *vcpu, unsigned long s
 		goto out;
 	}
 
-	hva = kvm_vcpu_gfn_to_hva_prot(vcpu, saddr >> PAGE_SHIFT, &writable);
-	if (kvm_is_error_hva(hva) || !writable) {
+	if (kvm_vcpu_validate_gpa_range(vcpu, saddr, PAGE_SIZE, true)) {
 		sbiret = SBI_ERR_INVALID_ADDRESS;
 		goto out;
 	}
diff --git a/arch/riscv/kvm/vcpu_sbi_sta.c b/arch/riscv/kvm/vcpu_sbi_sta.c
index 5f35427114c1..67dfb613df6a 100644
--- a/arch/riscv/kvm/vcpu_sbi_sta.c
+++ b/arch/riscv/kvm/vcpu_sbi_sta.c
@@ -85,8 +85,6 @@ static int kvm_sbi_sta_steal_time_set_shmem(struct kvm_vcpu *vcpu)
 	unsigned long shmem_phys_hi = cp->a1;
 	u32 flags = cp->a2;
 	struct sbi_sta_struct zero_sta = {0};
-	unsigned long hva;
-	bool writable;
 	gpa_t shmem;
 	int ret;
 
@@ -111,8 +109,8 @@ static int kvm_sbi_sta_steal_time_set_shmem(struct kvm_vcpu *vcpu)
 			return SBI_ERR_INVALID_ADDRESS;
 	}
 
-	hva = kvm_vcpu_gfn_to_hva_prot(vcpu, shmem >> PAGE_SHIFT, &writable);
-	if (kvm_is_error_hva(hva) || !writable)
+	/* The spec requires the shmem to be 64-byte aligned. */
+	if (kvm_vcpu_validate_gpa_range(vcpu, shmem, 64, true))
 		return SBI_ERR_INVALID_ADDRESS;
 
 	ret = kvm_vcpu_write_guest(vcpu, shmem, &zero_sta, sizeof(zero_sta));

-- 
2.43.0


