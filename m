Return-Path: <linux-kernel+bounces-870662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 782B3C0B64B
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 23:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E90C94EC8FD
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 22:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DE72FE585;
	Sun, 26 Oct 2025 22:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KaeTssaF"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA3119ADBA;
	Sun, 26 Oct 2025 22:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761518765; cv=none; b=H3eklkMFFyhlrVxRCYr3RKRSAKuhO6DWXJR6aY5As/ztT9zBXIq1iNRbp9uFzxaGly+a0v98GDNGJUq9r8o8KYDnuWa9zyyt2ImgcYMX/5AIHPYkFJpoTdkVgfkLn/8WElBd3sUkSlyJCstrwVB7D5raCZtRmYBcdd0yH588uNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761518765; c=relaxed/simple;
	bh=vzhdlIEpMd8preAq8V1PLePe1CE7+wRDXt2mnICYPZw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=huLd28hhDtd49eXu4laLbXjOyRqFrCcxRMNPedaJMDSPf2M/0mWWgHK44T5rPlFtoJR54M3798CnG7zbpb/nRne/WxjRBAG98h1WvEBWQaE5rDec7bLGbYkiicaBdvdtzr9GZhL5x0TSRH7r9U8LAJBiO+QVQIM/RkcTH9sr3Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KaeTssaF; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=kUUg7bDoLdltv7gMj6VVQ6B15kLbNGELqY0MsOWmwu0=; b=KaeTssaFzqVfUi/sZGHvoxzYY4
	+NGDBAqn5tOYcaAJndOuVqxPPkEuBWt9kFkevKEvR2oZbcSC5hwTgE7srVVEcrtOM1ZblxaffJxUe
	UJ3vQyahrZCVngZqdzkYwhQlPkoiv5OG8Rv4azM3DBtefYPKdkHX6e2CSMJHGrEaw06LRzgjQux/T
	46M14aqV94b+pwejHmOSy9k2LzM2Oxmz18DAP+m3meVu7SMDGFNcdadyRPVlBiSgBJi1DS7MZWl3b
	71AOZtwjhIdB3dGRWA6W+VZaLk91TUuG1nmaEwCFkB1K9GG0WVvEis1TO76jZ0SFPjyUKfho9n7TR
	5c4Z00Gg==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vD9Ut-0000000CpNa-1kIU;
	Sun, 26 Oct 2025 22:45:59 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Chunfeng Yun <chunfeng.yun@mediatek.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-usb@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH 1/2] usb: mtu3: fix misspelled words
Date: Sun, 26 Oct 2025 15:45:57 -0700
Message-ID: <20251026224558.826143-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix spelling errors as reported by codespell.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mediatek@lists.infradead.org
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-usb@vger.kernel.org
Cc: linux-doc@vger.kernel.org
---
 drivers/usb/mtu3/mtu3.h      |    4 ++--
 drivers/usb/mtu3/mtu3_core.c |    2 +-
 drivers/usb/mtu3/mtu3_qmu.c  |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

--- linux-next.orig/drivers/usb/mtu3/mtu3_core.c
+++ linux-next/drivers/usb/mtu3/mtu3_core.c
@@ -290,7 +290,7 @@ static void mtu3_csr_init(struct mtu3 *m
 
 	/* delay about 0.1us from detecting reset to send chirp-K */
 	mtu3_clrbits(mbase, U3D_LINK_RESET_INFO, WTCHRP_MSK);
-	/* enable automatical HWRW from L1 */
+	/* enable automatic HWRW from L1 */
 	mtu3_setbits(mbase, U3D_POWER_MANAGEMENT, LPM_HRWE);
 }
 
--- linux-next.orig/drivers/usb/mtu3/mtu3.h
+++ linux-next/drivers/usb/mtu3/mtu3.h
@@ -76,7 +76,7 @@ struct mtu3_request;
 
 /**
  * Normally the device works on HS or SS, to simplify fifo management,
- * devide fifo into some 512B parts, use bitmap to manage it; And
+ * divide fifo into some 512B parts, use bitmap to manage it; And
  * 128 bits size of bitmap is large enough, that means it can manage
  * up to 64KB fifo size.
  * NOTE: MTU3_EP_FIFO_UNIT should be power of two
@@ -121,7 +121,7 @@ enum mtu3_g_ep0_state {
 };
 
 /**
- * MTU3_DR_FORCE_NONE: automatically switch host and periperal mode
+ * MTU3_DR_FORCE_NONE: automatically switch host and peripheral mode
  *		by IDPIN signal.
  * MTU3_DR_FORCE_HOST: force to enter host mode and override OTG
  *		IDPIN signal.
--- linux-next.orig/drivers/usb/mtu3/mtu3_qmu.c
+++ linux-next/drivers/usb/mtu3/mtu3_qmu.c
@@ -221,7 +221,7 @@ static struct qmu_gpd *advance_deq_gpd(s
 	return ring->dequeue;
 }
 
-/* check if a ring is emtpy */
+/* check if a ring is empty */
 static bool gpd_ring_empty(struct mtu3_gpd_ring *ring)
 {
 	struct qmu_gpd *enq = ring->enqueue;

