Return-Path: <linux-kernel+bounces-777979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27389B2E007
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52E6B7B36B9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 14:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782F3321425;
	Wed, 20 Aug 2025 14:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="1TfWFFw2"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6AD31E116
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 14:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755701751; cv=none; b=OcrUddtPxgdc74+tSLpht8CCNDGKKfbXimgJ3pDowsD619Oo8ZEBTEPR67FDMG1R6b2JCBwkieR1xdbe/BFOkEVEFp6bZKf3uBZU4UkgC6XTvb0oGXqgst+mLtgTCx+XPqyU+DKTyHaY6w6zT6mC8wPSN4GX2gVCAU59kwK9Ez8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755701751; c=relaxed/simple;
	bh=7+oHWTACPFSALznoe36mPSP2bCu7kRLIqa4uxK/H3IQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fN7aKZYoNhlvnhLxX7RgsINzh1hI8n/pWqa7DVUVdm+BMeWCQ5azaxDdXHNDdXGEqCct741MrPcS9fWvHUhDbSD0UxuOqbda4CGJmrL9S21RHc4DV2U/QI8bhwJNS+SePozjKPznxOk5iL1F/42hlXSjeEZlxK8xAXFlkW1gtLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=1TfWFFw2; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id EFB371A09AA;
	Wed, 20 Aug 2025 14:55:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BA55E606A0;
	Wed, 20 Aug 2025 14:55:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C61211C2286DB;
	Wed, 20 Aug 2025 16:55:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1755701744; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=ih+mPY47VbrJ66aP5mMPRcqsVibkL6Zr8hZhh9qWJQ0=;
	b=1TfWFFw2fnGqLe7NkoH1peKdi3+CPCeu3cbZhajrEfJ0pjJZJNbGb+/ICi9HUxkaL9nZT3
	TVZuoxjWSx7cp7rRbvfMlotehEtTAy4hk0w8ql6CzX7i5zXeshVg+xJQuv2baU7t5hQd5f
	b1wIi/emNh1J6YXcGOTFokFXEBbp1Q2cpzLwFiNLkz9Yc32sHBshwF/Y/vht6ivoe/piU6
	WNOWVrZloO+Lwgl3u60E43KpASbpmM44bNTdMIXsCqf+cnqWAhu5SElhy2UjwPlWAzcXf7
	ZDjfd5QUIJyR4EUBcCK5bwogWHyawMobIN87D5RO5tfNm73a5EjGrOad/oeJyA==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: [PATCH net v4 0/5] net: macb: various fixes
Date: Wed, 20 Aug 2025 16:55:04 +0200
Message-Id: <20250820-macb-fixes-v4-0-23c399429164@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAMnhpWgC/22NSw7CIBCGr9LMWgzQkqIr72G6KDjYSSwYIETTc
 HcJa5ff/zwgYSRMcB0OiFgoUfANptMAdlv9Exk9GoPkUnHNNdtXa5ijDyaG0qmZoxByEtAK74j
 daPk7eMywNHGjlEP89oMyduvfVhkZZ1w74axRYr64mwkhv8ifbdhhqbX+AH2hAw6rAAAA
X-Change-ID: 20250808-macb-fixes-e2f570e11241
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 Harini Katakam <harini.katakam@xilinx.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Sean Anderson <sean.anderson@linux.dev>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

Fix a few disparate topics in MACB:

[PATCH net v4 1/5] dt-bindings: net: cdns,macb: allow tsu_clk without tx_clk
[PATCH net v4 2/5] net: macb: remove illusion about TBQPH/RBQPH being per-queue
[PATCH net v4 3/5] net: macb: move ring size computation to functions
[PATCH net v4 4/5] net: macb: single dma_alloc_coherent() for DMA descriptors
[PATCH net v4 5/5] net: macb: avoid double endianness swap in macb_set_hwaddr()

Patch 3/5 is a rework that simplifies patch 4/5.

What will follow is (1) many cleanup patches and (2) patches for EyeQ5
support. Those will be sent targeting net-next/main once this series
lands there, aiming to minimise merge conflicts. Old version of those
patches are visible in the V2 revision.

Thanks,
Have a nice day,
Théo

[0]: https://lore.kernel.org/lkml/20250627-macb-v2-0-ff8207d0bb77@bootlin.com/

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
Changes in v4:
- Drop 11 patches that are only cleanups. That includes the
  RBOF/skb_reserve() patch that, after discussion with Sean [1], has
  had its Fixes trailer dropped. "move ring size computation to
  functions" is the only non-fix patch that is kept, as it is depended
  upon by further patches. Dropped patches:
    dt-bindings: net: cdns,macb: sort compatibles
    net: macb: match skb_reserve(skb, NET_IP_ALIGN) with HW alignment
    net: macb: use BIT() macro for capability definitions
    net: macb: remove gap in MACB_CAPS_* flags
    net: macb: Remove local variables clk_init and init in macb_probe()
    net: macb: drop macb_config NULL checking
    net: macb: simplify macb_dma_desc_get_size()
    net: macb: simplify macb_adj_dma_desc_idx()
    net: macb: move bp->hw_dma_cap flags to bp->caps
    net: macb: introduce DMA descriptor helpers (is 64bit? is PTP?)
    net: macb: sort #includes
  [1]: https://lore.kernel.org/lkml/d4bead1c-697a-46d8-ba9c-64292fccb19f@linux.dev/
- Link to v3: https://lore.kernel.org/r/20250808-macb-fixes-v3-0-08f1fcb5179f@bootlin.com

Changes in v3:
- Cover letter: drop addresses that reject emails:
  cyrille.pitchen@atmel.com
  hskinnemoen@atmel.com
  jeff@garzik.org
  rafalo@cadence.com
- dt-bindings: Take 2x Reviewed-by Krzysztof.
- dt-bindings: add Fixes trailer to "allow tsu_clk without tx_clk"
  patch, to highlight we are not introducing new behavior.
- Reorder commits; move fixes first followed by cleanup patches.
- Drop all EyeQ5 related commits.
- New commit: "remove gap in MACB_CAPS_* flags".
- New commit: "move ring size computation to functions".
- New commit: "move bp->hw_dma_cap flags to bp->caps".
- Rename introduced helpers macb_dma_is_64b() to macb_dma64() and,
  macb_dma_is_ptp() to macb_dma_ptp().
- Rename MACB_CAPS_RSC_CAPABLE -> MACB_CAPS_RSC.
- Fix commit message typos: "maxime" -> "maximise", etc.
- Take 7x Reviewed-by: Sean Anderson.
- Add details to some commit messages.
- Link to v2: https://lore.kernel.org/r/20250627-macb-v2-0-ff8207d0bb77@bootlin.com

---
Théo Lebrun (5):
      dt-bindings: net: cdns,macb: allow tsu_clk without tx_clk
      net: macb: remove illusion about TBQPH/RBQPH being per-queue
      net: macb: move ring size computation to functions
      net: macb: single dma_alloc_coherent() for DMA descriptors
      net: macb: avoid double endianness swap in macb_set_hwaddr()

 .../devicetree/bindings/net/cdns,macb.yaml         |   2 +-
 drivers/net/ethernet/cadence/macb.h                |   4 -
 drivers/net/ethernet/cadence/macb_main.c           | 138 ++++++++++-----------
 3 files changed, 69 insertions(+), 75 deletions(-)
---
base-commit: 715c7a36d59f54162a26fac1d1ed8dc087a24cf1
change-id: 20250808-macb-fixes-e2f570e11241

Best regards,
-- 
Théo Lebrun <theo.lebrun@bootlin.com>


