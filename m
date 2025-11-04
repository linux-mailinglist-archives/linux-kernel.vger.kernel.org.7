Return-Path: <linux-kernel+bounces-885230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A249C32556
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 18:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7361189E47D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 17:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA75733B6FC;
	Tue,  4 Nov 2025 17:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O09p6ApL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427C3337104;
	Tue,  4 Nov 2025 17:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762276904; cv=none; b=L2gbK1oW0sPHfjn1WeYH1ZIFFHHbhim54toZthwRx9XimHwFS46u45amc7EKvQi3zgJ+oTiEePcj0qGAuakviqN/qGoIJCT3j26JFhJ43efctM6aUofgpmo+IAVyUibrYXBjB2C4boMLiUUqNPmTNB+jySbqnhjLdJDEZKnK2ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762276904; c=relaxed/simple;
	bh=8EJ06/xu+MF3npKBmkZkcX4nKJgZvz6INMbxir4/Xe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ahjA5JA0fpHBRoPSDz+xlx7RdJJ7woFHQfZtaB7oB9LsxY/kajPAsgz6X1SwndRSlcT6aVY9HRLzmTV2qF1adshp+4BeMqk5JAaNS387Us4t1/VQuuHOdMhkFfW1yn32NwdfC9xWFm69mCIQ9BqJfAxxDvc3usIByknIHx8X3Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O09p6ApL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C666FC4CEF8;
	Tue,  4 Nov 2025 17:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762276903;
	bh=8EJ06/xu+MF3npKBmkZkcX4nKJgZvz6INMbxir4/Xe4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O09p6ApLebmrl/aHzF6TcAoaXfhDCrzMISaQ5q8vGfdY8Bd6AIySyugt1StuAtiar
	 ozDRdquvT8cnFImmxDdKkLTu08IgDACEku9FuBDOfWnqsrVwDaq4S016OwF2C4P8Dx
	 Fve71DPcsTCjSmGb0ZQszdeS3QxPKwBTpvRIeGwgNNaMJEZlmBzmjiGTQd+lGutRe3
	 3eu26Fs9ShJx51vYDGf58SqAjHdICcA0pF01t6Gxd2kZwEivF2ZyFdVJ555Fj7rx+T
	 WuYKQXsdojm6sHUUbGlPmeG9garKVVzsMsj+ppOuaOgr7KlPZgCltdQYcUUNlO9O6T
	 orin7P94k+zxw==
Date: Tue, 4 Nov 2025 17:21:39 +0000
From: Conor Dooley <conor@kernel.org>
To: Gatien Chevallier <gatien.chevallier@foss.st.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: bus: add stm32mp21 RIFSC compatible
Message-ID: <20251104-cycling-paralyses-8e99cda7944c@spud>
References: <20251104-rifsc_debugfs-v1-0-7ebdfbf8d33f@foss.st.com>
 <20251104-rifsc_debugfs-v1-1-7ebdfbf8d33f@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Ja5NuCERZEEhWodx"
Content-Disposition: inline
In-Reply-To: <20251104-rifsc_debugfs-v1-1-7ebdfbf8d33f@foss.st.com>


--Ja5NuCERZEEhWodx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 04, 2025 at 02:54:10PM +0100, Gatien Chevallier wrote:
> The STM32MP21x platforms have a slightly different RIFSC. While its
> core functionalities are similar, the wiring is not the same. Hence,
> declare a new compatible.
>=20
> Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--Ja5NuCERZEEhWodx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQo2IwAKCRB4tDGHoIJi
0sdCAP9L1bHKFI2Qo75eH5i+O1mmMlb2f4QGSM0NNzMxwNGoRwEA6NFzMMoR4anc
eHAn0FSEmUesoeTP9grmuAiPkOVScAw=
=8oy3
-----END PGP SIGNATURE-----

--Ja5NuCERZEEhWodx--

