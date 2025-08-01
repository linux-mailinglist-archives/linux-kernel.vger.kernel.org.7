Return-Path: <linux-kernel+bounces-753367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE296B181F5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 14:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4021B3A04E0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 12:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62ADC2472A5;
	Fri,  1 Aug 2025 12:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W23ZS/PE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AA21F16B
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 12:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754052101; cv=none; b=raYr3V1Zy1p6NSYNCydhnLkNoL46MP8BrG3fwK2RHvr0YkM7HVxxHAz5zqOQ77EIQbC0G7WtO2T5LXF5aKq7+X0d3lN0TMHuKLjSW559H9Ysed6g22Heam8YlFsHK2CaeDAqB5sN2GH0ry8L/4DikW1ENWwe9/cVvQKz+eIrsRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754052101; c=relaxed/simple;
	bh=7ZK741fDoXgKVr+mT2QanV6sDcWA8u8GOKb4YwTXDXU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SGYlJnLPLXXcypVKj0Zv3/OxqR6cCL2WNEHNWB6f6swJGbUxJB0wKzML/MZ3hnNIVjSrTa3/V1FDkFV1TrXaDYUAFyy/h0gnpYFhJIdrv0F1b4HL5YWniuUJl1+LFjGtvcu3kDA1yjojONEA71EYggSkHC80/qvFYpid0tcHAqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W23ZS/PE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13997C4CEE7;
	Fri,  1 Aug 2025 12:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754052101;
	bh=7ZK741fDoXgKVr+mT2QanV6sDcWA8u8GOKb4YwTXDXU=;
	h=Date:From:To:Cc:Subject:From;
	b=W23ZS/PEB6H5jallqTm2K/+VLs1xF2nuvG7Th9LpsqSgPx7Hs9207aI8RakOCluVk
	 z/G/lmmMMwH4Fx6G4Z3qz7U3nxPEpUMRbkvi1kX+cEWGQxhLQRsL/uMYmEFHOqpg60
	 OgZr21iscB4xSAGdUNAhWvq+oPnBzeCmw/Ruxo8uFx4UgQDo9BYSk2/UxiAmxKhAVc
	 pCkX5nLknb9M1GkJObassPl2n/ud8GbKp0YqIfi7FF4/82AvHkrhR8gD3mAjW/V46I
	 s3uOAV6Wo9uDPpZjlalXJFoIABuNgp88Qq3GR4pcePI6njnOEbWtbNl5lboqxhZjpK
	 eCd6OBQeySCcA==
Date: Fri, 1 Aug 2025 18:11:38 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: dmaengine subsystem updates for v6.17
Message-ID: <aIy2AkFvYfbQ2WTD@vaman>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cR1We4SHDwaNKjyM"
Content-Disposition: inline


--cR1We4SHDwaNKjyM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

Please pull to receive updates for dmaengine subsystem consisting of a
new managed api, a new driver and couple of device support and few
updates and cleanups to drivers.

The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dm=
aengine-6.17-rc1

for you to fetch changes up to e3a9ccd21897a59d02cf2b7a95297086249306d6:

  dt-bindings: dma: fsl-mxs-dma: allow interrupt-names for fsl,imx23-dma-ap=
bx (2025-07-23 17:55:32 +0530)

----------------------------------------------------------------
dmaengine updates for v6.17

 Core:
  - Managed API for dma channel request

 New support:
  - Sophgo CV18XX/SG200X dmamux driver
  - Qualcomm Milos GPI, sc8280xp GPI support

 Updates:
  - Conversion of brcm,iproc-sba and marvell,orion-xor binding
  - Unused code cleanup across drivers

----------------------------------------------------------------
Amelie Delaunay (1):
      dmaengine: stm32-dma: configure next sg only if there are more than 2=
 sgs

Anil S Keshavamurthy (1):
      dmaengine: idxd: Fix warning for deadcode.deadstore

Bence Cs=F3k=E1s (2):
      dmaengine: sun4i: Simplify error handling in probe()
      dmaengine: Add devm_dma_request_chan()

Frank Li (1):
      dt-bindings: dma: fsl-mxs-dma: allow interrupt-names for fsl,imx23-dm=
a-apbx

Inochi Amaoto (2):
      dt-bindings: dmaengine: Add dma multiplexer for CV18XX/SG200X series =
SoC
      dmaengine: add driver for Sophgo CV18XX/SG200X dmamux

Krzysztof Kozlowski (7):
      dmaengine: dw-edma: Drop unused dchan2dev() and chan2dev()
      dmaengine: fsl-dpaa2-qdma: Drop unused mc_enc()
      dmaengine: qcom: gpi: Drop unused gpi_write_reg_field()
      dmaengine: fsl-qdma: Add missing fsl_qdma_format kerneldoc
      dmaengine: mmp: Fix again Wvoid-pointer-to-enum-cast warning
      dmaengine: sh: Do not enable SH_DMAE_BASE by default during compile t=
esting
      dmaengine: ti: Do not enable by default during compile testing

Luca Weiss (1):
      dt-bindings: dma: qcom,gpi: document the Milos GPI DMA Engine

Pengyu Luo (1):
      dt-bindings: dma: qcom,gpi: Document the sc8280xp GPI DMA engine

Rob Herring (Arm) (2):
      dt-bindings: dma: Convert brcm,iproc-sba to DT schema
      dt-bindings: dma: Convert marvell,orion-xor to DT schema

Robert Marko (1):
      dmaengine: xdmac: make it selectable for ARCH_MICROCHIP

Sven Peter (1):
      dmaengine: apple-admac: Drop default ARCH_APPLE in Kconfig

Thomas Fourier (2):
      dmaengine: mv_xor: Fix missing check after DMA map and missing unmap
      dmaengine: nbpfaxi: Add missing check after DMA map

Thomas Wei=DFschuh (1):
      dmaengine: stm32: Don't use %pK through printk

Vinod Koul (1):
      Merge branch 'topic/dmaengine_devm' into next

Yi Sun (1):
      dmaengine: idxd: Remove __packed from structures

 .../devicetree/bindings/dma/brcm,iproc-sba.txt     |  29 ---
 .../devicetree/bindings/dma/brcm,iproc-sba.yaml    |  41 ++++
 .../devicetree/bindings/dma/fsl,mxs-dma.yaml       |  33 +++
 .../devicetree/bindings/dma/marvell,orion-xor.yaml |  84 +++++++
 Documentation/devicetree/bindings/dma/mv-xor.txt   |  40 ----
 .../devicetree/bindings/dma/qcom,gpi.yaml          |   2 +
 .../bindings/dma/sophgo,cv1800b-dmamux.yaml        |  51 ++++
 drivers/dma/Kconfig                                |  12 +-
 drivers/dma/Makefile                               |   1 +
 drivers/dma/cv1800b-dmamux.c                       | 259 +++++++++++++++++=
++++
 drivers/dma/dmaengine.c                            |  30 +++
 drivers/dma/dw-edma/dw-edma-core.c                 |  12 -
 drivers/dma/fsl-dpaa2-qdma/dpdmai.c                |   5 -
 drivers/dma/fsl-qdma.c                             |   3 +
 drivers/dma/idxd/init.c                            |   1 -
 drivers/dma/idxd/registers.h                       |  60 ++---
 drivers/dma/mmp_tdma.c                             |   2 +-
 drivers/dma/mv_xor.c                               |  21 +-
 drivers/dma/nbpfaxi.c                              |  13 ++
 drivers/dma/qcom/gpi.c                             |  11 -
 drivers/dma/sh/Kconfig                             |   2 +-
 drivers/dma/stm32/stm32-dma.c                      |  12 +-
 drivers/dma/stm32/stm32-dma3.c                     |  10 +-
 drivers/dma/stm32/stm32-mdma.c                     |   8 +-
 drivers/dma/sun4i-dma.c                            |  46 ++--
 drivers/dma/ti/Kconfig                             |   4 +-
 include/linux/dmaengine.h                          |   7 +
 27 files changed, 615 insertions(+), 184 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/dma/brcm,iproc-sba.txt
 create mode 100644 Documentation/devicetree/bindings/dma/brcm,iproc-sba.ya=
ml
 create mode 100644 Documentation/devicetree/bindings/dma/marvell,orion-xor=
=2Eyaml
 delete mode 100644 Documentation/devicetree/bindings/dma/mv-xor.txt
 create mode 100644 Documentation/devicetree/bindings/dma/sophgo,cv1800b-dm=
amux.yaml
 create mode 100644 drivers/dma/cv1800b-dmamux.c

--=20
~Vinod

--cR1We4SHDwaNKjyM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmiMtgEACgkQfBQHDyUj
g0dQ1A//V1Huf3Rs6MY0DXAc4JNT0QltO4ZCczLG5Su8N2yzoe1PU9JDlK+K6LP/
DaFINY5F5O1TIkVbVY8K6XaaBri/Z2cRyH7NCh5i/SQbw7yVfwXqnuE4mfnXRaul
CX9LRGqEiWA2q/JGczIMEg0Zk+Rz0K4PY0eBCsW5ehQzl71ERQOpPjRm0NQOnSzF
HsQ2+grFUKU8AM2LPBRa/yuqTOG93uAOa8CWYBZq7lLXz5fBQLCsKMpERE4ZEa10
9KpwzvT1D4PlhNnv7NQJC3NXTg/UFsUBN0j1njAZ691aieyJewsqj5FU2c7QZfIB
XyWnoW6FzTlOIKlbfCIh2gK5XFd6EGEiKaTkdSJI+36fUVJ08jI/7Wvplt4g5oPw
eNpsw5BVj/g9S0/fl2ScutrQKURX9AyPcH+4Z11dyT/7SV9eXHgIWAyEgoz0WtxC
VUcutTjcYKNmfu9N+F9Haf0+UitIjsIo/bJk30R0FVDXNcSBfAzP99BxVDMUGatk
tDEc7zU3PyMrytGaf5jyZlSg7vUs9sn1CF89QDT2VuPEJjJoo6bN7P93Wk5b/4cm
ocP35C2C3rZRDqu77WKEPvKiYL58fhRhI2tSBr0EqE1/5+wv44DPfFn/zuvtgr0f
mzSjQNCQJemkq+vlnJfziv+VSJwTPESV/BXRvVZKRvqFlcwo0W0=
=DcHG
-----END PGP SIGNATURE-----

--cR1We4SHDwaNKjyM--

