Return-Path: <linux-kernel+bounces-731194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7900B050A1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 07:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C87383B41F3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 05:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F182B25F99B;
	Tue, 15 Jul 2025 05:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="haX3KLen"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FFF1A08B8
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 05:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752556335; cv=none; b=qAZcYGY71rTPT63fM2uy0gZIsZnYkbtil+wMowyL4KMtxfpS8wS97lTsWTrZn8pVIq3Z353abr6Y0JwbsUUF4Yhb2R1BVf2pdaw6Nv89/mivetvxeAw2lJtBsLtOsDq1PFc++l95S+8ieHSdiEQUoVAiDL0fGF90Ni01wwlzyjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752556335; c=relaxed/simple;
	bh=SJ9H3GqzzYYoa6bABzziZr2iSQG+4zXyeRND+xPo+8g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=F1KBIhz4fkUqlQY4EF3pmYbTIzGhNpg+4f/vdU/23jCgZ0FIYPFxsuu6Y4QtldRbrkBFvbC7vthbNpus+GyrxR29YIFy6o0FSWxlE/tPbtY9fkm+I88WgwhYhyPC5PJiHvCG3/5CRXo/jBf1qtg5H4Z+bHfCYd2Wp8iQWV/evuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=haX3KLen; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752556334; x=1784092334;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=SJ9H3GqzzYYoa6bABzziZr2iSQG+4zXyeRND+xPo+8g=;
  b=haX3KLen//VI4l647xzI/mJzDiNkm9VLzMefnb99IuHbK2mxRJQP8dNp
   Lxiq1VMA7n70PEF7ES9fg8wUN/UzCVEK0wbvX2OyB/DTZmXK7A0+ABH4U
   2hyK9ZO8ELBMPwwInurVk5HURGdGAarLfLm1flU6VWLNwp5nF1u9K0WPB
   ED43mEdzZJ85SsJbcTrjdU94mBESgs5gfdiC0wDJDKahugoZpBKdvAMtw
   geb0VCOplNere6i2NuT/ifDrM5JiB5/+/rOOCSVMmJ5J8LxDg5fGfxAVH
   fqvtLBQHFmQGdajXkhY8AVy9yNnXw7nCO7b74CcEajoSftnlklAthI9fM
   g==;
X-CSE-ConnectionGUID: CC/QBMp8TBqoDDpAVkjHHQ==
X-CSE-MsgGUID: GHamuHT8QiaXse4uC65pqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="58418660"
X-IronPort-AV: E=Sophos;i="6.16,312,1744095600"; 
   d="scan'208";a="58418660"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 22:12:13 -0700
X-CSE-ConnectionGUID: ZzTpZxipQ4unLEDJKNBJYg==
X-CSE-MsgGUID: Hl/RWTmvTSOqdHF6uqPaSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,312,1744095600"; 
   d="scan'208";a="157216144"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 14 Jul 2025 22:12:11 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ubXxZ-0009f9-1B;
	Tue, 15 Jul 2025 05:12:09 +0000
Date: Tue, 15 Jul 2025 13:11:29 +0800
From: kernel test robot <lkp@intel.com>
To: Tomas Glozar <tglozar@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: kernel/trace/trace_osnoise.c:2325:7-14: WARNING opportunity for
 memdup_user
Message-ID: <202507151301.xP2HYvaW-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   347e9f5043c89695b01e66b3ed111755afcf1911
commit: 17f89102fe23d7389085a8820550df688f79888a tracing/osnoise: Allow arbitrarily long CPU string
date:   10 weeks ago
config: arm-randconfig-r064-20250714 (https://download.01.org/0day-ci/archive/20250715/202507151301.xP2HYvaW-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project 01c97b4953e87ae455bd4c41e3de3f0f0f29c61c)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507151301.xP2HYvaW-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> kernel/trace/trace_osnoise.c:2325:7-14: WARNING opportunity for memdup_user

vim +2325 kernel/trace/trace_osnoise.c

  2300	
  2301	/*
  2302	 * osnoise_cpus_write - Write function for "cpus" entry
  2303	 * @filp: The active open file structure
  2304	 * @ubuf: The user buffer that contains the value to write
  2305	 * @count: The maximum number of bytes to write to "file"
  2306	 * @ppos: The current position in @file
  2307	 *
  2308	 * This function provides a write implementation for the "cpus"
  2309	 * interface to the osnoise trace. By default, it lists all  CPUs,
  2310	 * in this way, allowing osnoise threads to run on any online CPU
  2311	 * of the system. It serves to restrict the execution of osnoise to the
  2312	 * set of CPUs writing via this interface. Why not use "tracing_cpumask"?
  2313	 * Because the user might be interested in tracing what is running on
  2314	 * other CPUs. For instance, one might run osnoise in one HT CPU
  2315	 * while observing what is running on the sibling HT CPU.
  2316	 */
  2317	static ssize_t
  2318	osnoise_cpus_write(struct file *filp, const char __user *ubuf, size_t count,
  2319			   loff_t *ppos)
  2320	{
  2321		cpumask_var_t osnoise_cpumask_new;
  2322		int running, err;
  2323		char *buf __free(kfree) = NULL;
  2324	
> 2325		buf = kmalloc(count, GFP_KERNEL);
  2326		if (!buf)
  2327			return -ENOMEM;
  2328	
  2329		if (copy_from_user(buf, ubuf, count))
  2330			return -EFAULT;
  2331	
  2332		if (!zalloc_cpumask_var(&osnoise_cpumask_new, GFP_KERNEL))
  2333			return -ENOMEM;
  2334	
  2335		err = cpulist_parse(buf, osnoise_cpumask_new);
  2336		if (err)
  2337			goto err_free;
  2338	
  2339		/*
  2340		 * trace_types_lock is taken to avoid concurrency on start/stop.
  2341		 */
  2342		mutex_lock(&trace_types_lock);
  2343		running = osnoise_has_registered_instances();
  2344		if (running)
  2345			stop_per_cpu_kthreads();
  2346	
  2347		mutex_lock(&interface_lock);
  2348		/*
  2349		 * osnoise_cpumask is read by CPU hotplug operations.
  2350		 */
  2351		cpus_read_lock();
  2352	
  2353		cpumask_copy(&osnoise_cpumask, osnoise_cpumask_new);
  2354	
  2355		cpus_read_unlock();
  2356		mutex_unlock(&interface_lock);
  2357	
  2358		if (running)
  2359			start_per_cpu_kthreads();
  2360		mutex_unlock(&trace_types_lock);
  2361	
  2362		free_cpumask_var(osnoise_cpumask_new);
  2363		return count;
  2364	
  2365	err_free:
  2366		free_cpumask_var(osnoise_cpumask_new);
  2367	
  2368		return err;
  2369	}
  2370	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

