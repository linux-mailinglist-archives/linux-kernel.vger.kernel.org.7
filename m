Return-Path: <linux-kernel+bounces-775364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A21A1B2BE5E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07A43624AF7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 10:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B01225784B;
	Tue, 19 Aug 2025 10:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eHDzkgcc"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94ABF3451D3
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 10:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755597713; cv=none; b=lmbweq1i5HyJq5Sh8tGKGVMIQvBrpw7yCZtetBb29q8Oy6gGxLCBwPFGQK4Sj4FHZ8/F500HxJAVjzfQd4ZbgBFfhdZfnmLFQjOcvU/l/OqcZNqNv212HZESw//ASPUAiCMAHZRk9zjyODDqcXLxn7x6i7K8vDeyZJotpY51rKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755597713; c=relaxed/simple;
	bh=6lrl+CrpiMNm7AidKMi7Yz+L8HFAbZ19UP7qvcWmmM0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZfprbxhAdOnAr7hM3jQtHblB64WqDQFeLb04qU7Ub8tcR7zOYjYs9csvhUPZ2BDFTuiEYnT9OleJvybwL/mQr5UMCncHxfdNV08T6qLKyPNWYz12yIsbF6KaXwp4CHNCJSoE6uZXTAbFzjK/bOtWsMZZruEBTteiFlvFJDSfpoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=eHDzkgcc; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 74D1D43192;
	Tue, 19 Aug 2025 10:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1755597702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FFeOuo3C+LD3wY1Ey4Q0b2fLMCcGgtn4xZLXy86gnqE=;
	b=eHDzkgccaumhYy47ovtESxgB1pkGVcF4qMMtRi0hQepRITouNAM6obLy/DYytNx0RdBQuL
	w4DXMHxdszcKaxSSZ23XB9TvSBu9qwkuqegnVz/15+0+xVDPBQ9fKfVPR4c6udVwlHwZO9
	0Du+GyB83MUoMvJ8y9rep3/uPNqcZwRMsn/5P9WDqZSuJHc28JdM98n8XOTUG7xYGTvsCh
	V6gVfPmVwhIT2WPH8OKRQL/jR82iRlJl4xfigQlb7m16ann+TuvfUYyNBWY1ohiST1Qb5f
	+yloICecyJBYi8kBpeQbrm9lrE24R42/3sp7y9g1mwSTgKVBTRWd0h+r8erOng==
Date: Tue, 19 Aug 2025 12:01:38 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Inki Dae <inki.dae@samsung.com>, Jagan Teki
 <jagan@amarulasolutions.com>, Marek Szyprowski <m.szyprowski@samsung.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Hui Pu <Hui.Pu@gehealthcare.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] samsung-dsim: move drm_bridge_add() call to probe
Message-ID: <20250819120138.6f656ae6@booty>
In-Reply-To: <20250808152001.122f2da6@booty>
References: <20250725-drm-bridge-samsung-dsim-add-in-probe-v1-1-b23d29c23fbd@bootlin.com>
	<20250728-diligent-brainy-hyena-109dde@houat>
	<20250728194430.082f9952@booty>
	<20250731-tactful-jellyfish-of-perspective-cb0324@houat>
	<20250808152001.122f2da6@booty>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheehvddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpefnuhgtrgcuvegvrhgvshholhhiuceolhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnheptdeljeejuddvudetffdtudelfedugfduledtueffuedufefgudegkeegtdeihedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpsghoohhtlhhinhdrtghomhenucfkphepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegsvgegudemleehvgejmeefgeefmeeludefvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtvdemieejtdemvddtvddtmegvrgdtudemsggvgedumeelhegvjeemfeegfeemledufegvpdhhvghlohepsghoohhthidpmhgrihhlfhhrohhmpehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedukedprhgtphhtthhopehmrhhiphgrrhgusehkvghrnhgvlhdrohhrghdprhgtphhtthhopehinhhkihdruggrvgesshgrmhhsuhhnghdrtghomhdprhgtphhtthhopehjrghgrghnsegrmhgrrhhul
 hgrshholhhuthhiohhnshdrtghomhdprhgtphhtthhopehmrdhsiiihphhrohifshhkihesshgrmhhsuhhnghdrtghomhdprhgtphhtthhopegrnhgurhiivghjrdhhrghjuggrsehinhhtvghlrdgtohhmpdhrtghpthhtohepnhgvihhlrdgrrhhmshhtrhhonhhgsehlihhnrghrohdrohhrghdprhgtphhtthhopehrfhhoshhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopefnrghurhgvnhhtrdhpihhntghhrghrthesihguvggrshhonhgsohgrrhgurdgtohhm
X-GND-Sasl: luca.ceresoli@bootlin.com

Hi Maxime,

On Fri, 8 Aug 2025 15:20:01 +0200
Luca Ceresoli <luca.ceresoli@bootlin.com> wrote:

> > > Some drawbacks of current code are because at every DSI attach/detach,
> > > the samsung-dsim does drm_bridge_add/remove() itself:
> > > 
> > >  * To me this looks like a bad design, the samsung-dsim is always
> > >    present and not hotpluggable, so why should it add/remove itself?
> > > 
> > >  * I have a debugfs patch to show in $BUDUGFS/dri/bridges_removed all
> > >    the removes bridges: bridges after drm_bridge_remove() but not yet
> > >    freed because refcount still > 0. But it causes crashes due to the
> > >    samsung-dsim going backwards from "removed" to "added", and further
> > >    hacks are needed to avoid this crash.

I went back to my old debugfs series, updated it and sent a new
iteration:
https://lore.kernel.org/r/20250819-drm-bridge-debugfs-removed-v7-0-970702579978@bootlin.com

There you can see the lines added to drm_bridge_add() for handing
"un-removed" bridges.

It's a few lines of code only, but I don't feel very happy with them. I
look forward to knowing your opinion about those few lines.

So there were 3 issues I mentioned as reasons for this patch to
samsung-dsim (only purely technical ones, not counting the "looks like
a bad design" reason):

 1. debugfs needs special care for un-removed bridges: see this e-mail
 2. interferes with .gone flag: ruled out, N/A
 3. needs a horrible hack in hotplug-bridge

No news about issue 3. I'm going to experiment with removing the
hotplug-bridge but that will take time (as a prerequisite I most likely
need to remove the "always connected" DSI connector first). Stay
tuned...

Best regards,
Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

