Return-Path: <linux-kernel+bounces-774975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77647B2B9DC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 08:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3347D7B450C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 06:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C39226FA76;
	Tue, 19 Aug 2025 06:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ayO2QXmV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97CC1E5215
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 06:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755586276; cv=none; b=EHGZilyi+FIka8d38Ic6iBnnAzSaEnZUrFS86eYvTcZhMiq1VfGVSOckSo/j3cxLF8dFPLhQ3ub0p//gcdFMADeddUuQx+EqrLpdXyo68xgFUV3KkMJIKKA95h1jShn4QdUpKNmglDpkA6lmgKIvS+yBuqR2axLAK/FPcBDu52k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755586276; c=relaxed/simple;
	bh=Voljyj+cKS12WOKZRGoakYRM7MKNI5hAU6q7+aZKORU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=MVzhFyGW38U25nvxfpGPz/69n+kkWH0J/5RvDuW6+t4pqkx65phFEwRTu1deTvCmwUlMIfjPYcTtQ3ADcdA+US9mYjCPLQ+bZAQt6eHmizcjJKx12VT+cfR29H5fvryrFqcCL4HC3ouLxFFzoBdMr2b2mPLGwX9mcFQ+bBDoDJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ayO2QXmV; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755586275; x=1787122275;
  h=date:from:to:cc:subject:message-id;
  bh=Voljyj+cKS12WOKZRGoakYRM7MKNI5hAU6q7+aZKORU=;
  b=ayO2QXmV42BopDSUgBOg/DMI+0EPTat7upd6qYIu8KvgFfwTuNnD6bkK
   GJzl+sBD5EJ8pwyM0+FZ9k2Tqs2sg73h5Aku33oJB1v8Bn+B+LuK+YddC
   C+ev3+Twq6U2F/fLRlBNzi56MhZlIAx2QfP1oZRrF7vQmJBY8KFGb0PUO
   GbRJN9+waXXiWt7v4FGaTP4oqKB019grlyL6k55Ie2OFUB5+eejJt1mfh
   2nuLAB3nzMe4E9GrH1LXKQym8g8NZFz82aqSCaYrQTe6Yh6+kaAtZ5Pju
   cc6D34frbJJQ0a0qyJfuhKukDrawQweyFcytJIIkS9qTsEArS+baFYOfi
   A==;
X-CSE-ConnectionGUID: gBsK5zKmTaSXRacXhavgrw==
X-CSE-MsgGUID: Uq6Dy45QTe6ag4xUX6yV8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11526"; a="83249105"
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="83249105"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 23:51:14 -0700
X-CSE-ConnectionGUID: BGDZlDgFSiyIOjGomA7g4w==
X-CSE-MsgGUID: yjxbPnHeT/e5NUQtCbtldg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="173126197"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 18 Aug 2025 23:51:14 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uoGBb-000Gah-0r;
	Tue, 19 Aug 2025 06:51:11 +0000
Date: Tue, 19 Aug 2025 14:50:33 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 e9576e078220c50ace9e9087355423de23e25fa5
Message-ID: <202508191427.APSE5arH-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: e9576e078220c50ace9e9087355423de23e25fa5  x86/CPU/AMD: Ignore invalid reset reason value

elapsed time: 963m

configs tested: 20
configs skipped: 119

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                         allmodconfig    gcc-12
i386                          allnoconfig    gcc-12
i386                         allyesconfig    gcc-12
i386    buildonly-randconfig-001-20250819    gcc-12
i386    buildonly-randconfig-002-20250819    clang-20
i386    buildonly-randconfig-003-20250819    clang-20
i386    buildonly-randconfig-004-20250819    clang-20
i386    buildonly-randconfig-005-20250819    clang-20
i386    buildonly-randconfig-006-20250819    clang-20
i386                            defconfig    clang-20
x86_64                        allnoconfig    clang-20
x86_64                       allyesconfig    clang-20
x86_64  buildonly-randconfig-001-20250819    clang-20
x86_64  buildonly-randconfig-002-20250819    clang-20
x86_64  buildonly-randconfig-003-20250819    clang-20
x86_64  buildonly-randconfig-004-20250819    clang-20
x86_64  buildonly-randconfig-005-20250819    clang-20
x86_64  buildonly-randconfig-006-20250819    clang-20
x86_64                          defconfig    gcc-11
x86_64                      rhel-9.4-rust    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

