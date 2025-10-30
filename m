Return-Path: <linux-kernel+bounces-879052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E678FC22293
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 21:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F7371881412
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 20:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A91336E35F;
	Thu, 30 Oct 2025 20:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gz7K7LCI"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5302137DBCF
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 20:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761855014; cv=none; b=thf4kMjU3t759En2iUOHzhbIDQvjEBoHGBl+pB9E8V++56ypnMRDbrIzVS2F7B7XDq6/sE5X8iR8C2pfhd+E4R66/9BjxTCigIXr98wjbDJ03KA1hA7Tg2pmRLGBFeKdn5aOD4O2blyYObjZkSVwGJavCIRvmgKm0xvhNf5h7eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761855014; c=relaxed/simple;
	bh=Q2c6cNYSKoGYP4CYOI8nHGq0kI85fWBL8NZOIPZmdhU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DUzb8xlCEkunOIuLuWZqTcr9tjuJ8n6iDsXYkjkhlyJ0QezVu83kQWaiPzFTmUVrGQA00wq/K7pygx86sSPKIo8tjAkX0oELLI7SjRB+UPHNoBNgyuvPQAGixlzI7FToOmfCECF4AkqBcoDeKa3vMCETR314jiFtpI3pYrO9zoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gz7K7LCI; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b5535902495so987236a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 13:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761855011; x=1762459811; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=pr+88J8V2FFjpoCz/RKjLuOTT6WQDejtYqs45iSU51c=;
        b=gz7K7LCIaED4skeuMQNZUqP4NIJ3bX8PQX7dV1566hqiO8b+/xoA1fJs2faKHA5s6K
         UYNXrO8Du5eb91L7nSf/+bG0YCwXt3xfDAJGZG7rIg9tfnKBGSY+3wmDO/YTfoHgGo+8
         WZINsmqtOq8GGvfVvCf4pRALkAuA7NHbuyDsQReEVv0gW2aeKgp1xiULY3W/CSx3mnN5
         u3CShr1dkTerZL99tpypYYiKfQa/P0Xqo88tSHukNKBoMXDk2Q+goD6i4ldmD0x0ly1r
         JxiSsW92L1xw+KJjE+ukd+MSLBIBfjIFTYzt2zielD2sUYUA1fLnHn+JPcrP0TSZZDJ5
         kQEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761855011; x=1762459811;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pr+88J8V2FFjpoCz/RKjLuOTT6WQDejtYqs45iSU51c=;
        b=RxjP/Wwd+cZ/OKrmL1YAb0wIve1LTBu2ppvJQ/YWETizbs8VDg8CqdwH50MwHUA9yM
         wMzRJD3gFSAwjdF1bQXFtCL+HjqoOScwQuNbSxdB9WizkVfPoJ3rKeO8EJ003PaeL85L
         VxoTONmrHqxhhATy3Z+5vpOzKO2HuG8kiIsEUNVZAn4Or/YDCJ8QS7zKFP9xgIWzPV6s
         v6YmS3U6opElg/H47qIbx8S/KOnvDNjbaTMB14bFaOnmWKH1jvCO6N6gWvMMyt7OjJcp
         w3k5WftRfRhhUJZUGb5mR6CxEYdDMMthF5yge4xq3jO3F35IHdPCzEGwB+WhKFPPhATl
         MSng==
X-Forwarded-Encrypted: i=1; AJvYcCWgjsVgsGB3elkp0qPUwQyxiVFGvpVfH3fyRRyfTLDM4qIkvpNcqExeRhU+BMZgbVKIISCbcSGO7a0cMQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpygTiSK/oOcStcXdCLHu6eFBfraLYcztMeQ9aQwvOEWPdU7vH
	DyzqjrE8V1AOjkHEy6fybVdpP7bUyCid9/YQ9cmqYu/cWIPozUHaw9qw5ygvPe6svznUQdnPHAx
	XosGZGg==
X-Google-Smtp-Source: AGHT+IHqKKH3jALoT7jRe2OHIQ2mXXV+pELYiJKGwKEjf4ZIM+twJ+5jG3TjV8eGRlfpIUNYgujs+bg0n4E=
X-Received: from pjji4.prod.google.com ([2002:a17:90a:6504:b0:33b:dccb:b328])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4c8d:b0:33f:ebc2:63a
 with SMTP id 98e67ed59e1d1-34082fc2cb0mr1192488a91.14.1761855011296; Thu, 30
 Oct 2025 13:10:11 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 30 Oct 2025 13:09:28 -0700
In-Reply-To: <20251030200951.3402865-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251030200951.3402865-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
Message-ID: <20251030200951.3402865-6-seanjc@google.com>
Subject: [PATCH v4 05/28] KVM: x86/mmu: WARN if KVM attempts to map into an
 invalid TDP MMU root
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, "Kirill A. Shutemov" <kas@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, x86@kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>, 
	Kai Huang <kai.huang@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Michael Roth <michael.roth@amd.com>, Yan Zhao <yan.y.zhao@intel.com>, 
	Vishal Annapurve <vannapurve@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

When mapping into the TDP MMU, WARN (if KVM_PROVE_MMU=y) if the root is
invalid, e.g. if KVM is attempting to insert a mapping without checking if
the information and MMU context is fresh.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index c5734ca5c17d..440fd8f80397 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -1273,6 +1273,8 @@ int kvm_tdp_mmu_map(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 	struct kvm_mmu_page *sp;
 	int ret = RET_PF_RETRY;
 
+	KVM_MMU_WARN_ON(!root || root->role.invalid);
+
 	kvm_mmu_hugepage_adjust(vcpu, fault);
 
 	trace_kvm_mmu_spte_requested(fault);
-- 
2.51.1.930.gacf6e81ea2-goog


