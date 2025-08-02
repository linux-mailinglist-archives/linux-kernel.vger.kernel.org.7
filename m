Return-Path: <linux-kernel+bounces-754223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26648B1900A
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 23:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7FF87A8D77
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 21:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0002586EE;
	Sat,  2 Aug 2025 21:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jsvIFlZC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF7D7F9;
	Sat,  2 Aug 2025 21:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754169372; cv=none; b=rpC9bVgkI7X2/4hiaBs9Xds6DcEA6yE+LY9Unit+d0yIxHv0LL4/OappDaxojmJZxo/K1KhRXCisaX3hSSqzKSZl5EsrtjjZnwwsoMb6bTLwlOrrLpcAsFScq8uo530EP1QXwokIoLFweeJHXo/Qlky4ai3eFETDd6Aw1LWwxMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754169372; c=relaxed/simple;
	bh=fgZLiJKIa13lI24xblwoIrziXfGxuci0pwYHt1jmI7o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aPmM5Zrwdq0uDOFDvyhIrunKgcRQzHS8ep6a2yVWZqzUNHlB4eDP0pxCz6/6jvx8BNFCd2PhdVE/23Vsynr2C4o/XCQ/OuVJpcdys99Iy7w5N4WyolAsN35l6P/fvXxn+b85Z4kKh997BSCU6yI45kGRmvMFVGaGyuld6YeplhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jsvIFlZC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE656C4CEEF;
	Sat,  2 Aug 2025 21:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754169371;
	bh=fgZLiJKIa13lI24xblwoIrziXfGxuci0pwYHt1jmI7o=;
	h=From:To:Cc:Subject:Date:From;
	b=jsvIFlZCEc5aJdIgCMjYkVvc32vB5Cj2Xqknm1ZhmDBN4phJpFWNpgRcZW23Wl9Cz
	 yPO2U98HCCNNVj7iFuouJA7MilBTqAaXBzjYgn3CE/2hbSwJENyYfxpRbdxBaWTw8m
	 S7+cfQci6dYbNbmCoRYVlPex1tzo2JTbvCfGw8JJFOWGcyNgR0PVbhyC5GDX66zFAE
	 gd1CvhiyrjnjWXVVgcB36OntJA7/FpGfkNCnvGIYD48IlQypGQFKWlUnl72zf19dTf
	 ZRSqUHE0sxHuuvYWJO33+esMyq/ukXFF+Nk9Oc2Lgtw1ixEGx2Ex5v5jI0DfngIfEx
	 OxG+iuM3LWgUQ==
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
Subject: [GIT PULL] Rust for 6.17
Date: Sat,  2 Aug 2025 23:13:15 +0200
Message-ID: <20250802211316.875761-1-ojeda@kernel.org>
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

This is my first pull that has merges that you already have from
elsewhere (3 merge bases). So I have provided the diffstat of the test
merge, instead of the generated one (it would not have been too bad
in this case anyway). I still included those changes in the shortlog and
in the tag message (the "'dma' module" and the first bullet of
"'pin-init' crate").

There are a few conflicts, including a semantic one, but are all easy to
apply. The resolutions in the latest linux-next are fine -- I also did a
test merge with your state from a few hours ago:

    https://git.kernel.org/pub/scm/linux/kernel/git/ojeda/linux.git rust-6.17-test-merge

There may be also conflicts with the tip tree in arch `bug.h` headers.
The resolution for that in -next also seems fine.

All commits have been in linux-next since at least last week, most more.

Please pull for v6.17 -- thanks!

Cheers,
Miguel

The following changes since commit 86731a2a651e58953fc949573895f2fa6d456841:

  Linux 6.16-rc3 (2025-06-22 13:30:08 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ojeda/linux.git tags/rust-6.17

for you to fetch changes up to dff64b072708ffef23c117fa1ee1ea59eb417807:

  rust: Add warn_on macro (2025-07-23 02:05:58 +0200)

----------------------------------------------------------------
Rust changes for v6.17

Toolchain and infrastructure:

 - Enable a set of Clippy lints: 'ptr_as_ptr', 'ptr_cast_constness',
   'as_ptr_cast_mut', 'as_underscore', 'cast_lossless' and 'ref_as_ptr'.

   These are intended to avoid type casts with the 'as' operator, which
   are quite powerful, into restricted variants that are less powerful
   and thus should help to avoid mistakes.

 - Remove the 'author' key now that most instances were moved to the
   plural one in the previous cycle.

'kernel' crate:

 - New 'bug' module: add 'warn_on!' macro which reuses the existing
   'BUG'/'WARN' infrastructure, i.e. it respects the usual sysctls and
   kernel parameters:

       warn_on!(value == 42);

   To avoid duplicating the assembly code, the same strategy is followed
   as for the static branch code in order to share the assembly between
   both C and Rust. This required a few rearrangements on C arch headers
   -- the existing C macros should still generate the same outputs, thus
   no functional change expected there.

 - 'workqueue' module: add delayed work items, including a 'DelayedWork'
   struct, a 'impl_has_delayed_work!' macro and an 'enqueue_delayed'
   method, e.g.:

       /// Enqueue the struct for execution on the system workqueue,
       /// where its value will be printed 42 jiffies later.
       fn print_later(value: Arc<MyStruct>) {
           let _ = workqueue::system().enqueue_delayed(value, 42);
       }

 - New 'bits' module: add support for 'bit' and 'genmask' functions,
   with runtime- and compile-time variants, e.g.:

       static_assert!(0b00010000 == bit_u8(4));
       static_assert!(0b00011110 == genmask_u8(1..=4));

       assert!(checked_bit_u32(u32::BITS).is_none());

 - 'uaccess' module: add 'UserSliceReader::strcpy_into_buf', which reads
   NUL-terminated strings from userspace into a '&CStr'.

   Introduce 'UserPtr' newtype, similar in purpose to '__user' in C, to
   minimize mistakes handling userspace pointers, including mixing them
   up with integers and leaking them via the 'Debug' trait. Add it to
   the prelude, too.

 - Start preparations for the replacement of our custom 'CStr' type
   with the analogous type in the 'core' standard library. This will
   take place across several cycles to make it easier. For this one,
   it includes a new 'fmt' module, using upstream method names and some
   other cleanups.

   Replace 'fmt!' with a re-export, which helps Clippy lint properly,
   and clean up the found 'uninlined-format-args' instances.

 - 'dma' module:

   - Clarify wording and be consistent in 'coherent' nomenclature.

   - Convert the 'read!()' and 'write!()' macros to return a 'Result'.

   - Add 'as_slice()', 'write()' methods in 'CoherentAllocation'.

   - Expose 'count()' and 'size()' in 'CoherentAllocation' and add the
     corresponding type invariants.

   - Implement 'CoherentAllocation::dma_handle_with_offset()'.

 - 'time' module:

   - Make 'Instant' generic over clock source. This allows the compiler
     to assert that arithmetic expressions involving the 'Instant' use
     'Instants' based on the same clock source.

   - Make 'HrTimer' generic over the timer mode. 'HrTimer' timers take a
     'Duration' or an 'Instant' when setting the expiry time, depending
     on the timer mode. With this change, the compiler can check the
     type matches the timer mode.

   - Add an abstraction for 'fsleep'. 'fsleep' is a flexible sleep
     function that will select an appropriate sleep method depending on
     the requested sleep time.

   - Avoid 64-bit divisions on 32-bit hardware when calculating
     timestamps.

   - Seal the 'HrTimerMode' trait. This prevents users of the
     'HrTimerMode' from implementing the trait on their own types.

   - Pass the correct timer mode ID to 'hrtimer_start_range_ns()'.

 - 'list' module: remove 'OFFSET' constants, allowing to remove pointer
   arithmetic; now 'impl_list_item!' invokes 'impl_has_list_links!' or
   'impl_has_list_links_self_ptr!'. Other simplifications too.

 - 'types' module: remove 'ForeignOwnable::PointedTo' in favor of a
   constant, which avoids exposing the type of the opaque pointer, and
   require 'into_foreign' to return non-null.

   Remove the 'Either<L, R>' type as well. It is unused, and we want to
   encourage the use of custom enums for concrete use cases.

 - 'sync' module: implement 'Borrow' and 'BorrowMut' for 'Arc' types
   to allow them to be used in generic APIs.

 - 'alloc' module: implement 'Borrow' and 'BorrowMut' for 'Box<T, A>';
    and 'Borrow', 'BorrowMut' and 'Default' for 'Vec<T, A>'.

 - 'Opaque' type: add 'cast_from' method to perform a restricted cast
   that cannot change the inner type and use it in callers of
   'container_of!'. Rename 'raw_get' to 'cast_into' to match it.

 - 'rbtree' module: add 'is_empty' method.

 - 'sync' module: new 'aref' submodule to hold 'AlwaysRefCounted' and
   'ARef', which are moved from the too general 'types' module which we
   want to reduce or eventually remove. Also fix a safety comment in
   'static_lock_class'.

'pin-init' crate:

 - Add 'impl<T, E> [Pin]Init<T, E> for Result<T, E>', so results are now
   (pin-)initializers.

 - Add 'Zeroable::init_zeroed()' that delegates to 'init_zeroed()'.

 - New 'zeroed()', a safe version of 'mem::zeroed()' and also provide
   it via 'Zeroable::zeroed()'.

 - Implement 'Zeroable' for 'Option<&T>', 'Option<&mut T>' and for
   'Option<[unsafe] [extern "abi"] fn(...args...) -> ret>' for '"Rust"'
   and '"C"' ABIs and up to 20 arguments.

 - Changed blanket impls of 'Init' and 'PinInit' from 'impl<T, E>
   [Pin]Init<T, E> for T' to 'impl<T> [Pin]Init<T> for T'.

 - Renamed 'zeroed()' to 'init_zeroed()'.

 - Upstream dev news: improve CI more to deny warnings, use
   '--all-targets'. Check the synchronization status of the two '-next'
   branches in upstream and the kernel.

MAINTAINERS:

 - Add Vlastimil Babka, Liam R. Howlett, Uladzislau Rezki and Lorenzo
   Stoakes as reviewers (thanks everyone).

And a few other cleanups and improvements.

----------------------------------------------------------------
Abdiel Janulgue (3):
      rust: dma: clarify wording and be consistent in `coherent` nomenclature
      rust: dma: convert the read/write macros to return Result
      rust: dma: add as_slice/write functions for CoherentAllocation

Albin Babu Varghese (1):
      rust: list: replace unwrap() with ? in doctest examples

Alexandre Courbot (6):
      rust: alloc: implement `Borrow` and `BorrowMut` for `Vec`
      rust: alloc: implement `Borrow` and `BorrowMut` for `KBox`
      rust: dma: fix doc-comment of dma_handle()
      rust: dma: expose the count and size of CoherentAllocation
      rust: dma: add dma_handle_with_offset method to CoherentAllocation
      rust: sync: implement `Borrow` and `BorrowMut` for `Arc` types

Alice Ryhl (9):
      rust: vec: impl Default for Vec with any allocator
      rust: rbtree: add RBTree::is_empty
      rust: revocable: document why &T is not used in RevocableGuard
      rust: uaccess: add strncpy_from_user
      rust: uaccess: add UserSliceReader::strcpy_into_buf
      rust: uaccess: use newtype for user pointers
      rust: types: add Opaque::cast_from
      rust: types: rename Opaque::raw_get to cast_into
      workqueue: rust: add delayed work items

Andreas Hindborg (2):
      rust: types: add FOREIGN_ALIGN to ForeignOwnable
      rust: types: require `ForeignOwnable::into_foreign` return non-null

Benno Lossin (14):
      rust: pin-init: improve safety documentation for `impl<T> [Pin]Init<T> for T`
      rust: pin-init: change blanket impls for `[Pin]Init` and add one for `Result<T, E>`
      rust: pin-init: examples, tests: add conditional compilation in order to compile under any feature combination
      rust: pin-init: examples: pthread_mutex: disable the main test for miri
      rust: pin-init: feature-gate the `stack_init_reuse` test on the `std` feature
      rust: pin-init: rename `zeroed` to `init_zeroed`
      rust: pin-init: add `Zeroable::init_zeroed`
      rust: pin-init: add `zeroed()` & `Zeroable::zeroed()` functions
      rust: pin-init: implement `ZeroableOption` for `&T` and `&mut T`
      rust: pin-init: change `impl Zeroable for Option<NonNull<T>>` to `ZeroableOption for NonNull<T>`
      rust: pin-init: implement `ZeroableOption` for function pointers with up to 20 arguments
      rust: pin-init: examples, tests: use `ignore` instead of conditionally compiling tests
      rust: types: remove `Either<L, R>`
      rust: sync: fix safety comment for `static_lock_class`

Daniel Almeida (1):
      rust: bits: add support for bits/genmask macros

Danilo Krummrich (2):
      Merge tag 'topic/dma-features-2025-06-23' into alloc-next
      rust: dma: require mutable reference for as_slice_mut() and write()

FUJITA Tomonori (14):
      rust: time: Avoid 64-bit integer division on 32-bit architectures
      rust: time: Replace ClockId enum with ClockSource trait
      rust: time: Make Instant generic over ClockSource
      rust: time: Add ktime_get() to ClockSource trait
      rust: time: Replace HrTimerMode enum with trait-based mode types
      rust: time: Add HrTimerExpires trait
      rust: time: Make HasHrTimer generic over HrTimerMode
      rust: time: Remove Ktime in hrtimer
      rust: time: Seal the HrTimerMode trait
      rust: time: Add wrapper for fsleep() function
      x86/bug: Add ARCH_WARN_ASM macro for BUG/WARN asm code sharing with Rust
      riscv/bug: Add ARCH_WARN_ASM macro for BUG/WARN asm code sharing with Rust
      arm64/bug: Add ARCH_WARN_ASM macro for BUG/WARN asm code sharing with Rust
      rust: Add warn_on macro

Guilherme Giacomo Simoes (1):
      rust: macros: remove `module!`'s deprecated `author` key

Jesung Yang (1):
      rust: kunit: use crate-level mapping for `c_void`

Krishna Ketan Rai (1):
      rust: helpers: sort includes alphabetically

Lorenzo Stoakes (1):
      MAINTAINERS: add mm folks as reviewers to rust alloc

Lyude Paul (1):
      rust: time: Pass correct timer mode ID to hrtimer_start_range_ns

Miguel Ojeda (7):
      rust: init: re-enable doctests
      rust: init: remove doctest's `Error::from_errno` workaround
      Merge tag 'pin-init-v6.17' of https://github.com/Rust-for-Linux/linux into rust-next
      Merge tag 'alloc-next-v6.17-2025-07-15' of https://github.com/Rust-for-Linux/linux into rust-next
      Merge tag 'rust-timekeeping-for-v6.17' of https://github.com/Rust-for-Linux/linux into rust-next
      rust: list: undo unintended replacement of method name
      rust: list: remove nonexistent generic parameter in link

Onur Özkan (1):
      rust: rbtree: simplify finding `current` in `remove_current`

Sai Vishnu M (1):
      rust: io: avoid mentioning private fields in `IoMem`

Shankari Anand (1):
      rust: kernel: move ARef and AlwaysRefCounted to sync::aref

Tamir Duberstein (20):
      rust: enable `clippy::ptr_as_ptr` lint
      rust: enable `clippy::ptr_cast_constness` lint
      rust: enable `clippy::as_ptr_cast_mut` lint
      rust: enable `clippy::as_underscore` lint
      rust: enable `clippy::cast_lossless` lint
      rust: enable `clippy::ref_as_ptr` lint
      rust: list: simplify macro capture
      rust: list: use consistent type parameter style
      rust: list: use consistent self parameter name
      rust: list: use fully qualified path
      rust: list: add `impl_list_item!` examples
      rust: list: remove OFFSET constants
      scripts: rust: replace length checks with match
      scripts: rust: emit path candidates in panic message
      rust: kernel: remove `fmt!`, fix clippy::uninlined-format-args
      rust: kernel: add `fmt` module
      rust: use `kernel::{fmt,prelude::fmt!}`
      rust: str: remove unnecessary qualification
      rust: str: add `CStr` methods matching `core::ffi::CStr`
      rust: kernel: use `core::ffi::CStr` method names

Viresh Kumar (1):
      rust: Use consistent "# Examples" heading style in rustdoc

 MAINTAINERS                                   |   4 +
 Makefile                                      |   6 +
 arch/arm64/include/asm/asm-bug.h              |  33 ++-
 arch/riscv/include/asm/bug.h                  |  35 +--
 arch/x86/include/asm/bug.h                    |  56 ++---
 drivers/cpufreq/rcpufreq_dt.rs                |   5 +-
 drivers/gpu/drm/drm_panic_qr.rs               |   4 +-
 drivers/gpu/drm/nova/nova.rs                  |   2 +-
 drivers/gpu/nova-core/driver.rs               |   2 +-
 drivers/gpu/nova-core/firmware.rs             |   5 +-
 drivers/gpu/nova-core/nova_core.rs            |   2 +-
 drivers/gpu/nova-core/regs.rs                 |   2 +-
 drivers/gpu/nova-core/regs/macros.rs          |   2 +-
 drivers/gpu/nova-core/util.rs                 |   4 +-
 rust/Makefile                                 |   8 +
 rust/bindings/lib.rs                          |   3 +
 rust/helpers/bug.c                            |   5 +
 rust/helpers/helpers.c                        |   3 +-
 rust/helpers/time.c                           |  35 +++
 rust/kernel/.gitignore                        |   2 +
 rust/kernel/alloc/allocator_test.rs           |   2 +-
 rust/kernel/alloc/kbox.rs                     |  98 ++++++--
 rust/kernel/alloc/kvec.rs                     |  59 ++++-
 rust/kernel/bits.rs                           | 203 +++++++++++++++
 rust/kernel/block/mq.rs                       |   2 +-
 rust/kernel/block/mq/operations.rs            |   2 +-
 rust/kernel/block/mq/request.rs               |  11 +-
 rust/kernel/bug.rs                            | 126 ++++++++++
 rust/kernel/clk.rs                            |   6 +-
 rust/kernel/configfs.rs                       |  30 +--
 rust/kernel/cpufreq.rs                        |  10 +-
 rust/kernel/cpumask.rs                        |   4 +-
 rust/kernel/device.rs                         |   4 +-
 rust/kernel/device_id.rs                      |   4 +-
 rust/kernel/devres.rs                         |  10 +-
 rust/kernel/dma.rs                            |  10 +-
 rust/kernel/drm/device.rs                     |  10 +-
 rust/kernel/drm/gem/mod.rs                    |   4 +-
 rust/kernel/error.rs                          |  10 +-
 rust/kernel/firmware.rs                       |   9 +-
 rust/kernel/fmt.rs                            |   7 +
 rust/kernel/fs/file.rs                        |   2 +-
 rust/kernel/generated_arch_reachable_asm.rs.S |   7 +
 rust/kernel/generated_arch_warn_asm.rs.S      |   7 +
 rust/kernel/init.rs                           |  34 +--
 rust/kernel/io.rs                             |  20 +-
 rust/kernel/kunit.rs                          |  13 +-
 rust/kernel/lib.rs                            |  10 +
 rust/kernel/list.rs                           |  63 ++---
 rust/kernel/list/impl_list_item_mod.rs        | 239 ++++++++++++------
 rust/kernel/miscdevice.rs                     |  12 +-
 rust/kernel/mm/virt.rs                        |  52 ++--
 rust/kernel/net/phy.rs                        |   4 +-
 rust/kernel/of.rs                             |   6 +-
 rust/kernel/opp.rs                            |  20 +-
 rust/kernel/pci.rs                            |  13 +-
 rust/kernel/platform.rs                       |   2 +-
 rust/kernel/prelude.rs                        |   4 +-
 rust/kernel/print.rs                          |  12 +-
 rust/kernel/rbtree.rs                         |  29 +--
 rust/kernel/revocable.rs                      |   4 +
 rust/kernel/seq_file.rs                       |   2 +-
 rust/kernel/str.rs                            | 111 +++++----
 rust/kernel/sync.rs                           |  10 +-
 rust/kernel/sync/arc.rs                       | 102 +++++++-
 rust/kernel/sync/aref.rs                      | 154 ++++++++++++
 rust/kernel/time.rs                           | 233 ++++++++++++------
 rust/kernel/time/delay.rs                     |  49 ++++
 rust/kernel/time/hrtimer.rs                   | 304 +++++++++++++++--------
 rust/kernel/time/hrtimer/arc.rs               |   8 +-
 rust/kernel/time/hrtimer/pin.rs               |  10 +-
 rust/kernel/time/hrtimer/pin_mut.rs           |  10 +-
 rust/kernel/time/hrtimer/tbox.rs              |   8 +-
 rust/kernel/types.rs                          | 229 +++--------------
 rust/kernel/uaccess.rs                        | 167 +++++++++++--
 rust/kernel/workqueue.rs                      | 342 +++++++++++++++++++++++++-
 rust/kernel/xarray.rs                         |   9 +-
 rust/macros/module.rs                         |   6 -
 rust/pin-init/README.md                       |   2 +-
 rust/pin-init/examples/big_struct_in_place.rs |  28 ++-
 rust/pin-init/examples/linked_list.rs         |  10 +-
 rust/pin-init/examples/mutex.rs               |  97 +++++---
 rust/pin-init/examples/pthread_mutex.rs       |   4 +
 rust/pin-init/examples/static_init.rs         |  75 +++---
 rust/pin-init/src/__internal.rs               |   1 +
 rust/pin-init/src/lib.rs                      | 120 +++++++--
 rust/pin-init/src/macros.rs                   |  16 +-
 rust/uapi/lib.rs                              |   3 +
 samples/rust/rust_configfs.rs                 |   2 +-
 samples/rust/rust_driver_auxiliary.rs         |   2 +-
 samples/rust/rust_misc_device.rs              |   2 +
 samples/rust/rust_print_main.rs               |   2 +-
 scripts/Makefile.build                        |   5 +-
 scripts/rustdoc_test_gen.rs                   |  33 +--
 94 files changed, 2561 insertions(+), 987 deletions(-)
 create mode 100644 rust/helpers/time.c
 create mode 100644 rust/kernel/bits.rs
 create mode 100644 rust/kernel/bug.rs
 create mode 100644 rust/kernel/fmt.rs
 create mode 100644 rust/kernel/generated_arch_reachable_asm.rs.S
 create mode 100644 rust/kernel/generated_arch_warn_asm.rs.S
 create mode 100644 rust/kernel/sync/aref.rs
 create mode 100644 rust/kernel/time/delay.rs

