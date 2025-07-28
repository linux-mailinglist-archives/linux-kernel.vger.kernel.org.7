Return-Path: <linux-kernel+bounces-748434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B60B1B14142
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 19:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC5BE3BDEF0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 17:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5ED274FEE;
	Mon, 28 Jul 2025 17:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NzIALnIq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0530F1E5B60
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 17:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753724140; cv=none; b=VujvLqHwYOBEA3gKzhVRejG+XG5MIM7CtEqrQICtJTA9WYXFUuZnobSSYUncbsag3ibM7xijpht9umZdgZeJTC3xg0bum0xVteCJYqqpywWJlZV88abD+FjsmbuFsIUUDOWnCa3hlX1IN2qbM5LrOsIRO46nL4DtbJfZ0FWtRAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753724140; c=relaxed/simple;
	bh=qH1x2qT/9Xnl7IgzTfQK2sl6S5aSqNciX6TR6yTSXJM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=YzSmE9yJm/9HTbVdxjBw/kET59izCwmw25Iz4O/3Twsjr+VcT3mh3fzr2LOhvLtQMCiGVnVVKFA/DiWZS9P9KLkxuGXU6cVAuYA4p1GL6NxI9+Y7Nkf6K64ZUMs4YkNMtY8tAEnnLYZDDuyV7AuTQoUIRqepMPXoq64CQ0vuDC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NzIALnIq; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753724139; x=1785260139;
  h=date:from:to:cc:subject:message-id;
  bh=qH1x2qT/9Xnl7IgzTfQK2sl6S5aSqNciX6TR6yTSXJM=;
  b=NzIALnIqWW/7QlQ241o5l24NVVgY3G8aRDAJYEm1jZYTGNeK9OZJx8iG
   S7PMfDYfdYspfeZ4hBmNrje+92qx0Stkpv6Fhc6nPKLgMSxKATDnHZP3g
   UJ5RHwMBMOnDDWXHqR/dGF4fGlaaJrlRAkDR9vIr2Ft5GuwSFvUmnxbWX
   sdOrWBYPsBxY6dQzXylC0OQTbf2Ck6prBEQ36gNiBn+O8uHoI0rH6kZwn
   id916dJNt6GqEE80sVAsLelUFOK+TP9Pkll5gAqICy09tDGzVkw9EKFpH
   m7C16Str7tljsos8b56f+vGxt4Oz1v3+dNAl9ulUnoYSJXU0BVKCaDsTY
   w==;
X-CSE-ConnectionGUID: fxcalBjFQg+NMbCrE6Ag7Q==
X-CSE-MsgGUID: +F5YoYnQS5mJCuUqtOA0Xg==
X-IronPort-AV: E=McAfee;i="6800,10657,11505"; a="66548024"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="66548024"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2025 10:35:13 -0700
X-CSE-ConnectionGUID: zU1tIHH0SsS3MLrbiVWA5w==
X-CSE-MsgGUID: RkKg5wmcTvSc7Opuqkagiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="166646558"
Received: from lkp-server01.sh.intel.com (HELO 160750d4a34c) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 28 Jul 2025 10:34:22 -0700
Received: from kbuild by 160750d4a34c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ugRjv-0000dF-0v;
	Mon, 28 Jul 2025 17:34:19 +0000
Date: Tue, 29 Jul 2025 01:33:46 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/cpu] BUILD SUCCESS
 5bf2f5119b9e957f773a22f226974166b58cff32
Message-ID: <202507290135.Q61L82WG-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cpu
branch HEAD: 5bf2f5119b9e957f773a22f226974166b58cff32  Merge tag 'v6.16' into x86/cpu, to resolve conflict

elapsed time: 727m

configs tested: 20
configs skipped: 119

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                         allmodconfig    gcc-12
i386                          allnoconfig    gcc-12
i386                         allyesconfig    gcc-12
i386    buildonly-randconfig-001-20250728    gcc-12
i386    buildonly-randconfig-002-20250728    gcc-12
i386    buildonly-randconfig-003-20250728    gcc-12
i386    buildonly-randconfig-004-20250728    clang-20
i386    buildonly-randconfig-005-20250728    gcc-12
i386    buildonly-randconfig-006-20250728    clang-20
i386                            defconfig    clang-20
x86_64                        allnoconfig    clang-20
x86_64                       allyesconfig    clang-20
x86_64  buildonly-randconfig-001-20250728    clang-20
x86_64  buildonly-randconfig-002-20250728    clang-20
x86_64  buildonly-randconfig-003-20250728    clang-20
x86_64  buildonly-randconfig-004-20250728    clang-20
x86_64  buildonly-randconfig-005-20250728    clang-20
x86_64  buildonly-randconfig-006-20250728    gcc-12
x86_64                          defconfig    gcc-11
x86_64                      rhel-9.4-rust    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

