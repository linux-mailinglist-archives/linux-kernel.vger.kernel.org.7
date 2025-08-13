Return-Path: <linux-kernel+bounces-767257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D55B25208
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 19:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F5AC3BBEBE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 17:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8725026B748;
	Wed, 13 Aug 2025 17:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jMFkEZ/J"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17A9178372;
	Wed, 13 Aug 2025 17:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755105490; cv=none; b=BKJnWfnG/Hev2LoVCi5BVqzc7/6DF3XdCI7FR+zbWjeju9CFZyvFtLcs1C5mIrYjgz9w9AHtEt3paQyt4mqmFd0qA7Kqky8tN1TRbJM44Ja68d16X6Kf1sQOXDBg3mnoPFgF88xvvCCAKchExkOrbmBsERFBachB2UC4vpmjay0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755105490; c=relaxed/simple;
	bh=WV0Vo+K02OhsbWV4KFB/mzIPWVvcS25gBWrGy1wIQZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KWoQbOaJ14ANcj3GIqh15ecd+Ha9DoHhHXthgQabFnHCSwJ1Jjo13j1oIqzqHHAkJuiXy9yANwPm+tEY4f6OyxrBAXES9KdRmwUi3zr1onAAxBnobAGej0+UMMrjWn+zaUHzoqIANmg/b0lViJZxiw14nT4OyS+Az66Xko8dAmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jMFkEZ/J; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755105489; x=1786641489;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WV0Vo+K02OhsbWV4KFB/mzIPWVvcS25gBWrGy1wIQZE=;
  b=jMFkEZ/JjB1SkWFkkwPE2LwPHQHWumDA0/vWbMYT2E2ZEqvgCV8w9Nel
   GzKGyXMYroBo4ic3LGdE5+Vk2mXt+z/XuUCSFDctBKrZFiKmu6ngf+8kZ
   Utd/ufNyRTuxyd8vJxJnrUXcNTVENF80pCUfLMYYhs+KqtVyWjsgcOKbM
   GAytMRXKJyg+S+GaQKH16hXPl6h2dV5zc+rUTVI8Wy3KSBa/kQZREIim5
   hsP4F3/plGHzVubUL0MZpW4zRYN13mUTyQAklC54Suj3nEosR9YnVV7wy
   k/ysjES897bVMx3deD9EUi5ja4hysmGtSssXOMEsy76boPjNi8sM+oHdG
   A==;
X-CSE-ConnectionGUID: O0vnPNBVTYWCJNx6r+kKuA==
X-CSE-MsgGUID: jbjzLHc8QSSSbqDB5+CEWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="67683603"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="67683603"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 10:18:09 -0700
X-CSE-ConnectionGUID: SLv3rjliRGejYsPzB8JYLQ==
X-CSE-MsgGUID: So1G6vd/Qpa6singFRjHbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="171857712"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 13 Aug 2025 10:18:04 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1umF6W-000A9U-3B;
	Wed, 13 Aug 2025 17:17:44 +0000
Date: Thu, 14 Aug 2025 01:16:58 +0800
From: kernel test robot <lkp@intel.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Qiang Zhao <qiang.zhao@nxp.com>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: oe-kbuild-all@lists.linux.dev,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH v2 2/4] ASoc: fsl: fsl_qmc_audio: Ensure audio channels
 are ordered in TDM bus
Message-ID: <202508140002.NBrWOZJL-lkp@intel.com>
References: <8d01cf4599664188c92a515922d68c9834263384.1754993232.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d01cf4599664188c92a515922d68c9834263384.1754993232.git.christophe.leroy@csgroup.eu>

Hi Christophe,

kernel test robot noticed the following build warnings:

[auto build test WARNING on broonie-sound/for-next]
[also build test WARNING on linus/master v6.17-rc1 next-20250813]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christophe-Leroy/soc-fsl-qmc-Only-set-completion-interrupt-when-needed/20250812-193812
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
patch link:    https://lore.kernel.org/r/8d01cf4599664188c92a515922d68c9834263384.1754993232.git.christophe.leroy%40csgroup.eu
patch subject: [PATCH v2 2/4] ASoc: fsl: fsl_qmc_audio: Ensure audio channels are ordered in TDM bus
config: powerpc64-randconfig-r073-20250813 (https://download.01.org/0day-ci/archive/20250814/202508140002.NBrWOZJL-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 3769ce013be2879bf0b329c14a16f5cb766f26ce)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250814/202508140002.NBrWOZJL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508140002.NBrWOZJL-lkp@intel.com/

All warnings (new ones prefixed by >>):

   sound/soc/fsl/fsl_qmc_audio.c:888:39: error: no member named 'qmc_chans' in 'struct qmc_dai'
     888 |                 ret = qmc_chan_get_ts_info(qmc_dai->qmc_chans[i], &ts_info);
         |                                            ~~~~~~~  ^
>> sound/soc/fsl/fsl_qmc_audio.c:900:21: warning: format specifies type 'unsigned long' but the argument has type 'int' [-Wformat]
     899 |                         dev_err(qmc_audio->dev, "dai %d QMC chan %d unordered channels (RX timeslot %lu before %lu)\n",
         |                                                                                                     ~~~
         |                                                                                                     %d
     900 |                                 qmc_dai->id, i, prev_last_rx_ts, last_rx_ts);
         |                                                 ^~~~~~~~~~~~~~~
   include/linux/dev_printk.h:154:65: note: expanded from macro 'dev_err'
     154 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                                ~~~     ^~~~~~~~~~~
   include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ~~~    ^~~~~~~~~~~
   sound/soc/fsl/fsl_qmc_audio.c:900:38: warning: format specifies type 'unsigned long' but the argument has type 'int' [-Wformat]
     899 |                         dev_err(qmc_audio->dev, "dai %d QMC chan %d unordered channels (RX timeslot %lu before %lu)\n",
         |                                                                                                                ~~~
         |                                                                                                                %d
     900 |                                 qmc_dai->id, i, prev_last_rx_ts, last_rx_ts);
         |                                                                  ^~~~~~~~~~
   include/linux/dev_printk.h:154:65: note: expanded from macro 'dev_err'
     154 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                                ~~~     ^~~~~~~~~~~
   include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ~~~    ^~~~~~~~~~~
   sound/soc/fsl/fsl_qmc_audio.c:905:21: warning: format specifies type 'unsigned long' but the argument has type 'int' [-Wformat]
     904 |                         dev_err(qmc_audio->dev, "dai %d QMC chan %d unordered channels (TX timeslot %lu before %lu)\n",
         |                                                                                                     ~~~
         |                                                                                                     %d
     905 |                                 qmc_dai->id, i, prev_last_tx_ts, last_tx_ts);
         |                                                 ^~~~~~~~~~~~~~~
   include/linux/dev_printk.h:154:65: note: expanded from macro 'dev_err'
     154 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                                ~~~     ^~~~~~~~~~~
   include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ~~~    ^~~~~~~~~~~
   sound/soc/fsl/fsl_qmc_audio.c:905:38: warning: format specifies type 'unsigned long' but the argument has type 'int' [-Wformat]
     904 |                         dev_err(qmc_audio->dev, "dai %d QMC chan %d unordered channels (TX timeslot %lu before %lu)\n",
         |                                                                                                                ~~~
         |                                                                                                                %d
     905 |                                 qmc_dai->id, i, prev_last_tx_ts, last_tx_ts);
         |                                                                  ^~~~~~~~~~
   include/linux/dev_printk.h:154:65: note: expanded from macro 'dev_err'
     154 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                                ~~~     ^~~~~~~~~~~
   include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ~~~    ^~~~~~~~~~~
   4 warnings and 1 error generated.


vim +900 sound/soc/fsl/fsl_qmc_audio.c

   789	
   790	static int qmc_audio_dai_parse(struct qmc_audio *qmc_audio, struct device_node *np,
   791				       struct qmc_dai *qmc_dai,
   792				       struct snd_soc_dai_driver *qmc_soc_dai_driver)
   793	{
   794		struct qmc_chan_ts_info ts_info;
   795		struct qmc_chan_info info;
   796		unsigned long rx_fs_rate;
   797		unsigned long tx_fs_rate;
   798		int prev_last_rx_ts = 0;
   799		int prev_last_tx_ts = 0;
   800		unsigned int nb_tx_ts;
   801		unsigned int nb_rx_ts;
   802		unsigned int i;
   803		int last_rx_ts;
   804		int last_tx_ts;
   805		int count;
   806		u32 val;
   807		int ret;
   808	
   809		qmc_dai->dev = qmc_audio->dev;
   810	
   811		ret = of_property_read_u32(np, "reg", &val);
   812		if (ret) {
   813			dev_err(qmc_audio->dev, "%pOF: failed to read reg\n", np);
   814			return ret;
   815		}
   816		qmc_dai->id = val;
   817	
   818		qmc_dai->name = devm_kasprintf(qmc_audio->dev, GFP_KERNEL, "%s.%d",
   819					       np->parent->name, qmc_dai->id);
   820		if (!qmc_dai->name)
   821			return -ENOMEM;
   822	
   823		count = qmc_chan_count_phandles(np, "fsl,qmc-chan");
   824		if (count < 0)
   825			return dev_err_probe(qmc_audio->dev, count,
   826					     "dai %d get number of QMC channel failed\n", qmc_dai->id);
   827		if (!count)
   828			return dev_err_probe(qmc_audio->dev, -EINVAL,
   829					     "dai %d no QMC channel defined\n", qmc_dai->id);
   830	
   831		qmc_dai->chans = devm_kcalloc(qmc_audio->dev, count, sizeof(*qmc_dai->chans), GFP_KERNEL);
   832		if (!qmc_dai->chans)
   833			return -ENOMEM;
   834	
   835		for (i = 0; i < count; i++) {
   836			qmc_dai->chans[i].qmc_chan = devm_qmc_chan_get_byphandles_index(qmc_audio->dev, np,
   837											"fsl,qmc-chan", i);
   838			if (IS_ERR(qmc_dai->chans[i].qmc_chan)) {
   839				return dev_err_probe(qmc_audio->dev, PTR_ERR(qmc_dai->chans[i].qmc_chan),
   840						     "dai %d get QMC channel %d failed\n", qmc_dai->id, i);
   841			}
   842	
   843			ret = qmc_chan_get_info(qmc_dai->chans[i].qmc_chan, &info);
   844			if (ret) {
   845				dev_err(qmc_audio->dev, "dai %d get QMC %d channel info failed %d\n",
   846					qmc_dai->id, i, ret);
   847				return ret;
   848			}
   849	
   850			if (info.mode != QMC_TRANSPARENT) {
   851				dev_err(qmc_audio->dev, "dai %d QMC chan %d mode %d is not QMC_TRANSPARENT\n",
   852					qmc_dai->id, i, info.mode);
   853				return -EINVAL;
   854			}
   855	
   856			/*
   857			 * All channels must have the same number of Tx slots and the
   858			 * same numbers of Rx slots.
   859			 */
   860			if (i == 0) {
   861				nb_tx_ts = info.nb_tx_ts;
   862				nb_rx_ts = info.nb_rx_ts;
   863				tx_fs_rate = info.tx_fs_rate;
   864				rx_fs_rate = info.rx_fs_rate;
   865			} else {
   866				if (nb_tx_ts != info.nb_tx_ts) {
   867					dev_err(qmc_audio->dev, "dai %d QMC chan %d inconsistent number of Tx timeslots (%u instead of %u)\n",
   868						qmc_dai->id, i, info.nb_tx_ts, nb_tx_ts);
   869					return -EINVAL;
   870				}
   871				if (nb_rx_ts != info.nb_rx_ts) {
   872					dev_err(qmc_audio->dev, "dai %d QMC chan %d inconsistent number of Rx timeslots (%u instead of %u)\n",
   873						qmc_dai->id, i, info.nb_rx_ts, nb_rx_ts);
   874					return -EINVAL;
   875				}
   876				if (tx_fs_rate != info.tx_fs_rate) {
   877					dev_err(qmc_audio->dev, "dai %d QMC chan %d inconsistent Tx frame sample rate (%lu instead of %lu)\n",
   878						qmc_dai->id, i, info.tx_fs_rate, tx_fs_rate);
   879					return -EINVAL;
   880				}
   881				if (rx_fs_rate != info.rx_fs_rate) {
   882					dev_err(qmc_audio->dev, "dai %d QMC chan %d inconsistent Rx frame sample rate (%lu instead of %lu)\n",
   883						qmc_dai->id, i, info.rx_fs_rate, rx_fs_rate);
   884					return -EINVAL;
   885				}
   886			}
   887	
 > 888			ret = qmc_chan_get_ts_info(qmc_dai->qmc_chans[i], &ts_info);
   889			if (ret) {
   890				dev_err(qmc_audio->dev, "dai %d get QMC %d channel TS info failed %d\n",
   891					qmc_dai->id, i, ret);
   892				return ret;
   893			}
   894	
   895			last_rx_ts = fls64(ts_info.rx_ts_mask);
   896			last_tx_ts = fls64(ts_info.rx_ts_mask);
   897	
   898			if (prev_last_rx_ts > last_rx_ts) {
   899				dev_err(qmc_audio->dev, "dai %d QMC chan %d unordered channels (RX timeslot %lu before %lu)\n",
 > 900					qmc_dai->id, i, prev_last_rx_ts, last_rx_ts);
   901				return -EINVAL;
   902			}
   903			if (prev_last_tx_ts > last_tx_ts) {
   904				dev_err(qmc_audio->dev, "dai %d QMC chan %d unordered channels (TX timeslot %lu before %lu)\n",
   905					qmc_dai->id, i, prev_last_tx_ts, last_tx_ts);
   906				return -EINVAL;
   907			}
   908	
   909			prev_last_rx_ts = last_rx_ts;
   910			prev_last_tx_ts = last_tx_ts;
   911		}
   912	
   913		qmc_dai->nb_chans_avail = count;
   914		qmc_dai->nb_tx_ts = nb_tx_ts * count;
   915		qmc_dai->nb_rx_ts = nb_rx_ts * count;
   916	
   917		qmc_soc_dai_driver->id = qmc_dai->id;
   918		qmc_soc_dai_driver->name = qmc_dai->name;
   919	
   920		qmc_soc_dai_driver->playback.channels_min = 0;
   921		qmc_soc_dai_driver->playback.channels_max = 0;
   922		if (nb_tx_ts) {
   923			qmc_soc_dai_driver->playback.channels_min = 1;
   924			qmc_soc_dai_driver->playback.channels_max = count > 1 ? count : nb_tx_ts;
   925		}
   926		qmc_soc_dai_driver->playback.formats = qmc_audio_formats(nb_tx_ts,
   927									 count > 1);
   928	
   929		qmc_soc_dai_driver->capture.channels_min = 0;
   930		qmc_soc_dai_driver->capture.channels_max = 0;
   931		if (nb_rx_ts) {
   932			qmc_soc_dai_driver->capture.channels_min = 1;
   933			qmc_soc_dai_driver->capture.channels_max = count > 1 ? count : nb_rx_ts;
   934		}
   935		qmc_soc_dai_driver->capture.formats = qmc_audio_formats(nb_rx_ts,
   936									count > 1);
   937	
   938		qmc_soc_dai_driver->playback.rates = snd_pcm_rate_to_rate_bit(tx_fs_rate);
   939		qmc_soc_dai_driver->playback.rate_min = tx_fs_rate;
   940		qmc_soc_dai_driver->playback.rate_max = tx_fs_rate;
   941		qmc_soc_dai_driver->capture.rates = snd_pcm_rate_to_rate_bit(rx_fs_rate);
   942		qmc_soc_dai_driver->capture.rate_min = rx_fs_rate;
   943		qmc_soc_dai_driver->capture.rate_max = rx_fs_rate;
   944	
   945		qmc_soc_dai_driver->ops = &qmc_dai_ops;
   946	
   947		return 0;
   948	}
   949	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

