Return-Path: <linux-kernel+bounces-857208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D494BE632B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 05:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67C7419C5F28
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 03:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4CD12472BF;
	Fri, 17 Oct 2025 03:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="K2DRWzlZ"
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56D233468C;
	Fri, 17 Oct 2025 03:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760671008; cv=none; b=XuQS61EBsRZzGK44HSOn/RrWL9LPAHP4wNplFip2B4UpfZzfLGr/vj14rIk1LkIg+VXLvDXyem3Zlfanjaq3NEsVup8zN0ejI5wzENVwBJZl9XRkRS0YQEn10I0/3YydJ9zXTJC+8K8o6fV5akmfh9SBKzHUaCynylKG7+RbkYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760671008; c=relaxed/simple;
	bh=H6MXMa94xtKyGaXuh1vx3wBJduWNEFwnAtdX4wGFjLk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mza2k/NxCLmqu6qaYKkCRQfxXRsyjyh63fn/CeSr8irWozKbdnFM+56zmgW56GNPHP6nLwDWVuioux5Pn9hfl4ksATC+p6NZx/buQhLk1Ox9dOFING0HzibPuByjRda1fijIsfQ5BKCB3T4EHQGufg222BnRb4+6cP81zWcA4sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=K2DRWzlZ; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1760670990;
	bh=9v+Fk5DTo7hNssP/g4f19A+iJjJ8TGD0OsboXHdESE4=;
	h=From:Subject:Date:Message-Id:MIME-Version:To;
	b=K2DRWzlZuR9w+z6jw1OfCzMn60BcSNWkNeKxVojslqYIqLBsV6M2oGuiLdD9CD02p
	 1W+Mc4M9vxPCisPMwPyZPmitv06FH8llU/jJS4DpLWTY+lR2yWr6rkOp+mOhjKI2lZ
	 BJ9UmK8yE0L2CUX4yPTleJo7qx23s/lFAuPpmToE=
X-QQ-mid: zesmtpgz8t1760670983t788ce284
X-QQ-Originating-IP: qojL7vMlfQaFlybfSpLBeg6YG6SOl86XqCU3XD1N0BY=
Received: from = ( [61.145.255.150])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 17 Oct 2025 11:16:20 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15174984363743025248
EX-QQ-RecipientCnt: 17
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Subject: [PATCH v5 0/2] ASoC: spacemit: add i2s support to K1 SoC
Date: Fri, 17 Oct 2025 11:16:16 +0800
Message-Id: <20251017-k1-i2s-v5-0-401ae3775fcd@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAC18WgC/3XNTQ7CIBCG4asY1mKYodjiynsYFy0OOlFbhdrUN
 L27qPFnoctvwvMyiEiBKYrFZBCBOo7c1GmY6US4XVlvSfImbYEKjSpAyz1IxigBTOXnhsrSFSI
 9PgXy3D9Cq/VzBzpfUq/9HHcc2yZcH591cL++utmr24FU0mmAzFZoVQbLA9eXfhZPpaMjtzPXH
 MW91eGXx+LtMXllKa8y5ZVC99frj7cAb6+TN7mHXOcavf3tx3G8AdtzFYQ6AQAA
X-Change-ID: 20250813-k1-i2s-115bf65eaac8
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
 linux-kernel@vger.kernel.org, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Jinmei Wei <weijinmei@linux.spacemit.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760670980; l=2628;
 i=troy.mitchell@linux.spacemit.com; s=20250710; h=from:subject:message-id;
 bh=H6MXMa94xtKyGaXuh1vx3wBJduWNEFwnAtdX4wGFjLk=;
 b=2qdTVowky+Z8Ihqbuc6bZSGsDb5dg0rzRSLjEhkDL4iVIM9eGvIGoFF8dupuXB2xLZZeMh6rE
 QPnp5+IJ4z0BtRSKUfZlGu4HhQNgQbnlmKLqGf3YgkOwuWqJnSaHu6/
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=lQa7BzLrq8DfZnChqmwJ5qQk8fP2USmY/4xZ2/MSsXc=
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NwuAg3qwKjaTa+EgQsOIIt4o4iCl4r8Y39U+qzsSaq8sHkOrmds8vLRA
	8quZQD+tpIzi6KSTnY+ECbJVTzTh3x0dPndljC11iDA4EeHnqQ9359ruSIy3kJEWk0iF8zd
	pY+MGHVsNnIkL2R4TpVkgYm78M9lgQVGrDkUhDeetAQWQ2Z0sZUcrvE6DWG12QIjS0InqhB
	VNT1G1l84n5a/nCCi063VuERaBGffH6wuU6XR+gd/oDMam8WzGRwYEsyAHCm4xyQJx9bVpX
	oPoLj941zUFRm8L3xpHJpSUsiixLqWZlW6G3MhYKq9g3urZhpQpkQS5wywikkTcWbCv/AMW
	eQduyNQGkzQ5sFlnhY4iTqS8mIWqauHg3MQ9iQuUBgkD1g8LJj1v/BhQ/+hwN49Bs1TH5no
	3ldjM8JAjcl1JOUV7Qf5JowjbZDxomk/U6nKX+PU7A4vap2qzR0V59AtOzcwltLX/0o9NHT
	WDsqsFbLt6fu517EkawEdaGqjcZGCat+toBMp7O738tnDLjy7Kvunw+lVpiRwTAOXea1vmB
	juxCZzYAR0L7hnRkMUqUdryE+ihWYuuCIbU4iP3t0fK5CwZ7GJcAC/5iCamFEDQ6FVNcfaL
	LujmxUI5TyOJ5Ja1FTN+uxJQxuwVMCIKPM4YaM1wNxFVRqGbZVGsZmhkBUDLoA7xb2eXAVW
	mUSrvp7Qu8THAdLp7A2+WmOZ0SvlOpNYQVOQ2V4ycjNgR+atQg6Oy/UeqZoqx0/VGYRU0vf
	1U/ceg2P5oHK3ipxh6ry88QJ85MP5uYbM7xRfoSH6goCKSVkTz/ZhtsmX1GUsUZqBK+wCK7
	ZGKqdB+PM1/Hx7SyBjufYcjrtHem1OqZVU1QdKceHpwrkc1z1G/UNXU2IJjqQWSdILzU2wy
	HTPYXPHPB1EC2bkYMRnzstOlGYoK1V4rNfDl0ydakfkQNXSKbhOwWxGjcLHic07o5kgLhw8
	+hR7gcL7F8YvaXL0g+Yr+F7Qw0fSvnfa6ERFiAhFE21PYHNCwSRs39GOi3C91pAHhrqWfJB
	CxqCTh8mAsVx6j6dKmQKDueK6tNmSVRw75CMq7F9ZxKvXZbsiXjAc67JHrV1pRz/YpwdVGy
	CYxsSY3Zq5cVsJhANmOjQ8Y5YFF56/hWARqO1yOwG1W9Tv/KQ2OMTX0/atPk0k3YizNwnxs
	H8KizZoRQ/jlMzOVp7fy2V7fgB9NU/tP0W9ZLnbw/9jNL+8=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

On the K1 SoC, there is a full-duplex I2S controller.

The I2S is programmable, with the sample width configurable
to 8, 16, 18, or 32 bits.

A dedicated FIFO is provided for transmit (TXFIFO) and another
for receive (RXFIFO). In non-packed mode, both FIFOs are 32
entries deep and 32 bits wide, giving a total of 32 samples each.

The register definitions can be found here[1]

Link:
https://developer.spacemit.com/documentation?token=Rn9Kw3iFHirAMgkIpTAcV2Arnkf#18.2-spi%2Fi2s [1]

Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
---
Changes in v5:
- Patch 1/2:
  - nothing
- Patch 2/2:
  - dont't read sspsp value in spacemit_i2s_init()
  - set SSPSP_FSRT bit for DSP_A mode (was missing in previous version)
- Link to v4: https://lore.kernel.org/all/20250921-k1-i2s-v4-0-4f819f50e468@linux.spacemit.com/

Changes in v4:
- Patch 1/2:
  - nothing
- Patch 2/2:
  - Only 8k, 16k and 48k rates are supported
  - Only 16-bit and 32-bit are supported
  - Use the runtime constraint API instead of modifying dai->driver
- Link to v3: https://lore.kernel.org/r/20250911-k1-i2s-v3-0-57f173732f9c@linux.spacemit.com

Changes in v3:
- Patch 1/2:
  - simplify dma-names definition
- Patch 2/2 
  - remove empty spacemit_i2s_remove()
  - move FSRT setup for DSP_A into switch-case in spacemit_i2s_set_fmt()
- Link to v2: https://lore.kernel.org/r/20250828-k1-i2s-v2-0-09e7b40f002c@linux.spacemit.com

Changes in v2:
- Patch 1/2:
  - modify commit message
  - remove unused third cell from pdma dmas property
  - update SPDX license in spacemit,k1-i2s.yaml to (GPL-2.0-only OR BSD-2-Clause)
- Patch 2/2:
  - modify commit message
  - reset_assert in dai_ops::remove
  - select CMA and DMA_CMA in Kconfig
  - use devm_reset_control_get_exclusive
- Link to v1: https://lore.kernel.org/r/20250814-k1-i2s-v1-0-c31149b29041@linux.spacemit.com

---
Troy Mitchell (2):
      ASoC: dt-bindings: Add bindings for SpacemiT K1
      ASoC: spacemit: add i2s support for K1 SoC

 .../devicetree/bindings/sound/spacemit,k1-i2s.yaml |  87 ++++
 sound/soc/Kconfig                                  |   1 +
 sound/soc/Makefile                                 |   1 +
 sound/soc/spacemit/Kconfig                         |  16 +
 sound/soc/spacemit/Makefile                        |   5 +
 sound/soc/spacemit/k1_i2s.c                        | 458 +++++++++++++++++++++
 6 files changed, 568 insertions(+)
---
base-commit: 4f010aced22532eea2ef0d9a2f5db7c64a196fec
change-id: 20250813-k1-i2s-115bf65eaac8

Best regards,
-- 
Troy Mitchell <troy.mitchell@linux.spacemit.com>


