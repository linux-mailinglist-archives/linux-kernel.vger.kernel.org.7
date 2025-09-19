Return-Path: <linux-kernel+bounces-825062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BADE1B8AD41
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 19:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74956A025D2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693453218B2;
	Fri, 19 Sep 2025 17:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BGRx+Q7x"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901C524677D
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 17:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758304392; cv=none; b=StO08qvgtAU1N1dvUiuzBe54GrV5+9bUTxCtOhmrAxzKlQ17gocwHA03b0jSdBDisQXMePROPrzNI8H2awKxJ4Y1Ym9+LRO8xSkm8Y9e6jbz04lv4oBa80UY8Ds/zhuD1RF3AymF0v91nwNXWycg6UCUHWvH70/woG6TYSU3+ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758304392; c=relaxed/simple;
	bh=zcD4KrKYyKQtSs4RY+qnVbakuHatETbHq+Ctu2gCUfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qNKSrrxxZlRD8o4MmNdA0AkIf7V3a22QL+qsmKjVOMiBIJmPPJK3/MBIzAuG0t6za+nYEN0hzHHXH+VFPHNcVGC5tg4SuJcJo9517MN6eQNGn9UyDmD1zEbsGtRaBjp8oF0j5122TtbWWJ42SqmfMfuCrMVg2sw+3Gs/UsFXiLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BGRx+Q7x; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758304390; x=1789840390;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=zcD4KrKYyKQtSs4RY+qnVbakuHatETbHq+Ctu2gCUfY=;
  b=BGRx+Q7xnuRdOuUy1POkqCT7H9x671BPm92fK29s6hgmUkcl3sfaJ2t4
   KbPA6G121HS1C+7kv7IU608T3pRYnojkNJtF5ikcmohqhXfZhFQ1obQ2Q
   fEMoLAdAvZsx0UiCSLMzw29m+agXYW83Ik8MXf+6Sh9yrG6H8gfw1I3xg
   fd3FAbek2u42ILilutS23/0Utm5ZELTDnEjVWQr8du9C4wVN5lZ3OpCC2
   tmAPu8wlKu9f7baqklkzPPXBcbGQTS4Fh/FFNJ6bOumMiNF1TpikVihjm
   h2Lv1MLjEuLgbhKwmo7Qk/adHF2J9L5IsduH6whVyPq3NDbQmzr8lJmcC
   w==;
X-CSE-ConnectionGUID: l0T4qVYPTGWPvu5ZBGRG8Q==
X-CSE-MsgGUID: A5Fw3w3gTCyi03ph6Wamig==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="60573937"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="60573937"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 10:53:10 -0700
X-CSE-ConnectionGUID: X+YAV1iHTh2ZMt30KG8C3g==
X-CSE-MsgGUID: N8CKa8UCR8qKTVHjz9OJ2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="179911950"
Received: from lkp-server01.sh.intel.com (HELO 84a20bd60769) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 19 Sep 2025 10:53:08 -0700
Received: from kbuild by 84a20bd60769 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uzfI9-0004cx-0F;
	Fri, 19 Sep 2025 17:53:05 +0000
Date: Sat, 20 Sep 2025 01:52:18 +0800
From: kernel test robot <lkp@intel.com>
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	linux1394-devel@lists.sourceforge.net
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] firewire: core; eliminate pick_me goto label
Message-ID: <202509200157.ZsFKlqm4-lkp@intel.com>
References: <20250918230857.127400-6-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250918230857.127400-6-o-takashi@sakamocchi.jp>

Hi Takashi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on e6d2338b6f3e522872f3a14fcc5e5de2f58bf23b]

url:    https://github.com/intel-lab-lkp/linux/commits/Takashi-Sakamoto/firewire-core-remove-useless-generation-check/20250919-115832
base:   e6d2338b6f3e522872f3a14fcc5e5de2f58bf23b
patch link:    https://lore.kernel.org/r/20250918230857.127400-6-o-takashi%40sakamocchi.jp
patch subject: [PATCH 5/6] firewire: core; eliminate pick_me goto label
config: x86_64-randconfig-001-20250919 (https://download.01.org/0day-ci/archive/20250920/202509200157.ZsFKlqm4-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250920/202509200157.ZsFKlqm4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509200157.ZsFKlqm4-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/firewire/core-card.c:404:6: warning: variable 'stand_for_root' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
     404 |         if (card->bm_generation != generation) {
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/firewire/core-card.c:445:7: note: uninitialized use occurs here
     445 |         if (!stand_for_root) {
         |              ^~~~~~~~~~~~~~
   drivers/firewire/core-card.c:404:2: note: remove the 'if' if its condition is always true
     404 |         if (card->bm_generation != generation) {
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/firewire/core-card.c:391:21: note: initialize the variable 'stand_for_root' to silence this warning
     391 |         bool stand_for_root;
         |                            ^
         |                             = 0
   1 warning generated.


vim +404 drivers/firewire/core-card.c

e309c29e1b26f4 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-19  380  
e309c29e1b26f4 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-19  381  static void bm_work(struct work_struct *work)
e309c29e1b26f4 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-19  382  {
e309c29e1b26f4 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-19  383  	static const char gap_count_table[] = {
e309c29e1b26f4 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-19  384  		63, 5, 7, 8, 10, 13, 16, 18, 21, 24, 26, 29, 32, 35, 37, 40
e309c29e1b26f4 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-19  385  	};
e309c29e1b26f4 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-19  386  	struct fw_card *card __free(card_unref) = from_work(card, work, bm_work.work);
e309c29e1b26f4 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-19  387  	struct fw_node *root_node __free(node_unref) = NULL;
e309c29e1b26f4 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-19  388  	int root_id, new_root_id, irm_id, local_id;
e309c29e1b26f4 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-19  389  	int expected_gap_count, generation;
e309c29e1b26f4 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-19  390  	bool do_reset = false;
de5d138456fb29 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-19  391  	bool stand_for_root;
e309c29e1b26f4 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-19  392  
e309c29e1b26f4 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-19  393  	if (card->local_node == NULL)
e309c29e1b26f4 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-19  394  		return;
e309c29e1b26f4 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-19  395  
e309c29e1b26f4 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-19  396  	generation = card->generation;
e309c29e1b26f4 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-19  397  
e309c29e1b26f4 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-19  398  	root_node = fw_node_get(card->root_node);
e309c29e1b26f4 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-19  399  
e309c29e1b26f4 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-19  400  	root_id  = root_node->node_id;
e309c29e1b26f4 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-19  401  	irm_id   = card->irm_node->node_id;
e309c29e1b26f4 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-19  402  	local_id = card->local_node->node_id;
e309c29e1b26f4 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-19  403  
e309c29e1b26f4 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-19 @404  	if (card->bm_generation != generation) {
e309c29e1b26f4 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-19  405  		enum bm_contention_outcome result = contend_for_bm(card);
e309c29e1b26f4 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-19  406  
e309c29e1b26f4 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-19  407  		switch (result) {
e309c29e1b26f4 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-19  408  		case BM_CONTENTION_OUTCOME_WITHIN_WINDOW:
379b870c28c6a6 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-15  409  			fw_schedule_bm_work(card, msecs_to_jiffies(125));
25feb1a96e21ae drivers/firewire/core-card.c Takashi Sakamoto  2025-09-08  410  			return;
e309c29e1b26f4 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-19  411  		case BM_CONTENTION_OUTCOME_IRM_HAS_LINK_OFF:
de5d138456fb29 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-19  412  			stand_for_root = true;
de5d138456fb29 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-19  413  			break;
e309c29e1b26f4 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-19  414  		case BM_CONTENTION_OUTCOME_IRM_COMPLIES_1394_1995_ONLY:
de5d138456fb29 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-19  415  			stand_for_root = true;
de5d138456fb29 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-19  416  			break;
e309c29e1b26f4 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-19  417  		case BM_CONTENTION_OUTCOME_AT_NEW_GENERATION:
e309c29e1b26f4 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-19  418  			// BM work has been rescheduled.
e309c29e1b26f4 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-19  419  			return;
e309c29e1b26f4 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-19  420  		case BM_CONTENTION_OUTCOME_LOCAL_PROBLEM_AT_TRANSACTION:
e309c29e1b26f4 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-19  421  			// Let's try again later and hope that the local problem has gone away by
e309c29e1b26f4 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-19  422  			// then.
e309c29e1b26f4 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-19  423  			fw_schedule_bm_work(card, msecs_to_jiffies(125));
e309c29e1b26f4 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-19  424  			return;
e309c29e1b26f4 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-19  425  		case BM_CONTENTION_OUTCOME_IRM_IS_NOT_CAPABLE_FOR_IRM:
e309c29e1b26f4 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-19  426  			// Let's do a bus reset and pick the local node as root, and thus, IRM.
de5d138456fb29 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-19  427  			stand_for_root = true;
de5d138456fb29 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-19  428  			break;
e309c29e1b26f4 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-19  429  		case BM_CONTENTION_OUTCOME_IRM_HOLDS_ANOTHER_NODE_AS_BM:
e309c29e1b26f4 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-19  430  			if (local_id == irm_id) {
e309c29e1b26f4 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-19  431  				// Only acts as IRM.
e309c29e1b26f4 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-19  432  				allocate_broadcast_channel(card, generation);
e309c29e1b26f4 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-19  433  			}
e309c29e1b26f4 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-19  434  			fallthrough;
e309c29e1b26f4 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-19  435  		case BM_CONTENTION_OUTCOME_IRM_HOLDS_LOCAL_NODE_AS_BM:
e309c29e1b26f4 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-19  436  		default:
e309c29e1b26f4 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-19  437  			card->bm_generation = generation;
de5d138456fb29 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-19  438  			stand_for_root = false;
e309c29e1b26f4 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-19  439  			break;
931c4834c8d1e1 drivers/firewire/fw-card.c   Kristian Høgsberg 2007-01-26  440  		}
ff94548bbb2edf drivers/firewire/core-card.c Takashi Sakamoto  2025-09-19  441  	}
931c4834c8d1e1 drivers/firewire/fw-card.c   Kristian Høgsberg 2007-01-26  442  
de5d138456fb29 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-19  443  	// We're bus manager for this generation, so next step is to make sure we have an active
de5d138456fb29 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-19  444  	// cycle master and do gap count optimization.
de5d138456fb29 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-19  445  	if (!stand_for_root) {
91bf158f8cdf6f drivers/firewire/core-card.c Takashi Sakamoto  2025-09-13  446  		if (card->gap_count == GAP_COUNT_MISMATCHED) {
de5d138456fb29 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-19  447  			// If self IDs have inconsistent gap counts, do a
de5d138456fb29 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-19  448  			// bus reset ASAP. The config rom read might never
de5d138456fb29 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-19  449  			// complete, so don't wait for it. However, still
de5d138456fb29 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-19  450  			// send a PHY configuration packet prior to the
de5d138456fb29 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-19  451  			// bus reset. The PHY configuration packet might
de5d138456fb29 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-19  452  			// fail, but 1394-2008 8.4.5.2 explicitly permits
de5d138456fb29 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-19  453  			// it in this case, so it should be safe to try.
de5d138456fb29 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-19  454  			stand_for_root = true;
de5d138456fb29 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-19  455  
de5d138456fb29 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-19  456  			// We must always send a bus reset if the gap count
de5d138456fb29 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-19  457  			// is inconsistent, so bypass the 5-reset limit.
7ed4380009e96d drivers/firewire/core-card.c Takashi Sakamoto  2024-02-07  458  			card->bm_retries = 0;
cae2d92cdcae3f drivers/firewire/core-card.c Takashi Sakamoto  2025-09-08  459  		} else {
cae2d92cdcae3f drivers/firewire/core-card.c Takashi Sakamoto  2025-09-08  460  			// Now investigate root node.
cae2d92cdcae3f drivers/firewire/core-card.c Takashi Sakamoto  2025-09-08  461  			struct fw_device *root_device = fw_node_get_device(root_node);
cae2d92cdcae3f drivers/firewire/core-card.c Takashi Sakamoto  2025-09-08  462  
cae2d92cdcae3f drivers/firewire/core-card.c Takashi Sakamoto  2025-09-08  463  			if (root_device == NULL) {
cae2d92cdcae3f drivers/firewire/core-card.c Takashi Sakamoto  2025-09-08  464  				// Either link_on is false, or we failed to read the
cae2d92cdcae3f drivers/firewire/core-card.c Takashi Sakamoto  2025-09-08  465  				// config rom.  In either case, pick another root.
de5d138456fb29 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-19  466  				stand_for_root = true;
cae2d92cdcae3f drivers/firewire/core-card.c Takashi Sakamoto  2025-09-08  467  			} else {
cae2d92cdcae3f drivers/firewire/core-card.c Takashi Sakamoto  2025-09-08  468  				bool root_device_is_running =
cae2d92cdcae3f drivers/firewire/core-card.c Takashi Sakamoto  2025-09-08  469  					atomic_read(&root_device->state) == FW_DEVICE_RUNNING;
cae2d92cdcae3f drivers/firewire/core-card.c Takashi Sakamoto  2025-09-08  470  
cae2d92cdcae3f drivers/firewire/core-card.c Takashi Sakamoto  2025-09-08  471  				if (!root_device_is_running) {
cae2d92cdcae3f drivers/firewire/core-card.c Takashi Sakamoto  2025-09-08  472  					// If we haven't probed this device yet, bail out now
cae2d92cdcae3f drivers/firewire/core-card.c Takashi Sakamoto  2025-09-08  473  					// and let's try again once that's done.
25feb1a96e21ae drivers/firewire/core-card.c Takashi Sakamoto  2025-09-08  474  					return;
de5d138456fb29 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-19  475  				} else if (!root_device->cmc) {
cae2d92cdcae3f drivers/firewire/core-card.c Takashi Sakamoto  2025-09-08  476  					// Current root has an active link layer and we
cae2d92cdcae3f drivers/firewire/core-card.c Takashi Sakamoto  2025-09-08  477  					// successfully read the config rom, but it's not
cae2d92cdcae3f drivers/firewire/core-card.c Takashi Sakamoto  2025-09-08  478  					// cycle master capable.
de5d138456fb29 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-19  479  					stand_for_root = true;
de5d138456fb29 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-19  480  				}
83db801ce8c644 drivers/firewire/fw-card.c   Kristian Høgsberg 2007-01-26  481  			}
cae2d92cdcae3f drivers/firewire/core-card.c Takashi Sakamoto  2025-09-08  482  		}
cae2d92cdcae3f drivers/firewire/core-card.c Takashi Sakamoto  2025-09-08  483  	}
de5d138456fb29 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-19  484  
de5d138456fb29 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-19  485  	if (stand_for_root) {
de5d138456fb29 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-19  486  		new_root_id = local_id;
de5d138456fb29 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-19  487  	} else {
de5d138456fb29 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-19  488  		// We will send out a force root packet for this node as part of the gap count
de5d138456fb29 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-19  489  		// optimization on behalf of the node.
de5d138456fb29 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-19  490  		new_root_id = root_id;
de5d138456fb29 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-19  491  	}
de5d138456fb29 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-19  492  
24d40125f1f59a drivers/firewire/fw-card.c   Stefan Richter    2007-06-18  493  	/*
24d40125f1f59a drivers/firewire/fw-card.c   Stefan Richter    2007-06-18  494  	 * Pick a gap count from 1394a table E-1.  The table doesn't cover
24d40125f1f59a drivers/firewire/fw-card.c   Stefan Richter    2007-06-18  495  	 * the typically much larger 1394b beta repeater delays though.
24d40125f1f59a drivers/firewire/fw-card.c   Stefan Richter    2007-06-18  496  	 */
24d40125f1f59a drivers/firewire/fw-card.c   Stefan Richter    2007-06-18  497  	if (!card->beta_repeaters_present &&
15803478fdea96 drivers/firewire/fw-card.c   Stefan Richter    2008-02-24  498  	    root_node->max_hops < ARRAY_SIZE(gap_count_table))
8c2d2fcd6b7934 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-08  499  		expected_gap_count = gap_count_table[root_node->max_hops];
83db801ce8c644 drivers/firewire/fw-card.c   Kristian Høgsberg 2007-01-26  500  	else
8c2d2fcd6b7934 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-08  501  		expected_gap_count = 63;
83db801ce8c644 drivers/firewire/fw-card.c   Kristian Høgsberg 2007-01-26  502  
c781c06d119d04 drivers/firewire/fw-card.c   Kristian Høgsberg 2007-05-07  503  	/*
25b1c3d8889f98 drivers/firewire/fw-card.c   Stefan Richter    2008-03-24  504  	 * Finally, figure out if we should do a reset or not.  If we have
25b1c3d8889f98 drivers/firewire/fw-card.c   Stefan Richter    2008-03-24  505  	 * done less than 5 resets with the same physical topology and we
c781c06d119d04 drivers/firewire/fw-card.c   Kristian Høgsberg 2007-05-07  506  	 * have either a new root or a new gap count setting, let's do it.
c781c06d119d04 drivers/firewire/fw-card.c   Kristian Høgsberg 2007-05-07  507  	 */
19a15b937b2663 drivers/firewire/fw-card.c   Kristian Høgsberg 2006-12-19  508  
8c2d2fcd6b7934 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-08  509  	if (card->bm_retries++ < 5 && (card->gap_count != expected_gap_count || new_root_id != root_id))
25b1c3d8889f98 drivers/firewire/fw-card.c   Stefan Richter    2008-03-24  510  		do_reset = true;
19a15b937b2663 drivers/firewire/fw-card.c   Kristian Høgsberg 2006-12-19  511  
8c2d2fcd6b7934 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-08  512  	if (do_reset) {
8c2d2fcd6b7934 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-08  513  		int card_gap_count = card->gap_count;
8c2d2fcd6b7934 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-08  514  
26b4950de174bc drivers/firewire/core-card.c Stefan Richter    2012-02-18  515  		fw_notice(card, "phy config: new root=%x, gap_count=%d\n",
8c2d2fcd6b7934 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-08  516  			  new_root_id, expected_gap_count);
8c2d2fcd6b7934 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-08  517  		fw_send_phy_config(card, new_root_id, generation, expected_gap_count);
d0b06dc48fb159 drivers/firewire/core-card.c Takashi Sakamoto  2024-02-29  518  		/*
d0b06dc48fb159 drivers/firewire/core-card.c Takashi Sakamoto  2024-02-29  519  		 * Where possible, use a short bus reset to minimize
d0b06dc48fb159 drivers/firewire/core-card.c Takashi Sakamoto  2024-02-29  520  		 * disruption to isochronous transfers. But in the event
d0b06dc48fb159 drivers/firewire/core-card.c Takashi Sakamoto  2024-02-29  521  		 * of a gap count inconsistency, use a long bus reset.
d0b06dc48fb159 drivers/firewire/core-card.c Takashi Sakamoto  2024-02-29  522  		 *
d0b06dc48fb159 drivers/firewire/core-card.c Takashi Sakamoto  2024-02-29  523  		 * As noted in 1394a 8.4.6.2, nodes on a mixed 1394/1394a bus
d0b06dc48fb159 drivers/firewire/core-card.c Takashi Sakamoto  2024-02-29  524  		 * may set different gap counts after a bus reset. On a mixed
d0b06dc48fb159 drivers/firewire/core-card.c Takashi Sakamoto  2024-02-29  525  		 * 1394/1394a bus, a short bus reset can get doubled. Some
d0b06dc48fb159 drivers/firewire/core-card.c Takashi Sakamoto  2024-02-29  526  		 * nodes may treat the double reset as one bus reset and others
d0b06dc48fb159 drivers/firewire/core-card.c Takashi Sakamoto  2024-02-29  527  		 * may treat it as two, causing a gap count inconsistency
d0b06dc48fb159 drivers/firewire/core-card.c Takashi Sakamoto  2024-02-29  528  		 * again. Using a long bus reset prevents this.
d0b06dc48fb159 drivers/firewire/core-card.c Takashi Sakamoto  2024-02-29  529  		 */
8c2d2fcd6b7934 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-08  530  		reset_bus(card, card_gap_count != 0);
cbae787c0f288c drivers/firewire/fw-card.c   Stefan Richter    2009-03-10  531  		/* Will allocate broadcast channel after the reset. */
8c2d2fcd6b7934 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-08  532  	} else {
a4bac55d99d379 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-08  533  		struct fw_device *root_device = fw_node_get_device(root_node);
a4bac55d99d379 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-08  534  
a4bac55d99d379 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-08  535  		if (root_device && root_device->cmc) {
8c2d2fcd6b7934 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-08  536  			// Make sure that the cycle master sends cycle start packets.
b70a5f33381f78 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-08  537  			__be32 data = cpu_to_be32(CSR_STATE_BIT_CMSTR);
b70a5f33381f78 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-08  538  			int rcode = fw_run_transaction(card, TCODE_WRITE_QUADLET_REQUEST,
c374ab424249b6 drivers/firewire/core-card.c Clemens Ladisch   2010-06-10  539  					root_id, generation, SCODE_100,
c374ab424249b6 drivers/firewire/core-card.c Clemens Ladisch   2010-06-10  540  					CSR_REGISTER_BASE + CSR_STATE_SET,
b70a5f33381f78 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-08  541  					&data, sizeof(data));
c374ab424249b6 drivers/firewire/core-card.c Clemens Ladisch   2010-06-10  542  			if (rcode == RCODE_GENERATION)
25feb1a96e21ae drivers/firewire/core-card.c Takashi Sakamoto  2025-09-08  543  				return;
c374ab424249b6 drivers/firewire/core-card.c Clemens Ladisch   2010-06-10  544  		}
c374ab424249b6 drivers/firewire/core-card.c Clemens Ladisch   2010-06-10  545  
cbae787c0f288c drivers/firewire/fw-card.c   Stefan Richter    2009-03-10  546  		if (local_id == irm_id)
cbae787c0f288c drivers/firewire/fw-card.c   Stefan Richter    2009-03-10  547  			allocate_broadcast_channel(card, generation);
19a15b937b2663 drivers/firewire/fw-card.c   Kristian Høgsberg 2006-12-19  548  	}
8c2d2fcd6b7934 drivers/firewire/core-card.c Takashi Sakamoto  2025-09-08  549  }
19a15b937b2663 drivers/firewire/fw-card.c   Kristian Høgsberg 2006-12-19  550  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

