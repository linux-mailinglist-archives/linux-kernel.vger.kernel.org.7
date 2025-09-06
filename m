Return-Path: <linux-kernel+bounces-804285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A46B47032
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 16:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4580D1BC61C0
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 14:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CEC1DB546;
	Sat,  6 Sep 2025 14:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q8P9P2pT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DDF19E7F9;
	Sat,  6 Sep 2025 14:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757168632; cv=none; b=XzMkpKQfAlMj9rFqzImGgp+JUaOSoATBCgszVBIsyfle99WdrJ21q0jsZ/+u2FfmEfveOLrqvDO8U7OokU9QoAA7Jqlugs3F7snzCrBOUDbp6m/Q4v/Ft6JzzVyT8jw4T3trcJdXXvDgIYz/URObpjcpK3GquzRniAlaPqp+zfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757168632; c=relaxed/simple;
	bh=Ww9/g/RikH15RvIFCODDHkVdpfqdWwNe4n4hWG660hM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JJkFFqkRrpMG2Dd0Oz+iEeIDhW8fq2ivMaAqrFvNp/i3S6W9+JT0eziPaDeoexYAK5v8KQMd2iBH/i5kRP7vC7NEX4I7AnKzfMtNkbj0MKyu93a1nwrbm2xhkW0dErZx2T3Z/Ckp3NmFqEFQX8tvXPHQJYroQqI4Kgc8qN6v1rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q8P9P2pT; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757168631; x=1788704631;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ww9/g/RikH15RvIFCODDHkVdpfqdWwNe4n4hWG660hM=;
  b=Q8P9P2pTyQPf/2+R+klaufXlRGRSaUm8qgHmjcoG9HYv2ow0u5T3QQWM
   URj2n34mjP+HEyaX01C7zGt+D9xfPBt4AW7UqLbvJPSRLThpwiLJ5EEk/
   oATFs6gfvho5huiTadYBLrAf2wflfia/EtNcywKMtJ98cMTsyXcIONsix
   lR8mvKRzUq/749WLvylWKgpoyOVs+Db4PpryVZ2VQZ2KNj6cLHTsHjkbO
   o1ISyhHpmCQLWkVKM5o4ahd8kuYi5r+CgEkMv5s+H8s9Zwh5BjGGsE5cq
   4i8ksidBGo1jNPUqTFB9c00CWQcVT6/AMF7UlhSWZVE9ozuOugHneMOda
   A==;
X-CSE-ConnectionGUID: 6FyIqjZSQV+Xx0xP+JVoyw==
X-CSE-MsgGUID: qPrplt6NT+G660JK1uJqhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11544"; a="77106456"
X-IronPort-AV: E=Sophos;i="6.18,244,1751266800"; 
   d="scan'208";a="77106456"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2025 07:23:50 -0700
X-CSE-ConnectionGUID: i2hIG7cwT0+aq5nj4jkT+w==
X-CSE-MsgGUID: BsLZPeCiTX6FXTz1SsLAdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,244,1751266800"; 
   d="scan'208";a="196054538"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 06 Sep 2025 07:23:46 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uutpQ-0001X9-0E;
	Sat, 06 Sep 2025 14:23:44 +0000
Date: Sat, 6 Sep 2025 22:23:15 +0800
From: kernel test robot <lkp@intel.com>
To: Benno Lossin <lossin@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, Fiona Behrens <me@kloenk.dev>,
	Alban Kurti <kurti@invicto.ai>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: pin-init: add references to previously initialized
 fields
Message-ID: <202509062218.Mo9Wsmcd-lkp@intel.com>
References: <20250905140047.3325945-1-lossin@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905140047.3325945-1-lossin@kernel.org>

Hi Benno,

kernel test robot noticed the following build errors:

[auto build test ERROR on 8f5ae30d69d7543eee0d70083daf4de8fe15d585]

url:    https://github.com/intel-lab-lkp/linux/commits/Benno-Lossin/rust-pin-init-add-references-to-previously-initialized-fields/20250905-220242
base:   8f5ae30d69d7543eee0d70083daf4de8fe15d585
patch link:    https://lore.kernel.org/r/20250905140047.3325945-1-lossin%40kernel.org
patch subject: [PATCH] rust: pin-init: add references to previously initialized fields
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20250906/202509062218.Mo9Wsmcd-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250906/202509062218.Mo9Wsmcd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509062218.Mo9Wsmcd-lkp@intel.com/

All errors (new ones prefixed by >>):

>> error[E0308]: mismatched types
   --> rust/kernel/devres.rs:154:66
   |
   154 |                     bindings::devm_add_action(dev.as_raw(), Some(callback), inner.cast())
   |                                                             ---- ^^^^^^^^ expected fn pointer, found `&mut unsafe extern "C" fn(*mut c_void)`
   |                                                             |
   |                                                             arguments to this enum variant are incorrect
   |
   = note:     expected fn pointer `unsafe extern "C" fn(_)`
   found mutable reference `&mut unsafe extern "C" fn(_)`
   help: the type constructed contains `&mut unsafe extern "C" fn(*mut ffi::c_void)` due to the type of the argument passed
   --> rust/kernel/devres.rs:154:61
   |
   154 |                     bindings::devm_add_action(dev.as_raw(), Some(callback), inner.cast())
   |                                                             ^^^^^--------^
   |                                                                  |
   |                                                                  this argument influences the type of `Some`
   note: tuple variant defined here
   --> /opt/cross/rustc-1.88.0-bindgen-0.72.0/rustup/toolchains/1.88.0-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/library/core/src/option.rs:597:5
   |
   597 |     Some(#[stable(feature = "rust1", since = "1.0.0")] T),
   |     ^^^^
   help: consider dereferencing the borrow
   |
   154 |                     bindings::devm_add_action(dev.as_raw(), Some(*callback), inner.cast())
   |                                                                  +

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

