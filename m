Return-Path: <linux-kernel+bounces-804924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C546B48205
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 03:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25D88175913
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 01:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B0C1DE4C4;
	Mon,  8 Sep 2025 01:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="HL6eCRId";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="neymfP6i"
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFBA1A5B8B
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 01:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757294480; cv=none; b=SCw3FGd1Q+bXv6g5kX6RiQU+ZZHKGO2QkDp0xyAiy5hZeDvHXguLgncxQHUyvcjj3DpYUCMmDZpPGzDDnbJv4EH/QLMnKN0zLmaKRafhaF2N6qx73GbRz4PhfDyzICS0PfBZ6bOgMic1D0QNvMchlqmv2nQla1r3RUVgHdbl22Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757294480; c=relaxed/simple;
	bh=5ULHdccKNb4AQvYbXXvPgsynluSrbowxO6ZXAto5onI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z1z77NJsZrSJxbdYJO5P7W7FZr0Zy36VjIc7Tj2uhqxRR3zf0WTtW9eZoOCM6nDs9YiaRj2sNLEIGImiXq/DNrGcTTuFBOfW+j6RdUR9CAUQHAAJMxCm3hO70cCkaI3tAXbL3SD4MquouH4QpfbqS6O1QPNAWmZSFCN2lgRys/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=HL6eCRId; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=neymfP6i; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 0EDA1EC005A;
	Sun,  7 Sep 2025 21:21:18 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Sun, 07 Sep 2025 21:21:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1757294478; x=
	1757380878; bh=uchyU61E1WIGg/6ydRyc3JrxwAu4U5r2JO2FznzjLnk=; b=H
	L6eCRIdp4ivv+I2DZSCdwkbr1hiRCnAowS3Wx78c7PMtnnBFazulA/pkQ0rQXuns
	5+Xt6F4eg3b0hidzycnMU5J/5dt7pDbhvQgd3IVFkYR5TsCAZWUUHaSoaaZmxNbQ
	0gwpmcXWkShsLXB0+AEkyFE47KNNB20Kcic51184GkHI9gGpMtvFVznrgHxL6DBK
	yajFmocniauz/CdiRasxS173Aq0bXMhQpk6DPVLGeYSLtmBZjrIFlSxPMhwSuRdn
	vqeyhuWPFvsKMzOS9ynko0mKmSL5jJCaTD8JYYIPgLb5iWSN3r17n9rvgNvcMOvT
	5upRWu9L/1DK/6JoIMSCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1757294478; x=1757380878; bh=u
	chyU61E1WIGg/6ydRyc3JrxwAu4U5r2JO2FznzjLnk=; b=neymfP6iC68HIfFfw
	SpGTYrE7pgR7uLD0RKGp2zRfw5kUyqcm1VXAl1+Klr1ROtEQUC5fv+5CbrNfee4/
	o9QbSOYFrwDsQhGWmQC1IGYLq5yxtWuM2CPCCFFipYBPEJxVAJL1TmoHs4qiciR8
	0RtGQ8T3maVE3XidVGY1dAMEJLNoW6NCLBNFQZA4nNFnPsF+mx6Hu4tpmllRbvoU
	nSdLDrtz0myfoSxqLyprmQIxuYKnDNtFwhu/yzN4SwpvA+mAZvX9f8yZTcFSY+Tf
	CNHVbmsUsD6SxjQ9QX+65vdQYL9pKoo9N2EmO0Dc/feOH/4Zw5W//fkHhvVtPOun
	6KErg==
X-ME-Sender: <xms:jS--aGGtVeJSPzNEQIB45Rs4uSsFpyyabXb9nbxXrv42KlEaQMKzYA>
    <xme:jS--aAR2cjVoGhoz_UNjsEJIikxFcgct6gJSJY4HNr5nbCF9QzAV-50wUEzEtSkEQ
    hd2uFXIfAv6ItA1twY>
X-ME-Received: <xmr:jS--aCHDC3nsCRRLjAmvteRTBKTVFtLEC_akaahIQXaImoCj2ZAp_i5ZwWaLaolalaA9S-plIl0ROfXvzdfY-LPGsH_z1Xe9-C7p_mD5WZk>
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
X-ME-Proxy: <xmx:jS--aM9tUnf2JgOYPxJ-1eL-poQJD8UqcdHZgtumibuBH2ItNNweeg>
    <xmx:jS--aMKyZkv4-oG_G5dbYoViDQOZQ_Qx8NIz04-TafxP8Cqk-tc3Xg>
    <xmx:jS--aPZwqpqmK_EJ8QHHOQEFES2eLzdyUFHjksbJTEYbemQtezf0bg>
    <xmx:jS--aGKgoVuUWuirSayxIcJ2ZXQL3pKYMUSfckUjG8lfvkTVTVcxuw>
    <xmx:ji--aFoGdVuRsTbG7xlt3AiPW6QGJYHsTYI_6wYTty2CvetNAV31ggF_>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 7 Sep 2025 21:21:16 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 03/11] firewire: ohci: use return value from fw_node_get()
Date: Mon,  8 Sep 2025 10:21:00 +0900
Message-ID: <20250908012108.514698-4-o-takashi@sakamocchi.jp>
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

The programming pattern, referring after increasing reference count, is
supported by fw_node_get().

This commit simplify the programming pattern.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-card.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/firewire/core-card.c b/drivers/firewire/core-card.c
index d128c7a8bf5f..41902dcc10a0 100644
--- a/drivers/firewire/core-card.c
+++ b/drivers/firewire/core-card.c
@@ -306,8 +306,7 @@ static void bm_work(struct work_struct *work)
 
 	generation = card->generation;
 
-	root_node = card->root_node;
-	fw_node_get(root_node);
+	root_node = fw_node_get(card->root_node);
 	root_device = root_node->data;
 	root_device_is_running = root_device &&
 			atomic_read(&root_device->state) == FW_DEVICE_RUNNING;
-- 
2.48.1


