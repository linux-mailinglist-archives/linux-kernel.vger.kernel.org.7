Return-Path: <linux-kernel+bounces-854244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F7EBDDE71
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 12:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 64AD44F3345
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 10:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCEE31B126;
	Wed, 15 Oct 2025 10:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="P8jstF9E"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2352010EE
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 10:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760522592; cv=none; b=UQlUa2yf9dBxuI66UfXp9QJobJQPiFUXkFZf3Lx+i3lFQzF8V8G/fe4Bmi1x3B5mUrqKJsfUQnok70q9W8M4S3qFLIXxau/zI6BKUlVFksN7LEJvCRWlL8fEYqQcGqwzYXqxo5iD+IjWPrderKQ4ZBERiwbsRLaWYJAeEUQFLt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760522592; c=relaxed/simple;
	bh=vIUSMXrHYo6IVAXXMlf2z2QqzqoJqcv9TqtH8rYDitE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YZN253aIxX8JwYMV/cB0bK3cXwcmGUdBMrUyBcElez9lGLRfL4uuuDG1Si8P55RsvLP6uZ1UnfEJtdS1t9DcGT4ysY5SMAZ9+EScN9YdghquW64yT01ozbJPueVET4csVWrOt292Cq9rc7CGRK34IKRBPAnofzNla1J/togroX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=P8jstF9E; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760522588;
	bh=vIUSMXrHYo6IVAXXMlf2z2QqzqoJqcv9TqtH8rYDitE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=P8jstF9EFj1pRwbRbKvsomEZszhzzmqa/emjO22fMo3rkEfP5JsJ5N1N4ZpP/NswI
	 D17peeUodI2Qo1oJinpW1/CbABku69oUBKLoSXrnZBuiwxQ3OOvmM43QD8/UbUNVE9
	 r5/C1Fbytwz4q2HA5fTewQdJW0bvRyHP6kjpElWDxJiDCaUQdf7291XkG1n8rFAomC
	 bkX/PltyOWoolKBd9X2MSes74NZWXhZHwoiXVCb3HCZElbLxtyY2Xx968D9F9Z0NRP
	 99RxlnNhhstChFTilT1r8aC/xw0JRWM2s8Lh81FJgNnZJftCM3AXfhO/rZt2taTSQF
	 bftZTKi8vPQCw==
Received: from [192.168.1.90] (unknown [82.79.138.145])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 93E8E17E00A3;
	Wed, 15 Oct 2025 12:03:07 +0200 (CEST)
Message-ID: <7291eff3-b259-4209-b150-cb220abc01ec@collabora.com>
Date: Wed, 15 Oct 2025 13:03:07 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/bridge: dw-hdmi-qp: Fix spurious IRQ on resume
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, kernel@collabora.com
References: <20251014-rockchip-hdmi-suspend-fix-v1-1-983fcbf44839@collabora.com>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <20251014-rockchip-hdmi-suspend-fix-v1-1-983fcbf44839@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/14/25 7:00 PM, Sebastian Reichel wrote:
> After resume from suspend to RAM, the following splash is generated if
> the HDMI driver is probed (independent of a connected cable):
> 
> [ 1194.484052] irq 80: nobody cared (try booting with the "irqpoll" option)
> [ 1194.484074] CPU: 0 UID: 0 PID: 627 Comm: rtcwake Not tainted 6.17.0-rc7-g96f1a11414b3 #1 PREEMPT
> [ 1194.484082] Hardware name: Rockchip RK3576 EVB V10 Board (DT)
> [ 1194.484085] Call trace:
> [ 1194.484087]  ... (stripped)
> [ 1194.484283] handlers:
> [ 1194.484285] [<00000000bc363dcb>] dw_hdmi_qp_main_hardirq [dw_hdmi_qp]
> [ 1194.484302] Disabling IRQ #80
> 
> Apparently the HDMI IP is losing part of its state while the system
> is suspended and generates spurious interrupts during resume. The
> bug has not yet been noticed, as system suspend does not yet work
> properly on upstream kernel with either the Rockchip RK3588 or RK3576
> platform.
> 
> Fixes: 128a9bf8ace2 ("drm/rockchip: Add basic RK3588 HDMI output support")
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

LGTM, hence

Reviewed-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

