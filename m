Return-Path: <linux-kernel+bounces-791933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3B9B3BE1D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 16:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AA9E462C49
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 14:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5443218CE;
	Fri, 29 Aug 2025 14:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="EtK8PRuo"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E136031CA76
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 14:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756478473; cv=none; b=X9iozJ6ahhmoRlB7zNEzS5ZD6coNf57prfBgWpOkZGl3yxtdrNv1rqs0nt11GMizYPAdrdhl/LA250m9Ar0351xV2znWLypWOXDNJAQCo1dY/wlurS1pRiqoWQSeI376mMwB/ZlgkAqvxhJcXAI2f4OWgskSLrwTR1rvyFkDOUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756478473; c=relaxed/simple;
	bh=e7KhWyihGNeHQtmANrYGamMrWZjvNUfv+srLihtniBI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OrsDWjKJRrYmy1h9eSywnHqI/exyN0IE+J86lw6ylpFk0ww6IiLKkQaJV/lOFykOaTHoanRxtwLHiU7CpAwU6JdI9yiGWYAuvwTCprKqpXYzxIHU6RlQZAR2MuL6ASsY9m01k/gtf5pnQ8+/1mneXQayhtoUgZ4sPDFQ/lMnHCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=EtK8PRuo; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-771ed4a8124so2241977b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 07:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1756478471; x=1757083271; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=goqLKtDob+ZNX+w3rmmnq6+zF8DlfuvYjDiKv2ieDbU=;
        b=EtK8PRuoWOe95IqWtOpL1KDEh2Pv3PO+5PrWMXKT/e+2YbjNsIRDwLBkgVQIxjvmzq
         6WVDsFecW5MYzFjYAHag/p/IKLpCSnnCTNZ7vs/AfxVDUnnuJlcB42VhRWcflO3TfNDq
         VDBspTSvPpdaDfmpW0hyd9s6mw/zJ7Ulu5Tv987en4c0yRnSuLDgTQ9pFRLJXOjPPSKm
         k/mUUMT4AndDNwpO9TmKLQMAgl/bR2jcs1Lr+CeO259qwJ4RMqlTCqzVP+hcGwDjlZ+4
         k0Rq9QXNBSzi9ohKZTY98Zbo15iK6jhsGDwbnLOYYvez9PCbTIk8LSVgP+1CPglTBiih
         XvOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756478471; x=1757083271;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=goqLKtDob+ZNX+w3rmmnq6+zF8DlfuvYjDiKv2ieDbU=;
        b=TC2PjmRiKPhVHUaqaoDFjC/LicfgGmt6vaBFl3IkrfweGRLP+mkCNsM3OLUXd/Xbwf
         jZkLOTmEIL+mrvp0sYErImAfG5dlUZxWcbz+2btrxSAqsFJjxKE3uW3Dv8bra/QehhsD
         ZIS76AN8+D4wenpJkUACemSh5FFM8mgvow/LNl/vatH2MnH768m3kr6ZQgui6MLbB45U
         HXXoHFS0IoLM0jJSypZqLtzWUQUmpmicDqf4Sg1Ysvka+KgQk1iT1DDBaPRkUQcdkwrN
         CZEqyVleZf539OnHiGqzoKLH/NFghG3HrlyU/bL3f2iczB8CWMfty1Pa9hDVXsXjjELe
         A3wQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtT6JkYsbqjK/sZA1CfqexSNMBMqTydGk0kC8vQynA5UGPs8ri2l0meqvPYUmmCjPGmNmTG066qx1uCDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeeCitXQoC7TZ765n0/Nr7N1ep6PVtzypYg7NDi2pDANnxiejX
	fNdkkn2dEzxVUcuqnBRDM2pt+JxLNUHx5hFMmR36MZYtC32KfZtIeSDDAb2FbqGGL4g1CRNh71Z
	5+9TG
X-Gm-Gg: ASbGncs/iO1MSJ3wP2plKyrEDY75cOPZQBsiK63gsO0o4i2S2LGO9baSTFIIID79kHT
	Y5vwswhTRAXqB+P1blDnBXWbtR6v2xrA69jnCESzNDyBhRVALMEL6nOnzzeQww6HRjEHOrtFYR8
	TjF+NQiZfa2wOSIxItrzyi4Cj16WDC9noXYaSaoIwCBCSUt0xROi4UTh1wTn+i7fwt3Bg6F0dr2
	8kGYtPwWopXucFv6XgB3YN2GwcIcG+AbqZeYqlRblWJeIFWDktoUuPlwIZLFSP2BwHCMd3VmGP3
	tewddktLaK+8vugy6jDNNASTLcc7kBbSx+1Mq6M8yWJznXKIcFY7JgcsREdzMWMXWRbHZ6GNzh+
	btqgA0Re+L9caw3a3Jj4e33pztJnOcJu4tXzprFbhe9WEs2nfLv1baBFE
X-Google-Smtp-Source: AGHT+IEjIYlQyj5LF8L5OMDqDMzS8FXoLsXKsGZxQnXqTFQeAwVRK9v09HJ44UP8l3p9Cu40jXYhVg==
X-Received: by 2002:a05:6a00:4f92:b0:772:38a9:4d98 with SMTP id d2e1a72fcca58-77238a950ebmr927358b3a.13.1756478471237;
        Fri, 29 Aug 2025 07:41:11 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4e1f86sm2560999b3a.72.2025.08.29.07.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 07:41:10 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
Date: Fri, 29 Aug 2025 07:41:04 -0700
Subject: [PATCH v5 3/9] RISC-V: KVM: Add support for Raw event v2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250829-pmu_event_info-v5-3-9dca26139a33@rivosinc.com>
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


