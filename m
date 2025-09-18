Return-Path: <linux-kernel+bounces-801787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B49FDB449D5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 00:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 993597ACA71
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 22:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24072ECD20;
	Thu,  4 Sep 2025 22:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ksg6emtH"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5042F0C6C
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 22:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757025572; cv=none; b=NAbtdJg1lmR1Hygba9ZWXZ5eRTlb57RWPynjQUOOF7clOCg4imDsg91nZJX6fu8rY+i0QmzIejV7qg/pdrRMouczqPUXpgJD8E9Cv2EPbOp8HuBi3DQAS5L9kqYh5oZ9+rUGU8l4/KH1lQVSjUjNJgUcr3iUt+gT2gJMBL76ZUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757025572; c=relaxed/simple;
	bh=Py6ERm9u4XbjFAnqCPl9ivc1rlJYdEkiBn2dS6BUjHQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XgFAhVjdoqBLarZ9/5VqR2fyBRLcQt1eoUCvu5sS0EIV78XWLZv+TebYSNBNYEqhdn2K+B7KXXPyKsZr+8hymqs3maIhVDWvYGGgQTuWr64WHhDYZ3Ua/8inj0cd5FAe2cPvErZCe5S9CZDUgTH4TzMWPIYfszdhoIaDdfwdSYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dylanbhatch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ksg6emtH; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dylanbhatch.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-772642f9fa3so2466130b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 15:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757025570; x=1757630370; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6spkF2Mtmky9u9zJohv2so8g+gmgPw5xY2VZfo9rxBs=;
        b=ksg6emtHKDGZHt4AWKH5+VJvPShUmKuue5R3n3v5p/s7hmgReLr4yjp3W0M4JKALN5
         A22Zrb/GFO194uCAZFc7AwfOv9C4xKJ/TuaSnZc8nQ3z0iL0wVd1TRTG/nWwDKNQM0GV
         04ijDf9Or4lqHadn4fjksN/76DkQUIQIBQasKc0CQt3GRmIkDWAOfK7oHOQcbuK0ksK6
         Bv90dJw/7gQoNFP3eMb55m/Prdl7eftI0e77U2tqOh1kDT9Qk/02TIHElI05k/beGmv6
         5HEiS9QqI1Wr+8bFeitaTeAT1kE33s+KPfmcDDOiuBo9RPNWprxMa0gB/PlhHx0/rB17
         QcJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757025570; x=1757630370;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6spkF2Mtmky9u9zJohv2so8g+gmgPw5xY2VZfo9rxBs=;
        b=TyamCS79Bm5myn1odZsOswih//p5IIr4fmbpdKSRRLF6E1r7s22Qqk3EMar/oFvmHr
         i4pM3uWSeP4nJhvFCHmLDvRriURYU6m2hrbQZykl5NLGpZT5j9OkJSOEFuqjqogF1lCo
         IQ+XOrGH93Sjsww3gzgGOU1FhTctY9ZbB6nC12p6Y7hzOUpv+Ajvjr07441pzLkaenEJ
         um55oclHYvb/dzKplgV+cYDIHSg9LKIEDX2ufWi1lL4+M5bpslZhkwhx8TN8gcTbrJ4N
         pd3iPWClRbbcxtKNdgcf8QxRNhTFRgcx5Gk566pdCGKEhw6l8DWAp8byzHQFq+IrDc5H
         nS8w==
X-Forwarded-Encrypted: i=1; AJvYcCWV9rpIkCD9xCLeMI1fd6XMOTgpclI1RT5Xzeno9JBabntNhno3TecaKGejsvRPcOJmTI6ds7h+kDtzyj0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEIF/nXM1s/aUPVmUnpk9Bai0FgVi7BOBrwatzz9MAfhWr5PUa
	5Oa8PY9lcbAIWQTH8nqsECarRVHkS9lDZJJ7qU1s+cem5mOE7qL1vgE6BLOBbaR0HK/aB1Q4ePc
	Mptb4/BYU7ordv1PvnfWgiMhWPg==
X-Google-Smtp-Source: AGHT+IE4cVZe/Ko33sMePIr0pO/SLi1MRU5bNT+p9QofRSNLSjKXtZiV5Q8NrVHWoHaTXOqxsAmwXjjIdyqhxxJI8g==
X-Received: from pgbfy15.prod.google.com ([2002:a05:6a02:2a8f:b0:b4f:9acb:771e])
 (user=dylanbhatch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:9997:b0:24c:c33e:8ddc with SMTP id adf61e73a8af0-24e873686a5mr1550457637.28.1757025569652;
 Thu, 04 Sep 2025 15:39:29 -0700 (PDT)
Date: Thu,  4 Sep 2025 22:38:49 +0000
In-Reply-To: <20250904223850.884188-1-dylanbhatch@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904223850.884188-1-dylanbhatch@google.com>
X-Mailer: git-send-email 2.51.0.355.g5224444f11-goog
Message-ID: <20250904223850.884188-6-dylanbhatch@google.com>
Subject: [PATCH v2 5/6] arm64/module, unwind: Add sframe support for modules.
From: Dylan Hatch <dylanbhatch@google.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Indu Bhagat <indu.bhagat@oracle.com>, Peter Zijlstra <peterz@infradead.org>, 
	Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Jiri Kosina <jikos@kernel.org>
Cc: Dylan Hatch <dylanbhatch@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Weinan Liu <wnliu@google.com>, Mark Rutland <mark.rutland@arm.com>, Ian Rogers <irogers@google.com>, 
	linux-toolchains@vger.kernel.org, linux-kernel@vger.kernel.org, 
	live-patching@vger.kernel.org, joe.lawrence@redhat.com, 
	Puranjay Mohan <puranjay@kernel.org>, Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Weinan Liu <wnliu@google.com>

Add sframe table to mod_arch_specific and support sframe unwind when
.sframe section can be found on incoming modules.

Signed-off-by: Dylan Hatch <dylanbhatch@google.com>
Signed-off-by: Weinan Liu <wnliu@google.com>
---
 arch/arm64/include/asm/module.h |  6 ++++++
 arch/arm64/kernel/module.c      |  5 +++++
 include/linux/sframe_lookup.h   |  2 ++
 kernel/sframe_lookup.c          | 38 ++++++++++++++++++++++++++++++++-
 4 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/module.h b/arch/arm64/include/asm/module.h
index 79550b22ba19..e3781fcdc620 100644
--- a/arch/arm64/include/asm/module.h
+++ b/arch/arm64/include/asm/module.h
@@ -6,6 +6,7 @@
 #define __ASM_MODULE_H
 
 #include <asm-generic/module.h>
+#include <linux/sframe_lookup.h>
 
 struct mod_plt_sec {
 	int			plt_shndx;
@@ -17,6 +18,11 @@ struct mod_arch_specific {
 	struct mod_plt_sec	core;
 	struct mod_plt_sec	init;
 
+#ifdef CONFIG_SFRAME_UNWINDER
+	struct sframe_table sftbl;
+	bool sframe_init;
+#endif
+
 	/* for CONFIG_DYNAMIC_FTRACE */
 	struct plt_entry	*ftrace_trampolines;
 };
diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
index 40148d2725ce..d0adeb4cf63d 100644
--- a/arch/arm64/kernel/module.c
+++ b/arch/arm64/kernel/module.c
@@ -18,6 +18,7 @@
 #include <linux/moduleloader.h>
 #include <linux/random.h>
 #include <linux/scs.h>
+#include <linux/sframe_lookup.h>
 
 #include <asm/alternative.h>
 #include <asm/insn.h>
@@ -491,5 +492,9 @@ int module_finalize(const Elf_Ehdr *hdr,
 		}
 	}
 
+	s = find_section(hdr, sechdrs, ".sframe");
+	if (s)
+		sframe_module_init(me, (void *)s->sh_addr, s->sh_size);
+
 	return module_init_ftrace_plt(hdr, sechdrs, me);
 }
diff --git a/include/linux/sframe_lookup.h b/include/linux/sframe_lookup.h
index 1c26cf1f38d4..f84c1f41a421 100644
--- a/include/linux/sframe_lookup.h
+++ b/include/linux/sframe_lookup.h
@@ -31,9 +31,11 @@ struct sframe_table {
 
 #ifdef CONFIG_SFRAME_UNWINDER
 void init_sframe_table(void);
+void sframe_module_init(struct module *mod, void *_sframe, size_t _sframe_size);
 int sframe_find_pc(unsigned long pc, struct sframe_ip_entry *entry);
 #else
 static inline void init_sframe_table(void) {}
+static inline void sframe_module_init(struct module *mod, void *_sframe, size_t _sframe_size) {}
 static inline int sframe_find_pc(unsigned long pc, struct sframe_ip_entry *entry)
 {
 	return -EINVAL;
diff --git a/kernel/sframe_lookup.c b/kernel/sframe_lookup.c
index 51cd24a75956..c87a94f01891 100644
--- a/kernel/sframe_lookup.c
+++ b/kernel/sframe_lookup.c
@@ -156,10 +156,20 @@ int sframe_find_pc(unsigned long pc, struct sframe_ip_entry *entry)
 	struct sframe_table *sftbl_p = &sftbl;
 	int err;
 
-	if (!sframe_init)
+	if (!entry || !sframe_init)
 		return -EINVAL;
 
 	memset(entry, 0, sizeof(*entry));
+
+	if (!is_ksym_addr(pc)) {
+		struct module *mod;
+
+		mod = __module_address(pc);
+		if (!mod || !mod->arch.sframe_init)
+			return -EINVAL;
+		sftbl_p = &mod->arch.sftbl;
+	}
+
 	entry->ra_offset = sftbl_p->sfhdr_p->cfa_fixed_ra_offset;
 	entry->fp_offset = sftbl_p->sfhdr_p->cfa_fixed_fp_offset;
 
@@ -194,3 +204,29 @@ void __init init_sframe_table(void)
 		+ sftbl.sfhdr_p->fres_off;
 	sframe_init = true;
 }
+
+void sframe_module_init(struct module *mod, void *_sframe, size_t _sframe_size)
+{
+	size_t sframe_size = _sframe_size;
+	void *sframe_buf = _sframe;
+	struct sframe_table _sftbl;
+
+
+	if (sframe_size <= 0)
+		return;
+	_sftbl.sfhdr_p = sframe_buf;
+	if (!_sftbl.sfhdr_p || _sftbl.sfhdr_p->preamble.magic != SFRAME_MAGIC ||
+	    _sftbl.sfhdr_p->preamble.version != SFRAME_VERSION_2 ||
+	    !(_sftbl.sfhdr_p->preamble.flags & SFRAME_F_FDE_SORTED)) {
+		pr_warn("WARNING: Unable to read sframe header.  Disabling unwinder.\n");
+		return;
+	}
+
+	_sftbl.fde_p = (struct sframe_fde *)(sframe_buf + SFRAME_HEADER_SIZE(*_sftbl.sfhdr_p)
+						+ _sftbl.sfhdr_p->fdes_off);
+	_sftbl.fre_p = sframe_buf + SFRAME_HEADER_SIZE(*_sftbl.sfhdr_p)
+		+ _sftbl.sfhdr_p->fres_off;
+
+	mod->arch.sftbl = _sftbl;
+	mod->arch.sframe_init = true;
+}
-- 
2.51.0.355.g5224444f11-goog


