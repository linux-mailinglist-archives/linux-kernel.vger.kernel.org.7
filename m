Return-Path: <linux-kernel+bounces-857530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B5CBE7067
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 09:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D64AC5E23A2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 07:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCE8262FC2;
	Fri, 17 Oct 2025 07:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=murena.io header.i=@murena.io header.b="Bwe+9Ccy"
Received: from mail3.ecloud.global (mail3.ecloud.global [135.181.139.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0780F25A324;
	Fri, 17 Oct 2025 07:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=135.181.139.185
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760687916; cv=pass; b=CKC3AqXwqdXvuBPXaxNQ26qPGofGwR8Et1CE2Y3ezYvB89IXFxqQxquueMzGQyKXWLXFTvDWmOuM+5gPZWhPlQeFTRJO/e6jR2qPghXVT057NbG1xxOgnCi+NIHdvw5gHw/AR2LevNvmHKy1FJZmsjt5QGYHJyErbbZ/3XNRk2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760687916; c=relaxed/simple;
	bh=jkVEXnzGazlr4jffF/xWHkM2GQunmNsO0Rm623Owskc=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=RUiDpVzGpf2lCa+O2zORfwcOVjtSQkmKK53fF4Qq04dBWvbwgTbP0I6togsjf+BCO5sQ1xm2tbCht4DNg6NfNepNUx5XKgSluAOScjki++0RUTpS0ulsRjT6kR4NiAKFfHbkb539BNLxXDEuHu1/U4ZA5oO95RnafXmYfG3q9Yw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=murena.io; spf=pass smtp.mailfrom=murena.io; dkim=pass (1024-bit key) header.d=murena.io header.i=@murena.io header.b=Bwe+9Ccy; arc=pass smtp.client-ip=135.181.139.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=murena.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=murena.io
Received: from authenticated-user (mail3.ecloud.global [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail3.ecloud.global (Postfix) with ESMTPSA id AEBAD8844C7;
	Fri, 17 Oct 2025 07:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=murena.io; s=mail3;
	t=1760687904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5+N/g+Cv9kWgSOuIgoyJn0tjR7NN022I4B62iu5cZoI=;
	b=Bwe+9CcyUwQRoVsGFfIVFX7RAtwlIiFEUdlhv3ANwuLFytOkKmG5tMD3H6j/XdnEZGik/z
	L0h0EfmDWuHP/7ytSuLPFEmLJ9P6vVpjHa0TaDtq0Kpmys0p9oR2p0SHL+/9++d5c0P+Bs
	xTonHHy3cApXXPbD6tCP/sUxOQR4Q0g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=murena.io;
	s=mail3; t=1760687904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5+N/g+Cv9kWgSOuIgoyJn0tjR7NN022I4B62iu5cZoI=;
	b=h7XC6EJLNOSr2xCjrKKvzFpTGgC37z8vwGGUEz/yDpwgEM1EFv9ihoX3mWMEs1aZkf1kCW
	R0/HMKBPOAB88wj5s+pWSl9MJOGGWxCIgq/E0UUExaxLNmyFtIqGxTxHrf1GT0EaXhyeBJ
	g6KWr2MOYwx31wQ3kzXnhqg6IeYx7yU=
ARC-Authentication-Results: i=1;
	mail3.ecloud.global;
	auth=pass smtp.mailfrom=maud_spierings@murena.io
ARC-Seal: i=1; s=mail3; d=murena.io; t=1760687904; a=rsa-sha256; cv=none;
	b=0j0ePx5LqN5bNtXIaCR6iUppWGVksPuWjcEHiLwqt4vi9w6bXwRmsly/cu1e1ko/x/TcZ1
	rYi2dNWvWgPA6dPOrjf4/OPq/tmcAMEzh45RF3rfArefZ4yrUBvzmxJVntRIKbNGMQ4Cum
	jWmVbmTk3idqcDHnOavdiktfS2fua0Q=
Message-ID: <040d8fe8-da2f-4aa5-a2c3-1aec0cf2e8f0@murena.io>
Date: Fri, 17 Oct 2025 09:58:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: andyshrk@163.com
Cc: Laurent.pinchart@ideasonboard.com, andrzej.hajda@intel.com,
 andy.yan@rock-chips.com, devicetree@vger.kernel.org,
 dmitry.baryshkov@oss.qualcomm.com, dri-devel@lists.freedesktop.org,
 heiko@sntech.de, jernej.skrabec@gmail.com, jonas@kwiboo.se,
 knaerzche@gmail.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 neil.armstrong@linaro.org, rfoss@kernel.org, simona@ffwll.ch,
 tzimmermann@suse.de
References: <20251016083843.76675-3-andyshrk@163.com>
Subject: Re: [PATCH v8 2/2] MAINTAINERS: Add entry for Innosilicon hdmi bridge
 library
Content-Language: en-US
From: Maud Spierings <maud_spierings@murena.io>
In-Reply-To: <20251016083843.76675-3-andyshrk@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andy,

> From: Andy Yan <andy.yan@rock-chips.com>
> 
> Add entry for Innosilicon hdmi bridge library
> 
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> ---
> 
> (no changes since v1)
> 
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f9f985c7d7479..0adcfb1c264a1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12299,6 +12299,14 @@ M:	Samuel Holland <samuel@sholland.org>
>  S:	Maintained
>  F:	drivers/power/supply/ip5xxx_power.c
>  
> +INNOSILICON HDMI BRIDGE DRIVER
> +M:	Andy Yan <andy.yan@rock-chips.com>
> +L:	dri-devel@lists.freedesktop.org
> +S:	Maintained
> +T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
> +F:	drivers/gpu/drm/bridge/inno-hdmi.c
> +F:	include/drm/bridge/inno_hdmi.h
> +
>  INOTIFY
>  M:	Jan Kara <jack@suse.cz>
>  R:	Amir Goldstein <amir73il@gmail.com>
> -- 
> 2.43.0

I believe this patch should be squashed into the patch that actually 
creates the files listed in the MAINTAINERS entry, like I do here [1]. 
Checkpatch should be complaining about patch [1/2] if I'm not mistaken, 
when you run `b4 prep --check`.

Link: 
https://lore.kernel.org/all/20251009-max25014-v4-1-6adb2a0aa35f@gocontroll.com/ 
[1]

Kind regards,
Maud

