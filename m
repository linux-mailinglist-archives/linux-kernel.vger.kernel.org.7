Return-Path: <linux-kernel+bounces-710233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B50AEE995
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jun 2025 23:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07656189E355
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jun 2025 21:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D13E2949F0;
	Mon, 30 Jun 2025 21:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DNl5fFOk"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C27F1CDFCE
	for <linux-kernel@vger.kernel.org>; Mon, 30 Jun 2025 21:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751320005; cv=none; b=Iu/wh+hJaOkPuzaUxoyTHjJP28gKi1Rrdcz6x3XNc4iEq1Dj+rd4AJ+GS1lw7dBwU/7fhNO9WFNr1FCrYw8f+8aIBr3cW4llqdOivUF04TJlRaXGWulicd4YgRyyyXZW+seCDYawq/YqgK4oM4HGxmSVti+15mTFnv3Aimef5vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751320005; c=relaxed/simple;
	bh=u5s6k4Jdz2z8AXFLPplnaz3wYjFvVjXxszMHR4lBcFk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YPtqdYdTWYsesYwOve70xnHpqpEzZOYuWPda46h6m1BDf3LR8uQ+ihSxHtXra9jCriznJBBWr9gK6BqzGLMp+e3Nvl20QVzzh/uZWnmHXYEAMcv8z6H8FmbfwMRwZfdYYUIQhuvFhJ9gYhP5kqTZTpnA5PhCbrVeDJkwa3UIhBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DNl5fFOk; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751320001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RELCbEFu2DUPB6wgDcJ2J6c7pTcMWEgqSGU5NMKW/pQ=;
	b=DNl5fFOkj01YlNGt5Gz54+QW0c8ib+XC0OxLuFv87r2xZgE0JXwhRZSEd71XTbBhHSyqF2
	Tsbjp7c9MSSxsY3hPxfS04kbrQF8i+bfanAlO/xoiJsG6pWU7eRmkesO9C9dI173EJ0HxC
	E0eG3vpM7wETg33YPFHU+i1N9oHWcg8=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Takashi Iwai <tiwai@suse.de>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: mips/hal2: Refactor and improve hal2_compute_rate()
Date: Mon, 30 Jun 2025 23:45:52 +0200
Message-ID: <20250630214554.182953-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Assign 'codec->inc' first and then use it instead of the hardcoded
value 4 repeatedly.

Replace the if/else statement with a ternary operator and calculate
'codec->mod' directly. Remove the unnecessary local variable 'mod'.

Return the computed rate directly instead of updating the local variable
first.

No functional changes intended.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 sound/mips/hal2.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/sound/mips/hal2.c b/sound/mips/hal2.c
index 991793e6bda9..dd74bab531b4 100644
--- a/sound/mips/hal2.c
+++ b/sound/mips/hal2.c
@@ -313,21 +313,11 @@ static irqreturn_t hal2_interrupt(int irq, void *dev_id)
 
 static int hal2_compute_rate(struct hal2_codec *codec, unsigned int rate)
 {
-	unsigned short mod;
-
-	if (44100 % rate < 48000 % rate) {
-		mod = 4 * 44100 / rate;
-		codec->master = 44100;
-	} else {
-		mod = 4 * 48000 / rate;
-		codec->master = 48000;
-	}
-
 	codec->inc = 4;
-	codec->mod = mod;
-	rate = 4 * codec->master / mod;
+	codec->master = (44100 % rate < 48000 % rate) ? 44100 : 48000;
+	codec->mod = codec->inc * codec->master / rate;
 
-	return rate;
+	return codec->inc * codec->master / codec->mod;
 }
 
 static void hal2_set_dac_rate(struct snd_hal2 *hal2)
-- 
2.50.0


