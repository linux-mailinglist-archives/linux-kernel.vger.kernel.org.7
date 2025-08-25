Return-Path: <linux-kernel+bounces-785226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B13B347CE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 18:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE97C1B24FE5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C396C301014;
	Mon, 25 Aug 2025 16:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sTcPQNTh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274902309B2;
	Mon, 25 Aug 2025 16:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756140200; cv=none; b=GeoCm5NgYMPtLz35zc+94fdj0xMvkL6AwuMsevMmEc1olzZ1QiHPifASCsUFAnGlKBvRfHl+27xVV9X49cnoAaH4YWBLxOim1UFi/gphaHmbAtR2Y27iGbzp2dWPMQfhiK6lSLWIIBJmSMcu2KGKhzl4Ee/WkteQSY+bDofEVp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756140200; c=relaxed/simple;
	bh=TX9+vP2bWcTRF6M7qTWQFrs1kf9aQadhdDTstsDHILQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y42FWfaJEhWy0Zy1PiJ1M6WSvTCymX/4ZqMnSv+/jqUiWk9UKQW+T9ruQLYZat9yuS7Ro5iLfAMDka6R0YAQjMC9XT451Ihmy4CZUl56DrFBkHnV4PrdRPLeMMUCad7L079sFUpr/NaENd7DStVBSK8fXczOjw+NHF0wTfysbEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sTcPQNTh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5D03C4CEED;
	Mon, 25 Aug 2025 16:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756140198;
	bh=TX9+vP2bWcTRF6M7qTWQFrs1kf9aQadhdDTstsDHILQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sTcPQNThS9MQ/B+UVcpnHzLbpBfLvLN5OxVsY31TQJpQVHDZkNqI3TDqRw5lNdeZb
	 OvoKdBwTXAYElzerhPHQvrz5ZG7KEIV8l+Tw5AxjJyvgv7Z1Zm6xqBpgcXXqSBG0FN
	 dW228ZjNOZsx/Q6oaLAH2oBNhUKREaoV4kGBM39cWdlUJMyzxuU+eS/rHVmPVirdJE
	 2oa1DZSaCgZY4rsW3QzpQisWbowxcqeDceRNN8ZTxvrh8aDUGW8Zre5hDPODrKoYGa
	 2OqIAWyyLFx6iMsrTN37C9Fyu1If984tIPEfQSQ0YFbMwpG/LkkuqXqRAYKYj8C3rk
	 rYI8zV0iPtprg==
Date: Mon, 25 Aug 2025 17:43:13 +0100
From: Conor Dooley <conor@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maxim Schwalm <maxim.schwalm@gmail.com>,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3 RESEND] dt-bindings: display: extend the simple
 bridge with MStar TSUMU88ADT3-LF-1
Message-ID: <20250825-enable-defection-1a6c71f97fca@spud>
References: <20250824092728.105643-1-clamor95@gmail.com>
 <20250824092728.105643-3-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Ru7F0K2IIlOSUCt+"
Content-Disposition: inline
In-Reply-To: <20250824092728.105643-3-clamor95@gmail.com>


--Ru7F0K2IIlOSUCt+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--Ru7F0K2IIlOSUCt+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaKySoQAKCRB4tDGHoIJi
0lV6AQDKN8Bl2FlAJOol/GEne8FjWl6jL2eX5cDlccXnISsQfQD+KxXOzE2NO46X
SeRP1sCGOsOslu/gyYpBqkuFf5mrGgY=
=v7bc
-----END PGP SIGNATURE-----

--Ru7F0K2IIlOSUCt+--

