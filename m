Return-Path: <linux-kernel+bounces-826091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C6EB8D7EA
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 10:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CF293A574E
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 08:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CD9248F47;
	Sun, 21 Sep 2025 08:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="pNEMZFQc"
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440D02AF1D;
	Sun, 21 Sep 2025 08:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758444770; cv=none; b=SyjhMAt5vOSOr8Uu7srYCRTcqxSuvFG4y4cYCeSnpX/q5p5i8MluDBJzlwtCb9HFirpfcho5eQUW/YT15eLlrtgtixbHTUSM7lg6BQPyPl63igkCVb+mBrYzJkXkPBsyZUp2G2xYEE+lwMYYQi9360s91RD/beuUbVIzGrzlDos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758444770; c=relaxed/simple;
	bh=DmFeZAuzjiDDiooLpLk2yv2O/58zSRwZXt1vw0u+/pg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Ca0AoQmS+ODOFGzsMdM8/jBWdODJ760bZ3LMae3XH3YCjIUx5Mxty3wZAFk7UVzwJBw+qgIXpI8NCQBvquk4Dwi0rThjV2tx2i/SKhn2I7cd3Kc413zr5ZWuCkH4ac+EbVI1PJfXPvDszBkToQK6FQ5bNLK0vFOf1PJr/4DRlcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=pNEMZFQc; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1758444747;
	bh=XBIBLj73RGnSSKnxJ4ZehyTUKEtXkKIYYh2qsFiM7rU=;
	h=From:Subject:Date:Message-Id:MIME-Version:To;
	b=pNEMZFQcEAPq+wUO5yiDEPcgXX4q/ETGGXyl4xGxmKX8d6T3A16oloTlVS3R/8P5S
	 +aRAjy/eZBxCEg0bWEuPVqLyC8A6svzi6ZZcGuJKFJ+geNP7rUI842jMkLwrZNgb1d
	 lCNrqcV+BKFvQx2057b4gjZwGw8zkNTsIME7LHHA=
X-QQ-mid: zesmtpip2t1758444741t6bb70130
X-QQ-Originating-IP: fa4G0Z96TcIuLQMDYJVyH1WNdBxvsi2TGK6A1010glI=
Received: from = ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 21 Sep 2025 16:52:19 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14739136981806942369
EX-QQ-RecipientCnt: 17
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Subject: [PATCH v4 0/2] ASoC: spacemit: add i2s support to K1 SoC
Date: Sun, 21 Sep 2025 16:52:15 +0800
Message-Id: <20250921-k1-i2s-v4-0-4f819f50e468@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL+8z2gC/3XNTQ7CIBCG4asY1mKYgdriynsYFy0OOlFbhdrUN
 L27qPFnoctvwvMyiEiBKYrFZBCBOo7c1GmY6US4XVlvSfImbYEKM1WAlnuQjFECZJWfZ1SWrhD
 p8SmQ5/4RWq2fO9D5knrt57jj2Dbh+visg/v11TWvbgdSSacBjK3QKgPLA9eXfhZPpaMjtzPXH
 MW91eGXx+LtMXllKa+M8kqh++v1x1uAt9fJZ7mHXOcavf3tx3G8ASf0So46AQAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758444738; l=2372;
 i=troy.mitchell@linux.spacemit.com; s=20250712; h=from:subject:message-id;
 bh=DmFeZAuzjiDDiooLpLk2yv2O/58zSRwZXt1vw0u+/pg=;
 b=RaWOlpC5FWPJwn3c47TkAmC+iLUD31NCfLHyxz/qOMkN5rnFVMjNAZFAmO+/oPh65efNMEq9+
 +MzyQEXLjgWBk4MPN/I0whyQLjfzh/m/rKrrS2hOzHfxR3PrCA29Iqb
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=zhRP1xE0bftrurqSWI+SzcSdJGIZ0BTTY9Id0ESzqlI=
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: NxBUFebUJrFWwqnmh9UVFdXwpSTHzBo4NnP9/yzoMkWB7xFjeIYIANy4
	YM683d601mtJ42vionL5XjxIYs0fpmpMLzbzb6VBwmyQBXCUwE+hns2NfZ4zR9RE5uSZlLL
	z+novtX+VvjV+lx9tSKvK8/uZmRrph/V17jeJNghFN/HO2Ap+rlX7mUZahDEQF6S6vKxQa8
	barPat2lN4R1p/3aIkwKYeSeowXdXtl+3FbUdFA10LvfXkFstGZHkPMeYQWtH+R9qjN6cTa
	kbr7IpNzOCHrKnbBq0rq7vvOXPNTRL6k68DiKplapjMggBN1MFM14bn3IxNAlzwPwdxyQEk
	RKNuppUYQRJGx16y4mjkq5SGZrBoYGX4yxwHdbnpy7+28ycyezdMMUEOFj61iiK9fxPK5DF
	5VCXXUyKgK51lriP/mLgPwpKt5oTkLCaXjOpdJ9oy+exXzj+PhXXdITGabK1Xb/bbPDI1w2
	Bf3cklVWCaHHViVzwHeMgYGKHlvNDC60/SbmD1Uo8B+aXd+jI3iUPiG54hqncKIH5NDk33I
	C7LASjLkdMTgAGjpsW0uyj5NmovHR7xbRkWr8B717aCQhLWiUUiyOSaZqnAINpZuLeVxh7H
	S18KNUcFhR2QnZSjb1Ez36KcAEj768OmfvMTOFBnfW5KzghVLVWp5Q8RJ39uIpyhFZoWjjl
	FjKAkoGubUq24WmUKcHV6nUnksMvNWECUBXShcSHIwOqok96k+CuJ3Xoq5f6sY0+7MC+5FO
	RhH1gz1G1GhLQBdwQy7Rg2bx0h39NRvEev0DXqHuhQsAthvo1bWgiRBsZ62GqyZqXDHX4j0
	o+nRTq3GYUno6JlrlSSm3Fr28dOOvfAi2ebLE/705uRsA9BB2UU3dZUOxR0SxJ3VDvr1gZ3
	8u70qikLnz3N4utH39XPSn6i+gL4/3rG7voJpJPaO4mPC44zJowZmr60HAc2z2TuybgafMF
	7BmmFwrY98Y0QPFOox+kH3GqYdbOb+pRlPRL5BQ7u3A/wQHjJy0lbY5y1VCOc0FfGf/QFTI
	Ycb+L/qExsci9pb6CuGbcGJ5Pr8WUwwso3z8LKfFMNbEmU4srzj/3FzIU0YXPd+jyjLtJWf
	OLIlvV7eWMKgS6hFliGxIWkH+vHHykc2+ZGbA/GLW+PgYz9DRQGIZc9/0W+P79Fx0TMP1y0
	IpyjgTES0bzPGE8nzjrvB4MWRA==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
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
Changes in v4:
- Patch 1/2:
  - nothing
- Patch 2/2:
  - add some comments
  - adjust supported PCM rates and formats.
  - change macros from SSCR_DW_(8|16|18|32)BYTE to SSCR_DW_(8|16|18|32)BIT
  - use constraints API in hw_params
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
 sound/soc/spacemit/k1_i2s.c                        | 463 +++++++++++++++++++++
 6 files changed, 573 insertions(+)
---
base-commit: 4f010aced22532eea2ef0d9a2f5db7c64a196fec
change-id: 20250813-k1-i2s-115bf65eaac8

Best regards,
-- 
Troy Mitchell <troy.mitchell@linux.spacemit.com>


