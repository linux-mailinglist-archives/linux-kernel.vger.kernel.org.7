Return-Path: <linux-kernel+bounces-607792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E0CA90AD5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 20:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91BC63B6F7B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 18:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5C021ABCC;
	Wed, 16 Apr 2025 18:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eBpQibhv"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBA621C162
	for <linux-kernel@vger.kernel.org>; Wed, 16 Apr 2025 18:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744826725; cv=none; b=XmKdBMDsMi6DfpItmja9fo9Sqs03rJtjkl/HoB6s0II9BYb70PiJJ693pbzW2utgleMNm2IEI0xCxHdSbIPd+V+1rmY6j+zjTkok9KPeFgNRbRWGMof+vUZK0u/YHHEx+bvFa0biGPxeJAFaXDZNdEM7TqhlLqJUxLrTTmMpgsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744826725; c=relaxed/simple;
	bh=D/VurCqLb27guso/GqkYusIvZ2SnsZDyUpD9nIbj4iE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SRWDtIV2IAYf2z2I1yi5qkDRdxz1QPOGMhrxNdTVy847Uf4EqBY+NmlSwaDPMMRSvvoeqsc834z/236AZ0F9rmE+Tf0f7QK8lr8fRycgpfD+04NY39kcOZsul3L8RHFxHJEhbGpiuNOFEnEs6gKHkye5YspNr+bd5pxTNjcEai4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eBpQibhv; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43cf5196c25so42927695e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Apr 2025 11:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744826721; x=1745431521; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EWRjEDjHgnGUTAO1fUxX0nlQ73sblTBfWxiyoAckCmI=;
        b=eBpQibhva8cpm7O70uQni1x6t3Hhh+lUhf574VZhrObwHVPbLaawV8cr1rxZI6JbBE
         TwOgf2skQCgVJhXtESY4LF7O0XzJzHIXBz+zdH9ftXcUr1AwnbzXee6WVa+TT99AV6mc
         eg7/aTvDMFWzVD0UanI/nYn1m1zZd1EydYs8mOwcBKm/1O8QtO0ZD/tFPVZ476s8c2rA
         5cgvA3iaUWfTvhkLdczmHoAkcC2vMXpsJxgB+4AvonfrOs8eFsx8P8o1gqf5aYVeLteB
         8TEDlA4NFdrhuks6bgoYiyrItnKllSQkizAgJW9JaWr7daqVaeQw37d7KoZ93J1hZr+z
         Wy+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744826721; x=1745431521;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EWRjEDjHgnGUTAO1fUxX0nlQ73sblTBfWxiyoAckCmI=;
        b=hQds+IHbGn/iOBqQwyrFVa2g26DKg7eW7fC++PBZuAmdbW/Lbb3AFTmw/iFAhZL1E4
         D+1ng8fOktUgSHFR+1kdRPODb24KUFI+YWgRlh9AHWaQLWbkDpZPoWgJcaBjigl+41Ld
         KVAGo6l/+JsGiVf/E8EyWoIu9XVHiO6FqMfi1uPbCbpe1tpF+U4C5j5+drjg0J5qt/Fu
         bPrLF7FZ8DurIl6vVotN+IVWszefPpjf99eLKeuhbQhe+Gk81d5/1z1pW/sIGXvUKfKD
         vWfB0kbqDNZ6SKKsyPk9JfLHKbjEZ5M6nTVeh6UHorxHgB6ezwTV1HEyosEn9tiPF5Vm
         g9Ww==
X-Forwarded-Encrypted: i=1; AJvYcCWwt6QDIETsrhKi+brp+hMm9b39ZnpCrYPRCH+DUsfMdyxTa3APJbCxi+XHOd6GJJaUnC2w4CIcIfR6q0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YywhOEiTscGUfcY+5SSoOod/IDfx7R9kmzpGL6nyyBmI+9+snQ/
	+Wnjs3Dn2lthmwOdSKEQ/CsT8Ay64hk1AXRDTOF+GzQEmBSZysMMzDiuEFEQKnsMcl6W/yMCyOD
	6kB7i3InAeQ==
X-Google-Smtp-Source: AGHT+IGKfernDkJiPcq9aGD5Ngb6rDQ85prFSXMtxNjAKHAqgi+juJeLLNi5fr5EDrdbF7a6RZez8kPLKAZvew==
X-Received: from wmbev17.prod.google.com ([2002:a05:600c:8011:b0:43d:4055:98e3])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3487:b0:43c:f70a:2af0 with SMTP id 5b1f17b1804b1-4405d62a49cmr36178345e9.16.1744826721678;
 Wed, 16 Apr 2025 11:05:21 -0700 (PDT)
Date: Wed, 16 Apr 2025 18:04:32 +0000
In-Reply-To: <20250416180440.231949-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250416180440.231949-1-smostafa@google.com>
X-Mailer: git-send-email 2.49.0.777.g153de2bbd5-goog
Message-ID: <20250416180440.231949-3-smostafa@google.com>
Subject: [PATCH 2/4] ubsan: Remove regs from report_ubsan_failure()
From: Mostafa Saleh <smostafa@google.com>
To: kvmarm@lists.linux.dev, kasan-dev@googlegroups.com, 
	linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: will@kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	broonie@kernel.org, catalin.marinas@arm.com, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, kees@kernel.org, elver@google.com, andreyknvl@gmail.com, 
	ryabinin.a.a@gmail.com, akpm@linux-foundation.org, yuzenghui@huawei.com, 
	suzuki.poulose@arm.com, joey.gouly@arm.com, masahiroy@kernel.org, 
	nathan@kernel.org, nicolas.schier@linux.dev, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

report_ubsan_failure() doesn't use argument regs, and soon it will
be called from the hypervisor context were regs are not available.
So, remove the unused argument.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 arch/arm64/kernel/traps.c | 2 +-
 arch/x86/kernel/traps.c   | 2 +-
 include/linux/ubsan.h     | 4 ++--
 lib/ubsan.c               | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 224f927ac8af..9bfa5c944379 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -1118,7 +1118,7 @@ static struct break_hook kasan_break_hook = {
 #ifdef CONFIG_UBSAN_TRAP
 static int ubsan_handler(struct pt_regs *regs, unsigned long esr)
 {
-	die(report_ubsan_failure(regs, esr & UBSAN_BRK_MASK), regs, esr);
+	die(report_ubsan_failure(esr & UBSAN_BRK_MASK), regs, esr);
 	return DBG_HOOK_HANDLED;
 }
 
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 9f88b8a78e50..4b5a7a1a8dde 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -351,7 +351,7 @@ static noinstr bool handle_bug(struct pt_regs *regs)
 	case BUG_UD1_UBSAN:
 		if (IS_ENABLED(CONFIG_UBSAN_TRAP)) {
 			pr_crit("%s at %pS\n",
-				report_ubsan_failure(regs, ud_imm),
+				report_ubsan_failure(ud_imm),
 				(void *)regs->ip);
 		}
 		break;
diff --git a/include/linux/ubsan.h b/include/linux/ubsan.h
index d8219cbe09ff..c843816f5f68 100644
--- a/include/linux/ubsan.h
+++ b/include/linux/ubsan.h
@@ -3,9 +3,9 @@
 #define _LINUX_UBSAN_H
 
 #ifdef CONFIG_UBSAN_TRAP
-const char *report_ubsan_failure(struct pt_regs *regs, u32 check_type);
+const char *report_ubsan_failure(u32 check_type);
 #else
-static inline const char *report_ubsan_failure(struct pt_regs *regs, u32 check_type)
+static inline const char *report_ubsan_failure(u32 check_type)
 {
 	return NULL;
 }
diff --git a/lib/ubsan.c b/lib/ubsan.c
index cdc1d31c3821..17993727fc96 100644
--- a/lib/ubsan.c
+++ b/lib/ubsan.c
@@ -25,7 +25,7 @@
  * The mappings of struct SanitizerKind (the -fsanitize=xxx args) to
  * enum SanitizerHandler (the traps) in Clang is in clang/lib/CodeGen/.
  */
-const char *report_ubsan_failure(struct pt_regs *regs, u32 check_type)
+const char *report_ubsan_failure(u32 check_type)
 {
 	switch (check_type) {
 #ifdef CONFIG_UBSAN_BOUNDS
-- 
2.49.0.604.gff1f9ca942-goog


