Return-Path: <linux-kernel+bounces-882805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE30C2B8C6
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 12:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5FC93A49FE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 11:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001F1306B06;
	Mon,  3 Nov 2025 11:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FbvePhAA"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCF8306B02
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 11:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762170752; cv=none; b=I23DB91qNAzfNsVLgWPAdFJanrrzOLKRdnVo26qKd0iZtxYcQ7cJdisf88v9OY3za9iU9G68GG3LTyUc6yU3Crz58SZLwuS9EF88jdlWSPQYkdofnqR1ttWMseu0cBdiO07yoZLsTEGh1TQvyLXOOzmn+Ni+EuLDXhvWv2jEE+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762170752; c=relaxed/simple;
	bh=RPb/+8qLb7/0J9oKNYmFzQfLzRyJLF4cr7ZNuVBPCVI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nnBwgbC5rd0bL2c16S16B6ATQfwsR0C0GjFmYSNzDjtq4EKUQonRPrLv2HxiubcUlUTjFCbOX3iCWNAkcwUUDlxDMtlqOtC4VDPgFu89G3vHFpcgSx+d93lYqvVWlAVVCu8b71Cl+zBaAetr8jaxBoSQiuvkjfxhZI5TL7e0C6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FbvePhAA; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 751B64E414BA;
	Mon,  3 Nov 2025 11:52:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 49AB260628;
	Mon,  3 Nov 2025 11:52:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F0E6410B5005F;
	Mon,  3 Nov 2025 12:52:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762170746; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=nxLsgXaX3S7Wf96NrKXVV0SE7yKYs5dnel8d4jei4WI=;
	b=FbvePhAAaYxdeRQVSnYhE7UWK6DoHCvGymwxDkiWTU0lpiuIg60oBggkuzXgey7qynUvxV
	RVVN7od4+LESxZ02FMEkv24OswzAkrfIL4PAsYgUoQdeWsc0Fcxrz/ekicDsUpquTUzoCs
	TlIbS1pTmMSvdZ7PyQdGtnwVNqGPxvMUf+VIUgjJcbLLay9pteEAiA1gliQU7IrRAz0tiO
	AGp4tX/2t+7JfAz2TFqtQy1I+MQGGOh+Ofm3rTjiI/82hBTvajaxhet3JAHMoDWPdIeaX9
	jSP8Lz2hG5JhyuWRuU64gFZU8L1ikExIWOfYbOff83S6r+4rMYh0ygX48w3Ybw==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>, 
 Naresh Kamboju <naresh.kamboju@linaro.org>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251017-drm-bridge-alloc-getput-bridge-connector-fix-hdmi_cec-v2-0-667abf6d47c0@bootlin.com>
References: <20251017-drm-bridge-alloc-getput-bridge-connector-fix-hdmi_cec-v2-0-667abf6d47c0@bootlin.com>
Subject: Re: [PATCH v2 0/3] drm/display: bridge_connector: get/put the
 stored bridges: fix NULL pointer regression
Message-Id: <176217074003.78559.5719838860402143983.b4-ty@bootlin.com>
Date: Mon, 03 Nov 2025 12:52:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3


On Fri, 17 Oct 2025 18:15:03 +0200, Luca Ceresoli wrote:
> A patch of mine recently merged in drm-misc-next [1] has a NULL pointer
> deref regression (reported here [2] and here [3]). Being in lack of a quick
> fix, I sent a revert proposal [4].
> 
> The revert proposal has no answers currenty, and in the meanwhile I have a
> patch that implements the original idea but without the same bug. So here's
> a v2 series with:
> 
> [...]

Applied, thanks!

[1/3] Revert "drm/display: bridge_connector: get/put the stored bridges"
      commit: b4027536933f813e51cc53be0b7542012f09aa38
[2/3] drm/display: bridge_connector: get/put the stored bridges
      commit: 13adb8c97846603efc7bfc7663dfdc0ba2f34b8f
[3/3] drm/display: bridge_connector: get/put the panel_bridge
      commit: a3f433c57c46776f95fdf4cfaad1ab27dbca7311

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


