Return-Path: <linux-kernel+bounces-758242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F34B1CCDA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 22:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A64527B08BC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 19:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD832D23A6;
	Wed,  6 Aug 2025 19:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3mUGGDZ+"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFDE2D2388
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 19:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754510272; cv=none; b=rGQutuBvCU6jUZVyKqPHQQ7Spm2AFKIjCmpS18GJuDYfDL3puRNSyydUS1TH7Y8Zzih6M5gAZLvmMcsqvuU2h265Hfv9cc3lxbRxW1PmILp0dhC1zv4NLPDruTwuBJdimiFJx38W+kvgKavJKCOleRCostN1v0w7+NneGGEKKHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754510272; c=relaxed/simple;
	bh=dsL7u0gCksSjkMYlnKFIZN+mhAdNQOloX5K9ddADbjw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=prP/hFRxBSmHWn2nC/B/xwuIqKyTMQDvPNDyxB9JQjo+AVVT4VWrHfAaYAlXMbAIzIYQnmh2QJ2tKMqIxemdxAQAQWY18kD9r46Fdm90/k2SAenqzfn3FuzBI9KhhRIy4OAFPWDpbn76YpWBjEp/M1yWUbH01bVHF0JdMV7sWJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3mUGGDZ+; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-31ea430d543so310739a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 12:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754510269; x=1755115069; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=zcpMdowVJLAIFzpWUVXDuq4S/gKqPMBYO1OzyYmcx64=;
        b=3mUGGDZ+zv7uU59L8Ffhd//Jtbx25i3JD1bz2eGo6Z3VsU1hrc52wMguL5eBGBpd07
         kvDkTu/02am6NGibACJdrCbahTNW0RfmdXOCjn1dkuKsTyTz1JZZ7FXCq+jsI53zSKEd
         xmRm5+ZTX9+Y/FVsOZaiz/UVmhqPc7kemgrGx2gmWvzAgMWJqU+F2/iKGz1j8nzUk21M
         Xa7p7wdmHoynPZahfgtmt0iTe+C7gbcarlY6Py1Y6m2OkkjAldVnkNYOIDhGBbJLmOZ6
         lLYNcB1o6KuUNE4Acbs12URw9MLQiP3diNrz1QbIo0PtMR7sdVyeNA8CCUFWExuDBACP
         rDXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754510269; x=1755115069;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zcpMdowVJLAIFzpWUVXDuq4S/gKqPMBYO1OzyYmcx64=;
        b=F+8F100FjeYeLoKCmaRzyDeBZD6IX1R9XTxDqlO9VnUbIXPmtUcL+SPEaAbFcPnJDu
         g10OVZ8+eMlhyQ5q04vevCwseJevHHi+mGIGlQt0TW/ndh0YL5annfQdSAnewWZOeXiY
         h4VblkGtExJD7aTdBUIWmsiXeRmv7VCYCTp4yKZyZIkxU5dKnK7JoMc3ao0Adg51ogrZ
         v7FJFmSacFSdcBcy34l/mBgy1Qgtrd4Y91tJQ6HgctBYw/0oqV7t8W31ZQMW/j6hhT5r
         Mn5ENGwiwKeUu7/f+dwfRgZp4oN3H1OmZr0Nju8zBHOVCBpHPGfTaz9oM7bJ7hfNsGm9
         ktJA==
X-Forwarded-Encrypted: i=1; AJvYcCW8D9F8i2h+10NkJahu+HBlcuZVnRIYl6t5Dc8A7p6srWT4golaBvErnX9n7TPkOQlVaI6u9x2tQIt2Qy8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL1+6L3sWuJBxZCsCSg7LP+vhI7NbyKP11dk0+lPUMF1D4y7N3
	6PqZLMhKcjiDAYzGoVZAJwSbFZ/ALWno6wIBthMFIfUg+SN5CDbJTGaVfhG9IzY5+YSt3fz3EJQ
	sN8QGVw==
X-Google-Smtp-Source: AGHT+IEVLR7eG3e1/ODg1GEbzlPUzUDlLQzQgQfsonV4iFGNfX+Tq8xQvuZk8V1U7zslQQy51nOqc0FuQr8=
X-Received: from pjtd2.prod.google.com ([2002:a17:90b:42:b0:321:76a2:947c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:380a:b0:31f:36da:3f85
 with SMTP id 98e67ed59e1d1-32167520ee1mr6465429a91.17.1754510268743; Wed, 06
 Aug 2025 12:57:48 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  6 Aug 2025 12:56:33 -0700
In-Reply-To: <20250806195706.1650976-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250806195706.1650976-1-seanjc@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250806195706.1650976-12-seanjc@google.com>
Subject: [PATCH v5 11/44] perf/x86/core: Plumb mediated PMU capability from
 x86_pmu to x86_pmu_cap
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

From: Mingwei Zhang <mizhang@google.com>

Plumb mediated PMU capability to x86_pmu_cap in order to let any kernel
entity such as KVM know that host PMU support mediated PMU mode and has
the implementation.

Signed-off-by: Mingwei Zhang <mizhang@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/events/core.c            | 1 +
 arch/x86/include/asm/perf_event.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index b8583a6962f1..d58aa316b65a 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -3130,6 +3130,7 @@ void perf_get_x86_pmu_capability(struct x86_pmu_capability *cap)
 	cap->events_mask	= (unsigned int)x86_pmu.events_maskl;
 	cap->events_mask_len	= x86_pmu.events_mask_len;
 	cap->pebs_ept		= x86_pmu.pebs_ept;
+	cap->mediated		= !!(pmu.capabilities & PERF_PMU_CAP_MEDIATED_VPMU);
 }
 EXPORT_SYMBOL_GPL(perf_get_x86_pmu_capability);
 
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 70d1d94aca7e..74db361a53d3 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -292,6 +292,7 @@ struct x86_pmu_capability {
 	unsigned int	events_mask;
 	int		events_mask_len;
 	unsigned int	pebs_ept	:1;
+	unsigned int	mediated	:1;
 };
 
 /*
-- 
2.50.1.565.gc32cd1483b-goog


