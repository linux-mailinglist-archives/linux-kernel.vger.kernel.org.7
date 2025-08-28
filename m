Return-Path: <linux-kernel+bounces-789211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3D6B39245
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 05:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26B4E1B20D5D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 03:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6218D25A2CF;
	Thu, 28 Aug 2025 03:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="oOS6imXc"
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422EBBA4A;
	Thu, 28 Aug 2025 03:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756352289; cv=none; b=ulR1OU4cye8Qbi0a/tOwRggwKyzwc5JE/3Bbnj/oZMIjWHzLoG89QaT5kLjFMwfktySFR4XMuf+V4qVQXsrNlJBUioRVuFqvx9uSYvwV/wiQVuvX8meVunIMjz1z4s2d2F9Al92cCO4Gdvzlzg1Xf3sZT7m8DUwt0XqvDrxFtYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756352289; c=relaxed/simple;
	bh=H9JM7KaiTEuem8gTBIUL+9/e3Y5d6TsZUkFCScNdBJs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IBU6hxdovKBNbonkEc2XrCEHyxsQWolIrIL87jK0VPx0+9dXqXe/Joi4ORl4IaFywWz9t8UtvAogBWQJcBw47x1bZ43TLFDc5C0TxUfcmq+akeATKYKzrPFXG8ENLI1adXNlcl/xxJx6rUJdxqegwrKXJXbNC7UpmQ/Ttw3IT00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=oOS6imXc; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1756352270;
	bh=nvA92LYL6TES2+JhKWx8pUHrSNlBcF0zDiqaCtaIi9c=;
	h=From:Subject:Date:Message-Id:MIME-Version:To;
	b=oOS6imXccSWg36Y9gU7FPgs55BPyNcFBKWyLQjBZBgHIXK8Oh4qG5u8LPH9I/Nol6
	 9QCTqrMJGCF6ncmGGJ62Y/4r32K9/awnRbvH4sRtO2ZkzrWy8LU3CO/KaervBb6Xcx
	 ycZKu7RhKE6v2pcBxVBU3NJtglGAvWuqvgCYN8UU=
X-QQ-mid: zesmtpgz1t1756352263t24de1d74
X-QQ-Originating-IP: 8A8Eru9mCTqhfoGSiLMYDui+My6y+LChdG/s2XDmz9Q=
Received: from = ( [14.123.253.129])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 28 Aug 2025 11:37:41 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16113311847530731234
EX-QQ-RecipientCnt: 16
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Subject: [PATCH v2 0/2] ASoC: spacemit: add i2s support to K1 SoC
Date: Thu, 28 Aug 2025 11:37:31 +0800
Message-Id: <20250828-k1-i2s-v2-0-09e7b40f002c@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPvOr2gC/22R4W7bMAyEXyXQ76kgJUqyg6LYexRBQEtUKiRxO
 it1MxR59ylOB6xYfx4h3n3UfagqU5Gq1qsPNclcajmNTZgfKxVfeNyJLqlpZcA46NDqPepiqkZ
 0Q/ZOmGOn2uPXSXK5LEbPm7ue5Ndb8zvfh2rgKjqejsdyXq/EWkM9miyOwbEVJtunTMF74yTET
 nI0Q8/qX46GtVAA3SjiYb+Q7GSUic+NW4tIAOpFMPB6ptvyl9Rso/MWcwAhS2Kxi0QAKIYwJAo
 BMviY4LvUAKjfT9O+jLttOvL2NtjORodkYnbgmVNYz+6/zC47FgvJ9yk4sg0RUgDobOJMSbos6
 JLrlsWj1MqfoY/3W82XW2enQRsMgx9CFAb/81DGt8tDfeUoLe6hpT6p2/+/lHo+Tb+XXmdcCvi
 skP5WOGMzixaR+sH0QPiNmdpcr9c/FBpXWiUCAAA=
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
 Jinmei Wei <weijinmei@linux.spacemit.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756352261; l=2820;
 i=troy.mitchell@linux.spacemit.com; s=20250710; h=from:subject:message-id;
 bh=H9JM7KaiTEuem8gTBIUL+9/e3Y5d6TsZUkFCScNdBJs=;
 b=Jqg1lUiztA2/8/dxSHFeC/Rlj1+NK9GzjZCOWksp8tMzjsKISha1T+HE9F5SJZWlGlcqs41L+
 HGZvhi3bEQ5CamOiYzl5xVPNtG1s+0zXhMI87xXwqvYQz+34DxBDw81
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=lQa7BzLrq8DfZnChqmwJ5qQk8fP2USmY/4xZ2/MSsXc=
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: NjfDZKXN/FcNObUqzEkCvWctUngNcFuoiuKNa9sP2R1THFELOavGao6/
	sDdszANP3Z9am5CqENKaGbE5BiyHNIKMlX3RxJ2r88wd5oEf+TrvYRS/9iTCXc6fMS/XvLO
	Xc42pWNDwPdvJtAG4XliQOfut8x2MZoyMS0tNAGBBT9F/paRclAYhSPedgQ0ioPT1ErmsVS
	xdBBlqLNyM/Q7VR/Yt2kSwGBjqOsGNmeFbTg4dH3vH/o13N55Cq0Xh9nkf2qSJyt0/4JFa4
	wVTmWd0eOgjnEs3dsKTvw1Q0rDxn789fhRYeLn9Ph3ORuVosM/H7tHs1uZhm9sHVFVEHqdS
	tqbE0HVSQCWoYXzT4/50v2Wdm9jvdP6OAE0uguOeHypPxBeXrEpyupl8CqWsJLnV6r/bklu
	f7/ZfBjAAeEYgYnJl8K/aQ73vEwKIms8H98MCDFPtSy81bYaK2TMKXS+7qUcvrd9KchK78g
	1XMQOTuM0SrwjzBARJhVFGHv0vpiQZbfh8nfZNqlXdH/+XuxlV7dl6tQ4hEkksuCdmL15TH
	NwhVRVYfqEki2Zyr57DAjHUubQTNZu+10RIKR/XXT8OKoszx3f3XFfI6F2KLvMGhmC7bBUm
	u9d1gnzqPesEuzVonXouFkd1aIhkPtNdZMtVn4yeQ0Ig899+Y2SrGocMyVET93YJSDDosWM
	XeZhNgELb+LXN6wTCTL0j+F1Wc0UpNYE5+plYr+dGYOtZ/IxRgHAYyBUQNO1y+DnDcS1XnU
	9pJg6DEQ3t4hJe/3/e6aeUQ4akfcDwQM5mm0T1mDhpqZsXp7fmMpJSIEvAVV24uGB06Pt+w
	RD9a3qFPEcuazLV+IvVUgDZOIpMlm1FtD1sbQUjC3Qe3KVpmN+IKCcXhqU6Vsvg9N0mpGPY
	Hj44Q+G0+huE/Tvq3szVyScgr1z/dBENQ4qbTOPLulEKn93votesvwqX2KJuVgkWCgl6zOC
	NNK7oM+o/OOxJUigmjXfxi7eW2gCdrsLB7Cw5t3DZrxx9kSwNCrvDon9LeJpiUu7sVficQ1
	/yEkJPWAZGKWUdqrmBA73y0yYNcvngL83Cn/uAR95vowAR4XfOXlCseNTyw7mX03RMXUK71
	GBHRvT3lMthRsjNa9XLADRSqIr2Tyi76LDkyMHS702faE/xqAXqBgwSncmABl57aldI0XXt
	szjM
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
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

 .../devicetree/bindings/sound/spacemit,k1-i2s.yaml |  88 ++++
 sound/soc/Kconfig                                  |   1 +
 sound/soc/Makefile                                 |   1 +
 sound/soc/spacemit/Kconfig                         |  16 +
 sound/soc/spacemit/Makefile                        |   5 +
 sound/soc/spacemit/k1_i2s.c                        | 452 +++++++++++++++++++++
 6 files changed, 563 insertions(+)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250813-k1-i2s-115bf65eaac8
prerequisite-change-id: 20250804-k1-clk-i2s-generation-eee7049ee17a:v4
prerequisite-patch-id: b46d4007c5b20f11845db739fc78ffccc54f4dab
prerequisite-patch-id: 1e193c412de1206c024a674e2dd7da88092976b9
prerequisite-patch-id: af07a4bca4109b13a74c0b20a12f96af863090ef
prerequisite-change-id: 20250701-working_dma_0701_v2-7d2cf506aad7:v5
prerequisite-patch-id: 3fe97698036c32c20d03b1b835a5735e8ee8126c
prerequisite-patch-id: bf64cb2fbb9699d2ace64ae517532f13c6f8d277
prerequisite-patch-id: 49263c65c84a0b045f9b5ae6831dc011c4dea52f
prerequisite-patch-id: 2b43599bf7568e6432faa2f6aca5b2db792cd1c1
prerequisite-patch-id: 1b840918a99543f4497b6475ee52977bdb59f1c3
prerequisite-patch-id: 2f77be523fd5423bd011e3081a3635d130410096
prerequisite-patch-id: 78bcc660796fc4f73b884d17a1b63e62f99dfdd0
prerequisite-patch-id: 62d0b3678cf825bca51424ad85cf35ebdd6dc171
prerequisite-message-id: <20250824-k1-clk-i2s-v5-0-217b6b7cea06@linux.spacemit.com>
prerequisite-patch-id: 6f2626811da4833395f52f712d9f2a5fb553cb48
prerequisite-patch-id: d2594982f7a8f39c2aa4f21490a19e93ab67254d

Best regards,
-- 
Troy Mitchell <troy.mitchell@linux.spacemit.com>


