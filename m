Return-Path: <linux-kernel+bounces-590963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39966A7D90B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Apr 2025 11:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 575563B153A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Apr 2025 09:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B128D22F154;
	Mon,  7 Apr 2025 09:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MbvvmloL"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2761C22DFBA
	for <linux-kernel@vger.kernel.org>; Mon,  7 Apr 2025 09:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744016933; cv=none; b=PR7dQIeA9ONs+IVKf/GfL1qRA+IsEhlheNWFRJ7Vl6iKH+fkBuVAd2gVYnSDPwSNQ0zWxu8eXJU/9lauHFKdHgKb1zHyPO1I/W4zh6QTaEnC4MV9UlBIioXL5MkP+A8aNA8dXzCYaaugKY1QDAfdNEQrR99VMT8S6LgGhkFflII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744016933; c=relaxed/simple;
	bh=otjyu1yK+Nmm0V/n4TFbCOpBPDznw9MHSZTLk3O0/70=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nn4xCf0oZJIIvRx0gAZzKtfEa9YH36GAI7WidWYkcbBy8ES53iiIr/G8jAFGryaGCYJpa06Kb5em0ie62C81GLIURAucdpqQSZPzaTXYkTdSoiiG62sfOCYZGqkv5RepoELOfWEOXGQiwzRy9nnVNxgkVCF2Fh2V6pCQ92SluHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MbvvmloL; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744016929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PI2yBm7HedcIW7BHq6L6NdzgVKH2U6R6R99lyNbMjAI=;
	b=MbvvmloLqmACtwOASZdPBiiKhNS7Tlhx4oACe/gaRkdPZI2hpQlHnxYJ69k1YNPBbprgn+
	OnhuWeTjD6uv58h2y1q3E8rQkrhiVqQrCWRIN3Oew/L2smy1XWH5ksN1/c/r/UGqrKQgxD
	ZfiBcv9j0QkxIXd5CWOU2wxBIoqPcsY=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-hardening@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: azt2320: Replace deprecated strcpy() with strscpy()
Date: Mon,  7 Apr 2025 11:08:29 +0200
Message-ID: <20250407090832.743255-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strcpy() is deprecated, use strscpy() instead.

Link: https://github.com/KSPP/linux/issues/88
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 sound/isa/azt2320.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/isa/azt2320.c b/sound/isa/azt2320.c
index b937c9138d12..588b9f0831d3 100644
--- a/sound/isa/azt2320.c
+++ b/sound/isa/azt2320.c
@@ -189,8 +189,8 @@ static int snd_card_azt2320_probe(int dev,
 	if (error < 0)
 		return error;
 
-	strcpy(card->driver, "AZT2320");
-	strcpy(card->shortname, "Aztech AZT2320");
+	strscpy(card->driver, "AZT2320");
+	strscpy(card->shortname, "Aztech AZT2320");
 	sprintf(card->longname, "%s, WSS at 0x%lx, irq %i, dma %i&%i",
 		card->shortname, chip->port, irq[dev], dma1[dev], dma2[dev]);
 
-- 
2.49.0


