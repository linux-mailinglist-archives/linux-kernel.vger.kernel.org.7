Return-Path: <linux-kernel+bounces-797135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61844B40C47
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 19:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E27EE1894DFB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 17:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B33C34572C;
	Tue,  2 Sep 2025 17:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uj8MCz2z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F44A306D35;
	Tue,  2 Sep 2025 17:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756834831; cv=none; b=NyrtMl3+N313+bBlBC7C06duYLPsNAhax/TgB6MeqlqEUjMKevXLpDWSKLDEn0+8wKXG7voISHA9/o0U4T2kr4qnHTEyL5gTF2gvkeevjRDEhF+J0TUbkpE2dmEjFdepPChePynDS1LG85CHgo0NtSbmrb9WJl4uo7LNeoTStAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756834831; c=relaxed/simple;
	bh=8DlnXpYC+KIZ90R/hZ53tbMz4E6ISDH9xSdqxhlTqg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cwpqdt7fztMWgSYiNE0FFDbzDlQ8T5UfAeRIp3QMOLnQkDEG3C3vAalSDhIj33Qe+eXLj6YILXjSHZuCwZpWph4/prIHTSW1ePZEUvxj0okxRH9H1OI7FqAwwm7RKDbfbVlcWAcizkg4gfCNQ7eerSWdYXoGIPznF7A5mSIF5H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uj8MCz2z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AE72C4CEED;
	Tue,  2 Sep 2025 17:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756834831;
	bh=8DlnXpYC+KIZ90R/hZ53tbMz4E6ISDH9xSdqxhlTqg8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uj8MCz2zItGENmC9fV9rdh/pUQ1kyrq4/Ra946iRMQZ4OqYW5EdZVv2o39TzHklvb
	 HnlyUjKdnmHWuNyBPIgYOSIBmkxRnDbi7yId/pfjSSx3ab18neq6CTZnwETdKpngaO
	 zUIs9RPzjt2FNkcOHYVCwSH42cPqcU809XylqR8Y0/MRskmbtXeHPAoVzmFYpyLRqZ
	 uujNzqJqryKVsrUZSBDSezEpQzymB/Ff9B8PE2voHFfubwHJT2cYkUE2JzFp9W3m+y
	 ZyQ1UgMFRuQNHWBIGRHmoWxuP407aDXyKGI98Mp+h30oJ0j8Q8yPDSrg1iY3+o6w4g
	 dwVZY8w3sLS0Q==
Date: Tue, 2 Sep 2025 19:40:27 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: aliceryhl@google.com, airlied@gmail.com, simona@ffwll.ch, 
	maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, acourbot@nvidia.com, 
	daniel.almeida@collabora.com, nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add drm-rust tree for Rust DRM drivers and
 infrastructure
Message-ID: <humoafx7njwhvdwarelew2bwyl34q3ls5vbrkj6psfukoroni5@z7ap6mc4lj3k>
References: <20250901202850.208116-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="eikyndkyyww5vqd6"
Content-Disposition: inline
In-Reply-To: <20250901202850.208116-1-dakr@kernel.org>


--eikyndkyyww5vqd6
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] MAINTAINERS: Add drm-rust tree for Rust DRM drivers and
 infrastructure
MIME-Version: 1.0

On Mon, Sep 01, 2025 at 10:26:39PM +0200, Danilo Krummrich wrote:
> Multiple DRM Rust drivers (e.g. nova-core, nova-drm, Tyr, rvkms) are in
> development, with at least Nova and (soon) Tyr already upstream. Having a
> shared tree will ease and accelerate development, since all drivers can
> consume new infrastructure in the same release cycle.
>=20
> This includes infrastructure shared with other subsystem trees (e.g. Rust
> or driver-core). By consolidating in drm-rust, we avoid adding extra
> burden to drm-misc maintainers, e.g. dealing with cross-tree topic
> branches.
>=20
> The drm-misc tree is not a good fit for this stage of development, since
> its documented scope is small drivers with occasional large series.
>=20
> Rust drivers in development upstream, however, regularly involve large
> patch series, new infrastructure, and shared topic branches, which may
> not align well with drm-misc at this stage.
>=20
> The drm-rust tree may not be a permanent solution. Once the core Rust,
> DRM, and KMS infrastructure have stabilized, drivers and infrastructure
> changes are expected to transition into drm-misc or standalone driver
> trees respectively. Until then, drm-rust provides a dedicated place to
> coordinate development without disrupting existing workflows too much.
>=20
> Cc: Alice Ryhl <aliceryhl@google.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Alexandre Courbot <acourbot@nvidia.com>
> Cc: Daniel Almeida <daniel.almeida@collabora.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  MAINTAINERS | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fe168477caa4..1cd6597c7f1d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8079,7 +8079,6 @@ F:	Documentation/devicetree/bindings/gpu/
>  F:	Documentation/gpu/
>  F:	drivers/gpu/drm/
>  F:	drivers/gpu/vga/
> -F:	rust/kernel/drm/
>  F:	include/drm/drm
>  F:	include/linux/vga*
>  F:	include/uapi/drm/
> @@ -8096,6 +8095,16 @@ X:	drivers/gpu/drm/radeon/
>  X:	drivers/gpu/drm/tegra/
>  X:	drivers/gpu/drm/xe/
> =20
> +DRM DRIVERS AND COMMON INFRASTRUCTURE [RUST]
> +M:	Danilo Krummrich <dakr@kernel.org>
> +M:	Alice Ryhl <aliceryhl@google.com>
> +S:	Supported
> +W:	https://drm.pages.freedesktop.org/maintainer-tools/drm-rust.html
> +T:	git https://gitlab.freedesktop.org/drm/rust/kernel.git
> +F:	drivers/gpu/drm/nova/
> +F:	drivers/gpu/nova-core/
> +F:	rust/kernel/drm/
> +

Would it make sense to add the drm-misc maintainers as reviewers for the
bindings?

Either way,

Acked-by: Maxime Ripard <mripard@kernel.org>

Maxime

--eikyndkyyww5vqd6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaLcsCgAKCRAnX84Zoj2+
diUfAYCICnzUOeZAXgLDM24mxtd9WwQGTfjRMWXnN6NZg83KmAmJsj1/c3t0jBWF
9uQfGBkBf29ImuGgjfzhJp075EPXs6d9v5wSW4gfEAyyTPWZPraqjxliL6JU+je0
iWsShiuugg==
=RhRF
-----END PGP SIGNATURE-----

--eikyndkyyww5vqd6--

