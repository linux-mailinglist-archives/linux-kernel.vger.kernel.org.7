Return-Path: <linux-kernel+bounces-813458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A40B545B6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5079AA4D59
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 08:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1A42D73AB;
	Fri, 12 Sep 2025 08:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hQB7FqmP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7D62D24AA;
	Fri, 12 Sep 2025 08:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757666503; cv=none; b=obkjLli9EinZMWx+EeyEbIF+Iml/MOieabf5mftDKruhtd9gPI3m4c0stiWsT1yFci7ZE0F9Q4iKwzNbHpBuNo5KI1Kdws7gaQMVeP3MvDLGj8vq3bd6CJDwYdaG0U6k1g1G2cRO/i6OOw6aIu6vVuPiqtmDD1A3pDkgp5zwjak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757666503; c=relaxed/simple;
	bh=s5L8KoQhFU2ZA3F7R+EwAJEVzdr9sPoSaPCLEf7lhGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MfD7os0I9ahn9Kmw3BKrVBtFJ7wRunhNRoZTfCkmIgFSTyXurogSWdSJJExMIu8EMjmx13/XsLHPRwdry+0sy63sT5ekoqhHvhhqo02IJXnC6gy9L92VuZMIvSj2QSv3mT7Ci20K7UJrpnh6hA47RgCY2JXSnnKbX4kjEQojUOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hQB7FqmP; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757666500; x=1789202500;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=s5L8KoQhFU2ZA3F7R+EwAJEVzdr9sPoSaPCLEf7lhGk=;
  b=hQB7FqmPMhuHUGGbhEYs0/+FNK/NDBx25CE9+C4rg6I2KmIGveSUCyS3
   dXMbkvmRd6AYCa4RcX3TijAoOCZbCWjI3ZAMwAmYOapUnfFZeUzp59bS/
   fvTwyL98rn4dfiLzLmY62BKyNM6sCFLpPJY1qNMlFJvsEUfw4n2zjXOUa
   zqaSq+yOvUo2xQggpSAloQujm+egzaTAAG5LMhsHGaxAb111jh+MVmEb0
   ysjeQ7l/fjUyeDHLZC5pQ6wepi/+442CEXjdgdTddyl97O5gcoouD9JVm
   GgchqWPOJW0QJFsOi6AuethRTLJKgfDBnzgFm1Bhd4uyvSbLa6d23uYPJ
   Q==;
X-CSE-ConnectionGUID: o7x5RBJTSRWN4/rqtHDlzQ==
X-CSE-MsgGUID: N+X2FXp+TZyde2IToSnijQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11550"; a="71383688"
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="71383688"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 01:41:39 -0700
X-CSE-ConnectionGUID: j6s540COTtGz3/1djA5P9A==
X-CSE-MsgGUID: zAsxY1E6RuKF6m59R8TUcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="173825302"
Received: from lkp-server02.sh.intel.com (HELO eb5fdfb2a9b7) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 12 Sep 2025 01:41:35 -0700
Received: from kbuild by eb5fdfb2a9b7 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uwzLY-0000vY-24;
	Fri, 12 Sep 2025 08:41:32 +0000
Date: Fri, 12 Sep 2025 16:41:14 +0800
From: kernel test robot <lkp@intel.com>
To: Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
	rust-for-linux@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, daniel@sedlak.dev,
	dirk.behme@de.bosch.com, felipe_life@live.com, tamird@gmail.com,
	dakr@kernel.org, tmgross@umich.edu, aliceryhl@google.com,
	a.hindborg@kernel.org, lossin@kernel.org, bjorn3_gh@protonmail.com,
	gary@garyguo.net, boqun.feng@gmail.com, alex.gaynor@gmail.com,
	ojeda@kernel.org,
	Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>
Subject: Re: [PATCH v2 1/1] rust: refactor to_result to return the original
 value
Message-ID: <202509121607.yxpZ3HBS-lkp@intel.com>
References: <20250909170013.16025-2-work@onurozkan.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909170013.16025-2-work@onurozkan.dev>

Hi Onur,

kernel test robot noticed the following build errors:

[auto build test ERROR on broonie-regulator/for-next]
[cannot apply to driver-core/driver-core-testing driver-core/driver-core-next driver-core/driver-core-linus rafael-pm/linux-next rafael-pm/bleeding-edge rust/alloc-next rust/rust-next char-misc/char-misc-testing char-misc/char-misc-next char-misc/char-misc-linus akpm-mm/mm-everything pci/next pci/for-linus rust/rust-block-next linus/master v6.17-rc5 next-20250912]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Onur-zkan/rust-refactor-to_result-to-return-the-original-value/20250910-010803
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next
patch link:    https://lore.kernel.org/r/20250909170013.16025-2-work%40onurozkan.dev
patch subject: [PATCH v2 1/1] rust: refactor to_result to return the original value
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20250912/202509121607.yxpZ3HBS-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250912/202509121607.yxpZ3HBS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509121607.yxpZ3HBS-lkp@intel.com/

All errors (new ones prefixed by >>):

>> error[E0277]: the trait bound `i32: From<()>` is not satisfied
   --> rust/kernel/configfs.rs:181:17
   |
>> 179 |             crate::error::to_result(
   |             ----------------------- required by a bound introduced by this call
   180 |                 // SAFETY: We initialized `this.subsystem` according to C API contract above.
   181 |                 unsafe { bindings::configfs_register_subsystem(this.subsystem.get()) },
   |                 ^^^^^^^^^-----------------------------------------------------------^^
   |                 |        |
   |                 |        this tail expression is of type `i32`
   |                 the trait `From<()>` is not implemented for `i32`
   |
   = help: the following other types implement trait `From<T>`:
   `i32` implements `From<CpuId>`
   `i32` implements `From<bool>`
   `i32` implements `From<i16>`
   `i32` implements `From<i8>`
   `i32` implements `From<u16>`
   `i32` implements `From<u8>`
   = note: required for `()` to implement `Into<i32>`
   = note: required for `i32` to implement `TryFrom<()>`
   = note: required for `()` to implement `TryInto<i32>`
   note: required by a bound in `error::to_result`
   --> rust/kernel/error.rs:382:15
   |
   380 | pub fn to_result<T>(code: T) -> Result<T>
   |        --------- required by a bound in this function
   381 | where
   382 |     T: Copy + TryInto<i32>,
   |               ^^^^^^^^^^^^ required by this bound in `to_result`
--
>> error[E0277]: the trait bound `i32: From<()>` is not satisfied
   --> rust/kernel/net/phy/reg.rs:122:19
   |
   122 |           to_result(unsafe {
   |  _________---------_^
   | |         |
   | |         required by a bound introduced by this call
   123 | |             bindings::mdiobus_write((*phydev).mdio.bus, (*phydev).mdio.addr, self.0.into(), val)
   | |             ------------------------------------------------------------------------------------ this tail expression is of type `i32`
   124 | |         })
   | |_________^ the trait `From<()>` is not implemented for `i32`
   |
   = help: the following other types implement trait `From<T>`:
   `i32` implements `From<CpuId>`
   `i32` implements `From<bool>`
   `i32` implements `From<i16>`
   `i32` implements `From<i8>`
   `i32` implements `From<u16>`
   `i32` implements `From<u8>`
   = note: required for `()` to implement `Into<i32>`
   = note: required for `i32` to implement `TryFrom<()>`
   = note: required for `()` to implement `TryInto<i32>`
   note: required by a bound in `error::to_result`
   --> rust/kernel/error.rs:382:15
   |
   380 | pub fn to_result<T>(code: T) -> Result<T>
   |        --------- required by a bound in this function
   381 | where
   382 |     T: Copy + TryInto<i32>,
   |               ^^^^^^^^^^^^ required by this bound in `to_result`
--
>> error[E0277]: the trait bound `i32: From<()>` is not satisfied
   --> rust/kernel/net/phy/reg.rs:211:19
   |
   211 |           to_result(unsafe {
   |  _________---------_^
   | |         |
   | |         required by a bound introduced by this call
   212 | |             bindings::phy_write_mmd(phydev, self.devad.0.into(), self.regnum.into(), val)
   | |             ----------------------------------------------------------------------------- this tail expression is of type `i32`
   213 | |         })
   | |_________^ the trait `From<()>` is not implemented for `i32`
   |
   = help: the following other types implement trait `From<T>`:
   `i32` implements `From<CpuId>`
   `i32` implements `From<bool>`
   `i32` implements `From<i16>`
   `i32` implements `From<i8>`
   `i32` implements `From<u16>`
   `i32` implements `From<u8>`
   = note: required for `()` to implement `Into<i32>`
   = note: required for `i32` to implement `TryFrom<()>`
   = note: required for `()` to implement `TryInto<i32>`
   note: required by a bound in `error::to_result`
   --> rust/kernel/error.rs:382:15
   |
   380 | pub fn to_result<T>(code: T) -> Result<T>
   |        --------- required by a bound in this function
   381 | where
   382 |     T: Copy + TryInto<i32>,
   |               ^^^^^^^^^^^^ required by this bound in `to_result`
--
>> error[E0277]: the trait bound `i32: From<()>` is not satisfied
   --> rust/kernel/net/phy.rs:219:19
   |
   219 |         to_result(unsafe { bindings::genphy_soft_reset(phydev) })
   |         --------- ^^^^^^^^^-----------------------------------^^
   |         |         |        |
   |         |         |        this tail expression is of type `i32`
   |         |         the trait `From<()>` is not implemented for `i32`
   |         required by a bound introduced by this call
   |
   = help: the following other types implement trait `From<T>`:
   `i32` implements `From<CpuId>`
   `i32` implements `From<bool>`
   `i32` implements `From<i16>`
   `i32` implements `From<i8>`
   `i32` implements `From<u16>`
   `i32` implements `From<u8>`
   = note: required for `()` to implement `Into<i32>`
   = note: required for `i32` to implement `TryFrom<()>`
   = note: required for `()` to implement `TryInto<i32>`
   note: required by a bound in `error::to_result`
   --> rust/kernel/error.rs:382:15
   |
   380 | pub fn to_result<T>(code: T) -> Result<T>
   |        --------- required by a bound in this function
   381 | where
   382 |     T: Copy + TryInto<i32>,
   |               ^^^^^^^^^^^^ required by this bound in `to_result`
--
>> error[E0277]: the trait bound `i32: From<()>` is not satisfied
   --> rust/kernel/net/phy.rs:227:19
   |
   227 |         to_result(unsafe { bindings::phy_init_hw(phydev) })
   |         --------- ^^^^^^^^^-----------------------------^^
   |         |         |        |
   |         |         |        this tail expression is of type `i32`
   |         |         the trait `From<()>` is not implemented for `i32`
   |         required by a bound introduced by this call
   |
   = help: the following other types implement trait `From<T>`:
   `i32` implements `From<CpuId>`
   `i32` implements `From<bool>`
   `i32` implements `From<i16>`
   `i32` implements `From<i8>`
   `i32` implements `From<u16>`
   `i32` implements `From<u8>`
   = note: required for `()` to implement `Into<i32>`
   = note: required for `i32` to implement `TryFrom<()>`
   = note: required for `()` to implement `TryInto<i32>`
   note: required by a bound in `error::to_result`
   --> rust/kernel/error.rs:382:15
   |
   380 | pub fn to_result<T>(code: T) -> Result<T>
   |        --------- required by a bound in this function
   381 | where
   382 |     T: Copy + TryInto<i32>,
   |               ^^^^^^^^^^^^ required by this bound in `to_result`
--
>> error[E0277]: the trait bound `i32: From<()>` is not satisfied
   --> rust/kernel/net/phy.rs:235:19
   |
   235 |         to_result(unsafe { bindings::_phy_start_aneg(phydev) })
   |         --------- ^^^^^^^^^---------------------------------^^
   |         |         |        |
   |         |         |        this tail expression is of type `i32`
   |         |         the trait `From<()>` is not implemented for `i32`
   |         required by a bound introduced by this call
   |
   = help: the following other types implement trait `From<T>`:
   `i32` implements `From<CpuId>`
   `i32` implements `From<bool>`
   `i32` implements `From<i16>`
   `i32` implements `From<i8>`
   `i32` implements `From<u16>`
   `i32` implements `From<u8>`
   = note: required for `()` to implement `Into<i32>`
   = note: required for `i32` to implement `TryFrom<()>`
   = note: required for `()` to implement `TryInto<i32>`
   note: required by a bound in `error::to_result`
   --> rust/kernel/error.rs:382:15
   |
   380 | pub fn to_result<T>(code: T) -> Result<T>
   |        --------- required by a bound in this function
   381 | where
   382 |     T: Copy + TryInto<i32>,
   |               ^^^^^^^^^^^^ required by this bound in `to_result`
--
>> error[E0277]: the trait bound `i32: From<()>` is not satisfied
   --> rust/kernel/net/phy.rs:243:19
   |
   243 |         to_result(unsafe { bindings::genphy_resume(phydev) })
   |         --------- ^^^^^^^^^-------------------------------^^
   |         |         |        |
   |         |         |        this tail expression is of type `i32`
   |         |         the trait `From<()>` is not implemented for `i32`
   |         required by a bound introduced by this call
   |
   = help: the following other types implement trait `From<T>`:
   `i32` implements `From<CpuId>`
   `i32` implements `From<bool>`
   `i32` implements `From<i16>`
   `i32` implements `From<i8>`
   `i32` implements `From<u16>`
   `i32` implements `From<u8>`
   = note: required for `()` to implement `Into<i32>`
   = note: required for `i32` to implement `TryFrom<()>`
   = note: required for `()` to implement `TryInto<i32>`
   note: required by a bound in `error::to_result`
   --> rust/kernel/error.rs:382:15
   |
   380 | pub fn to_result<T>(code: T) -> Result<T>
   |        --------- required by a bound in this function
   381 | where
   382 |     T: Copy + TryInto<i32>,
   |               ^^^^^^^^^^^^ required by this bound in `to_result`
--
>> error[E0277]: the trait bound `i32: From<()>` is not satisfied
   --> rust/kernel/net/phy.rs:251:19
   |
   251 |         to_result(unsafe { bindings::genphy_suspend(phydev) })
   |         --------- ^^^^^^^^^--------------------------------^^
   |         |         |        |
   |         |         |        this tail expression is of type `i32`
   |         |         the trait `From<()>` is not implemented for `i32`
   |         required by a bound introduced by this call
   |
   = help: the following other types implement trait `From<T>`:
   `i32` implements `From<CpuId>`
   `i32` implements `From<bool>`
   `i32` implements `From<i16>`
   `i32` implements `From<i8>`
   `i32` implements `From<u16>`
   `i32` implements `From<u8>`
   = note: required for `()` to implement `Into<i32>`
   = note: required for `i32` to implement `TryFrom<()>`
   = note: required for `()` to implement `TryInto<i32>`
   note: required by a bound in `error::to_result`
   --> rust/kernel/error.rs:382:15
   |
   380 | pub fn to_result<T>(code: T) -> Result<T>
   |        --------- required by a bound in this function
   381 | where
   382 |     T: Copy + TryInto<i32>,
   |               ^^^^^^^^^^^^ required by this bound in `to_result`
--
>> error[E0277]: the trait bound `i32: From<()>` is not satisfied
   --> rust/kernel/net/phy.rs:264:19
   |
   264 |         to_result(unsafe { bindings::genphy_update_link(phydev) })
   |         --------- ^^^^^^^^^------------------------------------^^
   |         |         |        |
   |         |         |        this tail expression is of type `i32`
   |         |         the trait `From<()>` is not implemented for `i32`
   |         required by a bound introduced by this call
   |
   = help: the following other types implement trait `From<T>`:
   `i32` implements `From<CpuId>`
   `i32` implements `From<bool>`
   `i32` implements `From<i16>`
   `i32` implements `From<i8>`
   `i32` implements `From<u16>`
   `i32` implements `From<u8>`
   = note: required for `()` to implement `Into<i32>`
   = note: required for `i32` to implement `TryFrom<()>`
   = note: required for `()` to implement `TryInto<i32>`
   note: required by a bound in `error::to_result`
   --> rust/kernel/error.rs:382:15
   |
   380 | pub fn to_result<T>(code: T) -> Result<T>
   |        --------- required by a bound in this function
   381 | where
   382 |     T: Copy + TryInto<i32>,
   |               ^^^^^^^^^^^^ required by this bound in `to_result`
--
>> error[E0277]: the trait bound `i32: From<()>` is not satisfied
   --> rust/kernel/net/phy.rs:272:19
   |
   272 |         to_result(unsafe { bindings::genphy_read_lpa(phydev) })
   |         --------- ^^^^^^^^^---------------------------------^^
   |         |         |        |
   |         |         |        this tail expression is of type `i32`
   |         |         the trait `From<()>` is not implemented for `i32`
   |         required by a bound introduced by this call
   |
   = help: the following other types implement trait `From<T>`:
   `i32` implements `From<CpuId>`
   `i32` implements `From<bool>`
   `i32` implements `From<i16>`
   `i32` implements `From<i8>`
   `i32` implements `From<u16>`
   `i32` implements `From<u8>`
   = note: required for `()` to implement `Into<i32>`
   = note: required for `i32` to implement `TryFrom<()>`
   = note: required for `()` to implement `TryInto<i32>`
   note: required by a bound in `error::to_result`
   --> rust/kernel/error.rs:382:15
   |
   380 | pub fn to_result<T>(code: T) -> Result<T>
   |        --------- required by a bound in this function
   381 | where
   382 |     T: Copy + TryInto<i32>,
   |               ^^^^^^^^^^^^ required by this bound in `to_result`
--
>> error[E0277]: the trait bound `i32: From<()>` is not satisfied
   --> rust/kernel/net/phy.rs:280:19
   |
   280 |         to_result(unsafe { bindings::genphy_read_abilities(phydev) })
   |         --------- ^^^^^^^^^---------------------------------------^^
   |         |         |        |
   |         |         |        this tail expression is of type `i32`
   |         |         the trait `From<()>` is not implemented for `i32`
   |         required by a bound introduced by this call
   |
   = help: the following other types implement trait `From<T>`:
   `i32` implements `From<CpuId>`
   `i32` implements `From<bool>`
   `i32` implements `From<i16>`
   `i32` implements `From<i8>`
   `i32` implements `From<u16>`
   `i32` implements `From<u8>`
   = note: required for `()` to implement `Into<i32>`
   = note: required for `i32` to implement `TryFrom<()>`
   = note: required for `()` to implement `TryInto<i32>`
   note: required by a bound in `error::to_result`
   --> rust/kernel/error.rs:382:15
   |
   380 | pub fn to_result<T>(code: T) -> Result<T>
   |        --------- required by a bound in this function
   381 | where
   382 |     T: Copy + TryInto<i32>,
   |               ^^^^^^^^^^^^ required by this bound in `to_result`
..

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

