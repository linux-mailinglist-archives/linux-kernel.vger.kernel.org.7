Return-Path: <linux-kernel+bounces-732697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CE5B06AEA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 02:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37F7C16C2A6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 00:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D6021A445;
	Wed, 16 Jul 2025 00:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K9DI5IvW"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350E421773F
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 00:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752627150; cv=none; b=V+uWWoP0XZwuYsl4lQutDK75UDmXgYRAQ1tNWQ7RZKIlx2P21QJwvDBj50ngYFIKD+z3nTBqROg2H35KssvDF1un657GmqfzMh+hlFfCBzcDBav6fM+ab8HNDETC6x7qUtsDTg+qp+xoD6mVKt+svR0mwJrgi/DWdsuQ2cWWXps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752627150; c=relaxed/simple;
	bh=KMT5z8mhczbyFwWS7RYpw5Qrr1RGxPSb+bo/wxuCfOk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RqRDZummKynHoYvvdSLi6liOnTpkcq2AFxZq5ppMdVN+61BDFAMUHmLvEsNmwj3yx8by3aikYxh5hgqFt61ojGaUTGK4nrczpLYSaFCgg8Pf1VemRmdO84+mcD3tLuZj1wSJ9LQSGL6HDL0XP/sK1Y4Y+u+ATHGFwT/wuzhfUVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K9DI5IvW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FGDHYs031159
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 00:52:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=25xQM2KEtU4vblrflgweIvHQ5dspnQlwKDq
	ajlJ5ujY=; b=K9DI5IvW4EJecxEAH+s8vIlHUrT511UVAXWSQrvov3zfsjRY8Vt
	Sq9drhV8OecLtG386+YC7DcEEKjlckjLElKpB5VNAsmcWs0eTa4xjjpVmtGZbTLF
	1UalJyhgSTPLLQ4lwWNJ9WmxbRRiPP4VDYU8HMX4v4bOEFwMRJCyQcJRM/FFIFKQ
	X2S1yCY7b+J2oL90EhQYZcmlQDYbuzrt0NaHu/SnqKqj9p6ed37Kec7nYWqM7Pmg
	AejiXKDAuKdTFFyHLLPdKdXF12qLmqBW0N0lXqtGty1LDMgHQ+Qb0Lp7kLxl3Uj+
	jPQiV6kPrX/5P+ZfMY0EOzs79mk0U11ya4w==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufut9x3b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 00:52:27 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-748f3d4c7e7so5575343b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 17:52:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752627147; x=1753231947;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=25xQM2KEtU4vblrflgweIvHQ5dspnQlwKDqajlJ5ujY=;
        b=B3QsCDzggxobqppHXUaCbF8gXCKnoPdcdWQqIZOOhs3FvQLXk3FolJrRNbk2VQaRqd
         oFrwes9BMBJ5YtqYoakG8Meo8sNtFpbOgOPYsNX/x9Y4FNIClFjV/+PKgRk5omu56Bto
         hfjYejowZsp7nPBh1gGIsTT5R3Fko5cMhfgnwhgT6wZL+2B9k9KCa/XO6HjLw7YDmgQ9
         gsr9nuM6njjVyeXPjXW4gD3t+IDE+eujRQ+dD8TEF94Gt/8XN7l1Ttduzbd2LJE/N9LD
         Va0V3vmt28P4d7Cww/B7sQdFXKEXHflqY8PqdksM6KKt65a7HxfuYeG5xf7n9NswU88K
         2OKA==
X-Forwarded-Encrypted: i=1; AJvYcCXhmQuQkhGj9UcoPESGKhaAJZy/i1Es0rm0HRdTXcqnCWS0S4xw1PUUDIeaZJgxAWa8HAz9nbFufCF4AU4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1W/2Egn6kQl04CLT+EfENfYyv/IWyhOM1K1uauuUDnkvwUt//
	S2HOvrr737MxJ5BCTwEMkXFcN6SRwYIt+FUWCfGHGUWyEHp4xNIUmC/o8pjiN8OaWTaxtvyMFUL
	SbkgAd7Aoh3K5jpRFDZw015zvxLnEpRRVxEjeh02PiUKWDtiFLr2/i8txROAEL2foGk0=
X-Gm-Gg: ASbGncvt73Gh3/FFDE8U52s45p40uj5VveQe7EgTpoEPr4UyuYndY9jlMCoO2UhBhOU
	JFwcArmb5egGxGnLacknAJEPYeMBJyGmSg/8ONkYSOXdqtWL9kHI11GssJuJV8VlYKgtilyPFqV
	DKNla0NcY4J8JAo1ONOEbSK72HuviRkJWOd4wgZ15zVWdVehM+Z+ts7zkJ5wr5vSlNPs3hQlfTW
	QSZjK9T4wPahSfXxbi7FRk4lLIbiIl16M6VM4bIF8uhlkpOsHgOPQFismOac2jnZ25iMVuus28M
	u9Fjyhg8CYUTIa1AqoTDinpRwo7jP0nr7JzU3EwK5sMpiuyACVh05t3FGC/Z4fBIesbvQKnCwdV
	HvMsq0/VNWHGNDmdJ2NjnwJiaXco=
X-Received: by 2002:a05:6a21:648a:b0:231:4bbc:ff09 with SMTP id adf61e73a8af0-2381313ca9bmr1001224637.36.1752627146632;
        Tue, 15 Jul 2025 17:52:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYu/eOGeqhr9LJldFOKWzeuC3GEI23AZZeiCfg36XrTPAaeml4wmmR1iwzwasmrypGBn2QCQ==
X-Received: by 2002:a05:6a21:648a:b0:231:4bbc:ff09 with SMTP id adf61e73a8af0-2381313ca9bmr1001189637.36.1752627146224;
        Tue, 15 Jul 2025 17:52:26 -0700 (PDT)
Received: from hu-amelende-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe6f7507sm12752326a12.56.2025.07.15.17.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 17:52:25 -0700 (PDT)
From: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
To: heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org
Cc: lumag@kernel.org, neil.armstrong@linaro.org, johan+linaro@kernel.org,
        quic_bjorande@quicinc.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v2] usb: typec: ucsi: ucsi_glink: Increase buffer size to support UCSI v2
Date: Tue, 15 Jul 2025 17:52:24 -0700
Message-Id: <20250716005224.312155-1-anjelique.melendez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=e7gGSbp/ c=1 sm=1 tr=0 ts=6876f7cc cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=HougwLLIzSuBeMajkRwA:9
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: mSTiZR7nSI7CaEej8XSPLYVI8Gb6aVf-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDAwNSBTYWx0ZWRfX2oUZNcqWUygN
 E8GbI0uzn4zUx0cNsKw/cf8uV7AXmWX1Pe55iul6c5CVDMt9l/oMJEzfQgYWVHgR0RILF1Q8dtK
 NHAOjk4xRGYthBJ2MYBPUJuA4rcNewpC014c0dzbMRx8B8Dlt89ff+oELAUIYxTeWEeILeOq9h7
 dkYGMu/41G7ewUUvTWGNRXkGdi8XF+sTswsw4/ywR9bqS7t7/wMWr0sOX+zg3WhsXT7Xpr9EO4c
 u4Jc1llSqKiBHh8evgdRgezl/A8iaLMFSJCUvLMMJyDyNS6QWwvE/KxXA+D0VirgHJfJUc6Ni1d
 gmmYzAOibLsdB1QIYkp6wryZHTju82KGAMHs+CZ2TUmO8CwxpxaV5vAzkaIr0BlWAbN88S0MNSH
 IjzWeYOzmbosX5YuMHoblACg8uR8ZZHLKdMW4a6XQi8Ag/UiUbzkEHiiXZRyDilBIIeMsWMj
X-Proofpoint-ORIG-GUID: mSTiZR7nSI7CaEej8XSPLYVI8Gb6aVf-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_05,2025-07-15_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 spamscore=0 suspectscore=0
 phishscore=0 bulkscore=0 impostorscore=0 clxscore=1015 adultscore=0
 malwarescore=0 mlxlogscore=777 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507160005

UCSI v2 specification has increased the MSG_IN and MSG_OUT size from
16 bytes to 256 bytes each for the message exchange between OPM and PPM
This makes the total buffer size increase from 48 bytes to 528 bytes.
Update the buffer size to support this increase.

Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
---
Changes since v1:
 - Defined buf size in terms of other UCSI defines
 - Removed UCSI_BUF_SIZE and used the explicit v1 or v2 buffer size macros
 - Removed Qualcomm copyright
 - link: https://lore.kernel.org/all/20250624222922.2010820-1-anjelique.melendez@oss.qualcomm.com/
---
 drivers/usb/typec/ucsi/ucsi_glink.c | 58 ++++++++++++++++++++++++-----
 1 file changed, 48 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
index 8af79101a2fc..2918c88e54d2 100644
--- a/drivers/usb/typec/ucsi/ucsi_glink.c
+++ b/drivers/usb/typec/ucsi/ucsi_glink.c
@@ -16,10 +16,10 @@
 
 #define PMIC_GLINK_MAX_PORTS		3
 
-#define UCSI_BUF_SIZE                   48
+#define UCSI_BUF_V1_SIZE               (UCSI_MESSAGE_OUT + (UCSI_MESSAGE_OUT - UCSI_MESSAGE_IN))
+#define UCSI_BUF_V2_SIZE               (UCSIv2_MESSAGE_OUT + (UCSIv2_MESSAGE_OUT - UCSI_MESSAGE_IN))
 
 #define MSG_TYPE_REQ_RESP               1
-#define UCSI_BUF_SIZE                   48
 
 #define UC_NOTIFY_RECEIVER_UCSI         0x0
 #define UC_UCSI_READ_BUF_REQ            0x11
@@ -32,13 +32,25 @@ struct ucsi_read_buf_req_msg {
 
 struct ucsi_read_buf_resp_msg {
 	struct pmic_glink_hdr   hdr;
-	u8                      buf[UCSI_BUF_SIZE];
+	u8                      buf[UCSI_BUF_V1_SIZE];
+	u32                     ret_code;
+};
+
+struct ucsi_v2_read_buf_resp_msg {
+	struct pmic_glink_hdr   hdr;
+	u8                      buf[UCSI_BUF_V2_SIZE];
 	u32                     ret_code;
 };
 
 struct ucsi_write_buf_req_msg {
 	struct pmic_glink_hdr   hdr;
-	u8                      buf[UCSI_BUF_SIZE];
+	u8                      buf[UCSI_BUF_V1_SIZE];
+	u32                     reserved;
+};
+
+struct ucsi_v2_write_buf_req_msg {
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
@@ -131,8 +143,9 @@ static int pmic_glink_ucsi_read_message_in(struct ucsi *ucsi, void *val, size_t
 static int pmic_glink_ucsi_locked_write(struct pmic_glink_ucsi *ucsi, unsigned int offset,
 					const void *val, size_t val_len)
 {
-	struct ucsi_write_buf_req_msg req = {};
+	struct ucsi_v2_write_buf_req_msg req = {};
 	unsigned long left;
+	size_t len;
 	int ret;
 
 	req.hdr.owner = PMIC_GLINK_OWNER_USBC;
@@ -142,7 +155,18 @@ static int pmic_glink_ucsi_locked_write(struct pmic_glink_ucsi *ucsi, unsigned i
 
 	reinit_completion(&ucsi->write_ack);
 
-	ret = pmic_glink_send(ucsi->client, &req, sizeof(req));
+	if (!ucsi->ucsi->version || ucsi->ucsi->version >= UCSI_VERSION_2_1) {
+		/* If UCSI version is unknown, use the maximum buffer size */
+		len = sizeof(req);
+	} else {
+		/*
+		 * If UCSI V1, buffer size should be UCSI_BUF_V1_SIZE so update
+		 * len accordingly
+		 */
+		len = sizeof(struct ucsi_write_buf_req_msg);
+	}
+
+	ret = pmic_glink_send(ucsi->client, &req, len);
 	if (ret < 0) {
 		dev_err(ucsi->dev, "failed to send UCSI write request: %d\n", ret);
 		return ret;
@@ -216,12 +240,26 @@ static const struct ucsi_operations pmic_glink_ucsi_ops = {
 
 static void pmic_glink_ucsi_read_ack(struct pmic_glink_ucsi *ucsi, const void *data, int len)
 {
-	const struct ucsi_read_buf_resp_msg *resp = data;
+	const struct ucsi_v2_read_buf_resp_msg *resp = data;
+	u32 ret_code, buffer_len;
+
+	if (!ucsi->ucsi->version || ucsi->ucsi->version >= UCSI_VERSION_2_1) {
+		/* If UCSI version is unknown, use the maximum buffer size */
+		ret_code = resp->ret_code;
+		buffer_len = UCSI_BUF_V2_SIZE;
+	} else {
+		/*
+		 * If UCSI V1, use UCSI_BUF_V1_SIZE buffer size and
+		 * update ret_code offset accordingly
+		 */
+		ret_code = ((struct ucsi_read_buf_resp_msg *)data)->ret_code;
+		buffer_len = UCSI_BUF_V1_SIZE;
+	}
 
-	if (resp->ret_code)
+	if (ret_code)
 		return;
 
-	memcpy(ucsi->read_buf, resp->buf, UCSI_BUF_SIZE);
+	memcpy(ucsi->read_buf, resp->buf, buffer_len);
 	complete(&ucsi->read_ack);
 }
 
-- 
2.34.1


