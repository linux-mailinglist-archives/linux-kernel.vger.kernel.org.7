Return-Path: <linux-kernel+bounces-869027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FAA4C06BD5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 16:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 00C3A4E521E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 14:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E58931577D;
	Fri, 24 Oct 2025 14:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZS9v6yyX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AF82DC78C
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 14:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761316824; cv=none; b=j+UZ/8SorCjrC0iDTwrXjfzc/EJXvCiX9Ldz+rox9xN8QOCl4kNdnieIFiOJboJIc03/7nfDSQbYuDtexZto/N7blThvitKbut1px3t/2bI6uuk/Cx7OxAzlMedFaZQJlj/VA2EDtzDp9JafzkCccW8mXr+NxnV1Io4DW8K2e90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761316824; c=relaxed/simple;
	bh=pV5pcCB9vNpyv824WOHMj2E+HmfWIKutqHfUumuUzO0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QfDBl4Rbi5G+RgqF63DCIwMyI2lerAcJ4KHqyqVwyeHd9UA9H4wjgWL17+JQRCUFA29ps7QjtFufQZ7jkEH3oBVzEuNSnFy36Khkon9DnZ+UMYgftVbaaoX+tEIpInCpgA56tOZWysqwJ9Fb6hay8QzYWmVENnusZTyD2FuTzR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZS9v6yyX; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761316823; x=1792852823;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=pV5pcCB9vNpyv824WOHMj2E+HmfWIKutqHfUumuUzO0=;
  b=ZS9v6yyXLxToq33nhzsjOYz9tS9yl65JZjaHqg4jozvkWO02KVaud0P/
   fW/LIUlXNm+2dUYmibmXgdrHsvMjayIyMWnhRWA/c5Np8bBIRmcuwFjbA
   C+SsJoI6L2Oft9x5R3SrBC4iX3dd0VyngLTKa9hCtsyPnDU1S1snPAUUs
   E49su0KwkckcyCDE+AynBYaqqG7Ckmlh799uGuyK15jdLtj3cT+tFFfqk
   fiq4wb2vMDsbRS8spYr1tuVUeZcsramMmbXoSHfFbGIhdFPqKfpi+DACc
   bohfTO80KT/f+ytPwibKWqBQo/uqIUdzWVPFZljxi5YhXJIK75ntUH7uT
   Q==;
X-CSE-ConnectionGUID: a8uqGfcIQdipG19K7JkOvQ==
X-CSE-MsgGUID: VcZ4+5WOTSCkdHDDCVWR1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63399641"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63399641"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 07:40:22 -0700
X-CSE-ConnectionGUID: jzl1ZfFPSFStDMmJdsFrBg==
X-CSE-MsgGUID: /KORfN9JQPW/lKZIDo3sPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,252,1754982000"; 
   d="scan'208";a="221648148"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 24 Oct 2025 07:40:21 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vCIxm-000EYu-31;
	Fri, 24 Oct 2025 14:40:18 +0000
Date: Fri, 24 Oct 2025 22:40:11 +0800
From: kernel test robot <lkp@intel.com>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: fs/9p/vfs_dentry.c:112 __v9fs_lookup_revalidate() warn: inconsistent
 indenting
Message-ID: <202510242207.kbIt1Wet-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6fab32bb6508abbb8b7b1c5498e44f0c32320ed5
commit: 43c36a56ccf6d9b07b4b3f4f614756e687dcdc01 Revert "fs/9p: Refresh metadata in d_revalidate for uncached mode too"
date:   2 days ago
config: x86_64-randconfig-161-20251024 (https://download.01.org/0day-ci/archive/20251024/202510242207.kbIt1Wet-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510242207.kbIt1Wet-lkp@intel.com/

smatch warnings:
fs/9p/vfs_dentry.c:112 __v9fs_lookup_revalidate() warn: inconsistent indenting

vim +112 fs/9p/vfs_dentry.c

    63	
    64	static int __v9fs_lookup_revalidate(struct dentry *dentry, unsigned int flags)
    65	{
    66		struct p9_fid *fid;
    67		struct inode *inode;
    68		struct v9fs_inode *v9inode;
    69	
    70		if (flags & LOOKUP_RCU)
    71			return -ECHILD;
    72	
    73		inode = d_inode(dentry);
    74		if (!inode)
    75			goto out_valid;
    76	
    77		v9inode = V9FS_I(inode);
    78		if (v9inode->cache_validity & V9FS_INO_INVALID_ATTR) {
    79			int retval;
    80			struct v9fs_session_info *v9ses;
    81	
    82			fid = v9fs_fid_lookup(dentry);
    83			if (IS_ERR(fid)) {
    84				p9_debug(
    85					P9_DEBUG_VFS,
    86					"v9fs_fid_lookup: dentry = %pd (%p), got error %pe\n",
    87					dentry, dentry, fid);
    88				return PTR_ERR(fid);
    89			}
    90	
    91			v9ses = v9fs_inode2v9ses(inode);
    92			if (v9fs_proto_dotl(v9ses))
    93				retval = v9fs_refresh_inode_dotl(fid, inode);
    94			else
    95				retval = v9fs_refresh_inode(fid, inode);
    96			p9_fid_put(fid);
    97	
    98			if (retval == -ENOENT) {
    99				p9_debug(P9_DEBUG_VFS, "dentry: %pd (%p) invalidated due to ENOENT\n",
   100					 dentry, dentry);
   101				return 0;
   102			}
   103			if (v9inode->cache_validity & V9FS_INO_INVALID_ATTR) {
   104				p9_debug(P9_DEBUG_VFS, "dentry: %pd (%p) invalidated due to type change\n",
   105					 dentry, dentry);
   106				return 0;
   107			}
   108			if (retval < 0) {
   109				p9_debug(P9_DEBUG_VFS,
   110					"refresh inode: dentry = %pd (%p), got error %pe\n",
   111					dentry, dentry, ERR_PTR(retval));
 > 112			if (retval < 0)
   113				return retval;
   114			}
   115		}
   116	out_valid:
   117		p9_debug(P9_DEBUG_VFS, "dentry: %pd (%p) is valid\n", dentry, dentry);
   118		return 1;
   119	}
   120	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

