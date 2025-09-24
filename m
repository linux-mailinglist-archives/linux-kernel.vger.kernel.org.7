Return-Path: <linux-kernel+bounces-831398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1974B9C8DC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7144F163F73
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9878B2C0289;
	Wed, 24 Sep 2025 23:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AvBPHbpg"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161ED29D26D
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758756399; cv=none; b=TYX0AvZsgur/6yKKL4uDHaXFXCmu652YR3g42DamVWu13m4yoPJYnVAJah7wH/ylTku0uuPJArRJ+vLbVEE4N/p5v2sF5XDMUQlTorNBE2LvZ3CtS88qJzMpX6Ax1GBkYRiCO18Tqte8LV7zHgyIVs5W9hVUFkFrx8Ee6mivC00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758756399; c=relaxed/simple;
	bh=KK69pnbAoNl5x144Z6VFHt42qN29ZBsdut7CQJHZRrs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=otaWOcUgBjg5+bfuWfPlpX/yxDncIYRlLUS1adQbewdP+tbM73MIu9pd376bhXO3TxWUxKHvBhi6AozWchuWajv+hLEk/ZYcIqRCsg28KDjSYjjcbdImVrASuB+SzaZDZJ+dOIhe0T2JpgExMskRsKdqjWDK5GABG5SavX1dkS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AvBPHbpg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OCTQMS017434
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:26:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=GYGy+4NKYRu
	cBFROr7rYVhlIyW1M+CzZsu0iJLkrIuE=; b=AvBPHbpgGphAVrGGZUK/MJP9vqS
	SrZSJcrmTVfWtBT98muad+oIgnxKNSjWd9XVms5paPJOdPWitc+93RdizMGyViFl
	enJ1vfR5tbB9W+oV3zbB1vKXM5MB4lmVcwHuAiXgwobgryiaUp4TKz7YJCo4/rbJ
	EdywNnQADtT9DId+fihOlj0t8/4uW9AywtrxknT/vsth588nKPzt0L/tpOqOMQzc
	zvh853nSLVORqhJgvCgzzN2AJoPW5TAKQbDr9/9gZAOw3YH+406rrxqFAaLPyIm0
	cb130naS/dJCafewk3tc6cIC2Pl8q4COQD0NhfkJHmKQ2M9QvgsSUJNsSiA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bhvjyc15-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:26:37 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2699ebc0319so3084385ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:26:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758756396; x=1759361196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GYGy+4NKYRucBFROr7rYVhlIyW1M+CzZsu0iJLkrIuE=;
        b=u+W2ZNZs+ouI01bhq+Tpk38sS+5wv5pxM68DApwp2kHyGuboM9JzXZAecbLZnGLs9J
         w/L6IkU9kp/9NpY4Oo97pjZXEjMDjyHk4Uy1EjLsAnF0NnLx+4OToMKuK77ZWOuou1sy
         3X4VgDZQ04PdOu4auKrQj8I7hXXBfgx3R0upl56Bcr5sQJBAv+YLQdynIJy3+6n6dTeA
         9prW1kaue2EG1SGFMyn/QWJJ7HrfI8Q7rw8kIbUbDRqq/kIrWBhC/8ZiRBEiZx1jc/N5
         XyXqaDc2GBCayLEldVc8INLPQTQBuiSa4Q5Yvrhbssj+5CwrRjUfNIIOPfScj9nRb+y4
         irhw==
X-Forwarded-Encrypted: i=1; AJvYcCVOpZpwo16viibpHzHRLe44qYustIP89WZoJGvTvOf/wdS0A5yXCyczIi8nK7cAgYv4ZhN5v94FXosbTf8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg8o25YCkQLhq/ICa2+5D4e5yaKwMDoUhIYjAYHFYn7E5W3BpN
	6PqrzVwRe7IdKfYREqfh6y3wBA8KPjnaYvnPDZoMYcM3Vw7OMLWP9rkT4/sam7fedHLAUXiTYqX
	3mOeLV6w3gjy2LUpxC7GA94X0atVFb1DHcH5WKMG4pk5olg0llbCXc7mQmZuxoWenhfU=
X-Gm-Gg: ASbGnctcEpo/KBZxKP4WI2pSctzJ5KvXNp8N+/ckP4DrSzjF8FeuR0b0zhWUHQXrLrm
	jcpES/HSKOIuwObdifnxDj8MIim6sm8pG/NtbwmM2q3QRwDFNTJ2OoB2eq7SD0OcxzA5kYCsvTT
	ktAMzHqjUXyiB0VfT4Z//fV+75KHb5iNp55bHi//r6Bk1NhyDOUoab1WexZv3J4nS5FWwrkKiJL
	0WUTp+wxNanzfLjNcB4LZTte4hY8cljnN22CFl4VHRjV9lOOiwsN4d/tpsUpSihnKqhL0v4gAFs
	g8uau/JMvmC+H39bUitV96qzC8PgIQO2sVwKD66zQpgryFGhHWSWddUwKD2oWHnN58jZkVBMNl/
	gbpedWXITCjv789qz9Qon4rvRAmU=
X-Received: by 2002:a17:903:41cb:b0:267:ba53:8bd3 with SMTP id d9443c01a7336-27ed4a7f36fmr15578925ad.28.1758756396294;
        Wed, 24 Sep 2025 16:26:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKn09t+UKPyA6h0HbQGalUfPWYpaUodXo/WnK1LPlyaXBPEVy2q7a1JeG82EUURTm4VlE8bQ==
X-Received: by 2002:a17:903:41cb:b0:267:ba53:8bd3 with SMTP id d9443c01a7336-27ed4a7f36fmr15578685ad.28.1758756395854;
        Wed, 24 Sep 2025 16:26:35 -0700 (PDT)
Received: from hu-amelende-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed68821ebsm4005735ad.84.2025.09.24.16.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 16:26:35 -0700 (PDT)
From: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
To: heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org
Cc: lumag@kernel.org, neil.armstrong@linaro.org, johan+linaro@kernel.org,
        quic_bjorande@quicinc.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v4 2/2] usb: typec: ucsi_glink: Increase buffer size to support UCSI v2
Date: Wed, 24 Sep 2025 16:26:31 -0700
Message-Id: <20250924232631.644234-3-anjelique.melendez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250924232631.644234-1-anjelique.melendez@oss.qualcomm.com>
References: <20250924232631.644234-1-anjelique.melendez@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: jzX7WMB87oIpcN33T-OTBDQoWPFDdaev
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDAxMSBTYWx0ZWRfXxge6FsXBii2k
 Jy82/U1OEeNb85iugBExzJK2SuSDcPq967snKmlTNpdjKVQ5ez2f5+RgURlQ0/5ciCCDLJGI3vz
 VrKlPp7bJ1vkvXAOYj2h7nyyTogCeHHRg31iOBUshkNYq6sO1NgbNGildOpOw2fDKMyhAk2V+sg
 xp8CmsoP8bCIwHL1fN9HsuCFAhAgCIsEDlqUpGcz4zfdMPvXDcOMQR2AOA1X5/6kKizffeU13uL
 qBkugArWvR7no59LYzHH1PPJ06Pm+W8cz37WP1uiczAa8jUfL011duMUdT78mZX/2hoB+sNXb6x
 aFHNqpwvLafEBKgPZJ8Fv/TseMb5ZH4psOMrRa8pJTnOXISoh81slSBxpdr+9z1boQOxZbzSttn
 5jB6O0MY
X-Proofpoint-GUID: jzX7WMB87oIpcN33T-OTBDQoWPFDdaev
X-Authority-Analysis: v=2.4 cv=Csq/cm4D c=1 sm=1 tr=0 ts=68d47e2d cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=pUSBQGTQOVeKylh7KsIA:9
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 adultscore=0 impostorscore=0 phishscore=0
 clxscore=1011 spamscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509230011

UCSI v2 specification has increased the MSG_IN and MSG_OUT size from
16 bytes to 256 bytes each for the message exchange between OPM and PPM
This makes the total buffer size increase from 48 bytes to 528 bytes.
Update the buffer size to support this increase.

Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
---
 drivers/usb/typec/ucsi/ucsi_glink.c | 81 ++++++++++++++++++++++++-----
 1 file changed, 68 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
index 1f9f0d942c1a..7f19b4d23fed 100644
--- a/drivers/usb/typec/ucsi/ucsi_glink.c
+++ b/drivers/usb/typec/ucsi/ucsi_glink.c
@@ -16,10 +16,10 @@
 
 #define PMIC_GLINK_MAX_PORTS		3
 
-#define UCSI_BUF_SIZE                   48
+#define UCSI_BUF_V1_SIZE		(UCSI_MESSAGE_OUT + (UCSI_MESSAGE_OUT - UCSI_MESSAGE_IN))
+#define UCSI_BUF_V2_SIZE		(UCSIv2_MESSAGE_OUT + (UCSIv2_MESSAGE_OUT - UCSI_MESSAGE_IN))
 
 #define MSG_TYPE_REQ_RESP               1
-#define UCSI_BUF_SIZE                   48
 
 #define UC_NOTIFY_RECEIVER_UCSI         0x0
 #define UC_UCSI_READ_BUF_REQ            0x11
@@ -30,15 +30,27 @@ struct ucsi_read_buf_req_msg {
 	struct pmic_glink_hdr   hdr;
 };
 
-struct __packed ucsi_read_buf_resp_msg {
+struct __packed ucsi_v1_read_buf_resp_msg {
 	struct pmic_glink_hdr   hdr;
-	u8                      buf[UCSI_BUF_SIZE];
+	u8                      buf[UCSI_BUF_V1_SIZE];
 	u32                     ret_code;
 };
 
-struct __packed ucsi_write_buf_req_msg {
+struct __packed ucsi_v2_read_buf_resp_msg {
 	struct pmic_glink_hdr   hdr;
-	u8                      buf[UCSI_BUF_SIZE];
+	u8                      buf[UCSI_BUF_V2_SIZE];
+	u32                     ret_code;
+};
+
+struct __packed ucsi_v1_write_buf_req_msg {
+	struct pmic_glink_hdr   hdr;
+	u8                      buf[UCSI_BUF_V1_SIZE];
+	u32                     reserved;
+};
+
+struct __packed ucsi_v2_write_buf_req_msg {
+	struct pmic_glink_hdr   hdr;
+	u8                      buf[UCSI_BUF_V2_SIZE];
 	u32                     reserved;
 };
 
@@ -72,7 +84,7 @@ struct pmic_glink_ucsi {
 	bool ucsi_registered;
 	bool pd_running;
 
-	u8 read_buf[UCSI_BUF_SIZE];
+	u8 read_buf[UCSI_BUF_V2_SIZE];
 };
 
 static int pmic_glink_ucsi_read(struct ucsi *__ucsi, unsigned int offset,
@@ -131,18 +143,34 @@ static int pmic_glink_ucsi_read_message_in(struct ucsi *ucsi, void *val, size_t
 static int pmic_glink_ucsi_locked_write(struct pmic_glink_ucsi *ucsi, unsigned int offset,
 					const void *val, size_t val_len)
 {
-	struct ucsi_write_buf_req_msg req = {};
-	unsigned long left;
+	struct ucsi_v2_write_buf_req_msg req = {};
+	unsigned long left, max_buf_len;
+	size_t req_len;
 	int ret;
 
+	memset(&req, 0, sizeof(req));
 	req.hdr.owner = PMIC_GLINK_OWNER_USBC;
 	req.hdr.type = MSG_TYPE_REQ_RESP;
 	req.hdr.opcode = UC_UCSI_WRITE_BUF_REQ;
+
+	if (ucsi->ucsi->version >= UCSI_VERSION_2_0) {
+		req_len = sizeof(struct ucsi_v2_write_buf_req_msg);
+		max_buf_len = UCSI_BUF_V2_SIZE;
+	} else if (ucsi->ucsi->version) {
+		req_len = sizeof(struct ucsi_v1_write_buf_req_msg);
+		max_buf_len = UCSI_BUF_V1_SIZE;
+	} else {
+		return -EINVAL;
+	}
+
+	if (offset + val_len > max_buf_len)
+		return -EINVAL;
+
 	memcpy(&req.buf[offset], val, val_len);
 
 	reinit_completion(&ucsi->write_ack);
 
-	ret = pmic_glink_send(ucsi->client, &req, sizeof(req));
+	ret = pmic_glink_send(ucsi->client, &req, req_len);
 	if (ret < 0) {
 		dev_err(ucsi->dev, "failed to send UCSI write request: %d\n", ret);
 		return ret;
@@ -216,12 +244,39 @@ static const struct ucsi_operations pmic_glink_ucsi_ops = {
 
 static void pmic_glink_ucsi_read_ack(struct pmic_glink_ucsi *ucsi, const void *data, int len)
 {
-	const struct ucsi_read_buf_resp_msg *resp = data;
+	u8 *buf = ((struct ucsi_v2_read_buf_resp_msg *)data)->buf;
+	u32 ret_code, max_len;
+	u32 buf_len = 0;
+
+	if (ucsi->ucsi->version) {
+		if (ucsi->ucsi->version >= UCSI_VERSION_2_0)
+			buf_len = UCSI_BUF_V2_SIZE;
+		else
+			buf_len = UCSI_BUF_V1_SIZE;
+	} else if (!ucsi->ucsi_registered) {
+		/*
+		 * If UCSI version is not known yet because device is not registered,
+		 * choose buffer size which best fits incoming data
+		 */
+		if (len > sizeof(struct pmic_glink_hdr) + UCSI_BUF_V2_SIZE)
+			buf_len = UCSI_BUF_V2_SIZE;
+		else
+			buf_len = UCSI_BUF_V1_SIZE;
+	}
 
-	if (resp->ret_code)
+	max_len = sizeof(struct pmic_glink_hdr) + buf_len + sizeof(u32);
+
+	if (len > max_len)
+		return;
+
+	if (buf_len > len - sizeof(struct pmic_glink_hdr) - sizeof(u32))
+		buf_len = len - sizeof(struct pmic_glink_hdr) - sizeof(u32);
+
+	memcpy(&ret_code, buf + buf_len, sizeof(u32));
+	if (ret_code)
 		return;
 
-	memcpy(ucsi->read_buf, resp->buf, UCSI_BUF_SIZE);
+	memcpy(ucsi->read_buf, buf, buf_len);
 	complete(&ucsi->read_ack);
 }
 
-- 
2.34.1


