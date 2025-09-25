Return-Path: <linux-kernel+bounces-833079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B041BA129B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 21:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BBAE3A7895
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 19:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB7031BC90;
	Thu, 25 Sep 2025 19:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VVt2Kqu2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8C51F4625;
	Thu, 25 Sep 2025 19:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758828302; cv=none; b=WuBfYPrkR6AfRt0hfv27oWJvqUS7qKX0p2qVFyDOCT0/FRTKBCBi2Z+JOWkUQMBlJttr2Q1cBNID6tJx8/XYfm3ecpVeDEjireLQYlFXubuqaV157h0XrW5WOgzCEZZkqTQMtCjcuYqFg0p6olzQUXFfXCTZeW3CIrDrMFHmElc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758828302; c=relaxed/simple;
	bh=b6y3E0Pu+opi8bzUWKgkUqsnKvWRIRG8kX5WciKJSW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lps5H2xOON8QDN0PZSBuTX1rCrVbIfxa6tt4nCKX6JxF8/wMuvAS79zMQgZ9t7rBWkzAq7YV8axEg12Bgk4riEhcdshJno+CjUR1BlRcnNArUKEHw3HN/ESxEbeEyxl1O6wgKntxlQluPIWXm8yFAyrY1nhf8dXHpj+gAU6csWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VVt2Kqu2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CA09C4CEF0;
	Thu, 25 Sep 2025 19:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758828300;
	bh=b6y3E0Pu+opi8bzUWKgkUqsnKvWRIRG8kX5WciKJSW4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VVt2Kqu2ERuWAgl+4m/877EKbd51UL66OPOPQThE8HD0FWaK0G6FEJ/KhVEa7qSGF
	 kRGDHk+etLeOvrpqTeKXKopRLuIIkDonqmL148ZQ5Hxrt+lPon+vfBCB+hfy1DW3OP
	 id/5LrWBKRzz5ej305OxqPg9AjUVEACnZ8SirvvNe1FsXVLeJ3GZjrWkkrjp8aTIgN
	 GC7vL8NfQ2prIhOThp4Sl1g/95qV3Nm0JmBxL/e96UR3bAczNVxQEVfJyl1+tw8M7o
	 dDQM0lC0ow1BlhncvVMYCXG/GQagnG4x1vgJqrnvpvWrJJgZi9CvNrTvs2iOt6lu5E
	 3lmnXI6MCc2Xg==
Date: Thu, 25 Sep 2025 20:24:56 +0100
From: Conor Dooley <conor@kernel.org>
To: Harrison Carter <hcarter@thegoodpenguin.co.uk>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Brian Dodge <bdodge@arcticsand.com>,
	dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: leds: arc,arc2c0608: Convert to DT Schema
Message-ID: <20250925-demotion-decree-22fe36d9757e@spud>
References: <20250925-arctic-sand-v1-1-735b5ed8faed@thegoodpenguin.co.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Sv4rOuQC8mDbAU4F"
Content-Disposition: inline
In-Reply-To: <20250925-arctic-sand-v1-1-735b5ed8faed@thegoodpenguin.co.uk>


--Sv4rOuQC8mDbAU4F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--Sv4rOuQC8mDbAU4F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaNWXCAAKCRB4tDGHoIJi
0ouaAP9rp7lf/wrbmh12i3bUlNaxg7uk+gWlydlfQrQA3rD3AwD/ddi57BTrxPYD
u9N3vE39RVkhR8/MuNONSlqy/k0r5gE=
=I25W
-----END PGP SIGNATURE-----

--Sv4rOuQC8mDbAU4F--

