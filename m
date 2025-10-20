Return-Path: <linux-kernel+bounces-860499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F83BF044E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14F1D1883D81
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C16E2F746C;
	Mon, 20 Oct 2025 09:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EdRHOf5l"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F3D1E9919
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 09:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760953228; cv=none; b=aIqE2E5XgcXwbCCy5unbDJk9UsY5gg4pcl0NOPbWrhuzmMZn8RpYmWF6Gf6M4q/OwE+WmQaaBp/ilNNDIFhnZcU2CgAJUCzFUFLoTHNuKdKQi+gvGZApU0/SFzOOVWhdVrjWpM+cg80NxrOKJqbz4XgUHUlVX0CvHsS4uy5Xurw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760953228; c=relaxed/simple;
	bh=CmHgvSDDJ5FIVPEUea89ruQNY77rFAEjsBzW3bakiNE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XmW5VMtKI1vdU93jUzBQ0wa8dLCgEV/LhM6OA0PsmqBeK4L2zicWnG2WpvIs5w973A97wunFXst1vPlbNwuVsDstlBD/uNGnzppROQWKsFG/x4IbwRsB0DeVJMiWlWKTGznf3FB556OcEET5wdHkWe01AMo9Ud77W2jqdKvvEtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EdRHOf5l; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-27ee41e0798so66366745ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 02:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760953226; x=1761558026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a0oIALzdvBCzHopaQRdtbabnk+sudKi1EV/R9L+v82w=;
        b=EdRHOf5lLgTNen516q4LtwGgMKiHMR3yXKfB9EPnRQ95L3xW7dRLzqPA0aXU9odyLv
         OAVEOwmgKT3v60T4uLIGyHiN8NTZM68iIpjjVitpLiyeTzyLUAnrFiR4h+kQ/SHuxlfr
         j1TGeG0lYpDNbv2WUyHv4slJ67TWKwjL+YFl78GiclvIG0ouY4QSFkyLiQqJwAng8L6M
         fyPcyjl8FUhAzaDVvkWwmk6RjpTm0dGzeBiwb3n/f4cR6Z7yvttC1//sdBzu/y/MSaSq
         v6LO75ZXy8Ll7WBFYQRrSAUrv3XpO5/InJYrU0ig2m8gGWrKSwnRCVfYVFf4NgKMlDIq
         l6Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760953226; x=1761558026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a0oIALzdvBCzHopaQRdtbabnk+sudKi1EV/R9L+v82w=;
        b=NKyy8jl8yIjUZija9HZ980bFcMuCxyIdwqD5sRhvSuwllcZ6ZH8mGsK0SD+3cX9WLz
         HcqqHI+JtargN1RM/EXJ4jpaM71YGjL0I2/jsVlGJJbAteE/uW4qMM42yoV30tk94T4+
         0/jpbamj50ZeUadgzuXV45xw2HwnFzM3WEi0ePX9SiAdf2njRtRRgl2tA6MQyLOkvwOk
         HmO7P0m5uAGO5TRa1JRlan7TIwELj0ZIpARMeb34VEwdCU10cSwzy0KWsS3U4VEgd75R
         El1+yTiD2CDbd9zat5siir49imemnFbRlmBcCEHa9V8enwi5m2jjh8p9cmu+pMT3MKo2
         mkeg==
X-Gm-Message-State: AOJu0YxvUEIhDuhMzNpjqb56rUa7z28TKPl2+7cwlMmPj60ll5j8rvaX
	nJZZzYN2hz4ukwNhA8c5m08H2V0x+7m9s3R6hDKhpv+XHnhz47X5Lvgp
X-Gm-Gg: ASbGncuXmaivj2NDeQoa6f0rvv+mgJyJLRL862SvbunMV8CNhk5KWtbeTq3/btZzRo+
	8Z6fPWXBz5o+wnaZ++jHmIyFyNUQxFctaiGgvi18VP3qQkc+L8EuAphUO6iIUDXFB9Q1pc5Cj7f
	FqRafEbJqK/WxOvMLIXlBVs+wa3ixXrfRQlh5AHUwwerTwa2y7C3YW1Q0wxdbdsKgh4a90ue3Uk
	QaT1Fsd4zj3Nl8XnflH9D08c2ET/PSvHbA+CVcCYsh6U5D+WTWgNbEAZjRxjstGiXG9hCLhzKfD
	c2DgRzftqulG5N5MI4QzHCcquUUNLeFHE7nV3zNJrf9iDOBEsKtrRoRo/pvty2e5UsMshsDzi00
	OCBKFyQ5mFKMtJCQlBVZwJ3j4nCA6ma2aF+c1uJr+jijXzlDnkuSBbOhEKy/FomhQdc1uBEhv1Z
	bnexKgDv5GcxfTTf8UBVoe
X-Google-Smtp-Source: AGHT+IGZfMm3IaaCudoKntZRXnxbMi2Da04nhgpHPd/fehyifYq0ePK/zfcjTv3HglwhIjBUkF7u6Q==
X-Received: by 2002:a17:903:1106:b0:27e:f07c:8413 with SMTP id d9443c01a7336-290c9cf8f3amr142565565ad.9.1760953226254;
        Mon, 20 Oct 2025 02:40:26 -0700 (PDT)
Received: from cs20-buildserver.. ([2402:7500:402:b3a0:c6a1:3569:3089:3268])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fdcccsm75165905ad.78.2025.10.20.02.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 02:40:25 -0700 (PDT)
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
Subject: [PATCH v1 1/1] i3c: master: svc: Prevent incomplete IBI transaction
Date: Mon, 20 Oct 2025 17:40:20 +0800
Message-Id: <20251020094020.632545-1-yschu@nuvoton.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stanley Chu <yschu@nuvoton.com>

If no free IBI slot is available, svc_i3c_master_handle_ibi returns
immediately. This causes the STOP condition to be missed because the
EmitStop request is sent when the transfer is not complete. To resolve
this, svc_i3c_master_handle_ibi must wait for the transfer to complete
before returning.

Fixes: dd3c52846d59 ("i3c: master: svc: Add Silvaco I3C master driver")
Signed-off-by: Stanley Chu <yschu@nuvoton.com>
---
 drivers/i3c/master/svc-i3c-master.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 9641e66a4e5f..9cf9fb586e92 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -406,21 +406,27 @@ static int svc_i3c_master_handle_ibi(struct svc_i3c_master *master,
 	int ret, val;
 	u8 *buf;
 
-	slot = i3c_generic_ibi_get_free_slot(data->ibi_pool);
-	if (!slot)
-		return -ENOSPC;
-
-	slot->len = 0;
-	buf = slot->data;
-
+	/*
+	 * Wait for transfer to complete before returning. Otherwise, the EmitStop
+	 * request might be sent when the transfer is not complete.
+	 */
 	ret = readl_relaxed_poll_timeout(master->regs + SVC_I3C_MSTATUS, val,
-						SVC_I3C_MSTATUS_COMPLETE(val), 0, 1000);
+					 SVC_I3C_MSTATUS_COMPLETE(val), 0, 1000);
 	if (ret) {
 		dev_err(master->dev, "Timeout when polling for COMPLETE\n");
-		i3c_generic_ibi_recycle_slot(data->ibi_pool, slot);
 		return ret;
 	}
 
+	slot = i3c_generic_ibi_get_free_slot(data->ibi_pool);
+	if (!slot) {
+		dev_dbg(master->dev, "No free ibi slot, drop the data\n");
+		writel(SVC_I3C_MDATACTRL_FLUSHRB, master->regs + SVC_I3C_MDATACTRL);
+		return -ENOSPC;
+	}
+
+	slot->len = 0;
+	buf = slot->data;
+
 	while (SVC_I3C_MSTATUS_RXPEND(readl(master->regs + SVC_I3C_MSTATUS))  &&
 	       slot->len < SVC_I3C_FIFO_SIZE) {
 		mdatactrl = readl(master->regs + SVC_I3C_MDATACTRL);
-- 
2.34.1


