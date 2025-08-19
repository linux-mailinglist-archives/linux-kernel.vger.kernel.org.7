Return-Path: <linux-kernel+bounces-775892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABAF5B2C61E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 655051C23045
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B4D33EAFA;
	Tue, 19 Aug 2025 13:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dPgZ2hNm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189C032A3D5;
	Tue, 19 Aug 2025 13:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755611229; cv=none; b=Nm7XJuV2rLHfxhpaiwA2vbQexyPsr9Lr7Z+5iu5gpzXTWu5n1KTVz4R1nbH/zreQMNVQAa6o+h6/tPCDMnncrCY7ZcMxx9m41f1CiH0HQTm2LqPwDAGhNa/TsqMyv1tV+TDg6E/CXKkzRO3hj3frKaAlLrB2+Ep8cLYsr6Rofwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755611229; c=relaxed/simple;
	bh=0LlM/TmY7kun3N086n8nz+vfKY+G/rfvAUc/zm69FRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X5tmAecWz6jKvcYzTaDA8w614pYzVqTZmyTjeW4bYSoQUyH7aqhiLwT3mMHpOWnat88cCOSoAJ6syPYFGOjPjyzBOWOstQtqLKETjWsfS/zIzTDeUezCbhsztb3bYproeY9CASwmvx368Tj5OQ0azG58NuU6kutvrMg5BEaVa4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dPgZ2hNm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26B93C4CEF1;
	Tue, 19 Aug 2025 13:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755611228;
	bh=0LlM/TmY7kun3N086n8nz+vfKY+G/rfvAUc/zm69FRc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dPgZ2hNmMIAmn8WEoRRyYSL0sWizL9k1mu/g9r/NnRoHOSPlpeiJ3o3whMNP9Lc2/
	 8QZmljYITrfXGaoXap3f7VE/lFEkXmTAhrrbeprQHzqjIjmrA65rUnQh9hAF0Ls71/
	 uZfIytlhFXGqDFbt5++c3lol+M7XjdZuWDReMqlVUXSYKupFNZPjibjLg1VS6LeBsk
	 naSvLVDju+/AD7mHNscAMZfjdMmGCUV6RHuOLOuf+OxOUiodI0CdAgVXev6GdtyQMG
	 kr4ygb90tdI0nQM/k1q12LAKuCRLdTTM4m5F8oJspYlDovBPR6pWYlHZ1jKvQwicnp
	 GkP6m5LDerV7g==
Date: Tue, 19 Aug 2025 15:47:06 +0200
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
Subject: Re: [PATCH v2 3/9] drm/bridge: add
 drm_for_each_bridge_in_chain_scoped()
Message-ID: <7gpqrxlxxuarbp5b7bycukbbjdcuonlhn4zm6xinnrlqzrbeu7@rrpcwxnxxrag>
References: <20250808-drm-bridge-alloc-getput-for_each_bridge-v2-0-edb6ee81edf1@bootlin.com>
 <20250808-drm-bridge-alloc-getput-for_each_bridge-v2-3-edb6ee81edf1@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="htlwy25bloclwdxh"
Content-Disposition: inline
In-Reply-To: <20250808-drm-bridge-alloc-getput-for_each_bridge-v2-3-edb6ee81edf1@bootlin.com>


--htlwy25bloclwdxh
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 3/9] drm/bridge: add
 drm_for_each_bridge_in_chain_scoped()
MIME-Version: 1.0

On Fri, Aug 08, 2025 at 04:49:10PM +0200, Luca Ceresoli wrote:
> drm_for_each_bridge_in_chain() iterates ofer the bridges in an encoder
> chain without protecting the lifetime of the bridges using
> drm_bridge_get/put(). This creates a risk window where the bridge could be
> freed while iterating on it. Users of drm_for_each_bridge_in_chain() cann=
ot
> solve this reliably.
>=20
> Add variant of drm_for_each_bridge_in_chain() that gets/puts the bridge
> reference at the beginning/end of each iteration, and puts it if breaking
> ot of the loop.
>=20
> Note that this requires adding a new drm_bridge_get_next_bridge_and_put()
> function because, unlike similar functions as __of_get_next_child(),
> drm_bridge_get_next_bridge() gets the "next" pointer but does not put the
> "prev" pointer. Unfortunately drm_bridge_get_next_bridge() cannot be
> modified to put the "prev" pointer because some of its users rely on
> this, such as drm_atomic_bridge_propagate_bus_flags().
>=20
> Also deprecate drm_for_each_bridge_in_chain(), in preparation for removing
> it after converting all users to the scoped version.
>=20
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
>=20
> ---
>=20
> Changes in v2:
> - clarified commit message and mention an example where the current
>   behaviour of drm_bridge_get_next_bridge() is wanted
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
>=20
> Note 2: Yes, the drm_bridge_get_next_bridge_and_put() name is ugly, but we
>         do need a "next_bridge" function that does not put the "prev"
>         bridge and one that does. Any proposal for a better name or a
>         different implementation is welcome.
> ---
>  .clang-format            |  1 +
>  include/drm/drm_bridge.h | 41 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 42 insertions(+)
>=20
> diff --git a/.clang-format b/.clang-format
> index 48405c54ef271e9546da08893d200a4cf48f3a55..1cac7d4976644c8f083f801e9=
8f619782c2e23cc 100644
> --- a/.clang-format
> +++ b/.clang-format
> @@ -168,6 +168,7 @@ ForEachMacros:
>    - 'drm_exec_for_each_locked_object'
>    - 'drm_exec_for_each_locked_object_reverse'
>    - 'drm_for_each_bridge_in_chain'
> +  - 'drm_for_each_bridge_in_chain_scoped'
>    - 'drm_for_each_connector_iter'
>    - 'drm_for_each_crtc'
>    - 'drm_for_each_crtc_reverse'
> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> index 620e119cc24c3491c2be5f08efaf51dfa8f708b3..a8e2f599aea764c705da3582d=
f0ca428bb32f19c 100644
> --- a/include/drm/drm_bridge.h
> +++ b/include/drm/drm_bridge.h
> @@ -1365,10 +1365,51 @@ drm_bridge_chain_get_first_bridge(struct drm_enco=
der *encoder)
>   *	    iteration
>   *
>   * Iterate over all bridges present in the bridge chain attached to @enc=
oder.
> + *
> + * This is deprecated, do not use!
> + * New drivers shall use drm_for_each_bridge_in_chain_scoped().
>   */
>  #define drm_for_each_bridge_in_chain(encoder, bridge)			\
>  	list_for_each_entry(bridge, &(encoder)->bridge_chain, chain_node)
> =20
> +/**
> + * drm_bridge_get_next_bridge_and_put - Get the next bridge in the chain
> + *                                      and put the previous
> + * @bridge: bridge object
> + *
> + * Same as drm_bridge_get_next_bridge() but additionally puts the @bridg=
e.
> + *
> + * RETURNS:
> + * the next bridge in the chain after @bridge, or NULL if @bridge is the=
 last.
> + */
> +static inline struct drm_bridge *
> +drm_bridge_get_next_bridge_and_put(struct drm_bridge *bridge)
> +{
> +	struct drm_bridge *next =3D drm_bridge_get_next_bridge(bridge);
> +
> +	drm_bridge_put(bridge);
> +
> +	return next;
> +}
> +
> +/**
> + * drm_for_each_bridge_in_chain_scoped - iterate over all bridges attach=
ed
> + *                                       to an encoder
> + * @encoder: the encoder to iterate bridges on
> + * @bridge: a bridge pointer updated to point to the current bridge at e=
ach
> + *	    iteration
> + *
> + * Iterate over all bridges present in the bridge chain attached to @enc=
oder.
> + *
> + * Automatically gets/puts the bridge reference while iterating, and puts
> + * the reference even if returning or breaking in the middle of the loop.
> + */
> +#define drm_for_each_bridge_in_chain_scoped(encoder, bridge)		\
> +	for (struct drm_bridge *bridge __free(drm_bridge_put) =3D		\
> +	     drm_bridge_chain_get_first_bridge(encoder);		\

So my understanding is that the initial value of bridge would be cleaned
up with drm_bridge_put...

> +	     bridge;							\
> +	     bridge =3D drm_bridge_get_next_bridge_and_put(bridge))

=2E.. but also when iterating?

So if we have more than 0 values, we put two references?

Maxime

--htlwy25bloclwdxh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaKSAWQAKCRAnX84Zoj2+
dhA2AYDTGUPXjz2H7WiASyErvNCLeuaxLXCa7Wx66jEggdCDb0pq2kPxc01R6yvv
0YVIvSoBf3X67fAaK0eiAfBdd+jIsdplBNF+HcOHZp8Rq6mmtG7WTHeIIVqcRbK8
mLJO7cSOdA==
=eq2b
-----END PGP SIGNATURE-----

--htlwy25bloclwdxh--

