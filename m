Return-Path: <linux-kernel+bounces-897296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A05CC528BD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 14:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA97A3BEB1B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 13:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B54339B28;
	Wed, 12 Nov 2025 13:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZZ5y3ykm"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A883E338936;
	Wed, 12 Nov 2025 13:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762954678; cv=none; b=HRDFYAtNdTagm0LhneZGPRxqz0JjappLtAtGGFbKjJKuKDcW1WSyM9ib64OwHFPr03gXe40PvZbZo9bvh1TTPkN/tVyNORlrJxjiLaJeOMlr0/i36KGzmmLqzj3OuxBlcYxC/wz/2TRWz16bC0kQqBEiLzRdaiqfJ6olTu9dDdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762954678; c=relaxed/simple;
	bh=U7RoLsnYvGKocM2umwff9hFd9Cs4671agPc3xwEp9pA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EsWjTIOzbL7tc4VYkMKVz/SZTld0fyH+ZzH0j9+4Ct8K20kgWbvTLztvBXc+52NPALuCNTQyb7qapm5RpD6k5qmPhAd0Yh1y/98FuyJJHsR6POjCNeiLgYsm39OsQ0UfFAwZKx8HKf5tBBNTKTwe7c6aHdvOjpa6iLS4x22NmF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZZ5y3ykm; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762954677; x=1794490677;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U7RoLsnYvGKocM2umwff9hFd9Cs4671agPc3xwEp9pA=;
  b=ZZ5y3ykm2LRxNzmXN+4rx0Mf3qwNw/yXV+pAaIwfXPP/76U/cMUoEExw
   WB0E0ULyRyndE0giUvI8JN6KiBXKSp8LjCbUTmMLo8eI8/Fdtl+qalZZS
   i7EcC1cidK6lAx7ZPgNIYQJZnMBtFU08MlGJBDlZvwGtacAKPjQ7BRmNt
   xrl1ETuWE1rB84Eg1rWsC+791OxNhni8CFeZdeCjLjSDbt11PK04rwok4
   vvJwxECcOEwvWCnEFbzqsXNU+W1UebusT273pYMH+jTe1k3jEHs4C0pRM
   ILKsTcpoh9i6Eiz2ymjCGCPAZBeqHQt3S54y/nYA7nJWxdOwVWMnGIdX+
   A==;
X-CSE-ConnectionGUID: SRvsRNEHR/CyvpqPnk2NYQ==
X-CSE-MsgGUID: hUbwzqIfQHOUgtuDbcgeVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="76364778"
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; 
   d="scan'208";a="76364778"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 05:37:56 -0800
X-CSE-ConnectionGUID: j5tJq1vISKaxP6tLzTzBiw==
X-CSE-MsgGUID: EK+QKkEiRNiaccr2y9qYkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; 
   d="scan'208";a="189071651"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.244.214])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 05:37:52 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id A8E80121DDE;
	Wed, 12 Nov 2025 15:37:49 +0200 (EET)
Date: Wed, 12 Nov 2025 15:37:49 +0200
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: hariconscious@gmail.com
Cc: cezary.rojewski@intel.com, liam.r.girdwood@linux.intel.com,
	peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com,
	ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
	pierre-louis.bossart@linux.dev, broonie@kernel.org, perex@perex.cz,
	tiwai@suse.com, amadeuszx.slawinski@linux.intel.com,
	khalid@kernel.org, shuah@kernel.org, david.hunter.linux@gmail.com,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: Intel: avs: Replace snprintf() with scnprintf()
Message-ID: <aRSNrXnmPTElmx5H@kekkonen.localdomain>
References: <20251112120235.54328-2-hariconscious@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112120235.54328-2-hariconscious@gmail.com>

Hi HariKrishna,

On Wed, Nov 12, 2025 at 05:32:35PM +0530, hariconscious@gmail.com wrote:
> From: HariKrishna Sagala <hariconscious@gmail.com>
> 
> As per the C99 standard snprintf() returns the length of the data
> that *would have been* written if there were enough space for it.
> It's generally considered safer to use the scnprintf() variant.

Not only that, but the code assumes scnprintf() behaviour to function
correctly. This should be reflected in the commit message. I.e. this is a
bugfix and should probably be cc'd to stable. Could you provide a Fixes:
tag as well?

The change itself seems fine to me, apart from indentation.

> 
> Link: https://github.com/KSPP/linux/issues/105
> Signed-off-by: HariKrishna Sagala <hariconscious@gmail.com>
> ---
> This patch replaces snprintf() varaint with scnprintf() in
> scenario to know the actual length of the data rather than *would
> have been* written data of snprintf().
> No functional changes intended.
> Reference Links:
> https://lwn.net/Articles/69419/
> https://www.kernel.org/doc/html/latest/core-api/kernel-api.html#c.snprintf
> 
> Note:
> Compile & boot tested with necessary config parameters.
> Other areas of AVS uses scnprintf() variant.
> 
>  sound/soc/intel/avs/debugfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/intel/avs/debugfs.c b/sound/soc/intel/avs/debugfs.c
> index 3534de46f9e4..100b95bfcd78 100644
> --- a/sound/soc/intel/avs/debugfs.c
> +++ b/sound/soc/intel/avs/debugfs.c
> @@ -119,7 +119,7 @@ static ssize_t probe_points_read(struct file *file, char __user *to, size_t coun
>  	}
>  
>  	for (i = 0; i < num_desc; i++) {
> -		ret = snprintf(buf + len, PAGE_SIZE - len,
> +		ret = scnprintf(buf + len, PAGE_SIZE - len,
>  			       "Id: %#010x  Purpose: %d  Node id: %#x\n",
>  			       desc[i].id.value, desc[i].purpose, desc[i].node_id.val);
>  		if (ret < 0)
> 
> base-commit: 24172e0d79900908cf5ebf366600616d29c9b417

-- 
Kind regards,

Sakari Ailus

