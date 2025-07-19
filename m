Return-Path: <linux-kernel+bounces-737847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C8AB0B133
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 19:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A77363A2DAD
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 17:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2262877F6;
	Sat, 19 Jul 2025 17:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ieGT9pQA"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE7116DEB3
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 17:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752947103; cv=none; b=lJVE5gLuX+QzZY34RgpIW/7V7UWfXXq/zAVnjZpene81pgzx7lYSdXUPVkoVy0D5bXED5gHOBAsF5q5Kp3PYgDQz+/bzBZ+sopGJIeKZzd6IWBrD/bBrvBnbhJfSoR5cDuxHFlxJofcMNMdvBEy/CaOO4W9VQJ/8TdgoetbwUHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752947103; c=relaxed/simple;
	bh=R+GIYRAH1CREc7zBiLxlf83j2WhmBau02uktF3eiEjk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jSDlic46AMN+VTeUay1g1d/G+f7kNR224ZCBdD9Lp7EiEJr3LrTMIGOhJLaLLusdRVOXp47iogS8kUx5VCGx/lQC6ZvNGYVkmLglR3fL2C/8BDQK0J77sDEiUoMAQCqSWv9BSzCU85NHt6fc1gdFKO2bE6yH3SDik0I6p3n1F8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ieGT9pQA; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EC2C444498;
	Sat, 19 Jul 2025 17:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1752947092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PGaqyJxmQKkBI6tYtnykmM5zmB/mUgnPCW/pu5IRJl8=;
	b=ieGT9pQASCQAu0tc3H+Yvt2tT5WC6uOtVA48bH41lPyAx3C3OlJtYT3w6+HmWMglkExYfG
	IQ2Ytz7dcbHIxt/LIjGhWBOav2RMlQbIjQP8cF8jTWu1615O4oX7sGszY8ZTI7mWH+tpg3
	FwFoMAf8LHU6pr9taRo2FsMiIQvL6gMS8hd56b4VKKkGMSoO/reF0XTeXvy1AruveJd+nb
	vMvkYJ9QibdLibD3CNQcdIrvE+wy52oo7lrplH8trquRezKYMVvOIdtWRpy2vEZy7H+sxe
	8LzdCH3NsKCnezj00jH6bW6kGxqEOmWjxEvlDey2NqOEvLmpUQU+Y/JShf/+KQ==
Date: Sat, 19 Jul 2025 19:44:46 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/display: bridge-connector: correct CEC bridge
 pointers in drm_bridge_connector_init
Message-ID: <20250719194446.4fe59508@booty>
In-Reply-To: <20250719-fix-cec-bridges-v1-1-a60b1333c87d@oss.qualcomm.com>
References: <20250719-fix-cec-bridges-v1-1-a60b1333c87d@oss.qualcomm.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeiieeliecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthejredtredtvdenucfhrhhomhepnfhutggrucevvghrvghsohhlihcuoehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpedtleejjeduvddutefftdduleefudfgudeltdeuffeuudefgfdugeekgedtieehudenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdgsohhothhlihhnrdgtohhmnecukfhppeefjedrudeiuddrvddvvddrvdefjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeefjedrudeiuddrvddvvddrvdefjedphhgvlhhopegsohhothihpdhmrghilhhfrhhomheplhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudegpdhrtghpthhtohepughmihhtrhihrdgsrghrhihshhhkohhvsehoshhsrdhquhgrlhgtohhmmhdrtghomhdprhgtphhtthhopegrnhgurhiivghjrdhhrghjuggrsehinhhtvghlrdgtohhmpdhrtghpthhtohepnhgvihhlrdgrrhhmshhtrhhonhhgsehlihhnrghrohdrohhrghdprhgtphhtthhopehrfhhoshhssehkv
 ghrnhgvlhdrohhrghdprhgtphhtthhopefnrghurhgvnhhtrdhpihhntghhrghrthesihguvggrshhonhgsohgrrhgurdgtohhmpdhrtghpthhtohepjhhonhgrsheskhifihgsohhordhsvgdprhgtphhtthhopehjvghrnhgvjhdrshhkrhgrsggvtgesghhmrghilhdrtghomhdprhgtphhtthhopehmrggrrhhtvghnrdhlrghnkhhhohhrshhtsehlihhnuhigrdhinhhtvghlrdgtohhm
X-GND-Sasl: luca.ceresoli@bootlin.com

On Sat, 19 Jul 2025 13:58:13 +0300
Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> wrote:

> The bridge used in drm_bridge_connector_init() for CEC init does not
> correctly point to the required HDMI CEC bridge, which can lead to
> errors during CEC initialization.
> 
> Fixes: 65a2575a68e4 ("drm/display: bridge-connector: hook in CEC notifier support")
> Fixes: a74288c8ded7 ("drm/display: bridge-connector: handle CEC adapters")
> Reported-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> Closes: http://lore.kernel.org/r/20250718164156.194702d9@booty/
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

