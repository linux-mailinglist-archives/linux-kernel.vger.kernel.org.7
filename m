Return-Path: <linux-kernel+bounces-588696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6596FA7BC7F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Apr 2025 14:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5A1B7A784D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Apr 2025 12:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2726C1EA7D3;
	Fri,  4 Apr 2025 12:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d4yOYpua"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809EF1E8351;
	Fri,  4 Apr 2025 12:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743769186; cv=none; b=D1MMRLXyMFtmELRff5EmFTlqekUniyxXudn6VMZEH2febsD7forQV3xvhAx9Ey6abODBzGg3NuS/vHfPC3EviKUz+xIGWxh0X2J29hesYA87BZoJcYawzORyWBVECrFet3e/GtUtowBc1icBcS9jsrtimhmzinCBqqk2/heyssg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743769186; c=relaxed/simple;
	bh=A3xq0rUAdIUU549lnKoePK2QZqGdBsCq6aI5d3tcGBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MEViPzampN+CURDqE+J9bRd+yrUmA/H2hh9G9BAQE10hbJahJJojy5hTEPOdRQIJBSxbdZIASCHlMC7x7Oh2PLs3gxfa+lQhZ6bz9iVX18ucm6eIL3FajYFZ/fKMn92u9FVqr/H1O3STCdzFaLHzzy00gUlRMX+ryHTy4J5DTdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d4yOYpua; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74B47C4CEDD;
	Fri,  4 Apr 2025 12:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743769186;
	bh=A3xq0rUAdIUU549lnKoePK2QZqGdBsCq6aI5d3tcGBg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d4yOYpuaDHzeRLOfczZuQ23hmsy0R+6J6/zGgUr4QQWb34f3xBLwHuCN+s79XDmd2
	 GI1Rhr9O6OQBPPFNJeVa6nmq+S50+zmkVtDZ41ZdxyxSdanEoaUwKJa41Ng2mrvSwJ
	 vEe7DBFl50KgvXlm3Fn1+ibve5xzkh/l5sVZDueEtM0PePXX2GsqeZdbqHpEeSEb1c
	 CKixwd479MZLo3pemPMdhLlYtwzQB7GVH5q15WBD/5jRKg//LnkBWIc3ZbPvUmcoWh
	 RQzH0Vdzizk1OTAlSO7XO9E5By30vYR0HmHSpkRSU/hwXTyXUY70oxNeXQ5irikQLc
	 HatWhyeX7gV5g==
From: Philipp Stanner <phasta@kernel.org>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Clemens Ladisch <clemens@ladisch.de>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Philipp Stanner <phasta@kernel.org>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Maxim Mikityanskiy <maxtram95@gmail.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	He Lugang <helugang@uniontech.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Tang Bin <tangbin@cmss.chinamobile.com>
Cc: linux-parisc@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 02/11] ALSA: atiixp: Replace deprecated PCI functions
Date: Fri,  4 Apr 2025 14:19:03 +0200
Message-ID: <20250404121911.85277-4-phasta@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250404121911.85277-2-phasta@kernel.org>
References: <20250404121911.85277-2-phasta@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pcim_iomap_table() and pcim_iomap_regions() have been deprecated.
Replace them with pcim_iomap_region().

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 sound/pci/atiixp.c       | 7 +++----
 sound/pci/atiixp_modem.c | 7 +++----
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/sound/pci/atiixp.c b/sound/pci/atiixp.c
index df2fef726d60..427006be240b 100644
--- a/sound/pci/atiixp.c
+++ b/sound/pci/atiixp.c
@@ -1544,11 +1544,10 @@ static int snd_atiixp_init(struct snd_card *card, struct pci_dev *pci)
 	chip->card = card;
 	chip->pci = pci;
 	chip->irq = -1;
-	err = pcim_iomap_regions(pci, 1 << 0, "ATI IXP AC97");
-	if (err < 0)
-		return err;
+	chip->remap_addr = pcim_iomap_region(pci, 0, "ATI IXP AC97");
+	if (IS_ERR(chip->remap_addr))
+		return PTR_ERR(chip->remap_addr);
 	chip->addr = pci_resource_start(pci, 0);
-	chip->remap_addr = pcim_iomap_table(pci)[0];
 
 	if (devm_request_irq(&pci->dev, pci->irq, snd_atiixp_interrupt,
 			     IRQF_SHARED, KBUILD_MODNAME, chip)) {
diff --git a/sound/pci/atiixp_modem.c b/sound/pci/atiixp_modem.c
index eb569539f322..8d3083b9b024 100644
--- a/sound/pci/atiixp_modem.c
+++ b/sound/pci/atiixp_modem.c
@@ -1174,11 +1174,10 @@ static int snd_atiixp_init(struct snd_card *card, struct pci_dev *pci)
 	chip->card = card;
 	chip->pci = pci;
 	chip->irq = -1;
-	err = pcim_iomap_regions(pci, 1 << 0, "ATI IXP MC97");
-	if (err < 0)
-		return err;
+	chip->remap_addr = pcim_iomap_region(pci, 0, "ATI IXP MC97");
+	if (IS_ERR(chip->remap_addr))
+		return PTR_ERR(chip->remap_addr);
 	chip->addr = pci_resource_start(pci, 0);
-	chip->remap_addr = pcim_iomap_table(pci)[0];
 
 	if (devm_request_irq(&pci->dev, pci->irq, snd_atiixp_interrupt,
 			     IRQF_SHARED, KBUILD_MODNAME, chip)) {
-- 
2.48.1


