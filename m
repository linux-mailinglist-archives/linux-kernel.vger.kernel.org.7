Return-Path: <linux-kernel+bounces-723704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DCADAFEA15
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FE687B3291
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24152DFF22;
	Wed,  9 Jul 2025 13:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="FCLOXDdn"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5006A2E6D22;
	Wed,  9 Jul 2025 13:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752067433; cv=none; b=qx/Kq7iUVuxQl6LxjJMpIAtbzHJO/kE/k5d8jY7+3u4KWNTol4bnqGLAHUVOAs3etJkZF8Fvz4sWQwwCo4m6xTbTlwByvyw8OquOi5+RJz8tXobrkFWVD2qjMG6TXSY48Ty7Ov7ajYiXAXjHVZrXNu0MYJMKi/04x6fSs3w4GHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752067433; c=relaxed/simple;
	bh=U9IP5C7MLF//jo92LrBiXQE5SHZdtYV8h60M8KNrBaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KRXgITdcTsM8+ZwBL9H07yefE9dz64gZE0TKFNty3jA4mDh6GVICl4A1NCq8ZlRzgLo5Je0LjWp6dqcVMmoJ+ac167E2twOxqfqmAr4ACSba8lwAwsCLj1vyOlzFcGxhVhrGNpxM0CGsOwJ56UAIVJaI+C7CicyIi7rRj9rwHfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=FCLOXDdn; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=vN0UQyHmBDa84FvfCJXdkkuyplqKTnh+HaZ5ci/Ai2k=; b=FCLOXDdnN6hgoSu+jmJ3QMxoD+
	2+nEBMY4G0bhDl3957aiG2RDSF3XKqMWsU7MrIxJvnUpxZMvaX30gO+3DLwq7jmTBtkg1chbzVXD1
	PAndGZNYQrZPkiITtz6YzuvVsCgbCsbeWcs9clAEEsIywdyWp6XG2P+RM6lQFfKBN5go5DKgypQOV
	1xLFKJjZLxWT8WULyhqmjR/mlkLL1cAWnEO4+v0D6ETYEbFPPjMUUvdKmaPga9dYKs9l9RPxMbT4m
	4akxH32ASL2MNgQcN77sGkpN/eFyo+WNDtDuNJQjLLon7zWJkgveydjXhXusqxAFoo7MRJVMZaVlx
	giFk2pyg==;
Received: from 179-125-86-110-dinamico.pombonet.net.br ([179.125.86.110] helo=quatroqueijos.cascardo.eti.br)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uZUm1-00ETva-3g; Wed, 09 Jul 2025 15:23:45 +0200
Date: Wed, 9 Jul 2025 10:23:38 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dirk VanDerMerwe <dirk.vandermerwe@sophos.com>,
	Vimal Agrawal <vimal.agrawal@sophos.com>, kernel-dev@igalia.com
Subject: Re: [PATCH v5] char: misc: add test cases
Message-ID: <aG5tWs2rm1b8hE3f@quatroqueijos.cascardo.eti.br>
References: <20250612-misc-dynrange-v5-1-6f35048f7273@igalia.com>
 <202507091056.5d48c1a2-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202507091056.5d48c1a2-lkp@intel.com>

On Wed, Jul 09, 2025 at 09:14:04PM +0800, kernel test robot wrote:
> Hello,
> 
> kernel test robot noticed "sysfs:cannot_create_duplicate_filename" on:
> 
> commit: 127b049d35f10765f429aa2a97aa649ea9ac0b2f ("[PATCH v5] char: misc: add test cases")
> url: https://github.com/intel-lab-lkp/linux/commits/Thadeu-Lima-de-Souza-Cascardo/char-misc-add-test-cases/20250613-013440
> patch link: https://lore.kernel.org/all/20250612-misc-dynrange-v5-1-6f35048f7273@igalia.com/
> patch subject: [PATCH v5] char: misc: add test cases
> 
> in testcase: kunit
> version: 
> with following parameters:
> 
> 	group: group-00
> 
> 
> 
> config: x86_64-rhel-9.4-kunit
> compiler: gcc-12
> test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-4770 CPU @ 3.40GHz (Haswell) with 16G memory
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202507091056.5d48c1a2-lkp@intel.com
> 
> 
> [  112.908177][    T1]         ok 2 upper static range, bottom
> [  112.914070][    T1]         ok 3 lower static range, bottom
> [  112.920216][    T1]         ok 4 upper static range, top
> [  112.925861][    T1]     # miscdev_test_duplicate_minor: pass:4 fail:0 skip:0 total:4
> [  112.931240][    T1]     ok 5 miscdev_test_duplicate_minor
> [  112.939321][ T2928] sysfs: cannot create duplicate filename '/devices/virtual/misc/misc1'
> [  112.953103][ T2928] CPU: 0 UID: 0 PID: 2928 Comm: kunit_try_catch Tainted: G S               N  6.16.0-rc1-00001-g127b049d35f1 #1 PREEMPT(voluntary)
> [  112.953110][ T2928] Tainted: [S]=CPU_OUT_OF_SPEC, [N]=TEST
> [  112.953111][ T2928] Hardware name: Dell Inc. OptiPlex 9020/0DNKMN, BIOS A05 12/05/2013
> [  112.953113][ T2928] Call Trace:
> [  112.953115][ T2928]  <TASK>
> [ 112.953117][ T2928] dump_stack_lvl (kbuild/src/consumer/lib/dump_stack.c:123 (discriminator 1)) 
> [ 112.953124][ T2928] sysfs_warn_dup (kbuild/src/consumer/fs/sysfs/dir.c:32 (discriminator 1)) 
> [ 112.953129][ T2928] sysfs_create_dir_ns (kbuild/src/consumer/fs/sysfs/dir.c:63) 
> [ 112.953133][ T2928] ? __pfx_sysfs_create_dir_ns (kbuild/src/consumer/fs/sysfs/dir.c:41) 
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20250709/202507091056.5d48c1a2-lkp@intel.com
> 
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

This failure is intentional, it is part of the test. How can we make the
robot ignore it in this specific instance?

Regards.
Cascardo.

