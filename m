Return-Path: <linux-kernel+bounces-625646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9FDAA1B04
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 20:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A774717ECA8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 18:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4CD21ABDB;
	Tue, 29 Apr 2025 18:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fKvPCf+g"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0CB253321
	for <linux-kernel@vger.kernel.org>; Tue, 29 Apr 2025 18:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745953150; cv=none; b=k55gqmMwKWZlrZBZlnroNKLg8jvWlJTedaTcrur8e42KOb5katWICW24iRc8A3PYB0NFIFaiTYBu2iFu9oO+1dniMbr3C75Mp0k4WIdWW+t990j0JjOzJK4VmVA0ExslncqwFttYUX/L9k4qlJU40dM/4EcHdAC8Yk7w2rAKqIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745953150; c=relaxed/simple;
	bh=JKuR2HnO4uDM9v+Z7llC/3uiDFowURfwK74QDWYhdv8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=TQ7XBwScdkNAUu3gdvEZOZYmS5dxcv3EpZTssW8/aCKYOu59X4jCPo2ofGUjOEM0sikBFmo2v7wlOYN8EtqUSoKGbGIi+DGo9vcKc37UBNjhj8Qes7TpgL4DFrMhWoVTqVC/NZUfDPtAoLm7DXa2wBp5Z5D8Q2gbKJbBKNgvSFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fKvPCf+g; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff605a7a43so9213918a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Apr 2025 11:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745953148; x=1746557948; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eXJ8J07H9GMYt3devST83hdUmEga5s87LMXmrPwfkrE=;
        b=fKvPCf+gaZVDQfkmynEvFIEYEHR1BSCpdweSDhXd4Cc1QeEPCdRymYsL3XDIH2oVlB
         uY/ioN9kcoweilekVxVGCBng8e5r3SrJaQqmyaiDwXQxI9/OS/E+IM0HXBavsegwx5ZI
         c4MyEHMZHlgt5b9qJeeaL08/4cB0uGS7QjprLWSpIDdpOfNcxcNy6L14HQB6g8Fqt9AY
         +i45UJYFiECbxmQYKMurxKuhDPq41CWhZnforu/KDoUr2Gy1v6OO5APHsFXQyP4WCZ57
         xKnRUrLPDnfGjBRhxJzPaYs5xXPzQhXkRAWbYLUoJ8LRPjwOMazBEBCAfHGIGSPLDn4K
         p4UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745953148; x=1746557948;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eXJ8J07H9GMYt3devST83hdUmEga5s87LMXmrPwfkrE=;
        b=JaxUiX1G60mIxa5M/D8KVTWaIpb0rkExZPKHY4mT9hdWUvZfEu0AcKLZbsl6uzGIEw
         VP7PSz8X61nBJ/MkA2qSJ78YpOscjGtTfMOMpUSqog1gAPu5kJpTzsbSNfyGIyAmE5e6
         UGBtNdTNKw6Y/az2+di99pI+97NIdXsWhMMEvNkduFp6u/4m5S2D2j/5FM/mAib+hOIv
         jgRvhD2Qv6qppUF8DPtuR1kXhn20bQihVQ8K5FOsXde822SrmW5Y87Wxll5jVHn52QXx
         P4M84pRboS6YyONGGb8q6EW2SaKWlX6E+rRhZW5oanv8JXa3ObSpTdbhj/9QQ3Z0Cb0P
         cY+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVgxSeVDKawV32ejAGnpj45vVOowJiwdsgGBL83EV6BoFyc5SaNZFiBd0mv/31QWfeqYg8KHPSvaYKmKlc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzibshuiAWPZI+TDFaJ9aKCZjvf3Ueu1zvLhQMt5PzUtEBQQThX
	tDY/1aS2XpbVSjP63ygtERcyNsy2gPilftJYB7Ssb8S8rHKIRO+bhavh7aZ8MkbX/x1i0v7vg6t
	b4SnLRw==
X-Google-Smtp-Source: AGHT+IEwoN0N6+nJ6vqr/dgRzJLp6ISNYWD1HN7A2s+gg7YV9C0xR0d2OaoIaTgW058JKbZw1oATFTbdIpRF
X-Received: from pjbsm11.prod.google.com ([2002:a17:90b:2e4b:b0:301:2a0f:b03d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1346:b0:301:1c11:aa74
 with SMTP id 98e67ed59e1d1-30a333530c8mr307400a91.28.1745953148279; Tue, 29
 Apr 2025 11:59:08 -0700 (PDT)
Date: Tue, 29 Apr 2025 11:58:32 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.901.g37484f566f-goog
Message-ID: <20250429185839.1807005-1-irogers@google.com>
Subject: [PATCH v1 0/6] Use rustc-demangle for Rust demangling
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

Discussion of improved Rust demangling started with:
https://lore.kernel.org/lkml/jgxfnphfo3nzlfipnuuzdlfc4ehbr2tnh2evz3mdhynd6wvrsu@fcz6vrvepybb/
that led to implementing a Rust v0 demangler:
https://lore.kernel.org/lkml/20250129193037.573431-1-irogers@google.com/
Discussion on that patch series led to the rust-lang issue:
https://github.com/rust-lang/rust/issues/60705
where the pre-existing Rust C demangler, authored by
github.com/arielb1, was mentioned. There wasn't progress on that issue
and so I've pulled that work into perf as discussed on the issue.

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
 tools/perf/util/demangle-rust-v0.c       | 2035 ++++++++++++++++++++++
 tools/perf/util/demangle-rust-v0.h       |   81 +
 tools/perf/util/demangle-rust.c          |  269 ---
 tools/perf/util/demangle-rust.h          |    8 -
 tools/perf/util/symbol-elf.c             |   49 +-
 12 files changed, 2243 insertions(+), 305 deletions(-)
 create mode 100644 tools/perf/tests/demangle-rust-v0-test.c
 create mode 100644 tools/perf/util/demangle-rust-v0.c
 create mode 100644 tools/perf/util/demangle-rust-v0.h
 delete mode 100644 tools/perf/util/demangle-rust.c
 delete mode 100644 tools/perf/util/demangle-rust.h

-- 
2.49.0.901.g37484f566f-goog


