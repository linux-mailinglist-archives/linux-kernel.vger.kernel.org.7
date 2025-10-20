Return-Path: <linux-kernel+bounces-860795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 400D2BF0F7C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 13:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FA563BBD52
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20EF302CC9;
	Mon, 20 Oct 2025 11:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="KkCHc70t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pUKEzKgh"
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F9F30DD2F
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 11:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760961500; cv=none; b=EHBn21jbGPQVnUCmxZsicTLPdlSNtwIP95g/OYfeOIZBUtPS/T/agoMyxJGCIfsr8Vsbf4shhVf65B24xLGkq6jIpyuxDvgz86WCrxisAypJdANj/C4dExP2dyAvMYY+n+IAqCXBBzgpDekzxkCq23SX0ZQ4QIfri1K92GfiP/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760961500; c=relaxed/simple;
	bh=LrSjw7A1t1j3KWoJg+t7ZzRpPUSAFXuG6r84MPT5zqM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OAF27BQRPoBjxgNS/X587sFI/7UhqvyfmChnnZ7Zwgv8U3LhGGY1U23KMoEq72GeAL/ELSQ4CBXx+mlKSftZGf0sG85g3h/vVrEptRORLzJPglyiius9EmbRXfJlD/MCZ8rKHnSa4Ai94ToPRYHhE0y8j+EXiRMEcRjEjyoInGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=KkCHc70t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pUKEzKgh; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 97C24EC02E2;
	Mon, 20 Oct 2025 07:58:14 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 20 Oct 2025 07:58:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1760961494; x=1761047894; bh=Ww9DvCfxJ9
	3mFFiHtNCtI5RjcFbBSgRKT6N64U8sLJY=; b=KkCHc70t1mgu3nMMGEfvIM0gIe
	HmVPe+7wdWD0rlxBalyrB7ui1NT+yEKishMnun/sHHGFGYuSNArr71nk+h7P+Fa5
	gFMxqNq2QkEW/4dtgFYRoL8YDlmJwG/nfrL6heRMqbwC1QDjLcdqEcXDBHEOk+UD
	MfAOndw5/AgqmCDAhKcdBhi3hjccQM6Xi8HDkpaLyH1qVu4nVT+4dP+6offJkWek
	/5GbbQmtNha3bDSJvoH+G5O3Ysx90zw57Vy4Ss+MmcWCVBr6fX8aMuEstfMZ8EJK
	9VOepqPdcjaBLhNjF3BdgljnT+2CKzJ8DUTaY7yiI1xQAvf33p5OWKyqXYvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760961494; x=1761047894; bh=Ww9DvCfxJ93mFFiHtNCtI5RjcFbBSgRKT6N
	64U8sLJY=; b=pUKEzKghSifSQJs8BJXSEnSskU/UK9uojnvGTZrryBagWXR4NP8
	PHQmBfD1QTa1LCKmaLuSIx+mX3FZ7i+BrswGdL05vv0sd178OT4r/JSN5MuWvT4e
	mGhDR1jY4ptlss00Y8SGkn1BWzjzEcfjQLbv1CxODKCfJOZfX+7Ms3Ktcotn6Gnl
	RrD8OSdICckzWEZndu/KX5mY6y7Y4d1XslaVkEDTfTf+twAGHKfygMavxeoyIf/+
	KF5tSHFSkbvXf2oU0k/qCctcPs0nTH1rtmboEvtRo8l2561GEh651ayDIFy4yOBd
	hYZx3YJvX7dQASGKRwYTonqTz4Icl1WkIag==
X-ME-Sender: <xms:1iP2aHqqyTsbJWXhtkH69dJe-78IllZLRTxMXEnecsHAgJYCGXrVAg>
    <xme:1iP2aPl6WcCsitzEVwlCrYqdWbAGg5wYUeOfIKFFQOsf27q3vq-pICS6QGLSNvNsV
    1Jbb4G4XCDj-wAMYQKoYESSyXkd0Xmeopp-Alk-bKScmjEZyV-u3u0>
X-ME-Received: <xmr:1iP2aLyP538O7lnNRV-9NHMjS36khcpAVQW3vZjJG60jFJ--RwYiOiMFb83Ix3hlPhb-idcEbDgdWUWbggLrnd3R-r5eHnZzMPG7FkYY00Dx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufeejjeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghshhhi
    sehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeffvdeuleffveekud
    fhteejudffgefhtedtgfeutdfgvdfgueefudehveehveekkeenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrg
    hmohgttghhihdrjhhppdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehlihhnuhigudefleegqdguvghvvghlsehlihhsthhsrdhsohhurhgtvg
    hfohhrghgvrdhnvghtpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdr
    khgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:1iP2aHkGo6cgYWqDnkiRWm6kepPwmFP2sRoMDJID3vhGrsQfKGLp-A>
    <xmx:1iP2aEcqW5mqSURk2TKLMMogdzaGqk9rKWOnH7apNapd_dkVHYpbjA>
    <xmx:1iP2aNrBEnF7JgFzZO0blPcTx2QyP0DpBARMm5tE4tqKA-b6xCOnWA>
    <xmx:1iP2aC5unPTOy87JzbZn_muOwHwM_XKpACvsj2lzjlyXZDBaSNMu8Q>
    <xmx:1iP2aGdG4J73XGDqZyQTm35zaDr2wpGZBWnJZvo1QPziuAlgdM31yUI1>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Oct 2025 07:58:13 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] firewire: core: use cleanup function to release cached configuration ROM
Date: Mon, 20 Oct 2025 20:58:10 +0900
Message-ID: <20251020115810.92839-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When returning from read_config_rom() function, the allocated buffer and
the previous buffer for configuration ROM should be released. The cleanup
function is useful in the case.

This commit uses the cleanup function to remove goto statements.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-device.c | 34 ++++++++++++----------------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/drivers/firewire/core-device.c b/drivers/firewire/core-device.c
index 1674de477852..9b0080397154 100644
--- a/drivers/firewire/core-device.c
+++ b/drivers/firewire/core-device.c
@@ -653,8 +653,8 @@ static int read_rom(struct fw_device *device, int generation, int speed, int ind
 static int read_config_rom(struct fw_device *device, int generation)
 {
 	struct fw_card *card = device->card;
-	const u32 *old_rom, *new_rom;
-	u32 *rom, *stack;
+	const u32 *new_rom, *old_rom __free(kfree) = NULL;
+	u32 *stack, *rom __free(kfree) = NULL;
 	u32 sp, key;
 	int i, end, length, ret, speed;
 	int quirks;
@@ -673,7 +673,7 @@ static int read_config_rom(struct fw_device *device, int generation)
 	for (i = 0; i < 5; i++) {
 		ret = read_rom(device, generation, speed, i, &rom[i]);
 		if (ret != RCODE_COMPLETE)
-			goto out;
+			return ret;
 		/*
 		 * As per IEEE1212 7.2, during initialization, devices can
 		 * reply with a 0 for the first quadlet of the config
@@ -682,10 +682,8 @@ static int read_config_rom(struct fw_device *device, int generation)
 		 * harddisk).  In that case we just fail, and the
 		 * retry mechanism will try again later.
 		 */
-		if (i == 0 && rom[i] == 0) {
-			ret = RCODE_BUSY;
-			goto out;
-		}
+		if (i == 0 && rom[i] == 0)
+			return RCODE_BUSY;
 	}
 
 	quirks = detect_quirks_by_bus_information_block(rom);
@@ -712,15 +710,13 @@ static int read_config_rom(struct fw_device *device, int generation)
 		 */
 		key = stack[--sp];
 		i = key & 0xffffff;
-		if (WARN_ON(i >= MAX_CONFIG_ROM_SIZE)) {
-			ret = -ENXIO;
-			goto out;
-		}
+		if (WARN_ON(i >= MAX_CONFIG_ROM_SIZE))
+			return -ENXIO;
 
 		/* Read header quadlet for the block to get the length. */
 		ret = read_rom(device, generation, speed, i, &rom[i]);
 		if (ret != RCODE_COMPLETE)
-			goto out;
+			return ret;
 		end = i + (rom[i] >> 16) + 1;
 		if (end > MAX_CONFIG_ROM_SIZE) {
 			/*
@@ -744,7 +740,7 @@ static int read_config_rom(struct fw_device *device, int generation)
 		for (; i < end; i++) {
 			ret = read_rom(device, generation, speed, i, &rom[i]);
 			if (ret != RCODE_COMPLETE)
-				goto out;
+				return ret;
 
 			if ((key >> 30) != 3 || (rom[i] >> 30) < 2)
 				continue;
@@ -804,25 +800,19 @@ static int read_config_rom(struct fw_device *device, int generation)
 
 	old_rom = device->config_rom;
 	new_rom = kmemdup(rom, length * 4, GFP_KERNEL);
-	if (new_rom == NULL) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	if (new_rom == NULL)
+		return -ENOMEM;
 
 	scoped_guard(rwsem_write, &fw_device_rwsem) {
 		device->config_rom = new_rom;
 		device->config_rom_length = length;
 	}
 
-	kfree(old_rom);
-	ret = RCODE_COMPLETE;
 	device->max_rec	= rom[2] >> 12 & 0xf;
 	device->cmc	= rom[2] >> 30 & 1;
 	device->irmc	= rom[2] >> 31 & 1;
- out:
-	kfree(rom);
 
-	return ret;
+	return RCODE_COMPLETE;
 }
 
 static void fw_unit_release(struct device *dev)

base-commit: dbd0cf204fe6ba7ba226153d1d90369019b90164
-- 
2.51.0


