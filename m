Return-Path: <linux-kernel+bounces-623540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03346A9F735
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Apr 2025 19:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D4D81A81377
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Apr 2025 17:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F098028DF0D;
	Mon, 28 Apr 2025 17:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pJSdKjas"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9DB27FD6A
	for <linux-kernel@vger.kernel.org>; Mon, 28 Apr 2025 17:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745860987; cv=none; b=Zw2St4bpNLCezMswPOTHyIGD0EUaPKWEW+/suZZJtOwssVuTolmy6XanN3PK8HMT8NUB9jeS1twoYW/ZBsQNs8VLc8Co0jOKseo8Frk5azOwiV/8gOBo1wDY7OIvXq/XMzQj22hrYCvTXEHfXzrULo9u0cMlBzvjLMkl6hg8+ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745860987; c=relaxed/simple;
	bh=38lrtvP3Fegb2/yFDBCyBNOYLbgJmqfz9glOU33c8cA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MLCxwI0E0zjLMrRoWP8kaJtmyvb4uO6+5Y2FHUYbxvxZfRcPOCF82rXZ7CBF3sK8MapRa/MZEFnGEXwSkvosBVjbH0uEubUiAJpwGvQrPvwWDvSIsQ3intAiKiTcQMLeiPxP03IH8tT+cpkyonXo+kjJuPdz8RYxU2EHW0NbxBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pJSdKjas; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745860973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PFkNkl64NBVDb+0cR8KGO6d71bTbYgYFpudiWpVGc+M=;
	b=pJSdKjasmS03w+a2oAjY6Wjy/xlRqUHF7EoG2H3lGSaOaG+oW/W7/LCxH3f04hO/wDWvhG
	AVtvrIst6eAs/HDNQyhr4kcdZD5IoVWhslVY+Lqg5kGr6Se6h3rUFPBLwmMfiJEGNUZ/u5
	aDb7IAsKvb4YmgUmoMSFJCa6HTZtj+c=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Nilesh Javali <njavali@marvell.com>,
	GR-QLogic-Storage-Upstream@marvell.com,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: qla2xxx: Use secs_to_jiffies() instead of msecs_to_jiffies()
Date: Mon, 28 Apr 2025 19:22:05 +0200
Message-ID: <20250428172205.2749-2-thorsten.blum@linux.dev>
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
index 6b9b8218b512..276441e26ae2 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -1303,8 +1303,8 @@ qla2xxx_eh_abort(struct scsi_cmnd *cmd)
 	       "Abort command mbx cmd=%p, rval=%x.\n", cmd, rval);
 
 	/* Wait for the command completion. */
-	ratov_j = ha->r_a_tov/10 * 4 * 1000;
-	ratov_j = msecs_to_jiffies(ratov_j);
+	ratov_j = ha->r_a_tov / 10 * 4;
+	ratov_j = secs_to_jiffies(ratov_j);
 	switch (rval) {
 	case QLA_SUCCESS:
 		if (!wait_for_completion_timeout(&comp, ratov_j)) {
@@ -1818,8 +1818,8 @@ static void qla2x00_abort_srb(struct qla_qpair *qp, srb_t *sp, const int res,
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
2.49.0


