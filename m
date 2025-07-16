Return-Path: <linux-kernel+bounces-732731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A46CB06B57
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 03:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BFB4170E78
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 01:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F75D27146F;
	Wed, 16 Jul 2025 01:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="W0jW9R03"
Received: from mail-m15572.qiye.163.com (mail-m15572.qiye.163.com [101.71.155.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787802AE8E;
	Wed, 16 Jul 2025 01:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752631013; cv=none; b=TbFzbBR0x/RAzzNlR5lIHOkwJlGGjO7W1mVSKuR/rXHNSnw/WxiP7lbSkyy3Ex0dEE2KgXZAlveA2p6+5lt0QRX1SH/VgR6q4dxlSaTf/MY1lhYBGCGPtQwtUCkrH30Ly5J0ktd5TIzOR+CYlIFY9UqrepbgRpuXvdgOk9fsooQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752631013; c=relaxed/simple;
	bh=e9lUDbvdgYncphaWPprUaZQ6Mg/HpQCIuNBWvPgCjzY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jx/6cYSORDcDltEjq0SBRsIz0n+gLv++Fl/j+eiarJC3h6MkaFlNm3n9El2kvONdopZsx6ibgGsfwVt6FEPOxp1Zt0YnfLzLLWJcFcyoxMaiOjV72sRiY6xTmzyZW91+5sX84ocEdIRthNp8L0KwJoba8S68NzCcva7Eeuk2z0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=W0jW9R03; arc=none smtp.client-ip=101.71.155.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [127.0.0.1] (gy-adaptive-ssl-proxy-4-entmail-virt151.gy.ntes [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1c22589b7;
	Wed, 16 Jul 2025 09:56:28 +0800 (GMT+08:00)
Message-ID: <c84cb838-e6e7-4ed0-8d12-67b82f85ff28@rock-chips.com>
Date: Wed, 16 Jul 2025 09:56:27 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] phy: rockchip: phy-rockchip-typec: Add support for
 Type-C TCPM
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
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dragan Simic <dsimic@manjaro.org>, Johan Jonker <jbx6244@gmail.com>,
 Diederik de Haas <didi.debian@cknow.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 dri-devel@lists.freedesktop.org
References: <20250715112456.101-1-kernel@airkyi.com>
 <20250715112456.101-4-kernel@airkyi.com>
 <eqb5m22om6bx2ypjtnlwdjmgfyycpmgrlvro34xwlwjj4j2jeq@mrarg36wetp6>
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <eqb5m22om6bx2ypjtnlwdjmgfyycpmgrlvro34xwlwjj4j2jeq@mrarg36wetp6>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkgYH1ZMGk9MGh0fHhlJH0xWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCS0
	NVSktLVUpCWQY+
X-HM-Tid: 0a9810f28ea703abkunm90ac2de114329c6
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pkk6PAw6TzE0CQkqHyMaKTwO
	FCMwFBxVSlVKTE5JTUhLQkJDTExNVTMWGhIXVRgTGhQCElUYEx4VOwkUGBBWGBMSCwhVGBQWRVlX
	WRILWUFZTkNVSUlVTFVKSk9ZV1kIAVlBSUNNTDcG
DKIM-Signature:a=rsa-sha256;
	b=W0jW9R03pDXvYvm3Rcj4D/OVXpsMGGUD4uR1EzjGrfUvJ1jREzszZ3UvHu9fA4hJSWutBZqokl4p7J5EL4BskBgoitkLIFthMM+EJ1eWoL5y4pjR+pSdm4P3can6FI5v2Cx7gxWVhXUR4sdLwXNQPCr29lZXHdhlnt5R7jcGTaA=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=jn0hRWbIM6rr6NocmrIeQ0wNYnfckKljpY3FeBK/+iY=;
	h=date:mime-version:subject:message-id:from;

Hi Dmitry,

On 2025/7/15 20:05, Dmitry Baryshkov wrote:
> On Tue, Jul 15, 2025 at 07:24:54PM +0800, Chaoyi Chen wrote:
>> From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
>>
>> This patch add support for Type-C Port Controller Manager.
>> The extcon device should still be supported.
>>
>> Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
>> ---
>>   drivers/phy/rockchip/phy-rockchip-typec.c | 335 ++++++++++++++++++++--
>>   1 file changed, 319 insertions(+), 16 deletions(-)
> Please keep TCPM implementation under drivers/usb/typec/tcpm/ . Create
> an aux device and write an aux driver for the TCPM part.

Sorry, the commit messages may not be described accurately enough.


This patch adds mux/switch operations to the PHY driver to improve 
communication with the TCPM framework. Since this PHY is a combo USB/DP 
PHY, it requires configuration changes to the PHY lanes based on the 
USB-C  plug orientation (CC logic), similar to the existing extcon 
mechanism implementation. Of course, the original extcon functionality 
will remain fully compatible.



