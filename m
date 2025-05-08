Return-Path: <linux-kernel+bounces-638872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 747BBAAEF24
	for <lists+linux-kernel@lfdr.de>; Thu,  8 May 2025 01:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BA219C572D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 May 2025 23:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AFD12918D7;
	Wed,  7 May 2025 23:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d3RRlhWP"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B774291884
	for <linux-kernel@vger.kernel.org>; Wed,  7 May 2025 23:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746659658; cv=none; b=B7ff87Uy74cSPlkMMlKhYat9Al50FguLsB3PJbB0EM4LR91PLpk9LaW3TXaq+35nrPQGyWXz5eKZ1+T688id6m2shjwhzwcb0XXvUFs0VA23I9G9DkvGKqPbIk6f4+bdCCrCR7x43z6PS2mOWkJf9TBrRhpUOmi1SDan6+x31no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746659658; c=relaxed/simple;
	bh=WJVv+F/IReSeS1dXKSnftol5p1+Kb+p+lY9xAYcCpIE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LC6boMs9ewoXqYDsoiFLCDGCPR2vCY4/p1hY2NC9XGOG5iaoZRTzrlZS3BM9VXoNXnqajW73CtQpEVwrKG1desKAONBdXXIUXXCBq3PQaae8jPR+6zOKEpumflp3qr0ypn1SWsIX1HFOtjDtcvaCYoAA7k2uLJyaNIagI11jrrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d3RRlhWP; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-22e7f041997so5102785ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 May 2025 16:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746659654; x=1747264454; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7SrY24qH6WEJRs8Tqs5tyNmAdq/M++Or3BPhbb9qRaQ=;
        b=d3RRlhWPyfu0Wc/3/mzOiWGHsRQedOPZVpR/Z16LW6e/qIqckeaWSZEWgvseuBK0Pj
         +bb/0NX5j37n7ozB+tH7pwEiGp4FS8v/ZJkHor5ljDVEmGSg0nkno6u5Zo/7FSb9l/T6
         wcCmk0l9piZeMf1ihNhJYsTa4EfDQaGZY/ul/tq4vsvg/AqCOmOyZHPBfRvalHM0wKE8
         hb86s4VGvxhKBFm9/koYGJqBfnfgGtaxk/5oKPmtt0p3AWYpRGLjgfULrR8u7dq8aeqw
         oYBsxWxLmqlsaE9zTF8e+UxDCkuHXzQJAtojiV/sCAgRw5a7HJlPEnu/iPeJUlVXKcIo
         HRYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746659654; x=1747264454;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7SrY24qH6WEJRs8Tqs5tyNmAdq/M++Or3BPhbb9qRaQ=;
        b=qVBNkRbQ9r6rFy2+Mb/mhvWxUSqn4yJLVIIahvHG2WLgpXrJsEXtBGcFzx5EHYUick
         DO54COodJVMxSwwaDqR9TpoiotMSjxUetN/Y7Pw+cwvHjr+/PC4f7Y5PbYp7B0UI/j30
         93Ac4H3z/nRql8wdIvJiD3Tcwed9OXU+rY9DRoFEQ5kyW4bz+k0gCqabriH2lvb7GHNp
         soNbNqZ/eHfSz9pQDQE3XauEstRC+/VxE+KpiNsnjryg/MAqTt+z1DiOv0t1usbnGdaL
         IWwfgKGfCLdtB15+y8vtFV1B5XcU+sgx16ncvtDSnf65b5dYW1VrQb1rhZxnGo3p85B3
         uI5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVSnk3dYVtyPYIqvP558zOGF9aU2MobSCpdbjY4WWdm8QDNbAmB9ReTXa0W1mKfAkTBTSDeMOrN+XSIjDs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvj05o+Tikq01foHt6u2xbVHw/bi8YglyQHFYgxGzxheCIH3UV
	NmrkJ0gL9SyClF5HTGZXsFhgyhtz6M9v5Bo7rI5iUokVMXptDrhJ7z/sX2ZPlYkW2GbRGQlpthE
	S0B6r4mNhA9KK6avl1vRqNjgOmA==
X-Google-Smtp-Source: AGHT+IF+uiiPwr+ynZ4F+9/F2kgvOsuIPPJBbNzOh99Cd5IwSBKieqQGdTkO7dYNGaU/Iybmy2UnXpDvpWP8vY7e8tA=
X-Received: from pgly26.prod.google.com ([2002:a63:181a:0:b0:b1f:866e:b28a])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:3bb0:b0:224:1ec0:8a1a with SMTP id d9443c01a7336-22e5ee0f11bmr67283475ad.51.1746659654723;
 Wed, 07 May 2025 16:14:14 -0700 (PDT)
Date: Wed,  7 May 2025 23:14:07 +0000
In-Reply-To: <20250507231403.377725-7-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250507231403.377725-7-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=16739; i=samitolvanen@google.com;
 h=from:subject; bh=WJVv+F/IReSeS1dXKSnftol5p1+Kb+p+lY9xAYcCpIE=;
 b=owGbwMvMwCEWxa662nLh8irG02pJDBnSL23PGRzflP/3cGbZ6pc+yjuMiudGXHtYIMXOyq5gs
 e7olNr5HaUsDGIcDLJiiiwtX1dv3f3dKfXV5yIJmDmsTCBDGLg4BWAiou6MDL+Yf17d2vDP5s77
 WTGiMleWz4yRv82oOe3+5Ldcu+fpBB1lZPjKl5T+veTn64x82cfH6xMWfP+R+Ofg/WeWQdOU/O7 rf2MGAA==
X-Mailer: git-send-email 2.49.0.987.g0cc8ee98dc-goog
Message-ID: <20250507231403.377725-10-samitolvanen@google.com>
Subject: [PATCH v3 3/5] gendwarfksyms: Add a kABI rule to override type strings
From: Sami Tolvanen <samitolvanen@google.com>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@samsung.com>, linux-modules@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sami Tolvanen <samitolvanen@google.com>, Giuliano Procida <gprocida@google.com>
Content-Type: text/plain; charset="UTF-8"

In rare situations where distributions must make significant
changes to otherwise opaque data structures that have
inadvertently been included in the published ABI, keeping
symbol versions stable using the existing kABI macros can
become tedious.

For example, Android decided to switch to a newer io_uring
implementation in the 5.10 GKI kernel "to resolve a huge number
of potential, and known, problems with the codebase," requiring
"horrible hacks" with genksyms:

  "A number of the io_uring structures get used in other core
  kernel structures, only as "opaque" pointers, so there is
  not any real ABI breakage.  But, due to the visibility of
  the structures going away, the CRC values of many scheduler
  variables and functions were changed."
    -- https://r.android.com/2425293

While these specific changes probably could have been hidden
from gendwarfksyms using the existing kABI macros, this may not
always be the case.

Add a last resort kABI rule that allows distribution
maintainers to fully override a type string for a symbol or a
type. Also add a more informative error message in case we find
a non-existent type references when calculating versions.

Suggested-by: Giuliano Procida <gprocida@google.com>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
---
 scripts/gendwarfksyms/examples/kabi.h    |  14 ++-
 scripts/gendwarfksyms/examples/kabi_ex.c |   5 +
 scripts/gendwarfksyms/examples/kabi_ex.h |  79 ++++++++++++-
 scripts/gendwarfksyms/gendwarfksyms.h    |   1 +
 scripts/gendwarfksyms/kabi.c             |  25 ++++
 scripts/gendwarfksyms/types.c            | 140 ++++++++++++++++++++---
 6 files changed, 246 insertions(+), 18 deletions(-)

diff --git a/scripts/gendwarfksyms/examples/kabi.h b/scripts/gendwarfksyms/examples/kabi.h
index 86f4428e0479..170733a3fba4 100644
--- a/scripts/gendwarfksyms/examples/kabi.h
+++ b/scripts/gendwarfksyms/examples/kabi.h
@@ -37,11 +37,14 @@
 #define __stringify(x...) __stringify_1(x)
 #endif
 
-#define __KABI_RULE(hint, target, value)                             \
+#define ___KABI_RULE(hint, target, value)                            \
 	static const char __PASTE(__gendwarfksyms_rule_,             \
 				  __COUNTER__)[] __used __aligned(1) \
 		__section(".discard.gendwarfksyms.kabi_rules") =     \
-			"1\0" #hint "\0" #target "\0" #value
+			"1\0" #hint "\0" target "\0" value
+
+#define __KABI_RULE(hint, target, value) \
+	___KABI_RULE(hint, #target, #value)
 
 #define __KABI_NORMAL_SIZE_ALIGN(_orig, _new)                                             \
 	union {                                                                           \
@@ -96,6 +99,13 @@
  */
 #define KABI_BYTE_SIZE(fqn, value) __KABI_RULE(byte_size, fqn, value)
 
+/*
+ * KABI_TYPE_STRING(type, str)
+ *   For the given type, override the type string used in symtypes
+ *   output and version calculation with str.
+ */
+#define KABI_TYPE_STRING(type, str) ___KABI_RULE(type_string, type, str)
+
 /*
  * KABI_RESERVE
  *   Reserve some "padding" in a structure for use by LTS backports.
diff --git a/scripts/gendwarfksyms/examples/kabi_ex.c b/scripts/gendwarfksyms/examples/kabi_ex.c
index b73ee5399a59..1f799eb7c756 100644
--- a/scripts/gendwarfksyms/examples/kabi_ex.c
+++ b/scripts/gendwarfksyms/examples/kabi_ex.c
@@ -30,3 +30,8 @@ struct ex3b ex3b;
 struct ex3c ex3c;
 
 struct ex4a ex4a;
+
+struct ex5a ex5a;
+struct ex5b ex5b;
+
+int ex6a;
diff --git a/scripts/gendwarfksyms/examples/kabi_ex.h b/scripts/gendwarfksyms/examples/kabi_ex.h
index 092c8cb7bcd7..785b211d9c58 100644
--- a/scripts/gendwarfksyms/examples/kabi_ex.h
+++ b/scripts/gendwarfksyms/examples/kabi_ex.h
@@ -21,6 +21,12 @@
  * 	./gendwarfksyms --stable --dump-dies \
  * 		examples/kabi_ex.o 2>&1 >/dev/null | \
  * 	FileCheck examples/kabi_ex.h --check-prefix=STABLE
+
+ * $ nm examples/kabi_ex.o | awk '{ print $NF }' | \
+ * 	./gendwarfksyms --stable --dump-versions \
+ * 		examples/kabi_ex.o 2>&1 >/dev/null | \
+ * 	sort | \
+ * 	FileCheck examples/kabi_ex.h --check-prefix=VERSIONS
  */
 
 #ifndef __KABI_EX_H__
@@ -170,7 +176,7 @@ struct ex2a {
 /*
  * STABLE:      variable structure_type ex2a {
  * STABLE-NEXT:   member base_type int byte_size(4) encoding(5) a data_member_location(0) ,
- * STABLE-NEXT:   member base_type [[ULONG:long unsigned int|unsigned long]] byte_size(8) encoding(7) b data_member_location(8)
+ * STABLE-NEXT:   member base_type [[ULONG]] byte_size(8) encoding(7) b data_member_location(8)
  * STABLE-NEXT:   member base_type int byte_size(4) encoding(5) c data_member_location(16) ,
  * STABLE-NEXT:   member base_type [[ULONG]] byte_size(8) encoding(7) d data_member_location(24)
  * STABLE-NEXT: } byte_size(32)
@@ -227,7 +233,7 @@ struct ex3a {
 
 /*
  * STABLE:      variable structure_type ex3a {
- * STABLE-NEXT:   member base_type [[ULONG:long unsigned int|unsigned long]] byte_size(8) encoding(7) a data_member_location(0)
+ * STABLE-NEXT:   member base_type [[ULONG]] byte_size(8) encoding(7) a data_member_location(0)
  * STABLE-NEXT:   member base_type [[ULONG]] byte_size(8) encoding(7) unused data_member_location(8)
  * STABLE-NEXT: } byte_size(16)
  */
@@ -282,4 +288,73 @@ KABI_BYTE_SIZE(ex4a, 8);
  * STABLE-NEXT: } byte_size(8)
  */
 
+/*
+ * Example: A type string override.
+ */
+
+struct ex5a {
+	unsigned long a;
+};
+
+/*
+ * This may be safe if the structure is fully opaque to modules, even though
+ * its definition has inadvertently become part of the ABI.
+ */
+KABI_TYPE_STRING(
+	"s#ex5a",
+	"structure_type ex5a { member pointer_type { s#ex4a } byte_size(8) p data_member_location(0) } byte_size(8)");
+
+/*
+ * Make sure the fully expanded type string includes ex4a.
+ *
+ * VERSIONS:      ex5a variable structure_type ex5a {
+ * VERSIONS-SAME:   member pointer_type {
+ * VERSIONS-SAME:     structure_type ex4a {
+ * VERSIONS-SAME:       member base_type [[ULONG:long unsigned int|unsigned long]] byte_size(8) encoding(7) a data_member_location(0)
+ * VERSIONS-SAME:     } byte_size(8)
+ * VERSIONS-SAME:   } byte_size(8) p data_member_location(0)
+ * VERSIONS-SAME: } byte_size(8)
+ */
+
+/*
+ * Example: A type string definition for a non-existent type.
+ */
+
+struct ex5b {
+	unsigned long a;
+};
+
+/* Replace the type string for struct ex5b */
+KABI_TYPE_STRING(
+	"s#ex5b",
+	"structure_type ex5b { member pointer_type { s#ex5c } byte_size(8) p data_member_location(0) } byte_size(8)");
+
+/* Define a type string for a non-existent struct ex5c */
+KABI_TYPE_STRING(
+	"s#ex5c",
+	"structure_type ex5c { member base_type int byte_size(4) encoding(5) n data_member_location(0) } byte_size(8)");
+
+/*
+ * Make sure the fully expanded type string includes the definition for ex5c.
+ *
+ * VERSIONS:      ex5b variable structure_type ex5b {
+ * VERSIONS-SAME:   member pointer_type {
+ * VERSIONS-SAME:     structure_type ex5c {
+ * VERSIONS-SAME:       member base_type int byte_size(4) encoding(5) n data_member_location(0)
+ * VERSIONS-SAME:     } byte_size(8)
+ * VERSIONS-SAME:   } byte_size(8) p data_member_location(0)
+ * VERSIONS-SAME: } byte_size(8)
+ */
+
+/*
+ * Example: A type string override for a symbol.
+ */
+
+KABI_TYPE_STRING("ex6a", "variable s#ex5c");
+
+/*
+ * VERSIONS:      ex6a variable structure_type ex5c {
+ * VERSIONS-SAME:   member base_type int byte_size(4) encoding(5) n data_member_location(0)
+ * VERSIONS-SAME: } byte_size(8)
+ */
 #endif /* __KABI_EX_H__ */
diff --git a/scripts/gendwarfksyms/gendwarfksyms.h b/scripts/gendwarfksyms/gendwarfksyms.h
index 2db49c2ad50e..7dd03ffe0c5c 100644
--- a/scripts/gendwarfksyms/gendwarfksyms.h
+++ b/scripts/gendwarfksyms/gendwarfksyms.h
@@ -292,6 +292,7 @@ bool kabi_is_enumerator_ignored(const char *fqn, const char *field);
 bool kabi_get_enumerator_value(const char *fqn, const char *field,
 			       unsigned long *value);
 bool kabi_is_declonly(const char *fqn);
+bool kabi_get_type_string(const char *type, const char **str);
 
 void kabi_read_rules(int fd);
 void kabi_free(void);
diff --git a/scripts/gendwarfksyms/kabi.c b/scripts/gendwarfksyms/kabi.c
index 61620ff647bd..b3ade713778f 100644
--- a/scripts/gendwarfksyms/kabi.c
+++ b/scripts/gendwarfksyms/kabi.c
@@ -61,12 +61,20 @@
  */
 #define KABI_RULE_TAG_BYTE_SIZE "byte_size"
 
+/*
+ * Rule: type_string
+ * - For the type reference in the fqn field, use the type string
+ *   in the value field.
+ */
+#define KABI_RULE_TAG_TYPE_STRING "type_string"
+
 enum kabi_rule_type {
 	KABI_RULE_TYPE_UNKNOWN,
 	KABI_RULE_TYPE_DECLONLY,
 	KABI_RULE_TYPE_ENUMERATOR_IGNORE,
 	KABI_RULE_TYPE_ENUMERATOR_VALUE,
 	KABI_RULE_TYPE_BYTE_SIZE,
+	KABI_RULE_TYPE_TYPE_STRING,
 };
 
 #define RULE_HASH_BITS 7
@@ -139,6 +147,10 @@ void kabi_read_rules(int fd)
 			.type = KABI_RULE_TYPE_BYTE_SIZE,
 			.tag = KABI_RULE_TAG_BYTE_SIZE,
 		},
+		{
+			.type = KABI_RULE_TYPE_TYPE_STRING,
+			.tag = KABI_RULE_TAG_TYPE_STRING,
+		},
 	};
 
 	if (!stable)
@@ -333,6 +345,19 @@ bool kabi_get_byte_size(const char *fqn, unsigned long *value)
 	return false;
 }
 
+bool kabi_get_type_string(const char *type, const char **str)
+{
+	struct rule *rule;
+
+	rule = find_rule(KABI_RULE_TYPE_TYPE_STRING, type);
+	if (rule) {
+		*str = rule->value;
+		return true;
+	}
+
+	return false;
+}
+
 void kabi_free(void)
 {
 	struct hlist_node *tmp;
diff --git a/scripts/gendwarfksyms/types.c b/scripts/gendwarfksyms/types.c
index 6f37289104ff..39ce1770e463 100644
--- a/scripts/gendwarfksyms/types.c
+++ b/scripts/gendwarfksyms/types.c
@@ -100,7 +100,7 @@ static void type_expansion_append(struct type_expansion *type, const char *s,
 #define TYPE_HASH_BITS 12
 static HASHTABLE_DEFINE(type_map, 1 << TYPE_HASH_BITS);
 
-static int type_map_get(const char *name, struct type_expansion **res)
+static int __type_map_get(const char *name, struct type_expansion **res)
 {
 	struct type_expansion *e;
 
@@ -114,11 +114,12 @@ static int type_map_get(const char *name, struct type_expansion **res)
 	return -1;
 }
 
-static void type_map_add(const char *name, struct type_expansion *type)
+static struct type_expansion *type_map_add(const char *name,
+					   struct type_expansion *type)
 {
 	struct type_expansion *e;
 
-	if (type_map_get(name, &e)) {
+	if (__type_map_get(name, &e)) {
 		e = xmalloc(sizeof(struct type_expansion));
 		type_expansion_init(e);
 		e->name = xstrdup(name);
@@ -130,7 +131,7 @@ static void type_map_add(const char *name, struct type_expansion *type)
 	} else {
 		/* Use the longest available expansion */
 		if (type->len <= e->len)
-			return;
+			return e;
 
 		type_list_free(&e->expanded);
 
@@ -148,6 +149,34 @@ static void type_map_add(const char *name, struct type_expansion *type)
 		type_list_write(&e->expanded, stderr);
 		checkp(fputs("\n", stderr));
 	}
+
+	return e;
+}
+
+static void type_parse(const char *name, const char *str,
+		       struct type_expansion *type);
+
+static int type_map_get(const char *name, struct type_expansion **res)
+{
+	struct type_expansion type;
+	const char *override;
+
+	if (!__type_map_get(name, res))
+		return 0;
+
+	/*
+	 * If die_map didn't contain a type, we might still have
+	 * a type_string kABI rule that defines it.
+	 */
+	if (stable && kabi_get_type_string(name, &override)) {
+		type_expansion_init(&type);
+		type_parse(name, override, &type);
+		*res = type_map_add(name, &type);
+		type_expansion_free(&type);
+		return 0;
+	}
+
+	return -1;
 }
 
 static void type_map_write(FILE *file)
@@ -267,15 +296,18 @@ static char *get_type_name(struct die *cache)
 	return name;
 }
 
-static void __calculate_version(struct version *version, struct list_head *list)
+static void __calculate_version(struct version *version,
+				struct type_expansion *type)
 {
 	struct type_list_entry *entry;
 	struct type_expansion *e;
 
 	/* Calculate a CRC over an expanded type string */
-	list_for_each_entry(entry, list, list) {
+	list_for_each_entry(entry, &type->expanded, list) {
 		if (is_type_prefix(entry->str)) {
-			check(type_map_get(entry->str, &e));
+			if (type_map_get(entry->str, &e))
+				error("unknown type reference to '%s' when expanding '%s'",
+				      entry->str, type->name);
 
 			/*
 			 * It's sufficient to expand each type reference just
@@ -285,7 +317,7 @@ static void __calculate_version(struct version *version, struct list_head *list)
 				version_add(version, entry->str);
 			} else {
 				cache_mark_expanded(&expansion_cache, e);
-				__calculate_version(version, &e->expanded);
+				__calculate_version(version, e);
 			}
 		} else {
 			version_add(version, entry->str);
@@ -293,10 +325,11 @@ static void __calculate_version(struct version *version, struct list_head *list)
 	}
 }
 
-static void calculate_version(struct version *version, struct list_head *list)
+static void calculate_version(struct version *version,
+			      struct type_expansion *type)
 {
 	version_init(version);
-	__calculate_version(version, list);
+	__calculate_version(version, type);
 	cache_free(&expansion_cache);
 }
 
@@ -372,9 +405,80 @@ static void type_expand(struct die *cache, struct type_expansion *type,
 	cache_free(&expansion_cache);
 }
 
+static void type_parse(const char *name, const char *str,
+		       struct type_expansion *type)
+{
+	char *fragment;
+	size_t start = 0;
+	size_t end;
+	size_t pos;
+
+	if (!*str)
+		error("empty type string override for '%s'", name);
+
+	type_expansion_init(type);
+
+	for (pos = 0; str[pos]; ++pos) {
+		bool empty;
+		char marker = ' ';
+
+		if (!is_type_prefix(&str[pos]))
+			continue;
+
+		end = pos + 2;
+
+		/*
+		 * Find the end of the type reference. If the type name contains
+		 * spaces, it must be in single quotes.
+		 */
+		if (str[end] == '\'') {
+			marker = '\'';
+			++end;
+		}
+		while (str[end] && str[end] != marker)
+			++end;
+
+		/* Check that we have a non-empty type name */
+		if (marker == '\'') {
+			if (str[end] != marker)
+				error("incomplete %c# type reference for '%s' (string : '%s')",
+				      str[pos], name, str);
+			empty = end == pos + 3;
+			++end;
+		} else {
+			empty = end == pos + 2;
+		}
+		if (empty)
+			error("empty %c# type name for '%s' (string: '%s')",
+			      str[pos], name, str);
+
+		/* Append the part of the string before the type reference */
+		if (pos > start) {
+			fragment = xstrndup(&str[start], pos - start);
+			type_expansion_append(type, fragment, fragment);
+		}
+
+		/*
+		 * Append the type reference -- note that if the reference
+		 * is invalid, i.e. points to a non-existent type, we will
+		 * print out an error when calculating versions.
+		 */
+		fragment = xstrndup(&str[pos], end - pos);
+		type_expansion_append(type, fragment, fragment);
+
+		start = end;
+		pos = end - 1;
+	}
+
+	/* Append the rest of the type string, if there's any left */
+	if (str[start])
+		type_expansion_append(type, &str[start], NULL);
+}
+
 static void expand_type(struct die *cache, void *arg)
 {
 	struct type_expansion type;
+	const char *override;
 	char *name;
 
 	if (cache->mapped)
@@ -399,9 +503,13 @@ static void expand_type(struct die *cache, void *arg)
 		return;
 
 	debug("%s", name);
-	type_expand(cache, &type, true);
-	type_map_add(name, &type);
 
+	if (stable && kabi_get_type_string(name, &override))
+		type_parse(name, override, &type);
+	else
+		type_expand(cache, &type, true);
+
+	type_map_add(name, &type);
 	type_expansion_free(&type);
 	free(name);
 }
@@ -410,6 +518,7 @@ static void expand_symbol(struct symbol *sym, void *arg)
 {
 	struct type_expansion type;
 	struct version version;
+	const char *override;
 	struct die *cache;
 
 	/*
@@ -423,11 +532,14 @@ static void expand_symbol(struct symbol *sym, void *arg)
 	if (__die_map_get(sym->die_addr, DIE_SYMBOL, &cache))
 		return; /* We'll warn about missing CRCs later. */
 
-	type_expand(cache, &type, false);
+	if (stable && kabi_get_type_string(sym->name, &override))
+		type_parse(sym->name, override, &type);
+	else
+		type_expand(cache, &type, false);
 
 	/* If the symbol already has a version, don't calculate it again. */
 	if (sym->state != SYMBOL_PROCESSED) {
-		calculate_version(&version, &type.expanded);
+		calculate_version(&version, &type);
 		symbol_set_crc(sym, version.crc);
 		debug("%s = %lx", sym->name, version.crc);
 
-- 
2.49.0.987.g0cc8ee98dc-goog


