Return-Path: <linux-kernel+bounces-817559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A5CB583C0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 19:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DC623A86DE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 17:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DAA28A1ED;
	Mon, 15 Sep 2025 17:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y66p1jTL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A44B1AC43A;
	Mon, 15 Sep 2025 17:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757957717; cv=none; b=DP2nR54TS+nEdPYPC0IxObZBA9/xq3CAkgY7faPcFuPpSgocGZqO8VKWGLqElZq7KZRsblXScx1Hufegq+6qGGarIMv4/yFW+Anv8J9YhsrxVufVNfNDSrLdkaWCXs96d4JpWTOXvoB7mOu6IjIagL1gD8l9sXMTsyaPR7FhEmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757957717; c=relaxed/simple;
	bh=QWTOKgLOOY24M0pxF9F1dUC27aChqSXrt5C6h0tpwJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZnCmgkrDSbSfS0rYmkaLaoJxUHc28N532o6CKycUEaQjxcchkyY3oxKmObWV/PD/JOK5/ao8aPaw66k3L08SM/5WMiN6ilVUK8HlMhdwiPt33JYo4Ws86bq5bRDluWU99zqZbL1FYWK68yst26YDakO7MRRo9HTJTP0MvdOHzb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y66p1jTL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC697C4CEF1;
	Mon, 15 Sep 2025 17:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757957716;
	bh=QWTOKgLOOY24M0pxF9F1dUC27aChqSXrt5C6h0tpwJ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y66p1jTLGfNH1CHVRjUMkiQQyTa7Nfh3BiCJK31oRTgWi/VEixJWbdRuP/VZkZ1c7
	 nHc7h+KseJ2ZJhtv4LG7BAgER1KoOwJgSDfuoVjNwsTLoOodVxaDF5kmt5561LDiM7
	 klaN2hcu0Q6wE3NMXmGezUjlyLCvhN9ULXsy4u/C/q05eeV8QvAJXfNgXstBTcP1Ek
	 EvZtqIGKqoLl6FmDrDlyTtlXLy6INxqTDfgEtNsV4D9YRlG/rhMq3RpOefnGBksT+6
	 rQ0FvDq+Qi+ttaVS/Ni8vUV4dZYclzrFz12MSL0+gaxcteUKhvk+fpJC4c5f1juCaN
	 2wakMUKlT/e1g==
Date: Mon, 15 Sep 2025 18:35:12 +0100
From: Conor Dooley <conor@kernel.org>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] dt-bindings: usb: uhci: Add Aspeed AST2700 compatible
Message-ID: <20250915-whoopee-badass-a748ee552ae0@spud>
References: <20250915073926.3057368-1-ryan_chen@aspeedtech.com>
 <20250915073926.3057368-4-ryan_chen@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5Cw8QBaR2mcfITFg"
Content-Disposition: inline
In-Reply-To: <20250915073926.3057368-4-ryan_chen@aspeedtech.com>


--5Cw8QBaR2mcfITFg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--5Cw8QBaR2mcfITFg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaMhOUAAKCRB4tDGHoIJi
0s/DAQDd7007M9Dd8rFjGYhhADx7JfDCpm48I2J3engY+yTqewEAjuhfn3DTq6MB
VbjcWrpGmYeAQg3bW1Gb6Jo6YdwR4QU=
=gKal
-----END PGP SIGNATURE-----

--5Cw8QBaR2mcfITFg--

