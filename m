Return-Path: <linux-kernel+bounces-812125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B93B8B53344
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 15:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 797D33BC1C5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 13:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB2B322DCE;
	Thu, 11 Sep 2025 13:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BgrVqnrn"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78974322A08
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 13:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757596202; cv=none; b=UUSOFAn4F6deQ3udbMWxXvG1iEGVqcCk6FKkFomq7tpETVNe5XNi3fjTA3e1k9LcANYNRAPzDWavKkp7tD4XWcncs8SErh47mnqE6bVwjU+peHdGU8Z0vIQzQOtOj8AXTlx95gBQEApErV0/dRXq+qjwlWSxKVIN+buyYPkMwIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757596202; c=relaxed/simple;
	bh=RPXqkcmTWsfyxL6Pz1OhK0z3akT9tGXfNbPBYjOtYSo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OH39R85M71mZjH+JNS4mkA2xvM5UJ8IgCRNqp6lq7g9Z0gfylRRjaJhf6U/pEvPtBqk2ZrhpiU8CxjO5i0vtnhDwHWEgtR62anPakjgnlQt6Kve1GEf0HQvk/4RfpSzRuLNc/Ebt/NqXpCogu7EMscMcENKFZkfZd5hoxJxJQ4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BgrVqnrn; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id A99B11A0DD2;
	Thu, 11 Sep 2025 13:09:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6AB1560630;
	Thu, 11 Sep 2025 13:09:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9B426102F28C0;
	Thu, 11 Sep 2025 15:09:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757596196; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=gBN2nTMeD6i5ODZAJyp6omgQEcD75ChSVNi/z0zbMTc=;
	b=BgrVqnrn3NvMb/IQkkFntbxca04UWnqHUa9XhaflCUsia671bsNwisWxEnChrV5+/m6lp3
	j/SZ7a3yMcoFv7qo5I5+SV8E2xoJSLrS0XD+W+5F1ywXcC6Gc1dEA7OGZUSpyFGRqTNOYR
	ipSSoJk/yVbeWcvipTGBJKev9cnRbdmZkgC2FyPOQnK+2z4n1knU9LNjAHnMj29hz0NJEE
	e5qPxm9lT1+dOOyoJbnGlGfj1XyMkSepJmApr3MAYd8VrQB24nSl5NtHXaZ0Ht6AHFPzgr
	KHpFC+nRGtMZ5LE0JhvYk3+ssNVpwOizTfnYPwJo6dHrhGbWgwCD5ko6qfs8Eg==
Date: Thu, 11 Sep 2025 15:09:33 +0200
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
Subject: Re: [PATCH 2/2] drm/bridge: ti-sn65dsi83: protect device resources
 on unplug
Message-ID: <20250911150933.52a0416d@booty>
In-Reply-To: <20250911-adept-vengeful-jacamar-15f2a0@houat>
References: <20250808-drm-bridge-atomic-vs-remove-v1-0-a52e933b08a8@bootlin.com>
 <20250808-drm-bridge-atomic-vs-remove-v1-2-a52e933b08a8@bootlin.com>
 <l2orbpdoh3cqqgqudbnbdlogo3bd57uu4nv3ax74uoahknzjgr@gbxxuky3huw6>
 <20250820131302.6a2da5ef@booty>
 <20250908154901.64f1a639@booty>
 <20250910-amazing-camouflaged-barracuda-bb79cb@houat>
 <20250910183440.3fe50fac@booty>
 <20250911-adept-vengeful-jacamar-15f2a0@houat>
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
X-Last-TLS-Session-Version: TLSv1.3

Hi Maxime,

On Thu, 11 Sep 2025 08:44:34 +0200
Maxime Ripard <mripard@kernel.org> wrote:

> > > > Option 2: have a function to unconditionally do the cleanups:
> > > > 
> > > > sn65dsi83_cleanups()
> > > > {
> > > > 	/* the same cleanups (no if) */
> > > > }
> > > > 
> > > > And then:
> > > >  * in atomic_pre_enable, instead of setting the flag
> > > >    add a devres action to call sn65dsi83_cleanups()
> > > >  * in atomic_disable, instead of clearing the flag
> > > >    remove the devres action
> > > > 
> > > > Even this option looks like more complicated and less readable code
> > > > to do the same thing.
> > > > 
> > > > Do you have in mind a better option that I haven't figured out?    
> > > 
> > > Would using devm_add_action in atomic_pre_enable, and
> > > devm_release_action in atomic_post_disable work?
> > > 
> > > That way, if you have a typical enable / disable cycle, the action will
> > > get registered and executed properly, and if you only have an enable but
> > > no matching disable, it will be collected after remove.  
> > 
> > So you're OK with option 2. I just implemented it, works well and the
> > resulting code is a bit cleaner. Queued for v2.  
> 
> Kind of, but you shouldn't remove but release it, and it doesn't have to
> be a single action / function.

Released instead of removed: yes.

Doesn't have to be a single function: I currently implemented a single
function with the 3 actions that are currently done in atomic_disable.
I think you propose to add 3 different devres actions, one for each,
but it would be more code and a little more resources used and I don't
see the advantage.

I think it makes sense that I send my current version and we can
continue discussion based on the code. I'm waiting a bit before
sending it, in case you have feedback about the other branch of this
discussion (placement of drm_bridge_unplug()).

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

