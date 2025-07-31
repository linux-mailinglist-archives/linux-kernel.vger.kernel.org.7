Return-Path: <linux-kernel+bounces-752030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FDEB170A0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 13:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEECE542A42
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 11:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5242C1581;
	Thu, 31 Jul 2025 11:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b+Wz1vfP"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509DC236431
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 11:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753962711; cv=none; b=HbDjs4uEzbShLUfZZVzFsfwBQUPftPzo7NZTYmbgxgRxYNr2z2D1z9qwEmcTDzOANJgD8dPA6bOzh31KMBBK9pRIpkZDNlRphMWL5pNNAY3F2myj2IXhZkMvq7vztMp9JW6IS057X9S9ZpdeK8/zAOjoPbv1UA5dgm7B0VEXzt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753962711; c=relaxed/simple;
	bh=/YaqQbmjAyDLMKNqMblfPKHKB8Pubt0iKCZQ2aM+B5M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q0WQO5YLW74a7JwPGa3UZHrBNVOT10nQv+LmAR8dky6R4tQ6deqoGjveHM8+2HyY1R5097d+3LlJsCO37kgOeU2SC9YMJW3OzPGBUXv98OK9RIaLLrN9fmvMBO8jCudsT5Ahsfsiqqxz1ZDc/dHDqs3ZvK2qA6U9HgEXQi/UDxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--glider.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b+Wz1vfP; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--glider.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3b7851a096fso294598f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 04:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753962706; x=1754567506; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CXQg+XdaYsLX77wN5kdKJjw9/5umyLhAylJtIjXw9j0=;
        b=b+Wz1vfPIsWWOiHB/Xjdkh1qiXxo5thlpVxzxWiJDaZKTQLFbJU80BpCAuF6WKlnSV
         YqQ9iwlLTXxbamOXTLSk/rDhw/kPQnhFXY88b/ezdLZMRoZTOvCWmgh7FPDrSAaL2DI4
         F3afeLXyZcMNLB16JM9KANAFLZ/yawj8xKaSaEekF0NUyDmF0kUFm/S0+D3cLm5BSTjD
         GJ1fVLFjAe/yc8J7H4X4oq7F00dy7hMN+pxhVDu5AiaXpKkymbBomKZ71FWGYBgcBnUh
         256C3dHG6zrm3KvXWHcmr6F0dfLS9dYwzJbUcUVsFNvU50RfSYhJ+ipPYfRKjHCHCU7m
         DyJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753962706; x=1754567506;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CXQg+XdaYsLX77wN5kdKJjw9/5umyLhAylJtIjXw9j0=;
        b=mjDX4MK+3mRdzqwnDyLy0VTvUhiIGwODNJpckiUvjMNjM+PIz3lDbWwoD+RnvZkNJ5
         zbErr345XW8MDjCPHvoU9ismdN+I0erIEnYwzyySbWV17j9i1uYTKNkGWM+zGQgK0qAg
         2hI0yexArf8Z0j94RTu0gAXLa0pg+o0SOIBjl5kigwHHBuu4aJDWtfo4LvAV3GN1fxGy
         2y8aQYy2DO4cg0jR0nUTQwwhnyxDoFgrTsETsbHT1EVqk1gPG7nvnMuLdPEh6F22qc4x
         MULA2J2L4JTOOAwgzp31PgJQ0UkHPp8sDEQ2v6CcWwVzOhevWZ2nktv84nIhm+aExzaB
         gNOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTmIDjTe9bQqrw4zM9KQMZKIl1daQqzJDgIN8UZ6jNYvmSSn+YaeyNQ19wg3qNWx24NzEVx5bHvJPHQec=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsSJa8uKOE39VaFUv4+AN3HD6ZTjmx25LbFbBX9D1fWooXvAb6
	YPQucOotsWfq106G3KUsu6LLlysuTLAr4YnrXBgaw3DjGVUZFd5Zsn5CXzcwGSFY2g7L/TPqy3G
	9DJWYDg==
X-Google-Smtp-Source: AGHT+IHpZ5VlJorp1XLdO4xxLYlKlSsb2LC7QkiWpuKlb/RDNKu1odUVhKBJq6tTFUk49mJkrqOta4tjDK4=
X-Received: from wrbfy8.prod.google.com ([2002:a05:6000:2d88:b0:3b7:8d84:e97])
 (user=glider job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:3101:b0:3a4:dfc2:bb60
 with SMTP id ffacd0b85a97d-3b794fd3f6cmr5156251f8f.26.1753962706607; Thu, 31
 Jul 2025 04:51:46 -0700 (PDT)
Date: Thu, 31 Jul 2025 13:51:30 +0200
In-Reply-To: <20250731115139.3035888-1-glider@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250731115139.3035888-1-glider@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250731115139.3035888-2-glider@google.com>
Subject: [PATCH v4 01/10] x86: kcov: disable instrumentation of arch/x86/kernel/tsc.c
From: Alexander Potapenko <glider@google.com>
To: glider@google.com
Cc: quic_jiangenj@quicinc.com, linux-kernel@vger.kernel.org, 
	kasan-dev@googlegroups.com, Aleksandr Nogikh <nogikh@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Ingo Molnar <mingo@redhat.com>, Josh Poimboeuf <jpoimboe@kernel.org>, Marco Elver <elver@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

sched_clock() appears to be called from interrupts, producing spurious
coverage, as reported by CONFIG_KCOV_SELFTEST:

  RIP: 0010:__sanitizer_cov_trace_pc_guard+0x66/0xe0 kernel/kcov.c:288
  ...
   fault_in_kernel_space+0x17/0x70 arch/x86/mm/fault.c:1119
   handle_page_fault arch/x86/mm/fault.c:1477
   exc_page_fault+0x56/0x110 arch/x86/mm/fault.c:1538
   asm_exc_page_fault+0x26/0x30 ./arch/x86/include/asm/idtentry.h:623
  RIP: 0010:__sanitizer_cov_trace_pc_guard+0x66/0xe0 kernel/kcov.c:288
  ...
   sched_clock+0x12/0x70 arch/x86/kernel/tsc.c:284
   __lock_pin_lock kernel/locking/lockdep.c:5628
   lock_pin_lock+0xd7/0x180 kernel/locking/lockdep.c:5959
   rq_pin_lock kernel/sched/sched.h:1761
   rq_lock kernel/sched/sched.h:1838
   __schedule+0x3a8/0x4b70 kernel/sched/core.c:6691
   preempt_schedule_irq+0xbf/0x160 kernel/sched/core.c:7090
   irqentry_exit+0x6f/0x90 kernel/entry/common.c:354
   asm_sysvec_reschedule_ipi+0x1a/0x20 ./arch/x86/include/asm/idtentry.h:707
  RIP: 0010:selftest+0x26/0x60 kernel/kcov.c:1223
  ...
   kcov_init+0x81/0xa0 kernel/kcov.c:1252
   do_one_initcall+0x2e1/0x910
   do_initcall_level+0xff/0x160 init/main.c:1319
   do_initcalls+0x4a/0xa0 init/main.c:1335
   kernel_init_freeable+0x448/0x610 init/main.c:1567
   kernel_init+0x24/0x230 init/main.c:1457
   ret_from_fork+0x60/0x90 arch/x86/kernel/process.c:153
   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
   </TASK>

Signed-off-by: Alexander Potapenko <glider@google.com>
---
Change-Id: Ica191d73bf5601b31e893d6e517b91be983e986a
---
 arch/x86/kernel/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 0d2a6d953be91..ca134ce03eea9 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -43,6 +43,8 @@ KCOV_INSTRUMENT_dumpstack_$(BITS).o			:= n
 KCOV_INSTRUMENT_unwind_orc.o				:= n
 KCOV_INSTRUMENT_unwind_frame.o				:= n
 KCOV_INSTRUMENT_unwind_guess.o				:= n
+# Avoid instrumenting code that produces spurious coverage in interrupts.
+KCOV_INSTRUMENT_tsc.o					:= n
 
 CFLAGS_head32.o := -fno-stack-protector
 CFLAGS_head64.o := -fno-stack-protector
-- 
2.50.1.552.g942d659e1b-goog


