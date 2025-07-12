Return-Path: <linux-kernel+bounces-728812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2264FB02D37
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 23:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6351B4A2954
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 21:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3418B226D00;
	Sat, 12 Jul 2025 21:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZ4EypIi"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A033C3C;
	Sat, 12 Jul 2025 21:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752355926; cv=none; b=XY+2krR3lTdhn8uopvmt/xQeRB6LVadAbpWEDEkf6GDpUEJUwYk568CBtahQ6dJeP8Bbp6A3xoBxqFaqQ+QbFTo4uEvDYkN4Lk8U+LwtUOg4DqGIHAgV0OgGzHLEgz8xkIiSxyJEpurq0E6xNsNjfTGWUF3ZjKo4rfR4FqSHJXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752355926; c=relaxed/simple;
	bh=UqO+pzPFFY6UAe2VCZ7UIpEkrUPHeHKfA1W7oxRKNO4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BxdpC+B4nIcmmqZBD2X845bucxGBJc+4VSWMpzpMcmPSmdlR33ZKtnIuWlGvopXFYrgSM2Cbf+LLRVP7yiGvNNIj4lzyfx9vH7A/69GDo8BBaxNYjtu3jqmRssctKztwr269jiwltpAmygu2dna0XSqMQXQTW5rryJh/X0uFATg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dZ4EypIi; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-235ea292956so30262305ad.1;
        Sat, 12 Jul 2025 14:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752355924; x=1752960724; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4zSqHWIR90f+hCY/JOc+od+eym2RfLtRvRGq2Lf5IYE=;
        b=dZ4EypIipAg6Y0In4MrCAkevhnGD/4QMQNIXC3sJUB7RPLjPC5Qca6iBWiMjRFmkkz
         6yPSj9F4inH0YHDV7SwfvXRYV7EWBKWelkxLxJV49w5V6jnIy9cMnTD4J5ykEnnpQS1Z
         iuUEv2bXJvR7PF70IT6v8TFmLeGsjfB2/IZUEEAIDf7X9dPLuwUyRz+umt3vl0SCahSp
         ey/5lL1rCkWgqcp/WN5A4Nqc90fazY1TXrOePoGHa0c4EyciJ0nVntJZHZ6n0sPTouYA
         kOh9geTD8tUCsSruElmPfOe86RtegxNsOWI4+bqZEEoKXpy8nqkiv48ViE+LxgRBzy9j
         0jtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752355924; x=1752960724;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4zSqHWIR90f+hCY/JOc+od+eym2RfLtRvRGq2Lf5IYE=;
        b=LxIJKCKlp7SbIz/t0lRTHc7cUjYStkaEDOxCIByFdQf9QE12MVJ2xSKca9n65LMpPX
         m3xTM/rJ1xD3xYyFCof25b2fL1GzAuuQ2TZQXe3xbl55S6PMsHdxN7NSgDpigel/9Qpo
         hl+Rxeg48C/yOzRF8nLsRc6oIYlIZ1knY7+t9/hlmNkXFsm8bLUeFcTQBve75a3ntMDg
         eaMN3wG7+kQo0DDybCbCSYur5JDRiwX8AJ5f7Kx1m8R89SrtBN6rpZQAaE8OJQW3Xmkq
         gMYZM5oHogKpwfQMffp0NrzivYt4QNA2AMENsfAzhpP1RhUBpwVKQtsAivbd80JUHJkb
         M7qA==
X-Forwarded-Encrypted: i=1; AJvYcCWBvRwJcP1XB6MJKRB/asQGRn0/fmiXwUi8V1g7Xi1pwqxyyJz/A5H27bSZaF3etT+5wP6XqRBVnVCqoO+VaQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJd4w/gv4S5LQjtyhO09JBgvIi1kucPfupnLtXZAhs2qrMCglt
	D2aBE3nA/nCPv+g7hjL1AZylNI+lXIAaqW42WEVRaPNcak02TbzeQa/q
X-Gm-Gg: ASbGncvnNgHnfZoaF3Vpg1ALblzuLlE2FTiJamT1LKzgsPNLLf43RqJSDFWoeLs4O90
	0LPHNSA4QbyLxLyrEPGd9BSLnz253sjy2esKJ/cX/cVnJf4z57Dn8We2SJrWmy3WgZdrY2pWxsb
	wt6Dq2gVNnFPDkjUNp4/r2M/uhNx4Acrz9693NKTqcaCExMlaui8CSz/ARLIBn3qFLqaj1KUgvL
	uTTMdR1rQnizD6CqZdr1BzF5K09IN2rJs9SpduO4auwFKdOlNsRfa9IM+gGkvG38P+S3AthTk5J
	/qrFiSzQkuK69u0+W1DaBfe1CAz30NkNdOMNoPTYYrufli+0yMvaf8Q8c44zffeNmA4gIVglkM9
	EGCwBpNp8OG2kapaWIq64JEKb3OB8aIX6+DzMyqL2TkEIFA==
X-Google-Smtp-Source: AGHT+IE2VfCL8MnICrP0hyoet06fIB+lCLzjQEM0CGSgmw9lV2gCDP9njUYYoyx4Kl/Hd19Pi/P2Og==
X-Received: by 2002:a17:902:dace:b0:23c:7b65:9b08 with SMTP id d9443c01a7336-23dee1aba47mr150733885ad.1.1752355924149;
        Sat, 12 Jul 2025 14:32:04 -0700 (PDT)
Received: from mitchelllevy.localdomain ([174.127.224.194])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3eb65aa2sm8003935a91.40.2025.07.12.14.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jul 2025 14:32:03 -0700 (PDT)
From: Mitchell Levy <levymitchell0@gmail.com>
Subject: [PATCH v2 0/5] rust: Add Per-CPU Variable API
Date: Sat, 12 Jul 2025 14:31:11 -0700
Message-Id: <20250712-rust-percpu-v2-0-826f2567521b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB/UcmgC/2WQQQrCMBBFryJZG5mZNmpceQ9xkSZjDaitSVsU6
 d1Nq0LV5R947/PnISIHz1FsZg8RuPPRV5cUaD4T9mguJUvvUhYElMMaMxna2Miag61byYYOKi+
 UM1kmElEHPvjbaNvtUz762FThPso7HK6jBwn1l6dDCZJAI654TVTgtjwbf1rY6jxoE6NgSfk/o
 63SBawcGW0nzNDd0adPQY4/LCVWsQEHjjEzasr2ryGBr236RvNe0/dPZdp8jSsBAAA=
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Andrew Morton <akpm@linux-foundation.org>, 
 Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
 Christoph Lameter <cl@linux.com>, Danilo Krummrich <dakr@kernel.org>, 
 Benno Lossin <lossin@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-mm@kvack.org, Mitchell Levy <levymitchell0@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752355923; l=2596;
 i=levymitchell0@gmail.com; s=20240719; h=from:subject:message-id;
 bh=UqO+pzPFFY6UAe2VCZ7UIpEkrUPHeHKfA1W7oxRKNO4=;
 b=86cR7QRLC6OKVbGl/rLVqe4SMtAKStabupNYsLnqjggy4KhIL/gLYg/0KTObavinHrJEkwqcs
 sDFMhI1EEXGCKqxlKrDNshLodfnDnxmlx8/v3BWDw6gRvK377UOMa8A
X-Developer-Key: i=levymitchell0@gmail.com; a=ed25519;
 pk=n6kBmUnb+UNmjVkTnDwrLwTJAEKUfs2e8E+MFPZI93E=

This series adds an API for declaring an using per-CPU variables from
Rust, and it also adds support for Rust access to C per-CPU variables
(subject to some soundness requirements). It also adds a small test
module, lib/percpu_test_rust.rs, in the vein of lib/percpu_test.c.

---
Signed-off-by: Mitchell Levy <levymitchell0@gmail.com>

---
Changes in v2:
- Fix kernel test robot issues
- Fix documentation error
- Require `T: Zeroable` in the dynamic case
- Link to v1: https://lore.kernel.org/r/20250624-rust-percpu-v1-0-9c59b07d2a9c@gmail.com

Changes in v1:
- Use wrapping_add in `PerCpuPtr::get_ref` since overflow is expected.
- Separate the dynamic and static cases, with shared logic in a
  `PerCpuPtr` type.
- Implement pin-hole optimizations for numeric types
- Don't assume `GFP_KERNEL` when allocating the `Arc` in the dynamic
  case.
- Link to RFC v2: https://lore.kernel.org/r/20250414-rust-percpu-v2-0-5ea0d0de13a5@gmail.com

Changes in RFC v2:
- Renamed PerCpuVariable to StaticPerCpuSymbol to be more descriptive
- Support dynamically allocated per-CPU variables via the
  PerCpuAllocation type. Rework statically allocated variables to use
  this new type.
- Make use of a token/closure-based API via the PerCpu and PerCpuToken
  types, rather than an API based on PerCpuRef that automatically
  Deref(Mut)'s into a &(mut) T.
- Rebased
- Link to RFC: https://lore.kernel.org/r/20241219-rust-percpu-v1-0-209117e822b1@gmail.com

---
Mitchell Levy (5):
      rust: percpu: introduce a rust API for per-CPU variables
      rust: rust-analyzer: add lib to dirs searched for crates
      rust: percpu: add a rust per-CPU variable test
      rust: percpu: Add pin-hole optimizations for numerics
      rust: percpu: cache per-CPU pointers in the dynamic case

 lib/Kconfig.debug                 |   9 ++
 lib/Makefile                      |   1 +
 lib/percpu_test_rust.rs           | 156 +++++++++++++++++++
 rust/helpers/helpers.c            |   2 +
 rust/helpers/percpu.c             |  20 +++
 rust/helpers/preempt.c            |  14 ++
 rust/kernel/lib.rs                |   3 +
 rust/kernel/percpu.rs             | 315 ++++++++++++++++++++++++++++++++++++++
 rust/kernel/percpu/cpu_guard.rs   |  35 +++++
 rust/kernel/percpu/numeric.rs     | 117 ++++++++++++++
 scripts/generate_rust_analyzer.py |   2 +-
 11 files changed, 673 insertions(+), 1 deletion(-)
---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20240813-rust-percpu-ea2f54b5da33

Best regards,
-- 
Mitchell Levy <levymitchell0@gmail.com>


