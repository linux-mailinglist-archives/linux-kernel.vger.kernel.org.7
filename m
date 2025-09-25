Return-Path: <linux-kernel+bounces-833193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FFBBA1600
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 22:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 280F21B280A6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 20:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D490632143D;
	Thu, 25 Sep 2025 20:36:54 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B4431E0F0;
	Thu, 25 Sep 2025 20:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758832614; cv=none; b=H8x2fhkyCGXslPdNZqADFR2GOGnpcYhrxW1wbW78EYezqxklY7w5IRm2GBoaoaw5uVhVd9fzmtivE3nX8omt6q3VJjZ/YmiLxmUkwIm9/DdG6XH3yLcTENHN8b+BJ8zjfCvVgyv/o1GauM1kdzDBEgpsCuFg0HS3t5IvtLiZIdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758832614; c=relaxed/simple;
	bh=Hm2Qd5r+67hzVASCM80xs+J6rdkp6prOWAVTiQnZvME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NKaxN2Zec5dQta5Qe4C3F1y75QWh4yCkMoIPeVqTyWwar7xR/4Q/3QSiyy3WM/yI0R4iKxq7jd1N1QuHr+jU3xuv2BUYDZMp7LCOz0qAWbn8RymMScTJBNJr0QpILjPaDmA8VHaeCK1D5ihFAE3GyplD0oaaUnDrOAEdO5efXD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A99861692;
	Thu, 25 Sep 2025 13:36:43 -0700 (PDT)
Received: from pluto.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 15BFA3F694;
	Thu, 25 Sep 2025 13:36:48 -0700 (PDT)
From: Cristian Marussi <cristian.marussi@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org
Cc: sudeep.holla@arm.com,
	james.quinlan@broadcom.com,
	f.fainelli@gmail.com,
	vincent.guittot@linaro.org,
	etienne.carriere@st.com,
	peng.fan@oss.nxp.com,
	michal.simek@amd.com,
	quic_sibis@quicinc.com,
	dan.carpenter@linaro.org,
	d-gole@ti.com,
	souvik.chakravarty@arm.com,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH 10/10] firmware: arm_scmi: Use new Telemetry traces
Date: Thu, 25 Sep 2025 21:35:54 +0100
Message-ID: <20250925203554.482371-11-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250925203554.482371-1-cristian.marussi@arm.com>
References: <20250925203554.482371-1-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Track failed SHMTI accesses and received notifications.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/telemetry.c | 57 ++++++++++++++++++++++-----
 1 file changed, 48 insertions(+), 9 deletions(-)

diff --git a/drivers/firmware/arm_scmi/telemetry.c b/drivers/firmware/arm_scmi/telemetry.c
index f03000c173c2..aa706518e5b6 100644
--- a/drivers/firmware/arm_scmi/telemetry.c
+++ b/drivers/firmware/arm_scmi/telemetry.c
@@ -23,6 +23,8 @@
 #include "protocols.h"
 #include "notify.h"
 
+#include <trace/events/scmi.h>
+
 /* Updated only after ALL the mandatory features for that version are merged */
 #define SCMI_PROTOCOL_SUPPORTED_VERSION		0x10000
 
@@ -1021,8 +1023,10 @@ static void scmi_telemetry_tdcf_blkts_parse(struct telemetry_info *ti,
 
 	/* Check for spec compliance */
 	if (USE_LINE_TS(payld) || USE_BLK_TS(payld) ||
-	    DATA_INVALID(payld) || (PAYLD_ID(payld) != 0))
+	    DATA_INVALID(payld) || (PAYLD_ID(payld) != 0)) {
+		trace_scmi_tlm_access(0, "BLK_TS_INVALID", 0, 0);
 		return;
+	}
 
 	/* A BLK_TS descriptor MUST be returned: it is found or it is crated */
 	bts = scmi_telemetry_blkts_lookup(ti->dev, &ti->xa_bts, payld);
@@ -1031,6 +1035,9 @@ static void scmi_telemetry_tdcf_blkts_parse(struct telemetry_info *ti,
 
 	/* Update the descriptor with the lastest TS*/
 	scmi_telemetry_blkts_update(shmti->last_magic, bts);
+
+	trace_scmi_tlm_collect(bts->last_ts, (u64)payld,
+			       bts->last_magic, "SHMTI_BLK_TS");
 }
 
 static void scmi_telemetry_tdcf_data_parse(struct telemetry_info *ti,
@@ -1046,8 +1053,10 @@ static void scmi_telemetry_tdcf_data_parse(struct telemetry_info *ti,
 
 	id = PAYLD_ID(payld);
 	de = xa_load(&ti->xa_des, id);
-	if (!de)
+	if (!de) {
+		trace_scmi_tlm_access(id, "DE_INVALID", 0, 0);
 		return;
+	}
 
 	tde = to_tde(de);
 	/* Update DE location refs if requested: normally done only on enable */
@@ -1094,6 +1103,8 @@ static void scmi_telemetry_tdcf_data_parse(struct telemetry_info *ti,
 		tde->last_ts = tstamp;
 	else
 		tde->last_ts = 0;
+
+	trace_scmi_tlm_collect(0, de->info->id, tde->last_val, "SHMTI_DE_UPDT");
 }
 
 static int scmi_telemetry_tdcf_line_parse(struct telemetry_info *ti,
@@ -1139,8 +1150,10 @@ static int scmi_telemetry_shmti_scan(struct telemetry_info *ti,
 		fsleep((SCMI_TLM_TDCF_MAX_RETRIES - retries) * 1000);
 
 		startm = TDCF_START_SEQ_GET(tdcf);
-		if (IS_BAD_START_SEQ(startm))
+		if (IS_BAD_START_SEQ(startm)) {
+			trace_scmi_tlm_access(0, "MSEQ_BADSTART", startm, 0);
 			continue;
+		}
 
 		/* On a BAD_SEQ this will be updated on the next attempt */
 		shmti->last_magic = startm;
@@ -1152,18 +1165,25 @@ static int scmi_telemetry_shmti_scan(struct telemetry_info *ti,
 
 			used_qwords = scmi_telemetry_tdcf_line_parse(ti, next,
 								     shmti, update);
-			if (qwords < used_qwords)
+			if (qwords < used_qwords) {
+				trace_scmi_tlm_access(PAYLD_ID(next),
+						      "BAD_QWORDS", startm, 0);
 				return -EINVAL;
+			}
 
 			next += used_qwords * 8;
 			qwords -= used_qwords;
 		}
 
 		endm = TDCF_END_SEQ_GET(eplg);
+		if (startm != endm)
+			trace_scmi_tlm_access(0, "MSEQ_MISMATCH", startm, endm);
 	} while (startm != endm && --retries);
 
-	if (startm != endm)
+	if (startm != endm) {
+		trace_scmi_tlm_access(0, "TDCF_SCAN_FAIL", startm, endm);
 		return -EPROTO;
+	}
 
 	return 0;
 }
@@ -1544,6 +1564,8 @@ static void scmi_telemetry_scan_update(struct telemetry_info *ti, u64 ts)
 			tde->last_ts = tstamp;
 		else
 			tde->last_ts = 0;
+
+		trace_scmi_tlm_collect(ts, de->info->id, tde->last_val, "FC_UPDATE");
 	}
 }
 
@@ -1622,8 +1644,11 @@ static int scmi_telemetry_tdcf_de_parse(struct telemetry_de *tde,
 		fsleep((SCMI_TLM_TDCF_MAX_RETRIES - retries) * 1000);
 
 		startm = TDCF_START_SEQ_GET(tdcf);
-		if (IS_BAD_START_SEQ(startm))
+		if (IS_BAD_START_SEQ(startm)) {
+			trace_scmi_tlm_access(tde->de.info->id, "MSEQ_BADSTART",
+					      startm, 0);
 			continue;
+		}
 
 		/* Has anything changed at all at the SHMTI level ? */
 		scoped_guard(mutex, &tde->mtx) {
@@ -1639,11 +1664,16 @@ static int scmi_telemetry_tdcf_de_parse(struct telemetry_de *tde,
 		if (DATA_INVALID(payld))
 			return -EINVAL;
 
-		if (IS_BLK_TS(payld))
+		if (IS_BLK_TS(payld)) {
+			trace_scmi_tlm_access(tde->de.info->id,
+					      "BAD_DE_META", 0, 0);
 			return -EINVAL;
+		}
 
-		if (le32_to_cpu(payld->id) != tde->de.info->id)
+		if (le32_to_cpu(payld->id) != tde->de.info->id) {
+			trace_scmi_tlm_access(tde->de.info->id, "DE_INVALID", 0, 0);
 			return -EINVAL;
+		}
 
 		/* Data is always valid since NOT handling BLK TS lines here */
 		*val = LINE_DATA_GET(&payld->l);
@@ -1667,10 +1697,16 @@ static int scmi_telemetry_tdcf_de_parse(struct telemetry_de *tde,
 		}
 
 		endm = TDCF_END_SEQ_GET(tde->eplg);
+		if (startm != endm)
+			trace_scmi_tlm_access(tde->de.info->id, "MSEQ_MISMATCH",
+					      startm, endm);
 	} while (startm != endm && --retries);
 
-	if (startm != endm)
+	if (startm != endm) {
+		trace_scmi_tlm_access(tde->de.info->id, "TDCF_DE_FAIL",
+				      startm, endm);
 		return -EPROTO;
+	}
 
 	guard(mutex)(&tde->mtx);
 	tde->last_magic = startm;
@@ -1840,6 +1876,9 @@ scmi_telemetry_msg_payld_process(struct telemetry_info *ti,
 			tde->last_ts = LINE_TSTAMP_GET(&payld->tsl);
 		else
 			tde->last_ts = 0;
+
+		trace_scmi_tlm_collect(timestamp, tde->de.info->id, tde->last_val,
+				       "MESSAGE");
 	}
 }
 
-- 
2.51.0


