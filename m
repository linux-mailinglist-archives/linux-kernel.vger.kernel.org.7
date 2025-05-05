Return-Path: <linux-kernel+bounces-632905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE05EAA9E13
	for <lists+linux-kernel@lfdr.de>; Mon,  5 May 2025 23:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49D9117942E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 May 2025 21:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080D527586A;
	Mon,  5 May 2025 21:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Uqv2uDdA"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B95327466E
	for <linux-kernel@vger.kernel.org>; Mon,  5 May 2025 21:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746480255; cv=none; b=GvM7kezjqP0ktU8PWB4d37kn9UI02jzRKM8S151jCFhQlMoygXWs0FY67cTEgjTjrcorz+uf8SfRMfpxdYOyMC2aa7bEz/zdXTO3u+oL+PojGZKKO2gpHRR4v9gaWoaaBwUNRHsNXxmxAtDUvS0zbD6Y1D8SjeHcoHPHzhOVLbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746480255; c=relaxed/simple;
	bh=7s/E4m10J6aoRvjV1yW2+j2HRnsx8mgBbM/r51ocW5A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B3tH2viVYIiorAWVf3Drw+1IIbzZDGZjiaN7uPMj9opDnqx/5YOw6EYj/fkjZIOiWj6LBENo57ypoSDER5j2/WF8CRirVvnJw8o0YsG/pLOSym7lnfup8EZq7wg+mQhYuXGQtKDs1GnNk41Aw0AqN7u0T+n5VxXh7eZERYVuon0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Uqv2uDdA; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-afd1e7f52f7so2580152a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 May 2025 14:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746480252; x=1747085052; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GIPnE82b6i61LEjBTUCqfcsHkZywrijK+35yah+PyEc=;
        b=Uqv2uDdAt2blx9XF9webmgwyTyPUWjStjeqWDIA9Taow1KF9UtFk8lM1cquMwZT49E
         mnoL2L+/E/1NOxJEFA4ZiwdAO38u8DinDRM8NYikj5sND3t8P0qrezVISULaRqCHo6fH
         lM3AWZHFRdGR09wbhdJtBdGQHbAkPy9aZTTlMA993+jIvVWBpEzARDylk8VyjM7cklSa
         ZgOO8vd47NkA+CcNa0I4UZCLHe0DFB0VcucwSLtKD6/VeXWVEJR7ELplvLmO1r8Sv/IS
         90XhBuUX+FuBmvVoQC9qmZaIA4JMXlO7iWaQ90UlsSoQTHNRs+Ctviou2myTkAaxQ3W1
         esaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746480252; x=1747085052;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GIPnE82b6i61LEjBTUCqfcsHkZywrijK+35yah+PyEc=;
        b=p1TLARTWSJKUYeRgEL2+EtsAcaAnyhQ/9OfJG5jHovagoiPR8oTRrUIRFfw4nZrhKF
         xAW96rqZvqT/MfIwVMP1jiOMj0qCPrQY3ESFNJiCZySgmEX+tkn9ehHq/psqCs8wjP1J
         /jXAz7eC1D8evg7LnlT4JSr8Ok+loPZ0LYIKm1s2KDpwFLQPV/kY9ZBKp72IvE1IefuQ
         mie812frobN3zz7PwLkn0+CQIueBTzGp3TK7E4q8Sr9bEav7FBUIXfpyqqltrUt+bcv6
         Ae9y4lJ/zIxr0FrxfaiwTkWk3WgqgG2c3VW2+ft1GfVMskAP3L+qt0jLemljnKPfITxN
         Bicw==
X-Forwarded-Encrypted: i=1; AJvYcCW1abYlhgYa1YbAZv8qsJHZYP5Y5TsPJ3JR47ih+/8WvVdf7iHmk3PQ6oTFkBjfgBRnqtl86zZYULfM3mo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBmB0QChuK/hxuQjquMemrYbr6337R1UVtVgy53+6RTWY3vvdE
	zz96dG5VEiovT7dk35INO6mtaR6xkHHUEVAh7lqQk3ZKPliOCagRQgjMv93wZSTm2v1FOcQfqDu
	OnhLWr5Z2KjmVSl46/jk+Z4q9JQ==
X-Google-Smtp-Source: AGHT+IFFmAMe7NdEnE0TKIzz/g3neM1rXjl2OzQV2Y1xfStACjI4PFgGfGajlr+SLVSFArOxlcz0O91imM1sw8QoRSA=
X-Received: from pfbfn24.prod.google.com ([2002:a05:6a00:2fd8:b0:736:6fb6:7fc])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:6d84:b0:1f5:8e33:c417 with SMTP id adf61e73a8af0-21180774d80mr1067658637.2.1746480252274;
 Mon, 05 May 2025 14:24:12 -0700 (PDT)
Date: Mon,  5 May 2025 21:24:06 +0000
In-Reply-To: <20250505212401.3379699-6-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250505212401.3379699-6-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=5930; i=samitolvanen@google.com;
 h=from:subject; bh=7s/E4m10J6aoRvjV1yW2+j2HRnsx8mgBbM/r51ocW5A=;
 b=owGbwMvMwCEWxa662nLh8irG02pJDBmSOsUe+i0i6yYU7rNJ0C9jy3eYH6NS0n/i4qyFNirzV
 56aZFnaUcrCIMbBICumyNLydfXW3d+dUl99LpKAmcPKBDKEgYtTACZSfojhf0w1N8vmO6vNl058
 NFP5k7FD0dLEfM15wsmLJrWVix9OvMrwizmNvehiE0P66Zx2nQbezeoxFStkfRdMvL+XM5d7xet mRgA=
X-Mailer: git-send-email 2.49.0.967.g6a0df3ecc3-goog
Message-ID: <20250505212401.3379699-10-samitolvanen@google.com>
Subject: [PATCH v2 4/4] Documentation/kbuild: Add new gendwarfksyms kABI rules
From: Sami Tolvanen <samitolvanen@google.com>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@samsung.com>, linux-modules@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"

Document byte_size and type_string kABI stability rules. Also fix
the section numbers while we're at it.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 Documentation/kbuild/gendwarfksyms.rst | 103 +++++++++++++++++++++++--
 1 file changed, 95 insertions(+), 8 deletions(-)

diff --git a/Documentation/kbuild/gendwarfksyms.rst b/Documentation/kbuild/gendwarfksyms.rst
index e4beaae7e456..8b0d7ebbb084 100644
--- a/Documentation/kbuild/gendwarfksyms.rst
+++ b/Documentation/kbuild/gendwarfksyms.rst
@@ -125,14 +125,17 @@ the rules. The fields are as follows:
   qualified name of the DWARF Debugging Information Entry (DIE).
 - `value`: Provides rule-specific data.
 
-The following helper macro, for example, can be used to specify rules
+The following helper macros, for example, can be used to specify rules
 in the source code::
 
-	#define __KABI_RULE(hint, target, value)                             \
-		static const char __PASTE(__gendwarfksyms_rule_,             \
+	#define ___KABI_RULE(hint, target, value)			    \
+		static const char __PASTE(__gendwarfksyms_rule_,	     \
 					  __COUNTER__)[] __used __aligned(1) \
 			__section(".discard.gendwarfksyms.kabi_rules") =     \
-				"1\0" #hint "\0" #target "\0" #value
+				"1\0" #hint "\0" target "\0" value
+
+	#define __KABI_RULE(hint, target, value) \
+		___KABI_RULE(hint, #target, #value)
 
 
 Currently, only the rules discussed in this section are supported, but
@@ -223,7 +226,88 @@ Example usage::
 	KABI_ENUMERATOR_IGNORE(e, C);
 	KABI_ENUMERATOR_VALUE(e, LAST, 2);
 
-4.3. Adding structure members
+4.1.3. Managing structure size changes
+======================================
+
+A data structure can be partially opaque to modules if its allocation is
+handled by the core kernel, and modules only need to access some of its
+members. In this situation, it's possible to append new members to the
+structure without breaking the ABI, as long as the layout for the original
+members remains unchanged.
+
+To append new members, we can hide them from symbol versioning as
+described in section :ref:`Hiding members <hiding_members>`, but we can't
+hide the increase in structure size. The `byte_size` rule allows us to
+override the structure size used for symbol versioning.
+
+The rule fields are expected to be as follows:
+
+- `type`: "byte_size"
+- `target`: The fully qualified name of the target data structure
+  (as shown in **--dump-dies** output).
+- `value`: A positive decimal number indicating the structure size
+  in bytes.
+
+Using the `__KABI_RULE` macro, this rule can be defined as::
+
+        #define KABI_BYTE_SIZE(fqn, value) \
+                __KABI_RULE(byte_size, fqn, value)
+
+Example usage::
+
+	struct s {
+                /* Unchanged original members */
+		unsigned long a;
+                void *p;
+
+                /* Appended new members */
+                KABI_IGNORE(0, unsigned long n);
+	};
+
+	KABI_BYTE_SIZE(s, 16);
+
+4.1.4. Overriding type strings
+==============================
+
+In rare situations where distributions must make significant changes to
+otherwise opaque data structures that have inadvertently been included
+in the published ABI, keeping symbol versions stable using the more
+targeted kABI rules can become tedious. The `type_string` rule allows us
+to override the full type string for a type or a symbol, and even add
+types for versioning that no longer exist in the kernel.
+
+The rule fields are expected to be as follows:
+
+- `type`: "type_string"
+- `target`: The fully qualified name of the target data structure
+  (as shown in **--dump-dies** output) or symbol.
+- `value`: A valid type string (as shown in **--symtypes**) output)
+  to use instead of the real type.
+
+Using the `__KABI_RULE` macro, this rule can be defined as::
+
+	#define KABI_TYPE_STRING(type, str) \
+		___KABI_RULE("type_string", type, str)
+
+Example usage::
+
+	/* Override type for a structure */
+	KABI_TYPE_STRING("s#s",
+		"structure_type s { "
+			"member base_type int byte_size(4) "
+				"encoding(5) n "
+			"data_member_location(0) "
+		"} byte_size(8)");
+
+	/* Override type for a symbol */
+	KABI_TYPE_STRING("my_symbol", "variable s#s");
+
+The `type_string` rule should be used only as a last resort if maintaining
+a stable symbol versions cannot be reasonably achieved using other
+means. Overriding a type string increases the risk of actual ABI breakages
+going unnoticed as it hides all changes to the type.
+
+4.2. Adding structure members
 =============================
 
 Perhaps the most common ABI compatible change is adding a member to a
@@ -237,7 +321,7 @@ natural method. This section describes gendwarfksyms support for using
 reserved space in data structures and hiding members that don't change
 the ABI when calculating symbol versions.
 
-4.3.1. Reserving space and replacing members
+4.2.1. Reserving space and replacing members
 ============================================
 
 Space is typically reserved for later use by appending integer types, or
@@ -276,7 +360,9 @@ The examples include `KABI_(RESERVE|USE|REPLACE)*` macros that help
 simplify the process and also ensure the replacement member is correctly
 aligned and its size won't exceed the reserved space.
 
-4.3.2. Hiding members
+.. _hiding_members:
+
+4.2.2. Hiding members
 =====================
 
 Predicting which structures will require changes during the support
@@ -305,4 +391,5 @@ member to a union where one of the fields has a name starting with
                 unsigned long b;
         };
 
-With **--stable**, both versions produce the same symbol version.
+With **--stable**, both versions produce the same symbol version. The
+examples include a `KABI_IGNORE` macro to simplify the code.
-- 
2.49.0.967.g6a0df3ecc3-goog


