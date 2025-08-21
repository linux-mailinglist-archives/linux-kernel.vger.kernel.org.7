Return-Path: <linux-kernel+bounces-778725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18060B2E96F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 02:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2D171C8788B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 00:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33E81D5ADE;
	Thu, 21 Aug 2025 00:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="q2D3eIPI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Kchenfq+"
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990BB48CFC
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 00:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755736227; cv=none; b=KJvRleIb1LpzwcRBOzPczGUzfXKlJop8BANzEF+JSyIVJcJkD4rSK7HixUsrWVf3oiJw1jWpRCtmc/Drb86p9XIY33HYU/P04ROAyiPk7pPjNTk3dZ3pmp5bKhT+R8YqgYgwMs/oSsF2EF2Z6VeSNjSRo8x6TGprS4M2FA3QX+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755736227; c=relaxed/simple;
	bh=Jjb+/I/riqTI++d23gGdifrki43WM2j+z0kj5MRMPgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K70lRwtxVieOpkhRH7U7y+7LObIX8gVJnikcyBGQfYmiZSQrV0v9RWGWr23NRDdgNA7OQT4ZWZdWcxZDEJCVbV/zGpeq615E4D0zvrBiKX86NJqgEum0bs7HVgMox/azIUef7QWPDi/EHg6hJ8HjdywH2yH6tK9aZD9gjoI/B/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=q2D3eIPI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Kchenfq+; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C451F14000B7;
	Wed, 20 Aug 2025 20:30:24 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 20 Aug 2025 20:30:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1755736224; x=
	1755822624; bh=MJhbiDHxyLrwI3F474o+zyXCEkS3G232mRdv3WRIJMk=; b=q
	2D3eIPIvlLHx34rzFZKsBk5A09NOgI4vF6vgLTE4jcb7fI0cGLtNprkNdpZomdtR
	oN+RXbaOFecv6Cg/cIf9ZU3EEQtRtRAVum/7YHCN+qJFvI24CYwJTx7rExcARzx+
	9HNr+2IJ8/SB/C5RvpUXoKwsppwfa508Z1KDek2nxv4eDZ6oqhaUIVA43xfleTJp
	zLyI+N+uwK0azfg0M0lJRM7T/15+515jRV+SLmzsScNI/0nAPBNUqP9N00NqSTe6
	yfxDYWRlqm7QXlQOUuLkHF9hW6aaPUNx+duMtzZ49A5aAqWfowWkOitfOAY+OFif
	BaWT5OvNd3FQwNbqnAlyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1755736224; x=1755822624; bh=M
	JhbiDHxyLrwI3F474o+zyXCEkS3G232mRdv3WRIJMk=; b=Kchenfq+JPrn/393P
	Ee/3nP1BrOjKwIO3BU1bf0gr+ZajN2gWjQuhk4n8KhZYeFeSmJ9bRHt/WgnZSSYr
	lDA48v79T3TCPUYC0iGUAmnY/SaNkdv8PV4MAqUF7FXJ88Ff8lxhbpALyYT2wFx7
	LDyaK72WUbuENW65geuvBkr7Xx3c4K4esUWQK1a9rvIUS0UVLUNsioZH522AMEAm
	YPoVnCuvbo5kOU+NMdqU0nVvIsG43KH/E7eYxfSPCIUYQlk96f5l4wYkS57lcnyW
	Q3v70DqK9ag3022nX6mCjVswoPNZFPbZYKkIM2uG9XzgwmWebZ2LorHh5E8tUGaI
	MmTAw==
X-ME-Sender: <xms:oGimaFZn_g0_DBle3zmRLdWlHI1GMr5pnneKSNqYLQ7ol8tzNgUwdw>
    <xme:oGimaFXBN0dt0B-9DzBsM0pBwK7ytt29ku1qNIa2JcOoKNDMudItjygQOYeZ3MNFa
    CIxBt6nTvAw7ijmQ2g>
X-ME-Received: <xmr:oGimaJ6aY_hZBsfEPxNF94B7IC_BubwM_tz_h-AxUD_ZsxyQ1HRtKGlK2xJP5lHx3uvJW_tN_9QaQU4YNErsS4m-huOSFi8cWXgclw4aAN0KyQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheelkeduucetufdoteggodetrf
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
X-ME-Proxy: <xmx:oGimaAh8j6h7b0UH2Ruf13cw3L-V_IVXwiILqG_M1ns8-KFZy-L61g>
    <xmx:oGimaAf3uKftMQfZjRX9HOwRcYdrjuFzDibpvuGtFkGm58Mn-LUtdw>
    <xmx:oGimaFeAo5gykirQLllbkCOjUV1fptcASjTVaHWKUNGDZfCgBn3CHQ>
    <xmx:oGimaK9S6o0-lkK5RuiGxY3uSdBw-O0D2cIC2Y8EZYr2IOw14ofzPw>
    <xmx:oGimaLcxQtUSn2WQQM9Np0kNrYzI42e3TFMN5sfbyftztfBsI_akNonN>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Aug 2025 20:30:23 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] firewire: ohci: remove obsolete debug logging for selfID sequence
Date: Thu, 21 Aug 2025 09:30:15 +0900
Message-ID: <20250821003017.186752-3-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250821003017.186752-1-o-takashi@sakamocchi.jp>
References: <20250821003017.186752-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A commit 677ceae19073 ("firewire: core: add tracepoints event for
self_id_sequence") added the "firewire:self_id_sequence" event in v6.11.
A commit 526e21a2aa6f ("firewire: ohci: add tracepoints event for data
of Self-ID DMA") added the "firewire_ohci:self_id_complete" event in
v6.12.

These tracepoints replace the equivalent debug logging. This commit
removes the logging.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/ohci.c | 72 -----------------------------------------
 1 file changed, 72 deletions(-)

diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index d3ed43f4d0c3..8cecdf4c6572 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -394,87 +394,17 @@ MODULE_PARM_DESC(quirks, "Chip quirks (default = 0"
 	")");
 
 #define OHCI_PARAM_DEBUG_AT_AR		1
-#define OHCI_PARAM_DEBUG_SELFIDS	2
 
 static int param_debug;
 module_param_named(debug, param_debug, int, 0644);
 MODULE_PARM_DESC(debug, "Verbose logging, deprecated in v6.11 kernel or later. (default = 0"
 	", AT/AR events = "	__stringify(OHCI_PARAM_DEBUG_AT_AR)
-	", self-IDs = "		__stringify(OHCI_PARAM_DEBUG_SELFIDS)
 	", or a combination, or all = -1)");
 
 static bool param_remote_dma;
 module_param_named(remote_dma, param_remote_dma, bool, 0444);
 MODULE_PARM_DESC(remote_dma, "Enable unfiltered remote DMA (default = N)");
 
-static void log_selfids(struct fw_ohci *ohci, int generation, int self_id_count)
-{
-	static const char *const speed[] = {
-		[0] = "S100", [1] = "S200", [2] = "S400",    [3] = "beta",
-	};
-	static const char *const power[] = {
-		[0] = "+0W",  [1] = "+15W", [2] = "+30W",    [3] = "+45W",
-		[4] = "-3W",  [5] = " ?W",  [6] = "-3..-6W", [7] = "-3..-10W",
-	};
-	static const char port[] = {
-		[PHY_PACKET_SELF_ID_PORT_STATUS_NONE] = '.',
-		[PHY_PACKET_SELF_ID_PORT_STATUS_NCONN] = '-',
-		[PHY_PACKET_SELF_ID_PORT_STATUS_PARENT] = 'p',
-		[PHY_PACKET_SELF_ID_PORT_STATUS_CHILD] = 'c',
-	};
-	struct self_id_sequence_enumerator enumerator = {
-		.cursor = ohci->self_id_buffer,
-		.quadlet_count = self_id_count,
-	};
-
-	if (likely(!(param_debug & OHCI_PARAM_DEBUG_SELFIDS)))
-		return;
-
-	ohci_notice(ohci, "%d selfIDs, generation %d, local node ID %04x\n",
-		    self_id_count, generation, ohci->node_id);
-
-	while (enumerator.quadlet_count > 0) {
-		unsigned int quadlet_count;
-		unsigned int port_index;
-		const u32 *s;
-		int i;
-
-		s = self_id_sequence_enumerator_next(&enumerator, &quadlet_count);
-		if (IS_ERR(s))
-			break;
-
-		ohci_notice(ohci,
-		    "selfID 0: %08x, phy %d [%c%c%c] %s gc=%d %s %s%s%s\n",
-		    *s,
-		    phy_packet_self_id_get_phy_id(*s),
-		    port[self_id_sequence_get_port_status(s, quadlet_count, 0)],
-		    port[self_id_sequence_get_port_status(s, quadlet_count, 1)],
-		    port[self_id_sequence_get_port_status(s, quadlet_count, 2)],
-		    speed[*s >> 14 & 3], *s >> 16 & 63,
-		    power[*s >> 8 & 7], *s >> 22 & 1 ? "L" : "",
-		    *s >> 11 & 1 ? "c" : "", *s & 2 ? "i" : "");
-
-		port_index = 3;
-		for (i = 1; i < quadlet_count; ++i) {
-			ohci_notice(ohci,
-			    "selfID n: %08x, phy %d [%c%c%c%c%c%c%c%c]\n",
-			    s[i],
-			    phy_packet_self_id_get_phy_id(s[i]),
-			    port[self_id_sequence_get_port_status(s, quadlet_count, port_index)],
-			    port[self_id_sequence_get_port_status(s, quadlet_count, port_index + 1)],
-			    port[self_id_sequence_get_port_status(s, quadlet_count, port_index + 2)],
-			    port[self_id_sequence_get_port_status(s, quadlet_count, port_index + 3)],
-			    port[self_id_sequence_get_port_status(s, quadlet_count, port_index + 4)],
-			    port[self_id_sequence_get_port_status(s, quadlet_count, port_index + 5)],
-			    port[self_id_sequence_get_port_status(s, quadlet_count, port_index + 6)],
-			    port[self_id_sequence_get_port_status(s, quadlet_count, port_index + 7)]
-			);
-
-			port_index += 8;
-		}
-	}
-}
-
 static const char *evts[] = {
 	[0x00] = "evt_no_status",	[0x01] = "-reserved-",
 	[0x02] = "evt_long_packet",	[0x03] = "evt_missing_ack",
@@ -2163,8 +2093,6 @@ static void bus_reset_work(struct work_struct *work)
 	if (free_rom)
 		dmam_free_coherent(ohci->card.device, CONFIG_ROM_SIZE, free_rom, free_rom_bus);
 
-	log_selfids(ohci, generation, self_id_count);
-
 	fw_core_handle_bus_reset(&ohci->card, ohci->node_id, generation,
 				 self_id_count, ohci->self_id_buffer,
 				 ohci->csr_state_setclear_abdicate);
-- 
2.48.1


