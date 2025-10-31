Return-Path: <linux-kernel+bounces-879474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 57FC1C23350
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 04:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6C00B4EF4BA
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 03:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5D62512D7;
	Fri, 31 Oct 2025 03:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dnnzh4VD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5547054774;
	Fri, 31 Oct 2025 03:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761882364; cv=none; b=YnhcRjggxjDMh4cM/nb5SnbpHcGJ4TeXe0c0vKSKMbcFYqAbXfPjFhbhkHGQD3GoVWU3KxtRuL5S4+23S+r3Md9WZwJ4CBtsRWxx4Fr6bCkRA8a0PZUMtqJ7BrHAkt5dTvdScqqYHs25ghi3r6JNTidw3sav7A/LzBSUjmkTxK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761882364; c=relaxed/simple;
	bh=Pr6AZ9+2RkdlqDw+fjABCpLag/dByYgaK04YYWRiFKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sxCCOll1yO/aAeaKmib+lZ/Wgb8HIPrmUv73Ug8lGGgQfPRucZ8htyb2qvB6eCOVDrYr10JwXo9ajjMrgkFhxUB6vtluqR4mk5/KKJPgezrN1xCryuVwUWBNAmC4RW5N3oWAKxvxcz4FBfILWD34CLyCixvdHMvaH/gWdvFfSJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dnnzh4VD; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761882362; x=1793418362;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Pr6AZ9+2RkdlqDw+fjABCpLag/dByYgaK04YYWRiFKk=;
  b=dnnzh4VDqeHXHxBNzkZKiXSoLrLD3trrDBI6N80fRmAZCpfA7NJa6YYX
   mx1orCO1AotTdonD9Rhotrf7yB0qv9kPHAcj2Li9k9yiw5Xm3Ei+nCxNB
   CMNmfYmmprRITrzyX2LNmWjOJVpLcMS+H/+S+UYIio8uqMinld2jAW5WP
   IK6ixWUud7SpfPKUc+pKJqcpWsmicDYsd3eLnPtrab+ETo/edAK3gbXIM
   X1VoZ/Imx3a8v1un/UgYgxk9rpbCE0XGgpDQjHJvwu+p37W3rCLq4twzv
   frknSk2bgAHGavVWxaQL5iy3WUPpxfndKK0hfMOiwDvqk+57R7JnCy/ZS
   Q==;
X-CSE-ConnectionGUID: KsIv2iEURByefRlwMZQryg==
X-CSE-MsgGUID: XYHlS+kVTICgLmljnjD6Fg==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="64186951"
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="64186951"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 20:46:01 -0700
X-CSE-ConnectionGUID: wdSfgDtiQZypuda1fr0N3g==
X-CSE-MsgGUID: ubT6KOiHRa+xbnHNpFJw3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="186869283"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 30 Oct 2025 20:45:59 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vEg5M-000MkO-23;
	Fri, 31 Oct 2025 03:45:56 +0000
Date: Fri, 31 Oct 2025 11:45:25 +0800
From: kernel test robot <lkp@intel.com>
To: Denis Benato <denis.benato@linux.dev>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, platform-driver-x86@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Limonciello, Mario" <mario.limonciello@amd.com>,
	"Luke D . Jones" <luke@ljones.dev>,
	Alok Tiwari <alok.a.tiwari@oracle.com>,
	Derek John Clark <derekjohn.clark@gmail.com>,
	Mateusz Schyboll <dragonn@op.pl>,
	Denis Benato <benato.denis96@gmail.com>, porfet828@gmail.com
Subject: Re: [PATCH v16 2/9] platform/x86: asus-armoury: move existing
 tunings to asus-armoury module
Message-ID: <202510311115.gURckMs4-lkp@intel.com>
References: <20251030130320.1287122-3-denis.benato@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030130320.1287122-3-denis.benato@linux.dev>

Hi Denis,

kernel test robot noticed the following build warnings:

[auto build test WARNING on hid/for-next]
[also build test WARNING on linus/master v6.18-rc3 next-20251030]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Denis-Benato/platform-x86-asus-wmi-export-symbols-used-for-read-write-WMI/20251030-211412
base:   https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-next
patch link:    https://lore.kernel.org/r/20251030130320.1287122-3-denis.benato%40linux.dev
patch subject: [PATCH v16 2/9] platform/x86: asus-armoury: move existing tunings to asus-armoury module
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20251031/202510311115.gURckMs4-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251031/202510311115.gURckMs4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510311115.gURckMs4-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/platform/x86/asus-armoury.c:179 function parameter 'value' not described in 'armoury_set_devstate'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

