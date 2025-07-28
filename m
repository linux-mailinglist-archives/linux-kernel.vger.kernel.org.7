Return-Path: <linux-kernel+bounces-748370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 489EBB14054
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 18:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FF2F17DE46
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 16:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A784E27467F;
	Mon, 28 Jul 2025 16:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nr4Tskh4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBE8BE4E;
	Mon, 28 Jul 2025 16:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753720347; cv=none; b=TMSBgPe5UEolWQJvHLQrTn8SP6zqwwkUNghIkdram5huNlENDOIacwGjSwwf7M5AizNgdJ+i5A8t2mE28xaFWD5z1UEoDE/LFg1AMe5a0bbFbiBYZYsaWdq+kQKBsoB7nf4TYjTLpBxHfZ50DqsobDnGbWG8oWKhjz0okwWpMEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753720347; c=relaxed/simple;
	bh=/eUcfZ2MqgwVLNwIK09gIw7s9T8A3iFU9L3OUUHRTYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aD7nwiomo/fsbVf2o9NitQ/S2drVgxvwLt7R508qsxPgdhB3gtc7jLN4u0vqbrVSC2gzPRSnALG8EbbgB5angdrVZIw4UHIJEJSLbp23irVbpruumC0v/c6FKpcoKsIFx2XTYpBTjZocY55vc6xAtFoMvtF8DVvovVb2NOoMNAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nr4Tskh4; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753720345; x=1785256345;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/eUcfZ2MqgwVLNwIK09gIw7s9T8A3iFU9L3OUUHRTYE=;
  b=Nr4Tskh4yuLxqFh2ah6NhzLN4C1fp6pV82UfWtJ/LI4slr9nRKRt0M2W
   6gECgdCoIUbiaieIzkHI35Ak1mn/crsq01Y6vbkIU9iC58K5Xu9GoAdkz
   o3tm0zR4ibNZtItCcoYVgFG1jvZFTMUPDl6khp+kzjyZEpWvYrtXTtMHv
   zISkbgRgzvTyRBpfkI02tXDeFlWX82Uo9UaBd/lJXul7Y6FdoopWX+nJq
   G6R7gRzFq6Tjp0QunAQ4zJ0r/bFBuG11+OsO8YQICvt88gNLxVIp/RPO5
   tCNKmrgdUf/9prqZBvdJYSC5t+zdYItVOXFMbunNlFWvPQX/W5UDLXKsn
   A==;
X-CSE-ConnectionGUID: M5R597dhSjadkBECOEVOCg==
X-CSE-MsgGUID: 2+no70zUQh6ZUv5NgFobFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11505"; a="59797049"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="59797049"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2025 09:32:22 -0700
X-CSE-ConnectionGUID: mGMB5dIPRrWwWGNTnc7Z/g==
X-CSE-MsgGUID: TZaWB7G9SVChLWy3JNAA1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="166946244"
Received: from lkp-server01.sh.intel.com (HELO 160750d4a34c) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 28 Jul 2025 09:32:16 -0700
Received: from kbuild by 160750d4a34c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ugQlp-0000aP-1G;
	Mon, 28 Jul 2025 16:32:13 +0000
Date: Tue, 29 Jul 2025 00:31:47 +0800
From: kernel test robot <lkp@intel.com>
To: "Derek J. Clark" <derekjohn.clark@gmail.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hansg@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Alok Tiwari <alok.a.tiwari@oracle.com>,
	David Box <david.e.box@linux.intel.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 1/4] platform/x86: (ayn-ec) Add PWM Fan HWMON Interface
Message-ID: <202507290022.MIp5QCIp-lkp@intel.com>
References: <20250726204041.516440-2-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250726204041.516440-2-derekjohn.clark@gmail.com>

Hi Derek,

kernel test robot noticed the following build errors:

[auto build test ERROR on groeck-staging/hwmon-next]
[also build test ERROR on linus/master v6.16 next-20250728]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Derek-J-Clark/platform-x86-ayn-ec-Add-PWM-Fan-HWMON-Interface/20250727-044332
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
patch link:    https://lore.kernel.org/r/20250726204041.516440-2-derekjohn.clark%40gmail.com
patch subject: [PATCH v3 1/4] platform/x86: (ayn-ec) Add PWM Fan HWMON Interface
config: i386-randconfig-004-20250728 (https://download.01.org/0day-ci/archive/20250729/202507290022.MIp5QCIp-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250729/202507290022.MIp5QCIp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507290022.MIp5QCIp-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "ec_read" [drivers/platform/x86/ayn-ec.ko] undefined!
>> ERROR: modpost: "ec_write" [drivers/platform/x86/ayn-ec.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

