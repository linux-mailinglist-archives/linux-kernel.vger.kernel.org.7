Return-Path: <linux-kernel+bounces-784942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC87B343E8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64E8A17CF29
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBCCE2FF153;
	Mon, 25 Aug 2025 14:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="OONYzdpi"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5D92FDC5D
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756131975; cv=none; b=sfQnHP5rIAOhLN/pcNatFP37yZSsPJmn5dLAD8/e4Ay6gf2VJ2e+vp0YZVt1JM5FTNgpePhj1qRaw2qZY0968Ch0ROk9rkYv32QjEkLC+y3ydMAD3jzfKj6KiZjBPuzeM/WScAmzQWsvlWcWy7jF3+ufsHafNiQ8mlPBeEEQlro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756131975; c=relaxed/simple;
	bh=W5GALg/FqgFaa09TS+BRuKG5OXqUFl5TtcsPwormfpA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=SIqk6h9XmN5zxaTXffZ2HJQgBgdQO2fVdYoSO8h11HLcY5wSkJ8KlqeHLfYAmARkYarmR7APQmuv80C1fy7FiZIlfCMnx3ZvfFw7VmZs88VzYxoICZdz1s0MHsCjRH3G9zSKxs8gOItr/hSnfP9Knm+gC+CxP7nASqtuDOnQSjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=OONYzdpi; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250825142609euoutp023447595987a43abf804c0babb4adcbe8~fCLjj_D1g1837118371euoutp02b
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:26:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250825142609euoutp023447595987a43abf804c0babb4adcbe8~fCLjj_D1g1837118371euoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1756131969;
	bh=+/fhlaFQpc9GWye8OcasT16gmUpaIUbWQDT9KvPLfwM=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=OONYzdpiR5yidVbIpwQKR5Nxp54WV08CgIO23BBl8VHuPi0BBKD+Un0Psa2PE0rsT
	 M/H3LSDgxIstsLqsIQBxQr+bjDAQ5cKRaenInGRmmU3rd5yor6k1bRC/C8osUeSc6K
	 Aklm3NcJvyStuLIKBJE7OUWiWPPdBdCfn03yjvqM=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250825142609eucas1p164334c203abbc296bbbce60f9b6840a5~fCLi1GS9n0240502405eucas1p1j;
	Mon, 25 Aug 2025 14:26:09 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250825142606eusmtip29798f7b6677e4c6c11c859ab5a5459c7~fCLgRwoo-0270802708eusmtip2b;
	Mon, 25 Aug 2025 14:26:06 +0000 (GMT)
Message-ID: <567789e1-8c17-4603-9f27-b33470f6a165@samsung.com>
Date: Mon, 25 Aug 2025 16:26:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v1] drm/bridge: analogix_dp: Reuse
 &link_train.training_lane[] to set DPCD DP_TRAINING_LANEx_SET
To: Damon Ding <damon.ding@rock-chips.com>, andrzej.hajda@intel.com,
	neil.armstrong@linaro.org, rfoss@kernel.org
Cc: Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
	jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
	dmitry.baryshkov@oss.qualcomm.com, dianders@chromium.org,
	andy.yan@rock-chips.com, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20250824034138.3207855-1-damon.ding@rock-chips.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250825142609eucas1p164334c203abbc296bbbce60f9b6840a5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250824034253eucas1p2fa1ad3da751f4d0ac9645ec277cf4563
X-EPHeader: CA
X-CMS-RootMailID: 20250824034253eucas1p2fa1ad3da751f4d0ac9645ec277cf4563
References: <CGME20250824034253eucas1p2fa1ad3da751f4d0ac9645ec277cf4563@eucas1p2.samsung.com>
	<20250824034138.3207855-1-damon.ding@rock-chips.com>

On 24.08.2025 05:41, Damon Ding wrote:
> In analogix_dp_link_start(), &link_train.training_lane[] is used to
> set phy PE/VS configurations, and buf[] is initialized with the same
> values to set DPCD DP_TRAINING_LANEx_SET.
>
> It makes sense to reuse &link_train.training_lane[] to set DPCD
> DP_TRAINING_LANEx_SET, which can remove the redundant assignments
> and make codes more consice.
>
> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>   drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> index ed35e567d117..ec8443d66075 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> @@ -281,12 +281,8 @@ static int analogix_dp_link_start(struct analogix_dp_device *dp)
>   	if (retval < 0)
>   		return retval;
>   
> -	for (lane = 0; lane < lane_count; lane++)
> -		buf[lane] = DP_TRAIN_PRE_EMPH_LEVEL_0 |
> -			    DP_TRAIN_VOLTAGE_SWING_LEVEL_0;
> -
> -	retval = drm_dp_dpcd_write(&dp->aux, DP_TRAINING_LANE0_SET, buf,
> -				   lane_count);
> +	retval = drm_dp_dpcd_write(&dp->aux, DP_TRAINING_LANE0_SET,
> +				   dp->link_train.training_lane, lane_count);
>   	if (retval < 0)
>   		return retval;
>   

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


