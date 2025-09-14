Return-Path: <linux-kernel+bounces-815759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94EC8B56AD9
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 19:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0736B3B8CE5
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 17:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C8D2DCF46;
	Sun, 14 Sep 2025 17:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eft0MjL0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947C624A044
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 17:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757870987; cv=none; b=K3wDU+DNWwbKMXma+/II0QA+XIPw0exwJtO6oaBRonN5bZLBB9XatSHpoS4Bw9G8Cj3wGEDaOtBgBCs1j3sO9cs1aTLCh1Ja1ZgVtGMJ7zdxsmlznUVtsTNH/t46b0K77KGntuVNsMzrS1Qu/77EMdeLb9es2AL9YXSYJ6yxHnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757870987; c=relaxed/simple;
	bh=t3p+pSov61SCYmdMy91pdQkGkd+PsnOB9W706gIJFPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UY+Jn7O/HvYfpEGPUndkctDm+9UDHJ2D/2TqPsPrXpR6JsZzI/ffnsBgjQuJqJ2HqSrlNtkUmq+mNWsl1kAupbWd8OUSMqXWnlzXN9vAMiSxvrxFhpbPA8TJAp0iEc+VL8hZMrIbkD7KKVo7et+CZr0l5ezs3Fotd+zFROrir1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eft0MjL0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93313C4CEF0;
	Sun, 14 Sep 2025 17:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757870987;
	bh=t3p+pSov61SCYmdMy91pdQkGkd+PsnOB9W706gIJFPQ=;
	h=Date:From:To:Cc:Subject:From;
	b=Eft0MjL0FM7904ZiXv4rP6XCP6JFYYY12NIDuzFs+M/aeZnIFV/gBNfB7EIM+KOWC
	 nMkRYIQbcD+qAZ7QuiP7HDZRzapdntDGJtLVO097EndfTTKsBJkZvOJzSiJtMeyXAB
	 OGX0L9KsrOMyBGIIPWx3dhZgLiUPjYUMCxK4WuBrb0ebhtRLuajJ6SZEyaDd7DTQDu
	 9aaw9UejqEqXKS0nryUyzpuC/7IxHoZV2ZhT+SbKDSlKSvysDTy7Iq7sbqVrXc0R6q
	 fLjteqYcstPGqXGHF5U8jZ1hWZgCDaorNdkBze1eVEw1z/i/AXyBqI9kxRd+JBibS7
	 TXhUiCMrR6O9A==
Date: Sun, 14 Sep 2025 22:59:43 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: dmaengine fixes for v6.17
Message-ID: <aMb7h_VKd-2jMK56@vaman>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2CnvgaFZXkwUqa9g"
Content-Disposition: inline


--2CnvgaFZXkwUqa9g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

Please pull to receive couple of driver fixes for this cycle.

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dm=
aengine-fix-6.17

for you to fetch changes up to aa2e1e4563d3ab689ffa86ca1412ecbf9fd3b308:

  dmaengine: dw: dmamux: Fix device reference leak in rzn1_dmamux_route_all=
ocate (2025-09-02 15:01:51 +0530)

----------------------------------------------------------------
dmaengine fixes for v6.17

Couple of driver fixes for:
 - Intel idxd fixes for idxd_free() handling, refcount underflow on
   module unload, double free in idxd_setup_wqs().
 - Qualcomm bam dma missing properties and handing for channels with ees
 - dw device reference leak in rzn1_dmamux_route_allocate()

----------------------------------------------------------------
Anders Roxell (1):
      dmaengine: ti: edma: Fix memory allocation size for queue_priority_map

Dan Carpenter (1):
      dmaengine: idxd: Fix double free in idxd_setup_wqs()

Miaoqian Lin (1):
      dmaengine: dw: dmamux: Fix device reference leak in rzn1_dmamux_route=
_allocate

Stephan Gerhold (2):
      dt-bindings: dma: qcom: bam-dma: Add missing required properties
      dmaengine: qcom: bam_dma: Fix DT error handling for num-channels/ees

Yi Sun (2):
      dmaengine: idxd: Remove improper idxd_free
      dmaengine: idxd: Fix refcount underflow on module unload

 .../devicetree/bindings/dma/qcom,bam-dma.yaml      |  4 +++
 drivers/dma/dw/rzn1-dmamux.c                       | 15 ++++++---
 drivers/dma/idxd/init.c                            | 39 ++++++++++++------=
----
 drivers/dma/qcom/bam_dma.c                         |  8 +++--
 drivers/dma/ti/edma.c                              |  4 +--
 5 files changed, 44 insertions(+), 26 deletions(-)


Thanks
--=20
~Vinod

--2CnvgaFZXkwUqa9g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmjG+4cACgkQfBQHDyUj
g0eYNBAAwJEjt72v2cyFqpvrJcsiZiz39B7SO+KQP58LLd/FSEbBifeKoKS7xx9T
tuTTAYHfv1AFQYmR8ffKm/V21P7BmQ4vxOw2tZzzPhMzrN97g2aAeTKH3hqvh9cP
oR2hZ+UDUk0Y71xNQgiZZ+i+Qmi91fwF3CGFC+i/LIPW5J5errnGf6mqSibMNaBF
HgEPFLZ8eWdmIyzqOtsp1ZDdUYlsP4iBClS4dq0s2hy8TXnYP8w3WCBVFbnF2999
58GyaYN29y9gjyG8c3Vfl71qMbPBs8xMnlx5WM/HMwl+PVLUJetbSkaQZBLw7vRL
tQ0uD/7uTeTzAt7NQRVOWPW725M3aaW5LEU16LU9CzRC8ipatrqfFp+1JUQiCHtf
B+F1R7p3BLWfUzHbDSi0ZPFloK0mxvKNcEnLi7TXH85/nVgJ5zNqmR4ofX5MxrQN
AhU5//ryHW+waCuvEpHwH4TE19HdaiuUDivlEiYhtrlJ8f43Y4R6nDBGOae1CSQb
d2HjaPUvIt/xYPDukHhTm/fxZDNJiV4IozucM166UvERCNaSxjsTqlcZLnFjgQBW
n14qtmxoMVySSZNp4TSkIjUTVrfGW1FPOZRqjbZ+2Ws5Tw3yEm0cdwogdaUpZxTI
6z898HZ+w8+nkY0kCGosnXcQ+WjFNzlVSwFsYAFUPE/NjnCyxjc=
=stEg
-----END PGP SIGNATURE-----

--2CnvgaFZXkwUqa9g--

