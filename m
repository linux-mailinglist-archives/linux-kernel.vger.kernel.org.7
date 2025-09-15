Return-Path: <linux-kernel+bounces-817574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD2DB583FE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 19:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5BE31AA39C0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 17:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C46629C343;
	Mon, 15 Sep 2025 17:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sRb5sF/b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84182857F2;
	Mon, 15 Sep 2025 17:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757958683; cv=none; b=nXu8a2SWdCDOrMRKxuYLqep2kmP000O123oJG+7vuW3/QGpj8Yw0eT45lENpPLMWH6gM7Y3Pjfw4j61kRvI95K6owl/v3bA2yD5ovMK5w0CvES+Rx9cTEjSEGeJF+UaIZgPuwcJQaTJNkiXY459DqGYyGIyJJJL7khz8ZcaznC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757958683; c=relaxed/simple;
	bh=fFdF5CMCTAnwISZ/eT+Yrx/sOBZpyVdhARbcIzdq8VU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bIbJgtNAKIL+A2Psp/wNERsUOdIYBJFO9mTefGcb1dV9fXhWz3zaOSDzaYXl0KbUnF59Bh7rUNraNolG054+bhjaXHD9gUbJXYbu3iM1qgl/PSQ5AjCXN1J0CUoZrsyRrqsuJ7ahkJ+9sfuzt1NKZCRTJ68LRtOIH/HLZW5don0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sRb5sF/b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B6CFC4CEF1;
	Mon, 15 Sep 2025 17:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757958682;
	bh=fFdF5CMCTAnwISZ/eT+Yrx/sOBZpyVdhARbcIzdq8VU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sRb5sF/bNQ34JDwzv2LB0JOxy9bYFZ+e7R8cPR1WaImljDF11kCCrpzEiUKGvLsi+
	 HZa4tuxWeGLKXw1ZjCaOm4bHNIFe+lLBBBWyuqZ2j5ltYiJOkso94xIXk62ouG64Dm
	 mB3b1TCOJ7qo8vTN4oSfSx4Z/8f6PAaNpzBlrNrQ8wKxa5mmdXKop2tKO4jedveEZY
	 j3AUPBydRAZSw6YbOS/rsaouUKRdGm5ESTHPd2iAQEayn31iilu9EOSfWhZsCHzaR9
	 pZentVVopng0ONFoSCIsZMXXK6V+5l+f7ubnk4hKAo2mhUrV4ltNhChzQGYhbS2GEp
	 aCqjmEXNLCJVw==
Date: Mon, 15 Sep 2025 18:51:16 +0100
From: Conor Dooley <conor@kernel.org>
To: Chia-I Wu <olvaffe@gmail.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 1/2] dt-bindings: gpu: mali-valhall-csf: add MediaTek
 MT8196 compatible
Message-ID: <20250915-numerate-makeshift-c076500aaec3@spud>
References: <20250913002155.1163908-1-olvaffe@gmail.com>
 <20250913002155.1163908-2-olvaffe@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vT2LutKl9MtQTSAL"
Content-Disposition: inline
In-Reply-To: <20250913002155.1163908-2-olvaffe@gmail.com>


--vT2LutKl9MtQTSAL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--vT2LutKl9MtQTSAL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaMhSFAAKCRB4tDGHoIJi
0hyDAQD5XpyVrgwBrD8kkao4gH4YK4KfNqnZEXgFzHZtZFmiBQEA0WDTgBM88F9Z
PcXqDWyoUO1rnrO+HG6i4coKk1lnPQs=
=JkzN
-----END PGP SIGNATURE-----

--vT2LutKl9MtQTSAL--

