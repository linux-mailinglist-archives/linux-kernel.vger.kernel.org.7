Return-Path: <linux-kernel+bounces-866750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B8067C008E8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 64F0B359A28
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1ACF30AD1D;
	Thu, 23 Oct 2025 10:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="qMMFwP5z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NpoM/RWo"
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC8F3064B8
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761216237; cv=none; b=nZabLE+lmiOrN4wMyTLBgN4TqkyxBaLzxLeM2nRUxoAaSnJx0/1CK8XCDkCOm0RbjJAwcabQBGBJhnqZ+uJYXruokZb5s56rwZ+0bCOwa2yhj0YOkB6zDyFyUsN6fVgJuPwM2j+nrWcC9ei4AkTRWX6QWPrrFjzs+QeDHeRPdTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761216237; c=relaxed/simple;
	bh=ILR8x2MvIfzkFwOKXK2DTyFcgop2z2n3w6GynpMHVJU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nuxDvMNw5FRqLwk9nSBmYWSIEhBtHIil1BqRl4jPCv7z3nULSs5V98jewUg0mB3z5sQ2h8fZrZhSkD+mG20cZdmrEXyFJ0P2bncVEcauriPCwu55V/6YmV0y6rv56y3XXKV+qKQ0Z3Rla8Ab1b3pUrokZjM/NRhyDaKlweoXRqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=qMMFwP5z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NpoM/RWo; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id C7E701D0016D;
	Thu, 23 Oct 2025 06:43:53 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Thu, 23 Oct 2025 06:43:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1761216233; x=1761302633; bh=tuhuxGJxdn
	3r6WOzBBCivadKs4EzZvy7ECdmVrw+DgM=; b=qMMFwP5zEf8qcWiGYIbwuI7tGu
	21nrNebxrx8nq3NaFg9v8K32fLm2B5PelZEkli9o3M0A80CICFI7uoDTyRu8nXAN
	KzfKIdwiRXTjJN4heFRN8CJC642a8TsbtCeNfG/Z9otyQPc3Ixjp2/r+i0X2UplQ
	aIm2Az6mFdu/NL4CQYwvOSmWsFESbLZQZMjyd1ZBxpt0FbTizZPg0sKUzvngUrSs
	mtyRm3gt+au1gpyF4UG8gfetIIWo34ZPV9N6NzfAJ8BAFLTYcpZvSMm5/f9m9aUe
	wgwXxoLHgbj7l7O63lDPPVmAG0Hy46J8PjkyeTJVfS8k4HUerekjeey5vMJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761216233; x=1761302633; bh=tuhuxGJxdn3r6WOzBBCivadKs4EzZvy7ECd
	mVrw+DgM=; b=NpoM/RWod8FcQWF9CHr16AVnBNVYrt/3i47fyXo0jIRK5MZ/m5D
	a6Qqhfb9iP/FgH/0xGJKvQw1cRr5VTD3UZcMpE4enC3/PTofoGMbu/iG8EgYoPgZ
	Uivy3Y3Xkl6jSlQpWGtqEQKRLOD1t11188Qk9k7/wwSWRNCyWTNBLxTPUFRL+m7n
	+vOYU0ab0ZbbXDQWxjBlbkLBJ0G1UcAx8btv2Be4qc67fUIEYYkr7ZXfiwhMYvnF
	mGznGbQRH6FBu0FdMociaoirxli3QuI7Tgr32iZCjGUU/tIDZq+hodI5/KxKChah
	00x0UQBQ7o+OcgPD0/QzYX/xslSebig1t+Q==
X-ME-Sender: <xms:6Qb6aP5bBl7lhJdK2fDJO81XUyswstsptBPeAGlBx5h3w_19QZ5wtA>
    <xme:6Qb6aC2oXfnkYyIBcExCwMt4d-qtx_gwBhSVqA4CYAxdQIIS-S70pvqhqiaKnB_Lb
    q0EFjWsB1MSAIjJ-QKbXJkHhIfHPaP_ttmiq_OkCDlSVQeyZhTjCrU>
X-ME-Received: <xmr:6Qb6aOCGO0u4XvS6sB2hAoIsKtczpw6s4jBeRn5f720YD7_mUVSLU7YFGm-OrdHOTnVfUBZJo6Lt6BLwM7kJlNGCfqYTRtKChYxXr1ZcyYj3WA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeeivdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghshhhi
    sehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeffvdeuleffveekud
    fhteejudffgefhtedtgfeutdfgvdfgueefudehveehveekkeenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrg
    hmohgttghhihdrjhhppdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehlihhnuhigudefleegqdguvghvvghlsehlihhsthhsrdhsohhurhgtvg
    hfohhrghgvrdhnvghtpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdr
    khgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:6Qb6aM2YnbcRcbCjcEuhjwIP1HB90hOM8IR-HRm9Kzqo4cOZ8qbmbg>
    <xmx:6Qb6aAvw8kNSjHOP0s4Fv2i3jhQfrhzbOwP5avErsakKuiQB7-nZgA>
    <xmx:6Qb6aE4OELhUDuWBnNzjhyHj9S0ZZV0vghHc2D2UCH_K1sXb6EJ9vg>
    <xmx:6Qb6aJIzFtTBz5U29GlyRr_S7p4KuqgaT69pX9kkMo54J20GWdDVtg>
    <xmx:6Qb6aAuvs_MfzL9r0T2K_6LO5GdE5pNcPh72yMD4BijwqMcb2mk9BX26>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Oct 2025 06:43:52 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] firewire: core: fix __must_hold() annotation
Date: Thu, 23 Oct 2025 19:43:49 +0900
Message-ID: <20251023104349.415310-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The variable name passed to __must_hold() annotation is invalid.

This commit fixes it.

Fixes: 420bd7068cbf ("firewire: core: use spin lock specific to transaction")
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-transaction.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firewire/core-transaction.c b/drivers/firewire/core-transaction.c
index dd3656a0c1ff..c65f491c54d0 100644
--- a/drivers/firewire/core-transaction.c
+++ b/drivers/firewire/core-transaction.c
@@ -269,7 +269,7 @@ static void fw_fill_request(struct fw_packet *packet, int tcode, int tlabel,
 }
 
 static int allocate_tlabel(struct fw_card *card)
-__must_hold(&card->transactions_lock)
+__must_hold(&card->transactions.lock)
 {
 	int tlabel;
 

base-commit: 211ddde0823f1442e4ad052a2f30f050145ccada
-- 
2.51.0


