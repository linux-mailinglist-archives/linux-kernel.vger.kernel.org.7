Return-Path: <linux-kernel+bounces-732707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5A0B06B06
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 03:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8C984E0C84
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 01:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6697D214A64;
	Wed, 16 Jul 2025 01:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="QErOC5Uo"
Received: from mail-m19731109.qiye.163.com (mail-m19731109.qiye.163.com [220.197.31.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0F046B5;
	Wed, 16 Jul 2025 01:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752628571; cv=none; b=HqLBrvopSM3tnfucsOVvhSIW3naoCWDG44WqNfKbgc4Ui1zRSNkfRABxIuZkIFR1KXlR1IJ41NYQQNx+xKjN9OUCrMPGy3+/45znO2/JvApelsGld2qSLw8CnwmydfEXWa4Q0k2Re5IE0rKsCv5YKRN2RfszgbK2tpTWdkxyQck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752628571; c=relaxed/simple;
	bh=uaYNIOIWNjAfAKE+CoMMcRL7bIWEp9SNw0WMQ37y4nc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oZZyd5ga8TxDK4M9zF79bPqYc81Bv0oO7S8zrCr0/AhNkRK0Yd+eyXGdwfc/0OsTQoeAG+4TVArNs61gCI5lCqSBrcg2zEO4Qe+5QLPpWRybTUNEsOPNa/Yb5qlblUyLYEUSZnh68dHXXDt7eBFEifL2KZWDPEeXnjBw0HekwcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=QErOC5Uo; arc=none smtp.client-ip=220.197.31.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [127.0.0.1] (gy-adaptive-ssl-proxy-2-entmail-virt205.gy.ntes [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1c20d7125;
	Wed, 16 Jul 2025 09:15:47 +0800 (GMT+08:00)
Message-ID: <3a27b7f6-a614-49b4-85dd-5ecba1fbbf70@rock-chips.com>
Date: Wed, 16 Jul 2025 09:13:19 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] dt-bindings: connector: Add displayport connector for
 hotplug notify
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
 <20250715112456.101-2-kernel@airkyi.com>
 <r7b4y74lr5qwejkejquosaar75mthjvjfy4pp6bbl4pgte6cq4@n3gwjolsaw2j>
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <r7b4y74lr5qwejkejquosaar75mthjvjfy4pp6bbl4pgte6cq4@n3gwjolsaw2j>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkxOSVZISklNSh0dHkIYGk9WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpOTE
	9VSktLVUpCS0tZBg++
X-HM-Tid: 0a9810cd504203abkunm840d694a1422a31
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PDo6KCo4ITE1QgkzSBFDOBBD
	KD4wCg1VSlVKTE5JTUlDTk5MT0tLVTMWGhIXVRgTGhQCElUYEx4VOwkUGBBWGBMSCwhVGBQWRVlX
	WRILWUFZTkNVSUlVTFVKSk9ZV1kIAVlBSU5ITTcG
DKIM-Signature:a=rsa-sha256;
	b=QErOC5UoqyDYWY6i+q1Kg2Q45UWi3O2IVyJcMA1U/7LcGrlGgWVB09uVvIPfrOYKEcsJjjpCUbjXms9J4bcz4KxHOo2ErvusAHAuHfIyYmuk3PwbGw6m0m6hCQLlKA6SYkIKMj/7nPuL8sgKuV/dILnY4vDV16XIqVGUvBs+5u4=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=8tvZ89+8JoZnHFukEKSRMTvjOkm6vgN7ue8AXAXJ2pE=;
	h=date:mime-version:subject:message-id:from;

On 2025/7/15 20:04, Dmitry Baryshkov wrote:

> On Tue, Jul 15, 2025 at 07:24:52PM +0800, Chaoyi Chen wrote:
>> From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
>>
>> The USB Type-C DisplayPort alternate mode driver will find
>> "displayport" property for DRM hotplug event notify[0].
>>
>> [0]: https://lore.kernel.org/all/20210817215201.795062-9-hdegoede@redhat.com/
>>
>> Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
>> ---
>>   .../devicetree/bindings/connector/usb-connector.yaml          | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
> Please see how it was done on other platforms. For example, qualcomm
> (both tcpm and pmic-glink) use port / endpoint to link to the DP PHY /
> DP controller.
Thank you! I'll check these out.


