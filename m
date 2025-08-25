Return-Path: <linux-kernel+bounces-785219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88798B347B1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 18:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 917B51B25245
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94270301027;
	Mon, 25 Aug 2025 16:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ecv5mkxg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC1A2F2918;
	Mon, 25 Aug 2025 16:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756139918; cv=none; b=u+FTqNWgS8obHdOIeagY4bjFQos+NIf7FulB9yGsrt/Iigl7uUkVT3VX9sYVpm02l3MRUkB7ajACtjDgV97eQuFNWX6a1/p8NqmYuqkXLeMTa1SEm09JXSDbiYlH28FBpOv2FJ7oPzvp6qF5qUNJnCtOA2vMm2sHTd0VdCmKn9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756139918; c=relaxed/simple;
	bh=CMWCTdGAusm3hQWQsg2CdgEGKQ7dsznpkjRuCSAWWVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YLIYP/2c7YOM6n8wjwQmgtzMK9UhSFXN/Cf6+OTrc0Yp/nDS/JyGRAmz3tftONKFCxyrRaAFnvT4/5sGaiMR3gX3x2zZRFowZComALD1PLLOxOxSNcvLOvcc2pXyPgXzTJWEPFE9V99LpV2Jq0h9w69cGZ3/rBsZ2CmrQIG2p5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ecv5mkxg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D244C4CEED;
	Mon, 25 Aug 2025 16:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756139916;
	bh=CMWCTdGAusm3hQWQsg2CdgEGKQ7dsznpkjRuCSAWWVU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ecv5mkxgN/I8RvhUlsb2sIAZbuxajeGKci91xhxLS+e67mq/3IGp2pManh2kl9JtF
	 juTegqwAkrr/6I7CbaeEQsMNKsNHDQTELIPHwmRQCUZUKrEBhxTNplr921edcyoouj
	 99Li2QuK44VfKmxn7X7JeYXs+fvPNSNDlqpAcXcmeLutceImVFZ/TCQ6eQjtQz3Pjw
	 wUvoa0DFQnub7yXeEYGDrj9RtBUDux+d43iWw7uYYT6sNss+TSs6vHAg05UIrywMLD
	 2MaevT6zdKRaM58sWPA8nqIhWnF4BnZsS3xXDSnSw7Z4fpFxC5umZ6ngnqjM1tBTQf
	 zvX3XZSoYhagQ==
Date: Mon, 25 Aug 2025 17:38:31 +0100
From: Conor Dooley <conor@kernel.org>
To: Zhanzhan Ge <zhanzhan.ge@mediatek.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Project_Global_Chrome_Upstream_Group@mediatek.com,
	sirius.wang@mediatek.com, vince-wl.liu@mediatek.com,
	jh.hsu@mediatek.com, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: timer: mediatek,timer: Add compatible for
 MT8189
Message-ID: <20250825-tissue-rewire-2e74b3f6918f@spud>
References: <20250825033136.7705-1-zhanzhan.ge@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UI+qKYtt++1CWu95"
Content-Disposition: inline
In-Reply-To: <20250825033136.7705-1-zhanzhan.ge@mediatek.com>


--UI+qKYtt++1CWu95
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--UI+qKYtt++1CWu95
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaKyRhwAKCRB4tDGHoIJi
0tFZAQCZfUIEHKet8aipJi3IzMKDa+KfIG5vdjT00QVZWuO/fgD/YdNzRLdgrJAq
cZBGuWpeXaboQnDiisCuiTDzRKtFowI=
=37rC
-----END PGP SIGNATURE-----

--UI+qKYtt++1CWu95--

