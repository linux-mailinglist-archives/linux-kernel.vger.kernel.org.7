Return-Path: <linux-kernel+bounces-848791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2B8BCE931
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 23:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 297C34E4DA1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 21:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318E930217B;
	Fri, 10 Oct 2025 21:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fpu42L02"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07042F25EC
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 21:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760130106; cv=none; b=UwNNef3m+q3EIkomF8TRoN8EDCj1FVpW6WTc8p61Q0lUqWshYcpn/YgYq3L7TNuMPp8R+CdZCzBXBNpleA+QqyhUBF2ZtXORCKM1dgTLmplMwsMmxH3x3pE1O/VD7MNpaP9ELfpIi9sKwCqqkpV7ogJZ1e0Fb62LrduZHo+b8JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760130106; c=relaxed/simple;
	bh=q2WVUyCG5tHc5o5qJP5O0XCzNOqQPweayFUQN6bek4Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IONbHk6rFHgCVKNEMgpb+pXsgP85p9V3adtzlYKAjIpR0sfmRh2GmDfe9X+3pscJLTodNome/XQ/sFahIym+MqJoLW/TR6NQrFkOxiYPv+AFC5wsgl+c3nohHF0w4clyfiHTJZMFEW6IqeGpJQmyImZh05xJ3OoRcxKISSh4pL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--xur.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fpu42L02; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--xur.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-27eeb9730d9so56622355ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 14:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760130104; x=1760734904; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=q/wDnyhqkiKRqW0IjdCp0H/hnRPnE56SCwkMuf1SQlY=;
        b=fpu42L02e0bBNKn05/KX6GFnfECBFbMqR7VY84CB3lAFvDbvvGaw7O1ejiAybr7eC0
         AtH/I98/rXi4XXEcU/2eBXSfS0z2fRuaOQ7DvXzq0q+RFIFJsIozhMK3PkVmVWGuAG6A
         DlIxopGjScCm8IQNZxgAUuWkSedXRz/g3+HUVRgEd3nUW8BfCP9ZLT2HVRXa2MZLpCbS
         ftPOIu43fMhFhMhTSGVnPQ6YTVxD0mugMkzKHSTFBIWzPIyQDiY6PIoybDEgBFKcsNho
         wyXr554alWaY3m4Bboyc7KBnP1JJIgsFNPGVvBP9zayrds/Aay71OEi9lZly3QtwL0/H
         H0jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760130104; x=1760734904;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q/wDnyhqkiKRqW0IjdCp0H/hnRPnE56SCwkMuf1SQlY=;
        b=FOPvRfgCHqwYJTa8tWR2HuOf0hxN9+N9oZ4YpYC3GnZc4E3e+/oyUkIIl3BH6vrWVJ
         7LA8OlAxZR9eL36rM1Cn72yU0ipyt3e7QW+9dIAvM1Hfwzh6GTRnv2rieF/kAJ4ZFGrp
         DoYKTQEE2J/cmzWHShQccdOCHR4MKpx4o7XvnHLQizYk02ghDRo4+RLM/r2ftZCJycSe
         lgM1Ces3oJNCK/Imib2Vg4QSqxVLJeTe/eAEpqL1QGBkA5TzocUsOUCiMllHKAyH7DXy
         8NbRU7BmWwSuCCGaQpWJ0of+f98dvMwh9oAWUI5Z1nxMgeLxEBBANWRlPoMVPIkg60Ab
         UQsA==
X-Forwarded-Encrypted: i=1; AJvYcCWaNj4XsjEXNFV1Sr71ZKAyxAKEC09/TJKrRtmruNWlbfsx1OTy4NDpLS6CxKUkBVfbYiSuXTVM+0iGp24=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjQd28b/NB4Dx3ImH8kGHPmpO8Lowtxk4vRv8nP/FB0grScOYy
	bn9DFdn5Tpd+cID61IbYllO0D5uOPiqJydTuh41UEQQOyioDaIXraNIRKAL2JMtqsq/qiQ==
X-Google-Smtp-Source: AGHT+IH7+DQHEYaFa4vkW04Ba4BYGyws7ixpIQqYpHEmAr7KOX0ZVzNnotiWDd8X62vdONAhobou7zg=
X-Received: from pld16.prod.google.com ([2002:a17:903:3550:b0:290:28e2:ce62])
 (user=xur job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ce87:b0:250:6d0e:1e40
 with SMTP id d9443c01a7336-29027356a6emr202791475ad.7.1760130103552; Fri, 10
 Oct 2025 14:01:43 -0700 (PDT)
Date: Fri, 10 Oct 2025 21:01:32 +0000
In-Reply-To: <20251010210134.2066321-1-xur@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251010210134.2066321-1-xur@google.com>
X-Mailer: git-send-email 2.51.0.740.g6adb054d12-goog
Message-ID: <20251010210134.2066321-2-xur@google.com>
Subject: [PATCH 2/4] kbuild: Disable AutoFDO and Propeller flags for kernel modules
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

Signed-off-by: Rong Xu <xur@google.com>
---
 Makefile                   |  9 +++++----
 scripts/Makefile.autofdo   |  9 ++++++---
 scripts/Makefile.lib       |  9 ++++++---
 scripts/Makefile.propeller | 12 ++++++++----
 scripts/Makefile.vmlinux_o |  2 +-
 5 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/Makefile b/Makefile
index 6f88b1d3b40d9..f40bee23d5536 100644
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
index 23c8751285d79..9c4f0841e5c5d 100644
--- a/scripts/Makefile.vmlinux_o
+++ b/scripts/Makefile.vmlinux_o
@@ -56,7 +56,7 @@ vmlinux-o-ld-args-$(CONFIG_BUILTIN_MODULE_RANGES)	+= -Map=$@.map
 
 quiet_cmd_ld_vmlinux.o = LD      $@
       cmd_ld_vmlinux.o = \
-	$(LD) ${KBUILD_LDFLAGS} -r -o $@ \
+	$(LD) $(KBUILD_LDFLAGS) $(LDFLAGS_vmlinux) -r -o $@ \
 	$(vmlinux-o-ld-args-y) \
 	$(addprefix -T , $(initcalls-lds)) \
 	--whole-archive vmlinux.a --no-whole-archive \
-- 
2.51.0.740.g6adb054d12-goog


