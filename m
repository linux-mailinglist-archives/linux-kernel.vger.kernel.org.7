Return-Path: <linux-kernel+bounces-808186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF7CB4FB91
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEB9F3B451E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 12:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C407338F2F;
	Tue,  9 Sep 2025 12:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c4X4uqyv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6DF31B10E
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 12:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757421878; cv=none; b=obWOfCqsfqqwT76zRn8i2f58GdmOLbZbLVDBm2kN0COFRpKnOv4EvPzdLkpCbvl9SwkORaz3nAIvqdU33WtvPdspxaOg8kVJF91nwlh2GAHpxNkDXro6ez55g2saA5bkM6JgU9cOI/aBog2S5ozCUt10TVk/wBJ2zumiDBmkBsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757421878; c=relaxed/simple;
	bh=G038WdmGog4EOZkMKmHCh7lB80pDgiLXpw68xAADWy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fwuA4ia0ckO0n/e6N3cku752VjInKc5/XYfgk376mQ5hbORIGvdxEPYglkuBRj6AFBH6lUsds4ywPhmmbIRiC30lRNW07pg9LoaiBr/Z+fWTNcMlEy//4RD2KdxXkOA6LJrZ+qxHOmsMGxyrXDdnWpo4JDr14M2uOngoN1ctJ0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c4X4uqyv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F702C4CEFA;
	Tue,  9 Sep 2025 12:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757421878;
	bh=G038WdmGog4EOZkMKmHCh7lB80pDgiLXpw68xAADWy0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c4X4uqyvlp6gUsJ4r2eTVIpmXLfsAakB6LGSEO4rASOOqjyuijntUOt0spXPjEEcT
	 b7PR10UZdAQM02yy0+sfuP+i1oDEcN7w8QWQbecb/MMUbY8F6bF4ZWFqLIh3uF0OVU
	 tNuZA7/l57HjJvY85c2UBdr2yU9Y9REW5KghwrERmAuyGweHt9a6eryhsduhKltIik
	 gt5jXrdYjcBGIaYRysVGXP1MVj61kG3QCXJhfxn4mdGKPeoEFaurJ8dXrX7PhnM3V7
	 uM9YJcr2/xtvkr0aZ8Jg0GLn1+II+S7Iu+23aFwAamSQdoz+jtMBxtASiXJBBFx4nb
	 xB7PGDv1VYdXg==
Date: Tue, 9 Sep 2025 14:44:35 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Jyri Sarha <jyri.sarha@iki.fi>, Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
	Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/29] drm/atomic: Implement drm_atomic_print_old_state
Message-ID: <20250909-visionary-unyielding-loon-b214d4@houat>
References: <20250902-drm-state-readout-v1-0-14ad5315da3f@kernel.org>
 <20250902-drm-state-readout-v1-7-14ad5315da3f@kernel.org>
 <42e891ee-87b8-448e-a0c7-4f3e3b790556@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="523zrlvehmcdve4w"
Content-Disposition: inline
In-Reply-To: <42e891ee-87b8-448e-a0c7-4f3e3b790556@suse.de>


--523zrlvehmcdve4w
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 07/29] drm/atomic: Implement drm_atomic_print_old_state
MIME-Version: 1.0

Hi Thomas,

On Tue, Sep 02, 2025 at 03:26:49PM +0200, Thomas Zimmermann wrote:
> Am 02.09.25 um 10:32 schrieb Maxime Ripard:
> > We currently have a helper to print the new states associated to a
> > drm_atomic_state, but we don't have a variant to print the old state.
> >=20
> > It's somewhat expected, since we almost never care about what the new
> > state looks like when we commit a new state, but we're about to change
> > that.
> >=20
> > Signed-off-by: Maxime Ripard <mripard@kernel.org>
>=20
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

Thanks!

> I assume something later in the series uses this code?

Yeah, the readout code calls it to print the state that was built from
the hardware state.

Maxime

--523zrlvehmcdve4w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaMAhLgAKCRAnX84Zoj2+
dsJGAYCBTlTkqCHclm5b+I28vqbLA3bm50x5sHbJsN+hVR8xn8a97ufHx9J1M9ss
g6yAMp4Bf2dsrNnKywO5o0l9amNLMh4RswJ0TNueZPOuRpfQamBueGlqrspsG1Zj
1ZaZney8ew==
=a6zA
-----END PGP SIGNATURE-----

--523zrlvehmcdve4w--

