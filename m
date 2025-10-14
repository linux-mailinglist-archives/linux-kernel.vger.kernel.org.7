Return-Path: <linux-kernel+bounces-853249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EA347BDB035
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 21:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CD4C84F2D20
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 19:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5570C2C326E;
	Tue, 14 Oct 2025 19:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SXU1amsf"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CF32DC772
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 19:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760469128; cv=none; b=TrnPzm/LeDhXvWD8oVXwfr3BJde2qS/6v1V4sUqbUz4HRZ0CQs3rE+RLENuX6gI7rFL9NC6ZUqFTX+2Xb/IzAigeUE47SsrMtQ8GBbRr/7SDZSD9icdK0+bB5s1fsV1348YwTr8NZAA3Fpsab0gRuo88C5iwySHJqlBPm3KNm/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760469128; c=relaxed/simple;
	bh=cx36TyRZQRd8d2KdjPrZq7eNjP57j04LkvW74Zdo8sQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=m/FQ10lkVsCY7hT2XDrWmF+g5spAMRK3mqW2Y2l26s2yw4H26/Aph5O0yS+lHZYKmhVMbc227BRk+MtznHBfNKCBIkT4RCzLHXXXbPloytYGcaxk9Su6zUyfLUFcMrM0EAk8C9E+zHRf3NB5u1Q+tF5loM10ZaljV1foOlWf0YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--xur.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SXU1amsf; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--xur.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-33428befbbaso12598986a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 12:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760469126; x=1761073926; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zBllpB0ePNMOVbkElWmvNsFG+oJS+DPSsTH9YVldxTc=;
        b=SXU1amsf/jmSp+ogqNGR6/2XORm/gUcEflcrNWIjmvI7giOG0vN5xorDvZJn9RzpyB
         Q+kIm/peAO6fHjtQB42iFSEXLEIIOv7o0r4X8C1j5/myf7t7mEmSFMmx0ndAMPkEk/7n
         lWUcerMg10DEmPnhHek0d+PVOWQa1TBgLO9TjDmGW8uAXm4doZXHOb7IsWnTeXmjMZ0s
         xloIZ9ucGAqQMOoJDrK6PK/ApiwyWjUetcVcDmcAxLIFdvY8uD5OFhpR8iB/lG4QqF7x
         YgsvCMuAzz/rYKpiEcZXg29GGRX5tvdAlPUfC7QOwJRvaE4/Z5OK/wa/bgHn5cU5EBCf
         6v1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760469126; x=1761073926;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zBllpB0ePNMOVbkElWmvNsFG+oJS+DPSsTH9YVldxTc=;
        b=fiufErkDtI+xl+B6m1jzWf2E7a94xmjj51Gu37nuYq2zfDlyXMZWii6mrO11MDLyai
         E6VsqbkO5/pKemGkX48dir+SDZTem0L0s1lxTxvZKwYzSLKTIrtep4OYJs5rwT3kYobZ
         t2GNxgD8bAs12/rTY+JYX3E+q4DN2lgjlIhzSDanpq98ODlqmnxdFCVGBoDAzmkWEWf3
         VNTVXvFOsoPz7ZkKr6GxZfTr1C6I0uFsT9Cf9vObY5f9aL5BU7/ygTIN/xAhx++2rzoA
         k712VPBC85GFfjGShhNboiK8KiFqCXdRGGnX5k6ovkrpGGJhunkDVz7io4zprtyho+bK
         DRLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrtOLiGx0j7WEA1xtdHgBiA0aMhGeUUGh+O1Flk9kG53XdJnI28cJum0jkK2A75uzug9oEpzC9z5PP21Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzluZ4830W02a05tOJUxemawvwXtiwJn8chERNdmsDqpwi61DId
	pM/13JSFi5XYZqlPYnLLoZ+gme9bsiMBP8zMcZXmObkcPLbdUdlnAo2T7y15WdQhlFsHQA==
X-Google-Smtp-Source: AGHT+IF7GZo6/ROXKJlnWT1JhTqmzbjvSVDgDSvfujyxO4MGyLwSW7azfV21spAGRwjheSwdbs4i9m4=
X-Received: from pjbgv24.prod.google.com ([2002:a17:90b:11d8:b0:329:ec3d:72ad])
 (user=xur job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1c89:b0:32b:df0e:9283
 with SMTP id 98e67ed59e1d1-33b51399970mr33646704a91.34.1760469125986; Tue, 14
 Oct 2025 12:12:05 -0700 (PDT)
Date: Tue, 14 Oct 2025 19:11:56 +0000
In-Reply-To: <20251014191156.3836703-1-xur@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251014191156.3836703-1-xur@google.com>
X-Mailer: git-send-email 2.51.0.788.g6d19910ace-goog
Message-ID: <20251014191156.3836703-5-xur@google.com>
Subject: [PATCH v2 4/4] kbuild: Add config to assert profile accuracy for
 aggressive optimization
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

Adds a build config to AutoFDO to assert that the generated profile
accurately represents the intended workload. This enables Clang to
perform more aggressive optimizations.

Signed-off-by: Rong Xu <xur@google.com>
---
 arch/Kconfig             | 11 +++++++++++
 scripts/Makefile.autofdo |  3 +++
 2 files changed, 14 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index ebe08b9186adc..6fdc676cb0fe4 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -886,6 +886,17 @@ config AUTOFDO_CLANG
 
 	  If unsure, say N.
 
+config AUTOFDO_PROFILE_ACCURATE
+	bool "Assert AutoFDO profile is accurate (EXPERIMENTAL)"
+	depends on AUTOFDO_CLANG
+	help
+	  This option asserts that the AutoFDO profile (specified
+	  in CLANG_AUTOFDO_PROFILE) is collected from a representative
+	  workload, allowing the Clang compiler to perform more
+	  aggressive optimizations.
+
+	  If unsure, say N.
+
 config ARCH_SUPPORTS_PROPELLER_CLANG
 	bool
 
diff --git a/scripts/Makefile.autofdo b/scripts/Makefile.autofdo
index 5bcfcef273745..36abeae2accdc 100644
--- a/scripts/Makefile.autofdo
+++ b/scripts/Makefile.autofdo
@@ -11,6 +11,9 @@ endif
 ifdef CLANG_AUTOFDO_PROFILE
   CFLAGS_AUTOFDO_CLANG += -fprofile-sample-use=$(CLANG_AUTOFDO_PROFILE) -ffunction-sections
   CFLAGS_AUTOFDO_CLANG += -fsplit-machine-functions
+ifdef CONFIG_AUTOFDO_PROFILE_ACCURATE
+  CFLAGS_AUTOFDO_CLANG += -fprofile-sample-accurate
+endif
 endif
 
 ifdef CONFIG_LTO_CLANG_THIN
-- 
2.51.0.788.g6d19910ace-goog


