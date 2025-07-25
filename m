Return-Path: <linux-kernel+bounces-745355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6259EB118D4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 09:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B76497B73E2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 07:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472A3BE65;
	Fri, 25 Jul 2025 07:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFt5F7lp"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7482046BA
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 07:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753427014; cv=none; b=agQhztb1PcDNqZ1q7+ka+EmlMvu3SZ8ficAYaEZCJAH/34ofWK5nM5Llude8yLmP+5trviXuUU5rMZgbcWfDHQ/8Q4OlfsAvEncIrDUNBe/XmeSYo0vap86wqzCj5XvCQRtieVqJXwOIzkCMWqIlUEJRDghdVTnAPlTIf1gR/Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753427014; c=relaxed/simple;
	bh=CQaTjNHCAXMgvRwlxy2NvS8FYwbY/dLHQrwix/z9FUc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YRRQZuO4rEgZglqMUiCEGl11xHZHx25usEvkqXILf+VK6Fzf7NxP1pWIz9KbsojqJJ0z6jCs2GHdUczoxV16syG8i4PeOGLsY8xcLlenWaSjr46AROEpMdrlHeusS+WWf/B1lKIXtz6zXKca0n6uHc0zeMgeTgesSlcCzvFxmJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FFt5F7lp; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-234b9dfb842so15582605ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 00:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753427011; x=1754031811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K6yO7IzaeHBSJlHJN9ngERptq/fpvKj+ephhcUYtT70=;
        b=FFt5F7lpH4H6tx8T6UFreWYhzzsc6uRu6B2wVMAeUyh+dlTDX1OahTNNwudHXaYHMr
         K5HPoHl6yho3zPPYZc4qTG7STg+YLoM1XrG40iUZWKzMmKf43i6mr60pO8iNg5OBpZAd
         zPqjO3Rj8p6ef1ZLo1oc1iEmMpZsVwJzvYE4HXAilKHvTZs0jyazKFbP8bGw2jOwrYt4
         nPcBxHz53jrfkzxIkvU+yw9hDeCU3Nkm6y2jkaEHe/dpIxJqHy/5Gwdd4VeS/URJFiwD
         +gwnwKdiPeWS02AtzrTBP5p0l83vWVVxuRa408ygnW7GUJUP2hZJ0Oubq0Jigh2a4FTZ
         p34Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753427011; x=1754031811;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K6yO7IzaeHBSJlHJN9ngERptq/fpvKj+ephhcUYtT70=;
        b=Tpj413tTziONTwYOWA/jxjvi20eNAV2et2KQaCYTrbt63+kLYey0EyJqCHV9M0yuKH
         7Km229wORajBHzChdv2sPysXIaNsjGLIwtzJIBEMLbvfsMc9/pWHMA7AtZq3bqb4Puvz
         vTGewrMmxuQsbR57V0EVdxmQ5doU6FfFRL7fkPcUDCUFrsYzrkveN3wALxkuvymJwMp1
         YC3+uOxrI1FrCyDatVHb7MMTfeuxP7AIicsOWLFdvvSIHlk2/7wXmVv96Ajy62/7nxQB
         M4Y90F75hZDxELMBgPgfVO7zWtyfWahfPEs2nTF0Sy7XCipnCQHHKvn9TCv757noIAP1
         ezRQ==
X-Gm-Message-State: AOJu0YwrEz6lWhvzbulVjF/Bi/x8ATpZHRPZaOo9J2j+eQnYbfObGgUb
	WfhJ472eTya3BUeQkRqya+5FD1KrsBbbgMEggLCm3IoT1xyWL3yOSmls
X-Gm-Gg: ASbGncsOJhcdSYU6nq8OL131xaQDYnfr7nGbE3SIxIJ+sLBdTEcKIAnAuIFV5A3euCC
	YfdwjQR5ZcrPJ5dSkzVHh4j1WcM/8k7nVxZ3LB75zD/yNhTO1fMi2QLSiFLhQy3iJtBH9LNObBX
	wCdVQVkijzJv2pHb843+uj0iY0j//cRGn1fSujrgVZhkZxZpV2i6AudWNTO3JzmqqfRZNiueyu6
	ye5+teZdh2jEGJ1aICF83q0nE77DiEgV4/QOH/pg8sy8iY2+C5TDktX9tTzcZyKb5l7+rf30CsQ
	DlkgSJu5BDGxfidR5cPA4GYvot7xHO9TmWmfkqOuk71ZEYpF8714ZVEAHn2HmySDLJROhNMYxut
	GHL/CpJ9U7fI2B4uKfusqd6GbiXqk6tUw
X-Google-Smtp-Source: AGHT+IG6KVfUPFfMgR78uASZYFuZsUTL4kAp3w3utSG9AFXK2UQGsNqpZIMCbThdR2zXsyXoL7Ed3g==
X-Received: by 2002:a17:903:2409:b0:234:8a4a:adac with SMTP id d9443c01a7336-23fb30ab831mr13271445ad.20.1753427011460;
        Fri, 25 Jul 2025 00:03:31 -0700 (PDT)
Received: from cs20-buildserver.lan ([2402:7500:400:60db:2e0:4cff:fe68:863])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa475f2fesm30097865ad.21.2025.07.25.00.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 00:03:30 -0700 (PDT)
From: Stanley Chu <stanley.chuys@gmail.com>
X-Google-Original-From: Stanley Chu <yschu@nuvoton.com>
To: frank.li@nxp.com,
	miquel.raynal@bootlin.com,
	alexandre.belloni@bootlin.com,
	linux-i3c@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	tomer.maimon@nuvoton.com,
	kwliu@nuvoton.com,
	yschu@nuvoton.com
Subject: [PATCH v1] i3c: master: svc: Fix npcm845 FIFO_EMPTY quirk
Date: Fri, 25 Jul 2025 15:03:10 +0800
Message-Id: <20250725070310.1655585-1-yschu@nuvoton.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stanley Chu <yschu@nuvoton.com>

Prefilling in private write transfers is only necessary when the FIFO
is empty. Otherwise, if the transfer is NACKed due to IBIWON and retries
continue, data may be prefilled again but could be lost because the FIFO
is not empty.

Fixes: 4008a74e0f9b ("i3c: master: svc: Fix npcm845 FIFO empty issue")
Signed-off-by: Stanley Chu <yschu@nuvoton.com>
---
 drivers/i3c/master/svc-i3c-master.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 7e1a7cb94b43..34b6e125b18a 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -104,6 +104,7 @@
 #define   SVC_I3C_MDATACTRL_TXTRIG_FIFO_NOT_FULL GENMASK(5, 4)
 #define   SVC_I3C_MDATACTRL_RXTRIG_FIFO_NOT_EMPTY 0
 #define   SVC_I3C_MDATACTRL_RXCOUNT(x) FIELD_GET(GENMASK(28, 24), (x))
+#define   SVC_I3C_MDATACTRL_TXCOUNT(x) FIELD_GET(GENMASK(20, 16), (x))
 #define   SVC_I3C_MDATACTRL_TXFULL BIT(30)
 #define   SVC_I3C_MDATACTRL_RXEMPTY BIT(31)
 
@@ -280,6 +281,13 @@ static inline bool is_events_enabled(struct svc_i3c_master *master, u32 mask)
 	return !!(master->enabled_events & mask);
 }
 
+static inline bool svc_i3c_master_tx_empty(struct svc_i3c_master *master)
+{
+	u32 reg = readl(master->regs + SVC_I3C_MDATACTRL);
+
+	return (SVC_I3C_MDATACTRL_TXCOUNT(reg) == 0);
+}
+
 static bool svc_i3c_master_error(struct svc_i3c_master *master)
 {
 	u32 mstatus, merrwarn;
@@ -1303,7 +1311,8 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 		 * The only way to work around this hardware issue is to let the
 		 * FIFO start filling as soon as possible after EmitStartAddr.
 		 */
-		if (svc_has_quirk(master, SVC_I3C_QUIRK_FIFO_EMPTY) && !rnw && xfer_len) {
+		if (svc_has_quirk(master, SVC_I3C_QUIRK_FIFO_EMPTY) && !rnw && xfer_len &&
+		    svc_i3c_master_tx_empty(master)) {
 			u32 end = xfer_len > SVC_I3C_FIFO_SIZE ? 0 : SVC_I3C_MWDATAB_END;
 			u32 len = min_t(u32, xfer_len, SVC_I3C_FIFO_SIZE);
 
-- 
2.34.1


