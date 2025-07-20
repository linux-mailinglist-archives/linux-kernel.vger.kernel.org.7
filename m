Return-Path: <linux-kernel+bounces-738343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3395CB0B742
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 19:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAEDA3BE989
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 17:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674E822172E;
	Sun, 20 Jul 2025 17:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FANnmzhR"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F86B1C6FF4;
	Sun, 20 Jul 2025 17:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753032056; cv=none; b=BqDG1QaITjvQalI4Blq4pWBdjNM9RFDN36gJ4dmUkhZeUeJ3jJ6bVph3W1V0+Mu78uJ0pBZXc+ztYpgWCci3AhBgw6LdtWE0quRw+EFdJwYeHDxwT3SPVGI5uMCt7FyEB+KOWqW7keJRQzq8LuNgFXHAnlYdwLpl47tI5ENZ840=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753032056; c=relaxed/simple;
	bh=MTLxuC8TYZFrEvGLmTADCGhtiDFRB28ggwmncDHf+Bk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Ph7ydFLlijYaaRK+RrwnwDoSH6M1ljLkTQC/EYXh5A7cOvyCUcJAjxe9d3GvnT5UoNyPjWtlN99Oxi2ZTZUpSB2sqDYKJWga3YYX3V9Z1ktW91atrRtvZmmSdgll5YwE9aGjv9jlUBdoRVrMQpqemMjEe+7IkJLXzpDxRO36Krc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FANnmzhR; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7d7f2600c17so551907585a.0;
        Sun, 20 Jul 2025 10:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753032051; x=1753636851; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C4TrqO/b+uLbGny1Wg/yi1GT8S1D9uxPuhjoA6bF+kA=;
        b=FANnmzhRmBACsftjzgn8R45md4e0T8N2gGo/8ddHqIJ/vlnSHw32R51/MNf/bzKcyi
         ovSmbQoZsIZU0lWllpObD2qjf4kZAxDqM8vhtg6hu8Itn1WaYGRf2jbRIpmUXIjIS1fd
         rn3hiOPS8q4Ltq0UnNV1XkRVeAqZxGHI4T1hm2SRchI3pMDRgmZsI0i+DwXm+MLPzaa6
         tOQOryNJFN1DmqaIryiqKo9NvzT0o8UMUiTpmFqbxUW74Qtb0MLMWy9pPvhRtuG1KrRf
         tqxM9aBuxW3GplIa9TKAnagnKVyuWvCI5mr6li0KZyfntEHb17Dhx/qTJksTdxS4GaeA
         4yrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753032051; x=1753636851;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C4TrqO/b+uLbGny1Wg/yi1GT8S1D9uxPuhjoA6bF+kA=;
        b=pNRPkjDzkgRpVOBuB8fD/kgEGr/NN/VWvhHYyM+q6C5BVbc4WjrsYmis5Dvf9nWdan
         zDu/S9UMyx3qvhAONZeIiql1tl23U9wTMr9wBY/FIS8CiAP2qlxb/1dZ6imC2KNawKH1
         Zoe6g/5vYS1C4tG7GSvPOdWvaGuy6lOrMHDSaOmE+crNhnsZlMQWCcO/b8nN90opno9Q
         m9zkdnl+1NG+R9oHq9EAP+My367BIqyQc1DgqHEqA824bH7ntRd7t77mxIgtcseQ+HVp
         8HujjU+AHEQLXXgVw3DOamJb8qF2tPw8AEvmNHai4LyL/Iz6fozx4RFMxygck6JrDNsN
         xC6g==
X-Forwarded-Encrypted: i=1; AJvYcCUXnXOMAWHe3DNzs5+mVt9l8EcYCk4c3IHz7fvIfoXzv1F54rTPxAP4oTZEgNMLQZBXu/5gkMJ1zlIz2QI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/sxxf6WbLosN2gymDyLuyGB41gC5DjKbbeb6CmSdeex5lIfU+
	VhLGhpL90G9OnfNOnFlCZUnps2WDTRmLemIV/OQEf4M4gknfiHFFyaPj
X-Gm-Gg: ASbGncspmKTh9VhU6TFSRLoB1G0X43uZAB1pnqHPdJq59VlMhEvwBiSw5uswikuobP9
	6q/UF/6llwSkusQk3y7gGlipPluXmdJcDc8xlNtwHvYo6ZAMZkKcD7L1lK+A6DuGiV/c8gujD4j
	jXdWjabdUW5IFh2HLBuY4MzRXZPhJAigYQgvCA6LeBkziL/usAf/wRHC7rSLJmrA/htGlZc3UNX
	gYiMX+bDYIcSb6SdrrIfBxL1pLw/rUYWDYYJQx5IRomJ3DYV94HqSvzspfgl9r3R6skTYpTSRg1
	Pt+OlFvIX2Z+XYXv2J3odX8eJ0me9mCnou6HzhaTuTFNkDeABtbUc2s90TzrTqMLK4ziHYoTTCV
	ha6nRWGbV/0FNckwmwdj1aqJ/wneqxXPCjGIaxLb1P1o=
X-Google-Smtp-Source: AGHT+IEgNrc7ZlFOHIzaWbCET9ryv6dIC2rhy5M9nzuMa7kj1TUQ4jmwk6T+lYcKHzKIyswwUs1X1A==
X-Received: by 2002:a05:620a:1789:b0:7e3:28f3:899 with SMTP id af79cd13be357-7e356ae1809mr1080254485a.39.1753032050870;
        Sun, 20 Jul 2025 10:20:50 -0700 (PDT)
Received: from 156.1.168.192.in-addr.arpa ([2600:4041:5c29:e400:78d6:5625:d350:50d1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356c63e89sm320516285a.74.2025.07.20.10.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 10:20:50 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sun, 20 Jul 2025 13:20:40 -0400
Subject: [PATCH v3] rust: remove spurious compiler_builtins dependents
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250720-rust-remove-compiler-builtins-deps-v3-1-0df3a493973f@gmail.com>
X-B4-Tracking: v=1; b=H4sIAGclfWgC/5XNQQ6CMBCF4auQrh3TlqLgynsYF9hOYRKgpIVGQ
 7i7hY0udflPJt9bWEBPGNglW5jHSIHckCI/ZEy39dAgkEnNJJcFV7wEP4cJPPYuImjXj9Shh8d
 M3URDAINjAGH5SXCpjNXIEjR6tPTcR2731C2FyfnXvhnFdv2LjwIEKGtqZUV5FhW/Nn1N3TG9s
 42P8kMWUv1Eyp3U0lpVVnklvsl1Xd8vas2aJwEAAA==
X-Change-ID: 20250408-rust-remove-compiler-builtins-deps-1f061024dfce
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1753032049; l=4363;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=MTLxuC8TYZFrEvGLmTADCGhtiDFRB28ggwmncDHf+Bk=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QP/JxUnvZefQoukG+81afgmSg4X9OGAYmPfMC5UpO9IJrbPy3YxlVwhWrtvgYCyPLtSgqw3Xdxo
 qbXluZv6IKQs=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

The dependency on `compiler_builtins.o` was first added in commit
2f7ab1267dc9 ("Kbuild: add Rust support") to `alloc` which matches the
standard library[0] but was copied to other targets in:
- commit ecaa6ddff2fd ("rust: add `build_error` crate")
- commit d072acda4862 ("rust: use custom FFI integer types")
- commit 4e1746656839 ("rust: uapi: Add UAPI crate")
- commit d7659acca7a3 ("rust: add pin-init crate build infrastructure")

The alloc crate was removed in commit 392e34b6bc22 ("kbuild: rust:
remove the `alloc` crate and `GlobalAlloc`"). As far as I can tell none
of the other dependencies are required; it is only required that
compiler_builtins be linked into the rust-enabled kernel. In the
standard library, compiler_builtins is a dependency of std[1].

Remove these dependency edges. Add a dependency edge from
`compiler_builtins` to `core` to `scripts/generate_rust_analyzer.py` to
match `rust/Makefile`. This has been incorrect since commit 8c4555ccc55c
("scripts: add `generate_rust_analyzer.py`")

Link: https://github.com/rust-lang/rust/blob/f820b75feef00654924c9351a2faca8d34818339/library/alloc/Cargo.toml#L19 [0]
Link: https://github.com/rust-lang/rust/blob/f820b75feef00654924c9351a2faca8d34818339/library/std/Cargo.toml#L21 [1]
Link: https://rust-for-linux.zulipchat.com/#narrow/channel/288089-General/topic/rust-analyzer.20improvements/near/510200959
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
Changes in v3:
- Fix typo in commit message (fas -> far).
- Link to v2: https://lore.kernel.org/r/20250524-rust-remove-compiler-builtins-deps-v2-1-4fc2ff489391@gmail.com

Changes in v2:
- Rebase on rust-fixes to include "scripts: generate_rust_analyzer: Add
  ffi crate".
- Link to v1: https://lore.kernel.org/r/20250408-rust-remove-compiler-builtins-deps-v1-1-4fda4f187190@gmail.com
---
 rust/Makefile                     | 6 +++---
 scripts/generate_rust_analyzer.py | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/rust/Makefile b/rust/Makefile
index 27dec7904c3a..5a6a381bc23d 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -505,16 +505,16 @@ $(obj)/compiler_builtins.o: $(src)/compiler_builtins.rs $(obj)/core.o FORCE
 $(obj)/pin_init.o: private skip_gendwarfksyms = 1
 $(obj)/pin_init.o: private rustc_target_flags = --extern pin_init_internal \
     --extern macros --cfg kernel
-$(obj)/pin_init.o: $(src)/pin-init/src/lib.rs $(obj)/compiler_builtins.o \
+$(obj)/pin_init.o: $(src)/pin-init/src/lib.rs \
     $(obj)/$(libpin_init_internal_name) $(obj)/$(libmacros_name) FORCE
 	+$(call if_changed_rule,rustc_library)
 
 $(obj)/build_error.o: private skip_gendwarfksyms = 1
-$(obj)/build_error.o: $(src)/build_error.rs $(obj)/compiler_builtins.o FORCE
+$(obj)/build_error.o: $(src)/build_error.rs FORCE
 	+$(call if_changed_rule,rustc_library)
 
 $(obj)/ffi.o: private skip_gendwarfksyms = 1
-$(obj)/ffi.o: $(src)/ffi.rs $(obj)/compiler_builtins.o FORCE
+$(obj)/ffi.o: $(src)/ffi.rs FORCE
 	+$(call if_changed_rule,rustc_library)
 
 $(obj)/bindings.o: private rustc_target_flags = --extern ffi
diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
index 7c3ea2b55041..cab9a80bed49 100755
--- a/scripts/generate_rust_analyzer.py
+++ b/scripts/generate_rust_analyzer.py
@@ -83,7 +83,7 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs, core_edit
     append_crate(
         "compiler_builtins",
         srctree / "rust" / "compiler_builtins.rs",
-        [],
+        ["core"],
     )
 
     append_crate(
@@ -96,7 +96,7 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs, core_edit
     append_crate(
         "build_error",
         srctree / "rust" / "build_error.rs",
-        ["core", "compiler_builtins"],
+        ["core"],
     )
 
     append_crate(
@@ -117,7 +117,7 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs, core_edit
     append_crate(
         "ffi",
         srctree / "rust" / "ffi.rs",
-        ["core", "compiler_builtins"],
+        ["core"],
     )
 
     def append_crate_with_generated(

---
base-commit: cc84ef3b88f407e8bd5a5f7b6906d1e69851c856
change-id: 20250408-rust-remove-compiler-builtins-deps-1f061024dfce

Best regards,
--  
Tamir Duberstein <tamird@gmail.com>


