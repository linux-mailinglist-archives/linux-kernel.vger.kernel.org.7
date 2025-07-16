Return-Path: <linux-kernel+bounces-732799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C60C3B06C39
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 05:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A3FA7B4BA8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 03:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172BC28B7FD;
	Wed, 16 Jul 2025 03:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wy7hDKte"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11DE2877E9
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 03:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752636167; cv=none; b=RhSCdW9Sul8C/rakarzoyhnT2mhFERRLYSr8qK/k5cp8xxbKebDsIUndBl/7BX7T6u3gAdZN32vTqhEj4YhiPmXrNhVZnbxkasTnam8U7P2Q+oFVS8OTPxzdsNiBPK6Q/5Uw/ShcQ9kCbC8Kf4kmiCyyFNWhTYjgiusieb3EHCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752636167; c=relaxed/simple;
	bh=p335xwuasxivJxSfBt/bfL85xn1YPYtMa/fdyX2hkYw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=S5gPl7TtYMBmhPmJMd8jQ0dkWOOH9sqrqSE/GfBgt0qoRRWWT8VZG8t0gf3fSN3UKb4pdinS8Rm6WJdYPJhk6Ue0g/Mhih0NzYpq1rfhEXtTn7WvtlukozNx5E4Uu9phN0Oo+6q6msJLHp8CIGikt/fs0BSA6j3d907Nd6maLUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wy7hDKte; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3a4f8192e2cso3455020f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 20:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752636164; x=1753240964; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7khiFAj4YK22cn2aUX5ZXvNOvqbYT8yOs+hBn2ZA7n4=;
        b=Wy7hDKtewLa95R3bMrcRvGcCPLYFSF0VfKW+F53l793YvqyerPrAby0ee2/iOMC2DT
         N1/Hbhz5lIgeyxBypAxInJ55x7jKQ+UZvDLDdgkIdTYD/3R81KmZtzQ2slO9x+dcJMhe
         E6e11Ei46rjZmdedUsowQysDqjvMnbwoSP4bLP5cpKR8dxgjnETlX3Fkwtr8XZ1+nOP6
         WVcEIfRvJRxG1av08OAgiL5Jm1sQIhVpMbWsLkodQJSvTl0D9COXsMDI2Wr4wlc1SUsZ
         1cFcqayq1ZTYnWV8GFW/GYHKiE4CjdJwf+2LQn03B7aKHKTshRldenPi0OrhXrjwpKG3
         XXmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752636164; x=1753240964;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7khiFAj4YK22cn2aUX5ZXvNOvqbYT8yOs+hBn2ZA7n4=;
        b=bSlVNGsOC9jQtB3VXZOEJH89cuG6YLiuFTQO9Zqdz715xF6ojqso8bN1EFPEHlYVlF
         mdvm8+UwcowQR0331qZw4iAHJzkGPMhfKamrljZv5p8RZTd4SRzOmzHxbCifFhkzAftU
         2PmYy/hC9zXQms+ed5GhmzmP5+fLA60tkKL5wbF3dYr5JiD7oSLEzHGw5rjabEDXDJ2K
         TRmvziFYYgrCUafbRDUGa6PV/PUZTkSqnNxu0A2n5vC/p6ubiRu9Cnnns1A4ug5G+TlV
         1NoHdGBwAH2k5O7skqemnByti07d8Y+4o4adovO7xAtxY1tXMRWvauWRtfpMlhOsqe/A
         Ormg==
X-Gm-Message-State: AOJu0YyX31NxJNKPC/0dkDxuKt+RyCiwBULYLLlQj0pU6PDReAvT33Qe
	gJK3e+2n4rItCmFuWS+VFlPqgxy4iaYurmE+3RwLtAFXj1bBuLj8S1vY4d4x6rhWLlhZ625sIl2
	V909FYoQ8l8gS1UGfCNdSyqKW1yQcD8uP73/qUIWqyjB3W81U9SHUd58AZIyDA5lwE3WFQzsJS0
	kzmg/gcGdsbG/G/zIiSm4uAsSrIf/H/DODiQ==
X-Google-Smtp-Source: AGHT+IF2AGaO+mQScvryfHxDgCsObx0+rN9u21M6fulSWt9WhnXfRhnsuC2XAjckP/jNJ1QVu3osBtif
X-Received: from wmrn36.prod.google.com ([2002:a05:600c:5024:b0:456:24b4:ebc3])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a5d:64e9:0:b0:3b5:e084:283b
 with SMTP id ffacd0b85a97d-3b60e4c1e2fmr532728f8f.17.1752636164149; Tue, 15
 Jul 2025 20:22:44 -0700 (PDT)
Date: Wed, 16 Jul 2025 05:18:30 +0200
In-Reply-To: <20250716031814.2096113-24-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250716031814.2096113-24-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3473; i=ardb@kernel.org;
 h=from:subject; bh=KBpdtqnvzVD886mHANAPiui8pBP4bXCHS8Bbbn2shFU=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIaNcyvOdXW87y54pHVdXOsT35B7x5dI6qMFU/K5N73j1r
 42CW450lLIwiHExyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgIlcl2NkWLHfR8zSbMtj3lkx
 N4vXhU9TrDDWiFybKS+TG7XeMCj+KsNfKc2PZy547Cr/qT6Bd0mtQ7BeZ4tmsOPj6t1Mk2beOzq DFQA=
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250716031814.2096113-39-ardb+git@google.com>
Subject: [PATCH v5 15/22] objtool: Add action to check for absence of absolute relocations
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Kevin Loughlin <kevinloughlin@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nikunj A Dadhania <nikunj@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The x86 startup code must not use absolute references to code or data,
as it executes before the kernel virtual mapping is up.

Add an action to objtool to check all allocatable sections (with the
exception of __patchable_function_entries, which uses absolute
references for nebulous reasons) and raise an error if any absolute
references are found.

Note that debug sections typically contain lots of absolute references
too, but those are not allocatable so they will be ignored.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 tools/objtool/builtin-check.c           |  2 ++
 tools/objtool/check.c                   | 36 ++++++++++++++++++++
 tools/objtool/include/objtool/builtin.h |  1 +
 3 files changed, 39 insertions(+)

diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index 80239843e9f0..0f6b197cfcb0 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -87,6 +87,7 @@ static const struct option check_options[] = {
 	OPT_BOOLEAN('t', "static-call", &opts.static_call, "annotate static calls"),
 	OPT_BOOLEAN('u', "uaccess", &opts.uaccess, "validate uaccess rules for SMAP"),
 	OPT_BOOLEAN(0  , "cfi", &opts.cfi, "annotate kernel control flow integrity (kCFI) function preambles"),
+	OPT_BOOLEAN(0  , "noabs", &opts.noabs, "reject absolute references in allocatable sections"),
 	OPT_CALLBACK_OPTARG(0, "dump", NULL, NULL, "orc", "dump metadata", parse_dump),
 
 	OPT_GROUP("Options:"),
@@ -162,6 +163,7 @@ static bool opts_valid(void)
 	    opts.hack_noinstr		||
 	    opts.ibt			||
 	    opts.mcount			||
+	    opts.noabs			||
 	    opts.noinstr		||
 	    opts.orc			||
 	    opts.retpoline		||
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index d967ac001498..5d1d38404892 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4643,6 +4643,39 @@ static void disas_warned_funcs(struct objtool_file *file)
 		disas_funcs(funcs);
 }
 
+static int check_abs_references(struct objtool_file *file)
+{
+	struct section *sec;
+	struct reloc *reloc;
+	int ret = 0;
+
+	for_each_sec(file, sec) {
+		/* absolute references in non-loadable sections are fine */
+		if (!(sec->sh.sh_flags & SHF_ALLOC))
+			continue;
+
+		/* section must have an associated .rela section */
+		if (!sec->rsec)
+			continue;
+
+		/*
+		 * Special case for compiler generated metadata that is not
+		 * consumed until after boot.
+		 */
+		if (!strcmp(sec->name, "__patchable_function_entries"))
+			continue;
+
+		for_each_reloc(sec->rsec, reloc) {
+			if (reloc_type(reloc) == R_ABS64) {
+				WARN("section %s has absolute relocation at offset 0x%lx",
+				     sec->name, reloc_offset(reloc));
+				ret++;
+			}
+		}
+	}
+	return ret;
+}
+
 struct insn_chunk {
 	void *addr;
 	struct insn_chunk *next;
@@ -4776,6 +4809,9 @@ int check(struct objtool_file *file)
 			goto out;
 	}
 
+	if (opts.noabs)
+		warnings += check_abs_references(file);
+
 	if (opts.orc && nr_insns) {
 		ret = orc_create(file);
 		if (ret)
diff --git a/tools/objtool/include/objtool/builtin.h b/tools/objtool/include/objtool/builtin.h
index 6b08666fa69d..ab22673862e1 100644
--- a/tools/objtool/include/objtool/builtin.h
+++ b/tools/objtool/include/objtool/builtin.h
@@ -26,6 +26,7 @@ struct opts {
 	bool uaccess;
 	int prefix;
 	bool cfi;
+	bool noabs;
 
 	/* options: */
 	bool backtrace;
-- 
2.50.0.727.gbf7dc18ff4-goog


