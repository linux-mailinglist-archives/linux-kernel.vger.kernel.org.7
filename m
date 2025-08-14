Return-Path: <linux-kernel+bounces-769242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DAD4B26BC9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 18:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C27A55A7AD8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D70323504D;
	Thu, 14 Aug 2025 15:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="fiz69Bs3"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BA524168D
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 15:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755186971; cv=none; b=pC/4TBVFjmkvniM/NG7rg4IZLkVqcNSEyJrGRDsrxGH2ZVRSAdxdzg91L2/P/3wzpffrB5eVNVmrhVEmEiRCO+cTmi1zXicW4xAy8l9m7jYnn9X0e6aBMKIha2bjNEs/dBU+c3bwMjZVJETlHsh8Cmc9f7lBDL74YyYtSHW9J1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755186971; c=relaxed/simple;
	bh=AMl3xYJNuSAGeF7OLy/Kzv4+2drH4oPVNI0DIJBBJPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UHFwNIz2958IGQ9SXqmIygr/TGcCMy2XzledK02XcbzI60sHgotlC70r0YtY3cmD8Om1a+/q19nzeZBGwMEorcR2ytMJqNWSqWEiQLH2nNox+8KVbqjVmsI9flWIUzyXTgIsAy43y2euNiSWwfbi8urndrTK8tNYq8j+O+ziSIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=fiz69Bs3; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-244581c3b43so9805495ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 08:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755186966; x=1755791766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bm60/2Cr4w6uAzbvsdcbKrh6VNvMu+/Ils5A4Kn+0Hk=;
        b=fiz69Bs38/4zeuGfhRlrC409rA6lEj1VYNmfke5l81TWzPBup8G8xjG+Ix46y4RGnD
         tANIVvox1Lw+H8k6HCjSBfy475Iao8yS1/4G7BtiaPYU9pxFCHqtFJ+iwmpGHPOk7S4/
         SgvIYlk+1XRCUhPURCkSVHCFCNaLG70zX+XwHwSE8/XrzPrErUWjAWfU+t6Bd4/dpIRE
         OMSq8M3wYKY8Cpt1pEGXOaZ/LjyKOOiJBWLXe3yYgpODVdVSabxAKEvbI4W79O5fw2j/
         jrPsFqMgYeNvQX0Uq41CqV4WgUX7mPhmb8ZGwbNawawJAnvIIAFs+v6qp9Nu0ZDIIcCb
         jAow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755186966; x=1755791766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bm60/2Cr4w6uAzbvsdcbKrh6VNvMu+/Ils5A4Kn+0Hk=;
        b=qsEzjJakfonTjxvYsE16U+wQDtQH6xtLP2LFxCnlBG3jZIjoUXtEnm5SBl7GD8vXp1
         FYs+3dGCFHNaIcl/vckIetoTUKRI4wk4/0sJm7BEjWBeJclpObAR0yglpcO8Yw6hOmid
         p1UP4YcAr6QelglPrBVQGQDoFqGPg72ja6QACxN1Rq26dZRAVp7KyfZEfUh0G2Ji/yPN
         6FvLRp9IPIVBkaiUtDgeUcGTzpu2NldndRp/GKz4/+NlwTfNV3sN4tyBtqmbeUcFVWeH
         bDrKHR2z4dJTGGaSCbWnylBzbY9FhwNcOTYUOHdT12+oGHt8E0lWp1m//GRxAgu45wMy
         rjZw==
X-Forwarded-Encrypted: i=1; AJvYcCWNqlY4fztqRm8aoKkeiI+3DFnM8eksBpDuIaR85lwXVSf+9oLlu2ohuJNagADcDU2XNJ+MHIRxMo0e1k8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc3dDCa3qpHx/MnpUrnXVCS+9PF8x6c3rGhDu0g6jEiyaKPl4B
	Q5G3MTKi9GapvIFSk88jgjV3sQSoBga2ZCgCGYPrKGkoDh61gNsmkWkEoa7BR/pb4ag=
X-Gm-Gg: ASbGncu+EM+HnV6LqOoZfnU3usYrjU+g5LM3K9iV+TXr1PTUFRMcT6I19OSiddlWpVt
	6y29s7iiQm3ZODvPWx9BHg4vLKGFF2TiRaHMJ0+0wEUVGZrYuQT3K8Euijs/YDtWD8ZuW40aWsQ
	yB2MIxNUOkZRaTPmGMvFSq8BOsDNnMidW8GOorI1aYx1kzMdHcGCWWjT969hQm7hUYSBS335PwS
	7HGUsaEdBDCF883l7XQD/S/GoFHfkShPPTsv3wQWm5WCZYsBsYQeBHw2rrhjXdE16mZzJ5l+ajw
	PNJc6PLjc7rv0TJxM9zzV3NUf18ijPK2vTxWtmCsk08ENRDYXWr2yrpjf626KAKk4lJjLgusggh
	F/4UgwdkKFc4pfYxc7npMuU7/4KDIQ+hv+cA/1m8jJvnR4lM6/bFexiqhP27UQw==
X-Google-Smtp-Source: AGHT+IFZMx0P1JKNMfotkf1h9uD05/LbUJ3nHS+qqEqkenBGx5Rm/Php8OZMQlv5/iu6GkzqmdURRg==
X-Received: by 2002:a17:902:cccb:b0:23f:f065:f2be with SMTP id d9443c01a7336-244586a0e5bmr50715635ad.26.1755186965537;
        Thu, 14 Aug 2025 08:56:05 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.166.196])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3233108e1d9sm2225500a91.29.2025.08.14.08.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 08:56:05 -0700 (PDT)
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
Subject: [PATCH 1/6] RISC-V: KVM: Set initial value of hedeleg in kvm_arch_vcpu_create()
Date: Thu, 14 Aug 2025 21:25:43 +0530
Message-ID: <20250814155548.457172-2-apatel@ventanamicro.com>
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

The hedeleg may be updated by ONE_REG interface before the VCPU
is run at least once hence set the initial value of hedeleg in
kvm_arch_vcpu_create() instead of kvm_riscv_vcpu_setup_config().

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/kvm/vcpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
index f001e56403f9..86025f68c374 100644
--- a/arch/riscv/kvm/vcpu.c
+++ b/arch/riscv/kvm/vcpu.c
@@ -133,6 +133,8 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 
 	/* Mark this VCPU never ran */
 	vcpu->arch.ran_atleast_once = false;
+
+	vcpu->arch.cfg.hedeleg = KVM_HEDELEG_DEFAULT;
 	vcpu->arch.mmu_page_cache.gfp_zero = __GFP_ZERO;
 	bitmap_zero(vcpu->arch.isa, RISCV_ISA_EXT_MAX);
 
@@ -570,7 +572,6 @@ static void kvm_riscv_vcpu_setup_config(struct kvm_vcpu *vcpu)
 			cfg->hstateen0 |= SMSTATEEN0_SSTATEEN0;
 	}
 
-	cfg->hedeleg = KVM_HEDELEG_DEFAULT;
 	if (vcpu->guest_debug)
 		cfg->hedeleg &= ~BIT(EXC_BREAKPOINT);
 }
-- 
2.43.0


