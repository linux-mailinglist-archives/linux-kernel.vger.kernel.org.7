Return-Path: <linux-kernel+bounces-891970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 85913C43F2C
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 14:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 56F504E5C26
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 13:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2692F3621;
	Sun,  9 Nov 2025 13:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cSZyNpLy"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5259C27A130
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 13:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762696012; cv=none; b=hvtegMFRGnVpK+RYbwc2Vv6NeRIt+2UuGCVl75kEGKWILDVIiR1T1WbFHjW9QzlQL62sgjCUV6ephXMSQpkmpz2T1w3b9oDsDnUOhDP9lDbPQJStZKC4ZvugrlsqZlEKDIW1AkqEHw3fit8SYIR6MTVpLncQVeb8iUdgtBkZHVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762696012; c=relaxed/simple;
	bh=+DuCJn82wbX4x0o7SOgPUdX8m3bP6Y8y7aQCbdAHEQA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=seeJ494Vp33dH5uIIzmPLcgjUN3f/a5g5j2apdfRPXtG+0LLw9Odsc7fP+vlPp2BjZZsddydCxLFvyf021ExCBGI/mHNH2LkoJP/EEdnIHm7cwzl48Ofr19l2XAL38gkkP6K0iTTqCTdp+b8my2xpQV8KTXTTu8vwNy1bPp+0cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cSZyNpLy; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762696010; x=1794232010;
  h=date:from:to:cc:subject:message-id;
  bh=+DuCJn82wbX4x0o7SOgPUdX8m3bP6Y8y7aQCbdAHEQA=;
  b=cSZyNpLyWHpxMIfVuGKAMvopE1UDH/WMIZqYgxyWwIUQ4QNLT9A81vTZ
   AjZ/CbrPlRyiLFwFirOXglgHLFV4W18uZaLPZnkoOCTW6Z8KmVCIQCpUr
   bU2I6U1tSroQsfjRxLCxDmXacxJg8HrBRtbxv0Pc0cf+BmtriFlPk05gW
   j0QORAxXicwlJvuzCwzSHKmFXyPDdNDXsU4sQPhxOCrtYHK2LmS3uCMjH
   wN9ywgbS0GR0P/pq0jQsPQMVxa9Pzf9O+mDkU49htYfM0jXDwFkOgPUwa
   VC463tGrcT86MQfEyiCcqykKmMr8RrDIq9fdp58sJymKTmOCfqD5XeN7k
   w==;
X-CSE-ConnectionGUID: 8a365L1HQ3+b2jLffnK3rg==
X-CSE-MsgGUID: +3YTV6CZQFm1eTBffWn4gg==
X-IronPort-AV: E=McAfee;i="6800,10657,11607"; a="64923919"
X-IronPort-AV: E=Sophos;i="6.19,291,1754982000"; 
   d="scan'208";a="64923919"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2025 05:46:50 -0800
X-CSE-ConnectionGUID: L9vOr7jNQVacrR6KvUmzWg==
X-CSE-MsgGUID: 8l+VejrjRmKbXwZ+6Wlp+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,291,1754982000"; 
   d="scan'208";a="219191630"
Received: from lkp-server01.sh.intel.com (HELO 6ef82f2de774) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 09 Nov 2025 05:46:49 -0800
Received: from kbuild by 6ef82f2de774 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vI5kl-00022Z-0H;
	Sun, 09 Nov 2025 13:46:47 +0000
Date: Sun, 09 Nov 2025 21:45:48 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/microcode] BUILD SUCCESS
 67760efa1428c66632a8b901be388aa741e1f02c
Message-ID: <202511092142.CIzoJgOU-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/microcode
branch HEAD: 67760efa1428c66632a8b901be388aa741e1f02c  Merge branch 'x86/urgent' into x86/microcode, to resolve conflicts

elapsed time: 1471m

configs tested: 8
configs skipped: 141

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                allnoconfig    gcc-14
i386    randconfig-012-20251109    clang-20
i386    randconfig-013-20251109    gcc-14
i386    randconfig-014-20251109    gcc-14
i386    randconfig-015-20251109    gcc-12
i386    randconfig-016-20251109    gcc-14
x86_64              allnoconfig    clang-20
x86_64                defconfig    gcc-14

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

