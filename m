Return-Path: <linux-kernel+bounces-693401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C55ADFE88
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jun 2025 09:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5DD43BA8BC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jun 2025 07:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321E624EA90;
	Thu, 19 Jun 2025 07:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OmwLbtVT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259A6242D6E
	for <linux-kernel@vger.kernel.org>; Thu, 19 Jun 2025 07:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750317530; cv=none; b=dO7Jv1GjJ7E2sdtUbXSw25/U2H1Mvj69cH+fyi0Qf87ySvAicwG795VyFTyJSzef4Zrx8f5F56VGZMRHmuiTc4WjG7YF4z3Hp+cVE87FsfBhSIS4Rgi+dluoSIztTiiWlU8cabYqGufuvhlZliMqcc0TQyQrMzbyFIqhmkKRGBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750317530; c=relaxed/simple;
	bh=YHd4xZcBCdKBN8J++MiZTkfPsgwm7PVknj53DY0Zn6A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ctTiB3IBSix6fYrsXgi5YoZFgxEZBuGPSugPAhksPToIAMV2ZRH7RUz1VH974iTQ4j3M7uYed2KHPgQTOaOc2l+LV6Un2NeVAGTfWWMKFDSEA2E23NtL3A92I+kwc4KjInH9J5/Ph3oP6BtN+Y/sFEd1rSMoDMFy0D9L/mbmbLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OmwLbtVT; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750317529; x=1781853529;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YHd4xZcBCdKBN8J++MiZTkfPsgwm7PVknj53DY0Zn6A=;
  b=OmwLbtVTLIKp1IDDac+J8imrJZBABlw31H9rHlv1m+wGxrogMrXtC4N+
   C1YGHIfou+YPjSzPULep8omF8u8PsHzcDkNezRTAR7jwlBg/0w0il3h0w
   YdEsAHb4x7lLPRNwnbp90TKg/cv+nZYBiCroNbQp19vdOGehcL143wbcs
   wztzvPCVfe7u2Sn5x6D/2LkA9G3wrQPHCPLd1CJo3Ujvmip5VIMswMqHh
   G+AYor3eet9YphKx2b2vWPEGxM/XwAw09RMCnp0qA7ZeaGsguyJGBjWao
   E5OXZ6MDUDq9c/GCUATU8BOvk4K8dGqE40mU/aGEOdOOVcDDPetXgkyBf
   w==;
X-CSE-ConnectionGUID: FRNTAtpgTGSGH2TkeD6akQ==
X-CSE-MsgGUID: iwSg4DOzRYqI0k8fHuTxYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="51794283"
X-IronPort-AV: E=Sophos;i="6.16,247,1744095600"; 
   d="scan'208";a="51794283"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2025 00:18:48 -0700
X-CSE-ConnectionGUID: 9Ko/6TgiQOigySm7hs+47A==
X-CSE-MsgGUID: L3X4iJEeRXGTnNg8nOPIog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,247,1744095600"; 
   d="scan'208";a="155124667"
Received: from igk-lkp-server01.igk.intel.com (HELO 28ae90bf6994) ([10.91.175.65])
  by orviesa004.jf.intel.com with ESMTP; 19 Jun 2025 00:18:46 -0700
Received: from kbuild by 28ae90bf6994 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uS9Xg-0001KG-0s;
	Thu, 19 Jun 2025 07:18:36 +0000
Date: Wed, 4 Jun 2025 19:19:49 +0800
From: kernel test robot <lkp@intel.com>
To: Shahab Vahedi <shahab@synopsys.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	Alexei Starovoitov <ast@kernel.org>
Subject: arch/arc/net/bpf_jit_arcv2.c:2236:3: error: label at end of compound
 statement
Message-ID: <202506041921.lFErMU6Q-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5abc7438f1e9d62e91ad775cc83c9594c48d2282
commit: f122668ddcce450c2585f0be4bf4478d6fd6176b ARC: Add eBPF JIT support
date:   1 year, 1 month ago
config: arc-randconfig-2005-20250604 (https://download.01.org/0day-ci/archive/20250604/202506041921.lFErMU6Q-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250604/202506041921.lFErMU6Q-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506041921.lFErMU6Q-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/arc/net/bpf_jit_arcv2.c: In function 'gen_swap':
>> arch/arc/net/bpf_jit_arcv2.c:2236:3: error: label at end of compound statement
      default:
      ^~~~~~~
   arch/arc/net/bpf_jit_arcv2.c:2254:3: error: label at end of compound statement
      default:
      ^~~~~~~
   arch/arc/net/bpf_jit_arcv2.c: In function 'gen_jmp_64':
   arch/arc/net/bpf_jit_arcv2.c:2867:2: error: label at end of compound statement
     default:
     ^~~~~~~
--
   {standard input}: Assembler messages:
>> {standard input}:32583: Error: flag mismatch for instruction 'mpyd'


vim +2236 arch/arc/net/bpf_jit_arcv2.c

  2199	
  2200	u8 gen_swap(u8 *buf, u8 rd, u8 size, u8 endian, bool force, bool do_zext)
  2201	{
  2202		u8 len = 0;
  2203	#ifdef __BIG_ENDIAN
  2204		const u8 host_endian = BPF_FROM_BE;
  2205	#else
  2206		const u8 host_endian = BPF_FROM_LE;
  2207	#endif
  2208		if (host_endian != endian || force) {
  2209			switch (size) {
  2210			case 16:
  2211				/*
  2212				 * r = B4B3_B2B1 << 16 --> r = B2B1_0000
  2213				 * then, swape(r) would become the desired 0000_B1B2
  2214				 */
  2215				len = arc_asli_r(buf, REG_LO(rd), REG_LO(rd), 16);
  2216				fallthrough;
  2217			case 32:
  2218				len += arc_swape_r(BUF(buf, len), REG_LO(rd));
  2219				if (do_zext)
  2220					len += zext(BUF(buf, len), rd);
  2221				break;
  2222			case 64:
  2223				/*
  2224				 * swap "hi" and "lo":
  2225				 *   hi ^= lo;
  2226				 *   lo ^= hi;
  2227				 *   hi ^= lo;
  2228				 * and then swap the bytes in "hi" and "lo".
  2229				 */
  2230				len  = arc_xor_r(buf, REG_HI(rd), REG_LO(rd));
  2231				len += arc_xor_r(BUF(buf, len), REG_LO(rd), REG_HI(rd));
  2232				len += arc_xor_r(BUF(buf, len), REG_HI(rd), REG_LO(rd));
  2233				len += arc_swape_r(BUF(buf, len), REG_LO(rd));
  2234				len += arc_swape_r(BUF(buf, len), REG_HI(rd));
  2235				break;
> 2236			default:
  2237				/* The caller must have handled this. */
  2238			}
  2239		} else {
  2240			/*
  2241			 * If the same endianness, there's not much to do other
  2242			 * than zeroing out the upper bytes based on the "size".
  2243			 */
  2244			switch (size) {
  2245			case 16:
  2246				len = arc_and_i(buf, REG_LO(rd), 0xffff);
  2247				fallthrough;
  2248			case 32:
  2249				if (do_zext)
  2250					len += zext(BUF(buf, len), rd);
  2251				break;
  2252			case 64:
  2253				break;
  2254			default:
  2255				/* The caller must have handled this. */
  2256			}
  2257		}
  2258	
  2259		return len;
  2260	}
  2261	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

