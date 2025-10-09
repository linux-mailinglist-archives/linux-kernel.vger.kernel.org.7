Return-Path: <linux-kernel+bounces-847253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 733B7BCA5C0
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 19:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 945713C043D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 17:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ADB723C4ED;
	Thu,  9 Oct 2025 17:20:37 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C341397;
	Thu,  9 Oct 2025 17:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760030437; cv=none; b=J+q3ddRtkiJSq3/ItESNIsLw3uQrbGaVvFGare9oOO84OFbqSoc+hgDj/XxmyRPENRBm2oi6ULpPs9CEDP6fksll+B252vsf3pTLRFFyaTXVPqIFupVhXnP0pGuk/+SGoFgNnt61hWmg9YUL/sBao5zo8fNE6kNtbSq4FhJ4IQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760030437; c=relaxed/simple;
	bh=h6mBn1YnACsX7CDnRFvzoiOd0OKOEjGYnLm4xgraf4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nLGvnLzf48BQWX0c4NpzzT5r/LCifCQvX3SpKbRQxjlVFKkeBlBcWQvhRCE6McMfaPgKxazPP8md2AGESKWil/HZurjf1IXpMnA9Kj5JcFq4NhOPTnu3ZoKf27RkJVLyZa/J4XemqKR2RdtSvXMxhA0NVsK9PrHtZFxoiNUCF60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4cjGRF331Qz9sSY;
	Thu,  9 Oct 2025 19:03:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NF51hGVtVs4V; Thu,  9 Oct 2025 19:03:21 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4cjGRF2Gmsz9sSX;
	Thu,  9 Oct 2025 19:03:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 3D92B8B776;
	Thu,  9 Oct 2025 19:03:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id fzt8czwtvfVI; Thu,  9 Oct 2025 19:03:21 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id BD9F08B774;
	Thu,  9 Oct 2025 19:03:20 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Herve Codina <herve.codina@bootlin.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: codecs: Fix gain setting ranges for Renesas IDT821034 codec
Date: Thu,  9 Oct 2025 19:03:13 +0200
Message-ID: <2bd547194f3398e6182f770d7d6be711c702b4b2.1760029099.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760029394; l=2116; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=h6mBn1YnACsX7CDnRFvzoiOd0OKOEjGYnLm4xgraf4Y=; b=3zaVO3ilKwr/HpISlTX08kgChzyn0om6eB6WGsGlRurPoIiQ2NdveTwiCfbEl++3B1IH1Axzl Vbm0WVI90HyCfScIGXTBD64ZBKCdlDgPHhgvMO5Rm/SX2CYVzyyKLCJ
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

The gain ranges specified in Renesas IDT821034 codec documentation
are [-3dB;+13dB] in the transmit path (ADC) and [-13dB;+3dB] in the
receive path (DAC). Allthough the registers allow programming values
outside those ranges, the signal S/N and distorsion are only
guaranteed in the specified ranges.

Set ranges to the specified ones.

Fixes: e51166990e81 ("ASoC: codecs: Add support for the Renesas IDT821034 codec")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 sound/soc/codecs/idt821034.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/idt821034.c b/sound/soc/codecs/idt821034.c
index a03d4e5e7d144..cab2f2eecdfba 100644
--- a/sound/soc/codecs/idt821034.c
+++ b/sound/soc/codecs/idt821034.c
@@ -548,14 +548,14 @@ static int idt821034_kctrl_mute_put(struct snd_kcontrol *kcontrol,
 	return ret;
 }
 
-static const DECLARE_TLV_DB_LINEAR(idt821034_gain_in, -6520, 1306);
-#define IDT821034_GAIN_IN_MIN_RAW	1 /* -65.20 dB -> 10^(-65.2/20.0) * 1820 = 1 */
-#define IDT821034_GAIN_IN_MAX_RAW	8191 /* 13.06 dB -> 10^(13.06/20.0) * 1820 = 8191 */
+static const DECLARE_TLV_DB_LINEAR(idt821034_gain_in, -300, 1300);
+#define IDT821034_GAIN_IN_MIN_RAW	1288 /* -3.0 dB -> 10^(-3.0/20.0) * 1820 = 1288 */
+#define IDT821034_GAIN_IN_MAX_RAW	8130 /* 13.0 dB -> 10^(13.0/20.0) * 1820 = 8130 */
 #define IDT821034_GAIN_IN_INIT_RAW	1820 /* 0dB -> 10^(0/20) * 1820 = 1820 */
 
-static const DECLARE_TLV_DB_LINEAR(idt821034_gain_out, -6798, 1029);
-#define IDT821034_GAIN_OUT_MIN_RAW	1 /* -67.98 dB -> 10^(-67.98/20.0) * 2506 = 1*/
-#define IDT821034_GAIN_OUT_MAX_RAW	8191 /* 10.29 dB -> 10^(10.29/20.0) * 2506 = 8191 */
+static const DECLARE_TLV_DB_LINEAR(idt821034_gain_out, -1300, 300);
+#define IDT821034_GAIN_OUT_MIN_RAW	561 /* -13.0 dB -> 10^(-13.0/20.0) * 2506 = 561 */
+#define IDT821034_GAIN_OUT_MAX_RAW	3540 /* 3.0 dB -> 10^(3.0/20.0) * 2506 = 3540 */
 #define IDT821034_GAIN_OUT_INIT_RAW	2506 /* 0dB -> 10^(0/20) * 2506 = 2506 */
 
 static const struct snd_kcontrol_new idt821034_controls[] = {
-- 
2.49.0


