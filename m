Return-Path: <linux-kernel+bounces-858361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 98020BEA7CE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 18:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1E1035A8880
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E9C332EC9;
	Fri, 17 Oct 2025 15:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Xn/knt8C"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCD833507A
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 15:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760716796; cv=none; b=DG0uIkJI5/qpNh46UNxUpi/mikUEG3SmGozuFyJdwMlWnFfa3aow/LGgsmQW+5SNy05nf2wA4AuSZ6gIPnWbihqCyP80Gv9KXl8lFajayBOR1dczwyQiN96g8XMgM3N39UoM2Tr9P3yP5ocUfjJw2gbScnIsDgZAawqwyaN50gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760716796; c=relaxed/simple;
	bh=mljYXy3IxITmRqF+iKLm3Yh6cbzzCUWnVlBHoIsPH6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XKz0UE7l592er1ATJkMkg74qtbF3L8LGVdBLthIT90pU783W+fPCpHk/I2Bl8cmNM1U9swpp0eWmDbPyx0NciCRdVNiYMIZwwNjdckk8ZIX5cK9mWrv3+7qttudgtmYCPZJXdhHJG1xIDoYi0cLe0oqbCsJv44kDkrpy7R8BxdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Xn/knt8C; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-33bb1701ca5so1675281a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1760716795; x=1761321595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fOxr4kUrx3o2qKQ3zJr2xwhR1Y/B5zgWnTBkv0V7+0s=;
        b=Xn/knt8CdaLA62QFuoMDg5EOx2CW4Frz8EsSA/UudVLfzOMuzmgZXNuk5XkOBPHrDI
         nudbq+5eSeMiAXQGe/KV4+ibirQZdHEA4DWkriKw58mklKurKYayO8WgFwTBGp9pCBik
         A4Xb2qpXmM+fLzpWZIlAqz8CIcLYRmCUxq2pe/QRuA6RbIADb0LpIWxWeGxq+wukmuhd
         JnSsMrUf0b/tXwxl44mOaNYcc+UIMqxhk8xbLAePoQWF30+I2GHVEtjtIWmcHwVM2Kim
         KhQVLOc02Se/K4TJ63nNtCUDflhQnVGeTnDmTZ70X7ahw165ajXFAA54Zl3EpMPbs6Ix
         L7Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760716795; x=1761321595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fOxr4kUrx3o2qKQ3zJr2xwhR1Y/B5zgWnTBkv0V7+0s=;
        b=RiDEm2YAbASyTupvxo6EPA/N8sxoD6wmveBwZG7cQHsElbSPWIDA7tIwWmu2UmLY0e
         XEWgAu0KBgV4LgYn43fJJre5RuJX5djVtGUfY35f/Ugln50Mfb5LzGgC4SbNBBYk9PLL
         2mf/bUqyIsq9uzWJ8vk3CdBaLVqz8MGO7pwzh1necf7LZD8KA/NhhiPMmBQa/f2xY7w+
         34+I60ixn+rNIREWcxPHIOfOnYhm75hs0EJoPx8U++9F3+KCxISa1DgDSVDnlByPBiLZ
         g622PihXi0XSoj8HeJij/MCC5tGqisw3xBPFxwZTba+Ix2oRVCMjGLo0wbNFfa5d3N5S
         2ORg==
X-Forwarded-Encrypted: i=1; AJvYcCXd45emPY/IuIiiHxclhqZjX6e2TH5FOm6D/bVtx2ijE1PjRSZBtGsRqAIoZn3eQHkO3CP9jubatAmJAHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNhqX4D9Qe3iToiNlLLl3V7St6c9NM+01rkDHD08+Ry1egA+Uc
	DDheDOTxXB3p195SC0qyllqgDAf3ANjoXOjP2LddwkZjOLhXZsPcaqhhK1+AIXyYe5w=
X-Gm-Gg: ASbGnctvb/YyYnqm8o030ApzJxk5+0KBy+ELGuE5mMO7zz812f9dLmC19rZZwI7wI5H
	14pIm7ZN4Yl0fzJoI85/A/R9Z1a2ByFWseMAvjF5w78lEUZ81Tzz6WCB4m9rySZb4NcA34/ZPEE
	jBEIab+tDEb4YnJT6NyICqFkeNSYnFa30nrmw/1ZNMpOCaPsxVvSozuvmWx2P+c4E+O+2ZA8Igf
	dIzJVupmS0vTIoAPA7GQ5F8BXCApqFeqOIuHx80JgaKOxXmVDSVFYN/FVNeXoXPjJfmbM4RNJsA
	jlQ/PAQBZ09Y+gqWp60qTIb4W4n/A1CHSSNu/aJIcxsS6IoMWLw+cH6Q2+S1rT61RywohwusupL
	wQzGm4BvPEEQXO5chZa1KkVAdhiTJNJxwfXTmrRgnxOHNXmIPjMaQ5wC532K6cv0N4A8xwrqXZn
	g+vef7TjhWsYGsWn+wiwi/HAn1bS9kkSrx
X-Google-Smtp-Source: AGHT+IFoCPBiPeGQQLQ+fG7ai4z/yEAOOUIjHcz+WvJaH5Mkp92XTCRypBxB5qA/CcWwuixBEctClg==
X-Received: by 2002:a17:90b:2690:b0:33b:a5d8:f1b8 with SMTP id 98e67ed59e1d1-33bcf86ce26mr4729546a91.15.1760716794026;
        Fri, 17 Oct 2025 08:59:54 -0700 (PDT)
Received: from localhost.localdomain ([122.171.18.129])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a7669392csm151067a12.18.2025.10.17.08.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 08:59:53 -0700 (PDT)
From: Anup Patel <apatel@ventanamicro.com>
To: Atish Patra <atish.patra@linux.dev>,
	Andrew Jones <ajones@ventanamicro.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Anup Patel <anup@brainfault.org>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH 4/4] KVM: riscv: selftests: Add SBI MPXY extension to get-reg-list
Date: Fri, 17 Oct 2025 21:29:25 +0530
Message-ID: <20251017155925.361560-5-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251017155925.361560-1-apatel@ventanamicro.com>
References: <20251017155925.361560-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The KVM RISC-V allows SBI MPXY extensions for Guest/VM so add
it to the get-reg-list test.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 tools/testing/selftests/kvm/riscv/get-reg-list.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
index 705ab3d7778b..cb54a56990a0 100644
--- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
+++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
@@ -133,6 +133,7 @@ bool filter_reg(__u64 reg)
 	case KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_SUSP:
 	case KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_STA:
 	case KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_FWFT:
+	case KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_MPXY:
 	case KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_EXPERIMENTAL:
 	case KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_VENDOR:
 		return true;
@@ -639,6 +640,7 @@ static const char *sbi_ext_single_id_to_str(__u64 reg_off)
 		KVM_SBI_EXT_ARR(KVM_RISCV_SBI_EXT_SUSP),
 		KVM_SBI_EXT_ARR(KVM_RISCV_SBI_EXT_STA),
 		KVM_SBI_EXT_ARR(KVM_RISCV_SBI_EXT_FWFT),
+		KVM_SBI_EXT_ARR(KVM_RISCV_SBI_EXT_MPXY),
 		KVM_SBI_EXT_ARR(KVM_RISCV_SBI_EXT_EXPERIMENTAL),
 		KVM_SBI_EXT_ARR(KVM_RISCV_SBI_EXT_VENDOR),
 	};
@@ -1142,6 +1144,7 @@ KVM_SBI_EXT_SUBLIST_CONFIG(sta, STA);
 KVM_SBI_EXT_SIMPLE_CONFIG(pmu, PMU);
 KVM_SBI_EXT_SIMPLE_CONFIG(dbcn, DBCN);
 KVM_SBI_EXT_SIMPLE_CONFIG(susp, SUSP);
+KVM_SBI_EXT_SIMPLE_CONFIG(mpxy, MPXY);
 KVM_SBI_EXT_SUBLIST_CONFIG(fwft, FWFT);
 
 KVM_ISA_EXT_SUBLIST_CONFIG(aia, AIA);
@@ -1222,6 +1225,7 @@ struct vcpu_reg_list *vcpu_configs[] = {
 	&config_sbi_pmu,
 	&config_sbi_dbcn,
 	&config_sbi_susp,
+	&config_sbi_mpxy,
 	&config_sbi_fwft,
 	&config_aia,
 	&config_fp_f,
-- 
2.43.0


