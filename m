Return-Path: <linux-kernel+bounces-859926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE12BEEFAD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 03:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FFC23BC340
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 01:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B651B142D;
	Mon, 20 Oct 2025 01:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gQuYY91S"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42842A1B2;
	Mon, 20 Oct 2025 01:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760922257; cv=none; b=Wl7bMksg+omTDrkw/q1PuuChzeXPAgilBOn5y2RLQTouoIU9aH0zPuz40rpzLCne9AOm0g1KhcsX+1+3cZuEmtsy4V7Ham2xfmGZTJ6XFNnlYNi44t5SkH66vdofv1fYN/Yup0mJ/T9VEsSanAlNb8SZecR/bfqZfW+VDy+ESn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760922257; c=relaxed/simple;
	bh=rLgQP3nOmKiEqvN5xi1vJ2k/8gJA5JSpwAEVzG0O7VI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ihdSUOh9MGgZx6DeHFck7jchTFOZe8AiSRTzr27OTjq90mpzKsbeQ0eadfPsFmXfP8QZL7k9F0J8akyDkglBfBWm8TJgmtmcrX8b6dUF57T/n1+8kAf30EskbtCwCNPbcjcNyM+qIM3SB9vFuNSqWBC5EctFdwF3gvgll74nQXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gQuYY91S; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760922256; x=1792458256;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rLgQP3nOmKiEqvN5xi1vJ2k/8gJA5JSpwAEVzG0O7VI=;
  b=gQuYY91SSRkR3BqxtiKtnsQwenq1AmrZanYfhA+iwlYOCCOcxv149g1V
   FuQbTP4G0IpPk68V3lHCRT/NpNR3dJHNZg1U8Oue0nPk6XK6Ds1z/D97M
   6XQRukRQLMBIjrM/uQhYm7T71p4L/aodYtNgXXv/4p1PKcWv/YXhri+pu
   Pd0xNvnYJE/0icWQhaFliZtaaLHbGHZ0vQZhUQxJ3Byzi2NOtv44sPDVU
   g1DDgSTVHJhLmcPPRFT0RN4VjX0W1xoMhd9O9i7uv8kQ1da7H4WiwydLX
   OjNIPx6CbhhjVwtVYkWg+6DcOTMJTV7/SFhCfV0uLFUyG8TdYvqb3NnU9
   Q==;
X-CSE-ConnectionGUID: 5i/pCEjHSEOMjRmRsEiwwA==
X-CSE-MsgGUID: h1vW7cDPQdydx35yockBsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11587"; a="63188485"
X-IronPort-AV: E=Sophos;i="6.19,241,1754982000"; 
   d="scan'208";a="63188485"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 18:04:15 -0700
X-CSE-ConnectionGUID: LWhOyV7iQ/OJDJW9sjFm4g==
X-CSE-MsgGUID: CUH7w48sS5CwrB2fiq350g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,241,1754982000"; 
   d="scan'208";a="182759361"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 19 Oct 2025 18:04:13 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vAeJm-0009Nt-0i;
	Mon, 20 Oct 2025 01:04:10 +0000
Date: Mon, 20 Oct 2025 09:03:22 +0800
From: kernel test robot <lkp@intel.com>
To: Rong Zhang <i@rong.moe>, Mark Pearson <mpearson-lenovo@squebb.ca>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Armin Wolf <W_Armin@gmx.de>, Hans de Goede <hansg@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Rong Zhang <i@rong.moe>, Guenter Roeck <linux@roeck-us.net>,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 2/6] platform/x86: lenovo-wmi-{capdata,other}: Support
 multiple Capability Data
Message-ID: <202510200717.19aOSEUP-lkp@intel.com>
References: <20251019210450.88830-3-i@rong.moe>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251019210450.88830-3-i@rong.moe>

Hi Rong,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 3a8660878839faadb4f1a6dd72c3179c1df56787]

url:    https://github.com/intel-lab-lkp/linux/commits/Rong-Zhang/platform-x86-Rename-lenovo-wmi-capdata01-to-lenovo-wmi-capdata/20251020-050849
base:   3a8660878839faadb4f1a6dd72c3179c1df56787
patch link:    https://lore.kernel.org/r/20251019210450.88830-3-i%40rong.moe
patch subject: [PATCH 2/6] platform/x86: lenovo-wmi-{capdata,other}: Support multiple Capability Data
config: i386-buildonly-randconfig-006-20251020 (https://download.01.org/0day-ci/archive/20251020/202510200717.19aOSEUP-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251020/202510200717.19aOSEUP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510200717.19aOSEUP-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/platform/x86/lenovo/wmi-capdata.c:371 function parameter 'type' not described in 'lwmi_cd_match'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

