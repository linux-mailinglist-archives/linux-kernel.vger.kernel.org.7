Return-Path: <linux-kernel+bounces-758244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B750FB1CCDF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 22:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 931DF18C5249
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 20:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5485A2D3A9B;
	Wed,  6 Aug 2025 19:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sKnxSDF6"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE532D1F69
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 19:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754510276; cv=none; b=qbCSmN07EqJ5p/mpxAn/DE+9DlDeWYf4QZsGY0pyqImCPtlCTApy5bVfDAqXopnQwK3Lu9ze3Fa3+RSIltKTxI9EcIpyxjhxhXAymjjtqvSmVtRcP1+mN6i00y8DcfIo5D5e0qmRHSVnqjM02ywOCu8xeZZl1JwSkJ47MOPjVsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754510276; c=relaxed/simple;
	bh=jdq1crWcKn8y7XDSp99YavaEpnm3s9VMlFDhCc8MHB4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kBdXckLypCvE0BIOYN4V6SEyu7AK++Ue78GxErP3dCUAxhf8mmV0BxKFrRuz2JFwgCtUIBqBZ5KQt5Ce15PyLJmG35bqz/tQLKvNZnQqxViF0cqI2ACPlDDEcmXS3G+z2Eia+li/HdCIW2XoOeeRNH89Ifv/ktdTq+X4I4IFHlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sKnxSDF6; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2425e41424cso2203705ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 12:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754510272; x=1755115072; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=YZMeMFDLZr+yCjindHzAam67OkhMlNf3hlQ7J9N+n2w=;
        b=sKnxSDF6OzUh1O9m+DYJ84S2phrfAp9JUuB4ymZSub5iyiXZPwdD9+IbR2QFOZBYxD
         vhJbTii22o6Wo1vGPh4cm1O3YetTXyoXrKOP3k1HTndboNPVO909lBkA+/pq9vNsvZKo
         PgjMTdMNx9il0FdTnhxGhMUZcpNbFDfPjPAhOCj7WYSbGgMuzDooW4giPYpLxETuL5w3
         /HtC4trCo/9jY6SSalI+/37npQ5ZXErfi5ahnGlWevemkZHGbaHH+YB6onilxP70llNQ
         lhtWVmA3bK4Qxxe/xQRV7LsbLGXqnnWRCRkBU1BC9Z3q43WdnWisiyieuThBh7Bo5WTb
         1ugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754510272; x=1755115072;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YZMeMFDLZr+yCjindHzAam67OkhMlNf3hlQ7J9N+n2w=;
        b=B5BK0Fc5egzLP2h8zRjHA1lZuHkW44JKZXFdvVX+i4MhgkVUwSoii22c25Kwr9pYrD
         LLZDGwxu+U5azZsPjZlaFNe5jks1hvd1CAe9p5Q960B1+QebRBWQZKwe5fFDJsw4/f70
         l2jdP3dAjtlfO9v0WZZHFAw5d7+ww/xEzsBVj+/ajnF0IJS2KghFfzL+3YvrDaLZitI+
         S4hrnAyILSJ59J7HYtfumEs+eRg6+LQeZDLud/bWOh5ZL6sDqxUYudZP9USAz7x3fUqB
         WxoXbdvzS30Zlwj2PyWHKrVws0h9K7q7jY5cAFqWcr/7AO9VCSspqRu51JJmheFKBwZz
         grgQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1COx+OUVa2Veth4oYYDhhoF0IpfHLWpVBleqJ34f6HrEqgUlL8aSofDjY8cCJECpUcfgPUtwpi5ksw4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxssNLPq/ez1CRHpR15f7aUXP/pecYUoFMHOgqbflYVrFCZkm6k
	wbjHN4UZmFlLElrdBznx3KZbXrlm6chMHCVSiusAKzdflcsM0YnUsYFsXxynuwsmYM+Px+27yTZ
	UvuP11g==
X-Google-Smtp-Source: AGHT+IFt32OpTUGU6us4Rz359zlOuJVL+j3ifqAbqQAET68s3resGqbQqEcv8vf6Ss5FatBMSRwumXjkA8M=
X-Received: from pjbso3.prod.google.com ([2002:a17:90b:1f83:b0:311:1a09:11ff])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e784:b0:240:9f9:46a0
 with SMTP id d9443c01a7336-242b1aa312cmr4180365ad.38.1754510272385; Wed, 06
 Aug 2025 12:57:52 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  6 Aug 2025 12:56:35 -0700
In-Reply-To: <20250806195706.1650976-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250806195706.1650976-1-seanjc@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250806195706.1650976-14-seanjc@google.com>
Subject: [PATCH v5 13/44] perf/x86/amd: Support PERF_PMU_CAP_MEDIATED_VPMU for
 AMD host
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Xin Li <xin@zytor.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, loongarch@lists.linux.dev, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Kan Liang <kan.liang@linux.intel.com>, 
	Yongwei Ma <yongwei.ma@intel.com>, Mingwei Zhang <mizhang@google.com>, 
	Xiong Zhang <xiong.y.zhang@linux.intel.com>, Sandipan Das <sandipan.das@amd.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

From: Sandipan Das <sandipan.das@amd.com>

Apply the PERF_PMU_CAP_MEDIATED_VPMU flag for version 2 and later
implementations of the core PMU. Aside from having Global Control and
Status registers, virtualizing the PMU using the mediated model requires
an interface to set or clear the overflow bits in the Global Status MSRs
while restoring or saving the PMU context of a vCPU.

PerfMonV2-capable hardware has additional MSRs for this purpose, namely
PerfCntrGlobalStatusSet and PerfCntrGlobalStatusClr, thereby making it
suitable for use with mediated vPMU.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/events/amd/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index b20661b8621d..8179fb5f1ee3 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -1433,6 +1433,8 @@ static int __init amd_core_pmu_init(void)
 
 		amd_pmu_global_cntr_mask = x86_pmu.cntr_mask64;
 
+		x86_get_pmu(smp_processor_id())->capabilities |= PERF_PMU_CAP_MEDIATED_VPMU;
+
 		/* Update PMC handling functions */
 		x86_pmu.enable_all = amd_pmu_v2_enable_all;
 		x86_pmu.disable_all = amd_pmu_v2_disable_all;
-- 
2.50.1.565.gc32cd1483b-goog


