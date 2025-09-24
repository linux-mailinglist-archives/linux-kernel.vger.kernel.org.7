Return-Path: <linux-kernel+bounces-830341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F838B996F7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BF9B16A327
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3342C235F;
	Wed, 24 Sep 2025 10:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CJmHICuz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C372DF131
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 10:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758709897; cv=none; b=JfkXCupgRuQ3xDeGwotc8SSe9KLYsbGr12yLhkbYBIIIBSYgpnq+grbo64hxpRmwUJsncrzddYfTxwgb7PeKxmkzAl25prBWl7OSDMwSj2anAUAeJkL7Wl4v07Ah6FwteJgjCMFJgG8PlZ1+WqGfRlvBwZWakwC4GCiHgUHbnzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758709897; c=relaxed/simple;
	bh=YS5gq2sJy5pCLzSnXC+FMViysSGZ94AbURL0UpJg0hU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GGoOvGzO9J3DxTUISI0Xi98rK6Vli6KtttZ7rd3xWsykpr/qPvk1izKn0xecGRz0l6Jic6iXnX4nPN+NVeDnvuMzuAgUvEr5D+QWz4Q5CTJrmw3eclpSi9OinxTRL2Pr5QBGQ8ngyrW4cMEIqqKGgOyhLbFfCCQZYu5w+5Cr0Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CJmHICuz; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758709895; x=1790245895;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YS5gq2sJy5pCLzSnXC+FMViysSGZ94AbURL0UpJg0hU=;
  b=CJmHICuzT4DmXeSnsp2PZrq4/7Jks+SRkSUgy2ISY6TS21mgRoRnJ9cn
   T+GsuTvO36JM/V2rUMGtrwJfs6WbTRdwVPHJvGgmQLFmo/HJ6yAwQngrN
   2kAVE4ujZG/zezhdu9eQ1iqaSSZiBKmi6FTBVacoKoXyJZayI3npiwX8O
   bHyPbt5ja4sfmAxnFYxFkIi1I6ebTP/vmOcyep3qVGZjOIDGR/bC+ZmDi
   Al1veevlOOBvsi6ERneg4gxWtWsV8pyO9bPG3nTbJWf4XcC29AHN25K40
   l7Uw720su6d/1sVM9xq3QB61TVxvZw2n78KaKz6BHgNrZ0djNuzNTg9CV
   w==;
X-CSE-ConnectionGUID: GYp/WW6FQvWsAzm0EWKtzQ==
X-CSE-MsgGUID: em/8yaH3ScGD55lCPbLnmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="60042393"
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="60042393"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 03:31:34 -0700
X-CSE-ConnectionGUID: M8QbL6bGR2elKd2lxEy03w==
X-CSE-MsgGUID: mUqrN4rNRmCo6rSHssA3yQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="177446367"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 24 Sep 2025 03:31:32 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v1MmY-00043M-27;
	Wed, 24 Sep 2025 10:31:30 +0000
Date: Wed, 24 Sep 2025 18:30:53 +0800
From: kernel test robot <lkp@intel.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Brown <broonie@kernel.org>
Subject: arch/arm64/kernel/signal.c:1300: undefined reference to
 `preserve_gcs_context'
Message-ID: <202509241856.XvV8zSHD-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Robin,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   cec1e6e5d1ab33403b809f79cd20d6aff124ccfe
commit: f00b53f1614f7be554fd28b9594ef4e63e2686c5 arm64: cpufeature: Add GCS to cpucap_is_possible()
date:   10 months ago
config: arm64-randconfig-r132-20250924 (https://download.01.org/0day-ci/archive/20250924/202509241856.XvV8zSHD-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 10.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250924/202509241856.XvV8zSHD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509241856.XvV8zSHD-lkp@intel.com/

All errors (new ones prefixed by >>):

   aarch64-linux-ld: Unexpected GOT/PLT entries detected!
   aarch64-linux-ld: Unexpected run-time procedure linkages detected!
   aarch64-linux-ld: arch/arm64/kernel/signal.o: in function `setup_sigframe':
>> arch/arm64/kernel/signal.c:1300: undefined reference to `preserve_gcs_context'
   aarch64-linux-ld: arch/arm64/kernel/signal.o: in function `restore_sigframe':
>> arch/arm64/kernel/signal.c:1042: undefined reference to `restore_gcs_context'


vim +1300 arch/arm64/kernel/signal.c

bb4891a6c3551f Dave Martin      2017-06-15  1258  
20987de3c2c45c Dave Martin      2017-06-15  1259  static int setup_sigframe(struct rt_sigframe_user_layout *user,
2e8a1acea8597f Kevin Brodsky    2024-10-29  1260  			  struct pt_regs *regs, sigset_t *set,
2e8a1acea8597f Kevin Brodsky    2024-10-29  1261  			  const struct user_access_state *ua_state)
2c020ed8d148f7 Catalin Marinas  2012-03-05  1262  {
2c020ed8d148f7 Catalin Marinas  2012-03-05  1263  	int i, err = 0;
20987de3c2c45c Dave Martin      2017-06-15  1264  	struct rt_sigframe __user *sf = user->sigframe;
2c020ed8d148f7 Catalin Marinas  2012-03-05  1265  
304ef4e8367244 Will Deacon      2012-11-23  1266  	/* set up the stack frame for unwinding */
20987de3c2c45c Dave Martin      2017-06-15  1267  	__put_user_error(regs->regs[29], &user->next_frame->fp, err);
20987de3c2c45c Dave Martin      2017-06-15  1268  	__put_user_error(regs->regs[30], &user->next_frame->lr, err);
304ef4e8367244 Will Deacon      2012-11-23  1269  
2c020ed8d148f7 Catalin Marinas  2012-03-05  1270  	for (i = 0; i < 31; i++)
2c020ed8d148f7 Catalin Marinas  2012-03-05  1271  		__put_user_error(regs->regs[i], &sf->uc.uc_mcontext.regs[i],
2c020ed8d148f7 Catalin Marinas  2012-03-05  1272  				 err);
2c020ed8d148f7 Catalin Marinas  2012-03-05  1273  	__put_user_error(regs->sp, &sf->uc.uc_mcontext.sp, err);
2c020ed8d148f7 Catalin Marinas  2012-03-05  1274  	__put_user_error(regs->pc, &sf->uc.uc_mcontext.pc, err);
2c020ed8d148f7 Catalin Marinas  2012-03-05  1275  	__put_user_error(regs->pstate, &sf->uc.uc_mcontext.pstate, err);
2c020ed8d148f7 Catalin Marinas  2012-03-05  1276  
2c020ed8d148f7 Catalin Marinas  2012-03-05  1277  	__put_user_error(current->thread.fault_address, &sf->uc.uc_mcontext.fault_address, err);
2c020ed8d148f7 Catalin Marinas  2012-03-05  1278  
2c020ed8d148f7 Catalin Marinas  2012-03-05  1279  	err |= __copy_to_user(&sf->uc.uc_sigmask, set, sizeof(*set));
2c020ed8d148f7 Catalin Marinas  2012-03-05  1280  
6d502b6ba1b267 Suzuki K Poulose 2020-01-13  1281  	if (err == 0 && system_supports_fpsimd()) {
bb4891a6c3551f Dave Martin      2017-06-15  1282  		struct fpsimd_context __user *fpsimd_ctx =
bb4891a6c3551f Dave Martin      2017-06-15  1283  			apply_user_offset(user, user->fpsimd_offset);
0e0276d1e1dd06 Catalin Marinas  2014-04-04  1284  		err |= preserve_fpsimd_context(fpsimd_ctx);
0e0276d1e1dd06 Catalin Marinas  2014-04-04  1285  	}
2c020ed8d148f7 Catalin Marinas  2012-03-05  1286  
15af1942dd61ee Catalin Marinas  2013-09-16  1287  	/* fault information, if valid */
bb4891a6c3551f Dave Martin      2017-06-15  1288  	if (err == 0 && user->esr_offset) {
bb4891a6c3551f Dave Martin      2017-06-15  1289  		struct esr_context __user *esr_ctx =
bb4891a6c3551f Dave Martin      2017-06-15  1290  			apply_user_offset(user, user->esr_offset);
bb4891a6c3551f Dave Martin      2017-06-15  1291  
15af1942dd61ee Catalin Marinas  2013-09-16  1292  		__put_user_error(ESR_MAGIC, &esr_ctx->head.magic, err);
15af1942dd61ee Catalin Marinas  2013-09-16  1293  		__put_user_error(sizeof(*esr_ctx), &esr_ctx->head.size, err);
15af1942dd61ee Catalin Marinas  2013-09-16  1294  		__put_user_error(current->thread.fault_code, &esr_ctx->esr, err);
15af1942dd61ee Catalin Marinas  2013-09-16  1295  	}
15af1942dd61ee Catalin Marinas  2013-09-16  1296  
16f47bb9ac8afe Mark Brown       2024-10-01  1297  	if (system_supports_gcs() && err == 0 && user->gcs_offset) {
16f47bb9ac8afe Mark Brown       2024-10-01  1298  		struct gcs_context __user *gcs_ctx =
16f47bb9ac8afe Mark Brown       2024-10-01  1299  			apply_user_offset(user, user->gcs_offset);
16f47bb9ac8afe Mark Brown       2024-10-01 @1300  		err |= preserve_gcs_context(gcs_ctx);
16f47bb9ac8afe Mark Brown       2024-10-01  1301  	}
16f47bb9ac8afe Mark Brown       2024-10-01  1302  
85ed24dad2904f Mark Brown       2022-04-19  1303  	/* Scalable Vector Extension state (including streaming), if present */
85ed24dad2904f Mark Brown       2022-04-19  1304  	if ((system_supports_sve() || system_supports_sme()) &&
85ed24dad2904f Mark Brown       2022-04-19  1305  	    err == 0 && user->sve_offset) {
8cd969d28fd284 Dave Martin      2017-10-31  1306  		struct sve_context __user *sve_ctx =
8cd969d28fd284 Dave Martin      2017-10-31  1307  			apply_user_offset(user, user->sve_offset);
8cd969d28fd284 Dave Martin      2017-10-31  1308  		err |= preserve_sve_context(sve_ctx);
8cd969d28fd284 Dave Martin      2017-10-31  1309  	}
8cd969d28fd284 Dave Martin      2017-10-31  1310  
39e54499280f37 Mark Brown       2022-12-27  1311  	/* TPIDR2 if supported */
e9d14f3f3fb76c Dongxu Sun       2023-03-17  1312  	if (system_supports_tpidr2() && err == 0) {
39e54499280f37 Mark Brown       2022-12-27  1313  		struct tpidr2_context __user *tpidr2_ctx =
39e54499280f37 Mark Brown       2022-12-27  1314  			apply_user_offset(user, user->tpidr2_offset);
39e54499280f37 Mark Brown       2022-12-27  1315  		err |= preserve_tpidr2_context(tpidr2_ctx);
39e54499280f37 Mark Brown       2022-12-27  1316  	}
39e54499280f37 Mark Brown       2022-12-27  1317  
8c46def44409fc Mark Brown       2024-03-06  1318  	/* FPMR if supported */
8c46def44409fc Mark Brown       2024-03-06  1319  	if (system_supports_fpmr() && err == 0) {
8c46def44409fc Mark Brown       2024-03-06  1320  		struct fpmr_context __user *fpmr_ctx =
8c46def44409fc Mark Brown       2024-03-06  1321  			apply_user_offset(user, user->fpmr_offset);
8c46def44409fc Mark Brown       2024-03-06  1322  		err |= preserve_fpmr_context(fpmr_ctx);
8c46def44409fc Mark Brown       2024-03-06  1323  	}
8c46def44409fc Mark Brown       2024-03-06  1324  
466ece4c6e1952 Kevin Brodsky    2024-10-29  1325  	if (system_supports_poe() && err == 0) {
9160f7e909e179 Joey Gouly       2024-08-22  1326  		struct poe_context __user *poe_ctx =
9160f7e909e179 Joey Gouly       2024-08-22  1327  			apply_user_offset(user, user->poe_offset);
9160f7e909e179 Joey Gouly       2024-08-22  1328  
2e8a1acea8597f Kevin Brodsky    2024-10-29  1329  		err |= preserve_poe_context(poe_ctx, ua_state);
9160f7e909e179 Joey Gouly       2024-08-22  1330  	}
9160f7e909e179 Joey Gouly       2024-08-22  1331  
39782210eb7e87 Mark Brown       2022-04-19  1332  	/* ZA state if present */
39782210eb7e87 Mark Brown       2022-04-19  1333  	if (system_supports_sme() && err == 0 && user->za_offset) {
39782210eb7e87 Mark Brown       2022-04-19  1334  		struct za_context __user *za_ctx =
39782210eb7e87 Mark Brown       2022-04-19  1335  			apply_user_offset(user, user->za_offset);
39782210eb7e87 Mark Brown       2022-04-19  1336  		err |= preserve_za_context(za_ctx);
39782210eb7e87 Mark Brown       2022-04-19  1337  	}
39782210eb7e87 Mark Brown       2022-04-19  1338  
ee072cf708048c Mark Brown       2023-01-16  1339  	/* ZT state if present */
ee072cf708048c Mark Brown       2023-01-16  1340  	if (system_supports_sme2() && err == 0 && user->zt_offset) {
ee072cf708048c Mark Brown       2023-01-16  1341  		struct zt_context __user *zt_ctx =
ee072cf708048c Mark Brown       2023-01-16  1342  			apply_user_offset(user, user->zt_offset);
ee072cf708048c Mark Brown       2023-01-16  1343  		err |= preserve_zt_context(zt_ctx);
ee072cf708048c Mark Brown       2023-01-16  1344  	}
ee072cf708048c Mark Brown       2023-01-16  1345  
33f082614c3443 Dave Martin      2017-06-20  1346  	if (err == 0 && user->extra_offset) {
33f082614c3443 Dave Martin      2017-06-20  1347  		char __user *sfp = (char __user *)user->sigframe;
33f082614c3443 Dave Martin      2017-06-20  1348  		char __user *userp =
33f082614c3443 Dave Martin      2017-06-20  1349  			apply_user_offset(user, user->extra_offset);
33f082614c3443 Dave Martin      2017-06-20  1350  
33f082614c3443 Dave Martin      2017-06-20  1351  		struct extra_context __user *extra;
33f082614c3443 Dave Martin      2017-06-20  1352  		struct _aarch64_ctx __user *end;
33f082614c3443 Dave Martin      2017-06-20  1353  		u64 extra_datap;
33f082614c3443 Dave Martin      2017-06-20  1354  		u32 extra_size;
33f082614c3443 Dave Martin      2017-06-20  1355  
33f082614c3443 Dave Martin      2017-06-20  1356  		extra = (struct extra_context __user *)userp;
33f082614c3443 Dave Martin      2017-06-20  1357  		userp += EXTRA_CONTEXT_SIZE;
33f082614c3443 Dave Martin      2017-06-20  1358  
33f082614c3443 Dave Martin      2017-06-20  1359  		end = (struct _aarch64_ctx __user *)userp;
33f082614c3443 Dave Martin      2017-06-20  1360  		userp += TERMINATOR_SIZE;
33f082614c3443 Dave Martin      2017-06-20  1361  
33f082614c3443 Dave Martin      2017-06-20  1362  		/*
33f082614c3443 Dave Martin      2017-06-20  1363  		 * extra_datap is just written to the signal frame.
33f082614c3443 Dave Martin      2017-06-20  1364  		 * The value gets cast back to a void __user *
33f082614c3443 Dave Martin      2017-06-20  1365  		 * during sigreturn.
33f082614c3443 Dave Martin      2017-06-20  1366  		 */
33f082614c3443 Dave Martin      2017-06-20  1367  		extra_datap = (__force u64)userp;
33f082614c3443 Dave Martin      2017-06-20  1368  		extra_size = sfp + round_up(user->size, 16) - userp;
33f082614c3443 Dave Martin      2017-06-20  1369  
33f082614c3443 Dave Martin      2017-06-20  1370  		__put_user_error(EXTRA_MAGIC, &extra->head.magic, err);
33f082614c3443 Dave Martin      2017-06-20  1371  		__put_user_error(EXTRA_CONTEXT_SIZE, &extra->head.size, err);
33f082614c3443 Dave Martin      2017-06-20  1372  		__put_user_error(extra_datap, &extra->datap, err);
33f082614c3443 Dave Martin      2017-06-20  1373  		__put_user_error(extra_size, &extra->size, err);
33f082614c3443 Dave Martin      2017-06-20  1374  
33f082614c3443 Dave Martin      2017-06-20  1375  		/* Add the terminator */
33f082614c3443 Dave Martin      2017-06-20  1376  		__put_user_error(0, &end->magic, err);
33f082614c3443 Dave Martin      2017-06-20  1377  		__put_user_error(0, &end->size, err);
33f082614c3443 Dave Martin      2017-06-20  1378  	}
33f082614c3443 Dave Martin      2017-06-20  1379  
2c020ed8d148f7 Catalin Marinas  2012-03-05  1380  	/* set the "end" magic */
bb4891a6c3551f Dave Martin      2017-06-15  1381  	if (err == 0) {
bb4891a6c3551f Dave Martin      2017-06-15  1382  		struct _aarch64_ctx __user *end =
bb4891a6c3551f Dave Martin      2017-06-15  1383  			apply_user_offset(user, user->end_offset);
bb4891a6c3551f Dave Martin      2017-06-15  1384  
0e0276d1e1dd06 Catalin Marinas  2014-04-04  1385  		__put_user_error(0, &end->magic, err);
0e0276d1e1dd06 Catalin Marinas  2014-04-04  1386  		__put_user_error(0, &end->size, err);
bb4891a6c3551f Dave Martin      2017-06-15  1387  	}
2c020ed8d148f7 Catalin Marinas  2012-03-05  1388  
2c020ed8d148f7 Catalin Marinas  2012-03-05  1389  	return err;
2c020ed8d148f7 Catalin Marinas  2012-03-05  1390  }
2c020ed8d148f7 Catalin Marinas  2012-03-05  1391  

:::::: The code at line 1300 was first introduced by commit
:::::: 16f47bb9ac8afe09e7ca14cc53748f779b2a12e0 arm64/signal: Expose GCS state in signal frames

:::::: TO: Mark Brown <broonie@kernel.org>
:::::: CC: Catalin Marinas <catalin.marinas@arm.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

