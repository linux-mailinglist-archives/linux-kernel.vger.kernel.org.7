Return-Path: <linux-kernel+bounces-790972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79AFDB3B087
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 03:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B8DF1C81B6A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 01:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5301FECA1;
	Fri, 29 Aug 2025 01:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R23EBhK3"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF471F2BB5
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 01:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756431065; cv=none; b=ZRcaoUBjM3YUz05s8WFaRhne713L7DpF3gVosIL/GLh/Z0An/8ePueweyEUKOWzEvtQCchED3qoCBvDQUiCO65GFMQy2QU41FYvkI/PVRhdoX/r3BZl+VlMLRAGMozwvPUibafYreUYPK5GxsZNyaz+61k9UAmjtKahH8AmgukE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756431065; c=relaxed/simple;
	bh=Qbqep2hzcqNwSJ0FdtBOdWhD7FOE+5zl9NAF74yt6Bw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=INlc7O7NkAsRpFAnCJ+KwhqF/yMGO95zc2fA0xa/gVYUuFQtuMNhfw30c+mdf3nuzBtJlRpyEcNZ+SW4HkhVHzuNL7nC7KjF8Feb/hHkRy72F+MVoAr+vNBv8T5F/rUm2NFStXS09PTmzug7auZlej4QHfWyuLzUc3paMjBc4nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R23EBhK3; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-323267bc2eeso1209362a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 18:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756431061; x=1757035861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JCc+9KPYWnXlW7uF+KcOgI9YRTfMpRpG2O6mgKyAsFA=;
        b=R23EBhK3b3oEIEQTOCQnJ+oesTjr7+J9qwspbskDprPGSXHWcKERpwE9A3zE0KUFxa
         8LvNAG0cGBDDLvpOvqCtCLN1RBrPC8TjSvdw27VFUDZrMAhUyppQQD17/wooipidb8l8
         qXW4FhPvz9OiPQ4jBSwIIQjy9y5AULXk9019vSaS7ntm8iewbnwPCTeXkC/f8PCLtsJu
         7b83S3pj0bbwIYbqAraqW5ZYXdCVPJuSMFylekcQ5wwAIOfCxbEwqwmaXhhpZjkiblZf
         NKBsoBczvcstH07Dp5J36ROvWf5dc9JkviPH6uy0bOUfjaBlz4ozcFUTrc6f17voOnZG
         QqoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756431061; x=1757035861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JCc+9KPYWnXlW7uF+KcOgI9YRTfMpRpG2O6mgKyAsFA=;
        b=TnmluB0TtqJrBezbIyIrS7IU31tU0Spvh2DCue0KoWbY7wgtxFKCASjTbGoWIqOW0E
         gg/wDV3xq6kM50Q/So3q/6pbzWJSQZFAgvj802cRjexP1Mr8Y/+PmVXWLQaz1/uhECSM
         26tXO1VWCYD1xQ84eCN7mJiMVoc7Of1pCbhG36fEP+4WHHavNKEvt6Gnp8RDOSZQzrNo
         pP87twDb20nNp8K+k+lnXuCG7Rx6V7yhZvzG1Wg3ECNRKzNYvIN9wx0Qjd1wqwA/ogB0
         7k85GAXw0JCKgC/Mn3hF4+XPq7NPUiFFwELkIVOMSzxs0d9KFs3RremnrCLK0tO3ExU7
         50yg==
X-Gm-Message-State: AOJu0YytWxuFJvDNkE+uU9LQVn4wnPJGRvWfrkfJg42dsLZd0sT4LQdV
	ji/CaefLIr92yfD00Nt2vR4ISf4+dL8Mz7R6fAB3KAUI1pCbrWWHFJXQeCKO7A==
X-Gm-Gg: ASbGnctGry5kD8vdmuiRm0HBawcLh9DbKB1lH7VrDoGRCkf5ZJlgYYraMsc7FQapbPH
	gGmgwbBgLva2rRpCpqagE9NDLsvrBblakcROdTpR/hdSgFFaTiNsSPWL6IoIKEUI25qZ14xIyPO
	+tN5ZJVCy7ImdTgOfhQHw378jvluSyyHO2KmQzPS/75aXBSTJ9Hr23VaQ4hVhuhPvUuC9ixfKMf
	bouK++zYTt3b/CwgStK/ov6/wGzmM6wsxMEwQEA4HwIlstDizaMgcf4S6NXpOXS2ohLCHQD5ax/
	jPPrldkCvIrjqeOa1uVjQ+806vv8oJ6S+LjklmmeYXsxgVCfobGzf0KkcjXCrvmBcVG/nMhdw0W
	/vKN3fOtQs3W3GOmreDe4tnpaGjG++wJPWBy8TYMDXgI=
X-Google-Smtp-Source: AGHT+IGzfeCPaZZjJB+gqeKg99B8LCs/ZeRT0KWO62kRVGoGTA+idY+/TD5Dbn/d3RbdoRGPeyQ98w==
X-Received: by 2002:a17:90b:5644:b0:327:70b9:9d68 with SMTP id 98e67ed59e1d1-32770b99e1bmr10491075a91.16.1756431061407;
        Thu, 28 Aug 2025 18:31:01 -0700 (PDT)
Received: from cs20-buildserver.lan ([2402:7500:500:7a9f:2e0:4cff:fe68:863])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-327daeec552sm959977a91.27.2025.08.28.18.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 18:31:01 -0700 (PDT)
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
Subject: [RESEND PATCH v2 1/2] i3c: master: svc: Use manual response for IBI events
Date: Fri, 29 Aug 2025 09:30:52 +0800
Message-Id: <20250829013053.3562853-2-yschu@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250829013053.3562853-1-yschu@nuvoton.com>
References: <20250829013053.3562853-1-yschu@nuvoton.com>
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

Fixes: dd3c52846d59 ("i3c: master: svc: Add Silvaco I3C master driver")
Signed-off-by: Stanley Chu <yschu@nuvoton.com>
---
Changes since v1:
 * Specify full fileds in the MCTRL register
 * Add Fixes tag
---
 drivers/i3c/master/svc-i3c-master.c | 30 ++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 701ae165b25b..8e7b4ab919e3 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -517,9 +517,24 @@ static void svc_i3c_master_ibi_isr(struct svc_i3c_master *master)
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
+	       SVC_I3C_MCTRL_TYPE_I3C |
+	       SVC_I3C_MCTRL_IBIRESP_MANUAL |
+	       SVC_I3C_MCTRL_DIR(SVC_I3C_MCTRL_DIR_WRITE) |
+	       SVC_I3C_MCTRL_ADDR(I3C_BROADCAST_ADDR),
 	       master->regs + SVC_I3C_MCTRL);
 
 	/* Wait for IBIWON, should take approximately 100us */
@@ -539,10 +554,15 @@ static void svc_i3c_master_ibi_isr(struct svc_i3c_master *master)
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


