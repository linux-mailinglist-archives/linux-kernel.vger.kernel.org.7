Return-Path: <linux-kernel+bounces-777743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1DBB2DD4C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 15:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33A5E5C7DC5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 13:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425AE302CA4;
	Wed, 20 Aug 2025 13:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KRppZq+b"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE1C1DFFC
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 13:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755694996; cv=none; b=PZiadFZPDv1TumQ2rjaGFGtS2eAnNZiyT8ywQjWW4wgaYJQZM35pKqYYi9BKXSM4m9r4U8fkbLaqkTvFVMjZWpriiQuQszjOSZbWS1zhtTDO649s9ZsT2MCdS+3hvFrAHPRQy7uLDAP6vq5SMFS3fOsj71s6rM0XUVcKwwz5T00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755694996; c=relaxed/simple;
	bh=ou3ZKDpar22z4Oo2WKPAdf/6zQC0VvNL1qqpdsnqSrY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=frLb/s8EG07JO6DE5ybY9mDD71CnHxnTfHyuv5bAz72pNOQXAuNwJAHxKmRzZvbPl6wjbHPiXNqXI/FMiF+qzX1+Y230RznOXHh8HdbeWiPoCtvWZxjdFeO3+sKmu+obS3IdqsGeYhLE5/L2lrTYi7K38PV7VLdh1G3TdTzacgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KRppZq+b; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9CE7E43960;
	Wed, 20 Aug 2025 13:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1755694990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rt+0HzlN0GaJY1va0P0oiYStG3sAxyTGjMfwBuvnESY=;
	b=KRppZq+bBuap94XWSmAOhDA3aclBmjsNIEqRm59WtPolG/xPd78QgqhUFgPaxmkhTI5t+m
	3X5+2ti0WeFuEDJ01GYN/EZExEPgbw3WXuzcTsK6ePb3EKOuQRcCVYu45ZkS3gpavIZ4Ds
	jnIrsIUWLodzZ9mMnWSI7FpijLjEb0WCi2APzDW2hIjqpq6msOw1Rsc5dP6ctb10HaCOP4
	in9JuXK+vOUHek9nlDFXksOjG0Bpuzk51zAi6Q3dD+waCV7gCSd+iLqNjethPBnoWgx+tL
	0jHHsljZi7RhIDnYMXhJGORvLh02VVEO2JmKsa3qpGYY2+w1LswmKWfXW1CEFA==
Date: Wed, 20 Aug 2025 15:03:07 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Hui Pu <Hui.Pu@gehealthcare.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Dmitry Baryshkov <lumag@kernel.org>
Subject: Re: [PATCH v7 2/3] drm/bridge: add list of removed refcounted
 bridges
Message-ID: <20250820150307.358e164c@booty>
In-Reply-To: <ecfsac5tok6bu7n6ctzt5j7n6vtiumn47iwmff4pid57kdsunz@wqxdxgsaibcw>
References: <20250819-drm-bridge-debugfs-removed-v7-0-970702579978@bootlin.com>
	<20250819-drm-bridge-debugfs-removed-v7-2-970702579978@bootlin.com>
	<ecfsac5tok6bu7n6ctzt5j7n6vtiumn47iwmff4pid57kdsunz@wqxdxgsaibcw>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheekgeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpefnuhgtrgcuvegvrhgvshholhhiuceolhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeelffefgfehhfdtvdefueefieevkefggfelkeeiudetkeektedvhedukefgvddvnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppedvrgdtvdemieejtdemvddtvddtmegvrgdtudemsggvgedumeelhegvjeemfeegfeemledufegvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegsvgegudemleehvgejmeefgeefmeeludefvgdphhgvlhhopegsohhothihpdhmrghilhhfrhhomheplhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudeipdhrtghpthhtohepmhhrihhprghrugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughriigvjhdrhhgrjhgurgesihhnthgvlhdrtghomhdprhgtphhtthhopehnvghilhdrrghrmhhsthhrohhngheslhhinhgrr
 hhordhorhhgpdhrtghpthhtoheprhhfohhssheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnfgruhhrvghnthdrphhinhgthhgrrhhtsehiuggvrghsohhnsghorghrugdrtghomhdprhgtphhtthhopehjohhnrghssehkfihisghoohdrshgvpdhrtghpthhtohepjhgvrhhnvghjrdhskhhrrggsvggtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrrghrthgvnhdrlhgrnhhkhhhorhhstheslhhinhhugidrihhnthgvlhdrtghomh
X-GND-Sasl: luca.ceresoli@bootlin.com

Hi Maxime,

On Tue, 19 Aug 2025 13:15:30 +0200
Maxime Ripard <mripard@kernel.org> wrote:

> > @@ -197,15 +197,22 @@
> >   * driver.
> >   */
> >  
> > +/* Protect bridge_list and bridge_removed_list */
> >  static DEFINE_MUTEX(bridge_lock);
> >  static LIST_HEAD(bridge_list);
> > +static LIST_HEAD(bridge_removed_list);  
> 
> I'm not super fond of "removed" here, it's ambiguous, especially since
> the bridge wouldn't be considered as removed after the last put.
> 
> lingering maybe?

Sure, will rename.

> > @@ -288,10 +296,13 @@ void *__devm_drm_bridge_alloc(struct device *dev, size_t size, size_t offset,
> >  EXPORT_SYMBOL(__devm_drm_bridge_alloc);
> >  
> >  /**
> > - * drm_bridge_add - add the given bridge to the global bridge list
> > + * drm_bridge_add - publish a bridge
> >   *
> >   * @bridge: bridge control structure
> >   *
> > + * Add the given bridge to the global list of "published" bridges, where
> > + * they can be found by users via of_drm_find_bridge().  
> 
> It's quite a change in semantics, at least in the doc. I believe it
> should be a separate patch, since it's really more about updating the
> drm_bridge_add / drm_bridge_remove doc than collecting the
> removed-but-not-freed bridges.
> 
> Also, I'm not sure if it's more obvious here. The quotes around publish
> kind of it to that too. Maybe using register / registration would make
> it more obvious?

OK, I'll reword using register/registration and definitely move to a
separate patch.

Thanks for reviewing.

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

