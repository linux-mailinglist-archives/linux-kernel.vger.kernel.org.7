Return-Path: <linux-kernel+bounces-816813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7234BB57883
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF5D27B03A5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 11:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ACAD3002B2;
	Mon, 15 Sep 2025 11:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="irHbUquB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A782FFDFE
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 11:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757936149; cv=none; b=KM29f3nEe9NEgrDvzvo1+oKJ5PMFFj+yWByRBa5ARTvaVn7Li47ipAlI9cBhPEwzS80+PeIVvxV/a6upj/XjBeQzx9n3WqRvGY0TVJ/u/3da33rMAwohJRAlQaBXJvIP+HTngo4+0Omz9Q5/uY2Zsboh7CqduFxi8thyXCa59uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757936149; c=relaxed/simple;
	bh=g6iT4LnVK7VL5GwXa8h1y7q/YHk4y51nRdnBAvPMLHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g53ydy3wxGwm8ByeIqbfguQ4bCe5OxD8mT4cvkCcXAVRrmA2n5wtr5wOS4lyCyoPJJQWS9KnSJG01A4W9ALFMKQersrqEYH1eo1aXyxssL8Xi8+f9/MjPKn6JPI3aMyKJViS793e4C63wbjX7pR7IniEAjSpIx0wEw1bHvR2oZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=irHbUquB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 985F6C4CEF1;
	Mon, 15 Sep 2025 11:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757936149;
	bh=g6iT4LnVK7VL5GwXa8h1y7q/YHk4y51nRdnBAvPMLHg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=irHbUquBjSFrawKk+3UEmche2gt/Rgpdr15gS2JmZS1dAWlbJlXBHbjg8gXR11Yqp
	 +0Hq/9ortYg0Y/zWUUCIyy0K6u7iQLk2GngrdprqwAjvstszH+MGIy54oFkpGIx0ye
	 KKrLh/V0L3NQGkKrJPO0FsH9PER9w+OHgY/I8AlUOaS6rDDJZTDStchF9/Am2QVN7l
	 Ern40o9RIMirw5FmHcmpIWMXFeJ64dAut9owbvoKVl8v3FOCE6Gl6tuQSDnXl//x8/
	 I80uS8tMkCCT2pb8G+3gUOlazd6j8iEg+BvPx9JHasL18daPL8EFs1yAzIk3qM/tes
	 /AjpcK9rdKcBw==
Date: Mon, 15 Sep 2025 13:35:45 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Jyri Sarha <jyri.sarha@iki.fi>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Devarsh Thakkar <devarsht@ti.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/29] drm/atomic: Only call atomic_destroy_state on a
 !NULL pointer
Message-ID: <20250915-dangerous-industrious-gecko-b25b7b@penduick>
References: <20250902-drm-state-readout-v1-0-14ad5315da3f@kernel.org>
 <20250902-drm-state-readout-v1-8-14ad5315da3f@kernel.org>
 <20250902205247.GW13448@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="lzlgqubra4xlbor6"
Content-Disposition: inline
In-Reply-To: <20250902205247.GW13448@pendragon.ideasonboard.com>


--lzlgqubra4xlbor6
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 08/29] drm/atomic: Only call atomic_destroy_state on a
 !NULL pointer
MIME-Version: 1.0

On Tue, Sep 02, 2025 at 10:52:47PM +0200, Laurent Pinchart wrote:
> On Tue, Sep 02, 2025 at 10:32:36AM +0200, Maxime Ripard wrote:
> > The drm_atomic_state structure is freed through the
> > drm_atomic_state_put() function, that eventually calls
> > drm_atomic_state_default_clear() by default when there's no active
> > users of that state.
> >=20
> > It then iterates over all entities with a state, and will call the
>=20
> Did you mean s/with a state/within the state/ ?

I'm not sure how to phrase it, but I meant "entities" that have a
matching state structure. Encoders for example don't.

> I'd also replace "entity" with "object" as mentioned in the review of a
> previous patch.

And bridges aren't objects :/

> > atomic_destroy_state callback on the state pointer. The state pointer is
> > mostly used these days to point to which of the old or new state needs
> > to be freed, depending on whether the state was committed or not.
> >=20
> > So it all makes sense.
> >=20
> > However, with the hardware state readout support approaching, we might
> > have a state, with multiple entities in it, but no state to free because
> > we want them to persist. In such a case, state is going to be NULL, and
> > thus we'll end up with NULL pointer dereference.
>=20
> I'm not sure to follow you here. Are we talking with objects whose old
> and new states will both need to be preserved ? Or objects that have no
> old state ?

It's more of the latter, but not really. Objects, at this point of the
series, will always have an old state.

However, due to how the initial state is being built with hardware
readout, we would move the old state of an entity/object/whatever to
$object->state, and clear it from drm_atomic_state so it's not freed.

so drm_atomic_state ends up with a whole bunch of objects that don't
have an old state anymore, and drm_atomic_state_default_clear() chokes
on that.

Maxime

--lzlgqubra4xlbor6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaMf6EQAKCRAnX84Zoj2+
ds4WAX98P2TpRW0+Wg625O9mrd1bDzmxa7KteQ4ID+ZyQm39wgRPsGEEwcVEJ0yk
nO0ooV0BfiXGnL5cpFsL7vNgrr+yQFxUB+wWibtzPr2ITMmRVF7i7wbIpaH+jstp
18m/s/QBwA==
=KewR
-----END PGP SIGNATURE-----

--lzlgqubra4xlbor6--

