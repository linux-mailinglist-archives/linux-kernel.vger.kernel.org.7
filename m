Return-Path: <linux-kernel+bounces-815480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4E1B56709
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 08:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9EE4189EF91
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 06:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF7227817F;
	Sun, 14 Sep 2025 06:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PVdKwwxB"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEA52773F0
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 06:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757830241; cv=none; b=AgssDOdFbHa+bbmPK04g94LYAgt3iagWuk3ufIeRiC9K8yh8vMJbkNYg4r9ezhsqlN582EnYL4qginmcGe45/fcwuRbxbKqcY4jgSClGR0CaT9nYMv0LEpEFNospxEAHTPVudNOb/He105TxMvJqI0Xel02UsZqzNvJqizQdLwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757830241; c=relaxed/simple;
	bh=TnYOG+zU80fUH9AlYIHN4VWeKwWBClKGHV+KnhdenSo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=F1kmYQVpeM5HxAR3HoPIAUuAURVnh55oAQ7b6uEiEGfUsQaBpRdHrcO41LcbN2NuawB3RnDqgOQSJ04aD53npVris3A2O2oXSzC48hRK9zvOIuN6gzt3Deh/xrPv8aP8+i5MGp2kju5o7UhSvI2d803lZIp6eKVF/gvjUtQpjVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PVdKwwxB; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757830240; x=1789366240;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TnYOG+zU80fUH9AlYIHN4VWeKwWBClKGHV+KnhdenSo=;
  b=PVdKwwxBFn4wyJFy7hTMGxJ8er5P06D0tGwuNTOkGdubfQ/ix+i9WZIn
   PvYEReyh1L0Vwo6hoP4TAQpIb5hgg3ik3IxrcQhictjW1DnMluERKsw49
   LeDZfJiGRRm/EANyu+Eb4Unx3hqe4+McKWt7f3W3AlwMCpkbc5sIN1TOr
   n9MZRZP9uhFqBV1bivdR4MpIoVUEK2NmFyeT2FA8tB+p/U0bzCId/1eiB
   7UaLlecq/azS/BDlbk9OLkMHc71cln9CcXVRuM4I98u4UVP4OOKcDIVsT
   DSao2uGnjjpzTTeCVO0O2Yv3dTK1oHNuzDHZE3d3TlV+TcJ5rDpAAmXmu
   A==;
X-CSE-ConnectionGUID: nR1KeE7eRwSKzXg5GXbk8g==
X-CSE-MsgGUID: X8/qUjXHQN2nWeKAsfYf3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11552"; a="60186121"
X-IronPort-AV: E=Sophos;i="6.18,263,1751266800"; 
   d="scan'208";a="60186121"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2025 23:10:39 -0700
X-CSE-ConnectionGUID: 2ICbEcbwTYKefiZAIZPEyQ==
X-CSE-MsgGUID: b9+ZbyOvQfq6A7QlUK1q+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,263,1751266800"; 
   d="scan'208";a="198048155"
Received: from lkp-server02.sh.intel.com (HELO eb5fdfb2a9b7) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 13 Sep 2025 23:10:37 -0700
Received: from kbuild by eb5fdfb2a9b7 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uxfwY-00029d-33;
	Sun, 14 Sep 2025 06:10:34 +0000
Date: Sun, 14 Sep 2025 14:10:26 +0800
From: kernel test robot <lkp@intel.com>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Alice Ryhl <aliceryhl@google.com>, Benno Lossin <lossin@kernel.org>,
	Elle Rhumsaa <elle@weathered-steel.dev>
Subject: [tip:locking/core 1/13] error[E0425]: cannot find function
 `atomic_add` in crate `bindings`
Message-ID: <202509141437.5iiM1sOF-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
head:   502ae97746ab6d7b7b48d54b6a85a11815f390d0
commit: eb57133305f61b612252382d0c1478bba7f57b67 [1/13] rust: sync: Add basic atomic operation mapping framework
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20250914/202509141437.5iiM1sOF-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250914/202509141437.5iiM1sOF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509141437.5iiM1sOF-lkp@intel.com/

All errors (new ones prefixed by >>):

>> error[E0425]: cannot find function `atomic_read_acquire` in crate `bindings`
   --> rust/kernel/sync/atomic/internal.rs:124:37
   |
   124 |                   $unsafe { bindings::[< $ctype _ $func >]($($c_arg,)*) }
   |                                       ^^^^^^^^^^^^^^^^^^^^ not found in `bindings`
   ...
   201 | / declare_and_impl_atomic_methods!(
   202 | |     /// Basic atomic operations
   203 | |     pub trait AtomicBasicOps {
   204 | |         /// Atomic read (load).
   ...   |
   216 | | );
   | |_- in this macro invocation
   |
   = note: this error originates in the macro `impl_atomic_method` which comes from the expansion of the macro `declare_and_impl_atomic_methods` (in Nightly builds, run with -Z macro-backtrace for more info)
--
>> error[E0425]: cannot find function `atomic_read` in crate `bindings`
   --> rust/kernel/sync/atomic/internal.rs:124:37
   |
   124 |                   $unsafe { bindings::[< $ctype _ $func >]($($c_arg,)*) }
   |                                       ^^^^^^^^^^^^^^^^^^^^ not found in `bindings`
   ...
   201 | / declare_and_impl_atomic_methods!(
   202 | |     /// Basic atomic operations
   203 | |     pub trait AtomicBasicOps {
   204 | |         /// Atomic read (load).
   ...   |
   216 | | );
   | |_- in this macro invocation
   |
   = note: this error originates in the macro `impl_atomic_method` which comes from the expansion of the macro `declare_and_impl_atomic_methods` (in Nightly builds, run with -Z macro-backtrace for more info)
--
>> error[E0425]: cannot find function `atomic_xchg_relaxed` in crate `bindings`
   --> rust/kernel/sync/atomic/internal.rs:124:37
   |
   124 |                   $unsafe { bindings::[< $ctype _ $func >]($($c_arg,)*) }
   |                                       ^^^^^^^^^^^^^^^^^^^^ not found in `bindings`
   ...
   218 | / declare_and_impl_atomic_methods!(
   219 | |     /// Exchange and compare-and-exchange atomic operations
   220 | |     pub trait AtomicExchangeOps {
   221 | |         /// Atomic exchange.
   ...   |
   243 | | );
   | |_- in this macro invocation
   |
   = note: this error originates in the macro `impl_atomic_method` which comes from the expansion of the macro `declare_and_impl_atomic_methods` (in Nightly builds, run with -Z macro-backtrace for more info)
   help: consider importing this function
   |
   7   + use core::intrinsics::atomic_xchg_relaxed;
   |
--
>> error[E0425]: cannot find function `atomic_xchg` in crate `bindings`
   --> rust/kernel/sync/atomic/internal.rs:124:37
   |
   124 |                   $unsafe { bindings::[< $ctype _ $func >]($($c_arg,)*) }
   |                                       ^^^^^^^^^^^^^^^^^^^^ not found in `bindings`
   ...
   218 | / declare_and_impl_atomic_methods!(
   219 | |     /// Exchange and compare-and-exchange atomic operations
   220 | |     pub trait AtomicExchangeOps {
   221 | |         /// Atomic exchange.
   ...   |
   243 | | );
   | |_- in this macro invocation
   |
   = note: this error originates in the macro `impl_atomic_method` which comes from the expansion of the macro `declare_and_impl_atomic_methods` (in Nightly builds, run with -Z macro-backtrace for more info)
--
>> error[E0425]: cannot find function `atomic_try_cmpxchg_acquire` in crate `bindings`
   --> rust/kernel/sync/atomic/internal.rs:124:37
   |
   124 |                   $unsafe { bindings::[< $ctype _ $func >]($($c_arg,)*) }
   |                                       ^^^^^^^^^^^^^^^^^^^^ not found in `bindings`
   ...
   218 | / declare_and_impl_atomic_methods!(
   219 | |     /// Exchange and compare-and-exchange atomic operations
   220 | |     pub trait AtomicExchangeOps {
   221 | |         /// Atomic exchange.
   ...   |
   243 | | );
   | |_- in this macro invocation
   |
   = note: this error originates in the macro `impl_atomic_method` which comes from the expansion of the macro `declare_and_impl_atomic_methods` (in Nightly builds, run with -Z macro-backtrace for more info)
--
>> error[E0425]: cannot find function `atomic_try_cmpxchg_release` in crate `bindings`
   --> rust/kernel/sync/atomic/internal.rs:124:37
   |
   124 |                   $unsafe { bindings::[< $ctype _ $func >]($($c_arg,)*) }
   |                                       ^^^^^^^^^^^^^^^^^^^^ not found in `bindings`
   ...
   218 | / declare_and_impl_atomic_methods!(
   219 | |     /// Exchange and compare-and-exchange atomic operations
   220 | |     pub trait AtomicExchangeOps {
   221 | |         /// Atomic exchange.
   ...   |
   243 | | );
   | |_- in this macro invocation
   |
   = note: this error originates in the macro `impl_atomic_method` which comes from the expansion of the macro `declare_and_impl_atomic_methods` (in Nightly builds, run with -Z macro-backtrace for more info)
--
>> error[E0425]: cannot find function `atomic_try_cmpxchg_relaxed` in crate `bindings`
   --> rust/kernel/sync/atomic/internal.rs:124:37
   |
   124 |                   $unsafe { bindings::[< $ctype _ $func >]($($c_arg,)*) }
   |                                       ^^^^^^^^^^^^^^^^^^^^ not found in `bindings`
   ...
   218 | / declare_and_impl_atomic_methods!(
   219 | |     /// Exchange and compare-and-exchange atomic operations
   220 | |     pub trait AtomicExchangeOps {
   221 | |         /// Atomic exchange.
   ...   |
   243 | | );
   | |_- in this macro invocation
   |
   = note: this error originates in the macro `impl_atomic_method` which comes from the expansion of the macro `declare_and_impl_atomic_methods` (in Nightly builds, run with -Z macro-backtrace for more info)
--
>> error[E0425]: cannot find function `atomic_try_cmpxchg` in crate `bindings`
   --> rust/kernel/sync/atomic/internal.rs:124:37
   |
   124 |                   $unsafe { bindings::[< $ctype _ $func >]($($c_arg,)*) }
   |                                       ^^^^^^^^^^^^^^^^^^^^ not found in `bindings`
   ...
   218 | / declare_and_impl_atomic_methods!(
   219 | |     /// Exchange and compare-and-exchange atomic operations
   220 | |     pub trait AtomicExchangeOps {
   221 | |         /// Atomic exchange.
   ...   |
   243 | | );
   | |_- in this macro invocation
   |
   = note: this error originates in the macro `impl_atomic_method` which comes from the expansion of the macro `declare_and_impl_atomic_methods` (in Nightly builds, run with -Z macro-backtrace for more info)
--
>> error[E0425]: cannot find function `atomic64_xchg_acquire` in crate `bindings`
   --> rust/kernel/sync/atomic/internal.rs:124:37
   |
   124 |                   $unsafe { bindings::[< $ctype _ $func >]($($c_arg,)*) }
   |                                       ^^^^^^^^^^^^^^^^^^^^ not found in `bindings`
   ...
   218 | / declare_and_impl_atomic_methods!(
   219 | |     /// Exchange and compare-and-exchange atomic operations
   220 | |     pub trait AtomicExchangeOps {
   221 | |         /// Atomic exchange.
   ...   |
   243 | | );
   | |_- in this macro invocation
   |
   = note: this error originates in the macro `impl_atomic_method` which comes from the expansion of the macro `declare_and_impl_atomic_methods` (in Nightly builds, run with -Z macro-backtrace for more info)
--
>> error[E0425]: cannot find function `atomic64_xchg_release` in crate `bindings`
   --> rust/kernel/sync/atomic/internal.rs:124:37
   |
   124 |                   $unsafe { bindings::[< $ctype _ $func >]($($c_arg,)*) }
   |                                       ^^^^^^^^^^^^^^^^^^^^ not found in `bindings`
   ...
   218 | / declare_and_impl_atomic_methods!(
   219 | |     /// Exchange and compare-and-exchange atomic operations
   220 | |     pub trait AtomicExchangeOps {
   221 | |         /// Atomic exchange.
   ...   |
   243 | | );
   | |_- in this macro invocation
   |
   = note: this error originates in the macro `impl_atomic_method` which comes from the expansion of the macro `declare_and_impl_atomic_methods` (in Nightly builds, run with -Z macro-backtrace for more info)
--
>> error[E0425]: cannot find function `atomic64_xchg_relaxed` in crate `bindings`
   --> rust/kernel/sync/atomic/internal.rs:124:37
   |
   124 |                   $unsafe { bindings::[< $ctype _ $func >]($($c_arg,)*) }
   |                                       ^^^^^^^^^^^^^^^^^^^^ not found in `bindings`
   ...
   218 | / declare_and_impl_atomic_methods!(
   219 | |     /// Exchange and compare-and-exchange atomic operations
   220 | |     pub trait AtomicExchangeOps {
   221 | |         /// Atomic exchange.
   ...   |
   243 | | );
   | |_- in this macro invocation
   |
   = note: this error originates in the macro `impl_atomic_method` which comes from the expansion of the macro `declare_and_impl_atomic_methods` (in Nightly builds, run with -Z macro-backtrace for more info)
..

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

