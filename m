Return-Path: <linux-kernel+bounces-854049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC55BDD6DA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 10:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 048434FF39F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 08:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B46B304BA6;
	Wed, 15 Oct 2025 08:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CKMAO5mc"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EBF2FCC1E;
	Wed, 15 Oct 2025 08:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760517095; cv=none; b=IKJcSbqkeo4lrWnMrtEVy8yI+6DxsOzahUChHgh74e1VJePZ9fieMHjYI9oUS6cKLwltVimZybYseo5DiR3CSOrRxp7Ipraa5IfZCNp4y7yve7MJIdXcn7V7BY1AkI5CW5mXf/TdoeNWFuGWSgDjU0GZ56vfUjNVXbRLrWzhAY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760517095; c=relaxed/simple;
	bh=qe9hVuxDPgUwhlb4VhDfz8E+lFRVAyOeblT3cq7ZcrY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uHxYvMQa+OA1J28sMuKMrvcVr7ZHrV9BLVqWOwDcaMjkc2XHa6yrntoNTZC1c3nXJJY8EY1u/2J34aT5FZNHY7R75WhUua1WoN1qCAy5yOxQUhaRrq68KNg9cUzqQXAX5Hn3LFw6nmFX2DVXEOR5yiFEyZtF4WedUSgVGrXTe5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CKMAO5mc; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760517093; x=1792053093;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=qe9hVuxDPgUwhlb4VhDfz8E+lFRVAyOeblT3cq7ZcrY=;
  b=CKMAO5mcOLYjvCsd8bCz+nkYnkRBtMwpBc6NsD0HpQ87Y+oauQXNAVSL
   Zmkz6V5XyMEvR9hVkyP+s+1vW5ZIVZcGFQy8GYIww6ycKPxoCGIgtCrjn
   vEtVqBYXBN3soRtQ5YHRpbAbwRbMqtJc/zIqS3QdDHsNH8gu6FoceNpZ4
   T6fOKOIAfAkUz9t+z6w9mGbk2zfqRVwGCnoElmWSbbmuY/UXAgd0Z/Ztz
   /Io0QyvrLt13XpnjzjkCf09Fm5dGMqql6kcp2ZiqBMG/QqIzdxoyF9M/q
   DZLEWg1SsngYUxJdUYbBJLOzoJS9LZDiYdsdXO+XO6F6ltb3MZQaHY0eq
   w==;
X-CSE-ConnectionGUID: Qba5PxhFSQ2BZUQaa3QgvQ==
X-CSE-MsgGUID: obDAUBNISaG5kFuiJYTfRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="62578130"
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="62578130"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 01:31:33 -0700
X-CSE-ConnectionGUID: NtVwSgL4QNGL9Uo4zGyzVQ==
X-CSE-MsgGUID: y9XpkBUcSq6ya4fkFNFyCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="186123018"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.75])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 01:31:31 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: hansg@kernel.org, vadimp@nvidia.com, 
 David Thompson <davthompson@nvidia.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Shravan Kumar Ramani <shravankr@nvidia.com>
In-Reply-To: <20251013155605.3589770-1-davthompson@nvidia.com>
References: <20251013155605.3589770-1-davthompson@nvidia.com>
Subject: Re: [PATCH v2] platform/mellanox: mlxbf-pmc: add sysfs_attr_init()
 to count_clock init
Message-Id: <176051708584.2196.14874852596962553290.b4-ty@linux.intel.com>
Date: Wed, 15 Oct 2025 11:31:25 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Mon, 13 Oct 2025 15:56:05 +0000, David Thompson wrote:

> The lock-related debug logic (CONFIG_LOCK_STAT) in the kernel is noting
> the following warning when the BlueField-3 SOC is booted:
> 
> [   10.231318] BUG: key ffff00008a3402a8 has not been registered!
> [   10.237249] ------------[ cut here ]------------
> [   10.241914] DEBUG_LOCKS_WARN_ON(1)
> [   10.241927] WARNING: CPU: 4 PID: 592 at kernel/locking/lockdep.c:4801 lockdep_init_map_type+0x1d4/0x2a0
> <snip>
> [   10.385415] Call trace:
> [   10.385417]  lockdep_init_map_type+0x1d4/0x2a0
> [   10.385423]  __kernfs_create_file+0x84/0x140
> [   10.385428]  sysfs_add_file_mode_ns+0xcc/0x1cc
> [   10.385431]  internal_create_group+0x110/0x3d4
> [   10.385434]  internal_create_groups.part.0+0x54/0xcc
> [   10.385436]  sysfs_create_groups+0x24/0x40
> [   10.385438]  device_add+0x6e8/0x93c
> [   10.444559]  device_register+0x28/0x40
> [   10.448299]  __hwmon_device_register+0x4b0/0x8a0
> [   10.452907]  devm_hwmon_device_register_with_groups+0x7c/0xe0
> [   10.458641]  mlxbf_pmc_probe+0x1e8/0x3e0 [mlxbf_pmc]
> [   10.463598]  platform_probe+0x70/0x110
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-fixes branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-fixes branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/mellanox: mlxbf-pmc: add sysfs_attr_init() to count_clock init
      commit: a7b4747d8e0e7871c3d4971cded1dcc9af6af9e9

--
 i.


