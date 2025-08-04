Return-Path: <linux-kernel+bounces-755175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D67B1A2A9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 15:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E5BE189980B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 13:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887D026FD9F;
	Mon,  4 Aug 2025 13:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mYW1LsKa"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D153226B75B;
	Mon,  4 Aug 2025 13:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754312482; cv=none; b=ur/lj0af8n9+monrL1zjnZuh5h5Gfo+In7kpA4xtIb4I7brxiiFHc2ssVSStLGDm9keDxNf8OujEcDPx/9KdRBy6nykvz0zg+LO7mhFtfu5OpIiyHn5fExWS9ugv88yXq/HysPqsGTvT8wpz2xDpTNn4d9w5GTblOnASuy2A5uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754312482; c=relaxed/simple;
	bh=Hid3X110vD+PaqKN+lf+vdCxTrjDqH0gjrw2Ce/UfPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=So6AnQqkE4+wdzupiMtVnE7VmkfS1jKYlws00dHCuyYyUuDCTupj/zxS4vXAQOyQVp7SOR/ugcYUUN9N1a5Uy02Zk1SB1RAsKrmRmE1maegDtnZWpJ0xHfnqyYidJJbmj5XZfEWJlc5ejVnXZS9iafm4e1+bjdwwURNdTyOtxcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mYW1LsKa; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754312479; x=1785848479;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Hid3X110vD+PaqKN+lf+vdCxTrjDqH0gjrw2Ce/UfPE=;
  b=mYW1LsKaAu4H+/V8wW91YFPAR5KoAjVVWdf0Wjgydia+AIzOQQZ9G8v6
   igVPMvy+5PzOTxjJWqWsgiQCPtK5POX2J1rZgeY0ubuGCoVf8eGv94L2f
   tr8VNmg7ayTe8uAHZY6yxBud7s4KItJvqV5GGDYamadod8aB0xpUnQXm1
   bJbfUwcHLOJll0B0FdDI8c5xiX6vEm09caeXEZ5bN2MHvntaLmrmFILEM
   9ULqkNWWg3gipHftQIbUN9qngc9UeHuYg4M/2Xa4k/PDsoOBLXo96FQ+q
   HoOwu42flBHn7e+sXMrwhtAMqjfQ8cAELpHb+D9Da5ZLb/7+3uO7M0S8C
   g==;
X-CSE-ConnectionGUID: 8NwCf4TDT66x0VnM9HT+cw==
X-CSE-MsgGUID: hzPN+xwuQ6q2o83/Ymy3lg==
X-IronPort-AV: E=McAfee;i="6800,10657,11511"; a="59189544"
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="59189544"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 06:01:18 -0700
X-CSE-ConnectionGUID: G6BN1QhYTqaMOUKpjbHEFg==
X-CSE-MsgGUID: ta1RXwa3SbWiPiRjpJ8YUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="164153964"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 04 Aug 2025 06:01:15 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uiuoS-000027-17;
	Mon, 04 Aug 2025 13:01:12 +0000
Date: Mon, 4 Aug 2025 21:00:38 +0800
From: kernel test robot <lkp@intel.com>
To: Andrei Kuchynski <akuchynski@chromium.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Jameson Thies <jthies@google.com>,
	Tzung-Bi Shih <tzungbi@kernel.org>, linux-usb@vger.kernel.org,
	chrome-platform@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev, Guenter Roeck <groeck@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Baryshkov <lumag@kernel.org>,
	"Christian A. Ehrhardt" <lk@c--e.de>,
	Venkat Jayaraman <venkat.jayaraman@intel.com>,
	linux-kernel@vger.kernel.org,
	Andrei Kuchynski <akuchynski@chromium.org>
Subject: Re: [PATCH v3 05/10] usb: typec: Implement automated mode selection
Message-ID: <202508042044.JDdEBQcS-lkp@intel.com>
References: <20250804090340.3062182-6-akuchynski@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804090340.3062182-6-akuchynski@chromium.org>

Hi Andrei,

kernel test robot noticed the following build warnings:

[auto build test WARNING on usb/usb-testing]
[also build test WARNING on usb/usb-next usb/usb-linus chrome-platform/for-next chrome-platform/for-firmware-next linus/master v6.16 next-20250804]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andrei-Kuchynski/usb-typec-Add-alt_mode_override-field-to-port-property/20250804-170745
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/20250804090340.3062182-6-akuchynski%40chromium.org
patch subject: [PATCH v3 05/10] usb: typec: Implement automated mode selection
config: i386-buildonly-randconfig-002-20250804 (https://download.01.org/0day-ci/archive/20250804/202508042044.JDdEBQcS-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250804/202508042044.JDdEBQcS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508042044.JDdEBQcS-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/usb/typec/mode_selection.c:49 Enum value 'MS_STATE_MAX' not described in enum 'ms_state'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

