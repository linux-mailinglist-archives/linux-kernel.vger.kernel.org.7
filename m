Return-Path: <linux-kernel+bounces-890552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DAF9C404FD
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 15:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BE96934D735
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 14:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60ACD328B48;
	Fri,  7 Nov 2025 14:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bIykkcqG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4022DECA3
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 14:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762525507; cv=none; b=YiJYis7khHdzy9Uxehl9JZeH3j2NOUPy6BTi8KmVv9TrHe4gcSzOCQg8HDPSLIC66ZHpA/crpctKLSjEfJukZp1a3M+o3QsJDGGOK68SXW4XamHmTXxlC4Q1r/F43+4OBbkT9Pm8NErKeFGw2c/ztknC177xFZ2+KlO71goe+54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762525507; c=relaxed/simple;
	bh=lv0VmJgTVUdZ9nOO5TT5bSO+zym3xmQ5zBZpSKi4zCE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=F6jPZ3uPFv4vUUuDvEN8SxE0Dck0QvlqfLe2dClYze1R9cWcU9ut9xrzcVNRrhahk3LBnwVBuL4vO1ePJyJKgfaa2AoT2Nr9jqdGjrCJZ0uAmmFMiIOWadspvjseUHdVE4+B2OW6IhHAxzvmE8jHJdcqUaevsxB4LzMdDqM73H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bIykkcqG; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762525507; x=1794061507;
  h=date:from:to:cc:subject:message-id;
  bh=lv0VmJgTVUdZ9nOO5TT5bSO+zym3xmQ5zBZpSKi4zCE=;
  b=bIykkcqGGMhi7mwP8wDCGi5xm2wKKw3Cnu6lpWGpKcg4B8p+La0iDRqL
   /gO3NKilRqdN/EvoxwjJDm39uF3cusVCis5WmgVh3gKHEJRSr/OPt9vSn
   1rqbt1rvoJutXbHlQ6VqafGCDfbShlhKwVDuXIPflkY56qOvdDyVrtB4t
   5QlcSFvOKu0pVgWjJki026okJdYRKkadOG8xkc3bG3cboxB36VVukLV+a
   YEB569133OXl0I2ExGqCzeU+l6nLUiVlnaf43bi+Ktr5tEmS3i2KaMb11
   yba9zIVhFZkpLWSM0tHVM01WyXCn2gfKwYlSJ97vbX9RwvFZnLZj/XGgU
   g==;
X-CSE-ConnectionGUID: WW362jWPSceYOgAzkP++zA==
X-CSE-MsgGUID: MU+u5jH5ThW+gkdaLUdmRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11605"; a="64715002"
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; 
   d="scan'208";a="64715002"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 06:25:06 -0800
X-CSE-ConnectionGUID: cY9hv4PETQ6XhuZ4EI84Og==
X-CSE-MsgGUID: gVPKG337S0+4YsSjINWwsg==
X-ExtLoop1: 1
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 07 Nov 2025 06:25:05 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vHNOh-000VCM-07;
	Fri, 07 Nov 2025 14:25:03 +0000
Date: Fri, 07 Nov 2025 22:24:47 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:ras/core] BUILD SUCCESS
 94567e69f7460766aada806939ca8c13364861a3
Message-ID: <202511072241.HYaIuLY7-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras/core
branch HEAD: 94567e69f7460766aada806939ca8c13364861a3  x86/mce: Save and use APEI corrected threshold limit

elapsed time: 1464m

configs tested: 12
configs skipped: 124

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                          allnoconfig    gcc-14
i386    buildonly-randconfig-001-20251107    clang-20
i386    buildonly-randconfig-003-20251107    gcc-13
i386    buildonly-randconfig-004-20251107    gcc-14
x86_64                        allnoconfig    clang-20
x86_64                          defconfig    gcc-14
x86_64            randconfig-011-20251107    gcc-14
x86_64            randconfig-012-20251107    gcc-14
x86_64            randconfig-013-20251107    clang-20
x86_64            randconfig-014-20251107    clang-20
x86_64            randconfig-015-20251107    gcc-14
x86_64            randconfig-016-20251107    gcc-14

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

