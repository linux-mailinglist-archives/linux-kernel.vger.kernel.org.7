Return-Path: <linux-kernel+bounces-796105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA01B3FBF9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BD792C2046
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488222F0687;
	Tue,  2 Sep 2025 10:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OgQTdjce"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D0B2EFD81;
	Tue,  2 Sep 2025 10:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756808014; cv=none; b=KwxHnfDj5vllE5wusYt/S7Gjp4tkR6ftiQC7+Bq8YNC2K9YWTgXNe25HnZO+MWy/Sv9Ah7y3dKlqO7H6Ksxl72LnuRfKIypayj0t8EXdDBg078/L4lXVKJf7sy6R9DtBEmcl8HHj5Ph8ZUTvreBzPu4bpU03glAJb76PL23swCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756808014; c=relaxed/simple;
	bh=jIMRsGPvtdg9poTpwyfPNA5yMvawN69xdr5rcZYO6dQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NR2dTVmtQwqz5HfP61IQK5H/t5uaZ+IoaGI4Kv1vIuxzNQqylea8xq1rZlDoIjZbWY+VeJRgr60c2Pw4TrTPZjm9t2r6f64H7EZvrT8tL30YukK+G6ryD3W53uVJ3dKOIrcUvQsa40FwOvWLStTCe8cEUfKtB2F/Uzpymj37Txo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OgQTdjce; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756808014; x=1788344014;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jIMRsGPvtdg9poTpwyfPNA5yMvawN69xdr5rcZYO6dQ=;
  b=OgQTdjcevTw8LSY+9LJeIQ8QSRjjE9QubyEBhLgDU57pt490aVq6TLbY
   chWYbXniEC2Q+Tdel2YHbt+xOnWZXZaxRgQZoCzri7GF8yrs9uBQrq0+P
   8dZZkdkQtXDhY3gJkaKc30AvVfXUfsr3exE2YCngtKIpHc/5d/7Zgk8Ph
   2bocU7DWvvXw1QCyOQkXNK6Wgum8Z/HayT54eHEvSt0Cu4QcPemC8Nun2
   wQexx93Ww5xPMik2/SlK0RPffsAfn6BLY4lt8THJFezGENxOWQL+dnj80
   Dfw+zZ95D1nMDQYRh1e1VRDyYMD463TE3f5xKdrTwlMf471QZlP/+LpCu
   g==;
X-CSE-ConnectionGUID: Wxw8wKUIQLCk5xFiE3GxGQ==
X-CSE-MsgGUID: Trfloa5ITj2vH6iaUoGYSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11540"; a="70177134"
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="70177134"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 03:13:32 -0700
X-CSE-ConnectionGUID: /aQH3nLpQ32N0ZuQwOFi/A==
X-CSE-MsgGUID: Qy/RqTAfRvakCVQ5xlPenw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="171118685"
Received: from carterle-desk.ger.corp.intel.com (HELO [10.245.246.183]) ([10.245.246.183])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 03:13:28 -0700
Message-ID: <cb98f508-7ad1-4ed8-b366-7c2ed8951629@linux.intel.com>
Date: Tue, 2 Sep 2025 13:14:11 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] ASoC: SOF: ipc4-topology: Fix a less than zero
 check on a u32
To: Colin Ian King <colin.i.king@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Daniel Baluta <daniel.baluta@nxp.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, sound-open-firmware@alsa-project.org,
 linux-sound@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250902083213.2620124-1-colin.i.king@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <20250902083213.2620124-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 02/09/2025 11:32, Colin Ian King wrote:
> Currently the error check from the call to sof_ipc4_get_sample_type
> is always false because a u32 variable out_ref_type is being used
> to perform the less than zero check. Fix this by using the int
> variable ret to perform the check.
> 
> Fixes: c04c2e829649 ("ASoC: SOF: ipc4-topology: Add support for 8-bit formats")
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Acked-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

> ---
>  sound/soc/sof/ipc4-topology.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/sof/ipc4-topology.c b/sound/soc/sof/ipc4-topology.c
> index f5e62cd8fc0c..b6a732d0adb4 100644
> --- a/sound/soc/sof/ipc4-topology.c
> +++ b/sound/soc/sof/ipc4-topology.c
> @@ -2191,9 +2191,10 @@ sof_ipc4_prepare_copier_module(struct snd_sof_widget *swidget,
>  	case snd_soc_dapm_dai_in:
>  		out_ref_rate = params_rate(fe_params);
>  		out_ref_channels = params_channels(fe_params);
> -		out_ref_type = sof_ipc4_get_sample_type(sdev, fe_params);
> -		if (out_ref_type < 0)
> -			return out_ref_type;
> +		ret = sof_ipc4_get_sample_type(sdev, fe_params);
> +		if (ret < 0)
> +			return ret;
> +		out_ref_type = (u32)ret;
>  
>  		if (!single_output_bitdepth) {
>  			out_ref_valid_bits = sof_ipc4_get_valid_bits(sdev, fe_params);

-- 
Péter


