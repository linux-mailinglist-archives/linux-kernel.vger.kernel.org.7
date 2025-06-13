Return-Path: <linux-kernel+bounces-685051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9F9AD8381
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jun 2025 09:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E9F2189A3D7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jun 2025 07:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4903226059E;
	Fri, 13 Jun 2025 06:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="PbcNlBFR"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0A7258CF5
	for <linux-kernel@vger.kernel.org>; Fri, 13 Jun 2025 06:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749797922; cv=none; b=kNK+u+XVvcAcHz3MQ03J+cUlO0XhjA02ZSnxvDIuj3GK+ejbhjdSLRdaslbdeOYc9Ic6Lsq8V7qz1Q8+JK7kTNrPCixvysr7ZZ6BIzVBoTsAcdkuK1NQjFYbpxF7kQ2aCokAAIrnw5jxiNhPdMv0Yg4OxhgLtgLZSPuqF3bh13U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749797922; c=relaxed/simple;
	bh=/DDImLrZIWe6DHfRVDh2VF/oihV7w86USnafdPxDL18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RnQxI/nohyktYS37NXl7m1otLLk2wJqVvLtZYWogGUD15TSqzAoPtODT2TVHS0J5Urn9Ena0eeO8FjkfJqP0fcTBQ509M61/BoigT2PD5+qcPQMMcLxBWUaY2A6W7MIODAPkkNpxd3sQ7BnsJNE3cCZN9j6nztjl4YKM/Pispqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=PbcNlBFR; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3122a63201bso1764222a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jun 2025 23:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1749797920; x=1750402720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FTUNizeD4GAwjamuleDEZyMo3f2gr2d8rHj6sva7l/8=;
        b=PbcNlBFRLu/hF26fpRbT13b2I9HXg5m18Euc1J2rnVDlCleJVNBkHlx8OCNwgzkEM4
         0G1lrIWAOvi5Kig0Zkp5bot4P1PyYvH/fEvfeGtXPK8A+BlotFEofwvlOSlV5B1KHJQ9
         rFA6UK0EC8clhUaMCeTrrNQsXSvuMfgLjUgNSuLwRAAUZrMG+VyM6o2O1XX7vP3LdKuI
         sQop9C8NsbNO7fHRAbBlY6ECKRih7xEBx9AAVRLgbopmb3qf1Swnd+D7hS9W5kplUgV2
         XDFk3G64ReNFf3qhHdScVF8o9+HpelLRrGCA6yUtjYeIPOa+eBSBkkcOsHp9kRfh9Pxe
         NYRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749797920; x=1750402720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FTUNizeD4GAwjamuleDEZyMo3f2gr2d8rHj6sva7l/8=;
        b=FquKPWltU0yvuEs+dDZt/v7Q7t6W4WAKU12NZgQRB+O88GDeC6IDFduijO9QNJiEh+
         lZv5VoEulXw25PmLwSQjOobeTUn+4JQwOWLvffLyO/f73mFF3KFmyKs51ZLaVRvBzzdY
         aJDS7PuvnV7FWwNFxlhXC1GByPHedWzGD2FRlefD3w9SxjE/uhcyLKG2oe87mcAUFd41
         i8MRycGzOCwnr/+KPKEw1Cp1tr8TMXYUKe1dLwjrkbUohlgr4Y/cHBCWAgRa28tYXwdZ
         SHTL8mSLp6jbGB0HS7Bz9pWFe7Aq7VcSotrlli14cpA9iiqWZI8doYlqNDrK9pbTm3IR
         qgzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyAn9Lcf7EB6JyNLGuxTCD7mdpEpf3QV7Np1RwUKPINiFxD2WQxUfRseRMqp1Q9FZR3qjoITLLvkjYHCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOlITDLoGBF4z4mFjIGa5ew8fqYCcrGU+KB2Q2H0o1WjoqZ7XD
	MIhB0INmahOoHY0chbphuxkKPifA9GHdHJj/I16sbCd78JvR1xWpjE2fjvaffIUcOE0=
X-Gm-Gg: ASbGncs9KiNeUUEtQNWkbkAsdo//wv17nRajPtVsuEjIZgBKBieraCuKbya5mdb65uj
	EtunlUzdDcXPEhokiMysY305NZPmYCKy2HYPM8cMPQuoE7A2kUqmX7vnXusBgjM76kiVvnBobAF
	4iazTGu01/7D+l9rFfCzrQDOK7Z2KTbnGTb8zoanJWcJS1+4Do/bAZ9yYRzKZ+DoylXts781/y+
	lU4WNWWbuwWD40P7vyhUVLIFJt8IAtgBLHEkgkmjyFoDOGxWbsw4Ow77vutzB9UI81rRePmkCD8
	pincJxTFPtKzNYb0HlWT82qUScCzbYSsG9rqmfychAv9Eo8hi8/ywFv4dh/6YOsDNPoC7JlhLcv
	XqyY/AVBAuRdpUlfCltE=
X-Google-Smtp-Source: AGHT+IFD7ruLh4VfkVxEKY4I/hEXtNaiVk7YH6BljPh0dx2E18jMzd9JyHkdwcF8Bn4qR1nr7HznMQ==
X-Received: by 2002:a17:90b:4a4f:b0:312:639:a058 with SMTP id 98e67ed59e1d1-313d9ec4df9mr3120299a91.27.1749797920164;
        Thu, 12 Jun 2025 23:58:40 -0700 (PDT)
Received: from localhost.localdomain ([103.97.166.196])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-313c1b49b7fsm2653022a91.24.2025.06.12.23.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 23:58:39 -0700 (PDT)
From: Anup Patel <apatel@ventanamicro.com>
To: Atish Patra <atish.patra@linux.dev>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v2 10/12] RISC-V: KVM: Add vmid field to struct kvm_riscv_hfence
Date: Fri, 13 Jun 2025 12:27:41 +0530
Message-ID: <20250613065743.737102-11-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250613065743.737102-1-apatel@ventanamicro.com>
References: <20250613065743.737102-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the struct kvm_riscv_hfence does not have vmid field
and various hfence processing functions always pick vmid assigned
to the guest/VM. This prevents us from doing hfence operation on
arbitrary vmid hence add vmid field to struct kvm_riscv_hfence
and use it wherever applicable.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/include/asm/kvm_tlb.h |  1 +
 arch/riscv/kvm/tlb.c             | 30 ++++++++++++++++--------------
 2 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/arch/riscv/include/asm/kvm_tlb.h b/arch/riscv/include/asm/kvm_tlb.h
index cd00c9a46cb1..f67e03edeaec 100644
--- a/arch/riscv/include/asm/kvm_tlb.h
+++ b/arch/riscv/include/asm/kvm_tlb.h
@@ -19,6 +19,7 @@ enum kvm_riscv_hfence_type {
 struct kvm_riscv_hfence {
 	enum kvm_riscv_hfence_type type;
 	unsigned long asid;
+	unsigned long vmid;
 	unsigned long order;
 	gpa_t addr;
 	gpa_t size;
diff --git a/arch/riscv/kvm/tlb.c b/arch/riscv/kvm/tlb.c
index 6fc4361c3d75..349fcfc93f54 100644
--- a/arch/riscv/kvm/tlb.c
+++ b/arch/riscv/kvm/tlb.c
@@ -237,49 +237,43 @@ static bool vcpu_hfence_enqueue(struct kvm_vcpu *vcpu,
 
 void kvm_riscv_hfence_process(struct kvm_vcpu *vcpu)
 {
-	unsigned long vmid;
 	struct kvm_riscv_hfence d = { 0 };
-	struct kvm_vmid *v = &vcpu->kvm->arch.vmid;
 
 	while (vcpu_hfence_dequeue(vcpu, &d)) {
 		switch (d.type) {
 		case KVM_RISCV_HFENCE_UNKNOWN:
 			break;
 		case KVM_RISCV_HFENCE_GVMA_VMID_GPA:
-			vmid = READ_ONCE(v->vmid);
 			if (kvm_riscv_nacl_available())
-				nacl_hfence_gvma_vmid(nacl_shmem(), vmid,
+				nacl_hfence_gvma_vmid(nacl_shmem(), d.vmid,
 						      d.addr, d.size, d.order);
 			else
-				kvm_riscv_local_hfence_gvma_vmid_gpa(vmid, d.addr,
+				kvm_riscv_local_hfence_gvma_vmid_gpa(d.vmid, d.addr,
 								     d.size, d.order);
 			break;
 		case KVM_RISCV_HFENCE_VVMA_ASID_GVA:
 			kvm_riscv_vcpu_pmu_incr_fw(vcpu, SBI_PMU_FW_HFENCE_VVMA_ASID_RCVD);
-			vmid = READ_ONCE(v->vmid);
 			if (kvm_riscv_nacl_available())
-				nacl_hfence_vvma_asid(nacl_shmem(), vmid, d.asid,
+				nacl_hfence_vvma_asid(nacl_shmem(), d.vmid, d.asid,
 						      d.addr, d.size, d.order);
 			else
-				kvm_riscv_local_hfence_vvma_asid_gva(vmid, d.asid, d.addr,
+				kvm_riscv_local_hfence_vvma_asid_gva(d.vmid, d.asid, d.addr,
 								     d.size, d.order);
 			break;
 		case KVM_RISCV_HFENCE_VVMA_ASID_ALL:
 			kvm_riscv_vcpu_pmu_incr_fw(vcpu, SBI_PMU_FW_HFENCE_VVMA_ASID_RCVD);
-			vmid = READ_ONCE(v->vmid);
 			if (kvm_riscv_nacl_available())
-				nacl_hfence_vvma_asid_all(nacl_shmem(), vmid, d.asid);
+				nacl_hfence_vvma_asid_all(nacl_shmem(), d.vmid, d.asid);
 			else
-				kvm_riscv_local_hfence_vvma_asid_all(vmid, d.asid);
+				kvm_riscv_local_hfence_vvma_asid_all(d.vmid, d.asid);
 			break;
 		case KVM_RISCV_HFENCE_VVMA_GVA:
 			kvm_riscv_vcpu_pmu_incr_fw(vcpu, SBI_PMU_FW_HFENCE_VVMA_RCVD);
-			vmid = READ_ONCE(v->vmid);
 			if (kvm_riscv_nacl_available())
-				nacl_hfence_vvma(nacl_shmem(), vmid,
+				nacl_hfence_vvma(nacl_shmem(), d.vmid,
 						 d.addr, d.size, d.order);
 			else
-				kvm_riscv_local_hfence_vvma_gva(vmid, d.addr,
+				kvm_riscv_local_hfence_vvma_gva(d.vmid, d.addr,
 								d.size, d.order);
 			break;
 		default:
@@ -336,10 +330,12 @@ void kvm_riscv_hfence_gvma_vmid_gpa(struct kvm *kvm,
 				    gpa_t gpa, gpa_t gpsz,
 				    unsigned long order)
 {
+	struct kvm_vmid *v = &kvm->arch.vmid;
 	struct kvm_riscv_hfence data;
 
 	data.type = KVM_RISCV_HFENCE_GVMA_VMID_GPA;
 	data.asid = 0;
+	data.vmid = READ_ONCE(v->vmid);
 	data.addr = gpa;
 	data.size = gpsz;
 	data.order = order;
@@ -359,10 +355,12 @@ void kvm_riscv_hfence_vvma_asid_gva(struct kvm *kvm,
 				    unsigned long gva, unsigned long gvsz,
 				    unsigned long order, unsigned long asid)
 {
+	struct kvm_vmid *v = &kvm->arch.vmid;
 	struct kvm_riscv_hfence data;
 
 	data.type = KVM_RISCV_HFENCE_VVMA_ASID_GVA;
 	data.asid = asid;
+	data.vmid = READ_ONCE(v->vmid);
 	data.addr = gva;
 	data.size = gvsz;
 	data.order = order;
@@ -374,10 +372,12 @@ void kvm_riscv_hfence_vvma_asid_all(struct kvm *kvm,
 				    unsigned long hbase, unsigned long hmask,
 				    unsigned long asid)
 {
+	struct kvm_vmid *v = &kvm->arch.vmid;
 	struct kvm_riscv_hfence data;
 
 	data.type = KVM_RISCV_HFENCE_VVMA_ASID_ALL;
 	data.asid = asid;
+	data.vmid = READ_ONCE(v->vmid);
 	data.addr = data.size = data.order = 0;
 	make_xfence_request(kvm, hbase, hmask, KVM_REQ_HFENCE,
 			    KVM_REQ_HFENCE_VVMA_ALL, &data);
@@ -388,10 +388,12 @@ void kvm_riscv_hfence_vvma_gva(struct kvm *kvm,
 			       unsigned long gva, unsigned long gvsz,
 			       unsigned long order)
 {
+	struct kvm_vmid *v = &kvm->arch.vmid;
 	struct kvm_riscv_hfence data;
 
 	data.type = KVM_RISCV_HFENCE_VVMA_GVA;
 	data.asid = 0;
+	data.vmid = READ_ONCE(v->vmid);
 	data.addr = gva;
 	data.size = gvsz;
 	data.order = order;
-- 
2.43.0


