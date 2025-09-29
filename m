Return-Path: <linux-kernel+bounces-836402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 689C3BA9965
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 16:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF9B73AA072
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 14:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6033090E2;
	Mon, 29 Sep 2025 14:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VPxxUDtl"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F572FBDE7
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 14:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759156309; cv=none; b=s/5+my6/lCsUf/tO0rj/Z1Xdc4k7T5K1p4WchzAaABRbsXF2HfzzbrcY7eqFgMWXayZtvoEiX14hYaGugOQyzSVcT+3V6eT/wVoEqbD6u1CLHaQvg2mBbxNnw8GpET5n6hnDRlw+uWg/mV6Bgi4pEGR9Dse2ykHfwLSTBhyoqiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759156309; c=relaxed/simple;
	bh=IpGX4TAXRBmFsee6tJ2oBCu5Ti2cTDB6CTERjYAHTNg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EgzSua9UdOmJS1alZ3rI1HDdojr1wtIae/+Ra7hx4Tx+dZ9AgMITcs/46mSuXjI6/S9IKR6YcPJA2XFX3/D3lFnuUpAqsTPrVxIT5N/aPB7v1PUm1rifJOJhY6LC/yTzEWnU7R5sSd+h1jBfrjbQarudKz3V/lMNG2Gn5/0gxAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VPxxUDtl; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 1CDCC1A0F91;
	Mon, 29 Sep 2025 14:31:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DC77D606AE;
	Mon, 29 Sep 2025 14:31:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7F3B4102F16F4;
	Mon, 29 Sep 2025 16:31:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1759156300; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=xjTOCvFdY4AQNlquU9JgemAA95m0AG2lPPK+gJ1mSgQ=;
	b=VPxxUDtl11bkw/rkUE/A+VjJ0kUI6xgmqsZYhopAaSOFiSx0IOViaggmVpfg/VjmCJEfdk
	udZKT9ZsvEaI1h1dPA4wcmvUzxxca2ElIpCkRgrLbAl0Q6q0ZcVGzDg8huD9/dFkpgLMhb
	SCwLHgLxn8CtRcRzu2KFP04l2OqbW4fT1Fu0XebVQay8PYoXCQZNf7qrzMlbeqAvpTKn6h
	1z2QjkJ6rv6uiTcHJoAg6b+QLLIv2vHCuatdu6nQ4Igau/RxwLTz5hL0gnVB2A6eHFYjom
	zAJApIqQNovmcYsTDCfuhajAvFxGJpJd6rHfuee0i851gMT5+uUuEHaaj3Av9A==
Date: Mon, 29 Sep 2025 16:31:27 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Hui Pu
 <Hui.Pu@gehealthcare.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] drm/encoder: drm_encoder_cleanup: take chain mutex
 while tearing down
Message-ID: <20250929163127.5ad20e05@booty>
In-Reply-To: <20250929-flat-koel-from-nibiru-665d49@houat>
References: <20250926-drm-bridge-alloc-encoder-chain-mutex-v1-0-23b62c47356a@bootlin.com>
	<20250926-drm-bridge-alloc-encoder-chain-mutex-v1-2-23b62c47356a@bootlin.com>
	<20250929-flat-koel-from-nibiru-665d49@houat>
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

On Mon, 29 Sep 2025 14:45:10 +0200
Maxime Ripard <mripard@kernel.org> wrote:

> On Fri, Sep 26, 2025 at 05:59:43PM +0200, Luca Ceresoli wrote:
> > drm_encoder_cleanup() modifies the encoder chain by removing bridges via
> > drm_bridge_detach(). Protect this whole operation by taking the mutex, so
> > any users iterating over the chain will not access it during the change.
> > 
> > Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> > ---
> >  drivers/gpu/drm/drm_encoder.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/drm_encoder.c b/drivers/gpu/drm/drm_encoder.c
> > index 3261f142baea30c516499d23dbf8d0acf5952cd6..3a04bedf9b759acd6826864b7f2cc9b861a8f170 100644
> > --- a/drivers/gpu/drm/drm_encoder.c
> > +++ b/drivers/gpu/drm/drm_encoder.c
> > @@ -195,9 +195,11 @@ void drm_encoder_cleanup(struct drm_encoder *encoder)
> >  	 * the indices on the drm_encoder after us in the encoder_list.
> >  	 */
> >  
> > +	mutex_lock(&encoder->bridge_chain_mutex);
> >  	list_for_each_entry_safe(bridge, next, &encoder->bridge_chain,
> >  				 chain_node)
> >  		drm_bridge_detach(bridge);
> > +	mutex_unlock(&encoder->bridge_chain_mutex);  
> 
> You were claiming that the mutex was to prevent issues with concurrent
> iteration and removal of the list members. list_for_each_entry_safe() is
> explicitly made to protect against that. Why do we need both?

You're right saying we don't need both. With a mutex preventing the list
from any change, we can actually simpify code a bit to use the non-safe
list macro:

-	struct drm_bridge *bridge, *next;
+	struct drm_bridge *bridge;
...
+	mutex_lock(&encoder->bridge_chain_mutex);
- 	list_for_each_entry_safe(bridge, next, &encoder->bridge_chain,
+ 	list_for_each_entry(bridge, &encoder->bridge_chain,
 				 chain_node)
 		drm_bridge_detach(bridge);
+	mutex_unlock(&encoder->bridge_chain_mutex);
 
But it's not fully correct that list_for_each_entry_safe() protects
against concurrent removal. As I see it, all the _safe variants of
list_for_each*() macros protect against one specific and frequent use
case:

	list_for_each_entry_safe(curs, n, some_list, membername) {
		...
		list_del(&curs->membername);
		...
	}

So the _safe variant protect from removing the element at the current
iteration (*curs). It does so by taking the following element pointer in
advance, in the auxiliary variable @n. But _concurrent_ removal (the
topic of this series) means the element being removed could just be the
following one.

Consider this sequence:

 1. start loop: list_for_each_entry_safe() sets;
    pos = list_first_entry()   = <bridge 1>
    n   = list_next_entry(pos) = <bridge 2>
 2. enter the loop 1st time, do something with *pos (bridge 1)
 3. in the meanwhile bridge 2 is hot-unplugged
    -> another thread removes item 2 -> drm_bridge_detach()
    -> list_del() sets bridge->next = LIST_POISON1
 4. loop iteration 1 finishes, list_for_each_entry_safe() sets:
    pos = n (previously set to bridge 2)
    n   = (bridge 2)->next = LIST_POISON1
 5. enter the loop 2nd time, do something with *pos (bridge 2)
 6. loop iteration 2 finishes, list_for_each_entry_safe() sets:
    pos = n (previously set to LIST_POISON1) -> bug

Do you think this explains the need for this series?

If it does, I should probably add this to the cover letter and maybe
patch 1.

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

