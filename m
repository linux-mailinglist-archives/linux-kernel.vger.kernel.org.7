Return-Path: <linux-kernel+bounces-815156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E480FB5605F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 12:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BEB87B823F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 10:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4ED62EC56B;
	Sat, 13 Sep 2025 10:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="VfXUHIf+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mPpig+Vk"
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA2B2EC0BA
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 10:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757761065; cv=none; b=ItaFxMzuSWI2eT8FFug36xAAYVEPI0nc06wMyCPlQG5O/QBrAkUajB60ZZUrq0KUD0pwh1JBfIhg++4C9KmUhlH9gPiHDIw9CCrguzARtoGViuEiqysTd6UTz5IE2M46PhFKKLjZxwbzyJ+wafJ0wlj4GHbtIVHGAIti35bwCdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757761065; c=relaxed/simple;
	bh=SI4gSrLroLcxiPO6+TUPS+OVtyIiXAbmou7cIOpggBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ErNxAdUYjImlMdFpxbBSFuWTH0SDN9qvmLvDPncGBZRt8Jbl/sI9pUXr0XyBvGo3kDGdsGDcc5GF8TmROJbhjvcFc8+laGIC4Etv//CryAINpWBDBssEfOzGDCHaVlqYZsOcQFMvz7zoqgskqpkkfja56mQFEERzlKz32olMH44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=VfXUHIf+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mPpig+Vk; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 35F1BEC01E7;
	Sat, 13 Sep 2025 06:57:42 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Sat, 13 Sep 2025 06:57:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1757761062; x=
	1757847462; bh=/rTl3ZLV4TDqbR0iApij3yZEA1dATqWt7hFVGfCHOY0=; b=V
	fXUHIf++HTrtPc4dVzqII4XxBnKw/qYBaJC2t3OXjx7AKavEB+8uTnAfDPUHNn8o
	S2DX0H9a7Qd8NC3i1Y32TXZCRbhKF5g0Jvm/lRwIG3MSL3Ztg3El6TZCbtXqXUH2
	InMeyrMexf66OOYoNvijV0f+vCqjCFA34LdDARmhBlE2dhKaaiOmDlKR3TipHgFp
	mJbbqNPiY0besh4fiJ1t2uWugpMaLWZY3GfZk4CFegP4M/8GJxPdFYZW5BqXoAk/
	+NRd/OO8z1T99Iz56vxk0jktD8LNq15ONdaA4slDoBH0sJTGTqeUf9IbPbjg6TAM
	Dr6IV1EObJ1SaaAb8wUCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1757761062; x=1757847462; bh=/
	rTl3ZLV4TDqbR0iApij3yZEA1dATqWt7hFVGfCHOY0=; b=mPpig+VkQJ+x1tEuA
	vISC8Ozrnzh6gP6j5LOTtQb+9wboo1MF3U3CtLjXXU0GmknKPT8BfZgxaEAOhSiN
	I/yR4bxdf3W6p+24NtEW3a8PqzZd/jKXDOUd4M1ZbG7DWGQi0gUe+r/OJKiy6Kua
	Xqn8yjzaShcrglyK9DhNrX20e05dUls0BBUpeovffxcaFeqM5u2wIzG7nsFtkT7/
	c8+a6EgzBlkHMmW9k6fO8hnqfEv5gvBb1E5xi83zk3cwKHRXUU0wPz7cvIzyWuNl
	0kR2yMn+on01Szlv8pBCDysF14DhZVqR81zH2Pdhy1zKv2kCz9WreGL764+aQYhA
	9GeUg==
X-ME-Sender: <xms:Jk7FaDb3hPSIdinfCWu8TKmSG93GczZrBsFpBvGFPqRXUTc0C4XAMw>
    <xme:Jk7FaLVDRjaY4HiD6CCnhzORFFPtxV6mgeYbD63fNxCLfZ3dDQRB7CadEaptLxOCS
    pbL38kWSGcfG0eRI-M>
X-ME-Received: <xmr:Jk7FaH5dMzt241F75jHYPfgdyAbRhHDzDFpd_CeLytDT7hgu-92IYVnupOl1zagEtHm5X_YZ1akyNuJKFNIMxxA3DcswIb7QPe2oBh2m1uSFeg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefudejgecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:Jk7FaGi1mqpDkJJKrOElOvCr97rzi6S_TeNmzo4QnscUpSN7GyULug>
    <xmx:Jk7FaOekjMClzqHGjzyvK8NUG2SipJmGp4qyK2Z0Bk4izdSj67fZ8Q>
    <xmx:Jk7FaLfIe-MMht4KxdW2mapcRdOaKhhAKCee7C4orKZJ4iyutV3Fvg>
    <xmx:Jk7FaI9jh7XvxBpvqoPWrift9BMoe9SaQNXsgo7bZ7TmFXSCZBh8MQ>
    <xmx:Jk7FaJfowPJHjS8TVAOFxYIl4XhV10a4hfmHrCl-_6RADk3x9j_G4oaY>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 13 Sep 2025 06:57:41 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] firewire: core: use macro expression for gap count mismatch
Date: Sat, 13 Sep 2025 19:57:36 +0900
Message-ID: <20250913105737.778038-2-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250913105737.778038-1-o-takashi@sakamocchi.jp>
References: <20250913105737.778038-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The gap_count field is assigned to zero when mismatch is detected. In such
case, the macro expression is preferable since it is easy to understand
the situation.

This commit applies the idea.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-card.c     | 2 +-
 drivers/firewire/core-topology.c | 2 +-
 drivers/firewire/core.h          | 3 +++
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/firewire/core-card.c b/drivers/firewire/core-card.c
index 32cf6b3344cd..bf2e7f55b83e 100644
--- a/drivers/firewire/core-card.c
+++ b/drivers/firewire/core-card.c
@@ -425,7 +425,7 @@ static void bm_work(struct work_struct *work)
 	 */
 	card->bm_generation = generation;
 
-	if (card->gap_count == 0) {
+	if (card->gap_count == GAP_COUNT_MISMATCHED) {
 		/*
 		 * If self IDs have inconsistent gap counts, do a
 		 * bus reset ASAP. The config rom read might never
diff --git a/drivers/firewire/core-topology.c b/drivers/firewire/core-topology.c
index 74a6aa7d8cc9..5f8fb1201d80 100644
--- a/drivers/firewire/core-topology.c
+++ b/drivers/firewire/core-topology.c
@@ -241,7 +241,7 @@ static struct fw_node *build_tree(struct fw_card *card, const u32 *sid, int self
 		// If PHYs report different gap counts, set an invalid count which will force a gap
 		// count reconfiguration and a reset.
 		if (phy_packet_self_id_zero_get_gap_count(self_id_sequence[0]) != gap_count)
-			gap_count = 0;
+			gap_count = GAP_COUNT_MISMATCHED;
 
 		update_hop_count(node);
 
diff --git a/drivers/firewire/core.h b/drivers/firewire/core.h
index 083e39034c37..79eb57fd5812 100644
--- a/drivers/firewire/core.h
+++ b/drivers/firewire/core.h
@@ -27,6 +27,9 @@ struct fw_packet;
 
 /* -card */
 
+// This is the arbitrary value we use to indicate a mismatched gap count.
+#define GAP_COUNT_MISMATCHED	0
+
 extern __printf(2, 3)
 void fw_err(const struct fw_card *card, const char *fmt, ...);
 extern __printf(2, 3)
-- 
2.48.1


