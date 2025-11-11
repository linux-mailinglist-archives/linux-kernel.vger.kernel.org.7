Return-Path: <linux-kernel+bounces-895022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A66C4CB8F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EDA01885A03
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22D02EBBAF;
	Tue, 11 Nov 2025 09:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C0Sfp0tY"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513342EDD63
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 09:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762854017; cv=none; b=huRq2LN/U2QCWar21MpWSGin7NlkJohbVDp37RZ+MpVvWo2OkQBeJP8qxiCMwl9+6fE30YA4BT4xw04PwjMOKGdHYSGx5bvCxnfjajJC0yqb1Kil34dDmd0+Lkpgq6NDEmDFITstvDd0rPnUZcESW17hN72zdYj2wSBn3h0GwfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762854017; c=relaxed/simple;
	bh=0XlN1hfbslC30BvQG9RAGDVDbjrdUmeNj1psqbSZSiU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GFWPRIlIjXrD2BN9duaAIv5OWKh6lFzkWEJz82wrOCpdfhT8HTFbnwl3t1gd0G8VIMGT16JBaZ1IGxos6atcznVRd4GH9x6/jckXCMDtSwiJS9nPODsZkRjbM09aT2989y87ZYRoCQyi0JCvRFTxUF0+rJ3lKMRBTrCIbJ8oHOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C0Sfp0tY; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762854015; x=1794390015;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0XlN1hfbslC30BvQG9RAGDVDbjrdUmeNj1psqbSZSiU=;
  b=C0Sfp0tYC0c9C9Z1cp9C2GMcvUEnYEqiowuoOEHirxwDYVNaOFpfQbJS
   dvzPqKAVWZ8uW9viXzPJ4agMLc2q/oOuhUS9zf1V//FZNyY/iaktqvmIX
   liIunVei+2DwUHwVLbQMmKcC5MDd7ENfsCne6HYycKfj5P46fusQUhHzi
   Kc6Hn+xIikN7jWw97rvQm/XIWa+Um1kX6v3B8iT38wjIJg77ggybJrL+J
   FHl4ZAC+JjXx+QyYF0WfAmSb1XNLJ6K6v99zXre14nUrYr/nRa2yxaZPP
   NWp9pNf3r4jhJI464FOj7+EmkC82egz756bTKUosRaToy4oeWGQYgzoHb
   g==;
X-CSE-ConnectionGUID: a/+p7v1BTzig6p/dUDlxdA==
X-CSE-MsgGUID: dkSPDy3VRUSdkbfquowzOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="64797906"
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="64797906"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 01:40:15 -0800
X-CSE-ConnectionGUID: l7fVole9Tp6F6YYmGSCLvQ==
X-CSE-MsgGUID: lsa9c3JGRzGlo0FO/iGpAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="189176176"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 11 Nov 2025 01:40:13 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vIkrD-00031D-1o;
	Tue, 11 Nov 2025 09:40:11 +0000
Date: Tue, 11 Nov 2025 17:39:37 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/wfamnae-next20251110 10/18]
 drivers/scsi/aic94xx/aic94xx_sas.h:323:35: error: field 'ssp_cmd' has
 incomplete type
Message-ID: <202511111702.50G2mceU-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/wfamnae-next20251110
head:   be928bdef109364ada67e15d004067a1770a36f0
commit: fc09359f7ea98c65bfc288e3e37dda0af71652f7 [10/18] scsi: libsas/aci94xx: Avoid multiple -Wflex-array-member-not-at-end warnings
config: sparc-allmodconfig (https://download.01.org/0day-ci/archive/20251111/202511111702.50G2mceU-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251111/202511111702.50G2mceU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511111702.50G2mceU-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/scsi/aic94xx/aic94xx_hwi.h:19,
                    from drivers/scsi/aic94xx/aic94xx_reg.h:13,
                    from drivers/scsi/aic94xx/aic94xx_init.c:21:
>> drivers/scsi/aic94xx/aic94xx_sas.h:323:35: error: field 'ssp_cmd' has incomplete type
     323 |         struct ssp_command_iu_hdr ssp_cmd;
         |                                   ^~~~~~~


vim +/ssp_cmd +323 drivers/scsi/aic94xx/aic94xx_sas.h

   316	
   317	/* This is both ssp_task and long_ssp_task
   318	 */
   319	struct initiate_ssp_task {
   320		u8     proto_conn_rate;	  /* proto:6,4, conn_rate:3,0 */
   321		__le32 total_xfer_len;
   322		struct ssp_frame_hdr  ssp_frame;
 > 323		struct ssp_command_iu_hdr ssp_cmd;
   324		__le16 sister_scb;	  /* 0xFFFF */
   325		__le16 conn_handle;	  /* index to DDB for the intended target */
   326		u8     data_dir;	  /* :1,0 */
   327	#define DATA_DIR_NONE   0x00
   328	#define DATA_DIR_IN     0x01
   329	#define DATA_DIR_OUT    0x02
   330	#define DATA_DIR_BYRECIPIENT 0x03
   331	
   332		u8     _r_a;
   333		u8     retry_count;
   334		u8     _r_b[5];
   335		struct sg_el sg_element[3]; /* 2 real and 1 link */
   336	} __attribute__ ((packed));
   337	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

