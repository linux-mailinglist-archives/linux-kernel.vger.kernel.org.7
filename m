Return-Path: <linux-kernel+bounces-870823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF88C0BC44
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 04:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1CB4189E206
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 03:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270A01DF265;
	Mon, 27 Oct 2025 03:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GVwPOi0i"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201918F40
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 03:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761536843; cv=none; b=Jvpe53LIEKlHtSL9czO8rDhhI44GJKZEfP7Dz5NmOx1Mv1CDud1+JbG5x27M93Ucgd1O62wGQqeyHQhUeGBHI/AJE9065ViDU7GgAytq7w3NTKk4ivZ1JTnNb6dRW8WUzzpXBfu1SuWS/f/FksZIXWKlC8/x62fc7UtyeH+flsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761536843; c=relaxed/simple;
	bh=bPmRYGClCjWImOKQE6pPmi2I/cLUk7pdJ5I6ps2ojLQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LWBRdxatvs76ilXoHqtdaNUvUe1fK2CFN1bAwXd5UtORIKFSZbIm8N0olvEfp/jrjw3rQ+k29Ni/p5TnIPBAzXs4IUZHMHnH4DrUWTmQEQLK48EPEJCi76Nvc5IymJjfEUnggqZZWArGwoZLP6VLkiDNqimCsBb1dRz86VQahNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GVwPOi0i; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b6ce696c18bso3831118a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 20:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761536841; x=1762141641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CxQovh9eMpHejPQRZH3kbXNMIwm3B/L8EVHuJgLjyZA=;
        b=GVwPOi0i4dK6/Y3sJamQKB96ADUmxvmm1OpE4UEFawVETzjKK8eENsPHwktmBCRDl5
         ZXx7Y5KrbHcdxJPgfEK23m4Ci8sIQmzg+ZHoBhbMDL55fDfqBG1uNUVsrEjoZwHGX52u
         JQkvj4UuUAiR5BpFfk0nbbzW17Z3W0HOy1Pcz0nJ6ZWRzqq9o6rVkaPlSyAPGRDhKU/t
         +YLpqGfae+CZLWnBxZNdNo/B7OvHgf4/Pjv4vneg6TNT99tiaL7mdRMdqYDd56U/FYp7
         LQHLF2yaXV0dNxkRxBW8y1cT3Yz4KbFIFDtxayK/DaeEkMRlr56+EeKIxjoiKR+Tqv2X
         1yMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761536841; x=1762141641;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CxQovh9eMpHejPQRZH3kbXNMIwm3B/L8EVHuJgLjyZA=;
        b=CLwl3r3/KBcjjYi/MXcoPK1Hou4IoIyClo/6ujqwndN/Z4QW2ZIaVz/0JvTzVBmPGt
         w6xhLrqMBCQhza4Y2sygzSs/e3es5EucyjFs+pRgAK9m4DBi77c9tCe3lTuSCWvyZD6U
         2vPSG8UAtfzeU/K9V0XgxhUwcTUtFE3XcmoJgQNKUsfLevcOKZWiMISL1Dmh7N9MJJnQ
         EfNhKgE/oHomhX46XaX1jyEYTsoGoKW8Jh0KAv27OATUYYgYFPQ3gFqr4z0xj0Fx69sp
         24lOS1OkDchJKtJezxyT9Cot9QnnvBW664KAjpSdCkEPBFQQ3Vei3RcxBbN7evHpD0vG
         jEBA==
X-Gm-Message-State: AOJu0Yzl3MzMG6vFVlxr49Fmk71JokU3IjCXh90VHmhTTCWN1L77k8Cc
	FeQOESrW+awuRWmsBJQwS9iOKrumLyDnR1YrSl5SkVbT56d62OFCJA/y
X-Gm-Gg: ASbGncs6qVV0GgBQM0eJxCWp1c2SzK/Pl6XrBZIVlXyQIpIMEVWg4GcQM/cz/Y9lmlm
	V3Q5woM5dmtxCCENxX2VbmRJD1/rCzFAVLJAMDdQpbfKRzH328szh1C5plmJNXS8AXVbCpHFtJk
	Xz0uaOl3Mq0JYrRbBhJ5zlecwDxJIKEPNOoVvMgTDoTmPipq3viRSvYk7ZBKl4ZeRS4r0h31Vc7
	NaY+sXAbE+F+zJM/xOxFtNvVcsnK8EnCRan7VrJRSRW+TGIKe7mCEQqOgUwh+IW5ql3KCRMFgOE
	b6XmYmbgwoG3orPJxIEtNG7+GIhgVUKFuhisEvs3ed2B5+GJFNEOmIKsxHk41KqVxx83T9X951e
	wSl+HaBPUVXiSAL41of1i/QRCLkMzTexsksQF84fegVNxcPwI3gjR/BH0MbQDq/XDK5bEZ3KXUC
	1LjFbtC5wv+QVyVRpQqJoH
X-Google-Smtp-Source: AGHT+IG7mgnceqMZanZPDI1w2t5pzxRJNT+htUoM4mb2kcMgZdM1p1lZkOwKbk4NvSUfMv8tqi2X9Q==
X-Received: by 2002:a17:902:f68c:b0:25c:d4b6:f119 with SMTP id d9443c01a7336-290c9c89ce1mr477448905ad.12.1761536841341;
        Sun, 26 Oct 2025 20:47:21 -0700 (PDT)
Received: from cs20-buildserver.. ([2402:7500:402:b3a0:5492:7724:1128:1af1])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b71268bdd50sm5997929a12.0.2025.10.26.20.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 20:47:21 -0700 (PDT)
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
Subject: [PATCH v2 1/1] i3c: master: svc: Prevent incomplete IBI transaction
Date: Mon, 27 Oct 2025 11:47:15 +0800
Message-Id: <20251027034715.708243-1-yschu@nuvoton.com>
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
Changes since v1:
 * do not touch coding style change
---
 drivers/i3c/master/svc-i3c-master.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 9641e66a4e5f..e70a64f2a32f 100644
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
 						SVC_I3C_MSTATUS_COMPLETE(val), 0, 1000);
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


