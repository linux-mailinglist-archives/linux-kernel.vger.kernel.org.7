Return-Path: <linux-kernel+bounces-856181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 322C1BE354D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 14:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B900C1A649EF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 12:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A490632BF4E;
	Thu, 16 Oct 2025 12:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gNqlL3pO"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1511326D50
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 12:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760617316; cv=none; b=OH8xA1ezAEAD9krO2/iJov3fEJv44/PtqNX2Y7QZtFfTUshlhgHOa94YLvSHu+FkqDz4S+QXeVGmiSW++IXrbVIBWLBm/ZiLVX6F1lgbJTcrMhGMXFK0o2daK7plE3YBKUsvBEd45IsE7NBvIl27AdaSg2Y9x+ZqDWFgm7WrzRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760617316; c=relaxed/simple;
	bh=lprsLCblBdi1mu/waKPPvN3tSSOdNGhBXu1B77jQ7P8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=S7QG3Ho07lE4xe6U9DgLhrr68BcGmrAmYSP/5f3L1wFBIekDSuGJxdp+II+JzV4i9hhp5Oql+BHq+Wlr1fJ3jfOnCJggatHrHGalp+k+tEXNRoxoA3PT9yPJCMrL6Owu4kRB8wVHur6zQarWMFE7i7vjeYlX7ZzCiR7EfOheRpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gNqlL3pO; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760617313; x=1792153313;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=lprsLCblBdi1mu/waKPPvN3tSSOdNGhBXu1B77jQ7P8=;
  b=gNqlL3pOIo/nIM/8n9Qg7rjHphow/H27k4lbLwJKZFohzezwbYMAUaq5
   FM5GQ0Z9NMQ3qg6N+/Te+ytq2Y3lU66DSvDPt/eHj9Rliyu4dYnN7Hy23
   z/KxtGc0JVQnByddPWy2g63CSa68XfpaC0I3LGOyjh0q4tDPbH9p11OWT
   XUG8owZt3HfuTgBD3EPCwzJTyYQxIvpIm+Cq0i8Kj/I4+k8YPV+Pjf+8E
   8k3Bxa6+uGRtdVnreiPW68yrpywkkB0otZypa9zn5q3q7xNFfqaWmAlBi
   amFauN58C9fPUVyyk0yJP9Z6ESuG89Rv4PINYq4g+t+GUDeVzuAeBdJvG
   A==;
X-CSE-ConnectionGUID: /tvAT/p5RJawhK38FpW1Jw==
X-CSE-MsgGUID: z+8k7EVkTZqbwauEVHuPMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="62706332"
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="62706332"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 05:21:52 -0700
X-CSE-ConnectionGUID: hup6fz5HRROV0Clxjqfs7A==
X-CSE-MsgGUID: od+6l2uEQlqR2g+2/WYuJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="181571265"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 16 Oct 2025 05:21:50 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v9Myb-0004nP-2c;
	Thu, 16 Oct 2025 12:21:11 +0000
Date: Thu, 16 Oct 2025 20:20:27 +0800
From: kernel test robot <lkp@intel.com>
To: Tiwei Bie <tiwei.btw@antgroup.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: include/trace/events/ib_mad.h:23:1: sparse: sparse: cast to
 restricted __be16
Message-ID: <202510162047.GoUq7DXY-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7ea30958b3054f5e488fa0b33c352723f7ab3a2a
commit: a0e2cb6a90634f3dc80f16e882a683ee5761b0b0 um: Add VFIO-based virtual PCI driver
date:   5 months ago
config: um-randconfig-r121-20251016 (https://download.01.org/0day-ci/archive/20251016/202510162047.GoUq7DXY-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251016/202510162047.GoUq7DXY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510162047.GoUq7DXY-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/infiniband/core/mad.c: note: in included file (through include/trace/trace_events.h, include/trace/define_trace.h, include/trace/events/ib_mad.h):
   include/trace/events/ib_mad.h:23:1: sparse: sparse: cast to restricted __be64
   include/trace/events/ib_mad.h:23:1: sparse: sparse: cast to restricted __be64
   include/trace/events/ib_mad.h:23:1: sparse: sparse: cast to restricted __be64
   include/trace/events/ib_mad.h:23:1: sparse: sparse: cast to restricted __be64
   include/trace/events/ib_mad.h:23:1: sparse: sparse: cast to restricted __be64
   include/trace/events/ib_mad.h:23:1: sparse: sparse: cast to restricted __be64
   include/trace/events/ib_mad.h:23:1: sparse: sparse: cast to restricted __be64
   include/trace/events/ib_mad.h:23:1: sparse: sparse: cast to restricted __be64
   include/trace/events/ib_mad.h:23:1: sparse: sparse: cast to restricted __be64
   include/trace/events/ib_mad.h:23:1: sparse: sparse: cast to restricted __be64
>> include/trace/events/ib_mad.h:23:1: sparse: sparse: cast to restricted __be16
>> include/trace/events/ib_mad.h:23:1: sparse: sparse: cast to restricted __be16
>> include/trace/events/ib_mad.h:23:1: sparse: sparse: cast to restricted __be16
>> include/trace/events/ib_mad.h:23:1: sparse: sparse: cast to restricted __be16
>> include/trace/events/ib_mad.h:23:1: sparse: sparse: cast to restricted __be16
>> include/trace/events/ib_mad.h:23:1: sparse: sparse: cast to restricted __be16
>> include/trace/events/ib_mad.h:23:1: sparse: sparse: cast to restricted __be16
>> include/trace/events/ib_mad.h:23:1: sparse: sparse: cast to restricted __be16
   include/trace/events/ib_mad.h:23:1: sparse: sparse: cast to restricted __be64
   include/trace/events/ib_mad.h:23:1: sparse: sparse: cast to restricted __be64
   include/trace/events/ib_mad.h:23:1: sparse: sparse: cast to restricted __be64
   include/trace/events/ib_mad.h:23:1: sparse: sparse: cast to restricted __be64
   include/trace/events/ib_mad.h:23:1: sparse: sparse: cast to restricted __be64
   include/trace/events/ib_mad.h:23:1: sparse: sparse: cast to restricted __be64
   include/trace/events/ib_mad.h:23:1: sparse: sparse: cast to restricted __be64
   include/trace/events/ib_mad.h:23:1: sparse: sparse: cast to restricted __be64
   include/trace/events/ib_mad.h:23:1: sparse: sparse: cast to restricted __be64
   include/trace/events/ib_mad.h:23:1: sparse: sparse: cast to restricted __be64
>> include/trace/events/ib_mad.h:23:1: sparse: sparse: cast to restricted __be16
>> include/trace/events/ib_mad.h:23:1: sparse: sparse: cast to restricted __be16
>> include/trace/events/ib_mad.h:23:1: sparse: sparse: cast to restricted __be16
>> include/trace/events/ib_mad.h:23:1: sparse: sparse: cast to restricted __be16
>> include/trace/events/ib_mad.h:23:1: sparse: sparse: cast to restricted __be32
>> include/trace/events/ib_mad.h:23:1: sparse: sparse: cast to restricted __be32
>> include/trace/events/ib_mad.h:23:1: sparse: sparse: cast to restricted __be32
>> include/trace/events/ib_mad.h:23:1: sparse: sparse: cast to restricted __be32
>> include/trace/events/ib_mad.h:23:1: sparse: sparse: cast to restricted __be32
>> include/trace/events/ib_mad.h:23:1: sparse: sparse: cast to restricted __be32
>> include/trace/events/ib_mad.h:23:1: sparse: sparse: cast to restricted __be32
>> include/trace/events/ib_mad.h:23:1: sparse: sparse: cast to restricted __be32
>> include/trace/events/ib_mad.h:23:1: sparse: sparse: cast to restricted __be32
>> include/trace/events/ib_mad.h:23:1: sparse: sparse: cast to restricted __be32
>> include/trace/events/ib_mad.h:23:1: sparse: sparse: cast to restricted __be32
>> include/trace/events/ib_mad.h:23:1: sparse: sparse: cast to restricted __be32
   include/trace/events/ib_mad.h:120:1: sparse: sparse: cast to restricted __be64
   include/trace/events/ib_mad.h:120:1: sparse: sparse: cast to restricted __be64
   include/trace/events/ib_mad.h:120:1: sparse: sparse: cast to restricted __be64
   include/trace/events/ib_mad.h:120:1: sparse: sparse: cast to restricted __be64
   include/trace/events/ib_mad.h:120:1: sparse: sparse: cast to restricted __be64
   include/trace/events/ib_mad.h:120:1: sparse: sparse: cast to restricted __be64
   include/trace/events/ib_mad.h:120:1: sparse: sparse: cast to restricted __be64
   include/trace/events/ib_mad.h:120:1: sparse: sparse: cast to restricted __be64
   include/trace/events/ib_mad.h:120:1: sparse: sparse: cast to restricted __be64
   include/trace/events/ib_mad.h:120:1: sparse: sparse: cast to restricted __be64
   include/trace/events/ib_mad.h:120:1: sparse: sparse: cast to restricted __be16
   include/trace/events/ib_mad.h:120:1: sparse: sparse: cast to restricted __be16
   include/trace/events/ib_mad.h:120:1: sparse: sparse: cast to restricted __be16
   include/trace/events/ib_mad.h:120:1: sparse: sparse: cast to restricted __be16
   include/trace/events/ib_mad.h:183:1: sparse: sparse: cast to restricted __be16
   include/trace/events/ib_mad.h:183:1: sparse: sparse: cast to restricted __be16
   include/trace/events/ib_mad.h:183:1: sparse: sparse: cast to restricted __be16
   include/trace/events/ib_mad.h:183:1: sparse: sparse: cast to restricted __be16
   include/trace/events/ib_mad.h:183:1: sparse: sparse: cast to restricted __be16
   include/trace/events/ib_mad.h:183:1: sparse: sparse: cast to restricted __be16
   include/trace/events/ib_mad.h:183:1: sparse: sparse: cast to restricted __be16
   include/trace/events/ib_mad.h:183:1: sparse: sparse: cast to restricted __be16
   include/trace/events/ib_mad.h:183:1: sparse: sparse: cast to restricted __be64
   include/trace/events/ib_mad.h:183:1: sparse: sparse: cast to restricted __be64
   include/trace/events/ib_mad.h:183:1: sparse: sparse: cast to restricted __be64
   include/trace/events/ib_mad.h:183:1: sparse: sparse: cast to restricted __be64
   include/trace/events/ib_mad.h:183:1: sparse: sparse: cast to restricted __be64
   include/trace/events/ib_mad.h:183:1: sparse: sparse: cast to restricted __be64
   include/trace/events/ib_mad.h:183:1: sparse: sparse: cast to restricted __be64
   include/trace/events/ib_mad.h:183:1: sparse: sparse: cast to restricted __be64
   include/trace/events/ib_mad.h:183:1: sparse: sparse: cast to restricted __be64
   include/trace/events/ib_mad.h:183:1: sparse: sparse: cast to restricted __be64
   include/trace/events/ib_mad.h:183:1: sparse: sparse: cast to restricted __be16
   include/trace/events/ib_mad.h:183:1: sparse: sparse: cast to restricted __be16
   include/trace/events/ib_mad.h:183:1: sparse: sparse: cast to restricted __be16
   include/trace/events/ib_mad.h:183:1: sparse: sparse: cast to restricted __be16
   include/trace/events/ib_mad.h:183:1: sparse: sparse: cast to restricted __be32
   include/trace/events/ib_mad.h:183:1: sparse: sparse: cast to restricted __be32
   include/trace/events/ib_mad.h:183:1: sparse: sparse: cast to restricted __be32
   include/trace/events/ib_mad.h:183:1: sparse: sparse: cast to restricted __be32
   include/trace/events/ib_mad.h:183:1: sparse: sparse: cast to restricted __be32
   include/trace/events/ib_mad.h:183:1: sparse: sparse: cast to restricted __be32
   include/trace/events/ib_mad.h:294:1: sparse: sparse: cast to restricted __be64
   include/trace/events/ib_mad.h:294:1: sparse: sparse: cast to restricted __be64
   include/trace/events/ib_mad.h:294:1: sparse: sparse: cast to restricted __be64
   include/trace/events/ib_mad.h:294:1: sparse: sparse: cast to restricted __be64
   include/trace/events/ib_mad.h:294:1: sparse: sparse: cast to restricted __be64
   include/trace/events/ib_mad.h:294:1: sparse: sparse: cast to restricted __be64
   include/trace/events/ib_mad.h:294:1: sparse: sparse: cast to restricted __be64
   include/trace/events/ib_mad.h:294:1: sparse: sparse: cast to restricted __be64
   include/trace/events/ib_mad.h:294:1: sparse: sparse: cast to restricted __be64
   include/trace/events/ib_mad.h:294:1: sparse: sparse: cast to restricted __be64
   include/trace/events/ib_mad.h:294:1: sparse: sparse: cast to restricted __be32
   include/trace/events/ib_mad.h:294:1: sparse: sparse: cast to restricted __be32
   include/trace/events/ib_mad.h:294:1: sparse: sparse: cast to restricted __be32
   include/trace/events/ib_mad.h:294:1: sparse: sparse: cast to restricted __be32
   include/trace/events/ib_mad.h:294:1: sparse: sparse: cast to restricted __be32
   include/trace/events/ib_mad.h:294:1: sparse: sparse: cast to restricted __be32
   include/trace/events/ib_mad.h:294:1: sparse: sparse: cast to restricted __be32
   include/trace/events/ib_mad.h:294:1: sparse: sparse: cast to restricted __be32
   include/trace/events/ib_mad.h:294:1: sparse: sparse: cast to restricted __be32
   include/trace/events/ib_mad.h:294:1: sparse: sparse: cast to restricted __be32
   include/trace/events/ib_mad.h:294:1: sparse: sparse: cast to restricted __be32
   include/trace/events/ib_mad.h:294:1: sparse: sparse: cast to restricted __be32
   include/trace/events/ib_mad.h:339:1: sparse: sparse: cast to restricted __be64
   include/trace/events/ib_mad.h:339:1: sparse: sparse: cast to restricted __be64
   include/trace/events/ib_mad.h:339:1: sparse: sparse: cast to restricted __be64
   include/trace/events/ib_mad.h:339:1: sparse: sparse: cast to restricted __be64
   include/trace/events/ib_mad.h:339:1: sparse: sparse: cast to restricted __be64
   include/trace/events/ib_mad.h:339:1: sparse: sparse: cast to restricted __be64
   include/trace/events/ib_mad.h:339:1: sparse: sparse: cast to restricted __be64
   include/trace/events/ib_mad.h:339:1: sparse: sparse: cast to restricted __be64
   include/trace/events/ib_mad.h:339:1: sparse: sparse: cast to restricted __be64
   include/trace/events/ib_mad.h:339:1: sparse: sparse: cast to restricted __be64
   include/trace/events/ib_mad.h:339:1: sparse: sparse: cast to restricted __be16
   include/trace/events/ib_mad.h:339:1: sparse: sparse: cast to restricted __be16
   include/trace/events/ib_mad.h:339:1: sparse: sparse: cast to restricted __be16
   include/trace/events/ib_mad.h:339:1: sparse: sparse: cast to restricted __be16
   include/trace/events/ib_mad.h:339:1: sparse: sparse: cast to restricted __be16
   include/trace/events/ib_mad.h:339:1: sparse: sparse: cast to restricted __be16
   include/trace/events/ib_mad.h:339:1: sparse: sparse: cast to restricted __be16
   include/trace/events/ib_mad.h:339:1: sparse: sparse: cast to restricted __be16
   drivers/infiniband/core/mad.c: note: in included file (through include/trace/trace_events.h, include/trace/define_trace.h, include/trace/events/ib_mad.h):
   include/trace/events/ib_mad.h:23:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] wrtid @@     got restricted __be64 [usertype] tid @@
   include/trace/events/ib_mad.h:23:1: sparse:     expected unsigned long long [usertype] wrtid
   include/trace/events/ib_mad.h:23:1: sparse:     got restricted __be64 [usertype] tid
   include/trace/events/ib_mad.h:23:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] status @@     got restricted __be16 [usertype] status @@
   include/trace/events/ib_mad.h:23:1: sparse:     expected unsigned short [usertype] status
   include/trace/events/ib_mad.h:23:1: sparse:     got restricted __be16 [usertype] status
   include/trace/events/ib_mad.h:23:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] class_specific @@     got restricted __be16 [usertype] class_specific @@
   include/trace/events/ib_mad.h:23:1: sparse:     expected unsigned short [usertype] class_specific
   include/trace/events/ib_mad.h:23:1: sparse:     got restricted __be16 [usertype] class_specific
   include/trace/events/ib_mad.h:23:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] tid @@     got restricted __be64 [usertype] tid @@
   include/trace/events/ib_mad.h:23:1: sparse:     expected unsigned long long [usertype] tid
   include/trace/events/ib_mad.h:23:1: sparse:     got restricted __be64 [usertype] tid
   include/trace/events/ib_mad.h:23:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] attr_id @@     got restricted __be16 [usertype] attr_id @@
   include/trace/events/ib_mad.h:23:1: sparse:     expected unsigned short [usertype] attr_id
   include/trace/events/ib_mad.h:23:1: sparse:     got restricted __be16 [usertype] attr_id
   include/trace/events/ib_mad.h:23:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] attr_mod @@     got restricted __be32 [usertype] attr_mod @@
   include/trace/events/ib_mad.h:23:1: sparse:     expected unsigned int [usertype] attr_mod
   include/trace/events/ib_mad.h:23:1: sparse:     got restricted __be32 [usertype] attr_mod
   include/trace/events/ib_mad.h:120:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] wrtid @@     got restricted __be64 [usertype] tid @@
   include/trace/events/ib_mad.h:120:1: sparse:     expected unsigned long long [usertype] wrtid
   include/trace/events/ib_mad.h:120:1: sparse:     got restricted __be64 [usertype] tid
   include/trace/events/ib_mad.h:120:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] status @@     got restricted __be16 [usertype] status @@
   include/trace/events/ib_mad.h:120:1: sparse:     expected unsigned short [usertype] status
   include/trace/events/ib_mad.h:120:1: sparse:     got restricted __be16 [usertype] status
   include/trace/events/ib_mad.h:183:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] status @@     got restricted __be16 [usertype] status @@
   include/trace/events/ib_mad.h:183:1: sparse:     expected unsigned short [usertype] status
   include/trace/events/ib_mad.h:183:1: sparse:     got restricted __be16 [usertype] status
   include/trace/events/ib_mad.h:183:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] class_specific @@     got restricted __be16 [usertype] class_specific @@
   include/trace/events/ib_mad.h:183:1: sparse:     expected unsigned short [usertype] class_specific
   include/trace/events/ib_mad.h:183:1: sparse:     got restricted __be16 [usertype] class_specific
   include/trace/events/ib_mad.h:183:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] tid @@     got restricted __be64 [usertype] tid @@
   include/trace/events/ib_mad.h:183:1: sparse:     expected unsigned long long [usertype] tid
   include/trace/events/ib_mad.h:183:1: sparse:     got restricted __be64 [usertype] tid
   include/trace/events/ib_mad.h:183:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] attr_id @@     got restricted __be16 [usertype] attr_id @@
   include/trace/events/ib_mad.h:183:1: sparse:     expected unsigned short [usertype] attr_id
   include/trace/events/ib_mad.h:183:1: sparse:     got restricted __be16 [usertype] attr_id
   include/trace/events/ib_mad.h:183:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] attr_mod @@     got restricted __be32 [usertype] attr_mod @@
   include/trace/events/ib_mad.h:183:1: sparse:     expected unsigned int [usertype] attr_mod
   include/trace/events/ib_mad.h:183:1: sparse:     got restricted __be32 [usertype] attr_mod
   include/trace/events/ib_mad.h:294:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] mkey @@     got restricted __be64 [usertype] mkey @@
   include/trace/events/ib_mad.h:294:1: sparse:     expected unsigned long long [usertype] mkey
   include/trace/events/ib_mad.h:294:1: sparse:     got restricted __be64 [usertype] mkey
   include/trace/events/ib_mad.h:294:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] dr_slid @@     got restricted __be32 [usertype] dr_slid @@
   include/trace/events/ib_mad.h:294:1: sparse:     expected unsigned int [usertype] dr_slid
   include/trace/events/ib_mad.h:294:1: sparse:     got restricted __be32 [usertype] dr_slid
>> include/trace/events/ib_mad.h:294:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] dr_dlid @@     got restricted __be32 [usertype] dr_dlid @@
   include/trace/events/ib_mad.h:294:1: sparse:     expected unsigned int [usertype] dr_dlid
   include/trace/events/ib_mad.h:294:1: sparse:     got restricted __be32 [usertype] dr_dlid
   include/trace/events/ib_mad.h:339:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] mkey @@     got restricted __be64 [usertype] mkey @@
   include/trace/events/ib_mad.h:339:1: sparse:     expected unsigned long long [usertype] mkey
   include/trace/events/ib_mad.h:339:1: sparse:     got restricted __be64 [usertype] mkey
   include/trace/events/ib_mad.h:339:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] dr_slid @@     got restricted __be16 [usertype] dr_slid @@
   include/trace/events/ib_mad.h:339:1: sparse:     expected unsigned int [usertype] dr_slid
   include/trace/events/ib_mad.h:339:1: sparse:     got restricted __be16 [usertype] dr_slid
   include/trace/events/ib_mad.h:339:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] dr_dlid @@     got restricted __be16 [usertype] dr_dlid @@
   include/trace/events/ib_mad.h:339:1: sparse:     expected unsigned int [usertype] dr_dlid
   include/trace/events/ib_mad.h:339:1: sparse:     got restricted __be16 [usertype] dr_dlid
--
   drivers/infiniband/core/user_mad.c: note: in included file (through include/trace/trace_events.h, include/trace/define_trace.h, include/trace/events/ib_umad.h):
>> include/trace/events/ib_umad.h:16:1: sparse: sparse: cast to restricted __be32
>> include/trace/events/ib_umad.h:16:1: sparse: sparse: cast to restricted __be32
>> include/trace/events/ib_umad.h:16:1: sparse: sparse: cast to restricted __be32
>> include/trace/events/ib_umad.h:16:1: sparse: sparse: cast to restricted __be32
>> include/trace/events/ib_umad.h:16:1: sparse: sparse: cast to restricted __be32
>> include/trace/events/ib_umad.h:16:1: sparse: sparse: cast to restricted __be32
>> include/trace/events/ib_umad.h:16:1: sparse: sparse: cast to restricted __be32
>> include/trace/events/ib_umad.h:16:1: sparse: sparse: cast to restricted __be32
>> include/trace/events/ib_umad.h:16:1: sparse: sparse: cast to restricted __be32
>> include/trace/events/ib_umad.h:16:1: sparse: sparse: cast to restricted __be32
>> include/trace/events/ib_umad.h:16:1: sparse: sparse: cast to restricted __be32
>> include/trace/events/ib_umad.h:16:1: sparse: sparse: cast to restricted __be32
   include/trace/events/ib_umad.h:16:1: sparse: sparse: cast to restricted __be16
   include/trace/events/ib_umad.h:16:1: sparse: sparse: cast to restricted __be16
   include/trace/events/ib_umad.h:16:1: sparse: sparse: cast to restricted __be16
   include/trace/events/ib_umad.h:16:1: sparse: sparse: cast to restricted __be16
>> include/trace/events/ib_umad.h:16:1: sparse: sparse: cast to restricted __be32
>> include/trace/events/ib_umad.h:16:1: sparse: sparse: cast to restricted __be32
>> include/trace/events/ib_umad.h:16:1: sparse: sparse: cast to restricted __be32
>> include/trace/events/ib_umad.h:16:1: sparse: sparse: cast to restricted __be32
>> include/trace/events/ib_umad.h:16:1: sparse: sparse: cast to restricted __be32
>> include/trace/events/ib_umad.h:16:1: sparse: sparse: cast to restricted __be32
   include/trace/events/ib_umad.h:16:1: sparse: sparse: cast to restricted __be16
   include/trace/events/ib_umad.h:16:1: sparse: sparse: cast to restricted __be16
   include/trace/events/ib_umad.h:16:1: sparse: sparse: cast to restricted __be16
   include/trace/events/ib_umad.h:16:1: sparse: sparse: cast to restricted __be16
   include/trace/events/ib_umad.h:16:1: sparse: sparse: cast to restricted __be16
   include/trace/events/ib_umad.h:16:1: sparse: sparse: cast to restricted __be16
   include/trace/events/ib_umad.h:16:1: sparse: sparse: cast to restricted __be16
   include/trace/events/ib_umad.h:16:1: sparse: sparse: cast to restricted __be16
   include/trace/events/ib_umad.h:16:1: sparse: sparse: cast to restricted __be64
   include/trace/events/ib_umad.h:16:1: sparse: sparse: cast to restricted __be64
   include/trace/events/ib_umad.h:16:1: sparse: sparse: cast to restricted __be64
   include/trace/events/ib_umad.h:16:1: sparse: sparse: cast to restricted __be64
   include/trace/events/ib_umad.h:16:1: sparse: sparse: cast to restricted __be64
   include/trace/events/ib_umad.h:16:1: sparse: sparse: cast to restricted __be64
   include/trace/events/ib_umad.h:16:1: sparse: sparse: cast to restricted __be64
   include/trace/events/ib_umad.h:16:1: sparse: sparse: cast to restricted __be64
   include/trace/events/ib_umad.h:16:1: sparse: sparse: cast to restricted __be64
   include/trace/events/ib_umad.h:16:1: sparse: sparse: cast to restricted __be64
   include/trace/events/ib_umad.h:16:1: sparse: sparse: cast to restricted __be16
   include/trace/events/ib_umad.h:16:1: sparse: sparse: cast to restricted __be16
   include/trace/events/ib_umad.h:16:1: sparse: sparse: cast to restricted __be16
   include/trace/events/ib_umad.h:16:1: sparse: sparse: cast to restricted __be16
>> include/trace/events/ib_umad.h:16:1: sparse: sparse: cast to restricted __be32
>> include/trace/events/ib_umad.h:16:1: sparse: sparse: cast to restricted __be32
>> include/trace/events/ib_umad.h:16:1: sparse: sparse: cast to restricted __be32
>> include/trace/events/ib_umad.h:16:1: sparse: sparse: cast to restricted __be32
>> include/trace/events/ib_umad.h:16:1: sparse: sparse: cast to restricted __be32
>> include/trace/events/ib_umad.h:16:1: sparse: sparse: cast to restricted __be32
   drivers/infiniband/core/user_mad.c: note: in included file (through include/trace/trace_events.h, include/trace/define_trace.h, include/trace/events/ib_umad.h):
>> include/trace/events/ib_umad.h:16:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] qpn @@     got restricted __be32 [usertype] qpn @@
   include/trace/events/ib_umad.h:16:1: sparse:     expected unsigned int [usertype] qpn
   include/trace/events/ib_umad.h:16:1: sparse:     got restricted __be32 [usertype] qpn
>> include/trace/events/ib_umad.h:16:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] qkey @@     got restricted __be32 [usertype] qkey @@
   include/trace/events/ib_umad.h:16:1: sparse:     expected unsigned int [usertype] qkey
   include/trace/events/ib_umad.h:16:1: sparse:     got restricted __be32 [usertype] qkey
   include/trace/events/ib_umad.h:16:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] lid @@     got restricted __be16 [usertype] lid @@
   include/trace/events/ib_umad.h:16:1: sparse:     expected unsigned short [usertype] lid
   include/trace/events/ib_umad.h:16:1: sparse:     got restricted __be16 [usertype] lid
>> include/trace/events/ib_umad.h:16:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] flow_label @@     got restricted __be32 [usertype] flow_label @@
   include/trace/events/ib_umad.h:16:1: sparse:     expected unsigned int [usertype] flow_label
   include/trace/events/ib_umad.h:16:1: sparse:     got restricted __be32 [usertype] flow_label
   include/trace/events/ib_umad.h:16:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] mad_status @@     got restricted __be16 [usertype] status @@
   include/trace/events/ib_umad.h:16:1: sparse:     expected unsigned short [usertype] mad_status
   include/trace/events/ib_umad.h:16:1: sparse:     got restricted __be16 [usertype] status
   include/trace/events/ib_umad.h:16:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] class_specific @@     got restricted __be16 [usertype] class_specific @@
   include/trace/events/ib_umad.h:16:1: sparse:     expected unsigned short [usertype] class_specific
   include/trace/events/ib_umad.h:16:1: sparse:     got restricted __be16 [usertype] class_specific
   include/trace/events/ib_umad.h:16:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] tid @@     got restricted __be64 [usertype] tid @@
   include/trace/events/ib_umad.h:16:1: sparse:     expected unsigned long long [usertype] tid
   include/trace/events/ib_umad.h:16:1: sparse:     got restricted __be64 [usertype] tid
   include/trace/events/ib_umad.h:16:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] attr_id @@     got restricted __be16 [usertype] attr_id @@
   include/trace/events/ib_umad.h:16:1: sparse:     expected unsigned short [usertype] attr_id
   include/trace/events/ib_umad.h:16:1: sparse:     got restricted __be16 [usertype] attr_id
   include/trace/events/ib_umad.h:16:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] attr_mod @@     got restricted __be32 [usertype] attr_mod @@
   include/trace/events/ib_umad.h:16:1: sparse:     expected unsigned int [usertype] attr_mod
   include/trace/events/ib_umad.h:16:1: sparse:     got restricted __be32 [usertype] attr_mod

vim +23 include/trace/events/ib_mad.h

4d60cad5db7fb4 Ira Weiny     2019-03-19   22  
4d60cad5db7fb4 Ira Weiny     2019-03-19  @23  DECLARE_EVENT_CLASS(ib_mad_send_template,
4d60cad5db7fb4 Ira Weiny     2019-03-19   24  	TP_PROTO(struct ib_mad_send_wr_private *wr,
4d60cad5db7fb4 Ira Weiny     2019-03-19   25  		 struct ib_mad_qp_info *qp_info),
4d60cad5db7fb4 Ira Weiny     2019-03-19   26  	TP_ARGS(wr, qp_info),
4d60cad5db7fb4 Ira Weiny     2019-03-19   27  
4d60cad5db7fb4 Ira Weiny     2019-03-19   28  	TP_STRUCT__entry(
4d60cad5db7fb4 Ira Weiny     2019-03-19   29  		__field(u8,             base_version)
4d60cad5db7fb4 Ira Weiny     2019-03-19   30  		__field(u8,             mgmt_class)
4d60cad5db7fb4 Ira Weiny     2019-03-19   31  		__field(u8,             class_version)
4d60cad5db7fb4 Ira Weiny     2019-03-19   32  		__field(u8,             port_num)
4d60cad5db7fb4 Ira Weiny     2019-03-19   33  		__field(u32,            qp_num)
4d60cad5db7fb4 Ira Weiny     2019-03-19   34  		__field(u8,             method)
4d60cad5db7fb4 Ira Weiny     2019-03-19   35  		__field(u8,             sl)
4d60cad5db7fb4 Ira Weiny     2019-03-19   36  		__field(u16,            attr_id)
4d60cad5db7fb4 Ira Weiny     2019-03-19   37  		__field(u32,            attr_mod)
4d60cad5db7fb4 Ira Weiny     2019-03-19   38  		__field(u64,            wrtid)
4d60cad5db7fb4 Ira Weiny     2019-03-19   39  		__field(u64,            tid)
4d60cad5db7fb4 Ira Weiny     2019-03-19   40  		__field(u16,            status)
4d60cad5db7fb4 Ira Weiny     2019-03-19   41  		__field(u16,            class_specific)
4d60cad5db7fb4 Ira Weiny     2019-03-19   42  		__field(u32,            length)
4d60cad5db7fb4 Ira Weiny     2019-03-19   43  		__field(u32,            dlid)
4d60cad5db7fb4 Ira Weiny     2019-03-19   44  		__field(u32,            rqpn)
4d60cad5db7fb4 Ira Weiny     2019-03-19   45  		__field(u32,            rqkey)
4d60cad5db7fb4 Ira Weiny     2019-03-19   46  		__field(u32,            dev_index)
4d60cad5db7fb4 Ira Weiny     2019-03-19   47  		__field(void *,         agent_priv)
4d60cad5db7fb4 Ira Weiny     2019-03-19   48  		__field(unsigned long,  timeout)
4d60cad5db7fb4 Ira Weiny     2019-03-19   49  		__field(int,            retries_left)
4d60cad5db7fb4 Ira Weiny     2019-03-19   50  		__field(int,            max_retries)
4d60cad5db7fb4 Ira Weiny     2019-03-19   51  		__field(int,            retry)
4d60cad5db7fb4 Ira Weiny     2019-03-19   52  	),
4d60cad5db7fb4 Ira Weiny     2019-03-19   53  
4d60cad5db7fb4 Ira Weiny     2019-03-19   54  	TP_fast_assign(
4d60cad5db7fb4 Ira Weiny     2019-03-19   55  		__entry->dev_index = wr->mad_agent_priv->agent.device->index;
4d60cad5db7fb4 Ira Weiny     2019-03-19   56  		__entry->port_num = wr->mad_agent_priv->agent.port_num;
4d60cad5db7fb4 Ira Weiny     2019-03-19   57  		__entry->qp_num = wr->mad_agent_priv->qp_info->qp->qp_num;
4d60cad5db7fb4 Ira Weiny     2019-03-19   58  		__entry->agent_priv = wr->mad_agent_priv;
4d60cad5db7fb4 Ira Weiny     2019-03-19   59  		__entry->wrtid = wr->tid;
4d60cad5db7fb4 Ira Weiny     2019-03-19   60  		__entry->max_retries = wr->max_retries;
4d60cad5db7fb4 Ira Weiny     2019-03-19   61  		__entry->retries_left = wr->retries_left;
4d60cad5db7fb4 Ira Weiny     2019-03-19   62  		__entry->retry = wr->retry;
4d60cad5db7fb4 Ira Weiny     2019-03-19   63  		__entry->timeout = wr->timeout;
4d60cad5db7fb4 Ira Weiny     2019-03-19   64  		__entry->length = wr->send_buf.hdr_len +
4d60cad5db7fb4 Ira Weiny     2019-03-19   65  				  wr->send_buf.data_len;
4d60cad5db7fb4 Ira Weiny     2019-03-19   66  		__entry->base_version =
4d60cad5db7fb4 Ira Weiny     2019-03-19   67  			((struct ib_mad_hdr *)wr->send_buf.mad)->base_version;
4d60cad5db7fb4 Ira Weiny     2019-03-19   68  		__entry->mgmt_class =
4d60cad5db7fb4 Ira Weiny     2019-03-19   69  			((struct ib_mad_hdr *)wr->send_buf.mad)->mgmt_class;
4d60cad5db7fb4 Ira Weiny     2019-03-19   70  		__entry->class_version =
4d60cad5db7fb4 Ira Weiny     2019-03-19   71  			((struct ib_mad_hdr *)wr->send_buf.mad)->class_version;
4d60cad5db7fb4 Ira Weiny     2019-03-19   72  		__entry->method =
4d60cad5db7fb4 Ira Weiny     2019-03-19   73  			((struct ib_mad_hdr *)wr->send_buf.mad)->method;
4d60cad5db7fb4 Ira Weiny     2019-03-19   74  		__entry->status =
4d60cad5db7fb4 Ira Weiny     2019-03-19   75  			((struct ib_mad_hdr *)wr->send_buf.mad)->status;
4d60cad5db7fb4 Ira Weiny     2019-03-19   76  		__entry->class_specific =
4d60cad5db7fb4 Ira Weiny     2019-03-19   77  			((struct ib_mad_hdr *)wr->send_buf.mad)->class_specific;
4d60cad5db7fb4 Ira Weiny     2019-03-19   78  		__entry->tid = ((struct ib_mad_hdr *)wr->send_buf.mad)->tid;
4d60cad5db7fb4 Ira Weiny     2019-03-19   79  		__entry->attr_id =
4d60cad5db7fb4 Ira Weiny     2019-03-19   80  			((struct ib_mad_hdr *)wr->send_buf.mad)->attr_id;
4d60cad5db7fb4 Ira Weiny     2019-03-19   81  		__entry->attr_mod =
4d60cad5db7fb4 Ira Weiny     2019-03-19   82  			((struct ib_mad_hdr *)wr->send_buf.mad)->attr_mod;
4d60cad5db7fb4 Ira Weiny     2019-03-19   83  		create_mad_addr_info(wr, qp_info, __entry);
4d60cad5db7fb4 Ira Weiny     2019-03-19   84  	),
4d60cad5db7fb4 Ira Weiny     2019-03-19   85  
4d60cad5db7fb4 Ira Weiny     2019-03-19   86  	TP_printk("%d:%d QP%d agent %p: " \
4d60cad5db7fb4 Ira Weiny     2019-03-19   87  		  "wrtid 0x%llx; %d/%d retries(%d); timeout %lu length %d : " \
4d60cad5db7fb4 Ira Weiny     2019-03-19   88  		  "hdr : base_ver 0x%x class 0x%x class_ver 0x%x " \
4d60cad5db7fb4 Ira Weiny     2019-03-19   89  		  "method 0x%x status 0x%x class_specific 0x%x tid 0x%llx " \
4d60cad5db7fb4 Ira Weiny     2019-03-19   90  		  "attr_id 0x%x attr_mod 0x%x  => dlid 0x%08x sl %d "\
5c20311d76cbae Leonid Ravich 2022-11-09   91  		  "rpqn 0x%x rqpkey 0x%x",
4d60cad5db7fb4 Ira Weiny     2019-03-19   92  		__entry->dev_index, __entry->port_num, __entry->qp_num,
4d60cad5db7fb4 Ira Weiny     2019-03-19   93  		__entry->agent_priv, be64_to_cpu(__entry->wrtid),
4d60cad5db7fb4 Ira Weiny     2019-03-19   94  		__entry->retries_left, __entry->max_retries,
4d60cad5db7fb4 Ira Weiny     2019-03-19   95  		__entry->retry, __entry->timeout, __entry->length,
4d60cad5db7fb4 Ira Weiny     2019-03-19   96  		__entry->base_version, __entry->mgmt_class,
4d60cad5db7fb4 Ira Weiny     2019-03-19   97  		__entry->class_version,
4d60cad5db7fb4 Ira Weiny     2019-03-19   98  		__entry->method, be16_to_cpu(__entry->status),
4d60cad5db7fb4 Ira Weiny     2019-03-19   99  		be16_to_cpu(__entry->class_specific),
4d60cad5db7fb4 Ira Weiny     2019-03-19  100  		be64_to_cpu(__entry->tid), be16_to_cpu(__entry->attr_id),
4d60cad5db7fb4 Ira Weiny     2019-03-19  101  		be32_to_cpu(__entry->attr_mod),
5c20311d76cbae Leonid Ravich 2022-11-09  102  		be32_to_cpu(__entry->dlid), __entry->sl,
4d60cad5db7fb4 Ira Weiny     2019-03-19  103  		__entry->rqpn, __entry->rqkey
4d60cad5db7fb4 Ira Weiny     2019-03-19  104  	)
4d60cad5db7fb4 Ira Weiny     2019-03-19  105  );
4d60cad5db7fb4 Ira Weiny     2019-03-19  106  

:::::: The code at line 23 was first introduced by commit
:::::: 4d60cad5db7fb450e64532afbbaba85af235fa5d IB/MAD: Add send path trace points

:::::: TO: Ira Weiny <ira.weiny@intel.com>
:::::: CC: Jason Gunthorpe <jgg@mellanox.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

