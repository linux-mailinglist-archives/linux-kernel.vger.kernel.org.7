Return-Path: <linux-kernel+bounces-847337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87233BCA903
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 20:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33B871A61FD6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 18:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F41E24BBF0;
	Thu,  9 Oct 2025 18:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SslW039S"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9643D38D
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 18:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760034326; cv=none; b=mEOOTixQMPyG7E1CgsASGB9xFJLFtUXhWIWmt3RSH84QnnNhEe/WQklz2I/AEAuBdaXoXYYEIDJpOWC64QkRFunAFr3stXBq8cORGSmJrMOfZWw/mVweXvgN8Sr4T5ulF/ue/e2QiM2tZYw/z4tDsrvHDuzPoYRyT03c3pVlfu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760034326; c=relaxed/simple;
	bh=jEadZHWyU9PmRj3TJ6TyxC0A8hLQDeXCwDl/o/ivfFs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dxlKJnPnWlukM4Waz1SDeOmAl4LjnfGaak3tKsjjck7itJJoJE/BzEOz9bT6N9IAJkpowjdeymKwbBCEIM8WFPiGnf1GO/PSsJL/1lmGiwy7/cTfOd2hwwgdr2k/Kh+WPad4LSYjXkv0Gw/vHGgAOpaSo52OOy/g1T7QGnC+ox4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SslW039S; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760034325; x=1791570325;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jEadZHWyU9PmRj3TJ6TyxC0A8hLQDeXCwDl/o/ivfFs=;
  b=SslW039SMoBKcB+iWn5LyhDZBnH8sC0FM6fhLXpqxQrWB4lcVL5d8RhA
   ZrIHxU2i7VT4R6fLQZvveCYgTgX/6yQbzCsyyVqi38A3lAYKN5PCq8mR9
   IkMXEN1j53TMqO4PpNOB+J3HyLYOedbht5SGBefVT6DeMnb7VZgtdxba/
   aXlLShb6EQK+6wUOOzznwOLEIc5G2IDBIhhF9TipR8hHj8/mvmxOeO0sw
   N29r7nuaqTeSbCx3Jz/jxCiUxVtno+0Vw2EWCJC0wGe0hIJg1/bmu+XeK
   VPqcCRs690w9p9n1sIOin9XzOkHM39xmiqyNZoTvNkMm66oIl2SQHf7Pg
   g==;
X-CSE-ConnectionGUID: 8KCjKuErTZaGQSSkY7QCLQ==
X-CSE-MsgGUID: IyHwHq+vQB6Nqq5HVTM70A==
X-IronPort-AV: E=McAfee;i="6800,10657,11577"; a="73684628"
X-IronPort-AV: E=Sophos;i="6.19,217,1754982000"; 
   d="scan'208";a="73684628"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 11:25:25 -0700
X-CSE-ConnectionGUID: kVYDhj5iSEeJn1imVOzjcg==
X-CSE-MsgGUID: UDcXBy6USWOEhiwo/zKDjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,217,1754982000"; 
   d="scan'208";a="184807941"
Received: from lkp-server01.sh.intel.com (HELO 6a630e8620ab) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 09 Oct 2025 11:25:22 -0700
Received: from kbuild by 6a630e8620ab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v6vKK-0001Cb-07;
	Thu, 09 Oct 2025 18:25:20 +0000
Date: Fri, 10 Oct 2025 02:25:14 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/wfamnae-next20251002 14/14]
 drivers/scsi/aic94xx/aic94xx_sas.h:323:28: error: field has incomplete type
 'struct ssp_command_iu_hdr'
Message-ID: <202510100232.BV1e8PYX-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/wfamnae-next20251002
head:   7bcbc6fbcc6816b0e3307e1ebab74b01797d0fb6
commit: 7bcbc6fbcc6816b0e3307e1ebab74b01797d0fb6 [14/14] scsi: libsas/aci94xx: Avoid multiple -Wflex-array-member-not-at-end warnings
config: sparc64-randconfig-002-20251009 (https://download.01.org/0day-ci/archive/20251010/202510100232.BV1e8PYX-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 39f292ffa13d7ca0d1edff27ac8fd55024bb4d19)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251010/202510100232.BV1e8PYX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510100232.BV1e8PYX-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/scsi/aic94xx/aic94xx_sds.c:15:
   In file included from drivers/scsi/aic94xx/aic94xx_reg.h:13:
   In file included from drivers/scsi/aic94xx/aic94xx_hwi.h:19:
>> drivers/scsi/aic94xx/aic94xx_sas.h:323:28: error: field has incomplete type 'struct ssp_command_iu_hdr'
     323 |         struct ssp_command_iu_hdr ssp_cmd;
         |                                   ^
   drivers/scsi/aic94xx/aic94xx_sas.h:323:9: note: forward declaration of 'struct ssp_command_iu_hdr'
     323 |         struct ssp_command_iu_hdr ssp_cmd;
         |                ^
   1 error generated.
--
   In file included from drivers/scsi/aic94xx/aic94xx_init.c:21:
   In file included from drivers/scsi/aic94xx/aic94xx_reg.h:13:
   In file included from drivers/scsi/aic94xx/aic94xx_hwi.h:19:
>> drivers/scsi/aic94xx/aic94xx_sas.h:323:28: error: field has incomplete type 'struct ssp_command_iu_hdr'
     323 |         struct ssp_command_iu_hdr ssp_cmd;
         |                                   ^
   drivers/scsi/aic94xx/aic94xx_sas.h:323:9: note: forward declaration of 'struct ssp_command_iu_hdr'
     323 |         struct ssp_command_iu_hdr ssp_cmd;
         |                ^
   drivers/scsi/aic94xx/aic94xx_init.c:741:45: warning: shift count >= width of type [-Wshift-count-overflow]
     741 |         err = dma_set_mask_and_coherent(&dev->dev, DMA_BIT_MASK(64));
         |                                                    ^~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:93:54: note: expanded from macro 'DMA_BIT_MASK'
      93 | #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
         |                                                      ^ ~~~
   1 warning and 1 error generated.
--
   In file included from drivers/scsi/aic94xx/aic94xx_scb.c:13:
   In file included from drivers/scsi/aic94xx/aic94xx_reg.h:13:
   In file included from drivers/scsi/aic94xx/aic94xx_hwi.h:19:
>> drivers/scsi/aic94xx/aic94xx_sas.h:323:28: error: field has incomplete type 'struct ssp_command_iu_hdr'
     323 |         struct ssp_command_iu_hdr ssp_cmd;
         |                                   ^
   drivers/scsi/aic94xx/aic94xx_sas.h:323:9: note: forward declaration of 'struct ssp_command_iu_hdr'
     323 |         struct ssp_command_iu_hdr ssp_cmd;
         |                ^
>> drivers/scsi/aic94xx/aic94xx_scb.c:369:39: error: no member named 'escb' in 'struct scb'
     369 |         struct empty_scb *escb = &ascb->scb->escb;
         |                                   ~~~~~~~~~  ^
>> drivers/scsi/aic94xx/aic94xx_scb.c:631:42: error: no member named 'control_phy' in 'struct scb'
     631 |         struct control_phy *control_phy = &scb->control_phy;
         |                                            ~~~  ^
   drivers/scsi/aic94xx/aic94xx_scb.c:770:42: error: no member named 'control_phy' in 'struct scb'
     770 |         struct control_phy *control_phy = &scb->control_phy;
         |                                            ~~~  ^
   4 errors generated.
--
   In file included from drivers/scsi/aic94xx/aic94xx_task.c:11:
>> drivers/scsi/aic94xx/aic94xx_sas.h:323:28: error: field has incomplete type 'struct ssp_command_iu_hdr'
     323 |         struct ssp_command_iu_hdr ssp_cmd;
         |                                   ^
   drivers/scsi/aic94xx/aic94xx_sas.h:323:9: note: forward declaration of 'struct ssp_command_iu_hdr'
     323 |         struct ssp_command_iu_hdr ssp_cmd;
         |                ^
>> drivers/scsi/aic94xx/aic94xx_task.c:129:33: error: no member named 'ssp_task' in 'struct scb'
     129 |                        le64_to_cpu(ascb->scb->ssp_task.sg_element[0].bus_addr);
         |                                    ~~~~~~~~~  ^
   include/linux/byteorder/generic.h:87:21: note: expanded from macro 'le64_to_cpu'
      87 | #define le64_to_cpu __le64_to_cpu
         |                     ^
   include/uapi/linux/byteorder/big_endian.h:33:59: note: expanded from macro '__le64_to_cpu'
      33 | #define __le64_to_cpu(x) __swab64((__force __u64)(__le64)(x))
         |                                                           ^
   include/uapi/linux/swab.h:131:31: note: expanded from macro '__swab64'
     131 |         (__u64)(__builtin_constant_p(x) ?       \
         |                                      ^
>> drivers/scsi/aic94xx/aic94xx_task.c:129:33: error: no member named 'ssp_task' in 'struct scb'
     129 |                        le64_to_cpu(ascb->scb->ssp_task.sg_element[0].bus_addr);
         |                                    ~~~~~~~~~  ^
   include/linux/byteorder/generic.h:87:21: note: expanded from macro 'le64_to_cpu'
      87 | #define le64_to_cpu __le64_to_cpu
         |                     ^
   include/uapi/linux/byteorder/big_endian.h:33:59: note: expanded from macro '__le64_to_cpu'
      33 | #define __le64_to_cpu(x) __swab64((__force __u64)(__le64)(x))
         |                                                           ^
   include/uapi/linux/swab.h:132:21: note: expanded from macro '__swab64'
     132 |         ___constant_swab64(x) :                 \
         |                            ^
   include/uapi/linux/swab.h:25:12: note: expanded from macro '___constant_swab64'
      25 |         (((__u64)(x) & (__u64)0x00000000000000ffULL) << 56) |   \
         |                   ^
>> drivers/scsi/aic94xx/aic94xx_task.c:129:33: error: no member named 'ssp_task' in 'struct scb'
     129 |                        le64_to_cpu(ascb->scb->ssp_task.sg_element[0].bus_addr);
         |                                    ~~~~~~~~~  ^
   include/linux/byteorder/generic.h:87:21: note: expanded from macro 'le64_to_cpu'
      87 | #define le64_to_cpu __le64_to_cpu
         |                     ^
   include/uapi/linux/byteorder/big_endian.h:33:59: note: expanded from macro '__le64_to_cpu'
      33 | #define __le64_to_cpu(x) __swab64((__force __u64)(__le64)(x))
         |                                                           ^
   include/uapi/linux/swab.h:132:21: note: expanded from macro '__swab64'
     132 |         ___constant_swab64(x) :                 \
         |                            ^
   include/uapi/linux/swab.h:26:12: note: expanded from macro '___constant_swab64'
      26 |         (((__u64)(x) & (__u64)0x000000000000ff00ULL) << 40) |   \
         |                   ^
>> drivers/scsi/aic94xx/aic94xx_task.c:129:33: error: no member named 'ssp_task' in 'struct scb'
     129 |                        le64_to_cpu(ascb->scb->ssp_task.sg_element[0].bus_addr);
         |                                    ~~~~~~~~~  ^
   include/linux/byteorder/generic.h:87:21: note: expanded from macro 'le64_to_cpu'
      87 | #define le64_to_cpu __le64_to_cpu
         |                     ^
   include/uapi/linux/byteorder/big_endian.h:33:59: note: expanded from macro '__le64_to_cpu'
      33 | #define __le64_to_cpu(x) __swab64((__force __u64)(__le64)(x))
         |                                                           ^
   include/uapi/linux/swab.h:132:21: note: expanded from macro '__swab64'
     132 |         ___constant_swab64(x) :                 \
         |                            ^
   include/uapi/linux/swab.h:27:12: note: expanded from macro '___constant_swab64'
      27 |         (((__u64)(x) & (__u64)0x0000000000ff0000ULL) << 24) |   \
         |                   ^
>> drivers/scsi/aic94xx/aic94xx_task.c:129:33: error: no member named 'ssp_task' in 'struct scb'
     129 |                        le64_to_cpu(ascb->scb->ssp_task.sg_element[0].bus_addr);
         |                                    ~~~~~~~~~  ^
   include/linux/byteorder/generic.h:87:21: note: expanded from macro 'le64_to_cpu'
      87 | #define le64_to_cpu __le64_to_cpu
         |                     ^
   include/uapi/linux/byteorder/big_endian.h:33:59: note: expanded from macro '__le64_to_cpu'
      33 | #define __le64_to_cpu(x) __swab64((__force __u64)(__le64)(x))
         |                                                           ^
   include/uapi/linux/swab.h:132:21: note: expanded from macro '__swab64'
     132 |         ___constant_swab64(x) :                 \
         |                            ^
   include/uapi/linux/swab.h:28:12: note: expanded from macro '___constant_swab64'
      28 |         (((__u64)(x) & (__u64)0x00000000ff000000ULL) <<  8) |   \
         |                   ^
>> drivers/scsi/aic94xx/aic94xx_task.c:129:33: error: no member named 'ssp_task' in 'struct scb'
     129 |                        le64_to_cpu(ascb->scb->ssp_task.sg_element[0].bus_addr);
         |                                    ~~~~~~~~~  ^
   include/linux/byteorder/generic.h:87:21: note: expanded from macro 'le64_to_cpu'
      87 | #define le64_to_cpu __le64_to_cpu
         |                     ^
   include/uapi/linux/byteorder/big_endian.h:33:59: note: expanded from macro '__le64_to_cpu'
      33 | #define __le64_to_cpu(x) __swab64((__force __u64)(__le64)(x))
         |                                                           ^
   include/uapi/linux/swab.h:132:21: note: expanded from macro '__swab64'
     132 |         ___constant_swab64(x) :                 \
         |                            ^
   include/uapi/linux/swab.h:29:12: note: expanded from macro '___constant_swab64'
      29 |         (((__u64)(x) & (__u64)0x000000ff00000000ULL) >>  8) |   \
         |                   ^
>> drivers/scsi/aic94xx/aic94xx_task.c:129:33: error: no member named 'ssp_task' in 'struct scb'
     129 |                        le64_to_cpu(ascb->scb->ssp_task.sg_element[0].bus_addr);
         |                                    ~~~~~~~~~  ^
   include/linux/byteorder/generic.h:87:21: note: expanded from macro 'le64_to_cpu'
      87 | #define le64_to_cpu __le64_to_cpu
         |                     ^
   include/uapi/linux/byteorder/big_endian.h:33:59: note: expanded from macro '__le64_to_cpu'
      33 | #define __le64_to_cpu(x) __swab64((__force __u64)(__le64)(x))
         |                                                           ^
   include/uapi/linux/swab.h:132:21: note: expanded from macro '__swab64'
     132 |         ___constant_swab64(x) :                 \
         |                            ^
   include/uapi/linux/swab.h:30:12: note: expanded from macro '___constant_swab64'
      30 |         (((__u64)(x) & (__u64)0x0000ff0000000000ULL) >> 24) |   \
         |                   ^
>> drivers/scsi/aic94xx/aic94xx_task.c:129:33: error: no member named 'ssp_task' in 'struct scb'
     129 |                        le64_to_cpu(ascb->scb->ssp_task.sg_element[0].bus_addr);
         |                                    ~~~~~~~~~  ^
   include/linux/byteorder/generic.h:87:21: note: expanded from macro 'le64_to_cpu'
      87 | #define le64_to_cpu __le64_to_cpu
         |                     ^
   include/uapi/linux/byteorder/big_endian.h:33:59: note: expanded from macro '__le64_to_cpu'
      33 | #define __le64_to_cpu(x) __swab64((__force __u64)(__le64)(x))
         |                                                           ^
   include/uapi/linux/swab.h:132:21: note: expanded from macro '__swab64'
     132 |         ___constant_swab64(x) :                 \
         |                            ^
   include/uapi/linux/swab.h:31:12: note: expanded from macro '___constant_swab64'
      31 |         (((__u64)(x) & (__u64)0x00ff000000000000ULL) >> 40) |   \
         |                   ^
>> drivers/scsi/aic94xx/aic94xx_task.c:129:33: error: no member named 'ssp_task' in 'struct scb'
     129 |                        le64_to_cpu(ascb->scb->ssp_task.sg_element[0].bus_addr);
         |                                    ~~~~~~~~~  ^
   include/linux/byteorder/generic.h:87:21: note: expanded from macro 'le64_to_cpu'
      87 | #define le64_to_cpu __le64_to_cpu
         |                     ^
   include/uapi/linux/byteorder/big_endian.h:33:59: note: expanded from macro '__le64_to_cpu'
      33 | #define __le64_to_cpu(x) __swab64((__force __u64)(__le64)(x))
         |                                                           ^
   include/uapi/linux/swab.h:132:21: note: expanded from macro '__swab64'
     132 |         ___constant_swab64(x) :                 \
         |                            ^
   include/uapi/linux/swab.h:32:12: note: expanded from macro '___constant_swab64'
      32 |         (((__u64)(x) & (__u64)0xff00000000000000ULL) >> 56)))
         |                   ^
>> drivers/scsi/aic94xx/aic94xx_task.c:129:33: error: no member named 'ssp_task' in 'struct scb'
     129 |                        le64_to_cpu(ascb->scb->ssp_task.sg_element[0].bus_addr);
         |                                    ~~~~~~~~~  ^
   include/linux/byteorder/generic.h:87:21: note: expanded from macro 'le64_to_cpu'
      87 | #define le64_to_cpu __le64_to_cpu
         |                     ^
   include/uapi/linux/byteorder/big_endian.h:33:59: note: expanded from macro '__le64_to_cpu'
      33 | #define __le64_to_cpu(x) __swab64((__force __u64)(__le64)(x))
         |                                                           ^
   include/uapi/linux/swab.h:133:12: note: expanded from macro '__swab64'
     133 |         __fswab64(x))
         |                   ^
>> drivers/scsi/aic94xx/aic94xx_task.c:365:7: error: no member named 'ata_task' in 'struct scb'
     365 |         scb->ata_task.proto_conn_rate = (1 << 5); /* STP */
         |         ~~~  ^
   drivers/scsi/aic94xx/aic94xx_task.c:367:8: error: no member named 'ata_task' in 'struct scb'
     367 |                 scb->ata_task.proto_conn_rate |= dev->linkrate;
         |                 ~~~  ^
   drivers/scsi/aic94xx/aic94xx_task.c:369:7: error: no member named 'ata_task' in 'struct scb'
     369 |         scb->ata_task.total_xfer_len = cpu_to_le32(task->total_xfer_len);
         |         ~~~  ^
   drivers/scsi/aic94xx/aic94xx_task.c:370:7: error: no member named 'ata_task' in 'struct scb'
     370 |         scb->ata_task.fis = task->ata_task.fis;
         |         ~~~  ^
   drivers/scsi/aic94xx/aic94xx_task.c:372:8: error: no member named 'ata_task' in 'struct scb'
     372 |                 scb->ata_task.fis.flags |= 0x80; /* C=1: update ATA cmd reg */
         |                 ~~~  ^
   drivers/scsi/aic94xx/aic94xx_task.c:373:7: error: no member named 'ata_task' in 'struct scb'
     373 |         scb->ata_task.fis.flags &= 0xF0; /* PM_PORT field shall be 0 */
         |         ~~~  ^
   drivers/scsi/aic94xx/aic94xx_task.c:375:15: error: no member named 'ata_task' in 'struct scb'
     375 |                 memcpy(scb->ata_task.atapi_packet, task->ata_task.atapi_packet,
         |                        ~~~  ^
   drivers/scsi/aic94xx/aic94xx_task.c:377:7: error: no member named 'ata_task' in 'struct scb'
     377 |         scb->ata_task.sister_scb = cpu_to_le16(0xFFFF);
         |         ~~~  ^
   fatal error: too many errors emitted, stopping now [-ferror-limit=]
   20 errors generated.
--
   In file included from drivers/scsi/aic94xx/aic94xx_tmf.c:12:
>> drivers/scsi/aic94xx/aic94xx_sas.h:323:28: error: field has incomplete type 'struct ssp_command_iu_hdr'
     323 |         struct ssp_command_iu_hdr ssp_cmd;
         |                                   ^
   drivers/scsi/aic94xx/aic94xx_sas.h:323:9: note: forward declaration of 'struct ssp_command_iu_hdr'
     323 |         struct ssp_command_iu_hdr ssp_cmd;
         |                ^
>> drivers/scsi/aic94xx/aic94xx_tmf.c:120:7: error: no member named 'clear_nexus' in 'struct scb'
     120 |         scb->clear_nexus.nexus = NEXUS_ADAPTER;
         |         ~~~  ^
   drivers/scsi/aic94xx/aic94xx_tmf.c:129:7: error: no member named 'clear_nexus' in 'struct scb'
     129 |         scb->clear_nexus.nexus = NEXUS_PORT;
         |         ~~~  ^
   drivers/scsi/aic94xx/aic94xx_tmf.c:130:7: error: no member named 'clear_nexus' in 'struct scb'
     130 |         scb->clear_nexus.conn_mask = port->phy_mask;
         |         ~~~  ^
   drivers/scsi/aic94xx/aic94xx_tmf.c:146:7: error: no member named 'clear_nexus' in 'struct scb'
     146 |         scb->clear_nexus.nexus = NEXUS_I_T;
         |         ~~~  ^
   drivers/scsi/aic94xx/aic94xx_tmf.c:149:8: error: no member named 'clear_nexus' in 'struct scb'
     149 |                 scb->clear_nexus.flags = EXEC_Q | SUSPEND_TX;
         |                 ~~~  ^
   drivers/scsi/aic94xx/aic94xx_tmf.c:152:8: error: no member named 'clear_nexus' in 'struct scb'
     152 |                 scb->clear_nexus.flags = SEND_Q | NOTINQ;
         |                 ~~~  ^
   drivers/scsi/aic94xx/aic94xx_tmf.c:155:8: error: no member named 'clear_nexus' in 'struct scb'
     155 |                 scb->clear_nexus.flags = RESUME_TX;
         |                 ~~~  ^
   drivers/scsi/aic94xx/aic94xx_tmf.c:157:7: error: no member named 'clear_nexus' in 'struct scb'
     157 |         scb->clear_nexus.conn_handle = cpu_to_le16((u16)(unsigned long)
         |         ~~~  ^
   drivers/scsi/aic94xx/aic94xx_tmf.c:206:7: error: no member named 'clear_nexus' in 'struct scb'
     206 |         scb->clear_nexus.nexus = NEXUS_I_T_L;
         |         ~~~  ^
   drivers/scsi/aic94xx/aic94xx_tmf.c:207:7: error: no member named 'clear_nexus' in 'struct scb'
     207 |         scb->clear_nexus.flags = SEND_Q | EXEC_Q | NOTINQ;
         |         ~~~  ^
   drivers/scsi/aic94xx/aic94xx_tmf.c:208:14: error: no member named 'clear_nexus' in 'struct scb'
     208 |         memcpy(scb->clear_nexus.ssp_task.lun, lun, 8);
         |                ~~~  ^
   drivers/scsi/aic94xx/aic94xx_tmf.c:209:7: error: no member named 'clear_nexus' in 'struct scb'
     209 |         scb->clear_nexus.conn_handle = cpu_to_le16((u16)(unsigned long)
         |         ~~~  ^
   drivers/scsi/aic94xx/aic94xx_tmf.c:220:7: error: no member named 'clear_nexus' in 'struct scb'
     220 |         scb->clear_nexus.nexus = NEXUS_TAG;
         |         ~~~  ^
   drivers/scsi/aic94xx/aic94xx_tmf.c:221:14: error: no member named 'clear_nexus' in 'struct scb'
     221 |         memcpy(scb->clear_nexus.ssp_task.lun, task->ssp_task.LUN, 8);
         |                ~~~  ^
   drivers/scsi/aic94xx/aic94xx_tmf.c:222:7: error: no member named 'clear_nexus' in 'struct scb'
     222 |         scb->clear_nexus.ssp_task.tag = tascb->tag;
         |         ~~~  ^
   drivers/scsi/aic94xx/aic94xx_tmf.c:224:8: error: no member named 'clear_nexus' in 'struct scb'
     224 |                 scb->clear_nexus.conn_handle = cpu_to_le16((u16)(unsigned long)
         |                 ~~~  ^
   drivers/scsi/aic94xx/aic94xx_tmf.c:235:7: error: no member named 'clear_nexus' in 'struct scb'
     235 |         scb->clear_nexus.nexus = NEXUS_TRANS_CX;
         |         ~~~  ^
   drivers/scsi/aic94xx/aic94xx_tmf.c:237:8: error: no member named 'clear_nexus' in 'struct scb'
     237 |                 scb->clear_nexus.conn_handle = cpu_to_le16((u16)(unsigned long)
         |                 ~~~  ^
   fatal error: too many errors emitted, stopping now [-ferror-limit=]
   20 errors generated.
--
   In file included from drivers/scsi/aic94xx/aic94xx_hwi.c:16:
   In file included from drivers/scsi/aic94xx/aic94xx_reg.h:13:
   In file included from drivers/scsi/aic94xx/aic94xx_hwi.h:19:
>> drivers/scsi/aic94xx/aic94xx_sas.h:323:28: error: field has incomplete type 'struct ssp_command_iu_hdr'
     323 |         struct ssp_command_iu_hdr ssp_cmd;
         |                                   ^
   drivers/scsi/aic94xx/aic94xx_sas.h:323:9: note: forward declaration of 'struct ssp_command_iu_hdr'
     323 |         struct ssp_command_iu_hdr ssp_cmd;
         |                ^
>> drivers/scsi/aic94xx/aic94xx_hwi.c:344:40: error: no member named 'escb' in 'struct scb'
     344 |                 struct empty_scb *escb = &ascb->scb->escb;
         |                                           ~~~~~~~~~  ^
   2 errors generated.


vim +323 drivers/scsi/aic94xx/aic94xx_sas.h

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

