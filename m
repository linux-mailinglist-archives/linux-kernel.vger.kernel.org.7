Return-Path: <linux-kernel+bounces-777418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A7EB2D8F0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 11:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 201924E350B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 09:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460BA2E2DDC;
	Wed, 20 Aug 2025 09:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Y/y9Pepq"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5186B2797B2
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 09:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755682843; cv=none; b=iBDMldhAbuYJrpDbqC46wtnBxt9h82h9VWxVH/hfoh4A0zELN6+W0ttzZH8SJeXuc5+QgA0XKqwSy4gBs6Wf0vbXeWGsbXGKiJoH2LICspugVKhBQrE3Grw7nrg2rSysJyHDsGh6QDth1+bS9dIC8YHXeKkuN099BJIm/7yr7rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755682843; c=relaxed/simple;
	bh=SlDNVjaqSCJN1qq7vItlVzarPa3bLQWQpk6xfhoW6kw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HC9o1UlcKgOwCmUvsnn2E3mvGm3szb1X0JMjRN8TlsBtC7BwuUtVBCrXwOL+xAigjxlOLWamSfRcvX5M7GPMA9h4rW5acAA6pPcGvkw0Q7/DORoYwVpp5imcpSNRQSb39smJuvPGPrLQHIT3QkrjAuNIMJkVY715A1QrJS3XFWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Y/y9Pepq; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C351643193;
	Wed, 20 Aug 2025 09:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1755682838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wF4ezXe1oz0qXQ3iPrYQSXp9CX1fNeaMxP5k7bhgW6w=;
	b=Y/y9PepqlsSdvoFd64NEFTFgsyQlwPoRfHeHRuhUHMxQ67R8niwxqsZUEGaKTWEYy2tbaJ
	8OgyxxkkKx1V9LH5l1nTOtxtv+hQww1vcEGMoUvYxikbV5EzCD3B/gQU0m5jR2DpOLz0xq
	KGZDhOrxTHYZ2g3mJ7XNOL1SP0BkeeKRX83PiSrFwhtgHq88Iv7uv6k02VCQ13nh0WQfZ7
	KrCCjR5uhKWwXqnzWgJ9p9vcR44jTZkDq5YZmlqHevFXif8umFS90Jq6m+47J5Rm3ik2+s
	Gwk6sv+ZgpkBKPupUCKjZQDYEz7+ZGSsAIUdeUdMQlP28df9Z/pFw8yTaWltcg==
Date: Wed, 20 Aug 2025 11:40:30 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor
 <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Dmitry Baryshkov
 <dmitry.baryshkov@oss.qualcomm.com>, Chaoyi Chen
 <chaoyi.chen@rock-chips.com>, Hui Pu <Hui.Pu@gehealthcare.com>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v2 3/9] drm/bridge: add
 drm_for_each_bridge_in_chain_scoped()
Message-ID: <20250820114030.401e5d4f@booty>
In-Reply-To: <20250819180137.28ca89c0@booty>
References: <20250808-drm-bridge-alloc-getput-for_each_bridge-v2-0-edb6ee81edf1@bootlin.com>
	<20250808-drm-bridge-alloc-getput-for_each_bridge-v2-3-edb6ee81edf1@bootlin.com>
	<7gpqrxlxxuarbp5b7bycukbbjdcuonlhn4zm6xinnrlqzrbeu7@rrpcwxnxxrag>
	<20250819180137.28ca89c0@booty>
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
X-GND-Score: -51
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheektdefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuuhhsphgvtghtffhomhgrihhnucdlgeelmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpefnuhgtrgcuvegvrhgvshholhhiuceolhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgfeukedufeekuddugfeuteekgeelveelgfduteefjeffjeeiveetvefflefguddtnecuffhomhgrihhnpehophgvnhdqshhtugdrohhrghdpghhithhhuhgsrdhiohdpsghoohhtlhhinhdrtghomhenucfkphepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegrgeeivdemudgsuggumeeluddtudemvdelgehfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegrgeeivdemudgsuggumeeluddtudemvdelgehfpdhhvghlohepsghoohhthidpmhgrihhlfhhrohhmpehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvgedprhgtphhtthhopehmrhhiphgrrhgusehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhiiv
 ghjrdhhrghjuggrsehinhhtvghlrdgtohhmpdhrtghpthhtohepnhgvihhlrdgrrhhmshhtrhhonhhgsehlihhnrghrohdrohhrghdprhgtphhtthhopehrfhhoshhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopefnrghurhgvnhhtrdhpihhntghhrghrthesihguvggrshhonhgsohgrrhgurdgtohhmpdhrtghpthhtohepjhhonhgrsheskhifihgsohhordhsvgdprhgtphhtthhopehjvghrnhgvjhdrshhkrhgrsggvtgesghhmrghilhdrtghomhdprhgtphhtthhopehmrggrrhhtvghnrdhlrghnkhhhohhrshhtsehlihhnuhigrdhinhhtvghlrdgtohhm
X-GND-Sasl: luca.ceresoli@bootlin.com

Hi Maxime,

On Tue, 19 Aug 2025 18:01:37 +0200
Luca Ceresoli <luca.ceresoli@bootlin.com> wrote:

> Hi Maxime,
> 
> On Tue, 19 Aug 2025 15:47:06 +0200
> Maxime Ripard <mripard@kernel.org> wrote:
> 
> > > +/**
> > > + * drm_for_each_bridge_in_chain_scoped - iterate over all bridges attached
> > > + *                                       to an encoder
> > > + * @encoder: the encoder to iterate bridges on
> > > + * @bridge: a bridge pointer updated to point to the current bridge at each
> > > + *	    iteration
> > > + *
> > > + * Iterate over all bridges present in the bridge chain attached to @encoder.
> > > + *
> > > + * Automatically gets/puts the bridge reference while iterating, and puts
> > > + * the reference even if returning or breaking in the middle of the loop.
> > > + */
> > > +#define drm_for_each_bridge_in_chain_scoped(encoder, bridge)		\
> > > +	for (struct drm_bridge *bridge __free(drm_bridge_put) =		\
> > > +	     drm_bridge_chain_get_first_bridge(encoder);		\    
> > 
> > So my understanding is that the initial value of bridge would be cleaned
> > up with drm_bridge_put...
> >   
> > > +	     bridge;							\
> > > +	     bridge = drm_bridge_get_next_bridge_and_put(bridge))    
> > 
> > ... but also when iterating?
> > 
> > So if we have more than 0 values, we put two references?  
> 
> No, this is not the case. The __free action is executed only when
> exiting the entire for loop, not a single iteration.
> 
> This is consistent with the fact that the loop variable is persistent
> across iterations.

PS: here's the C language spec reference:

> 6.8.5.3 The for statement
> The statement
> for ( clause-1 ; expression-2 ; expression-3 ) statement
> behaves as follows:
> [...]
> If clause-1 is a declaration, the scope of any identifiers it declares
> is the remainder of the declaration and the entire loop 

https://www.open-std.org/jtc1/sc22/wg14/www/docs/n1256.pdf
https://rgambord.github.io/c99-doc/sections/6/8/5/3/index.html

Best regards,
Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

