Return-Path: <linux-kernel+bounces-743522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3438B0FFB5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 06:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B4851C84665
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 04:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E27620371E;
	Thu, 24 Jul 2025 04:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jb+3gtTS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B446C1F8EEC
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 04:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753332501; cv=none; b=JQ+O55z3rQJUYb9xC63IxAmBIswrQVRdmz2eFCW7J6vRVTFbQGjX8Vvx/kYHxxSanqfVxOB0teySQiinmRdKy63CIFO6qX+pEHQQRwLxxsS+iKcDGTAiCIW6rcZ2a7WL3X4nXe6aAnE95mszGWL3m+6URGyX8h8WrXM1D3gu06Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753332501; c=relaxed/simple;
	bh=Ki5Hy2E8sloJery7GvJLGY/v5APDUehTnCCyUoyL19k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rvtFW70VU4mUq7E5CjmTDBIN085O+j8wYpGx5XXU3WX2hSFnW7ZDLCE9Wv8Fkb+t/0920EvLQRjyfWkJlxW6dJD4Gh4hfu4f26OU8xaNmbANm5CvK0didGYwdYbxmNSdZjVOJLFVUOAmysPkgF7K7eu00MW8hX9lKGhlS8O/0GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jb+3gtTS; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753332500; x=1784868500;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Ki5Hy2E8sloJery7GvJLGY/v5APDUehTnCCyUoyL19k=;
  b=jb+3gtTSIrfWIB54s8WxWy8u4p0O78pJnU+YUcerUkgcHJFsB7vc+tjU
   wME5UTmRK5MRkneqcvW/Mp8MBe7rP2/JSVOywsFySSCkoh6A0hnPbap8f
   rmVkEEZzBKlHXGDmYZE16/vwauiCSvgYw4yPSeAqCJ7d8EeiX2L//Wg8L
   YvTnCTcamtJhkqq96Rf4lvZ2yxtKW2YegkTHfk/EyrAhEI63QP6SQGco1
   khf/9p691A2VfXGdwcJu4IZRc8WT1++jmf5wO76XASsSEAPCNJW3nW+Yn
   OZGlSC2lVuJXCQ+O97Be1C3yy/JmCKPijVTphY1kCyDmn5qfhoZk1YwWe
   Q==;
X-CSE-ConnectionGUID: SQPMFgd0Qd+Bi8VQK6I/ow==
X-CSE-MsgGUID: /H7t7aEuQPuQycYjdU+z8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="65892155"
X-IronPort-AV: E=Sophos;i="6.16,336,1744095600"; 
   d="scan'208";a="65892155"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 21:48:18 -0700
X-CSE-ConnectionGUID: BiZjj5bJQ7idwhffywmDNg==
X-CSE-MsgGUID: 5SYRgRwrSpiOtpfJhIbd3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,336,1744095600"; 
   d="scan'208";a="159242001"
Received: from igk-lkp-server01.igk.intel.com (HELO 8b57277650df) ([10.91.175.65])
  by orviesa006.jf.intel.com with ESMTP; 23 Jul 2025 21:48:17 -0700
Received: from kbuild by 8b57277650df with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uensM-0000F7-0p;
	Thu, 24 Jul 2025 04:48:14 +0000
Date: Thu, 24 Jul 2025 06:47:48 +0200
From: kernel test robot <lkp@intel.com>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: /usr/bin/ld: warning: .tmp_vmlinux1 has a LOAD segment with RWX
 permissions
Message-ID: <202507240631.WFG1QqKl-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Masahiro,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   25fae0b93d1d7ddb25958bcb90c3c0e5e0e202bd
commit: b1a9a5e04767e2a78783e19c9e55c25812ceccc3 kbuild: merge temporary vmlinux for BTF and kallsyms
date:   1 year ago
config: um-randconfig-2004-20250724 (https://download.01.org/0day-ci/archive/20250724/202507240631.WFG1QqKl-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 6193dd55535460c347f8c0b794df7d7d52fa78c9)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250724/202507240631.WFG1QqKl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507240631.WFG1QqKl-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> /usr/bin/ld: warning: .tmp_vmlinux1 has a LOAD segment with RWX permissions
>> /usr/bin/ld: warning: .tmp_vmlinux2 has a LOAD segment with RWX permissions
   /usr/bin/ld: warning: vmlinux has a LOAD segment with RWX permissions

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

