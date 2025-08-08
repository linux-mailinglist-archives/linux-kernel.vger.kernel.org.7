Return-Path: <linux-kernel+bounces-760534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28650B1EC88
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 17:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C318E3B62DE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 15:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239D3285CB9;
	Fri,  8 Aug 2025 15:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ofc9fAkA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8302A23ABB3;
	Fri,  8 Aug 2025 15:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754668499; cv=none; b=hQwHi6/TnEw+PgKlAj0YBxIT9MexDToMd2/ti5HDGXbocNY450Phjr5KvkO5snpsOVIgyf/l07Uqkw3ZxFLGRNnPq0C7rH0lM4ISTL0/7FHKi2QqoH7fMibQ3333pMOjBOs3xz7BgOKCAq8SZpzOyzNaiYTuDJ5ACa7azOM09+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754668499; c=relaxed/simple;
	bh=lgnkbkVduOwdXuXf7x7uzQPLcodvS2Q7o9dW6uo78kg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q93GgaI08J3561g+P9s4CDso4O5yRczk6IGqN6S7r3bUt3lelukqvT2GB2hOypn7zmD2HkpvxAsBW5VpYi8+nblGMShNjf5FhZqA8Hg8Wdqe9G3g2w0ncjaxPoKrEQqJTr8d7JiQqVT8tJwEvagRTz9tGrodcm3ZWdaemocCBR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ofc9fAkA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 921CDC4CEED;
	Fri,  8 Aug 2025 15:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754668499;
	bh=lgnkbkVduOwdXuXf7x7uzQPLcodvS2Q7o9dW6uo78kg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ofc9fAkAU+7a4uujMtgNa1n9cJhVu0pitr80wnx3yGR9IoOxbZdct8DwUo9f4y5lh
	 wCRsX1SlteB4rcmrxQDpeqWUL76jXBLUpBAU283d39YHZh2P7+3MBeJOynu0zLKC0Z
	 21yBg3RZIzm6+Jre5VxmoCnhMLWU1hYhNLXuaW10JmavespXqcjlFaDHNhxyCGkBqp
	 t0pO9W6x/GsUWcvDF+Q7dAZym7qjROX54CP8oYm+t+AuMh+Mn0N753OmLi2o6fP/bW
	 /rRFy2L5jDK+5Ts41qylJwfdvXw9QZq2kKpjqh39/POE+jcZl4Ditx4v3IYZLh4S+M
	 PsUicC0kX91eg==
Date: Fri, 8 Aug 2025 16:54:54 +0100
From: Conor Dooley <conor@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: display: Drop duplicate ti,opa362 binding
Message-ID: <20250808-elude-detail-ee0c8bd3a833@spud>
References: <20250807214508.4174167-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="o5zS9a3DrV3RFezK"
Content-Disposition: inline
In-Reply-To: <20250807214508.4174167-1-robh@kernel.org>


--o5zS9a3DrV3RFezK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 07, 2025 at 04:45:07PM -0500, Rob Herring (Arm) wrote:
> The "ti,opa362" binding is already supported in simple-bridge.yaml, so
> remove the old binding doc.
>=20
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--o5zS9a3DrV3RFezK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaJYdzgAKCRB4tDGHoIJi
0rCLAQCUZ8fu5dvlD2WAVYrW8ScBubBwZq7aRilZr1iswQxUUQEAqyT3QVMIyIeq
7KJ+SHBGzMKPRKWt+PdB7qJQ2iQCOQk=
=20Lm
-----END PGP SIGNATURE-----

--o5zS9a3DrV3RFezK--

