Return-Path: <linux-kernel+bounces-755777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C04B1ABAA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 02:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95B151802DA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 00:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BBFC7262E;
	Tue,  5 Aug 2025 00:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="byfDP6Sz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885CE11185;
	Tue,  5 Aug 2025 00:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754353140; cv=none; b=UP8Qb6zook87QIuC56i9U93pPOgUU/K+z85jc2klpgBC2X24V8DlIUpJlvJE9yIaPp32/cYw75yGSJu5B9AFZcWZq9vdXaFqh3aw7uRa0O1Df8Nh27Yu92j/pzmqbur794NfoZ2xO+4nmPbUHPMmrWW4j48MKnymnmfx8T+gghM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754353140; c=relaxed/simple;
	bh=gmEU2CGm3iuP8hhTI8f0tjLRE4Zc8lBtOMemYgAqxsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GrEQlLfL0WU+H4wmHnt+pz6sjxEcmOKJ60+MiB/fDVW1SC3nIrjuTy4UsBaAkwOOrxucF7uAmhfvNS1g7hG0Ijdqy3Uw23rpRCzt4kLpbSY6dEETrlthiaEv8eJr++slSaClu1vnOCTxAgp9IMtJmKqfi29jBugjdikKbq0Fh3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=byfDP6Sz; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754353139; x=1785889139;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gmEU2CGm3iuP8hhTI8f0tjLRE4Zc8lBtOMemYgAqxsg=;
  b=byfDP6SzhN4DNjn7GQzJQBxbsOyq/OYFXXKMiRHGJ/Vrg20SxPYfvsEr
   HFgciNVeu1ldq+hmZ3VmcsvXkLiyzqU06N8ZXpN1nsquS5RmxcDXhXxnL
   L0jgtozP4i+YQlkVydJdcT4JgvPJrQF/A+B4tAk5BYeR+wGRkWrFLMxyM
   izPcSI7LKVusVKT6+43CH+CcAVjgDfebuKv8pWr3tjx40b4vb8W8BQEyk
   iZPd9tVE7u/W60M4MtnGHkIJWr9ZnTm36YwaX2BTWrmLfKPV5yd2md3L2
   Oimyg47HIANeqGDFH8UGEp9OcVa7tnpSc4dt0zYtFqjbc7xRVo4QuvwYJ
   Q==;
X-CSE-ConnectionGUID: mObhx2u6TP6YTXQ+B4pB1w==
X-CSE-MsgGUID: T9s5FfkUSp+NHtoRygOboQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11512"; a="79185744"
X-IronPort-AV: E=Sophos;i="6.17,265,1747724400"; 
   d="scan'208";a="79185744"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 17:18:58 -0700
X-CSE-ConnectionGUID: e6erJoSQQ22WLS7fPA1xew==
X-CSE-MsgGUID: kNcGp7GzQG6xim+mMUVKaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,265,1747724400"; 
   d="scan'208";a="195144498"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 04 Aug 2025 17:18:53 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uj5OD-0000Kt-2T;
	Tue, 05 Aug 2025 00:18:49 +0000
Date: Tue, 5 Aug 2025 08:17:51 +0800
From: kernel test robot <lkp@intel.com>
To: Ritvik Gupta <ritvikfoss@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v3] rust: kernel: introduce `unsafe_precondition_assert!`
 macro
Message-ID: <202508050756.oFg4cjPu-lkp@intel.com>
References: <20250731111234.28602-1-ritvikfoss@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731111234.28602-1-ritvikfoss@gmail.com>

Hi Ritvik,

kernel test robot noticed the following build errors:

[auto build test ERROR on dff64b072708ffef23c117fa1ee1ea59eb417807]

url:    https://github.com/intel-lab-lkp/linux/commits/Ritvik-Gupta/rust-kernel-introduce-unsafe_precondition_assert-macro/20250731-191444
base:   dff64b072708ffef23c117fa1ee1ea59eb417807
patch link:    https://lore.kernel.org/r/20250731111234.28602-1-ritvikfoss%40gmail.com
patch subject: [PATCH v3] rust: kernel: introduce `unsafe_precondition_assert!` macro
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20250805/202508050756.oFg4cjPu-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250805/202508050756.oFg4cjPu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508050756.oFg4cjPu-lkp@intel.com/

All errors (new ones prefixed by >>):

>> error: cannot find macro `unsafe_precondition_assert` in this scope
   --> rust/doctests_kernel_generated.rs:8012:5
   |
   8012 |     unsafe_precondition_assert!(!buf.is_null(), "buf must not be null");
   |     ^^^^^^^^^^^^^^^^^^^^^^^^^^
   |
   ::: /opt/cross/rustc-1.88.0-bindgen-0.72.0/rustup/toolchains/1.88.0-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/library/core/src/ub_checks.rs:52:1
   |
   52   | macro_rules! assert_unsafe_precondition {
   | --------------------------------------- similarly named macro `assert_unsafe_precondition` defined here
   |
   help: a macro with a similar name exists
   |
   8012 -     unsafe_precondition_assert!(!buf.is_null(), "buf must not be null");
   8012 +     assert_unsafe_precondition!(!buf.is_null(), "buf must not be null");
   |
   help: consider importing this macro
   |
   3    + use kernel::unsafe_precondition_assert;
   |
--
>> error: cannot find macro `unsafe_precondition_assert` in this scope
   --> rust/doctests_kernel_generated.rs:8013:5
   |
   8013 |     unsafe_precondition_assert!((buf as usize) % 16 == 0, "buf must be 16-byte aligned");
   |     ^^^^^^^^^^^^^^^^^^^^^^^^^^
   |
   ::: /opt/cross/rustc-1.88.0-bindgen-0.72.0/rustup/toolchains/1.88.0-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/library/core/src/ub_checks.rs:52:1
   |
   52   | macro_rules! assert_unsafe_precondition {
   | --------------------------------------- similarly named macro `assert_unsafe_precondition` defined here
   |
   help: a macro with a similar name exists
   |
   8013 -     unsafe_precondition_assert!((buf as usize) % 16 == 0, "buf must be 16-byte aligned");
   8013 +     assert_unsafe_precondition!((buf as usize) % 16 == 0, "buf must be 16-byte aligned");
   |
   help: consider importing this macro
   |
   3    + use kernel::unsafe_precondition_assert;
   |
--
>> error: cannot find macro `unsafe_precondition_assert` in this scope
   --> rust/doctests_kernel_generated.rs:8014:5
   |
   8014 |     unsafe_precondition_assert!(
   |     ^^^^^^^^^^^^^^^^^^^^^^^^^^
   |
   ::: /opt/cross/rustc-1.88.0-bindgen-0.72.0/rustup/toolchains/1.88.0-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/library/core/src/ub_checks.rs:52:1
   |
   52   | macro_rules! assert_unsafe_precondition {
   | --------------------------------------- similarly named macro `assert_unsafe_precondition` defined here
   |
   help: a macro with a similar name exists
   |
   8014 -     unsafe_precondition_assert!(
   8014 +     assert_unsafe_precondition!(
   |
   help: consider importing this macro
   |
   3    + use kernel::unsafe_precondition_assert;
   |

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

