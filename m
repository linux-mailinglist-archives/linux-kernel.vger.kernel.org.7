Return-Path: <linux-kernel+bounces-702540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16571AE83A7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 15:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25E061BC50EE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 13:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A93325D53E;
	Wed, 25 Jun 2025 13:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arunraghavan.net header.i=@arunraghavan.net header.b="NiRCZPsb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Uz297v19"
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584BA8633A;
	Wed, 25 Jun 2025 13:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750856832; cv=none; b=E2OnY94fDgKCbfT/GIvPTf3BFQ/JeZzH6r7CaBOnvDW06f2PQBD7ktolAY4XuLwViY0Tlh7nTi3DEH+FOuVSQA/tl9WnPxlO2JIb0xrVBHh97Nat0gESRb6nMM1QEk/zu41vdDfZQZx6JLa3XI5knOjy2TwSGNNYYclQh5mi1cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750856832; c=relaxed/simple;
	bh=ulJl+2beCO/apcRm6imFORMz5zwwAo4RQlOmKeJG5ro=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ssg8dm3s8tV8vA2fk3OHlvKtOjiNgSmZfkL5g7vsbfIzI7yFUycrXtH1lkGneXMum6XiifG5retfG1o+N8PYWrD8cZnxjAwGEYh5jlqgwgUfpwVKjsFSuiCArdn/g2u90hLwp7E2SLXDdeHW+PPM1Yf9yekOPxDsGOHWH6E1L+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=arunraghavan.net; spf=pass smtp.mailfrom=arunraghavan.net; dkim=pass (2048-bit key) header.d=arunraghavan.net header.i=@arunraghavan.net header.b=NiRCZPsb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Uz297v19; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=arunraghavan.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arunraghavan.net
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 0327E1D00217;
	Wed, 25 Jun 2025 09:07:08 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 25 Jun 2025 09:07:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	arunraghavan.net; h=cc:cc:content-transfer-encoding:content-type
	:date:date:from:from:in-reply-to:message-id:mime-version
	:reply-to:subject:subject:to:to; s=fm1; t=1750856828; x=
	1750943228; bh=mYAc1EALspLuVXr2tNLHf33N87U9klyBRW2qKuitYhc=; b=N
	iRCZPsbnH0kf8n0T3tzCALGVTdE+PGEtgVpNv/12qeHdRRgqV+f5VUV2IDGJbW75
	DwT0YMujfHs4HHLSQpxvqcckpZz5zDcWoSYssh3eYpdCYKhhzjwcwfQOPKQ0HoM9
	SexImBEwq0A/1ser+E7rIxm9EyMarN7ecbH0a348B76DhD4JtpOuMf4KK9MikN0N
	f6NkgLVPjpQ+1UFeYpk5OZZ1qnC7qRTzaRSayZa96nfbglvFNNYyNjNoLl/p3YJ6
	Ve0P6HIKuH+erc970GAGHnahzbsdlQN3bTzm8RFnjK2ggVVD1ABdAUcTOLO4/g5B
	ACn40mBQtAj6ddaQG4VNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1750856828; x=1750943228; bh=mYAc1EALspLuVXr2tNLHf33N87U9klyBRW2
	qKuitYhc=; b=Uz297v19dxDBmaCgXDfknpPIZW+pHMmgOjDcFyB54SxvpZl6Vja
	b7s0N7hUfSC4qs0ayFcAwqePPMSwvdjHYj2WppEEVeBlaZq1yHBSzmclPDs0+gE5
	mzIMQZdZMsxLMo01OTltX1UsD9J7vab4fn9ZYaECZJV7Inb+1JRa8Y5cCVNaI3LB
	ZC6Bk+MTBzMU+q4Cv8Y/m6x1MEv2pUAIJZqPM2DZhEVGLAhSkSAJnM3cdkexXENe
	swLfgj0H55ja98Y8RoUJe8N9KEiiQlrNYrSdXUV9XEkx+240zalkmEIVyp8hyyRO
	rZDusFTAenq5GWYGS2FelndeOxVhl0s+UDg==
X-ME-Sender: <xms:e_RbaBJkMxaGd8E8pikNRd405FY43X_jhr45TSBzWwShZjklcnxSew>
    <xme:e_RbaNLjV8QP-AqS623yT--JoEalmfCMsmoh4qqebQAPHuGeTPLV7a-SJNZexSR06
    nY9p_JAld-vdOzeOg>
X-ME-Received: <xmr:e_RbaJsEE6l4tAifTSWhNnVwCyl-WQJr1JP4GJddF-5H5b89QiXmekKpDStq1Trz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvvdekhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeetrhhunhcutfgrghhh
    rghvrghnuceorghruhhnsegrrhhunhhrrghghhgrvhgrnhdrnhgvtheqnecuggftrfgrth
    htvghrnhepteduheelvedvledvudfhudevkefhhfeifefggeevkedvudfgueelvdehtdet
    vdefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hruhhnsegrrhhunhhrrghghhgrvhgrnhdrnhgvthdpnhgspghrtghpthhtohepudefpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehshhgvnhhgjhhiuhdrfigrnhhgsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepgihiuhgsohdrlhgvvgesghhmrghilhdrtghomhdp
    rhgtphhtthhopehfvghsthgvvhgrmhesghhmrghilhdrtghomhdprhgtphhtthhopehnih
    gtohhlvghothhsuhhkrgesghhmrghilhdrtghomhdprhgtphhtthhopehlghhirhgufiho
    ohgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepsghrohhonhhivgeskhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepphgvrhgvgiesphgvrhgvgidrtgiipdhrtghpthhtohepthhi
    figrihesshhushgvrdgtohhmpdhrtghpthhtohepphdrtggrmhgvrhhlhihntghksehtvg
    hlvghvihgtrdgtohhm
X-ME-Proxy: <xmx:e_RbaCakAwEoJ-N3AuLc6sRbLQSp7FC_TzfgO_6jk7UkOpVN27ZgXA>
    <xmx:e_RbaIbMUjfp5FiWTkCiO7V5ntXLGeuabYiGZUgSKLGs3ciGqwo2Iw>
    <xmx:e_RbaGAVcDLFmlIN9eDjCOyUqdkCvA4KUQICVaKnCrF4L8n6mi42_g>
    <xmx:e_RbaGbrCpRevF54zYbUdCgNvs3GHf8RhmhjIGf3hjsx9E4hbJSF7A>
    <xmx:fPRbaCIbg9Vu5L40sdvsI0bLIuxbK8TFcuRsoolv83b_LMG0z0WTLYzy>
Feedback-ID: i42c0435e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Jun 2025 09:07:06 -0400 (EDT)
From: Arun Raghavan <arun@arunraghavan.net>
To: Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Pieterjan Camerlynck <p.camerlynck@televic.com>,
	linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Arun Raghavan <arun@asymptotic.io>
Subject: [PATCH] ASoC: fsl_sai: Force a software reset when starting in consumer mode
Date: Wed, 25 Jun 2025 09:06:48 -0400
Message-ID: <20250625130648.201331-1-arun@arunraghavan.net>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arun Raghavan <arun@asymptotic.io>

In a setup with an external clock provider, when running the receiver
(arecord) and triggering an xrun with xrun_injection, we see a channel
swap/offset. This happens sometimes when running only the receiver, but
occurs reliably if a transmitter (aplay) is also concurrently running.

The theory is that SAI seems to lose track of frame sync during the
trigger stop -> trigger start cycle that occurs during an xrun. Doing
just a FIFO reset in this case does not suffice, and only a software
reset seems to get it back on track.

Signed-off-by: Arun Raghavan <arun@asymptotic.io>
Reported-by: Pieterjan Camerlynck <p.camerlynck@televic.com>
---
 sound/soc/fsl/fsl_sai.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index af1a168d35e3..3a5ebf32903f 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -841,6 +841,18 @@ static int fsl_sai_trigger(struct snd_pcm_substream *substream, int cmd,
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		/*
+		 * Force a software reset if we are not the clock provider, as we
+		 * might have lost frame sync during xrun recovery.
+		 */
+		if (sai->is_consumer_mode) {
+			regmap_update_bits(sai->regmap,
+					FSL_SAI_xCSR(tx, ofs), FSL_SAI_CSR_SR,
+					FSL_SAI_CSR_SR);
+			regmap_update_bits(sai->regmap,
+					FSL_SAI_xCSR(tx, ofs), FSL_SAI_CSR_SR,
+					0);
+		}
 		regmap_update_bits(sai->regmap, FSL_SAI_xCSR(tx, ofs),
 				   FSL_SAI_CSR_FRDE, FSL_SAI_CSR_FRDE);
 
-- 
2.49.0


