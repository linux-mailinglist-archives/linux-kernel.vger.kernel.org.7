Return-Path: <linux-kernel+bounces-819768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF21B7F76F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52C4D4804D4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 00:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69780C8FE;
	Wed, 17 Sep 2025 00:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="rUgcRxSQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EJLml2t+"
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35D036B
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 00:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758067435; cv=none; b=TwqfnvcORVB61Xg/m2zg2bW5xkUmBr8nXB5UP9dkewYMilARlUrzBEr1w/c+plT08iHTAYMQ9bxf0frbbTubq26f2FU0MBAhxc5S0HVB2VAUZ0MIz4BbBWMaOwTq3ttZupGP27aT4AilfBrdHvekpb8tyF34XDKPMZVAb+/WZrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758067435; c=relaxed/simple;
	bh=IdfvsZMrew8FdTObrP8TNBiNuJiQVycQcPa0nplx88I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bNue0ij0AHUsadNv8XKbOJP7DwrXH6gEmeg/AyZdeRDR4+KTOxL76apRUTnsqj0BeGp0qLnbbPHa289Prt8xG1W9q3QTiUb+eO/EiWvMdKpCEhQ4XhLHos9afRWhyje9KRJFR9rV1qb1nxFtaR4jY9ouPh8JHNTJd18uUdYXyz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=rUgcRxSQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EJLml2t+; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DA1E77A02CC;
	Tue, 16 Sep 2025 20:03:52 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 16 Sep 2025 20:03:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1758067432; x=
	1758153832; bh=XqttZHgRieOanhNfA33PuK7ta9Fx7p7mI7X1kqv62mA=; b=r
	UgcRxSQ4z3m+mlziZaCWhACddgP3MEA/egOHo5LXeoq54zPTB2qtCWgCczLcK0JF
	0PPgruK72QwUbxYzWPLzk/mca93JNL1ABJWLx7lW8Tq8rGdc9M77qBcy6FB6gcrr
	z3P6tZMssfJZswMQMMo8R6JxAWfplBRm0WQO+6cSX7Ge4Yhzso1jdrdy8c3GX/Iz
	BXSyRzHxP0CJUGLyCjOpFve7Qymn+iPujJMrXlkwQEgDg9XhPVfunjshk8WZ6+Aa
	gr/VIubtD8Ys/SJhzWuBP59bWRNhMRV9wkIsbPAr1voLDUPKVJmutUk53mDyeMkJ
	Q1Fr0BnUjMkzGANiBhcoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1758067432; x=1758153832; bh=X
	qttZHgRieOanhNfA33PuK7ta9Fx7p7mI7X1kqv62mA=; b=EJLml2t+hiCRdGGfi
	dGKjo/MpAzFwpElwRNNd09PL4aOurz2olycyrucf8xJHKKWejpYSqjy8/PzpmzLC
	yXLTNTtrI7CcOPHAzNPg3fcpSE8svQajokqGhUjTORnF+1blyPaDQSQkIHFOra3g
	qW1dQZEEmYRG1Dik1jUcaBbnAV65D4ySRTXm365BV5uD8ql2w5sC2gx1NXfofLJb
	QiknCkcItJ7oKFQo6eQJzy/k8ZHTk6CgKEljWEnnO7eg5cy7jYDHQRU7NHeKx5mm
	PxrcTWJwFhJorsPMs00lNW8daI57AhfYiRjiff3VVXU/GwecO++dDC8ZkuqglxY3
	HqSVg==
X-ME-Sender: <xms:6PrJaO-AdfFoxXw-nDpaG41y6PWKomyRcPeL6Lw86Px-suXeOTDjNw>
    <xme:6PrJaHod-WjuH9iQqUrXn8PO2fLp7cTjSCR3uP1RAOgRBhNmIWKOcQ9o1wbxaVjTc
    cLdfsmuyiPMV37ipyU>
X-ME-Received: <xmr:6PrJaF8UnRhqUQHaF3LqFASxd1IAY42zrGOSSVHDBgG6XWe84F6eUs6DmzUdXm1nlaeUKHMGPgSJo0E0EFRA-TZRnQ2h5r2o5DzAomjsnDsgPg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegudeliecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:6PrJaDW5V6BDRXt7ba8DfBtkEFjuQWWoSMr7XzipqPBkOiNBqP2nLg>
    <xmx:6PrJaDBxbXqrxHBzD34E7jG90nNvVP18wAaaYaczOmzdj2EG2mTK8Q>
    <xmx:6PrJaMxZCKFY5knzHOk28I5HwtC73sNqvNOyrqPj7xCugrNey6-TFA>
    <xmx:6PrJaIAHFqqoyXp6zLfMLodouGH6aVfL6PO-5o3vkF8zQIwEvGrFgA>
    <xmx:6PrJaNi8aIGnnko0DFDwOgmoXPOjt_OgAJ3CMKaY9_fkDYNIRejboTAQ>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Sep 2025 20:03:51 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] firewire: core: schedule bm_work item outside of spin lock
Date: Wed, 17 Sep 2025 09:03:45 +0900
Message-ID: <20250917000347.52369-2-o-takashi@sakamocchi.jp>
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

Before (re)building topology tree, fw_core_handle_bus_reset() schedules
a work item under acquiring fw_card spin lock. The work item invokes
bm_work() which acquires the spin lock at first, then can be stalled to
wait until the building tree finishes. This is inconvenient.

This commit moves the timing to schedule the work item after releasing
the spin lock.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-topology.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/firewire/core-topology.c b/drivers/firewire/core-topology.c
index 8fa0772ee723..2f73bcd5696f 100644
--- a/drivers/firewire/core-topology.c
+++ b/drivers/firewire/core-topology.c
@@ -479,7 +479,6 @@ void fw_core_handle_bus_reset(struct fw_card *card, int node_id, int generation,
 		card->reset_jiffies = get_jiffies_64();
 		card->bm_node_id  = 0xffff;
 		card->bm_abdicate = bm_abdicate;
-		fw_schedule_bm_work(card, 0);
 
 		local_node = build_tree(card, self_ids, self_id_count, generation);
 
@@ -496,6 +495,8 @@ void fw_core_handle_bus_reset(struct fw_card *card, int node_id, int generation,
 		}
 	}
 
+	fw_schedule_bm_work(card, 0);
+
 	// Just used by transaction layer.
 	scoped_guard(spinlock, &card->topology_map.lock) {
 		update_topology_map(card->topology_map.buffer, sizeof(card->topology_map.buffer),
-- 
2.48.1


