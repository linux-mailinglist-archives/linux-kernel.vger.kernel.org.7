Return-Path: <linux-kernel+bounces-896440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1104C505FA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 03:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 922333A7EBD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 02:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1442C327C;
	Wed, 12 Nov 2025 02:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="BfnanaLs"
Received: from mail-m1973191.qiye.163.com (mail-m1973191.qiye.163.com [220.197.31.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D0C2F56;
	Wed, 12 Nov 2025 02:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762916182; cv=none; b=UfskPmjD0yuNMkZRT2Skc0Iko5MBfepSMgbPlUK5jm8n0jerqRvHnN8D/943l6en4Qp9cXeSV0mDLp92JIVav86H1aJWtSvAf6csGSBLwkcrEb8T2Mn97Tiz4HDWL+L7BjL+OLYa5DFXjagpI/nbVy4Ny0pZNMi3ZpvSzonwvoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762916182; c=relaxed/simple;
	bh=yY3OdD0Wf3KLSwr77WwJGHM//jDxDpOVbvQPM76WUZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XvUaShchqaseOctJ2wqojp6ztPbHF9O+3UN4/w7JAoJcbJKi5dUAAp6hskbmflscERsudWDPxROLD3NUc2rg8aQ4KoXYkz8yO32gvESOlp3PpqTEpFDFCemTiK14/0JmpKaKVuCgBpVpxrs53Vo4chp4o/CJUtXAAL53ok6i/10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=BfnanaLs; arc=none smtp.client-ip=220.197.31.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.149] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2943c7c46;
	Wed, 12 Nov 2025 10:50:59 +0800 (GMT+08:00)
Message-ID: <d4861ef9-a25c-491c-9a00-d65fe75d2677@rock-chips.com>
Date: Wed, 12 Nov 2025 10:50:57 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 04/10] dt-bindings: phy: rockchip: rk3399-typec-phy:
 Support mode-switch
To: Krzysztof Kozlowski <krzk@kernel.org>, Chaoyi Chen <kernel@airkyi.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Peter Chen <hzpeterchen@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
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
 Amit Sunil Dhamne <amitsd@google.com>, Dragan Simic <dsimic@manjaro.org>,
 Johan Jonker <jbx6244@gmail.com>, Diederik de Haas <didi.debian@cknow.org>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 dri-devel@lists.freedesktop.org
References: <20251111105040.94-1-kernel@airkyi.com>
 <20251111105040.94-5-kernel@airkyi.com>
 <868f09fd-8fe8-4c01-952f-6317604c43a3@kernel.org>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <868f09fd-8fe8-4c01-952f-6317604c43a3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9a75f93d9b03abkunm3992e66e1852d51
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGh5NTFZMQkMZSRpJGUJJHkpWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=BfnanaLsNym3HyzqwH3OnGP1xmT0wPf4OoG6mLeXNzKNon4hMOY5ybAPzIG5A2swqv9GW1Dk0xahQPlEdSUzGVGO030Q+pdtfdO7Vn8vOx3D4j7Jqoib9PCmnjI9PllpUI2CFlrsM/l5X+lLXGTAlfSSW9PssoQIt4PnwxpBKbs=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=7NS+b33zjPCJC+YQ9D+VMMD2zKMV2hZ3cis1B+LtXgQ=;
	h=date:mime-version:subject:message-id:from;

On 11/11/2025 7:09 PM, Krzysztof Kozlowski wrote:

> On 11/11/2025 11:50, Chaoyi Chen wrote:
>> While an external Type-C controller is still required to detect cable
>> attachment and report USB PD events, the actual mode and orientation
>> switching is performed internally by the PHY through software
>> configuration. This allows the PHY to act as a Type-C multiplexer for
>> both data role and DP altmode configuration.
>>
>> To reflect this hardware design, this patch introduces a new
>> "mode-switch" property for the dp-port node in the device tree bindings.
>> This property indicates that the connected PHY is capable of handling
>> Type-C mode switching itself.
>>
>> Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
>>
>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> There are never blank lines between tags.
>
Sorry for that. I will pay attention to this in future submissions.

-- 
Best,
Chaoyi


