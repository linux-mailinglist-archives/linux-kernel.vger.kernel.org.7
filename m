Return-Path: <linux-kernel+bounces-748232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB2AB13E44
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 17:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 118AA7ACB00
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 15:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D75273D7F;
	Mon, 28 Jul 2025 15:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bhL4Q0op"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5C6273808
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 15:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753716363; cv=none; b=aC3YOWcs6jo96WpkUn6apBiDkRcKa5LjHs5wnJJaF0w/X2OGxrM1W6Oy5+HvmdpW/5ezXne6VtQH8okTWqzup7xocuvuAJvhdivnjJfAZ/MRSlUawe8p1Bqqu4TEmT4qr0Zwc5OS1/CFojFciCXl0QQ0W3wyrT/Km7zxpSVXMJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753716363; c=relaxed/simple;
	bh=gVNBX5v1fHfBF+/rvqTg/Zf4VYqZlUkchmACzkZ+K8k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gdB7UDqYkEq3DDRvlA5TLHzh2wrexT9FXiROo8QcoQU8rcSBMtKviuWSG0TvRrfc0X993bz5L0GFVA9s5TO0FC8RW3BWxLLfoQFaiFTpUqme5dKLwU3V7vSa00O+DuG6tyeevVzykmEh0FaRZc1V5Mv3DKViDiGDb/OihLITEfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--glider.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bhL4Q0op; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--glider.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3a6d1394b07so2713929f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 08:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753716360; x=1754321160; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hA2z1o4ZKLpPx/4s7kZhiOi+XbhOvD8L3886s5YuSNo=;
        b=bhL4Q0opoJ/IKJx/b2RNy+2CFvGgbJKGlZyZTUNmaKzu5F6ChN0kL+piBenWBWQvQ0
         uJbBrYgUsd32cFd2RvHWajRVON25UWfxfCVpGOUZOA8HMp/RZSrUGP6ZAriH2KMmWJpl
         dMEopspM6qZoDi+dmpv5bpGqdNOSr5/GSMRSEM3/b+SMMs4vKKxJL/a1oQ12phT8SKlD
         giZqTzhl6Cf954O3Lbi49bEO4aYMiCMoeeT8dIPeifv57CXiAt1yf1UrL/S5E2o3cP9I
         zuS77w2p/PDQmxpGCXYx37ov6HZjQPzmmfniaWrhA/bletbc0gk8jPizm97j3yZs2AQH
         WwCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753716360; x=1754321160;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hA2z1o4ZKLpPx/4s7kZhiOi+XbhOvD8L3886s5YuSNo=;
        b=Hj5Uh3jjAUURtVYzOfP5fyxSXRdAw4PYH0IwPwGUc67RXMUSOgUTOgcTLQaw1TEAP/
         N3vGUDmYHp2FzolJe9VpVd3WsBftIQzHOX29BBrzvwsbcFGtJohFiAJtu58hzKLTwflw
         ho+XVVe+9Jm9pBm1F0LTDPsJsqg1q5Wt7OCFf9GuVucnDVPXOxp4XR/1nuuZ/+bOrIN8
         Ycdtapbp8qvCv6fOXdChMvcAsrBAjF1Ruh/qr5EQKUtbIPOiczbF8XloZSSbSYNfr1p4
         LZ3uB1YsUGUfXOqUsySQpKG7oH/l0HzyYVLHIEEJSArbmEq0C/Dt9ha01xfGZdSl2UDn
         mdFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnVIJgqsyqqRM5qS23bDzCzwZQoKfcliy1Lfm3PoyjrMPraHvap/VDaBnZ+3Gj8L+6NcUhr6g3CqVVYTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVa09aHQaeYEWrLRi2FN5R/Jga/QJIrT1Q9OjKphLsLGhECSVA
	Dd6L0NP6P14Bna8Nu9UER6MuVmdVoBexwiM1EUTcCItvF0wjrxDliScSr9T91kQotQBMHEvhFDI
	SC5uwVQ==
X-Google-Smtp-Source: AGHT+IEdqY6eTeVAU3TB+2kdhYBC38PQ/sxXzD1PRV8zVs8UyJbuGs3uNpUw75OIdLQLrdfOizU1DybRo6I=
X-Received: from wrur18.prod.google.com ([2002:a05:6000:1b92:b0:3a3:6eeb:2a27])
 (user=glider job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:230d:b0:3b7:8d71:9657
 with SMTP id ffacd0b85a97d-3b78d71968amr446780f8f.28.1753716359829; Mon, 28
 Jul 2025 08:25:59 -0700 (PDT)
Date: Mon, 28 Jul 2025 17:25:39 +0200
In-Reply-To: <20250728152548.3969143-1-glider@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250728152548.3969143-1-glider@google.com>
X-Mailer: git-send-email 2.50.1.470.g6ba607880d-goog
Message-ID: <20250728152548.3969143-2-glider@google.com>
Subject: [PATCH v3 01/10] x86: kcov: disable instrumentation of arch/x86/kernel/tsc.c
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
2.50.1.470.g6ba607880d-goog


