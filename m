Return-Path: <linux-kernel+bounces-759186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE04B1D9D3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 16:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25298563584
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 14:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403F7192B96;
	Thu,  7 Aug 2025 14:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VtSh9PJl"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869042B2DA
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 14:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754576349; cv=none; b=Tv84za5apihFDRwFpKljEvZr4cQ1/rhAMDIfM+tj4S/7JjAO3LNCVF4DuCzH7w1C0qN4uTyzP4JeuRPM6auhGv1p50aTUQDbGFPuQlXtsnpencuTfnKMKGn3K8uANTZRFNoyQL79KYDk3UXKPuS8ogTkiG5mVGaE/Ijv+Dr/eBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754576349; c=relaxed/simple;
	bh=g68CV+WBbLe6zejdTQ/wxBOHHimPAMiEf05czA0QRQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GfsRr3uS3YXfokjJE1sS+QLJ3UIuGNEg/t3U+IB+Qbd5lUyDN96DpUXoWnEQnrXveaxC3NhEPCJjDPa6Yz1F/hOAMSwfWcqGUrxk7rgKdr646ouU1cHjs1SUGGzvUTbQSe/walFn6stB9uWAj2AeBt6NpiMSAKaxynN5caV4Duo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VtSh9PJl; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 85E2B4435C;
	Thu,  7 Aug 2025 14:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1754576345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wtz8BM8N6dsLJ4l/x1CO4upvlAXB7mujSRm/cuika7o=;
	b=VtSh9PJlgNlkwwSwcZEAXP56crN4z3IKJ/0xzSJSrCH91/uausGi1D59IDftllnIZ3SA/a
	IPBoNPDo+PPOF5cW4yZoJpWyhk7hSCeKSh1sPX0ui4HO6Lujzs4HgDNxdMPmABQiDZkjt0
	+GsyPyvnW6p+1q9fc8LjvZ9CF6uGeZ9FKXU35a0VI5SH2UQIT1qWdvtaBRtpa9xUTYFnUu
	t9eCdNf4turu3qErmDV2FgGoVFQuazeA30D/bII0YWNJXwBrQjH2qLy/W45g8BAGv/067Z
	WinIgURbtw0hzwcATzLZ/695IGIZ/y8vKr1G5kYSI0FmIRRm3zMhTe1CQR9rpw==
Date: Thu, 7 Aug 2025 16:18:59 +0200
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
Subject: Re: [PATCH] drm/bridge: Remove unnecessary memset
Message-ID: <20250807161859.09d2134f@booty>
In-Reply-To: <20250807123836.494696-1-liaoyuanhong@vivo.com>
References: <20250807123836.494696-1-liaoyuanhong@vivo.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvdduudehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpefnuhgtrgcuvegvrhgvshholhhiuceolhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeelffefgfehhfdtvdefueefieevkefggfelkeeiudetkeektedvhedukefgvddvnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppedvrgdtvdemieejtdemvddtvddtmegvrgdtudemsggvgedumeelhegvjeemfeegfeemledufegvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegsvgegudemleehvgejmeefgeefmeeludefvgdphhgvlhhopegsohhothihpdhmrghilhhfrhhomheplhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudejpdhrtghpthhtoheplhhirghohihurghnhhhonhhgsehvihhvohdrtghomhdprhgtphhtthhopegrnhgurhiivghjrdhhrghjuggrsehinhhtvghlrdgtohhmpdhrtghpthhtohepnhgvihhlrdgrrhhmshhtrhhonhhgsehli
 hhnrghrohdrohhrghdprhgtphhtthhopehrfhhoshhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopefnrghurhgvnhhtrdhpihhntghhrghrthesihguvggrshhonhgsohgrrhgurdgtohhmpdhrtghpthhtohepjhhonhgrsheskhifihgsohhordhsvgdprhgtphhtthhopehjvghrnhgvjhdrshhkrhgrsggvtgesghhmrghilhdrtghomhdprhgtphhtthhopehmrggrrhhtvghnrdhlrghnkhhhohhrshhtsehlihhnuhigrdhinhhtvghlrdgtohhm
X-GND-Sasl: luca.ceresoli@bootlin.com

Hello Liao,

On Thu,  7 Aug 2025 20:38:33 +0800
Liao Yuanhong <liaoyuanhong@vivo.com> wrote:

> kzalloc() has already been initialized to full 0 space, there is no need to
> use memset() to initialize again.
> 
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
> ---
>  drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
> index a57ca8c3bdae..590f7c75744e 100644
> --- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
> +++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
> @@ -1047,7 +1047,6 @@ cdns_dsi_bridge_atomic_reset(struct drm_bridge *bridge)
>  	if (!dsi_state)
>  		return NULL;
>  
> -	memset(dsi_state, 0, sizeof(*dsi_state));

Thanks, your patch seems correct, but your subject line should mention
the driver you are changing. You can use 
'git log --oneline -- <filename>'
to ensure which prefix is used for that file.

Without that your subject line would suggest you are changing the
drm_bridge core or doing a change affecting several drivers. That would
be misleading to reviewers receiving your patch as well as when looking
at the git history in case the patch gets applied (because the e-mail
Subject will be used as the git commit message title.

Best regards,
Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

