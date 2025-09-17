Return-Path: <linux-kernel+bounces-820156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E7FB7D2F5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D45C8520A2C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 07:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CBF1FF1B5;
	Wed, 17 Sep 2025 07:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="REAaPcMP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64169248873
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 07:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758094446; cv=none; b=XgE+a/jmGV+8k+xpHdn1rjjh9WYC2X/4mASMTYxUdFYGWYFM0lIBx+CZjXoTj+yEBEvXCZgvBTBFe6AbB9lt0qJI++Qc++oeMnzrTutvCZguRR937/+xnY4tKhUiBCZm6wlkAoHCUzMCLuSHp5HSjVwrt0CKdVv059gzxvaywBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758094446; c=relaxed/simple;
	bh=CVkmvhMNF6rHMzSUkW07/UaFA64g6mKPu2TSjkDWrPk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=XefjBM32hi8cO5eNoSbqkAnRNdA5FWJzuABZbnzLRHlXeQeMsVq651naFIPjw3CJUtCdkitRfJuek3AflHGL+yUI3f08PUaJcIDpoJKBigplFnsVXxFlPuGjFjdXvhkVadW4F7lWhhZLn0/6e+L4Iw3OzD4StButckwioRdVf2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=REAaPcMP; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758094445; x=1789630445;
  h=date:from:to:cc:subject:message-id;
  bh=CVkmvhMNF6rHMzSUkW07/UaFA64g6mKPu2TSjkDWrPk=;
  b=REAaPcMPau3zo3M1FJgRFnU1pNa/qzTNtnjxqoFQZkOFaLolHPEpbANZ
   aYDRsPUPQg1yn1/eaL/SOwQJLH0zUlfk5l85yLl3ROKTYILTxRHj+8vdK
   JVuHEL3iuGvZMv9aJD7YM8sqHwtyKZX3mKOqNUJ7JYh2+6X9D2j2vaEjm
   h46VMQqbbjWj8tzjUtAINTe54FWAlpYhGSItiFYOvTkX7cmrqlmQ8VV9q
   33pwpMzCjCIW6KNej0Gv2n7rzyD2L/pYV9TSA9fke936u+hIkD35+lPbc
   Rus1m5fMt71gw4EMVjb2jccZN/YFeIHeJvOQt8D0D0auX3M5xMeQt9fD0
   Q==;
X-CSE-ConnectionGUID: YMCblra+Saaxo46+xQ3OZA==
X-CSE-MsgGUID: Xq8du+SRTpeZ9t/PRD7Etg==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="64209276"
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; 
   d="scan'208";a="64209276"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 00:34:04 -0700
X-CSE-ConnectionGUID: 1nylRQtBQbihT6YxSUM8kw==
X-CSE-MsgGUID: tMa1yuOgTDG4oEQHeEg6mQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; 
   d="scan'208";a="175943562"
Received: from lkp-server01.sh.intel.com (HELO 84a20bd60769) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 17 Sep 2025 00:34:04 -0700
Received: from kbuild by 84a20bd60769 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uymfx-0001Dq-36;
	Wed, 17 Sep 2025 07:34:01 +0000
Date: Wed, 17 Sep 2025 15:33:55 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:tip/urgent] BUILD SUCCESS
 70d5308cbbd7f62f5513b7d1acf904be16576f10
Message-ID: <202509171549.z02KilPP-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tip/urgent
branch HEAD: 70d5308cbbd7f62f5513b7d1acf904be16576f10  Merge branch into tip/master: 'x86/urgent'

elapsed time: 1461m

configs tested: 12
configs skipped: 119

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386    buildonly-randconfig-001-20250916    gcc-14
i386    buildonly-randconfig-002-20250916    gcc-14
i386    buildonly-randconfig-003-20250916    clang-20
i386    buildonly-randconfig-004-20250916    gcc-14
i386    buildonly-randconfig-005-20250916    gcc-14
i386    buildonly-randconfig-006-20250916    clang-20
x86_64  buildonly-randconfig-001-20250916    gcc-14
x86_64  buildonly-randconfig-002-20250916    clang-20
x86_64  buildonly-randconfig-003-20250916    clang-20
x86_64  buildonly-randconfig-004-20250916    clang-20
x86_64  buildonly-randconfig-005-20250916    clang-20
x86_64  buildonly-randconfig-006-20250916    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

