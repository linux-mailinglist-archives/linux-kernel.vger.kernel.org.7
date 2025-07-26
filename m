Return-Path: <linux-kernel+bounces-746679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F5DB12A02
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 12:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F8AE1C83270
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 10:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B98F23AB81;
	Sat, 26 Jul 2025 10:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ffhD4u/C"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6B51F150A
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 10:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753524989; cv=none; b=BfhSjyNH9o5SC9JxNvdVM2xc0k6skonv/qQjXpLWLdFWlQOjmZiL5P0bHpn5PfGZNbZuFsE2AdLOXVXe0sN4L5Q/NfJt47GmVGrRf622BElLvo2pkPl234vagjTS8mI0PuWsMHwTbGYZ+R7h67EZJrXqssXPrhsodyDHlbaW7Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753524989; c=relaxed/simple;
	bh=W1nUY5JRvORjm+vb1XNGGtov6ZtefmvCdZ1mHgN2mlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dyBFaKy0yan8Aoo6IuVN9MLp0tnFIXuFLIOGFoDuuaOt+4KoUjlbhzVOp/lmzcLhQ6VVrk23JVH8VAHprV7kQV3Bu2zOugIBz98ein6mKIyR8kXO44JQNIXzrADM/CNix9+RWbzkZf0lICh6vai2D5hIaZ9JJalWXs8+UG4rm7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ffhD4u/C; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753524989; x=1785060989;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=W1nUY5JRvORjm+vb1XNGGtov6ZtefmvCdZ1mHgN2mlk=;
  b=ffhD4u/CZfRDQng4+gtNNMh+BZULo4d6xtJrvgsa6vwh75+5rxpfYWHK
   ynnMUvw4JDQ6yAlVOZZ4gxbDN7bmqqEeqo9qhOuggxXnulSGL/2zf77wq
   YUxdcniB/hvOxOH1WFMFwWAM0RWGTFkvGR6Q9ST7Z2/3SxkFo1xvGDizg
   hyKDvEBt05oFq7Wkxf299FSim8wuDAJxgoEFKlkTblvzUl3iPRLEoOZyU
   10iCIkSlzvf2VQ+ju67pCbUlqMmOtFd9HD1l4w9Vul9Y3d0jZ8jB3T1sc
   izsOaHA5+7OqKtbWh+6VhuYQt0c/QU6Y7GMjToHA7auvcbztxj+JX1nyT
   w==;
X-CSE-ConnectionGUID: forzjHjBSZOSqZaFUbaXLQ==
X-CSE-MsgGUID: a+ksjuR1RBGedTdlQAOPow==
X-IronPort-AV: E=McAfee;i="6800,10657,11503"; a="59646439"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="59646439"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2025 03:16:28 -0700
X-CSE-ConnectionGUID: qT0WqMIBTVuDvvUSqVicjQ==
X-CSE-MsgGUID: A02kl49eTdGcIXBoeLSxSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="161180536"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 26 Jul 2025 03:16:24 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ufbwz-000Lrb-2T;
	Sat, 26 Jul 2025 10:16:21 +0000
Date: Sat, 26 Jul 2025 18:15:44 +0800
From: kernel test robot <lkp@intel.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Christoph Hellwig <hch@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: remove io-mapping
Message-ID: <202507261811.4FJjX1bu-lkp@intel.com>
References: <20250724145313.65920-1-lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724145313.65920-1-lorenzo.stoakes@oracle.com>

Hi Lorenzo,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Lorenzo-Stoakes/mm-remove-io-mapping/20250724-225556
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20250724145313.65920-1-lorenzo.stoakes%40oracle.com
patch subject: [PATCH] mm: remove io-mapping
config: x86_64-buildonly-randconfig-003-20250725 (https://download.01.org/0day-ci/archive/20250726/202507261811.4FJjX1bu-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250726/202507261811.4FJjX1bu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507261811.4FJjX1bu-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/ethernet/mellanox/mlx4/main.c:43:10: fatal error: 'linux/io-mapping.h' file not found
      43 | #include <linux/io-mapping.h>
         |          ^~~~~~~~~~~~~~~~~~~~
   1 error generated.
--
>> drivers/net/ethernet/mellanox/mlx4/pd.c:36:10: fatal error: 'linux/io-mapping.h' file not found
      36 | #include <linux/io-mapping.h>
         |          ^~~~~~~~~~~~~~~~~~~~
   1 error generated.


vim +43 drivers/net/ethernet/mellanox/mlx4/main.c

c1b43dca137f21 drivers/net/mlx4/main.c                   Eli Cohen        2011-03-22 @43  #include <linux/io-mapping.h>
ab9c17a009ee8e drivers/net/ethernet/mellanox/mlx4/main.c Jack Morgenstein 2011-12-13  44  #include <linux/delay.h>
10b1c04e92229e drivers/net/ethernet/mellanox/mlx4/main.c Jack Morgenstein 2016-12-29  45  #include <linux/etherdevice.h>
09d4d087cd4869 drivers/net/ethernet/mellanox/mlx4/main.c Jiri Pirko       2016-02-26  46  #include <net/devlink.h>
225c7b1feef1b4 drivers/net/mlx4/main.c                   Roland Dreier    2007-05-08  47  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

