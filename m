Return-Path: <linux-kernel+bounces-651958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4FBABA52E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 May 2025 23:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 350D91C00AD0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 May 2025 21:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80EA28134A;
	Fri, 16 May 2025 21:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EHwsbHb6"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F5228030D
	for <linux-kernel@vger.kernel.org>; Fri, 16 May 2025 21:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747431011; cv=none; b=gAfw7znpDHguGFKtBsGkAfs4Vu/D9HhxIY6BPBXZv9WO3fnm7R9WsP/7M42JNOTLiaf9E7/xMRePWUtLlDhB8hAQaqJluOjVvvCtS1rbrfKMZ/H4L1dFJQEjJETjf8L+1HidC+94tAmfJjYXcg/rNIG9obvNBbQhyCLobQDQwkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747431011; c=relaxed/simple;
	bh=DIrrcPlHnq5EeZRAr8HvqCuhe1CzBiwfAT2oWIINOSE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GLbyrUGvq/7hAHyBri5oZ6lEp2/XyZkwjaq04ZtrY2Yl2kDkxbiaHODKjzeFeFJa2os5OdqJyRBh8dd0X1PRXagHWnu1Yrpjeu9OupgK9iGajDbKFLwPD1x7F57kpQB49fAqnHcgIU1kA2NMQevssksVuK4lHGq2nn09LO2a15I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EHwsbHb6; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-231d7f590ffso9292275ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 May 2025 14:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747431009; x=1748035809; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=NqEHUZ2TPYAtGToYJi37fXESd2ZGwlNQjgbzr/1LJdY=;
        b=EHwsbHb6b4nydBI5mtDrWco7DDoaRbTr4XyYo+L9P6RrxK4689dEWQMgG6G6m2DatD
         GAnN+P0CNRAglsp3KI6G7O1CSYGIY7lG8caLVxo3eqgRZykG4RHjg3ScUaiCFSyd0PNt
         vCKKpzYQxbC8TcGL+rocujSmtSv8gTiCYfzWCEVPoCu8xFoOPPlKmXvAahXNDK5+Y0Mo
         0CWrU/uqwoINJ3/2OKm5kh2zAz/wdC3mBrviC0DDrhMfwjTb4eQvF0p9glvbfD+pYuyu
         X/l3/hS9NZzEuM40CyDqodKpdXmZ1fqifZ+aAqJMSmlJjp24BUJk1HM0XKZ4jGDFZH9p
         uoGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747431009; x=1748035809;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NqEHUZ2TPYAtGToYJi37fXESd2ZGwlNQjgbzr/1LJdY=;
        b=U44G27K00gD/1SMIEq4AHgWbtLTl+UYtzQAJjq5vLOH3GQB4JrxN+p+gbhUr4OCHb2
         Yv8ym+zCQSswCSvPaYn5bG7R/0BrLCr8kTYamrM8OSoizmjjzxeIhP1voTVoRM6HFYoT
         OAPlfBAOPGO752UB21Y4Qrk+lqDD7jQtcdq13A5JekOFouvuGJhZYEG2aDIKmSxR1hYE
         fHoc9Oe0wMiWXyXeWb5QIV5JpgP9nZl4laAaQL5lMXB/8bYdIKKI0+f/XsPWfDxO9FrL
         5NN0ya1WILFuAz0SD0rUaEzK0mhcuMjD3DEABdpiJxsPxOzhSTza4VJHI9Bulf4Ci+Qx
         02yg==
X-Gm-Message-State: AOJu0YzVpMPdvRlmTh3GM/Y6IRbsr5UwZuBDZ8leSLz8c2Rwc6wVq+r6
	7gGaj2Zr0v5fMaQAxnabEhPMZVo47T7o8ifAr9GPKLuBzeF6JyiGVaJsXlH4u0gvHLy2JdoOYRy
	QHFzM+Q==
X-Google-Smtp-Source: AGHT+IHTq80VcqezatgmWlMunNaSOj4mkdrzwcQ+8bhQSnlwEViznyKrv/5A/SubVqL2ubXidQVjO6bdruo=
X-Received: from plbp12.prod.google.com ([2002:a17:903:174c:b0:223:52c5:17f6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d4c5:b0:223:faf5:c82
 with SMTP id d9443c01a7336-231de2e6c76mr46558255ad.8.1747431008643; Fri, 16
 May 2025 14:30:08 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 16 May 2025 14:28:28 -0700
In-Reply-To: <20250516212833.2544737-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250516212833.2544737-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1112.g889b7c5bd8-goog
Message-ID: <20250516212833.2544737-4-seanjc@google.com>
Subject: [PATCH v2 3/8] x86, lib: Drop the unused return value from wbinvd_on_all_cpus()
From: Sean Christopherson <seanjc@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Zheyun Shen <szy0127@sjtu.edu.cn>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Kevin Loughlin <kevinloughlin@google.com>, 
	Kai Huang <kai.huang@intel.com>, Mingwei Zhang <mizhang@google.com>
Content-Type: text/plain; charset="UTF-8"

Drop wbinvd_on_all_cpus()'s return value; both the "real" version and the
stub always return '0', and none of the callers check the return.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/smp.h | 5 ++---
 arch/x86/lib/cache-smp.c   | 3 +--
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index 0c1c68039d6f..028f126018c9 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -112,7 +112,7 @@ void __noreturn hlt_play_dead(void);
 void native_play_dead(void);
 void play_dead_common(void);
 void wbinvd_on_cpu(int cpu);
-int wbinvd_on_all_cpus(void);
+void wbinvd_on_all_cpus(void);
 
 void smp_kick_mwait_play_dead(void);
 void __noreturn mwait_play_dead(unsigned int eax_hint);
@@ -148,10 +148,9 @@ static inline struct cpumask *cpu_l2c_shared_mask(int cpu)
 
 #else /* !CONFIG_SMP */
 #define wbinvd_on_cpu(cpu)     wbinvd()
-static inline int wbinvd_on_all_cpus(void)
+static inline void wbinvd_on_all_cpus(void)
 {
 	wbinvd();
-	return 0;
 }
 
 static inline struct cpumask *cpu_llc_shared_mask(int cpu)
diff --git a/arch/x86/lib/cache-smp.c b/arch/x86/lib/cache-smp.c
index 7af743bd3b13..079c3f3cd32c 100644
--- a/arch/x86/lib/cache-smp.c
+++ b/arch/x86/lib/cache-smp.c
@@ -14,9 +14,8 @@ void wbinvd_on_cpu(int cpu)
 }
 EXPORT_SYMBOL(wbinvd_on_cpu);
 
-int wbinvd_on_all_cpus(void)
+void wbinvd_on_all_cpus(void)
 {
 	on_each_cpu(__wbinvd, NULL, 1);
-	return 0;
 }
 EXPORT_SYMBOL(wbinvd_on_all_cpus);
-- 
2.49.0.1112.g889b7c5bd8-goog


