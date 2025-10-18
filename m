Return-Path: <linux-kernel+bounces-858990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 85097BEC6AC
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 05:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0A961352DEB
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 03:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B722728D83D;
	Sat, 18 Oct 2025 03:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="WJ3eawXd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vXKD/Saf"
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7E5286D40;
	Sat, 18 Oct 2025 03:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760759744; cv=none; b=NIY3Qva0bc88sA/hceUUdO+V1EIT7QNlQ5LVY7pA/XHSYjdfSndnUdf/lEhZYlPNpTmqMRNYYMhjX8TyO3VJBKEfrJ5ReRp1NoKpOyf6IRayGlCuWGMCcsnXoaVqq5xgT2zGkjoq2dIe46DE7cYtwhk3Pt2Yln/QfL0gaGd5BEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760759744; c=relaxed/simple;
	bh=9q4ZenqssNuq566mSzIGMWY9TKVglICy5yTYQWSr0Xg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EJkS23bNcWCt1Uqc+nANPPm9CakBvjoYMB8JPIQKGmYbcJ3m/MRe+BUWJ7izSVIcYn7llJjZ02FFTj7ShzX907wRfZf1mg2v+/HGvBqMRnZlpoBnxXfsQwV6DUR/z2QGesN5DeY+3bDdJV/XQYRt/S96LOHO1rJFPcUqu4XdOKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=WJ3eawXd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vXKD/Saf; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 168F97A0147;
	Fri, 17 Oct 2025 23:55:42 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 17 Oct 2025 23:55:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1760759741; x=
	1760846141; bh=dm4H81ZdYiAnyPguz4Bgqq3z9wTH09vJcCXCWxJQJ8Y=; b=W
	J3eawXd2Sn10e3oevbtewhdQX6zvoVsPhvoppgBu2JraxuK6yD/5ss6xxTt/VymR
	pnGD1aUUlDnrdZKSOPrFyTOJLIBbg3JiqGywmwY3r/ETfVkrdy3MwBbSVJP8sibm
	KL2WCzPfpZDTBAVg4jUxOpYlCN6+2En793B7Es2twZwe0/rgRNv7808eRDeMuR3U
	C02HL7VvN1vBSbbngvs87K2Dqecrb39m/CEW6Hudx87ldca1V0s1g9OIWL1Hb8rp
	XqtsZiORqw9v36UrkGYPLCD2LB8nMw/qCn1ZuYkh84wAVpt3/OvI3FxAZvgueZTC
	edSdyrKYYwaWi0hZzR9+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1760759741; x=1760846141; bh=d
	m4H81ZdYiAnyPguz4Bgqq3z9wTH09vJcCXCWxJQJ8Y=; b=vXKD/SafGXwIqQQDF
	TxTQsOsYXAUc1WhnBY7LAanehod+cIAthAHWczatomusNC2a0ptrd/JbCt48N8uU
	l+kDrUxveySkz7p5d+H9MtUfxR7kAlZO7hQtubCa5xWKZ1E4N7O08dLFlSLW/inQ
	0j+8pGxqJ1nArssRHDRs0lxsBVpsDKjf71joWWVlRWB8B8EAszcI0sNTCOyFhbaS
	vkULi5F/KnSZ3yV+GjbhM9CAflO9avugusf6D4iXaG136q6m1uaGqID3nwnpgbZc
	sQ1DGCdLC13ncRvAF7qx4iucmHS68gdIxMz37cKfbqxVD0ntHN4lSVOUeh3cn2tW
	xwamg==
X-ME-Sender: <xms:vQ_zaFWmLUJjeLmb49thVloP28bp-xaDcP64tpB8O34ng6k-lLwRIw>
    <xme:vQ_zaFuxzUcprYJwKASP3vp3bkSLHZKkD92e7RwmB_UsWMV1mno_vVve-7qy2xYCR
    dEspVxXlBIUSQoZNoS_j6P1EfsyYfucWz7nSMfziB2n9k6Bst7DX94>
X-ME-Received: <xmr:vQ_zaJVPozdTOAyjXkvp9HvfeF3IBaglWryWRRLp0HKrFBj6VJHosk4-4_1fZUxx-KahtU0TpCD_RoEckjPyG_IyzZ15FJLbuI4apxNTGbBetA>
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
X-ME-Proxy: <xmx:vQ_zaAmBk2ArH3ksVWMGGJur7gSoSKk-PAu6dapu3Rpb7_JE5p8LBQ>
    <xmx:vQ_zaKYU8tS1WLAQ1J-IOyLe-2wJuSyp-RjuoAkERXZlF4eihyzMVw>
    <xmx:vQ_zaLP8x_8ewuMxy6a6E9wXe57yuJWsQZLMLGGW1Xanq80FOba4CA>
    <xmx:vQ_zaPafdHGI75E7B62ogdVZpSCzlNzqLeT7cSPC8zhvXlkzk7W60A>
    <xmx:vQ_zaBLipWL0OwlR-GsdxtPIDJQwdJX8w36WMAfO5nSywGZFYWTJpK96>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Oct 2025 23:55:40 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org
Subject: [PATCH 3/4] firewire: core: handle device quirk of TASCAM FW-1884/FW-1804/FW-1082
Date: Sat, 18 Oct 2025 12:55:31 +0900
Message-ID: <20251018035532.287124-4-o-takashi@sakamocchi.jp>
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

TASCAM FW-1884/FW-1804/FW-1082 is too lazy to repspond to asynchronous
request at S400. The asynchronous transaction often results in timeout.
This is a problematic quirk.

This commit adds support for the quirk. When identifying the new quirk
flag, then the transaction speed is configured at S200.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-device.c | 18 +++++++++++++++++-
 include/linux/firewire.h       |  3 +++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/firewire/core-device.c b/drivers/firewire/core-device.c
index 6a5740ed4934..1674de477852 100644
--- a/drivers/firewire/core-device.c
+++ b/drivers/firewire/core-device.c
@@ -571,6 +571,14 @@ static const struct entry_match motu_audio_express_matches[] = {
 	{ 8, 0x17104800 },
 };
 
+static const struct entry_match tascam_fw_series_matches[] = {
+	{ 1, 0x0300022e },
+	{ 3, 0x8d000006 },
+	{ 4, 0xd1000001 },
+	{ 6, 0x1200022e },
+	{ 8, 0xd4000004 },
+};
+
 static int detect_quirks_by_root_directory(const u32 *root_directory, unsigned int length)
 {
 	static const struct {
@@ -583,6 +591,11 @@ static int detect_quirks_by_root_directory(const u32 *root_directory, unsigned i
 			.matches = motu_audio_express_matches,
 			.match_count = ARRAY_SIZE(motu_audio_express_matches),
 		},
+		{
+			.quirk = FW_DEVICE_QUIRK_UNSTABLE_AT_S400,
+			.matches = tascam_fw_series_matches,
+			.match_count = ARRAY_SIZE(tascam_fw_series_matches),
+		},
 	};
 	int quirks = 0;
 	int i;
@@ -761,7 +774,10 @@ static int read_config_rom(struct fw_device *device, int generation)
 	// Just prevent from torn writing/reading.
 	WRITE_ONCE(device->quirks, quirks);
 
-	speed = device->node->max_speed;
+	if (unlikely(quirks & FW_DEVICE_QUIRK_UNSTABLE_AT_S400))
+		speed = SCODE_200;
+	else
+		speed = device->node->max_speed;
 
 	// Determine the speed of
 	//   - devices with link speed less than PHY speed,
diff --git a/include/linux/firewire.h b/include/linux/firewire.h
index f1d8734c0ec6..6143b7d28eac 100644
--- a/include/linux/firewire.h
+++ b/include/linux/firewire.h
@@ -179,6 +179,9 @@ enum fw_device_quirk {
 
 	// MOTU Audio Express transfers acknowledge packet with 0x10 for pending state.
 	FW_DEVICE_QUIRK_ACK_PACKET_WITH_INVALID_PENDING_CODE = BIT(2),
+
+	// TASCAM FW-1082/FW-1804/FW-1884 often freezes when receiving S400 packets.
+	FW_DEVICE_QUIRK_UNSTABLE_AT_S400 = BIT(3),
 };
 
 enum fw_device_state {
-- 
2.51.0


