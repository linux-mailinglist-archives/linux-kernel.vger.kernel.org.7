Return-Path: <linux-kernel+bounces-882850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFB1C2BAE4
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 13:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 347934F5425
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 12:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B371830BB97;
	Mon,  3 Nov 2025 12:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="X2qSiPXq"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298B0301491
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 12:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762172654; cv=none; b=bZtPW9ErKBliI+c54wZua9UX21BMeCFASbjSP+WBiux+ioZgT+R1rBr4mVMhRxkpDUkCPbl3ZkupchHiaRtwpQDgMOcCFF6hrqfaGZ2U0kjAfDRjqtj6VKsjYgXawNYK0n4KNQ/ZaLBXXO4O73XhAdHtt0d7rqj1Viyq0Bszq2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762172654; c=relaxed/simple;
	bh=Gf3of/ZdbLGHwxzDCrnaWnMFmUY0xc+brt5rcOyzdFc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tB54ZbRtRxoYxhlJYY/arzLaG36TPraS75zGdnAL3LNFtt4/byCA+AxOXsQjvW6m1rKgSgEgHqdb9a7qNfFFYi8ttzN4radeTz54qHg5DN6nLy0zRvaxQwadRz1r0PdmXuYsyot0+BOSK1BX328CAOAJWnhRNDG+vzAfr2A3Eok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=X2qSiPXq; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 52CAD4E414CC;
	Mon,  3 Nov 2025 12:24:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 23AA060628;
	Mon,  3 Nov 2025 12:24:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B75D210B5003D;
	Mon,  3 Nov 2025 13:23:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762172646; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=jWIBKsXwl+lZlSI+m4JdF3FwkWNJycGm6EYh0H2B5I8=;
	b=X2qSiPXqpWSRnWH7izdKgmYPC9Cuxd5s4IeCuS7c4pB77qAbaYcbs3Dpo5k798ISZlkTLJ
	oUV4VlczKvQa5z6ElJkUxJTEE8dyfrGmsvYUOVZ/tgXzBWWL68R4MzBBLeT1nMxFtaD0BL
	ojW9ItGFvw+TJvHqEm/+b6zWWTC1yJV7VoX/RaVHxuh/Y7CJQpuWCjab0bv6ldd244bL9F
	+YwMYra6bQBYWDoRZHy0GhNUqjcgZwvddEfNHSnmq5Ke2A8LS7aayI5c7WU/CRpm65aqlF
	Wzcw2kBn55yIc3y6o4XVWUylDccNGD8HjvQL0ushUpY2W+n3IDMseSE6Las6ow==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Alain Volmat <alain.volmat@foss.st.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Raphael Gallais-Pou <rgallaispou@gmail.com>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251028-b4-drm-bridge-alloc-add-before-attach-v3-0-bb8611acbbfb@bootlin.com>
References: <20251028-b4-drm-bridge-alloc-add-before-attach-v3-0-bb8611acbbfb@bootlin.com>
Subject: Re: [PATCH v3 0/6] drm/bridge: enforce drm_bridge_add() before
 drm_bridge_attach()
Message-Id: <176217263847.134567.5881036101864864671.b4-ty@bootlin.com>
Date: Mon, 03 Nov 2025 13:23:58 +0100
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


On Tue, 28 Oct 2025 11:15:41 +0100, Luca Ceresoli wrote:
> This small series enforces that DRM bridges must be added before they are
> attached as discussed in [1].
> 
> This is part of the work towards removal of bridges from a still existing
> DRM pipeline without use-after-free. The grand plan was discussed in [0].
> Here's the work breakdown (➜ marks the current series):
> 
> [...]

Applied, thanks!

[1/6] drm/sti: hda: add bridge before attaching
      commit: d28726efc637c5e76e23156b0c2418d37ef45b8e
[2/6] drm/sti: hdmi: add bridge before attaching
      commit: ebad7a8f3db6c43c29dacbccb1d7615563f4e80a
[3/6] drm/bridge: document that adding a bridge is mandatory before attach
      commit: f8b460262a28060be932078e2b8d9fb8bf99dcf6
[4/6] drm/bridge: add warning for bridges attached without being added
      commit: 76f1a9711b837f90fba91d00e33549ed1364bea2
[5/6] drm/bridge: add warning for bridges using neither devm_drm_bridge_alloc() nor drm_bridge_add()
      commit: 9347f2fbb0183b04070cd7dfde080bfcc54c0f7c
[6/6] drm/bridge: synopsys: dw-dp: add bridge before attaching
      commit: b726970486d81ed3eea09cf9f80f39fe1928a741

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


