Return-Path: <linux-kernel+bounces-839838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B68A0BB2885
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 07:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BF8D17F07A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 05:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4AA27FD4A;
	Thu,  2 Oct 2025 05:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YqUeviPY"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A6A23185E
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 05:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759382797; cv=none; b=fLhGHja2IzGs5dtdtav1mhCWpjDNHRBOlEFTBKinId7C89J58aVsiyga3yEI293/2pRE2vP2GyhHyCqa85swX2qPUzUnwyMlNHhjPn2DqkRj9NK24EZ58ngpjLvIdVwm/v9+uYX/UQ7DUv214ju18gYzSdukBVqMOVfgUu7rD+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759382797; c=relaxed/simple;
	bh=IrCR+MhlLo9ogR9M2WOk3pIVlPMhWUizgRZCayEgJL0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L/tsmt802VF5yVz1JLEsCbnmvvBdqsOhfoZjhm0IzI7fg8LVJJ4JL6hcN0s4A1miFo6yBp6Lzpjz3YnUr8M9dAieuug4UZNlBrX8j6+ne6qG8fgBtYpVYDp8rbOtzZRGvGL1OIzWR1dEUR0v7NYJAxLVRMUxlnEuUDxxaJmS50U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YqUeviPY; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-578ecc56235so548354e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 22:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759382794; x=1759987594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eK6KFYZ1WJDqYwvEkBhzBI4Di9nWKpUoo1mNcrKQMbg=;
        b=YqUeviPYuDTVrOUoSb/FG+fPS9eHUnnMrmxQZ2WmhaEXdV74JnrQWMxtX6eXJ0FDw2
         bKmWpCZcfgSu66RyIyYsIIKu09Wt7PPF2z/Z01xODe/etIaJECNEYfa37MOg6U1awTZo
         7udN4vTtPC2OYPV9d/9Wee6KI66lkZ7eG1rWPZicwQxNZnLG/tbFXp21hsgKuwEoIA/G
         yKL7ptIvu6XtPvolLOOZXR8cxyQGEfZp6ncOSjlNIAu09jnnH2i1egHVR7sti7akvFSM
         njFHw0Lj5xXp89BjIjrCm/eLWYP2JdZNzIztJ+LvgHmBQ3fStDqaliu/PWQVQdPeMS37
         EO/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759382794; x=1759987594;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eK6KFYZ1WJDqYwvEkBhzBI4Di9nWKpUoo1mNcrKQMbg=;
        b=W/gipqdnDRK8gudQ8F2FMNlXq1t0mhtZDo+3HEEvDW0Aot0cXY9krT2o7W3fZ4pOhC
         UXt0MXl1LA3c1Xq81Y4DoyK+RrCSUy8u6u+1tWh2zbHcoeFwLsoxKHvWzvmIOQ/QSL9u
         nONYrnSQLI/1GQPv7XUihIJYv1Teu65PpxKD2/Vl6be/KRwH8WZYA0tRPYlIbKhlZQqx
         nDq7sUMsZpWzGGCE47E2+aaW+m2b1k/p67OxtNWo9b3D6elKiw/XpC6+7JkGW70V1r1l
         vUHDSM4h4j1YaBdl3lDPjuaxZ1sflT+bQvJvBv0w35ilIDgpykChrtBP4INnTmL/gp7+
         tZWQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3J+Ek2sryoxTv3VCH5Cv+jhH/vmQ6Vlp2OYdWG0E65vB//7V5mKVXois86YWJ11fvewUfiMuNE/ii79g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrcsE4QYXqcCMRh5WCk22+qRLaFJXMlGHCrx9tw5hgUYAT+ugf
	JdcuHZPP52Vki1EAbVGy8YyOdvBT6CmIoMfJpVV4f1oFxS1komzUqDRs
X-Gm-Gg: ASbGncs8GFAW6gzmNzUFfOAxV6dq0Pc73hoh4hXDqLvWFJbvZulvqLO10WoTaLjTqYw
	6N7IdoDmlviiG9pRVxhopZk0cWCObH0o1bbZX7LFC1VmX+NlqYaT6TzO+LkbinzKxwSmrMZzLNG
	pE8JfmQkwCn84caRl+VccZSayb65+POLMh4v1nniq6rCTOZOSJDAWS1VqVBvcbym2AmuIFHaej+
	6FLDKqGuna9z7nc7PmQ2zikX0o3NfkQNxEKWbkSLRgAcSOyYwfIFuN8DD415GPKXda95eS7UWQT
	c0o2csGNDct82LvH1sdslaOSwPhZcplS3qe4zcIqVOPl22tz5pM+O4NCKb7n/L0HZhRQm/gB317
	fR7TTuQbBqgd8HZPf3Q9ZhTmWsm8JukihTF4Q8MHvt6bBdcMfwDCY4Wy6c4NDxvVWCsYBtugwap
	YiXxMdVZ+BLYBLHrVIUridL2k=
X-Google-Smtp-Source: AGHT+IGx0TmMId2k4OxpwBsBxNp5vaWRWUNwEeINRHFP67qi+nW6n36bR9aB6MgBpyixiRJR6NaLfw==
X-Received: by 2002:ac2:51c6:0:b0:55f:536f:e895 with SMTP id 2adb3069b0e04-58af9f50c7emr1801728e87.45.1759382793740;
        Wed, 01 Oct 2025 22:26:33 -0700 (PDT)
Received: from buildhost.darklands.se (h-94-254-104-176.A469.priv.bahnhof.se. [94.254.104.176])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b01124438sm510914e87.4.2025.10.01.22.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 22:26:33 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: james.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Magnus Lindholm <linmag7@gmail.com>
Subject: [PATCH] scsi: qla1280.c: fix compiler warnings (DEBUG mode)
Date: Thu,  2 Oct 2025 07:25:24 +0200
Message-ID: <20251002052604.24590-1-linmag7@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Building the qla1280 driver with DEBUG_QLA1280 set will emit compiler
warnings. Fix some print formatting strings to reflect the correct
type of printed variables as well as remove unused  code. (static
function ql1280_dump_device) in order to avoid compiler warnings.

Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 drivers/scsi/qla1280.c | 35 ++++++-----------------------------
 1 file changed, 6 insertions(+), 29 deletions(-)

diff --git a/drivers/scsi/qla1280.c b/drivers/scsi/qla1280.c
index 6af018f1ca22..55262500d11e 100644
--- a/drivers/scsi/qla1280.c
+++ b/drivers/scsi/qla1280.c
@@ -2799,7 +2799,7 @@ qla1280_64bit_start_scsi(struct scsi_qla_host *ha, struct srb * sp)
 
 	dprintk(2, "start: cmd=%p sp=%p CDB=%xm, handle %lx\n", cmd, sp,
 		cmd->cmnd[0], (long)CMD_HANDLE(sp->cmd));
-	dprintk(2, "             bus %i, target %i, lun %i\n",
+	dprintk(2, "             bus %i, target %i, lun %llu\n",
 		SCSI_BUS_32(cmd), SCSI_TCN_32(cmd), SCSI_LUN_32(cmd));
 	qla1280_dump_buffer(2, cmd->cmnd, MAX_COMMAND_SIZE);
 
@@ -2871,7 +2871,7 @@ qla1280_64bit_start_scsi(struct scsi_qla_host *ha, struct srb * sp)
 			remseg--;
 		}
 		dprintk(5, "qla1280_64bit_start_scsi: Scatter/gather "
-			"command packet data - b %i, t %i, l %i \n",
+			"command packet data - b %i, t %i, l %llu \n",
 			SCSI_BUS_32(cmd), SCSI_TCN_32(cmd),
 			SCSI_LUN_32(cmd));
 		qla1280_dump_buffer(5, (char *)pkt,
@@ -2929,14 +2929,14 @@ qla1280_64bit_start_scsi(struct scsi_qla_host *ha, struct srb * sp)
 			remseg -= cnt;
 			dprintk(5, "qla1280_64bit_start_scsi: "
 				"continuation packet data - b %i, t "
-				"%i, l %i \n", SCSI_BUS_32(cmd),
+				"%i, l %llu \n", SCSI_BUS_32(cmd),
 				SCSI_TCN_32(cmd), SCSI_LUN_32(cmd));
 			qla1280_dump_buffer(5, (char *)pkt,
 					    REQUEST_ENTRY_SIZE);
 		}
 	} else {	/* No data transfer */
 		dprintk(5, "qla1280_64bit_start_scsi: No data, command "
-			"packet data - b %i, t %i, l %i \n",
+			"packet data - b %i, t %i, l %llu \n",
 			SCSI_BUS_32(cmd), SCSI_TCN_32(cmd), SCSI_LUN_32(cmd));
 		qla1280_dump_buffer(5, (char *)pkt, REQUEST_ENTRY_SIZE);
 	}
@@ -3655,7 +3655,7 @@ qla1280_status_entry(struct scsi_qla_host *ha, struct response *pkt,
 
 			dprintk(2, "qla1280_status_entry: Check "
 				"condition Sense data, b %i, t %i, "
-				"l %i\n", SCSI_BUS_32(cmd), SCSI_TCN_32(cmd),
+				"l %llu\n", SCSI_BUS_32(cmd), SCSI_TCN_32(cmd),
 				SCSI_LUN_32(cmd));
 			if (sense_sz)
 				qla1280_dump_buffer(2,
@@ -3955,7 +3955,7 @@ __qla1280_print_scsi_cmd(struct scsi_cmnd *cmd)
 
 	sp = scsi_cmd_priv(cmd);
 	printk("SCSI Command @= 0x%p, Handle=0x%p\n", cmd, CMD_HANDLE(cmd));
-	printk("  chan=%d, target = 0x%02x, lun = 0x%02x, cmd_len = 0x%02x\n",
+	printk("  chan=%d, target = 0x%02x, lun = 0x%02llx, cmd_len = 0x%02x\n",
 	       SCSI_BUS_32(cmd), SCSI_TCN_32(cmd), SCSI_LUN_32(cmd),
 	       CMD_CDBLEN(cmd));
 	printk(" CDB = ");
@@ -3976,29 +3976,6 @@ __qla1280_print_scsi_cmd(struct scsi_cmnd *cmd)
 	printk(" underflow size = 0x%x, direction=0x%x\n",
 	       cmd->underflow, cmd->sc_data_direction);
 }
-
-/**************************************************************************
- *   ql1280_dump_device
- *
- **************************************************************************/
-static void
-ql1280_dump_device(struct scsi_qla_host *ha)
-{
-
-	struct scsi_cmnd *cp;
-	struct srb *sp;
-	int i;
-
-	printk(KERN_DEBUG "Outstanding Commands on controller:\n");
-
-	for (i = 0; i < MAX_OUTSTANDING_COMMANDS; i++) {
-		if ((sp = ha->outstanding_cmds[i]) == NULL)
-			continue;
-		if ((cp = sp->cmd) == NULL)
-			continue;
-		qla1280_print_scsi_cmd(1, cp);
-	}
-}
 #endif
 
 
-- 
2.49.0


