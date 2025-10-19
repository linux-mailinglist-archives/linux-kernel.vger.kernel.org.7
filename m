Return-Path: <linux-kernel+bounces-859492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5C4BEDD4B
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 02:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 16FD24E2FC5
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 00:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2414149C41;
	Sun, 19 Oct 2025 00:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jdeFTVj6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0E2433AD
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 00:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760833070; cv=none; b=ZkFh/RfWJ13giWtvyLi+YVNdLyxo0+9kljwYZG7pjbvBLUkC3h4nEJhGMKlcvphLJfVxp8MdpNRDFgsOWAWJcYA3kcmu1QGs+ybaipA482Jwjw4P+K+C6C0GraPafBUkZKZEf50jt/2gLD0jxTxlYl2eR0ifIbhUhc4LXBGAjXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760833070; c=relaxed/simple;
	bh=6YtHTN8JelBYMBjlGGZa5b66hk89NZ8oV757l4sx5rw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ouNhrg8oNd8GSecJ0noOJFTZIplFd5Sor87rwhvgyotl5/6+TAK2tGxSF0tDFEdDjmaobKMIoZ/fbsVZz2hOdw8JVcolUxw2d+ZCvizky11h3hOBwLxU9Q4rbjFlt6J3EednfvS+I8gFMyAcJKxdRKHMp1dR+ayuC66qwAnNLZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jdeFTVj6; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760833068; x=1792369068;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6YtHTN8JelBYMBjlGGZa5b66hk89NZ8oV757l4sx5rw=;
  b=jdeFTVj6y2+eCRsKsjuDfJuAkt8+KwbLi2NuC+3txjkdxBtaWznpBNek
   acjxDj9+sjm0QBBU6QfAR9ax28jxODY5sfywVAf/JkBzBvME6hePxpQQJ
   3lxMSDoRnAVJDdXHdT4CQ94naBRWdvkCTEDXxP4AhAL0lpqnSLQaVH1OP
   PF0BE/60NywTapJg4sMTPMcddPhfDSuykS3O8ZgiaWFYiiAC3HlYDy/ec
   Z224kXnkd/mYJw93pSVBBKZPD7MAMSXbBthyezmzgxuCGHNBQhabzdXrj
   aHZmiC9V4ePiJkWdYh9wRAER1w5gTXIbJwQn0t0wFUVxVZPgjw06hFv4E
   w==;
X-CSE-ConnectionGUID: /pqxawfWQ8mUVATJqMfYdQ==
X-CSE-MsgGUID: haDZ00ruTg+9og/MjzuuPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="88474315"
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="88474315"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 17:17:48 -0700
X-CSE-ConnectionGUID: 89UPFPtkTe2sp2zu+qXINw==
X-CSE-MsgGUID: ZMG2vYG5S+qbzEJNEEIpWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="183517395"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 18 Oct 2025 17:17:46 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vAH7I-0008iT-18;
	Sun, 19 Oct 2025 00:17:44 +0000
Date: Sun, 19 Oct 2025 08:17:36 +0800
From: kernel test robot <lkp@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Lee Trager <lee@trager.us>,
	Simon Horman <horms@kernel.org>
Subject: drivers/net/ethernet/meta/fbnic/fbnic_tlv.h:83:24: warning:
 conversion from 'long unsigned int' to 'u16' {aka 'short unsigned int'}
 changes value from '261632' to '65024'
Message-ID: <202510190832.3SQkTCHe-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1c64efcb083c48c85227cb4d72ab137feef2cdac
commit: 005a54722e9d493be58405a77f2a444e06f03be0 eth: fbnic: add FW health reporter
date:   4 weeks ago
config: powerpc-randconfig-002-20251019 (https://download.01.org/0day-ci/archive/20251019/202510190832.3SQkTCHe-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 10.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251019/202510190832.3SQkTCHe-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510190832.3SQkTCHe-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/net/ethernet/meta/fbnic/fbnic_devlink.c:12:
   drivers/net/ethernet/meta/fbnic/fbnic_devlink.c: In function 'fbnic_fw_reporter_dump':
>> drivers/net/ethernet/meta/fbnic/fbnic_tlv.h:83:24: warning: conversion from 'long unsigned int' to 'u16' {aka 'short unsigned int'} changes value from '261632' to '65024' [-Woverflow]
      83 | #define TLV_MAX_DATA   (PAGE_SIZE - 512)
         |                        ^
   drivers/net/ethernet/meta/fbnic/fbnic_devlink.c:429:31: note: in expansion of macro 'TLV_MAX_DATA'
     429 |  fw_cmpl->u.coredump.stride = TLV_MAX_DATA;
         |                               ^~~~~~~~~~~~


vim +83 drivers/net/ethernet/meta/fbnic/fbnic_tlv.h

c6203e678cc9a5 Alexander Duyck 2024-07-12  82  
c6203e678cc9a5 Alexander Duyck 2024-07-12 @83  #define TLV_MAX_DATA			(PAGE_SIZE - 512)
c6203e678cc9a5 Alexander Duyck 2024-07-12  84  #define FBNIC_TLV_ATTR_ID_UNKNOWN	USHRT_MAX
c6203e678cc9a5 Alexander Duyck 2024-07-12  85  #define FBNIC_TLV_ATTR_STRING(id, len)	{ id, len, FBNIC_TLV_STRING }
c6203e678cc9a5 Alexander Duyck 2024-07-12  86  #define FBNIC_TLV_ATTR_FLAG(id)		{ id, 0, FBNIC_TLV_FLAG }
c6203e678cc9a5 Alexander Duyck 2024-07-12  87  #define FBNIC_TLV_ATTR_U32(id)		{ id, sizeof(u32), FBNIC_TLV_UNSIGNED }
c6203e678cc9a5 Alexander Duyck 2024-07-12  88  #define FBNIC_TLV_ATTR_U64(id)		{ id, sizeof(u64), FBNIC_TLV_UNSIGNED }
c6203e678cc9a5 Alexander Duyck 2024-07-12  89  #define FBNIC_TLV_ATTR_S32(id)		{ id, sizeof(s32), FBNIC_TLV_SIGNED }
c6203e678cc9a5 Alexander Duyck 2024-07-12  90  #define FBNIC_TLV_ATTR_S64(id)		{ id, sizeof(s64), FBNIC_TLV_SIGNED }
c6203e678cc9a5 Alexander Duyck 2024-07-12  91  #define FBNIC_TLV_ATTR_MAC_ADDR(id)	{ id, ETH_ALEN, FBNIC_TLV_BINARY }
c6203e678cc9a5 Alexander Duyck 2024-07-12  92  #define FBNIC_TLV_ATTR_NESTED(id)	{ id, 0, FBNIC_TLV_NESTED }
c6203e678cc9a5 Alexander Duyck 2024-07-12  93  #define FBNIC_TLV_ATTR_ARRAY(id)	{ id, 0, FBNIC_TLV_ARRAY }
c6203e678cc9a5 Alexander Duyck 2024-07-12  94  #define FBNIC_TLV_ATTR_RAW_DATA(id)	{ id, TLV_MAX_DATA, FBNIC_TLV_BINARY }
c6203e678cc9a5 Alexander Duyck 2024-07-12  95  #define FBNIC_TLV_ATTR_LAST		{ FBNIC_TLV_ATTR_ID_UNKNOWN, 0, 0 }
c6203e678cc9a5 Alexander Duyck 2024-07-12  96  

:::::: The code at line 83 was first introduced by commit
:::::: c6203e678cc9a5bf01ec7ae382851f504870777f eth: fbnic: Add message parsing for FW messages

:::::: TO: Alexander Duyck <alexanderduyck@fb.com>
:::::: CC: Jakub Kicinski <kuba@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

