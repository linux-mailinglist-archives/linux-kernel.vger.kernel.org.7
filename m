Return-Path: <linux-kernel+bounces-866694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D117C0074A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8631E356C9B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39F830504C;
	Thu, 23 Oct 2025 10:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Rx8YMLF2"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D40C307AC5
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761215161; cv=none; b=m7wXFHBSvBl3A0vo5NIZLSO/msK/4CEYMC/f1Urd4d7xp+XSAc0YPy51wPdxi8eu5vBnT7o3Eo/U6CmsbGAy1cnO5koTc9vdNDnJLA7XBxRBbLVCE5Cs1XM9MIdErbuI/gXOoaiPugl9GhHq+g6yKFQnPdankvyWMh/zfnNP0OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761215161; c=relaxed/simple;
	bh=0NX0xrr/Yc+5DC4N9bMIQUn7iisOTqFME7dif499+F0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dttinuJYq0KBCOYPedaq2h+x1c/g0H2yVYvjteM+0RhZP0iukiMfNK3xiv4ZKPRl+5dyGgrDqvsRxulwjoc2bQWY+6IqjCeXoLyNrdsnMDorPpmjIsZuPqwTK1PKjJmpF5/7RIGElmp4W0sFiBZRYwRmMNPY+IYTrYwq9N1ia1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Rx8YMLF2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N7ep0s026316
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:25:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=rFyaRjCqrsV
	Ko5s83gYJ5NPJ5RtH4VSu/szdbYAmjEM=; b=Rx8YMLF2ki2Zt5b4l/45qX2MiQ+
	HxSn4jUkFtd1xYRVeAz1B9d/D3Q5M+9HNXSJmJcZRh8lnYWFfYhwk1mfjG8goGbk
	gBiXBNJpZjtcVPZYSMRGf958bAr44gY+EtCayYRpJjlHURVdceISASbtrSMPIwI3
	8NHIOb1eWTBmRijalxdgy6TJTPCbeKX2W7huimyPNZKEmOg6O/FNK/+iPd26Fig1
	g/5RZCa6p24beG21dl/Buxxa+EcKzpKG6vGybh/ICv93AsKv4WnkwBnI5N+oLCnR
	NSl/dtu9EaAWUExiGqfZS+cxHKo0WRPVmUYDk9lS5o0h4mEaVfHlhxOysXA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49y5x8j42g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:25:58 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4e8a3d0fb09so8805701cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 03:25:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761215157; x=1761819957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rFyaRjCqrsVKo5s83gYJ5NPJ5RtH4VSu/szdbYAmjEM=;
        b=rMTDkYyeDqm09epHx5Qaf4GICR7Uh5yROhyrCc3JGcPwqMbJww7w3NXBCr9V2Pbfgu
         Wvk1uKM/85WqLkVRaEKtrJE3PpffWC6rM0qdWTSgrTbIMAZtsuWccaO/MHEuzc8ydWol
         aoCNVuo9zuXDMojAAL5mZZNlRtqxXf6vamWWkN9KFnAI3APSLJ3nE/fo2wNP+2fG96XM
         79A//Wa5y2LRbp0fjbLbkLuB7d2JrpPJ+9NyKAP3dAzaVj4kBwA7P6Hpam2koDKbjbvX
         Bj1mf5ky18glWPWKUfxmWEok6afPt8y7djctsuG7UYxCYEnlkkEjwYooAptMdpNFDkJj
         2lxg==
X-Forwarded-Encrypted: i=1; AJvYcCXW3EQbl9EAGAaNO6ToxqYf1nrUzYO5wjWCEvW+11vHuv+QfCAgKgM2xdNoGRKqouNIyWFsLMu7gVXsSsw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6xHNaOi7r6bTaBOGTYWx36jkNJ9gXgZ2jAy1NWVjzEEFDWIer
	rFgEVwkTldcp0J3pF3KWf64+7jN5FGgt/U6qhFU+WEIKpg/Ur/0Y1XH16j3jvTb5O/a5/uBxao1
	Ce/xG0AYY6lYELUjN8XzfN0ZgSwGr15tjoU5rQocZdmkZh/GJJyoIpQahintYoJjeRiQ=
X-Gm-Gg: ASbGncunG+YGr1fkdafL41Wp6z8q3a3kn46HdZ8Dlo/fG1mcNaiHKWHG8tdwsVCZvHC
	qmir/yZgKB071zuzhvrxVl+pDF2UoebqVOdkqP5J0BpsNcfBD/mxbvEcuOzbO6cttiQFtRRY9sb
	/Zq6JgNCvNvfZsSskNOFtcuPlxRtOV95stIelBJzW7ipItrpINvUNOmdrmKdgblnZx53z97BMD3
	FfloB5TAMw0/qf/I5oAeBXHcoZanDImr0aoXVYpiRqDaa1Jxi0nwmdVF5Q+TUfEWe2fSo9zUTT6
	i3b0WTnWUxmL2MPXJ/8jOq6yda9Xm0gmoVFOthvVWis98H+nznWEJ4SBOmZdqeDQlfajadf8KzN
	vpWrbM36JNJvo
X-Received: by 2002:a05:622a:393:b0:4e8:bab2:9e0b with SMTP id d75a77b69052e-4e8bab2a3d8mr229158411cf.77.1761215157422;
        Thu, 23 Oct 2025 03:25:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEipUZPr/7bW8OGjBlVV+GOSronEBCQCGLlkN6DxGOE9VuhM0WSPcYLaWlph9XC0He1x3Uo4Q==
X-Received: by 2002:a05:622a:393:b0:4e8:bab2:9e0b with SMTP id d75a77b69052e-4e8bab2a3d8mr229158211cf.77.1761215156957;
        Thu, 23 Oct 2025 03:25:56 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c427f77bsm92220685e9.3.2025.10.23.03.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 03:25:56 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        Stable@vger.kernel.org, Martino Facchin <m.facchin@arduino.cc>,
        Alexey Klimov <alexey.klimov@linaro.org>
Subject: [PATCH v2 02/20] ASoC: qcom: q6adm: the the copp device only during last instance
Date: Thu, 23 Oct 2025 11:24:26 +0100
Message-ID: <20251023102444.88158-3-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023102444.88158-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20251023102444.88158-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: CuA0yT3iBPufvfXRxNNUFMEo22d3SkOy
X-Proofpoint-GUID: CuA0yT3iBPufvfXRxNNUFMEo22d3SkOy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDE2NCBTYWx0ZWRfX5T054oLJbL3W
 5jESkhDaCDpS/GtLfA6f4sXFQg2R28i5bl3/CBcPlxfA7atC15SqU4ehOSMCZqiRqwTz3MhLD+V
 CMEII+qH8UxC81AguJYemHLM48ZaJCsNz9SwT9Y+773/IPqwrZ320MnlaqSFJrK1TZncUjzWaJh
 Bn64SiNrLi1sBK7EW2gZOZmCyMubnNFHpfg9cGBlHioW5EkKDLhA8yK4wSR2BMzisr7F6kerV+N
 zpoFdDd8V8/zf6pJNDnTJnPP6nuc20JwB55wbOEdrx2ylGjxHLEGlQYqP4Lw9w/QFvjicNw9atK
 XDHVCLRXdWLnfCjvnAzDLtI8oU3f58s2PE++KA2EyP57XMjT1h/2gz4+S7nXFi/n1/mMKjLBF6Y
 u9KnYstczfLSrXA1zd8bGUc3HRuIIA==
X-Authority-Analysis: v=2.4 cv=UOTQ3Sfy c=1 sm=1 tr=0 ts=68fa02b6 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=KKAkSRfTAAAA:8 a=LQLTnAVHjxzgEifUwDEA:9 a=uxP6HrT_eTzRwkO_Te1X:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510220164

A matching Common object post processing instance is normally resused
across multiple streams. However currently we close this on DSP
even though there is a refcount on this copp object, this can result in
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
Tested-by: Alexey Klimov <alexey.klimov@linaro.org> # RB5, RB3
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


