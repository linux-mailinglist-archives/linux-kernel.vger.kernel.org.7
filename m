Return-Path: <linux-kernel+bounces-757862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46777B1C787
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 16:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D99457220D2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 14:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B464628D85F;
	Wed,  6 Aug 2025 14:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fE3q0a58"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E86328CF74;
	Wed,  6 Aug 2025 14:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754489927; cv=none; b=JdHqf/n9fXHNgzsMM0Jf3nOGGJt1X5O8wWVa8qS3IE+kXROWAD9VRuqS6unoA+Lt2EMCcsqG48UM3UoxedmmsInHrfXc8Lbp9CcnBb4AGlN0OEhvDVaImpih3oaRcrCY+dzwSx/i9z02r/tOWI5GUmr3/ycmpfUL5/hbAYsp4Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754489927; c=relaxed/simple;
	bh=8vn6ZtPjSIpXPuhK4QsSMMCxmuVPfaex9cP9yHV9bVw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WReRKFCxwLxBIeJiEDLJfBASv1T9wD+/OjuZhsDOasAAKg8jb56jLIi4l81kKkXJXLL0KfYMb0cRora9vZzxxymn09RTuBU6tYGu3kuloKXFgeT2NxHzzF07knyeyYRca0ULPRKq4FQFKZhjrOIPwY8/p9vkbnjt4+iTrA6y8w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fE3q0a58; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 578CE43917;
	Wed,  6 Aug 2025 14:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1754489921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HhTJ0ZxeTanB6PYHM6Joeibc8NvywE+k5XoJ2tcNG1w=;
	b=fE3q0a58Z19Ltzn1hzWFA4NISsL97TuQsPc0SsTN0cyBGDhSOz7UX88X9b7At1iy/7NhEr
	Y7CSVXWjxHuiXbRyWWmwRc/XNneO4/r6po2vZCV5WNAqkBnLXT+MEJi/0Fhb9S0DY8GNfu
	QHkkPlEDa2/3qkHoULtuDbEAzVAHQxTHN3VQiAIgUrdwosjexoi2IMXkKyBtjCdzixsp7e
	tzlT/Usa6E9JxIiVP32Q7hY5ofDYw28Exya4YYNJ7Ht40qIxQxR4WcAtD5G4iJ8kNIZGZ+
	nXhTek8+Cm5n7kW4L8nn4+e+Aq/Ob/AYt2y1KXQ30CEheYz7m87TiONBoeXQ9A==
Date: Wed, 6 Aug 2025 16:18:36 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Andrzej Hajda
 <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Laurent Pinchart
 <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Dmitry Baryshkov
 <dmitry.baryshkov@oss.qualcomm.com>, Douglas Anderson
 <dianders@chromium.org>, Damon Ding <damon.ding@rock-chips.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: analogix_dp: Fix a NULL vs IS_ERR() check
 in probe()
Message-ID: <20250806161836.3ca0eef4@booty>
In-Reply-To: <aJNAYCXKTaT1bjyL@stanley.mountain>
References: <aJNAYCXKTaT1bjyL@stanley.mountain>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudekvdejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpefnuhgtrgcuvegvrhgvshholhhiuceolhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnheptdeljeejuddvudetffdtudelfedugfduledtueffuedufefgudegkeegtdeihedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpsghoohhtlhhinhdrtghomhenucfkphepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegsvgegudemleehvgejmeefgeefmeeludefvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtvdemieejtdemvddtvddtmegvrgdtudemsggvgedumeelhegvjeemfeegfeemledufegvpdhhvghlohepsghoohhthidpmhgrihhlfhhrohhmpehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduledprhgtphhtthhopegurghnrdgtrghrphgvnhhtvghrsehlihhnrghrohdrohhrghdprhgtphhtthhopehmrdhsiiihphhrohifshhkihesshgrmhhsuhhnghdrtghomhdprhgtphhtthhopegrn
 hgurhiivghjrdhhrghjuggrsehinhhtvghlrdgtohhmpdhrtghpthhtohepnhgvihhlrdgrrhhmshhtrhhonhhgsehlihhnrghrohdrohhrghdprhgtphhtthhopehrfhhoshhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopefnrghurhgvnhhtrdhpihhntghhrghrthesihguvggrshhonhgsohgrrhgurdgtohhmpdhrtghpthhtohepjhhonhgrsheskhifihgsohhordhsvgdprhgtphhtthhopehjvghrnhgvjhdrshhkrhgrsggvtgesghhmrghilhdrtghomh
X-GND-Sasl: luca.ceresoli@bootlin.com

Hello Dan,

On Wed, 6 Aug 2025 14:45:36 +0300
Dan Carpenter <dan.carpenter@linaro.org> wrote:

> The devm_drm_bridge_alloc() function doesn't return NULL pointers, it
> returns error pointers.  Update the error checking to match.
> 
> Fixes: 48f05c3b4b70 ("drm/bridge: analogix_dp: Use devm_drm_bridge_alloc() API")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Thanks! You fix is correct, but an equivalent patch has been sent a few
hours ago, so I guess that one should be applied:
https://lore.kernel.org/all/20250806095224.527938-1-victor.liu@nxp.com/

Best regards,
Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

