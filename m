Return-Path: <linux-kernel+bounces-868344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7DDC0505F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 866733AEDE0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 08:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4CE230215D;
	Fri, 24 Oct 2025 08:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="cbh7z5oM"
Received: from mail-m21467.qiye.163.com (mail-m21467.qiye.163.com [117.135.214.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F123019A9;
	Fri, 24 Oct 2025 08:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.214.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761293582; cv=none; b=tQ1E5UA4dyL8WkCTWDAHgNgd9pCu5BfgGFtJtUw8p1vtL5+roHb04SbchGSMF3k2zf1u323JuOmh/Yh5QcTWQdVPeBxx3cHfTD3jyQaJZqlSDsVgPRvGhrKFAxbc8H9+SrRk9rbHx2Ux/L58YHb0D0ngFG2tdxjDOiNw/LZcGMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761293582; c=relaxed/simple;
	bh=X8eEYQQ4MNkto2esE9lEJmHcm1ClymqxfAWV5cW50Lg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rDuXFVO49RLl/+P6z98oy7hZ0beXFCC+d3xTlAdurUC+JKdPyVyACFvrkVO23aFsgxqIrrGF/jDg4P7PIlgb9h1vdxyGkWjKtFDdJR2A6jNuYA7RmWIu2paLjMC9kmedfh/w1eFpfItmGjtcrHre/R1pBvtgivNF8X+jE1AIqO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=cbh7z5oM; arc=none smtp.client-ip=117.135.214.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.149] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 270f1f398;
	Fri, 24 Oct 2025 16:12:48 +0800 (GMT+08:00)
Message-ID: <9ec2189e-ec36-4cd8-9713-beb490b8297c@rock-chips.com>
Date: Fri, 24 Oct 2025 16:12:47 +0800
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
 Amit Sunil Dhamne <amitsd@google.com>, Dragan Simic <dsimic@manjaro.org>,
 Johan Jonker <jbx6244@gmail.com>, Diederik de Haas <didi.debian@cknow.org>,
 Peter Robinson <pbrobinson@gmail.com>, linux-usb@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org
References: <20251023033009.90-1-kernel@airkyi.com>
 <20251023033009.90-3-kernel@airkyi.com> <aPnrKFWTvpuRTyhI@kuha.fi.intel.com>
 <14b8ac71-489b-4192-92d6-5f228ff3881d@rock-chips.com>
 <aPoZhBdc1M6Qgfae@kuha.fi.intel.com>
 <6f769567-b383-4c79-b441-3dd84f21cdae@rock-chips.com>
 <aPsse5qVL84XOj8w@kuha.fi.intel.com>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <aPsse5qVL84XOj8w@kuha.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a1547081303abkunmae71b56b2f4984
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQh9PTFYYHU8YGkNDQx0ZTx9WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEtNQk
	tVSktLVUpCWQY+
DKIM-Signature: a=rsa-sha256;
	b=cbh7z5oMnHR/DLqyOIDZk4K7gXmeu0Z/ewCxVZLD2lfh51kbnP5gwdZNZ7a3inVN4NoC/E/hL4XmvOdj5FQ0/XmmJ78CkfSevEhzvOTjQ9VpmomjoQ1rpjyzol1iXhudUcEI++95744VHFl5SRJlcN0jA2NbRp7MwZ9xcoa3t1g=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=k9PZlmFs4+G6V09YuUs38/TEsI+fOADgB825HrzHznU=;
	h=date:mime-version:subject:message-id:from;

On 10/24/2025 3:36 PM, Heikki Krogerus wrote:

>> Another thing is that CONFIG_DRM_AUX_HPD_BRIDGE originally needed to be
>> selected by other modules. With this change, we also need to expose it in
>> Kconfig.
> Sorry, I don't understand the problem here? What do you need to expose
> in Kconfig?

config DRM_AUX_HPD_BRIDGE
     tristate
     depends on DRM_BRIDGE && OF
     select AUXILIARY_BUS
     help
       Simple bridge that terminates the bridge chain and provides HPD
       support.

The tristate here is empty, so now it can only be selected by some TypeC controller drivers. I think it's not a big deal, just expose this item.


>
> thanks,
>
-- 
Best,
Chaoyi


