Return-Path: <linux-kernel+bounces-823784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1E5B876F1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 01:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB33F581E52
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 23:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA68F2F9D86;
	Thu, 18 Sep 2025 23:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="kB3PAg9q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PmSWAcG2"
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABB52F5A19
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 23:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758239704; cv=none; b=SmfAeBYy+LOwix6tBVGSOn6wus5QpBpzbVtVLi6KRi6R7XGlaCbYQXXHTS5qyNK/McW2ghvmiBWN2wamTRSwDPLTVYo3zkZhrkrqig6VRBq99qPVUqmABoJkIc+WnWfCfGhRkPEErrvYJ8wvDeLLznY3AOgd6gYgs35P8c5OYFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758239704; c=relaxed/simple;
	bh=uECkJXUPwFb7rYrOSXuFNLXpq3z/zzqrZrzZMpFEJs8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pHnErlq+J84CETifUPpfJEZokb4rvNO93kkGrHHRluCGyy/CCiQamC1r1ojyjZzw1/Gh1RT7i3qLUWdBHoXdjTkk8t36X2a8gZ13Wwyegb+FjsTGzntfQOpQABFIBZKYrybxqefesU/sdD0XggXCL5cQZzH8p8ANJB7g2nH9jWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=kB3PAg9q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PmSWAcG2; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 96D997A02DF;
	Thu, 18 Sep 2025 19:55:01 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 18 Sep 2025 19:55:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1758239701; x=
	1758326101; bh=xzYwZqfvPW6KOoTt5TjmQYlp4Q4mwY00/jLyNK2kg1E=; b=k
	B3PAg9qsv6oNBrBk+UkeJv18rGi1MwzulVq9eQVeGb/yjm72NDVV/kn86qs09Sbt
	tP5LY8iEVEBCa8hdsrTVk7phpuhh4g2zt6suBkJvWAfzNQ9WvGH/wrXiwSHm+Qpw
	TbV5x8y8c44E0y7+UDqXYnUp0pR8ubqrikEJYPI7fHYCLOhXk4zv0HYvGagZ2zT4
	GYK+JT1ksZrkPmZDNibObQr19/GkNoN3fcaFCLdHXD4vAiUlkrhL4eKY533/o2Qo
	tLyNb5MJ5dvdyeKhrKNagb8AmzizJe73aQJBt+i/GbAxzkk8GRPfuiolLss/ij+S
	EURCvhlPX6RbHbv/ILHRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1758239701; x=1758326101; bh=x
	zYwZqfvPW6KOoTt5TjmQYlp4Q4mwY00/jLyNK2kg1E=; b=PmSWAcG2BqkDxrtKL
	oIUplyKeBbFVNH+Y3CFCW3GBLERXYu8hK4Lg+fkaR3mzM6VJdH7Dat/8s20CDx3V
	fHN2p2IDsRvsQnIGDtR26ujjxa3cV9B0FOoyTd5tkONf/ZpaqRR7KB+jzVi/iFZe
	bKcBL06/Zsn79uF5cjHv6Z4hSGO5iSsxYIqlyhU8brgWes/fCM1gD9pkIH/YtkHG
	hq64ClGoLxh/akk0Ur2HnrKi8iK9DqWxYcZz1Mf44XiZ84T8WJMIBavh9FwyI6xC
	tn54H1cUTa6xwJrQk1QJXq7HSMl/1gp65+PcVqXmpKstyZmk3sZliQmU1vK4g0jw
	R7YBQ==
X-ME-Sender: <xms:1ZvMaJBDXmhlO1GueoBayFyDvGPSifRWrOAY9du3hvLt1dymny4zTg>
    <xme:1ZvMaAeiXDPFB_--A-UoyY4mRtwelsst38mjbgDfawTEpa7d_WxAfKJlyGepJZaab
    ZQoSDs_qkiubMtL5-Q>
X-ME-Received: <xmr:1ZvMaGgyDyZNOFqyF02yRXbt5qkOlGKDgVs8FKzSzxKUVvxE5WyAhESeV0-mVqUaJDFH6rNOpfV_0UJfi6S0lE53rBgrya3JUOZINCFT_YJd01I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegjeejtdcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:1ZvMaAqZNl-3NH2alHB2jC8bJk7-JmdSKkZjqU3g_7lQYiUP5XvG5g>
    <xmx:1ZvMaOEcyAp1MXpQ0iCgUf91a3bVdJFLPjcWOlQKX7fYxpt1XWb6tw>
    <xmx:1ZvMaCl6EFMfIVtLpZNCdcbW-frGIOwOj5g_qONUenjL13-i5Cbt8A>
    <xmx:1ZvMaBldW0DFDQnVOHqJBP9IgllgfQf5xxfzCC7fCH0GYA304ggxqQ>
    <xmx:1ZvMaEEPMfbTp4J8z48-62ION6oIqn-JZ30GDEvB6mqPx-APd20k07kI>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Sep 2025 19:55:00 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/6] firewire: core: minor code refactoring to delete useless local variable
Date: Fri, 19 Sep 2025 08:54:48 +0900
Message-ID: <20250918235448.129705-7-o-takashi@sakamocchi.jp>
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
index 58d1f58a4a0f..4a5459696093 100644
--- a/drivers/firewire/core-card.c
+++ b/drivers/firewire/core-card.c
@@ -387,7 +387,6 @@ static void bm_work(struct work_struct *work)
 	struct fw_node *root_node __free(node_unref) = NULL;
 	int root_id, new_root_id, irm_id, local_id;
 	int expected_gap_count, generation;
-	bool do_reset = false;
 	bool stand_for_root = false;
 
 	if (card->local_node == NULL)
@@ -499,16 +498,10 @@ static void bm_work(struct work_struct *work)
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


