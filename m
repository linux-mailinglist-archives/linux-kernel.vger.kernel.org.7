Return-Path: <linux-kernel+bounces-815217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC025B56151
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 16:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEC881C22049
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 14:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1BE52ED843;
	Sat, 13 Sep 2025 14:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G1pzWbuO"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127D6199FAB
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 14:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757772036; cv=none; b=tFGfjMoVB9AIcaUjwsER5jpR5/3zIIqrxDU5VQ0lggDRJnGHpnaVDeDg8k8uYtG3n9vqZZba+/uyQ4V4ppPrIeiyoetnKQospJEnikK7f4a/6SDtCHeU77X46mBQcOgwNeH8ZsK1qwXVZO3nyBvbkBDR5Yp2jg7MjFTBKJ0IUGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757772036; c=relaxed/simple;
	bh=nEomdwrY0x+N627biNdsd37XgirP9L8af7tXqvHXYeA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WbPblTkahXRHa3Y/CRiSTdpdlNKYKN7Vw5s3J8Xysot0pFsTHPjISSYvWHieYAQR59FDGi3hQbb19irbh8CpK+xT5fzionrK5ZsvWQ9Nup1JaBjhh/Vojc7gpLjUKiKUV62NkoDxFzT1VmQxkdKCgHNvYxjZM9Zu0E4XGy1gxFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G1pzWbuO; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757772035; x=1789308035;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nEomdwrY0x+N627biNdsd37XgirP9L8af7tXqvHXYeA=;
  b=G1pzWbuOkiBHEwXS1vvT/zxIez4yjdDWF0NYKSZfhe8uV5x9TszoSIXN
   RgVmmf+EGw6MlwsFGXi/3rYLY8FFeAknxFd5EhMp2k0TF+RxfvZ6gTFI9
   MQCcM2MWL9ZiSfSjdSkh1/UY9FOr++oSv5OLACgr8rtpx7tnZy0SuSjRI
   u/lFhJZb1O/7RWTDRZazXfwzYNHw678pSRin4Feeel/RcfWa6fRYsVuom
   mP6VGltlyJGEwj9ha8nX818B6LrO22eTcJ7wBZOhQnBstKK/rFO/IADHy
   C/8UETZdoAnmE9W4Y65WV1d7d4gRjIDi7cEKYT1hIPSZHsEf4MnZUfz+q
   w==;
X-CSE-ConnectionGUID: nfjO0sC9QxuG//SAP8jRjA==
X-CSE-MsgGUID: ykXcZAqjQcWD+Jy3xHN8jQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11552"; a="62724445"
X-IronPort-AV: E=Sophos;i="6.18,261,1751266800"; 
   d="scan'208";a="62724445"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2025 07:00:34 -0700
X-CSE-ConnectionGUID: 7vC6pctMTCy6XcykPzGg9g==
X-CSE-MsgGUID: 4u37J0pkR22bZhtFWu/Yjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,261,1751266800"; 
   d="scan'208";a="174151474"
Received: from igk-lkp-server01.igk.intel.com (HELO 0e586ad5e7f7) ([10.91.175.65])
  by fmviesa006.fm.intel.com with ESMTP; 13 Sep 2025 07:00:32 -0700
Received: from kbuild by 0e586ad5e7f7 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1uxQnm-000000001dh-0Kc5;
	Sat, 13 Sep 2025 14:00:30 +0000
Date: Sat, 13 Sep 2025 16:00:27 +0200
From: kernel test robot <lkp@intel.com>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Alice Ryhl <aliceryhl@google.com>, Benno Lossin <lossin@kernel.org>,
	Elle Rhumsaa <elle@weathered-steel.dev>
Subject: [tip:locking/core 1/13] error[E0425]: cannot find function
 `atomic_add` in crate `bindings`
Message-ID: <202509131610.IPwv7fy3-lkp@intel.com>
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
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20250913/202509131610.IPwv7fy3-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250913/202509131610.IPwv7fy3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509131610.IPwv7fy3-lkp@intel.com/

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

