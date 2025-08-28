Return-Path: <linux-kernel+bounces-790351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA90B3A5D6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 18:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2EDEE4E22BB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 16:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35102D6407;
	Thu, 28 Aug 2025 16:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="c4Hrq8ZM"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6261A25D202
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 16:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756397594; cv=none; b=lmAUdHugnHbysvFhfqLwI0kjPKGV0Oqyjxv1r7aWvszWI30BBupdplXkOyhRIxc+oi2GtoXRxPCCxFQmat7Iik99nK8Wkt5ZgZ+eu+V0Z0vOssys/KbQkrvTO3Dr2NbCVkr7KdF1LMIsQ2thz0ZkLgPabJDsucNlkjiwbnac3Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756397594; c=relaxed/simple;
	bh=mFfLc2w4A1s0Z+GSo7QaZhoKYbIHCQGO4bXrafwtMjs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RMHmXthEpJInzVVU5wKAp0DP9Q6iF3Uj3lqIWNqzl9F2c12B3sLcOmNSdif2mLGmXGEL1rbSWuQo1Pkd8g6eqitNOoRDPCyIVCTUnBTBOh0nfiFy1RXEPITxfbAjfm4/FjyFSy42JhJqsk1gOrXDvFHrJX3Oy2VFrGX08MQBNPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=c4Hrq8ZM; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756397580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZvjX2ifl7fBCryv7z+YmmCfuSCRQ329m4eE0VyNCgVs=;
	b=c4Hrq8ZMkjm/bUMRu9m0RqhuURkaxCZ8f/p7fRXL3/IBdaYgfq2GfgqzzS9Y0nrfcy8zya
	leKu67rSZ7BcVKDqjfFzBuyD+YiuPAE/GImyc5+xF9edkIArTDWdomqaAGdb3b7pjBOW2y
	wOB4tNAdHEYO8W0d8xAqga1oxnTKH/U=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Nilesh Javali <njavali@marvell.com>,
	GR-QLogic-Storage-Upstream@marvell.com,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] scsi: qla2xxx: Use secs_to_jiffies() instead of msecs_to_jiffies()
Date: Thu, 28 Aug 2025 18:11:53 +0200
Message-ID: <20250828161153.3676-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use secs_to_jiffies() instead of msecs_to_jiffies() and avoid scaling
'ratov_j' to milliseconds.

No functional changes intended.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/scsi/qla2xxx/qla_bsg.c | 4 ++--
 drivers/scsi/qla2xxx/qla_os.c  | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_bsg.c b/drivers/scsi/qla2xxx/qla_bsg.c
index 10431a67d202..ccfc2d26dd37 100644
--- a/drivers/scsi/qla2xxx/qla_bsg.c
+++ b/drivers/scsi/qla2xxx/qla_bsg.c
@@ -3106,8 +3106,8 @@ static bool qla_bsg_found(struct qla_qpair *qpair, struct bsg_job *bsg_job)
 	switch (rval) {
 	case QLA_SUCCESS:
 		/* Wait for the command completion. */
-		ratov_j = ha->r_a_tov / 10 * 4 * 1000;
-		ratov_j = msecs_to_jiffies(ratov_j);
+		ratov_j = ha->r_a_tov / 10 * 4;
+		ratov_j = secs_to_jiffies(ratov_j);
 
 		if (!wait_for_completion_timeout(&comp, ratov_j)) {
 			ql_log(ql_log_info, vha, 0x7089,
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index d4b484c0fd9d..9a2f328200ab 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -1291,8 +1291,8 @@ qla2xxx_eh_abort(struct scsi_cmnd *cmd)
 	       "Abort command mbx cmd=%p, rval=%x.\n", cmd, rval);
 
 	/* Wait for the command completion. */
-	ratov_j = ha->r_a_tov/10 * 4 * 1000;
-	ratov_j = msecs_to_jiffies(ratov_j);
+	ratov_j = ha->r_a_tov / 10 * 4;
+	ratov_j = secs_to_jiffies(ratov_j);
 	switch (rval) {
 	case QLA_SUCCESS:
 		if (!wait_for_completion_timeout(&comp, ratov_j)) {
@@ -1806,8 +1806,8 @@ static void qla2x00_abort_srb(struct qla_qpair *qp, srb_t *sp, const int res,
 		rval = ha->isp_ops->abort_command(sp);
 		/* Wait for command completion. */
 		ret_cmd = false;
-		ratov_j = ha->r_a_tov/10 * 4 * 1000;
-		ratov_j = msecs_to_jiffies(ratov_j);
+		ratov_j = ha->r_a_tov / 10 * 4;
+		ratov_j = secs_to_jiffies(ratov_j);
 		switch (rval) {
 		case QLA_SUCCESS:
 			if (wait_for_completion_timeout(&comp, ratov_j)) {
-- 
2.50.1


