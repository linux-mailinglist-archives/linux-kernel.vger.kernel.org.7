Return-Path: <linux-kernel+bounces-869753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C0FC08A99
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 05:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 42D414E873F
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 03:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1993725BEE7;
	Sat, 25 Oct 2025 03:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bnLa/qej"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF87257843
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 03:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761364670; cv=none; b=V4dWPvyGvig4ajPR5IZ/qcU9k/OK4e4mt955BvOGBTnkGD9a607uAkfPVusexrUvFzafnCXUT50Do39Oeonz14KZ8mOepsJ4eBpJ2/c0WBUa+aEY1ABOCuDJhPk9T+u/UBzs9cHpeQhQESRIlpkrjmFYYp4WIoMY17Cb2yNyLDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761364670; c=relaxed/simple;
	bh=zdY7TECA95G1snEXpjR0jev+kdjPGHGKfzCPjDCGUTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X3H8g46rWVjU07xfbO5739EJZqSC+Oozz9LVLT9kvVnUJhSPLKtmbISwNGRtgdFuLZMNS52Z1xUiNhoJaRWtLVBfnhN0uVIEpbzE8xDxFhtXt2BHfqoNd5WmI9UiwuNlJdUOy4Fdl+y2s3zxxbdWaBFTfpA0bh+mOdsRgC2qhes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bnLa/qej; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761364669; x=1792900669;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zdY7TECA95G1snEXpjR0jev+kdjPGHGKfzCPjDCGUTM=;
  b=bnLa/qejK4c00iGfZjGLQ4PzKOr234bhbe79wQvBIwj5ylszzonJVDPW
   Gj0UZHphwnGLIT3N3hXPmpxl8NGoji1r0yIXGJPuzFEp5u85MBtAsDDqf
   mcuNFEg4vQomR2aMdktyMQfaNgl/ByGsPZY+qnTbA88HMwWfqPNpk2pYN
   ej8nG+MmywI+CQpYy4UlfWIzxZeJysVym55B/yrDq64ymnsjNj4CaZNz/
   gaE0pFywN4BdVyKFGEyn0IiPcU04iq7NmalpBZXnTnhZ13TpWfM1JLCFn
   koIq1GQF9UqJsbfMes+C3hf8j+e+CGezjDLd9p3YdZfQ2BcO1s7vCf39Q
   w==;
X-CSE-ConnectionGUID: 8WIGmdA6Tmi8hDbAoKzS6Q==
X-CSE-MsgGUID: 09hg6eIZTM2keTg6Bas+2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="89011568"
X-IronPort-AV: E=Sophos;i="6.19,254,1754982000"; 
   d="scan'208";a="89011568"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 20:57:48 -0700
X-CSE-ConnectionGUID: zeiL05zFRYOibm3bN9b6TA==
X-CSE-MsgGUID: GJg2D4PwS8W3UGjX1XeAag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,254,1754982000"; 
   d="scan'208";a="184489554"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 24 Oct 2025 20:57:45 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vCVPT-000F6f-2R;
	Sat, 25 Oct 2025 03:57:43 +0000
Date: Sat, 25 Oct 2025 11:56:46 +0800
From: kernel test robot <lkp@intel.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: Re: [PATCH 5/6] drm/sitronix/st7571: split up the driver into a
 common and an i2c part
Message-ID: <202510251116.5wpReHRY-lkp@intel.com>
References: <20251024-st7571-split-v1-5-d3092b98130f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024-st7571-split-v1-5-d3092b98130f@gmail.com>

Hi Marcus,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 7e73cefd2bede5408d1aeb6145261b62d85d23be]

url:    https://github.com/intel-lab-lkp/linux/commits/Marcus-Folkesson/drm-sitronix-st7571-i2c-rename-struct-drm_device-in-st7571_device/20251024-192347
base:   7e73cefd2bede5408d1aeb6145261b62d85d23be
patch link:    https://lore.kernel.org/r/20251024-st7571-split-v1-5-d3092b98130f%40gmail.com
patch subject: [PATCH 5/6] drm/sitronix/st7571: split up the driver into a common and an i2c part
config: x86_64-randconfig-005-20251025 (https://download.01.org/0day-ci/archive/20251025/202510251116.5wpReHRY-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251025/202510251116.5wpReHRY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510251116.5wpReHRY-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: module st7571-i2c uses symbol st7567_config from namespace DRM_ST7571, but does not import it.
>> WARNING: modpost: module st7571-i2c uses symbol st7571_config from namespace DRM_ST7571, but does not import it.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

