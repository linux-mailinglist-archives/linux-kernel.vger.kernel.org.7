Return-Path: <linux-kernel+bounces-807315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF02B4A2E3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54C351BC6AD0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 07:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54F43090F7;
	Tue,  9 Sep 2025 07:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="TDz56iMr"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E32A3081BA
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 07:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757401412; cv=none; b=jD7nrDUKpsY1BFsolqhEXuYE7zXOVQYfHSaRTVhlYR1Hf/ghRxVy/MMMN7g8I/uNNfNfwQ7g+LTnoeSL5lZUwtL3M2+mxBN6185DQU8jMGubktxyNItrNOPmHD8VKm0Xh/Qh7rDRVCetcvcDLmh91+8k0NUIzpecB5PHiUY4DWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757401412; c=relaxed/simple;
	bh=FShHH1HSMrmoVp5u1PcL4F5vjxrP/Jvx+dnFDhWtXGY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IsA4uWWv/sJKo+pSBxZ69kzLR//oxs8wNc67Vs64uT+pk7g9l8PO5hH5JAMKPC3A0Iv2/epxH5EOIKQGAxyhCcojDoIh0otN10cFb7ttP+ayyVWQIV8PYDlCw0cpZjN5xlcvRHeaXukmz98pIuJpfU3mA5kAmqStXtkFQ1no6dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=TDz56iMr; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-32b5d8bea85so3574436a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 00:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1757401410; x=1758006210; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=53RW3r37vVd/uOGEJeJ40vwWJphKZpVppDFV/CpDLs4=;
        b=TDz56iMrt1ib0qgISpTvRAUQZ6DsWjZMgBX8xvglndagXbPz/4t2DsGbgPRFMa7hZw
         /6dhdZKjkXUFCCNlhPB1MtZCK9Et9wizJ6w0mGExScOMCyMMywZ5zfFPk9JLnl3VKDvW
         r/6wolsGLUyhJBkHIaalnBlSk/mZwCP5GxHCv5T4GZ761GBCT2oN58Eo7FONXQu5asm8
         PxhC9Sx2mcBCIG634ob8WIsMHPjw3EusJt3jCRsEpqhWVKF/rMuqJDtr4id8pPtaYDV9
         BDJnVW2alpeRQcAl+uPEsfqkN2uSNdlJACz1I4tsmqFHp38Gv93OQkfJGp+yLuewJMsX
         Wdfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757401410; x=1758006210;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=53RW3r37vVd/uOGEJeJ40vwWJphKZpVppDFV/CpDLs4=;
        b=LuALi7GUjSxaKdLHvjVkW8wlwlq1qAxAf7Zl4LNJYRm1uO6xEzQiS1nxmeHSGomaNy
         KobZgPwF5BGfPfbkHiyf2BgXJu5D6bgywbDBD8/RFbPylCnh7CYp992Ha9uC1LhrLuRs
         ouJqIAQFajwRvmLMew0MG12v36X8mwqSGLVQXB5IXKpXtJQ+hd9fFtHhf85v3JzpeJIK
         0BtDRX6VkZLMh8vlRkl4u3MsPz9Ho+UufhcdcbR/raMViWVEopjwt7B9P/kox1XWLvGI
         ikZbT6kCXyF2M6+ZJyfNzXL8QTF/gGcqtZ/0d77xd/TN63ybybCnM87+AFU6Uok16fJE
         xwcg==
X-Forwarded-Encrypted: i=1; AJvYcCXUSS7dzMFpZVxZ6NhoHKa71oJ0KVSGC4KkjGtk7CMuagpUQnJ5Xh19VLIK7QpNXjoqAla2uYrRpG+AkUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU/BePX9xE9f3xq8/J091WHHC11jClPHl6bzSFcRN9PfqxMntz
	VakZNdFv+0GHkApXc/zj9Cq9TevsCqnGLe/GExsCDZG/sIIY1rHOXuvxMFAlZUW5qmY=
X-Gm-Gg: ASbGncsbO6A//xKTWFKViDAOv+wDkYEH0VbrjZhE+lvf7JHY5CaLJ82dzfiK9GVOF9F
	INi9Vyq06JMeGYZQVAh8+auM6bBUUlfvcVSOSvCtS4oSK8GA9ak4Pp1vvJAnIQ0iP6MYGn+HY8z
	yBtIFg+WZWGFX2E0k3E83TSH1gMZ+OU6/6hxMne6uj6p/AWh1RyMxfCbRccQLduE1AfSmbnjXP7
	4C03XpoECaTcHLcsXmi8OSFT7beqphPbKDKQdrr+1vK9U9rkzzEVKCjjQDOqv9a5Fs8oR/z+ek/
	a/dQ3xEa340X513PhJe7SYhrTDAh2eNVO6aGr3rp9fqGSls60o9m+G18IBvqwjEbxSuMCoM14dB
	6gsqscWDOp1xfI+eqna618zom4v21cdFuFU//NePHoRc8tQ==
X-Google-Smtp-Source: AGHT+IEp7M2YTd5oqLJWntqYzx+W66KU/8IVhi9uG5EgartrnOvK3S6t6vrkn2Q3yP3sdZUpu5Y3+A==
X-Received: by 2002:a17:90b:48c9:b0:32b:96f2:e2c9 with SMTP id 98e67ed59e1d1-32bbe104088mr17623995a91.12.1757401410327;
        Tue, 09 Sep 2025 00:03:30 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-774662c7158sm1025535b3a.72.2025.09.09.00.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 00:03:29 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
Date: Tue, 09 Sep 2025 00:03:25 -0700
Subject: [PATCH v6 6/8] RISC-V: KVM: No need of explicit writable slot
 check
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-pmu_event_info-v6-6-d8f80cacb884@rivosinc.com>
References: <20250909-pmu_event_info-v6-0-d8f80cacb884@rivosinc.com>
In-Reply-To: <20250909-pmu_event_info-v6-0-d8f80cacb884@rivosinc.com>
To: Anup Patel <anup@brainfault.org>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>
Cc: linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 kvm-riscv@lists.infradead.org, Atish Patra <atishp@rivosinc.com>, 
 Sean Christopherson <seanjc@google.com>
X-Mailer: b4 0.15-dev-50721

There is not much value in checking if a memslot is writable explicitly
before a write as it may change underneath after the check. Rather, return
invalid address error when write_guest fails as it checks if the slot
is writable anyways.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/kvm/vcpu_pmu.c     | 11 ++---------
 arch/riscv/kvm/vcpu_sbi_sta.c |  9 ++-------
 2 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
index 15d71a7b75ba..f8514086bd6b 100644
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
@@ -432,19 +430,14 @@ int kvm_riscv_vcpu_pmu_snapshot_set_shmem(struct kvm_vcpu *vcpu, unsigned long s
 		goto out;
 	}
 
-	hva = kvm_vcpu_gfn_to_hva_prot(vcpu, saddr >> PAGE_SHIFT, &writable);
-	if (kvm_is_error_hva(hva) || !writable) {
-		sbiret = SBI_ERR_INVALID_ADDRESS;
-		goto out;
-	}
-
 	kvpmu->sdata = kzalloc(snapshot_area_size, GFP_ATOMIC);
 	if (!kvpmu->sdata)
 		return -ENOMEM;
 
+	/* No need to check writable slot explicitly as kvm_vcpu_write_guest does it internally */
 	if (kvm_vcpu_write_guest(vcpu, saddr, kvpmu->sdata, snapshot_area_size)) {
 		kfree(kvpmu->sdata);
-		sbiret = SBI_ERR_FAILURE;
+		sbiret = SBI_ERR_INVALID_ADDRESS;
 		goto out;
 	}
 
diff --git a/arch/riscv/kvm/vcpu_sbi_sta.c b/arch/riscv/kvm/vcpu_sbi_sta.c
index cc6cb7c8f0e4..caaa28460ca4 100644
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
 
@@ -111,13 +109,10 @@ static int kvm_sbi_sta_steal_time_set_shmem(struct kvm_vcpu *vcpu)
 			return SBI_ERR_INVALID_ADDRESS;
 	}
 
-	hva = kvm_vcpu_gfn_to_hva_prot(vcpu, shmem >> PAGE_SHIFT, &writable);
-	if (kvm_is_error_hva(hva) || !writable)
-		return SBI_ERR_INVALID_ADDRESS;
-
+	/* No need to check writable slot explicitly as kvm_vcpu_write_guest does it internally */
 	ret = kvm_vcpu_write_guest(vcpu, shmem, &zero_sta, sizeof(zero_sta));
 	if (ret)
-		return SBI_ERR_FAILURE;
+		return SBI_ERR_INVALID_ADDRESS;
 
 	vcpu->arch.sta.shmem = shmem;
 	vcpu->arch.sta.last_steal = current->sched_info.run_delay;

-- 
2.43.0


