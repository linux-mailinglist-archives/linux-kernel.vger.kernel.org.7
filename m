Return-Path: <linux-kernel+bounces-868965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 213A1C0698B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 15:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 443323AD5EA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 13:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DAFA322755;
	Fri, 24 Oct 2025 13:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zanders.be header.i=@zanders.be header.b="KjvhtKgE"
Received: from smtp28.bhosted.nl (smtp28.bhosted.nl [94.124.121.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D454B3203A7
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 13:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.124.121.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761314297; cv=none; b=HWJMEVt7Q4EkIf/Qs27jSv2Gin0em8I0vFHlruttDJ5SnI6MGwxA4wX+u/AuqWzUebOwOvFg/KYAjTYk0+SOhrXwT1/6XzEOE/K7ha3PvoJFqYYyM+snF1+ZUKMSq1H0vVUHRuQ/j9SAErCCH4ONhGwP6/uArm0jowU5I7iDkcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761314297; c=relaxed/simple;
	bh=DStSGKatGmrev5tmHwVq9RguAZktbzzq7CaSyteKbOg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fZbjcEheWnrJ4HX83hz2Lpa6HrCh75rBZR2jemrgLYEjC7/lIf7/h7rJHKzeTPv6FTqQmzBC8lWk9Bfv3mhuSPReStUhFi8346WQ8gXRjEeDXwcT32kRvUj3FCHbqpRh2h2leB836kgoUZqlP5i+7cRUfgSYV30t/lkLSTcpRYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zanders.be; spf=pass smtp.mailfrom=zanders.be; dkim=pass (2048-bit key) header.d=zanders.be header.i=@zanders.be header.b=KjvhtKgE; arc=none smtp.client-ip=94.124.121.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zanders.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zanders.be
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=zanders.be; s=202002;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
	 from;
	bh=C48gu7NXP8y9dk94tbYBWS5GwTbZ0M7NmzNqhOYrSd4=;
	b=KjvhtKgExdpcHYFilqCL/n3gSrBhfxpmDPuL5KhQYQniH2SckHkfQfl0G0TdKrdljobuZ0t4/oKn3
	 zlxgX3bOVmPGQt//fSkWkHAfUQ3CHEitL+D63lQY6oor3b8A0uUbOEo2bItFey7M++/SyRGJeDCriF
	 WoeVMY0l1T8+ZEqU7WgjI3f9ptb1/n3ZLyl7oVueLdzpSod1HXJBeN7Stro84l3y89obs40vbrhXkn
	 7iWeq/JoBPjAy0lMTSvIR7DrCKEVpAPzr+LBThbF2im/t2isyYzwG1mna5IBN1oDKuNdx/B5FAsNio
	 MIbhsdVGxyjODj/30hd2vQouQIs58/w==
X-MSG-ID: 75dfb013-b0e1-11f0-bf45-0050568164d1
From: Maarten Zanders <maarten@zanders.be>
To: Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Zidan Wang <zidan.wang@freescale.com>
Cc: Maarten Zanders <maarten@zanders.be>,
	linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: fsl_sai: Fix sync error in consumer mode
Date: Fri, 24 Oct 2025 15:57:15 +0200
Message-ID: <20251024135716.584265-1-maarten@zanders.be>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When configured for default synchronisation (Rx syncs to Tx) and the
SAI operates in consumer mode (clocks provided externally to Tx), a
synchronisation error occurs on Tx on the first attempt after device
initialisation when the playback stream is started while a capture
stream is already active. This results in channel shift/swap on the
playback stream.
Subsequent streams (ie after that first failing one) always work
correctly, no matter the order, with or without the other stream active.

This issue was observed (and fix tested) on an i.MX6UL board connected
to an ADAU1761 codec, where the codec provides both frame and bit clock
(connected to TX pins).

To fix this, always initialize the 'other' xCR4 and xCR5 registers when
we're starting a stream which is synced to the opposite one, irregardless
of the producer/consumer status.

Fixes: 51659ca069ce ("ASoC: fsl-sai: set xCR4/xCR5/xMR for SAI master mode")

Signed-off-by: Maarten Zanders <maarten@zanders.be>
---
 sound/soc/fsl/fsl_sai.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 757e7868e322..178a6e8fbe2c 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -653,12 +653,12 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
 		val_cr4 |= FSL_SAI_CR4_CHMOD;
 
 	/*
-	 * For SAI provider mode, when Tx(Rx) sync with Rx(Tx) clock, Rx(Tx) will
-	 * generate bclk and frame clock for Tx(Rx), we should set RCR4(TCR4),
-	 * RCR5(TCR5) for playback(capture), or there will be sync error.
+	 * When Tx(Rx) sync with Rx(Tx) clock, Rx(Tx) will provide bclk and
+	 * frame clock for Tx(Rx). We should set RCR4(TCR4), RCR5(TCR5)
+	 * for playback(capture), or there will be sync error.
 	 */
 
-	if (!sai->is_consumer_mode[tx] && fsl_sai_dir_is_synced(sai, adir)) {
+	if (fsl_sai_dir_is_synced(sai, adir)) {
 		regmap_update_bits(sai->regmap, FSL_SAI_xCR4(!tx, ofs),
 				   FSL_SAI_CR4_SYWD_MASK | FSL_SAI_CR4_FRSZ_MASK |
 				   FSL_SAI_CR4_CHMOD_MASK,
-- 
2.51.0


