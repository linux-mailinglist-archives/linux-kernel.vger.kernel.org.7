Return-Path: <linux-kernel+bounces-818434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C7FB591B8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 11:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B5EA5280B2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 09:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B04298CC9;
	Tue, 16 Sep 2025 09:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iL7oN6ib"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6448299A84;
	Tue, 16 Sep 2025 09:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758013424; cv=none; b=Q2rwZwQ9hFj96EBRl7z/vfxMsf21cN7uexDgsXXuT8q1wMhaBhYwBielQejL4Awu+3LslnXBrY/GiClrTXqFc9bJSyTxPOwIuSDL06cLrjLpB288c/Bpvdl/tJTvzXKlOMDUev4CP2rF1GL+T1ubpRWbZXxxawapwHjJ0MBHQ/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758013424; c=relaxed/simple;
	bh=MZwGrBHn7fPx6J7jWScTagGw2ALfjMRVbO4DtaIYdUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DdrDbeuwFEA1NdHs7XaMb8OZCEYhVOPPHQhKtPc6FFYGuXEh+xlQ+NXCb3VIM8k5cgP2PsoU0O5mc/Q1YNGaaDzaA3SdwkojTp/kw8pOXPvi+6RdoeNVt05kUZdAXMXoPSufqhxyjzWgbCZH46SCUSsV3T2yggkp6EKmqNbGlI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iL7oN6ib; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9CFBC4CEEB;
	Tue, 16 Sep 2025 09:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758013424;
	bh=MZwGrBHn7fPx6J7jWScTagGw2ALfjMRVbO4DtaIYdUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iL7oN6ibPnr6d7GQE8OAHny60zW/mzn/tDXnzQgFQR7+vf2SJVb4P4Pq5N2+VyJUG
	 q7ANJyAG8L2AIho1rgjoEgGTOQJcmfJXQWpXocWsG+Q+e4sHI13OChBO2D2azFuFyu
	 MlfXpicvnoSPlFkzfLAZK14fWTbrgOHxOyyYsM5qH/gWjyj+BDmKa2LBV0mXJxThxC
	 hoFfQB1gsnY0bax6j42NeJNHVcN/fQsf72WZGC8iJFwJC4U2a8d4Lv3+1lQeUZzWhJ
	 N0EtDzFu/OAo5+Wy/9GuV0qie36ilqZ1A4xlnZPNmvCLdSqERVsiMEWq+XUPC2bdYm
	 8JOGBUzdFdIjQ==
Date: Tue, 16 Sep 2025 11:03:41 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Miguel Ojeda <ojeda@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Chaoyi Chen <chaoyi.chen@rock-chips.com>, Hui Pu <Hui.Pu@gehealthcare.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev
Subject: Re: [PATCH v2 7/9] drm/bridge: remove drm_for_each_bridge_in_chain()
Message-ID: <20250916-jade-seal-of-cleaning-5ee2bd@houat>
References: <20250808-drm-bridge-alloc-getput-for_each_bridge-v2-0-edb6ee81edf1@bootlin.com>
 <20250808-drm-bridge-alloc-getput-for_each_bridge-v2-7-edb6ee81edf1@bootlin.com>
 <20250915-optimal-hornet-of-potency-efa54a@penduick>
 <20250915175805.6e8df6ef@booty>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="j5gg2kqgg6e4zl3s"
Content-Disposition: inline
In-Reply-To: <20250915175805.6e8df6ef@booty>


--j5gg2kqgg6e4zl3s
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 7/9] drm/bridge: remove drm_for_each_bridge_in_chain()
MIME-Version: 1.0

On Mon, Sep 15, 2025 at 05:58:05PM +0200, Luca Ceresoli wrote:
> On Mon, 15 Sep 2025 14:22:24 +0200
> Maxime Ripard <mripard@kernel.org> wrote:
> > On Fri, Aug 08, 2025 at 04:49:14PM +0200, Luca Ceresoli wrote:
> > > All users have been replaced by drm_for_each_bridge_in_chain_scoped().
> > >=20
> > > Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> > > ---
> > >  .clang-format            |  1 -
> > >  include/drm/drm_bridge.h | 14 --------------
> > >  2 files changed, 15 deletions(-)
> > >=20
> > > diff --git a/.clang-format b/.clang-format
> > > index 1cac7d4976644c8f083f801e98f619782c2e23cc..d5c05db1a0d96476b711b=
95912d2b82b2e780397 100644
> > > --- a/.clang-format
> > > +++ b/.clang-format
> > > @@ -167,7 +167,6 @@ ForEachMacros:
> > >    - 'drm_connector_for_each_possible_encoder'
> > >    - 'drm_exec_for_each_locked_object'
> > >    - 'drm_exec_for_each_locked_object_reverse'
> > > -  - 'drm_for_each_bridge_in_chain'
> > >    - 'drm_for_each_bridge_in_chain_scoped'
> > >    - 'drm_for_each_connector_iter'
> > >    - 'drm_for_each_crtc'
> > > diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> > > index a8e2f599aea764c705da3582df0ca428bb32f19c..6adf9221c2d462ec8e0e4=
e281c97b39081b3da24 100644
> > > --- a/include/drm/drm_bridge.h
> > > +++ b/include/drm/drm_bridge.h
> > > @@ -1358,20 +1358,6 @@ drm_bridge_chain_get_first_bridge(struct drm_e=
ncoder *encoder)
> > >  						       struct drm_bridge, chain_node));
> > >  }
> > > =20
> > > -/**
> > > - * drm_for_each_bridge_in_chain() - Iterate over all bridges present=
 in a chain
> > > - * @encoder: the encoder to iterate bridges on
> > > - * @bridge: a bridge pointer updated to point to the current bridge =
at each
> > > - *	    iteration
> > > - *
> > > - * Iterate over all bridges present in the bridge chain attached to =
@encoder.
> > > - *
> > > - * This is deprecated, do not use!
> > > - * New drivers shall use drm_for_each_bridge_in_chain_scoped().
> > > - */
> > > -#define drm_for_each_bridge_in_chain(encoder, bridge)			\
> > > -	list_for_each_entry(bridge, &(encoder)->bridge_chain, chain_node)
> > > - =20
> >=20
> > I think I'd go a step further and rename
> > drm_for_each_bridge_in_chain_scoped to drm_for_each_bridge_in_chain,
> > there's no need to have a "scoped" variant if it's our only variant.
> >=20
> > It can be done in a subsequent patch though.
>=20
> Sure, that's the plan. There's a note in patch 3:
>=20
> Note 1: drm_for_each_bridge_in_chain_scoped() could be renamed removing t=
he
>         _scoped suffix after removing all the users of the current macro
>         and eventually the current macro itself. Even though this series =
is
>         converting all users, I'd at least wait one kernel release before
>         renaming, to minimize issues with existing patches which would fa=
il
>         building.

No need to wait that long, and the best time to do it is right now
actually, about the time we start collecting the patches for a new
release.

Maxime

--j5gg2kqgg6e4zl3s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaMkn4gAKCRAnX84Zoj2+
diPbAYCE0rN0Hys4v3lgLLkZRuYYI0Gb8t/xeW3MGR8DoeSuRalFsZbza8OQj62I
uKDA+8ABgMfMlLq3E2nNIB21uXhtaO+otkyU/nIntjQV4yQTEzi8wU1GnNHMU2H9
nilJreknJg==
=KvpI
-----END PGP SIGNATURE-----

--j5gg2kqgg6e4zl3s--

