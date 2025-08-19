Return-Path: <linux-kernel+bounces-776285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13589B2CB47
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 19:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A76771BC5215
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 17:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E12930BF71;
	Tue, 19 Aug 2025 17:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/MoSGe8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6922C1E489;
	Tue, 19 Aug 2025 17:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755625592; cv=none; b=SkQtcApGpl982jtwFnKWZyKJ/JOmoDu8PT3Mb4KBx9sQWURH4XV4JO5KlG5Gbe8tIpnlq54FCOEoEmsUgRlaAkUQeGR0QokhXm/9lhIIEOibXvZjTMm2QT+4/aNRv0j9bReNb6wRhE3eyhyzL7mcj0doXse7rYFUHRrN2onDziU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755625592; c=relaxed/simple;
	bh=SW5RXsaoTZMO3L7MVmnLPWOD9kCXxsSPjnjHmdPSzNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AcXtkHC4sRUGqUtBqm9cf9vpgUp8AKSN3Pnea9YIVEqG4UwRfCTrYXHCnn1J9+cQE1EUPz0M9BQ2096YWBTpzDZYteYQJep/4vNdApNpaX+XyY/gS+YnkUomxzxxab3xIzwWrwNVfplTmUm+stszBvQq64i4HO/MAA1qLN4err4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/MoSGe8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FD40C4CEF1;
	Tue, 19 Aug 2025 17:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755625592;
	bh=SW5RXsaoTZMO3L7MVmnLPWOD9kCXxsSPjnjHmdPSzNY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q/MoSGe8mNFWOhu9UdrTSL++yd9XMX6sovN4043gu3uwz4apOiMsXHefG8XYx2ASz
	 u6+TxltcwXEwNGWnlB5kA4tPDg1sPrxsiLGb8ve9xbUfRcaQvS4yAKMi4Mple/LhrB
	 neOuh9LLLBVEcKzcWHujXx3G4BXu4OVHWjX7P6Dtm3fw/0IMPsiH7hebGiOPemLT9C
	 69/+3/OXQjRyift62vVSXHni/PQ7Jvlxx8SMruy3CbgQY9TK57wllHzIpwpWCqCVWp
	 3x/V93tSursuW7++1vXF47LXvhzoaM42daQC82k4lESPwVWl2iVpvAkKsDgVOAZ0X7
	 FNE0yhWhpr60g==
Date: Tue, 19 Aug 2025 18:46:27 +0100
From: Conor Dooley <conor@kernel.org>
To: Mateusz Koza <mateusz.koza@grinn-global.com>
Cc: angelogioacchino.delregno@collabora.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
	marcin.czarnecki@grinn-global.com, b.bilas@grinn-global.com
Subject: Re: [PATCH v2 4/4] dt-bindings: arm: mediatek: Add
 grinn,genio-510-sbc
Message-ID: <20250819-cilantro-likewise-c05598130f86@spud>
References: <20250819130231.181571-1-mateusz.koza@grinn-global.com>
 <20250819130231.181571-5-mateusz.koza@grinn-global.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="M1EmyOgt2pNN1sUX"
Content-Disposition: inline
In-Reply-To: <20250819130231.181571-5-mateusz.koza@grinn-global.com>


--M1EmyOgt2pNN1sUX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline



Acked-by: Conor Dooley <conor.dooley@microchip.com>

--M1EmyOgt2pNN1sUX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaKS4cwAKCRB4tDGHoIJi
0txiAQDk/OW0DYIQ0yHsK6fT+9/UbqkFjCUTxVBCmoBai01fQQEAtO9abF18VjHJ
9moXkwimE1EOng4bPEsfg1pzhQXi5Ac=
=Znqv
-----END PGP SIGNATURE-----

--M1EmyOgt2pNN1sUX--

