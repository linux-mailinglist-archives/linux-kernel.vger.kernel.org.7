Return-Path: <linux-kernel+bounces-804927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04DDFB48209
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 03:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBC84161A9B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 01:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA76202C30;
	Mon,  8 Sep 2025 01:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="O1KJoKCL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HpXuwSvs"
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9B71EF363
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 01:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757294485; cv=none; b=Kw514XuX3nOSpfAtu1AvuxZMOtRWDZ5WKeRWNJMFmkPuLo7QGw66AQMnPc9lmTLn0t672/gQ+PmBRaWCDB5FeQNjnZVlRu9pJvVlg/vMh96GMRMWoHeeH/67W4FTFbEa951RkWGorW4FqSjrYmqHDNhh3fCQvhERYUlecO9bbYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757294485; c=relaxed/simple;
	bh=HK13AI7lto+XHviTa3mTQZBaSkUYEU5SGXjshS1kmcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U65X0lz+JgCqEylflbQwRUPvvl5yM9HSs3AqiONt6cxbCx3vtplHjjvvS/yZaR+kALsRB+rI7N48X1mjzppDIoUbuLD3kMDVpCcpwdPNUo+f459+spYAPEsK8Z8WsOcYTcHprEJa1d1pXjxVSXMhz8GNBK07QSzggLd27l/GmLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=O1KJoKCL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HpXuwSvs; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 5C0F3EC008A;
	Sun,  7 Sep 2025 21:21:22 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Sun, 07 Sep 2025 21:21:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1757294482; x=
	1757380882; bh=zb78927kFIsqfW6PLd6meqtF4v0FQTdlwbh5TO1B41c=; b=O
	1KJoKCLxsJg3rI03pQG0AAgff3cTaJQFAS6wWfBd0omYQnr+YleRTvJxGS+QmEAI
	LjjHZTrhIludes7n0a6cU2F5WdB+5GRpyAH/EPwqh8DMYrgSEXqcL6zVu99UfYi4
	9ILvbLQBzRkZVQMZZ4apKjVDFB+/pyEogoQSky0ikGFcfRWrbL2A1LW/HDPoSobD
	VAlIyZRcGgk8E5/5bloSQyj1LjAhNH1PApc810VCe8qXWYPlfdCf96rRNqEqTB8W
	G3SpNYfNyMnJp4lC7goWgxIKis738Ggn6maSGrTDojdjhdi3N58yBcJ465KlJdS2
	68cyZ+499nEa9kvs2Rsow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1757294482; x=1757380882; bh=z
	b78927kFIsqfW6PLd6meqtF4v0FQTdlwbh5TO1B41c=; b=HpXuwSvsmPf8nW2E+
	MDTBuhbhaHACVJBJS3ZiMliilPqBYGnylGFOyqMTKh0YN5cgYhUKr8Wuy7r+J/Vj
	T5VL4xTk1O1TzhseOIppyV8BdhoEJ2iwWe0u63HRn0c1d6sKT/HRfpq1u1e3Qlsw
	JtKdkSJbnqw40rIWMD9jk8++yvF+Gnw8OJTBjTSqP3ne43511xeemiwsEHWgqhd1
	k/yx9e0tQEcYuam9+n6qwEjEi0rrCJX+/Xi1VD0s3y5XKpIAdT7kWnUzAcLFo9IA
	sGl081Ga1UH70rweLJBlTwmEHL9jMkk5m0dgF+ba56wZlm3oQVPA5+VAg1UK3GCB
	azB7g==
X-ME-Sender: <xms:ki--aN8eKzzfbRE20f6huzqfsMJHALV48qjfYn6gd2LPodbwx0gGrA>
    <xme:ki--aKr8ch0EpJHUHCBnJk0XIAe9PDpxov7GTvE7z6RQrz9AzU3NA3PwrN9N48ZMB
    c6rWHniITAP4l3ugRc>
X-ME-Received: <xmr:ki--aM87Rs8RzfZnii9XDoFWzDh7_8t70bWpJtw907sI1kGKVa68_APhEU9G2OaeUq0AyhEuVHix3S6ZKq1FO0vqIC3c3FDbxIOjpjKalD4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduiedulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhh
    ihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepvdejgfejuedvgf
    duudekleevtefgtdevhfdtffefiefgveeuteffiedvffekvddtnecuvehluhhsthgvrhfu
    ihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkh
    grmhhotggthhhirdhjphdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtoheplhhinhhugidufeelgedquggvvhgvlheslhhishhtshdrshhouhhrtg
    gvfhhorhhgvgdrnhgvthdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghr
    rdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ki--aOUjDNu4GX4XUNU-C1hfUEREdBabth_y5lqw2j-45RoDr1TUww>
    <xmx:ki--aCD-WIuZaKA93VVrBLTOSK67p4QOoeCesjvHFS8EctyYgQcg0w>
    <xmx:ki--aPz7MoPGZ9mLi_Xb9gD9uPg1b2SeLvCqCONuHhcIQkPdNsjPIg>
    <xmx:ki--aPA1NGgJvG6Xsix_oK0HupBY8CIgkUg4qZRXy0zVChCesrpmXg>
    <xmx:ki--aEieGe9hfLNUIR_78YEjvdDz0gjrGpr8pVNZVZ9wPwiqgzTjXb0u>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 7 Sep 2025 21:21:21 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 06/11] firewire: ohci: localize transaction data and rcode per condition branch
Date: Mon,  8 Sep 2025 10:21:03 +0900
Message-ID: <20250908012108.514698-7-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250908012108.514698-1-o-takashi@sakamocchi.jp>
References: <20250908012108.514698-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function local variable, transaction_data, in bm_work function is
conditionally used. In the case, the branch-level variable is sometimes
useful.

This commit uses this idea.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-card.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/firewire/core-card.c b/drivers/firewire/core-card.c
index 5bd89ddf5018..b98797e4f1d4 100644
--- a/drivers/firewire/core-card.c
+++ b/drivers/firewire/core-card.c
@@ -292,13 +292,12 @@ static void bm_work(struct work_struct *work)
 	struct fw_device *root_device, *irm_device;
 	struct fw_node *root_node __free(node_unref) = NULL;
 	int root_id, new_root_id, irm_id, bm_id, local_id;
-	int gap_count, generation, grace, rcode;
+	int gap_count, generation, grace;
 	bool do_reset = false;
 	bool root_device_is_running;
 	bool root_device_is_cmc;
 	bool irm_is_1394_1995_only;
 	bool keep_this_irm;
-	__be32 transaction_data[2];
 
 	lockdep_assert_held(&card->lock);
 
@@ -346,6 +345,11 @@ static void bm_work(struct work_struct *work)
 		 * gap count.  That could well save a reset in the
 		 * next generation.
 		 */
+		__be32 data[2] = {
+			cpu_to_be32(0x3f),
+			cpu_to_be32(local_id),
+		};
+		int rcode;
 
 		if (!card->irm_node->link_on) {
 			new_root_id = local_id;
@@ -361,21 +365,18 @@ static void bm_work(struct work_struct *work)
 			goto pick_me;
 		}
 
-		transaction_data[0] = cpu_to_be32(0x3f);
-		transaction_data[1] = cpu_to_be32(local_id);
-
 		spin_unlock_irq(&card->lock);
 
 		rcode = fw_run_transaction(card, TCODE_LOCK_COMPARE_SWAP,
 				irm_id, generation, SCODE_100,
 				CSR_REGISTER_BASE + CSR_BUS_MANAGER_ID,
-				transaction_data, 8);
+				data, sizeof(data));
 
 		// Another bus reset, BM work has been rescheduled.
 		if (rcode == RCODE_GENERATION)
 			return;
 
-		bm_id = be32_to_cpu(transaction_data[0]);
+		bm_id = be32_to_cpu(data[0]);
 
 		scoped_guard(spinlock_irq, &card->lock) {
 			if (rcode == RCODE_COMPLETE && generation == card->generation)
@@ -523,11 +524,11 @@ static void bm_work(struct work_struct *work)
 		/*
 		 * Make sure that the cycle master sends cycle start packets.
 		 */
-		transaction_data[0] = cpu_to_be32(CSR_STATE_BIT_CMSTR);
-		rcode = fw_run_transaction(card, TCODE_WRITE_QUADLET_REQUEST,
+		__be32 data = cpu_to_be32(CSR_STATE_BIT_CMSTR);
+		int rcode = fw_run_transaction(card, TCODE_WRITE_QUADLET_REQUEST,
 				root_id, generation, SCODE_100,
 				CSR_REGISTER_BASE + CSR_STATE_SET,
-				transaction_data, 4);
+				&data, sizeof(data));
 		if (rcode == RCODE_GENERATION)
 			return;
 	}
-- 
2.48.1


