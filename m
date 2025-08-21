Return-Path: <linux-kernel+bounces-778727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6DEB2E971
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 02:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86FD1688697
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 00:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03FD31F1505;
	Thu, 21 Aug 2025 00:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="ZatSAQS9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BOASutjh"
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667E01D516C
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 00:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755736230; cv=none; b=ndSNj3W4hqevOJH2ZSfpyhhGITkUweQZAl5G+3BljZNIncrtdO58tqVAkKWomxTm9nYz+Yy/U0VT2/D1Q/KZMS8J9/zdgPTAYGkqtTH0Ze8xvCtnzuZV6FURtyxjuu+cN+VaEOQblbKswRuDRLuCYoUOWyB6N3/TuImQluwToAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755736230; c=relaxed/simple;
	bh=7/52hrzDnwKKHNOyhvLcGtSWxHlP5P1EZdABet1qIRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HblYtneenxZYhZKXz8/+OUUG3BIEVlaI+BlKUYfQkNyboKoahCyLW7nU5nBa2GlWynNAffyO9tWNMfJhlSNTX+QLR8len+6mJIUZ9FDQBGONFLCL7IZw2ylF7XLiVBdxLeIL67IiKKi1NbWRvPy76iESb16X59vqfEBGnMUv8Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=ZatSAQS9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BOASutjh; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7F0FD14000BE;
	Wed, 20 Aug 2025 20:30:27 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 20 Aug 2025 20:30:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1755736227; x=
	1755822627; bh=Y3gqU4SmbBblagmxLkKgp6Bptdbd0oMAoCphalQECBI=; b=Z
	atSAQS9CSedBqwhF/YHndWSgZj5FaOHiGmKFGR703WQekQUKt7wEhZPXD6geUX9y
	kefKFQ9cv0rS4SZ3g4rJRlofDEcn8VyZ9bSmjztftREhes+0wACXbRArqj1S4VCd
	DijW3hFPb1IPT2+7/6VA+rcBMhlc9vv0HuUEGxPiFULmXUEQzINVNRhqYVpTNHgc
	9Vt3id3ydr+v03Mey4LKA2OX24etg0Qd6AJYacLaHCdT+of8hDRhYXLiaqU+QX6g
	CBluBw/nhTxPlFIFvQ9nPcST3uT69UKJY2tonRb5TzyOSa969pnFmFVxqRcHcTmO
	pEAHTUJB/8WmfhEpsoJ4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1755736227; x=1755822627; bh=Y
	3gqU4SmbBblagmxLkKgp6Bptdbd0oMAoCphalQECBI=; b=BOASutjhosW6V0JB0
	/00WsVVgy6RJVt4CPgnsXjNMXEPMH8N5T6CZYOlUR9ciQDd+s/MzaSAACIuE4IQM
	8dIFeZTplcUVbE8mxX56S2P5zg++raog0Xo+IBFjIXhk8fHcT2RW9H0HU4F/GAXJ
	rwBZzJ7s8MgYvQKtv1tmQwCvhA3t5+Knqt+DGQiy5iNStTKaWvCGM3LSJ5Tpt3tA
	Zk0uxSlzuGWTAREJGUO5+2CyWeg2yoenXCMvVrMRQrygqbuDXWnJTlj69CXrNhv8
	pS5bM/AqENooMiDqU8iomt6JmOJhpjYq1cB3IaWQRlr3xZr05EAb/ZkP7Jlo97j2
	b2z4A==
X-ME-Sender: <xms:o2imaKqcuYBcSlJQv0FRqbA5Vzf6LqRG3xBoVMaF8LSKwjYkj96_nw>
    <xme:o2imaBnuRlQM0svr3LjcVixDoHqaqatzqPEazAwAR07857uysFy2B67oLMKbGNqtf
    HhPVfwxjPBv1h5VEeU>
X-ME-Received: <xmr:o2imaBLCwWbh6XiItLJ4dG6ODmc2F7qoEzE6ACnL7B2sefEd6fo0cYYww9BHxGzAZG91CUCwOvLbMREaBKZ0mqOVxivnCcrcFDEo2KfH_UZ36Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheelkeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghs
    hhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgjeeuvd
    fguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushhtvghr
    ufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhisehsrg
    hkrghmohgttghhihdrjhhppdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehlihhnuhigudefleegqdguvghvvghlsehlihhsthhsrdhsohhurh
    gtvghfohhrghgvrdhnvghtpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:o2imaGyACDVa2DnvXBtDgs-VIIh0qnANrM_IHe1xNIHKhww47iNItw>
    <xmx:o2imaJutYfUwEIm794xuvxUWVrIKOdJ78qFCN7C9S7--_6t0fl1a9g>
    <xmx:o2imaFs18uVK4MIhQDG6yZktu8H9jR_D091WwzUEIDZvcx042aHzmA>
    <xmx:o2imaGP9voZ_6TZwzSFDhZOiNETZoU2jGUnzmJ8FaRDiKWfM0Bg2qw>
    <xmx:o2imaKu4hhaaLk9bKKxdPjD6Sh4FYD3SEqNggCeVR5zM6QZ-LO7HB-gg>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Aug 2025 20:30:26 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] firewire: ohci: remove obsolete module-level debug parameter
Date: Thu, 21 Aug 2025 09:30:17 +0900
Message-ID: <20250821003017.186752-5-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250821003017.186752-1-o-takashi@sakamocchi.jp>
References: <20250821003017.186752-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The module-level debug parameter was added in v2.6.26 by a commit
ad3c0fe8b8d16 ("firewire: debug interrupt events"). Its functionality
has long been superseded by tracepoints.

This commit removes the module parameter, bye.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/ohci.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index ae7f75fade8d..c8c5d598e3c8 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -393,11 +393,6 @@ MODULE_PARM_DESC(quirks, "Chip quirks (default = 0"
 	", IR wake unreliable = "	__stringify(QUIRK_IR_WAKE)
 	")");
 
-static int param_debug;
-module_param_named(debug, param_debug, int, 0644);
-MODULE_PARM_DESC(debug, "Verbose logging, deprecated in v6.11 kernel or later. (default = 0"
-	", or a combination, or all = -1)");
-
 static bool param_remote_dma;
 module_param_named(remote_dma, param_remote_dma, bool, 0444);
 MODULE_PARM_DESC(remote_dma, "Enable unfiltered remote DMA (default = N)");
@@ -2017,11 +2012,6 @@ static irqreturn_t irq_handler(int irq, void *data)
 	if (!event || !~event)
 		return IRQ_NONE;
 
-	if (unlikely(param_debug > 0)) {
-		dev_notice_ratelimited(ohci->card.device,
-				       "The debug parameter is superseded by tracepoints events, and deprecated.");
-	}
-
 	/*
 	 * busReset and postedWriteErr events must not be cleared yet
 	 * (OHCI 1.1 clauses 7.2.3.2 and 13.2.8.1)
-- 
2.48.1


