Return-Path: <linux-kernel+bounces-786322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C12F0B3586B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 11:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 484D1175188
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 09:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F280279DC5;
	Tue, 26 Aug 2025 09:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DEYMSi4j"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2753054E5;
	Tue, 26 Aug 2025 09:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756199491; cv=none; b=sXUXeUWp1FJibHIpyhwZxjRdsEgwyoI1UARF23GC1D3yJhjeQIGRp1u6ilEOmnzg5K+UrGNkdYa0Y9YQ83zlvCdb1jcxMqgaItHMSgN+6D02hy0E4KmAE2X6ISQ9G819b+V7PA+nRXcV929/ZJkCwiBXmL2WiNOWR29Vfm5jPCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756199491; c=relaxed/simple;
	bh=eBOr2RpiZufw8xG5QulV/98+dCNxavPMBGdKmW1cQ6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bM9Bv1vEuPOjhup5lW4Z8+5lFYmafR/4Mx52/eo0KIPeMPp2YaoXZXbRNJwvsTtsOc0CM1cmGQCFq8TwA8gRhwAnm3LAQ3XL89GNqEh2Q/YxjYuFSzsPsuBQxDvB4qjX9dgl0yq7XzIKtaNc72GZay6F2VXT6yFpYmqO/kBkZ84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DEYMSi4j; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756199489; x=1787735489;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eBOr2RpiZufw8xG5QulV/98+dCNxavPMBGdKmW1cQ6A=;
  b=DEYMSi4jfCHPBIBL88cE2FFLA0//y7O5zjnfRI/4sd29UsQjUebBCdiz
   B67e8M0SCK/lHLvgD5orvrIyno0qky03f55zp4B2y7ED02PydoTbENy9r
   bWh8EaHNHZYrcgGt2tLsJLJo684BbsDFxpFJ/X4K7ImlrTnmyxwo6qwSd
   51k2KqLK4RYNU56OhOopE6sM/r2mjfT3dqITOwe2T6OYs+KFPZb1AfT/F
   bJps3CRaVS0issSdoL7sQRRaOgsSv9NhkhTELwjgZVshdtXgGoZKNHMiq
   iRoxxXGMWhAqhjMC9N751PMW7z/+WdluGiH1i2Ln6rjbSJRY62/UZN7d7
   Q==;
X-CSE-ConnectionGUID: CSPwdiwOSXa1iEl/0SxGFw==
X-CSE-MsgGUID: 6TwneSocSl6rE7t6J5CuOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="58346425"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="58346425"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 02:11:28 -0700
X-CSE-ConnectionGUID: yuzWgUc3SJyc4SsHyobBew==
X-CSE-MsgGUID: RujYWHaCRXCZwW48rej0eQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="174789996"
Received: from carterle-desk.ger.corp.intel.com (HELO [10.245.246.74]) ([10.245.246.74])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 02:11:24 -0700
Message-ID: <431d4cbf-281a-4f93-bda4-767fa6b96c8c@linux.intel.com>
Date: Tue, 26 Aug 2025 12:11:54 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ASoC: SOF: Intel: WCL: Add the sdw_process_wakeen op
To: Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
 linux-kernel@vger.kernel.org
Cc: linux-sound@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>, Jaroslav Kysela
 <perex@perex.cz>, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Daniel Baluta <daniel.baluta@nxp.com>, Mac Chiang <mac.chiang@intel.com>,
 alsa-devel@alsa-project.org
References: <20250826090530.2409509-1-ajye_huang@compal.corp-partner.google.com>
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
Content-Language: en-US
In-Reply-To: <20250826090530.2409509-1-ajye_huang@compal.corp-partner.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 26/08/2025 12:05, Ajye Huang wrote:
> Add the missing op in the device description to avoid issues with jack
> detection.
> 
> Signed-off-by: Ajye Huang <ajye_huang@compal.corp-partner.google.com>

Can you add these tags and send v2?
Fixes: 6b04629ae97a ("ASoC: SOF: Intel: add initial support for WCL")
Acked-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

Thank you!

> ---
>  sound/soc/sof/intel/ptl.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/soc/sof/intel/ptl.c b/sound/soc/sof/intel/ptl.c
> index 1bc1f54c470d..4633cd01e7dd 100644
> --- a/sound/soc/sof/intel/ptl.c
> +++ b/sound/soc/sof/intel/ptl.c
> @@ -143,6 +143,7 @@ const struct sof_intel_dsp_desc wcl_chip_info = {
>  	.read_sdw_lcount =  hda_sdw_check_lcount_ext,
>  	.check_sdw_irq = lnl_dsp_check_sdw_irq,
>  	.check_sdw_wakeen_irq = lnl_sdw_check_wakeen_irq,
> +	.sdw_process_wakeen = hda_sdw_process_wakeen_common,
>  	.check_ipc_irq = mtl_dsp_check_ipc_irq,
>  	.cl_init = mtl_dsp_cl_init,
>  	.power_down_dsp = mtl_power_down_dsp,

-- 
Péter


