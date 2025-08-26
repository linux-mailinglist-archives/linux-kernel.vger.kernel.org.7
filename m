Return-Path: <linux-kernel+bounces-786792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4228BB36A5A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 16:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7275F565406
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 14:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBC835690B;
	Tue, 26 Aug 2025 14:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a8wqbzh3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C88356905
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 14:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756218153; cv=none; b=jWL98CyG4fXx0bhQJ0ZhZO4v2ZGKsEvOwz2n1Gdq3tLItpCoq8TVZuMEkw3D4X5OtdrhUvu6O546/GVKX/E6ehv38diUsgOg7URm3X5Hgws+7o5cbB7PXq3NVIdKsdiso+o7dV/VAIFyD64ZaMweFREpADfJxc+sFEYLTbmnRSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756218153; c=relaxed/simple;
	bh=eAPPXNMt2r8PyCZNmQ80hf+3YDD0lYLkuWsYrf5Nm9g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Gud/iOKwHzAQuKZ2CyZ2nGtCloKM5OypXW/bLd0W6Vzjp6e79mXCK4BT2nRZ82CKZtybT1xnNzR6cvbR6XEGdwdudNhFR43whFIAb6wcS16L7iv0rpr3OKRJIHjwQp28VMQAGL6C6vp7eRMpN3xyKuqL+SOfMUE/7s2y0r+o9ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a8wqbzh3; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756218152; x=1787754152;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eAPPXNMt2r8PyCZNmQ80hf+3YDD0lYLkuWsYrf5Nm9g=;
  b=a8wqbzh3+cFCXS08pAc8CtNCn/IN/Sbt+rh2zTqFRDbggPQaquANAT2b
   MByKoSRzuyMbougxamal9uCzzI2z2FbsGs5Dx0AZSJdhzqdDIY2eRPCEE
   x2nxRDpma+1Fl/YV3ChlTd+HrPMkJoRJ8OATimb4eo7vSa/x1dF30lEAY
   M3UHvpqcDUCkY5FHTJvWlfc2n5lha+o1W+pRnqKbep+F6hAGMgsSE/EPD
   gsREfOl7daiEMiH+DiaCluJToGqynQ5arNNzUmLFV5+hjFXsFSYY7r3C6
   JFig6009b2xRwovDlw2g4ivbCzO66jVzEPWS959caPUVMb4c1f66AuhyI
   A==;
X-CSE-ConnectionGUID: 9qsYVAloQTOCBjfB8XPNuw==
X-CSE-MsgGUID: S+BTrZvZTZaUrgr/am0CGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="58388073"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="58388073"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 07:22:31 -0700
X-CSE-ConnectionGUID: 0jUl7dozSYCzJK3w9wOViQ==
X-CSE-MsgGUID: eqZ0R6QxSQGGrhI/lmeuvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="170407267"
Received: from igk-lkp-server01.igk.intel.com (HELO ca260db0ef79) ([10.91.175.65])
  by fmviesa010.fm.intel.com with ESMTP; 26 Aug 2025 07:22:29 -0700
Received: from kbuild by ca260db0ef79 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uquZ9-0002S3-2T;
	Tue, 26 Aug 2025 14:22:27 +0000
Date: Tue, 26 Aug 2025 16:22:06 +0200
From: kernel test robot <lkp@intel.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Alice Ryhl <aliceryhl@google.com>
Subject: warning: unresolved link to `kernel::drm::Device`
Message-ID: <202508261644.9LclwUgt-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   fab1beda7597fac1cecc01707d55eadb6bbe773c
commit: d6e26c1ae4a602d8b7eeb39e23514f6f98d91eb5 device: rust: expand documentation for Device
date:   2 weeks ago
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20250826/202508261644.9LclwUgt-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250826/202508261644.9LclwUgt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508261644.9LclwUgt-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> warning: unresolved link to `kernel::drm::Device`
   --> rust/kernel/device.rs:154:22
   |
   154 | /// [`drm::Device`]: kernel::drm::Device
   |                      ^^^^^^^^^^^^^^^^^^^ no item named `drm` in module `kernel`
   |
   = note: `#[warn(rustdoc::broken_intra_doc_links)]` on by default

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

