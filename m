Return-Path: <linux-kernel+bounces-853250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F316DBDB03B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 21:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B32D5422288
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 19:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4CCA2FBDF8;
	Tue, 14 Oct 2025 19:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nYo3xJrO"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA132E2EF9
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 19:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760469129; cv=none; b=aRqJQAPBjr9GPR/rL1CEcR0veHDtlavmoaI1ITddX2VqtdQF5AYPLESXv2WJgOu9yMzJaJtFHAKLN5knisXrCRvWSfCeVfbKyhwiBrljKmufJce5hYj9d3uhV7aaYKCmVhK1IRUIKZRgTjnevqNVYI2E9QwBNX3CVBK7qEPREVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760469129; c=relaxed/simple;
	bh=t9jLJHWdyiSzQs+a689FPxJdopVxx51fZYgZFEcmQ5Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cL593HUVq7dLb+NsAr4ZGICs+ZAf0XDQrAewunysV9RPcqKEeBVsqeuB+5o/cDJOGyK5TYfJpQmH1BMo/VuasRR7blxkHCROSNkysasMPnAyvylBU8ESlhMCfeMnReIcpW1arWlNVJqepanHWyFziMlS8kRJDy+Crd60vnCjj48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--xur.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nYo3xJrO; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--xur.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-33428befb83so13190026a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 12:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760469124; x=1761073924; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=L2k6wtYt3FDVRDHH1AoubVXUFy6ND2LEU/3IEKkdm9o=;
        b=nYo3xJrOl3jOrBCo9deUBQZRvglFvGANRhYHdn3Y+MRJhCgIs5RRprabptUAcl2Oti
         GXG/4JypDVFPzGswCKZsePCUJNgNH1G4GLWO/Ayefj9uwldVMXyeC78GoNcbAhTUS83m
         MILzh791VEIMT3tkNlpmDrGnBVxVc1sXqYEyPFVMD6PrqOXXZPp0AI743EMQNaQm5E1k
         soBdYex3FNr1z5OO1HgS8XPw80ZbNg20GKfwnMCq6K+A97cVnxa0YfInsVDBmuknNoqs
         gu+P3EHraWdv1CsHDuc4v5LVxdl7b57lfVCrVZQzs+biUh6cwFGf2gO+KVh1dJiHsCWO
         VJDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760469124; x=1761073924;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L2k6wtYt3FDVRDHH1AoubVXUFy6ND2LEU/3IEKkdm9o=;
        b=Mc4corDtwcfrPkK4y9X6lw+GAkkmPDRPkii9h3zT4mA1bX3xTklzeEVToInmIjaxHY
         NLuWTkpUvzeCF0oDveb0EPeg1gKVMoPxN60v6ZiPFgDdZ/kCTq3LMgKYJ8DCo7pOu6R4
         22p7czfALbNHPwVF+miGeOQcAmFZgj7R4YlXOWMk0WWvudDmLZNsvtP4BZ5TCoIcV7Ib
         XMbMnvVkd6XBGJM212LHT9kan0O96oO2bPhwLHuGZKhZRfGbrdoBx7EdlXV6EonbZ7KZ
         oKwiD3QLGYaNFELNubYrM9J9AhujEclBzCrf3yuNUyjH7nWcuM0x5ojfERJ9fIGYX1tx
         Qhgw==
X-Forwarded-Encrypted: i=1; AJvYcCWZJAuvHIa33OolyqZlRdad0I18nm5rK3xBlS1OMSN3c9r7jlXojSRjlFiMbe9JnaGCxOcdhReF0YA2Hhg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5XRYhXeyam7TXAjLR2NH4qnayMzgAmHAH8Xu9PQzZsL7j96PV
	9xzaiVCn1m1lgSrH3tFM+yTz18Zg9OEPY6g3Fo9uImunX5Hnhia2VD5u3/+dgLuB1kF1pg==
X-Google-Smtp-Source: AGHT+IHulkYFxj6v34g0vqq41jw+L0+RXXWl3W28nXbYFSfeZcxshajXMcaq1+9j7wMsxlIF15JufAg=
X-Received: from pjto23.prod.google.com ([2002:a17:90a:c717:b0:33b:51fe:1a8b])
 (user=xur job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4d10:b0:32e:d282:3672
 with SMTP id 98e67ed59e1d1-33b5138db1emr37538703a91.23.1760469124371; Tue, 14
 Oct 2025 12:12:04 -0700 (PDT)
Date: Tue, 14 Oct 2025 19:11:55 +0000
In-Reply-To: <20251014191156.3836703-1-xur@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251014191156.3836703-1-xur@google.com>
X-Mailer: git-send-email 2.51.0.788.g6d19910ace-goog
Message-ID: <20251014191156.3836703-4-xur@google.com>
Subject: [PATCH v2 3/4] kbuild: Remove MFS flags from Propeller profile
 generate builds
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

Propeller profile generation requires Machine Function Splitter (MFS)
to be disabled.

Change-Id: I12579e6f2cfaecefbed0ce85f1904f79783562a1
Signed-off-by: Rong Xu <xur@google.com>
---
 scripts/Makefile.propeller | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/scripts/Makefile.propeller b/scripts/Makefile.propeller
index fa018098506b8..8c3e514dbcc04 100644
--- a/scripts/Makefile.propeller
+++ b/scripts/Makefile.propeller
@@ -13,8 +13,14 @@ else
   else
     CFLAGS_PROPELLER_CLANG := -fbasic-block-sections=labels
   endif
+  # Disable Machine Function Splitter for Propeller.
+  # Propeller profile generation requires Machine Function Splitter to be disabled.
+  # We use -fno-split-machine-functions to override any prior AutoFDO/PGO flags
+  #(in Makefile.lib), assuming Propeller options are applied afterward.
+  CFLAGS_PROPELLER_CLANG += -fno-split-machine-functions
 endif
 
+
 # Propeller requires debug information to embed module names in the profiles.
 # If CONFIG_DEBUG_INFO is not enabled, set -gmlt option. Skip this for AutoFDO,
 # as the option should already be set.
@@ -33,6 +39,8 @@ ifdef CONFIG_LTO_CLANG_THIN
     else
        _ldflags_propeller += --lto-basic-block-sections=labels
     endif
+    # Again, we need to disable Machine Function Splitter.
+    LDFLAGS_vmlinux := $(filter-out -plugin-opt=-split-machine-functions, $(LDFLAGS_vmlinux))
   endif
 endif
 
-- 
2.51.0.788.g6d19910ace-goog


