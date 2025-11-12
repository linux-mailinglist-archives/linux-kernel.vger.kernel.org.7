Return-Path: <linux-kernel+bounces-897962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0E2C5406D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 19:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E21FA4E4D1F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 18:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402FB34B1B6;
	Wed, 12 Nov 2025 18:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/hD8IGn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9740A1B3925;
	Wed, 12 Nov 2025 18:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762973373; cv=none; b=h3Kg8fOv2DJRuzDW76dXzHb6vfHlA3gAk2Ah/htwsI2keWUZAYq9HQ19fugcG3jWYPi8YzKz22F+ZN+Q2EIiDVeQc5DdSBBJxX7WFTdZeLTE/zB3dCmc3saXoEh6yom5z0LwCoAqed0YdAG8txJFTPUG+x6BuunEibcQz66dWuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762973373; c=relaxed/simple;
	bh=9DyqYhTVr+ET9PloHfUUoxUdfC+ZS9pwHUh1FrcT11k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=flnSatJX7JqVDPcBDXY3op/mmbevlAUg2GjaYK8SOPXBNHdp1qg46X1kpWSr6phkaMZ6lOIgjgrk08eMqZR2aAl1L4cFR9rPF3dEhU5Y9VB2AM/4QWn5pZKwTmI4t7Jww3gP00Y10rsE1y+xQkVPa/SZ89PV707yRE1JXv0aLrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j/hD8IGn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C5DDC16AAE;
	Wed, 12 Nov 2025 18:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762973372;
	bh=9DyqYhTVr+ET9PloHfUUoxUdfC+ZS9pwHUh1FrcT11k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j/hD8IGn4k3nGs1deCFbvPkATaE2YeiYjoZhwtT9+V5Dp/fkl7jo75GraV13cjXXu
	 zM6yI8SIQUz7ysX6z44hZStuk8v0kjUTL0ZqtYSos2ZZfgZDjhjX445ev5SfiOkBbj
	 Bh5CFP1aH/wKN2V+igHPH1tyFMyaWXvY0e7vHjds629LP7D588fvvGNW9f+0bqi6U8
	 BJTntb+UttZMxIGpV3z5b3VN2OBK0Uaxf/x5+D/5Cm9Lh85sfRNxqhQFe4Bk8DvKqn
	 n6SsCU8kzQtZ9r2YaA0N27QOGJRW8WA71l6zkqMm1CHD8K6ZnUnvcu5udTnKidK85u
	 K64MxSrHAVlMg==
Date: Wed, 12 Nov 2025 18:49:28 +0000
From: Conor Dooley <conor@kernel.org>
To: Robert Marko <robert.marko@sartura.hr>
Cc: srini@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, horatiu.vultur@microchip.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	daniel.machon@microchip.com, luka.perkov@sartura.hr
Subject: Re: [PATCH v2 1/2] dt-bindings: nvmem: lan9662-otpc: Add LAN969x
 series
Message-ID: <20251112-enlarging-deed-f0ca3281f35e@spud>
References: <20251112130213.842337-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k2yE/U1BfqNR5hr7"
Content-Disposition: inline
In-Reply-To: <20251112130213.842337-1-robert.marko@sartura.hr>


--k2yE/U1BfqNR5hr7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable
(Although idk anything about the device despite my employer, I am just
reviewing th binding)

--k2yE/U1BfqNR5hr7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaRTWtwAKCRB4tDGHoIJi
0n8yAQCJ3K01O7eOJJmyiglKn74p0A/nstYW9kAvF2eKzAjCaAD/cJjUsF7zUife
hntWlvxLy7s9ayYUvB+PkWqz7jCb9AE=
=ksNA
-----END PGP SIGNATURE-----

--k2yE/U1BfqNR5hr7--

