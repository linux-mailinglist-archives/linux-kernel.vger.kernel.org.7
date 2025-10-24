Return-Path: <linux-kernel+bounces-869037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 546E8C06C74
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 16:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AC12400DDF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 14:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9745024469B;
	Fri, 24 Oct 2025 14:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="lGbv1+pS"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE1B23314B;
	Fri, 24 Oct 2025 14:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761317381; cv=none; b=ZeIGGHib9mhQKV/nqcJZU6nBN57uNJ25treGW16Aw1caXKL4rRsac3YqAsb4EriUSsnLbbejHmIOy/pPj1vxpH5NUqIL5C6AU9xiis9rC+n8TlWyPxgwEEMAm8tR1KAhXrlK3zObt8M2bR2TLps14BY380yq76wmIN/Ezy7xcDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761317381; c=relaxed/simple;
	bh=JffTwI3RQ2d7PH4LhOOXVjAnaYD7FuXwhXY0G2PkDYg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ITVGCAZSwhV8OftdsVT6qW4ZM7OgiWy5bXQZE99DVuVgo9CTW8Q19zMuNGm31zXyxFJ9k1bCQ8mWCpR/p3TiKZSkfW9PO0IIWhSonj6MpZB3ETr0foCE8ZkrK+yg7YSu8rBPQSpAWlUgAq2rpCkF7+VOoGl2jXHLMQCWvh27wio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=lGbv1+pS; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 7B3E225C72;
	Fri, 24 Oct 2025 16:49:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1761317370;
	bh=5z29d9Nasu98bW6N8tJSBPookct1TNtx6qJSNSczmPc=; h=From:To:Subject;
	b=lGbv1+pSdbYu7m8C+Cp47kBpc4GA3KZQOiGNhIlEp6qHmFEuo6tZ3C8hePphMhMtV
	 dh42HjCbyynOjErSxlQmEL9V2fzncoo8qe/ORUN5/OAu7i02VaXeftZtpyieBd9BAX
	 HqjrhFIlbjOEkNyApSXnXf7OENu+TOuK7mO7UHuyJNuU8QFztHWNcb6/ObQip2+XY8
	 DB/ZMhqr0vn7a4aWltzR0qJMGedHU5082MMBT5b0/jlkkmH5tIA/kXazZFmJC9OUnD
	 OL2pXksmXi+LGz8JTz/hg+RWyDQMAgeBtky/En+mJudMenksQUiFs8nYoVRW1nkzqh
	 weCbWVtywEaXg==
From: Francesco Dolcini <francesco@dolcini.it>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"Kirill A. Shutemov" <kas@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 0/2] arm64: dts: freescale: add Toradex SMARC iMX95
Date: Fri, 24 Oct 2025 16:49:19 +0200
Message-Id: <20251024144921.77714-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Francesco Dolcini <francesco.dolcini@toradex.com>

This series adds support for the Toradex SMARC iMX95 SoM and the
Toradex SMARC Development Board.

The module consists of an NXP i.MX95 family SoC, up to 16GB of LPDDR5
RAM and up to 128GB of storage, a USB 3.0 Host Hub and 2.0 OTG, two
Gigabit Ethernet PHYs, a 10 Gigabit Ethernet interface, an I2C EEPROM
and Temperature Sensor, an RX8130 RTC, a Quad/Dual lane CSI interface,
and some optional addons: TPM 2.0, DSI, LVDS, DisplayPort (through a
DSI-DP bridge), and Wi-Fi/BT module.

Link: https://www.toradex.com/computer-on-modules/smarc-arm-family/nxp-imx95
Link: https://www.toradex.com/products/carrier-board/smarc-development-board-kit

João Paulo Gonçalves (1):
  dt-bindings: arm: fsl: add Toradex SMARC iMX95

Max Krummenacher (1):
  arm64: dts: freescale: add Toradex SMARC iMX95

 .../devicetree/bindings/arm/fsl.yaml          |    6 +
 arch/arm64/boot/dts/freescale/Makefile        |    1 +
 .../dts/freescale/imx95-toradex-smarc-dev.dts |  277 ++++
 .../dts/freescale/imx95-toradex-smarc.dtsi    | 1153 +++++++++++++++++
 4 files changed, 1437 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx95-toradex-smarc-dev.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx95-toradex-smarc.dtsi

-- 
2.39.5


