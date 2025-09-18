Return-Path: <linux-kernel+bounces-823780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCCDB876EB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 01:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76DBA3A37C0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 23:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09E82D7801;
	Thu, 18 Sep 2025 23:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="mtIq3rrA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RDVoz+Vj"
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E4127D782
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 23:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758239698; cv=none; b=FLK4OWfS0Gby8qoe4KDsVAh703LWqmbqnf6gwiJvH9jucl4w99lACK+i12+Alj/F0ig/Waq1ogPZcph6x/jB4TwSLWmtrDaUnm8omrvC6RcZftj6LW7QvAJznyavtO0crMzzvG8g+YYGl0HLg9aduO6R5jwIw1AHInWHa+x0pMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758239698; c=relaxed/simple;
	bh=UMMxmPgQwssZS4e1o+79eVN0EoB4UA7jX6vcpvX8PL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U7tBFKgaBVdp+/8Tywg0TmsgoMbwwO4wpfXhdG/IHrVRssakLxlGvzEW33KbbqX0SrVho6Y6N1GbQShzqTr+Zm/dSiAZXvUGuL9/LvBjGx64aebRszRlQrO0ySRDVJ28BNhJ1YeGDFJuO+76aDsyl+qrGz2VLZ6y4sbwLbLQeKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=mtIq3rrA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RDVoz+Vj; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 37A357A02DF;
	Thu, 18 Sep 2025 19:54:55 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 18 Sep 2025 19:54:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1758239695; x=
	1758326095; bh=1bhCuPFgP4C1oxsw4LyiUdUqGNWaw/azPwPIYtQV6D8=; b=m
	tIq3rrAQrUx7B9fdBE/FbgrXer2ML5Hsti69lgaME/GvkWdbJl5hXsCs7f1gCMmB
	bEJ7uDwka/r/QcMNWwfgOoXDMCdfIcm1O+6Qyp0adxqy/2+ush1fbeVtd9RO9MDh
	2NpgJwVfD7+ZsLAT872tuXhXnevw8p9cdjZwqD9FzwasHdhAo9XGawtmT7JMKIDZ
	x9/23Dw5CPMyPfRd8vahYRUyUeEtGIgHFNSyZzyTS6zSLbU5nru9PG+/A2ws/Q2c
	8zqpEGkXVgJ8yXfoq4N5BCGPY4zGbrTxsSYHiBzABRechUAamYvwVVSVPiRhNPsK
	qq4iAJt65OerqAj1OalFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1758239695; x=1758326095; bh=1
	bhCuPFgP4C1oxsw4LyiUdUqGNWaw/azPwPIYtQV6D8=; b=RDVoz+VjfUVYE4QBV
	A8l3t3HvMC1GT7+r9u91DXdN5r2MZqHE2y1lJLg3DfKENkpE4CbWSnOU5Dc5OLuM
	LF7NPJaGUqNFLYONBN4dYS6SQQQZ1zVptLJ5EjXZDqmPC/Fh4iPueh6Xe+elR4h1
	hDIsf8eLu4J9DkLQwReSY96DTm+AVV8yTc5OwPhREajmoIMLDl0KPACiFzxqHLwF
	B41V0afJfwx30Cx85aQDIqMj4qZlqRexUqGSl5gl5p/g8sZ4VTJEETZBzxa9PC+j
	PrSVWUXTRWKqr5U/kd0V3rQSNqpW78YVu1pFtQ49s2wg40idKakKIarPWpKOuca6
	2Vx7g==
X-ME-Sender: <xms:zpvMaI2mNrEg_PydudTf3AVIuA0swi3uqK3lpC1w77Mg6g9OKHnacQ>
    <xme:zpvMaMAVqke09NVx9B77SypqiY6Gm8mYr0uOifEhL2lNEs14cSGqXLs0sPAVpLZlg
    uwoK_0xoK-wV_u2evU>
X-ME-Received: <xmr:zpvMaC2ujX0vEUfD6-pFW9TwREG1IOinw4DrWLtxfP65W0NdpLT48oxbyrNg9lFyNcdRHl4E_Y8o6rdR66QXXYazcHLxmKOEVfLqrzPNnqwxU_I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegjeejtdcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:zpvMaOtJ4DIk9yXLxfvKR5dUEqSzEAoxpV710yr8vpwqcW5h3ryX3g>
    <xmx:zpvMaK6SXswa9J7y2tI_jzqPuzBM1AxXwK-xYbk4EzZW0vR7FURmZw>
    <xmx:zpvMaHLQ8kxbX6xGZncNIyx95pnz0c33Pnmx8K478n1i-pV59xl5vA>
    <xmx:zpvMaC6wi9hSvuhJIwCfkX5LPOtwAC6i_bKCV2Tiqf2V3yUNjztIUw>
    <xmx:z5vMaOYBzlp9-Z7AtI4A_olFMTYriVYmomGfnOP_vtxSgNUC_EddMOb4>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Sep 2025 19:54:53 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/6] firewire: core: use switch statement to evaluate transaction result to CSR_BUS_MANAGER_ID
Date: Fri, 19 Sep 2025 08:54:44 +0900
Message-ID: <20250918235448.129705-3-o-takashi@sakamocchi.jp>
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


