Return-Path: <linux-kernel+bounces-765733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DA0B23D94
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 03:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8180456871C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 01:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE09C136E37;
	Wed, 13 Aug 2025 01:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l2uHuSvO"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F16BA42;
	Wed, 13 Aug 2025 01:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755047248; cv=none; b=a3EU/C2N/ahhg3XkFRqJ6OQG3lm7pwnYwsyeYsdG++loUjxfD/lB/7Ytx3m1xD9W6huQ4Q5NGQ1fvfGQE+cxSPZyRnGUNbvRh9pw/IYfkZF+kuGXXUV08H4lon8kJvkFMjt09ILK5ByRj7GffuIy4yUGsYimHkAXoAM0MNEZiYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755047248; c=relaxed/simple;
	bh=YOqgCET3sgCMudSdk7vjfyd62U6KchjYeSESnAN8BC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=REu3YoQdsGSZIp26jYHbuV/idXQLCdC+CiZJrlqpSmALgCeQnzfr0QUKKPwvLBoCDFhyjGJlE2Bdv7jDdgDzZ5QA+5+NfLRKNg9cA8SUAkz7NwNhSGChvsF+86hOprzUa3Pq3LnahPp2FodPJf5fn34vZNBmTWEcCGsLk8LvhVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l2uHuSvO; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755047247; x=1786583247;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YOqgCET3sgCMudSdk7vjfyd62U6KchjYeSESnAN8BC0=;
  b=l2uHuSvOLiEnfeAuRsNBG7Zu441yDxJCNiwErVkrs1iw3Ehr+6tj+ORf
   KPqOmuKcgIxFD37Mr9cVXPTeB+VTeJKUrFxmvrysP4+EzggVbPbavlcOa
   5iS9AqHzFoX7Dv3693vO5tPvJuJXdA1AapVj50IJgmqdW5pZ6AKjtgDqM
   Y8zfz8XJJ0Pq7Kog0yCVDV4U9TaeiIMM69xuM3yNQdxGxJTThAUPXVWwm
   5H6rRvB+LT73MSYl/FXX/hFLxISfhefOKMmrAU3KFm63do0I7m3IF/HO4
   pPCO99+EYPtatFskwGgpd4/GqQkoBwPIX08pHFgBx4mLcc/dszm7NPdST
   Q==;
X-CSE-ConnectionGUID: U1V79hlUSuqD5Ex9lWGWPA==
X-CSE-MsgGUID: WxfHVP6HRayN6xcD5gKmGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="57395803"
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="57395803"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 18:07:26 -0700
X-CSE-ConnectionGUID: QqUNkE64T/KB9wIQ+rDQBg==
X-CSE-MsgGUID: rc0OWkRKTpm2ZDmsjmHVfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="170540166"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 12 Aug 2025 18:07:22 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ulzxP-0009Qi-32;
	Wed, 13 Aug 2025 01:07:12 +0000
Date: Wed, 13 Aug 2025 09:06:32 +0800
From: kernel test robot <lkp@intel.com>
To: "Christian S. Lima" <christiansantoslima21@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, ~lkcamp/patches@lists.sr.ht,
	richard120310@gmail.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v9] rust: transmute: Add methods for FromBytes trait
Message-ID: <202508130702.MtRUndHU-lkp@intel.com>
References: <20250811213851.65644-1-christiansantoslima21@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811213851.65644-1-christiansantoslima21@gmail.com>

Hi Christian,

kernel test robot noticed the following build errors:

[auto build test ERROR on rust/rust-next]
[also build test ERROR on linus/master v6.17-rc1 next-20250812]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-S-Lima/rust-transmute-Add-methods-for-FromBytes-trait/20250812-054010
base:   https://github.com/Rust-for-Linux/linux rust-next
patch link:    https://lore.kernel.org/r/20250811213851.65644-1-christiansantoslima21%40gmail.com
patch subject: [PATCH v9] rust: transmute: Add methods for FromBytes trait
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20250813/202508130702.MtRUndHU-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250813/202508130702.MtRUndHU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508130702.MtRUndHU-lkp@intel.com/

All errors (new ones prefixed by >>):

>> error[E0046]: not all trait items implemented, missing: `from_bytes`, `from_bytes_mut`
   --> rust/doctests_kernel_generated.rs:4749:1
   |
   4749 | unsafe impl kernel::transmute::FromBytes for MyStruct{};
   | ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ missing `from_bytes`, `from_bytes_mut` in implementation
   |
   = help: implement the missing item: `fn from_bytes(_: &[u8]) -> Option<&Self> { todo!() }`
   = help: implement the missing item: `fn from_bytes_mut<Self>(_: &mut [u8]) -> Option<&mut Self> where Self: AsBytes { todo!() }`
--
>> error[E0046]: not all trait items implemented, missing: `from_bytes`, `from_bytes_mut`
   --> rust/doctests_kernel_generated.rs:4814:1
   |
   4814 | unsafe impl kernel::transmute::FromBytes for MyStruct{};
   | ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ missing `from_bytes`, `from_bytes_mut` in implementation
   |
   = help: implement the missing item: `fn from_bytes(_: &[u8]) -> Option<&Self> { todo!() }`
   = help: implement the missing item: `fn from_bytes_mut<Self>(_: &mut [u8]) -> Option<&mut Self> where Self: AsBytes { todo!() }`
--
>> error[E0046]: not all trait items implemented, missing: `from_bytes`, `from_bytes_mut`
   --> samples/rust/rust_dma.rs:42:1
   |
   42 | unsafe impl kernel::transmute::FromBytes for MyStruct {}
   | ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ missing `from_bytes`, `from_bytes_mut` in implementation
   |
   = help: implement the missing item: `fn from_bytes(_: &[u8]) -> Option<&Self> { todo!() }`
   = help: implement the missing item: `fn from_bytes_mut<Self>(_: &mut [u8]) -> Option<&mut Self> where Self: AsBytes { todo!() }`

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

