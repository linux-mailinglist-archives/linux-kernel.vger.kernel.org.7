Return-Path: <linux-kernel+bounces-836651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 512D2BAA3B0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 19:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B83CF7A2611
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 17:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D8421C9E1;
	Mon, 29 Sep 2025 17:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ViAKnlkz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B298415442C;
	Mon, 29 Sep 2025 17:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759168163; cv=none; b=D648z20aRY/CesCXOBsZiL8ln/ABrFFBdtSSCY48iRyJCv493LGnef1NBR71R96LKpOSAdyUHZp7j6e7Dg7+OUX1RUJveB63PvLkYQpZMWX1zmHWgf0RQ/1OEwkKwSRpNRbc6vaBlxRpcUh0Giqd7GoIjzO/KKPFU/rleV+qNC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759168163; c=relaxed/simple;
	bh=soLluZgeSmqgsmOBHJcCPda1vU0ZJi0dJXO96pm9yUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M9RR3Pjn9zBLlzc+mVG/1pQ+7QEpddD9h7OQLTfnIn33mOnxf4SjbFRRbWi8Oepsdt8cEyeZxJBOVDxIsmBUAiLD+IAFIVWlBR2Ouio8DsgNvkzPXkiGmeGQ7bOipfBRwQjUiAu4JpLif68sDNuLFyA/HB+VvjaiFw6wszpV2Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ViAKnlkz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08AF0C4CEF4;
	Mon, 29 Sep 2025 17:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759168163;
	bh=soLluZgeSmqgsmOBHJcCPda1vU0ZJi0dJXO96pm9yUQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ViAKnlkzzXET5wwfMyvm1xC0DmknH7EfkpmjRb92WixqJFyGvCn2z+WMV9Fyc6kUc
	 H7OgHGIJoSxQ6sp63SxWJUQ+d3uW7xsuXRSMPo1zlTvcJP8YBZ8ZNi0iScJG+oKz9K
	 JowbAnDH6kijVEakdb1PhYFroGKY/haao1MB9R5iz6H5lhnJMKjNj8ZPSnwXkLls5a
	 h5U/LKY5Bz11JiJjmSAJ0+2GAEZ/wb5FXdvkv745DMqMm/Iq0P0Sg218nOboa4jabs
	 +OuKHWOKQg/6mIU6oDd6uXfWLNdt9i+evAa35I1fbX1COi4jBu4GhtI0zOHG8Rq88E
	 sLXKhjX0DomIg==
Date: Mon, 29 Sep 2025 18:49:18 +0100
From: Conor Dooley <conor@kernel.org>
To: Christian Hewitt <christianshewitt@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: arm: amlogic: add support for Tanix TX9
 Pro
Message-ID: <20250929-geometric-massive-7ebe6c6c7c15@spud>
References: <20250927125006.824293-1-christianshewitt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jdhi7zx2CJL1nOyr"
Content-Disposition: inline
In-Reply-To: <20250927125006.824293-1-christianshewitt@gmail.com>


--jdhi7zx2CJL1nOyr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--jdhi7zx2CJL1nOyr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaNrGngAKCRB4tDGHoIJi
0lVDAQCj0EH8sKppN9fcZi8CL0ZzlYbuvLG5lN9ZfMsnhBU5fgD+PywrSMAcHnqO
7xsSNakZ8ZVUV/XWH+AOuRzZicayCg0=
=p03h
-----END PGP SIGNATURE-----

--jdhi7zx2CJL1nOyr--

