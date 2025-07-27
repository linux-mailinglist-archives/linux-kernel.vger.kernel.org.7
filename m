Return-Path: <linux-kernel+bounces-747319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0749B13280
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 01:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AC283ACE69
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 23:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9822522B6;
	Sun, 27 Jul 2025 23:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XO5xmix8"
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75911DFE26
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 23:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753659700; cv=none; b=W/BYs0IgBxKzEB9+NSrz0i0a8m33889m5qQewES5YLmHySxdHmR+Y+oFC1QS/MI/hmulQcYUwGgbYmUJPe5s6c2+kHbfGO75K+uX47fCdxpDRSWr61H/o3VIKdtE91TfF7zDvCqAGExQl69p6TxZAzNQDgD3fHbrPc4KZiQV/NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753659700; c=relaxed/simple;
	bh=9NoYby5K/yF68gc5DC5elQLi1A4u+feavzmVW1fmGbs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WqDJFzfctd21usKSzwEDsSMtQrXq0nX3TjqOY0SvOQZJBSclZiuI+05ijy6V2U09ujp4o0DCAAmoVAZhp1jLlT8mmcmE6EZDulTZZJbUrWVfEEIoo9uZYnFrZSuLNV4b1uPBlfNAUYqdObvAQmxxHbYb+2kylEoJTD7wPIp7vUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XO5xmix8; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-24009eeb2a7so4221845ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 16:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753659698; x=1754264498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6I61v9FrWBIFSshN0VXI9NqKHts/F8m+kZPpHjU7+/8=;
        b=XO5xmix8MifTYAVQBRnxdAXZdLdf9En6z/J/ZvF189PYk4t1pfzPvadVYP0H4s3UcJ
         KrdTzh0iqZyeokJ9FGWQ6Tdk4ZnPNCNKUQbgHFsyUEOBa+UHug0lMLNL109SgabpBcZG
         VC1iikK2iGCIwCBsFY7DYcDpqCi/P4NeVP2paLpiid0jicwCJB2ejWIgiECOXkIawNHK
         wZroi0SHU++pQMGdyfJY7eikRZshpPSGxaNg7TVDWIT+TKSAO283vTkcfh2LMj2MW0kt
         71ofy7XYX/18qezutuuwvzCn1kKjahT/+J1z3y9d3AFb19i5YdWy1hlCt9ndhXWYqPYS
         lDSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753659698; x=1754264498;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6I61v9FrWBIFSshN0VXI9NqKHts/F8m+kZPpHjU7+/8=;
        b=C9aGgYFgeb+lbK93pE87VryijSMufL3CzynCCMiCR+0JubTn1Cct8bk0ertxjuNaDG
         cmnawyiNQvqGO2eew7VJMBxByqrakIttoH1f0iDjPl2tanyZpEQV22ZrH4xXVGFIeTDw
         Dlchh6CSEr7fbyUGfpFfrEkHyx3zT1q5RPeOCnH5joXmiA4op2yZdkteeZkJDt430atP
         pPBApB4TjCumJ33G5T6/gB9hig09m+ZnhRpnpAUBJSm1KV/nOYQ4ppN+xWyn4nxGAuxg
         LUNzci19oSh8om5dMFEDnrCoGN1bI5uy922ec+gJJdzJKdPwP4kMACrhNTanL9pVsnvP
         k/9w==
X-Forwarded-Encrypted: i=1; AJvYcCVPgTZVv4HBRwBZFXDcq8j2+o+eF+PY8IVNIWN+AlA21Je90n1ZtMyTROPORPcpeSZU7jb8BphJP0m8A4U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUwq/PV6cPNvs2aYuTlZ8nhSif0aX89n4YgQGjOp511+QbcJrI
	Bvx9IzeTXZxXlGp2SBCFVnrUGX71PLY7mftTzlCYq1A+Bb1Nh+AVFylLMoP7WiSdbME=
X-Gm-Gg: ASbGncvPvCXMjRvNC1mag9YqKoW5arT2bdt3OeM1mz9edbpvLQ98yFz1mE9CnTymqmb
	7zzhpcDAAQ5Oo1CANMs3VqIzlonwXLJhDi4BtsS5eyIa3CZu9M4smvz6UmP3KTQ3WqPLzY71ag7
	olVL9ILtdTyigdQ0BdKQSKeIu72pn8HXlBy73zuwkCCXQA3hI59LUclLx1h3NLrbUz6Jmj9D+hA
	1yg4btl2+N4/n/O07P3DrnWMY1Wh+MrBqnKe+XVDxZTHysNLrIw5EzhEG+5hShEH+STl0fBSarT
	4Yra4Oyi2HkWr6PSJSom6EmOSvV5hFLDcdUP/G6pKtbGXaAJsaLWQzivKZ4QXAOM8WjlKzlV4aD
	jMdktbz3ZB2ER2TZ8iUdm8Zix5z1tQo1npW53KcKKxw==
X-Google-Smtp-Source: AGHT+IEm4+/xOC7fhjVYt4xHp91hQq4cJbhjB+6Gfp/MleFM3HxcB9d6ChQsVlXp3v2MJObA8SUmXw==
X-Received: by 2002:a17:902:ce8e:b0:220:ea90:191e with SMTP id d9443c01a7336-23fb2fefd1bmr155188565ad.4.1753659697987;
        Sun, 27 Jul 2025 16:41:37 -0700 (PDT)
Received: from localhost.localdomain ([167.220.100.18])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fdf5fa955sm30916875ad.202.2025.07.27.16.41.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 27 Jul 2025 16:41:37 -0700 (PDT)
From: Tian <27392025k@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org
Cc: arnd@arndb.de,
	Tian <27392025k@gmail.com>
Subject: [PATCH] misc: cardreader: fix overwritten return value in RTS5260 driver
Date: Sun, 27 Jul 2025 16:41:34 -0700
Message-Id: <20250727234134.26540-1-27392025k@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In both rts5260.c and rtsx_pcr.c, a return value is set and then
overwritten by a later function call, which makes the original value
unused. This patch ensures the return value is handled properly
to avoid ignoring possible error conditions.

Signed-off-by: Tian <27392025k@gmail.com>
---
 drivers/misc/cardreader/rts5260.c  | 2 +-
 drivers/misc/cardreader/rtsx_pcr.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/cardreader/rts5260.c b/drivers/misc/cardreader/rts5260.c
index d2d3a6ccb8f7..ed8adaab54a8 100644
--- a/drivers/misc/cardreader/rts5260.c
+++ b/drivers/misc/cardreader/rts5260.c
@@ -269,7 +269,7 @@ static int rts5260_card_power_off(struct rtsx_pcr *pcr, int card)
 	rts5260_card_before_power_off(pcr);
 	err = rtsx_pci_write_register(pcr, LDO_VCC_CFG1,
 			 LDO_POW_SDVDD1_MASK, LDO_POW_SDVDD1_OFF);
-	err = rtsx_pci_write_register(pcr, LDO_CONFIG2,
+	err |= rtsx_pci_write_register(pcr, LDO_CONFIG2,
 			 DV331812_POWERON, DV331812_POWEROFF);
 	if (pcr->option.ocp_en)
 		rtsx_pci_disable_ocp(pcr);
diff --git a/drivers/misc/cardreader/rtsx_pcr.c b/drivers/misc/cardreader/rtsx_pcr.c
index a7b066c48740..9fb22f2cedbd 100644
--- a/drivers/misc/cardreader/rtsx_pcr.c
+++ b/drivers/misc/cardreader/rtsx_pcr.c
@@ -1196,7 +1196,7 @@ static int rtsx_pci_init_hw(struct rtsx_pcr *pcr)
 		/* Gating real mcu clock */
 		err = rtsx_pci_write_register(pcr, RTS5261_FW_CFG1,
 			RTS5261_MCU_CLOCK_GATING, 0);
-		err = rtsx_pci_write_register(pcr, RTS5261_REG_FPDCTL,
+		err |= rtsx_pci_write_register(pcr, RTS5261_REG_FPDCTL,
 			SSC_POWER_DOWN, 0);
 	} else {
 		err = rtsx_pci_write_register(pcr, FPDCTL, SSC_POWER_DOWN, 0);
-- 
2.39.5 (Apple Git-154)


