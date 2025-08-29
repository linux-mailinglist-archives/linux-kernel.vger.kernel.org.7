Return-Path: <linux-kernel+bounces-790963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86931B3B06A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 03:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 241021C841F1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 01:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A9C223DF1;
	Fri, 29 Aug 2025 01:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DHueCD94"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04A7219E8D
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 01:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756430599; cv=none; b=RAKSkHevTzEI8aTPxMTY99yWCvaPmxv0IVxcTcxmYae9Ysy5YwPHlbitGnF38weoAV1Ca6HN+PS04qiJt+v5+EFG8AFdYf97CU5vl7O2r+NvGN8WbzbtCSJLeGH89UOhiFJ7P8wrBlDeECaVbN/JsGLpM3r4QHJgoq3e7GN7OJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756430599; c=relaxed/simple;
	bh=Qbqep2hzcqNwSJ0FdtBOdWhD7FOE+5zl9NAF74yt6Bw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W9djV2fT21lxc/k2S8H1E5o76DuCnEraViBVop4eMJNzoqBv3coeTYOlxKklBgZy7wd+YvSVCb38QFnjFSPEjFP4NeUkJNwDd46wWZX2QcpQPRF+YaurI35lUUEyurPZ60xy8fm1aCTh3Ob8kkBiLSAKAjDzSUcZlnXe30wlX1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DHueCD94; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-248a638dbbeso14299365ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 18:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756430597; x=1757035397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JCc+9KPYWnXlW7uF+KcOgI9YRTfMpRpG2O6mgKyAsFA=;
        b=DHueCD94GY4UGuiPBjO90UfRLjMCPF0hz2AZ2wv1tH5tAspVDS/ph6Xx7S4EcpgH4z
         zL+ybx9ZirI/9N9kjev7WX8s3Psa6LnZo+edvvwTcRtAMvMLUDBiECGJ4Z7hIb8mOXdk
         Ov/xg0as3pm443QsM8txK8GuiFooVi9zc7WFbKi7EqKpuz01Nzr/kQxyWNPqR+8Fy3B5
         Ik9Ew4kwO3/rh/kB4wEhYo7DZ2lEZiAffcreIHxUbWCNft5T80v6OJoamtq3KRbgSsBR
         SRQSmwVkZhJjxA+LfNC9gQliR2cmyxx+Nxp+WkqKpB/O0Svnuwoeyt8Vy0ZoDkoMYNBQ
         +vdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756430597; x=1757035397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JCc+9KPYWnXlW7uF+KcOgI9YRTfMpRpG2O6mgKyAsFA=;
        b=ZtQMIOFcHfWX9M/SbJUMFpM20vkPQS/REcGUIuOa9Z8auQ0ztUaylsHAXRjyzTRK6z
         jgCwVHNZBi59iTHtGqT5PRcxz73TJ1qiSqoWNGGyqj1bzJSYxLscGi8zIEBUb+OhizfB
         jLqPE1oFBascQTgOY0AZNVXq09JK2n13gKMD+V8yM7g8yvUvgasMBlKlGQKJhccLKCCO
         TNAsh0tE9USIUPCDRUPC34vU0f45jn2GHTxlgaYuNzsPsDY6PtwF9k7LeEK20vJcxsrD
         IO3PECWM07GeUOe/xB2LfXTH5J6okWbg/ZyOEDX0M+xSZDoE5isHJTccIzr8VOnPhMHt
         iVwA==
X-Gm-Message-State: AOJu0Yw9mkRq6VUzKA7wmM6toKlTB+je304P/IoKMiQCKr1zg72AjatM
	saeo1TlHuihludZX3mLFcKYnQgaG+VT1T/OCn/f4ofMDsO9xrDYqeMlY
X-Gm-Gg: ASbGncsiVZbHJvVQ7PlEf7BbCoObmPgx+2stWBpK5Ryf1j9TE2r2FsYbVvwHSQlJG3G
	HePa7lCYlZ/3tLSjnN22PRZGpGa55vColT/GkHgc/qEdDV5pFtleD4HlXA0BlmX4JL+TVCQaSmb
	4GDFFZP9qF1t3PDFwB76TQtfiTWp/mRakhf64Fm2YDirvaOOPq0G4By2Rvc1pAgj+raF19ym1Jj
	hEOWsDldiF4LL3jUuuwnYcXjkz/BYUJEALI/1ZBk7x8dVG68I8D4l6lVOorN9HAQMmnLqfACXo4
	deYiPppTEIZglDREGKmq6wXtCPw1ycgqHBwRMOwGVUMcwwIOAaSIsMj+M2+KI5UNxykhqx31HVn
	HDHpZrfPv/4bH0yjF9lWIReUMieNEKrYaYI/M2MhK3lA=
X-Google-Smtp-Source: AGHT+IHmO6ojEFw+n3wHVhsw/EFAK1mSMF5sDMQeXbOj8huc/adhHS7E4f1wH0RYuA2hnfjxzOdWeA==
X-Received: by 2002:a17:903:943:b0:240:5549:7094 with SMTP id d9443c01a7336-2462ee53d7dmr335075475ad.18.1756430597328;
        Thu, 28 Aug 2025 18:23:17 -0700 (PDT)
Received: from cs20-buildserver.lan ([2402:7500:500:7a9f:2e0:4cff:fe68:863])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24905da183asm7686885ad.74.2025.08.28.18.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 18:23:17 -0700 (PDT)
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
Subject: [PATCH v2 1/2] i3c: master: svc: Use manual response for IBI events
Date: Fri, 29 Aug 2025 09:23:08 +0800
Message-Id: <20250829012309.3562585-2-yschu@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250829012309.3562585-1-yschu@nuvoton.com>
References: <20250829012309.3562585-1-yschu@nuvoton.com>
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


