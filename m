Return-Path: <linux-kernel+bounces-783157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF02DB32A3A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 18:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B40B3681F2D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 16:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3C92E9EB5;
	Sat, 23 Aug 2025 16:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="A4x5nRlO"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFCB2E888B
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 16:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755964809; cv=none; b=I1kH31pdz46qevoNXBkHG/FgALlZdyvx/lmpLIZ07yw++QXtzO5zTjzLo+0jaEq1ERM4TelmLR0R6k+Kl2NTvvJ/8j1iNoYiCTOzOB0szrDBa8TSPveWjg0a4N2SG4BF7vFVFgVroEaYNbKa5KyKtVf3+wfP06R+3+g49EjaEBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755964809; c=relaxed/simple;
	bh=WUdBTM0dhD8Re3kqq0DQBL5Pq0pV3tt6HtHEsLxoxa4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PIwSEHGTzC9HfGmgXDjUlzWHB2AMpsX/a3oMkWXAdr3jak+J6PvJymaPdGkK+3YZX+OIEfe0kVvK+La4uSGH6v+6Q3RBZIqKGJUdK//85f0N6CXrxFr8ja1srLLj0b3uEYshU8gymJAZ3AaZsRT8KVgCk12PgPByKdJZwXms9ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=A4x5nRlO; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b49cf21320aso607070a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 09:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755964807; x=1756569607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QxIYjoD6qGJ2CFZvAXrDV0PDdB+JeyudOZZgvLWLYX8=;
        b=A4x5nRlOEs0eMEekwhHdrr94WOzBOwWUwfBsyfgg4mqWzenHJywiDuCnUiPpqra/Ef
         x8zYA63YhEWdTo5dP1KAAJi9X3DWKZNpJ4kOUBUEexCzTll6juuHvz40fZZXAmI/jByJ
         t2hYbKwQGjAI0YAHmZZFJACfkRHZlL+b+vIOvJxRvsgCVvyx/TvPGBH1fXfJ51xugZHC
         LJE5GZSMl74L7Bya/HDprTVzXxf6xuWkGVduToUWVxY5Yd8XB0kacfrCrAatvbz7nj/V
         ebyPe4gLXGLGHNBH3RRVHrpW6WxSrboKAeY/KTsEdch64028wAAZD7Q2MbtmDgerru7B
         JwXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755964807; x=1756569607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QxIYjoD6qGJ2CFZvAXrDV0PDdB+JeyudOZZgvLWLYX8=;
        b=pWB5IF5yZCPSPBN2n8bXA186F6sY1KgqsBvFS/x5UD4JBBWeEBBF86gLYZKeVgSc9n
         WDB+IT6uCrIgJbh/zZyBptrlnSRu78tl4cK3HX1EjUp9hTzDKW8N6sctfWWVr3gMnfk1
         BmeZJ24qLanTbmROTuOwONKhOuAOa0IUoIs6kIdA5sTb4KdyPSotUIMy8F+LpTHjv0Sr
         skx3cqQa06Tp4CtQv3mwmgtKw3gZS8H0tXUTvZ56GzpNXEaRV0bNeW0skDDLAQZUGH+G
         KJm4CHpIAgvpz5qxbN+G7wmvYsrpkDD94k8snWUC+QphqsgiXiH8ZEWNyPQAFeuC9mBX
         x+KQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCxA+XXjYfF4ytKCWJwlqNwvQC1vKlEwzVn20GnTOuxi4TN+6b6ntw7dK+ZWLTLVjpVV3Yd/fQsotYPlk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE4FXaq+wOSzBU9YOUdMFQOc3qeHaTMW01y+zLocYFX4mC1QIw
	7DyJUriseflc7yUwJbyukMnVmlzxXGboUT30K1hcTwoeANT+exnS6HkXY70LTgjiYH7mcj4Rvsi
	P3Hhe
X-Gm-Gg: ASbGncvzcofbA2WnYVXs0NPRwdyKWDiGW8GXC+wwN7II+diav30ummDhVewE4Sm/inL
	FJBaaPL36HX8yJiWwaIqkB44IU/vm9HUYOndsnTKLheiGBkRreHSyuwr9vv74opvLtpQyix8/pJ
	N7DJG3SRkL6I4JGyuO15d7WSaMrRUyBIYdeAPWjc8H91iplKg47m/qcW+CdVdS3qkRqYFOhf0sJ
	99PDgVeZ2txJUaPmcIMzVESd6oV+cfafqDtzR/H1CmMAoyiyAL8bANHfpS6wMtj5UHLNN3U6585
	Y77WzLjHamofO6zDgP3xCwsUv+eJldcorTlu9obXsuFux63d1ha+TpRJwjcMW9ZfK04L17nHmFQ
	cALUlMKavxIgPOiUY2vnMfVWrFw8sxVYNT0DGDq7uKl/UnWNflRFg3tjEuGyvQGrQ/ACLeHsh
X-Google-Smtp-Source: AGHT+IH5FZJLOyfrOllB8g78rtlC90yaqO9Xq93Uvux/rEMgW/lp4f5ouiM5epDFAdg0M4MxVn/lXQ==
X-Received: by 2002:a05:6a20:1592:b0:23d:dd9b:b563 with SMTP id adf61e73a8af0-24340d15dcemr10004613637.39.1755964806710;
        Sat, 23 Aug 2025 09:00:06 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.166.196])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77040214b81sm2804464b3a.93.2025.08.23.09.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Aug 2025 09:00:06 -0700 (PDT)
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
Subject: [PATCH v3 1/6] RISC-V: KVM: Set initial value of hedeleg in kvm_arch_vcpu_create()
Date: Sat, 23 Aug 2025 21:29:42 +0530
Message-ID: <20250823155947.1354229-2-apatel@ventanamicro.com>
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

The hedeleg may be updated by ONE_REG interface before the VCPU
is run at least once hence set the initial value of hedeleg in
kvm_arch_vcpu_create() instead of kvm_riscv_vcpu_setup_config().

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/kvm/vcpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
index 3ebcfffaa978..47bcf190ccc5 100644
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


