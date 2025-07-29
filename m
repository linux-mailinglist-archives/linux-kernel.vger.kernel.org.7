Return-Path: <linux-kernel+bounces-748769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0899B145D6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 03:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15AC73BAD5A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 01:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055351F1317;
	Tue, 29 Jul 2025 01:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RfSDiTIB"
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E59017578
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 01:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753752915; cv=none; b=OmPsGTb03dqiC/znxWfVCIyNopuXfte/K9XROc7qZYiVEnlRgTS7MHzf5A5AbS159qpXCjkQFo2Z9Qxg3ZhNU3oXzB0AicAU+ISa1qf8HyvlfXcX8mcnGrWW4+UX+JmEndWeXw2BHNHmZl6IqJKqmTTfFzAy4yaGUeuNkbSvVpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753752915; c=relaxed/simple;
	bh=417s9K9vMJGYNSAt2caW8cTsx0O5xolM3LHhI3shnVA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AzwtvR1Z7XnY3CzUmTk2DtyzzrFB6Afj587iR6yRw1AvdIxC3O5K//oflr5jVPsWJXFhQ6vHiUD5GpuRTcvQ5lsWnxUnkgQAZH9gSt9XsRVWyG+E6J8GO/crNEk5UIatT/qm7/cUg4LpsBeOM0kO2jsftAU+8Cx3DAXXf9aK0po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RfSDiTIB; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-31ee880f7d2so1661044a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 18:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753752913; x=1754357713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Rt9mX5Mb6s2byllZfTIS4H+QBzV029aCkfK2lwXebF8=;
        b=RfSDiTIBnzzqc+yZrNIUWKnb408BUdpYu9DmZ6GjI2aYpuuNHTfAfbGY5pj2YJg9G+
         RemaJdNujn0tAuYZ8gJdG5pBeRBSxlisL/EQe9ADGhhGr1WeDOx70QHlIG+JaBmF1skn
         ePX01WJdzM7vZ1xjCeEmEuX5ggfiacdbd5W5Th6t+dUn9Ije1/W+X8Fq15NopIQXc83p
         /eA9VD/uLfp9fcQbxN++VDgkByFOffQ8BfXZZBu9+7tx7w8DV4RxNWDUnR/4QMbGk3c+
         HkEzXbojIrFlcTTnTGZkFXyuNa0qGMhnaSH8B8jIvnz3PVRW3PiUHVCf/fz9jphRxIMj
         ISHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753752913; x=1754357713;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rt9mX5Mb6s2byllZfTIS4H+QBzV029aCkfK2lwXebF8=;
        b=kS5wPADcGqwUge/qQViyGo2taxyWfXuGZLM+VNvfTicXKvhibRMoODDfe+UAVp7l7N
         BXBscHuSqTKVV3Gtz1Cd/FNOCdSMyMJkWNnTn3Pd8388VH7SiRmn73fFmxYiM2l/7PK7
         IRk7+GvOSiCZ3ga/kCUTFafGEeDAN+7EHbTJYjaOKkf/A1Da4utAc7HpG4SMSMTR+QHz
         juzrTrso+7IRmy4x8nPyEdzIqUWVMx9kSktnRcb+qfFZ2ag+8Ngbic//AhonvbIM/vbs
         CTam2U2621PZvQ+VThF3GRoDcrH8kC2EkeKJ8HV8gDRBzcki8KBpwpXeJF85Rp4y8o1j
         AQNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrBBJ/T2Bv7tu+Znj6gNw3BiGc4A4toaCZaX46y2LLGY5e8bJktV520nW3+GhmOKqxfX7a+V/0qCjKYto=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEOVyT9ELOYtAJ53hX1sVEvj+tQy4Knx1CY47QgJQdg20czjDD
	jBSo5HNCakXlwDu+yqkIsSf2IFV1eDtNMokyetxtsa7n0TUyrdIKObaE
X-Gm-Gg: ASbGncujW+QyANwQpdVEdWgSAiVYixDhaEOHYvmzqFpozW+E17jh8qXSXIZ8uasRHAv
	a46LFpqmmusGPsnhWCzgS97v9yk4cMNL7TOO78JWSu90F9lQgGIM1zgVlKaTnV2Hhy+aCLt3jio
	xmDQtNEWOcW0qCA5qmoHPaKwRnx28WOfMIp2Wg4iKRxrVPZ1phDsK6J6PxNQYKRW/uSjyCGWegl
	gf+s1+8/Es3ifwML4Ek88wgHKv48qaeDD+wZQeg12FbsQR1MfhVEDtEwuZgrf3CBd3Y5qWB0GVR
	2mnmZDu87OPUy0IXqe2RvgkLDpadwkbgtZzosjjdB32ge4MnyHnNBBR2U0yFoVOjKxsg+ib/QUt
	SyoN9vzfEsdzHXs+4dpjCW75x+76Xfg==
X-Google-Smtp-Source: AGHT+IEYkTal4nceQr+Hsq7FyOMvq/QX8UWdGciXifD+Vuh70D/a0Jat1uDfWwNb6vQzeZqki9OV8A==
X-Received: by 2002:a17:90b:3bc4:b0:308:7270:d6ea with SMTP id 98e67ed59e1d1-31e77a2483fmr17407876a91.30.1753752913253;
        Mon, 28 Jul 2025 18:35:13 -0700 (PDT)
Received: from localhost.localdomain ([167.220.61.18])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7640b3d3d3csm6564895b3a.111.2025.07.28.18.35.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 28 Jul 2025 18:35:12 -0700 (PDT)
From: Tian <27392025k@gmail.com>
To: gregkh@linuxfoundation.org
Cc: arnd@arndb.de,
	linux-kernel@vger.kernel.org,
	Tian Liu <27392025k@gmail.com>
Subject: [PATCH misc v2] misc: cardreader: fix overwritten return value in RTS5260 driver
Date: Mon, 28 Jul 2025 18:35:10 -0700
Message-Id: <20250729013510.34358-1-27392025k@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tian Liu <27392025k@gmail.com>

In both rts5260.c and rtsx_pcr.c, a return value is assigned and then
overwritten by a subsequent call, which causes the original result to be
lost. This may result in silently ignoring errors from the first write.

This patch uses `err |=` to preserve earlier failure status.

This is an untested cleanup inspired by commit c55c7a85e02a ("um: ubd: Preserve earlier error value in ubd_user") which fixed similar error-handling logic. While this change has not been functionally tested on hardware, it is a mechanical fix and aligns with expected error-handling style.

Fixes: bede03a579b3 ("misc: rtsx: Enable OCP for rts522a rts524a rts525a rts5260")
Fixes: c0e5f4e73a71 ("misc: rtsx: Add support for RTS5261")

Signed-off-by: Tian Liu <27392025k@gmail.com>

Changes in v2:
- Use full name in Signed-off-by and From
- Add Fixes: tag
- Clarify that patch is untested, but reasoned from upstream style
- Cc: appropriate public mailing list

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


