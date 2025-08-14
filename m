Return-Path: <linux-kernel+bounces-768321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8544B25FC3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD8FE7B7BC8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 08:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A6A2EE29F;
	Thu, 14 Aug 2025 08:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="kS0dw5wN"
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB062EBB96;
	Thu, 14 Aug 2025 08:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755161689; cv=none; b=BnaNZhl+nC7yUX9MUDkBmgOQO5/M9AfsgzcZRcBtk0L5xjCOKtq5MpmUSE8ytE29Tj259fiAvDUbKjSZ4WcN4Pvx/7eiyQpM0hhTUUY+YBrb6F8fm8Op0Phn3+PwN1N37VOfj6Wlx2hCvdAWUvRupOcIl9OQx3jv6LWUI6dYzQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755161689; c=relaxed/simple;
	bh=QgGpAdvzuormNjUn6tUmYY9jPTavcmAGKkKi1zctL28=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=krE/g+hrLVJQXbk8uEZDRMtWiHtvmCCFz2PgHpat2yDjo4cfolvmltPfXeT6NeKK38glgn4CpOsAv2rLbxUZYaGFT3H5vrU0Q1BMFIPpLJurqmk+4gR50BHzSWFDXHb4wbdLbk9V0qNctpwL35bBxod0trlJSCWnvtJ4KzUwwhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=kS0dw5wN; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1755161671;
	bh=Ke3beEqe6Pa4xwQguH8Wm9RAEs+vkFTy1jmJSngED4Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:To;
	b=kS0dw5wNinvAqKYXLoMCEkD2yRtQVZDQQw2U+8URw0fx4ZpAIzTqwGf3wLsjdYXM0
	 Y1xXN7tQmtYHgiUbJJ04Vv1YGNV9CEyzvcnaxT+E1dOTyxU3rUJpjrNjcKN9UZR59s
	 4Jg/b4zTph6sxhoMHOK15xNCBjGPRjqgcUR2/Trc=
X-QQ-mid: zesmtpgz5t1755161666tdaa37b79
X-QQ-Originating-IP: xyGPJ5a57LfI2fCmO+XffstQbpLH+Fv6qZj+s9/q1UU=
Received: from = ( [61.145.255.150])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 14 Aug 2025 16:54:23 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2060538249097170707
EX-QQ-RecipientCnt: 16
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Subject: [PATCH 0/2] ASoC: spacemit: add i2s support to K1 SoC
Date: Thu, 14 Aug 2025 16:54:18 +0800
Message-Id: <20250814-k1-i2s-v1-0-c31149b29041@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADuknWgC/62QQW6EMAxFr4KybqQkJDhwlWqETOzQiAJToLTSa
 O7eMGxGapddfsv+78k3sfKSeBVNcRML72lN85SDfilEeMOpZ5koZ2GUccrrUg5aJrNKrV0XK8e
 IwYu8fF04pu9H0evlzAt/fOa+7RyKDleWYR7HtDWFjw65VFTVBM6WzKwIlPIlYbTEPrJ25LwTz
 x5NcVooe1iE9+Fh0vPEC27ZW+YaULZm1oDNbo7jf6OChmcqWwMm6ljnPzS7+4WqOgZ0CJVHjKF
 TQBqgI5P5FXbesmWFgfhPlNLya16GNPUtjdgeg3Y3EsiE6FSFSNDspbjc7z8Wj7lBwAEAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755161663; l=2411;
 i=troy.mitchell@linux.spacemit.com; s=20250710; h=from:subject:message-id;
 bh=QgGpAdvzuormNjUn6tUmYY9jPTavcmAGKkKi1zctL28=;
 b=HO70OsWIvdbMolshXdBIfReQ6sDMnZTin41uCKGbrCSaqlVvv0JcII+K2L+wrBi1z1xSvtNRi
 98J5274iTZ6BZZSjNc4bN9jrB7B93X/TaMZ2ToMXk66cfczgcA+w9Fe
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=lQa7BzLrq8DfZnChqmwJ5qQk8fP2USmY/4xZ2/MSsXc=
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: MnDLfP0IFnF4q3CsMA0+AlK0uRVkWrUFp5e+7IQt3dc2Ko8ZIi3f2tkA
	YA8N97cyTXJPKUl43DHFElWU6/DloiNupc09qH7vlA9AU0yzo11ZUH4gvCkJu1ttfVaQb7X
	H+zxC3DiHV6MxzV7l6qVI+fTKlCZnpg3pJ6EUYLtOoo7UEi5Vljm5BpAz9VpAoXVkCj/n8K
	c0j89NZIp2hOd6NRpo2bVTFTIY7MDCjfm3cY0aYDJHIhZVWveCRxsjMi38UbnCVecyGdKPs
	wNljE9FnmLrYaKA4lqrR/cO3XA4G2xhRAQI+oFw+b/EyK4NfZpU+mz3wE+EOwfUxe4+kver
	PhDh9PFHdGvnPXFWUmFmzEwOl+2dBs0dqQ2f7fLgeiYTcH3FGM6T3cC1bZoc0Cq2Y3CzUzW
	Bsbt6uljO3K0Fss/ByvNYL8zURAvBluUy9UfqteqXgcXs2t0Ggmb74WS+beJf8KOW2HX+Ft
	Cjf3SrHi81AsVd9uK4zlu0vBaNIyAfLb3HiS4QJ3dNf4qcautBN5vfD2xRdfvTT8EML0wqU
	MWwtIS1cOd09D/fedY1TOoCDCf7OSVSDe0HJSGFgvsz0RjurNIx3XaCmOqYpVKXg8hzEUjc
	Kst6qTMNWEpR/sJPBEwQtzS7rt+jnRS8Tq6IvSa3RaL741XMnSkmfygdj0b9FFUCTwjz7/4
	f3q0OBoV9FvbcF3BPwZeBgodf34EezbENzrr3X4Zmy06gG7wthp47avo2zOp7IstdUVtZ8M
	cIQ1VFnb+EkvWtOMIqgR/eOMHWe8GX2q5tYaQfMXkCAaZvidcRyM7/cojfV1DFB2PDNKAls
	OfwNialf+xzokq2MJdqYPAlKk0nXP4ikTNPmv+4/sUuZOMK9XYKLF6Ez6tFFp6smXuCxl03
	DrVgWe/rOyQc9Lm/0Zm2xT87rgB0Fv1+/W4luVtKzrSG03ezC0ejXdYJ2WEJcFwOB41+Mxu
	6vKCML/FMMd2GzrVylyb4hUFyho9Zfy03KxHvawfKnZ+BUtqH5bG9G4VB5BL/MognFBpi9J
	/NtT0CHGip+M7whJtdb8QEWT4pmEol5IzYdy+tmhHAKf2aWwMpdnHlxxu0uNmIej5wPHGL/
	LNryRAuI8kfRd+8cv7wyQnzcvzfQkuw40XV3ynE7qcRMFrIPLwmkANgJTxZtr8HdKNAb133
	kbY7b9BgyJ5QrD2PLs0AyEz/C3cGDlhpJAXGz/l/8phHp+m2op2/JsXR2g==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
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
Troy Mitchell (2):
      dt-bindings: i2s: spacemit: add support for K1 SoC
      ASoC: spacemit: i2s: add support for K1 SoC

 .../devicetree/bindings/sound/spacemit,k1-i2s.yaml |  88 ++++
 sound/soc/Kconfig                                  |   1 +
 sound/soc/Makefile                                 |   1 +
 sound/soc/spacemit/Kconfig                         |  14 +
 sound/soc/spacemit/Makefile                        |   5 +
 sound/soc/spacemit/k1_i2s.c                        | 444 +++++++++++++++++++++
 6 files changed, 553 insertions(+)
---
base-commit: 6be7a5a768aafcb07d177bd2ae36ab84e4e0acde
change-id: 20250813-k1-i2s-115bf65eaac8
prerequisite-change-id: 20250804-k1-clk-i2s-generation-eee7049ee17a:v2
prerequisite-patch-id: 21c0ef38a82ad5f8e471bd904559e5bf68099445
prerequisite-patch-id: 6fa5b6872559a75651342831399676ec96cc3974
prerequisite-patch-id: 03cbe1816e519bc16c641055972558fb5eec6a37
prerequisite-patch-id: 1ef339ef1a80a508b5761dab1ddf448a985864e9
prerequisite-change-id: 20250717-k1-clk-i2s-e4272f1f915b:v5
prerequisite-patch-id: 6f2626811da4833395f52f712d9f2a5fb553cb48
prerequisite-patch-id: d2594982f7a8f39c2aa4f21490a19e93ab67254d
prerequisite-change-id: 20250701-working_dma_0701_v2-7d2cf506aad7:v3
prerequisite-patch-id: 3fe97698036c32c20d03b1b835a5735e8ee8126c
prerequisite-patch-id: bf64cb2fbb9699d2ace64ae517532f13c6f8d277
prerequisite-patch-id: 49263c65c84a0b045f9b5ae6831dc011c4dea52f
prerequisite-patch-id: a62678262e4fd2361b8c0c535ce34853febf492a
prerequisite-patch-id: 1b840918a99543f4497b6475ee52977bdb59f1c3
prerequisite-patch-id: 75e5a355a32ceb2b0047ead035c07c5b201bebbc
prerequisite-patch-id: bc8f599bef77297a7bd69736bb5307a0964aeff5
prerequisite-patch-id: 62d0b3678cf825bca51424ad85cf35ebdd6dc171

Best regards,
-- 
Troy Mitchell <troy.mitchell@linux.spacemit.com>


