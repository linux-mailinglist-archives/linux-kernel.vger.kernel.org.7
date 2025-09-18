Return-Path: <linux-kernel+bounces-823726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E376FB8752E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 01:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 450E77E4332
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 23:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBFE92FBE1C;
	Thu, 18 Sep 2025 23:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="fasvvCTm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mHRS8UTF"
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BF9285404
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 23:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758236949; cv=none; b=L8CyUlvmmys1a+4VzT9bQsRsVWhFf29p+i0Mp2+A/5ia+nQL7Rvi9ueU3AEw8mYEHU+ZRcC87ovIo3xe91c5/vnEr/bA99oAWie4+BWdZU0vSyZFVPG5I13uH5iWqB5gmP9ph+VSYFBAlCwsSwAJp6M0TRApFTbK5NGetxOvebw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758236949; c=relaxed/simple;
	bh=UMMxmPgQwssZS4e1o+79eVN0EoB4UA7jX6vcpvX8PL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sItLgrCu3CtiL2QIi2261TqIo8ZCfawZaR1an+bkL4a5SQnGgmV07YRdUF2ht1q7JtLDNyVjEqaQSdUcxp/teIPwC0OjalJMjTF3N/QwsMqLRV/nBYJtnB72gh1qPM3vMGALHxmDpr2ILEIq2Ow8Ti+SvlmmwNez0DxJIyaa/tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=fasvvCTm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mHRS8UTF; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 1FDA41D002D6;
	Thu, 18 Sep 2025 19:09:06 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 18 Sep 2025 19:09:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1758236945; x=
	1758323345; bh=1bhCuPFgP4C1oxsw4LyiUdUqGNWaw/azPwPIYtQV6D8=; b=f
	asvvCTm+9KHFmKMnoYAzin9td+QeKi2F4e8OGE8+B0xtLVsu0ESa4WRWoat9p+t/
	OM+/4wWiYzqRMz2LmkmyPkRwqFSovtyyb19ox7TkWwHI9z656u3zjo+2bRPDjyhM
	5MOXxk6nSsljh7WsI3UEOsXu5Wj8tbh5l4B6Oy4+DmiT5aTTKvuVdhunzZd0HdZK
	jMsG0kaqcI02v+oagi9VcUvYpz/W6BFhmaCLMi+5STOxnpZ/lNiS/bZVTkY6PmJT
	SbbQYqwmzhZ9jOjh0tfvVK78T2ejs8zP3qRQ/xZb5KDJhvDj0z8doqzp8LGBXfpz
	N4Rrez1QpTOa/7Nsde51Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1758236945; x=1758323345; bh=1
	bhCuPFgP4C1oxsw4LyiUdUqGNWaw/azPwPIYtQV6D8=; b=mHRS8UTFbfP8EnZAo
	9zuaaWrwB+iv9gYShO98xqAHyuhAOcCQ4a+2y2UGZpPdJpeU+8Kqe+0H4JBXqI0L
	7OK6/LTrx9vmxrm++JcJmaJ60QdoiLoKAoWDGPYWn3TRZhSqiA1nlctvTZ2KGRod
	S8bkMfc2+kWhBM6efPK3yd2rDAkBxP4zjd2uFlmIQBuEQNRxK4Kyvu229HFDHtmT
	WS8dbWw9FdcWNxNkFuswSgrkN5WPmRSVo5+rFuXPtLPGr5SANaT/RoAtw8ONgI/Z
	2v7tpwUUmGp4dITYi7S7nASd+6BOqN5L88be7pJGkLryZXQ+YkxRa8LkUsZiIwVN
	xCVMg==
X-ME-Sender: <xms:EZHMaF8y3SBjeLlzfBv_yyN5kdo1ZZ8z6N70FJNWxYFeeffEMlCVeg>
    <xme:EZHMaCpKynTUMArmFDXUSdWJmSNlmCAFGvZdEVJotQpNx6u249LyeKnlGvGnOrSLF
    jlqs1k6wRJtyBhgJpI>
X-ME-Received: <xmr:EZHMaE87E-F2lAu3I5EGH5UK5zDcC0OFnRPrJO3LZ7QhyfG3monhGwKiO4BZNiGwGhFFsVMgXo99fcZfS3-0yGNtmWeDkDLiUxc9VFBJEhtiigE>
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
X-ME-Proxy: <xmx:EZHMaGXt4SZG1Zurts0QnN8nfxOZk7njcX3al6NCWQ0u1ZsIvvsuYA>
    <xmx:EZHMaKDJaKp2dohZCuqbzbB_p013y70DArbYbmxFFlkqDrCIJEDjiQ>
    <xmx:EZHMaHyhwYeqgSJSzIwj8VTFfvW0xIEs9zHJeKzKNIlCheYuMb9P5A>
    <xmx:EZHMaHCtoROFBx4h-CYlpm-XxDXfT1HJMN3ERhbtQFxMH2_XDkXJPA>
    <xmx:EZHMaMjt8aI4LRToaeoFScg4b21YKdYsTHO2IM02-yObDXCYjFSrmERV>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Sep 2025 19:09:04 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] firewire: core: use switch statement to evaluate transaction result to CSR_BUS_MANAGER_ID
Date: Fri, 19 Sep 2025 08:08:53 +0900
Message-ID: <20250918230857.127400-3-o-takashi@sakamocchi.jp>
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

The result of the lock transaction to swap bus manager on isochronous
resource manager looks like an ad-hoc style. It is hard to read.

This commit uses switch statement to evaluate the result.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-card.c | 50 +++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 26 deletions(-)

diff --git a/drivers/firewire/core-card.c b/drivers/firewire/core-card.c
index ef00125fb01a..e9bf8d93f5b7 100644
--- a/drivers/firewire/core-card.c
+++ b/drivers/firewire/core-card.c
@@ -355,11 +355,18 @@ static void bm_work(struct work_struct *work)
 				CSR_REGISTER_BASE + CSR_BUS_MANAGER_ID,
 				data, sizeof(data));
 
-		// Another bus reset, BM work has been rescheduled.
-		if (rcode == RCODE_GENERATION)
+		switch (rcode) {
+		case RCODE_GENERATION:
+			// Another bus reset, BM work has been rescheduled.
 			return;
-
-		if (rcode == RCODE_COMPLETE) {
+		case RCODE_SEND_ERROR:
+			// We have been unable to send the lock request due to
+			// some local problem.  Let's try again later and hope
+			// that the problem has gone away by then.
+			fw_schedule_bm_work(card, msecs_to_jiffies(125));
+			return;
+		case RCODE_COMPLETE:
+		{
 			int bm_id = be32_to_cpu(data[0]);
 
 			// Used by cdev layer for "struct fw_cdev_event_bus_reset".
@@ -376,29 +383,20 @@ static void bm_work(struct work_struct *work)
 					allocate_broadcast_channel(card, generation);
 				return;
 			}
+			break;
 		}
-
-		if (rcode == RCODE_SEND_ERROR) {
-			/*
-			 * We have been unable to send the lock request due to
-			 * some local problem.  Let's try again later and hope
-			 * that the problem has gone away by then.
-			 */
-			fw_schedule_bm_work(card, msecs_to_jiffies(125));
-			return;
-		}
-
-		if (rcode != RCODE_COMPLETE && !keep_this_irm) {
-			/*
-			 * The lock request failed, maybe the IRM
-			 * isn't really IRM capable after all. Let's
-			 * do a bus reset and pick the local node as
-			 * root, and thus, IRM.
-			 */
-			new_root_id = local_id;
-			fw_notice(card, "BM lock failed (%s), making local node (%02x) root\n",
-				  fw_rcode_string(rcode), new_root_id);
-			goto pick_me;
+		default:
+			if (!keep_this_irm) {
+				// The lock request failed, maybe the IRM
+				// isn't really IRM capable after all. Let's
+				// do a bus reset and pick the local node as
+				// root, and thus, IRM.
+				new_root_id = local_id;
+				fw_notice(card, "BM lock failed (%s), making local node (%02x) root\n",
+					  fw_rcode_string(rcode), new_root_id);
+				goto pick_me;
+			}
+			break;
 		}
 	} else if (card->bm_generation != generation) {
 		/*
-- 
2.48.1


