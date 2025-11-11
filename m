Return-Path: <linux-kernel+bounces-895870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 536DEC4F26C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 17:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DDC43BEA32
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9BF377EAB;
	Tue, 11 Nov 2025 16:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kCIRjXUS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14003043B5;
	Tue, 11 Nov 2025 16:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762880103; cv=none; b=OLUj8awfIQuEb0MqGzEeckIvc4e88Xa3Q1m1MBT9r6XsUkrqpSMmeXFY37qrap3WLKwPQIEClBcpxkfw6tgSYI0JMsY91GHvg6T+ThdscZPclzlHPcoDEdFvKf0SmAtsNI88UTCjGWQI5zvvCPsSTZuhReP2vyeg/X/IJYCkM2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762880103; c=relaxed/simple;
	bh=prdjIqfhZ5Q0oGHb9kMj2RXqTMX3Z4oj+cyb9XYhN0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qtpuwUobVyZDbd+SMHaRHfEgvlkeOVOwvmZS5yaitF8jGOSU1thq7bW604bdM7Z7qSVK7hX4L+lvizbf/tGtHvx/sq3MYy7PvYDeQzXYGpHoD1blvbrcooS24VQqaUpUb4xZze7M2n7KU9Bt0aqIJM0mhfiiXt8TxN9L/1Du4e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kCIRjXUS; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762880102; x=1794416102;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=prdjIqfhZ5Q0oGHb9kMj2RXqTMX3Z4oj+cyb9XYhN0c=;
  b=kCIRjXUSie5mtzwzJA8zfmRA3b/fDhVbGqqK9M3SERqSBTifiZ+wsWdG
   qvxCA+Oz7LPVZegQYEtOprKI/CywsFHkCKoKYfduIhCL18W0pWs+GG1r3
   T3TEM4MEa9LeXNdhaVvK63IOkHyRXZx5EBr/T7Tnaz7Qgq0xVeEWG7Rx+
   Gy4YUEFGRHY/DY7pAPpe6cixUbcmvdeXdYwOmHg7DQxR0os0nO3aJ3ag+
   IP7q1rBAYiaC55amLkwdlF3upSukyNryETcTw0d0RZ7XD8ttTHrlLQ+oY
   heaYve2zV1ycJ4rh1LlmlUjHheG/+WESJPjjEmULNtOWxoXIXPdvbwxpq
   Q==;
X-CSE-ConnectionGUID: JR8YbLO8QFqBbjOF7O73Uw==
X-CSE-MsgGUID: VM7/uyCgREOxf02xbljwTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11610"; a="64150237"
X-IronPort-AV: E=Sophos;i="6.19,297,1754982000"; 
   d="scan'208";a="64150237"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 08:55:01 -0800
X-CSE-ConnectionGUID: qj9ZEu2IS3q/G3o69uv9+w==
X-CSE-MsgGUID: LiZ1YefBQLm1L/1gKRqSZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,297,1754982000"; 
   d="scan'208";a="212405116"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 11 Nov 2025 08:54:58 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vIrdv-0003Oh-3C;
	Tue, 11 Nov 2025 16:54:55 +0000
Date: Wed, 12 Nov 2025 00:54:40 +0800
From: kernel test robot <lkp@intel.com>
To: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Fedor Pchelkin <boddah8794@gmail.com>,
	Andrei Kuchynski <akuchynski@chromium.org>,
	Venkat Jayaraman <venkat.jayaraman@intel.com>,
	Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 2/3] usb: typec: ucsi: Add duplicate detection to
 nvidia registration path
Message-ID: <202511120044.i2blPN85-lkp@intel.com>
References: <20251111010541.145421-2-acelan.kao@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111010541.145421-2-acelan.kao@canonical.com>

Hi Chia-Lin,

kernel test robot noticed the following build errors:

[auto build test ERROR on usb/usb-testing]
[also build test ERROR on usb/usb-next usb/usb-linus linus/master v6.18-rc5 next-20251111]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chia-Lin-Kao-AceLan/usb-typec-ucsi-Add-duplicate-detection-to-nvidia-registration-path/20251111-092153
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/20251111010541.145421-2-acelan.kao%40canonical.com
patch subject: [PATCH v2 2/3] usb: typec: ucsi: Add duplicate detection to nvidia registration path
config: x86_64-randconfig-072-20251111 (https://download.01.org/0day-ci/archive/20251112/202511120044.i2blPN85-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251112/202511120044.i2blPN85-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511120044.i2blPN85-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/usb/typec/ucsi/ucsi.c:547:7: error: call to undeclared function 'ucsi_altmode_is_duplicate'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     547 |                 if (ucsi_altmode_is_duplicate(con, recipient, altmode_array, i,
         |                     ^
   drivers/usb/typec/ucsi/ucsi.c:570:13: error: static declaration of 'ucsi_altmode_is_duplicate' follows non-static declaration
     570 | static bool ucsi_altmode_is_duplicate(struct ucsi_connector *con, u8 recipient,
         |             ^
   drivers/usb/typec/ucsi/ucsi.c:547:7: note: previous implicit declaration is here
     547 |                 if (ucsi_altmode_is_duplicate(con, recipient, altmode_array, i,
         |                     ^
   2 errors generated.


vim +/ucsi_altmode_is_duplicate +547 drivers/usb/typec/ucsi/ucsi.c

   483	
   484	static int
   485	ucsi_register_altmodes_nvidia(struct ucsi_connector *con, u8 recipient)
   486	{
   487		int max_altmodes = UCSI_MAX_ALTMODES;
   488		struct typec_altmode_desc desc;
   489		struct ucsi_altmode alt;
   490		struct ucsi_altmode orig[UCSI_MAX_ALTMODES];
   491		struct ucsi_altmode updated[UCSI_MAX_ALTMODES];
   492		struct ucsi *ucsi = con->ucsi;
   493		bool multi_dp = false;
   494		u64 command;
   495		int ret;
   496		int len;
   497		int i;
   498		int k = 0;
   499	
   500		if (recipient == UCSI_RECIPIENT_CON)
   501			max_altmodes = con->ucsi->cap.num_alt_modes;
   502	
   503		memset(orig, 0, sizeof(orig));
   504		memset(updated, 0, sizeof(updated));
   505	
   506		/* First get all the alternate modes */
   507		for (i = 0; i < max_altmodes; i++) {
   508			memset(&alt, 0, sizeof(alt));
   509			command = UCSI_GET_ALTERNATE_MODES;
   510			command |= UCSI_GET_ALTMODE_RECIPIENT(recipient);
   511			command |= UCSI_GET_ALTMODE_CONNECTOR_NUMBER(con->num);
   512			command |= UCSI_GET_ALTMODE_OFFSET(i);
   513			len = ucsi_send_command(con->ucsi, command, &alt, sizeof(alt));
   514			/*
   515			 * We are collecting all altmodes first and then registering.
   516			 * Some type-C device will return zero length data beyond last
   517			 * alternate modes. We should not return if length is zero.
   518			 */
   519			if (len < 0)
   520				return len;
   521	
   522			/* We got all altmodes, now break out and register them */
   523			if (!len || !alt.svid)
   524				break;
   525	
   526			orig[k].mid = alt.mid;
   527			orig[k].svid = alt.svid;
   528			k++;
   529		}
   530		/*
   531		 * Update the original altmode table as some ppms may report
   532		 * multiple DP altmodes.
   533		 */
   534		multi_dp = ucsi->ops->update_altmodes(ucsi, recipient, orig, updated);
   535	
   536		/* now register altmodes */
   537		for (i = 0; i < max_altmodes; i++) {
   538			struct ucsi_altmode *altmode_array = multi_dp ? updated : orig;
   539	
   540			if (!altmode_array[i].svid)
   541				return 0;
   542	
   543			/*
   544			 * Check for duplicates in current array and already
   545			 * registered altmodes. Skip if duplicate found.
   546			 */
 > 547			if (ucsi_altmode_is_duplicate(con, recipient, altmode_array, i,
   548						      altmode_array[i].svid,
   549						      altmode_array[i].mid, i))
   550				continue;
   551	
   552			memset(&desc, 0, sizeof(desc));
   553			desc.svid = altmode_array[i].svid;
   554			desc.vdo = altmode_array[i].mid;
   555			desc.roles = TYPEC_PORT_DRD;
   556	
   557			ret = ucsi_register_altmode(con, &desc, recipient);
   558			if (ret)
   559				return ret;
   560		}
   561	
   562		return 0;
   563	}
   564	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

