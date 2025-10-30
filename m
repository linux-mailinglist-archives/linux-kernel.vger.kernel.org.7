Return-Path: <linux-kernel+bounces-878896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 143A4C21ADF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 19:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68222462EFC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81EDD36E349;
	Thu, 30 Oct 2025 18:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OzR1+CTa"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026DB36CA95;
	Thu, 30 Oct 2025 18:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761847678; cv=none; b=kyrunG6GKewXhFABqnSPippRrBpyv1xo/l3TEhjP4+L9FEeto3SmicfjvggqlC/NMbxB24JJOsXnKI6GFR8F43n03jy/LC9MC7Ku9NDRMpzj9rOEyzs5lHqFsUDBepsQZvYoG0PIPTUemIxpZTNONy8Au1Xg3v6s8A9CitmnQes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761847678; c=relaxed/simple;
	bh=iP/s4UAA9B2nPL0oz7dCcsbvxDo5KsExttoOXbiI4jw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RPfqLVaZVpzi4Nkmxy3N0e8OntPPFg8F7GVN/7DNEzQfrxGhCU/B9XDmY2sUJD4maMrl1ajk7MUqZrjNiT3dvm9rcLWrsAyx+CDi7+WqEORAa7y/W5FU1//3VNNuDpOnmXI7bo0HK4VrKR9VJo7KqNn/X/j3DDOfjMAiKzbrFyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OzR1+CTa; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761847677; x=1793383677;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iP/s4UAA9B2nPL0oz7dCcsbvxDo5KsExttoOXbiI4jw=;
  b=OzR1+CTaqF1mLQwL5NeOqUBtdVdcbuSiMYT6605CO7d83+mMLUkNTKvQ
   +cJqPyFZ19QJxpHL7w3PjaHHQzRAmTIToUkJVT/MNEpmAptjfmIpHGZ4k
   KWU3islokpTYpwOXFkhYnWimF6NATPzs2OnPV5XU7yTA4AahT3luYkBuj
   JuBqXsIv9QXf77/vi2/riwXDFq0FSD+72z7Y6kf58TQQRsoTFibnWHgru
   i33tP5Xa7SAfdrkFpoWi43mDunehjd4decOI1t2ZyfaM8A6d8VcIi9Aix
   3qltfaArs08eRYTVQ+mKt6PZ2KhHLvTfzj9FzU2DiC4oNsOGL2doIMniq
   w==;
X-CSE-ConnectionGUID: Uh1FImt0SaiUH5Se0ir31g==
X-CSE-MsgGUID: tWgIMi/SSE2qi05mSxqL/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63928186"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63928186"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 11:07:57 -0700
X-CSE-ConnectionGUID: 9p/tDAhTRCCj2jfvrIEJuA==
X-CSE-MsgGUID: lUJf09szRfOicaHLR05gkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,267,1754982000"; 
   d="scan'208";a="185232151"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 30 Oct 2025 11:07:52 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vEX3p-000MNw-1s;
	Thu, 30 Oct 2025 18:07:46 +0000
Date: Fri, 31 Oct 2025 02:06:32 +0800
From: kernel test robot <lkp@intel.com>
To: Lyude Paul <lyude@redhat.com>, dri-devel@lists.freedesktop.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Danilo Krummrich <dakr@kernel.org>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>
Subject: Re: [PATCH] rust/dma: Take &mut self in
 CoherentAllocation::field_write()
Message-ID: <202510310102.NdHj0ur8-lkp@intel.com>
References: <20251028211801.85215-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028211801.85215-1-lyude@redhat.com>

Hi Lyude,

kernel test robot noticed the following build errors:

[auto build test ERROR on 3b83f5d5e78ac5cddd811a5e431af73959864390]

url:    https://github.com/intel-lab-lkp/linux/commits/Lyude-Paul/rust-dma-Take-mut-self-in-CoherentAllocation-field_write/20251029-052034
base:   3b83f5d5e78ac5cddd811a5e431af73959864390
patch link:    https://lore.kernel.org/r/20251028211801.85215-1-lyude%40redhat.com
patch subject: [PATCH] rust/dma: Take &mut self in CoherentAllocation::field_write()
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20251031/202510310102.NdHj0ur8-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251031/202510310102.NdHj0ur8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510310102.NdHj0ur8-lkp@intel.com/

All errors (new ones prefixed by >>):

>> error[E0596]: cannot borrow value as mutable, as it is not declared as mutable
   --> samples/rust/rust_dma.rs:70:13
   |
   70 |             kernel::dma_write!(ca[i] = MyStruct::new(value.0, value.1))?;
   |             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ cannot borrow as mutable
   |
   = note: this error originates in the macro `$crate::dma_write` which comes from the expansion of the macro `kernel::dma_write` (in Nightly builds, run with -Z macro-backtrace for more info)
   help: consider changing this to be mutable
   |
   66 |         let mut ca: CoherentAllocation<MyStruct> =
   |             +++

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

