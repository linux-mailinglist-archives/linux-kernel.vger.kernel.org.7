Return-Path: <linux-kernel+bounces-828054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF1DB93D33
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 03:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 714FE3B9D0D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 01:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313321F1534;
	Tue, 23 Sep 2025 01:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="COY5I7jk"
Received: from mail-m15597.qiye.163.com (mail-m15597.qiye.163.com [101.71.155.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63E71386B4;
	Tue, 23 Sep 2025 01:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758590440; cv=none; b=sWxa+0p/GPfq5izNZPI4709NJAmpHE+H0moHqyHt5ASqsMer8SzpcuGo8ObBZ3veA3hrgcCaDoo3PwcVTr8hCzViIqTMk+bRowJqjtfpKnUylV+Jjj2QI1oXq0uepr+9nk22p/9Jaz+UzUScv7lKmmL6YboIxERZw1dQKZd6Sh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758590440; c=relaxed/simple;
	bh=EBLtSizlEaGrkSeBx2Zot7Oeyumos8fWX3DZsxqhFMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UOd2xWO9aZL8BVCDbrEJ6hWZnlWn6xvytIcX225Rbzc717Ex+QdahhJW/THoVZHipiNIu5+jj3r+rjd1zBhbaxnkbKmILDUKZl1yNscH/H89Q9/wJCbKaNiaMvtVwSvaTqQ4KXj5Ugu9cyu8WQluZxW/ryXvZeDBK/nDsi57/IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=COY5I7jk; arc=none smtp.client-ip=101.71.155.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.153] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 23b3334ac;
	Tue, 23 Sep 2025 09:15:15 +0800 (GMT+08:00)
Message-ID: <5d078df4-4e0b-464b-9c2f-28b9a2669c5c@rock-chips.com>
Date: Tue, 23 Sep 2025 09:15:13 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/7] drm/rockchip: cdn-dp: Support handle lane info
 without extcon
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Chaoyi Chen <kernel@airkyi.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Heiko Stuebner
 <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>,
 Andy Yan <andy.yan@rock-chips.com>,
 Yubing Zhang <yubing.zhang@rock-chips.com>,
 Frank Wang <frank.wang@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Amit Sunil Dhamne <amitsd@google.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dragan Simic <dsimic@manjaro.org>, Johan Jonker <jbx6244@gmail.com>,
 Diederik de Haas <didi.debian@cknow.org>,
 Peter Robinson <pbrobinson@gmail.com>, linux-usb@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org
References: <20250922012039.323-1-kernel@airkyi.com>
 <20250922012039.323-5-kernel@airkyi.com>
 <gcgiszrrpqkoi3mhajn4i72awbffqv6mayahmnyswoitxxmrgd@nr2z4cpurbwq>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <gcgiszrrpqkoi3mhajn4i72awbffqv6mayahmnyswoitxxmrgd@nr2z4cpurbwq>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9974239f4c03abkunmb38508cda8da5
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0JDSlZDGBhCH0NKQ09DT0JWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=COY5I7jkTU/zXnYTeQOMUc3ZPuGFmr7/r/7qdm6w5dIx4BIwgxKuHNnKEw48qSuL2b7I94/K+LtFixhilqgXOiMbji0L+k7o+/ueZ9uLqIghKjY/fF4rNBK3sPFb4H4n910b157/pQHZiPerd1v1I9xllp6XzfHxWzaziQqdB9A=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=TnzpHwo3q7997FFkEs8jwSh1z9SSMeRB7M3+4Ac9o8k=;
	h=date:mime-version:subject:message-id:from;

On 9/22/2025 6:01 PM, Dmitry Baryshkov wrote:

> On Mon, Sep 22, 2025 at 09:20:36AM +0800, Chaoyi Chen wrote:
>> From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
>>
>> This patch add support for get PHY lane info without help of extcon.
>>
>> There is no extcon needed if the Type-C controller is present. In this
>> case, the lane info can be get from PHY instead of extcon.
>>
>> The extcon device should still be supported if Type-C controller is
>> not present.
>>
>> Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
>> ---
>>
>> Changes in v4:
>> - Remove cdn_dp_hpd_notify().
>>
>> (no changes since v3)
>>
>> Changes in v2:
>> - Ignore duplicate HPD events.
>>
>>   drivers/gpu/drm/rockchip/cdn-dp-core.c | 25 +++++++++++++++++--------
>>   1 file changed, 17 insertions(+), 8 deletions(-)
>>
>> @@ -1120,14 +1129,14 @@ static int cdn_dp_probe(struct platform_device *pdev)
>>   		    PTR_ERR(phy) == -EPROBE_DEFER)
>>   			return -EPROBE_DEFER;
>>   
>> -		if (IS_ERR(extcon) || IS_ERR(phy))
>> +		if (IS_ERR(phy) || PTR_ERR(extcon) != -ENODEV)
>>   			continue;
> This will break the case when the extcon is present. It should be
> (IS_ERR(extcon) && PTR_ERR(extcon) != -ENODEV)

Yes, will fix in v5


>
>>   
>>   		port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
>>   		if (!port)
>>   			return -ENOMEM;
>>   
>> -		port->extcon = extcon;
>> +		port->extcon = IS_ERR(extcon) ? NULL : extcon;
>>   		port->phy = phy;
>>   		port->dp = dp;
>>   		port->id = i;
>> -- 
>> 2.49.0
>>
-- 
Best,
Chaoyi


