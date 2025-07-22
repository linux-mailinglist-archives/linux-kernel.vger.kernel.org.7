Return-Path: <linux-kernel+bounces-741586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C368B0E61C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 00:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DDF31CC112C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 22:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E982877CE;
	Tue, 22 Jul 2025 22:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="egs341Sg"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2022E371F;
	Tue, 22 Jul 2025 22:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753222254; cv=none; b=Rsn54uXRXOjr5JyOqyK8PWuFAgbAPDkC4+3oBtFS+hFjLRr8tCXUk3tafWMEVdkNSpvtayGunCmfp1AJ0UxoId1x81alLC2l8zXnEJsQT2H3HJpKvonoiAUQ7MCZWXwAdVDZEYNdTItKk3lilhHSBUb1uOrVeJay3Q0lTXdJ+d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753222254; c=relaxed/simple;
	bh=C2FBRWKCIQGxWRG+faoXHvCKGguLUFl1fbUyeX1jHAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ol4hZIq5Vh+lrWf+BMc3S5PAgGt+NAa8av2+sgqd6iXo0HI3NYTxNn0mh+qyrLyq2QU8yAU7wusAbpJPsCozLSWwZ5NcWcOCDPLDZlNBxKYm3bYJ0k8dr3t/tGX4X0634frykJPSUpTvNE0Il1b9lQMRnvn6Qnt7Y0sb6X7v/N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=egs341Sg; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753222252; x=1784758252;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=C2FBRWKCIQGxWRG+faoXHvCKGguLUFl1fbUyeX1jHAo=;
  b=egs341SgltMAx73mErYX8Xsd5slB9A+DqXXGRJt6fd630LPoERXfj6Uu
   eRQljL2vWGqcvfv1klIjkqhl9K4LjFZdWyL40nK4+MUe5gB/D6L3pF/sP
   Z/wwHWRWEQetozqffa/YNR2qx8mhv++2s+q1K+htCaFzjshzasKzpW1ml
   Rj79ob9xIPm5dI+1iSpQHdSrvbjl2i0GZSWZDhjc/jdHHusG+hRsEIkF0
   l+bzjqHQJ16wK94m+HSaCFERiUcBRG3DJMNA1PrPAYPPBe5BIHPTamQHT
   Wk7jhskvkJ4ivjQs3j7V7N2VUuygY+Jyv3/wpsnpQCiN/9y2hdl13M67P
   Q==;
X-CSE-ConnectionGUID: AQZNFDy7QUuPECW1prmEAg==
X-CSE-MsgGUID: soyZTpAkSrO8pFeLrH9jZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="54706848"
X-IronPort-AV: E=Sophos;i="6.16,332,1744095600"; 
   d="scan'208";a="54706848"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 15:10:51 -0700
X-CSE-ConnectionGUID: BXbq7hgsRPSplwyEI9nfKg==
X-CSE-MsgGUID: GOe4/IchQK+wBiBY0MImcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,332,1744095600"; 
   d="scan'208";a="158563056"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 22 Jul 2025 15:10:48 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ueLCA-000IkR-1c;
	Tue, 22 Jul 2025 22:10:46 +0000
Date: Wed, 23 Jul 2025 06:10:26 +0800
From: kernel test robot <lkp@intel.com>
To: Arnaud Lecomte <contact@arnaud-lcm.com>, gregkh@linuxfoundation.org
Cc: oe-kbuild-all@lists.linux.dev, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
	snovitoll@gmail.com,
	syzbot+86b6d7c8bcc66747c505@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com, contact@arnaud-lcm.com
Subject: Re: [PATCH] usb: mon: Fix slab-out-of-bounds in mon_bin_event due to
 unsafe URB transfer_buffer access
Message-ID: <202507230548.g6zwppI6-lkp@intel.com>
References: <20250720200057.19720-1-contact@arnaud-lcm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250720200057.19720-1-contact@arnaud-lcm.com>

Hi Arnaud,

kernel test robot noticed the following build warnings:

[auto build test WARNING on usb/usb-testing]
[also build test WARNING on usb/usb-next usb/usb-linus westeri-thunderbolt/next linus/master v6.16-rc7 next-20250722]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Arnaud-Lecomte/usb-mon-Fix-slab-out-of-bounds-in-mon_bin_event-due-to-unsafe-URB-transfer_buffer-access/20250721-040222
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/20250720200057.19720-1-contact%40arnaud-lcm.com
patch subject: [PATCH] usb: mon: Fix slab-out-of-bounds in mon_bin_event due to unsafe URB transfer_buffer access
config: m68k-randconfig-r073-20250723 (https://download.01.org/0day-ci/archive/20250723/202507230548.g6zwppI6-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.3.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507230548.g6zwppI6-lkp@intel.com/

smatch warnings:
drivers/usb/mon/mon_bin.c:422 mon_bin_get_data() warn: unsigned 'mon_copy_to_buff(rp, offset, urb->transfer_buffer, length)' is never less than zero.
drivers/usb/mon/mon_bin.c:443 mon_bin_get_data() warn: unsigned 'offset' is never less than zero.

vim +422 drivers/usb/mon/mon_bin.c

   409	
   410	static unsigned int mon_bin_get_data(const struct mon_reader_bin *rp,
   411	    unsigned int offset, struct urb *urb, unsigned int length,
   412	    char *flag)
   413	{
   414		int i;
   415		struct scatterlist *sg;
   416		unsigned int this_len;
   417	
   418		*flag = 0;
   419		if (urb->num_sgs == 0) {
   420			if (
   421				urb->transfer_buffer == NULL ||
 > 422				mon_copy_to_buff(rp, offset, urb->transfer_buffer, length) < 0
   423			) {
   424				*flag = 'Z';
   425				return length;
   426			}
   427			length = 0;
   428	
   429		} else {
   430			/* If IOMMU coalescing occurred, we cannot trust sg_page */
   431			if (urb->transfer_flags & URB_DMA_SG_COMBINED) {
   432				*flag = 'D';
   433				return length;
   434			}
   435	
   436			/* Copy up to the first non-addressable segment */
   437			for_each_sg(urb->sg, sg, urb->num_sgs, i) {
   438				if (length == 0 || PageHighMem(sg_page(sg)))
   439					break;
   440				this_len = min_t(unsigned int, sg->length, length);
   441				offset = mon_copy_to_buff(rp, offset, sg_virt(sg),
   442						this_len);
 > 443				if (offset < 0) {
   444					*flag = 'Z';
   445					return length;
   446				}
   447				length -= this_len;
   448			}
   449			if (i == 0)
   450				*flag = 'D';
   451		}
   452	
   453		return length;
   454	}
   455	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

