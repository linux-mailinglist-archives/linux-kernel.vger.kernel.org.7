Return-Path: <linux-kernel+bounces-808216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45511B4FBFA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 241504447DE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0405A3375DA;
	Tue,  9 Sep 2025 13:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GeisLJSh"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE01314B85
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 13:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757422929; cv=none; b=ceLhNBwwpIcV1X6oBIwen6/vJZ469+ZMCeBzdAH/zrWfOrZuZUsOBQ0uZpUAF8UViMKQqE4vIg7TtNCO0NhhWQNgwRVwvqutqU46bKSIselJVzJR8HPJBHoWjnWoUa1KiQrhkoqQdELx6lyMWGDVfCuMZdkXJ6xNJO8XasM/L9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757422929; c=relaxed/simple;
	bh=IMA0hrozi89cCMAFa8tayuZ0jLgUEdMU2u5d1AcjFdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZnZxgDE6zeqZYOyDpxLClDRrd3pGj3EanFs9Gfv7sX+HvCgbWS19J+o+uLBm9xju1Nrc5o/r0mVEUczxhJ79S2DF7R7PS/tUXdj6voH2AxV0f85W/ybsgOEnuGzkI9DXhVHzR2BhsZoO9h0usz/mOrveKJHHkP9pYeXkJh1bEmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GeisLJSh; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757422927; x=1788958927;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IMA0hrozi89cCMAFa8tayuZ0jLgUEdMU2u5d1AcjFdE=;
  b=GeisLJShCOrCPnL+2UjGZKhc75dTYu0haCuugHQRGioTlCLrBxkstpUU
   oPT6StybiFufoZFvaKi4Vr0y8dwZYDFeURCCKgzjVXufSvBWT93AzpmS8
   HLUQXp4huZ/UY7Sl4OS4j9S6Lzc0H8kzd3OpHsGpfwvsYVWc4cPGbBL2V
   RFmbgq+j29EqqDRpNtSRWkizyg1knnr5URUUwxD2m7lQDRj2r51uTmhK0
   ALO+disMwXj41B5RHrjyrnxjiu4uM0TlrsBVq+xiVYAsd4LfBES7tca51
   SRw4wll2VtmVsVHlnfdVj7lHoH48qXwVOWmrmlESDeKo1fzhOMxU8uT2/
   Q==;
X-CSE-ConnectionGUID: jFAn9BFnR8OY7rerkBiTdQ==
X-CSE-MsgGUID: Ff/WyG7gS8eCD8+D7BAqnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11547"; a="62332707"
X-IronPort-AV: E=Sophos;i="6.18,251,1751266800"; 
   d="scan'208";a="62332707"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 06:02:06 -0700
X-CSE-ConnectionGUID: xEPoSo38S5S/y6YfQS7UgQ==
X-CSE-MsgGUID: DxGAStGNTjuqZlrDaEzHWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,251,1751266800"; 
   d="scan'208";a="172250957"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 09 Sep 2025 06:02:00 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uvxyw-0004rz-1o;
	Tue, 09 Sep 2025 13:01:58 +0000
Date: Tue, 9 Sep 2025 21:01:08 +0800
From: kernel test robot <lkp@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com, will@kernel.org,
	robin.murphy@arm.com
Cc: oe-kbuild-all@lists.linux.dev, joro@8bytes.org,
	jean-philippe@linaro.org, miko.lenczewski@arm.com,
	balbirs@nvidia.com, peterz@infradead.org, smostafa@google.com,
	kevin.tian@intel.com, praan@google.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH rfcv2 4/8] iommu/arm-smmu-v3: Introduce a per-domain
 arm_smmu_invs array
Message-ID: <202509092020.mxUyqGcN-lkp@intel.com>
References: <80310b98efa4bd7e95d7b3ca302f40d4d69e59c5.1757373449.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80310b98efa4bd7e95d7b3ca302f40d4d69e59c5.1757373449.git.nicolinc@nvidia.com>

Hi Nicolin,

kernel test robot noticed the following build errors:

[auto build test ERROR on soc/for-next]
[also build test ERROR on linus/master v6.17-rc5 next-20250909]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nicolin-Chen/iommu-arm-smmu-v3-Clear-cmds-num-after-arm_smmu_cmdq_batch_submit/20250909-073052
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
patch link:    https://lore.kernel.org/r/80310b98efa4bd7e95d7b3ca302f40d4d69e59c5.1757373449.git.nicolinc%40nvidia.com
patch subject: [PATCH rfcv2 4/8] iommu/arm-smmu-v3: Introduce a per-domain arm_smmu_invs array
config: arm64-randconfig-003-20250909 (https://download.01.org/0day-ci/archive/20250909/202509092020.mxUyqGcN-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250909/202509092020.mxUyqGcN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509092020.mxUyqGcN-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:1082:23: error: static declaration of 'arm_smmu_invs_merge' follows non-static declaration
    1082 | struct arm_smmu_invs *arm_smmu_invs_merge(struct arm_smmu_invs *invs,
         |                       ^~~~~~~~~~~~~~~~~~~
   In file included from drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:34:
   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h:721:23: note: previous declaration of 'arm_smmu_invs_merge' with type 'struct arm_smmu_invs *(struct arm_smmu_invs *, struct arm_smmu_invs *)'
     721 | struct arm_smmu_invs *arm_smmu_invs_merge(struct arm_smmu_invs *invs,
         |                       ^~~~~~~~~~~~~~~~~~~
>> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:1165:8: error: static declaration of 'arm_smmu_invs_unref' follows non-static declaration
    1165 | size_t arm_smmu_invs_unref(struct arm_smmu_invs *invs,
         |        ^~~~~~~~~~~~~~~~~~~
   In file included from drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:34:
   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h:723:8: note: previous declaration of 'arm_smmu_invs_unref' with type 'size_t(struct arm_smmu_invs *, struct arm_smmu_invs *)' {aka 'long unsigned int(struct arm_smmu_invs *, struct arm_smmu_invs *)'}
     723 | size_t arm_smmu_invs_unref(struct arm_smmu_invs *invs,
         |        ^~~~~~~~~~~~~~~~~~~
>> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:1215:23: error: static declaration of 'arm_smmu_invs_purge' follows non-static declaration
    1215 | struct arm_smmu_invs *arm_smmu_invs_purge(struct arm_smmu_invs *invs,
         |                       ^~~~~~~~~~~~~~~~~~~
   In file included from drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:34:
   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h:725:23: note: previous declaration of 'arm_smmu_invs_purge' with type 'struct arm_smmu_invs *(struct arm_smmu_invs *, size_t)' {aka 'struct arm_smmu_invs *(struct arm_smmu_invs *, long unsigned int)'}
     725 | struct arm_smmu_invs *arm_smmu_invs_purge(struct arm_smmu_invs *invs,
         |                       ^~~~~~~~~~~~~~~~~~~
   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:1215:23: warning: 'arm_smmu_invs_purge' defined but not used [-Wunused-function]
    1215 | struct arm_smmu_invs *arm_smmu_invs_purge(struct arm_smmu_invs *invs,
         |                       ^~~~~~~~~~~~~~~~~~~
   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:1165:8: warning: 'arm_smmu_invs_unref' defined but not used [-Wunused-function]
    1165 | size_t arm_smmu_invs_unref(struct arm_smmu_invs *invs,
         |        ^~~~~~~~~~~~~~~~~~~
   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:1082:23: warning: 'arm_smmu_invs_merge' defined but not used [-Wunused-function]
    1082 | struct arm_smmu_invs *arm_smmu_invs_merge(struct arm_smmu_invs *invs,
         |                       ^~~~~~~~~~~~~~~~~~~


vim +/arm_smmu_invs_merge +1082 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c

  1063	
  1064	/**
  1065	 * arm_smmu_invs_merge() - Merge @to_merge into @invs and generate a new array
  1066	 * @invs: the base invalidation array
  1067	 * @to_merge: an array of invlidations to merge
  1068	 *
  1069	 * Return: a newly allocated array on success, or ERR_PTR
  1070	 *
  1071	 * This function must be locked and serialized with arm_smmu_invs_unref() and
  1072	 * arm_smmu_invs_purge(), but do not lockdep on any lock for KUNIT test.
  1073	 *
  1074	 * Either @invs or @to_merge must be sorted itself. This ensures the returned
  1075	 * array will be sorted as well.
  1076	 *
  1077	 * Caller is resposible for freeing the @invs and the returned new one.
  1078	 *
  1079	 * Entries marked as trash will be purged in the returned array.
  1080	 */
  1081	VISIBLE_IF_KUNIT
> 1082	struct arm_smmu_invs *arm_smmu_invs_merge(struct arm_smmu_invs *invs,
  1083						  struct arm_smmu_invs *to_merge)
  1084	{
  1085		struct arm_smmu_invs *new_invs;
  1086		struct arm_smmu_inv *new;
  1087		size_t num_adds = 0;
  1088		size_t num_dels = 0;
  1089		size_t i, j;
  1090	
  1091		for (i = j = 0; i != invs->num_invs || j != to_merge->num_invs;) {
  1092			int cmp = arm_smmu_invs_merge_cmp(invs, i, to_merge, j);
  1093	
  1094			if (cmp < 0) {
  1095				/* no found in to_merge, leave alone but delete trash */
  1096				if (!refcount_read(&invs->inv[i].users))
  1097					num_dels++;
  1098				i++;
  1099			} else if (cmp == 0) {
  1100				/* same item */
  1101				i++;
  1102				j++;
  1103			} else {
  1104				/* unique to to_merge */
  1105				num_adds++;
  1106				j++;
  1107			}
  1108		}
  1109	
  1110		new_invs = arm_smmu_invs_alloc(invs->num_invs - num_dels + num_adds);
  1111		if (IS_ERR(new_invs))
  1112			return new_invs;
  1113	
  1114		new = new_invs->inv;
  1115		for (i = j = 0; i != invs->num_invs || j != to_merge->num_invs;) {
  1116			int cmp = arm_smmu_invs_merge_cmp(invs, i, to_merge, j);
  1117	
  1118			if (cmp <= 0 && !refcount_read(&invs->inv[i].users)) {
  1119				i++;
  1120				continue;
  1121			}
  1122	
  1123			if (cmp < 0) {
  1124				*new = invs->inv[i];
  1125				i++;
  1126			} else if (cmp == 0) {
  1127				*new = invs->inv[i];
  1128				refcount_inc(&new->users);
  1129				i++;
  1130				j++;
  1131			} else {
  1132				*new = to_merge->inv[j];
  1133				refcount_set(&new->users, 1);
  1134				j++;
  1135			}
  1136			new++;
  1137		}
  1138	
  1139		WARN_ON(new != new_invs->inv + new_invs->num_invs);
  1140	
  1141		return new_invs;
  1142	}
  1143	EXPORT_SYMBOL_IF_KUNIT(arm_smmu_invs_merge);
  1144	
  1145	/**
  1146	 * arm_smmu_invs_unref() - Find in @invs for all entries in @to_unref, decrease
  1147	 *                         the user counts without deletions
  1148	 * @invs: the base invalidation array
  1149	 * @to_unref: an array of invlidations to decrease their user counts
  1150	 *
  1151	 * Return: the number of trash entries in the array, for arm_smmu_invs_purge()
  1152	 *
  1153	 * This function will not fail. Any entry with users=0 will be marked as trash.
  1154	 * All trash entries will remain in the @invs until being completely deleted by
  1155	 * the next arm_smmu_invs_merge() or an arm_smmu_invs_purge() function call.
  1156	 *
  1157	 * This function must be locked and serialized with arm_smmu_invs_merge() and
  1158	 * arm_smmu_invs_purge(), but do not lockdep on any lock for KUNIT test.
  1159	 *
  1160	 * Note that the @invs->num_invs will not be updated, even if the actual number
  1161	 * of invalidations are decreased. Readers should take the read lock to iterate
  1162	 * each entry and check its users counter until @inv->num_invs.
  1163	 */
  1164	VISIBLE_IF_KUNIT
> 1165	size_t arm_smmu_invs_unref(struct arm_smmu_invs *invs,
  1166				   struct arm_smmu_invs *to_unref)
  1167	{
  1168		size_t num_dels = 0;
  1169		size_t i, j;
  1170	
  1171		for (i = j = 0; i != invs->num_invs || j != to_unref->num_invs;) {
  1172			int cmp;
  1173	
  1174			if (!refcount_read(&invs->inv[i].users)) {
  1175				num_dels++;
  1176				i++;
  1177				continue;
  1178			}
  1179	
  1180			cmp = arm_smmu_invs_merge_cmp(invs, i, to_unref, j);
  1181			if (cmp < 0) {
  1182				/* not found in to_unref, leave alone */
  1183				i++;
  1184			} else if (cmp == 0) {
  1185				/* same item */
  1186				if (refcount_dec_and_test(&invs->inv[i].users))
  1187					num_dels++;
  1188				i++;
  1189				j++;
  1190			} else {
  1191				/* item in to_unref is not in invs or already a trash */
  1192				WARN_ON(true);
  1193				j++;
  1194			}
  1195		}
  1196		return num_dels;
  1197	}
  1198	EXPORT_SYMBOL_IF_KUNIT(arm_smmu_invs_unref);
  1199	
  1200	/**
  1201	 * arm_smmu_invs_purge() - Purge all the trash entries in the @invs
  1202	 * @invs: the base invalidation array
  1203	 * @num_dels: expected number of trash entries, typically the return value from
  1204	 *            a prior arm_smmu_invs_unref() call
  1205	 *
  1206	 * Return: a newly allocated array on success removing all the trash entries, or
  1207	 *         NULL on failure
  1208	 *
  1209	 * This function must be locked and serialized with arm_smmu_invs_merge() and
  1210	 * arm_smmu_invs_unref(), but do not lockdep on any lock for KUNIT test.
  1211	 *
  1212	 * Caller is resposible for freeing the @invs and the returned new one.
  1213	 */
  1214	VISIBLE_IF_KUNIT
> 1215	struct arm_smmu_invs *arm_smmu_invs_purge(struct arm_smmu_invs *invs,
  1216						  size_t num_dels)
  1217	{
  1218		struct arm_smmu_invs *new_invs;
  1219		size_t i, j;
  1220	
  1221		if (WARN_ON(invs->num_invs < num_dels))
  1222			return NULL;
  1223	
  1224		new_invs = arm_smmu_invs_alloc(invs->num_invs - num_dels);
  1225		if (IS_ERR(new_invs))
  1226			return NULL;
  1227	
  1228		for (i = j = 0; i != invs->num_invs; i++) {
  1229			if (!refcount_read(&invs->inv[i].users))
  1230				continue;
  1231			new_invs->inv[j] = invs->inv[i];
  1232			j++;
  1233		}
  1234	
  1235		WARN_ON(j != new_invs->num_invs);
  1236		return new_invs;
  1237	}
  1238	EXPORT_SYMBOL_IF_KUNIT(arm_smmu_invs_purge);
  1239	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

