Return-Path: <linux-kernel+bounces-761392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7117CB1F986
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 11:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EF9C1896002
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 09:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343F423A9AD;
	Sun, 10 Aug 2025 09:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ez1RxXOE"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C90E1DB92A
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 09:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754819405; cv=none; b=HkLAoIxpdVoItriWmuGdc1j/0C+NMIag4Qmus8QSLMFDa44kzKk5IXKVEmI9pOOyuxKfw3T5/SES3NVifZwricswUDM9xfUDrYXEtNe4Qgf6B4z8EFajJLa2lwIU7nPTrvv2G7SrwoMef8mkxWSSSgTxnWUB377g+40B2JOa9rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754819405; c=relaxed/simple;
	bh=S5iYfEFmgkv1YdH2jyiFWAX3ClrOAVHmKPAAv0Mx9lg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cAUHpWBY22jGpucl7ro2To/WrjSQue1eh0E1CMIwCKEySNbpXhe4gRrtDYUpa4qrKFrdwbXwRYl+D/KdUkGgKqkQOXzjoV5WPSblMklzEKmBROZV86IeTk1w7CWJrlctC/1I3323exC7M4nMfCvsB9l8GFUdWItzV8AjLyQo2aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ez1RxXOE; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754819404; x=1786355404;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S5iYfEFmgkv1YdH2jyiFWAX3ClrOAVHmKPAAv0Mx9lg=;
  b=Ez1RxXOEZCg60tC1P6moA9oQT0xgr3GNgZYg8LX3CsCOq/jMeOH9vqhC
   NfQOVDBoKbfHQXp7E832b6Xax7XcEBQWMdgnaNEeapp5123Y9nYGGLnqV
   EkE4Th/lIOk0giwa7JaJY/SrrnOc3zOVqrgmrvsava0c9kUBc3E7mHNTP
   B4H8LUHHzGNxs1FG1Qqpg0OVxserXdstYTUUyMOgiQrFypiidV0vdIW1h
   6Lo0o7IRmlOVAbVHMQ025f98FjK71MXqs1uZdfclVgnD1+CgcxOCTHYC8
   LoTjaWLT1nV8B/Blp+2C64wM5W3pikbCvABFdOmRRa+E9C+ZXGNhW61Me
   A==;
X-CSE-ConnectionGUID: /qHuDpNUTGaamHDsaV354w==
X-CSE-MsgGUID: D4d9e1pCS9SBzTj8PT0pYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11516"; a="74549298"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="74549298"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2025 02:50:03 -0700
X-CSE-ConnectionGUID: WpdJDaenSfWkgqXhx9TUEQ==
X-CSE-MsgGUID: gtmWuhJYSYahXYGG2Rz1bA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="165985762"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 10 Aug 2025 02:50:00 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ul2gc-0005FM-0w;
	Sun, 10 Aug 2025 09:49:54 +0000
Date: Sun, 10 Aug 2025 17:49:25 +0800
From: kernel test robot <lkp@intel.com>
To: Tiwei Bie <tiwei.bie@linux.dev>, richard@nod.at,
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net
Cc: oe-kbuild-all@lists.linux.dev, linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org, benjamin@sipsolutions.net,
	arnd@arndb.de, tiwei.btw@antgroup.com, tiwei.bie@linux.dev
Subject: Re: [PATCH v2 06/10] um: Define timers on a per-CPU basis
Message-ID: <202508101712.K4PzKDp3-lkp@intel.com>
References: <20250810055136.897712-7-tiwei.bie@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250810055136.897712-7-tiwei.bie@linux.dev>

Hi Tiwei,

kernel test robot noticed the following build warnings:

[auto build test WARNING on uml/next]
[also build test WARNING on linus/master next-20250808]
[cannot apply to uml/fixes arnd-asm-generic/master v6.16]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tiwei-Bie/um-Stop-tracking-virtual-CPUs-via-mm_cpumask/20250810-135542
base:   https://git.kernel.org/pub/scm/linux/kernel/git/uml/linux next
patch link:    https://lore.kernel.org/r/20250810055136.897712-7-tiwei.bie%40linux.dev
patch subject: [PATCH v2 06/10] um: Define timers on a per-CPU basis
config: um-randconfig-001-20250810 (https://download.01.org/0day-ci/archive/20250810/202508101712.K4PzKDp3-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250810/202508101712.K4PzKDp3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508101712.K4PzKDp3-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: arch/um/os-Linux/time.c:90 function parameter 'cpu' not described in 'os_timer_disable'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

