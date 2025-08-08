Return-Path: <linux-kernel+bounces-759883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCFAB1E3EB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 09:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EDB1189C14A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 07:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FD8245010;
	Fri,  8 Aug 2025 07:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Jw5Q+zej"
Received: from relay15.mail.gandi.net (relay15.mail.gandi.net [217.70.178.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485F878F39
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 07:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754639719; cv=none; b=JvMgZ5E9kb9sLb8BoISJrFC8cgaPwLkjjNhsQrwseQSjgMSr9MQbZADc/ZVV2CLoJXK83MnwWKlPLIRNg7//IGJ5ppuPojwiqB3+agxxs7jWZwEsORSbs8B/u33/PqxL0n/lpRileG1Bj2GkLym6qJ0Ne+LVHaeIbBWAYJfCYJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754639719; c=relaxed/simple;
	bh=pVxFHL9HzSCSx8QhDhlyAkNUlcRpniIjlScG/IP3+4s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mMEnfNr8VTNDtFmXwca+iaM2p5sQsSQ0vLWRvz+MVpKzx073kq9rqc2Q2llybjeo7XWMQzO9wvxIrQOfbKBtTVsBzZErFkd+cPmcbqCQoCTuRaAk+K4W3nf8/TeT9akFkd2BBB4j2tOlYw2ZV9AiJMYLg3b7kaLKS/b2whBxikE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Jw5Q+zej; arc=none smtp.client-ip=217.70.178.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8C6584422E;
	Fri,  8 Aug 2025 07:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1754639714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S8PKXqTNQ/3w7esuxvUmGUr1FNJgEX8ancYJBx/8lUU=;
	b=Jw5Q+zejgVSOJLIWzjuV1peIgXNXkkWjcs7DfVxeX/TAjpG38xMw+88vR33+6kR5NZQKdX
	Nh0d4mUPXBxKv1qB2EtiEuc2+JNZMcRsZ7VNCk6rhYJ6j6i696oJZCel3qxnSCgJ67uNnr
	Wq4RJ5kvhB8QhOzAQTn9wAeTan9HA20GbZP+fdDzu4zQDsYf9sXvJAEdKqe4EOe5rhtL/C
	YFWMs4o7r68wr/Mt2eZqUGrrBQBY3qo12OtZYxww32XXdDdF32WaopNFC9qtdZEV53Oj7a
	WLu0NFyffwSTgykhGVLi4LONvI4C95mcdNkMt4mBLUno/lL8IKd/UsIgS8eJ1w==
Date: Fri, 8 Aug 2025 09:55:07 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Liao Yuanhong <liaoyuanhong@vivo.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Aradhya Bhatia
 <a-bhatia1@ti.com>, Dmitry Baryshkov <lumag@kernel.org>, Tomi Valkeinen
 <tomi.valkeinen@ideasonboard.com>, dri-devel@lists.freedesktop.org (open
 list:DRM DRIVERS), linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH v2] drm/bridge: cdns-dsi: Remove unnecessary memset
Message-ID: <20250808095507.3675071a@booty>
In-Reply-To: <20250808035939.134861-1-liaoyuanhong@vivo.com>
References: <20250808035939.134861-1-liaoyuanhong@vivo.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvdefvdeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpefnuhgtrgcuvegvrhgvshholhhiuceolhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeelffefgfehhfdtvdefueefieevkefggfelkeeiudetkeektedvhedukefgvddvnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeejkedrvdduvddrvdejrdduudehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepjeekrddvuddvrddvjedrudduhedphhgvlhhopegsohhothihpdhmrghilhhfrhhomheplhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudejpdhrtghpthhtoheplhhirghohihurghnhhhonhhgsehvihhvohdrtghomhdprhgtphhtthhopegrnhgurhiivghjrdhhrghjuggrsehinhhtvghlrdgtohhmpdhrtghpthhtohepnhgvihhlrdgrrhhmshhtrhhonhhgsehlihhnrghrohdrohhrghdprhgtphhtthhopehrfhhoshhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopefnrghurhgvnhhtr
 dhpihhntghhrghrthesihguvggrshhonhgsohgrrhgurdgtohhmpdhrtghpthhtohepjhhonhgrsheskhifihgsohhordhsvgdprhgtphhtthhopehjvghrnhgvjhdrshhkrhgrsggvtgesghhmrghilhdrtghomhdprhgtphhtthhopehmrggrrhhtvghnrdhlrghnkhhhohhrshhtsehlihhnuhigrdhinhhtvghlrdgtohhm

On Fri,  8 Aug 2025 11:59:37 +0800
Liao Yuanhong <liaoyuanhong@vivo.com> wrote:

> kzalloc() has already been initialized to full 0 space, there is no need to
> use memset() to initialize again.
> 
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

