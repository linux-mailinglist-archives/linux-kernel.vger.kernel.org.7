Return-Path: <linux-kernel+bounces-761623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB8AB1FCB0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 00:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6AE41886118
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 22:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A892D661D;
	Sun, 10 Aug 2025 22:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ctA/tw8p"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E84263C9E
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 22:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754864675; cv=none; b=hl9F9GobJ2zEKJ0Ee+EUO6/01aT7qGSryK0/SUAa/9lQw3jNdbjOF4xD/97qBVhvCVHRb30u7dnf6oL5haw9IU3wxkV8CoR52MVfCymHk9E6GXayxwFGotu94BL9vIsLlis5KSBq9xtPK1R8RggGFiARkgX+SxTLBC5xDgufipc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754864675; c=relaxed/simple;
	bh=SGSec+EQWjKUsfxRcIYsyrxplqR++XYwLaxooXSSvvw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Dq6PH5LoakXLGiOp1N0QJ0e/adFT0iHqWD2ModBrFmdvD7O+8OfjqT+tz1uk+Gl96M3xwBglXzDeNB1EEtVO4bju2sfwQah67o0vSsPgNqRrAuys4eOEL8EO+npp7CSZxmPMSQi3BCNwie8zyr7SF8VXjoXkLPnVNDuio2UWcQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ctA/tw8p; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754864672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DsLJnbX2CWZtNzZ1OcDHZ6+zw0frPO9S9vsrOrlu7po=;
	b=ctA/tw8piE/cHEb9N/L4tnolhQTc7PliiFcXnyqZmJgVb22ecwmv+DMoP9DFBAtW/ip3Cx
	eT3/+LgX0hKdCoMxP4xI/sNruM/zItEnE6X8KkYW2S3MQPOtnbpqULfON15mlIWj9HqTR0
	DzCai8aVrACVd8yqxIyVYbByaLzWue8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-7N5H9NmrPZyEttwyerqaaQ-1; Sun, 10 Aug 2025 18:24:31 -0400
X-MC-Unique: 7N5H9NmrPZyEttwyerqaaQ-1
X-Mimecast-MFC-AGG-ID: 7N5H9NmrPZyEttwyerqaaQ_1754864670
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7e69e201c51so908071885a.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 15:24:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754864670; x=1755469470;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DsLJnbX2CWZtNzZ1OcDHZ6+zw0frPO9S9vsrOrlu7po=;
        b=E1TVi8DvBq7rIzLJQ608uT1JbMTy3ft5HwPlXMr4JRm8pFSch6D+d7pE+en7hwrvbH
         VXK/XkSCshtcFERrqymUUHGTehAIFCVfixB7C1iKv7/jbfrr2is0VmlV8gDd0nDuxO9H
         ZkOce7EFUgqNvBP76/tj+TBytnarT/EeLy0IipAx/TYi60qRJhbys2T1LZ+xYTCLtPwV
         DGv9U17gbv1S3VoQjyUuSuNO68q4ZuAPQ+6myQgDDE0ej5ISM8OuL9JQVD6gUGRVE413
         ek2t+Vy6OcAcR2dB2xYSLNhYYvR35mSbzsGpyqaOddBVW9TQPcgl/k6Hi+8gJPAjIO4O
         wTPA==
X-Forwarded-Encrypted: i=1; AJvYcCXDfPI1B2cAR+7ZDpzYKsRzAfoDtbwnVBjyKuapxDmt2SADGKan6g8op2QNExxb/jdsfXUxgiWCZD1tt/E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvc0mJeVBOSo7lPfc32fmLt1P7Ncd4PZX5mTZcRzRs0O1n/Zx/
	S1eO8mTbukedG9yVVRISof/zDiu/34F73uuSBEgI108KBuNDnM9II3EZXRQ4pp5+mX6nwOK6Upe
	c9rX7xd6Ho3tZOC6rXZzKecN0p714xjqtDq4jiaAr1VZNMPFIf9Im07gk8ujyK7KbFlVDIxGrCg
	==
X-Gm-Gg: ASbGncsIPkzs0z040l0HMIWiAPT7W9ZdElxtZOxA3XIa6hPJt2SkcZZ8UtFuKBu9b6l
	2MhRxjPlmnAYsP5kUgp1R3fGBnI916Jp02ztXg8aDA8gkXfRGGxdovOTRTMZrBWZ27MVtToaCrJ
	K5o+y1/SOvzHPAnJrvfyFDBc8bgOp9vx0FyLnp1h+x9QooQ4qnu/W2C2x701FiPG7Ys0qnY2iOk
	u1PbKn1W1AMU9tEPKdX3HTLtjiWYTlxNp3VubWv5pO+Y5GcQm9kRREvQ74M3RLFTBSU4gmiBRss
	gCm/A1azWVJPKRNhCRjdsfAQrVWHoOQC8eu/MWAa9xH3ug0LzM4SNI/5XGV3BjmhukLVwoYrvbn
	hndD2kA==
X-Received: by 2002:a05:620a:7202:b0:7e8:2998:51e9 with SMTP id af79cd13be357-7e82c75fcbcmr921979985a.32.1754864670040;
        Sun, 10 Aug 2025 15:24:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfZ1YzRY3j+zDzQiBRzGaCbAkWEl6UfwFm1tYgoAJVmJujnBFCV7yyaVBd09br3SkByw4KDA==
X-Received: by 2002:a05:620a:7202:b0:7e8:2998:51e9 with SMTP id af79cd13be357-7e82c75fcbcmr921977585a.32.1754864669639;
        Sun, 10 Aug 2025 15:24:29 -0700 (PDT)
Received: from [10.144.145.224] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b0867b7b70sm74050441cf.9.2025.08.10.15.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 15:24:29 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Sun, 10 Aug 2025 18:24:14 -0400
Subject: [PATCH] net: cadence: macb: convert from round_rate() to
 determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250810-net-round-rate-v1-1-dbb237c9fe5c@redhat.com>
X-B4-Tracking: v=1; b=H4sIAA0cmWgC/x3MMQqAMAxA0auUzAbaooheRRyCTTVLlbSKIN7d4
 viG/x/IrMIZRvOA8iVZ9lThGgPLRmlllFAN3vrO9n7AxAV1P1NApcJonWv7yIEGilCjQznK/Q+
 n+X0/6Gb5/WAAAAA=
X-Change-ID: 20250729-net-round-rate-01147feda9af
To: Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Maxime Ripard <mripard@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754864666; l=3055;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=SGSec+EQWjKUsfxRcIYsyrxplqR++XYwLaxooXSSvvw=;
 b=VlXqvJ2j2K8T7qZ6gDnZKdk0xvGKLfpw0ErL2SsM89sdyKwSzDeTzqTfmr4nlHao+o7kILkOl
 2kuTkv2p1lLBQHzyzOLh+NSk3F84nKm10XJn38FozI5LJMvotkmqP07
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate().

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 61 ++++++++++++++++++--------------
 1 file changed, 35 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index ce95fad8cedd7331d4818ba9f73fb6970249e85c..ce55a1f59b50dd85fa92bf139d06e6120d109e89 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4822,36 +4822,45 @@ static unsigned long fu540_macb_tx_recalc_rate(struct clk_hw *hw,
 	return mgmt->rate;
 }
 
-static long fu540_macb_tx_round_rate(struct clk_hw *hw, unsigned long rate,
-				     unsigned long *parent_rate)
-{
-	if (WARN_ON(rate < 2500000))
-		return 2500000;
-	else if (rate == 2500000)
-		return 2500000;
-	else if (WARN_ON(rate < 13750000))
-		return 2500000;
-	else if (WARN_ON(rate < 25000000))
-		return 25000000;
-	else if (rate == 25000000)
-		return 25000000;
-	else if (WARN_ON(rate < 75000000))
-		return 25000000;
-	else if (WARN_ON(rate < 125000000))
-		return 125000000;
-	else if (rate == 125000000)
-		return 125000000;
-
-	WARN_ON(rate > 125000000);
-
-	return 125000000;
+static int fu540_macb_tx_determine_rate(struct clk_hw *hw,
+					struct clk_rate_request *req)
+{
+	if (WARN_ON(req->rate < 2500000))
+		req->rate = 2500000;
+	else if (req->rate == 2500000)
+		req->rate = 2500000;
+	else if (WARN_ON(req->rate < 13750000))
+		req->rate = 2500000;
+	else if (WARN_ON(req->rate < 25000000))
+		req->rate = 25000000;
+	else if (req->rate == 25000000)
+		req->rate = 25000000;
+	else if (WARN_ON(req->rate < 75000000))
+		req->rate = 25000000;
+	else if (WARN_ON(req->rate < 125000000))
+		req->rate = 125000000;
+	else if (req->rate == 125000000)
+		req->rate = 125000000;
+	else if (WARN_ON(req->rate > 125000000))
+		req->rate = 125000000;
+	else
+		req->rate = 125000000;
+
+	return 0;
 }
 
 static int fu540_macb_tx_set_rate(struct clk_hw *hw, unsigned long rate,
 				  unsigned long parent_rate)
 {
-	rate = fu540_macb_tx_round_rate(hw, rate, &parent_rate);
-	if (rate != 125000000)
+	struct clk_rate_request req;
+	int ret;
+
+	clk_hw_init_rate_request(hw, &req, rate);
+	ret = fu540_macb_tx_determine_rate(hw, &req);
+	if (ret != 0)
+		return ret;
+
+	if (req.rate != 125000000)
 		iowrite32(1, mgmt->reg);
 	else
 		iowrite32(0, mgmt->reg);
@@ -4862,7 +4871,7 @@ static int fu540_macb_tx_set_rate(struct clk_hw *hw, unsigned long rate,
 
 static const struct clk_ops fu540_c000_ops = {
 	.recalc_rate = fu540_macb_tx_recalc_rate,
-	.round_rate = fu540_macb_tx_round_rate,
+	.determine_rate = fu540_macb_tx_determine_rate,
 	.set_rate = fu540_macb_tx_set_rate,
 };
 

---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250729-net-round-rate-01147feda9af

Best regards,
-- 
Brian Masney <bmasney@redhat.com>


