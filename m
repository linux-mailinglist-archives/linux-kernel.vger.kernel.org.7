Return-Path: <linux-kernel+bounces-625652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9356BAA1B09
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 21:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B18701B6869D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 19:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54239256C81;
	Tue, 29 Apr 2025 18:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zDymbMwI"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F339F2561AD
	for <linux-kernel@vger.kernel.org>; Tue, 29 Apr 2025 18:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745953162; cv=none; b=A0gufZqAtznJb4XbWCz+igQcMuBkCPjbGDy9U6L+3SPev6Qc+e5Z/tKu5rn//Mykcdo3tN/8L73h8+6r5uC1dVr6TQz1paK9x6XFbKHCrYDYFa4khVM/ldXOSsWHUjRs6CQvkO9zoSqmBawZmUntW4gtvzgXG43wdHDq1kcKrZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745953162; c=relaxed/simple;
	bh=pLvxUdxndsr2wYkJQYg49ecez/cviTwRj3eN4nJwgxo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=guKeXWqTiBxDD7MXJZV6c47uLhNF/SlJAey3kXtylNiNyOCYMh5rxRdlHW7k3eSkEvmty2d8EzQ7eFbsTisMLDqkk+ThWy/ccxioorZGE8+L4qhkFu5ik07i52VU5tO2WIIM24SprEUcbOnzFqfFg/n/My/AzJY24w7eupSuekI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zDymbMwI; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7375e2642b4so4401281b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Apr 2025 11:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745953160; x=1746557960; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VWjkucJuMaosxMcy1Z3rSUNsLtdDY3ZZywavpz7InSY=;
        b=zDymbMwInQKAVcErEFRAR0EnDlvRzMLF6vT3IWe/I5jn6ZqKYWFMQTzDb/yKLiK8MQ
         0llb0Hz6Jj+P+dFCNAWXh6EGpTJ0Fr2BEVbldENl0IKRziQvzfiuLNwkszqIaIBtwEIu
         LQqnEA/4NCTx6le+xKRAAAyTWO387bdFwFjJMgFTmiD2eemwsUwEYxU5o9ARgFGu/Ja0
         2tbSQlPw6dR3elEFfbdi3Ur+fLZw09tCJQGzy/zPSqJXJMwkC18qgAu/N+5QfSugwpkE
         Y6hQrLKlhzHdbotbu5XpuyXIncHGemGaBe4mKv2S1dpF+ASEGDZY4c+bZ4OmtX0zhqPE
         lngw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745953160; x=1746557960;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VWjkucJuMaosxMcy1Z3rSUNsLtdDY3ZZywavpz7InSY=;
        b=VLM7/kIJejKet1sPFAZNB94LtCszNS1R948GqrxuYxzJKq0f3A7FH6XFqualBgbG5a
         xN5wb2wnVmnjnYKsX10eHKrisXCqTxpNzrOtjg5U6Fp7AVUc4TN4kpv/Bl9tk1kHO7xH
         9J1RFF46ROLyQL6/OAF8JgmMIfj7aFafLTLPPch5oFWVAvHFfhq95o1M7kKSorpPoVk4
         FEww7iqep3e7DBqwywAc9gnhJ1Y89rIkYYJx0KY502z57Yk1Czkp3eWZVhAgAOyIHW6D
         +AmHSyHofUwBaozGYw+fFxDqW4uVMVvNBWMQgJJ5D/cL1Y78bLuh/9UB6q6C8JMWeLdW
         P23g==
X-Forwarded-Encrypted: i=1; AJvYcCVJvYydw9VYRFOtgGoFuZh3fdJkXk+W8vZzVc1B5lcVWVis5sfl4sV5yG+MMJ7F14vWky7F8+MtSUhTl18=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEfY+BKukJ4S9CHu1QkGCatQyusbtFlG+DP42lIjeKlmwyg8Ge
	6TGXxVq2QQO16066U3NBi155gMhXD33fmsPLvNnEguggSIGDeKPV3g9tDJ4NVKtn3Ciz9nZMmnA
	SUwFKEA==
X-Google-Smtp-Source: AGHT+IE9GdSCCd1KtURt295JV/22SX3CPi6lw9sUTh1EaaTFjgWPJE0uM3WPfZxAJUze5crpoLd8uFNTRjF3
X-Received: from pfbkq4.prod.google.com ([2002:a05:6a00:4b04:b0:736:56a2:99ac])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:d504:b0:1f5:7c6f:6c8a
 with SMTP id adf61e73a8af0-20a899fc238mr130852637.35.1745953160176; Tue, 29
 Apr 2025 11:59:20 -0700 (PDT)
Date: Tue, 29 Apr 2025 11:58:38 -0700
In-Reply-To: <20250429185839.1807005-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250429185839.1807005-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.901.g37484f566f-goog
Message-ID: <20250429185839.1807005-7-irogers@google.com>
Subject: [PATCH v1 6/6] perf test demangle-ocaml: Switch to using dso__demangle_sym
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, llvm@lists.linux.dev, 
	Daniel Xu <dxu@dxuuu.xyz>
Content-Type: text/plain; charset="UTF-8"

The use of the demangle-ocaml APIs means we don't detect if a different
demangler is used before the OCaml one for the case that matters to
perf.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/demangle-ocaml-test.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/demangle-ocaml-test.c b/tools/perf/tests/demangle-ocaml-test.c
index 90a4285e2ad5..612c788b7e0d 100644
--- a/tools/perf/tests/demangle-ocaml-test.c
+++ b/tools/perf/tests/demangle-ocaml-test.c
@@ -2,10 +2,9 @@
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
-#include "tests.h"
-#include "session.h"
 #include "debug.h"
-#include "demangle-ocaml.h"
+#include "symbol.h"
+#include "tests.h"
 
 static int test__demangle_ocaml(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
@@ -27,7 +26,7 @@ static int test__demangle_ocaml(struct test_suite *test __maybe_unused, int subt
 	};
 
 	for (i = 0; i < ARRAY_SIZE(test_cases); i++) {
-		buf = ocaml_demangle_sym(test_cases[i].mangled);
+		buf = dso__demangle_sym(/*dso=*/NULL, /*kmodule=*/0, test_cases[i].mangled);
 		if ((buf == NULL && test_cases[i].demangled != NULL)
 				|| (buf != NULL && test_cases[i].demangled == NULL)
 				|| (buf != NULL && strcmp(buf, test_cases[i].demangled))) {
-- 
2.49.0.901.g37484f566f-goog


