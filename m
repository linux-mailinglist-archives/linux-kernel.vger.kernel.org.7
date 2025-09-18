Return-Path: <linux-kernel+bounces-823730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E56D5B8754F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 01:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A25E7E42DD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 23:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB2D31A7E9;
	Thu, 18 Sep 2025 23:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="YV1y0l/d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K9s7FSdW"
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D8D30DD14
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 23:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758236955; cv=none; b=b32q0gaE40b3MBTkB6TWnA2P04e+af3FdcTLRm+D4MLyPXxXXLUnt1krMAeIzFkQu9NDT1eimIHUjIYEV2HYYTimh6o4R9j1oo6/+5W3WwgfvuqxSdVd+tzbusyVE4Zs7zSbH8xnZHXjg2+3cHgTEySmrDgfwrDsdA8D2aN5blU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758236955; c=relaxed/simple;
	bh=St2b7cHSZC3ZZZPxW7dlg77nj7MUjvqV85jPkIhwpBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L+T8mLKoOdUjzfhlVCnPX7pfVBPNUo+h5nVPRX11UzYowM/JG2F6A1V+KvsYkN4+3T5h2V/ToBxJ1qkrL0vT58Cbzo0Qd2+qte06RUYTrUCF8bNUhMSvpfAMcA7oQRE4G0OIv1/s1dorHMZCK9UoWKccKiMrRtiKxx1aKD/jgXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=YV1y0l/d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K9s7FSdW; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 8375C1D002D6;
	Thu, 18 Sep 2025 19:09:12 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 18 Sep 2025 19:09:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1758236952; x=
	1758323352; bh=RAKnE91e6mZe7mbb83yvaKy3djJ4JJZGxtMDS0v5CI4=; b=Y
	V1y0l/d4Qq2dM4gc2qpDojKYx3mUPlF0AUD3lWESgWHzNd0idz06ykcnNodldlXn
	KdWZTX2Rw+Sb4GKR4Rhl33pfuZtHzDV0C4wvBp9RHEBpICKEEoOc28sf6JvyNJ53
	xtov5nZYpIFm4HshpJ65QyiL/jiVwZ3vH2baZDAFSdupr+0BpNYaPlBf1jrnV3e+
	Eo5+vBsnZ0iXqt2gbo/4rfsvwwwhhIcuapKhqz5G16uaS6GisOnvUNhpLypi2vrx
	NquPgo0FAuWk/xYDQr8WkueIZZUeNtLnEZhPMEJGIVQgUUCBIVLZh9uVxL5S7g4V
	sCUf3DKRQpyddkInnkjsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1758236952; x=1758323352; bh=R
	AKnE91e6mZe7mbb83yvaKy3djJ4JJZGxtMDS0v5CI4=; b=K9s7FSdWM2VwwlV7H
	a5VDrxwp0ObA5Q0V1cqnxLbqQz7oo6lSiEzQc6Z86gc/8gP0n/tnrbfV7QdQAac0
	o6G10/VntjxSHaSddANqcqsW1ZHPZvW7bSHRISYdG6LXqcfDFppO6SWZbqTI6UQ8
	USTQ63icdYvg7oQCKX2wlP8I3AeBgDuxJE2CV8oVdBWNabA1trdAb+03NrAtEDtF
	0pYNtZjRFuqvpUE+DroHCZE+2b1kyYPqUThbBduaszNZME8i0sJiRYIJpyU88O+T
	gUkdyhTCoFZ9t4esGDSGNadvJQURT+zaB3tJW/ZG5DtwNYanQCZaIpCOD0MWbMMu
	VpN7A==
X-ME-Sender: <xms:GJHMaHAPJI81I6Hdm3sR-kVCAIJ0c8SmCl81IEr0AufCCWa4dAXkLQ>
    <xme:GJHMaGewP53i004qBEvKrlsUu6JAXz9up414EeKNCfeKV6rvgZM3lTHx0GUU3XBVC
    yltlrCC9raNTGG6XsI>
X-ME-Received: <xmr:GJHMaEiRJrv6PM3Crut7TxeCnTdAo63uRINS0a19FVwARdUUThvL187AYt3rvPP77yOEsK6sfx2y9oYzcTz80RS8AVLbFFY68SkoeFJlFJhqHQ8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegjeeiudcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:GJHMaGo-54-VV1HJ0h4Zy5O6pjCrrRu8PK-UBhCTgt56nSfowE3HhA>
    <xmx:GJHMaMHGEi-LDAWOcoXbBzWw5984uoXRUTHxUKqc4auPbaM9g9xEGw>
    <xmx:GJHMaIkO-rVzCQKz2VJGFeJMOmvfIVaO_WaYmiX9d9BHeURYKmB27A>
    <xmx:GJHMaPnJnUF1ln3yL-fk1nVyzaHAhAs7-rp9AeiXp7380z0lNGoteg>
    <xmx:GJHMaCHizeo8lFl1MqthmLYRwS304iO5zWl6aVpGFSRgVaqd7UOZXlbQ>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Sep 2025 19:09:11 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] firewire: core: minor code refactoring to delete useless local variable
Date: Fri, 19 Sep 2025 08:08:57 +0900
Message-ID: <20250918230857.127400-7-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250918230857.127400-1-o-takashi@sakamocchi.jp>
References: <20250918230857.127400-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The do_reset local variable has less merit. Let's remove it.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-card.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/firewire/core-card.c b/drivers/firewire/core-card.c
index b766ce5fdea4..527a99ef7c90 100644
--- a/drivers/firewire/core-card.c
+++ b/drivers/firewire/core-card.c
@@ -387,7 +387,6 @@ static void bm_work(struct work_struct *work)
 	struct fw_node *root_node __free(node_unref) = NULL;
 	int root_id, new_root_id, irm_id, local_id;
 	int expected_gap_count, generation;
-	bool do_reset = false;
 	bool stand_for_root;
 
 	if (card->local_node == NULL)
@@ -500,16 +499,10 @@ static void bm_work(struct work_struct *work)
 	else
 		expected_gap_count = 63;
 
-	/*
-	 * Finally, figure out if we should do a reset or not.  If we have
-	 * done less than 5 resets with the same physical topology and we
-	 * have either a new root or a new gap count setting, let's do it.
-	 */
-
-	if (card->bm_retries++ < 5 && (card->gap_count != expected_gap_count || new_root_id != root_id))
-		do_reset = true;
-
-	if (do_reset) {
+	// Finally, figure out if we should do a reset or not. If we have done less than 5 resets
+	// with the same physical topology and we have either a new root or a new gap count
+	// setting, let's do it.
+	if (card->bm_retries++ < 5 && (card->gap_count != expected_gap_count || new_root_id != root_id)) {
 		int card_gap_count = card->gap_count;
 
 		fw_notice(card, "phy config: new root=%x, gap_count=%d\n",
-- 
2.48.1


