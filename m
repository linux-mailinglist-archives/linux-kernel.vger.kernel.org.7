Return-Path: <linux-kernel+bounces-839637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D02ABBB20E5
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 01:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F17E1893AE7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 23:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7377426B742;
	Wed,  1 Oct 2025 23:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j8d7M/Zi"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E7E14A4CC
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 23:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759360321; cv=none; b=CwaA43KAyu6RUE9yqRIeiDhS6+aeobvek1mi80FOsR6TnAnSPXbNQZOwby+guJ5DVFqlz80GHAUqONnUedSmyMdZA8C4neqqBPlH/JFaGaTPRGbD80ldtoLyJ10/bJJaOBxNbejY6mUKwnMVhbz/aQG2PHHqyrm/+nIhEvezyiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759360321; c=relaxed/simple;
	bh=EoVYwOP+p0Ur4QWrj0wTbgfrG7TlL90RvLFDlvdF5Uk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GdKgAGbPStJwJaYdxNwfOuWo6ewVQqRHw0N+d/e+5F/CnZY1e5NlByLdjKQmmRMdQDlI70MzvdgaslxmA2sQEPqVcq7HABwZRGnHlOMcmeA+mqzTrpnfDeifmXVb5f1/LxJcPuaoaP4e1XFI+LBBiVmpTecABAlkFK873nS4YLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j8d7M/Zi; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759360319; x=1790896319;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EoVYwOP+p0Ur4QWrj0wTbgfrG7TlL90RvLFDlvdF5Uk=;
  b=j8d7M/Zi4WRmVRWERYAQqlynHvirbqpTy79ttwnULekzCNerlBTq2Gid
   W+q488I43POT5VooUnPCkb0oTks+7DPxdLvEvHte65CobGRH9nv3meX9C
   ZaDYoESc45/4Wq8McUcvUXm4ymW+xgWDnGVwhEQv3NGo3Lyh19GOXaGiQ
   Bw6W0gPMsbfsGQdvoovT/oqZgQ56WBf0SnolOlEY9IF9uQoJdBbHaODnR
   GF16zg66YJZAiiPFHLCAgJteAi4igQlUQ1kknFhAwcisDbu/eX914hEOX
   OPjO6CdiUXtzYarQTS1/URfDIhY3MsMXe8Sk1phF84lprKkJu2AItAL7K
   w==;
X-CSE-ConnectionGUID: fd35eXmKSFez4X+9FV2z0w==
X-CSE-MsgGUID: FXyF8FfoQk26lswdXO7TvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="60686625"
X-IronPort-AV: E=Sophos;i="6.18,308,1751266800"; 
   d="scan'208";a="60686625"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2025 16:11:59 -0700
X-CSE-ConnectionGUID: hYMZbWhCRnGM0cadoE9SDg==
X-CSE-MsgGUID: K6JnkKeKRbiLkZnMxKEuRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,308,1751266800"; 
   d="scan'208";a="202633185"
Received: from lkp-server01.sh.intel.com (HELO 2f2a1232a4e4) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 01 Oct 2025 16:11:57 -0700
Received: from kbuild by 2f2a1232a4e4 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v45zH-0003Qt-1o;
	Wed, 01 Oct 2025 23:11:55 +0000
Date: Thu, 2 Oct 2025 07:11:53 +0800
From: kernel test robot <lkp@intel.com>
To: syzbot <syzbot+9db318d6167044609878@syzkaller.appspotmail.com>,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: Forwarded: [PATCH] ext4: fix use-after-free in
 ext4_ext_insert_extent()
Message-ID: <202510020639.uRHSs90S-lkp@intel.com>
References: <68dbf53f.a00a0220.102ee.004a.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68dbf53f.a00a0220.102ee.004a.GAE@google.com>

Hi syzbot,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tytso-ext4/dev]
[also build test WARNING on linus/master v6.17 next-20250929]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/syzbot/Forwarded-PATCH-ext4-fix-use-after-free-in-ext4_ext_insert_extent/20250930-232453
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
patch link:    https://lore.kernel.org/r/68dbf53f.a00a0220.102ee.004a.GAE%40google.com
patch subject: Forwarded: [PATCH] ext4: fix use-after-free in ext4_ext_insert_extent()
config: arc-randconfig-r073-20251001 (https://download.01.org/0day-ci/archive/20251002/202510020639.uRHSs90S-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 13.4.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510020639.uRHSs90S-lkp@intel.com/

New smatch warnings:
fs/ext4/extents.c:2089 ext4_ext_insert_extent() warn: inconsistent indenting

Old smatch warnings:
arch/arc/include/asm/thread_info.h:62 current_thread_info() error: uninitialized symbol 'sp'.
fs/ext4/extents.c:4456 ext4_ext_map_blocks() error: uninitialized symbol 'ex'.
fs/ext4/extents.c:4456 ext4_ext_map_blocks() error: uninitialized symbol 'depth'.

vim +2089 fs/ext4/extents.c

  1969	
  1970	/*
  1971	 * ext4_ext_insert_extent:
  1972	 * tries to merge requested extent into the existing extent or
  1973	 * inserts requested extent as new one into the tree,
  1974	 * creating new leaf in the no-space case.
  1975	 */
  1976	struct ext4_ext_path *
  1977	ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
  1978			       struct ext4_ext_path *path,
  1979			       struct ext4_extent *newext, int gb_flags)
  1980	{
  1981		struct ext4_extent_header *eh;
  1982		struct ext4_extent *ex, *fex;
  1983		struct ext4_extent *nearex; /* nearest extent */
  1984		int depth, len, err = 0;
  1985		ext4_lblk_t next;
  1986		int mb_flags = 0, unwritten;
  1987	
  1988		if (gb_flags & EXT4_GET_BLOCKS_DELALLOC_RESERVE)
  1989			mb_flags |= EXT4_MB_DELALLOC_RESERVED;
  1990		if (unlikely(ext4_ext_get_actual_len(newext) == 0)) {
  1991			EXT4_ERROR_INODE(inode, "ext4_ext_get_actual_len(newext) == 0");
  1992			err = -EFSCORRUPTED;
  1993			goto errout;
  1994		}
  1995		depth = ext_depth(inode);
  1996		ex = path[depth].p_ext;
  1997		eh = path[depth].p_hdr;
  1998		if (unlikely(path[depth].p_hdr == NULL)) {
  1999			EXT4_ERROR_INODE(inode, "path[%d].p_hdr == NULL", depth);
  2000			err = -EFSCORRUPTED;
  2001			goto errout;
  2002		}
  2003	
  2004		/* try to insert block into found extent and return */
  2005		if (ex && !(gb_flags & EXT4_GET_BLOCKS_PRE_IO)) {
  2006	
  2007			/*
  2008			 * Try to see whether we should rather test the extent on
  2009			 * right from ex, or from the left of ex. This is because
  2010			 * ext4_find_extent() can return either extent on the
  2011			 * left, or on the right from the searched position. This
  2012			 * will make merging more effective.
  2013			 */
  2014			if (ex < EXT_LAST_EXTENT(eh) &&
  2015			    (le32_to_cpu(ex->ee_block) +
  2016			    ext4_ext_get_actual_len(ex) <
  2017			    le32_to_cpu(newext->ee_block))) {
  2018				ex += 1;
  2019				goto prepend;
  2020			} else if ((ex > EXT_FIRST_EXTENT(eh)) &&
  2021				   (le32_to_cpu(newext->ee_block) +
  2022				   ext4_ext_get_actual_len(newext) <
  2023				   le32_to_cpu(ex->ee_block)))
  2024				ex -= 1;
  2025	
  2026			/* Try to append newex to the ex */
  2027			if (ext4_can_extents_be_merged(inode, ex, newext)) {
  2028				ext_debug(inode, "append [%d]%d block to %u:[%d]%d"
  2029					  "(from %llu)\n",
  2030					  ext4_ext_is_unwritten(newext),
  2031					  ext4_ext_get_actual_len(newext),
  2032					  le32_to_cpu(ex->ee_block),
  2033					  ext4_ext_is_unwritten(ex),
  2034					  ext4_ext_get_actual_len(ex),
  2035					  ext4_ext_pblock(ex));
  2036				err = ext4_ext_get_access(handle, inode,
  2037							  path + depth);
  2038				if (err)
  2039					goto errout;
  2040				unwritten = ext4_ext_is_unwritten(ex);
  2041				ex->ee_len = cpu_to_le16(ext4_ext_get_actual_len(ex)
  2042						+ ext4_ext_get_actual_len(newext));
  2043				if (unwritten)
  2044					ext4_ext_mark_unwritten(ex);
  2045				nearex = ex;
  2046				goto merge;
  2047			}
  2048	
  2049	prepend:
  2050			/* Try to prepend newex to the ex */
  2051			if (ext4_can_extents_be_merged(inode, newext, ex)) {
  2052				ext_debug(inode, "prepend %u[%d]%d block to %u:[%d]%d"
  2053					  "(from %llu)\n",
  2054					  le32_to_cpu(newext->ee_block),
  2055					  ext4_ext_is_unwritten(newext),
  2056					  ext4_ext_get_actual_len(newext),
  2057					  le32_to_cpu(ex->ee_block),
  2058					  ext4_ext_is_unwritten(ex),
  2059					  ext4_ext_get_actual_len(ex),
  2060					  ext4_ext_pblock(ex));
  2061				err = ext4_ext_get_access(handle, inode,
  2062							  path + depth);
  2063				if (err)
  2064					goto errout;
  2065	
  2066				unwritten = ext4_ext_is_unwritten(ex);
  2067				ex->ee_block = newext->ee_block;
  2068				ext4_ext_store_pblock(ex, ext4_ext_pblock(newext));
  2069				ex->ee_len = cpu_to_le16(ext4_ext_get_actual_len(ex)
  2070						+ ext4_ext_get_actual_len(newext));
  2071				if (unwritten)
  2072					ext4_ext_mark_unwritten(ex);
  2073				nearex = ex;
  2074				goto merge;
  2075			}
  2076		}
  2077	
  2078		depth = ext_depth(inode);
  2079		eh = path[depth].p_hdr;
  2080		if (le16_to_cpu(eh->eh_entries) < le16_to_cpu(eh->eh_max))
  2081			goto has_space;
  2082	
  2083		/* probably next leaf has space for us? */
  2084		fex = EXT_LAST_EXTENT(eh);
  2085		next = EXT_MAX_BLOCKS;
  2086		if (le16_to_cpu(eh->eh_magic) != EXT4_EXT_MAGIC ||
  2087		   le16_to_cpu(eh->eh_entries) == 0) {
  2088			EXT4_ERROR_INODE(inode, "corrupted extent header");
> 2089			 err = -EFSCORRUPTED;
  2090			goto errout;
  2091		}
  2092		if (le32_to_cpu(newext->ee_block) > le32_to_cpu(fex->ee_block))
  2093			next = ext4_ext_next_leaf_block(path);
  2094		if (next != EXT_MAX_BLOCKS) {
  2095			struct ext4_ext_path *npath;
  2096	
  2097			ext_debug(inode, "next leaf block - %u\n", next);
  2098			npath = ext4_find_extent(inode, next, NULL, gb_flags);
  2099			if (IS_ERR(npath)) {
  2100				err = PTR_ERR(npath);
  2101				goto errout;
  2102			}
  2103			BUG_ON(npath->p_depth != path->p_depth);
  2104			eh = npath[depth].p_hdr;
  2105			if (le16_to_cpu(eh->eh_entries) < le16_to_cpu(eh->eh_max)) {
  2106				ext_debug(inode, "next leaf isn't full(%d)\n",
  2107					  le16_to_cpu(eh->eh_entries));
  2108				ext4_free_ext_path(path);
  2109				path = npath;
  2110				goto has_space;
  2111			}
  2112			ext_debug(inode, "next leaf has no free space(%d,%d)\n",
  2113				  le16_to_cpu(eh->eh_entries), le16_to_cpu(eh->eh_max));
  2114			ext4_free_ext_path(npath);
  2115		}
  2116	
  2117		/*
  2118		 * There is no free space in the found leaf.
  2119		 * We're gonna add a new leaf in the tree.
  2120		 */
  2121		if (gb_flags & EXT4_GET_BLOCKS_METADATA_NOFAIL)
  2122			mb_flags |= EXT4_MB_USE_RESERVED;
  2123		path = ext4_ext_create_new_leaf(handle, inode, mb_flags, gb_flags,
  2124						path, newext);
  2125		if (IS_ERR(path))
  2126			return path;
  2127		depth = ext_depth(inode);
  2128		eh = path[depth].p_hdr;
  2129	
  2130	has_space:
  2131		nearex = path[depth].p_ext;
  2132	
  2133		err = ext4_ext_get_access(handle, inode, path + depth);
  2134		if (err)
  2135			goto errout;
  2136	
  2137		if (!nearex) {
  2138			/* there is no extent in this leaf, create first one */
  2139			ext_debug(inode, "first extent in the leaf: %u:%llu:[%d]%d\n",
  2140					le32_to_cpu(newext->ee_block),
  2141					ext4_ext_pblock(newext),
  2142					ext4_ext_is_unwritten(newext),
  2143					ext4_ext_get_actual_len(newext));
  2144			nearex = EXT_FIRST_EXTENT(eh);
  2145		} else {
  2146			if (le32_to_cpu(newext->ee_block)
  2147				   > le32_to_cpu(nearex->ee_block)) {
  2148				/* Insert after */
  2149				ext_debug(inode, "insert %u:%llu:[%d]%d before: "
  2150						"nearest %p\n",
  2151						le32_to_cpu(newext->ee_block),
  2152						ext4_ext_pblock(newext),
  2153						ext4_ext_is_unwritten(newext),
  2154						ext4_ext_get_actual_len(newext),
  2155						nearex);
  2156				nearex++;
  2157			} else {
  2158				/* Insert before */
  2159				BUG_ON(newext->ee_block == nearex->ee_block);
  2160				ext_debug(inode, "insert %u:%llu:[%d]%d after: "
  2161						"nearest %p\n",
  2162						le32_to_cpu(newext->ee_block),
  2163						ext4_ext_pblock(newext),
  2164						ext4_ext_is_unwritten(newext),
  2165						ext4_ext_get_actual_len(newext),
  2166						nearex);
  2167			}
  2168			len = EXT_LAST_EXTENT(eh) - nearex + 1;
  2169			if (len > 0) {
  2170				ext_debug(inode, "insert %u:%llu:[%d]%d: "
  2171						"move %d extents from 0x%p to 0x%p\n",
  2172						le32_to_cpu(newext->ee_block),
  2173						ext4_ext_pblock(newext),
  2174						ext4_ext_is_unwritten(newext),
  2175						ext4_ext_get_actual_len(newext),
  2176						len, nearex, nearex + 1);
  2177				memmove(nearex + 1, nearex,
  2178					len * sizeof(struct ext4_extent));
  2179			}
  2180		}
  2181	
  2182		le16_add_cpu(&eh->eh_entries, 1);
  2183		path[depth].p_ext = nearex;
  2184		nearex->ee_block = newext->ee_block;
  2185		ext4_ext_store_pblock(nearex, ext4_ext_pblock(newext));
  2186		nearex->ee_len = newext->ee_len;
  2187	
  2188	merge:
  2189		/* try to merge extents */
  2190		if (!(gb_flags & EXT4_GET_BLOCKS_PRE_IO))
  2191			ext4_ext_try_to_merge(handle, inode, path, nearex);
  2192	
  2193		/* time to correct all indexes above */
  2194		err = ext4_ext_correct_indexes(handle, inode, path);
  2195		if (err)
  2196			goto errout;
  2197	
  2198		err = ext4_ext_dirty(handle, inode, path + path->p_depth);
  2199		if (err)
  2200			goto errout;
  2201	
  2202		return path;
  2203	
  2204	errout:
  2205		ext4_free_ext_path(path);
  2206		return ERR_PTR(err);
  2207	}
  2208	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

