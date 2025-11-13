Return-Path: <linux-kernel+bounces-899336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C3CC576F7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 13:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C7BE94E520B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 12:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09A1342534;
	Thu, 13 Nov 2025 12:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TfI7PuAP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FF62D94A3
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 12:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763037315; cv=none; b=jejPKyVrY0naQI/vA8cL9YJnlWfM7Y60oitPiyJRoSYC1oNIjkb5Mdad4+bUxP6JDjKnXSske+5HFZxOIs3jkLHI1tleR+Uw5czhvliKFQX3EXlNwnRoify31/J7zdtHrxHl9L98CqRAdTgiv4d9tOQZlpyFBvztzZjnxvRvf9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763037315; c=relaxed/simple;
	bh=z7Tt8b1VSXUMC0z5DvrE/AP42l5aJLVRZ1SAJmVtOFs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=i9HrLNpVJpZu1J0xNuFtUAgXiTeMScJOB4IXAtLAKzEd1fBHT0tjamUJb8AGLFKhQZ2UZIA+kTz3QuCIeN76o7Rx2OuI59RqEH5v/hMHkwEcpeFTfb/nlKpR9xy9ZySNyMy83OYZfAniyYqUwkDrkLd9uNefR9iIFMhxANvB/o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TfI7PuAP; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763037313; x=1794573313;
  h=date:from:to:cc:subject:message-id;
  bh=z7Tt8b1VSXUMC0z5DvrE/AP42l5aJLVRZ1SAJmVtOFs=;
  b=TfI7PuAPLTxga2etf4YKZhUCeHbcnVfOvOY0JxrWfysN6EuvXLbiwUwH
   RO4n0hP+iiecqc6189FSFf27l/hnQgAB0DjEqHu4QKNd3VZN21jWzlLU3
   qQYbOBPq3HIxDRW0q7M9uKgKwsT5GneI3QKBNfHqrT0uKrKys13IJ6Ose
   +Ry245aXhhQealU8GI/+do85zxwIPYahsw+3X9qu9HLOehM21hFBVvFsG
   SW3xq6j+H9BuU6/HloCGuHjFbOlGZZ3crSTgD2r2j3FVhZGqw/kg3tQa4
   VjTN+xfE4UriRIgKFiKhmdKrU+EvPepWgr8FCub9fcL34mYgnklM4WiJX
   Q==;
X-CSE-ConnectionGUID: TsRiKUN5RRyrNjqDkD0Vhg==
X-CSE-MsgGUID: zOW3n/zXRnOvzEhHzqJZCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="90589655"
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; 
   d="scan'208";a="90589655"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 04:35:12 -0800
X-CSE-ConnectionGUID: 52nhxV42S02ZWM20j9UwBw==
X-CSE-MsgGUID: BnPzx2+JQUa3WgDKXfTi6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; 
   d="scan'208";a="189919769"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 13 Nov 2025 04:35:11 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vJWXd-0005KF-19;
	Thu, 13 Nov 2025 12:35:09 +0000
Date: Thu, 13 Nov 2025 20:35:02 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:perf/core] BUILD SUCCESS
 9929dffce5ed7e2988e0274f4db98035508b16d9
Message-ID: <202511132057.uYMOfBhq-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core
branch HEAD: 9929dffce5ed7e2988e0274f4db98035508b16d9  perf/x86/intel: Fix and clean up intel_pmu_drain_arch_pebs() type use

elapsed time: 1495m

configs tested: 2
configs skipped: 124

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386    allnoconfig    gcc-14
x86_64  allnoconfig    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

