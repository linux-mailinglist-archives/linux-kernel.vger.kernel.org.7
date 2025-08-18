Return-Path: <linux-kernel+bounces-773214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9D8B29CBD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 10:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4A4A7A864B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 08:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC46308F11;
	Mon, 18 Aug 2025 08:51:00 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6DF23009E1;
	Mon, 18 Aug 2025 08:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755507060; cv=none; b=PA0KGECTNLJVwGUlNl/MVxkEGznwZ/BJ1TVEupBI7GpjnkWos3mebMIH+wq0Ll8qiULd627V3I4EbIXXAwbYgNP8bkWTCq8PzBOPkgASCj1ZwIJQSqe0ehSn/LtDvWy4iJ6KoLI+v4gG6oo80GgKbAE0xmfgbYDYo4A3GElMbtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755507060; c=relaxed/simple;
	bh=pbAuN88+fAvtq6e9c1Cuomlr5CexTJYFwYsjbKKxSv0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u9vnUlC1ZFHK8kJUmeAcT/ceV0W3DP7zwETRNWxVu3vBSccWiaQF3J0ZgLKqi6msvSZcVCw1kFL0AQdney5ehuqHEMcJWcIWf04Nl2lFs1pVbhcbULZFSwhABuryo299v5hof4MlvEu86ELsQrPifV6A/8a7nrfQzJ8fvbrMpsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4c55HS397Bz9sW6;
	Mon, 18 Aug 2025 10:20:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FMMyCDZPktia; Mon, 18 Aug 2025 10:20:04 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4c55HS1ztdz9sW4;
	Mon, 18 Aug 2025 10:20:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 2F1EB8B765;
	Mon, 18 Aug 2025 10:20:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id ymC4Y2tOtNpK; Mon, 18 Aug 2025 10:20:04 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [10.25.207.160])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id F2BA48B763;
	Mon, 18 Aug 2025 10:20:03 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Herve Codina <herve.codina@bootlin.com>,
	Qiang Zhao <qiang.zhao@nxp.com>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org
Subject: [PATCH v3 0/4] ASoC: fsl: fsl_qmc_audio: Reduce amount of interrupts
Date: Mon, 18 Aug 2025 10:19:59 +0200
Message-ID: <cover.1755504428.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755505199; l=2329; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=pbAuN88+fAvtq6e9c1Cuomlr5CexTJYFwYsjbKKxSv0=; b=kYoKb+1G4M+oBNjPSIblYLyr02FxdpGXktGAtambWltq8gWdILmpYrw9TuWcteLPOJ82HWcGW zHtiikDuJHPBlwm+8sNkaJ/GwOEiXWLXie2LYf+BV8zuMn5tZMMOKBw
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

This series reduces significantly the amount of interrupts on
fsl_qmc_audio device.

Patches 1 and 2 are preparatory patches.
Patch 3 is the main change
Patch 4 is a cleanup which is enabled by previous patch

Changes in v3:
- Properly check the buffer descriptor is unused (Patch 1, comment from Herve Codina)
- Fixed copy/paste error (patch 2, comment from Herve Codina)
- Fixed build failure (patch 2, comment from Herve Codina and Test robot)

Changes in v2:
- Don't remove UB bit (Patch 1, comment from Herve Codina)
- Make sure audio channels are ordered on TDM bus (Patch 2, new patch, comment from Herve Codina)
- Drop struct qmc_dai_chan  (patch 4, new patch)

Backgroup (copied from patch 3):

In non-interleaved mode, several QMC channels are used in sync.
More details can be found in commit 188d9cae5438 ("ASoC: fsl:
fsl_qmc_audio: Add support for non-interleaved mode.")
At the time being, an interrupt is requested on each channel to
perform capture/playback completion, allthough the completion is
really performed only once all channels have completed their work.

This leads to a lot more interrupts than really needed. Looking at
/proc/interrupts shows ~3800 interrupts per second when using
4 capture and 4 playback devices with 5ms periods while
only 1600 (200 x 4 + 200 x 4) periods are processed during one second.

The QMC channels work in sync, the one started first is the one
finishing first and the one started last is the one finishing last,
so when the last one finishes it is guaranteed that the other ones are
finished as well. Therefore only request completion processing on the
last QMC channel.

On my board with the above exemple, on a kernel started with
'threadirqs' option, the QMC irq thread uses 16% CPU time with this
patch while it uses 26% CPU time without this patch.

Christophe Leroy (4):
  soc: fsl: qmc: Only set completion interrupt when needed
  ASoc: fsl: fsl_qmc_audio: Ensure audio channels are ordered in TDM bus
  ASoC: fsl: fsl_qmc_audio: Only request completion on last channel
  ASoc: fsl: fsl_qmc_audio: Drop struct qmc_dai_chan

 drivers/soc/fsl/qe/qmc.c      |  44 +++++++++---
 sound/soc/fsl/fsl_qmc_audio.c | 125 +++++++++++++++-------------------
 2 files changed, 87 insertions(+), 82 deletions(-)

-- 
2.49.0


