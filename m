Return-Path: <linux-kernel+bounces-822474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19FBAB83F8C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 12:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6C801C06C4E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 10:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBEDD278753;
	Thu, 18 Sep 2025 10:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ANpjOcGQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1B410F1
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 10:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758190307; cv=none; b=GHv/aWR8gqJouARGWdpwHJYlE4lZm+CwWH7YfWEkve5uIqx6sdd6ZDNMWgL/11NhwUSVTe6FGPBTXJVNCDW+2UwTGaUuc0MJh5KdGb79tPdSRzSsD+0osb57mqAHmUrGL2h9+V6vx5G+bOjcD0qijkldvxS0PgZK0S1vlw2uF1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758190307; c=relaxed/simple;
	bh=B7+3NVi8bMlRHZXM9z2Z0a/JnqEMQivf+7YsNtm5tfE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=OYaVeAJw76UkerF1yW/F4k+uqq4jH+ASJ1LeNcOGXnBwTTTKs91eZcRYF10CkcXzjQrOPv5O9k5yyuoto/4K/DTJD5WqglW6U40JgMmMsrMdys40nYb7hPGSjJXlNTXtIUSjyxzLXOSvQwqQDhTRbft0sto6QaYzXhgWkklOHVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ANpjOcGQ; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758190305; x=1789726305;
  h=date:from:to:cc:subject:message-id;
  bh=B7+3NVi8bMlRHZXM9z2Z0a/JnqEMQivf+7YsNtm5tfE=;
  b=ANpjOcGQ3NbldngBti5dOujd0aL38X9zclQsRdhPK5bTwfcjMV3RhOw2
   pocESFwFJbFmhrPnSrOiRhezCAKGRsxsbQdqbTOUEUULL5PIVTPzIcht/
   QgaQLcyaQidxSFFsXBNtxHZSTepJ+epu5GgwVw3MQGBgF9MO2O32HNGU7
   HWxbPVenR9fcqwJAOmRKxoWEVf9wqW7W3cq+zZ4OZbdull/LOs/RSgEYx
   +ipTU70hNW1bcPkdytqZdIwA1YndCASxhKFI10EF+1ztsq6Enunc56ers
   QPIEDtPwFHzRNgsklvyF9AYSnB9j5SsoFw9Lzy9YAoNeM7LdKJWg7Luvn
   Q==;
X-CSE-ConnectionGUID: DMXXZ9cjSu6LWiLCdT1DxQ==
X-CSE-MsgGUID: ginvFxWAQS2GLghBKOUsTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11556"; a="63143215"
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; 
   d="scan'208";a="63143215"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 03:11:44 -0700
X-CSE-ConnectionGUID: gezh5+/ATGSkh8zh71mbpg==
X-CSE-MsgGUID: lhaIVw4tSRuzZxgzyBdCyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; 
   d="scan'208";a="180779193"
Received: from lkp-server01.sh.intel.com (HELO 84a20bd60769) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 18 Sep 2025 03:11:43 -0700
Received: from kbuild by 84a20bd60769 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uzBc5-000365-2c;
	Thu, 18 Sep 2025 10:11:41 +0000
Date: Thu, 18 Sep 2025 18:11:02 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:tip/urgent] BUILD SUCCESS
 b40bb754c6fab152a51e980702f33c4abc442f78
Message-ID: <202509181856.nktnxGwx-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tip/urgent
branch HEAD: b40bb754c6fab152a51e980702f33c4abc442f78  Merge branch into tip/master: 'x86/urgent'

elapsed time: 1455m

configs tested: 12
configs skipped: 119

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386    buildonly-randconfig-001-20250917    gcc-14
i386    buildonly-randconfig-002-20250917    clang-20
i386    buildonly-randconfig-003-20250917    gcc-14
i386    buildonly-randconfig-004-20250917    gcc-14
i386    buildonly-randconfig-005-20250917    gcc-14
i386    buildonly-randconfig-006-20250917    clang-20
x86_64  buildonly-randconfig-001-20250917    gcc-14
x86_64  buildonly-randconfig-002-20250917    clang-20
x86_64  buildonly-randconfig-003-20250917    clang-20
x86_64  buildonly-randconfig-004-20250917    clang-20
x86_64  buildonly-randconfig-005-20250917    clang-20
x86_64  buildonly-randconfig-006-20250917    gcc-12

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

