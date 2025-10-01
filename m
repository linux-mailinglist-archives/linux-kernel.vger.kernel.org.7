Return-Path: <linux-kernel+bounces-839290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54970BB1420
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 18:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B97C7189EE39
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 16:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE01927F749;
	Wed,  1 Oct 2025 16:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MW8rz7qD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EC02836A0
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 16:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759336588; cv=none; b=B8a9hivZ+qS0PZHCoPGtfrtMa3sfcc9hqYHqgqTTp+dEuWS2N/1UPspKLWDSzRB4D1ktizjmXfw6DevQADHBro+x/bFh187lSPXKgONYPtimkUuhuKhH0LwKbV9XfHezpU7RUnUPgOJO1V9Kal+HtoalnxW1OpHnW7in0tiNhoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759336588; c=relaxed/simple;
	bh=HSLm25QXTpkKM7aT1hm4htROq4qR0UuimjxRvDGXd0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ucsDIsehNJLkmtNe/wIAUoaM9boAn2iPjkbdG/7ze3RRuXALzI8pw2ERZVMmIfvZq6i6iDAJmYygYehjVy6JthAch1WK7JNad13axmZr7QMODkwMOM6ZqRXVUhcSG7XJ2PmmTmUeufTwWGK2dw3StAk9nv/f9yF4iF+Jfa/TP+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MW8rz7qD; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759336586; x=1790872586;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HSLm25QXTpkKM7aT1hm4htROq4qR0UuimjxRvDGXd0s=;
  b=MW8rz7qDm9Cmsfsoy9lN2n3eZV/HF8khNLMhbYRPIb+5CFmWoXVYU2ZI
   GDq6ojjBrOZ/bJQSjYtDtq9rfElqlC8QDAWq/yOhV5oHrqIs1pdMlfqZ3
   o5olV1G41YMzjEsHsLteQJ2OsRJN6u1BcI4AjghvkOQGm4IwuuTmAkZNw
   sVpJ6N71yvb/f/2D3ubBk2ScUVpYF+YtMyD4wg4eWp4wlMi1Ry+NGGDKI
   WqRjHVLGoZxa+5Nln0woXJ+V+gV8bld0nFa38X7GgrdYxEZ06xqUsUx8I
   X71agy5Jr/QTxrAjV3t9knyGLPvmc18A1Le+NBcFF8yp5N4KKrg7ZsCpb
   Q==;
X-CSE-ConnectionGUID: SQOW/7ZwTQimdDpkW7pPIQ==
X-CSE-MsgGUID: iWMtgMxqT3K7u8SiqNo7Aw==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="61506577"
X-IronPort-AV: E=Sophos;i="6.18,307,1751266800"; 
   d="scan'208";a="61506577"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2025 09:36:26 -0700
X-CSE-ConnectionGUID: TwRkw5L8S9qMFlhUI5AWtQ==
X-CSE-MsgGUID: OPt0fZOnSpGgCizH7DihNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,307,1751266800"; 
   d="scan'208";a="183116776"
Received: from lkp-server01.sh.intel.com (HELO 2f2a1232a4e4) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 01 Oct 2025 09:36:22 -0700
Received: from kbuild by 2f2a1232a4e4 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v3zoR-0003B5-26;
	Wed, 01 Oct 2025 16:36:19 +0000
Date: Thu, 2 Oct 2025 00:35:48 +0800
From: kernel test robot <lkp@intel.com>
To: Jason Miu <jasonmiu@google.com>, Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Changyuan Lyu <changyuanl@google.com>,
	David Matlack <dmatlack@google.com>,
	David Rientjes <rientjes@google.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH v1 2/3] memblock: Remove KHO notifier usage
Message-ID: <202510020000.IIPFcxsW-lkp@intel.com>
References: <20251001011941.1513050-3-jasonmiu@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001011941.1513050-3-jasonmiu@google.com>

Hi Jason,

kernel test robot noticed the following build errors:

[auto build test ERROR on rppt-memblock/for-next]
[also build test ERROR on linus/master v6.17]
[cannot apply to rppt-memblock/fixes akpm-mm/mm-everything next-20250929]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jason-Miu/kho-Adopt-KHO-radix-tree-data-structures/20251001-092230
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock.git for-next
patch link:    https://lore.kernel.org/r/20251001011941.1513050-3-jasonmiu%40google.com
patch subject: [PATCH v1 2/3] memblock: Remove KHO notifier usage
config: x86_64-randconfig-003-20251001 (https://download.01.org/0day-ci/archive/20251002/202510020000.IIPFcxsW-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251002/202510020000.IIPFcxsW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510020000.IIPFcxsW-lkp@intel.com/

All errors (new ones prefixed by >>):

>> lib/test_kho.c:59:44: error: too many arguments to function call, expected 2, have 3
      59 |         err |= kho_add_subtree(ser, KHO_TEST_FDT, folio_address(state->fdt));
         |                ~~~~~~~~~~~~~~~                    ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kexec_handover.h:30:5: note: 'kho_add_subtree' declared here
      30 | int kho_add_subtree(const char *name, void *fdt);
         |     ^               ~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.


vim +59 lib/test_kho.c

b753522bed0b7e Mike Rapoport (Microsoft  2025-07-27  40) 
b753522bed0b7e Mike Rapoport (Microsoft  2025-07-27  41) static int kho_test_notifier(struct notifier_block *self, unsigned long cmd,
b753522bed0b7e Mike Rapoport (Microsoft  2025-07-27  42) 			     void *v)
b753522bed0b7e Mike Rapoport (Microsoft  2025-07-27  43) {
b753522bed0b7e Mike Rapoport (Microsoft  2025-07-27  44) 	struct kho_test_state *state = &kho_test_state;
b753522bed0b7e Mike Rapoport (Microsoft  2025-07-27  45) 	struct kho_serialization *ser = v;
b753522bed0b7e Mike Rapoport (Microsoft  2025-07-27  46) 	int err = 0;
b753522bed0b7e Mike Rapoport (Microsoft  2025-07-27  47) 
b753522bed0b7e Mike Rapoport (Microsoft  2025-07-27  48) 	switch (cmd) {
b753522bed0b7e Mike Rapoport (Microsoft  2025-07-27  49) 	case KEXEC_KHO_ABORT:
b753522bed0b7e Mike Rapoport (Microsoft  2025-07-27  50) 		return NOTIFY_DONE;
b753522bed0b7e Mike Rapoport (Microsoft  2025-07-27  51) 	case KEXEC_KHO_FINALIZE:
b753522bed0b7e Mike Rapoport (Microsoft  2025-07-27  52) 		/* Handled below */
b753522bed0b7e Mike Rapoport (Microsoft  2025-07-27  53) 		break;
b753522bed0b7e Mike Rapoport (Microsoft  2025-07-27  54) 	default:
b753522bed0b7e Mike Rapoport (Microsoft  2025-07-27  55) 		return NOTIFY_BAD;
b753522bed0b7e Mike Rapoport (Microsoft  2025-07-27  56) 	}
b753522bed0b7e Mike Rapoport (Microsoft  2025-07-27  57) 
b753522bed0b7e Mike Rapoport (Microsoft  2025-07-27  58) 	err |= kho_preserve_folio(state->fdt);
b753522bed0b7e Mike Rapoport (Microsoft  2025-07-27 @59) 	err |= kho_add_subtree(ser, KHO_TEST_FDT, folio_address(state->fdt));
b753522bed0b7e Mike Rapoport (Microsoft  2025-07-27  60) 
b753522bed0b7e Mike Rapoport (Microsoft  2025-07-27  61) 	return err ? NOTIFY_BAD : NOTIFY_DONE;
b753522bed0b7e Mike Rapoport (Microsoft  2025-07-27  62) }
b753522bed0b7e Mike Rapoport (Microsoft  2025-07-27  63) 

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

