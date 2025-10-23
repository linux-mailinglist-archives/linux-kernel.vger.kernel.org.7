Return-Path: <linux-kernel+bounces-866278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C228BFF5E3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 08:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 389C43A879C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 06:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF982980A8;
	Thu, 23 Oct 2025 06:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JUnDempr"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78663272E41;
	Thu, 23 Oct 2025 06:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761201568; cv=none; b=oJ/TdqSysROiR4HreVBqQZ/hJaKnhCaSkyMpgUiowbkhAUS144eSuwhyUGY6isTw2YFxhHTcGtEa75kamYnVHe6Qao13HIwrQM5F2RqBTSu0qHCSuwJBv+yEjNXQ97SYw2SHZZF6M+0W2YP13bqTT0lrd2kMmN3M3ZXnkbOL9ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761201568; c=relaxed/simple;
	bh=IjoIJ46m5G2Srg/5nswfnJndfZbxt7ecWzpQzMbgZhE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r4SPGG0CRYa1dj/hyeJRWdmCrJhyLiKj2QyYP5O9TP7NQIkr/vbHmskKD/UWMTNpfdKR5VlFXN4C5LhNYpRgBykOGBOC4vb9YHu7vjr9s6hne/gxQFV2tyKUYz5Rw+KabQaEgb8YONBDoTuth4J+ExX9EQ5shnXDOB+RN32hS4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JUnDempr; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761201567; x=1792737567;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IjoIJ46m5G2Srg/5nswfnJndfZbxt7ecWzpQzMbgZhE=;
  b=JUnDemprdu+WqDZF1k/iFHiim5DE0hBjjZcbLoPpHsnmnT784X5s9o+5
   h0JDUBxRm/zDktvyl9qGigATjuj2lv5vM91cLUneqk4zfzVJQLcftP190
   FdUVTonL3R0dcMHuDGvDW+B2W8qOipEN4uI5LezLIeRMIK9ixS7gTbXBP
   XHRBRZKBsPhYfRPpJinvICHUIdSbT8xOX7DLeARLiPaZpVZrCEAM+2Kq/
   W3e+KMZdbaz1LCrkXfpaaCSKCS2/AQEScoCoMnX9ZqYZ8sql1jsqUcC1j
   CB8JUjACDk1mC9yNRFj5RWMelbw2grAFxu3zOkjbsGt0cPwT7evW4B032
   g==;
X-CSE-ConnectionGUID: U99k0GdKQkq0hC9kaJaQJw==
X-CSE-MsgGUID: gKjhNUyPTny9BGFe/MX1CA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62570458"
X-IronPort-AV: E=Sophos;i="6.19,249,1754982000"; 
   d="scan'208";a="62570458"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 23:39:26 -0700
X-CSE-ConnectionGUID: eWAiBujDR8uX1nRj9EuO5A==
X-CSE-MsgGUID: Y3Ll4AUfSEu+xoBLv0ZhRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,249,1754982000"; 
   d="scan'208";a="184849576"
Received: from carterle-desk.ger.corp.intel.com (HELO [10.245.246.145]) ([10.245.246.145])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 23:39:22 -0700
Message-ID: <a464eb64-4c07-41d0-989a-bdc9eaae9acf@linux.intel.com>
Date: Thu, 23 Oct 2025 09:39:28 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: SOF: Fix function topology name check in profile
 info output
To: Chen-Yu Tsai <wenst@chromium.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Daniel Baluta <daniel.baluta@nxp.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
Cc: sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-mediatek@lists.infradead.org
References: <20251023061226.1127345-1-wenst@chromium.org>
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
Content-Language: en-US
In-Reply-To: <20251023061226.1127345-1-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 23/10/2025 09:12, Chen-Yu Tsai wrote:
> The function topology feature, and the plat_data->machine field that
> specifies this feature, is ACPI specific. The check didn't take this
> into consideration, which causes a NULL pointer dereference splat on
> OF platforms:
> 
>     BUG: KASAN: null-ptr-deref in sof_create_ipc_file_profile (sound/soc/sof/fw-file-profile.c:291 sound/soc/sof/fw-file-profile.c:340) snd_sof
>     Read of size 8 at addr 00000000000000c8 by task (udev-worker)/247
> 
>     CPU: 7 UID: 0 PID: 247 Comm: (udev-worker) Not tainted 6.18.0-rc2-next-20251023-03804-g93b191bc0c26-dirty #747 PREEMPT  ba3c303a11d89508de4087cb5b4f8985b6d87b6f
>     Hardware name: Google Ciri sku2 board (DT)
>     Call trace:
>     [KASAN stuff]
>     sof_create_ipc_file_profile (sound/soc/sof/fw-file-profile.c:291 sound/soc/sof/fw-file-profile.c:340) snd_sof
>     snd_sof_device_probe (sound/soc/sof/core.c:304 sound/soc/sof/core.c:388 sound/soc/sof/core.c:460 sound/soc/sof/core.c:719) snd_sof
>     sof_of_probe (sound/soc/sof/sof-of-dev.c:84) snd_sof_of
>      platform_probe (drivers/base/platform.c:1405)
>     [...]
> 
> Check that the ACPI specific field is actually valid before accessing
> it.
> 
> This was seen on a MediaTek based Chromebook.

Acked-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

> 
> Fixes: 2b92b98cc476 ("ASoC: SOF: Don't print the monolithic topology name if function topology may be used")
> Cc: Bard Liao <yung-chuan.liao@linux.intel.com>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>  sound/soc/sof/fw-file-profile.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/sof/fw-file-profile.c b/sound/soc/sof/fw-file-profile.c
> index 4a2afc04f338..76bde2e0be1d 100644
> --- a/sound/soc/sof/fw-file-profile.c
> +++ b/sound/soc/sof/fw-file-profile.c
> @@ -288,7 +288,8 @@ static void sof_print_profile_info(struct snd_sof_dev *sdev,
>  	if (profile->fw_lib_path)
>  		dev_info(dev, " Firmware lib path: %s\n", profile->fw_lib_path);
>  
> -	if (plat_data->machine->get_function_tplg_files && !plat_data->disable_function_topology)
> +	if (plat_data->machine && plat_data->machine->get_function_tplg_files &&
> +	    !plat_data->disable_function_topology)
>  		dev_info(dev, " Topology file:     function topologies\n");
>  	else
>  		dev_info(dev, " Topology file:     %s/%s\n",

-- 
Péter


