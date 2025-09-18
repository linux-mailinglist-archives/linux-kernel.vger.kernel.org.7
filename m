Return-Path: <linux-kernel+bounces-766997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C80F2B24DA5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 17:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC0F756266F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 15:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B848126E719;
	Wed, 13 Aug 2025 15:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VnQgspkz"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FA7242927
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 15:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755099357; cv=none; b=EvISabyHjVqmifjn2HFGHo9QX0sNTkW14YMCvGqAsllGul+ym2D0eaxPNLgQ/ldFhfidh/IXtSYSpgzftkRmp7kD65JULOF+VszFk1EAqb0+4zpraCAdZHYlQ3yL74SW7yF3aJVOAE2ERxmxHUvEvSspM824vmcOPA6I6kvEUFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755099357; c=relaxed/simple;
	bh=nAefCVPurRI4i8pyN/lArlZolw2f5/AOienIUoRdoPQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hZFw6Z+Xt4D3z5gYKKMChGAkA9LH7mBfY0jY6YaFdY1gJ6WZRlK3T+hqJ9jAfURhxbK9Graj1OlQJWZ7taKrff+6Y3QLf7TCL2qsCpzGWmudS3xIDBVtkF/sDbGciKGzUABuw/klWwEOOZp/RVvQhYgOawUw1g9zDrobq9gYfy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VnQgspkz; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3b788e2581bso3227405f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 08:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755099354; x=1755704154; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WTJ/r9bXaTFpTtDUGeEeFZMGB7wU8ouOoYvPnFBzAyg=;
        b=VnQgspkzH+WclT2CaPOacDTHvtik4LdWFpVo5y0942SGKjcVWPx+D8NKjWzRh1buDV
         XzQ8ztEkyv6dDrczB1xT9iz/NxLW1Hwn4HEK5jslrSWS2h1HczFsc+Ch+SncPi7tmn7b
         2Hk8OzESujyrvNN23MgWzG0QTgLciLDS4F8Rg/tiZc1aJZYfyAR8yWeFOS1Muupu7kGC
         vuUVwolLaCBegWJ0LlIDOmXAc1xaLcqBSiUb+OrCaC0FAOhcec1Uy/QAGhL2Q2G4CNTR
         9bmrh17f0Og6YMfCVxY26IDApz74FNdl8tyograwMLf594rPiUXZ3uHxg2bNroO1XhOE
         zJuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755099354; x=1755704154;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WTJ/r9bXaTFpTtDUGeEeFZMGB7wU8ouOoYvPnFBzAyg=;
        b=VN9wtDI1V89RuBzxPUiE+Msadd3T/IPhGov1RxYdha8Iu9G3gDRStpOaW+VzpGCB48
         NlaXY7Nj8TVinyk4UBo+1miCmz1Dv5l3ANYa2wDALpdmlsDvsdB9qi+LGbJB9ATA3at3
         yPcVSZWGsi0l5eVGY670Pfqc7w7Tv8PWOVwqPUeypXAPMnkDN78FJ4e3HSIUGwRJ219O
         UPMg6s2P8UBU2o9hZP2DNiYSOst+lqwYscJTAJWuJr8E1Q+PhHIdbKEi1gwB8NDU9AE0
         uzax2jDQXAgqyGMDY9Ga/K6Y13dR3EPShTM9f5AH+UG+qv/64itskjHaEsiYH2yvaNcF
         VgXQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/yd7vV8uUX1Ni+GT1UhJsvRr7kFz46WnL9NjixHiTwZsFfXtDuaUe8H2PsZuxEvU4xq8fi99lhk7mnbM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCM9QHmph2h1xRMWFvaxskSn0o+wZDWsdBjGFpZ+C/HtIbXdHN
	Po3SLQiIKRjtsBj5tDJoyFGIvO3utnliwX//dSxLMPdowcwfLtr58kDjh0XIHkYVXg9dmA==
X-Google-Smtp-Source: AGHT+IHyidtGE1wPgAR1BD1a1GXqEiEznqO+2+Jzs08mzkl8QpLtufQG9+8IQawAfWvvZA1IgV4bOF0=
X-Received: from wrp6.prod.google.com ([2002:a05:6000:41e6:b0:3b7:91ae:2671])
 (user=bqe job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:1acc:b0:3b7:644f:9ca7
 with SMTP id ffacd0b85a97d-3b917e51fd4mr3186918f8f.25.1755099353950; Wed, 13
 Aug 2025 08:35:53 -0700 (PDT)
Date: Wed, 13 Aug 2025 15:35:41 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.rc0.205.g4a044479a3-goog
Message-ID: <20250813153548.1650533-1-bqe@google.com>
Subject: [PATCH v14 0/5] rust: adds Bitmap API, ID pool and bindings
From: Burak Emir <bqe@google.com>
To: Yury Norov <yury.norov@gmail.com>, Kees Cook <kees@kernel.org>
Cc: Burak Emir <bqe@google.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, "Gustavo A . R . Silva" <gustavoars@kernel.org>, 
	Carlos LLama <cmllamas@google.com>, Pekka Ristola <pekkarr@protonmail.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This series adds a Rust bitmap API for porting the approach from
commit 15d9da3f818c ("binder: use bitmap for faster descriptor lookup")
to Rust. The functionality in dbitmap.h makes use of bitmap and bitops.

The Rust bitmap API provides a safe abstraction to underlying bitmap
and bitops operations. For now, only includes method necessary for
dbitmap.h, more can be added later. We perform bounds checks for
hardening, violations are programmer errors that result in panics.

We include set_bit_atomic and clear_bit_atomic operations. One has
to avoid races with non-atomic operations, which is ensure by the
Rust type system: either callers have shared references &bitmap in
which case the mutations are atomic operations. Or there is a
exclusive reference &mut bitmap, in which case there is no concurrent
access.

This series includes an optimization to represent the bitmap inline,
as suggested by Yury.

We ran a simple microbenchmark which shows that overall the Rust API 
can be expected to be about 4.5% slower than C API.

We also introduce a Rust API in id_pool.rs that would replace 
dbitmap.h from the commit referenced above. This data structure is coupled 
with the bitmap API and adds support for growing and shrinking, along
with fine-grained control over when allocation happens. 
The Binder code needs this since it holds a spinlock at the time it
discovers that growing is necessary; this has to be release
for performing a memory allocation with GFP_KERNEL that may cause 
sleep.  We include example doctests that demonstrate this usage.

Thanks everyone for all the helpful comments, this series has improved 
significantly as a result of your work.

Changes v13 --> v14:
- Rebased on commit 8742b2d8935f ("Merge tag 'pull-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs")
- applied clippy suggestions for pointer casts
- in benchmark module, replace use of the Rust Ktime abstraction 
- in benchmark module, move newlines around for pr_cont to work
  with Instant, elapsed.
- added Alice's Reviewed-by tag

Changes v12 --> v13:
- Rebased on commit 75f5f23f8787 ("Merge tag 'block-6.16-20250619' of git://git.kernel.dk/linux")
- Renamed types CBitmap --> Bitmap, Bitmap --> BitmapVec.
- Rewrote unit tests to not use `unwrap()` but `Result` and `?`
- Replaced NonNull::as_mut() with NonNull::as_ptr()
- declared local BITS_PER_LONG usize constants, fixed rustdoc

Changes v11 --> v12:
- Added Reviewed-by tag, changed named of benchmark module
- Fixed config, rustdoc, clippy and bytes computation (Pekka).
- Added test that exercises CONFIG_RUST_BITMAP_HARDENED,
  verified it panics.
- Had to add a break to benchmark module, for the
  CONFIG_RUST_BITMAP_HARDENED case which enforces bounds check.

Changes v10 --> v11:
- Fix Kconfig dependency, Rust benchmark depends on CONFIG_RUST
- Disable clippy warning for len() without is_empty() in id_pool.rs

Changes v9 --> v10:
- change helper to use `unsigned long` for `nr` parameter (Boqun)
- add missing and fix safety comments (Boqun, Pekka)
- move benchmark module output and results to #4 commit msg.
- use pr_cont to avoid repeating find_bit_benchmark_rust log prefix.
- Disable clippy warning for len() without is_empty() in bitmap.rs

Changes v8 --> v9:
- added a new type `CBitmap` that makes any C bitmap accessible with
  the same API, and add Deref so both Bitmap and
  CBitmap can share the same implementation.  Full credit for this 
  goes to Alice who suggested idea and code.
- added config dependency on CONFIG_RUST that was missing from
  CONIG_FIND_BIT_BENCHMARK_RUST.
- implemented Send for Bitmap, it is actually needed by Binder.
- reworded commit msg for clarity.
- removed unsafe for atomic ops.
- renamed `bitmap_hardening_assert` to `bitmap_assert` and make operations
  do nothing and log error when RUST_BITMAP_HARDENED is off.
- update author information in find_bit_benchmark_rust.rs
- Various improvements to id_pool, better names and comments.

Changes v7 --> v8:
- added Acked-by for bindings patches
- add RUST_BITMAP_HARDENED config, making extra bound-checks configurable.
  This is added to security/Kconfig.hardening 
- changed checks of `index` return value to >=
- removed change to FIND_BIT_BENCHMARK

Changes v6 --> v7:
- Added separate unit tests in bitmap.rs and benchmark module,
  following the example in find_bit_benchmark.c
- Added discussion about using vendored bitset to commit message.
- Refined warning about naming convention

Changes v5 --> v6:
- Added SAFETY comment for atomic operations.
- Added missing volatile to bitops set_bit and clear_bit bindings.
- Fixed condition on `nbits` to be <= i32::MAX, update SAFETY comments.
- Readability improvements.
- Updated doc comments wording and indentation.

Changes v4 --> v5: (suggested by Yury and Alice)
- rebased on next-20250318
- split MAINTAINERS changes
- no dependencies on [1] and [2] anymore - Viresh,
  please do add a separate section if you want to maintain cpumask.rs
  separately.
- imports atomic and non-atomic variants, introduces a naming convention
  set_bit and set_bit_atomic on the Rust side.
- changed naming and comments. Keeping `new`.
- change dynamic_id_pool to id_pool
- represent bitmap inline when possible
- add some more tests
- add myself to M: line for the Rust abstractions

Changes v3 --> v4:
- Rebased on Viresh's v3 [2].
- split into multiple patches, separate Rust and bindings. (Yury)
- adds dynamic_id_pool.rs to show the Binder use case. (Yury)
- include example usage that requires release of spinlock (Alice)
- changed bounds checks to `assert!`, shorter (Yury)
- fix param names in binding helpers. (Miguel)
- proper rustdoc formatting, and use examples as kunit tests. (Miguel)
- reduce number of Bitmap methods, and simplify API through
  use Option<usize> to handle the "not found" case.
- make Bitmap pointer accessors private, so Rust Bitmap API
  provides an actual abstraction boundary (Tamir)
- we still return `AllocError` in `Bitmap::new` in case client code
  asks for a size that is too large. Intentionally
  different from other bounds checks because it is not about
  access but allocation, and we expect that client code need
  never handle AllocError and nbits > u32::MAX situations
  differently.

Changes v2 --> v3:
- change `bitmap_copy` to `copy_from_bitmap_and_extend` which
  zeroes out extra bits. This enables dbitmap shrink and grow use
  cases while offering a consistent and understandable Rust API for
  other uses (Alice)

Changes v1 --> v2:
- Rebased on Yury's v2 [1] and Viresh's v3 [2] changes related to
  bitmap.
- Removed import of `bindings::*`, keeping only prefix (Miguel)
- Renamed panic methods to make more explicit (Miguel)
- use markdown in doc comments and added example/kunit test (Miguel)
- Added maintainer section for BITOPS API BINDINGS [RUST] (Yury)
- Added M: entry for bitmap.rs which goes to Alice (Viresh, Alice)
- Changed calls from find_* to _find_*, removed helpers (Yury)
- Use non-atomic __set_bit and __clear_bit from Bitmap Rust API (Yury)

Link [1] https://lore.kernel.org/all/20250224233938.3158-1-yury.norov@gmail.com/
Link [2] https://lore.kernel.org/rust-for-linux/cover.1742296835.git.viresh.kumar@linaro.org/
Link [v13] https://lore.kernel.org/rust-for-linux/20250611194840.877308-1-bqe@google.com/


Burak Emir (5):
  rust: add bindings for bitmap.h
  rust: add bindings for bitops.h
  rust: add bitmap API.
  rust: add find_bit_benchmark_rust module.
  rust: add dynamic ID pool abstraction for bitmap

 MAINTAINERS                     |  15 +
 lib/Kconfig.debug               |  13 +
 lib/Makefile                    |   1 +
 lib/find_bit_benchmark_rust.rs  | 104 ++++++
 rust/bindings/bindings_helper.h |   2 +
 rust/helpers/bitmap.c           |   9 +
 rust/helpers/bitops.c           |  23 ++
 rust/helpers/helpers.c          |   2 +
 rust/kernel/bitmap.rs           | 597 ++++++++++++++++++++++++++++++++
 rust/kernel/id_pool.rs          | 226 ++++++++++++
 rust/kernel/lib.rs              |   2 +
 security/Kconfig.hardening      |  10 +
 12 files changed, 1004 insertions(+)
 create mode 100644 lib/find_bit_benchmark_rust.rs
 create mode 100644 rust/helpers/bitmap.c
 create mode 100644 rust/helpers/bitops.c
 create mode 100644 rust/kernel/bitmap.rs
 create mode 100644 rust/kernel/id_pool.rs


base-commit: 8742b2d8935f476449ef37e263bc4da3295c7b58
-- 
2.51.0.rc0.205.g4a044479a3-goog


