Return-Path: <linux-kernel+bounces-811380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C30CFB52846
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 07:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 735C9179E43
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 05:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629352586C9;
	Thu, 11 Sep 2025 05:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="pMwb1HTB"
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.65.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CE9254B09;
	Thu, 11 Sep 2025 05:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.65.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757569678; cv=none; b=a49jvco+l+OK6FN0qinnH6n5b0Nm39Ym4XrGP8mm2z/fuhVU8w/RN3ssK+T8SXjYRFhi3JkFZn0TGpeNomqqpPjle4BDMV7bF69v67DANr9SVe+pv3lcALBqxpKxyHtF2EqKsP2DAqVK6chPzocoFSQwJcEYC0xrzh8nJPqExZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757569678; c=relaxed/simple;
	bh=wyo7J5QXwYorHs3VIYK952W/gBVMDZcLxmYyvyfKHKw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WoY5oe7jJ7NT+pWSXQ1f9ZHD6Yfhx/ctYbLgY4Ow88SKutsJMolYJvVHpEI7PvxjEhErWBj7g2y7OnRKw3+PZXBfqfgMLA9Nb6qb6iRstDSAKMVMOlYTsILo+bWNBpivMA8WTuUR3CFCVf2tpx9M03cHuCL/mq8iidFY5uPBS7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=pMwb1HTB; arc=none smtp.client-ip=114.132.65.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1757569647;
	bh=gba1Pk4T5pQwOY2V80nBcfMbzr4ZlXRsPp1nhoH8bGc=;
	h=From:Subject:Date:Message-Id:MIME-Version:To;
	b=pMwb1HTBJoByXcZi6NBPN7p1l5wqf7G0hCReGWdvnltO+3ZClJOjy9rrkZxiWLfjs
	 qRu+kyJpl/nxmHO+9HOoQogYEvdp0rGR9gCvl9G3GVpBevqXeGxi49fDPycCVfFpBA
	 rlYfJiFAsyByfRzC214uXcvoSu2Q0DTz0z9dUcqw=
X-QQ-mid: esmtpgz15t1757569640td1eec744
X-QQ-Originating-IP: zD+y2Tss7YaPUqLQHkkUXRkXYwluZmlFiaX+x5Us2Xk=
Received: from = ( [61.145.255.150])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 11 Sep 2025 13:47:18 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10611340100835449465
EX-QQ-RecipientCnt: 16
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Subject: [PATCH v3 0/2] ASoC: spacemit: add i2s support to K1 SoC
Date: Thu, 11 Sep 2025 13:47:09 +0800
Message-Id: <20250911-k1-i2s-v3-0-57f173732f9c@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGBiwmgC/22R3W7bMAyFXyXw9VSQEvXjYBj2HsMQ0BKVCmmcz
 krdFkXevbLbDhmWSxI653zUeeuqTEVqt928dZPMpZbT2AbzbdPFex73okpqc6dBWwho1AFV0VU
 h2iE7K8wxdO3x4yS5vKxGv35/zJP8eWp+549lN3AVFU/HYzlvN9lE6wxmD0KGxGCIRAAomtAn8
 h4yuJigu+bYblYKD6ieT9OhjPtdOvJuWexmrXzSMVtwzMlvZ7tI/8kUYzT1qLNYBstGmEyfMnn
 ntBUfg+Soh54X4VFq5c/Q72tqj7jcHh8O6/17GWXic/stNZMCFQfWQGwhUfj5UManl7v6yFFa8
 l0D+PEfTciWxUByffKWjIhA8gDBJM6UJGRBm2ywt2mCpmua2TYEjX5wg4/C4G4iLL3cl3o+Ta9
 r3zOuxXxWS1/VzrjcYxCpH3QPhDfMVq9ZX+l1+KvXTQ+9+IFai6DjTf3lcnkH6Rban30CAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757569637; l=3133;
 i=troy.mitchell@linux.spacemit.com; s=20250710; h=from:subject:message-id;
 bh=wyo7J5QXwYorHs3VIYK952W/gBVMDZcLxmYyvyfKHKw=;
 b=iQIwYBxkdVAD/JmeC/sIDKyr80CBKdbO6QwoyhiURHDrmlgONjNFU6gLoyjhAd0u0U/UA6+jb
 aV0mzBdX1xdC2qd7P81w+h6MfH4EBBo5olHja30qxUOlLOvdPzRSU+x
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=lQa7BzLrq8DfZnChqmwJ5qQk8fP2USmY/4xZ2/MSsXc=
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: MA4gBIaQqRQg3kL+u/xQbbRIikTTteDhmXsZPSJKc1N4l+hYE6nomKJh
	Hz8JYgPfx3boklRdfIu0W/n2yCszq5JpEm0aqqMT1st2ipMLw6VU5LhBw7/Dr5uwcgK8dKX
	vsr0BQm6X/3CvpZhnESnfzJWy77wwvliRQ1rqqKh50ioQyMOyWhwQcJnoXGn4c09WSH/imu
	Vwm501cc+zBB7oZxuqnTbZyxNFNb4NK11kTQ5V9XjJ2LRnIPM/wlL2LPqySBDOdzoZy2m/h
	jd0hn7ohxZsuuvKbdTP80Saq6Ex+ebyLaVtG5x9W6a8vnOto5WfRWtzgtlWfi/or/3xy8SH
	74SBgiTh0LmKbh8hpzV/Fnpah2DWR9pGgNSY0jn722U1/6jrj/1hzhttDX//UlE323tdTT6
	ebWU3hGDLf5z6oxj4wQi0ZJGQzopDwJKKX4MYQHQIiVGCvbYBt007HEtsReASmlXAvK1cK0
	D++tl2Pslbc8aRO2Or8DiYdOwEOpzDRnc2W5XWMycT3QMgwnrTARVGMj9PhgWk3CHKpBqqj
	iZgfi5/fECYqrbiMFgV8x1lmiwnVr6GF8fnyme9F8yVp+bfx6ve1Dvyl0w0MPTydnI0weo0
	mG7mz7s7M76HBy1LgDr0UQCQNR1bMNEZdxlcGM4mfZmjnkFCA0JkyJqZO6XH0tWTXyqBr3m
	PbjEDzTVDSxwiXhewFSOJdv0URfyO4KyDYec7yxlWNrPnC4GWTD2Gsz0sVvgZay6hFfUuvq
	Af4PbLVMdVs4siXsOkAjELLoH5dBRuz5iUDXmNYCUMgZYAPesDEDMj3qZYfySa+pAZA8Q+Q
	bunhfCwIWyznZKHLCq/BWMMd3Y7NQpsq9WmNrIH+BUnVQJb3n7dPjvRMN4EdK+milzLxx4k
	wtOGAdJTScomUpgDv32wVRtm7jGfWNqfPSmHWlHeFL3nTa/1iVfgFfnDlS1EaI+M3U6+m47
	/ZkQa667pkoQLhAekU96NOZKmL6ucBxGkKQCuFbyb/AJAhgGHuKJSqp3rEYIHcEJnNnMMFY
	gY3Q2G1zewPtU+k/vdZd21MaqLMOJ/b97Wd6ehSsXm1j2ojxWOxt+oK51MQMrKL52TPMx7l
	d2i+cheYwKQi7l/p2svHnU6wQzWawB6HgTx6iV4ftTq
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
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
 sound/soc/spacemit/k1_i2s.c                        | 444 +++++++++++++++++++++
 6 files changed, 554 insertions(+)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250813-k1-i2s-115bf65eaac8
prerequisite-change-id: 20250701-working_dma_0701_v2-7d2cf506aad7:v5
prerequisite-patch-id: 3fe97698036c32c20d03b1b835a5735e8ee8126c
prerequisite-patch-id: bf64cb2fbb9699d2ace64ae517532f13c6f8d277
prerequisite-patch-id: 49263c65c84a0b045f9b5ae6831dc011c4dea52f
prerequisite-patch-id: 2b43599bf7568e6432faa2f6aca5b2db792cd1c1
prerequisite-patch-id: 1b840918a99543f4497b6475ee52977bdb59f1c3
prerequisite-patch-id: 2f77be523fd5423bd011e3081a3635d130410096
prerequisite-patch-id: 78bcc660796fc4f73b884d17a1b63e62f99dfdd0
prerequisite-patch-id: 62d0b3678cf825bca51424ad85cf35ebdd6dc171
prerequisite-message-id: <20250911-k1-clk-i2s-generation-v4-0-cba204a50d48@linux.spacemit.com>
prerequisite-patch-id: b46d4007c5b20f11845db739fc78ffccc54f4dab
prerequisite-patch-id: 1e193c412de1206c024a674e2dd7da88092976b9
prerequisite-patch-id: af07a4bca4109b13a74c0b20a12f96af863090ef
prerequisite-message-id: <20250824-k1-clk-i2s-v5-0-217b6b7cea06@linux.spacemit.com>
prerequisite-patch-id: 6f2626811da4833395f52f712d9f2a5fb553cb48
prerequisite-patch-id: d2594982f7a8f39c2aa4f21490a19e93ab67254d

Best regards,
-- 
Troy Mitchell <troy.mitchell@linux.spacemit.com>


