Return-Path: <linux-kernel+bounces-883557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB23C2DBDC
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 19:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C753C343DF9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 18:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2118320A08;
	Mon,  3 Nov 2025 18:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O2S9Yrgh"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906BA313E0F
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 18:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762195923; cv=none; b=phJ2bABRgg0yejhhjnG31RTvXQSty3xwPTFkVeWpGMXOhN1g7AplwDg32IKUoMdkllQQznM4sMUCAWo4NwB3ati5w4sS4tDu6K5bdsiZ0tjST9wTGDwMDW0KMtMBv7M+uz/XvF/tRyKwpeJYXXRwjvbv4TniUg7mONqzymvUhuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762195923; c=relaxed/simple;
	bh=NfSoKf/rJIvjo4Ax9OoVEWnW/RMZpLoWtbAesGHJnfE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fJdEe7iZNbRd26QzkcIfY+aV9VnvEPCkFA/BTCB44QCv5hMYaHMqbLc9qTE1Yr4gE3IJWPV1XNjldxfBYgTs5msOh1bu5z5tNFLe0L/izMeLNr8gMZYoRNTY5hb0stIMm7+UOJ6D/sxbHoUXFg4k/YpF5sIyYDeF9ylFPtSP9dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--xur.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O2S9Yrgh; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--xur.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b5533921eb2so3475941a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 10:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762195920; x=1762800720; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ep5hff/kebeSHMlWyq4X41WzbBRij4gmigHMfhGNEGM=;
        b=O2S9YrghfssD27BGrxWEColRzQXACExTrPdcyldnvtUdjiBMJncCGTLygK8Oa/lBdJ
         bKjrMnXOqtLNuuOlUYxK54pbfGl67wjmKl04rQnJHuf1E6PysPvymExB4YpHh8FkfPsh
         QKVwNmzJNyvHxvSt5AheTt6UxcRzkpUspOa1qxsJBIX5FU7YNIrx/gZSD/kDIP//YYPf
         9bfdmcL175CNS1K+7VTw6N1GwcwIQmC6jNy+jsiIKm6sAsLb93l03yGn1zsEeVQzcF8Q
         b7fh/pSTcsIpjxgWzQE7N/ossASbqd4afEgB6W5eTRIVFgNd365gO8o4bw2mL0pDMIsw
         fDOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762195920; x=1762800720;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ep5hff/kebeSHMlWyq4X41WzbBRij4gmigHMfhGNEGM=;
        b=iKMrkok5TjHiV+4FuQDKIfz6ob/fNVxgGlRvBBLhuKWTLgMG0HzG4JzqZn9qUWrZB8
         cFMaE/FQh81lzFgFspY8fejSoYrw+eq6p5blSL7q1wmYY8dwNIJxNDZvt2vYccNkce9A
         QASShX1OHDsWxgNqPi/QOZ4WQbtMUlx5mOFRXzjC+Az4R5ajwfH89glesy06wGWHaKgw
         tiZlK6zhVQQBTwGhNZrtbBsDHjqZefgFlDSA4osuMTXzKgaYF9H0gY/lf8eHv8A8Nark
         SdbqeIORqwIycTmNGREeMXP/wMe0X5h2jIiaCccb0JKIXMGryngYaT8u5VrM6dWI23cp
         0a8A==
X-Gm-Message-State: AOJu0YwAbrhLQXySRaK8ltVGtgUVUDhGZJVBQ4Gnwr8yfPIZgLGNtbjr
	V2VA7E+A/4+GbEiZ8FkDBoW0hbC9WFzOjFnzfXsezs6crBzxVzvKNFoExstBZ6QSVUcQqw==
X-Google-Smtp-Source: AGHT+IE7zxJwFGesmnJVREudrq8E/q3R5OOuO2HMoomNOLbog26aHvntyfXnZFzrWrKzUtwGcc87w04=
X-Received: from plbjv14.prod.google.com ([2002:a17:903:58e:b0:267:e06f:8ba6])
 (user=xur job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c409:b0:24b:1625:5fa5
 with SMTP id d9443c01a7336-2951a3a63a8mr212783165ad.11.1762195919596; Mon, 03
 Nov 2025 10:51:59 -0800 (PST)
Date: Mon,  3 Nov 2025 18:51:54 +0000
In-Reply-To: <20251103185154.1933872-1-xur@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251103185154.1933872-1-xur@google.com>
X-Mailer: git-send-email 2.51.2.997.g839fc31de9-goog
Message-ID: <20251103185154.1933872-2-xur@google.com>
Subject: [PATCH 2/2] objtool: dead_end function change for split functions
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
---
 tools/objtool/check.c | 88 +++++++++++++++++++++++++++++++++----------
 1 file changed, 69 insertions(+), 19 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index c2ee3c3a84a62..b752cf508d09a 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -237,6 +237,73 @@ static bool is_rust_noreturn(const struct symbol *func)
 		str_ends_with(func->name, "_fail"));
 }
 
+static bool __dead_end_function(struct objtool_file *, struct symbol *, int);
+
+/*
+ * Check if the target of a sibling_call instruction is a dead_end function.
+ * Note insn must be a sibling call.
+ */
+static inline bool __dead_end_sibling_call(struct objtool_file *file,
+		struct instruction *insn, int recursion) {
+	struct instruction *dest = insn->jump_dest;
+
+	if (!dest)
+		/* sibling call to another file */
+		return false;
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
+			struct symbol *func, int recursion)
+{
+	char section_name[256];
+	struct section *sec;
+	struct instruction *insn;
+
+	/*
+	 * Use a fixed-size buffer (max 256) to avoid malloc. If the section
+	 * length exceeds this limit, we return a conservative value. This is
+	 * a safe fallback and does not compromise functional correctness.
+	 */
+	if (snprintf(section_name, sizeof(section_name), ".text.split.%s",
+		     func->name) >= sizeof(section_name)) {
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
@@ -298,33 +365,16 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
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


