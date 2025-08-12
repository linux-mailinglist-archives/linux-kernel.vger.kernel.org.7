Return-Path: <linux-kernel+bounces-765157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A70B22C4A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 17:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7026B62402A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02652F7473;
	Tue, 12 Aug 2025 15:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W3qr45cZ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B952F8BF5;
	Tue, 12 Aug 2025 15:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755013972; cv=none; b=cBJw/fEixrU6LFnwUQQBp/hr/ABS2IGyLmlwYT0AbRG8XN7ZFP42QENCV1eQeZ0odg9vmClv2WaBrKHM3Kl6em/OE0VlOueH2bDje5EyhfDwl9NkDjk2olDGzDlPtu6SlCtDFX8WWFhCjmZjLMlSwg8tiQoCEhvtwMTVOkYKYW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755013972; c=relaxed/simple;
	bh=xGqRUdnbzPC+ihtI7x1CKaRb+bb/xRHekZu9g4Xe/HU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZBSWgdDuXL7eSIcqLss0KI0Zh66uCsA18vxIcAs30KRSFLHdhB00tNHo7ccgsJljOIoZ/OEicwbNR6Ji/Tu/nEtLsdA0WvsaAbhXEyN5C/Sy3a74sDWVcFxOQ63oSWHrqOsz32FGcvY+qF3hUP8UEcSimVovDxEQYKs7UlQbxiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W3qr45cZ; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755013970; x=1786549970;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xGqRUdnbzPC+ihtI7x1CKaRb+bb/xRHekZu9g4Xe/HU=;
  b=W3qr45cZt+XTIzsSuTquVJ2sLeT8YtZkSJehEYO4ob7WDhE/2zUbH6VZ
   phJHgz6cK8ucgPJKvH3jO1YU+gnwSjQAaC8bdFck7xHH1nwYhLO6y4KtV
   S947u/nNGs2KNO951XgtO/6oT27JIZZpDvD26u+qlzStxqqIew3iwEjDn
   i6PYye1MkVBKZkGplz+IXA/sIcQqNkZAh0hnelSLhRseWZb3CzOikcIOI
   XiZL+hX97qVniXPnctSdJiMB33hwK+xzhMghUw1y4QvdnhCVMBl/2UkID
   YtZPiRRyD36PEuU2eVFY7L93FwW+kgn88FWpdSt4jIdaN0nxqR0uyRmmy
   w==;
X-CSE-ConnectionGUID: j5lM1hjyR2mh1T9IFvE+nA==
X-CSE-MsgGUID: q7frcN9mT+Gk2R+pxZ5uOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="57214438"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="57214438"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 08:52:49 -0700
X-CSE-ConnectionGUID: 0bsw4FC6RT6UhF2rBBn1Xw==
X-CSE-MsgGUID: V+pW2tW4R/SxfVbWnVAIWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="165862736"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 12 Aug 2025 08:52:46 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ulrIp-0006wd-2S;
	Tue, 12 Aug 2025 15:52:43 +0000
Date: Tue, 12 Aug 2025 23:52:11 +0800
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
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v4] rust: kernel: introduce `unsafe_precondition_assert!`
 macro
Message-ID: <202508122341.rb7U1Q2P-lkp@intel.com>
References: <20250808192005.209188-1-ritvikfoss@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808192005.209188-1-ritvikfoss@gmail.com>

Hi Ritvik,

kernel test robot noticed the following build errors:

[auto build test ERROR on 37816488247ddddbc3de113c78c83572274b1e2e]

url:    https://github.com/intel-lab-lkp/linux/commits/Ritvik-Gupta/rust-kernel-introduce-unsafe_precondition_assert-macro/20250809-032122
base:   37816488247ddddbc3de113c78c83572274b1e2e
patch link:    https://lore.kernel.org/r/20250808192005.209188-1-ritvikfoss%40gmail.com
patch subject: [PATCH v4] rust: kernel: introduce `unsafe_precondition_assert!` macro
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20250812/202508122341.rb7U1Q2P-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250812/202508122341.rb7U1Q2P-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508122341.rb7U1Q2P-lkp@intel.com/

All errors (new ones prefixed by >>):

>> error[E0423]: cannot initialize a tuple struct which contains private fields
   --> rust/doctests_kernel_generated.rs:8841:5
   |
   8841 |     CpuId(id)
   |     ^^^^^
   |
   note: constructor is not visible here due to private fields
   --> rust/kernel/cpu.rs:47:18
   |
   47   | pub struct CpuId(u32);
   |                  ^^^ private field
   help: you might have meant to use an associated function to build this type
   |
   8841 -     CpuId(id)
   8841 +     CpuId::from_i32_unchecked(_)
   |
   8841 -     CpuId(id)
   8841 +     CpuId::from_u32_unchecked(_)
   |
   8841 -     CpuId(id)
   8841 +     CpuId::current()
   |

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

