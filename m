Return-Path: <linux-kernel+bounces-868442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B757C053D9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 11:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0877542648D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 08:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC51306D26;
	Fri, 24 Oct 2025 08:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="g2jiBWJ+"
Received: from mail-m49228.qiye.163.com (mail-m49228.qiye.163.com [45.254.49.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB14B2F7AB9;
	Fri, 24 Oct 2025 08:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761295896; cv=none; b=EeMGWxzqendwh53eOcj9wC1xg73/kcTHkgm7mlmlVug7THKyobw8jjtsairGp2VohuXoUd9WFarurgJUrxt5y+TtD88UOrJBUAxlMNjR84vbcNyycrjYtIlyfi0C5hpADtmMHdhBh6Iwx0OplcLVk2cTnzfkdJqOfHyNKurg0cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761295896; c=relaxed/simple;
	bh=st+YiT6+ntVTsbmWboA5z/ppcN3WvsLFMmnop252vB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mgdzV/qS1hKmiyyiSqmX4Q+jHzd8tY5mIYZDYpvCilZ4kqGI7dni3FbuttplFPsFL6gs9r48M1XRY2t1aJPbzAL181752+HjOBnOq1tep+BECklEgE3wCsIT1mJX8suQIeacgOrs5HuWPqlS+1vu/EbYxMecgDaPLQRdwlnLjMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=g2jiBWJ+; arc=none smtp.client-ip=45.254.49.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.149] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 270f3fb7d;
	Fri, 24 Oct 2025 16:16:01 +0800 (GMT+08:00)
Message-ID: <836a096a-c6ed-4c9c-9de5-f8b0ee44fac3@rock-chips.com>
Date: Fri, 24 Oct 2025 16:16:00 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/9] drm/bridge: Implement generic USB Type-C DP HPD
 bridge
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Heiko Stuebner
 <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>,
 Andy Yan <andy.yan@rock-chips.com>,
 Yubing Zhang <yubing.zhang@rock-chips.com>,
 Frank Wang <frank.wang@rock-chips.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Amit Sunil Dhamne <amitsd@google.com>,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>, Dragan Simic <dsimic@manjaro.org>,
 Johan Jonker <jbx6244@gmail.com>, Diederik de Haas <didi.debian@cknow.org>,
 Peter Robinson <pbrobinson@gmail.com>, linux-usb@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org
References: <20251023033009.90-1-kernel@airkyi.com>
 <20251023033009.90-3-kernel@airkyi.com> <aPsyPTTq3bD2mo87@kuha.fi.intel.com>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <aPsyPTTq3bD2mo87@kuha.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9a1549fc6403abkunm8ebff3a42f61fa
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQklPSVZPGkoeGkMYTkNDH0lWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUJNS0
	pVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=g2jiBWJ+5dWD89nwOEyvWd7ig8i9jlV3bsjkJAfzip9OCKfRVMZ7DwJm4SNDH65hPFNm/b8wbYa+2UzpdVOu94do1TGefahMmFST785Ic9q/7uVSPmL0w+k8+xHAmfVSu8VVKj0qOgXwm9Jo7p28h1IRDDdjnxmfKRmTfLl7vds=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=ypCW1dxnbfwi7cFlpQlnKjE4aNK9rTR6Jockrm+i67Q=;
	h=date:mime-version:subject:message-id:from;

On 10/24/2025 4:01 PM, Heikki Krogerus wrote:

> On Thu, Oct 23, 2025 at 11:30:02AM +0800, Chaoyi Chen wrote:
>> +static int drm_typec_bus_event(struct notifier_block *nb,
>> +			       unsigned long action, void *data)
>> +{
>> +	struct typec_altmode *alt = (struct typec_altmode *)data;
>> +
>> +	if (action != TYPEC_ALTMODE_REGISTERED)
>> +		goto done;
>> +
>> +	if (alt->svid != USB_TYPEC_DP_SID)
>> +		goto done;
>> +
>> +	/*
>> +	 * alt->dev.parent->parent : USB-C controller device
>> +	 * alt->dev.parent         : USB-C connector device
>> +	 */
>> +	drm_dp_hpd_bridge_register(alt->dev.parent->parent,
>> +				   to_of_node(alt->dev.parent->fwnode));
> Okay, this explains it. So you do need the port altmode.
>
> So you'll need to export the device types and check that the parent of
> the altmode is the port instead of partner.
>
>          if (!is_typec_port(alt->dev.parent) || alt->svid != USB_TYPEC_DP_SID)
>                  return NOTIFY_DONE;
>
> I think we might as well export all the types while at it. Check the
> attachment.

Oh, I did miss the existence of partner. Thank you for your code!


>
> thanks,
>
-- 
Best,
Chaoyi


