Return-Path: <linux-kernel+bounces-783451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 345E7B32DC9
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 08:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C76B17AF723
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 06:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F65241103;
	Sun, 24 Aug 2025 06:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="bxUMKVL+"
Received: from mail-m1973172.qiye.163.com (mail-m1973172.qiye.163.com [220.197.31.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9ED14A4CC
	for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 06:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756017384; cv=none; b=e664Mei9YDuUJ3cbM3dHjoZNd6pRraq8etvE7Xj/dsZPr6lRq1qI/ddqnn1WrMFjZld63FWs0XpfPqg6fWNiOqAAUSW5/XfrtfDAWlBTn7MpA7EtdQeCi3ZSalSw2/SsV/2iDZQUS9RX400urN3pg2CRw+VvEpQXsiv6L+DioJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756017384; c=relaxed/simple;
	bh=IF1y7NdLfQ45AanWLb6aGn8LJaicRpIzFSCjYGfLkzA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CNanCphZD7zYzhAX1Zyx2Jk5kEHcjgOrliq7DNwlg96acguXASoHpiXlw7J3l2ftgroRsoZX4MDx6ztx8TDJWfgEn9DTTDZEvJJ/oKRXbUFduHqM4jhsI7q/JXf5LduQ64/tqiIIedOjoirugRFTDMdE4gwtevMe2H3lkGO2+VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=bxUMKVL+; arc=none smtp.client-ip=220.197.31.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.26] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2063387f6;
	Sun, 24 Aug 2025 14:36:09 +0800 (GMT+08:00)
Message-ID: <8513b4b6-0b59-4b42-864b-0fe0423cd7fd@rock-chips.com>
Date: Sun, 24 Aug 2025 14:36:07 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] drm/rockchip: analogix_dp: Apply
 devm_clk_get_optional() for &rockchip_dp_device.grfclk
To: Heiko Stuebner <heiko@sntech.de>, andy.yan@rock-chips.com,
 hjc@rock-chips.com
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 dmitry.baryshkov@oss.qualcomm.com, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250824031932.3204920-1-damon.ding@rock-chips.com>
 <7656195.LvFx2qVVIh@phil>
Content-Language: en-US
From: Damon Ding <damon.ding@rock-chips.com>
In-Reply-To: <7656195.LvFx2qVVIh@phil>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a98dacaa0e303a3kunmefff2f7629c876
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkoZQlYYTk5LS01CQkpMQk9WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=bxUMKVL+NrOoJGo0j4JgfMVjfGeoJtah3thFVVG8wSzKTDStABIUg7WbZ9XvtcP47w1h8dvuRThD6xthQB6L53UVa3N1PaIfZmKod8eCZd4iuBDTPsGmWtFHEFkK6EmcaYr6PGmOunhPJgBRb+vaFxz5D6HPK53Opjr1JHcx5ws=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=XcRU7Z/PkU7Ppn7Ao+1BSxCwQMj8o7al8ldpZz63HXk=;
	h=date:mime-version:subject:message-id:from;

Hi Heiko,

On 8/24/2025 2:08 PM, Heiko Stuebner wrote:
> Hi Damon,
> 
> Am Sonntag, 24. August 2025, 05:19:32 Mitteleuropäische Sommerzeit schrieb Damon Ding:
>> The "grf" clock is optional for Rockchip eDP controller(RK3399 needs
>> while RK3288 and RK3588 do not).
>>
>> It can make the code more consice to use devm_clk_get_optional()
>> instead of devm_clk_get() with extra checks.
>>
>> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
>> ---
>>   drivers/gpu/drm/rockchip/analogix_dp-rockchip.c | 8 ++------
>>   1 file changed, 2 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
>> index d30f0983a53a..d0f78ab9faa6 100644
>> --- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
>> +++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
>> @@ -335,12 +335,8 @@ static int rockchip_dp_of_probe(struct rockchip_dp_device *dp)
>>   		return PTR_ERR(dp->grf);
>>   	}
>>   
>> -	dp->grfclk = devm_clk_get(dev, "grf");
>> -	if (PTR_ERR(dp->grfclk) == -ENOENT) {
>> -		dp->grfclk = NULL;
>> -	} else if (PTR_ERR(dp->grfclk) == -EPROBE_DEFER) {
>> -		return -EPROBE_DEFER;
>> -	} else if (IS_ERR(dp->grfclk)) {
>> +	dp->grfclk = devm_clk_get_optional(dev, "grf");
>> +	if (IS_ERR(dp->grfclk)) {
>>   		DRM_DEV_ERROR(dev, "failed to get grf clock\n");
>>   		return PTR_ERR(dp->grfclk);
> 
> generall I definitly I agree, but you're loosing the
> "don't print anything for EPROBE_DEFER" handling.
> 
> Additionally DRM_DEV_ERROR says in the code
> "this is deprecated in favor of drm_err() or dev_err()." .
> 
> Also this in the probe-path, so to catch both issues, I'd sugest
> using dev_err_probe() for the message, which handles EPROBE_DEFER
> automatically.
> 

Yeah, I will use dev_err_probe() instead in the next version.

In addition, it should be nice to modify the other similar codes in 
rockchip_dp_of_probe(). I will add another commit to do it.

Best regards,
Damon


