Return-Path: <linux-kernel+bounces-823725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8E9B8752B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 01:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F6087E41CF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 23:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A2C2E6CCC;
	Thu, 18 Sep 2025 23:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="DSKoN2Xm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CrIA6jhC"
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895F628488F
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 23:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758236947; cv=none; b=YD6e8hKKYYF1rMf/FUWA7UAESvm73rNggspGtUkI8gL5XwIcUSXRB1XWyF/pOr2rBsv8PRR11tWrf/pozN0R7Kmj/HqBRQg6XydAbkbqEGV0uWEwyEMuw4quEbhqootTtUEbgepl0GG9uP7OUGyI8OtWlgYU1UYui9EpeKGNlDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758236947; c=relaxed/simple;
	bh=SaMhrXY4ROVt7GFlmLm/qxTHJtT+uMbdM59hXVeaRIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=esdEuWBHwS8xDZk/JpMQ1LC8fuWDrAkBNCkOOBFNmkEY1clL40/OKLKnvTxkmdTVxjHuBB4ByagGIwVVaV0kf2m6zcVsUiFiZHgchAw4XBvKpE+j28XKcac8Z77eHCcMF33hMjfxR0rJCBlZYF258nxeDVr+f9OSeyLvTn7dFFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=DSKoN2Xm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CrIA6jhC; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 911667A02F8;
	Thu, 18 Sep 2025 19:09:04 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 18 Sep 2025 19:09:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1758236944; x=
	1758323344; bh=ejd4z6Y74LQMHrIhXYwar2zF5r9qzO6yTwePlxELzOg=; b=D
	SKoN2XmwFgtTRw/nPdlG+86H3qTbMSbZq6VyTy9VRjFpCCMK5CkQE7SFCYybtaJP
	RrSvdC7uxk0pcApCdaqTiX6OnlG9XppAhHBByJAfGTenws8T0vMr85pdrjL4TeT+
	j4/OBP23gDmjslAbePQSwDUfXwSQLsEmn+uZvO8/jU1ivllERKwAiOFoUECwtMeB
	vzaneqPpw8sFQQRP32+p7Qr8z0uO1ED+UVC0xlbYiyDXR51aYVAAmWWk0FBissLr
	Op9lGsM8QIF1e/3VySlKafL+qfznWetj3UFxA104ZIaKvB3dblyWZiG8edBF+ULA
	Hr9faY52EwYM3aSb3rZiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1758236944; x=1758323344; bh=e
	jd4z6Y74LQMHrIhXYwar2zF5r9qzO6yTwePlxELzOg=; b=CrIA6jhCsY/BxMck5
	ZPXroNW9UiQjAAPmfem7Sb6nUt5Kck+biSMOV62cggUrn/YNF9qom3jjeyTXGTIN
	hNad82VeJ/W2VZ/WxsXMYz/VlDeKow4kXU8EFp2Nz4SuxhT8WtcAeEtElFxu5gG9
	X/YLgm+Klxw/FI5zZLq3SfcY5w7k5JVTyjaai4Eg8tBbZF3atlfPi8V6xzenhpbs
	xSRhrDY3ZmjW8OI79YMpx+SZQAEo31BeG0GYd+L4+48792Qziv49AVo+a5yR9DT9
	OnmkPttLufBr542gac5hYPGoxIuAIwpjg2k2OR+6EIkqw41QZwYRZt4vB8684DiW
	0vD+Q==
X-ME-Sender: <xms:EJHMaHlR7DUTyoqz0YMs4-gqVQMIubpU-pdyisvaijVb1H_5fhufFA>
    <xme:EJHMaDzkIzpAdpcdn6icjHxuglv3w9o03KXp6WxZjLEOfdsidCnWfKd-lVX3NMh7t
    AMaYR7pAdNSf3uFP2M>
X-ME-Received: <xmr:EJHMaPkAPg31a3G9N0hKFlcWpDQMWqjt6atDWT1K7HI6fnjhKn2YGBcPXQXqVKAe-BRI6H5psibRB70AP6MAXYnJSxa3-qSYZi_4p1h-peMcka8>
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
X-ME-Proxy: <xmx:EJHMaMfSZgfE7crULodLH7b7sWRuTu6LEG_zatSD1PRys0c4jPlDzw>
    <xmx:EJHMaFqAbBsJrPOWKJyR2j6bEIcuRG3dc1HCWIdXDWNUbjIZwfCZCQ>
    <xmx:EJHMaK6K-buK3fx6zXpUFF_jpRuR3BvOr_s1IrH8Jxd1lSoSMcf-hw>
    <xmx:EJHMaLrjCuEyfIwDOC6uAl--SSsTX8rB0ubYCjstgA8_6IMe_2jI5Q>
    <xmx:EJHMaDINeqGrqRvWGgxeA7VarVoNIKcbo4f3-VPNacZm_0FK9dcMNErg>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Sep 2025 19:09:03 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] firewire: core: remove useless generation check
Date: Fri, 19 Sep 2025 08:08:52 +0900
Message-ID: <20250918230857.127400-2-o-takashi@sakamocchi.jp>
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

Two functions, fw_core_handle_bus_reset() and bm_work(), are serialized
by a commit 3d91fd440cc7 ("firewire: core: disable bus management work
temporarily during updating topology"). Therefore the generation member
of fw_card is immutable in bm_work().

This commit removes useless generation check in bm_work().

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-card.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/firewire/core-card.c b/drivers/firewire/core-card.c
index 4fcd5ce4b2ce..ef00125fb01a 100644
--- a/drivers/firewire/core-card.c
+++ b/drivers/firewire/core-card.c
@@ -362,14 +362,12 @@ static void bm_work(struct work_struct *work)
 		if (rcode == RCODE_COMPLETE) {
 			int bm_id = be32_to_cpu(data[0]);
 
-			if (generation == card->generation) {
-				// Used by cdev layer for "struct fw_cdev_event_bus_reset".
-				scoped_guard(spinlock, &card->lock) {
-					if (bm_id != BUS_MANAGER_ID_NOT_REGISTERED)
-						card->bm_node_id = 0xffc0 & bm_id;
-					else
-						card->bm_node_id = local_id;
-				}
+			// Used by cdev layer for "struct fw_cdev_event_bus_reset".
+			scoped_guard(spinlock, &card->lock) {
+				if (bm_id != BUS_MANAGER_ID_NOT_REGISTERED)
+					card->bm_node_id = 0xffc0 & bm_id;
+				else
+					card->bm_node_id = local_id;
 			}
 
 			if (bm_id != BUS_MANAGER_ID_NOT_REGISTERED) {
-- 
2.48.1


