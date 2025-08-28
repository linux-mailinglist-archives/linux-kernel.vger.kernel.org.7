Return-Path: <linux-kernel+bounces-790475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BACFBB3A7C2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 19:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB3B21894479
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 17:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12EC1337689;
	Thu, 28 Aug 2025 17:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g96eJfti"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65210334730;
	Thu, 28 Aug 2025 17:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756401717; cv=none; b=I0HybYJqrpdGQ58/VXatEWc5c28eMXsCqIcWCOF1f+qnH8j+qd1TwH543DYMDfDbkUat098j6yF6bXlzEvlu71E5Yt9EwKZsuQT+OGbVkUaq3KDTGyB5yiB4lFHVv8+LEG/O7hzNA9/dc0W1QYsMk2OwTmc5o3IiIxGOUZXaE48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756401717; c=relaxed/simple;
	bh=89YntpE4gZPOG50GWRFi1m+icTQx4/ls24M95AuzsxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qMMYqcgIoYofl/bHpOjYCJmq47ND1JOJZzm0k4izu8DfTCTXxBbthFeo+XE1GEz+dhP8AgmasY+PJePbjxwg+BxqUoaUVgoYbpXQG1XEWevf7XZQgawImLtGMZPC3LVjPl19SoB52xc3y5kshSJng+0LB1g4nhFwujGR1S35M6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g96eJfti; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A392C4AF09;
	Thu, 28 Aug 2025 17:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756401717;
	bh=89YntpE4gZPOG50GWRFi1m+icTQx4/ls24M95AuzsxU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g96eJftifqtu06klKzvK4Ty6vItA/kFVARAOKvluP32FawOgp9Nv5BcsM4fFqvXfE
	 weUlwMM6cCtGaNCVbOCp91h76Zlg8D1ZguGqJFUbOcpGOvgXEMMKVc+qNmzXBxNKyF
	 0aNVBrXaSszgVistb/VtGy2mO1bWLgNeT1ZHXM957zVrKRIWd+3IkoktrYKv+AKQ7e
	 JDtonmUIn2tyTlcCAkHWCX6zWCOLDlXhcoXdK9oFv+RAJ5t6BV0JqwikXyIiPQfoTy
	 kQTLomhG/5w41KFwXV48J+xZMJm/enwD0gdidCZ3rZ5GdaAOAXiGCt9debLoslmVH8
	 1GwgU0injyi4g==
Date: Thu, 28 Aug 2025 18:21:53 +0100
From: Conor Dooley <conor@kernel.org>
To: Grant Peltier <grantpeltier93@gmail.com>
Cc: robh@kernel.org, conor+dt@kernel.org, grant.peltier.jg@renesas.com,
	linux@roeck-us.net, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] dt-bindings: hwmon: (pmbus/isl68137) add RAA228244
 and RAA228246 support
Message-ID: <20250828-bonfire-gulp-94c2160c09e9@spud>
References: <cover.1756331945.git.grantpeltier93@gmail.com>
 <c0c6e99e51b6fd4c5dbab02e02e4d81abe31f085.1756331945.git.grantpeltier93@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OYHz+RiNkpQbmBQ0"
Content-Disposition: inline
In-Reply-To: <c0c6e99e51b6fd4c5dbab02e02e4d81abe31f085.1756331945.git.grantpeltier93@gmail.com>


--OYHz+RiNkpQbmBQ0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--OYHz+RiNkpQbmBQ0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaLCQMQAKCRB4tDGHoIJi
0kWQAQCD8RYrCwM6PpWiJl18lW8xi5JfBq87dZ3jSXryTaVpSAD9ENX1xQWb8M8M
TXyCsNTESndugJnY6PssU+a8wF9gCw0=
=pFCw
-----END PGP SIGNATURE-----

--OYHz+RiNkpQbmBQ0--

