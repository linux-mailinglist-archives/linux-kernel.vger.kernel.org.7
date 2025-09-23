Return-Path: <linux-kernel+bounces-829637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A94B9782F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 22:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEE3B321418
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 20:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B22309F12;
	Tue, 23 Sep 2025 20:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mdkHlAIj"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671223FB31
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 20:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758660022; cv=none; b=LH0XQNJ9MbDFaVPmyXrsdHjMlJY1y6Iihvq2KPnIhJzLfYyI4u9eg9365m3yCwAlH69UT4xhO+jKFOmMalYcqlcqP8cnDu4liuNucsOMUxWnPxcKh+jIsSTBrDXxQ7jecsN6l+ZgNPlNe+4PcHcNhdarlS4ake9YBAJWGKxbK1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758660022; c=relaxed/simple;
	bh=3ZRv4fpYH8VhhjFaU0Pyw7JlprjBgX364strOthES/Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qoIc8Tm6imNAt84XuuJtlY9BhPs1ynUj3EJJ9giaTJOhNNimyuwzlb8vXOhlfBGv4Q6O2P/mNGXi1HyMqup1xonCWHrrO7IkV2RrxVwtYb2qB3wb2VtRjL9LMwPt5uNikaqRTHJfyE4amqHL4uhd4Ng4mK3EIYbjGEXKVstbkUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mdkHlAIj; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 91F1F4E40CB9;
	Tue, 23 Sep 2025 20:40:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4D87260690;
	Tue, 23 Sep 2025 20:40:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8B5E8102F18CD;
	Tue, 23 Sep 2025 22:39:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758660015; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=qeyUwc/beOs4EzAIFpBkfpET30cy18dsLsFqrVOyb6s=;
	b=mdkHlAIj2Gkm6+cx0OP7HbjeimBPfrpI0jEeBWvda719ObioAUGUentg+v0Inwa200ckRo
	niILT7wj3Ys/14+wjf+9t+LfjFnucbGVM26hkomz+aOhcfPc0jm1wtxbidjHn3ArsaNGL0
	xSYmtWu/u3CbgzKnFvEGNxxhZjwaueLRLlh0tr4T0ZMT/fcuGHjljm/M9VuzTN0VrMwN6J
	uiSEkOZPISB8Xl+q33HPZzhh7Ab9DS+RUEiHIY9sg33tMoub6Z9168RC4t3GwVjlaC1oQE
	of1HdqOUM9jIsbHLOPoP2alwxTrtNXQQLfrI0+gAeAjK9s8GD7EFoGceqhENAw==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <lumag@kernel.org>
In-Reply-To: <20250915-drm-bridge-debugfs-removed-v9-0-6e5c0aff5de9@bootlin.com>
References: <20250915-drm-bridge-debugfs-removed-v9-0-6e5c0aff5de9@bootlin.com>
Subject: Re: [PATCH v9 0/3] drm/bridge: debugfs: show refcount and list
 removed bridges
Message-Id: <175865999985.903984.7339834418819121005.b4-ty@bootlin.com>
Date: Tue, 23 Sep 2025 22:39:59 +0200
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


On Mon, 15 Sep 2025 12:12:45 +0200, Luca Ceresoli wrote:
> This series shows removed bridges to the global <debugfs>/dri/bridges file.
> Removed bridges are bridges after drm_bridges_remove() but before they are
> eventually freed on the last drm_bridge_put().
> 
> This is part of the work towards removal of bridges from a still existing
> DRM pipeline without use-after-free. The grand plan was discussed in [1].
> Here's the work breakdown (➜ marks the current series):
> 
> [...]

Applied, thanks!

[1/3] drm/bridge: add list of removed refcounted bridges
      commit: 17805a15d1751f5d6bb06f924f9bed216feb8db7
[2/3] drm/debugfs: show lingering bridges
      commit: 27312a8f24419b5fe544e30f75d692492790304c
[3/3] drm/bridge: adapt drm_bridge_add/remove() docs, mention the lingering list
      commit: 90315cd293f321ada7bbd43a59636716e102d68a

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


