Return-Path: <linux-kernel+bounces-882155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62162C29C58
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 02:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FBF9188FE93
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 01:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9EF273804;
	Mon,  3 Nov 2025 01:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="Xf2GCOog"
Received: from mail-m1973187.qiye.163.com (mail-m1973187.qiye.163.com [220.197.31.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F79086334;
	Mon,  3 Nov 2025 01:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762132643; cv=none; b=cC6kJRYFOuuwHTX2JhbMtapu8C10IdWusKRyKI8Lixl23OFbU5pls5viFP7q0y0NKnDRUX2zcpmL50thmFZYyB4wWAjY//buEWPCemcYMLnjZ+3XM4gLYC5s4PtUu487QyfQuv7P1D3iVSZO9BSagb+0Shb3ysWtwDZVkNuNo2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762132643; c=relaxed/simple;
	bh=5za/wdwfGmyMjsBpSMunPbfMRKuNjLwmg5jr/Bt+LWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gMdTfy/jsz6EwjuEW/ee3f71MzPSbXz0S80vmkPDI9Qv2FT7ZL5zLrPDE932ocKPsy9jAYib2Y4PfsqUJnbrGgc9Aon17AYQE87BdDt4F0H3SvN52YuzxPvFFXZei3Von+tg2LQ0mcIfV1OyoDblOSEKR5Gt52i0LfVERC9kGY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=Xf2GCOog; arc=none smtp.client-ip=220.197.31.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.149] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2818c2243;
	Mon, 3 Nov 2025 09:11:59 +0800 (GMT+08:00)
Message-ID: <39c21e9f-4958-4007-bb09-3ef40ff30d2a@rock-chips.com>
Date: Mon, 3 Nov 2025 09:11:57 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 01/10] usb: typec: Add notifier functions
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Chaoyi Chen <kernel@airkyi.com>
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
 Amit Sunil Dhamne <amitsd@google.com>, Dragan Simic <dsimic@manjaro.org>,
 Johan Jonker <jbx6244@gmail.com>, Diederik de Haas <didi.debian@cknow.org>,
 Peter Robinson <pbrobinson@gmail.com>, linux-usb@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org
References: <20251029071435.88-1-kernel@airkyi.com>
 <20251029071435.88-2-kernel@airkyi.com> <aQS8IatWiAUzBUxd@kuha.fi.intel.com>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <aQS8IatWiAUzBUxd@kuha.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9a47455e0103abkunm8b2c313f943871
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGR5MTVYYQk0YGR1KQ0kfTx1WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=Xf2GCOogE5JU9VFai8bfqqPO4EwB1WJ7U798BYDMShF5yADbVIRdoEeXupnhnUlWCWamERfBB8hOvuY9KC55ljPx2XdO0aSSZ4aN/YVRrfNdwUmKid0Rkhyi8liJDc6hPFcv+WVwWCoRwFPiFILAWI0NSARBI9pcgXmLDxUm+VA=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=kGpL6uycvY2W1UtRJCq/id+/GMXz5vHEcP9JtnFabFA=;
	h=date:mime-version:subject:message-id:from;

On 10/31/2025 9:39 PM, Heikki Krogerus wrote:

> Hi,
>
>> diff --git a/include/linux/usb/typec_notify.h b/include/linux/usb/typec_notify.h
>> new file mode 100644
>> index 000000000000..f3a7b5f5b05b
>> --- /dev/null
>> +++ b/include/linux/usb/typec_notify.h
>> @@ -0,0 +1,16 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +
>> +#ifndef __USB_TYPEC_NOTIFY
>> +#define __USB_TYPEC_NOTIFY
>> +
>> +#include <linux/notifier.h>
> Replace that include with a forward declaration:
>
> struct notifier_block;
>
>> +enum usb_typec_event {
>> +	TYPEC_ALTMODE_REGISTERED,
>> +	TYPEC_ALTMODE_UNREGISTERED,
>> +};
>> +
>> +int typec_altmode_register_notify(struct notifier_block *nb);
>> +int typec_altmode_unregister_notify(struct notifier_block *nb);
>> +
>> +#endif /* __USB_TYPEC_NOTIFY */
> I don't see any need for a separate header file for this. Intoduce
> those in typec_altmode.h.

Will fix these in v9. Thank you.


>
> thanks,
>
-- 
Best,
Chaoyi


