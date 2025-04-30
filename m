Return-Path: <linux-kernel+bounces-627972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA35AA5794
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 23:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E622177445
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 21:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DAA62D0ABB;
	Wed, 30 Apr 2025 21:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i3EOgRSu"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C672D026D
	for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 21:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746049263; cv=none; b=id0UTv2qbZPM9u/RyeA6xBx1y0gSpbhxO5SgnAiR+npmRDk44Bx4tqwJJvB1dAq1CvnnpwCQIKS79OPK/JWf3oN28c+2qafb2lDM+rz1eg+bIsGG0r4WcGSOil/QDv3FEErsl640/3dLeCoOCAGsZGnu8LlSFurs5Gqcgecel1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746049263; c=relaxed/simple;
	bh=BXxzO4skt6xJol8bYXVYkap2MgomdSVnQvJsmZd5Rv4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=k7D6i9iqb4UtpBuQ5vX7aZ6RdGG4Ltu68yxbEMLZs9eTuxepsZMV3J9z0T5nTpX4WipRi38eK2g3Ow6ArHAb1MqJTWvlmgv55IiJ5OVnwQ2rBqVSnBU6gb3qWDDF5LzJ1Y/mQR7g/50iVvZ87tBq7HqSAQuLLuIpYCaYVRXTqYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i3EOgRSu; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-22650077995so4278215ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 14:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746049261; x=1746654061; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2CKngrC6O9cGcVCCxaaxP3YTy+M2SG0vauU8yNbnhDM=;
        b=i3EOgRSufBc/N5ThQuZ5iT154iaFRHxunyWoD6+bPGsfaIjwvndU7BZCXVD/QMqzes
         VqR5Vj7Nyd9Qqggvjtg3oegkZGIJ+66iaCzQHuIeJxCv7x+TdTFLBZ+ZQ9gTHOl0S89C
         bb94zg6vaqo9dPM92VpXFw/bw1Vyd/MdB5amNOYk7jJux+tsZLy9EPI/r2D7r6p2Utfz
         iRQbFZu/9f98Rx/bEixN62N0aqKX7DshPu5rWy4xyy9Un1AN04wIeuWKTYXQoJwKRprf
         O3nH5ESnC1flnx2X8fXJujCoIXMgJ+TEWvTVBC2t+vAGJuWhP3Z2oO6eV756eyyc2Gci
         Aepg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746049261; x=1746654061;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2CKngrC6O9cGcVCCxaaxP3YTy+M2SG0vauU8yNbnhDM=;
        b=baKqKgtxAMRKltbyZfhzzRfa0HwVGXtB/lhjw7fkEtqD6620zGAX9+HovQrZM/RH3g
         /bIy0HGdBqoFb4FNhQJX5m0YxUrXxe8RvB6vpK3Pc7q5sYNSBOdp9MJCvOBZydxWOjs0
         3CoNpKzPI/Rx+PriRvo3abRIudk4w/pxpH/dFXFsP+PGEazHIOhHVcdJf2v6VNN61ylC
         H0eF7B2mJ06qW3flcSDVpfyT4uBhZJqJ1WKZBWkdW0X9kapJkZ3ZubFzWvPMd3bBPvCp
         E7w+OUaZRdd/gM/2V9H30qE+RMRlVK/CPqUb0RTYfmWxGiPHWf68PEgUTGp36wB/9/kI
         876A==
X-Forwarded-Encrypted: i=1; AJvYcCWaHw0GQ6LvpOgSc8WfxptpgXScAJi26j6AD4TfX1hKnLS6NA8sboK9kNdYAbbAkYQVVI9hyS3k7ZUZN+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOGi4sri9Jzw6hU2xnZrjmPgJufduMn+m12Y7qjL8WSGmrlW/j
	1HIoejiWwO4Fk9CEdRkG31vNrlyjrGu85DikO6otx6WXf2BMt8PJPbi4D8dI/eksAlEueLEQ8w6
	udszeFyPXfCW54fgq4u2s29OPLA==
X-Google-Smtp-Source: AGHT+IETLi4YUB9i3nzd3B7QsdSWK9DWkyN6lL+7n7jW5K1EkSKzr6FtERyyusMh4VkNLRFF1ZSS0b66BdWXyA6THqM=
X-Received: from pll21.prod.google.com ([2002:a17:902:c215:b0:223:6c8e:eaf1])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:4407:b0:224:8bf:6d81 with SMTP id d9443c01a7336-22e04127919mr10994115ad.46.1746049261149;
 Wed, 30 Apr 2025 14:41:01 -0700 (PDT)
Date: Wed, 30 Apr 2025 21:40:54 +0000
In-Reply-To: <20250430214049.2658716-6-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250430214049.2658716-6-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=5930; i=samitolvanen@google.com;
 h=from:subject; bh=BXxzO4skt6xJol8bYXVYkap2MgomdSVnQvJsmZd5Rv4=;
 b=owGbwMvMwCEWxa662nLh8irG02pJDBlCMx5L2m+O0vn6QC11ve2dbb5Sd9Vef4ss0pZaZnfww
 47frSpvO0pZGMQ4GGTFFFlavq7euvu7U+qrz0USMHNYmUCGMHBxCsBELmcxMlxZOVv5iVGJ59kZ
 H693pRRfjF1hXKdzLvP+Yh2Lot0z5bYx/E/co1qW9LmpM79BQHUru7xa2MX3N65OrxM81/efnef aNHYA
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
Message-ID: <20250430214049.2658716-10-samitolvanen@google.com>
Subject: [PATCH 4/4] Documentation/kbuild: Add new gendwarfksyms kABI rules
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
2.49.0.906.g1f30a19c02-goog


