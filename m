Return-Path: <linux-kernel+bounces-796559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2C2B4028D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 15:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67794168140
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 13:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01BC3043D0;
	Tue,  2 Sep 2025 13:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CWaUPFgS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFC52BE65C;
	Tue,  2 Sep 2025 13:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756819009; cv=none; b=OY7Fi85uzLBuV32m8y6fBePSxj9mE02LtGrerW9L0z6zE3R0BACK4vY7fp9XXLNJjo0I0ODm+ka9N60AmqPhl8E8s7/Iqnj85pGym+yDTgVqk9aZBM4cp/pI521wTJAF706NG3Wz2IzR1HTcjQeJUkdsYzWqYPccKlCKgVSDEkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756819009; c=relaxed/simple;
	bh=vgV6oU+KN3/QRZFIeHk7PC6Ii26XZHrx8aCL79SZIG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QDEx5VrdoLiZXyGgwuP9jSxdYLIBa14vJEHTlmhvZlqM1GuxNV7Sq914SKwti99ASZFtdoXpIq9QlFWbu2vRXGuDf/Lm1HTzDUq40FDferIjUvLw54Yk3nGGhJ5MuhZBK1Au2C8j4Q56CAdnJp54lBnXP5MRMXD2ZUg5SXxtOIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CWaUPFgS; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756819008; x=1788355008;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vgV6oU+KN3/QRZFIeHk7PC6Ii26XZHrx8aCL79SZIG4=;
  b=CWaUPFgSI5dLxXyz2uyBIsHvigOmII+blAQS3sN/nkYNkH3LqEvEas6w
   3AVuuoHtOkDiN4/qJ3JdEuCzqxg9+iTux1cwk5rzds0AQEzjT80gFHZ4F
   G9u0z5zNrXyW/31Ax3t7ju6cEKnZk0UZikROUeA4GKuAzGS9YrhX/+Upx
   CZe+wMyJqi2NZVVodNxt+TfgmmQcEJcuvDLmgx7siYuPuZKAFuSC8nm8z
   hDXalSjI1FxxDOg3+tLSTteHLhN0094fN2gXZL7I9Ai4vHfJobtdGlYXx
   86iwvo3QOlx890RZGQGutts0Mb9cUorOT0t5bJVDlK3lRyCAEnxkP048N
   A==;
X-CSE-ConnectionGUID: CBgZDrbhT+apD24wq/2w1g==
X-CSE-MsgGUID: 8+Fw75hWSpOZ7joM4JTwbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="70521229"
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="70521229"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 06:16:47 -0700
X-CSE-ConnectionGUID: NfIZbdgxRV2me/reuHxKHA==
X-CSE-MsgGUID: orfH6rrfQgGlXSCs3uNgog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="170831206"
Received: from carterle-desk.ger.corp.intel.com (HELO [10.245.246.183]) ([10.245.246.183])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 06:16:42 -0700
Message-ID: <ec553d4f-169c-4173-8fa8-281ed3a147d8@linux.intel.com>
Date: Tue, 2 Sep 2025 16:17:26 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] ASoC: SOF: Intel: hda-stream: Fix incorrect
 variable used in error message
To: Colin Ian King <colin.i.king@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Daniel Baluta <daniel.baluta@nxp.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Keyon Jie <yang.jie@linux.intel.com>,
 sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250902120639.2626861-1-colin.i.king@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <20250902120639.2626861-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 02/09/2025 15:06, Colin Ian King wrote:
> The dev_err message is reporting an error about capture streams however
> it is using the incorrect variable num_playback instead of num_capture.
> Fix this by using the correct variable num_capture.
> 
> Fixes: a1d1e266b445 ("ASoC: SOF: Intel: Add Intel specific HDA stream operations")
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Acked-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

> ---
>  sound/soc/sof/intel/hda-stream.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/sof/intel/hda-stream.c b/sound/soc/sof/intel/hda-stream.c
> index aa6b0247d5c9..a34f472ef175 100644
> --- a/sound/soc/sof/intel/hda-stream.c
> +++ b/sound/soc/sof/intel/hda-stream.c
> @@ -890,7 +890,7 @@ int hda_dsp_stream_init(struct snd_sof_dev *sdev)
>  
>  	if (num_capture >= SOF_HDA_CAPTURE_STREAMS) {
>  		dev_err(sdev->dev, "error: too many capture streams %d\n",
> -			num_playback);
> +			num_capture);
>  		return -EINVAL;
>  	}
>  

-- 
Péter


