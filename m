Return-Path: <linux-kernel+bounces-758243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B82B1CCDD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 22:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE4AE56258D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 20:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DB52D3750;
	Wed,  6 Aug 2025 19:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pGBJ+uSW"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E782D239D
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 19:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754510274; cv=none; b=fI3Bo8y1gSKUWRT3uyx3k8jdXf8ivSahqAIZ78l9YksBzyRli6PpyxAGOulu3U10tDiJxd2WJnKdxwdoKBD81S1swwXl9x+qhE7QEeIavXmam4FSRosM4tCvRGk7XAPhVnA3F1wOXWHOmJKRDx9xwAp7Q8pq5JUQVoaq9B+kdOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754510274; c=relaxed/simple;
	bh=Bb1MCKlidS4HUVTcCu642tswWStbNqiXpa6NcxDtYbk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QSxj2CVBKd6mGFEPT9wTWvip6u/v7C8Hjczv0QfwX3p30F2wz0BKhDJyh4zVixh2pn1+dhlEfFg9MHFLiXi0dfGrUWiEG0w28jiTXACHbfiwc094GWrMQJqkn5RNh6Cm6h06vkXJlf3G+WQMKAk1R7NYmkpu1G8Mxy9jM79HExM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pGBJ+uSW; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-31f3b65ce07so464451a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 12:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754510270; x=1755115070; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=P+6kUSR5aBTgNcunERrWOcQMCZiG0moZeRQ0turCJ94=;
        b=pGBJ+uSWmY4u2nY77yBijaQ3pMQAq32EqtGrVokpellFCEw6GPtef9oej+go+VN3I3
         Sq5svNwPiH82SYrZeJinnAa2YMkUdBujXyglUR2OImyeJBRhKpQQpG9py2/v+3G+ncOF
         7Rf40w9xO1TFBSjh0FXPu0hKqPe2JyHd65kH9G131jwI3FhQBBCyM4hJ0Ta6e80/z12d
         fhLNiCtFwFINpHkrfbI9nghTiO+tUfM+UnARDMfORgb4jyveWWhsAOcuMIaFmVAk54QK
         /k9KAWqE/sn93EILPowyW2z9Ir91XNmlVpr+XHtFxbpxWP4gWBn6Ik31zh4M8hY1uDwi
         qRQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754510270; x=1755115070;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P+6kUSR5aBTgNcunERrWOcQMCZiG0moZeRQ0turCJ94=;
        b=fZDb4XfSKUckNPqtuyaC4LeD/4codAbMloqwNzQNeDTeNy+42hXkiy8zzPaY75KYyn
         SuXn+/tyh5CkD6dYdBLlLXqExND86UdCh63bd6YeMyUdfo1kSl/CU1RQJvTonzyUGoL9
         4FbcM6TOl5JUA6Qcwm6qkmEC2FshZ+gyE0lhp1ndRFzvNIRWb1h4/dogA+0INhHMq1bu
         9HN5JnVjXWi6UJtmWp0LM0IKphJ1o5jPBm/4FXzu/Yb9K/Dss3p9EpaSS6T99FNgdnKs
         7Qav9bzTUNjPbNQSi/vUIyPtTOWIjNXoyjJ6lpHDYAJozadTt4SSCtUQhbGm1teXinFM
         1Fdw==
X-Forwarded-Encrypted: i=1; AJvYcCUsZta9VipxzHUq+aOqtoh783z2A7hlpcNEIWRYNXknclD7KttDetpz8gGtYt4wa9CeycqrFRwdsEu4Fdg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd7qTIhmmCXFrSLeqboRkzG1+j43fpUN/5S3H1yQq5YTDHHyv0
	SrdvY6dqnv0sq4/WvVsjqWmyJrbWnA5W7grphygMJ/ramCrbQBqKOekG4cd8OqITnsG1vTRUyxR
	+fSDgSA==
X-Google-Smtp-Source: AGHT+IF3NS6j+zPTC7HBpb/PhEo054/sULoDCrTNDdSbB3JBoD67HO9NJP/SyaYTvqhMXFbG0IGQUgBSmnM=
X-Received: from pjbeu16.prod.google.com ([2002:a17:90a:f950:b0:31f:28cf:d340])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:e7d0:b0:312:ea46:3e66
 with SMTP id 98e67ed59e1d1-32166ca3f0bmr5365514a91.21.1754510270478; Wed, 06
 Aug 2025 12:57:50 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  6 Aug 2025 12:56:34 -0700
In-Reply-To: <20250806195706.1650976-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250806195706.1650976-1-seanjc@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250806195706.1650976-13-seanjc@google.com>
Subject: [PATCH v5 12/44] perf/x86/intel: Support PERF_PMU_CAP_MEDIATED_VPMU
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

From: Kan Liang <kan.liang@linux.intel.com>

Apply the PERF_PMU_CAP_MEDIATED_VPMU for Intel core PMU. It only indicates
that the perf side of core PMU is ready to support the mediated vPMU.
Besides the capability, the hypervisor, a.k.a. KVM, still needs to check
the PMU version and other PMU features/capabilities to decide whether to
enable support mediated vPMUs.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
[sean: massage changelog]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/events/intel/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index c2fb729c270e..3d93fcf8b650 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5322,6 +5322,8 @@ static void intel_pmu_check_hybrid_pmus(struct x86_hybrid_pmu *pmu)
 	else
 		pmu->intel_ctrl &= ~(1ULL << GLOBAL_CTRL_EN_PERF_METRICS);
 
+	pmu->pmu.capabilities |= PERF_PMU_CAP_MEDIATED_VPMU;
+
 	intel_pmu_check_event_constraints(pmu->event_constraints,
 					  pmu->cntr_mask64,
 					  pmu->fixed_cntr_mask64,
@@ -6939,6 +6941,9 @@ __init int intel_pmu_init(void)
 			pr_cont(" AnyThread deprecated, ");
 	}
 
+	/* The perf side of core PMU is ready to support the mediated vPMU. */
+	x86_get_pmu(smp_processor_id())->capabilities |= PERF_PMU_CAP_MEDIATED_VPMU;
+
 	/*
 	 * Many features on and after V6 require dynamic constraint,
 	 * e.g., Arch PEBS, ACR.
-- 
2.50.1.565.gc32cd1483b-goog


