Return-Path: <linux-kernel+bounces-623532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 840DAA9F71D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Apr 2025 19:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4773C3B18BF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Apr 2025 17:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C8B28F50B;
	Mon, 28 Apr 2025 17:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="g2Zla/yz"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45280270EBC
	for <linux-kernel@vger.kernel.org>; Mon, 28 Apr 2025 17:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745860641; cv=none; b=TgT6KdQowC8/aIFFIqZQqx8N06p+pI3KSFk0CJDa7eu0Fo6XacVQOxzdPC+R/DkBEUw41UJDd9Sc2aWzExGMdPjHxd+n2Ij4nLcsx8tw1e4iSD3AcXYFGTSMsTMMgRW9fecqCrDrGMc8SG/TapzNpXUKcouNx8HFFxiGSlh7AJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745860641; c=relaxed/simple;
	bh=Q44nlAzJAWRtcbuLv7vRmsMflaRgSG13S50QWb/l6v8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KTgmzQaP0ssl1sx1FA7IFVCie/UjmDVCdpxAK0Z5RcVlfYcoD6GQOFIjiJv1AlYfnl7cN7LZUMU1ScM82ozKi51py5CopRDnaGHvKiKEUAlb6ew1GWQ4Vw9kCryv+KwT0rPt566Z2jmMqMTtyGUV7ndCFP5qGr21SHvWQnBf5E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=g2Zla/yz; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745860635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8R0RWxWmLIRk6b3UDexAAn0Iao0D6NIuoSCe7Qbxh8s=;
	b=g2Zla/yz3sd4i7MJBgkX4D03yzYugMIQsDGcdxEA6L0g60MnsNsiKj0iryCd+oEGj8tu8e
	ptWoUF0nExLXURtV8uHOH/tgOa8xB1ui51UfHPhcIOoysiYHrVll44Fs2FwoxTzi/Shs19
	LeqgDUfVPjDppNhJyo/qzFrkxTtEMdE=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: James Smart <james.smart@broadcom.com>,
	Dick Kennedy <dick.kennedy@broadcom.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: lpfc: Use secs_to_jiffies() instead of msecs_to_jiffies()
Date: Mon, 28 Apr 2025 19:16:26 +0200
Message-ID: <20250428171625.2499-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use secs_to_jiffies() instead of msecs_to_jiffies() and avoid scaling
the timeouts to milliseconds.

No functional changes intended.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/scsi/lpfc/lpfc_bsg.c   | 6 ++----
 drivers/scsi/lpfc/lpfc_vport.c | 4 ++--
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_bsg.c b/drivers/scsi/lpfc/lpfc_bsg.c
index c8f8496bbdf8..d61d979f9b77 100644
--- a/drivers/scsi/lpfc/lpfc_bsg.c
+++ b/drivers/scsi/lpfc/lpfc_bsg.c
@@ -2687,8 +2687,7 @@ static int lpfcdiag_loop_get_xri(struct lpfc_hba *phba, uint16_t rpi,
 	evt->wait_time_stamp = jiffies;
 	time_left = wait_event_interruptible_timeout(
 		evt->wq, !list_empty(&evt->events_to_see),
-		msecs_to_jiffies(1000 *
-			((phba->fc_ratov * 2) + LPFC_DRVR_TIMEOUT)));
+		secs_to_jiffies(phba->fc_ratov * 2 + LPFC_DRVR_TIMEOUT));
 	if (list_empty(&evt->events_to_see))
 		ret_val = (time_left) ? -EINTR : -ETIMEDOUT;
 	else {
@@ -3258,8 +3257,7 @@ lpfc_bsg_diag_loopback_run(struct bsg_job *job)
 	evt->waiting = 1;
 	time_left = wait_event_interruptible_timeout(
 		evt->wq, !list_empty(&evt->events_to_see),
-		msecs_to_jiffies(1000 *
-			((phba->fc_ratov * 2) + LPFC_DRVR_TIMEOUT)));
+		secs_to_jiffies(phba->fc_ratov * 2 + LPFC_DRVR_TIMEOUT));
 	evt->waiting = 0;
 	if (list_empty(&evt->events_to_see)) {
 		rc = (time_left) ? -EINTR : -ETIMEDOUT;
diff --git a/drivers/scsi/lpfc/lpfc_vport.c b/drivers/scsi/lpfc/lpfc_vport.c
index cc56a7334319..2797aa75a689 100644
--- a/drivers/scsi/lpfc/lpfc_vport.c
+++ b/drivers/scsi/lpfc/lpfc_vport.c
@@ -505,7 +505,7 @@ lpfc_send_npiv_logo(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
 		wait_event_timeout(waitq,
 				   !test_bit(NLP_WAIT_FOR_LOGO,
 					     &ndlp->save_flags),
-				   msecs_to_jiffies(phba->fc_ratov * 2000));
+				   secs_to_jiffies(phba->fc_ratov * 2));
 
 		if (!test_bit(NLP_WAIT_FOR_LOGO, &ndlp->save_flags))
 			goto logo_cmpl;
@@ -703,7 +703,7 @@ lpfc_vport_delete(struct fc_vport *fc_vport)
 				wait_event_timeout(waitq,
 				   !test_bit(NLP_WAIT_FOR_DA_ID,
 					     &ndlp->save_flags),
-				   msecs_to_jiffies(phba->fc_ratov * 2000));
+				   secs_to_jiffies(phba->fc_ratov * 2));
 			}
 
 			lpfc_printf_vlog(vport, KERN_INFO, LOG_VPORT | LOG_ELS,
-- 
2.49.0


