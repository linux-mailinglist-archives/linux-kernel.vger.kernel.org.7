Return-Path: <linux-kernel+bounces-791938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 410F4B3BE4F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 16:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01D85B61E92
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 14:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D07B32A3E7;
	Fri, 29 Aug 2025 14:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="Lh+YeIS8"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3744322532
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 14:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756478479; cv=none; b=Q/lZnmOjgC0pbKvwWPDzSM2ye2FK45Zzh7qHcEtYn3xHpRN7QOg2kwfoGic5r2WeD4n3/ZBH6aqtwMh0DISdFdhLSfhZHpwRbVzKiRv5VMQ/1iP3P9CewyAVx2Hs9EN3PzaodFGSINkCObkbViBfsLaeAKBaNgiEePi7MqxXfB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756478479; c=relaxed/simple;
	bh=OIK2edexmMK460AAbag3XeqDeoi08HRp9qzXGx0bT/w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pRj6XfxPiWPHbzmr1jGJUsehgnhTPNCKrUd7squdwYaYq55cQkpksHtE8rJzFJOyy4graijuwqW7PzdmLEC8cQxr9IxAr8lkSBJlwcorAden7nmNE22PRXWe5eecfUtGH/xmkE7fb7Tbdx7YvyMNgrH8ar0paW2klU0gZ0bn0kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=Lh+YeIS8; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-772301f8a4cso712966b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 07:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1756478476; x=1757083276; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/MakGsp/S2cNx5PFmj2E2VVtHHLv1RzGj2Qogo6hOhw=;
        b=Lh+YeIS8uU0oKZaRM02NqtKJRiINqEaf4E7OOXIh0qeWnkmCyYd5znmi0T1yJ0akMh
         RAuwdKylWl3lJmPOQ1R/vnw3nBbQgEcFkRHPj+SOwesn/RiaV8HMC1N1pl7+/wZlcUcW
         tytRi10LGrYJmG7G1q12tDoJC9bglJp4DBnbr0ji07Y4WngPxn/KrW+ftSdknYDeCkh3
         ti+rrj4jeDAiyT+nkf44vUK/tGAQpnpxEq5jZ8EpfYwfwfVWihJmogqFxwHJ9yYhz6b+
         /gQzODFKENIBtfTQnesZ9IIbBQjkYiJSVIoY+VVHf3o1BSnU9oV5OZg9IR+hjkJvQo20
         t3Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756478476; x=1757083276;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/MakGsp/S2cNx5PFmj2E2VVtHHLv1RzGj2Qogo6hOhw=;
        b=T0MgmI6K/4Ox/rbOe38KFnSgs5YejuNHdVB0Wn4U1KF92RoJHSnwJGoWDliIPNCiS4
         8GMvNJzV4ae9AoaNce2DVe1nXGhYvx4kzMkXR/w/b6oR6s86dK2oXa+v64FkOL6h1uYC
         FY1qj5xpPGX56i2Li45K+LT0in5iTEtHdj5w4hhlWbOIurnm0lpMEZ2QsAUzVC8PgbBm
         p/4iarPMAHN3YtFkJ9Lkq3mrokBm9A08R05w8xwm0Y440X+3H+XeWjy+J0vmF1aUOVyo
         rlb0KDnoz07sJU8Mb0UnfcA/ZURKqf0Qehu7FwIl7sJOzE5xtYKk/HDf0sNGIZg0o4wQ
         v8IQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0lqqNLC37SWft0UtCXjWG/axnL4IHD6xGn15gZo3TbShsXI3cl6Ip9yAOQBBcwOHqnf7YZKdsANP6Cls=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbz1XynksbyCErD8xeH6jMkFWvMUYdmv/XNj6zXn/zThtpwGgs
	dq4/669T1t/tsEMl7coIcNIh6EVIdzThMngwv+grnoZBaYqLVdXT6sC12ognujJ0o/Y=
X-Gm-Gg: ASbGncufwCDRVe0/bPmYFcY2GPzLIS9qlIVFFtN3szzWjNh7kyYx/JhrMS/MnBqOIgN
	HVMpYMQcWWNB5c56YUPydAnRFZmyMGLj3nsJqiPMmLOJu+vrKC6epmmls2HbZsISoesruKZGi3j
	DtivZoPvkuLAcZM6K4dcfdIubEqpo3H3H3+ogXATdYrYRe1p0j4rcekLraTewkpZQdSPRJX76+k
	JXi49bJVTOZRcKLuVQcK6goOvv+B8dQlswQof6LcDHO9F5decBxXbbsYfPHzOuuC+u7EbQSgP0K
	04WEHfS69ibhEHBIgorI2LV6ITZvx4hCb+0N0+8oeM7WZQjIWZ0RmcsE2rQVpxis9uEFDh+Re+t
	jNIureIdtn2zzUMZEzHlEMwpquMn6fcBoz31uZNfnR0IBGg==
X-Google-Smtp-Source: AGHT+IFbDhya0VpL4dDdmpa2UiIlEb5E5l+kiCERG2V1mfvmn8kbsxwgyRACqpsdN0fY/j0vO5OnzQ==
X-Received: by 2002:a05:6a20:7d8a:b0:243:78a:82b1 with SMTP id adf61e73a8af0-24340db3ac2mr40858661637.57.1756478475772;
        Fri, 29 Aug 2025 07:41:15 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4e1f86sm2560999b3a.72.2025.08.29.07.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 07:41:15 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
Date: Fri, 29 Aug 2025 07:41:08 -0700
Subject: [PATCH v5 7/9] RISC-V: KVM: Use the new gpa validate helper
 function
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250829-pmu_event_info-v5-7-9dca26139a33@rivosinc.com>
References: <20250829-pmu_event_info-v5-0-9dca26139a33@rivosinc.com>
In-Reply-To: <20250829-pmu_event_info-v5-0-9dca26139a33@rivosinc.com>
To: Anup Patel <anup@brainfault.org>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>
Cc: linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 kvm-riscv@lists.infradead.org, Atish Patra <atishp@rivosinc.com>
X-Mailer: b4 0.15-dev-50721

Remove the duplicate code and use the new helper function to validate
the shared memory gpa address.

Reviewed-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/kvm/vcpu_pmu.c     | 5 +----
 arch/riscv/kvm/vcpu_sbi_sta.c | 6 ++----
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
index 15d71a7b75ba..851caa86cde2 100644
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
+	if (!kvm_is_gpa_in_writable_memslot(vcpu->kvm, saddr)) {
 		sbiret = SBI_ERR_INVALID_ADDRESS;
 		goto out;
 	}
diff --git a/arch/riscv/kvm/vcpu_sbi_sta.c b/arch/riscv/kvm/vcpu_sbi_sta.c
index cc6cb7c8f0e4..80acbb75041a 100644
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
+	if (!kvm_is_gpa_in_writable_memslot(vcpu->kvm, shmem))
 		return SBI_ERR_INVALID_ADDRESS;
 
 	ret = kvm_vcpu_write_guest(vcpu, shmem, &zero_sta, sizeof(zero_sta));

-- 
2.43.0


