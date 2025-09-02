Return-Path: <linux-kernel+bounces-797388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFDDEB40FD8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 00:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52CB53BFDB3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 22:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B705726D4F1;
	Tue,  2 Sep 2025 22:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="W4Wn71t0"
Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7312526CE05
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 22:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756850872; cv=none; b=Ubuqkc0S8uWimxC6cSnFPitztTsYZZPVhFGKoJ5aH52NAwPsVNker4LkUWM6lSUETRos0aKYaw4nvGUenfJC6sL1ndbzhvap5MHYgRKsh18xw47gt73cBEKPZMvFA9mmH3XhlikjbBGZi1257u3InlBQKTJNj+2/2cYZ4QZDZkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756850872; c=relaxed/simple;
	bh=ItFG1T7/E8/ZPrI5DQMhDZwiCfiNmpQlDjwao2bBscQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bhv2JD2pXfN5qne/QVO5ONr46lU0j+MwMUTa7vi8V9qUKpRHBUakyAakUickYZa+UCCxVT6pYsgJUjZMOkrZY2Luho6pC6SslPVatfta9pTw++P3PIWVkR2iThVDbMFt9iFx06Z49r6Ow6yjC4S/ob4uVNxMOqlitE6TRQGbVb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=W4Wn71t0; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 1A86C5826D1
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 21:53:43 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id F127C41DE2;
	Tue,  2 Sep 2025 21:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1756850015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=br/QgVoy/c9/5rdndTufFT/AwJSOiX40/l6/1pESy2E=;
	b=W4Wn71t0ERnKj+15R+6nOiFru5MHlxap9PUNx0hhPgURCDHhHcLz06thXfcbSt+mgDmGDD
	WF1OcYas8FP2V/i3eALEJeS1uhoVlHI0QSSD3nC7IJE7oxz5213OdxhmGpLmSuZsCwnblE
	sN15FwekQWvsaZJMjT7uEmHTglMngF7o0i66Kf+ik950cVo0q5WWh8JAmxCvS24+Q6vCLh
	Fr4ibsSTGtFmkbsUh2fRbq20u9gvgaWVYKkLBBBU5XpHp5dVa99niAu/zX6sh7ylULCF5j
	82f1boSl7fdtq5tAukfWCFh8yiEbZkSvB0QByw7x8JeWRcjnZdtvs9WP/4W/Tw==
Date: Tue, 2 Sep 2025 23:53:26 +0200
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
Message-ID: <20250902235326.678947cd@booty>
In-Reply-To: <20250820114030.401e5d4f@booty>
References: <20250808-drm-bridge-alloc-getput-for_each_bridge-v2-0-edb6ee81edf1@bootlin.com>
	<20250808-drm-bridge-alloc-getput-for_each_bridge-v2-3-edb6ee81edf1@bootlin.com>
	<7gpqrxlxxuarbp5b7bycukbbjdcuonlhn4zm6xinnrlqzrbeu7@rrpcwxnxxrag>
	<20250819180137.28ca89c0@booty>
	<20250820114030.401e5d4f@booty>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuuhhsphgvtghtffhomhgrihhnucdlgeelmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpefnuhgtrgcuvegvrhgvshholhhiuceolhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgfeukedufeekuddugfeuteekgeelveelgfduteefjeffjeeiveetvefflefguddtnecuffhomhgrihhnpehophgvnhdqshhtugdrohhrghdpghhithhhuhgsrdhiohdpsghoohhtlhhinhdrtghomhenucfkphepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegrgeeivdemudgsuggumeeluddtudemvdelgehfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegrgeeivdemudgsuggumeeluddtudemvdelgehfpdhhvghlohepsghoohhthidpmhgrihhlfhhrohhmpehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvgedprhgtphhtthhopehmrhhiphgrrhgusehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhiivghjr
 dhhrghjuggrsehinhhtvghlrdgtohhmpdhrtghpthhtohepnhgvihhlrdgrrhhmshhtrhhonhhgsehlihhnrghrohdrohhrghdprhgtphhtthhopehrfhhoshhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopefnrghurhgvnhhtrdhpihhntghhrghrthesihguvggrshhonhgsohgrrhgurdgtohhmpdhrtghpthhtohepjhhonhgrsheskhifihgsohhordhsvgdprhgtphhtthhopehjvghrnhgvjhdrshhkrhgrsggvtgesghhmrghilhdrtghomhdprhgtphhtthhopehmrggrrhhtvghnrdhlrghnkhhhohhrshhtsehlihhnuhigrdhinhhtvghlrdgtohhm
X-GND-Sasl: luca.ceresoli@bootlin.com

Hi Maxime,

On Wed, 20 Aug 2025 11:40:30 +0200
Luca Ceresoli <luca.ceresoli@bootlin.com> wrote:

> Hi Maxime,
> 
> On Tue, 19 Aug 2025 18:01:37 +0200
> Luca Ceresoli <luca.ceresoli@bootlin.com> wrote:
> 
> > Hi Maxime,
> > 
> > On Tue, 19 Aug 2025 15:47:06 +0200
> > Maxime Ripard <mripard@kernel.org> wrote:
> >   
> > > > +/**
> > > > + * drm_for_each_bridge_in_chain_scoped - iterate over all bridges attached
> > > > + *                                       to an encoder
> > > > + * @encoder: the encoder to iterate bridges on
> > > > + * @bridge: a bridge pointer updated to point to the current bridge at each
> > > > + *	    iteration
> > > > + *
> > > > + * Iterate over all bridges present in the bridge chain attached to @encoder.
> > > > + *
> > > > + * Automatically gets/puts the bridge reference while iterating, and puts
> > > > + * the reference even if returning or breaking in the middle of the loop.
> > > > + */
> > > > +#define drm_for_each_bridge_in_chain_scoped(encoder, bridge)		\
> > > > +	for (struct drm_bridge *bridge __free(drm_bridge_put) =		\
> > > > +	     drm_bridge_chain_get_first_bridge(encoder);		\      
> > > 
> > > So my understanding is that the initial value of bridge would be cleaned
> > > up with drm_bridge_put...
> > >     
> > > > +	     bridge;							\
> > > > +	     bridge = drm_bridge_get_next_bridge_and_put(bridge))      
> > > 
> > > ... but also when iterating?
> > > 
> > > So if we have more than 0 values, we put two references?    
> > 
> > No, this is not the case. The __free action is executed only when
> > exiting the entire for loop, not a single iteration.
> > 
> > This is consistent with the fact that the loop variable is persistent
> > across iterations.  
> 
> PS: here's the C language spec reference:
> 
> > 6.8.5.3 The for statement
> > The statement
> > for ( clause-1 ; expression-2 ; expression-3 ) statement
> > behaves as follows:
> > [...]
> > If clause-1 is a declaration, the scope of any identifiers it declares
> > is the remainder of the declaration and the entire loop   
> 
> https://www.open-std.org/jtc1/sc22/wg14/www/docs/n1256.pdf
> https://rgambord.github.io/c99-doc/sections/6/8/5/3/index.html

I think my replies have proven the correctness of the bridge cleanup in
this patch. Based on my arguments, do you agree this patch is correct?

If it is, I think most of the remainder of this series is trivial to
review, and it would be a good step forward for dynamic bridge lifetime
implementation.

Otherwise, don't hesitate to let me know your concerns.

Best regards,
Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

