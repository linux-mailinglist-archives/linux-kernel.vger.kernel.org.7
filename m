Return-Path: <linux-kernel+bounces-728735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D63B02C61
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 20:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8A0D1AA4003
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 18:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F57201276;
	Sat, 12 Jul 2025 18:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T9fJK//u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFB4183CB0
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 18:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752344378; cv=none; b=NKAxumV+VCRwatwLmACepAhqnE/v6KeyKcICsNofKqHoW+LDbEw3ca5ZY3NPltA18p1qmGTxvSvzbvLmg97wsZuKSd2HXmzSEwTY/7YdVN8I+IiEsnectc+7ZH4z+emSfA4As/dNQkXFYomWyBFKAgqP82DJPVgUO9+4iCH25j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752344378; c=relaxed/simple;
	bh=uOsaMgO2xPAC6O84t9r3fFCJRUEmIjkX3nZ46MZz1s4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rsZMQwxIDuS9d82GHi6728ANn9BAxqW74RdbLaD01iK7F39IWa+Lukh6zjiK7KsYH80JiLv1id/58pKxcPrgkU0RSB3LWgLVFnBU1593Tnd6/nfJx+ykFslyeuEbMKbRuYp+X2L61V3PSulTbKXM7EzQ46lNcq9eB8/DWLX7Sa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T9fJK//u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B05CC4CEEF;
	Sat, 12 Jul 2025 18:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752344378;
	bh=uOsaMgO2xPAC6O84t9r3fFCJRUEmIjkX3nZ46MZz1s4=;
	h=From:To:Cc:Subject:Date:From;
	b=T9fJK//u6FqRCSp2eRF3NXu13lNA6Dsor1Pl9WOtVgvuLdk4F4lnA0eZiyHIKzRZK
	 CCy4J36F6837jJfJ+OJAcCiiSr4Cnyj2PO4ZCHNFQVN1bf0NlEIjFf/0RrkkltxD7J
	 r68imYH+imEydgSmNYq/Zj47dAD6lnMfdhD86vKPH8Tol2/2nz30gpsz/B2QoX6KEu
	 UNIp5ZWJcKvm4o//dPnnEXt8J7y4zB9+eiqkn9IYSqH4ybZtOfOzSFVlwn6dzC9gON
	 LGthVIV399L/VptrO3fZiz2RoaITw5Edr+1V/IqR8plGs1B5PQBVQOa0kQE+Nzm8Mv
	 OpUpASMp7JzUA==
From: srini@kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Srinivas Kandagatla <srini@kernel.org>
Subject: [PATCH 0/8] nvmem: patches (set 1) for 6.17
Date: Sat, 12 Jul 2025 19:18:56 +0100
Message-ID: <20250712181905.6738-1-srini@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Srinivas Kandagatla <srini@kernel.org>

Here are few nvmem patches for 6.17, Could you please queue
these for 6.17.

Patches include:
	- adding bindings conversion to yaml for lpc1857 and vf610
	  providers.
	- fix some typos in MODULE_AUTHOR.
	- make nvmem_bus_type constant
	- add bindings for A523 SID controller.
	- Update fixed-layout to support optional bit position

Thanks,
Srini

Alok Tiwari (1):
  nvmem: core: Fix typos in comments and MODULE_AUTHOR strings

Chen-Yu Tsai (1):
  dt-bindings: nvmem: mediatek: efuse: split MT8186/MT8188 from base
    version

Frank Li (2):
  dt-bindings: nvmem: convert lpc1857-eeprom.txt to yaml format
  dt-bindings: nvmem: convert vf610-ocotp.txt to yaml format

Greg Kroah-Hartman (1):
  nvmem: make nvmem_bus_type constant

Mikhail Kalashnikov (1):
  dt-bindings: nvmem: SID: Add binding for A523 SID controller

Sven Peter (2):
  nvmem: apple: drop default ARCH_APPLE in Kconfig
  dt-bindings: nvmem: fixed-layout: Allow optional bit positions

 .../nvmem/allwinner,sun4i-a10-sid.yaml        |  1 +
 .../bindings/nvmem/fsl,vf610-ocotp.yaml       | 47 ++++++++++++++
 .../bindings/nvmem/layouts/fixed-layout.yaml  |  2 +-
 .../bindings/nvmem/lpc1857-eeprom.txt         | 28 ---------
 .../bindings/nvmem/mediatek,efuse.yaml        | 17 +++++-
 .../bindings/nvmem/nxp,lpc1857-eeprom.yaml    | 61 +++++++++++++++++++
 .../devicetree/bindings/nvmem/vf610-ocotp.txt | 19 ------
 drivers/nvmem/Kconfig                         |  1 -
 drivers/nvmem/core.c                          | 12 ++--
 9 files changed, 131 insertions(+), 57 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/nvmem/fsl,vf610-ocotp.yaml
 delete mode 100644 Documentation/devicetree/bindings/nvmem/lpc1857-eeprom.txt
 create mode 100644 Documentation/devicetree/bindings/nvmem/nxp,lpc1857-eeprom.yaml
 delete mode 100644 Documentation/devicetree/bindings/nvmem/vf610-ocotp.txt

-- 
2.43.0


