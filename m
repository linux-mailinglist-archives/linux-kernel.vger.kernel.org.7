Return-Path: <linux-kernel+bounces-842643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 580FBBBD384
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 09:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42C793B4E99
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 07:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14788254B1F;
	Mon,  6 Oct 2025 07:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q610UksX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68876128819
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 07:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759736046; cv=none; b=eh79A8NgqEcwumOWKUburSM4XC6ypmUghG7ZXHhqV3LZD/lcHKziNqzFfjU/EGw/1Sq6gvNxshIIWp/aXJp9tZWyZFC5rmcbd187rco10ngZ+azwyvuZZsdsae0YyFZpnS83QxuMpHPiCl49j0SYoSRzSDOWhIUcQhUykG2rIiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759736046; c=relaxed/simple;
	bh=jvLakp1JnHijuCzEc/9tmajSZRM69J0Cm2VuA0oa6iI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Pmaq4aNPRrwqemQ5Nq+RJfSsgIKCxkF0WooxxkNgyMli2oLi/+wzzGpMsa20svzU0Ucjh3E5e+ceJNemyRx+IoFYaOYPqKWSlJ7EvDsVQucdnS3NO8RKjW4ZnUg+Qr2J+7q1WQGlv4lzg+oStGAo1qGWksa0MtJA1JkgQaT511g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q610UksX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 827ECC4CEF5;
	Mon,  6 Oct 2025 07:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759736046;
	bh=jvLakp1JnHijuCzEc/9tmajSZRM69J0Cm2VuA0oa6iI=;
	h=Date:From:To:Cc:Subject:From;
	b=q610UksXwbB6rGOFXKHBBuntlrHzWmvRtUfOOnj2AhGkfyiRq1WLDgHUt8ILfFkW+
	 JnvZngNZRpE/Zjjuxfy+FNMaCcP8SSxJLQt0Q+BYKfMM1RjWDk/D2D6M1lNH/6pw4H
	 74wJPXMxtVeI3r1Vuz9CPtlewC/6XhXd9b8F+zUEmkGrh2vQpOgB3nCDXOpsoYehKs
	 vc4szt0PowOg5q7dOCZjmixntisHg6JVlusNJyo2yPzjyN/JZbSFbo4PLmYDznuY7n
	 Z8hebYk9a7wnb0zow9+roaV09jgTEyeUxDAcL9OaJO6PcjOWxg8TqIMZA/4RQmsgWq
	 N/FlWzHdg74gA==
Date: Mon, 6 Oct 2025 13:04:02 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: dmaengine subsystem updates for v6.18
Message-ID: <aONw6q7WavFEm1Ux@vaman>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YlFtTszXK9m2KaKe"
Content-Disposition: inline


--YlFtTszXK9m2KaKe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Linus,

Please pull to recieve the dmaengine subsystem updates for this cycle.
Couple of new device support and small driver updates for this round.

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dm=
aengine-6.18-rc1

for you to fetch changes up to cc0bacac6de7763a038550cf43cb94634d8be9cd:

  dt-bindings: dma: rz-dmac: Document RZ/G3E family of SoCs (2025-09-02 12:=
57:20 +0530)

----------------------------------------------------------------
dmaengine updates for v6.18

 New support:
  - Intel idxd Wildcat Lake family support
  - SpacemiT K1 PDMA controller support
  - Renesas RZ/G3E family support

 Updates:
  - Xilinx shutdown support and dma client properties update
  - Designware edma callback_result support

----------------------------------------------------------------
Abin Joseph (2):
      dmaengine: zynqmp_dma: Add shutdown operation support
      dt-bindings: dmaengine: xilinx_dma: Remove DMA client properties

Anil S Keshavamurthy (1):
      dmaengine: idxd: Add a new IAA device ID for Wildcat Lake family plat=
forms

Chelsy Ratnawat (1):
      dmaengine: Replace zero-length array with flexible-array

Colin Ian King (1):
      dmaengine: ppc4xx: Remove space before newline

Devendra K Verma (1):
      dmaengine: dw-edma: Set status for callback_result

Folker Schwesinger (1):
      dmaengine: xilinx_dma: Support descriptor setup from dma_vecs

Guodong Xu (5):
      dt-bindings: dma: Add SpacemiT K1 PDMA controller
      dmaengine: mmp_pdma: Add clock support
      dmaengine: mmp_pdma: Add reset controller support
      dmaengine: mmp_pdma: Add operations structure for controller abstract=
ion
      dmaengine: mmp_pdma: Add SpacemiT K1 PDMA support with 64-bit address=
ing

Nathan Lynch (1):
      dmaengine: Fix dma_async_tx_descriptor->tx_submit documentation

Rob Herring (Arm) (1):
      dt-bindings: dma: nvidia,tegra20-apbdma: Add undocumented compatibles=
 and "clock-names"

Rosen Penev (1):
      dmaengine: mv_xor: match alloc_wc and free_wc

Thomas Andreatta (1):
      dmaengine: sh: setup_xref error handling

Thorsten Blum (1):
      dmaengine: idxd: Replace memset(0) + strscpy() with strscpy_pad()

Tommaso Merciai (1):
      dt-bindings: dma: rz-dmac: Document RZ/G3E family of SoCs

 .../bindings/dma/nvidia,tegra20-apbdma.yaml        |  12 +-
 .../devicetree/bindings/dma/renesas,rz-dmac.yaml   |   5 +
 .../devicetree/bindings/dma/spacemit,k1-pdma.yaml  |  68 +++++
 .../devicetree/bindings/dma/xilinx/xilinx_dma.txt  |  23 --
 drivers/dma/Kconfig                                |   2 +-
 drivers/dma/dw-edma/dw-edma-core.c                 |  22 ++
 drivers/dma/idxd/defaults.c                        |   6 +-
 drivers/dma/idxd/init.c                            |   2 +
 drivers/dma/idxd/registers.h                       |   1 +
 drivers/dma/imx-sdma.c                             |   2 +-
 drivers/dma/mmp_pdma.c                             | 293 +++++++++++++++++=
+---
 drivers/dma/mv_xor.c                               |   4 +-
 drivers/dma/ppc4xx/adma.c                          |   4 +-
 drivers/dma/sh/shdma-base.c                        |  25 +-
 drivers/dma/sh/shdmac.c                            |  17 +-
 drivers/dma/xilinx/xilinx_dma.c                    |  94 +++++++
 drivers/dma/xilinx/zynqmp_dma.c                    |   5 +-
 include/linux/dmaengine.h                          |   2 +-
 include/linux/shdma-base.h                         |   2 +-
 19 files changed, 504 insertions(+), 85 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/spacemit,k1-pdma.=
yaml
--=20
~Vinod

--YlFtTszXK9m2KaKe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmjjcOoACgkQfBQHDyUj
g0dabhAAoR28we6VAr+1cmJTP3vF8QTTrMCbE4zygf3bI6ZNiMGXBprW4xcFLfb4
Kt1CN3/Xl434dg54Gk8OHrazGNSECAzC58cTz1gw0orcwpipCsMkZ5hj4x34n4o5
ZjUf6uPYNXl8y4Ex+6GE5qzT3bkDJBChidr7VwHDCDZCOltjbry9F+9jCuWDTRzA
va6v8RkhKYpixhV9DAxsotgeW+H/wATO3MYZCioFhQfe6d1tiOHqhHa4oxHbrWqy
QfLT/t/Ach0f0LqoF2CW/1nbX/RGlIChw6FDflqLvkHGgjce4JfcnJk6gdhxOuHr
OGC7GP+Cwb9r9iltg3KvvcP0tyVfZOP57gBRArE6QP5wIWnDt7LCwLiRUbS5DB38
xE7l3g3DwTR4zuL+DXAinvR/hv41TBDMFC1QXKp2CahDDuChzXidcuUlbB6fXvpM
T1GU+mefMzC065cBrGUe3eJGww5kC/WT856HZo/DGJEOmTWwjuAcN4SWyfftoMG4
zNt5D/r2+MxsX3r3NpiXGmpIzJ4MgExJwwpSzsmXbBH+cqiPuf03ZT6kgU8F5Xid
YPUAQPWtgbzxj0uaRHdcgi3rXuxIh/xfHpkqWrSeN8Zaqo9/CwjSbkxKn4bl+rIm
C9UjaBFrDTSD8iYmvCIBJ0xiVaVqvMbMzWozgUFrT+20njVat58=
=9HZt
-----END PGP SIGNATURE-----

--YlFtTszXK9m2KaKe--

