Return-Path: <linux-kernel+bounces-878246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FC3C20188
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:52:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 01C054E806E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D39F3570AE;
	Thu, 30 Oct 2025 12:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="NSEISNFa"
Received: from mx-relay16-hz2.antispameurope.com (mx-relay16-hz2.antispameurope.com [83.246.65.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B39B340A51
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 12:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=83.246.65.158
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761828668; cv=pass; b=aXK55xvDHzz2wcRLBywE50TVC5ksut7A+0ALvxRABNrbFRtq6Nl2gJNbvV1sHYgZBahfYdt59sYyXzQ01PFpfBh/Uhs5j8Cz1iGFgkQ7TRocbxmyF+hXONqVnddEu0hXnrtcmfMr18lfHsI8neiVLXG67+MoslgnjoRORZMXuHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761828668; c=relaxed/simple;
	bh=f+RxHNX/PkgtqpUObsVvi3CaeeKjaEaIpLrIKPlMWiA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EvpnVWv7e+Ubq9Q6XpCsYd1b+SmXvIp3IketIeLdBGLVCrliL6jC+2m+xSCTWMbS9nhdx0DxjiHEpPNua3/SVisbcAXbQozq7QqQI2bEGVc+Yz5yqn3wIixFGvXwM+OFtzWxsjOJQTk9plJiq+lopj3bVM4XBJAB5hnYIsuSMvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=NSEISNFa; arc=pass smtp.client-ip=83.246.65.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate16-hz2.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com
 smtp.helo=hmail-p-smtp01-out04-hz1.hornetsecurity.com; dmarc=pass
 header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=hEveejQ5LezW2cXHJne2TGfo1ZNO0O+jmUKcv/3d1g8=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1761828606;
 b=kdQWN08XaRD3MhdEuWMzPVbwzKHwve5Sp5TSdcNW9Fd6uHiaVR12Vkvy3tYoUkdK5TVcHMkn
 1KtWvfUKi47G86LtP1FxsemYvB/I5BS3B96zhHi1Bs0z4ZboPJ40Atgd7uhS9beaca2/G7sivqL
 m5pxTnxbyS2N+UXh0yvPECkbPQEtII3J+PnJ8G175BqV50q3IbXOVgJdGJr+uyHMn7atBUUAEiv
 ucN0Ll0gyf84FggwuDC6cmP0G96BPFMnYC8RX868JKkxW39CnzEPsZIZtLlme5fFf2IxP1x4crc
 Pmocz4I08x1OrV/yD/QW3Ku+nF0KYhjhSbSiwFCCqEpUg==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1761828606;
 b=UBfO61kj1HG+nmDV8SettLQwfsZbwp+kijMkqxb/qz8fyzzERGDhTmZerHHZTwQnAASfyuLQ
 DIPtcB65Z/g2p8W/JrvfdHQJNX0zcn0eW2ZIhP6OhJoh6dFI0M/whJhX2VxHj04+tt0JVNPxkqH
 AjTPzZ9lELeVWsNMpvMJb1lA7ej20zNTxZ9bM3v3KHjdnnToesOxRnhQNyky1/nVYshd6pQjfGe
 l/SOCN5rVI/ukd8k2ayJS1y1l8UI9LtTouqeUzpu2yy/mKIW+LgHt8gyX+EfgUX4bR70OjAUaKu
 gnAdTcN6w9JEuktElQsoObh+6sivFHCNdGZsWDDCl2gMg==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay16-hz2.antispameurope.com;
 Thu, 30 Oct 2025 13:50:06 +0100
Received: from steina-w.tq-net.de (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: alexander.stein@ew.tq-group.com)
	by hmail-p-smtp01-out04-hz1.hornetsecurity.com (Postfix) with ESMTPSA id 1D6A7220C5A;
	Thu, 30 Oct 2025 13:49:50 +0100 (CET)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: linux@ew.tq-group.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 00/19] TQMa95xxSA DT fixes and cleanup
Date: Thu, 30 Oct 2025 13:49:07 +0100
Message-ID: <20251030124936.1408152-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-cloud-security-sender:alexander.stein@ew.tq-group.com
X-cloud-security-recipient:linux-kernel@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: alexander.stein@ew.tq-group.com
X-cloud-security-Mailarchivtype:outbound
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay16-hz2.antispameurope.com with 4cy3q25g17z29yQ2
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest:4af8d990a1c9f7c4fdb1574041f6d9a2
X-cloud-security:scantime:1.686
DKIM-Signature: a=rsa-sha256;
 bh=hEveejQ5LezW2cXHJne2TGfo1ZNO0O+jmUKcv/3d1g8=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1761828605; v=1;
 b=NSEISNFafWbLfQgXLjKM5zTCT7kgZot/zLGhdFVrXoUBLPb/1IFoWzDk2sCtxbOIafZ7B31u
 Np7KUTeS8tgnyRJidQDFNaxRnd9KMNuPGXJuvsiH7LA2s4GCHgbC5IFP1NVRGlsJ+CuewguhQfJ
 DN8QwIlsQIUv7AD4mJP+cTCHCgCJT92fae29ctcerZ8iP+ut4GzoW6IQhKbBCtmpTdhHLHXTWyJ
 Kwnl8CZKssXSAtWxsC1FUGUa+zP84qry/To5ONgCiU3++fBORQ429JbnoKQpVPm7Vn+UFyvOLul
 9YULeBc2vH/meKf/MjXO5Ky2uXpNEeWhaSE+YZFkZB6aw==

Hi everyone,

this series includes two fixes for TQMa95xxSA. Having a Fixes-tag I put them
at the beginning. Following patches are DT cleanups:
* move pinctrl/config to module .dtsi as SMARC-2 already defines the pinout
  the mux is fixed already.
* Remove 'sleep' pinctrl settings as they are identical to 'default'
* Add I2C bus recovery
* EERPOM page size is increased to 32
* Whitespace fix
* Add MicIn routing
* Mark LPUART1 reserved. Unique control of syste manager (SM)

Best regards,
Alexander

Alexander Stein (14):
  arm64: dts: imx95-tqma9596sa: reduce maximum FlexSPI frequency to
    66MHz
  arm64: dts: imx95-tqma9596sa: increase flexspi slew rate
  arm64: dts: imx95-tqma9596sa: move flexcan pinctrl to SOM
  arm64: dts: imx95-tqma9596sa: move lpspi3 pinctrl to SOM
  arm64: dts: imx95-tqma9596sa: move sai config to SOM
  arm64: dts: imx95-tqma9596sa: move pcie config to SOM
  arm64: dts: imx95-tqma9596sa: update pcie config
  arm64: dts: imx95-tqma9596sa: remove superfluous pinmux for flexspi
  arm64: dts: imx95-tqma9596sa: remove superfluous pinmux for i2c
  arm64: dts: imx95-tqma9596sa: remove superfluous pinmux for usdhci
  arm64: dts: imx95-tqma9596sa: add gpio bus recovery for i2c
  arm64: dts: imx95-tqma9596sa: whitespace fixes
  arm64: dts: imx95-tqma9596sa-mb-smarc-2: Add MicIn routing
  arm64: dts: imx95-tqma9596sa-mb-smarc-2: mark LPUART1 as reserved

Markus Niebel (5):
  arm64: dts: imx95-tqma9596sa: fix TPM5 pinctrl node name
  arm64: dts: imx95-tqma9596sa: move USDHC2 config to SOM
  arm64: dts: imx95-tqma9596sa: add EEPROM pagesize
  arm64: dts: imx95-tqma9596sa-mb-smarc-2: remove superfluous line
  arm64: dts: imx95-tqma9596sa-mb-smarc-2: add aliases for SPI

 .../freescale/imx95-tqma9596sa-mb-smarc-2.dts |  75 ++-------
 .../boot/dts/freescale/imx95-tqma9596sa.dtsi  | 153 +++++++++++++++---
 2 files changed, 139 insertions(+), 89 deletions(-)

-- 
2.43.0


