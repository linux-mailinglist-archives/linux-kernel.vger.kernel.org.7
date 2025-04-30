Return-Path: <linux-kernel+bounces-626184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B000AA3FA9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 02:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D79934A0AA3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 00:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F055383;
	Wed, 30 Apr 2025 00:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="27RO7OP3"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD8B9444
	for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 00:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745973699; cv=none; b=AuboOwnGwZyZkaY0+8GK5IRwCHd5LWx8gjLs7Ujq8XAzYqMJOxwjDicdJ+KEm75BjqmZLbFpO+7aBInBQ5cASkvKqiN/Fot7egziIibCPvOB49O/PaXJzNxnPv7z9OGzvAZRGhRB0kUXSteke5F+fMMWOWNNYszWoai1toKD/xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745973699; c=relaxed/simple;
	bh=TOqGYGaZz9fvoejadFEUP6gpffSVdtLwcV7I+VdXHNY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=kCuW3hO1wYwI5oTdP+zzaG3u5SOx0P709DZAfO97S2NsJtLdTE+229NxrVDB57mepU95Q1kzWzy9SPBkI/S0PwqyKJ4/s5Ih5JR1PnaC1TEgueivJslEJv6yFJK/Yb4ctTusJ1Weuim9UVfGZseAsRGAAQeFDbsYcz1g9cuNnhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=27RO7OP3; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff58318acaso9500922a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Apr 2025 17:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745973697; x=1746578497; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nhesGxbQSaQBAbqhCwSPE3SFnfsQfgQz+PVunKpo4yY=;
        b=27RO7OP3CLJD6mZHbzeX5RSBWkKTgm0vMD/y6XxBMQ96/sHF1XHlDGXbryODXHQfZF
         s+IhvPkzb/BWK4IKtI7ZdBql72UgeL8GnzdAwbz1V7t/Z5OR1ShIBEMqGnG/ncfr0Sn5
         L60tmdBBthGoGOR6GKScZV56i/UDBUkCz6+3vVHvf4tgfRhSVGJPfKPQSWNZLVfmQYRz
         WrIBnYOSMknGgdGWR1Pc1/c9GAIzvWQxOxOaH+Oc/UVntdYwr1AJUSAWCS7heodRHkDu
         yICzwE3NJAdYOh7w/RX33fYhW0BhWC/bk7GSIn+GMPxwZCT6SdHBz+NvH75AP7Xcfgge
         KjXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745973697; x=1746578497;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nhesGxbQSaQBAbqhCwSPE3SFnfsQfgQz+PVunKpo4yY=;
        b=K2uz3CsjWr6Q/1Ec5KMFD6+mcNYZHw+RONN+pl5QiBR/EMMyO4Epwt6+KpaGXSWfRg
         l8R8P74T2bpq4iGEIBaK/wiguHprnzCzG6sqUr1KT/j1wILNZG+m9Uv4G6hBqsH/o14f
         T+lePU14oHxfPBpkUKL/0oky19R1kuxJs2L/n6WhJA0IlpSO0QTpAXV2MxJSBToWwUFa
         pxhjKaRNLl7jIpNJvVktNjpo6+39KsVXiDXVNELdr3bQ02rhhrA6zIvg96XYE6cszT0e
         Hqx1fcFk6B/rtK+se9BbOoSpB34+R6Sbs+cMkh/6T2vuBut4IdJQUGrX6EphGQV/BqLd
         boUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxhl5E1Fw1ZCCokbl7u26arpMYu6IYfvumxKTUaswrHDqlTvtifHuaq9dO1VQwUlYpSRvJnyzio6KZ61Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1yBDQUpL4bKTaPVSNwER8xP3Llmhsup/aPoIHMCxVpq/tLVxK
	Gw2I6gs6cBs/dtC3h9k6YygF5UfRHNEUb91WW+0wS2jA30aeffVgCGn1qq6JLG3+TXS910iYfBM
	6CFrLag==
X-Google-Smtp-Source: AGHT+IHgctZQ0WCaEoa8Pxu0muUZeCA140D06nFHu0NZvmHnGRqOdyuKNhChOgWLSlk7PS9sR8xmBckQ5Ptv
X-Received: from pjbtd4.prod.google.com ([2002:a17:90b:5444:b0:2fa:1fac:2695])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5883:b0:2f6:be57:49d2
 with SMTP id 98e67ed59e1d1-30a33300eb6mr1898732a91.17.1745973697119; Tue, 29
 Apr 2025 17:41:37 -0700 (PDT)
Date: Tue, 29 Apr 2025 17:41:22 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.901.g37484f566f-goog
Message-ID: <20250430004128.474388-1-irogers@google.com>
Subject: [PATCH v2 0/6] Use rustc-demangle for Rust demangling
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
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
	Daniel Xu <dxu@dxuuu.xyz>, Ariel Ben-Yehuda <ariel.byd@gmail.com>
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Discussion of improved Rust demangling started with:
https://lore.kernel.org/lkml/jgxfnphfo3nzlfipnuuzdlfc4ehbr2tnh2evz3mdhynd6wvrsu@fcz6vrvepybb/
that led to implementing a Rust v0 demangler:
https://lore.kernel.org/lkml/20250129193037.573431-1-irogers@google.com/
Discussion on that patch series led to the rust-lang issue:
https://github.com/rust-lang/rust/issues/60705
where the pre-existing Rust C demangler, authored by Ariel Ben-Yehuda
 <ariel.byd@gmail.com>, was mentioned. There wasn't progress on that
issue and so I've pulled that work into perf as discussed on the
issue.

v2: Changes to references from arielb1 to "Ariel Ben Yehuda
    <ariel.byd@gmail.com>", license tidying as suggested by Miguel
    Ojeda" <ojeda@kernel.org>. Don't change from alternate demangling
    flag from false to true in the test change, make it true from the
    beginning (patch 2).

Ian Rogers (6):
  perf demangle-rust: Add rustc-demangle C demangler
  perf symbol-elf: Integrate rust-v0 demangling
  perf demangle-rust: Remove previous legacy rust decoder
  perf test demangle-rust: Add Rust demangling test
  perf test demangle-java: Switch to using dso__demangle_sym
  perf test demangle-ocaml: Switch to using dso__demangle_sym

 tools/perf/tests/Build                   |    1 +
 tools/perf/tests/builtin-test.c          |    1 +
 tools/perf/tests/demangle-java-test.c    |   17 +-
 tools/perf/tests/demangle-ocaml-test.c   |    7 +-
 tools/perf/tests/demangle-rust-v0-test.c |   74 +
 tools/perf/tests/tests.h                 |    1 +
 tools/perf/util/Build                    |    5 +-
 tools/perf/util/demangle-rust-v0.c       | 2042 ++++++++++++++++++++++
 tools/perf/util/demangle-rust-v0.h       |   88 +
 tools/perf/util/demangle-rust.c          |  269 ---
 tools/perf/util/demangle-rust.h          |    8 -
 tools/perf/util/symbol-elf.c             |   49 +-
 12 files changed, 2257 insertions(+), 305 deletions(-)
 create mode 100644 tools/perf/tests/demangle-rust-v0-test.c
 create mode 100644 tools/perf/util/demangle-rust-v0.c
 create mode 100644 tools/perf/util/demangle-rust-v0.h
 delete mode 100644 tools/perf/util/demangle-rust.c
 delete mode 100644 tools/perf/util/demangle-rust.h

-- 
2.49.0.901.g37484f566f-goog


