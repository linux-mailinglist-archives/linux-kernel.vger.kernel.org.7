Return-Path: <linux-kernel+bounces-775512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7EFB2C001
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E05DF189F051
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA8F23D29F;
	Tue, 19 Aug 2025 11:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B0DNFhrQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3120331AF17
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 11:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755602134; cv=none; b=oCH0IUW7DfJYuNHRW/MsF/7MwSG7hj8KiqNZyykmNZt4PdwPq8/B9fROLcJrKvwtjElWeCbJsIosvXd/l7fRQLtpg4jR32OodYJ4ETDkUiTlli2S/7tKyXGynGXUdem5NTdFaFEEbpuTeU4QdrcM7aFBTtzWy0ERiwQN1X5HeDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755602134; c=relaxed/simple;
	bh=kMnUYwQP+DdOU8NHJO6yq5VjpZNz60BrZq0kGU8lUqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V52EszEDDR6FkmRpiUggweIODlcmWcVxGbbL/5IMIagNtH3yHuAQqL5lMW6MO0gkYxZhV3nIKFLcV/mDNtoMLLYX+E8BWDBzoAGVf1Tccfse15B0oGtPROhPFSJwUP8CKaP9qYW0zepwCLcl3DBegBERNdTmBh9eX6/sRUOcFhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B0DNFhrQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51D1BC4CEF1;
	Tue, 19 Aug 2025 11:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755602134;
	bh=kMnUYwQP+DdOU8NHJO6yq5VjpZNz60BrZq0kGU8lUqs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B0DNFhrQkf61CLNcDm3FOQvUto7KbiKzaZCr6Pj03oSHhXZ7c3tX9q27cp7i3AP3y
	 t1iHxpDi5OsxU7Tz90j4lHw5bd4c3OKWGc42X2Wf6KACm11+r5TYoBaeRgVbUvz7ac
	 PBEOnIV0Z4/jIPu/Xz1Du2Cny0iI9u89u4J6bI6FCmXyxm0D2hTKvfkDQgaN41qt+Q
	 V58nivdyCui9qaimtoysBkctMeMvY2EtOoJxSSm42uLYfaMrwFEpyMuoBD8xGR1ocm
	 Bg8Gv9yGYYHNXllmIXZjDwlJ/jv7tlABBVBzryyromwtz+VzKIiR4mTVYbvwOF314y
	 VWz6GNvIfRH5g==
Date: Tue, 19 Aug 2025 13:15:30 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Hui Pu <Hui.Pu@gehealthcare.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Dmitry Baryshkov <lumag@kernel.org>
Subject: Re: [PATCH v7 2/3] drm/bridge: add list of removed refcounted bridges
Message-ID: <ecfsac5tok6bu7n6ctzt5j7n6vtiumn47iwmff4pid57kdsunz@wqxdxgsaibcw>
References: <20250819-drm-bridge-debugfs-removed-v7-0-970702579978@bootlin.com>
 <20250819-drm-bridge-debugfs-removed-v7-2-970702579978@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="nsotnouia2rwiyj2"
Content-Disposition: inline
In-Reply-To: <20250819-drm-bridge-debugfs-removed-v7-2-970702579978@bootlin.com>


--nsotnouia2rwiyj2
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v7 2/3] drm/bridge: add list of removed refcounted bridges
MIME-Version: 1.0

On Tue, Aug 19, 2025 at 11:42:11AM +0200, Luca Ceresoli wrote:
> Between drm_bridge_add() and drm_bridge_remove() bridges are "published" =
to
> the DRM core via the global bridge_list and visible in
> /sys/kernel/debug/dri/bridges. However between drm_bridge_remove() and the
> last drm_bridge_put() memory is still allocated even though the bridge is
> not "published", i.e. not in bridges_list, and also not visible in
> debugfs. This prevents debugging refcounted bridges lifetime, especially
> leaks due to any missing drm_bridge_put().
>=20
> In order to allow debugfs to also show the removed bridges, move such
> bridges into a new ad-hoc list until they are eventually freed.
>=20
> Note this requires adding INIT_LIST_HEAD(&bridge->list) in the bridge
> initialization code. The lack of such init was not exposing any bug so fa=
r,
> but it would with the new code, for example when a bridge is allocated and
> then freed without calling drm_bridge_add(), which is common on probe
> errors.
>=20
> Document the new behaviour of drm_bridge_remove() and update the
> drm_bridge_add() documentation to stay consistent.
>=20
> drm_bridge_add() needs special care for bridges being added after having
> been previously added and then removed.  This happens for example for many
> non-DCS DSI host bridge drivers like samsung-dsim which
> drm_bridge_add/remove() themselves every time the DSI device does a DSI
> attaches/detach. When the DSI device is hot-pluggable this happens multip=
le
> times in the lifetime of the DSI host bridge.  When this happens, the
> bridge->list is found in the removed list, not at the initialized state as
> drm_bridge_add() currently expects.
>=20
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
>=20
> ---
>=20
> Changes in v7:
> - rebase on current drm-misc-next
> - remove if (drm_bridge_is_refcounted(bridge)), refcounting is now
>   mandatory
> - add check to detect when re-adding a bridge that is in the removed list
> - improve commit message
> - fix typo
>=20
> This patch was added in v6.
> ---
>  drivers/gpu/drm/drm_bridge.c | 30 +++++++++++++++++++++++++++---
>  1 file changed, 27 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index 36e0829d25c29457cff5da5fec99646c74b6ad5a..2e688ee14b9efbc810bcdb0ab=
7ecd4b688be8299 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -197,15 +197,22 @@
>   * driver.
>   */
> =20
> +/* Protect bridge_list and bridge_removed_list */
>  static DEFINE_MUTEX(bridge_lock);
>  static LIST_HEAD(bridge_list);
> +static LIST_HEAD(bridge_removed_list);

I'm not super fond of "removed" here, it's ambiguous, especially since
the bridge wouldn't be considered as removed after the last put.

lingering maybe?

> =20
>  static void __drm_bridge_free(struct kref *kref)
>  {
>  	struct drm_bridge *bridge =3D container_of(kref, struct drm_bridge, ref=
count);
> =20
> +	mutex_lock(&bridge_lock);
> +	list_del(&bridge->list);
> +	mutex_unlock(&bridge_lock);
> +
>  	if (bridge->funcs->destroy)
>  		bridge->funcs->destroy(bridge);
> +
>  	kfree(bridge->container);
>  }
> =20
> @@ -275,6 +282,7 @@ void *__devm_drm_bridge_alloc(struct device *dev, siz=
e_t size, size_t offset,
>  		return ERR_PTR(-ENOMEM);
> =20
>  	bridge =3D container + offset;
> +	INIT_LIST_HEAD(&bridge->list);
>  	bridge->container =3D container;
>  	bridge->funcs =3D funcs;
>  	kref_init(&bridge->refcount);
> @@ -288,10 +296,13 @@ void *__devm_drm_bridge_alloc(struct device *dev, s=
ize_t size, size_t offset,
>  EXPORT_SYMBOL(__devm_drm_bridge_alloc);
> =20
>  /**
> - * drm_bridge_add - add the given bridge to the global bridge list
> + * drm_bridge_add - publish a bridge
>   *
>   * @bridge: bridge control structure
>   *
> + * Add the given bridge to the global list of "published" bridges, where
> + * they can be found by users via of_drm_find_bridge().

It's quite a change in semantics, at least in the doc. I believe it
should be a separate patch, since it's really more about updating the
drm_bridge_add / drm_bridge_remove doc than collecting the
removed-but-not-freed bridges.

Also, I'm not sure if it's more obvious here. The quotes around publish
kind of it to that too. Maybe using register / registration would make
it more obvious?

Maxime

--nsotnouia2rwiyj2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaKRczQAKCRAnX84Zoj2+
dgXtAX9SgyL+O/+ndp90CYpn+wH3ax9YUd9RjgKIfBDLu5PvchzpeRiLkvuSw3/K
4qFv3QwBfA1KiLO2rkETWPOnEmSDhrpvllgdOl/mGmY4mwQZ6n23bDNgJxuqwb/N
Nf3FJ0a15w==
=Bwie
-----END PGP SIGNATURE-----

--nsotnouia2rwiyj2--

