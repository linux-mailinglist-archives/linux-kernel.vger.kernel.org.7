Return-Path: <linux-kernel+bounces-785631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6334DB34ECD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 00:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D0E61A86E3D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 22:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC602BD5BF;
	Mon, 25 Aug 2025 22:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HUvhXT9l"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6762820DB
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 22:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756159961; cv=none; b=Jb5IOPuqGg/kQsAWpFJkoESEGM3NeNNwniG9/HSNTlmWDvzEoJY9Y8POH1kttSZBIi2GQ4+HTlxU0xWRuEwecnShqydrEX5+/WS2QgpgucyJvPcO7hP0og0Rt2whNuo0P8md9R1Qtoet8OFP6FdCsnyDVEOHhHLcM63J8Y8rdyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756159961; c=relaxed/simple;
	bh=1tOOeHxavsK3Uh7V+mDeRX9w6ljGlrDwkmRmeUDip8I=;
	h=Date:From:To:Cc:Subject:Message-ID; b=E6OuRULb+NIj822XgQMvsim2Nrciy4nEiu65LxGMlxM2G3gjNuasJC8WFsr/LqnW64XRbwml8UIfJvbqQ6zyddkGXVl9kBqRIXmnS+zHxIUKj/DKV0boh4HG16IKxxdt7wNG9VUWHi2ixqjMJGiDnoNBdCNhGy60U4VVyAdROUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HUvhXT9l; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756159961; x=1787695961;
  h=date:from:to:cc:subject:message-id;
  bh=1tOOeHxavsK3Uh7V+mDeRX9w6ljGlrDwkmRmeUDip8I=;
  b=HUvhXT9lLdgxXQ4wFZhUT30xoMkluw8WSu7SAYUjBLI+vE8+TP/BmIJ5
   P9CFtEOf1/gtbM1CXF/fikn5T3EcprQGDZxG8gBKy4zb8OvYNYfRhjY21
   qONIA00FMiMrKRM/AqSHdVa0CkDWQYltOrCokCVDWInaaVrkHEuIfOcjU
   SzKuZEPh54uCg23sT1aLqZPvtimTogzus/6nwU91AVJNKji3jUv5V+ISW
   kGo3s0IRJ+o2gbr1bXCVFZ52B2sxcnI4aPV9ZVB93M7rDxxinZzXXWkgP
   WiemUDyV3onIhWJElzid6a/KBqqLePN7/filzqWvJrXSsUPC1C1i5D3kJ
   w==;
X-CSE-ConnectionGUID: hJDbZpuGRsqXSTx4CQ2woQ==
X-CSE-MsgGUID: qrroKuS9Tfm1XtdsdtYsvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11533"; a="68653435"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="68653435"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 15:12:40 -0700
X-CSE-ConnectionGUID: iW8WEX5FQ1KhkVyCrJuNug==
X-CSE-MsgGUID: UWyPCjE9RveQwS9h0jH71w==
X-ExtLoop1: 1
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 25 Aug 2025 15:12:38 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uqfQ4-000O2R-0Y;
	Mon, 25 Aug 2025 22:12:14 +0000
Date: Tue, 26 Aug 2025 06:11:32 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/apic] BUILD SUCCESS
 1b558e14f3c17dc29ce2e8cd0b8bd385e108734b
Message-ID: <202508260626.kCoeAVUJ-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/apic
branch HEAD: 1b558e14f3c17dc29ce2e8cd0b8bd385e108734b  x86/apic: Make the ISR clearing sane

elapsed time: 722m

configs tested: 20
configs skipped: 119

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                         allmodconfig    gcc-12
i386                          allnoconfig    gcc-12
i386                         allyesconfig    gcc-12
i386    buildonly-randconfig-001-20250825    gcc-12
i386    buildonly-randconfig-002-20250825    clang-20
i386    buildonly-randconfig-003-20250825    clang-20
i386    buildonly-randconfig-004-20250825    gcc-12
i386    buildonly-randconfig-005-20250825    gcc-12
i386    buildonly-randconfig-006-20250825    clang-20
i386                            defconfig    clang-20
x86_64                        allnoconfig    clang-20
x86_64                       allyesconfig    clang-20
x86_64  buildonly-randconfig-001-20250825    clang-20
x86_64  buildonly-randconfig-002-20250825    gcc-12
x86_64  buildonly-randconfig-003-20250825    gcc-12
x86_64  buildonly-randconfig-004-20250825    clang-20
x86_64  buildonly-randconfig-005-20250825    clang-20
x86_64  buildonly-randconfig-006-20250825    clang-20
x86_64                          defconfig    gcc-11
x86_64                      rhel-9.4-rust    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

