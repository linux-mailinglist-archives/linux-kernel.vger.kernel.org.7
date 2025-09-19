Return-Path: <linux-kernel+bounces-825025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D23B8ABC4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 19:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0D5C1C23292
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1F3271464;
	Fri, 19 Sep 2025 17:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AlnVEepW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CBC2253B0;
	Fri, 19 Sep 2025 17:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758302424; cv=none; b=L4w+ZGg8AS4yX1YrMUXHtPFZFfKArH/KKS9o8n3XGbsmbi7ql1uJJeWuy8YqKkDTjiqhUt0f2eNuXK3AZGK69mKRx1T+L9BbD+Mh7hq7SHjLQmb1Lest00iwiPLMVK6xgdKe/kcLrjeCXOMbNd471Hlv5LTLrFiyFKbQ89QhUTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758302424; c=relaxed/simple;
	bh=piPFu+cMpmpbBtwW/KgBv/3Pl9j2EwCCE9vhSTtvT+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mfnQrP2pi+/YU+Jj+20vQoD09QxZsjZYjcXp5xgRMYbM+EINHq8k6loJVZt/yKkmqQuhHQJrzwXeBB8m5N5zm39EgLKl2t+jahti87jgJEOaUh2ThZyIM0FqacT1mp5dqM62nAjdc9/Fpy6p+SNfze5INdZKaN9TXLSR46AMLhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AlnVEepW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B395DC4CEF0;
	Fri, 19 Sep 2025 17:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758302423;
	bh=piPFu+cMpmpbBtwW/KgBv/3Pl9j2EwCCE9vhSTtvT+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AlnVEepWxHalo5mDInuATYumccjTzTky/qELxnGG3oDJtRmuG0tAZx6+2TY5uaTeR
	 0arw3OcYJX3p7w6obN0kQfqfGEf+L/PGII+JBvFvcgltm37vVFg2nDK/7B1oow+CZx
	 BwWveWIHGZ0fOoBIdhrYr8m1zC6u24Ry5M4GmEUmgQgJzuoeFkxUiML05VCgwYsKQH
	 LaAw2AeKQ/TnJRqX76G7GDJXPEESetpw2DnaeC+wQZILuQ2EseTfTbSOnkOkNAq4Cx
	 a+P1FJk5dMaNN72lKt+yC10+A8N+s3BwCCg3MBBKKgRJzTR36DF/QmKbMbZ3UPxHgF
	 1dUwO+TNAOKng==
Date: Fri, 19 Sep 2025 18:20:19 +0100
From: Conor Dooley <conor@kernel.org>
To: Marc Olberding <molberding@nvidia.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: arm: aspeed: Add Nvidia msx4 board
Message-ID: <20250919-retrace-lego-31dde220b234@spud>
References: <20250918-msx1_devicetree-v1-0-18dc07e02118@nvidia.com>
 <20250918-msx1_devicetree-v1-1-18dc07e02118@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="R02dLCybvaecFiaK"
Content-Disposition: inline
In-Reply-To: <20250918-msx1_devicetree-v1-1-18dc07e02118@nvidia.com>


--R02dLCybvaecFiaK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--R02dLCybvaecFiaK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaM2Q0wAKCRB4tDGHoIJi
0tVwAQCtT8kAmJaiRiYCHAZ9+okhbpCV4iRU7npKt8xpiaaAGgD9FrWGFrB4qeYy
Lww4rVJvvHOciqSTshRRzKcBT66riwM=
=CCD4
-----END PGP SIGNATURE-----

--R02dLCybvaecFiaK--

