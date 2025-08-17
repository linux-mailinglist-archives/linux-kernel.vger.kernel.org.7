Return-Path: <linux-kernel+bounces-772356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A44F3B291AF
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 07:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CDAB485D9E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 05:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B9420D51C;
	Sun, 17 Aug 2025 05:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PZsx3Ijk"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D701D88D0;
	Sun, 17 Aug 2025 05:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755409847; cv=none; b=shY5X0htvwB+DfduJBe8mMFron2HM2/FQVkPWw5XMKGEalrTc5ihdpPifjrZ0wztWonTi2lWXpuhsKpqqLFhDRBGxopwYfpqKN5bSzt4jcbiZoANHBdWy9Xm3DzRAy/noA4LJH9FC1jyVFyfvx7bJw2OUDlnNcNZkXhuVRDjVkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755409847; c=relaxed/simple;
	bh=nyHY7omVt4L3NYX9AX1MTT90Ptj3gLdYmhit4iwSvbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mIL2Jj5sCvahmmuhIdsGAbDsB/FJXHLLlh1J2a//XgDPgjeDZ7Z1xen5uIjz1LAdjcmyG2+mzlFIdOzZkzf6zVjToU6h3OvL7eQfyGqUwTm9w2iUxpzFDkDi8xFdGhsxFCP+/KWMSJsCVntwbFHoYqgzx1MJU3OjMW89q0yULFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PZsx3Ijk; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755409846; x=1786945846;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nyHY7omVt4L3NYX9AX1MTT90Ptj3gLdYmhit4iwSvbo=;
  b=PZsx3Ijk3hhAf3EbYu6gOQahLNy1ZSIxNwRka/YhL72zmkEqqeIUZQQI
   sGmoKsHpt6Imgz8sNj231f2hPx41xfQj6zZ1ARP8CbT8jrbhFJo2/Lg57
   fnyTGN4cHU3g7ojewo8JzMRKtOm1E2SqFQ6zHZuFceTreWg4dzBi0ewA+
   vQOVdQ8u1UQ9C2884vis4MCLvnTu2HltxA0qk6yu5rtARgXkLTsLeHsUT
   xW41UQVDPAfDQRtIoxABnUlIO0b2VoSI34FfxO/Yo8VMifLpkMnVreCZv
   WQ9d9bsKoU+a5w/y69fM3vbnJQxd0dpXmtWdkx7qiGH11S3VQe6VIzqqv
   A==;
X-CSE-ConnectionGUID: waDkMputRQ+3W63kTCxlMg==
X-CSE-MsgGUID: JDU2pCKtQFCCQIca264Urg==
X-IronPort-AV: E=McAfee;i="6800,10657,11524"; a="57739989"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="57739989"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2025 22:50:45 -0700
X-CSE-ConnectionGUID: m4cyg5rXRHmnAQLPkXCxVQ==
X-CSE-MsgGUID: GN+H44+ORmSvjJ9NK+uWag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="171757046"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 16 Aug 2025 22:50:41 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1unWHt-000DNd-2i;
	Sun, 17 Aug 2025 05:50:37 +0000
Date: Sun, 17 Aug 2025 13:50:12 +0800
From: kernel test robot <lkp@intel.com>
To: Ayush Singh <ayush@beagleboard.org>,
	Jason Kridner <jkridner@beagleboard.org>,
	Deepak Khatri <lorforlinux@beagleboard.org>,
	Robert Nelson <robertcnelson@beagleboard.org>,
	Miguel Ojeda <ojeda@kernel.org>, Dhruva Gole <d-gole@ti.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Benno Lossin <lossin@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Ayush Singh <ayush@beagleboard.org>
Subject: Re: [PATCH v2 2/2] rust: kernel: of: Add overlay id abstraction
Message-ID: <202508171342.vNfvpebZ-lkp@intel.com>
References: <20250816-rust-overlay-abs-v2-2-48a2c8921df2@beagleboard.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250816-rust-overlay-abs-v2-2-48a2c8921df2@beagleboard.org>

Hi Ayush,

kernel test robot noticed the following build errors:

[auto build test ERROR on 931e46dcbc7e6035a90e9c4a27a84b660e083f0a]

url:    https://github.com/intel-lab-lkp/linux/commits/Ayush-Singh/rust-kernel-of-Add-DeviceNode-abstraction/20250816-140122
base:   931e46dcbc7e6035a90e9c4a27a84b660e083f0a
patch link:    https://lore.kernel.org/r/20250816-rust-overlay-abs-v2-2-48a2c8921df2%40beagleboard.org
patch subject: [PATCH v2 2/2] rust: kernel: of: Add overlay id abstraction
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20250817/202508171342.vNfvpebZ-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250817/202508171342.vNfvpebZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508171342.vNfvpebZ-lkp@intel.com/

All errors (new ones prefixed by >>):

>> error[E0425]: cannot find function `of_overlay_fdt_apply` in crate `bindings`
   --> rust/kernel/of.rs:95:23
   |
   95 |             bindings::of_overlay_fdt_apply(
   |                       ^^^^^^^^^^^^^^^^^^^^ not found in `bindings`
--
>> error[E0425]: cannot find function `of_overlay_remove` in crate `bindings`
   --> rust/kernel/of.rs:109:28
   |
   109 |         unsafe { bindings::of_overlay_remove(&mut self.0) };
   |                            ^^^^^^^^^^^^^^^^^ not found in `bindings`

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

