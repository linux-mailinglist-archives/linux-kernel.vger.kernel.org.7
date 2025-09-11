Return-Path: <linux-kernel+bounces-812943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46456B53E92
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 00:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A182D7BDA7B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 22:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F97B34DCE4;
	Thu, 11 Sep 2025 22:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="F/cUGYZS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ded1Os2X"
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD1F1957FC
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 22:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757628801; cv=none; b=j8G1zeEQP3VxYXkZemRv6s9nxHj1TEKMwf8hLNd77CeccUbj7nLvib1iso8L5SGv3gxG3cuuCg2GY89N1UAHdEF+Gebvppjay0AuvFlqRJbtx1iwb2RS12lN2z5X65uRDZ3SNPGIzpgzM1ZqDAe5Gvy92kUwMNgmbTCtVt2cos4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757628801; c=relaxed/simple;
	bh=zaPKl5bPhpHDaK/jvMkwCqifAdyixpMVgWw/aRgZ2VY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tdOS3OH+oWej+0fb/ZbGc3n7Dje5ajXGz83WfuRZLPomd0W3bSF6vswcNTg6SE37tIVYo1za2FB3XX74+yYuNaM6uFvMWPyjTM2Qy6fEF355y/tZiOnFkXKsKfLN7byHs9JhRRJK7zl3F3JB3OhRkY5N7IZ5zBJwhg3y5EMKkTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=F/cUGYZS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ded1Os2X; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CD7931400371;
	Thu, 11 Sep 2025 18:13:17 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 11 Sep 2025 18:13:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1757628797; x=1757715197; bh=eNjR1LB7bR
	YZ3xIvKQ3Zc+CVsQG5+qT7pKALYdttNsw=; b=F/cUGYZSSUsWUHuxttfCnJ4+3O
	EUfyc295V5nKxoYdvcv9b6ZnSA0HgdCheAiAOHFeGWS3jo1LQx6GSIbD+eIG6Qk7
	KTHbVIGsu1V+z4iy0D8DmpNyrMK029dJFI00QwcX+Y6P6p8JTKnMlfiz4e3Fv1Jq
	tO8jk6/Q3ovBBm0i7RGgxcq2cOsHL6lHHpE2tWPnVZQL/QFA2jbxpLzHs8SD3RmW
	efAg4H6I9ItOaDs/I4SqkLvA1v2rC0R0+wFm4M20k/Miybp9uBeop308pQTpnHC1
	tTp3ljQdE/G965Y3ftGYto2BnU1CfqtOBOMYx3acuJQPPuVrgV6QStgO8/4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757628797; x=1757715197; bh=eNjR1LB7bRYZ3xIvKQ3Zc+CVsQG5+qT7pKA
	LYdttNsw=; b=ded1Os2XBRMvNCnHPrzMzU3znZG6Po4P69FYCXPUiXq4zKTG+8p
	xyuY67q49aprKj/SpYQSavcS+Hv7K0RNLjy22dRn4BTPriV0oipKWCz18bl+VxVe
	LKqUgfIHf8sf5BusYAtfnnfjqdCVlODiJbfzWprjTTIFHTI8GVleqvAvka9ByMQQ
	Vxaj74I72kh7rynJUyAZYmmQyqg1mw6uVvaIb8kU22yNRbvYqzY+wnnv/9zKPPDj
	3EwnWGymiK2fklRVBzqVMOhudFNVLSWkhJIAX397S6yj3BVVUwA1QJlN3bN88cpw
	tJ4FtrgDkD9lcMkdYEuyEHJDhjk9YKOuR3g==
X-ME-Sender: <xms:fUnDaHw8WFC8wfc-V3Fm_YSQQHzzUdv-SxZqYZx1T8RMWpbwLt1CVg>
    <xme:fUnDaIOm_69CYmfCvK1ymsnaezp4briY8Py_6Dow3tslKZfGbOuN_8J4qbSSM2ITW
    QdtgB6Ws8zQ-hNY7N4>
X-ME-Received: <xmr:fUnDaDSDz1eDSudcN74rjGPfaeCprvKRoE72DpJaqcEPZPFJZi_ubC_950Ok4GAdLgncIiodNae8FM8JLwoskuyp4uBduAotfUJUmeEaVTRE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvjeefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekredtredttd
    enucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihes
    shgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepffdvueelffevkeduhf
    etjeduffeghfettdfguedtgfdvgfeufeduheevheevkeeknecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmh
    hotggthhhirdhjphdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtoheplhhinhhugidufeelgedquggvvhgvlheslhhishhtshdrshhouhhrtggvfh
    horhhgvgdrnhgvthdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhk
    vghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:fUnDaOZHwLpYWSoPEx3Xsa_gur9S2XGQG9txYMKKjbruLKfMcpYh2A>
    <xmx:fUnDaI04UbJ00cqhca8WllCTRfUjb93H-62qjuTa-mxdxRTWZJkRnA>
    <xmx:fUnDaGXK3YF2EMpaFteXGYDvr0XLPXWm6UJVIBBwMK5iutcn_wYEqQ>
    <xmx:fUnDaKVuLKMjomb15CJYQHxKImfUoGeNIw6lZhbQmN81_GkBfrmAAA>
    <xmx:fUnDaI1YmrULcjLP6oyfKCQ6aKt13AbETAGm1oVvat5WtDPnhvfyvcds>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Sep 2025 18:13:16 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] firewire: core: remove useless lockdep_assert_held()
Date: Fri, 12 Sep 2025 07:13:11 +0900
Message-ID: <20250911221312.678076-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bm_work work item should be scheduled after holding fw_card reference
counting. At a commit 25feb1a96e21 ("firewire: core: use cleanup function
in bm_work"), I misinterpreted it as fw_card spinlock and inserted
lockdep_assert_hold() wrongly.

This commit removes the useless line.

Fixes: 25feb1a96e21 ("firewire: core: use cleanup function in bm_work")
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-card.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/firewire/core-card.c b/drivers/firewire/core-card.c
index 474d8066e090..32cf6b3344cd 100644
--- a/drivers/firewire/core-card.c
+++ b/drivers/firewire/core-card.c
@@ -294,8 +294,6 @@ static void bm_work(struct work_struct *work)
 	int expected_gap_count, generation, grace;
 	bool do_reset = false;
 
-	lockdep_assert_held(&card->lock);
-
 	spin_lock_irq(&card->lock);
 
 	if (card->local_node == NULL) {
-- 
2.48.1


