Return-Path: <linux-kernel+bounces-823779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5155B876D3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 01:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60B4B625D1E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 23:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B73C2BEFF9;
	Thu, 18 Sep 2025 23:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="c38uZGiB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B37X+xSf"
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE0D20C488
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 23:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758239696; cv=none; b=uds7NSGyG4dahnkz5AXYVYsYV0mB9SWGc1ghQSRn44q+hlzwwka7km8MgL7Cgw2SGhHQsfTgc1KTT4xZzLSRKzIc6AuOq/9ioNYXNS5/nvVoNAfPCfINCx/E/VI9N4BlDKc2FwdUmHwEY0py7fk5sU5OWRCFuWN5XWs8AfcLM0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758239696; c=relaxed/simple;
	bh=SaMhrXY4ROVt7GFlmLm/qxTHJtT+uMbdM59hXVeaRIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OXD2s591301vWry6NfDSAXW+z8VY7dvUSN6Ck0cFXS7I2ZoW2stSTJ5QPXwEqHkAt8Zg5kJ/rBvM4cFkkjyPjCd5BXRna5ebWLrsonM8KBDXAJ//rzqS/hp/V9PsHp0OXmwonXKj/KKStBG+6Nhkph6SmJKRps8HUtnbd5R7Www=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=c38uZGiB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B37X+xSf; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 8B8EA1D0028E;
	Thu, 18 Sep 2025 19:54:53 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 18 Sep 2025 19:54:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1758239693; x=
	1758326093; bh=ejd4z6Y74LQMHrIhXYwar2zF5r9qzO6yTwePlxELzOg=; b=c
	38uZGiBuk9pBkBw+iaAnut3EnYTKzdvVVb3R/OcQOckbqcphKU/xGyk9a8pnKkkI
	S/OgPJpfN2Lrf2AO0jH80hati/Fv9ZnX79uWirpeHM/UO1OA/jdKpxv4jtXEgTDO
	tdNyO9qXjSh42XTBrE5kLK+lPf3mSf8VoJZC08AgjdS9YjSgQ5KdFLwT5kNknFhg
	GWlVQhxLbvCBuAt4iLYoaiDTSWSXFfzqXBB9s2szSEcw7IOWLV5U8QgzRKI5KT2t
	kBxcTc7gFK0Kq3yq1ZO8RouXj4ghpuFViG13MG9ITqDIV2k9BTToRYmQL/fKqP8q
	RwLCYnV4VEEUtOr0r54jQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1758239693; x=1758326093; bh=e
	jd4z6Y74LQMHrIhXYwar2zF5r9qzO6yTwePlxELzOg=; b=B37X+xSf/fCZHX8Yu
	ZKNFow/EfEiZgXng1bJaRC8zg8enbQkoJtjbdg3GOpZ2IPshgiQ967QhqWvf+zXA
	TkAPoqqVb7jDBLLn1MsZcdzaTuljNefjsrj3CrKHLPB1Pgd7JJBwNy+OgLql79UL
	Hd1diPewM4sOTOJN7yi/U8DINeoAsv0ORQUd0CRNYZa5RG3OrXSf3gTgwM6BY7k3
	MwM3Bfw4Nwm5hEHXucLtoHGv4nrSuQMoNsgUAZKltdvydEYkELmn0ldzyNT0qa3I
	3YENndllSCHZ9EXYmQ/emHdMuGtfT9GBwhYBrNC91bg6/D8vtksa/z2uJjg6Rzdv
	OMo6g==
X-ME-Sender: <xms:zZvMaJchoTj2n98wXG6-oRoYNdoL4Jo8TeWwZ4_JE1jy-FXLBEdIHg>
    <xme:zZvMaAJ1w7OIsjVFECZeBl5yxVLKJoP2RaGiqxJiKlY3dbVB1dpu1o4oaD6RsVa2T
    KnR1Uqua1lcEefKQrk>
X-ME-Received: <xmr:zZvMaEeJyFzw2qe14aeiWwAQkCCNrRjwTEo_Up8Gfd10ex1P-LzABeBDi5VxxUX-fhikEE-NyPzG553s7RcMx1v2L8RfWL6dDPJhaKGzEwOjgyk>
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
X-ME-Proxy: <xmx:zZvMaP3vwKc1XDjKJNp1z3u1bECAYlpFrJwxuNCKp1ONEcO-X8eSsw>
    <xmx:zZvMaFh00RlyU6ZAO42_4h4HMj_XnP1LwCY3BPYh8W7MUEr6U1xbwQ>
    <xmx:zZvMaNShU_KA4hEFUyaX8b39_Rgw6g6LZF_7OCtaPLHy1a-Du2f__g>
    <xmx:zZvMaOjiOkHoOWcY7qYSojcYKdBlo4zwB0hMFr34l1b-dIVENpfRag>
    <xmx:zZvMaMAwJe93aoU7oJQoiL7LnUt4UBkNujVaKKUatf4soVX-i7ig9Byv>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Sep 2025 19:54:52 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/6] firewire: core: remove useless generation check
Date: Fri, 19 Sep 2025 08:54:43 +0900
Message-ID: <20250918235448.129705-2-o-takashi@sakamocchi.jp>
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


