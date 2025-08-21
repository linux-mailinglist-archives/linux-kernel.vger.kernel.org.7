Return-Path: <linux-kernel+bounces-779044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2832BB2EE4F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 08:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 779E6568731
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 06:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E51D2D9EEF;
	Thu, 21 Aug 2025 06:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sun3t1hh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8CF2BEFE8;
	Thu, 21 Aug 2025 06:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755758262; cv=none; b=T8V7cHBwhPJupqG3uEMDdBkgOQWvztl7zadZpbgeKiPdu2pVrKNCRcK3o3TgdbOIlLiMyqA2K3r7VdN3VAlYDotazXq8Izx9hgwwTa+GtcDq3AV7OFDHMuWGxK0ZoMx1lC0FSpL25UnyJXjCTRzU/pqmtHTtBlgNgT6ivqqL7ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755758262; c=relaxed/simple;
	bh=AXMmQlL5kvjii97BT5wuk1EpAnCzrmI+u1fqWegbaGU=;
	h=Content-Type:Date:Message-Id:Cc:From:To:Subject:References:
	 In-Reply-To; b=mK1ZfyWp2sjq/VVOhdWknL6sOcC3wewa6jnNVNvAX6l4DgixOiz7xgKbZM4XVqTyom0POoQ1tcmP/gcXGNgPHNC1dSX77VZ2NpFXilnACi/Mj9G+AW71qpGWgT1x1sL1gZsqA5K5Eo04BxFJUSwkMaXLOlII5+tE9tveFHsJ7Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sun3t1hh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 830CEC4CEED;
	Thu, 21 Aug 2025 06:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755758261;
	bh=AXMmQlL5kvjii97BT5wuk1EpAnCzrmI+u1fqWegbaGU=;
	h=Date:Cc:From:To:Subject:References:In-Reply-To:From;
	b=sun3t1hh94JMitWYhgzcEdQC+GHnoLg1ovIto7FsMhRP1PUlJNaDUccJ3SzuWnlkF
	 EfDQhEGK8dIlRQCuhX26NC1uDqIVr3aWizuBSmnCgZOO2Amz1Z+p0iPX2ViDlcxM6l
	 IuF2uMc6hJc4DAFxX/aTkd03u4/mUJvElnTuOPHExjUWDaLOgIklK5W/0e5f1qlLjX
	 b04JaLEaE1jqjX7b5xeCGqgXqL2//bW6UAMOBfHv6rdqC6qyVI9M/0DwvU7VYNAYT1
	 C/0n3Gg+3SROzv0Uyd4yZwO7NV2+N7S1NOqMZBtfmkCa+Pw/M4uyfSkjAxAonZie+I
	 oXaWAqWI0DGQQ==
Content-Type: multipart/signed;
 boundary=6e0bd8a8b640f082cfb6850cca9df390417e4a46f66449d7859a78f39371;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Thu, 21 Aug 2025 08:37:37 +0200
Message-Id: <DC7WCWIUD576.1YXDRIK1OSR8G@kernel.org>
Cc: "Mathew McBride" <matt@traverse.com.au>
From: "Michael Walle" <mwalle@kernel.org>
To: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Benson Leung" <bleung@chromium.org>,
 "Guenter Roeck" <groeck@chromium.org>, "Tim Harvey"
 <tharvey@gateworks.com>, "Lee Jones" <lee@kernel.org>,
 <devicetree@vger.kernel.org>, <chrome-platform@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: mfd: Move embedded controllers to own
 directory
X-Mailer: aerc 0.16.0
References: <20250821062840.9383-2-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250821062840.9383-2-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--6e0bd8a8b640f082cfb6850cca9df390417e4a46f66449d7859a78f39371
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Thu Aug 21, 2025 at 8:28 AM CEST, Krzysztof Kozlowski wrote:
> Move ChromeOS Embedded Controller, Gateworks System Controller and
> Kontron sl28cpld Board Management Controller to new subdirectory
> "embedded-controller" matching their purpose.  MFD is coming from Linux
> and does not really fit the actual purpose of this hardware.
>
> Rename Gateworks GSC filename to match compatible, as preferred for
> bindings.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Not sure if I can even ack that, if not, disregard it:

Acked-by: Michael Walle <mwalle@kernel.org> # for sl28cpld

> ---
>
> Cc: Mathew McBride <matt@traverse.com.au>
>
> Lee,
> Can you take it via MFD?

That would be good, as I also have a new patch series (planned for
this week) for a sl28cpld compatible "sa67mcu" embedded controller,
which touches that file. As it also contains MFD patches, I'd expect
that the DT changes of that series also go through the MFD tree then.

-michael

--6e0bd8a8b640f082cfb6850cca9df390417e4a46f66449d7859a78f39371
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCaKa+shIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/hl1wGAtUsFu6ERO54ALkWdfzQLlwDcBnVp8Qzs
3YXN76+ZzparZalD55wi9eO5sumO8DyOAYDvDL2SA+j//XLuslZjZ1elBrLRuo4Y
kwPLZdkE5CigSMCUCcxk0SAcP5S1T+eSAf0=
=t/V2
-----END PGP SIGNATURE-----

--6e0bd8a8b640f082cfb6850cca9df390417e4a46f66449d7859a78f39371--

