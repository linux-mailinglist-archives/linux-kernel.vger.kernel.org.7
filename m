Return-Path: <linux-kernel+bounces-828698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D7BB953A0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 11:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A56CF1893BF8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 09:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED5C31D379;
	Tue, 23 Sep 2025 09:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZVlB0dd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB13C2701CF
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 09:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758619344; cv=none; b=LkGbuM0zOe8uZjCef9epgoBoZmEKFkSusnsU+OlvZ3SQqZOphPNjMBw9FFafYpieOCT+zaLkg5P9SRqDW6FrvY63P80sPpZVHWLC8NJWKHX9SSpHXVtjdwOlZLBm+L0coZK10REtUsOjyim8tbEM+Ngrzm+bYp7hmjaDQg1TCN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758619344; c=relaxed/simple;
	bh=re8iyrzRlnW2KmH2O/yo6Zjt7gcZw/+zmt+4s8KfKJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oYVnaHegtu4AkzUZz1DZ5MkAkzHFQLVcR5kVEa58H1p0jeZyO4naY2nXYkyoNQJNHukT+NhQk9fD2M8jfhYQxNezxwIhNiwMQ7gTs1U+XLV/xTFLRR24oCB4keULcospJUqA0r4EpJonVJgshMbet3quHyP7ZRFIu38skO+8sRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MZVlB0dd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18395C4CEF5;
	Tue, 23 Sep 2025 09:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758619344;
	bh=re8iyrzRlnW2KmH2O/yo6Zjt7gcZw/+zmt+4s8KfKJE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MZVlB0ddvj5BrCyX8+ae5Roxf7FrqnvhgP+C8nOr9ITCQSYRfy91wOyjgSOap7W2H
	 CPl5bTP8c9yjRdf7xW6popjRiqN1rZfjAU6b3Umlb05hD0wt7a+A8v6c43GoKHGD9R
	 ls0ct7WS0zdiV/zJdzcoWkB+wtXbXhKkp3SAh5jyHLgyQhU5VFDEdlKX6LL/aZWMxo
	 3vnyeOBWZLnmGsmvNrPT6JtA/x2O8Ev6zrJwGXQYmF4sTDa423G79ByHiCZp3x+Zm2
	 on0WYinRNSv8ygYdKj/cj+vMUStafrzz/nKran23FtTQy8ExGnaKfQ700qtcWPmEIj
	 Nh2L5zTdbiyXA==
Date: Tue, 23 Sep 2025 11:22:21 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Jyri Sarha <jyri.sarha@iki.fi>, Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
	Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/29] drm/atomic: Document atomic state lifetime
Message-ID: <20250923-quantum-resolute-crayfish-681be7@penduick>
References: <20250902-drm-state-readout-v1-0-14ad5315da3f@kernel.org>
 <20250902-drm-state-readout-v1-1-14ad5315da3f@kernel.org>
 <d807d181-6b14-4711-b297-72dcd49b4937@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="xcj2dhr6gp5yfski"
Content-Disposition: inline
In-Reply-To: <d807d181-6b14-4711-b297-72dcd49b4937@suse.de>


--xcj2dhr6gp5yfski
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 01/29] drm/atomic: Document atomic state lifetime
MIME-Version: 1.0

Hi Thomas,

On Tue, Sep 02, 2025 at 03:08:12PM +0200, Thomas Zimmermann wrote:
> > + *     or a newer one if a commit has been made. The new state is the
> > + *     state we just allocated and we might eventually commit to the
> > + *     hardware. The existing state points to the state we'll eventual=
ly
> > + *     have to free, the new state for now.
>=20
> That final sentence is confusing. What are we doing with the existing sta=
te?

After the other cleanup series I have, existing state is only ever used
to point to the state we should free.

> Will the old state ever become the existing state? You also never explain
> this below.

Yes, after we run an atomic commit. If the commit is only allocated and
freed, or if the atomic is only checked, then we'll free new state. It's
what I tried to explain in the next paragraph, but maybe it's not clear
enough?

> Maybe only focus on the old and new state for now and explain the meaning=
 of
> the existing state in a separate bullet point.

I'll try to do that then, thanks!

> > + *
> > + *   + Once we run a commit, it is first checked and if the check is
> > + *     successful, it is committed. Part of the commit is a call to
> > + *     drm_atomic_helper_swap_state() which will turn the new state in=
to
> > + *     the active state. Doing so involves updating the entity state
> > + *     pointer (&drm_crtc.state or similar) to point to the new state,
> > + *     and the existing state will now point to the old state, that us=
ed
> > + *     to be active but isn't anymore.
> > + *
> > + *   + When the commit is done, and when all references to our &struct
> > + *     drm_atomic_state are put, drm_atomic_state_clear() runs and will
> > + *     free all the old states.
> > + *
> > + *   + Now, we don't have any active &struct drm_atomic_state anymore,
> > + *     and only the entity active states remain allocated.
> > + */

--xcj2dhr6gp5yfski
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaNJmzAAKCRAnX84Zoj2+
djruAXwN4+6FidGF/ogsD+nFQGj6eOw3CtbeBVxDiAJdGguaREseAmRxHo/1MtH2
4esqsqsBgNbbzRjH+nCW82lbiNUAaXXEEa9Y1r25647rSbVbuv6YNkr7nTwGIZ4f
avLp25jN3Q==
=XmOB
-----END PGP SIGNATURE-----

--xcj2dhr6gp5yfski--

