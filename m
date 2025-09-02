Return-Path: <linux-kernel+bounces-796937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 150A1B409B8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 17:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EF6F542EE2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 15:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814A732ED45;
	Tue,  2 Sep 2025 15:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="es/TZHVQ"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C44432ED4E
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 15:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756828193; cv=none; b=N/dfr++yKtkVbIoO7mr2wsranvn12N9ItCStLT0x9j9f3LHVUBHs/FbcPcqwHvjPV4eK4Yam0pxU686qbV3ADnZcFioHNKPKq3sXZJUeuFKwScFRxgrwtTlei9ZUHRb+YvMkz6dgvtpG5IhKAhx4WOVmyEcatzH6hoR/t3/9L3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756828193; c=relaxed/simple;
	bh=GfKvp+lWp4pDl+F4HAi/ffLkDmbqVxkZi9rQVn5iVpY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f30HK4C7MJJ+gx5CGO9cTrI4wcUOfZuP2XqbSSWOJ2C09U1mMwPKOjDHJHDuWonci5Zwp774NHcVY9NUk944cyv2y5wDkXVZs/af2e8gxP3MA1SSPt6FrqxeqEBEqR3Yi9e4P1ZJ6LCHuG6TvaZoIvzQAWUlDlIR1p9J0/JhSjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=es/TZHVQ; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756828179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8x5w68yf3Af8nxe3BL7wYw1TQsHaAxRinJcTtpFvXT0=;
	b=es/TZHVQgvzG8f6T1erx6DDmo4HpoPWny4bktD1QFKblYA5QWlEw2wvSQelfxWRgIPFjB9
	QeEI3tdGUQhBZ2am/Kb/SS6gE+IYwSBYpbzZuGwJatt6PLMOzYfDf1pdS/QsuYKXaE5+z+
	6wA39BitRgzRxuu0AWe2NAQMev1+YgM=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Vasiliy Kovalev <kovalev@altlinux.org>,
	John Veness <john-linux@pelago.org.uk>,
	bo liu <bo.liu@senarytech.com>,
	Jackie Dong <xy-jackie@139.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Takashi Iwai <tiwai@suse.de>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Oldherl Oh <me@oldherl.one>,
	=?UTF-8?q?Jaros=C5=82aw=20Janik?= <jaroslaw.janik@gmail.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: hda/conexant: Fix typos in comments
Date: Tue,  2 Sep 2025 17:48:41 +0200
Message-ID: <20250902154858.86102-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

s/OPLC/OLPC/

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 sound/hda/codecs/conexant.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/hda/codecs/conexant.c b/sound/hda/codecs/conexant.c
index c881bf213ebe..5fcbc1312c69 100644
--- a/sound/hda/codecs/conexant.c
+++ b/sound/hda/codecs/conexant.c
@@ -32,7 +32,7 @@ struct conexant_spec {
 
 	unsigned int parse_flags; /* flag for snd_hda_parse_pin_defcfg() */
 
-	/* OPLC XO specific */
+	/* OLPC XO specific */
 	bool recording;
 	bool dc_enable;
 	unsigned int dc_input_bias; /* offset into olpc_xo_dc_bias */
@@ -407,7 +407,7 @@ static void cxt_fixup_headset_mic(struct hda_codec *codec,
 	}
 }
 
-/* OPLC XO 1.5 fixup */
+/* OLPC XO 1.5 fixup */
 
 /* OLPC XO-1.5 supports DC input mode (e.g. for use with analog sensors)
  * through the microphone jack.
-- 
2.51.0


