Return-Path: <linux-kernel+bounces-725945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C388B005CF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 16:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C0485648E8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 14:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F6D2741C9;
	Thu, 10 Jul 2025 14:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cPv/YPDM"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A46270568;
	Thu, 10 Jul 2025 14:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752159223; cv=none; b=NJC6xnkoErtE7ZNPqK96lnrViTZExclOmBuFn5G7TQxIRzk2q/gO9IrnTPCn5wtGkipOvVdzQcRxwnfe58LbXyehl2iZEfytS1XUn+sbyHCF7yvF79rmtRB/xiyDaupXlel74SDCHbhBHkEF5OE+91rcbkhCUwrboxGS0q7d1h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752159223; c=relaxed/simple;
	bh=tUFt9BBZ5MnJsTh+9uHXZO9+SANByvRwukNaukxwxE8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dANKO0ZS95klQWJP/4b9UaI/Z5NMmaKdVAesyfJ4+2XXkUp5BkNHj+lQ0NAUAXsd6bN2tfjRahxOxj5iCFfF7P1xpvn9IKfURUuheecWxeWZiOIkC6Jo4Dcf9lP6xhN2VS6zwGrOUyUKvc0M/HcwzmGQbVSKQJe9qx7lk80NC+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cPv/YPDM; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7d5df741f71so94217985a.3;
        Thu, 10 Jul 2025 07:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752159220; x=1752764020; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VFrKN4Gj5VJ/IVOHHd2Q53g9/2HHHqgd/K5T/hrSeck=;
        b=cPv/YPDM68ovYwqkbTguMZjcBp6MdvZnXm4cVFIHqjRaQ5LkJWMJUI3cw67vfWIdju
         l+FI6NLzRipG4rDTNbmh5pTWpog7H6qhwby2vGHpSMAgqqZKCvMYpTPrgIx0mBvwiqmK
         GLNBKjt6ZyQ92ozmBF4kTg9hQODUjxDq4tOhWtPWsrFuo9f0A6ifpXWy9ts83pmEfTOM
         CEbxvcw/tLJSUxXKGV5uWQF12CW/ShuQSzDdwn3mMNoQW9u/tdcMQfAWH750Ho03wCxP
         NBiodYIP3D2EsILPrJ/G4Ims+C3NnlMbPnnp7aMMOBGmPUX3gGefHo8P5/bVS9hPpGy1
         jUMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752159220; x=1752764020;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VFrKN4Gj5VJ/IVOHHd2Q53g9/2HHHqgd/K5T/hrSeck=;
        b=XvjlwfVVL47FKbiAqRpR5tinrgGtpRa4ZtT+IKoaD+3w45UVWCf0BO9kNfYnifKLY1
         8lQTAXmd09VZM+PveKfQ0escibr5ra/LGiD+OTAjle3BrSUGPFXbv/jgcFbtncFG6NeF
         FNGTJhB8AXyh3ILKQBRbThnYrYhNW/cibublTRIgTRewj++pKX9zQ8W999cYm4mVnBXm
         6vO3Qtz30SU1HmFFmyboNVme5BcDKMNMj/ufbUGXFHtm/ld9LROBsvv45N46SIuL+JpJ
         Fm3JNGR0FKTdpEwobiyUezqoOt/J+FcUCJ5qY0jArlbDWZKYNk8exXKCXw/2jBgZvIPD
         YVXA==
X-Forwarded-Encrypted: i=1; AJvYcCVjPX3/iEWquB0IJYca5vqSL9RoamZPkRB0bm28U2l2GuKBUMdnrCHCymW3yEMxyUBASFMdNM1nBsFF94I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqJkpKJeBfr6rhg9wDtLBz+yaDJNpnVcotr3KHCuPfNlbid7OR
	p88V2iwoqjFL023DN8JdJQHR/n35hrPW6BoJB4ycwFvT1kG9oo2pYxgl
X-Gm-Gg: ASbGncsectJ3jGbeCWd+5IBR5tQ1xurVyaXADAdYcX7wElqHNs7uX/PN+Mu2nsTGfH4
	syUAZDD3JUxMma3qZJKqQvOi5vtAnbLaTXgUgY3hp9HI8yt6gV/fU9GmNYwTQtJ/69QVGaECMmK
	ku8DEv3+S/6hegOXo53wFGgbAW1tqGUL331+N+kO1ysqC7iqZIs4sJ5FCANg+bYhFsNTVCf1wfu
	MhXCKTbK8yi67zX0WzJGtUp5IL3ZjhWYJBW70Bw/dDQNZT1yM54U2vZMhs7yI1ll6qgC3NhA2Y0
	fX4mwyZa+EMk/uMO23MQuCRgHTasYC3ojcC2E1u9Hlew+O50/XaLcj+xolVCx37e/fxmy22VWAu
	6JoeRFWGDbX3LtEvofs0ncGITGPzoJpoj5CvrGM5ehbdb+9KMRg4kFyVMGOi1NXA=
X-Google-Smtp-Source: AGHT+IGseKnLwvXTPKGWFD5LOMXTcg2BX989CTXMByRu/v/AXV6dhaRdn2b1AXeWS2oj+AdPH0hHrw==
X-Received: by 2002:a05:620a:4687:b0:7d3:f63c:7ee0 with SMTP id af79cd13be357-7dc944aade6mr510956585a.27.1752159220142;
        Thu, 10 Jul 2025 07:53:40 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([148.76.185.197])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-704979f49b0sm9138996d6.54.2025.07.10.07.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 07:53:39 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH v14 0/3] rust: replace kernel::str::CStr w/ core::ffi::CStr
Date: Thu, 10 Jul 2025 10:53:28 -0400
Message-Id: <20250710-cstr-core-v14-0-ca7e0ca82c82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOnTb2gC/5XSS27bMBAG4KsYWpfBcPgcr3KPogs+Y6GV6VKK0
 CDw3UPZSS3Z6KLLEfUNf5Lz3o2p9mns9rv3rqa5H/tybAWX33ZdOLjjS2J9bB86BFSAwFkYp8p
 CqYlF6clr4gghd+3/U025/3Np9v1Hq3MtA5sONbmvDhIsJ66EVvoJrQXDkM0ullrm8efb86mWq
 RwH1/96CmVYWh76cSr17RJv1kvjryC4CjJrBsxKTSHqiJTj88vfJkuQ2fxTmiaj47YtIUhh76V
 dS7GWtsngRUadjNVW30u6ScHNWlKTikcdgkLMGu8lhxtVKNeUQ7NacnQkI0WjHixfWQEby5fEk
 QIEHzzB4754s5rTxuJywxAoGC8VATxYcbNmMyVtqdn2KiaK5Mm4zU2dr3NT0+/XNnvTdXg678b
 U9DD0035nNCWB0mvtIRJGkFlwFSFI5SAbNMIEI0l265Hd7z6jyGuKS5620cm1gjwl7YyPyqT9z
 Bc4pHF0W0krmd2xvE6Mt9NcHkCATaYNRA6rw/xvmxwNCS+Ssm7zFufzB1SfqGCXAwAA
X-Change-ID: 20250201-cstr-core-d4b9b69120cf
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1752159218; l=8791;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=tUFt9BBZ5MnJsTh+9uHXZO9+SANByvRwukNaukxwxE8=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QPIk3lt1CEK4++/KwriO5LLWahbv3Rfs9EBdbLuOU6r21bPjsfaOKp/qYCZuF5j2majc4J64oTe
 GbnQRgth21ws=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

This picks up from Michal Rostecki's work[0]. Per Michal's guidance I
have omitted Co-authored tags, as the end result is quite different.

This series is intended to be taken through rust-next. The final patch
in the series requires some other subsystems' `Acked-by`s:
- rust/kernel/device.rs: driver-core. Already acked by gregkh.
- rust/kernel/firmware.rs: driver-core. Danilo, could you take a look?
- rust/kernel/seq_file.rs: vfs, I think? missing MAINTAINERS entry.
  Christian Brauner <brauner@kernel.org>, perhaps?
- rust/kernel/sync/*: no clear owner, probably doesn't need any.

This series depends on steps 2a[1] and 2b[2] which both depend on step
1[3].

Link: https://lore.kernel.org/rust-for-linux/20240819153656.28807-2-vadorovsky@protonmail.com/t/#u [0]
Link: https://lore.kernel.org/all/20250709-core-cstr-fanout-1-v1-0-64308e7203fc@gmail.com/ [1]
Link: https://lore.kernel.org/all/20250709-core-cstr-fanout-1-v1-0-fd793b3e58a2@gmail.com/ [2]
Link: https://lore.kernel.org/all/20250704-core-cstr-prepare-v1-0-a91524037783@gmail.com/ [3]
Closes: https://github.com/Rust-for-Linux/linux/issues/1075

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
Changes in v14:
- Break the change into multiple series.
- Move `CStr` reexport to `kernel::ffi`. (Alice Ryhl)
- `pub use core::fmt::{....}` in `kernel/fmt.rs`. (Benno Lossin)
- Avoid unnecessary binding to `first_lit` in `fmt!`. (Benno Lossin)
- Add comment to `identifier`-extracting loop. (Benno Lossin)
- Change `quote_spanned!` formatting. (Benno Lossin)
- Link to v13: https://lore.kernel.org/r/20250701-cstr-core-v13-0-29f7d3eb97a6@gmail.com

Changes in v13:
- Rebase on v6.16-rc4.
- Link to v12: https://lore.kernel.org/r/20250619-cstr-core-v12-0-80c9c7b45900@gmail.com

Changes in v12:
- Introduce `kernel::fmt::Display` to allow implementations on foreign
  types.
- Tidy up doc comment on `str_to_cstr`. (Alice Ryhl).
- Link to v11: https://lore.kernel.org/r/20250530-cstr-core-v11-0-cd9c0cbcb902@gmail.com

Changes in v11:
- Use `quote_spanned!` to avoid `use<'a, T>` and generally reduce manual
  token construction.
- Add a commit to simplify `quote_spanned!`.
- Drop first commit in favor of
  https://lore.kernel.org/rust-for-linux/20240906164448.2268368-1-paddymills@proton.me/.
  (Miguel Ojeda)
- Correctly handle expressions such as `pr_info!("{a}", a = a = a)`.
  (Benno Lossin)
- Avoid dealing with `}}` escapes, which is not needed. (Benno Lossin)
- Revert some unnecessary changes. (Benno Lossin)
- Rename `c_str_avoid_literals!` to `str_to_cstr!`. (Benno Lossin &
  Alice Ryhl).
- Link to v10: https://lore.kernel.org/r/20250524-cstr-core-v10-0-6412a94d9d75@gmail.com

Changes in v10:
- Rebase on cbeaa41dfe26b72639141e87183cb23e00d4b0dd.
- Implement Alice's suggestion to use a proc macro to work around orphan
  rules otherwise preventing `core::ffi::CStr` to be directly printed
  with `{}`.
- Link to v9: https://lore.kernel.org/r/20250317-cstr-core-v9-0-51d6cc522f62@gmail.com

Changes in v9:
- Rebase on rust-next.
- Restore `impl Display for BStr` which exists upstream[1].
- Link: https://doc.rust-lang.org/nightly/std/bstr/struct.ByteStr.html#impl-Display-for-ByteStr [1]
- Link to v8: https://lore.kernel.org/r/20250203-cstr-core-v8-0-cb3f26e78686@gmail.com

Changes in v8:
- Move `{from,as}_char_ptr` back to `CStrExt`. This reduces the diff
  some.
- Restore `from_bytes_with_nul_unchecked_mut`, `to_cstring`.
- Link to v7: https://lore.kernel.org/r/20250202-cstr-core-v7-0-da1802520438@gmail.com

Changes in v7:
- Rebased on mainline.
- Restore functionality added in commit a321f3ad0a5d ("rust: str: add
  {make,to}_{upper,lower}case() to CString").
- Used `diff.algorithm patience` to improve diff readability.
- Link to v6: https://lore.kernel.org/r/20250202-cstr-core-v6-0-8469cd6d29fd@gmail.com

Changes in v6:
- Split the work into several commits for ease of review.
- Restore `{from,as}_char_ptr` to allow building on ARM (see commit
  message).
- Add `CStrExt` to `kernel::prelude`. (Alice Ryhl)
- Remove `CStrExt::from_bytes_with_nul_unchecked_mut` and restore
  `DerefMut for CString`. (Alice Ryhl)
- Rename and hide `kernel::c_str!` to encourage use of C-String
  literals.
- Drop implementation and invocation changes in kunit.rs. (Trevor Gross)
- Drop docs on `Display` impl. (Trevor Gross)
- Rewrite docs in the style of the standard library.
- Restore the `test_cstr_debug` unit tests to demonstrate that the
  implementation has changed.

Changes in v5:
- Keep the `test_cstr_display*` unit tests.

Changes in v4:
- Provide the `CStrExt` trait with `display()` method, which returns a
   `CStrDisplay` wrapper with `Display` implementation. This addresses
   the lack of `Display` implementation for `core::ffi::CStr`.
- Provide `from_bytes_with_nul_unchecked_mut()` method in `CStrExt`,
   which might be useful and is going to prevent manual, unsafe casts.
- Fix a typo (s/preffered/prefered/).

Changes in v3:
- Fix the commit message.
- Remove redundant braces in `use`, when only one item is imported.

Changes in v2:
- Do not remove `c_str` macro. While it's preferred to use C-string
   literals, there are two cases where `c_str` is helpful:
   - When working with macros, which already return a Rust string literal
     (e.g. `stringify!`).
   - When building macros, where we want to take a Rust string literal as an
     argument (for caller's convenience), but still use it as a C-string
     internally.
- Use Rust literals as arguments in macros (`new_mutex`, `new_condvar`,
   `new_mutex`). Use the `c_str` macro to convert these literals to C-string
   literals.
- Use `c_str` in kunit.rs for converting the output of `stringify!` to a
   `CStr`.
- Remove `DerefMut` implementation for `CString`.

---
Tamir Duberstein (3):
      rust: macros: reduce collections in `quote!` macro
      rust: support formatting of foreign types
      rust: replace `CStr` with `core::ffi::CStr`

 rust/ffi.rs                     |   2 +
 rust/kernel/device.rs           |   1 +
 rust/kernel/error.rs            |   2 +
 rust/kernel/firmware.rs         |   9 +-
 rust/kernel/fmt.rs              |  87 ++++++++-
 rust/kernel/prelude.rs          |   7 +-
 rust/kernel/seq_file.rs         |   2 +-
 rust/kernel/str.rs              | 395 +++++++++-------------------------------
 rust/kernel/sync/condvar.rs     |   2 +-
 rust/kernel/sync/lock.rs        |   2 +-
 rust/kernel/sync/lock/global.rs |   2 +-
 rust/macros/fmt.rs              |  94 ++++++++++
 rust/macros/lib.rs              |  19 ++
 rust/macros/quote.rs            | 111 +++++------
 14 files changed, 362 insertions(+), 373 deletions(-)
---
base-commit: 769e324b66b0d92d04f315d0c45a0f72737c7494
change-id: 20250201-cstr-core-d4b9b69120cf
prerequisite-change-id: 20250704-core-cstr-prepare-9b9e6a7bd57e:v1
prerequisite-patch-id: 83b1239d1805f206711a5a936bbb61c83227d573
prerequisite-patch-id: a0355dd0efcc945b0565dc4e5a0f42b5a3d29c7e
prerequisite-patch-id: 8585bf441cfab705181f5606c63483c2e88d25aa
prerequisite-patch-id: 04ec344c0bc23f90dbeac10afe26df1a86ce53ec
prerequisite-patch-id: a2fc6cd05fce6d6da8d401e9f8a905bb5c0b2f27
prerequisite-patch-id: f14c099c87562069f25fb7aea6d9aae4086c49a8
prerequisite-message-id: 20250709-core-cstr-fanout-1-v1-0-64308e7203fc@gmail.com
prerequisite-patch-id: fa79c5d8fd2762b5e488ba017e13a5774d933f81
prerequisite-patch-id: c338aa49e1319e9e802de2ad8bb0fa688bce9d9c
prerequisite-patch-id: 589a352ba7f7c9aefefd84dfd3b6b20e290b0d14
prerequisite-patch-id: 29fc25261295349f6747d1bb409cf18130e9aa69
prerequisite-patch-id: 3d89601bba1fb01d190b0ba415b28ad9cbf1e209
prerequisite-patch-id: 10923aebf24011b727f60496c0f9e0ad57e0a967
prerequisite-patch-id: 56583fd829951fb4fac843c6b1874c643b726de0
prerequisite-patch-id: 9a7e8ba460358985147efd347658be31fbc78ba2
prerequisite-patch-id: 5821a23334e317cd0351b8e4404b9e3b36b72d67
prerequisite-message-id: 20250709-core-cstr-fanout-1-v1-0-fd793b3e58a2@gmail.com
prerequisite-patch-id: 0ccc3545ff9bf22a67b79a944705cef2fb9c2bbf
prerequisite-patch-id: b1866166714606d5c11a4d7506abe4c2f86dac8d
prerequisite-patch-id: 163b8ff1edaf8e48976fd5de3f64e68fc38c7277
prerequisite-patch-id: 8fee5e2daf0749362331dad4fc63d907a01b14e9
prerequisite-patch-id: 366ef1f93fb40b1d039768f2041ff79995e7e228
prerequisite-patch-id: 1d350291f9292f910081856d8f7d5e4d9545cfd1
prerequisite-patch-id: 9a6a60bd2b209126de64c16a77a3a1d229dd898c
prerequisite-patch-id: 08ae5855768ec3b4c68272b86d2a0e0667c9aa47
prerequisite-patch-id: f15b54927660a03b52ffb34fb7943ac3228b7803
prerequisite-patch-id: f0dbf0a55a27fe8e199e242d1f79ea800d1ddb66

Best regards,
--  
Tamir Duberstein <tamird@gmail.com>


