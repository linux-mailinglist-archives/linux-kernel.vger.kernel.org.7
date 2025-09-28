Return-Path: <linux-kernel+bounces-835514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94467BA7599
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 19:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC5E518952CE
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 17:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33C223BD13;
	Sun, 28 Sep 2025 17:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XobWPXQZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD61F221DAE;
	Sun, 28 Sep 2025 17:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759080958; cv=none; b=dBJeE8w/W0mjWD5EvNhxYQ2PHbb1ucQNZLIBlGtiOjhP8boExLcZD7PxPoVa7cBDBlMpzX/AqxtTDnHdfIJklmcgUzZ4kbhgJa8fJIDbEPz2c1QH9qT8l6N22NC6MzA2xW57h0Ge8VUMPDpwthcf3mlDhUw5dAx6SGUxw5gCay8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759080958; c=relaxed/simple;
	bh=ZDDoSQHfUfGlV5GTCCz5MrXChE3PkwoLjvorvdmzaHY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=akk8x1i6Dmvmq4k/X/6Oi8RumlHtLLjEqcTsgu51RwkUXEx4FTspdmcJgK5j4qmMcs65daRSgugfGzABFWV5gHC+cp/IPAqz7I67LvMPGtA3P5gD9DktBtanh3Up6FkRriW5TM+jgFCW6hcZHbrG0pY6DQp/tRVebPKxQwpD4uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XobWPXQZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E763C4CEF0;
	Sun, 28 Sep 2025 17:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759080958;
	bh=ZDDoSQHfUfGlV5GTCCz5MrXChE3PkwoLjvorvdmzaHY=;
	h=From:To:Cc:Subject:Date:From;
	b=XobWPXQZa9osT//YvtFffPGE800IwVqpG3b9bXLAReVbjwNJgmD8GfOK3R7YlGYSx
	 Vy6jIAjbbK0FqvBeAQl/PTMctS1yxFTaSs5R48U0h/jmu85cpYvNcDk90+St6NUEPU
	 riClis+tr60aijt02YjTjQbPf56+9ATSIBMlPNuqR8y/0BUplNZAhygHyrj4Z8Qbnx
	 32YaIhbgJpM7jDFvYoQj/K0nHHZkh97X4Y7sHoHRn0kxS67Xg2jSjTeW5z3I0eMZW6
	 3XXuBg3KB740t+Xf4oasjDkKypqj5eGBCqUVNXbhPjAoqaFXmpJuuwFgdEE7h7PesB
	 L1opgXulb1KrQ==
From: Miguel Ojeda <ojeda@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Rust for 6.18
Date: Sun, 28 Sep 2025 19:35:40 +0200
Message-ID: <20250928173541.229298-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

This is the next round of the Rust support.

A small one this time. One of the trees I merge (pin-init) is going this
cycle through DRM for convenience.

No conflicts expected at this time. Nevertheless, I did a test merge and
tested it a bit and it seems fine.

When you merge other trees, you will have some. The resolutions in -next
should be fine, except for a `rustfmt` issue in one, so please remember
to double-check that on your merges (it may be solved by the time you
get to it).

All commits have been in linux-next for at least four rounds, most for
two weeks or more.

Please pull for v6.18 -- thanks!

Cheers,
Miguel

The following changes since commit 76eeb9b8de9880ca38696b2fb56ac45ac0a25c6c:

  Linux 6.17-rc5 (2025-09-07 14:22:57 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ojeda/linux.git tags/rust-6.18

for you to fetch changes up to f3f6b3664302e16ef1c6b91034a72df5564d6b8a:

  gpu: nova-core: use Alignment for alignment-related operations (2025-09-22 23:56:06 +0200)

----------------------------------------------------------------
Rust changes for v6.18

Toolchain and infrastructure:

 - Derive 'Zeroable' for all structs and unions generated by 'bindgen'
   where possible and corresponding cleanups. To do so, add the
   'pin-init' crate as a dependency to 'bindings' and 'uapi'.

   It also includes its first use in the 'cpufreq' module, with more to
   come in the next cycle.

 - Add warning to the 'rustdoc' target to detect broken 'srctree/' links
   and fix existing cases.

 - Remove support for unused (since v6.16) host '#[test]'s, simplifying
   the 'rusttest' target. Tests should generally run within KUnit.

'kernel' crate:

 - Add 'ptr' module with a new 'Alignment' type, which is always a power
   of two and is used to validate that a given value is a valid
   alignment and to perform masking and alignment operations:

       // Checked at build time.
       assert_eq!(Alignment::new::<16>().as_usize(), 16);

       // Checked at runtime.
       assert_eq!(Alignment::new_checked(15), None);

       assert_eq!(Alignment::of::<u8>().log2(), 0);

       assert_eq!(0x25u8.align_down(Alignment::new::<0x10>()), 0x20);
       assert_eq!(0x5u8.align_up(Alignment::new::<0x10>()), Some(0x10));
       assert_eq!(u8::MAX.align_up(Alignment::new::<0x10>()), None);

   It also includes its first use in Nova.

 - Add 'core::mem::{align,size}_of{,_val}' to the prelude, matching
   Rust 1.80.0.

 - Keep going with the steps on our migration to the standard library
   'core::ffi::CStr' type (use 'kernel::{fmt, prelude::fmt!}' and use
   upstream method names).

 - 'error' module: improve 'Error::from_errno' and 'to_result'
   documentation, including examples/tests.

 - 'sync' module: extend 'aref' submodule documentation now that it
   exists, and more updates to complete the ongoing move of 'ARef' and
   'AlwaysRefCounted' to 'sync::aref'.

 - 'list' module: add an example/test for 'ListLinksSelfPtr' usage.

 - 'alloc' module:

   - Implement 'Box::pin_slice()', which constructs a pinned slice of
     elements.

   - Provide information about the minimum alignment guarantees of
     'Kmalloc', 'Vmalloc' and 'KVmalloc'.

   - Take minimum alignment guarantees of allocators for
     'ForeignOwnable' into account.

   - Remove the 'allocator_test' (including 'Cmalloc').

   - Add doctest for 'Vec::as_slice()'.

   - Constify various methods.

 - 'time' module:

   - Add methods on 'HrTimer' that can only be called with exclusive
     access to an unarmed timer, or from timer callback context.

   - Add arithmetic operations to 'Instant' and 'Delta'.

   - Add a few convenience and access methods to 'HrTimer' and
     'Instant'.

'macros' crate:

 - Reduce collections in 'quote!' macro.

And a few other cleanups and improvements.

----------------------------------------------------------------
Alexandre Courbot (2):
      rust: add `Alignment` type
      gpu: nova-core: use Alignment for alignment-related operations

Alice Ryhl (3):
      rust: alloc: specify the minimum alignment of each allocator
      rust: alloc: take the allocator into account for FOREIGN_ALIGN
      rust: alloc: implement Box::pin_slice()

Benno Lossin (4):
      rust: add `pin-init` as a dependency to `bindings` and `uapi`
      rust: derive `Zeroable` for all structs & unions generated by bindgen where possible
      rust: cpufreq: replace `MaybeUninit::zeroed().assume_init()` with `pin_init::zeroed()`
      rust: sync: extend module documentation of aref

Boqun Feng (1):
      rust: list: Add an example for `ListLinksSelfPtr` usage

Danilo Krummrich (1):
      rust: alloc: add ARCH_KMALLOC_MINALIGN to bindgen blocklist

Hui Zhu (2):
      rust: alloc: kvec: add doc example for as_slice method
      rust: alloc: kvec: simplify KUnit test module name to "rust_kvec"

Lyude Paul (9):
      rust: hrtimer: Document the return value for HrTimerHandle::cancel()
      rust: hrtimer: Add HrTimerInstant
      rust: hrtimer: Add HrTimer::raw_forward() and forward()
      rust: hrtimer: Add HrTimerCallbackContext and ::forward()
      rust: hrtimer: Add forward_now() to HrTimer and HrTimerCallbackContext
      rust: time: Add Instant::from_ktime()
      rust: hrtimer: Add HrTimer::expires()
      rust: time: Implement Add<Delta>/Sub<Delta> for Instant
      rust: time: Implement basic arithmetic operations for Delta

Miguel Ojeda (10):
      rust: kernel: remove support for unused host `#[test]`s
      rust: alloc: remove `allocator_test`
      Merge tag 'alloc-next-v6.18-2025-09-04' of https://github.com/Rust-for-Linux/linux into rust-next
      rust: block: fix `srctree/` links
      rust: drm: fix `srctree/` links
      rust: warn if `srctree/` links do not exist
      rust: prelude: re-export `core::mem::{align,size}_of{,_val}`
      rust: error: improve `Error::from_errno` documentation
      rust: error: improve `to_result` documentation
      Merge tag 'rust-timekeeping-v6.18' of https://github.com/Rust-for-Linux/linux into rust-next

Onur Özkan (3):
      rust: make `ArrayLayout::new_unchecked` a `const fn`
      rust: make `kvec::Vec` functions `const fn`
      rust: error: add C header links

Ritvik Gupta (1):
      rust: kernel: cpu: mark `CpuId::current()` inline

Shankari Anand (3):
      rust: dma: Update ARef and AlwaysRefCounted imports from sync::aref
      rust: sync: Update ARef and AlwaysRefCounted imports from sync::aref
      rust: task: update ARef and AlwaysRefCounted imports from sync::aref

Tamir Duberstein (21):
      gpu: nova-core: use `kernel::{fmt,prelude::fmt!}`
      rust: alloc: use `kernel::{fmt,prelude::fmt!}`
      rust: block: use `kernel::{fmt,prelude::fmt!}`
      rust: device: use `kernel::{fmt,prelude::fmt!}`
      rust: file: use `kernel::{fmt,prelude::fmt!}`
      rust: kunit: use `kernel::{fmt,prelude::fmt!}`
      rust: seq_file: use `kernel::{fmt,prelude::fmt!}`
      rust: sync: use `kernel::{fmt,prelude::fmt!}`
      rust: device: use `kernel::{fmt,prelude::fmt!}`
      drm/panic: use `core::ffi::CStr` method names
      rust: auxiliary: use `core::ffi::CStr` method names
      rust: configfs: use `core::ffi::CStr` method names
      rust: cpufreq: use `core::ffi::CStr` method names
      rust: drm: use `core::ffi::CStr` method names
      rust: firmware: use `core::ffi::CStr` method names
      rust: kunit: use `core::ffi::CStr` method names
      rust: miscdevice: use `core::ffi::CStr` method names
      rust: net: use `core::ffi::CStr` method names
      rust: of: use `core::ffi::CStr` method names
      rust: acpi: use `core::ffi::CStr` method names
      rust: macros: reduce collections in `quote!` macro

 Documentation/gpu/nova/core/todo.rst |   1 -
 drivers/block/rnull.rs               |   2 +-
 drivers/gpu/drm/drm_panic_qr.rs      |   2 +-
 drivers/gpu/nova-core/fb.rs          |   6 +-
 drivers/gpu/nova-core/gpu.rs         |   3 +-
 drivers/gpu/nova-core/regs/macros.rs |   6 +-
 drivers/gpu/nova-core/vbios.rs       |   4 +-
 rust/Makefile                        |  29 ++---
 rust/bindgen_parameters              |   5 +
 rust/bindings/bindings_helper.h      |   1 +
 rust/bindings/lib.rs                 |   8 ++
 rust/kernel/acpi.rs                  |   7 +-
 rust/kernel/alloc.rs                 |  15 +--
 rust/kernel/alloc/allocator.rs       |   8 ++
 rust/kernel/alloc/allocator_test.rs  | 124 -------------------
 rust/kernel/alloc/kbox.rs            |  92 +++++++++++++-
 rust/kernel/alloc/kvec.rs            |  24 ++--
 rust/kernel/alloc/kvec/errors.rs     |   2 +-
 rust/kernel/alloc/layout.rs          |   2 +-
 rust/kernel/auxiliary.rs             |   4 +-
 rust/kernel/block/mq.rs              |   2 +-
 rust/kernel/block/mq/gen_disk.rs     |   4 +-
 rust/kernel/block/mq/raw_writer.rs   |   3 +-
 rust/kernel/configfs.rs              |   4 +-
 rust/kernel/cpu.rs                   |   1 +
 rust/kernel/cpufreq.rs               |   6 +-
 rust/kernel/device.rs                |   6 +-
 rust/kernel/device/property.rs       |  23 ++--
 rust/kernel/dma.rs                   |   2 +-
 rust/kernel/drm/device.rs            |   6 +-
 rust/kernel/drm/driver.rs            |   2 +-
 rust/kernel/drm/file.rs              |   2 +-
 rust/kernel/drm/gem/mod.rs           |   2 +-
 rust/kernel/drm/ioctl.rs             |   2 +-
 rust/kernel/error.rs                 |  66 ++++++++--
 rust/kernel/firmware.rs              |   2 +-
 rust/kernel/fs/file.rs               |   5 +-
 rust/kernel/kunit.rs                 |  14 +--
 rust/kernel/lib.rs                   |   5 +-
 rust/kernel/list.rs                  | 120 ++++++++++++++++++
 rust/kernel/miscdevice.rs            |   2 +-
 rust/kernel/net/phy.rs               |   2 +-
 rust/kernel/of.rs                    |   2 +-
 rust/kernel/prelude.rs               |   5 +-
 rust/kernel/ptr.rs                   | 228 +++++++++++++++++++++++++++++++++++
 rust/kernel/seq_file.rs              |   6 +-
 rust/kernel/sync/arc.rs              |   8 +-
 rust/kernel/sync/aref.rs             |  17 ++-
 rust/kernel/task.rs                  |   7 +-
 rust/kernel/time.rs                  | 163 ++++++++++++++++++++++++-
 rust/kernel/time/hrtimer.rs          | 152 ++++++++++++++++++++++-
 rust/kernel/time/hrtimer/arc.rs      |   9 +-
 rust/kernel/time/hrtimer/pin.rs      |   9 +-
 rust/kernel/time/hrtimer/pin_mut.rs  |  12 +-
 rust/kernel/time/hrtimer/tbox.rs     |   9 +-
 rust/macros/quote.rs                 | 104 ++++++++--------
 rust/uapi/lib.rs                     |   2 +
 samples/rust/rust_configfs.rs        |   2 +-
 samples/rust/rust_dma.rs             |   2 +-
 scripts/generate_rust_analyzer.py    |   4 +-
 scripts/rustdoc_test_gen.rs          |   2 +-
 61 files changed, 1054 insertions(+), 315 deletions(-)
 delete mode 100644 rust/kernel/alloc/allocator_test.rs
 create mode 100644 rust/kernel/ptr.rs

