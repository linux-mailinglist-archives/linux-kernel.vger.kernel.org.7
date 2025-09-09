Return-Path: <linux-kernel+bounces-807312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFB8B4A2DE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 130AC7A758B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 07:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6753081C9;
	Tue,  9 Sep 2025 07:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="N1E/HJe2"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3562630597D
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 07:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757401410; cv=none; b=NLbx01BvzP1GbtlSdykgfhAmrVbvfRcD3rGml10+GX5JQy7SLSSwru/CoWqS5DZSgKkElYUCOPNWj35rztYj8buPPuPietDoNmFgMO9uN9q35sbpGfHOWr3Rtr9nHBwffz8XU8W6MjuN9DrbrM4uTz2MxwTWEvJs1uvULHxQ2UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757401410; c=relaxed/simple;
	bh=e7KhWyihGNeHQtmANrYGamMrWZjvNUfv+srLihtniBI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sN5SXkvGL+zWJDMjucQtVEGMFXh7rDjk6T0pWcHOl2v/ccmDmyHYELbkRc/gVF618XcQn79q6SxyowJ8lxqIgOMmsjlrhJ3XSkm1m9HfHHC9iVZxiW8IrjFUX2MTmmDUqhj9zcs5CDCUXVtZB5/nYHCl73Fp/vERCnqnIqj58+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=N1E/HJe2; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-77256200f1bso4583308b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 00:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1757401407; x=1758006207; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=goqLKtDob+ZNX+w3rmmnq6+zF8DlfuvYjDiKv2ieDbU=;
        b=N1E/HJe2XfSWukdNA17LW04R5vXX2EnQM/AjD6fK6Uv4HKXw6MCiXmp35efxtGosCe
         tzJwq7qowlNgMg3NKlnPrN2HiW+/wEWliiFq63hdtmc5Ap+gGHNOSVWPFqn2m1c+Uf2Z
         A2DvjJp8how1xD9zw7u8LP4tni9+dN47NOwYbMBiRQw/BzG1G2pcaiBrOkRiM7TAbAEH
         ijw8+k3C/1nhuPhfLJ1KcFCFerxcYgkhPWxPcZsblCugurdHDcwqiMQFKNdvfet95XTP
         rkskltf+8STQilT4lxOx720khqEZhW0kpyza5WMw84hRVtqQuudNjhXWsJZIsq8sE4LK
         QUEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757401407; x=1758006207;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=goqLKtDob+ZNX+w3rmmnq6+zF8DlfuvYjDiKv2ieDbU=;
        b=TAzJmzTvK1at6NdP29Xy7Kjbwia5wbPhaH3lw6OUcxwcl5LBPkExeW/CrP6f+Pwr9q
         z6cA4uNInn1m1Cwg9Rhz8kl+HSSW9JXvmlKHyQhv6DQU4lx6ucfno2sx7UWsA1PVmGHt
         rOy/geB7VQf8kgmnYwJKwl2BPYAjQwZ1KFUvlnkBQ+h385gm4drj8VPyPZNp1TzLlAH/
         Xq/6wqg5bboDYncxxHPhHNpUBewu37J84bsW4U51+pK5b28j1Uo4T8APmACV3GKUKCvW
         ELAAP/SwG/Ys32IyWiiWy1baAA3bMi1WB5m8pDPD9GHSfKWEjcwm8Gi58d3kU4d2VDiv
         ooDw==
X-Forwarded-Encrypted: i=1; AJvYcCXL1QXamJcvfN7Kzx3102u0SVHakV5akOoXBTnaTE+8Bk69FiqCkRD052u1QGakNnwsDwcKIHzAfU87ta4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwgKhqrv3gdIcRNaQ4duLJZK3OtJW8vI8tncaIsBshGnABF8UX
	eqLfycijy8v6S/uQF9arumS1BETH8nnLplnv52IxnqWFEimVDSnf+RcrxB0Z3LlC+7c=
X-Gm-Gg: ASbGncv85FNE+faZ3XPgDcJTc8YjmIriNIVU9R3utdaPrJ5fwn2gfzDFNep43rg359s
	y4wIUELmeExj3DdrVaqijOq+eeYVFqQP0mFn6d+xhvVCF1mqS0KWtGcZK7WNOXCaqoVD3cpizM6
	34cBbnCu6Y8ViWiwm8C2ssAGsJJhqFMs8f0B7IAb2F1TlPZaeSHjfsglnZaccoR/Y4dHlE6ckZF
	AQiUbFavkYqE8aJm9CG0YyVlp1jQSNa1VSqE73/k/cUi07cPYw4bpOrc5A7BBlHetOfVp4ZbAGO
	xjN4D5flYyxiShjhiPsJ9KYddheE1EZak1Us8Pj3bUqGMaCdIKhKMSOPHyXxakXgVyQ/9C4vHZC
	ElnN5Ovhcz+4anQE/IuZLmzzdzJthrOZjF1w=
X-Google-Smtp-Source: AGHT+IGJbDnkT5SHhTAhiO5Q6ljc1ugcvXc+gcWNPs7wch9qaoN42+cmkfKz9M/HNQWQv+Jtvr6PpA==
X-Received: by 2002:a05:6a20:3d83:b0:250:429b:9e56 with SMTP id adf61e73a8af0-2533e9476eamr16763215637.8.1757401407457;
        Tue, 09 Sep 2025 00:03:27 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-774662c7158sm1025535b3a.72.2025.09.09.00.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 00:03:27 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
Date: Tue, 09 Sep 2025 00:03:22 -0700
Subject: [PATCH v6 3/8] RISC-V: KVM: Add support for Raw event v2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-pmu_event_info-v6-3-d8f80cacb884@rivosinc.com>
References: <20250909-pmu_event_info-v6-0-d8f80cacb884@rivosinc.com>
In-Reply-To: <20250909-pmu_event_info-v6-0-d8f80cacb884@rivosinc.com>
To: Anup Patel <anup@brainfault.org>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>
Cc: linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 kvm-riscv@lists.infradead.org, Atish Patra <atishp@rivosinc.com>
X-Mailer: b4 0.15-dev-50721

SBI v3.0 introduced a new raw event type v2 for wider mhpmeventX
programming. Add the support in kvm for that.

Reviewed-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/kvm/vcpu_pmu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
index 78ac3216a54d..15d71a7b75ba 100644
--- a/arch/riscv/kvm/vcpu_pmu.c
+++ b/arch/riscv/kvm/vcpu_pmu.c
@@ -60,6 +60,7 @@ static u32 kvm_pmu_get_perf_event_type(unsigned long eidx)
 		type = PERF_TYPE_HW_CACHE;
 		break;
 	case SBI_PMU_EVENT_TYPE_RAW:
+	case SBI_PMU_EVENT_TYPE_RAW_V2:
 	case SBI_PMU_EVENT_TYPE_FW:
 		type = PERF_TYPE_RAW;
 		break;
@@ -128,6 +129,9 @@ static u64 kvm_pmu_get_perf_event_config(unsigned long eidx, uint64_t evt_data)
 	case SBI_PMU_EVENT_TYPE_RAW:
 		config = evt_data & RISCV_PMU_RAW_EVENT_MASK;
 		break;
+	case SBI_PMU_EVENT_TYPE_RAW_V2:
+		config = evt_data & RISCV_PMU_RAW_EVENT_V2_MASK;
+		break;
 	case SBI_PMU_EVENT_TYPE_FW:
 		if (ecode < SBI_PMU_FW_MAX)
 			config = (1ULL << 63) | ecode;

-- 
2.43.0


