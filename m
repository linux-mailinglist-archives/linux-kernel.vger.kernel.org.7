Return-Path: <linux-kernel+bounces-835364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD34BBA6E6A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 11:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8527B3BCA3F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 09:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F331E2DAFD2;
	Sun, 28 Sep 2025 09:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="fkmaC9Jh"
Received: from mail-m21471.qiye.163.com (mail-m21471.qiye.163.com [117.135.214.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE3A2DA758;
	Sun, 28 Sep 2025 09:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.214.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759053479; cv=none; b=WCIrcnT83G/qKGA2UQSX6V3lWTF82lOBSvC9CBjb7FNAIB4M9xEcaEKKP53BIPp9nMlk/Y0eCKQuPBHecJtKOsya0cMWOnLwDm/qr1928ogZ3mQ+aR4ZN4IE1XU4PgnVrpnrYcomT5ZG5ObTivItDltuXvc+votzzVd3Wukn1Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759053479; c=relaxed/simple;
	bh=J8c7JVbiIEeckY6sC/rBbPzskekmzcvgPP0Qe1vVJQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IUVvV1wzYn4bmsIyBfr+UlDadZLwQsAPXsGccqhTRBulzhYXRsWHcb5hxMRBbBBjrKhKwBkdKhSgw6fRLZlz8p/3w5lYGBDxb0vYlaY6ybU1Dtpiz6svy1tjo0XvybYlGtwvpsKtoDN/8XPSQITwlTgVZrV9myRZuqYKcB0VCxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=fkmaC9Jh; arc=none smtp.client-ip=117.135.214.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.153] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2455d07b1;
	Sun, 28 Sep 2025 17:52:36 +0800 (GMT+08:00)
Message-ID: <ede70598-c451-4352-ab3e-0e278ce33ad7@rock-chips.com>
Date: Sun, 28 Sep 2025 17:52:35 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/7] drm/rockchip: cdn-dp: Add multiple bridges to
 support PHY port selection
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
 <20250922012039.323-6-kernel@airkyi.com>
 <idyrlzhd5sotg3ylr7vbwmczimglffc75nafxbnhhm3ot2jn4w@ixerm6elfmre>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <idyrlzhd5sotg3ylr7vbwmczimglffc75nafxbnhhm3ot2jn4w@ixerm6elfmre>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a998fbd11a503abkunma2c1ce0f943b8a
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGhlLGlZNSk0YGE9JTx5PGkNWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=fkmaC9JhLsx9ypREA2gyK2saMIt0xQXv11bYSJmDDFFpI7xmfpCJWCu/QwNzs8iObZJwhYNAOBXT0AKdgryMB/HWPPuwHP4cE9dr6FPYq6oyYCBt+9FMdhF+19j6+JMmlgQdJWNrnY2U734Idzqo3Sisf0O1F72QkVhyE4zITHI=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=r6bywD2WUzTYm4ELUvERid8tPQSU5/IWu32J6FLL1ok=;
	h=date:mime-version:subject:message-id:from;

On 9/23/2025 9:50 AM, Dmitry Baryshkov wrote:

[...]


>> +	/* One endpoint may correspond to one HPD bridge. */
>> +	for_each_of_graph_port_endpoint(port, dp_ep) {
>> +		/* Try to get "port" node of correspond PHY device */
>> +		struct device_node *phy_ep __free(device_node) =
>> +			of_graph_get_remote_endpoint(dp_ep);
>> +		struct device_node *phy_port __free(device_node) =
>> +			of_get_parent(phy_ep);
>> +
>> +		if (!phy_port) {
>> +			continue;
>> +		}
>> +
>> +		/*
>> +		 * A PHY port may contain two endpoints: USB connector port or CDN-DP port.
>> +		 * Try to find the node of USB connector.
> And then there can be a retimer between PHY and the USB-C connector. Or
> some signal MUX. Or DP-to-HDMI bridge. Please, don't parse DT for other
> devices. Instead you can add drm_aux_bridge to your PHY and let DRM core
> build the bridge chain following OF graph.
>
I think building a bridge chain across multiple drm_aux_hpd_bridge may be difficult. First, drm_dp_hpd_bridge_register() cannot register the bridge immediately; instead, it is deferred until drm_aux_hpd_bridge_probe(). When it is added to the bridge_list, it may not yet be attached, and attempting to attach it at that point is too late.

But, if I only use drm_aux_bridge on the USB-C connector, and use my own custom bridge on the PHY device and managing the alloc and attach bridge process myself, then things would become much easier.

-- 
Best,
Chaoyi


