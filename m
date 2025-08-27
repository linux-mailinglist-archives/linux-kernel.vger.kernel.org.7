Return-Path: <linux-kernel+bounces-788823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4EDB38ABB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 22:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 133177C4D57
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 20:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638F72F068E;
	Wed, 27 Aug 2025 20:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LTG0SrGG"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072B02F067F
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 20:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756325570; cv=none; b=am+Ygt2fvmjOTlSa7VLOlBUpoAHUkBubyrXFHXfHxEzsJUMtPN/2uGU6h/oeBiHaJS4+00gRMi5JcXjnW6jyt/rNxY/pNo3xDOwIw+Fm/4DPKwhPtgUZf/SYInmTq5wlgu/+R0FG7AwuBpS1zAWQWt5eB97cgjknuDusqdz+78w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756325570; c=relaxed/simple;
	bh=MpyJSyCj2xWmtO5J2dSyFdFgZvc2VOqXTVnMmGLSs2Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tuQA9/d5Zhgx7x09FL4h0BG1LeE6q1sDcBCIv7LyVAiZqmLMqHznoF8DxYOaUEhEAQjTK1JzQpNTi3q+lmctYPpS+c97iGdG3O77y6xnwZAYtGobs8JViOdjqDUQXxKw0wq2XzDA6b7+jlJDBXeoaPdnQd9GgnZLCIcTb0CD9Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LTG0SrGG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57RGf6A3031265
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 20:12:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=+hiFh6kSS4u
	nir4HcxHNHp4T4OOazJBEpiZOWRLYe38=; b=LTG0SrGGbIx021JG/C6xPuJ0G/w
	5uZtkYFkHdnq+6D81Hy716kfooSw2M8SZJK8lsQwWpVkGPBn1meglXJ8HvdcabIR
	rr5M+iZjjVxf5xCbM8YTbe3k7O+3E9BUIxJkJf9V6SOo/N8hgxoKOLSr7+C8KKXA
	+X178pSYUbxbv76Qr1JvU1aTpUAr+sly+J8gsC3Do9I45+lDXX9ctutQ6cKeG1Xj
	XiayCg6I8m/MLS3U8Hk4A0L+s8bABAM5aEpd81rf9NG9MEvl1BigqHlAjwNVqBCl
	8FRKiZmq1YgcHNlMXU/fALtmU0FPvdiT/zxTXT4MVsrTlKnbzGwLHJcWe+A==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q615nrq1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 20:12:47 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7720ac7c788so188555b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 13:12:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756325567; x=1756930367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+hiFh6kSS4unir4HcxHNHp4T4OOazJBEpiZOWRLYe38=;
        b=vyT47xrf4sMPI5c+UQdXLcoYPKAucjPvprFTE8GbsblawKkqstdyIY9Aip/5PoCSeD
         LGOlNxybxyHrvxTnArf5BnSjHQEQtzHm1WSrXi4o5+IQ1Tg6J91dUoCJKTDGS6+xrhYJ
         m2b4FnMYjB/z9ZMpW+6aJ6Ak83oZVYhmjAYbHJgLnqoI/NnGGqMF8eRhBrojyKFnjeba
         ulT8eSNYlnYl6W6ZLkRJQTM/a+H3IoUkpTBA6o1jGck310do94q7Sg311CrdJ4W5ETex
         DvMAvcMKW8VafX6qjIz19lvUHfrnVj91UrfKXLjZLDK8bU/kigoij1womhJrzxDlvbuP
         1cOg==
X-Forwarded-Encrypted: i=1; AJvYcCXnxgAQL2jYFR79+5Ff+g/NjhnC93CJAC7Axi5FKxR9AVDLpXKjoIjNZcOSnpHw10pzipKBQdh3dYMeI40=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNdydXsSow+kWPipCMgwK7UkJ5ZmXOu//2N2zj+FQ/jMcWp7Si
	x8Uziq3N59HWOCh70exHzoPyUwRSZMoNQi0AvfQhUOtZpzkFrwa+i8UfhY2+K7CnStoXAuYGPhw
	rSDDU5G/rtkmOQlKKdkJ57t4lf1Hx0P5XCPxLi0S6cDkV84vmVHg0zYGnDR8eUtyyFt4=
X-Gm-Gg: ASbGncuPgZobzmbHoefho1pyRx5NSiMZuzZdb5XlrO+DX+cJC6AZxl1mUCWrBk7mGaU
	kiBnHRm7Td1fs39MBAhqcLUXlGJnJ0eJtoZFHA+WlJAXWYREtCXu5LT4ZquPJLlWfCbIa3bQlEL
	OddllatX8XQESbpjrBDIOp+TbCPVcCxT/dMNxSGV55X5NLrJK/GgxgGZSUZ+RevzQFTn23QXaL/
	H34WblO/qROfaJBHpcIjmJDHhr6MeQrghpU2Mtgx26Fomh83zaLZjtWmT9Fc+dblSKxRinhVoGV
	Ylkn2kw4s+xU5Fp+oKHlSmNsA8dqY+4BZC1vTmlTa+Zrnxw1p7eIq3NL30J065acMoJ7OwaDLrI
	9KG9iozaPp8zdE7ON7A/Um1oUz60=
X-Received: by 2002:a05:6a20:549d:b0:240:1d13:ccc3 with SMTP id adf61e73a8af0-24340b04b66mr28622416637.4.1756325566630;
        Wed, 27 Aug 2025 13:12:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuabulry35Oh45R7S+Y/EAACvQFqi8OkZbW04d7jR07ab1s2Trdgdysl7HE23tj34ZDiibaA==
X-Received: by 2002:a05:6a20:549d:b0:240:1d13:ccc3 with SMTP id adf61e73a8af0-24340b04b66mr28622386637.4.1756325566115;
        Wed, 27 Aug 2025 13:12:46 -0700 (PDT)
Received: from hu-amelende-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cbbbaffdsm12185234a12.51.2025.08.27.13.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 13:12:45 -0700 (PDT)
From: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
To: heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org
Cc: lumag@kernel.org, neil.armstrong@linaro.org, johan+linaro@kernel.org,
        quic_bjorande@quicinc.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v3 2/2] usb: typec: ucsi_glink: Increase buffer size to support UCSI v2
Date: Wed, 27 Aug 2025 13:12:41 -0700
Message-Id: <20250827201241.3111857-3-anjelique.melendez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250827201241.3111857-1-anjelique.melendez@oss.qualcomm.com>
References: <20250827201241.3111857-1-anjelique.melendez@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzNCBTYWx0ZWRfX5icp2ix6h6tF
 Y4imHaDEyqJ1IvOhoZf6eZS1W8wMobmv4yzw9rO8wZEDmelB32t2uxrK58jSDFX1oqczSi2tpF2
 iOqKB83CW1E6r+ZICYOUSx+zKA8o3QNmeUBzyKvtvWArC4ucmK5CiB0ZTOKk5bSODsAY/jvnMz1
 Sg5v1jnAnMjZ+1HXgV61ISaHVenbBjsbb8nyzEBmCVvrOpd/iIV67LfgbYlofFEMFSMJTA/hAy1
 upgnT3ddv4Eff6pST05zPHHWisBSwvcnjGJf2F1bT0tRfoV9Ps0SYK4fYo33LYvbJb0XCCJWM8j
 4VdnH4Hp5TlVrk6m8GSvV/oadk6srs8WgzaeRtQKR3H1fzRuAkZo9trw57G9eSXylUdhpm0Pn5C
 cqA0gevD
X-Proofpoint-GUID: dBv9LZIKIDSnd50uQa9vJx5-tCnahpXA
X-Authority-Analysis: v=2.4 cv=K+AiHzWI c=1 sm=1 tr=0 ts=68af66bf cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=vumWCRg_uR-EWTXYnocA:9
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: dBv9LZIKIDSnd50uQa9vJx5-tCnahpXA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_04,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230034

UCSI v2 specification has increased the MSG_IN and MSG_OUT size from
16 bytes to 256 bytes each for the message exchange between OPM and PPM
This makes the total buffer size increase from 48 bytes to 528 bytes.
Update the buffer size to support this increase.

Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
---
 drivers/usb/typec/ucsi/ucsi_glink.c | 85 +++++++++++++++++++++++++----
 1 file changed, 75 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
index 1f9f0d942c1a..fc12569ec520 100644
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
@@ -32,13 +32,25 @@ struct ucsi_read_buf_req_msg {
 
 struct __packed ucsi_read_buf_resp_msg {
 	struct pmic_glink_hdr   hdr;
-	u8                      buf[UCSI_BUF_SIZE];
+	u8                      buf[UCSI_BUF_V1_SIZE];
+	u32                     ret_code;
+};
+
+struct __packed ucsi_v2_read_buf_resp_msg {
+	struct pmic_glink_hdr   hdr;
+	u8                      buf[UCSI_BUF_V2_SIZE];
 	u32                     ret_code;
 };
 
 struct __packed ucsi_write_buf_req_msg {
 	struct pmic_glink_hdr   hdr;
-	u8                      buf[UCSI_BUF_SIZE];
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
+	struct ucsi_v2_write_buf_req_msg req = {};
+	size_t len, max_buf_len;
 	unsigned long left;
 	int ret;
 
 	req.hdr.owner = PMIC_GLINK_OWNER_USBC;
 	req.hdr.type = MSG_TYPE_REQ_RESP;
 	req.hdr.opcode = UC_UCSI_WRITE_BUF_REQ;
+
+	if (ucsi->ucsi->version >= UCSI_VERSION_2_0) {
+		max_buf_len = UCSI_BUF_V2_SIZE;
+		len = sizeof(req);
+	} else if (ucsi->ucsi->version) {
+		max_buf_len = UCSI_BUF_V1_SIZE;
+		len = sizeof(struct ucsi_write_buf_req_msg);
+	} else {
+		dev_err(ucsi->dev, "UCSI version not set\n");
+		return -EINVAL;
+	}
+
+	if (offset + val_len > max_buf_len)
+		return -EINVAL;
+
 	memcpy(&req.buf[offset], val, val_len);
 
 	reinit_completion(&ucsi->write_ack);
 
-	ret = pmic_glink_send(ucsi->client, &req, sizeof(req));
+	ret = pmic_glink_send(ucsi->client, &req, len);
 	if (ret < 0) {
 		dev_err(ucsi->dev, "failed to send UCSI write request: %d\n", ret);
 		return ret;
@@ -216,12 +244,49 @@ static const struct ucsi_operations pmic_glink_ucsi_ops = {
 
 static void pmic_glink_ucsi_read_ack(struct pmic_glink_ucsi *ucsi, const void *data, int len)
 {
-	const struct ucsi_read_buf_resp_msg *resp = data;
+	u32 ret_code, buf_len, max_len;
+	u8 *buf;
+
+	if (ucsi->ucsi->version) {
+		if (ucsi->ucsi->version >= UCSI_VERSION_2_0) {
+			max_len = sizeof(struct ucsi_v2_read_buf_resp_msg);
+			buf = ((struct ucsi_v2_read_buf_resp_msg *)data)->buf;
+			buf_len = UCSI_BUF_V2_SIZE;
+		} else {
+			max_len = sizeof(struct ucsi_read_buf_resp_msg);
+			buf = ((struct ucsi_read_buf_resp_msg *)data)->buf;
+			buf_len = UCSI_BUF_V1_SIZE;
+		}
+	} else if (!ucsi->ucsi->version && !ucsi->ucsi_registered) {
+		/*
+		 * If UCSI version is not known yet because device is not registered, choose buffer
+		 * size which best fits incoming data
+		 */
+		if (len > sizeof(struct pmic_glink_hdr) + UCSI_BUF_V2_SIZE) {
+			max_len = sizeof(struct ucsi_v2_read_buf_resp_msg);
+			buf = ((struct ucsi_v2_read_buf_resp_msg *)data)->buf;
+			buf_len = UCSI_BUF_V2_SIZE;
+		} else {
+			max_len = sizeof(struct ucsi_read_buf_resp_msg);
+			buf = ((struct ucsi_read_buf_resp_msg *)data)->buf;
+			buf_len = UCSI_BUF_V1_SIZE;
+		}
+	} else {
+		dev_err(ucsi->dev, "UCSI version not set\n");
+		return;
+	}
 
-	if (resp->ret_code)
+	if (len > max_len)
+		return;
+
+	if (buf_len > len - sizeof(struct pmic_glink_hdr) - sizeof(u32))
+		buf_len = len - sizeof(struct pmic_glink_hdr) - sizeof(u32);
+
+	memcpy(&ret_code, buf + sizeof(struct pmic_glink_hdr) + buf_len, sizeof(u32));
+	if (ret_code)
 		return;
 
-	memcpy(ucsi->read_buf, resp->buf, UCSI_BUF_SIZE);
+	memcpy(ucsi->read_buf, buf, buf_len);
 	complete(&ucsi->read_ack);
 }
 
-- 
2.34.1


