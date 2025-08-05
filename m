Return-Path: <linux-kernel+bounces-756942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E5AB1BB58
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 22:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4796218A62E2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 20:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B504291C12;
	Tue,  5 Aug 2025 20:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="29FNzCVo"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D85523A98E
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 20:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754425352; cv=none; b=XIDz95BCoZsUwKSSMzV2rIMXo02oQtHQafWqHiNsQIgyBlyIQ5EUexEVgHCBa4aWES6H1gwgsQbmtcpk+8wyVlDghNUvm/Nra1e6bJoDX3rZLPZtQvCHR5U/HmcEmoXaBCesHuivLtsPphV9rY2VUY3y4PfvnBmvnujjdGiuoAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754425352; c=relaxed/simple;
	bh=m4cvXDVqGW0AbHw4k3Vzfovsu939uVbAU2XVf0YMJis=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dm9yepTz+Vsus4G7nAIW/uFUYdVQG/QzqZ+LAqCx2rTjLTh9xnU1PK68/PrAXYSuDi38JF+bCOcnSWXUdm+yirjp8JkDcA5a60QNJ/iOMWPbNwIJV4fHouv47T8BSlqCHsX6cOCOykDuE6VuTXLHHL/ikEC948U+ljZoHMN1Wik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=29FNzCVo; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-76bcf2cac36so4985486b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 13:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754425350; x=1755030150; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=wjR/uxIdvcDRTpBouU2Bht36ZMEEqH5DZxI9XQvsEgw=;
        b=29FNzCVoA3UTpIt0UXOjFra+kcVX/goUGRP7qMVOeFpJjJR+Rn+N1IR8WC44Td+HoA
         PMI+YxTW0wfOv6vYKx9Iyx1l9fg24x4xk2+zsc44Qa+OkCtAk7z9a04QWZGDVqpkvDg9
         s/5yrkFH2kZtXGWRXaS/Z6qJjV6lnE7n7VgzsbC/1/l+wA+9YS7RIT0//9xF580ST9n1
         84JkqDQSLpbvuWIsV4QB9GYlmZAoCvXem+oGlvUwL6yamuuN8fbwxjWSkb1d1NOSU1Ie
         0IlqGPP4DpE13L+g7JQjoK5tN2WBkkwMuoZQx0lRB82bqVJbqRrUMPTqZgR2VFFJukaO
         qVkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754425350; x=1755030150;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wjR/uxIdvcDRTpBouU2Bht36ZMEEqH5DZxI9XQvsEgw=;
        b=YuShocqiobcP8Lc7FHE1aLDh8/MjENj8nCFYfNybnI8viUnVJxMdQCxId+nTE0LxpZ
         PYAkU9qfRk7XoanVrqHTwELyUjngwcPuYgKBNrbwgEgHJy1vChJPu8Yy/SSubLFflvMQ
         Fe+vLX01XFBk2hN51CwdrcLXXwitotlqbkeTQLI4hmRlEMXm5s7skhME4eIBXaBpywNm
         RjPM94SfBNKQL/c7ZZqtqpSdMNpG0SEML+zLGNENBAq0DzaWFOdJl42Smp5fORBP8ScA
         MlkebPf0VnZFmiGYvUTUAD7YF+kcv/o/4OyTHDjvdAw8MBphJV1N+BeEhdK+DSdA1nEJ
         Ww5w==
X-Forwarded-Encrypted: i=1; AJvYcCUs+7jaWOZ8pqwohsFhdJmXa7wrzHOYdxmeBVuzOqAkGvqp1qng+OZTtlx3ex1FWaMGqr9AxXMgIT0BnoU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoMqjZOJ5bU76I9j1HpvDFxVactj7QHI50MuDXuUh+/F+2WYkU
	ZqDjlMVUQc9ob1FXbukKbq1WrCabYdEs0TsyJt+SDXyfhVTLYskIwF5C9h/+hzheglhORKzPs+K
	GcaLmpQ==
X-Google-Smtp-Source: AGHT+IFCEgZsJmKgL2NHifE5gOQctZUA/8fGKPI5Bt4+O9PcW1nCN4b728D10NGn7NJpY+CAkpFhrL7KBbw=
X-Received: from pfnp22.prod.google.com ([2002:aa7:8616:0:b0:76b:269d:d476])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:2590:b0:240:265f:4eb0
 with SMTP id adf61e73a8af0-24031412f65mr574781637.4.1754425350570; Tue, 05
 Aug 2025 13:22:30 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  5 Aug 2025 13:22:19 -0700
In-Reply-To: <20250805202224.1475590-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250805202224.1475590-1-seanjc@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250805202224.1475590-2-seanjc@google.com>
Subject: [PATCH v3 1/6] x86/cpufeatures: Add a CPU feature bit for MSR
 immediate form instructions
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Borislav Petkov <bp@alien8.de>, Xin Li <xin@zytor.com>
Content-Type: text/plain; charset="UTF-8"

From: Xin Li <xin@zytor.com>

The immediate form of MSR access instructions are primarily motivated
by performance, not code size: by having the MSR number in an immediate,
it is available *much* earlier in the pipeline, which allows the
hardware much more leeway about how a particular MSR is handled.

Use a scattered CPU feature bit for MSR immediate form instructions.

Suggested-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/kernel/cpu/scattered.c    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 286d509f9363..75b43bbe2a6d 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -491,6 +491,7 @@
 #define X86_FEATURE_TSA_SQ_NO		(21*32+11) /* AMD CPU not vulnerable to TSA-SQ */
 #define X86_FEATURE_TSA_L1_NO		(21*32+12) /* AMD CPU not vulnerable to TSA-L1 */
 #define X86_FEATURE_CLEAR_CPU_BUF_VM	(21*32+13) /* Clear CPU buffers using VERW before VMRUN */
+#define X86_FEATURE_MSR_IMM		(21*32+14) /* MSR immediate form instructions */
 
 /*
  * BUG word(s)
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index b4a1f6732a3a..5fe19bbe538e 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -27,6 +27,7 @@ static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_APERFMPERF,		CPUID_ECX,  0, 0x00000006, 0 },
 	{ X86_FEATURE_EPB,			CPUID_ECX,  3, 0x00000006, 0 },
 	{ X86_FEATURE_INTEL_PPIN,		CPUID_EBX,  0, 0x00000007, 1 },
+	{ X86_FEATURE_MSR_IMM,			CPUID_ECX,  5, 0x00000007, 1 },
 	{ X86_FEATURE_APX,			CPUID_EDX, 21, 0x00000007, 1 },
 	{ X86_FEATURE_RRSBA_CTRL,		CPUID_EDX,  2, 0x00000007, 2 },
 	{ X86_FEATURE_BHI_CTRL,			CPUID_EDX,  4, 0x00000007, 2 },
-- 
2.50.1.565.gc32cd1483b-goog


