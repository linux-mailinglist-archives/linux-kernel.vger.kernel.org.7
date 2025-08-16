Return-Path: <linux-kernel+bounces-771984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D96CB28D7E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 13:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F5183A65C6
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 11:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49635286416;
	Sat, 16 Aug 2025 11:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i4AkqDGM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22F31E86E
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 11:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755344835; cv=none; b=HXzdTDZZvPYhW3/Wm0W4QCl2mfzp80H5L2DQvoNxYfHBBDx3ifPM55wh2U9KOD4vbF2gLPSPVf1VlcgZFinT5YsUWTbpfUMXCHUkwoPir8h+iWU/1K8h+qJVAy4whnFYDHvmRY0dqbY6tz58r7NryaxoRlUvcP61ZI6YKqkcgQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755344835; c=relaxed/simple;
	bh=9QG2qnN+bLG0YRjxusIeoXyhEcbIIovm9S32OrHzO+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iuVAqo5ua3/Pdtz3r0MS5eH9+cEXbCLvaAhBtDE3LpeLV8BI/z3HiJUK5wz1q/NXqzt/7bvmjdWNByV6igkCeq8MD/ocvdMBo4xt5ycD1D3V4AcLGbRLbkH1KaP9U42PcfDdB8sJRgt+3l6sgp3b70YoefY85ythhc+d9U7hLhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i4AkqDGM; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755344834; x=1786880834;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9QG2qnN+bLG0YRjxusIeoXyhEcbIIovm9S32OrHzO+A=;
  b=i4AkqDGMPTJGxFfssZOaK8ZnPXd7tIGnHhMMrRC7FH7/pF92ydEf772P
   FwZseWhcnVvZVY4pxUx5WDm+Hu4O93EEi8c5eTNImXuOiCxNGTmYMLW6A
   zn6N70hky886i+2MJFeK/guDTLdeeeS54Z1mjeqnP/rbdpf8NR/+chI7U
   yMEQzGRrDk1F/U/EOHUIeFFMpYHWe3Zb6kF3McVN8yG6mlbISmsUSDon3
   T2HHKLF9ni+U3QxxtAEzBqIYA+p8yHA3hRnLw5TI0Xcs5rUm0GRuzubiI
   H7vTdqGmz2ziwuOJzkXpCY3aw7eEYG3Upr34Aosc7WTgD8On02D0UEelO
   A==;
X-CSE-ConnectionGUID: a+sZodJ5SVW5mtuLzA23OA==
X-CSE-MsgGUID: zLbGTkRWRKy5xtZ5DECbXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11523"; a="57748533"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="57748533"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2025 04:47:13 -0700
X-CSE-ConnectionGUID: HqWPDu/kQ9GXT3ZWH1xpiw==
X-CSE-MsgGUID: kAy0Muq7SN+8aIBnGiPL5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="166822571"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 16 Aug 2025 04:47:11 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1unFNI-000Cqk-0N;
	Sat, 16 Aug 2025 11:47:06 +0000
Date: Sat, 16 Aug 2025 19:46:15 +0800
From: kernel test robot <lkp@intel.com>
To: Tzung-Bi Shih <tzungbi@kernel.org>, bleung@chromium.org
Cc: oe-kbuild-all@lists.linux.dev, tzungbi@kernel.org, dawidn@google.com,
	chrome-platform@lists.linux.dev, akpm@linux-foundation.org,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] platform/chrome: cros_ec_chardev: Consume
 cros_ec_device via ref_proxy
Message-ID: <202508161910.b7YHKLdh-lkp@intel.com>
References: <20250814091020.1302888-4-tzungbi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814091020.1302888-4-tzungbi@kernel.org>

Hi Tzung-Bi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on chrome-platform/for-next]
[also build test WARNING on next-20250815]
[cannot apply to chrome-platform/for-firmware-next akpm-mm/mm-nonmm-unstable akpm-mm/mm-everything linus/master v6.17-rc1]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tzung-Bi-Shih/lib-Add-ref_proxy-module/20250814-172126
base:   https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git for-next
patch link:    https://lore.kernel.org/r/20250814091020.1302888-4-tzungbi%40kernel.org
patch subject: [PATCH 3/3] platform/chrome: cros_ec_chardev: Consume cros_ec_device via ref_proxy
config: i386-randconfig-061-20250815 (https://download.01.org/0day-ci/archive/20250816/202508161910.b7YHKLdh-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250816/202508161910.b7YHKLdh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508161910.b7YHKLdh-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/platform/chrome/cros_ec_chardev.c:75:47: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct cros_ec_device *ec_dev @@     got struct cros_ec_device [noderef] __rcu *[assigned] ec_dev @@
   drivers/platform/chrome/cros_ec_chardev.c:75:47: sparse:     expected struct cros_ec_device *ec_dev
   drivers/platform/chrome/cros_ec_chardev.c:75:47: sparse:     got struct cros_ec_device [noderef] __rcu *[assigned] ec_dev
>> drivers/platform/chrome/cros_ec_chardev.c:126:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got union ec_response_get_next_data_v3 [noderef] __rcu * @@
   drivers/platform/chrome/cros_ec_chardev.c:126:17: sparse:     expected void const *
   drivers/platform/chrome/cros_ec_chardev.c:126:17: sparse:     got union ec_response_get_next_data_v3 [noderef] __rcu *
>> drivers/platform/chrome/cros_ec_chardev.c:126:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got union ec_response_get_next_data_v3 [noderef] __rcu * @@
   drivers/platform/chrome/cros_ec_chardev.c:126:17: sparse:     expected void const *
   drivers/platform/chrome/cros_ec_chardev.c:126:17: sparse:     got union ec_response_get_next_data_v3 [noderef] __rcu *
   drivers/platform/chrome/cros_ec_chardev.c:126:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const * @@     got union ec_response_get_next_data_v3 [noderef] __rcu * @@
   drivers/platform/chrome/cros_ec_chardev.c:126:17: sparse:     expected void const *
   drivers/platform/chrome/cros_ec_chardev.c:126:17: sparse:     got union ec_response_get_next_data_v3 [noderef] __rcu *
>> drivers/platform/chrome/cros_ec_chardev.c:287:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct blocking_notifier_head *nh @@     got struct blocking_notifier_head [noderef] __rcu * @@
   drivers/platform/chrome/cros_ec_chardev.c:287:42: sparse:     expected struct blocking_notifier_head *nh
   drivers/platform/chrome/cros_ec_chardev.c:287:42: sparse:     got struct blocking_notifier_head [noderef] __rcu *
   drivers/platform/chrome/cros_ec_chardev.c:341:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct cros_ec_device *ec_dev @@     got struct cros_ec_device [noderef] __rcu *[assigned] ec_dev @@
   drivers/platform/chrome/cros_ec_chardev.c:341:40: sparse:     expected struct cros_ec_device *ec_dev
   drivers/platform/chrome/cros_ec_chardev.c:341:40: sparse:     got struct cros_ec_device [noderef] __rcu *[assigned] ec_dev
>> drivers/platform/chrome/cros_ec_chardev.c:374:43: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct cros_ec_device *ec @@     got struct cros_ec_device [noderef] __rcu *[assigned] ec_dev @@
   drivers/platform/chrome/cros_ec_chardev.c:374:43: sparse:     expected struct cros_ec_device *ec
   drivers/platform/chrome/cros_ec_chardev.c:374:43: sparse:     got struct cros_ec_device [noderef] __rcu *[assigned] ec_dev
>> drivers/platform/chrome/cros_ec_chardev.c:113:34: sparse: sparse: dereference of noderef expression
   drivers/platform/chrome/cros_ec_chardev.c:114:47: sparse: sparse: dereference of noderef expression
   drivers/platform/chrome/cros_ec_chardev.c:124:31: sparse: sparse: dereference of noderef expression
   drivers/platform/chrome/cros_ec_chardev.c:125:37: sparse: sparse: dereference of noderef expression
   drivers/platform/chrome/cros_ec_chardev.c:126:17: sparse: sparse: dereference of noderef expression
   drivers/platform/chrome/cros_ec_chardev.c:365:22: sparse: sparse: dereference of noderef expression
   drivers/platform/chrome/cros_ec_chardev.c:374:23: sparse: sparse: dereference of noderef expression

vim +75 drivers/platform/chrome/cros_ec_chardev.c

    51	
    52	static int ec_get_version(struct chardev_priv *priv, char *str, int maxlen)
    53	{
    54		static const char * const current_image_name[] = {
    55			"unknown", "read-only", "read-write", "invalid",
    56		};
    57		struct ec_response_get_version *resp;
    58		struct cros_ec_command *msg;
    59		struct cros_ec_device __rcu *ec_dev;
    60		int ret;
    61	
    62		msg = kzalloc(sizeof(*msg) + sizeof(*resp), GFP_KERNEL);
    63		if (!msg)
    64			return -ENOMEM;
    65	
    66		msg->command = EC_CMD_GET_VERSION + priv->cmd_offset;
    67		msg->insize = sizeof(*resp);
    68	
    69		REF_PROXY_GET(priv->ec_dev_proxy, ec_dev) {
    70			if (!ec_dev) {
    71				ret = -ENODEV;
    72				goto exit;
    73			}
    74	
  > 75			ret = cros_ec_cmd_xfer_status(ec_dev, msg);
    76			if (ret < 0) {
    77				snprintf(str, maxlen,
    78					 "Unknown EC version, returned error: %d\n",
    79					 msg->result);
    80				goto exit;
    81			}
    82		}
    83	
    84		resp = (struct ec_response_get_version *)msg->data;
    85		if (resp->current_image >= ARRAY_SIZE(current_image_name))
    86			resp->current_image = 3; /* invalid */
    87	
    88		snprintf(str, maxlen, "%s\n%s\n%s\n%s\n", CROS_EC_DEV_VERSION,
    89			 resp->version_string_ro, resp->version_string_rw,
    90			 current_image_name[resp->current_image]);
    91	
    92		ret = 0;
    93	exit:
    94		kfree(msg);
    95		return ret;
    96	}
    97	
    98	static int cros_ec_chardev_mkbp_event(struct notifier_block *nb,
    99					      unsigned long queued_during_suspend,
   100					      void *_notify)
   101	{
   102		struct chardev_priv *priv = container_of(nb, struct chardev_priv,
   103							 notifier);
   104		struct cros_ec_device __rcu *ec_dev;
   105		struct ec_event *event;
   106		unsigned long event_bit;
   107		int total_size;
   108	
   109		REF_PROXY_GET(priv->ec_dev_proxy, ec_dev) {
   110			if (!ec_dev)
   111				return NOTIFY_DONE;
   112	
 > 113			event_bit = 1 << ec_dev->event_data.event_type;
   114			total_size = sizeof(*event) + ec_dev->event_size;
   115	
   116			if (!(event_bit & priv->event_mask) ||
   117			    (priv->event_len + total_size) > CROS_MAX_EVENT_LEN)
   118				return NOTIFY_DONE;
   119	
   120			event = kzalloc(total_size, GFP_KERNEL);
   121			if (!event)
   122				return NOTIFY_DONE;
   123	
   124			event->size = ec_dev->event_size;
   125			event->event_type = ec_dev->event_data.event_type;
 > 126			memcpy(event->data, &ec_dev->event_data.data, ec_dev->event_size);
   127		}
   128	
   129		spin_lock(&priv->wait_event.lock);
   130		list_add_tail(&event->node, &priv->events);
   131		priv->event_len += total_size;
   132		wake_up_locked(&priv->wait_event);
   133		spin_unlock(&priv->wait_event.lock);
   134	
   135		return NOTIFY_OK;
   136	}
   137	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

