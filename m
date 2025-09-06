Return-Path: <linux-kernel+bounces-804132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B52F8B46A5B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 11:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 687827BBAB5
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 09:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7410F288C2B;
	Sat,  6 Sep 2025 09:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OTzLPc+W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BC826C391;
	Sat,  6 Sep 2025 09:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757149796; cv=none; b=dw42VzDQZ5bfQ2s8CPY1QakUdpDfK/kjlv4ga8ETgUEAWin/IbsuorsV6FqMXHPv3kFqSxg0iu1HT/4hCWEaNlmKL+C2fafzXuqWvj5vqw2WNVmO424DMGPdnyFL2ZaU0AUJTPAyGCKeRqi9CqzGaX8TG9D9dnQUL8FNVSiprvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757149796; c=relaxed/simple;
	bh=oUpwW1ukVVMWcU3O8pfRmoB6AzDVF2v4yYJ6GaL05Uw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=faRK0MqlVawrpl3RKQfp0fYP+G3eej9bFCcwVz0Q7lCOqFiP4P47pEhE11wdtXsWkIjOvNTJ34XYJCCLNtnJAf0016Kvzv4JTMGx/cxzYmgQULhet4eW0iNGggv7WUPlZKTJE/HLnKVZLqIrwsbWfqpB9Q3NBdctyqDPPydGmfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OTzLPc+W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25AC4C4CEE7;
	Sat,  6 Sep 2025 09:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757149796;
	bh=oUpwW1ukVVMWcU3O8pfRmoB6AzDVF2v4yYJ6GaL05Uw=;
	h=From:Subject:Date:To:Cc:From;
	b=OTzLPc+WVYmA1rfUZ5A3YXIpvrvHpSjY5VPYXb55h+sTCVxk2zyhWNq+qeKJUUNLA
	 k/YSpGU/li2N+YSWsqK+g3Yr9jkkGBkV0zLFLnatNATbK3WiIv3075EGSt0YvJGJAV
	 RS/8fLMKTqVV1YilXZHTOqJIVOaLv4DixBc5zCqS3rXccN9C8+35ruw/OVzuM0Uckj
	 3QM+U0z+NCNMBirgmxKpCiCyTqhYeEUg9qOVfZxzddCHaHkXdnrBZ7LoqYSIqOaCHi
	 wh6eUGHU3IludvLeEAlkrayk/ypmcoL0DMOqVZ9oUnexLZQF9udz/hB9qtmfB+YdE3
	 KmLLEPjBT+gew==
From: Andreas Kemnade <akemnade@kernel.org>
Subject: [PATCH 0/4] regulator: sy7636a: define and init all resources
 needed
Date: Sat, 06 Sep 2025 11:09:11 +0200
Message-Id: <20250906-sy7636-rsrc-v1-0-e2886a9763a7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADj6u2gC/x3MQQ5AMBBA0as0s9akigpXEYtRg9kgM4mQxt01l
 m/xfwIlYVLoTQKhi5WPPaMsDMQN95Usz9ngnW9c54LVpw1VsKISbfQOMUyIPtaQi1No4fu/DeP
 7fuDWrjRdAAAA
X-Change-ID: 20250906-sy7636-rsrc-c20aa6baa2c4
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alistair Francis <alistair@alistair23.me>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Andreas Kemnade <akemnade@kernel.org>
X-Mailer: b4 0.15-dev-50721
X-Developer-Signature: v=1; a=openpgp-sha256; l=1563; i=akemnade@kernel.org;
 h=from:subject:message-id; bh=oUpwW1ukVVMWcU3O8pfRmoB6AzDVF2v4yYJ6GaL05Uw=;
 b=owGbwMvMwCEm/rzkS6lq2x3G02pJDBm7fznmaR6y7Oc9/ffw/+iZ5/59lei0iXD3OTnje/hF7
 ZeB5rqvO0pZGMQ4GGTFFFl+WSu4fVJ5lhs8NcIeZg4rE8gQBi5OAZjIyi0Mf3h/cGwWfpHx7d+P
 7zN8JBbPvBrJ2dovHCF7THnZ9L2SiTsY/icaOPTsXV6ePi+seqXBVGPj7M1aMh9juQSWPMw7fHT
 Pfh4A
X-Developer-Key: i=akemnade@kernel.org; a=openpgp;
 fpr=EEC0DB858E66C0DA70620AC07DBD6AC74DE29324

The SY7636A has some pins which can be hardwired or used to have more
more advanced power management available. As several devices containing
this regulator have these pins not hardwired, but instead connected to some
GPIO, enhance the driver to have them defined and initialized.
Also add the ability to power off the chip completely by defining some
input power supply.

Actually implementing better power management is planned to be
implemented as a second step. The regulators in the SY7636A should only
be on for a short time during display refresh, but currently they are
unconditionally forcefully enabled by the hwmon part of this chip.

Signed-off-by: Andreas Kemnade <akemnade@kernel.org>
---
Andreas Kemnade (4):
      dt-bindings: mfd: sy7636a: Add missing gpio pins and supply
      regulator: sy7636a: fix lifecycle of power good gpio
      regulator: sy7636a: add gpios and input regulator
      ARM: dts: imx: e70k02: add sy7636

 .../devicetree/bindings/mfd/silergy,sy7636a.yaml   | 16 +++++++++++
 arch/arm/boot/dts/nxp/imx/e70k02.dtsi              | 25 +++++++++++++++-
 .../arm/boot/dts/nxp/imx/imx6sl-tolino-vision5.dts | 24 ++++++++++++++++
 .../arm/boot/dts/nxp/imx/imx6sll-kobo-librah2o.dts | 24 ++++++++++++++++
 drivers/regulator/sy7636a-regulator.c              | 33 ++++++++++++++++++++--
 5 files changed, 118 insertions(+), 4 deletions(-)
---
base-commit: 1b237f190eb3d36f52dffe07a40b5eb210280e00
change-id: 20250906-sy7636-rsrc-c20aa6baa2c4

Best regards,
--  
Andreas Kemnade <akemnade@kernel.org>


