Return-Path: <linux-kernel+bounces-819769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE29B7F3EB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B8D9481334
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 00:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123D928371;
	Wed, 17 Sep 2025 00:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="g8DE4dAS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ucg87op8"
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C94B2110
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 00:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758067437; cv=none; b=ONtUCHFl7tIxF1PNcwPdkSvdRlIL5NDei4IczXzFmIIbmJOEX/zUPmWPbOF3SAHF1mOPwS2/Ig9Mx2BuK6jHA6JdDlDm8/WRL4+FeFPGQxyW+D7yvw6Aj5/T6L63LzGaOogsnQrRvgE/3/kNfqazlF8jPdMsjnECxVyvvt0KQmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758067437; c=relaxed/simple;
	bh=YrzPqOkHgr50Lu/GqGlttyH24fN64WgEyjHmDQSnMms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BIRohiuzy/sbh+82BEVFgZpjKFT6gk5RIPomVAXAjnR5L/rmAP4AEGTp2LuFaGSszwXda3mDcybc/z3bU34dGJR/FN0Sg4liAyygwlLO1dtViqRIddTklP96/97dCfSspZmNhT13Csnh/SeP9ujvxeJj7MgO/uWi+BGl3EYE8Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=g8DE4dAS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ucg87op8; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 8F31A1D002D9;
	Tue, 16 Sep 2025 20:03:54 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 16 Sep 2025 20:03:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1758067434; x=
	1758153834; bh=t1f8CJyyveNUQMePWwDrGPs1RuYxKALIwyp3EIOyP3s=; b=g
	8DE4dAS/6d0ZXY23sw71l52STE+Q6tXXouUxyOtDANd+GPRCWmCDj73ZlwIaRAaR
	27wHIpcrGXgXurwGqbSiYEMtFMpp6ZAj2wfV5TLJhH9BA2cG3Io+328k2ygVEmWI
	zIMVPDX84PW+GLIgXPGh/P8zpmZMlfzvPFAsGcdQ1K82wVmRwBhAI46foMouUv8d
	lPyh6Q7d9uLEuYi6QaNVPX7CGaWi3NJdA7cjeXXYiF5vFIifPQXrQ8XjF6caceOk
	l1Is64bIzH59yq5liJOhFVRV4ZPsJ1pIU8z0Qi49ie+PWC5sKyDj4DNxb/zAJgLN
	sRsJE1Wi9ioGwkaQHNZFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1758067434; x=1758153834; bh=t
	1f8CJyyveNUQMePWwDrGPs1RuYxKALIwyp3EIOyP3s=; b=Ucg87op8JBpn0QZZU
	ye+OW+63PIj8ug0eZulQ9n8T/eBHuKhfz698Rue7qKuWy+RTsNHQ9BiMZrZYHZWU
	2D6MBBjevjw867CGApAQYyOFUlD5gyjlUWbP2EOso//mNv0HE3vDqq4ZA9L5I54K
	YqDH0HeJT8JxmT4Uwx+AlkvaFOWiRxAb993kPvMJMLn2HOqba+uaAazy0woNVJg4
	Dg6rzCMIzdsvnT7V3z2JsK6B+hxeMHa8XHYO32/4SsaV9TCm3O++CteoN3YRsG5D
	xYTNzYPrucHlz2VkvvXkE465mEd8JbSVZ3qc3+lcwIa9PFaZkkMEDxtN6DMp8iri
	XCzrQ==
X-ME-Sender: <xms:6vrJaG4HibUMs9kZu-aPSJKpUrXLqvrVk2ocb8RtDov4NIKiz3lCOw>
    <xme:6vrJaI17M4-DAcGPlz2g2Iay8uvhIz4K2fCMLrwAmCP0myX_g9gAeGRMWg_X-G4pK
    PV760cD7PskfheYm8A>
X-ME-Received: <xmr:6vrJaHY0gAOc3KgokmJs0u0rDNNVVKDb-amU8aNkFPF5fKHzd0DKZHXSEaxPLDtUqtjxS_7gvy_xOL_Kcyl-ejyyR3zYrQmqTwQW4_qTAKEmzQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegudeljecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:6vrJaAANFTn5gHsGVblt2V-bC00fpYjaIEZ5Oz4LnAjmOxblvMkSgw>
    <xmx:6vrJaJ-AduVaHFdQnt0B9ThgN7CWNZQMKGMAaC8qdIiKh9TWswJ_IQ>
    <xmx:6vrJaA-mFdT8qUeM1Yv_X5Y0flOSRiEYPkjajBUyEPmhEfDq6ybxmA>
    <xmx:6vrJaAeyB8Eh2OKyYfytuiMut-3JUsw8c7hZHNkR09DWjmbz09nljw>
    <xmx:6vrJaI8U0IRsDVB6h8VU4xvLDWBaljKuo2rF7j-gWFDIs0kY6qXu6biY>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Sep 2025 20:03:53 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] firewire: core: disable bus management work temporarily during updating topology
Date: Wed, 17 Sep 2025 09:03:46 +0900
Message-ID: <20250917000347.52369-3-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250917000347.52369-1-o-takashi@sakamocchi.jp>
References: <20250917000347.52369-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When processing selfID sequence, bus topology tree is (re)built, and some
members of fw_card are determined. Once determined, the members are valid
during the bus generation. The above operations are in the critical
section of fw_card spin lock.

Before building the bus topology, a work item is scheduled for bus manager
work. The bm_work() function is invoked by the work item. The function
tries to acquire the spin lock, then can be stalled until the bus topology
building finishes.

The bus manager should work once the members of fw_card are determined.
This commit suppresses the above situation by disabling the work item
during processing selfID sequence.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-topology.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/firewire/core-topology.c b/drivers/firewire/core-topology.c
index 2f73bcd5696f..90b988035a2a 100644
--- a/drivers/firewire/core-topology.c
+++ b/drivers/firewire/core-topology.c
@@ -460,8 +460,14 @@ void fw_core_handle_bus_reset(struct fw_card *card, int node_id, int generation,
 {
 	struct fw_node *local_node;
 
+	might_sleep();
+
 	trace_bus_reset_handle(card->index, generation, node_id, bm_abdicate, self_ids, self_id_count);
 
+	// Disable bus management work during updating the cache of bus topology, since the work
+	// accesses to some members of fw_card.
+	disable_delayed_work_sync(&card->bm_work);
+
 	scoped_guard(spinlock, &card->lock) {
 		// If the selfID buffer is not the immediate successor of the
 		// previously processed one, we cannot reliably compare the
@@ -495,6 +501,8 @@ void fw_core_handle_bus_reset(struct fw_card *card, int node_id, int generation,
 		}
 	}
 
+	enable_delayed_work(&card->bm_work);
+
 	fw_schedule_bm_work(card, 0);
 
 	// Just used by transaction layer.
-- 
2.48.1


