Return-Path: <linux-kernel+bounces-659683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D250AC1388
	for <lists+linux-kernel@lfdr.de>; Thu, 22 May 2025 20:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDCE97A91E3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 May 2025 18:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40521DD0F2;
	Thu, 22 May 2025 18:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wAwoBtRN"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BEA1D86D6
	for <linux-kernel@vger.kernel.org>; Thu, 22 May 2025 18:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747939416; cv=none; b=IebUBO3Kjm8MSNLw0IE0Xgprb4N90iTJKj55hQ91aezNyTa6EBxyQ3f8xF6BUtZGCI85UpT1YdI4uog+de/AEbJVd1RTjxvGWELAOjootK+oBnVzJfHtTjS9Bodjmkx07as7aN1ArASDshH2eAFkDABZ6QEjgamsOJji48N/N+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747939416; c=relaxed/simple;
	bh=jJr80GibqNEdgcxyZBMyi89A7bP3UtXPqgP+qLyi9+8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BNs0dtifK4ObTHZT/CUzEBTDvc2n1IXzt4Z4+qq924neFpmR5ZohYCn6OhgBdUWyhCQJBIfAofHu24Hyq5B+QR2ynFlGUPpBgf3VjbYAKu/olrJG9IlTWe+cztHfALx1+XmVpwmjKqHnX7/KmdGnzn1Bg7Rq5L145gmqiJ4ZynY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dylanbhatch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wAwoBtRN; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dylanbhatch.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7395d07a3dcso6308533b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 May 2025 11:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747939414; x=1748544214; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=92VpszQeWU7JifUGtOrwdJo97oyAeIi7e4IDebGw7f4=;
        b=wAwoBtRNbVvQ6gQlN3T75oyWsIZNagqq0sZoaJDziJ2R8tY9TISPiLnRpT8ZpWV+eC
         OBWed4yHXshb5YLRRqbDRsNI8VIYKJVtd87qOAAqORmLl1r1WXfHaDcZ/vwjv7AJalm6
         5monn43rBh4+osHN+U9yHPgy24R23HeeVmmpSfVZyK0KP8+1SVhQP99ZFxyPAeERqs7H
         FZH1ki5Eg11Wq1/s3d9DcKLJuJ79MQOQU+PH1o1TxGoob2CzbziclZ/EJqrRTFdEFbM7
         8oRVYwZaFDY29hUP8ek/dn3sQok8nqmY+F4CAIt7iuru7qIrrWRLUV0wicG0fj9PqKOG
         +DKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747939414; x=1748544214;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=92VpszQeWU7JifUGtOrwdJo97oyAeIi7e4IDebGw7f4=;
        b=mqa+R0rKWUjmS8BuMEVr+JTTUnKWo2v9ijhGxHqJBAhD8Wsl7PbvMlnm1FPndMfjUg
         4hBenR+hriBJBwaXHFAOw18fI9eBctko67DEQKs9k4xhwJyVdnXwNmM46ePHTSps2zfx
         gkUI2z7psE2GxfzouLF2Cow8oJm5SKKALMyKN5DcaoB+UHkR8nkjSSi3qKyT08s1WixX
         ps2lE14mQ+mulRq8AeUIfBjTYpXzgSozDAypxjteRvGFRMG9cBwYjmgGFSBZL1wPzsBO
         Oi0fY5Tf+MBnVs+82FJ8zQMyqv6PAwmnQYgsKyWDschwswJ65PtXWt8wYK3HPq2fIERh
         Dymg==
X-Forwarded-Encrypted: i=1; AJvYcCV9C7Jew3FSVAIc3Mc8MDJw6k6w0drGm/fgslMhzd+G71XPQMZBDdWEqooIyFtdlM0hFJoGMRexVxmmbZs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/Ld+c5Gxk9lYQ1uPC4uNMjGQeFTrn06EG5Oc5sehk8XmkqgZB
	/Bwa1tO6QMGMZZfgyX+r0fO2L6c2XuRTO6yS9htQAbNiDwtnhwbEXZ1R2ajBplRwRM8fGA+lDmx
	mst5dhZM8y0BR5v75ojMp7VzGFA==
X-Google-Smtp-Source: AGHT+IGKUcET+DAt6Z7npMzRM8aN3sJKBM05Fcb4AydPl2HZdYYbUgJFo+MDKjqDZlJXgFGLoq8r/15q55J3rGWQ/A==
X-Received: from pfbbd35.prod.google.com ([2002:a05:6a00:27a3:b0:737:30c9:fe46])
 (user=dylanbhatch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:130e:b0:742:a77b:8c4 with SMTP id d2e1a72fcca58-745ed847e76mr239264b3a.3.1747939414028;
 Thu, 22 May 2025 11:43:34 -0700 (PDT)
Date: Thu, 22 May 2025 18:42:48 +0000
In-Reply-To: <20250522184249.3137187-1-dylanbhatch@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250522184249.3137187-1-dylanbhatch@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250522184249.3137187-2-dylanbhatch@google.com>
Subject: [PATCH v3 1/2] livepatch, x86/module: Generalize late module
 relocation locking.
From: Dylan Hatch <dylanbhatch@google.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
	Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, 
	Joe Lawrence <joe.lawrence@redhat.com>
Cc: Dylan Hatch <dylanbhatch@google.com>, Song Liu <song@kernel.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, "Mike Rapoport (Microsoft)" <rppt@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Late module relocations are an issue on any arch that supports
livepatch, so move the text_mutex locking to the livepatch core code.

Signed-off-by: Dylan Hatch <dylanbhatch@google.com>
---
 arch/x86/kernel/module.c |  8 ++------
 kernel/livepatch/core.c  | 18 +++++++++++++-----
 2 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
index ff07558b7ebc6..38767e0047d0c 100644
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -197,18 +197,14 @@ static int write_relocate_add(Elf64_Shdr *sechdrs,
 	bool early = me->state == MODULE_STATE_UNFORMED;
 	void *(*write)(void *, const void *, size_t) = memcpy;
 
-	if (!early) {
+	if (!early)
 		write = text_poke;
-		mutex_lock(&text_mutex);
-	}
 
 	ret = __write_relocate_add(sechdrs, strtab, symindex, relsec, me,
 				   write, apply);
 
-	if (!early) {
+	if (!early)
 		text_poke_sync();
-		mutex_unlock(&text_mutex);
-	}
 
 	return ret;
 }
diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index 0e73fac55f8eb..9968441f73510 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -294,9 +294,10 @@ static int klp_write_section_relocs(struct module *pmod, Elf_Shdr *sechdrs,
 				    unsigned int symndx, unsigned int secndx,
 				    const char *objname, bool apply)
 {
-	int cnt, ret;
+	int cnt, ret = 0;
 	char sec_objname[MODULE_NAME_LEN];
 	Elf_Shdr *sec = sechdrs + secndx;
+	bool early = pmod->state == MODULE_STATE_UNFORMED;
 
 	/*
 	 * Format: .klp.rela.sec_objname.section_name
@@ -319,12 +320,19 @@ static int klp_write_section_relocs(struct module *pmod, Elf_Shdr *sechdrs,
 					  sec, sec_objname);
 		if (ret)
 			return ret;
-
-		return apply_relocate_add(sechdrs, strtab, symndx, secndx, pmod);
 	}
 
-	clear_relocate_add(sechdrs, strtab, symndx, secndx, pmod);
-	return 0;
+	if (!early)
+		mutex_lock(&text_mutex);
+
+	if (apply)
+		ret = apply_relocate_add(sechdrs, strtab, symndx, secndx, pmod);
+	else
+		clear_relocate_add(sechdrs, strtab, symndx, secndx, pmod);
+
+	if (!early)
+		mutex_unlock(&text_mutex);
+	return ret;
 }
 
 int klp_apply_section_relocs(struct module *pmod, Elf_Shdr *sechdrs,
-- 
2.49.0.1151.ga128411c76-goog


