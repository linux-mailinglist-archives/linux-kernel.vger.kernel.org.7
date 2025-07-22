Return-Path: <linux-kernel+bounces-740741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3624B0D87C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 13:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF40618912B5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 11:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B1723A98E;
	Tue, 22 Jul 2025 11:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="o57jEKFi"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F5028A1D5
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 11:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753184593; cv=none; b=VUzIEjNR/61cXVOQXE9mxx5XNNNw4LQd6JPQlmL7TZ0HRZxFSWgUBoBq9RowraOuGMLFggdvyuCiHNlq4wN+9I/DKU7dtz+MOO3I5Cs8esHINVOg2a6YG2r0UFGERF7VPBr24oK7QF8TLjjzaCPLNNHdyiT9kTHymuAe+hDZEaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753184593; c=relaxed/simple;
	bh=KqvDSVFm/oQcfrKYyGZDGrV8pbcJ2Diaz+9Wztdpbog=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=vFI4LPOs89B3rTSMO8HOexYb63uPa58hZU+gwfd3SzcN0aRGtyV+ZZ3mvbwFs9nZhq7kyTreg9Omd30YQRyTwiPQZIv+q1iWdxeDEshSsXes1S+yoiXWhJqxSzIlbxuRk4QUNdg2QpFH3SsGKlPyK+vuNE6j0ERMcreiFoHXCm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=o57jEKFi; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0966B4335F;
	Tue, 22 Jul 2025 11:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1753184589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RZx9garggCkb/4fuz/ISY5Yhx3oRGz6TSqSU+AFBcZU=;
	b=o57jEKFip4Jeg9G/3rSSRHrZofXaKJDGzZgxI4eo/G3/sRveZrZVnH+waD48AVLCbX2N0f
	QDpYcFz2bQjx3JoteaZ64aFKBbPo35o18pyM14oPipRgqeWjqhzhE/wS2urMt85UOIS79l
	FR9iFtECxSWcaZ5QtpCXRnE4NtGpadgjNWW1JMJFm8U3lkoMDBgiVk+PRXWRFqWEaJddnf
	f56ebPIf3mg9Eudu2gEZQvk+tWUjN4aarg4KqM5LMV81EELb1n9kedmjxjMEVkVfHFID0p
	IZG6R4Qo87q+1Rj9YbXlxv4WDExhX1Qvzwqm3yGCjbYpwFznMyd6UHqfd+FAJQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Liu Ying <victor.liu@nxp.com>, Hui Pu <Hui.Pu@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20250708-drm-bridge-alloc-getput-drm_bridge_chain_get_first_bridge-v9-0-db1ba3df7f58@bootlin.com>
References: <20250708-drm-bridge-alloc-getput-drm_bridge_chain_get_first_bridge-v9-0-db1ba3df7f58@bootlin.com>
Subject: Re: [PATCH v9 0/5] drm/bridge: get/put the bridge returned by
 drm_bridge_chain_get_first_bridge()
Message-Id: <175318458693.1221782.3691939996156823166.b4-ty@bootlin.com>
Date: Tue, 22 Jul 2025 13:43:06 +0200
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejgeekudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvegjfhfukfffgggtgffosehtkeertdertdejnecuhfhrohhmpefnuhgtrgcuvegvrhgvshholhhiuceolhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepledtveevveduvedvteefhffgiefhfeefleffvdfgffefheeuueeihffhtdeuteehnecukfhppedvrgdtvdemieejtdemvddtvddtmegvrgdtudemsggvgedumeelhegvjeemfeegfeemledufegvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegsvgegudemleehvgejmeefgeefmeeludefvgdphhgvlhhopegludelvddrudeikedrudejkedrjeehngdpmhgrihhlfhhrohhmpehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvhedprhgtphhtthhopehfvghsthgvvhgrmhesghhmrghilhdrtghomhdprhgtphhtthhopefnrghurhgvnhhtrdhpihhntghhrghrthesihguvggrshhonhgsohgrrhgurdgtohhmpdhrtghpthhtohepjfhuihdrrfhusehgvghhvggrlhhthhgtrghrvgdrt
 ghomhdprhgtphhtthhopehjohhnrghssehkfihisghoohdrshgvpdhrtghpthhtoheprghirhhlihgvugesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdgrrhhmqdhkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopehnvghilhdrrghrmhhsthhrohhngheslhhinhgrrhhordhorhhg
X-GND-Sasl: luca.ceresoli@bootlin.com


On Tue, 08 Jul 2025 17:48:17 +0200, Luca Ceresoli wrote:
> This series adds drm_bridge_get/put() calls for DRM bridges returned by
> drm_bridge_chain_get_first_bridge().
> 
> All patches are Reviewed-by Maxime except patch 3.
> 
> This is part of the work towards removal of bridges from a still existing
> DRM pipeline without use-after-free. The grand plan was discussed in [1].
> Here's the work breakdown (➜ marks the current series):
> 
> [...]

Applied, thanks!

[1/5] drm/bridge: add a cleanup action for scope-based drm_bridge_put() invocation
      commit: 4d2d28776ae3ad7aa95328d28aff220b0ec6202d
[2/5] drm/bridge: get the bridge returned by drm_bridge_chain_get_first_bridge()
      commit: 8fa5909400f377351836419223c33f1131f0f7d3
[3/5] drm/mxsfb: put the bridge returned by drm_bridge_chain_get_first_bridge()
      commit: a73ddcba33ed8fe8f2bd5be4de88125b06df96b4
[4/5] drm/atomic-helper: put the bridge returned by drm_bridge_chain_get_first_bridge()
      commit: c26c844390e1384c49dd9a395c3bab268dcb5bea
[5/5] drm/probe-helper: put the bridge returned by drm_bridge_chain_get_first_bridge()
      commit: 956f82e529dd283382f080273ed3b8db1e978699

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


