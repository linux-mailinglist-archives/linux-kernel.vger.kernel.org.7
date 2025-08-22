Return-Path: <linux-kernel+bounces-782737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4534B324A5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 23:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EB306833CC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 21:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DA02D322F;
	Fri, 22 Aug 2025 21:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W3tJtXk0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E961531C8;
	Fri, 22 Aug 2025 21:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755898315; cv=none; b=d9Y173nU56z7N275EnrF1Kofw/Lasd1ncAzhSRAZP4HN2KICZamscbBQ9wSZmFSBB/wm2TH/YFUDm31WaPLS8SRd0HIFwGfH3YJH0mfXbAp8r6qxSrP/sZNPZsuLF8IBRNw2nN8n5d7qD8dn4PaptHTnihCLVmaPQGx8Ie9Y5N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755898315; c=relaxed/simple;
	bh=OZDL56ts6cpMtHv06rx//Jcb9k8kAprl1hOGapCSJ0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sgMGq2II0+psxFX7K9j+GjMIOG/DJo7vvoTgmyAkjRsqjZWidFHttMZdIoWrM6yenzyl05HvqKC+5htbV4VqzLoX+Rm52IHLEvHCAGwkiTCkSCNIlUcCErfhp6zUxUrOnZkpd7KPpo9JeW2tZRn0PwHy1UC1bSvBrGcW/GNJIH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W3tJtXk0; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755898313; x=1787434313;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OZDL56ts6cpMtHv06rx//Jcb9k8kAprl1hOGapCSJ0Y=;
  b=W3tJtXk0BZBu1kK8CBEcoCLf3CgoN+QntPapomfRhevR8zpXMj+xWEj4
   RHVFG39JNPNRvu7uvZNEDGLG2i96H3Yn8XgfP5bGA0hxJBYClMA7KdyhA
   OiRi7M0ZrcEONoJSYIP75CvvMb3FGqpsLLDdvQPYWyKETC15trNxp/5jm
   m+9lzGVxh2YD7CG1YPHAjZitDL0jnEn2pJ9Bc8/xpmtrtShOYcF1f33R6
   Y3qPnt3OmPTI3Qn6H34O+Vy40BYFDJ94MrqYJQ4J6HHCdH5nTPf95QnPu
   AFCT+jJhYvHMA3QVyE/9M7KcUQtKp2UlmEfZAzb4hDEGn+Jo2cGWEtYB4
   A==;
X-CSE-ConnectionGUID: UCVV9SJvSYunO5LFKn+T1w==
X-CSE-MsgGUID: weyx3vo7QQiY3sozM2uVbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="45784567"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="45784567"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 14:31:52 -0700
X-CSE-ConnectionGUID: JxdUFZ2jTJWTdC23usu6cA==
X-CSE-MsgGUID: yb+VR08XSSGzNFcTO+jxnA==
X-ExtLoop1: 1
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 22 Aug 2025 14:31:49 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1upZM0-000LqR-01;
	Fri, 22 Aug 2025 21:31:27 +0000
Date: Sat, 23 Aug 2025 05:31:01 +0800
From: kernel test robot <lkp@intel.com>
To: Chen-Yu Tsai <wenst@chromium.org>, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: oe-kbuild-all@lists.linux.dev, Chen-Yu Tsai <wenst@chromium.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: mediatek: common: Switch to
 for_each_available_child_of_node_scoped()
Message-ID: <202508230528.DeD3hVns-lkp@intel.com>
References: <20250822062738.2632746-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822062738.2632746-1-wenst@chromium.org>

Hi Chen-Yu,

kernel test robot noticed the following build warnings:

[auto build test WARNING on broonie-sound/for-next]
[also build test WARNING on broonie-spi/for-next linus/master v6.17-rc2 next-20250822]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chen-Yu-Tsai/ASoC-mediatek-common-Switch-to-for_each_available_child_of_node_scoped/20250822-142918
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
patch link:    https://lore.kernel.org/r/20250822062738.2632746-1-wenst%40chromium.org
patch subject: [PATCH] ASoC: mediatek: common: Switch to for_each_available_child_of_node_scoped()
config: x86_64-buildonly-randconfig-001-20250823 (https://download.01.org/0day-ci/archive/20250823/202508230528.DeD3hVns-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250823/202508230528.DeD3hVns-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508230528.DeD3hVns-lkp@intel.com/

All warnings (new ones prefixed by >>):

   sound/soc/mediatek/common/mtk-soundcard-driver.c: In function 'parse_dai_link_info':
>> sound/soc/mediatek/common/mtk-soundcard-driver.c:92:29: warning: unused variable 'sub_node' [-Wunused-variable]
      92 |         struct device_node *sub_node;
         |                             ^~~~~~~~


vim +/sub_node +92 sound/soc/mediatek/common/mtk-soundcard-driver.c

c0e7390e6d3f42b Trevor Wu    2023-05-26   88  
4302187d955f166 Trevor Wu    2023-01-16   89  int parse_dai_link_info(struct snd_soc_card *card)
4302187d955f166 Trevor Wu    2023-01-16   90  {
4302187d955f166 Trevor Wu    2023-01-16   91  	struct device *dev = card->dev;
4302187d955f166 Trevor Wu    2023-01-16  @92  	struct device_node *sub_node;
4302187d955f166 Trevor Wu    2023-01-16   93  	struct snd_soc_dai_link *dai_link;
4302187d955f166 Trevor Wu    2023-01-16   94  	const char *dai_link_name;
4302187d955f166 Trevor Wu    2023-01-16   95  	int ret, i;
4302187d955f166 Trevor Wu    2023-01-16   96  
4302187d955f166 Trevor Wu    2023-01-16   97  	/* Loop over all the dai link sub nodes */
bd1311e421261f6 Chen-Yu Tsai 2025-08-22   98  	for_each_available_child_of_node_scoped(dev->of_node, sub_node) {
4302187d955f166 Trevor Wu    2023-01-16   99  		if (of_property_read_string(sub_node, "link-name",
bd1311e421261f6 Chen-Yu Tsai 2025-08-22  100  					    &dai_link_name))
4302187d955f166 Trevor Wu    2023-01-16  101  			return -EINVAL;
4302187d955f166 Trevor Wu    2023-01-16  102  
4302187d955f166 Trevor Wu    2023-01-16  103  		for_each_card_prelinks(card, i, dai_link) {
4302187d955f166 Trevor Wu    2023-01-16  104  			if (!strcmp(dai_link_name, dai_link->name))
4302187d955f166 Trevor Wu    2023-01-16  105  				break;
4302187d955f166 Trevor Wu    2023-01-16  106  		}
4302187d955f166 Trevor Wu    2023-01-16  107  
bd1311e421261f6 Chen-Yu Tsai 2025-08-22  108  		if (i >= card->num_links)
4302187d955f166 Trevor Wu    2023-01-16  109  			return -EINVAL;
4302187d955f166 Trevor Wu    2023-01-16  110  
4302187d955f166 Trevor Wu    2023-01-16  111  		ret = set_card_codec_info(card, sub_node, dai_link);
bd1311e421261f6 Chen-Yu Tsai 2025-08-22  112  		if (ret < 0)
4302187d955f166 Trevor Wu    2023-01-16  113  			return ret;
c0e7390e6d3f42b Trevor Wu    2023-05-26  114  
c0e7390e6d3f42b Trevor Wu    2023-05-26  115  		ret = set_dailink_daifmt(card, sub_node, dai_link);
bd1311e421261f6 Chen-Yu Tsai 2025-08-22  116  		if (ret < 0)
c0e7390e6d3f42b Trevor Wu    2023-05-26  117  			return ret;
c0e7390e6d3f42b Trevor Wu    2023-05-26  118  	}
4302187d955f166 Trevor Wu    2023-01-16  119  
4302187d955f166 Trevor Wu    2023-01-16  120  	return 0;
4302187d955f166 Trevor Wu    2023-01-16  121  }
4302187d955f166 Trevor Wu    2023-01-16  122  EXPORT_SYMBOL_GPL(parse_dai_link_info);
4302187d955f166 Trevor Wu    2023-01-16  123  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

