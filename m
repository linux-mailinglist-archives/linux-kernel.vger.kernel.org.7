Return-Path: <linux-kernel+bounces-698886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C0AAE4B69
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 18:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A075189A1FB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 16:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA712BCF4B;
	Mon, 23 Jun 2025 16:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gpmoWZTr"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6BA28313D
	for <linux-kernel@vger.kernel.org>; Mon, 23 Jun 2025 16:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750697039; cv=none; b=iusTuHip/SB+VOKgS9cj6vOSc/P2QT2ZLvOETjUbsKdfR5kHqoXMNYKOVIFZM3T5rsyJXDPn9FRc6OVZUFXy615c4IKZCwh9X8myLOtVt1EVyFb7ANGxjQ31VJrwJPIjnNLy2dDBEZ/PQcQXqRWeNLBkClT4lAR3+3q70XCQcEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750697039; c=relaxed/simple;
	bh=YZUBtdMrOu9oRJYltUtsuCHLn65wM+oMi2tnyHqk1ck=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HFdZAVyv4YO49xNn6/acshuHr4C71XYlbe3EFTcJSL00z+OCz8kkUDRIdHvYT/3Suah1a/IrelXuLij4+1Lg4oRsrMCYILKQMFge8ystKbb0X7pZRGwtkNaZKbgSnnoj0paebQ40Gul7AFvQwx7gk6j51RJUog6PssMdWGF1+fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gpmoWZTr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55NGKuo0002966
	for <linux-kernel@vger.kernel.org>; Mon, 23 Jun 2025 16:43:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6Gp4KTM2ss1gIVnakPLCD9UpvQd1HhAAfpFPPwxXMtE=; b=gpmoWZTrzmcKuE+y
	Mv57i6/4TSXgcB2+QO8AuIsOHKAvVeMh4F7ZYmyEToJJxXvi7UOXFuQBOfgfmJhz
	JTb2jEULvdu5tZrCkyiY9tBf0yCi55wKb4lATKYsz3qYQM0EZ1HEb6EsvZpUy9n6
	KTwXImi5jZKSoOzax76TtSX13iyYb6Pkc2h6sORwtOe/dCNfpu4/dpMtuf+La4I6
	BneQFkYtrQ7QrXf/gYP4zUIUFICQ1N/t8VFBBl2k2hBn1RadyYUulwLsZs2BWgAd
	8+jlAcKSiZgFKU5CL2c4ocva9oOMKfdiT3qtYETy+DNlZ1b/vJQ1FnqGdhswz7xB
	gdnMaw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47fabd821h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 23 Jun 2025 16:43:56 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b2fcbd76b61so5481241a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jun 2025 09:43:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750697035; x=1751301835;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Gp4KTM2ss1gIVnakPLCD9UpvQd1HhAAfpFPPwxXMtE=;
        b=w73phtLTUxOygS0+hcVJlw3nKzdlY2jRzTqRxjQ6SMWOeavp0F1XYGc6aBunsePdJT
         K6Mc9VJ8HTFh7FRjcqiLQronSzbt9AjutMGm1+q1JfNB8qtlCYRsPXWzHnBictwWJ3ys
         GrEZBSrLqesXOXdYLEEQZdCF920W0tPESjAp1x5oFH67Y98wmeWk709P5N8Jr8TcvO4F
         ojXunjauQnKsKsRz31Krx6vDCaTA+afSeykSoLaNvB6S1paGkS6oWZvDegyn46Pcloou
         Gix688I8rSD9JOn/MaNvE4ILxXjYnJ2TKsOKqoQsvNElLlzzXNv0rktxnbkW6CWkZGE9
         M4ow==
X-Forwarded-Encrypted: i=1; AJvYcCXZJEynxRpA65heGkpAwyqObRXoe+eb+VIoI+t5rXioaDQwF43MAKqkRASkzTbD8/vSwFX9894lwBwipqU=@vger.kernel.org
X-Gm-Message-State: AOJu0YybD8N6/qQ6V9S6vn0Z745vwioY5KcA1SI7uAsRxbN/b/fxPhlH
	Fcuw8kTB8xAQTSqY8xxzXUEJMuH5k1wWz+jrxOPMDBBJvKdMVHxgUTynOEtSoqC4fhO8G/drtet
	gtcpSvfVg/hvFC5NhP4cxIzBCdDkRtzPVc19dFxh19b3eIf/m33vsmzTDh4gZV1S34DE=
X-Gm-Gg: ASbGncs4RNhkgMVYtuJ4desSzgWxQTonPBKC0qKFAYOEifvfAg7ON2CQqAjFMbfoZC6
	UbO39djvxPuC7fWj6jRxZDLZDmXOpPrf4C8XxsvBwUpEdXSGmS9UvCBYBzD6YzSBqMYyxQwQqZN
	crTiG3ZKggHhGQgSarR54bOH1Nk9xR9Az3XKuxGU4s/Qr21xiq8+0w/PpCpi42Agmyp5PidvAxp
	mDcsIlJuJqIvYPRhKBl9Kn512T2hAoXFNe8LE95di3h6JuANIgwGK3n7jNwrIE4LhD5YJOmYyuH
	0PR7dmlZTDMBxFkKv9yomHxGYNUlxvV/u9sXYzGTcThteOZf/31J
X-Received: by 2002:a17:90b:2889:b0:311:e8cc:4248 with SMTP id 98e67ed59e1d1-3159d8f7f8emr25727507a91.33.1750697035149;
        Mon, 23 Jun 2025 09:43:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7X9jf+cu1c0sm4aA1WuSCQvY3/vycTn+T2aPmrvRj0ZYX3vnW7zvYC9mDTYusdSfBoC548w==
X-Received: by 2002:a17:90b:2889:b0:311:e8cc:4248 with SMTP id 98e67ed59e1d1-3159d8f7f8emr25727484a91.33.1750697034750;
        Mon, 23 Jun 2025 09:43:54 -0700 (PDT)
Received: from hu-kamalw-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3159e048346sm9271254a91.26.2025.06.23.09.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 09:43:54 -0700 (PDT)
From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Date: Mon, 23 Jun 2025 22:13:40 +0530
Subject: [PATCH 1/2] soc: qcom: rpmh: Add support to read back resource
 settings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250623-add-rpmh-read-support-v1-1-ae583d260195@oss.qualcomm.com>
References: <20250623-add-rpmh-read-support-v1-0-ae583d260195@oss.qualcomm.com>
In-Reply-To: <20250623-add-rpmh-read-support-v1-0-ae583d260195@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        Maulik Shah <maulik.shah@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750697028; l=7829;
 i=kamal.wadhwa@oss.qualcomm.com; s=20241018; h=from:subject:message-id;
 bh=Deo7CKV42V7f0kQwaNWmGiavoI3ZoT4v46mr2+YU2yo=;
 b=a4sojfD84Lo46zdhKgpPLd3fwsOR3V/ye/0R4FY+vXkRE2NnV9waoeetz6o5Teakcc95Seq+I
 YAWHwR+8BQdB7WSzG5eHXVdbehEjDeZDR1V0jEPalAX6YHPBvflsf0k
X-Developer-Key: i=kamal.wadhwa@oss.qualcomm.com; a=ed25519;
 pk=XbPE6DM5/mJi2tsiYwMCJCZ4O5XPMqColJRlGVcM7Hs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDEwMSBTYWx0ZWRfX+zuIun/FHb4v
 0KW/X8mFA9NfoyGD960kfAobsP99wSrvLkSrSzC8uPNAix8vYqU9LeVPNOXe1s7YSUibdihLdcq
 CBDLxU4OJGgQe8h3dPBcZXvfayWUvXh+aIER2hodrNj7oqXAFFbxF8Dogl5hKQFYuXQvXbgWnls
 XSKK/5/PxbisFTseQe2mQVxJImLdGxBgQzgCLzeNADCpClC7zghQlaZEAQ/aa1Gt/TsY8WzF0kt
 vT6lxM2AlMhkPp/4s/HbwXdS9YYXg2b2P5YCVAnpyQE34SWuNSiEAu4Y9K/WmzuBzWk19N2exoe
 GwbM2Y9Nqn1nWOv9a6F3A249cyiwnzLBzHv7rh5d7NM1DILNSRd+L3ee0YT1Q+wdCOl/vJR2D0c
 gIytiEgUUWFY4hKvQSfZ/6t33GHNwSD/MBG/j2npS2nmz8raBVYK6xkiG+IrfRemqtwOgx6y
X-Authority-Analysis: v=2.4 cv=FK8bx/os c=1 sm=1 tr=0 ts=6859844c cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=J08J-H9Ko50usCvt6EIA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: h-PI8GSLWJQ7GE2-txeOtf06EgVgd9GN
X-Proofpoint-GUID: h-PI8GSLWJQ7GE2-txeOtf06EgVgd9GN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-23_04,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 mlxlogscore=999 mlxscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0
 priorityscore=1501 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506230101

From: Maulik Shah <maulik.shah@oss.qualcomm.com>

All rpmh_*() APIs so far have supported placing votes for various
resource settings but the H/W also have option to read resource
settings.

This change adds a new rpmh_read() API to allow clients
to read back resource setting from H/W. This will be useful for
clients like regulators, which currently don't have a way to know
the settings applied during bootloader stage.

Signed-off-by: Maulik Shah <maulik.shah@oss.qualcomm.com>
---
 drivers/soc/qcom/rpmh-rsc.c | 12 ++++++++--
 drivers/soc/qcom/rpmh.c     | 54 +++++++++++++++++++++++++++++++++++++++++----
 include/soc/qcom/rpmh.h     |  7 ++++++
 include/soc/qcom/tcs.h      |  2 ++
 4 files changed, 69 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index cb82e887b51d4401edba713348eed9621622b73b..18eed2cb8d300e862991efc20be58ff7ead378ce 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -443,6 +443,7 @@ static irqreturn_t tcs_tx_done(int irq, void *p)
 	int i;
 	unsigned long irq_status;
 	const struct tcs_request *req;
+	u32 reg;
 
 	irq_status = readl_relaxed(drv->tcs_base + drv->regs[RSC_DRV_IRQ_STATUS]);
 
@@ -453,6 +454,11 @@ static irqreturn_t tcs_tx_done(int irq, void *p)
 
 		trace_rpmh_tx_done(drv, i, req);
 
+		if (req->is_read) {
+			reg = drv->regs[RSC_DRV_CMD_RESP_DATA];
+			req->cmds[0].data = read_tcs_reg(drv, reg, i);
+		}
+
 		/*
 		 * If wake tcs was re-purposed for sending active
 		 * votes, clear AMC trigger & enable modes and
@@ -496,13 +502,14 @@ static void __tcs_buffer_write(struct rsc_drv *drv, int tcs_id, int cmd_id,
 			       const struct tcs_request *msg)
 {
 	u32 msgid;
-	u32 cmd_msgid = CMD_MSGID_LEN | CMD_MSGID_WRITE;
+	u32 cmd_msgid = CMD_MSGID_LEN;
 	u32 cmd_enable = 0;
 	struct tcs_cmd *cmd;
 	int i, j;
 
 	/* Convert all commands to RR when the request has wait_for_compl set */
 	cmd_msgid |= msg->wait_for_compl ? CMD_MSGID_RESP_REQ : 0;
+	cmd_msgid |= (!msg->is_read) ? CMD_MSGID_WRITE : 0;
 
 	for (i = 0, j = cmd_id; i < msg->num_cmds; i++, j++) {
 		cmd = &msg->cmds[i];
@@ -516,7 +523,8 @@ static void __tcs_buffer_write(struct rsc_drv *drv, int tcs_id, int cmd_id,
 
 		write_tcs_cmd(drv, drv->regs[RSC_DRV_CMD_MSGID], tcs_id, j, msgid);
 		write_tcs_cmd(drv, drv->regs[RSC_DRV_CMD_ADDR], tcs_id, j, cmd->addr);
-		write_tcs_cmd(drv, drv->regs[RSC_DRV_CMD_DATA], tcs_id, j, cmd->data);
+		if (!msg->is_read)
+			write_tcs_cmd(drv, drv->regs[RSC_DRV_CMD_DATA], tcs_id, j, cmd->data);
 		trace_rpmh_send_msg(drv, tcs_id, msg->state, j, msgid, cmd);
 	}
 
diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
index 8903ed956312d0a2ac7f673d86ef504947e9b119..c69f08fc76eea724f2c9933c7e25fbf671820764 100644
--- a/drivers/soc/qcom/rpmh.c
+++ b/drivers/soc/qcom/rpmh.c
@@ -175,6 +175,9 @@ static int __rpmh_write(const struct device *dev, enum rpmh_state state,
 	struct cache_req *req;
 	int i;
 
+	if (rpm_msg->msg.is_read)
+		goto send_data;
+
 	/* Cache the request in our store and link the payload */
 	for (i = 0; i < rpm_msg->msg.num_cmds; i++) {
 		req = cache_rpm_request(ctrlr, state, &rpm_msg->msg.cmds[i]);
@@ -182,6 +185,7 @@ static int __rpmh_write(const struct device *dev, enum rpmh_state state,
 			return PTR_ERR(req);
 	}
 
+send_data:
 	if (state == RPMH_ACTIVE_ONLY_STATE) {
 		ret = rpmh_rsc_send_data(ctrlr_to_drv(ctrlr), &rpm_msg->msg);
 	} else {
@@ -194,7 +198,7 @@ static int __rpmh_write(const struct device *dev, enum rpmh_state state,
 }
 
 static int __fill_rpmh_msg(struct rpmh_request *req, enum rpmh_state state,
-		const struct tcs_cmd *cmd, u32 n)
+		const struct tcs_cmd *cmd, u32 n, bool is_read)
 {
 	if (!cmd || !n || n > MAX_RPMH_PAYLOAD)
 		return -EINVAL;
@@ -204,10 +208,52 @@ static int __fill_rpmh_msg(struct rpmh_request *req, enum rpmh_state state,
 	req->msg.state = state;
 	req->msg.cmds = req->cmd;
 	req->msg.num_cmds = n;
+	req->msg.is_read = is_read;
 
 	return 0;
 }
 
+/**
+ * rpmh_read: Read a resource value
+ *
+ * @dev: The device making the request
+ * @state: Must be Active state
+ * @cmd: The payload having address of resource to read
+ * @n: The number of elements in @cmd, must be single command
+ *
+ * Reads the value for the resource address given in tcs_cmd->addr
+ * and returns the tcs_cmd->data filled with same.
+ *
+ * May sleep. Do not call from atomic contexts.
+ *
+ * Return:
+ * * 0			- Success
+ * * -Error             - Error code
+ */
+int rpmh_read(const struct device *dev, enum rpmh_state state, struct tcs_cmd *cmd, u32 n)
+{
+	int ret;
+	DECLARE_COMPLETION_ONSTACK(compl);
+	DEFINE_RPMH_MSG_ONSTACK(dev, state, &compl, rpm_msg);
+
+	if (n != 1 || state != RPMH_ACTIVE_ONLY_STATE)
+		return -EINVAL;
+
+	ret = __fill_rpmh_msg(&rpm_msg, state, cmd, n, true);
+	if (ret)
+		return ret;
+
+	ret = __rpmh_write(dev, state, &rpm_msg);
+	if (ret)
+		return ret;
+
+	ret = wait_for_completion_timeout(&compl, RPMH_TIMEOUT_MS);
+	cmd[0].data = rpm_msg.cmd[0].data;
+
+	return (ret > 0) ? 0 : -ETIMEDOUT;
+}
+EXPORT_SYMBOL_GPL(rpmh_read);
+
 /**
  * rpmh_write_async: Write a set of RPMH commands
  *
@@ -230,7 +276,7 @@ int rpmh_write_async(const struct device *dev, enum rpmh_state state,
 		return -ENOMEM;
 	rpm_msg->needs_free = true;
 
-	ret = __fill_rpmh_msg(rpm_msg, state, cmd, n);
+	ret = __fill_rpmh_msg(rpm_msg, state, cmd, n, false);
 	if (ret) {
 		kfree(rpm_msg);
 		return ret;
@@ -257,7 +303,7 @@ int rpmh_write(const struct device *dev, enum rpmh_state state,
 	DEFINE_RPMH_MSG_ONSTACK(dev, state, &compl, rpm_msg);
 	int ret;
 
-	ret = __fill_rpmh_msg(&rpm_msg, state, cmd, n);
+	ret = __fill_rpmh_msg(&rpm_msg, state, cmd, n, false);
 	if (ret)
 		return ret;
 
@@ -352,7 +398,7 @@ int rpmh_write_batch(const struct device *dev, enum rpmh_state state,
 	rpm_msgs = req->rpm_msgs;
 
 	for (i = 0; i < count; i++) {
-		__fill_rpmh_msg(rpm_msgs + i, state, cmd, n[i]);
+		__fill_rpmh_msg(rpm_msgs + i, state, cmd, n[i], false);
 		cmd += n[i];
 	}
 
diff --git a/include/soc/qcom/rpmh.h b/include/soc/qcom/rpmh.h
index bdbee1a97d3685d8a6153d586ddf650bd3bd3dde..03eea0bc798e6b66a4d47e9ae1bc408de696c059 100644
--- a/include/soc/qcom/rpmh.h
+++ b/include/soc/qcom/rpmh.h
@@ -11,6 +11,9 @@
 
 
 #if IS_ENABLED(CONFIG_QCOM_RPMH)
+int rpmh_read(const struct device *dev, enum rpmh_state state,
+	      struct tcs_cmd *cmd, u32 n);
+
 int rpmh_write(const struct device *dev, enum rpmh_state state,
 	       const struct tcs_cmd *cmd, u32 n);
 
@@ -24,6 +27,10 @@ void rpmh_invalidate(const struct device *dev);
 
 #else
 
+static inline int rpmh_read(const struct device *dev, enum rpmh_state state,
+			    struct tcs_cmd *cmd, u32 n)
+{ return -ENODEV; }
+
 static inline int rpmh_write(const struct device *dev, enum rpmh_state state,
 			     const struct tcs_cmd *cmd, u32 n)
 { return -ENODEV; }
diff --git a/include/soc/qcom/tcs.h b/include/soc/qcom/tcs.h
index cff67ce25488e2d3603a7707af2ca77f8266a713..45b8513be2f9bb0957796476f6031146ee34e931 100644
--- a/include/soc/qcom/tcs.h
+++ b/include/soc/qcom/tcs.h
@@ -51,6 +51,7 @@ struct tcs_cmd {
  * struct tcs_request: A set of tcs_cmds sent together in a TCS
  *
  * @state:          state for the request.
+ * @is_read:        set for read only requests
  * @wait_for_compl: wait until we get a response from the h/w accelerator
  *                  (same as setting cmd->wait for all commands in the request)
  * @num_cmds:       the number of @cmds in this request
@@ -58,6 +59,7 @@ struct tcs_cmd {
  */
 struct tcs_request {
 	enum rpmh_state state;
+	bool is_read;
 	u32 wait_for_compl;
 	u32 num_cmds;
 	struct tcs_cmd *cmds;

-- 
2.25.1


