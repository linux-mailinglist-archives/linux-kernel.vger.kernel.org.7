Return-Path: <linux-kernel+bounces-833085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 603BBBA12D5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 21:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67BCB7B1B94
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 19:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A7631C56F;
	Thu, 25 Sep 2025 19:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KybBiZJ0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E6731A06A;
	Thu, 25 Sep 2025 19:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758828478; cv=none; b=JBjsUvAy5ECnKnQ23hmjT5PEdRDq20ERHzP2QmaRcrrIzxZ38T/R4I/kt3tgStPzfiRbatBYow8xXebDrA/hMmKJFbxPazOVnKxF/bTkI7D3SLB635al2NjhFMzgH6ukHYpKzepNuljrS6lYT9uNxjWdIrEYfK439AsCfSIn550=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758828478; c=relaxed/simple;
	bh=SGyD42+nLFRtpF3/nqqtTJzH1KFD5FuhGSNA+fxfXeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aMcM4Jq08njjK42ARQiRsrwQdvmjiD2p8EPDVodkpJ+xhUytXxmLgO06ISn3rhFgxZeEi1vaqpgDGIc/7LjrnvZO91FyOFnyg1d17Ua1QVguO/EyWOcG65qDWcn8FyzjvN4rJkwczQ4k6nVLyw8ACTXj16HZfMmDaazGeSOBJYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KybBiZJ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 608D9C4CEF0;
	Thu, 25 Sep 2025 19:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758828478;
	bh=SGyD42+nLFRtpF3/nqqtTJzH1KFD5FuhGSNA+fxfXeM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KybBiZJ0ch51ly9WQsjmpgbbq20GqiUSeM4iBIdm2j2C/eBB3CK3ihYFy65E3q6gS
	 0zhDCrME8xglux+xfW16Eg7+PCA0WL0EMNSq6XxVpLYVoFI6XVccwAEkE/b3ZVuDyd
	 0kwk/rTBxJ5ZjrdDv13YCsRergtm++rBm9C3RUQk5MyFw2sCB3C2jsB6lz9xtO8FSZ
	 Jhbsfts4Yycfgp2AI8+xmeWdhSZat7nw6uBZ2gVROh8DhfhYJ+a67ub3jbpQwn9PP4
	 ClcNsE29npPnzCgmhL4Xchy4WJqn0HBP4dvLhZ8qDXbbToxU24QcODs7QrFZRnWxx6
	 9Zn2YSyPKV+Wg==
Date: Thu, 25 Sep 2025 20:27:54 +0100
From: Conor Dooley <conor@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	ukleinek@debian.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 5/6] dt-bindings: arm: rockchip: add TS233 to
 RK3568-based QNAP NAS devices
Message-ID: <20250925-reborn-degree-799bec1f7ac6@spud>
References: <20250925092923.2184187-1-heiko@sntech.de>
 <20250925092923.2184187-6-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9TWnaI4DxVO0LRhz"
Content-Disposition: inline
In-Reply-To: <20250925092923.2184187-6-heiko@sntech.de>


--9TWnaI4DxVO0LRhz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--9TWnaI4DxVO0LRhz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaNWXugAKCRB4tDGHoIJi
0pbdAQCojilOiu15Cp5rOWVEo/mgDL7lkFMrQJOB+gnddLSxCgEAxbpFBqLtIMqY
It1eK6buLLxrthe7e42mim6YLkdzcww=
=wsJB
-----END PGP SIGNATURE-----

--9TWnaI4DxVO0LRhz--

