Return-Path: <linux-kernel+bounces-858988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8F2BEC6B2
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 05:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77AB9422601
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 03:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64AC2868A9;
	Sat, 18 Oct 2025 03:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="aUTkoMUf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Bz6JrJtL"
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D771247DE1;
	Sat, 18 Oct 2025 03:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760759741; cv=none; b=oCZSkyTltgSCP8NgE+I2lEZ4tX382g78k693olRqTqvF+vjOFAIW0a20JmV0bB5bRNsnXZBLQSp4xqXLx3kIvvP/5QglPFutbZmFBnjon9YDc26L/fnje+flBsOqJ+B+K8Kx3IDpG7pXRw6uj9WTJoA/Afj6u9eoh1JMTWSHyjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760759741; c=relaxed/simple;
	bh=1KjPBXpllrt7gQWTe0vVJMze3JSCqr4z7wLJC/BXbP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kx5dWoEaqLe4M0FI1olt4KbEj/Ha3GgofFhhzkYRvilX69EP953swalccG89ArUOYajagGz0smm3p6lzaCw/j/V0c1vyX0KXDflgbJxyw1uL2KyYqWfyrY0QJ1wJHk1TQG5XZnlm+nNfHiLQnveIo58CVfFNuM6Z721UdS9qIaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=aUTkoMUf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Bz6JrJtL; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 7B4991D00151;
	Fri, 17 Oct 2025 23:55:38 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 17 Oct 2025 23:55:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1760759738; x=
	1760846138; bh=7hcYwfBrFq5jZc04hPPfE2gQ2RHVPgydmNVwQVUfXMM=; b=a
	UTkoMUfTLOtktLwlIWR8tes62PHTRtO8rr6071xdk/gxvKnyyUtmzeB9qn3QdeRq
	KUPUt3T6eOTqiuvGSOD3eL5lmTq2mJXs71BmLfMS+uE3aNH7C9rOQavFCB/rvFlL
	5mrhLwdQSW84P9erhW5/a8aauTsJpxbom6DAOaistaA/YJfXWpCd7wi/tjuIo/jc
	50ybN6NIJHLMuLDnBvNIK1Rdj022Nt+YZ8WR0LaRTrUOblTY0bHP3R4ujlzhUXZJ
	tsoGCW4OlLiS0bksXqKXYLIVEjYtUyvE+ClXavAdsp3i4k7z6WfZUFID6rxo7noO
	Y/AX6MK8OCruERLeRK0YA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1760759738; x=1760846138; bh=7
	hcYwfBrFq5jZc04hPPfE2gQ2RHVPgydmNVwQVUfXMM=; b=Bz6JrJtLa5/Kkb2aI
	Nl0NbnQ7ok1WcO3mqXJm7j4vp4uw/brWUBXR4qqqmGI/I/A1qRaR/fbXpt/L/ujJ
	dR7gaGaIVT+un3x0Jg5DtaB8UJut9X9re7Q55Fofi15uL95zhTK4KGneCu5oGDMS
	A30fHZrcs87F3AmqK/gvL6KTylJA5NP1iDQChwEBoWHj5w9FbjudIXf3Cyr9lCbD
	4ofa25sKU7MkEWnqg/NSHuTzuLB8eQITYeh6yp85O7teHdwAfvdl5cL/T9l+ZCr4
	GB9kuD3dLACzSZzlhu/VlJdC1QekSZbqRyDnpUvSq3ZVzzBaViFvb6cT5xpFle2L
	Uchng==
X-ME-Sender: <xms:ug_zaOMbnj5Vllodk4gFVgCom6BJwdbOZqiDFoAr3fgZ6vfpK14goQ>
    <xme:ug_zaNFSNVAS6YFrjK02JWYzehpcKBL9PpBFMoTadVhD-Vz_zslkUBWOt3FF8HfHU
    s6GUexZv7eKX_XwrrZuDDsDe952OiZ9iTRkH_qvuLiitTil_e2JHWJj>
X-ME-Received: <xmr:ug_zaNMSmxMi6B47JJtYVJPGysY_7iqyT2KkbLpv_-f4U82u7A6aSUAmXpb_jnGFaKvfqCNGTSMJnfKwHLhZI2veUGYzINRrMWDISoHn7m9Uog>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufedutdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghs
    hhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgjeeuvd
    fguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhisehsrg
    hkrghmohgttghhihdrjhhppdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehlihhnuhigudefleegqdguvghvvghlsehlihhsthhsrdhsohhurh
    gtvghfohhrghgvrdhnvghtpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqshhouhhnugesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ug_zaG9Wo2P3HH0zkkv2xDns6ppX1bF8dpQOo10O37-g5NlnmNiSBw>
    <xmx:ug_zaBSVcYq0Mf5Q9UXZjhejYKRdolaIafDusC-X1zudU3snMGbHHA>
    <xmx:ug_zaIl_3J3SovSS2xeGOGhxndm8ttnnGfZUlWuLXHDC2V1Ckq0F5w>
    <xmx:ug_zaBSZBF-RKxtrSUubI-51xgosASibQ8mYCtxjus7s6UBG1-xjUw>
    <xmx:ug_zaLgToIpYiDjEf1svl1YVJTejKCxG2JzF1rXpCiJeXLTbuZN49bgP>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Oct 2025 23:55:37 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org
Subject: [PATCH 1/4] firewire: core: code refactoring to compute transaction speed
Date: Sat, 18 Oct 2025 12:55:29 +0900
Message-ID: <20251018035532.287124-2-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251018035532.287124-1-o-takashi@sakamocchi.jp>
References: <20251018035532.287124-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit refactors the helper function to read the content of
configuration ROM with the passed speed.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-device.c | 35 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/drivers/firewire/core-device.c b/drivers/firewire/core-device.c
index 33ce4cd357ed..c698d4ced7d7 100644
--- a/drivers/firewire/core-device.c
+++ b/drivers/firewire/core-device.c
@@ -605,8 +605,7 @@ static int detect_quirks_by_root_directory(const u32 *root_directory, unsigned i
 	return quirks;
 }
 
-static int read_rom(struct fw_device *device,
-		    int generation, int index, u32 *data)
+static int read_rom(struct fw_device *device, int generation, int speed, int index, u32 *data)
 {
 	u64 offset = (CSR_REGISTER_BASE | CSR_CONFIG_ROM) + index * 4;
 	int i, rcode;
@@ -617,7 +616,7 @@ static int read_rom(struct fw_device *device,
 	for (i = 10; i < 100; i += 10) {
 		rcode = fw_run_transaction(device->card,
 				TCODE_READ_QUADLET_REQUEST, device->node_id,
-				generation, device->max_speed, offset, data, 4);
+				generation, speed, offset, data, 4);
 		if (rcode != RCODE_BUSY)
 			break;
 		msleep(i);
@@ -644,7 +643,7 @@ static int read_config_rom(struct fw_device *device, int generation)
 	const u32 *old_rom, *new_rom;
 	u32 *rom, *stack;
 	u32 sp, key;
-	int i, end, length, ret;
+	int i, end, length, ret, speed;
 	int quirks;
 
 	rom = kmalloc(sizeof(*rom) * MAX_CONFIG_ROM_SIZE +
@@ -655,11 +654,11 @@ static int read_config_rom(struct fw_device *device, int generation)
 	stack = &rom[MAX_CONFIG_ROM_SIZE];
 	memset(rom, 0, sizeof(*rom) * MAX_CONFIG_ROM_SIZE);
 
-	device->max_speed = SCODE_100;
+	speed = SCODE_100;
 
 	/* First read the bus info block. */
 	for (i = 0; i < 5; i++) {
-		ret = read_rom(device, generation, i, &rom[i]);
+		ret = read_rom(device, generation, speed, i, &rom[i]);
 		if (ret != RCODE_COMPLETE)
 			goto out;
 		/*
@@ -681,7 +680,7 @@ static int read_config_rom(struct fw_device *device, int generation)
 	// Just prevent from torn writing/reading.
 	WRITE_ONCE(device->quirks, quirks);
 
-	device->max_speed = device->node->max_speed;
+	speed = device->node->max_speed;
 
 	/*
 	 * Determine the speed of
@@ -692,20 +691,18 @@ static int read_config_rom(struct fw_device *device, int generation)
 	 * because some buggy firmwares set it lower than necessary and because
 	 * 1394-1995 nodes do not have the field.
 	 */
-	if ((rom[2] & 0x7) < device->max_speed ||
-	    device->max_speed == SCODE_BETA ||
-	    card->beta_repeaters_present) {
+	if ((rom[2] & 0x7) < speed || speed == SCODE_BETA || card->beta_repeaters_present) {
 		u32 dummy;
 
 		/* for S1600 and S3200 */
-		if (device->max_speed == SCODE_BETA)
-			device->max_speed = card->link_speed;
+		if (speed == SCODE_BETA)
+			speed = card->link_speed;
 
-		while (device->max_speed > SCODE_100) {
-			if (read_rom(device, generation, 0, &dummy) ==
+		while (speed > SCODE_100) {
+			if (read_rom(device, generation, speed, 0, &dummy) ==
 			    RCODE_COMPLETE)
 				break;
-			device->max_speed--;
+			--speed;
 		}
 	}
 
@@ -734,7 +731,7 @@ static int read_config_rom(struct fw_device *device, int generation)
 		}
 
 		/* Read header quadlet for the block to get the length. */
-		ret = read_rom(device, generation, i, &rom[i]);
+		ret = read_rom(device, generation, speed, i, &rom[i]);
 		if (ret != RCODE_COMPLETE)
 			goto out;
 		end = i + (rom[i] >> 16) + 1;
@@ -758,7 +755,7 @@ static int read_config_rom(struct fw_device *device, int generation)
 		 * it references another block, and push it in that case.
 		 */
 		for (; i < end; i++) {
-			ret = read_rom(device, generation, i, &rom[i]);
+			ret = read_rom(device, generation, speed, i, &rom[i]);
 			if (ret != RCODE_COMPLETE)
 				goto out;
 
@@ -785,6 +782,8 @@ static int read_config_rom(struct fw_device *device, int generation)
 			length = i;
 	}
 
+	device->max_speed = speed;
+
 	quirks |= detect_quirks_by_root_directory(rom + ROOT_DIR_OFFSET, length - ROOT_DIR_OFFSET);
 
 	// Just prevent from torn writing/reading.
@@ -1234,7 +1233,7 @@ static int reread_config_rom(struct fw_device *device, int generation,
 	int i, rcode;
 
 	for (i = 0; i < 6; i++) {
-		rcode = read_rom(device, generation, i, &q);
+		rcode = read_rom(device, generation, device->max_speed, i, &q);
 		if (rcode != RCODE_COMPLETE)
 			return rcode;
 
-- 
2.51.0


