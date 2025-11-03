Return-Path: <linux-kernel+bounces-883727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DDCE4C2E32B
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 22:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6425C4E3C33
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 21:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD612D6E48;
	Mon,  3 Nov 2025 21:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F0F5J5rR"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569072C15BA
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 21:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762206772; cv=none; b=fKiw8Rjt6YlZQU4Ty8qPyp1trzQHuvoPk92m7GxIZsxHWvGOXJsMZqzVRxSHuG0y8nVzjXxnpMk9hHfR2OCTrgOK0LYQjGBdH3O3m7+wqs8c6RXwLS/CYXO7bY9GK5MKIpUkXZKqJ74MfK5C+ogbts9Tkb+8vvrDvXVRQgrnOrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762206772; c=relaxed/simple;
	bh=IlggUArbQTDTduC0g9V/2wl5U3zKtqFiADzR9hIxB3g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KLkkd03vJX0O8J76PFazz7+Y+/3ApeffWcSwGZtEOGRn6mTBQe+rMhR49c4Mok5/Mcj1wxx/4feYJqdOxjGWqEcSLYuT2pJRXanpSRTmNcfFsz+onWNwx3GtcRQtDGV35CIvCYBdG7WNpE7lstKP+vY1zbRnDye3pkZ+TaWqQnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--xur.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F0F5J5rR; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--xur.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-7864cc72141so48689597b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 13:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762206769; x=1762811569; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lmZROG5/WoXSOPz2A/xpuNPLNUZgkFep1sfBodhmhFU=;
        b=F0F5J5rRSW2lGjcRNp0s1jnewK4CMuwCXJ+Lo3Lx9pJgwLkgasj3Nymnfi9Mu4+JZM
         FcU6Z31v/KveIw6GZeOMSGzuTbe4E2LqIL+Izo9dYQVc9R0JsMCQrpafeJDEpY3SSbGI
         ddppL3q0uCSrNaNX5L5GxAigLs571721aiEn2jEP3OsaA++PmAdncz7mm8egcp5Pq/Kd
         KPX5vZsXEx6MTO7r3T++JCaWHIQo+qNfz7M+8iE1+NfWSQbQKEqaGpbKLof5UYuvsrcC
         gqbDcRK5iRiEqeWClY1MmHiaCvpLtBcXp/vEkfPaMZJ0PehqwVi1SCmA7TraeaSjxxI+
         F79g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762206769; x=1762811569;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lmZROG5/WoXSOPz2A/xpuNPLNUZgkFep1sfBodhmhFU=;
        b=fwfN4lrRobN3OXQw5Ku0kL2j4io/eIu+eH/lTg7tCljoRov2NwBpZNOgROyBxWUfZI
         ze8xnQM71LnV6IOc/+fudkWBDNs4bftbYzz+ct326uGaFEsanTTogfsoOWZ6KZvwjv8h
         QHZQjmb68p4zehpyENAEMVCbVlN26MFWY5208r/Ury2me+hOBA4fRvWNE6NgXV9urPA0
         F23ahD0iSywVh1dHlWuJ5GlD6rfHFDWE118gUBuoeyqTwfjdLN+5CDfGLyuZWY2ziVzS
         pvSp4rinvjuTDRqSVC9FquBegyhyxgfFQ/22hEY91Vrf3zwpSpEZ54KN2bopgP21LK92
         MZ4Q==
X-Gm-Message-State: AOJu0YyycHECDzb5fJdDa44iqFwKLO4rdGyPAVv6bM2s8K+zGdIsuSZt
	r0OMHoSnFKYyDbMBGsi1nHmWBG6lLD81hPSZpDJcKLGeGej1Fn/kSplMTPCcvBbJqL5OhA==
X-Google-Smtp-Source: AGHT+IE6DX3HBwLA27RLX1QPiH1AvOeFq4K5YgoBG0GcqWZ92945ttonTEIiMR+dfZu0kJcJ29YMxhA=
X-Received: from ybbcf18.prod.google.com ([2002:a05:6902:1812:b0:ebc:882c:90e5])
 (user=xur job=prod-delivery.src-stubby-dispatcher) by 2002:a05:690c:909:b0:785:d173:7d0f
 with SMTP id 00721157ae682-786485575d3mr127972087b3.52.1762206769195; Mon, 03
 Nov 2025 13:52:49 -0800 (PST)
Date: Mon,  3 Nov 2025 21:52:44 +0000
In-Reply-To: <20251103215244.2080638-1-xur@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251103215244.2080638-1-xur@google.com>
X-Mailer: git-send-email 2.51.2.997.g839fc31de9-goog
Message-ID: <20251103215244.2080638-2-xur@google.com>
Subject: [PATCH v2 2/2] objtool: dead_end function change for split functions
From: xur@google.com
To: Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Rong Xu <xur@google.com>
Cc: linux-kernel@vger.kernel.org, Sriraman Tallam <tmsriram@google.com>, 
	Han Shen <shenhan@google.com>, Krzysztof Pszeniczny <kpszeniczny@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Rong Xu <xur@google.com>

Function Splitting can potentially move all return instructions
into the cold (infrequently executed) section of the function.
If this happens, the original function might be incorrectly
flagged as a dead-end function.

The consequence is an incomplete ORC table, which leads to an unwind
error, and subsequently, a livepatch failure.

This patch adds the support of the dead_end_function check for
split function.

Signed-off-by: Rong Xu <xur@google.com>
Reviewed-by: Sriraman Tallam <tmsriram@google.com>
Reviewed-by: Han Shen <shenhan@google.com>
Reviewed-by: Krzysztof Pszeniczny <kpszeniczny@google.com>

ChangeLOG:
 v2: Coding style changes suggested by Peter Zijlstra.
---
 tools/objtool/check.c | 91 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 72 insertions(+), 19 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index c2ee3c3a84a62..4864d54cdd79e 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -237,6 +237,76 @@ static bool is_rust_noreturn(const struct symbol *func)
 		str_ends_with(func->name, "_fail"));
 }
 
+static bool __dead_end_function(struct objtool_file *, struct symbol *, int);
+
+/*
+ * Check if the target of a sibling_call instruction is a dead_end function.
+ * Note insn must be a sibling call.
+ */
+static inline bool __dead_end_sibling_call(struct objtool_file *file,
+					   struct instruction *insn,
+					   int recursion) {
+	struct instruction *dest = insn->jump_dest;
+
+	if (!dest) {
+		/* sibling call to another file */
+		return false;
+	}
+
+	/* local sibling call */
+	if (recursion == 5) {
+		/*
+		 * Infinite recursion: two functions have
+		 * sibling calls to each other.  This is a very
+		 * rare case.  It means they aren't dead ends.
+		 */
+		return false;
+	}
+
+	return __dead_end_function(file, insn_func(dest), recursion+1);
+}
+
+/*
+ * Handling split functions. Mimic the workflow in __dead_end_function.
+ */
+static bool __dead_end_split_func(struct objtool_file *file,
+				  struct symbol *func, int recursion)
+{
+	char section_name[256];
+	struct section *sec;
+	struct instruction *insn;
+	int n;
+
+	/*
+	 * Use a fixed-size buffer (max 256) to avoid malloc. If the section
+	 * length exceeds this limit, we return a conservative value. This is
+	 * a safe fallback and does not compromise functional correctness.
+	 */
+	n = sizeof(section_name);
+	if (snprintf(section_name, n, ".text.split.%s", func->name) >= n) {
+		fprintf(stderr, "Error: Function name '%s' too long.\n", func->name);
+		return false;
+	}
+
+	sec = find_section_by_name(file->elf, section_name);
+	if (!sec)
+		return false;
+
+	sec_for_each_insn(file, sec, insn) {
+		if (insn->type == INSN_RETURN)
+			return false;
+	}
+
+	sec_for_each_insn(file, sec, insn) {
+		if (is_sibling_call(insn)) {
+			if (!__dead_end_sibling_call(file, insn, recursion))
+				return false;
+		}
+	}
+
+	return true;
+}
+
 /*
  * This checks to see if the given function is a "noreturn" function.
  *
@@ -298,33 +368,16 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
 	 */
 	func_for_each_insn(file, func, insn) {
 		if (is_sibling_call(insn)) {
-			struct instruction *dest = insn->jump_dest;
-
-			if (!dest)
-				/* sibling call to another file */
-				return false;
-
-			/* local sibling call */
-			if (recursion == 5) {
-				/*
-				 * Infinite recursion: two functions have
-				 * sibling calls to each other.  This is a very
-				 * rare case.  It means they aren't dead ends.
-				 */
-				return false;
-			}
-
 			/*
 			 * A function can have multiple sibling calls. All of
 			 * them need to be dead ends for the function to be a
 			 * dead end too.
 			 */
-			if (!__dead_end_function(file, insn_func(dest), recursion+1))
+			if (!__dead_end_sibling_call(file, insn, recursion))
 				return false;
 		}
 	}
-
-	return true;
+	return __dead_end_split_func(file, func, recursion);
 }
 
 static bool dead_end_function(struct objtool_file *file, struct symbol *func)
-- 
2.51.2.997.g839fc31de9-goog


