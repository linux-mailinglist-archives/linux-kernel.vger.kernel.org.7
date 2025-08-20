Return-Path: <linux-kernel+bounces-777719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AFBBB2DD10
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 14:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAD551BA6AD8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 12:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0F82E6117;
	Wed, 20 Aug 2025 12:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qiIFpN8a"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C822DECA3
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 12:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755694382; cv=none; b=miy/l0QGDrLHu7v1R6prIG0bh2Qg2cWGzOnW2gTAAwScwAeS4J2Ug9uB/VCJORDk5nOw9MyEO2StF+OUPuVVvcc4q0Lr8I8B2eBTEVNhaMvmSYRGD+l09yakUQBWUM7b7la5zbdWU5XHi39bGkKYepufz3ReBjiC/F28SFoYrh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755694382; c=relaxed/simple;
	bh=GG4x+CutKMR6WqOK8NkY6FdnesLerID/jLDBIE48Uag=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RX9N0vdBwAUhF3Qk4+MhNjISYB82pP0WwWc+f9Wa1bsqknfVmdFajY7bNxOYC9BIFgxZwmzjNzFzPFPtNMvvmVXrmC8AYYlJSVd3m5QpQeQ5gSJgOGpueyUGkCz9afWwyfkygxKRvcNLxIp/znAoqcxdK4wdd9C1Hg4rHuM5Y7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qiIFpN8a; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3234811cab3so4967053a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 05:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755694380; x=1756299180; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=u8tQsJtbOtmViZK75zDsxOA6YlL6q69XluwQxXqwuqg=;
        b=qiIFpN8akT00PY8gSH6tRFL/ggIvnzGQWXD9jlJgET0SPWgYxGdwIbgU1SIqNs4qFm
         vOmDdV/iBICKL1sn8QQN+weL3MX1NyvRkTYf/nOL4rmAljkF7lcvPjSzrRm1b8ztiOon
         M6YNR5GS+hl12M97K6ikeuEtErayqIlB5ffcTe5esosT2/wYt/0gHSQ7EYbYQ85YlYNq
         H4koVvjPNY4C8GHR8/YjsK01wnU89YE5vlRO9h05AavC8JvUzpk7CN2UK26Z15YSnWeh
         VCnDwc1jeEyG8Hv33dWbbC4iYd1SSbReqFJyyn9OPOJ9fAf6mj+uATBLWuIjXFBdWUVz
         oJuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755694380; x=1756299180;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u8tQsJtbOtmViZK75zDsxOA6YlL6q69XluwQxXqwuqg=;
        b=RZNqVWrVMsr6yHWQGG9AnYX0nAubFELnFxXjWD/phuvzsh60vnvK90b6KqfW8xHD1x
         9uvb7SKDm/3mLu+D01fjxIeS/TtrBkk0Wjn9gch7QBg67EuP/3K+375wzkrnaDHsfgXV
         RBkyl4I5aOi1wfTMcjglCt60xNUOVkf8MIqfEq4jyZV0femrPsGBxlB0Po3chUWQAisj
         YbPyG63maDkmIl1OX9yQkkJcAnihWcEMJ9GesTHHE46X0YNBPD83wpiviZB9zXhi7i5Y
         iFRlQB7Fxs/UcECM6VJFrG3hLT1QXvnTph496V5CMvH0poEIOp6Qqb7i1VffzOAznEa/
         cDQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUezLTwHh0QjhuWsq0X6QcsYslFoab+yDEUyoidpId0qAOjB+dLUAdbrfPCZ8G8jpY41knekRYjw1Kgzc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ6p+kYnYR38Q13xau8rglTaaVWm2c3WzVRyZ5zRlABYoPm/H7
	Mzzh1il8M9Cv2X/JQMZn8m8slVED3os22S4+Luan907XdRwRMyIqT7CkCfgVDYz/NKUKshMAAXL
	wGAl1uA==
X-Google-Smtp-Source: AGHT+IEFE0ZzF3ZW8fsqHa0cuy+ndasKY0AFzvFN3x8x6GXIRGKtUDymw3twpbsRdEmTRMJYxx28v6VS0pM=
X-Received: from pjbee6.prod.google.com ([2002:a17:90a:fc46:b0:31e:fe0d:f464])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2cc7:b0:31f:8723:d128
 with SMTP id 98e67ed59e1d1-324e1422c22mr3402153a91.34.1755694380232; Wed, 20
 Aug 2025 05:53:00 -0700 (PDT)
Date: Wed, 20 Aug 2025 05:52:57 -0700
In-Reply-To: <18f2ea68-0f7c-465e-917e-e079335995c1@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250624231930.583689-1-seanjc@google.com> <18f2ea68-0f7c-465e-917e-e079335995c1@sirena.org.uk>
Message-ID: <aKXFKaJuZZTbAbJD@google.com>
Subject: Re: [PATCH] selftests: harness: Rework is_signed_type() to avoid
 collision with overflow.h
From: Sean Christopherson <seanjc@google.com>
To: Mark Brown <broonie@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Aug 20, 2025, Mark Brown wrote:
> On Tue, Jun 24, 2025 at 04:19:30PM -0700, Sean Christopherson wrote:
> > Rename is_signed_type() to is_signed_var() to avoid colliding with a macro
> > of the same name defined by linux/overflow.h.  Note, overflow.h's version
> > takes a type as the input, whereas the harness's version takes a variable!
> 
> This patch is in -next and is causing widespread breakage in the
> selftests -next on at least arm and arm64 due to:
> 
> make --silent --keep-going --jobs=15 O=/build/stage/build-work INSTALL_PATH=/build/stage/build-work/kselftest_install ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- kselftest-install
> 
> ...
> 
> In file included from test-pcmtest-driver.c:10:
> ../kselftest_harness.h:59:10: fatal error: linux/overflow.h: No such file or directory
>    59 | #include <linux/overflow.h>
>       |          ^~~~~~~~~~~~~~~~~~
> compilation terminated.

Argh, many selftests don't add tools/include to their include path.  The least
awful thing I can think of is to go with a minimal fix to avoid the collision.
AFAICT, nothing outside of kselftest_harness.h uses is_signed_type(), so this
shouldn't cause a different flavor of breakage?

--
From: Sean Christopherson <seanjc@google.com>
Date: Tue, 24 Jun 2025 16:19:30 -0700
Subject: [PATCH] selftests: harness: Rework is_signed_type() to avoid
 collision with overflow.h

Rename is_signed_type() to is_signed_var() to avoid colliding with a macro
of the same name defined by tools' linux/overflow.h.  This fixes warnings
(and presumably potential test failures) in tests that utilize the
selftests harness and happen to (indirectly) include overflow.h.

  In file included from tools/include/linux/bits.h:34,
                   from tools/include/linux/bitops.h:14,
                   from tools/include/linux/hashtable.h:13,
                   from include/kvm_util.h:11,
                   from x86/userspace_msr_exit_test.c:11:
  tools/include/linux/overflow.h:31:9: error: "is_signed_type" redefined [-Werror]
     31 | #define is_signed_type(type)       (((type)(-1)) < (type)1)
        |         ^~~~~~~~~~~~~~
  In file included from include/kvm_test_harness.h:11,
                   from x86/userspace_msr_exit_test.c:9:
  ../kselftest_harness.h:754:9: note: this is the location of the previous definition
    754 | #define is_signed_type(var)       (!!(((__typeof__(var))(-1)) < (__typeof__(var))1))
        |         ^~~~~~~~~~~~~~

Use a separate definition, at least for now, as many selftests build
without tools/include in their include path.

Fixes: fc92099902fb ("tools headers: Synchronize linux/bits.h with the kernel sources")
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Link: https://lore.kernel.org/r/20250624231930.583689-1-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kselftest_harness.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 2925e47db995..8516e8434bc4 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -751,7 +751,7 @@
 	for (; _metadata->trigger; _metadata->trigger = \
 			__bail(_assert, _metadata))
 
-#define is_signed_type(var)       (!!(((__typeof__(var))(-1)) < (__typeof__(var))1))
+#define is_signed_var(var)	(!!(((__typeof__(var))(-1)) < (__typeof__(var))1))
 
 #define __EXPECT(_expected, _expected_str, _seen, _seen_str, _t, _assert) do { \
 	/* Avoid multiple evaluation of the cases */ \
@@ -759,7 +759,7 @@
 	__typeof__(_seen) __seen = (_seen); \
 	if (!(__exp _t __seen)) { \
 		/* Report with actual signedness to avoid weird output. */ \
-		switch (is_signed_type(__exp) * 2 + is_signed_type(__seen)) { \
+		switch (is_signed_var(__exp) * 2 + is_signed_var(__seen)) { \
 		case 0: { \
 			uintmax_t __exp_print = (uintmax_t)__exp; \
 			uintmax_t __seen_print = (uintmax_t)__seen; \

base-commit: 923fcb3dbc0246fc5207093c0049af4c56f20e41
--

