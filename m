Return-Path: <linux-kernel+bounces-831496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A57B1B9CD3A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 02:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E0853B3723
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 00:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E594E72639;
	Thu, 25 Sep 2025 00:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="rl5MdRO4"
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1DC189
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758759352; cv=none; b=OPSpPz6sU7fWwhfMlLoE68qhQ0d+kTSduckZqDqzAuLG8QzvKyae+r6lgNHPFnzmMbwoSbhGtLkGsfWlJkqZNymo23IE8QfuidDeefb0URurkzPL1BNA9hQB1H2qt+DPRa3p5YZ3hj90O9HGynbKGa/2hc5bcJXA1gCk3XZWEt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758759352; c=relaxed/simple;
	bh=dT04tKkxXqfM/jbVnRQes+SiBhpZ7W17hcuTYujfUPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PYnVUuMW7xHUeI3kTgFWy6W64/RjM7tK5yhunKCat6By/XsYkbSk26qMQCouFwxKhmimxqNTVSSn6dI7/jhJ2T6EVPjEbV48GdJUmzElH40Oe1xH7iPSK+rAhMEvZYrjhDnQQEnoMjFFZPIODWcOxHjmlHGRj3tNcMpCwqZ2v90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=rl5MdRO4; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4cXDl53gZvz9tfZ;
	Thu, 25 Sep 2025 02:15:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1758759345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bTtDLT8H2plsrrvyz4ktwDsg5w24dGcjLmDpwykIzss=;
	b=rl5MdRO4kh7Cu1/5cEAoVYY6++WFy7gocUO6QYAvoShlRgs3056mqhgjfayP+2PcjyWXtO
	d9JHB2InCx9/0ATXWHcD0hlhqVegLCwZUen6+SLgp40Ba+N3Ixkq2X56oVfXPPiK6OzeRt
	gDwhClZYD1hJACc3DKyuCXgsg2wT3b4o7XjSw69BZfyR+AKY+48NYMIlKTlDrlG+LK3AsB
	4WAWFFpSaK7+X03Pv35KXE4kNHBtBp2pfSD9loNaqIYHpoAnA1G/BjzXScHK5lUuqWqOE3
	049qYq+Wjjsxcu3r2ISTvAYVHVal79U4jCN5XCR7XhAjJ8vOxpTnSv3+HxuEMQ==
Message-ID: <6e50e9fb-10f5-48e6-bc04-ec66ca90a626@mailbox.org>
Date: Thu, 25 Sep 2025 02:15:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] drm/panel: sitronix-st7789v: fix sync flags for
 t28cp45tn89
To: Sebastian Reichel <sre@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Michael Riesch <michael.riesch@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com, Sebastian Reichel <sebastian.reichel@collabora.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
References: <20250924-t28cp45tn89-fix-v1-1-8e8f52239c84@collabora.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250924-t28cp45tn89-fix-v1-1-8e8f52239c84@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: wfjs4nj6e736ezfw8su1auuimktxzj6j
X-MBO-RS-ID: 93eb9d9084b88f6345c

On 9/24/25 11:46 PM, Sebastian Reichel wrote:
> From: Sebastian Reichel <sebastian.reichel@collabora.com>
> 
> I planned to set the polarity of horizontal and vertical sync, but
> accidentally described vertical sync twice with different polarity
> instead.
> 
> Note, that there is no functional change, because the driver only
> makes use of DRM_MODE_FLAG_P[HV]SYNC to divert from the default
> active-low polarity.
> 
> Reported-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Closes: https://lore.kernel.org/all/20250923132616.GH20765@pendragon.ideasonboard.com/
> Fixes: a411558cc143 ("drm/panel: sitronix-st7789v: add Inanbo T28CP45TN89 support")
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>   drivers/gpu/drm/panel/panel-sitronix-st7789v.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
> index 04d91929eedda092b966b8cffdef5b267748f190..dedf0a390a88dd45a8179e2d22e872128c87cfda 100644
> --- a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
> +++ b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
> @@ -261,7 +261,7 @@ static const struct drm_display_mode t28cp45tn89_mode = {
>   	.vtotal = 320 + 8 + 4 + 4,
>   	.width_mm = 43,
>   	.height_mm = 57,
> -	.flags = DRM_MODE_FLAG_PVSYNC | DRM_MODE_FLAG_NVSYNC,
> +	.flags = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_PVSYNC,
Is this panel somehow special with its NHSYNC / PVSYNC , compared to the 
other supported panels, which all use PHSYNC / PVSYNC ? I would expect 
all of these DSI TCON to use the same polarity, how come this one needs 
NHSYNC ?

