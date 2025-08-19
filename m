Return-Path: <linux-kernel+bounces-775207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B01F2B2BC96
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26B4316511E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A133115A1;
	Tue, 19 Aug 2025 09:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FoxQMfI2"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC35287244
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 09:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755594521; cv=none; b=MHsQe30PzsnnrRHj8+uDmJTD1YSlI1ZAmyfd0enIDR27BIeVM7yshRRd2CzflCcKooI7PfEeNcaEdKSg6NxMBYo4wYy2IOPY5vOA/AKPJYWDZkXwWi5PuHlbp7ea5n16EIndJUPj9fxuIN46QeeSj1GcVU9zyytw9bILtbw9b6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755594521; c=relaxed/simple;
	bh=rtbzxgaJK92IW5jbBSEvGBOA1KuHW8+G4hwoSD0GJoM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XCdIRg11rtSVcs0neQY6Lm/ss6vYn9pdfKfXFNwU+r5Ags7cpF5OV3CFdD3R8Dx91MFkp8rdFJ3IDngzkO9QuLbSwVyIY3dumACqOUgXrSk5Rr2J8suE+or7WWFeWTLPgbZTfZB9Cgx83pi+7zmISIC+9QUFJZ6o1T7+JsZeNiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FoxQMfI2; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b4717554c29so3327250a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 02:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755594518; x=1756199318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IM574u9BvfLwspshaKYvYoAzraPVyBpTcdO8NtZkO9I=;
        b=FoxQMfI2AQEMFhaQ+yFSetO6dXN5NgHBY8NtcRUAo6gl4ksL5Rogqlf7QgZnLKjr/V
         HGRkCF52jKEYsT9X75NbyzB8OQ/3Zbf+qdUaoAOqEtoQ+qBdCtmj8IChnU4murx0DIf4
         0g5j4critznsDgvauakjlAr+ZN5M5iGxY6j+C2rKJ6ZtoERcVeVomjb8vrhBW9D8NtDI
         UsWyeyZTkhD42Z+z2c5lJyJP0PXTx8jsVOI/mnz9Kt7eO3uopsTBFz0reD6Cff6pliwR
         C+CXXzL/S6quESy4+AWNFg7zRg9Z89u7OLJsAR+s+LpY/Za926ybdxAk6kpGATvfEET4
         bX+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755594518; x=1756199318;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IM574u9BvfLwspshaKYvYoAzraPVyBpTcdO8NtZkO9I=;
        b=s7Q5OBtKsqxyvESmMsWFK/hGgQuRWtqXUfuKb6MT2aFKzxJXgCtRSET08XlYRPA9R4
         X+4nQuk8sVxkmW/aZZKAzn5VW47+m5van6MbzMoUtD5UzbYrR9SrWX9Ft/dcmQq+kEMK
         51ng6/hlw7PBMRfh1fd5gz34wUz/Q5pHTb3ZwAvYZo5EyV7OHnhhKwVtX0ucnKZA2Sdl
         AjAeUSqIilz5tkXQ2HkaVI0DO7saw5RJ/orAICJ8vphUEVowmoAhmh5oaTl2rbuPC1J9
         M0TXxWmegp8PNe5qQ1w6D92A1tSi8JKGqgd4DbziOXkNdLKpnakpw1js0t8YWq5uYIl3
         M4vQ==
X-Gm-Message-State: AOJu0YymLIk5t4Pw17KVJoUw2tEH7kwkTVmL+FeG566H8WHeOQ0h24GM
	zdyn5yiUvQrVDlX9H33TSTLnDK5/DhLzfzq/DaN3bRRQK4AbxuJk3//k
X-Gm-Gg: ASbGncsyqt7lGcZl1LSiQ3BmdpUuCFQ1JiLe8hgs1Cl+BidvT0foAM5CmnkrhCCUn1s
	L/ve4XmIvijZmFXDmMdbb7u7HkREjjmeCjfnarvxzdjpjh30XhVPFvSXhb3LK1ykGu7pMOzOL6t
	4z04pGr4M+dbyiZQxh6USpNMSA7ao3tgnlNzhJpL9KgK9N7k3ysJIqghmifJsqZyN5L0ugfzo87
	A/q6wSBwwH7QbgA7CMQ6qtKLDNjKjC0iywkD9GbjQ2YWKeKsa+8sBdeiEjsqJ8o/1GODpAFpX/X
	g/f/+TQnPOIwNib9r7iyGR4u2X2qvNv17UFrBmwBGMwrt2WfiyDwKYUCeXUpXOdqBQhMp+0DsMk
	17JRRz4hGtY+Vh1+JgAuPfepHV86Y1HMO
X-Google-Smtp-Source: AGHT+IFbouRjVkiLIRAKmdNpxoLTYyac7gzUT26rM+4XmksL6F3pg/OvHMPzXf0ODtZEXmE13gk4kQ==
X-Received: by 2002:a17:903:291:b0:240:96a:b812 with SMTP id d9443c01a7336-245e04b6fdcmr25057385ad.24.1755594518003;
        Tue, 19 Aug 2025 02:08:38 -0700 (PDT)
Received: from cs20-buildserver.lan ([2402:7500:500:7a9f:2e0:4cff:fe68:863])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d5536c3sm102693555ad.137.2025.08.19.02.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 02:08:37 -0700 (PDT)
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
Subject: [PATCH v1] i3c: master: svc: Use manual response for IBI events
Date: Tue, 19 Aug 2025 17:08:31 +0800
Message-Id: <20250819090831.3009647-1-yschu@nuvoton.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stanley Chu <yschu@nuvoton.com>

Using IBIRESP_AUTO causes the hardware to ACK IBI requests even when the
target is not in the device list. The svc_i3c_master_nack_ibi() has no
effect in such case.

AutoIBI has another issue that the controller doesn't quit AutoIBI state
after an IBIWON polling timeout. The following sequence is the case:
1. Target pulls SDA low
2. SLVSTART interrupt triggers the IBI ISR
3. Target releases SDA
4. Driver writes AutoIBI request to MCTRL
5. SDA is high, so AutoIBI process does not start
6. IBIWON polling times out
7. Controller state is AutoIBI and doesn't accept EmitStop request

Emitting broadcast address with IBIRESP_MANUAL avoids both issues.

Signed-off-by: Stanley Chu <yschu@nuvoton.com>
---
 drivers/i3c/master/svc-i3c-master.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 701ae165b25b..17644e041b44 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -517,9 +517,10 @@ static void svc_i3c_master_ibi_isr(struct svc_i3c_master *master)
 	 */
 	writel(SVC_I3C_MINT_IBIWON, master->regs + SVC_I3C_MSTATUS);
 
-	/* Acknowledge the incoming interrupt with the AUTOIBI mechanism */
-	writel(SVC_I3C_MCTRL_REQUEST_AUTO_IBI |
-	       SVC_I3C_MCTRL_IBIRESP_AUTO,
+	/* Emit broadcast address for arbitration */
+	writel(SVC_I3C_MCTRL_REQUEST_START_ADDR |
+	       SVC_I3C_MCTRL_IBIRESP_MANUAL |
+	       SVC_I3C_MCTRL_ADDR(I3C_BROADCAST_ADDR),
 	       master->regs + SVC_I3C_MCTRL);
 
 	/* Wait for IBIWON, should take approximately 100us */
@@ -539,10 +540,15 @@ static void svc_i3c_master_ibi_isr(struct svc_i3c_master *master)
 	switch (ibitype) {
 	case SVC_I3C_MSTATUS_IBITYPE_IBI:
 		dev = svc_i3c_master_dev_from_addr(master, ibiaddr);
-		if (!dev || !is_events_enabled(master, SVC_I3C_EVENT_IBI))
+		if (!dev || !is_events_enabled(master, SVC_I3C_EVENT_IBI)) {
 			svc_i3c_master_nack_ibi(master);
-		else
+		} else {
+			if (dev->info.bcr & I3C_BCR_IBI_PAYLOAD)
+				svc_i3c_master_ack_ibi(master, true);
+			else
+				svc_i3c_master_ack_ibi(master, false);
 			svc_i3c_master_handle_ibi(master, dev);
+		}
 		break;
 	case SVC_I3C_MSTATUS_IBITYPE_HOT_JOIN:
 		if (is_events_enabled(master, SVC_I3C_EVENT_HOTJOIN))
-- 
2.34.1


