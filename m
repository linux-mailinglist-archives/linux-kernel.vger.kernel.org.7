Return-Path: <linux-kernel+bounces-858989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C1FEEBEC6BD
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 05:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AD75E4F1F09
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 03:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3B52882A1;
	Sat, 18 Oct 2025 03:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="asld1cgw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WiafUUXt"
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C1E283FCD;
	Sat, 18 Oct 2025 03:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760759743; cv=none; b=m9rlOqFY8YwI7jfOOWLi57fLqxm7U4TbvJwF9qxEytqHrRH0//1ptwivXP61+GWlFb06VhnJOcFpy1adr4LQUaco958NHHobGIXL4swsy0pMuTSAu9JM3vS88RGdrLXPgmAPivwCNAA7h9i53ad5MmiR/tfcfgle5SweWlIPpR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760759743; c=relaxed/simple;
	bh=E6hanbGQUZFTn7iDKfN/WIfwn073f0TH4F1/RRVmj24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qmrIkdGfXPzqHHEfIyp24OycJ1HhyumYM4gXN8Qa5GONAnsDIvWRSMl1AHzPRBv17U8JPGQS9hMbjHHVHCoNooBd8/sNXq15chivNpwO74YTbDOr+gEbolLa3T5B+pThJ7XEWGN65/NZ4ig4XnkeLddLBYfhS5eWRfqWHfdCBaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=asld1cgw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WiafUUXt; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5A3647A0140;
	Fri, 17 Oct 2025 23:55:40 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 17 Oct 2025 23:55:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1760759740; x=
	1760846140; bh=yGRLVQuJIrWSADXY2lmb05uJei7Ja3Kf7eceuATqL44=; b=a
	sld1cgwe3nm/t5hVjfdXsZRcUZKW7J7KiUmfzWaFGfE/9VFELTRyurBiHvUojG8N
	Tszm0X2kAxlcHhs2/19cV2SF/31X+12y5gZZV+UmpO+qpKkpHVN91fo/Vg1N9UEZ
	aPK/fVcYBeSNFMLSQOnJmfggnhJ43LNIDP5DrlHoHAFnDS5eCEQH7jSyPc1h46m/
	pgA8VgBeYp5SeLTLIntzFITRXbJBYCVfyIh7skO7Fs2Q80vWvTyliYmRk1g9nQL3
	ekezbiGddkP3k2Zfn3NJsuZ1CGW8oEdQ6ZNI0mNrO+WkDvxqgramKdxl7HsKzMhN
	JFy/ZpH+dhobvL0APM4yg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1760759740; x=1760846140; bh=y
	GRLVQuJIrWSADXY2lmb05uJei7Ja3Kf7eceuATqL44=; b=WiafUUXt0pTbhRXpF
	Li3sQ5MvsqLO+w43amhexhcfBVG/5IxTMMkBWvZ1M58Djv23dEi0VA2sM4MCsODq
	WI6p/i8wfuHtT4iJiwcfkB1eWzxrF0Yc43+3ipJNgtmldnkWt+1HjpwjXAx+OGo/
	7be8XnViIwW/+lz4cvpc1RKIkinGcGtuoLI/h0/W0IXgsCdDTKwHjM4DWbZatf5X
	pmujMaxu7UYnjFxIdBGzazNI1cB309PsNaARbaN54/D+71aHfzGmBp59FKENFjgA
	6k3HaePPRBFwHMK50ed9YHfwD251xV4lsHXzIy3YK4NC92b1qkOIAzxprTVZ4jrE
	n2tdw==
X-ME-Sender: <xms:uw_zaIw1qdvdAQepF7JvSy2cjwQ80CohLnxys00XxGPPOicb9c8swg>
    <xme:uw_zaMYVyVwTEvtEO1OzB0hch4pi0YUkUjGmL99Dn4um8HAJuGS6SmOMo0G_gxSjV
    Zd8ZBd_ZYkBzeNOE3_MLfMf8b9SBuuRrAvGbjNQh71WywXhPqJHk0w>
X-ME-Received: <xmr:uw_zaCQziV-Ggo3NKlGokP5kA8BT2NYUa3cEI5WQSUXNM-gqmtLyeI6FyP5NdDsr-WH0UKf4N7k6KiUCPTEC13cAixNWcYFhW26BJSO3pILezg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufedutddvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:uw_zaOzeu7Gq35gDSUYytUnVi6MxvDFuSAnQ_q0FQgxcqS01gZUKnw>
    <xmx:vA_zaE0AwA5Zkzz9Hw3Lkg0EoNocnogLY5RJoV-QJ0Cw5wPzyP1QYQ>
    <xmx:vA_zaM5cIa4vz_bVWg2eZCLqVTCGLDAgEtJ-f3pkwHUotMbvF6tsmg>
    <xmx:vA_zaHXNvvwUx495HNrrb601Yvk80glJQ8hnnSzCcqBzC_CCncwoNw>
    <xmx:vA_zaBVQSZ-QQbms4nbWPU6IAlczDBpZoqzYuFAc_q1hEP9fwepFxzlm>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Oct 2025 23:55:38 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org
Subject: [PATCH 2/4] firewire: core: determine transaction speed after detecting quirks
Date: Sat, 18 Oct 2025 12:55:30 +0900
Message-ID: <20251018035532.287124-3-o-takashi@sakamocchi.jp>
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

Current implementation determines the maximum transaction speed supported
by the target device after reading bus information block of configuration
ROM. The read operations for root directory block are then performed at
the determined speed. However, some devices have quirks that cause issues
when transactions are performed at the determined speed.

In the first place, all devices are required to support the lowest speed
(S100) and must respond successfully to any read request within the
configuration ROM space. Therefore it is safe to postpone speed
determination until the entire configuration ROM has been read.

This commit moves the speed determination after reading root directory.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-device.c | 53 ++++++++++++++++------------------
 1 file changed, 25 insertions(+), 28 deletions(-)

diff --git a/drivers/firewire/core-device.c b/drivers/firewire/core-device.c
index c698d4ced7d7..6a5740ed4934 100644
--- a/drivers/firewire/core-device.c
+++ b/drivers/firewire/core-device.c
@@ -680,32 +680,6 @@ static int read_config_rom(struct fw_device *device, int generation)
 	// Just prevent from torn writing/reading.
 	WRITE_ONCE(device->quirks, quirks);
 
-	speed = device->node->max_speed;
-
-	/*
-	 * Determine the speed of
-	 *   - devices with link speed less than PHY speed,
-	 *   - devices with 1394b PHY (unless only connected to 1394a PHYs),
-	 *   - all devices if there are 1394b repeaters.
-	 * Note, we cannot use the bus info block's link_spd as starting point
-	 * because some buggy firmwares set it lower than necessary and because
-	 * 1394-1995 nodes do not have the field.
-	 */
-	if ((rom[2] & 0x7) < speed || speed == SCODE_BETA || card->beta_repeaters_present) {
-		u32 dummy;
-
-		/* for S1600 and S3200 */
-		if (speed == SCODE_BETA)
-			speed = card->link_speed;
-
-		while (speed > SCODE_100) {
-			if (read_rom(device, generation, speed, 0, &dummy) ==
-			    RCODE_COMPLETE)
-				break;
-			--speed;
-		}
-	}
-
 	/*
 	 * Now parse the config rom.  The config rom is a recursive
 	 * directory structure so we parse it using a stack of
@@ -782,13 +756,36 @@ static int read_config_rom(struct fw_device *device, int generation)
 			length = i;
 	}
 
-	device->max_speed = speed;
-
 	quirks |= detect_quirks_by_root_directory(rom + ROOT_DIR_OFFSET, length - ROOT_DIR_OFFSET);
 
 	// Just prevent from torn writing/reading.
 	WRITE_ONCE(device->quirks, quirks);
 
+	speed = device->node->max_speed;
+
+	// Determine the speed of
+	//   - devices with link speed less than PHY speed,
+	//   - devices with 1394b PHY (unless only connected to 1394a PHYs),
+	//   - all devices if there are 1394b repeaters.
+	// Note, we cannot use the bus info block's link_spd as starting point because some buggy
+	// firmwares set it lower than necessary and because 1394-1995 nodes do not have the field.
+	if ((rom[2] & 0x7) < speed || speed == SCODE_BETA || card->beta_repeaters_present) {
+		u32 dummy;
+
+		// for S1600 and S3200.
+		if (speed == SCODE_BETA)
+			speed = card->link_speed;
+
+		while (speed > SCODE_100) {
+			if (read_rom(device, generation, speed, 0, &dummy) ==
+			    RCODE_COMPLETE)
+				break;
+			--speed;
+		}
+	}
+
+	device->max_speed = speed;
+
 	old_rom = device->config_rom;
 	new_rom = kmemdup(rom, length * 4, GFP_KERNEL);
 	if (new_rom == NULL) {
-- 
2.51.0


