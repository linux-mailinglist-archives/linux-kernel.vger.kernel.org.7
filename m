Return-Path: <linux-kernel+bounces-880052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB33DC24C34
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2813F188A731
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60F33446D0;
	Fri, 31 Oct 2025 11:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QZ5Bxy/T"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9241386C9
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 11:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761909674; cv=none; b=jICJmJA+r+iu5b3T6BP0pUUitT5yFYjIGvTn69VDI65JPD3ImcU+OVpVY0QamV1Ey/0R8ibA0Q2kLHfuUBhUk00mY5F6mKiVGvAAzNfWP5uvtMAs4XvI7FNBuDCwNQ6rDJnjYjf3ulAN3mrELqF22sPj9NSTToFcSaKLn6MoUCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761909674; c=relaxed/simple;
	bh=trBGG14+bE8UKAyiCKZ22diZpFWw0p7vHgvrWEtkBng=;
	h=Date:From:To:Cc:Subject:Message-ID; b=YWdwnb/xpWiLCQQ+UP9t7bHQ7Rd+zr9mKBo0kWSZJszJhReJkao2MgHKlMA9DAAHh+vB7U8c8DqfJCMXnATPpK+sGvFtfsx9++xKcsvYLY2xjlgFKF1+7sAq+gmmcrYf4s+OdK+MlbhH3q8ryiYUGxjHUbPNh6mSmseAqBdPZlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QZ5Bxy/T; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761909672; x=1793445672;
  h=date:from:to:cc:subject:message-id;
  bh=trBGG14+bE8UKAyiCKZ22diZpFWw0p7vHgvrWEtkBng=;
  b=QZ5Bxy/Thhjnm4mgv/7SXJVciNT3r3BhuLU85czrOMsPE56pK/N0eMKZ
   ioQQRGOh03RngpHTjifB70LcL2oGrzYFVUROMkkWCEu8Hx+s7Cb0TSC6x
   Li/O9Vlf2xjHVTJ6UsR2D0ZCRXjDusUjU5znjTEM9bXLMe3zTJ+M8epQq
   SBddKAGTG1H116vBr1kLBHArfmtDD9zrxU2yGWVtofqNP5x4NqipN6soC
   F2MzBKAqxgRn8eVUJi6p8r5RgdrlfzaFtA2/UwEZkLUOsvyuUQ69+XBxo
   Doo3fdovbDpi15OtiWKEILw8mpf/uz5+U3WvGKVH5f78aVIUCwrMv1hr9
   Q==;
X-CSE-ConnectionGUID: E9rq7kglRcW2TgLg7Uqt2Q==
X-CSE-MsgGUID: pmk6Kfy4Tuat3qEMwzU81A==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="81698074"
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="81698074"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 04:21:11 -0700
X-CSE-ConnectionGUID: 9nC/8IJORCm60RtJPSla6A==
X-CSE-MsgGUID: TNEi4rstR8uPBOMAIg97Ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="186150362"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 31 Oct 2025 04:21:11 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vEnBK-000N2K-0t;
	Fri, 31 Oct 2025 11:20:45 +0000
Date: Fri, 31 Oct 2025 19:20:33 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 89216c9051ef6635f1514f8e0d2f9cd63b37a3b6
Message-ID: <202510311927.OzSp4TXe-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 89216c9051ef6635f1514f8e0d2f9cd63b37a3b6  x86/cpu: Add/fix core comments for {Panther,Nova} Lake

elapsed time: 1454m

configs tested: 9
configs skipped: 129

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                          allnoconfig    gcc-14
x86_64                        allnoconfig    clang-20
x86_64  buildonly-randconfig-001-20251031    clang-20
x86_64  buildonly-randconfig-002-20251031    gcc-14
x86_64  buildonly-randconfig-003-20251031    clang-20
x86_64  buildonly-randconfig-004-20251031    gcc-14
x86_64  buildonly-randconfig-005-20251031    gcc-14
x86_64  buildonly-randconfig-006-20251031    gcc-14
x86_64                          defconfig    gcc-14

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

