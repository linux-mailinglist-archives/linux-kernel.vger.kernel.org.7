Return-Path: <linux-kernel+bounces-742376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B13B0F0E5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 13:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38FE0189087E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 11:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D79222564;
	Wed, 23 Jul 2025 11:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Ri+ecnKq"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB4A6F06B
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 11:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753269023; cv=none; b=QXy6PmFPVqQq07dIdfl/ABzVNpwNB9rnwqcIbRP9fq36PJ6MvGZpSlTT3HW/i0kcS9yggFVTh8L4CFQZJ3nRBopqbTo8qv135vDecTIRA9VvwDA6BhAv2DOY96ZEsiHOv39WYR872LN2+EaMh92uIetEZkPP6en5kH9stQ/EOiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753269023; c=relaxed/simple;
	bh=+PsIDRh39+QLU7O4We0suOk5TY87ALaXw+iWI70Jd04=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WzqyDY/IqCm4ltJtODQzOr5goWAUHH4i4p6lcMph8ruUuhfdP8myJ5WYd+TfJUrIjKCtrpSHz5mWLpaMHiVQxBsKkrUh9xBAuUBcvZSG6c31R1zk4Edeu+cTyGOiRYpJ3XXUYlpZXmYCzCcCdu2AWMWAzxxJgs7yUGAMv/cWSQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Ri+ecnKq; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4BF6F41C84;
	Wed, 23 Jul 2025 11:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1753269014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jEJXTViUpwJmM1PZQ4s5GJCfEWzwic955fqQl2UwH2Y=;
	b=Ri+ecnKq2DYLUj8KACW+RfVmXvXtr5s4EL4hPM5F3FAZm5N6cXrkR7xTphb29dqoVLNH7M
	F3uGD1otPxX5lJ1yB9HNKWuLJ5GQQTYscGf69OAQgI4zfWavFEO7EprayVJUFoBKdMdu/E
	wcrrIxfOGC1Emtmq/ZLK0vY9UAKRzrOkx6GSy3SZK5rTJuQGPYDjvMGaV7dgX9vDNo3vhA
	0rJRv+nCAfEca1UzSlbtlQsZzQPDDumS/j3mAn77PJSnP3yAETqKSi/VN5wDUtDPwdrF9X
	40INrZClD3YDKuXvWaUIhEurA8qOZrHcgg74mQPjef9pXXYFYztZ6lijYKPRmA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250709-drm-bridge-alloc-getput-drm_bridge_get_prev_bridge-v1-0-34ba6f395aaa@bootlin.com>
References: <20250709-drm-bridge-alloc-getput-drm_bridge_get_prev_bridge-v1-0-34ba6f395aaa@bootlin.com>
Subject: Re: [PATCH 0/3] drm/bridge: get/put the bridge returned by
 drm_bridge_get_prev_bridge()
Message-Id: <175326901209.1518728.9011986165395959669.b4-ty@bootlin.com>
Date: Wed, 23 Jul 2025 13:10:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejjeeivdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvegjfhfukfffgggtgffosehtkeertdertdejnecuhfhrohhmpefnuhgtrgcuvegvrhgvshholhhiuceolhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepledtveevveduvedvteefhffgiefhfeefleffvdfgffefheeuueeihffhtdeuteehnecukfhppedvrgdtvdemieejtdemvddtvddtmegvrgdtudemsggvgedumeelhegvjeemfeegfeemledufegvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegsvgegudemleehvgejmeefgeefmeeludefvgdphhgvlhhopegludelvddrudeikedrudejkedrjeehngdpmhgrihhlfhhrohhmpehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduiedprhgtphhtthhopefnrghurhgvnhhtrdhpihhntghhrghrthesihguvggrshhonhgsohgrrhgurdgtohhmpdhrtghpthhtoheprghirhhlihgvugesghhmrghilhdrtghomhdprhgtphhtthhopehsihhmohhnrgesfhhffihllhdrtghhpdhrtghpthhto
 hepjhgvrhhnvghjrdhskhhrrggsvggtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjfhuihdrrfhusehgvghhvggrlhhthhgtrghrvgdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurhhiqdguvghvvghlsehlihhsthhsrdhfrhgvvgguvghskhhtohhprdhorhhgpdhrtghpthhtohepjhhonhgrsheskhifihgsohhordhsvg
X-GND-Sasl: luca.ceresoli@bootlin.com


On Wed, 09 Jul 2025 17:59:36 +0200, Luca Ceresoli wrote:
> This series adds drm_bridge_get/put() calls for DRM bridges returned by
> drm_bridge_get_prev_bridge().
> 
> This is part of the work towards removal of bridges from a still existing
> DRM pipeline without use-after-free. The grand plan was discussed in [1].
> Here's the work breakdown (➜ marks the current series):
> 
> [...]

Applied, thanks!

[1/3] drm/bridge: get the bridge returned by drm_bridge_get_prev_bridge()
      commit: 9b75346e3c2b8ecb5b90b132c2fc185ddd30ecf3
[2/3] drm/bridge: select_bus_fmt_recursive(): put the bridge obtained by drm_bridge_get_prev_bridge()
      commit: d4eecb4c24dc160f4a003c804602c746fb8fec58
[3/3] drm/bridge: display-connector: put the bridge obtained by drm_bridge_get_prev_bridge()
      commit: c571cb70e1ed43ee543c70151e61a001ab2eefa2

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


