Return-Path: <linux-kernel+bounces-757427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7788B1C1FF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 10:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6595D3B2C9A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 08:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5AB220F2C;
	Wed,  6 Aug 2025 08:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n1zXnz7B"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4933C2FB;
	Wed,  6 Aug 2025 08:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754468242; cv=none; b=W2Iw4U7rLYMFjXRLOOehEUOhQBPyBU56fyb/dfRdiMB1JIDswHEhoetTO/T75b+jeJFAx/4MJiCg/2bxRwSA5HCIo2xrZCkZy0LX7/4+g1eEXbLcxkAqG5NsHVhxFMyG9QQ7qLIfcUGrWIaKcWAatTJ0RHnDHqL4ZPF019oIWrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754468242; c=relaxed/simple;
	bh=XvYNe9Z/pKTzySjVjDUyDO+RTJi9tAQzInJGWEfIv3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FBYy58oiKyI+XXM0pblv8VrM2sQZ3SJdWOew6S8y+ppVpPluB4DB7u15+dibzy6sv1ebWB7zxvqQ4MaDkRYI72/4Pcpi8eFS9fPvkt3BiSl83Tktr8pN4rrkGAXlRrUmQyIcuZCQ6pWZruG2Eb5NBk37a7h6l/UCwG3aQxXmCaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n1zXnz7B; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754468241; x=1786004241;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XvYNe9Z/pKTzySjVjDUyDO+RTJi9tAQzInJGWEfIv3k=;
  b=n1zXnz7BojWWn2frAMKz809r+WYjjqlNGqf2v2s8+JE1ffFPL/uiCsqA
   1ZfY3CdqSfkCNc9oZYKG9XPJbOIYU7jARR6LQfU9GS6lqc0rCYQ9CfJkY
   GIinm0rnwfEdSKyMtsODpN3Y/0AAEBxluzcQX1SLnWfzgmhGIEtSjCnaG
   F1Dpezn30xg5SijY+m9uyC8pc/xXadhKMN1y2I59ElEbTgpwJGXe2HcME
   lv5aj/LvFmr2ve5MsRK2aKrTxPW6CuKBwjnDx+el3JttPpsvrDfg36kun
   7P1MDES7h64x0G6hcDmco3ziBYrth6ipLwNtf/HY88twSlwdGCVpEfRZh
   Q==;
X-CSE-ConnectionGUID: ypGU4PFqSiOtYOfAyh/CTg==
X-CSE-MsgGUID: P0f+yZlqQpCRaU8BoyFIfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11513"; a="56854725"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="56854725"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 01:17:20 -0700
X-CSE-ConnectionGUID: FAURbn9/Qxmp8QAcjJrstw==
X-CSE-MsgGUID: QGeNJLQOTB2UdU7mwkc8YQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="164245938"
Received: from unknown (HELO [10.227.10.83]) ([10.227.10.83])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 01:17:17 -0700
Message-ID: <5ae69075-d79d-4fa8-9d49-12e0e1786acc@linux.intel.com>
Date: Wed, 6 Aug 2025 16:17:05 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: SOF: Intel: hda-sdw-bpt: fix
 SND_SOF_SOF_HDA_SDW_BPT dependencies
To: Arnd Bergmann <arnd@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Daniel Baluta <daniel.baluta@nxp.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
 Vinod Koul <vkoul@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Kai Vehmanen
 <kai.vehmanen@linux.intel.com>, sound-open-firmware@alsa-project.org,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250805160451.4004602-1-arnd@kernel.org>
Content-Language: en-US
From: "Liao, Bard" <yung-chuan.liao@linux.intel.com>
In-Reply-To: <20250805160451.4004602-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/6/2025 12:04 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The hda-sdw-bpt code links against the soundwire driver, but that fails when
> trying to link from built-in code into loadable module:
> 
> x86_64-linux-ld: vmlinux.o: in function `intel_ace2x_bpt_close_stream.isra.0':
> intel_ace2x.c:(.text+0x137a531): undefined reference to `hda_sdw_bpt_close'
> x86_64-linux-ld: vmlinux.o: in function `intel_ace2x_bpt_send_async':
> intel_ace2x.c:(.text+0x137aa45): undefined reference to `hda_sdw_bpt_open'
> x86_64-linux-ld: intel_ace2x.c:(.text+0x137ab67): undefined reference to `hda_sdw_bpt_close'
> x86_64-linux-ld: intel_ace2x.c:(.text+0x137ac30): undefined reference to `hda_sdw_bpt_send_async'
> x86_64-linux-ld: vmlinux.o: in function `intel_ace2x_bpt_wait':
> intel_ace2x.c:(.text+0x137aced): undefined reference to `hda_sdw_bpt_wait'
> 
> Ensure that both SOUNDWIRE_INTEL and SND_SOF_SOF_HDA_SDW_BPT are selected
> at the same time by SND_SOC_SOF_INTEL_LNL, and that this happens even if
> SND_SOC_SOF_INTEL_SOUNDWIRE is a loadable module but SND_SOC_SOF_INTEL_LNL
> is built-in.
> 
> This follows the same logic as commit c5a61db9bf89 ("ASoC: SOF: fix
> intel-soundwire link failure").
> 
> Fixes: 5d5cb86fb46e ("ASoC: SOF: Intel: hda-sdw-bpt: add helpers for SoundWire BPT DMA")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>

> ---
>  sound/soc/sof/intel/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/sof/intel/Kconfig b/sound/soc/sof/intel/Kconfig
> index 7e92aa2f7e39..9722ae43e87c 100644
> --- a/sound/soc/sof/intel/Kconfig
> +++ b/sound/soc/sof/intel/Kconfig
> @@ -272,9 +272,10 @@ config SND_SOC_SOF_METEORLAKE
>  
>  config SND_SOC_SOF_INTEL_LNL
>  	tristate
> +	select SOUNDWIRE_INTEL if SND_SOC_SOF_INTEL_SOUNDWIRE != n
>  	select SND_SOC_SOF_HDA_GENERIC
>  	select SND_SOC_SOF_INTEL_SOUNDWIRE_LINK_BASELINE
> -	select SND_SOF_SOF_HDA_SDW_BPT if SND_SOC_SOF_INTEL_SOUNDWIRE
> +	select SND_SOF_SOF_HDA_SDW_BPT if SND_SOC_SOF_INTEL_SOUNDWIRE != n
>  	select SND_SOC_SOF_IPC4
>  	select SND_SOC_SOF_INTEL_MTL
>  


