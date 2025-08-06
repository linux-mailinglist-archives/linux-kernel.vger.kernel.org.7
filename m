Return-Path: <linux-kernel+bounces-758240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FDEB1CCD9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 22:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F32FA5671F1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 20:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82AE12D29D7;
	Wed,  6 Aug 2025 19:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eMTwdtGF"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4FD2C08C0
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 19:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754510270; cv=none; b=lAfW/aPeiYgGfCnTbLIvCTm6mWLZoUoiJYF9FF1dNzw3P0GRzXrZP41Zfa2ec52w7mETytw3Rsl0luQ5NwJjtsC1uAXzidDNjnny1WeqSgxP04BvP3VSPbgu0mgiSlmeVTZiLZtE5/rpK7jUhw115fabf+mbi9/y/EIxGGGoNr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754510270; c=relaxed/simple;
	bh=5aUcvaWHp6TRUDOiSNC6KCm1Cyy80ztm2LX/UEyRYFs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ggSkvtLtHyDNIa8RMtQIbax2/Ga8a/TaZ0sfKaSMl8mj8gxB7mpSN6Upx2E2m56ZBvFBuOK8rWsD8KeoHRdtVs1dD1cxfAjNywwjd08cJkOjwsklRh9AkvNiwfoDYvXbGV5+lKgfaK7A83rRqHcuFByWjqUbFHtzhLcTMH90MlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eMTwdtGF; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b3f38d3cabeso111803a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 12:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754510267; x=1755115067; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=V6GitVs58LgSs5T9j7jt8hclUfm0doY6DCHFmJ55L1k=;
        b=eMTwdtGFjbvVQoXhRX/iyjkk815eoFubGn5kVNq0OdKfwh8Krtaq8ybEe0Gxzu/O+y
         KIsvZKJt1zp1pLtuiSr0kP2cgPKDL+AUZ54lUBwztyui30nPWwS4LZKjT/nZdA8WwAhk
         VNzALLYK3IDoIunP6Qmc1d2mum6nH4+Jironf1gTMd5ex9ENVAVGks/Jt0DRzUjggpnb
         ny78NS0xfSgVp5cx0nd42nL+Uv4G3FMou6JzaJ8z+17elLLZNEV440l51x0TXcAfVjo0
         zCtJyGPx/sIeN9oxibqxA6FfQjCMYe0q+DT6F0Ry643QWB+ORqn4rYBFWj91C/TSS2LA
         UVpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754510267; x=1755115067;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V6GitVs58LgSs5T9j7jt8hclUfm0doY6DCHFmJ55L1k=;
        b=UM7mO79mLXx/7UkzshdfpbKGtvAwAP7GPRssDPrmrv48theJpw5vCc6daU/1vE0gmG
         wGK2l3z3OwEB2LCjpF8vrbK7nd8JxkhBCl6oSG0lcNmlBV/Qn3Dq/F9qu4222osCRUnQ
         9274vsy3hb0XPvJMEifCizu87L9KZJ079aM2qOu6jgHo9CqEEiHY/he/xcLrcXQo6jsy
         5XYj9HkmdHEV6rTuEvPAfEg4wGVfPjZc9crI5tWCSslfrfeXYXLpzmIpyVvphWy5IY3w
         50JTO7OaOgD7tQSD1jvagijKdg/xF0mjcOsQ8jSUnAUaODcMzrp0pZd3qJFlyyBWD27R
         dqOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWziCjAstRp2Gy1nUiUn7AtNGATxS3BBPhWlPMA0BtGje6I6kFB+oRQYBLDL36mD1ZqTJjqWC57+pefpaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzfK7Qhe84qOFh3CMFnQOU0A64uaZG0ejy9K78UDCeaB4T0Wr+
	kVAsA5btOJQaodT/mm3AtR+C8H2a3/3K0dcDobdvVBpU3dHhWTKxD9HrZiuGCscvfopa94H/49x
	2DRSvQw==
X-Google-Smtp-Source: AGHT+IEe9aouosNHmFsjzcywZl+bDxrMa7gzbIrywT1O9OJ/U5YazLpsqSIEAJkZctqsm307cXJuaDMPuPY=
X-Received: from pjbee13.prod.google.com ([2002:a17:90a:fc4d:b0:311:462d:cb60])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2743:b0:311:fde5:c4be
 with SMTP id 98e67ed59e1d1-32166d06ed8mr5169966a91.35.1754510266366; Wed, 06
 Aug 2025 12:57:46 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  6 Aug 2025 12:56:32 -0700
In-Reply-To: <20250806195706.1650976-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250806195706.1650976-1-seanjc@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250806195706.1650976-11-seanjc@google.com>
Subject: [PATCH v5 10/44] perf/x86/core: Do not set bit width for unavailable counters
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

Not all x86 processors have fixed counters. It may also be the case that
a processor has only fixed counters and no general-purpose counters. Set
the bit widths corresponding to each counter type only if such counters
are available.

Fixes: b3d9468a8bd2 ("perf, x86: Expose perf capability to other modules")
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/events/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 9b0525b252f1..b8583a6962f1 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -3125,8 +3125,8 @@ void perf_get_x86_pmu_capability(struct x86_pmu_capability *cap)
 	cap->version		= x86_pmu.version;
 	cap->num_counters_gp	= x86_pmu_num_counters(NULL);
 	cap->num_counters_fixed	= x86_pmu_num_counters_fixed(NULL);
-	cap->bit_width_gp	= x86_pmu.cntval_bits;
-	cap->bit_width_fixed	= x86_pmu.cntval_bits;
+	cap->bit_width_gp	= cap->num_counters_gp ? x86_pmu.cntval_bits : 0;
+	cap->bit_width_fixed	= cap->num_counters_fixed ? x86_pmu.cntval_bits : 0;
 	cap->events_mask	= (unsigned int)x86_pmu.events_maskl;
 	cap->events_mask_len	= x86_pmu.events_mask_len;
 	cap->pebs_ept		= x86_pmu.pebs_ept;
-- 
2.50.1.565.gc32cd1483b-goog


