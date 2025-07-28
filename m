Return-Path: <linux-kernel+bounces-747624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FC4B13603
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 10:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28DA53B7FA3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 08:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655E721D5B5;
	Mon, 28 Jul 2025 08:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gL7/u70B"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8411993B7
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 08:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753689917; cv=none; b=CVWJHDNiCaWGylpzOCxdgW9NSPfJFItFFbr8TMmaYohnCKbeRACF3UFTJIufZBBvXfuwaelHKU9bJekvN5bRJ1yOxFjUWVuEdG2SzXn36oYtBAuqJXCHowJ0+s9o47ysPterAdwRuRaYJGz17Z1vjfdupx4+tI572G6mJeqJEfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753689917; c=relaxed/simple;
	bh=NvRheiuw5llbSfehMjIWn6sJASkkZsxB1P34xtvXJ0Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OmWudfQAu0B8cTMkqLy3d9OaszEpbkN+CQpYTrL4ZZyyBE+42rujJbWUUf6Xh+OBXLWezyZzjOhhzDTKA/AdmuemfdxUtMWEyxmWJJ9R70Ul+SnPWPVZK2TzqdMqOYZNyh1mbS0RFEmgNVr1p1Sa9GzQ7a+iTgri/psq/Xc7MoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gL7/u70B; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-73c17c770a7so4380419b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 01:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753689916; x=1754294716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c3Oc+mR2KuG3z3xaNZHJFJeibphFim3rI0DGIkQkO6A=;
        b=gL7/u70BrOSdzOY2utdFnoboziosV/EE29W+spdiqpdqCi0NHWg58ldP/tfBMi2HBE
         kRa1bXxNl0jRPeZLEfwwWeN6WFuoVyAgU8ww70WyRc/dvXhctojPIoxaZ+gn5OhXnRXb
         KTHnTfH3H+ZC+UkeNFDEYKAq5OjwZZbsaoEZnwxpqOqW5RZAX3+yP/5+lPNu2VNo6v4h
         wrSz19EaJoCM0IOHSwsJYEERNlb6VJHfILB6/NC92Wc7/2JqlPGqxQPTThgyqQ5/uR9K
         M4tGQqu8ZapKqlya5S2OERWvcnXckKf9P+RYLp09bUG8bbW8Oo4/AZVCT/jonkE4eZn6
         J7Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753689916; x=1754294716;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c3Oc+mR2KuG3z3xaNZHJFJeibphFim3rI0DGIkQkO6A=;
        b=FyCND7hUAe2PHLA/0mFSLqZA81iUVRsOo93MzOTX0OGKKstocAw7iaNDviu6mcMaLr
         hiXDZjQubdDe408zfkPO+mYU8mlJZ8E/kApFr5m+smRlH5e/Sup86emMnv3pVMPVM1JZ
         4fpb4QMJqcq3jXBTraDSlR0xzA2YYAhPZFxD+oJc5sG5Y+wDGmm5kJBpeCCsVtjMkXYW
         mU/YGICK1lWDdyghQzZ72HjZoIttJcoHPbMjTO3pA7D5miXauPgiiUEVWpPIQuIy75W7
         xYw28J/OGYBvgvgl56YNuAwlrMnOg7sco06SGaIUqPYjde79Gvs9u0uFBYuxp+UO12N/
         eWaQ==
X-Gm-Message-State: AOJu0Yz0T+wSjsA4y+6lYj6NTqIoG428M2CjAprltFOE2vIM4EBja1hw
	T3r2uyjHJBSIMOOosK5Pb86Jcr8TRTGHE1UEGvfDmTnbIoYFXfoqj1q4
X-Gm-Gg: ASbGnctG1Aenhy1AdfKCkEun7/v19zlrPpAM1flfn+MxeN3cVaWlZVLaKmqvV57C60f
	QqYmcdYiqpg4UgCCfnCkHEYqSN8+lNCtGz/jWdmH2h6qCyPOTsKlCQoCG4FlLpNfDE4/NzNYhcY
	Aj/BJxU8ai43uFU57C5GF+0Y/0KRnp6LJopnoWsv0D0qb4Z1s3dXY0+CMdbVieW0gxq30YESM74
	02wzAjwtfb8sGqiupo1pU34qxgs24oq3maQmr2iUq/3hT+aS8jE65IKRjlnUmazAUCOt7CuL8D3
	ECPLrgcAB7qRvl/D56hqmAmkuOm/l25UFmHSdPUAwe39zRAGjpyoiGUXNxxpgTauyHySruZQpUM
	H4heWYC8gxqp+KL9eWMmMdCMNAZAwV+5F
X-Google-Smtp-Source: AGHT+IH1hanGyoNS1mZu3A6pq3+qut8z3SbX7sMFBOxpHlREXfl3yRlupsfBR6nUWReumhCBMpt7ZA==
X-Received: by 2002:a05:6a00:2ea8:b0:748:f135:4fe6 with SMTP id d2e1a72fcca58-76335980736mr13588630b3a.10.1753689915606;
        Mon, 28 Jul 2025 01:05:15 -0700 (PDT)
Received: from cs20-buildserver.lan ([2402:7500:400:60db:2e0:4cff:fe68:863])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7640adfbf7asm4908203b3a.75.2025.07.28.01.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 01:05:15 -0700 (PDT)
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
Subject: [PATCH v2] i3c: master: svc: Fix npcm845 FIFO_EMPTY quirk
Date: Mon, 28 Jul 2025 16:05:08 +0800
Message-Id: <20250728080508.1743052-1-yschu@nuvoton.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stanley Chu <yschu@nuvoton.com>

In a private write transfer, the driver pre-fills the FIFO to work around
the FIFO_EMPTY quirk. However, if an IBIWON event occurs, the hardware
emits a NACK and the driver initiates a retry. During the retry, driver
attempts to pre-fill the FIFO again if there is remaining data, but since
the FIFO is already full, this leads to data loss.
This patch adds a condition to ensure that data is only written when there
is available space in the FIFO.

Fixes: 4008a74e0f9b ("i3c: master: svc: Fix npcm845 FIFO empty issue")
Signed-off-by: Stanley Chu <yschu@nuvoton.com>
---
Changes since v1:
 remove svc_i3c_master_tx_empty helper, instead check for available FIFO space

 drivers/i3c/master/svc-i3c-master.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 7e1a7cb94b43..ece563353895 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -104,6 +104,7 @@
 #define   SVC_I3C_MDATACTRL_TXTRIG_FIFO_NOT_FULL GENMASK(5, 4)
 #define   SVC_I3C_MDATACTRL_RXTRIG_FIFO_NOT_EMPTY 0
 #define   SVC_I3C_MDATACTRL_RXCOUNT(x) FIELD_GET(GENMASK(28, 24), (x))
+#define   SVC_I3C_MDATACTRL_TXCOUNT(x) FIELD_GET(GENMASK(20, 16), (x))
 #define   SVC_I3C_MDATACTRL_TXFULL BIT(30)
 #define   SVC_I3C_MDATACTRL_RXEMPTY BIT(31)
 
@@ -1304,14 +1305,19 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 		 * FIFO start filling as soon as possible after EmitStartAddr.
 		 */
 		if (svc_has_quirk(master, SVC_I3C_QUIRK_FIFO_EMPTY) && !rnw && xfer_len) {
-			u32 end = xfer_len > SVC_I3C_FIFO_SIZE ? 0 : SVC_I3C_MWDATAB_END;
-			u32 len = min_t(u32, xfer_len, SVC_I3C_FIFO_SIZE);
-
-			writesb(master->regs + SVC_I3C_MWDATAB1, out, len - 1);
-			/* Mark END bit if this is the last byte */
-			writel(out[len - 1] | end, master->regs + SVC_I3C_MWDATAB);
-			xfer_len -= len;
-			out += len;
+			u32 space, end, len;
+
+			reg = readl(master->regs + SVC_I3C_MDATACTRL);
+			space = SVC_I3C_FIFO_SIZE - SVC_I3C_MDATACTRL_TXCOUNT(reg);
+			if (space) {
+				end = xfer_len > space ? 0 : SVC_I3C_MWDATAB_END;
+				len = min_t(u32, xfer_len, space);
+				writesb(master->regs + SVC_I3C_MWDATAB1, out, len - 1);
+				/* Mark END bit if this is the last byte */
+				writel(out[len - 1] | end, master->regs + SVC_I3C_MWDATAB);
+				xfer_len -= len;
+				out += len;
+			}
 		}
 
 		ret = readl_poll_timeout(master->regs + SVC_I3C_MSTATUS, reg,
-- 
2.34.1


