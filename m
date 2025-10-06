Return-Path: <linux-kernel+bounces-843522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6928BBFA4C
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 00:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CE0F189D966
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 22:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574CF1F09A8;
	Mon,  6 Oct 2025 22:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y990LoQP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BC411713;
	Mon,  6 Oct 2025 22:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759788763; cv=none; b=YwupQvMs6cjdw78rAz5wOJOHljQNR1/8h10cgktQyMLkFINXV7A3cD94dzNBIQSdAadfF7zyTAxRh68uJ1szn8ft8OWi67kA9sTSk03gCwpzi2RnBZl9khy8plaYQi7HWRVN5lcxbU2R4QaBIZ57F7CUD0ijmwKGnsjUWnQe9pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759788763; c=relaxed/simple;
	bh=frN59PtaP2NnDY37GTjkkk5HaJHZi6o8TAEh204hsUw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=o7Xrkh5uWMtO5CYSgI/w4S2r7MzEeNjm4aKXKG7n9Q3irszXAtnyaxX9Pc160qJ1z5ATDierzNTEyQAa4Okt2bRJg+4h/KEuGhKgX7TvY+hPUWcH2qbAfN/HB1ROsrgXJ7x/nSqD+0V/00iHtkiBskvZAS5pfxJeLQ6dXfTZAU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y990LoQP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3B4E5C4CEF5;
	Mon,  6 Oct 2025 22:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759788763;
	bh=frN59PtaP2NnDY37GTjkkk5HaJHZi6o8TAEh204hsUw=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=Y990LoQPFXJep5tZcVNY1X9Hd8cChZMnMlx5TuuDQTTiBWY0EN2fa43UR8eP9lBFQ
	 tFi8EFE9pkzG55PxKvDK4znwjfZIgkOv4tYx7cpCjp9M7eXIxD03OBKV145pu6jYiP
	 RU37evp4JBS2qJ/t9HZXLfvlCX302REhA1DTENeJDAIEfm733lEyUDSAnDZ5IfMHIs
	 vDeZsC9h6WHfGYYYbd62VdmMuw4BvvORGHe19TsIt0Loxjqez3AlxTFNrJrueanflE
	 zN/bchdlMVAgYtOrtDdXk7aHPdGZS/fbj+GSjuwCU/XLZ2Symr4GWTf5hsKIslyt7x
	 n3KQESdCio3fg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2790DCCA471;
	Mon,  6 Oct 2025 22:12:43 +0000 (UTC)
From: Valerio Setti via B4 Relay <devnull+vsetti.baylibre.com@kernel.org>
Date: Tue, 07 Oct 2025 00:12:19 +0200
Subject: [PATCH] ASoC: meson: aiu-encoder-i2s: fix bit clock polarity
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251007-fix-i2s-polarity-v1-1-86704d9cda10@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAMI+5GgC/x2MWwqAIBAArxL73YKt9qCrRB9SWy2EhkYU0t2TP
 gdmJkHkIByhLxIEviSKdxmqsoBps25llDkzkKK6UqrBRW4Uinj43QY5H5xbY7TuFkukIWdH4Oz
 8y2F83w/n6ZUSYgAAAA==
X-Change-ID: 20251006-fix-i2s-polarity-d744338fa223
To: Jerome Brunet <jbrunet@baylibre.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Valerio Setti <vsetti@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1584;
 i=vsetti@baylibre.com; h=from:subject:message-id;
 bh=yhS4Hp8u/Or3vlCBo8NKBwUHK5bFZ95+lSDqT7ffm68=;
 b=owGbwMvMwCF2z3ty7kUrRgbG02pJDBlP7G7Vcrw8+WNXspbGklMbFI6a5LY+1/gg9v5pfgqHn
 ozu2umiHaUsDGIcDLJiiiws0+/9LihVe2iccLIAZg4rE8gQBi5OAZhIlAzDT0aRdVUTjRINNFhD
 Sg6cPrPmuFXCOu/OksauQpW5T2W/+zIy/FO7m1Wq8VTx9nf/GRt3bdV6nfajzTH9xteVf6afa9P
 azgAA
X-Developer-Key: i=vsetti@baylibre.com; a=openpgp;
 fpr=0497DEFB707526E13360C970DE4B936DD13A0100
X-Endpoint-Received: by B4 Relay for vsetti@baylibre.com/default with
 auth_id=515
X-Original-From: Valerio Setti <vsetti@baylibre.com>
Reply-To: vsetti@baylibre.com

From: Valerio Setti <vsetti@baylibre.com>

According to I2S specs audio data is sampled on the rising edge of the
clock and it can change on the falling one. When operating in normal mode
this SoC behaves the opposite so a clock polarity inversion is required
in this case.

This was tested on an OdroidC2 (Amlogic S905 SoC) board.

Signed-off-by: Valerio Setti <vsetti@baylibre.com>
---
 sound/soc/meson/aiu-encoder-i2s.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/soc/meson/aiu-encoder-i2s.c b/sound/soc/meson/aiu-encoder-i2s.c
index a0dd914c8ed13616fbcbc0828e36418cfd255391..3b4061508c18047fe8d6f3f98061720f8ce238f2 100644
--- a/sound/soc/meson/aiu-encoder-i2s.c
+++ b/sound/soc/meson/aiu-encoder-i2s.c
@@ -236,8 +236,12 @@ static int aiu_encoder_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	    inv == SND_SOC_DAIFMT_IB_IF)
 		val |= AIU_CLK_CTRL_LRCLK_INVERT;
 
-	if (inv == SND_SOC_DAIFMT_IB_NF ||
-	    inv == SND_SOC_DAIFMT_IB_IF)
+	/*
+	 * The SoC changes data on the rising edge of the bitclock
+	 * so an inversion of the bitclock is required in normal mode
+	 */
+	if (inv == SND_SOC_DAIFMT_NB_NF ||
+	    inv == SND_SOC_DAIFMT_NB_IF)
 		val |= AIU_CLK_CTRL_AOCLK_INVERT;
 
 	/* Signal skew */
@@ -328,4 +332,3 @@ const struct snd_soc_dai_ops aiu_encoder_i2s_dai_ops = {
 	.startup	= aiu_encoder_i2s_startup,
 	.shutdown	= aiu_encoder_i2s_shutdown,
 };
-

---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20251006-fix-i2s-polarity-d744338fa223

Best regards,
-- 
Valerio Setti <vsetti@baylibre.com>



