Return-Path: <linux-kernel+bounces-816030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79566B56E5C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 04:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C4001899E35
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 02:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FAC8223DFF;
	Mon, 15 Sep 2025 02:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="AMh4AcP+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eFhvMD8/"
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A279191F91
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 02:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757904161; cv=none; b=LbI2SI/BHy8QVYBzTUjsdz8Xw4SdZj0VfgKnmLl2P7zoPmB6uq48XN/v9AwoXkxNlnK1J5O02fAeKZ7kvBmMz08aoJDJ+FeJFPAH5+Arfl4t0ip8BynBiX26RG8997Aq1tK19VUjY4FcUbFtR8Y3SDuAZaSllqV9c5C9VKrKOVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757904161; c=relaxed/simple;
	bh=OBZsxDOpeHEmkoUPIjRPN2Gl3zXhaEaBM5SX94I1a+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CKubUDKkz5xbKX8LYCCC6S/yXDOwk9jd2wG4BPWh8lM2eQBf1oy6i35FIQ6r0qbZwt+LOTfxUsV4VG+C2fR61d8qyJkDc2FIBeLt//u0KHEr3PyB2ZrzyKVTbZKi+WRXeT7h70OWuB8VxUYDcgV9y5kD6vzCFCt9IBMz439RS/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=AMh4AcP+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eFhvMD8/; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 33DD01D0006D;
	Sun, 14 Sep 2025 22:42:38 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Sun, 14 Sep 2025 22:42:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1757904158; x=
	1757990558; bh=PG6YnBZyw4rk9Rj3FF0nqQIWnEBCq/ECXui2hyE59tU=; b=A
	Mh4AcP+lxgU070Fm7dDIvQQSjni/RyqQ6tPmltM4vl3BppTgP3cOKp3A29L3+dMV
	KCvYsh9TdUPwgcDZT7JSV+TJzkRYjgMWlranJJ94LeQ6DxYGZw3gmOXczcW54NI6
	o6cnzXwaKj9GkGB1FQ/zTeg5TYMo6fLgN5255UU0/eTmATauWxKVQSirPk9yMZpp
	eArt02Y5sh/8IvuVrM3lDuIlZ3xjWyiJGeBjNw+UrHZgt2pR4DtGZ/evAEa3EB1E
	ENtM9fOga6lCqlViHhkSRqFRHn1Y+LCr9hc+GWVMb9ucs1iFGGq/o53ACjhd7o+f
	n2y7qjV4zkIiT/QGxR0FA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1757904158; x=1757990558; bh=P
	G6YnBZyw4rk9Rj3FF0nqQIWnEBCq/ECXui2hyE59tU=; b=eFhvMD8/cDdnlNQfw
	cRPOmHbvkHHoc7dPF/DfSWdb0CqJZUPUSMblRKdp/v6oWhW7TbJxVGQgB1+xpCmv
	ugnG0KN2h72q84qWVWgE9DlpVpCjw+6IBIEYB/YNxC6SVT1Cd6hen2i2ZyALyVe/
	jtl3l8mrdVKmLNlyR8C4eaL4gg5lZVApHDZPVLO+HNg22L/ZK2L8lzj+rvXPluDz
	Xo3Jy/vEtuR9cbi0XUM0KeFSwkh2u5TbS2QbTrRg26sKyeuNr1J0u/lbE0RrkX4p
	OeemhCU85wNzTuncJcbxZ5P+Pmq4QXA2ixzzxN1FFxxa7KQKA5vecoP4yLX7mwzF
	7xOMA==
X-ME-Sender: <xms:HX3HaHFPzJutFX7rqaPUjxNe39I7I1L6p7vxaBI2Q0nx75Hh7aPvQQ>
    <xme:HX3HaNTWTwmWcxfzwY-pwE41_cO6gc23mrF1M-1U-0dTkBkqC_v5D7keY2ITRu9fw
    fo9g9lh5AaVdlrzuAE>
X-ME-Received: <xmr:HX3HaLHbCDMkwJ38jSmf1WxNTET0I51DnT47kT6VAI2SFAAzPWBEiwX2xgAw8awQUg7vu_ycCy26njLH4bnt5XPsp0qf7eO_njoSvnheSr1EPc8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefieehvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhh
    ihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepvdejgfejuedvgf
    duudekleevtefgtdevhfdtffefiefgveeuteffiedvffekvddtnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkh
    grmhhotggthhhirdhjphdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtoheplhhinhhugidufeelgedquggvvhgvlheslhhishhtshdrshhouhhrtg
    gvfhhorhhgvgdrnhgvthdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghr
    rdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:HX3HaB9D55C-mVxlNjrSmVu5Wolnu6m9u6XplZCWhMBUYpGHNeuQaQ>
    <xmx:HX3HaNJlK-0b3ibN9s7K03Ntp6ls17W3qF6Oz0q1WsimZ9oPQeVDsQ>
    <xmx:HX3HaMYOCyfk2-hE_mqMpwRcsJjGWpojQkUg8EJ7sMDPFxG-F7O1Og>
    <xmx:HX3HaPKxTcplk-91DiD2jsM6bG-XYkvOsIqyi8HKzqjBKSPi5f3g9w>
    <xmx:Hn3HaOpkAh3fdMhIC_sZJrE8w1uhMj89RkZQgZU1WhS2Bu01iLBckkgz>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 14 Sep 2025 22:42:36 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] firewire: core: use helper macros instead of direct access to HZ
Date: Mon, 15 Sep 2025 11:42:31 +0900
Message-ID: <20250915024232.851955-2-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250915024232.851955-1-o-takashi@sakamocchi.jp>
References: <20250915024232.851955-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are some macros available to convert usecs, msecs, and secs into
jiffies count.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-card.c        | 17 +++++++----------
 drivers/firewire/core-cdev.c        |  4 ++--
 drivers/firewire/core-device.c      |  6 +++---
 drivers/firewire/core-transaction.c |  4 ++--
 drivers/firewire/core.h             |  2 ++
 5 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/firewire/core-card.c b/drivers/firewire/core-card.c
index adb90161c4c6..2541e8bb4b75 100644
--- a/drivers/firewire/core-card.c
+++ b/drivers/firewire/core-card.c
@@ -229,8 +229,7 @@ void fw_schedule_bus_reset(struct fw_card *card, bool delayed, bool short_reset)
 
 	/* Use an arbitrary short delay to combine multiple reset requests. */
 	fw_card_get(card);
-	if (!queue_delayed_work(fw_workqueue, &card->br_work,
-				delayed ? DIV_ROUND_UP(HZ, 100) : 0))
+	if (!queue_delayed_work(fw_workqueue, &card->br_work, delayed ? msecs_to_jiffies(10) : 0))
 		fw_card_put(card);
 }
 EXPORT_SYMBOL(fw_schedule_bus_reset);
@@ -241,10 +240,10 @@ static void br_work(struct work_struct *work)
 
 	/* Delay for 2s after last reset per IEEE 1394 clause 8.2.1. */
 	if (card->reset_jiffies != 0 &&
-	    time_before64(get_jiffies_64(), card->reset_jiffies + 2 * HZ)) {
+	    time_before64(get_jiffies_64(), card->reset_jiffies + secs_to_jiffies(2))) {
 		trace_bus_reset_postpone(card->index, card->generation, card->br_short);
 
-		if (!queue_delayed_work(fw_workqueue, &card->br_work, 2 * HZ))
+		if (!queue_delayed_work(fw_workqueue, &card->br_work, secs_to_jiffies(2)))
 			fw_card_put(card);
 		return;
 	}
@@ -309,8 +308,7 @@ static void bm_work(struct work_struct *work)
 	irm_id   = card->irm_node->node_id;
 	local_id = card->local_node->node_id;
 
-	grace = time_after64(get_jiffies_64(),
-			     card->reset_jiffies + DIV_ROUND_UP(HZ, 8));
+	grace = time_after64(get_jiffies_64(), card->reset_jiffies + msecs_to_jiffies(125));
 
 	if ((is_next_generation(generation, card->bm_generation) &&
 	     !card->bm_abdicate) ||
@@ -396,7 +394,7 @@ static void bm_work(struct work_struct *work)
 			 * that the problem has gone away by then.
 			 */
 			spin_unlock_irq(&card->lock);
-			fw_schedule_bm_work(card, DIV_ROUND_UP(HZ, 8));
+			fw_schedule_bm_work(card, msecs_to_jiffies(125));
 			return;
 		}
 
@@ -418,7 +416,7 @@ static void bm_work(struct work_struct *work)
 		 * bus reset is less than 125ms ago.  Reschedule this job.
 		 */
 		spin_unlock_irq(&card->lock);
-		fw_schedule_bm_work(card, DIV_ROUND_UP(HZ, 8));
+		fw_schedule_bm_work(card, msecs_to_jiffies(125));
 		return;
 	}
 
@@ -551,8 +549,7 @@ void fw_card_initialize(struct fw_card *card,
 	card->split_timeout_hi = DEFAULT_SPLIT_TIMEOUT / 8000;
 	card->split_timeout_lo = (DEFAULT_SPLIT_TIMEOUT % 8000) << 19;
 	card->split_timeout_cycles = DEFAULT_SPLIT_TIMEOUT;
-	card->split_timeout_jiffies =
-			DIV_ROUND_UP(DEFAULT_SPLIT_TIMEOUT * HZ, 8000);
+	card->split_timeout_jiffies = isoc_cycles_to_jiffies(DEFAULT_SPLIT_TIMEOUT);
 	card->color = 0;
 	card->broadcast_channel = BROADCAST_CHANNEL_INITIAL;
 
diff --git a/drivers/firewire/core-cdev.c b/drivers/firewire/core-cdev.c
index 78b10c6ef7fe..9e90c79becdb 100644
--- a/drivers/firewire/core-cdev.c
+++ b/drivers/firewire/core-cdev.c
@@ -1324,8 +1324,8 @@ static void iso_resource_work(struct work_struct *work)
 		todo = r->todo;
 		// Allow 1000ms grace period for other reallocations.
 		if (todo == ISO_RES_ALLOC &&
-		    time_before64(get_jiffies_64(), client->device->card->reset_jiffies + HZ)) {
-			schedule_iso_resource(r, DIV_ROUND_UP(HZ, 3));
+		    time_before64(get_jiffies_64(), client->device->card->reset_jiffies + secs_to_jiffies(1))) {
+			schedule_iso_resource(r, msecs_to_jiffies(333));
 			skip = true;
 		} else {
 			// We could be called twice within the same generation.
diff --git a/drivers/firewire/core-device.c b/drivers/firewire/core-device.c
index 6a04a0014694..7d5821cd9b37 100644
--- a/drivers/firewire/core-device.c
+++ b/drivers/firewire/core-device.c
@@ -847,9 +847,9 @@ static void fw_schedule_device_work(struct fw_device *device,
  */
 
 #define MAX_RETRIES	10
-#define RETRY_DELAY	(3 * HZ)
-#define INITIAL_DELAY	(HZ / 2)
-#define SHUTDOWN_DELAY	(2 * HZ)
+#define RETRY_DELAY	secs_to_jiffies(3)
+#define INITIAL_DELAY	msecs_to_jiffies(500)
+#define SHUTDOWN_DELAY	secs_to_jiffies(2)
 
 static void fw_device_shutdown(struct work_struct *work)
 {
diff --git a/drivers/firewire/core-transaction.c b/drivers/firewire/core-transaction.c
index 1d1c2d8f85ae..623e1d9bd107 100644
--- a/drivers/firewire/core-transaction.c
+++ b/drivers/firewire/core-transaction.c
@@ -458,7 +458,7 @@ static struct fw_packet phy_config_packet = {
 void fw_send_phy_config(struct fw_card *card,
 			int node_id, int generation, int gap_count)
 {
-	long timeout = DIV_ROUND_UP(HZ, 10);
+	long timeout = msecs_to_jiffies(100);
 	u32 data = 0;
 
 	phy_packet_set_packet_identifier(&data, PHY_PACKET_PACKET_IDENTIFIER_PHY_CONFIG);
@@ -1220,7 +1220,7 @@ static void update_split_timeout(struct fw_card *card)
 	cycles = clamp(cycles, 800u, 3u * 8000u);
 
 	card->split_timeout_cycles = cycles;
-	card->split_timeout_jiffies = DIV_ROUND_UP(cycles * HZ, 8000);
+	card->split_timeout_jiffies = isoc_cycles_to_jiffies(cycles);
 }
 
 static void handle_registers(struct fw_card *card, struct fw_request *request,
diff --git a/drivers/firewire/core.h b/drivers/firewire/core.h
index 9e68ebf0673d..7f2ca93406ce 100644
--- a/drivers/firewire/core.h
+++ b/drivers/firewire/core.h
@@ -30,6 +30,8 @@ struct fw_packet;
 // This is the arbitrary value we use to indicate a mismatched gap count.
 #define GAP_COUNT_MISMATCHED	0
 
+#define isoc_cycles_to_jiffies(cycles)	usecs_to_jiffies(cycles * USEC_PER_SEC / 8000)
+
 extern __printf(2, 3)
 void fw_err(const struct fw_card *card, const char *fmt, ...);
 extern __printf(2, 3)
-- 
2.48.1


