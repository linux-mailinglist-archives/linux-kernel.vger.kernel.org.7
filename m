Return-Path: <linux-kernel+bounces-841620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E34ABB7D56
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 20:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31FE34A3E6F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 18:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AC22DEA89;
	Fri,  3 Oct 2025 18:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Jjm0gcxj"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C66381BA;
	Fri,  3 Oct 2025 18:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759514612; cv=none; b=qoB5JZqKErJjb3PHYwAagk1U2dopUl4uIRvp/PfKonXAGYCrvSBr1aEM4R0URO2BHExeiC4ifP3CvPTB0ODPfjRTEKMjvCNNKM7XpPYnXHweUimaRv19qsBMI0vXucEE/lXgsL5CEEDPDNDKX8i9+N8h+lrCip7/ExHZzYY5gTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759514612; c=relaxed/simple;
	bh=1Ot6z9hO//qEEGRqMoDJT+qBc+H1lWRc/pl1r7YqdDY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d4SfVPMCKWoAXWN1KVgucaIyz5row4KxAM+SHwPiWrINCfke4hbd0Nuje0lJPCN3ec4+gTyw4ytDwTnKq/0ME4ooJJj2T/6UxFy9pENq2klxBbuHle8RNvMpUcGacRrORV6Mcg7heleM4skyhMs3Yr6OULTNKtZZLdorg+a0Zfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Jjm0gcxj; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759514609;
	bh=1Ot6z9hO//qEEGRqMoDJT+qBc+H1lWRc/pl1r7YqdDY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Jjm0gcxjFD9xbjCgclwu/DIiXhF3x2g1nsydvr7JNV0a3acaBG7a3KowD+3TFAi85
	 I0Aos/uBTISAt/oMA0TAKKyghYWjfs4cmqa0WgInziKR0Cj/Qg69ARM1EdPhjwoQvf
	 /BaIb5mTpVMSukY/o65dM2OhBrKOBZO8LnbQlTNh5lU0N2asx/po7tWY8XjxJ8/BHt
	 ck8WMJmndw0VJrYG/2CcvHjZp274NW2zLUeyisaPvjyGbBjkejFdoIoL+ifWG0ih52
	 gBiaEXhN4SFQUGUNz3S2YL1y6vod8vFrWo53sd/Tsjuk522/jpNUYb0DKZWUWYiuwP
	 pCMY/PK8pVl4Q==
Received: from localhost (unknown [82.79.138.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 2CDB017E137E;
	Fri,  3 Oct 2025 20:03:29 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Fri, 03 Oct 2025 21:03:24 +0300
Subject: [PATCH 2/5] ASoC: nau8821: Generalize helper to clear IRQ status
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251003-nau8821-jdet-fixes-v1-2-f7b0e2543f09@collabora.com>
References: <20251003-nau8821-jdet-fixes-v1-0-f7b0e2543f09@collabora.com>
In-Reply-To: <20251003-nau8821-jdet-fixes-v1-0-f7b0e2543f09@collabora.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Seven Lee <wtli@nuvoton.com>
Cc: kernel@collabora.com, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

Instead of adding yet another utility function for dealing with the
interrupt clearing register, generalize nau8821_int_status_clear_all()
by renaming it to nau8821_irq_status_clear(), whilst introducing a
second parameter to allow restricting the operation scope to a single
interrupt instead of the whole range of active IRQs.

While at it, also fix a spelling typo in the comment block.

Note this is mainly a prerequisite for subsequent patches aiming to
address some deficiencies in the implementation of the interrupt
handler.  Thus the presence of the Fixes tag below is intentional, to
facilitate backporting.

Fixes: aab1ad11d69f ("ASoC: nau8821: new driver")
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 sound/soc/codecs/nau8821.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/nau8821.c b/sound/soc/codecs/nau8821.c
index fed5d51fa5c3b4ea6060cc3b8287261d7509e225..cefce97893123462198c2e66d1de9d06e4d3dd28 100644
--- a/sound/soc/codecs/nau8821.c
+++ b/sound/soc/codecs/nau8821.c
@@ -1021,12 +1021,17 @@ static bool nau8821_is_jack_inserted(struct regmap *regmap)
 	return active_high == is_high;
 }
 
-static void nau8821_int_status_clear_all(struct regmap *regmap)
+static void nau8821_irq_status_clear(struct regmap *regmap, int active_irq)
 {
-	int active_irq, clear_irq, i;
+	int clear_irq, i;
 
-	/* Reset the intrruption status from rightmost bit if the corres-
-	 * ponding irq event occurs.
+	if (active_irq) {
+		regmap_write(regmap, NAU8821_R11_INT_CLR_KEY_STATUS, active_irq);
+		return;
+	}
+
+	/* Reset the interruption status from rightmost bit if the
+	 * corresponding irq event occurs.
 	 */
 	regmap_read(regmap, NAU8821_R10_IRQ_STATUS, &active_irq);
 	for (i = 0; i < NAU8821_REG_DATA_LEN; i++) {
@@ -1053,7 +1058,7 @@ static void nau8821_eject_jack(struct nau8821 *nau8821)
 	snd_soc_dapm_sync(dapm);
 
 	/* Clear all interruption status */
-	nau8821_int_status_clear_all(regmap);
+	nau8821_irq_status_clear(regmap, 0);
 
 	/* Enable the insertion interruption, disable the ejection inter-
 	 * ruption, and then bypass de-bounce circuit.
@@ -1522,7 +1527,7 @@ static int nau8821_resume_setup(struct nau8821 *nau8821)
 	nau8821_configure_sysclk(nau8821, NAU8821_CLK_DIS, 0);
 	if (nau8821->irq) {
 		/* Clear all interruption status */
-		nau8821_int_status_clear_all(regmap);
+		nau8821_irq_status_clear(regmap, 0);
 
 		/* Enable both insertion and ejection interruptions, and then
 		 * bypass de-bounce circuit.

-- 
2.51.0


