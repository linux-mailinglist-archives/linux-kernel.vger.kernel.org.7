Return-Path: <linux-kernel+bounces-819729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C406B7D406
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06A09174109
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 23:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D772C375E;
	Tue, 16 Sep 2025 23:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DPpksF7o"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD1B28467B
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 23:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758064933; cv=none; b=ppgK6e5dJVJuUWdzCXPbRlfI9nWkJTjSiFp0/kSTzvm+5HhVgAizNVxHZQNn78qL4omFkkrmjxh8W2qKFS7FYe7+EXLvn7CY/eUgM5cG1u4JoXSIMirSxejTaVczJtaS6a5caXaEDGYBaX6tZ/dZNY4Zeu28iJgrDBHPP6rqhbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758064933; c=relaxed/simple;
	bh=paQHa9b3xhY6u+jULo2ppco20m/1K8DGNXQUpteD7e0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ZitMrlZ0ZwdvSoPYb4pyW/34jK5lGSaYPAI+tp8VIS2LkAUF3vdGasL5cpNWgY33xIFHi5zMro2W+EYA4eIwxgxTs8SNjhtDgKv8HXnzm3nrLDr6uFflqzd84UCWF+wRc+TQmLfNFF/qjFaVR1xSVe5qcmYXHsUubRNkwamEuhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DPpksF7o; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758064932; x=1789600932;
  h=date:from:to:cc:subject:message-id;
  bh=paQHa9b3xhY6u+jULo2ppco20m/1K8DGNXQUpteD7e0=;
  b=DPpksF7o7wTogR5vtxQBpIf3L+DscxYzuKBrCPV0hMYVcZCLGM+wOi+k
   p1fZzMcm9BtI8qXbp60oQtfc+2UjTHqwqV2/ZgH/6TaLr2w+7csi6VaT7
   A21Co51NUduCCtA0PSLwLEpatT7XcIitRazBhraK8V1PfuGBpRA3ZRtGg
   M4k3GjgcmdzpD94Pb+uRpjEle7MYyrEAD+85RKRcoAlx1dqpkm/keD1IP
   ypFKvr6Vfdgof4X8sHPkVHaO7d0z7YVTHMKqcFK6eJRgbid5bmx1XX79M
   xb8UGGJBO7bM9hzkfu72Yp0lB66vN3Ut7053reRDfi3hHPTkFP9aeEf5v
   A==;
X-CSE-ConnectionGUID: v05xC5zNQXObPq3doiKmBQ==
X-CSE-MsgGUID: r5uFdQUoRXeNzMMSi/ZU8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="60504748"
X-IronPort-AV: E=Sophos;i="6.18,270,1751266800"; 
   d="scan'208";a="60504748"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 16:22:12 -0700
X-CSE-ConnectionGUID: TMrQnMQlTjSeg4htSXNNcg==
X-CSE-MsgGUID: nKZ2YNfYQxq2RrvM4e8SFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,270,1751266800"; 
   d="scan'208";a="179082819"
Received: from lkp-server01.sh.intel.com (HELO 84a20bd60769) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 16 Sep 2025 16:22:11 -0700
Received: from kbuild by 84a20bd60769 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uyezw-0000qh-0s;
	Tue, 16 Sep 2025 23:22:08 +0000
Date: Wed, 17 Sep 2025 07:21:56 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 7f830e126dc357fc086905ce9730140fd4528d66
Message-ID: <202509170750.Jsr6zfkF-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 7f830e126dc357fc086905ce9730140fd4528d66  x86/sev: Guard sev_evict_cache() with CONFIG_AMD_MEM_ENCRYPT

elapsed time: 1462m

configs tested: 17
configs skipped: 119

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                          allnoconfig    gcc-14
i386    buildonly-randconfig-001-20250916    gcc-14
i386    buildonly-randconfig-002-20250916    gcc-14
i386    buildonly-randconfig-003-20250916    clang-20
i386    buildonly-randconfig-004-20250916    gcc-14
i386    buildonly-randconfig-005-20250916    gcc-14
i386    buildonly-randconfig-006-20250916    clang-20
x86_64                        allnoconfig    clang-20
x86_64                       allyesconfig    clang-20
x86_64  buildonly-randconfig-001-20250916    gcc-14
x86_64  buildonly-randconfig-002-20250916    clang-20
x86_64  buildonly-randconfig-003-20250916    clang-20
x86_64  buildonly-randconfig-004-20250916    clang-20
x86_64  buildonly-randconfig-005-20250916    clang-20
x86_64  buildonly-randconfig-006-20250916    clang-20
x86_64                          defconfig    gcc-14
x86_64                      rhel-9.4-rust    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

