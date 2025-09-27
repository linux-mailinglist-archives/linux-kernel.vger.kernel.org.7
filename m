Return-Path: <linux-kernel+bounces-834944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B6EBA5E36
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 13:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 246791B22700
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 11:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1F82DFF18;
	Sat, 27 Sep 2025 11:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GbBPAjEk"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476A52DF6E9;
	Sat, 27 Sep 2025 11:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758971654; cv=none; b=XwIPLSH7SXIROfqgFPwvb2tMRXPjtohOPeaeNj9KIcxEtvR2AewDl8Ci4YkeZ0Uvv1JjhtHrTnhzbexvz9djUhJRK+s1dTaFolA5Aodk8fwUdp8r0cHQtGU4HEZFPWjlZ/4mq6zth7ju1lhLMAtWt97DhaQHZ6AS/rRAcBKV854=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758971654; c=relaxed/simple;
	bh=R8kNawSngsIcDsCBVG3dnK3T8BBO0B+q9UeKairCbtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j+PLxsXCZBxirJao/lJNGWqkL3tZrCwpMg2gkPZmc7O+2qt77WKxTiPataWZNq1w6U//M6jlJN3EJm+oMfdwCL9qlkwjJcEyQZ21w8ipwehVrQ42NKDnLTgL9exSqnySVVyep+IWuhF3BMk0gbtrAIItGee7faKOLazAbe8NmVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GbBPAjEk; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758971654; x=1790507654;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R8kNawSngsIcDsCBVG3dnK3T8BBO0B+q9UeKairCbtg=;
  b=GbBPAjEkYw37B15/kKG1FxiTCvggqCHESOdfwbpIHgUM+pwf6H0vDLjm
   grnLU/HAX94Yk0Bx/tmX+JYtt3z8GrwTtrroEWqDaPI4ii5/v6Cjn5Q6R
   Bu7ELtOmWWL6GzbqnJOT4FPDNuaMJBVs5jAyxFZ07x0z+MNdhGLi6/yVa
   IYk0gQY9SD5lAG92ACxbUGQW7kWUBcbbdAZJoRIqGc73Q3+srkxYxLxUM
   9QStCYJo09VCWZWQMxThDbl4MTtWsisZ7NSR/LiKbIhaykjoLRfZ3HBFk
   we+fHPFFdBKGn9ClIHEWhu+sEPLDWPvgTGoLvnAoufQoITfFhbRjSdG2e
   w==;
X-CSE-ConnectionGUID: cSrcMeDwQaa93yjSaCcAnA==
X-CSE-MsgGUID: yIAjHy6TTrKbMkdhbJ+p0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11565"; a="60992161"
X-IronPort-AV: E=Sophos;i="6.18,297,1751266800"; 
   d="scan'208";a="60992161"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2025 04:14:11 -0700
X-CSE-ConnectionGUID: eSLfmdSdQVKNT9170Nt3jw==
X-CSE-MsgGUID: MEKIiVrnTU2pu+InOxfiUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,297,1751266800"; 
   d="scan'208";a="182996562"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 27 Sep 2025 04:14:07 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v2SsO-00070Z-32;
	Sat, 27 Sep 2025 11:14:04 +0000
Date: Sat, 27 Sep 2025 19:13:49 +0800
From: kernel test robot <lkp@intel.com>
To: Cryolitia PukNgae via B4 Relay <devnull+cryolitia.uniontech.com@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: oe-kbuild-all@lists.linux.dev, Mingcong Bai <jeffbai@aosc.io>,
	Kexy Biscuit <kexybiscuit@aosc.io>,
	Nie Cheng <niecheng1@uniontech.com>,
	Zhan Jun <zhanjun@uniontech.com>,
	Feng Yuan <fengyuan@uniontech.com>, qaqland <anguoli@uniontech.com>,
	kernel@uniontech.com, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Cryolitia PukNgae <cryolitia@uniontech.com>
Subject: Re: [PATCH v5 3/4] ALSA: usb-audio: make param quirk_flags
 change-able in runtime
Message-ID: <202509271834.cL5PYMND-lkp@intel.com>
References: <20250925-sound-v5-3-2593586ff350@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925-sound-v5-3-2593586ff350@uniontech.com>

Hi Cryolitia,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 4c421c40c8b30ab7aae1edc7f7e294fcd33fc186]

url:    https://github.com/intel-lab-lkp/linux/commits/Cryolitia-PukNgae-via-B4-Relay/ALSA-usb-audio-add-two-way-convert-between-name-and-bit-for-QUIRK_FLAG_/20250925-173635
base:   4c421c40c8b30ab7aae1edc7f7e294fcd33fc186
patch link:    https://lore.kernel.org/r/20250925-sound-v5-3-2593586ff350%40uniontech.com
patch subject: [PATCH v5 3/4] ALSA: usb-audio: make param quirk_flags change-able in runtime
config: arm64-randconfig-r132-20250927 (https://download.01.org/0day-ci/archive/20250927/202509271834.cL5PYMND-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project cafc064fc7a96b3979a023ddae1da2b499d6c954)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250927/202509271834.cL5PYMND-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509271834.cL5PYMND-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> sound/usb/card.c:112:1: sparse: sparse: symbol 'quirk_flags_mutex' was not declared. Should it be static?

vim +/quirk_flags_mutex +112 sound/usb/card.c

   110	
   111	/* protects quirk_flags */
 > 112	DEFINE_MUTEX(quirk_flags_mutex);
   113	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

