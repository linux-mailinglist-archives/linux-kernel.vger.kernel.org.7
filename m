Return-Path: <linux-kernel+bounces-882328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 209E2C2A322
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 07:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53CA4188B3E1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 06:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198472980A8;
	Mon,  3 Nov 2025 06:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="lLTFZU36"
Received: from smtp.smtpout.orange.fr (smtp-21.smtpout.orange.fr [80.12.242.21])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C4E286D56;
	Mon,  3 Nov 2025 06:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762151603; cv=none; b=FW3sn+LUn0Hder9Xg6m4dYKXWiKKefnHeNXLTAYLHLJrq6MTGIiJNQnqDenQrNoc4lHIJz8P8zAcZl/zbB39XtWDnMA3H6ZQP/NqrlL5oS8uWxhaHv6Dgzbfv9BXQy3HesRsELZhWA0opwvXc8Hxv58kJFn+pVeF1MiaRlDS7+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762151603; c=relaxed/simple;
	bh=0Nbk7N6TuGG8DqeUUT+1/buN8Uf1W+rXtEdV71vyM0k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uWT6FXn9ezrtNW/YNFZeR1IQoLqHDrNQBQNls6rb62YuePpq+C46T4i7SsshEL41Io9KgpN5vJ+sU7bGTaU9/PUT9RUdNIM1LuVCCUX775HveIwCgVbwNkovXfAq6qGxPc0W7CAG0Obd4h4FxvfFEylJ/Lopz2tHMjE44NRl4PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=lLTFZU36; arc=none smtp.client-ip=80.12.242.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id Fo6ovtBvMsL0VFo6pvhfqx; Mon, 03 Nov 2025 07:32:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1762151528;
	bh=AXuQEY3AagyS51O+lVG4zaIuniqmVZG13dgoQRqEHxA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=lLTFZU36FYB0sKQyFImDYg0x8kfglP8EUdMvpX22mTojxO3tFK3caMU/oiUty2jgO
	 kIU+K9GQdAjC1Y42Lreqn7cTd3hDfmtZR8lvFMGrrfFtorC6cyjZwUbEswloGoinjf
	 gOtnnQQkH8KXBiPlrQAvLPybrYotWwgRVBSP3vNvDGnoBO4/em1NEwvEqk0jx7KJ1G
	 EPugLS+Qlley1Ylz/XLOnCCAnl+VpBo1ho38+kLM9R2hRX9xxd0135mYwqbJIk2TU9
	 cex59Yo2hDoQw+2TvTzDrqCfYHHaqIotJ/7PcqX7umepfUHMFyznUupg9QpcbTHNON
	 fsnF4qh0nMHyQ==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 03 Nov 2025 07:32:08 +0100
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] ASoC: fsl_spdif: Constify some structures
Date: Mon,  3 Nov 2025 07:32:03 +0100
Message-ID: <5fe08f028395a6c6f50d11eee8fdb4a90b1f68ab.1762151503.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct fsl_spdif_soc_data' and 'struct snd_kcontrol_new' are not modified
in this driver.

Constifying these structures moves some data to a read-only section, so
increases overall security, especially when the structure holds some
function pointers.

On a x86_64, with allmodconfig:
Before:
======
   text	   data	    bss	    dec	    hex	filename
  53548	  25576	    128	  79252	  13594	sound/soc/fsl/fsl_spdif.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
  54828	  24296	    128	  79252	  13594	sound/soc/fsl/fsl_spdif.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 sound/soc/fsl/fsl_spdif.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index ee946e0d3f49..1b9be85b34c2 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -148,7 +148,7 @@ struct fsl_spdif_priv {
 	struct clk *pll11k_clk;
 };
 
-static struct fsl_spdif_soc_data fsl_spdif_vf610 = {
+static const struct fsl_spdif_soc_data fsl_spdif_vf610 = {
 	.imx = false,
 	.shared_root_clock = false,
 	.raw_capture_mode = false,
@@ -158,7 +158,7 @@ static struct fsl_spdif_soc_data fsl_spdif_vf610 = {
 	.tx_formats = FSL_SPDIF_FORMATS_PLAYBACK,
 };
 
-static struct fsl_spdif_soc_data fsl_spdif_imx35 = {
+static const struct fsl_spdif_soc_data fsl_spdif_imx35 = {
 	.imx = true,
 	.shared_root_clock = false,
 	.raw_capture_mode = false,
@@ -168,7 +168,7 @@ static struct fsl_spdif_soc_data fsl_spdif_imx35 = {
 	.tx_formats = FSL_SPDIF_FORMATS_PLAYBACK,
 };
 
-static struct fsl_spdif_soc_data fsl_spdif_imx6sx = {
+static const struct fsl_spdif_soc_data fsl_spdif_imx6sx = {
 	.imx = true,
 	.shared_root_clock = true,
 	.raw_capture_mode = false,
@@ -179,7 +179,7 @@ static struct fsl_spdif_soc_data fsl_spdif_imx6sx = {
 
 };
 
-static struct fsl_spdif_soc_data fsl_spdif_imx8qm = {
+static const struct fsl_spdif_soc_data fsl_spdif_imx8qm = {
 	.imx = true,
 	.shared_root_clock = true,
 	.raw_capture_mode = false,
@@ -189,7 +189,7 @@ static struct fsl_spdif_soc_data fsl_spdif_imx8qm = {
 	.tx_formats = SNDRV_PCM_FMTBIT_S24_LE,  /* Applied for EDMA */
 };
 
-static struct fsl_spdif_soc_data fsl_spdif_imx8mm = {
+static const struct fsl_spdif_soc_data fsl_spdif_imx8mm = {
 	.imx = true,
 	.shared_root_clock = false,
 	.raw_capture_mode = true,
@@ -199,7 +199,7 @@ static struct fsl_spdif_soc_data fsl_spdif_imx8mm = {
 	.tx_formats = FSL_SPDIF_FORMATS_PLAYBACK,
 };
 
-static struct fsl_spdif_soc_data fsl_spdif_imx8ulp = {
+static const struct fsl_spdif_soc_data fsl_spdif_imx8ulp = {
 	.imx = true,
 	.shared_root_clock = true,
 	.raw_capture_mode = false,
@@ -1146,7 +1146,7 @@ static int fsl_spdif_usync_put(struct snd_kcontrol *kcontrol,
 }
 
 /* FSL SPDIF IEC958 controller defines */
-static struct snd_kcontrol_new fsl_spdif_ctrls[] = {
+static const struct snd_kcontrol_new fsl_spdif_ctrls[] = {
 	/* Status cchanel controller */
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
@@ -1233,7 +1233,7 @@ static struct snd_kcontrol_new fsl_spdif_ctrls[] = {
 	},
 };
 
-static struct snd_kcontrol_new fsl_spdif_ctrls_rcm[] = {
+static const struct snd_kcontrol_new fsl_spdif_ctrls_rcm[] = {
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_PCM,
 		.name = "IEC958 Raw Capture Mode",
-- 
2.51.1


