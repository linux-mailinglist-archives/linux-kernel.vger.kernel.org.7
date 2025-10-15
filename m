Return-Path: <linux-kernel+bounces-854560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7DABDEB57
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 15:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 511F5481629
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 13:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F7321FF55;
	Wed, 15 Oct 2025 13:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SY27D/q7"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57941F1537
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 13:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760534293; cv=none; b=AwnKHjuDVlgVdLYiZXLYxDg4gw8bwty3tDty/e7MyqzAdRBkuPklTmj2+wBO8nd736YDWZQ7brM0CejfwN7YDuW29+9WSZXIv/0A8PJkm/o2rVYN4EQkoi0Ffd9A0w1wP1mwuxbeRXuYHpvP+KyvjNqcKPgXDD7AifpEAPw6zvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760534293; c=relaxed/simple;
	bh=vZ/RyRZG/SlbF7P/WnS78eUkc8xlz11H4I4OUiw1Xeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nWFu7oxw6/mouSib9+DjL5o45GuefzFSfZy3omljB5WhfDeznECL1IOISRmsUUhezh1n36I/fvBC55K8tXNZ0EIK1OGRtJAlb2+b2Y93OuxraKN93iHydcFB99bi4cBwIm6eizKrXriKTssXjCGnwt0m6snedFXiZ/S+IvcTq5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SY27D/q7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59FAKbWP016165
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 13:18:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=1cUb4FoZv4E
	2KpTwpsL1Qi55vPJoClmNMvvhIsU2zWg=; b=SY27D/q7Tkw0/ujcXTJXGzt2sUP
	FS64aI8m7A42kZZsmUc3IdSSYZyTi7oRojnF6hBXThCJMqvM7grwF6/tsAPo3UmP
	qzP8/BSMQ7hXACnxsYxoxnX9PXeR2LrqYv0Z9Xeqyv4g1ZCnuzwnOHjU3qsOXyb0
	Vkqk0Ka7Td7Db2xWKtSZwv2RSaWzYoJru0q1H6u2bdqFOijVbk2EMzrt4CX4s0Ok
	Tq0PIzlFgwZ/ZitsqPhYvvs33Cl8+r50H/tJABKayCizm1eyL1DpWWc9jq3bdu20
	zy6W0GZwRK/xIwdjHbFB4grjRipi/JrhoaXKJcKwxqrRQ+SsKHkUCX3vhDA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfm5mkw6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 13:18:10 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8635d47553dso2553955085a.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 06:18:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760534289; x=1761139089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1cUb4FoZv4E2KpTwpsL1Qi55vPJoClmNMvvhIsU2zWg=;
        b=xHrqRnbiVjzf6tewsrIlouMson7MaZ/Txw6hnol0CsMS2GA6zt+OYFaFlopBpMvUek
         eKs+Bsa36XUz0tZ1MYBNySRgAlgzDp5PN9V2f6/SdJ9D9m5M7QMqETs0asQwqVeuQedv
         YhzPHKZnpiQR8Bi0aq6Ku5Dq6fwR6kMG2WDb5gJs32ek7A2i4Fysf4bNG0dp27ADF5ME
         cDExvTFo1eGEQdnE83fVP4gq2dKsEaFX/j6xSlmTRN9LSEnxEFBYbR6z5K72TFF3ZZnp
         +3J6IDMMvVr35wkXeu2MIf7W7CAyTEAyK4BytIulaqFpjdHp2h3SU2GD4MOe9uYgFG6r
         ehBA==
X-Forwarded-Encrypted: i=1; AJvYcCVJPvjxpo1QJZ+I/Gn1zvCrpD3DYGVE3pZkCtGsqcwA9O7mve/8Bi6CiKIiOnqOUwS4ugHWeUJ/DqPnW7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVHndMEpH31JTXBujzBJTULYheaTRMHh8UxYOxKwYNvALl5UDp
	Bis8GlUDuz9sstUfJarAjiKZm5ys3p9kcOrz9Y7haehY4wLwI8Lkztpu2zoot+r8oppfd///q2N
	zyOF0mT1nsXotTAexDdFiYbFoWKxCMB8YpmDbzX92qJrTpfHWJ5PZXW5LJYQ1XIojrF0=
X-Gm-Gg: ASbGnctOy2x6W5naE8cKuXF5YT/D1qYIi4mfWZofuL/ExuvxKmKbJPC9nzs4A34ggZ7
	OxbAyCAFaMZ8Pifd+3c3lsANAF6NmHYnGNrsjxnNE6QxjwgOIrilhdVxDn8Tq4syeV3qzEGQowm
	QT5Yh4kOYjFSSMUzXa4iG3612HVGLz5rr0WHEdp5R/f9v2c7s1ECHvLWFwfcmC1UF2w7gSfRfNk
	QQ0jsqZJ8pSu3yVuHBJkFyNiH20iZJM1RPv72A648abq9BtFXGO3pfilBxCS5Cyamyk01N7QW2Q
	H39qiZhTYS3IJUlVrb0Y520avfp+A5hadYDBDdqb3cUxGKmEpdZSOQ==
X-Received: by 2002:a05:622a:4c1b:b0:4b5:e7c3:1dee with SMTP id d75a77b69052e-4e6ead54342mr390090101cf.47.1760534289359;
        Wed, 15 Oct 2025 06:18:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6c3G91brdZkpPUjrur01pEn1Xk3q4nJeLRsNBiynm9tkfya6SGJvXyEwQXuksUqgpd7mVMQ==
X-Received: by 2002:a05:622a:4c1b:b0:4b5:e7c3:1dee with SMTP id d75a77b69052e-4e6ead54342mr390089561cf.47.1760534288837;
        Wed, 15 Oct 2025 06:18:08 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fc155143fsm262081245e9.11.2025.10.15.06.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 06:18:08 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org, alexey.klimov@linaro.org,
        linux-sound@vger.kernel.org, m.facchin@arduino.cc,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        Stable@vger.kernel.org
Subject: [PATCH 2/9] ASoC: qcom: q6adm: the the copp device only during last instance
Date: Wed, 15 Oct 2025 14:17:32 +0100
Message-ID: <20251015131740.340258-3-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015131740.340258-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20251015131740.340258-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 5hlBIpoVaCyL0KJvtRPsepQ5LpfPreaJ
X-Proofpoint-ORIG-GUID: 5hlBIpoVaCyL0KJvtRPsepQ5LpfPreaJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyMCBTYWx0ZWRfXy5fqG4lYyTtC
 TNvKw6hawBQzMKDxzOvnDVRLEMKZOk2UOWW5QRnPc5z57cRIIk2GjB5hnIp1gvND7IfK+v3hNpz
 iKBVKiBW2xVMIN2IBp/EjxUJK2dIOhDspAM1fKOGP0OCC2a36X+9G3obvG2IzODkaX7REB3dPkj
 kcCZ6I7GKB0IMuppzPVjGvlk7W0SlQy4bIc5oGW53jROoiUhhDjk7AMuZX4n6ZkFAYYv+QAe9WX
 F2MrqxDRHJJDooFfiuhB1iGKNuFtTU/uS9mu3JR5lLCeivutGZVdpLjn01FyFADtfGoISk+q0VX
 ActTXGcW2ObkceV2/omZeDKOdgDWh10PAiLD0C76RYFFJi6kEy0A3ZaWDjutYn+gWg94goUyX9H
 3ssGtPPmXgh53fT9ZuRJQbOLFPcl2w==
X-Authority-Analysis: v=2.4 cv=V71wEOni c=1 sm=1 tr=0 ts=68ef9f12 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=LQLTnAVHjxzgEifUwDEA:9 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0
 impostorscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110020

A matching Common object post processing instance is normally resused
across multiple streams. However currently we close this on DSP
eventhough there is a refcount on this copp object, this can result in
below error.

q6routing ab00000.remoteproc:glink-edge:apr:service@8:routing: Found Matching Copp 0x0
qcom-q6adm aprsvc:service:4:8: cmd = 0x10325 return error = 0x2
q6routing ab00000.remoteproc:glink-edge:apr:service@8:routing: DSP returned error[2]
q6routing ab00000.remoteproc:glink-edge:apr:service@8:routing: Found Matching Copp 0x0
qcom-q6adm aprsvc:service:4:8: cmd = 0x10325 return error = 0x2
q6routing ab00000.remoteproc:glink-edge:apr:service@8:routing: DSP returned error[2]
qcom-q6adm aprsvc:service:4:8: cmd = 0x10327 return error = 0x2
qcom-q6adm aprsvc:service:4:8: DSP returned error[2]
qcom-q6adm aprsvc:service:4:8: Failed to close copp -22
qcom-q6adm aprsvc:service:4:8: cmd = 0x10327 return error = 0x2
qcom-q6adm aprsvc:service:4:8: DSP returned error[2]
qcom-q6adm aprsvc:service:4:8: Failed to close copp -22

Fix this by addressing moving the adm_close to copp_kref destructor
callback.

Fixes: 7b20b2be51e1 ("ASoC: qdsp6: q6adm: Add q6adm driver")
Cc: <Stable@vger.kernel.org>
Reported-by: Martino Facchin <m.facchin@arduino.cc>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 sound/soc/qcom/qdsp6/q6adm.c | 146 +++++++++++++++++------------------
 1 file changed, 71 insertions(+), 75 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6adm.c b/sound/soc/qcom/qdsp6/q6adm.c
index 1530e98df165..75a029a696ac 100644
--- a/sound/soc/qcom/qdsp6/q6adm.c
+++ b/sound/soc/qcom/qdsp6/q6adm.c
@@ -109,11 +109,75 @@ static struct q6copp *q6adm_find_copp(struct q6adm *adm, int port_idx,
 
 }
 
+static int q6adm_apr_send_copp_pkt(struct q6adm *adm, struct q6copp *copp,
+				   struct apr_pkt *pkt, uint32_t rsp_opcode)
+{
+	struct device *dev = adm->dev;
+	uint32_t opcode = pkt->hdr.opcode;
+	int ret;
+
+	mutex_lock(&adm->lock);
+	copp->result.opcode = 0;
+	copp->result.status = 0;
+	ret = apr_send_pkt(adm->apr, pkt);
+	if (ret < 0) {
+		dev_err(dev, "Failed to send APR packet\n");
+		ret = -EINVAL;
+		goto err;
+	}
+
+	/* Wait for the callback with copp id */
+	if (rsp_opcode)
+		ret = wait_event_timeout(copp->wait,
+					 (copp->result.opcode == opcode) ||
+					 (copp->result.opcode == rsp_opcode),
+					 msecs_to_jiffies(TIMEOUT_MS));
+	else
+		ret = wait_event_timeout(copp->wait,
+					 (copp->result.opcode == opcode),
+					 msecs_to_jiffies(TIMEOUT_MS));
+
+	if (!ret) {
+		dev_err(dev, "ADM copp cmd timedout\n");
+		ret = -ETIMEDOUT;
+	} else if (copp->result.status > 0) {
+		dev_err(dev, "DSP returned error[%d]\n",
+			copp->result.status);
+		ret = -EINVAL;
+	}
+
+err:
+	mutex_unlock(&adm->lock);
+	return ret;
+}
+
+static int q6adm_device_close(struct q6adm *adm, struct q6copp *copp,
+			      int port_id, int copp_idx)
+{
+	struct apr_pkt close;
+
+	close.hdr.hdr_field = APR_HDR_FIELD(APR_MSG_TYPE_SEQ_CMD,
+					APR_HDR_LEN(APR_HDR_SIZE),
+					APR_PKT_VER);
+	close.hdr.pkt_size = sizeof(close);
+	close.hdr.src_port = port_id;
+	close.hdr.dest_port = copp->id;
+	close.hdr.token = port_id << 16 | copp_idx;
+	close.hdr.opcode = ADM_CMD_DEVICE_CLOSE_V5;
+
+	return q6adm_apr_send_copp_pkt(adm, copp, &close, 0);
+}
+
 static void q6adm_free_copp(struct kref *ref)
 {
 	struct q6copp *c = container_of(ref, struct q6copp, refcount);
 	struct q6adm *adm = c->adm;
 	unsigned long flags;
+	int ret;
+
+	ret = q6adm_device_close(adm, c, c->afe_port, c->copp_idx);
+	if (ret < 0)
+		dev_err(adm->dev, "Failed to close copp %d\n", ret);
 
 	spin_lock_irqsave(&adm->copps_list_lock, flags);
 	clear_bit(c->copp_idx, &adm->copp_bitmap[c->afe_port]);
@@ -155,13 +219,13 @@ static int q6adm_callback(struct apr_device *adev, struct apr_resp_pkt *data)
 		switch (result->opcode) {
 		case ADM_CMD_DEVICE_OPEN_V5:
 		case ADM_CMD_DEVICE_CLOSE_V5:
-			copp = q6adm_find_copp(adm, port_idx, copp_idx);
-			if (!copp)
-				return 0;
-
-			copp->result = *result;
-			wake_up(&copp->wait);
-			kref_put(&copp->refcount, q6adm_free_copp);
+			list_for_each_entry(copp, &adm->copps_list, node) {
+				if ((port_idx == copp->afe_port) && (copp_idx == copp->copp_idx)) {
+					copp->result = *result;
+					wake_up(&copp->wait);
+					break;
+				}
+			}
 			break;
 		case ADM_CMD_MATRIX_MAP_ROUTINGS_V5:
 			adm->result = *result;
@@ -234,65 +298,6 @@ static struct q6copp *q6adm_alloc_copp(struct q6adm *adm, int port_idx)
 	return c;
 }
 
-static int q6adm_apr_send_copp_pkt(struct q6adm *adm, struct q6copp *copp,
-				   struct apr_pkt *pkt, uint32_t rsp_opcode)
-{
-	struct device *dev = adm->dev;
-	uint32_t opcode = pkt->hdr.opcode;
-	int ret;
-
-	mutex_lock(&adm->lock);
-	copp->result.opcode = 0;
-	copp->result.status = 0;
-	ret = apr_send_pkt(adm->apr, pkt);
-	if (ret < 0) {
-		dev_err(dev, "Failed to send APR packet\n");
-		ret = -EINVAL;
-		goto err;
-	}
-
-	/* Wait for the callback with copp id */
-	if (rsp_opcode)
-		ret = wait_event_timeout(copp->wait,
-					 (copp->result.opcode == opcode) ||
-					 (copp->result.opcode == rsp_opcode),
-					 msecs_to_jiffies(TIMEOUT_MS));
-	else
-		ret = wait_event_timeout(copp->wait,
-					 (copp->result.opcode == opcode),
-					 msecs_to_jiffies(TIMEOUT_MS));
-
-	if (!ret) {
-		dev_err(dev, "ADM copp cmd timedout\n");
-		ret = -ETIMEDOUT;
-	} else if (copp->result.status > 0) {
-		dev_err(dev, "DSP returned error[%d]\n",
-			copp->result.status);
-		ret = -EINVAL;
-	}
-
-err:
-	mutex_unlock(&adm->lock);
-	return ret;
-}
-
-static int q6adm_device_close(struct q6adm *adm, struct q6copp *copp,
-			      int port_id, int copp_idx)
-{
-	struct apr_pkt close;
-
-	close.hdr.hdr_field = APR_HDR_FIELD(APR_MSG_TYPE_SEQ_CMD,
-					APR_HDR_LEN(APR_HDR_SIZE),
-					APR_PKT_VER);
-	close.hdr.pkt_size = sizeof(close);
-	close.hdr.src_port = port_id;
-	close.hdr.dest_port = copp->id;
-	close.hdr.token = port_id << 16 | copp_idx;
-	close.hdr.opcode = ADM_CMD_DEVICE_CLOSE_V5;
-
-	return q6adm_apr_send_copp_pkt(adm, copp, &close, 0);
-}
-
 static struct q6copp *q6adm_find_matching_copp(struct q6adm *adm,
 					       int port_id, int topology,
 					       int mode, int rate,
@@ -567,15 +572,6 @@ EXPORT_SYMBOL_GPL(q6adm_matrix_map);
  */
 int q6adm_close(struct device *dev, struct q6copp *copp)
 {
-	struct q6adm *adm = dev_get_drvdata(dev->parent);
-	int ret = 0;
-
-	ret = q6adm_device_close(adm, copp, copp->afe_port, copp->copp_idx);
-	if (ret < 0) {
-		dev_err(adm->dev, "Failed to close copp %d\n", ret);
-		return ret;
-	}
-
 	kref_put(&copp->refcount, q6adm_free_copp);
 
 	return 0;
-- 
2.51.0


