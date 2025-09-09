Return-Path: <linux-kernel+bounces-808985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDB8B50726
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 22:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B66F3ABFAB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 20:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0111F34A304;
	Tue,  9 Sep 2025 20:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pi/6Fm4a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549C32FD1B6;
	Tue,  9 Sep 2025 20:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757450047; cv=none; b=SKTAsnS1xse1cDn5stVLnwFhuHiCMcbTiP5X0rq+uoVoRDarT7iIeNR5MMg+lv3DUMx6QtpQl34vs7Y0XoY1yjC2Sg7sfErNRShYaB2Lc2DSp0viqss/NGVAYuapSw5LquQIzub2KXpY4o88sDgx9mAxrAdWJe8pVFQnqpYr2lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757450047; c=relaxed/simple;
	bh=IsCF+MUxVzd13pKkvlXlP/Ccmh25UQn/2DMZZUacACQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Q3hHPOBXgryf3u2wIJ3qjJCxSZOlcoKFYOwi+YIMn0lOgQsJVs/lu65y5a1xyd0wvRvJM5ab6leAeUlBISkJMdvoJL1eOnCwE6jr5k6qCWdYkEyUGO8V+HqTudyPp3xFddrCTLhI/J6fGevApzpI0fwjZeWUxdzo4CnKeIq4cdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pi/6Fm4a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8CE8C4CEF4;
	Tue,  9 Sep 2025 20:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757450046;
	bh=IsCF+MUxVzd13pKkvlXlP/Ccmh25UQn/2DMZZUacACQ=;
	h=From:Subject:Date:To:Cc:From;
	b=Pi/6Fm4aKrtyZmoD47MIk+2XEaNGEKSGvzDAEn7BW6R3SWBk1tfYPJQ207A+ukqIH
	 efbIfEZ3JJAOkF/ySBMoMAyOBPQFM/rw1nm0DvlStfj5EYoCTMhbHLxssuOoiL7B5G
	 fiPDeZjvxrgusL+VBIMP3ENfrl1tODwDB7ua0e4z5g99rsMjtSQdQwtzWoGVVgh7Gm
	 G0jhyoEaZWrE+LXt+63xAYwWJQHD0uvVIBfcH+skb6uIJbFquHPWVV8/8PNVJXDBP2
	 t7OikkrH0xFC+rS5B2rqNWT/aAw4lLZBptJbcly63rI2pE0XvJNNpFfE3gBSZP3SA4
	 jR48JpShhwd4g==
From: Andreas Kemnade <akemnade@kernel.org>
Subject: [PATCH v2 0/3] regulator: sy7636a: define and init all resources
 needed
Date: Tue, 09 Sep 2025 22:33:01 +0200
Message-Id: <20250909-sy7636-rsrc-v2-0-cfd9f44fd259@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP6OwGgC/22MQQ6CMBAAv0L27JqyagFP/sNwWOsKjaYlW0Mkp
 H+3cvY4k8yskES9JDhXK6jMPvkYCtCuAjdyGAT9vTCQoZPpjMW0NPZgUZM6dGSY7Y2Z3BFKMak
 8/Ge7XfvCo0/vqMs2n+uf/f+ZazQo1LaWu2K5uTxFg7z2UQfoc85fHj9F1qcAAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1791; i=akemnade@kernel.org;
 h=from:subject:message-id; bh=IsCF+MUxVzd13pKkvlXlP/Ccmh25UQn/2DMZZUacACQ=;
 b=owGbwMvMwCEm/rzkS6lq2x3G02pJDBkH+vnPTTxzUXRhTfqE6mvGl+aE77f6I6JQGK0QmHhN4
 Zf4rbc7O0pZGMQ4GGTFFFl+WSu4fVJ5lhs8NcIeZg4rE8gQBi5OAZjIl2aGf4pvBO/b9M6u6vkd
 Y/8qc1GWt7Hm7ZkdLDMeCF62+vkkZwsjw8lGzbfLLI4ZO95qO3I0TEjZZo67WB4PU8qeOUsadJz
 3cQIA
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
Changes in v2:
- en[-gpios] -> enable[-gpios] in yaml/dts/driver
- fix en vs vcom_en in error handling
- comment delay
- drop applied commit (rebased to regulator/for-linus)
- Link to v1: https://lore.kernel.org/r/20250906-sy7636-rsrc-v1-0-e2886a9763a7@kernel.org

---
Andreas Kemnade (3):
      dt-bindings: mfd: sy7636a: Add missing gpio pins and supply
      regulator: sy7636a: add gpios and input regulator
      ARM: dts: imx: e70k02: add sy7636

 .../devicetree/bindings/mfd/silergy,sy7636a.yaml   | 16 +++++++++++++
 arch/arm/boot/dts/nxp/imx/e70k02.dtsi              | 25 +++++++++++++++++++-
 .../arm/boot/dts/nxp/imx/imx6sl-tolino-vision5.dts | 24 +++++++++++++++++++
 .../arm/boot/dts/nxp/imx/imx6sll-kobo-librah2o.dts | 24 +++++++++++++++++++
 drivers/regulator/sy7636a-regulator.c              | 27 ++++++++++++++++++++++
 5 files changed, 115 insertions(+), 1 deletion(-)
---
base-commit: c05d0b32eebadc8be6e53196e99c64cf2bed1d99
change-id: 20250906-sy7636-rsrc-c20aa6baa2c4

Best regards,
--  
Andreas Kemnade <akemnade@kernel.org>


