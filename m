Return-Path: <linux-kernel+bounces-863922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E64BF982C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 02:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0BD7486D5B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 00:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF101F2B88;
	Wed, 22 Oct 2025 00:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VaCWdTIk"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D89E19309C
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 00:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761093963; cv=none; b=EcJdqw4qANK8ootwigD5ee8AGglsRiClQ5BgBp0btcmpz30pdq+F5kVmqYihgNLqvoWN/w0mzyIrAq+D0V8XdHxSmKo3yUAA9NatkZb02rCw2PossXQiwfVTNpcjab0HRjKgtIrUTaa65LKE/dWKGn0cDEZW8igN85La+xEhcYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761093963; c=relaxed/simple;
	bh=pWxHW44EZoYVSkOewAQZ0Iz+uCPAjge1yg8BskkCR7U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tKu8M6d4UJlm8xPs574SPR65BgVjuXkdM0vMlX9RS9r4ux8xbwsI5YpCcpHtOzprrjN+bUCM2auYVs+NuJgNR+rYpJT8XkWkGZG/3/FAOORMwMIdqvP1shoUaa3VdxLsTslEipPnhCEySvNea69Y0nKzb1keTQL837rNE9p1RT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VaCWdTIk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59LEXGaX020635
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 00:46:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Ofz4SPaaGCE
	jihV6QVq9ZPH2b088K+t4UidQCmtgRC4=; b=VaCWdTIkFArEhHkxLlC9B88rryZ
	h9tRtVeoxL5XUDfBk1uvVtYyssCYKpk5CzmsXYEqvuuFPblWvceOPavXzG82Qx45
	HcwjSBBBrdSh287cfV9Ovd6iWiOxfZ5+fBs2Re06LsP0SVa6je+OXDMyOYf91pIY
	jOstS5lw2wAECHFuWRXaZMgEPTjV8SCAbqPcUU3S6Tj/ffsI/t9RKr50ZAGRYuG0
	h3ZXr7FWQQXi+UdLnX8AjIO9epEmeHJYBiQUjlQd9Z5Khba7/kwT0uNp/QAkMNrW
	hHki3TeCljKWxiIeUR/AnSjJjdq4FkNe0IH3Vwpa6I4UFmR+lpxiFjyFZEQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v3442p1d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 00:46:00 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-28c58e009d1so139810685ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 17:46:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761093960; x=1761698760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ofz4SPaaGCEjihV6QVq9ZPH2b088K+t4UidQCmtgRC4=;
        b=tpwZ6GJhHevy0Uq8gaa55TZR2gqGYPvirOzhE9irKKemE1U02yipOY/15O51FSQrtw
         HwfhEBu4q456l1lybTU0lPZZxbrfHN0tolZsod1XqlIuzlpPAZjI/DA/Z8nXyr9AW9y/
         TrJP5j0YPKyPBMG6uwlvv5yheJhphiOWaFZvQcdaUraUMWDzz3x4NP3F4kpln5mu3JBe
         0uH7bBVKKFhiBUQA57RHEVb8G8HAVDmtIyfClqSR4lrUHoWKNTVqo9rNqjVZr7Bc2mz/
         kO4h/cxci2WCa2Jtlt+FDAaACA/eAXdUFLkNJOOKVOeeaFNWeMBzB9rYWepj1ZhtGju8
         GgSw==
X-Forwarded-Encrypted: i=1; AJvYcCXIZeajVfrNZR767OPpSE/z8M0hIkjnhjZPtqo5Aj6N4jDnc2yyam3qYnO8PCT5CYuRg5rrwVLcmCwIeOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW7+2ujkFOApRLqX0q+BROACYq+rZxg4d4B8cgoNk8P+J4to44
	D5VrhK9kgXjp9pmVX5fC9NejbGcRnmnJ+7UwVIxlb5ySFo9Yk8+SwIxnfmi+HeNyO4FrTNrSjjk
	JlVEg+F/UqIH83EjzhCNgsxcq7hukw5IBaTZSHv+TtrGBY8r1l5RIi2z50He8NrDlNxs=
X-Gm-Gg: ASbGncv50PoQ6WDrsJMmYPcLjz3WXrgreGBIXPMzcQIoPvNrOGtZwlBzsX0rCvMHk9f
	kskMaeGsjmPvn6iJCEQ1mT3zXtytyiGoCQKsiCIWYG2JLHpi2q76cTCHRbTm/8Ly2bGlIk1JQAW
	O/6quogqnk53n+GSQ/+k+D4PK3Isyrnjmf4hVMwK4z/qYwTfKATJ6Yn4rg8AjlDD1fSERPMdy4u
	FPeXVNdCwkTfHC0Jsk+NGZVv7UwJk70lUcEu5SFsALKphj2Fe39jw3Yztk/NSFArbG5gUHmGhOQ
	hr6U1q0KrqVEc5Z5W/TN3lSHdHgG4maHLPXyy7wml3pkluc/QO2akX6E8tI2+Mun3e9FmVL4Ear
	QsLOlXmt1rw3mB4vIjDUptvQlyOoyig3hoxJPCBIgGO6SHJRy0HbxALRvC/3vwg==
X-Received: by 2002:a17:903:1250:b0:290:dfab:ca91 with SMTP id d9443c01a7336-290dfabccd9mr198000185ad.54.1761093959884;
        Tue, 21 Oct 2025 17:45:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGP2bGgL//K1+9S3/naE7QJvU094EI8LGpgUEBEN4PEQmvyRXKJYh7a9Zju5xNxs8aORy14XQ==
X-Received: by 2002:a17:903:1250:b0:290:dfab:ca91 with SMTP id d9443c01a7336-290dfabccd9mr197999975ad.54.1761093959412;
        Tue, 21 Oct 2025 17:45:59 -0700 (PDT)
Received: from hu-amelende-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246ebcf67sm121913045ad.15.2025.10.21.17.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 17:45:58 -0700 (PDT)
From: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
To: heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org
Cc: lumag@kernel.org, neil.armstrong@linaro.org, johan+linaro@kernel.org,
        quic_bjorande@quicinc.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v6 2/2] usb: typec: ucsi_glink: Increase buffer size to support UCSI v2
Date: Tue, 21 Oct 2025 17:45:54 -0700
Message-Id: <20251022004554.1956729-3-anjelique.melendez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251022004554.1956729-1-anjelique.melendez@oss.qualcomm.com>
References: <20251022004554.1956729-1-anjelique.melendez@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: h-ESW-GVkdz5mi5ZCBh0xamiXXFl9-BZ
X-Proofpoint-ORIG-GUID: h-ESW-GVkdz5mi5ZCBh0xamiXXFl9-BZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMyBTYWx0ZWRfX78we0lvsBzhF
 fCxUCnyV4EPraF7J2/z2SQztcvXc4KJyg+bXe8JR4lFFP/RPjPhpIsQcnAkwfITAybIvSvOQDsW
 /f/ynu6ah01zfEuhiuQNZygh1WoYTit6G76EXgxz1ZzSMYAccMJynxQAqgn8c3MxyybIFuVVq/X
 c28wIGzyXpeemtGTbVtSrlBywO1kEwKG8rgUckNwc5SVHEwZ8xui76yzcoCr6TYH4KxGHgQfKZR
 92bHEtqusAsKoRuJIbd3QWJUKtXPYtZ+ZhuEgT9GycjeXW6cu8JEV+nEpSyRu42BeUQPsStY1/p
 97qlUyXvpWLhDTfBdsSs+2ZN0uvrkyFB9XxEASYGedI0gcykHFTJDJ6NKPTkVbY7cVH+jUPy5dI
 0fzKVcPpt2iZ4qEYsdHQLuMt5M/6qQ==
X-Authority-Analysis: v=2.4 cv=E/vAZKdl c=1 sm=1 tr=0 ts=68f82948 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=bL7WY3GH-9A0ZCLeatoA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-21_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180023

UCSI v2 specification has increased the MSG_IN and MSG_OUT size from
16 bytes to 256 bytes each for the message exchange between OPM and PPM
This makes the total buffer size increase from 48 bytes to 528 bytes.
Update the buffer size to support this increase.

Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
---
 drivers/usb/typec/ucsi/ucsi_glink.c | 80 +++++++++++++++++++++++++----
 1 file changed, 70 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
index 1f9f0d942c1a..11b3e24e34e2 100644
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
@@ -32,13 +32,19 @@ struct ucsi_read_buf_req_msg {
 
 struct __packed ucsi_read_buf_resp_msg {
 	struct pmic_glink_hdr   hdr;
-	u8                      buf[UCSI_BUF_SIZE];
+	union {
+		u8 v2_buf[UCSI_BUF_V2_SIZE];
+		u8 v1_buf[UCSI_BUF_V1_SIZE];
+	} buf;
 	u32                     ret_code;
 };
 
 struct __packed ucsi_write_buf_req_msg {
 	struct pmic_glink_hdr   hdr;
-	u8                      buf[UCSI_BUF_SIZE];
+	union {
+		u8 v2_buf[UCSI_BUF_V2_SIZE];
+		u8 v1_buf[UCSI_BUF_V1_SIZE];
+	} buf;
 	u32                     reserved;
 };
 
@@ -72,7 +78,7 @@ struct pmic_glink_ucsi {
 	bool ucsi_registered;
 	bool pd_running;
 
-	u8 read_buf[UCSI_BUF_SIZE];
+	u8 read_buf[UCSI_BUF_V2_SIZE];
 };
 
 static int pmic_glink_ucsi_read(struct ucsi *__ucsi, unsigned int offset,
@@ -132,17 +138,35 @@ static int pmic_glink_ucsi_locked_write(struct pmic_glink_ucsi *ucsi, unsigned i
 					const void *val, size_t val_len)
 {
 	struct ucsi_write_buf_req_msg req = {};
+	size_t req_len, buf_len;
 	unsigned long left;
 	int ret;
+	u8 *buf;
 
 	req.hdr.owner = PMIC_GLINK_OWNER_USBC;
 	req.hdr.type = MSG_TYPE_REQ_RESP;
 	req.hdr.opcode = UC_UCSI_WRITE_BUF_REQ;
-	memcpy(&req.buf[offset], val, val_len);
+
+	if (ucsi->ucsi->version >= UCSI_VERSION_2_0) {
+		buf_len = UCSI_BUF_V2_SIZE;
+		buf = req.buf.v2_buf;
+	} else if (ucsi->ucsi->version) {
+		buf_len = UCSI_BUF_V1_SIZE;
+		buf = req.buf.v1_buf;
+	} else {
+		dev_err(ucsi->dev, "UCSI version unknown\n");
+		return -EINVAL;
+	}
+	req_len = sizeof(struct pmic_glink_hdr) + buf_len + sizeof(u32);
+
+	if (offset + val_len > buf_len)
+		return -EINVAL;
+
+	memcpy(&buf[offset], val, val_len);
 
 	reinit_completion(&ucsi->write_ack);
 
-	ret = pmic_glink_send(ucsi->client, &req, sizeof(req));
+	ret = pmic_glink_send(ucsi->client, &req, req_len);
 	if (ret < 0) {
 		dev_err(ucsi->dev, "failed to send UCSI write request: %d\n", ret);
 		return ret;
@@ -216,12 +240,48 @@ static const struct ucsi_operations pmic_glink_ucsi_ops = {
 
 static void pmic_glink_ucsi_read_ack(struct pmic_glink_ucsi *ucsi, const void *data, int len)
 {
-	const struct ucsi_read_buf_resp_msg *resp = data;
+	u32 ret_code, resp_len, buf_len = 0;
+	u8 *buf;
+
+	if (ucsi->ucsi->version) {
+		if (ucsi->ucsi->version >= UCSI_VERSION_2_0) {
+			buf = ((struct ucsi_read_buf_resp_msg *)data)->buf.v2_buf;
+			buf_len = UCSI_BUF_V2_SIZE;
+		} else {
+			buf = ((struct ucsi_read_buf_resp_msg *)data)->buf.v1_buf;
+			buf_len = UCSI_BUF_V1_SIZE;
+		}
+	} else if (!ucsi->ucsi_registered) {
+		/*
+		 * If UCSI version is not known yet because device is not registered, choose buffer
+		 * size which best fits incoming data
+		 */
+		if (len > sizeof(struct pmic_glink_hdr) + UCSI_BUF_V2_SIZE) {
+			buf = ((struct ucsi_read_buf_resp_msg *)data)->buf.v2_buf;
+			buf_len = UCSI_BUF_V2_SIZE;
+		} else {
+			buf = ((struct ucsi_read_buf_resp_msg *)data)->buf.v1_buf;
+			buf_len = UCSI_BUF_V1_SIZE;
+		}
+	} else {
+		dev_err(ucsi->dev, "Device has been registered but UCSI version is still unknown\n");
+		return;
+	}
 
-	if (resp->ret_code)
+	resp_len = sizeof(struct pmic_glink_hdr) + buf_len + sizeof(u32);
+
+	if (len > resp_len)
+		return;
+
+	/* Ensure that buffer_len leaves space for ret_code to be read back from memory */
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


