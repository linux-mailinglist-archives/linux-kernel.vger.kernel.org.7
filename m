Return-Path: <linux-kernel+bounces-789539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5641B3970A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 10:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 807013BAD48
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 08:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DFF2E3AFE;
	Thu, 28 Aug 2025 08:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/6dnKcv"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A9A1F7580
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 08:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756369959; cv=none; b=NIPPAhdGRlvR4PypRtOs/UhiV1fDzI7vqbibuokEhb4sLxZy1FltuR5sqgPmpjmX8lJ5PH5GETs0d5uwf2KfejS7Wdfo/dM7scN0J1ikB6ASxi8wPBH4FK7tk3PD1bey+PYKrfjGNieRKZJCqmBteWeBGCPy7H2rgCTm0iATNEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756369959; c=relaxed/simple;
	bh=7b6XxNZsRMjQrnkz2AtVX7MlNfVZ5seW+qrqMqolUI8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iJFeE6Hw+Mngo81WYhCBh2mlu5ftdmF5mqV9NqvQ0yLvoCMhRlsxuQoa3H2aqk2gH6eExw6ozrZfylwyJnjzudBH175Ys75JMH+VrrIb+FXfFOH4Vmys7/L6S6f4AkQ6miJp+aeNaVyNyXjEAEXgREKUJF7G2NQfJ3l3mrfbYZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b/6dnKcv; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-246151aefaaso14565795ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 01:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756369957; x=1756974757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lm8GPCPzMzcahypxzHwZb0Rzqx2ICQwQ/5Ip1qxN3kk=;
        b=b/6dnKcvDY/X/VDJAtrG2GR0aZ7mS+Mdhd+S3n6jr2shYjzmkKOFvl7/MEmEjCGAU+
         WL7Rzmv/C4adhr/nMG6i4ESKl99p2AnQseSwUjDnRehBAH9gYrPwYzxFDubAz16g0DVP
         aTpe7SoglOSY1vZFF8zfXoAEqJuMocrHKto5f1Vzy7UJIUufecGtUUEguKdFqXhrbwPI
         Lrz7RF2HG44PCBsIwbtJMO+O84JWlbptNLH93kcMlhcHgHdYJVLVC791hIS+Z9dhxv0w
         5nH6zZLVukz4qljbyflI6bXVttvjznOQjQXm4TJ+SP4e72j+AeOG3TAPnfrrasTzhTew
         Pnyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756369957; x=1756974757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lm8GPCPzMzcahypxzHwZb0Rzqx2ICQwQ/5Ip1qxN3kk=;
        b=s70GIGqr/3nDJ7bSahsKHtc2PM4ATXH/w7m6RwtxxBItDIShkL4iYZkC9/t4XcfQLV
         Ni5/j4WjF8lrL1DjxxRu362EAIQVE1VWjK9RXBunD9Heq99MJ5lWXbHeXFeh+rQjyLnB
         A5YleSWBtp4mSm/tbC2421yTmYfuNKpXu4d2QUGTf2s+JDT2GIU3dnIIoNda0d6lfGgG
         yLe22XzQaSvUE5ADmySxjkMmh4F8l0yxIPeYZw5VTlGs9mhck39L7X3lL/1qlzWTkP3b
         grAFSGpKmPTLQSwio1FwJ+aYuZRiTVSU6upfVlFOTw4SA2QE9mnNxQ2Y4AsfwNIq6Iuy
         mZkg==
X-Gm-Message-State: AOJu0Yxuozim6KdbFr+U3qZzJRsMnOuskAcoXxzhIu536CVnv+OuDABM
	48iHfeljPW3RtfP8NHfBPBLFyMAP6wQ+EJ0lmyl/eKzorX6tEXBCNImV
X-Gm-Gg: ASbGncub9pPoZei5ur0MiJUgTEaSz94H5FUAceC372DLUyB4/0c3ma3HUlzx0u4TTJT
	VqqW18lHLiKFQxlcarfgATazYhhezuplG2UGyW4TFBvwZP+z2Kl5yEtvieOeWO93Pdvilivu7rh
	AUg2/zEERoYxoE1lELS1iteFsYc5EIh8uRjOu0mdOih/RDK3ltgyhNkALCul3DaS/I6Teh2PVHa
	ylvc/muVtXOZE/utEQEioMy4lqw7x3JFLPxKLtctTXzVvaDY8i0TCLFv6R/qoNvVQXTiuFqqbp4
	6/PsKjFcxqra/YBcAbKfqxORS27bn6SMFFHA+LR5qzYJQC08O7VGPRRqLNMqPwTSRMDrnurH9UJ
	xtquW+ZhPMVHAWpEqzcn+YuMT3epU9BojcubjCypfzmuf4oCBEzoMew==
X-Google-Smtp-Source: AGHT+IGhM/ccZEyF0simKH/f54xmziqAM/K0pJ/uS89XeLLZK3ZgBAFLP+zAoPECYnU+ZMpLrWUxrQ==
X-Received: by 2002:a17:903:41c9:b0:245:f6aa:1cd0 with SMTP id d9443c01a7336-248753a2592mr126200535ad.17.1756369957036;
        Thu, 28 Aug 2025 01:32:37 -0700 (PDT)
Received: from cs20-buildserver.lan ([2402:7500:500:7a9f:2e0:4cff:fe68:863])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3276fde4cecsm4335148a91.29.2025.08.28.01.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 01:32:36 -0700 (PDT)
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
Subject: [PATCH v1 1/2] i3c: master: svc: Use manual response for IBI events
Date: Thu, 28 Aug 2025 16:32:24 +0800
Message-Id: <20250828083225.3558100-2-yschu@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250828083225.3558100-1-yschu@nuvoton.com>
References: <20250828083225.3558100-1-yschu@nuvoton.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stanley Chu <yschu@nuvoton.com>

Driver wants to nack the IBI request when the target is not in the
known address list. In below code, svc_i3c_master_nack_ibi() will
cause undefined behavior when using AUTOIBI with auto response rule,
because hw always auto ack the IBI request.

    switch (ibitype) {
    case SVC_I3C_MSTATUS_IBITYPE_IBI:
            dev = svc_i3c_master_dev_from_addr(master, ibiaddr);
            if (!dev || !is_events_enabled(master, SVC_I3C_EVENT_IBI))
                    svc_i3c_master_nack_ibi(master);
            ...
            break;

AutoIBI has another issue that the controller doesn't quit AutoIBI state
after IBIWON polling timeout when there is a SDA glitch(high->low->high).
1. SDA high->low: raising an interrupt to execute IBI ISR
2. SDA low->high
3. Driver writes an AutoIBI request
4. AutoIBI process does not start because SDA is not low
5. IBIWON polling times out
6. Controller reamins in AutoIBI state and doesn't accept EmitStop request

Emitting broadcast address with IBIRESP_MANUAL avoids both issues.

Signed-off-by: Stanley Chu <yschu@nuvoton.com>
---
 drivers/i3c/master/svc-i3c-master.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 701ae165b25b..baf3059fd668 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -517,9 +517,22 @@ static void svc_i3c_master_ibi_isr(struct svc_i3c_master *master)
 	 */
 	writel(SVC_I3C_MINT_IBIWON, master->regs + SVC_I3C_MSTATUS);
 
-	/* Acknowledge the incoming interrupt with the AUTOIBI mechanism */
-	writel(SVC_I3C_MCTRL_REQUEST_AUTO_IBI |
-	       SVC_I3C_MCTRL_IBIRESP_AUTO,
+	/*
+	 * Write REQUEST_START_ADDR request to emit broadcast address for arbitration,
+	 * instend of using AUTO_IBI.
+	 *
+	 * Using AutoIBI request may cause controller to remain in AutoIBI state when
+	 * there is a glitch on SDA line (high->low->high).
+	 * 1. SDA high->low, raising an interrupt to execute IBI isr.
+	 * 2. SDA low->high.
+	 * 3. IBI isr writes an AutoIBI request.
+	 * 4. The controller will not start AutoIBI process because SDA is not low.
+	 * 5. IBIWON polling times out.
+	 * 6. Controller reamins in AutoIBI state and doesn't accept EmitStop request.
+	 */
+	writel(SVC_I3C_MCTRL_REQUEST_START_ADDR |
+	       SVC_I3C_MCTRL_IBIRESP_MANUAL |
+	       SVC_I3C_MCTRL_ADDR(I3C_BROADCAST_ADDR),
 	       master->regs + SVC_I3C_MCTRL);
 
 	/* Wait for IBIWON, should take approximately 100us */
@@ -539,10 +552,15 @@ static void svc_i3c_master_ibi_isr(struct svc_i3c_master *master)
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


