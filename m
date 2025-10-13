Return-Path: <linux-kernel+bounces-850627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B54BD354B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8FAAA4F26B5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5DF26FD84;
	Mon, 13 Oct 2025 14:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="c1JrtJKd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ruIN39Fm"
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7C1255F5E
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760364201; cv=none; b=tBJkeE0HnBVEa8XjYJyeZNTqBXJm7mm6R+Y3qFZeYw27pt37P57xbsmZIZaqnnDqyig6TSW8cP2QClzmkps8Z2YqsT4CA4HY3gj79Wc3eqXuHEl6LEIK7kVdWNPcV6KUiOiN53Ot3LAqBdAXI4eFRmxQBlrZhi1DmNvXQPSOdHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760364201; c=relaxed/simple;
	bh=aTuDQJOc9QyDWw7NeVePyqs/4KWPG9WwxbPFBpmsEgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gsKu+JKjyvQyiVqF136HtZhC9cZpfXWQOwr9PXHZtTBYZsoQm75C9TE1GK3go95MRU+Jfxuj1XFyFVpNbOeIZG4fglpJL9Oqr2IqylGypOn/bWsyjRECKSVH8Z2HItA/WqhhJvvZEFsYBaXcb5p/rB50dW0laH/0ZrC0n0aemt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=c1JrtJKd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ruIN39Fm; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id B4E341D00188;
	Mon, 13 Oct 2025 10:03:18 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 13 Oct 2025 10:03:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1760364198; x=
	1760450598; bh=ju0TXwkvur7Pc8DU4WdaqDLH7X5oT5Eo8QJC4dqaWb4=; b=c
	1JrtJKdnXQfxlqtEAInguBEN0kIlB+MFkFPvFIm6GNUqeXiVb6ZRt7uWy4029yx3
	AVGhnkiovIaahOPaFt7ckFdIgwrcZvzYPMDknT1Es+TZkfT6ffKnztms/PJnIhBL
	uI2Renv6an7qno1Y6EQtNbWDEe04YEL8P2ASuvdT3XHLeUsLK3a6hNCFnpB43E77
	RDzPU9gZ52MPpznF1Eb6TxFy3kULDMg1GO466buC5TnlE84LIIWVbrBgYZqahHKO
	Rek3KYhmgmAvQvkUOMSZ47ws6/bUeU2AmMVPaTbqZESFhBo86m37o0EIetgFhRpd
	4iC7fep53HkaAexDEbinw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1760364198; x=1760450598; bh=j
	u0TXwkvur7Pc8DU4WdaqDLH7X5oT5Eo8QJC4dqaWb4=; b=ruIN39FmjGCMhtRJV
	ARr8ow+pwdnOlbw1WWTXQYyi1+1OBKlwlP8IB4kf8uCksYF1dB8QCMyIkSIOXS91
	Xykefta5lDZ01ousXCBndsAFLE1kBaA3+vkDupdRarCkm8M5YxULh56EFoI9CpwB
	ZZLf86z0mPwKozwSHnOnQe3Aymwjkh1vSycMDs2A0xbJ63UyZdoQ3ZVzJpJF0SnN
	7Rcclx1qVvc7RxhKHTuyd9Hxb2JbuOj43q+fuCGE3TEUlRpZHsFH3b/nLCyvFvDY
	7WSdnbZVEsuluX0wXy7m4ZYwzdZGVpW36Fszew/fBhYIWmYLXxdPJ4IhAjXE7R/F
	/7kyQ==
X-ME-Sender: <xms:pgbtaBB498kyOEGyGbYbmYLTnvytO1tNxuz-5mr-CnsRv2MdinNyzQ>
    <xme:pgbtaNfH1gqDQLfcwUBvKNkGsSgZXGwQyoG4Msc55ZfqNM0_LgLvMlSlGufPY3fbe
    6pR50KDEoRrAL4EuOc-xYhdreuM-bNQJaDU63dBgUeBf_HnuiIoQBY>
X-ME-Received: <xmr:pgbtaEK--Cqq1S7z2Uw58E8etIXUiWoNZ1L_KvHV8Z9BAM68IKIniVdzfnG7tYZ4YCA6Y9gNqXWOXhE7z3YYTdl5PRspw7OwSdsxbqml0UzC5g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudejkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghs
    hhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgjeeuvd
    fguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhisehsrg
    hkrghmohgttghhihdrjhhppdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehlihhnuhigudefleegqdguvghvvghlsehlihhsthhsrdhsohhurh
    gtvghfohhrghgvrdhnvghtpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:pgbtaIc5SAWxQsL6BkD7wXdeP0a5k8PwYAcQksLhRXH_OuC4eG-etg>
    <xmx:pgbtaD17eBkGQ_xqWra-0qb9bphQODz0B7ZaJc0_zFmPJHP0zRSC1g>
    <xmx:pgbtaJg-E0t2d7po3yoHhO3af8f6Q1cmbLnugk42yF3p8RLYPmhHpQ>
    <xmx:pgbtaBQ_DPp2FknKOVTKk1PjfJ__xviqKNmutbninVxq0rbIGD7upQ>
    <xmx:pgbtaC1dE5IcjWh7S0i621g3dKx204tCLPNgG7L0zwWbzYE8a91QduHP>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Oct 2025 10:03:17 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] firewire: core: handle device quirk of MOTU Audio Express
Date: Mon, 13 Oct 2025 23:03:11 +0900
Message-ID: <20251013140311.97159-3-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013140311.97159-1-o-takashi@sakamocchi.jp>
References: <20251013140311.97159-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A commit 3a93d082bacf ("ALSA: firewire-motu: add support for MOTU Audio
Express") describes a quirk of MOTU Audio Express. The device returns
acknowledge packet with 0x10 as the pending state of any types of
asynchronous request transaction. It is completely out of specification.

This commit implements handling for that device-specific quirk. The quirk
is detected after reading the root directory of configuration ROM. When
processing the acknowledge code in 1394 OHCI AT context event handler,
firewire-ohci module seeks the device instance of destination node by
traversing device hierarchy. If the device has the quirk, the acknowledge
code is replaced with the standard code.

The 1394 OHCI AT context events occur for outgoing asynchronous request
packets. The device traversal is safe since no new request initiators
exist after the fw_card_instance has been invalidated.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-device.c | 53 ++++++++++++++++++++++++++++++++++
 drivers/firewire/ohci.c        | 29 +++++++++++++++++++
 include/linux/firewire.h       |  3 ++
 3 files changed, 85 insertions(+)

diff --git a/drivers/firewire/core-device.c b/drivers/firewire/core-device.c
index 9bab2d594b89..33ce4cd357ed 100644
--- a/drivers/firewire/core-device.c
+++ b/drivers/firewire/core-device.c
@@ -557,6 +557,54 @@ static int detect_quirks_by_bus_information_block(const u32 *bus_information_blo
 	return quirks;
 }
 
+struct entry_match {
+	unsigned int index;
+	u32 value;
+};
+
+static const struct entry_match motu_audio_express_matches[] = {
+	{ 1, 0x030001f2 },
+	{ 3, 0xd1000002 },
+	{ 4, 0x8d000005 },
+	{ 6, 0x120001f2 },
+	{ 7, 0x13000033 },
+	{ 8, 0x17104800 },
+};
+
+static int detect_quirks_by_root_directory(const u32 *root_directory, unsigned int length)
+{
+	static const struct {
+		enum fw_device_quirk quirk;
+		const struct entry_match *matches;
+		unsigned int match_count;
+	} *entry, entries[] = {
+		{
+			.quirk = FW_DEVICE_QUIRK_ACK_PACKET_WITH_INVALID_PENDING_CODE,
+			.matches = motu_audio_express_matches,
+			.match_count = ARRAY_SIZE(motu_audio_express_matches),
+		},
+	};
+	int quirks = 0;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(entries); ++i) {
+		int j;
+
+		entry = entries + i;
+		for (j = 0; j < entry->match_count; ++j) {
+			unsigned int index = entry->matches[j].index;
+			unsigned int value = entry->matches[j].value;
+
+			if ((length < index) || (root_directory[index] != value))
+				break;
+		}
+		if (j == entry->match_count)
+			quirks |= entry->quirk;
+	}
+
+	return quirks;
+}
+
 static int read_rom(struct fw_device *device,
 		    int generation, int index, u32 *data)
 {
@@ -737,6 +785,11 @@ static int read_config_rom(struct fw_device *device, int generation)
 			length = i;
 	}
 
+	quirks |= detect_quirks_by_root_directory(rom + ROOT_DIR_OFFSET, length - ROOT_DIR_OFFSET);
+
+	// Just prevent from torn writing/reading.
+	WRITE_ONCE(device->quirks, quirks);
+
 	old_rom = device->config_rom;
 	new_rom = kmemdup(rom, length * 4, GFP_KERNEL);
 	if (new_rom == NULL) {
diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index 030aed5453a1..757dd9c64b1c 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -1319,6 +1319,14 @@ static void at_context_flush(struct at_context *ctx)
 	enable_work(&ctx->work);
 }
 
+static int find_fw_device(struct device *dev, const void *data)
+{
+	struct fw_device *device = fw_device(dev);
+	const u32 *params = data;
+
+	return (device->generation == params[0]) && (device->node_id == params[1]);
+}
+
 static int handle_at_packet(struct context *context,
 			    struct descriptor *d,
 			    struct descriptor *last)
@@ -1390,6 +1398,27 @@ static int handle_at_packet(struct context *context,
 		fallthrough;
 
 	default:
+		if (unlikely(evt == 0x10)) {
+			u32 params[2] = {
+				packet->generation,
+				async_header_get_destination(packet->header),
+			};
+			struct device *dev;
+
+			fw_card_get(&ohci->card);
+			dev = device_find_child(ohci->card.device, (const void *)params, find_fw_device);
+			fw_card_put(&ohci->card);
+			if (dev) {
+				struct fw_device *device = fw_device(dev);
+				int quirks = READ_ONCE(device->quirks);
+
+				put_device(dev);
+				if (quirks & FW_DEVICE_QUIRK_ACK_PACKET_WITH_INVALID_PENDING_CODE) {
+					packet->ack = ACK_PENDING;
+					break;
+				}
+			}
+		}
 		packet->ack = RCODE_SEND_ERROR;
 		break;
 	}
diff --git a/include/linux/firewire.h b/include/linux/firewire.h
index 161829cfcc00..f1d8734c0ec6 100644
--- a/include/linux/firewire.h
+++ b/include/linux/firewire.h
@@ -176,6 +176,9 @@ enum fw_device_quirk {
 
 	// See a509e43ff338 ("firewire: core: fix unstable I/O with Canon camcorder").
 	FW_DEVICE_QUIRK_IRM_IGNORES_BUS_MANAGER = BIT(1),
+
+	// MOTU Audio Express transfers acknowledge packet with 0x10 for pending state.
+	FW_DEVICE_QUIRK_ACK_PACKET_WITH_INVALID_PENDING_CODE = BIT(2),
 };
 
 enum fw_device_state {
-- 
2.51.0


