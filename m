Return-Path: <linux-kernel+bounces-817920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5944B58895
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 01:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 095531AA8510
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 23:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961862DEA8F;
	Mon, 15 Sep 2025 23:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="m9dVGK8e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OEQlB0SB"
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FA32D7DC3
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 23:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757980084; cv=none; b=N0dfgoRPPUPguSG4+zpWTwmFRU0qzaqeCz1trehvLKOQb6sSRfY1TcDB4BEYqj8DtvJbeaYCHLSk1xmjGXI/0wF0u8SdRXMq70ZqK0H3Nekokf3Tvtta7Eux5r8DLsnNm1+vms2Kh6awsFRuPm42PsHwum8y7tFAS4d+AhSQtug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757980084; c=relaxed/simple;
	bh=poh/xEaqp/7aH7FXA6r+ZHKUolObNr3GkBGAeyRaZ/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TeGlGwjppLoHqY/JTUJAx1GzcBJhYotiO2Do5xiE7jr22Q27HytyV9d0eWvbBBz7KFwcA9DMLcsQ9/WJZb1pd+QLJpC7NNFV9bU8VUcoug3bdgLxh0GYvIMV/HHL9EduWMNPssviQiMsrKZd98c/8K31Uw70kU2OseFisDBdamo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=m9dVGK8e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OEQlB0SB; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id C2DD51D001B8;
	Mon, 15 Sep 2025 19:48:00 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 15 Sep 2025 19:48:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1757980080; x=
	1758066480; bh=T6wMwxzSvaxXpw+n82w5s56jqEc3YNWXuoN96hl1MF0=; b=m
	9dVGK8ekC3Nujd+QOrvppfpz/FZdaGPnQot4/Bmr9Qt+Qs/hDBSRkaiL/PEY2PxU
	kKKlf2cO+9TsIEFJD6UBJDNnmpVOnszmOnRtErelhZeXOoCTfq55v2a5hukoVEg1
	oCKdUtTECB68Gs7HoYzdl69q1e4STKraTphlRuRijEAwx0UaIzAHC4bzUuqhn1t5
	vq/USK50ATUuQLnTdXo8fG0xdxaC2hHq5jnqG1UCmUb7wFQ8S6TH8QLRToob2En1
	adL/xDQn7qw0dW+l1c+qBesXTQ+j/d2j6YPNnEA9qEorwKeS3Ix8Mp11jmlOM1Hx
	kxM+d/MQ3KbWFPoY72VXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1757980080; x=1758066480; bh=T
	6wMwxzSvaxXpw+n82w5s56jqEc3YNWXuoN96hl1MF0=; b=OEQlB0SBkyRuYWt3Z
	cq9FX6PeP2nNlOVDwlACCVi+3dYEDF2upVDzreB6xc1mnbr/4uEQCtwQ/Danlr6s
	Frc+PV6Sugf+86txMxnsvb2dtseH2iroSyUpwV7BHNZOTe2zltmU51ufu2KwX77z
	IDjmgkGVyMqWfzLkzlGHqTxta3Sp0n0PouL4pVlzvUm++MVUZv0RifpoKv1B+84M
	PW5eKSYmqk35/ghipAL0cZMQ/tW/0T2vaboNopQ1jHbXYqFiaQv9qVVh1gV+jh+l
	MqcDoo+0oV6o0W3geWEagPHGw5BXf+1cVOycjaX/FV3NxDzlGv/7f5DYsiQvxzOT
	8jTog==
X-ME-Sender: <xms:sKXIaFxIFdY7eSUd0qHjqXlZipti7hQH36PeVfJcLZL3RhsLSJHZdw>
    <xme:sKXIaOP0qKzbwP78KEFjWlIzgbHd_p8RAuaxT6tMEUa_4CYfCAGypU6vBUnM2Kkst
    9PkdhgIVKuu-PVbYYw>
X-ME-Received: <xmr:sKXIaBQi0Ii1P3myhS1nxo4iK-G55vIumgbMjZMoeJYHVtK0xS43Nn5z6t8f1owjsXv4elZ4qxcztdiIo1C_DKms4-2T-nTjinpEbi8aG5Vlsg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefledthecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:sKXIaEYtQd2UKgdH89gHPUbdIXqjfQ8AmZQO-NrqrX61GVTO6XcyVA>
    <xmx:sKXIaG0ix-XjP_jO1GrTn96QN6UGEKUDc4XfCm-ue-dVPDr_1wCkWg>
    <xmx:sKXIaMWesTWbkN-7OTJwvUxHkckKUAYPMem6a9ippiqnivV41SGN3A>
    <xmx:sKXIaIUbrI2EjUwXchf-1iwdwGiXbMduN-jqNQrmXWW1V8D7I9ERYQ>
    <xmx:sKXIaG1r2Hhul0-Q4hDBzEIIO-5gxTNVvuOMHl-4l7wg6VluKy7GLGgf>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 19:47:59 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] firewire: core: annotate fw_destroy_nodes with must-hold-lock
Date: Tue, 16 Sep 2025 08:47:47 +0900
Message-ID: <20250915234747.915922-7-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250915234747.915922-1-o-takashi@sakamocchi.jp>
References: <20250915234747.915922-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function, fw_destroy_nodes(), is used widely within firewire-core
module. It has a prerequisite condition that struct fw_card.lock must
be hold in advance.

This commit adds annotation for it.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-topology.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/firewire/core-topology.c b/drivers/firewire/core-topology.c
index c62cf93f3f65..8fa0772ee723 100644
--- a/drivers/firewire/core-topology.c
+++ b/drivers/firewire/core-topology.c
@@ -325,9 +325,11 @@ static void report_found_node(struct fw_card *card,
 	card->bm_retries = 0;
 }
 
-/* Must be called with card->lock held */
 void fw_destroy_nodes(struct fw_card *card)
+__must_hold(&card->lock)
 {
+	lockdep_assert_held(&card->lock);
+
 	card->color++;
 	if (card->local_node != NULL)
 		for_each_fw_node(card, card->local_node, report_lost_node);
-- 
2.48.1


