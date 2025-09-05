Return-Path: <linux-kernel+bounces-803036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B543B459B9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 587DB7BD82A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 13:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8844F35E4EF;
	Fri,  5 Sep 2025 13:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NWVuXeMQ"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BD635E4EB
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 13:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757080504; cv=none; b=Bwq4xSlggyIeiwWaWH7e1sCU5I2WFHOU6TuFEbPFGGAv1RSIoBrw3AJ+gFAsFmf4iB+tXpiaebdv2MSb5EO8P3XzZs7Ejw5r0OXVgTvYzcGkH4NOE4fXKWtg8/eJWmIhQ7EEcj67A+3yClrtYuRVBrVZlVDs4JlRaT2IbUP3zhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757080504; c=relaxed/simple;
	bh=UCiGATb/qHq9xnqHinm4V+YkHiCr4MxapKsdsK8p3/M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nojwOXZmRvQ2SyGoJ34WJNChjWG5FoZfXf7zeKcnYI5BGeWAU6ql7b6r58+qWSXFbyPm0fbjcyjPvfsm6bp4Pv6XyMHu4OTJVUqBWmYDvIo2BKRxyCvLjo6LL1ikeDrmcYDWDjl9HyZjDA2DvvR5FbT7tT648pI12dE+adMeObM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NWVuXeMQ; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id A97BD1A0DD7;
	Fri,  5 Sep 2025 13:54:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7F8E56060B;
	Fri,  5 Sep 2025 13:54:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 603E7102F27F9;
	Fri,  5 Sep 2025 15:54:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757080498; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=wXuDvE2U7zArCNiE29U7rGYQ6gNdC7m1Plskv1PwsfQ=;
	b=NWVuXeMQs40iG/K4xjae3frw9k+oo7GG4MkGDvrQaYSWA2HZsBGfgpCmlLE8+sJ76pBcb9
	AfkX2KpluWe1Swv+rn3dFYmoRrK3MYGznIxlAVhUBSL9Xz5lH1qDMdT1ECWe8YS9dP22Dl
	57ssoT1BiGT3s5A0gCd6hpm5HKUVK18DkNA/g3mJ+HOqilN7Vu2aN280IIMCNLuuOJ/jEj
	iy3Z/d8fBf0tQhAqzpMjXuQIJxIADAJsQkvNm7gNVKlxuvk8aWQHX3ifL+SZal3Fkf8a0Z
	v3ey4D0uKndOz5kgGQFMdK34MSjVuiX+BZChzKhinyLAwjQuVjRpyRFLJFPwsw==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Chaoyi Chen <chaoyi.chen@rock-chips.com>, Hui Pu <Hui.Pu@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev
In-Reply-To: <20250808-drm-bridge-alloc-getput-for_each_bridge-v2-0-edb6ee81edf1@bootlin.com>
References: <20250808-drm-bridge-alloc-getput-for_each_bridge-v2-0-edb6ee81edf1@bootlin.com>
Subject: Re: (subset) [PATCH v2 0/9] drm/bridge: get/put the bridge when
 looping over the encoder chain
Message-Id: <175708046120.649333.5235747071021830726.b4-ty@bootlin.com>
Date: Fri, 05 Sep 2025 15:54:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3


On Fri, 08 Aug 2025 16:49:07 +0200, Luca Ceresoli wrote:
> This series adds drm_bridge_get/put() calls for DRM bridges used when
> looping over bridges in an encoder chain.
> 
> This is part of the work towards removal of bridges from a still existing
> DRM pipeline without use-after-free. The grand plan was discussed in [1].
> Here's the work breakdown (➜ marks the current series):
> 
> [...]

Applied, thanks!

[2/9] drm/display: bridge-connector: remove unused variable assignment
      commit: 9e05c8dc4e8bb14bdb86eccff1d07169cfd69df8

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


