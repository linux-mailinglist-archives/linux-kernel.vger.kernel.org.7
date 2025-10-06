Return-Path: <linux-kernel+bounces-842639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F3999BBD36F
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 09:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 027BF4E84D9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 07:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A88D255222;
	Mon,  6 Oct 2025 07:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EBSv25hh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD87E128816
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 07:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759735869; cv=none; b=WP2S2u1dKXJ7JcUAk9irkn5HLf/Q+9vPWr7iYcs/YEXmYAcYjldsD+BajQq7lr9Xil9Q82p8mRTm/vyQRylVm5PVQtO1uALPR8qpIzTOS1WwV9opzJCVUBeFcqpnfOG0bkayH2QLxK3atnhnzD1yP/U0JlX/S8hPPiHAHaUHL/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759735869; c=relaxed/simple;
	bh=mM7urDSfiUgmzy+qrvcD946ewqFnOZ1jRDkeOVUWxIg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=A68PgxxQ+vUfn47R2Mfn15OQMgq9Muxmct91SUdTf56T6mgLEmR57RNB7kHqMSSQWJCSN1c+/rap0IUztdK/lun4TGmPAU0xfsbZWo4ymEUJltN+L95RMOaXomcCXW6IxPKTwJxaqEvWZ784uM1MAcYeN6YUVdrQfVCC43gq+L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EBSv25hh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE102C4CEF5;
	Mon,  6 Oct 2025 07:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759735868;
	bh=mM7urDSfiUgmzy+qrvcD946ewqFnOZ1jRDkeOVUWxIg=;
	h=Date:From:To:Cc:Subject:From;
	b=EBSv25hhqa9qSZoYASSbg+PrUkCl3oT7Pm6X1tMajmcl0cJCEY7SvODEL31VgAyGc
	 BlydO5ETXNdVy7ZWFa0bZqWSUXqWKbguK/Hb++sm3GnAfl3vYTF171bLngMQDk6C6j
	 Ailz3gR9nRttx/6OZxmqS+L8UnxukRIhsG/8JAQ4EJac/BEG3yZ5TnSXJs7tjWQ/Hz
	 +x8MAXV9ERdx1DfDFlU9gDrGequsXPfxbFv4N2J0jjdhIir+pTUQylM7UCa/d91dXk
	 9ujTCcaQ0vM6TCkXwnwBk/KnEWn+fWrOwePXgORZ9/ttHXhl4mocCCneVYx0bEEqu4
	 K+ZrMWppG5bRA==
Date: Mon, 6 Oct 2025 13:01:04 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: soundwire updates for v6.18
Message-ID: <aONwOOvxYbnygl4U@vaman>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6nwThBXH8ovDbKhg"
Content-Disposition: inline


--6nwThBXH8ovDbKhg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

Please pull the soundwire subystem updates. A very small update of
couple of patches this time.

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/so=
undwire-6.18-rc1

for you to fetch changes up to 88f5d2a477ec64b12e83b488407490bb4a9298f8:

  soundwire: Use min() to improve code (2025-09-01 22:48:22 +0530)

----------------------------------------------------------------
soundwire updates for 6.18

A very small update this time
 - add few registers to debugfs
 - core: drop dev_pm_domain_detach() call and min() to improve code

----------------------------------------------------------------
Claudiu Beznea (1):
      soundwire: bus: Drop dev_pm_domain_detach() call

Qianfeng Rong (1):
      soundwire: Use min() to improve code

Shuming Fan (1):
      soundwire: debugfs: add SCP_SDCA_IntStatX and SCP_SDCA_IntMaskX regis=
ters

 drivers/soundwire/bus_type.c | 3 ---
 drivers/soundwire/debugfs.c  | 2 ++
 drivers/soundwire/qcom.c     | 5 +----
 3 files changed, 3 insertions(+), 7 deletions(-)

--=20
~Vinod

--6nwThBXH8ovDbKhg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmjjcDgACgkQfBQHDyUj
g0f1BQ/+OsmwAu5498qN28EiilWbO36w1SiNYRlACfEiAaGVYPedQz8aMjnbV59k
ctSCVrfVUZ4ZXVENDv3f09jJvzP2KrEd1+LN3W/Chmkerk8u2zpD2AGdv1gk1xkh
tjKuI7O9EUDnqhsDqJA7ecPEwCR0d0wHo8Fuckpj2n8MDdoBk8TSB75/HGAywD7N
2J1GlujIFXjmxPrDGvHnU1zzUwVUNGfP+/0Q/oHl034YRJSAhZA+7VNHNDkV92UR
Z1bnQL3LRxl9g045UAIH5EHIULsz5KNJmewWXI95pN8PN9Oqo7xIWARMLWGdQeap
D2TN9pcI1lyWvau6i/Lp6daorIKx1eHn2QIjJpfi9FsXoBrsrazR87q8FpAOnfTB
58V7V1wZEE+Giw4eREiNLXuEhUn9eSqQQc7gFj8gtxsiN3niqjB2FTIITIzXRgHE
q1ZJNaR+oE8tXuPehb72ioDVzlqQLwsxEekuB55gLVpGGHptzFQz8mGZ8d1qWL+8
dBimgWN4IeVEKQ2Xlre1tnG2E+gxm5EksL+d8mOp/wXotkEtVQfcSpKMP4RiCMnS
5wG8Wv4swOemgtgzdK1qAwS5XKtHiZvZ1O4CXemGkqG5Yq5xQjy7FJ+wT+nPXsfh
yGasQaRGBEGXRegDjPHj+/V7LcQO6vLNIFIweJt2ITFdGYS/Eas=
=BoX6
-----END PGP SIGNATURE-----

--6nwThBXH8ovDbKhg--

