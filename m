Return-Path: <linux-kernel+bounces-738706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF1DB0BC23
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 07:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA6771899361
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 05:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F151218E9F;
	Mon, 21 Jul 2025 05:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JZBo67Il"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2DB142E67;
	Mon, 21 Jul 2025 05:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753077284; cv=none; b=OXTt59dRvwS2tVD3gmB/kIqlZ9nSqpTPTwWX0cerSqwE6B0JNeVMqvnzWAFQflkPUg6nAACh48fwDvkEyREKscTpvBICyqB7jTmFjfmx9hdPbnSPE2IzZNAbw8XjDEboT61dc4drcLRvDCJIxvmOlDYZZdbT06Xm/7V6zcptkA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753077284; c=relaxed/simple;
	bh=2afK1CH5WnQZWgkGs3NYU8/AgC/IpRnXT8a0xNhCXEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t0q7T81c5jP8kDc3h3MCuIFktkDNoqD3tctnNSFY4ca3CZNwgD2vgp5AIvjC5CVEb3IkYt103MlZRxKrT7SCJ9ddydsJty0M2WEtDkLHY7euuxNGeWnTUZbmnZItyigkMpid/beF2udeUF0JBuvpBedUkBgYpVEf85VmOLSSkxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JZBo67Il; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753077283; x=1784613283;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2afK1CH5WnQZWgkGs3NYU8/AgC/IpRnXT8a0xNhCXEo=;
  b=JZBo67IlUBC6XFkC1j0OA3fm6TtBSIR0pH3KU40sKhpUrZOgdTBVQ3VN
   6WVtEsMIufo/mzSHEOyqGQC9i7viyZ0QX7kZAEZrr1gbY3zQnHDfE42NL
   uZLd39akXZmMN5vAaW8mtRLR35eqXeSNNkQT+RYk7bTH1npZIasniBE9V
   4hCx9B2YdDfoX5W7UfxpBQt+AjKqN6TeEER1pgup9la483vBRJ3gkKXzy
   pM1ozQtZgS0iTu9jmxPqwH9MJNEHN6hbDAbMLj3cvssauXSw8wmXQo/7Y
   AUndCd4PX232boXRKEW2D9MrNFoeeAtutctV/gU31cyKcBZiLVlK3NdFn
   Q==;
X-CSE-ConnectionGUID: WZKSbji+TJ+iSGZwHa0Jag==
X-CSE-MsgGUID: bGDfcpsvRmWplGLFYDohEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11498"; a="59074323"
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="59074323"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2025 22:54:43 -0700
X-CSE-ConnectionGUID: KSKLZ4HHQZS+P5WPXVHcvg==
X-CSE-MsgGUID: nIx7VcZxQbykuO627Y0SPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="158862613"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 20 Jul 2025 22:54:39 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1udjTw-000GWH-2p;
	Mon, 21 Jul 2025 05:54:36 +0000
Date: Mon, 21 Jul 2025 13:54:13 +0800
From: kernel test robot <lkp@intel.com>
To: Tamir Duberstein <tamird@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	Tamir Duberstein <tamird@gmail.com>
Subject: Re: [PATCH v3] rust: remove spurious compiler_builtins dependents
Message-ID: <202507211312.M1fkG8v8-lkp@intel.com>
References: <20250720-rust-remove-compiler-builtins-deps-v3-1-0df3a493973f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250720-rust-remove-compiler-builtins-deps-v3-1-0df3a493973f@gmail.com>

Hi Tamir,

kernel test robot noticed the following build errors:

[auto build test ERROR on cc84ef3b88f407e8bd5a5f7b6906d1e69851c856]

url:    https://github.com/intel-lab-lkp/linux/commits/Tamir-Duberstein/rust-remove-spurious-compiler_builtins-dependents/20250721-012236
base:   cc84ef3b88f407e8bd5a5f7b6906d1e69851c856
patch link:    https://lore.kernel.org/r/20250720-rust-remove-compiler-builtins-deps-v3-1-0df3a493973f%40gmail.com
patch subject: [PATCH v3] rust: remove spurious compiler_builtins dependents
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20250721/202507211312.M1fkG8v8-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250721/202507211312.M1fkG8v8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507211312.M1fkG8v8-lkp@intel.com/

All errors (new ones prefixed by >>):

>> error[E0463]: can't find crate for `core`
   |
   = note: the `target` target may not be installed
   = help: consider downloading the target with `rustup target add target`
   = help: consider building the standard library from source with `cargo build -Zbuild-std`
--
   For more information about this error, try `rustc --explain E0463`.
   make[3]: *** [rust/Makefile:514: rust/build_error.o] Error 1
>> error[E0463]: can't find crate for `core`
   |
   = note: the `target` target may not be installed
   = help: consider downloading the target with `rustup target add target`
   = help: consider building the standard library from source with `cargo build -Zbuild-std`
--
   For more information about this error, try `rustc --explain E0463`.
   make[3]: *** [rust/Makefile:518: rust/ffi.o] Error 1
>> error[E0463]: can't find crate for `core`
   |
   = note: the `target` target may not be installed
   = help: consider downloading the target with `rustup target add target`
   = help: consider building the standard library from source with `cargo build -Zbuild-std`

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

