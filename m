Return-Path: <linux-kernel+bounces-863713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7B0BF8E7B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 23:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 12A07502B21
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 21:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2922877FA;
	Tue, 21 Oct 2025 21:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LYnoTcHt"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71719286897
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 21:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761080951; cv=none; b=TH2RP/+piTcf5n+Bm0dkSF04INVgSOSbDRptmkBy3cdDqt7a8i1Y7ZE7+tvudPbLLgEhBYdZz7hpyrkfQPHSV8skUoEgBhNT27AaazDhRa12K0GtOqQI2yz0zDOGrLbYFqVnR4pdDb9tylZ5b7HkxFklclaifyDB+xuDUO9tYSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761080951; c=relaxed/simple;
	bh=IYnlj7LXZPv8KblJK4JOxfWz5iX9/ovyWWmCoKyeldE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F6khag7wLAjdVFu6L0iijUKfqKoH4yWQiOZoH73qFsibWsC/IVDYXnuCDqqeEZQXI+J91Mrcgme6FAP7EFeWvZhYBOJe6eSkhnEGR3n4vUf65Q6qR8qbU9UfLmjHmhT2J9F/wa9qWytPOUU0+AbzhPQv4/aIUBv+PRt1RxJT34I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LYnoTcHt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59LE6ngk024879
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 21:09:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	S1lDbfpkOot17HD81aaVZVl8RbtCiVtkKz86iz+Hgk0=; b=LYnoTcHtNXEy/6Ia
	yRMhxOJ1Od5NJafinq13VxKJRnrzTrsR8WlU6UxfALwla63fSD4Pq/jotJLUh1KC
	aMPaV01Ksa7lNOGq31+r6ZsUKtVMS0dLTsVFtiy4bQWt+QSIa5BcjBlwNcpXdIi5
	mD94fLLp33G3/fP4DTcMvJlQukYy1WNtb93rObY508A4cYUHYt3SBdqJG/CbLqTK
	ZDvzkigCZiV8oI/cAQa/zwBpsGEiReOMbwi/r5Up5RXqsineMmdfGIlgmjfMXbtC
	LE7H8LI1Kcb1Xk3KfiqqsQ/h368Hdtty53Mxq46p1yi8AjUMM/BFLy8VPcp9JP78
	tlJMYA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49wsws4me4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 21:09:08 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b522037281bso3852400a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 14:09:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761080947; x=1761685747;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S1lDbfpkOot17HD81aaVZVl8RbtCiVtkKz86iz+Hgk0=;
        b=XQfnXZjrlXMEsLy+Ve5ToUpi4H6UDrcITaWxkt86qznXRTMSgYxE98OpYFIbbbsAY+
         cp53orOfg+vzePMRuttTjj8zBwbSCvkG0zUNu1KUc7u8maS9iN3WyNhLirGpEFFBUG/W
         e5rH16v7js71jZw1KosCS8KA5kDrT3heI44sTpGnNUKFJ1VUtpL2oD4VKV+IjThGYUid
         OIp0c1ojPiZN06lzSVAriu+5MqHulluS3b5nLAFxuCBQmECD0P6ttddvcf5F2MVjZZjE
         JwGpo0CjIX9qR0xOSCIk/pKda7ZVnPYAuumPWHgCzTPSc8n8WpqZikGV9kiAlQ4prHdJ
         wqrg==
X-Forwarded-Encrypted: i=1; AJvYcCUgy2uM1GiVF1/BbVYSvzDKrDUVLKHQV+3Iubpmj0jxa4M714levwlVqVipLD/UhdbdPGogZB4CRAtdt7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzru3HuoAPFPugJN7j66l1LefkDw1AYGj3b/BvHqMS7wDNNHTQ+
	H+KgmO8lte1SDXFTbPEuPyDm7NGjOiSw6FoOdETs/ZW/qRIoPP+7G/lGzkd1UBYOZDdP47OLI1z
	tf/bThTSGQmr6eSj6IJRh2rdvkn2foGVGrUKaW5rShvLfIPkt/gAPfsv8GVDFNf88mKY=
X-Gm-Gg: ASbGncvvDWjJYofFmx2JT+88VfHHCL6Yb2iYbe4EFVvLAJp40N3kruUP8tI+eBbjt6A
	PUf0n+aPDYMUar/AeMwUqRNWUJ2ejzPES2x9gruc336f5zqg1R08DTzbKI2jfa9xZQCfLbic740
	AZZtz6TsR2of+l1y3FFbv+rYaZpzxWBFEUtXHxv8AaOp0qhCYOpA9qCPIiC7qhQu0ykp9ZUi+/Z
	qvO+q5d0gafdoVn0jLd9sSIvNvF3qYiaimhIptkpiWbh8NgyLLSpShCNSMW41xN9PDJm6wZGe4T
	RhhRO4pNC+cEkaedK0Cpwqc6cU99o5ME2s7kvsqHiC1GoMW0WjKdsUvumEuwB/twQalsxr9UVFa
	1Oxk/p1MyfenM/QUBbUSaKzOaTLNj4gIKa+I+NzEjdT9WSdtI+D6Xm96uGUjv
X-Received: by 2002:a05:6a20:3d8a:b0:2e2:3e68:6e36 with SMTP id adf61e73a8af0-334a8629dddmr22481514637.49.1761080946766;
        Tue, 21 Oct 2025 14:09:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErhKmV81lNDF55ykcnebLwzRGAZfvjjqqKGHwmxPLIO3pK2VJXRkVNw/oKzvWOeGTrNOwEKw==
X-Received: by 2002:a05:6a20:3d8a:b0:2e2:3e68:6e36 with SMTP id adf61e73a8af0-334a8629dddmr22481487637.49.1761080946280;
        Tue, 21 Oct 2025 14:09:06 -0700 (PDT)
Received: from hu-kamalw-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e223c813fsm489833a91.4.2025.10.21.14.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 14:09:05 -0700 (PDT)
From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Date: Wed, 22 Oct 2025 02:38:54 +0530
Subject: [PATCH v2 2/4] soc: qcom: rpmh: Add support to read back resource
 settings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-add-rpmh-read-support-v2-2-5c7a8e4df601@oss.qualcomm.com>
References: <20251022-add-rpmh-read-support-v2-0-5c7a8e4df601@oss.qualcomm.com>
In-Reply-To: <20251022-add-rpmh-read-support-v2-0-5c7a8e4df601@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        Maulik Shah <maulik.shah@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761080935; l=7721;
 i=kamal.wadhwa@oss.qualcomm.com; s=20241018; h=from:subject:message-id;
 bh=rpH2m6fV0PIyAMPCvD1xeto6cV05dSIbBAqJhS+qp84=;
 b=DGNvQk9aVlAr9xMHQNGu/q0p4bej7Qo2jzf2NiwIrRISE7Ud1p+GM6KVguwCUa/aO4cYGuF9Q
 g+vVuaMRZxcCJJqe4dqSUMiTbScLiNGNkc48Xdzsnbm5PeQIMZSESIP
X-Developer-Key: i=kamal.wadhwa@oss.qualcomm.com; a=ed25519;
 pk=XbPE6DM5/mJi2tsiYwMCJCZ4O5XPMqColJRlGVcM7Hs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIwMDE0OCBTYWx0ZWRfXwXPcaA3sFQB3
 dI0xd90aBVkoN2rCD6cA8oMb4ScN+On191nkzsLct5dDwViH//T32MAsm1W67T9ijRbTGjMqoaF
 e3avpMwctDFRDKtIGW5hBvTMx6u11R0OCFGFek45k07xMlRGJa9hXjMkWQwaBPbTn0OxSNc/oIZ
 FMZ/IyuKol5Z868aXVETt12m/3sBZCCf8Vr7SHbmu3OBTMARD6jz9e+k2ssKIpK7DgsKcFzu5NF
 9WhI1Xg4EniXR5xT96zocfqGohBrcjXqxUbw94POv63xQDd/zViCl7Y0mTMIMoIWWY8+d5SVjec
 bwUC5qzHd4z2ZF87aPCh/5wQwbweYsx7FTGJ+HRdTksaM3B9YNSyHkNoFqWFoFPxbxIZMgtlC8p
 LVTb7ftbrOCVFiC+48UUe1mSdgIAAg==
X-Proofpoint-GUID: GGYUCWWB7VT_AZSIiPAvDE73dM2QYjeE
X-Proofpoint-ORIG-GUID: GGYUCWWB7VT_AZSIiPAvDE73dM2QYjeE
X-Authority-Analysis: v=2.4 cv=a+E9NESF c=1 sm=1 tr=0 ts=68f7f674 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=RgaPuue0vXMEEcOqpiYA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-21_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510200148

From: Maulik Shah <maulik.shah@oss.qualcomm.com>

All rpmh_*() APIs so far have supported placing votes for various
resource settings but the H/W also have option to read resource
settings.

This change adds a new rpmh_read() API to allow clients
to read back resource setting from H/W. This will be useful for
clients like regulators, which currently don't have a way to know
the settings applied during bootloader stage.

Link: https://lore.kernel.org/r/20250623-add-rpmh-read-support-v1-1-ae583d260195@oss.qualcomm.com
Signed-off-by: Maulik Shah <maulik.shah@oss.qualcomm.com>
Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
---
 drivers/soc/qcom/rpmh-rsc.c | 13 +++++++++++--
 drivers/soc/qcom/rpmh.c     | 47 +++++++++++++++++++++++++++++++++++++++++----
 include/soc/qcom/rpmh.h     |  5 +++++
 include/soc/qcom/tcs.h      |  2 ++
 4 files changed, 61 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index c6f7d5c9c493d9e06c048930b8a14a38660df4b1..ec85c457ea4527f94339c2033bfcc12346e3c443 100644
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
 		/* Clear AMC trigger & enable modes and
 		 * disable interrupt for this TCS
 		 */
@@ -493,13 +499,15 @@ static void __tcs_buffer_write(struct rsc_drv *drv, int tcs_id, int cmd_id,
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
+	if (!msg->is_read)
+		cmd_msgid |= CMD_MSGID_WRITE;
 
 	for (i = 0, j = cmd_id; i < msg->num_cmds; i++, j++) {
 		cmd = &msg->cmds[i];
@@ -513,7 +521,8 @@ static void __tcs_buffer_write(struct rsc_drv *drv, int tcs_id, int cmd_id,
 
 		write_tcs_cmd(drv, drv->regs[RSC_DRV_CMD_MSGID], tcs_id, j, msgid);
 		write_tcs_cmd(drv, drv->regs[RSC_DRV_CMD_ADDR], tcs_id, j, cmd->addr);
-		write_tcs_cmd(drv, drv->regs[RSC_DRV_CMD_DATA], tcs_id, j, cmd->data);
+		if (!msg->is_read)
+			write_tcs_cmd(drv, drv->regs[RSC_DRV_CMD_DATA], tcs_id, j, cmd->data);
 		trace_rpmh_send_msg(drv, tcs_id, msg->state, j, msgid, cmd);
 	}
 
diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
index 8903ed956312d0a2ac7f673d86ef504947e9b119..4a611dac437ef28bac124583073c87a79e9e5cad 100644
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
@@ -204,10 +208,45 @@ static int __fill_rpmh_msg(struct rpmh_request *req, enum rpmh_state state,
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
+ * @cmd: The payload having address of resource to read
+ *
+ * Reads the value for the resource address given in tcs_cmd->addr
+ * and returns the tcs_cmd->data filled with same.
+ *
+ * May sleep. Do not call from atomic contexts.
+ *
+ * Return: 0 on success, negative errno on failure
+ */
+int rpmh_read(const struct device *dev, struct tcs_cmd *cmd)
+{
+	DECLARE_COMPLETION_ONSTACK(compl);
+	DEFINE_RPMH_MSG_ONSTACK(dev, RPMH_ACTIVE_ONLY_STATE, &compl, rpm_msg);
+	int ret;
+
+	ret = __fill_rpmh_msg(&rpm_msg, RPMH_ACTIVE_ONLY_STATE, cmd, 1, true);
+	if (ret)
+		return ret;
+
+	ret = __rpmh_write(dev, RPMH_ACTIVE_ONLY_STATE, &rpm_msg);
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
@@ -230,7 +269,7 @@ int rpmh_write_async(const struct device *dev, enum rpmh_state state,
 		return -ENOMEM;
 	rpm_msg->needs_free = true;
 
-	ret = __fill_rpmh_msg(rpm_msg, state, cmd, n);
+	ret = __fill_rpmh_msg(rpm_msg, state, cmd, n, false);
 	if (ret) {
 		kfree(rpm_msg);
 		return ret;
@@ -257,7 +296,7 @@ int rpmh_write(const struct device *dev, enum rpmh_state state,
 	DEFINE_RPMH_MSG_ONSTACK(dev, state, &compl, rpm_msg);
 	int ret;
 
-	ret = __fill_rpmh_msg(&rpm_msg, state, cmd, n);
+	ret = __fill_rpmh_msg(&rpm_msg, state, cmd, n, false);
 	if (ret)
 		return ret;
 
@@ -352,7 +391,7 @@ int rpmh_write_batch(const struct device *dev, enum rpmh_state state,
 	rpm_msgs = req->rpm_msgs;
 
 	for (i = 0; i < count; i++) {
-		__fill_rpmh_msg(rpm_msgs + i, state, cmd, n[i]);
+		__fill_rpmh_msg(rpm_msgs + i, state, cmd, n[i], false);
 		cmd += n[i];
 	}
 
diff --git a/include/soc/qcom/rpmh.h b/include/soc/qcom/rpmh.h
index bdbee1a97d3685d8a6153d586ddf650bd3bd3dde..14ecbf242b6bd67c8167c176ed0970f42432f4f4 100644
--- a/include/soc/qcom/rpmh.h
+++ b/include/soc/qcom/rpmh.h
@@ -11,6 +11,8 @@
 
 
 #if IS_ENABLED(CONFIG_QCOM_RPMH)
+int rpmh_read(const struct device *dev, struct tcs_cmd *cmd);
+
 int rpmh_write(const struct device *dev, enum rpmh_state state,
 	       const struct tcs_cmd *cmd, u32 n);
 
@@ -24,6 +26,9 @@ void rpmh_invalidate(const struct device *dev);
 
 #else
 
+static inline int rpmh_read(const struct device *dev, struct tcs_cmd *cmd)
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


