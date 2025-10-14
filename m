Return-Path: <linux-kernel+bounces-853248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 691A8BDB02F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 21:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 249833E6973
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 19:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945872EC574;
	Tue, 14 Oct 2025 19:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zbKIH2dr"
Received: from mail-yx1-f74.google.com (mail-yx1-f74.google.com [74.125.224.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD91A2D193B
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 19:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760469125; cv=none; b=XcmZaaUM+QrIv4xd3qNJ7fpHeqO/8UE+2wrPZbTWEb9Vgme63MLqgZMXgpyN7L/+RV2iHiC0J6J6ijpHNfJJJRN1+UFxbodhs6dVL8p6m443y2elxms+TZUDp2sPmfJxgjgdWGBqcOpD//bm5w3Hqomm0OmHQlRxzHYncZmwxTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760469125; c=relaxed/simple;
	bh=7hZJVFkdIfTmvalRXi5Libvp24ccfs8HyqnQSUB6V5I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lG6z1T7TLdxgqH9Slwf9RIkqdpTvLbip0aczu7uM3mVMSFCcTWQ9jTfntR9S36aJCGRSI3kjgRPLsMx/TDoNOf4E552m4+NqJJdfLfxxux3YxP/A5K1cTXdcl07JeyjLnsfK2HpiR6DHd3AN5fqd5oEnzdfBtCJ9WsfrTo7RAg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--xur.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zbKIH2dr; arc=none smtp.client-ip=74.125.224.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--xur.bounces.google.com
Received: by mail-yx1-f74.google.com with SMTP id 956f58d0204a3-6361cb5b665so9141723d50.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 12:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760469123; x=1761073923; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YTzthtl7Wa7asoY7x1cmJ9taUGPGsRkaB7TH32ms+Iw=;
        b=zbKIH2drEASRL6R+O7VcVl8D/XzzJMsmFKsW2uPEnk5Y+3Z0e2Y6kWQfWbWbUbLRuv
         oZ0tCPE1qKMdNkr2GQnRIf6j5p3EJaslXxJbEBm+fOQSbaYOCJCGf4E8KgGmsVfagLIH
         vX5+Ya0Jsa/GacUJMeyTRhhew0xVeivUg+Kw4JanZ4PPrBqUbF4J827Ny4p+aGqnltZx
         M24sP/u6dbZ5lxzt0D4Y3z7hSp7aiQrMN5ipeET9cC+Y5efeWtBgqWRxERnmuYx0rG7c
         bd6IBjwDe7Ci+v8uh4bV+VA7KCwtwn63vjQHL5XESqGtEcKh4bva5XA3EvDnR9E/IzOc
         Taow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760469123; x=1761073923;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YTzthtl7Wa7asoY7x1cmJ9taUGPGsRkaB7TH32ms+Iw=;
        b=bHbZa2FQDTwwgB4Helz8Ot+E1MAqS0DmpdT4F4VGvVlkJgSHudcOAubXtYe5sH1s2X
         3qZ8lbS2/9Rh3QZFUuCcVc0CsyyIe2p+v8+g3GvlN0z/X9laERSk7+FL3BwQBueTWJSn
         P6WX/rs065anyWcscgmASFxFw99U2jznWSai5LymAHG2VFncwcjWwyeRobHxORFmacGv
         ySRIvaQ0UuK92/mTClQwlQ/+nPf44SA5XSKe+FbA0wdO0nClTeR1UmVsd7NeFOr3I08r
         vGeYhNlyDKZgYFBvIIRA1AQKC9MrYAv0CUgyufFCFqXjvuBq7BSkvJd8NrEgci8R4U1R
         mMyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXtFl6BPgMI7Vi5mBsk0ZYdNnSHAk5uvh/KO3LTXnDC+HkFVpxaqeetdWAQn37moYCHYB1zXAy30z5oIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhizV1MPt+S4TC8rswHqgesgj5RBQjo7N8EaafXu+4TCrpkPXL
	tWhnWPlBkPHJucGNtRD4I/PrPSjD9/DBN0UCLlhVPK7E9aTgo20/DWeqO3OOEopI+Br88w==
X-Google-Smtp-Source: AGHT+IHwQOX/dXbeDQWkS8bkoVL1lPfoiTSNYulq1q1NsBWe/XUwcHB9R0EaTveL9zV4HNtOfNvb1jY=
X-Received: from ybdt35.prod.google.com ([2002:a25:f623:0:b0:eb3:7397:f4b])
 (user=xur job=prod-delivery.src-stubby-dispatcher) by 2002:a05:690e:2513:20b0:63c:f5a6:f2fb
 with SMTP id 956f58d0204a3-63cf5a70641mr9544759d50.61.1760469122851; Tue, 14
 Oct 2025 12:12:02 -0700 (PDT)
Date: Tue, 14 Oct 2025 19:11:54 +0000
In-Reply-To: <20251014191156.3836703-1-xur@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251014191156.3836703-1-xur@google.com>
X-Mailer: git-send-email 2.51.0.788.g6d19910ace-goog
Message-ID: <20251014191156.3836703-3-xur@google.com>
Subject: [PATCH v2 2/4] kbuild: Disable AutoFDO and Propeller flags for kernel modules
From: xur@google.com
To: Alexey Gladkov <legion@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Bill Wendling <morbo@google.com>, Han Shen <shenhan@google.com>, 
	Ingo Molnar <mingo@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Tamir Duberstein <tamird@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>, 
	"=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?=" <thomas.weissschuh@linutronix.de>, Yabin Cui <yabinc@google.com>, 
	Sriraman Tallam <tmsriram@google.com>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, Rong Xu <xur@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Rong Xu <xur@google.com>

AutoFDO and Propeller build currently does not support kernel modules,
but the corresponding build flags are still being set.

This change suppresses these build flags for modules. These flags can
be re-enabled once Propeller support for kernel modules is added.

Change-Id: I3f8bf88ff1fb435f903ba861a7b9a87f6123fa0c
Signed-off-by: Rong Xu <xur@google.com>
---
 Makefile                   |  9 +++++----
 scripts/Makefile.autofdo   |  9 ++++++---
 scripts/Makefile.lib       |  9 ++++++---
 scripts/Makefile.propeller | 12 ++++++++----
 scripts/Makefile.vmlinux_o |  3 ++-
 5 files changed, 27 insertions(+), 15 deletions(-)

diff --git a/Makefile b/Makefile
index 17cfa11ca7163..3fd0c364ff84e 100644
--- a/Makefile
+++ b/Makefile
@@ -1230,14 +1230,15 @@ PHONY += vmlinux
 # not for decompressors. LDFLAGS_vmlinux in arch/*/boot/compressed/Makefile is
 # unrelated; the decompressors just happen to have the same base name,
 # arch/*/boot/compressed/vmlinux.
-# Export LDFLAGS_vmlinux only to scripts/Makefile.vmlinux.
+# Export LDFLAGS_vmlinux only to scripts/Makefile.vmlinux, and
+# scripts/Makefile.vmlinux_o.
 #
 # _LDFLAGS_vmlinux is a workaround for the 'private export' bug:
 #   https://savannah.gnu.org/bugs/?61463
 # For Make > 4.4, the following simple code will work:
-#  vmlinux: private export LDFLAGS_vmlinux := $(LDFLAGS_vmlinux)
-vmlinux: private _LDFLAGS_vmlinux := $(LDFLAGS_vmlinux)
-vmlinux: export LDFLAGS_vmlinux = $(_LDFLAGS_vmlinux)
+#  vmlinux vmlinux_o: private export LDFLAGS_vmlinux := $(LDFLAGS_vmlinux)
+vmlinux vmlinux_o: private _LDFLAGS_vmlinux := $(LDFLAGS_vmlinux)
+vmlinux vmlinux_o: export LDFLAGS_vmlinux = $(_LDFLAGS_vmlinux)
 vmlinux: vmlinux.o $(KBUILD_LDS) modpost
 	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.vmlinux
 
diff --git a/scripts/Makefile.autofdo b/scripts/Makefile.autofdo
index 1caf2457e585c..5bcfcef273745 100644
--- a/scripts/Makefile.autofdo
+++ b/scripts/Makefile.autofdo
@@ -14,11 +14,14 @@ ifdef CLANG_AUTOFDO_PROFILE
 endif
 
 ifdef CONFIG_LTO_CLANG_THIN
+  _ldflags_autofdo := --mllvm=-enable-fs-discriminator=true --mllvm=-improved-fs-discriminator=true -plugin-opt=thinlto
+  _ldflags_autofdo += -plugin-opt=-split-machine-functions
   ifdef CLANG_AUTOFDO_PROFILE
-    KBUILD_LDFLAGS += --lto-sample-profile=$(CLANG_AUTOFDO_PROFILE)
+    _ldflags_autofdo += --lto-sample-profile=$(CLANG_AUTOFDO_PROFILE)
   endif
-  KBUILD_LDFLAGS += --mllvm=-enable-fs-discriminator=true --mllvm=-improved-fs-discriminator=true -plugin-opt=thinlto
-  KBUILD_LDFLAGS += -plugin-opt=-split-machine-functions
+  # TODO: change LDFLAGS_vmlinux to KBUILD_LDFLAGS when kernel modules
+  # are supported.
+  LDFLAGS_vmlinux += $(_ldflags_autofdo)
 endif
 
 export CFLAGS_AUTOFDO_CLANG
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 53c02fc3b348a..0f6874e8d584d 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -108,20 +108,23 @@ endif
 #
 # Enable AutoFDO build flags except some files or directories we don't want to
 # enable (depends on variables AUTOFDO_PROFILE_obj.o and AUTOFDO_PROFILE).
-#
+# TODO: change '$(part-of-builtin)' to '$(is-kernel-object)' when the AutoFDO
+# build supports modules.
 ifeq ($(CONFIG_AUTOFDO_CLANG),y)
 _c_flags += $(if $(patsubst n%,, \
-	$(AUTOFDO_PROFILE_$(target-stem).o)$(AUTOFDO_PROFILE)$(is-kernel-object)), \
+	$(AUTOFDO_PROFILE_$(target-stem).o)$(AUTOFDO_PROFILE)$(part-of-builtin)), \
 	$(CFLAGS_AUTOFDO_CLANG))
 endif
 
 #
 # Enable Propeller build flags except some files or directories we don't want to
 # enable (depends on variables AUTOFDO_PROPELLER_obj.o and PROPELLER_PROFILE).
+# TODO: change '$(part-of-builtin)' to '$(is-kernel-object)' when the Propeller
+# build supports modules.
 #
 ifdef CONFIG_PROPELLER_CLANG
 _c_flags += $(if $(patsubst n%,, \
-	$(PROPELLER_PROFILE_$(target-stem).o)$(PROPELLER_PROFILE)$(is-kernel-object)), \
+	$(PROPELLER_PROFILE_$(target-stem).o)$(PROPELLER_PROFILE)$(part-of-builtin)), \
 	$(CFLAGS_PROPELLER_CLANG))
 endif
 
diff --git a/scripts/Makefile.propeller b/scripts/Makefile.propeller
index 48a660128e256..fa018098506b8 100644
--- a/scripts/Makefile.propeller
+++ b/scripts/Makefile.propeller
@@ -3,7 +3,7 @@
 # Enable available and selected Clang Propeller features.
 ifdef CLANG_PROPELLER_PROFILE_PREFIX
   CFLAGS_PROPELLER_CLANG := -fbasic-block-sections=list=$(CLANG_PROPELLER_PROFILE_PREFIX)_cc_profile.txt -ffunction-sections
-  KBUILD_LDFLAGS += --symbol-ordering-file=$(CLANG_PROPELLER_PROFILE_PREFIX)_ld_profile.txt --no-warn-symbol-ordering
+  _ldflags_propeller := --symbol-ordering-file=$(CLANG_PROPELLER_PROFILE_PREFIX)_ld_profile.txt --no-warn-symbol-ordering
 else
   # Starting with Clang v20, the '-fbasic-block-sections=labels' option is
   # deprecated. Use the recommended '-fbasic-block-address-map' option.
@@ -26,14 +26,18 @@ endif
 
 ifdef CONFIG_LTO_CLANG_THIN
   ifdef CLANG_PROPELLER_PROFILE_PREFIX
-    KBUILD_LDFLAGS += --lto-basic-block-sections=$(CLANG_PROPELLER_PROFILE_PREFIX)_cc_profile.txt
+    _ldflags_propeller += --lto-basic-block-sections=$(CLANG_PROPELLER_PROFILE_PREFIX)_cc_profile.txt
   else
     ifeq ($(call test-ge, $(CONFIG_LLD_VERSION), 200000),y)
-       KBUILD_LDFLAGS += --lto-basic-block-address-map
+       _ldflags_propeller += --lto-basic-block-address-map
     else
-       KBUILD_LDFLAGS += --lto-basic-block-sections=labels
+       _ldflags_propeller += --lto-basic-block-sections=labels
     endif
   endif
 endif
 
+# TODO: change LDFLAGS_vmlinux to KBUILD_LDFLAGS when kernel modules
+# are supported.
+LDFLAGS_vmlinux += $(_ldflags_propeller)
+
 export CFLAGS_PROPELLER_CLANG
diff --git a/scripts/Makefile.vmlinux_o b/scripts/Makefile.vmlinux_o
index 23c8751285d79..ee070bf35385a 100644
--- a/scripts/Makefile.vmlinux_o
+++ b/scripts/Makefile.vmlinux_o
@@ -56,7 +56,8 @@ vmlinux-o-ld-args-$(CONFIG_BUILTIN_MODULE_RANGES)	+= -Map=$@.map
 
 quiet_cmd_ld_vmlinux.o = LD      $@
       cmd_ld_vmlinux.o = \
-	$(LD) ${KBUILD_LDFLAGS} -r -o $@ \
+	$(LD) $(KBUILD_LDFLAGS) \
+	$(filter-out -pie, $(LDFLAGS_vmlinux)) -r -o $@ \
 	$(vmlinux-o-ld-args-y) \
 	$(addprefix -T , $(initcalls-lds)) \
 	--whole-archive vmlinux.a --no-whole-archive \
-- 
2.51.0.788.g6d19910ace-goog


