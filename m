Return-Path: <linux-kernel+bounces-781623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C46B314B1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C275AA016D5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 10:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC08F2D8DCE;
	Fri, 22 Aug 2025 10:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XXbmBnsf"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F682D7DC2
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755856855; cv=none; b=cXuH5b4BdLzNJKeB7RHYc/qmxnZ+2ykFPl+WIxGb7PV4T17PKzom6bokHhiWN6MCv0t5mCU+dghsqqaKYTAh2/3FpS2fCAIwxxI6W37GUI1XHY9t0AIC6o0Ca5QDqwdwCuZ3UB7DajVNI8I6H1nPhHzi63eLDO/rk9FpbkM7BAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755856855; c=relaxed/simple;
	bh=pEetoVTDodelXBwJrt38dostCVJshVjnFzOU+XhTBjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hwxr9Nv41J4Cpzu3e+4BvhJTIxoLzdZzz8IOWQTPoRW9lYChovXaXTaobEU0nL2pjUQ9xH74DJ938h9CNlRc6Pt0Fz22iMO5rqjuQ7uF2LmPBWlIH3chXv4xDd4sz4CE33K0rETzDZP8mB5WL3tmzmPq07sycgxtcWg403w523A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XXbmBnsf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M8UIkK027205
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:00:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=seU5VyNwZ7P
	hzDSFhbvRs6XB3sWasRwy3GspI+Jm/Rs=; b=XXbmBnsfM/h5W2KrZFVAzKUJTZt
	Z1HMKDfhL73N9zmko0vHj4DE1/2uIFzyajQNaY7RJkexgDqKZEdsFUKTPKuhvwl3
	1/AEhJmtWvegV9k/5+aZGMENqlhZpy64KRB5DMW6ND7hZCogtvVl970NuOht1oy0
	v1qAfTosPJv0JFEkiEZjiEyUTJ+bY4CFgCktnLoq3f3xslGRIycWxok31ThipGaT
	8fpvK/MzZ71t6SxePnGQM2FnTISo0FEg9zpdoQfPBEQB+a3rlqLucSmi/oHagUuN
	LoFkWa3gdUAr2IN0NdPOcK5R7zQ6YWl2zHo1H2iE6frDXdvioiw738goV1A==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n5298tds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:00:53 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b109bc103bso46292101cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 03:00:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755856852; x=1756461652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=seU5VyNwZ7PhzDSFhbvRs6XB3sWasRwy3GspI+Jm/Rs=;
        b=jK6ivaOMhTtqjG5SO4YaaQkjL8R5aJkG0cBB/frClL/0ozGVkH9dtkmf3dWEtbn1Q+
         n8opT1Nltj+f01X4ykZpnc/XxA3mPIpHVdVDpDpdUUYlZhTC/f/SYQjsVPZMtlkz6UfA
         AsdCBfMnWKAhEKAAUIkDLEbW72Sp9H67UKBH3OxYKmMl7iVknNujObpiiQvHJUMy/Wh0
         0DgiMtzpJhg6x0yqoL69dvH+3ubWgntcTWFxOLbi57c/tRLAHN5XkX3DoaU+12/kR1Sb
         mmFxALdXVRFVcT+UBX64F7LnsFy3I8FAed2qSf7T9aajJxVHlCoa0dRfxxfXcUk0g07O
         iZ4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVrYqLPtU+w4wUetIjtyzKZQ7pOPbwkXLSqVdB9MPw273TFsmUuICK3wF+1SWosOzTiHKrV7IsiehZNMMU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvch3OOoVB50SRTgxL4SBuwGDZLGDEY8vy5znUF8StMeN/sq2s
	bG05xbRnoBYaZ67FQW2SvYjXheean+9U4T7ytBNd0LITKhf15o4FQ3Z4pWlTPqtet1OKdwPXYti
	IFcNKvVnBZtBFYGZ7MvYux2qqk8HUrbxMiyQXqyfNGdgtnFafleNYpJqQcNEScM7Q23I=
X-Gm-Gg: ASbGncvb1mJcWzBbZRJGKwa+6OHi2IpGPfD6lLTgLPcEetUCgTSjjBmJ9WR2rKsjWTv
	zDyug5boOou28vIch6tPeCI4RfGEquDMQXL+Wb8cqngg1atr7fPfW3C1vP2Axw6yBcVGW0LlAoy
	zFW9HJN3IwMrzhdiMZFnKUXvach4KfNHpcnSAxRKTLUxood8WpSXxmvVFr7yNW3mvAA+US6umIf
	UIZDVnidcawfzOHovPU59olZ7OqWQ+v3LnX11kWx4YNvVgcvbF34aikCtQtGd+oAQ6ERYUj4wUE
	N+ypdfxBOWDMO7H3JDaGyEihpl9cYu9DRcLxiHzCubRv5H4X464FyA==
X-Received: by 2002:a05:622a:1cc9:b0:4b2:94a7:217b with SMTP id d75a77b69052e-4b2aaa599d7mr28342501cf.37.1755856852127;
        Fri, 22 Aug 2025 03:00:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTI6SJSLk1AF3i7MxH2gUf6ex3W/Wf5mKpRmzSeB4ddoFBiT2mWoh4+lF7VcoIx6vuIho8PA==
X-Received: by 2002:a05:622a:1cc9:b0:4b2:94a7:217b with SMTP id d75a77b69052e-4b2aaa599d7mr28341801cf.37.1755856851491;
        Fri, 22 Aug 2025 03:00:51 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c0748797a1sm14184608f8f.5.2025.08.22.03.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 03:00:51 -0700 (PDT)
From: srinivas.kandagatla@oss.qualcomm.com
To: andersson@kernel.org
Cc: mathieu.poirier@linaro.org, srichara@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH 2/2] rpmsg: glink_native: remove duplicate code for rpmsg device remove
Date: Fri, 22 Aug 2025 11:00:43 +0100
Message-ID: <20250822100043.2604794-3-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250822100043.2604794-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20250822100043.2604794-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ZJKOWX7b c=1 sm=1 tr=0 ts=68a83fd5 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=9_ireLxDWfKNmGTEU-MA:9
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: -7Bk7mslw4cGOrjP8drkvKIbO_IDoa17
X-Proofpoint-GUID: -7Bk7mslw4cGOrjP8drkvKIbO_IDoa17
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX3+DGMmDKaQQr
 0ijTJ0Yaug6UcDeWQTrT8v9nX3U+JvzsmYXLHW8AB4LwWnHzC5P0+HnX+C0R9ixsEX9y/smqIrX
 ygHc3FkxgWMC4iROoFVMtq54VwTGA9RIxT98tt+XcqSpEwVgXsE4NeTNDwq664ZVmEmdR8n2ZQm
 pu2jf9XV7YrSgfoz5RV2gbJecRIJnajv4X3VIWEtyu7p8bcooY3jPIaKL5ahTU1nqAsRFBlUrcC
 2Op8UF4hT/JdpwAl7JmzUM3nwkxXjpIS5k4ECluTkzkZWwJZNPjtlmSe5Vk4fJvaPeHBqn3i1Wf
 RoD4/o7bbe7R15v/Sg+iaY4Wp4y36kV9MWHlzPqHwna1Bx15Ie3MI7Mkm+1EnCqkvJkugewqvwY
 QGuZrTIdziXtQxUBBVPo5TUatYv9/w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>

rpmsg device remove code is duplicated in at-least 2-3 places, add a
helper function to remove this duplicated code.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 drivers/rpmsg/qcom_glink_native.c | 43 ++++++++++++-------------------
 1 file changed, 16 insertions(+), 27 deletions(-)

diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
index 3a15d9d10808..5ea096acc858 100644
--- a/drivers/rpmsg/qcom_glink_native.c
+++ b/drivers/rpmsg/qcom_glink_native.c
@@ -1395,11 +1395,23 @@ static int qcom_glink_announce_create(struct rpmsg_device *rpdev)
 	return 0;
 }
 
+static void qcom_glink_remove_rpmsg_device(struct qcom_glink *glink, struct glink_channel *channel)
+{
+	struct rpmsg_channel_info chinfo;
+
+	if (channel->rpdev) {
+		strscpy_pad(chinfo.name, channel->name, sizeof(chinfo.name));
+		chinfo.src = RPMSG_ADDR_ANY;
+		chinfo.dst = RPMSG_ADDR_ANY;
+		rpmsg_unregister_device(glink->dev, &chinfo);
+	}
+	channel->rpdev = NULL;
+}
+
 static void qcom_glink_destroy_ept(struct rpmsg_endpoint *ept)
 {
 	struct glink_channel *channel = to_glink_channel(ept);
 	struct qcom_glink *glink = channel->glink;
-	struct rpmsg_channel_info chinfo;
 	unsigned long flags;
 
 	spin_lock_irqsave(&channel->recv_lock, flags);
@@ -1407,14 +1419,7 @@ static void qcom_glink_destroy_ept(struct rpmsg_endpoint *ept)
 	spin_unlock_irqrestore(&channel->recv_lock, flags);
 
 	/* Decouple the potential rpdev from the channel */
-	if (channel->rpdev) {
-		strscpy_pad(chinfo.name, channel->name, sizeof(chinfo.name));
-		chinfo.src = RPMSG_ADDR_ANY;
-		chinfo.dst = RPMSG_ADDR_ANY;
-
-		rpmsg_unregister_device(glink->dev, &chinfo);
-	}
-	channel->rpdev = NULL;
+	qcom_glink_remove_rpmsg_device(glink, channel);
 
 	qcom_glink_send_close_req(glink, channel);
 }
@@ -1705,7 +1710,6 @@ static int qcom_glink_rx_open(struct qcom_glink *glink, unsigned int rcid,
 
 static void qcom_glink_rx_close(struct qcom_glink *glink, unsigned int rcid)
 {
-	struct rpmsg_channel_info chinfo;
 	struct glink_channel *channel;
 	unsigned long flags;
 
@@ -1721,14 +1725,7 @@ static void qcom_glink_rx_close(struct qcom_glink *glink, unsigned int rcid)
 	/* cancel pending rx_done work */
 	cancel_work_sync(&channel->intent_work);
 
-	if (channel->rpdev) {
-		strscpy_pad(chinfo.name, channel->name, sizeof(chinfo.name));
-		chinfo.src = RPMSG_ADDR_ANY;
-		chinfo.dst = RPMSG_ADDR_ANY;
-
-		rpmsg_unregister_device(glink->dev, &chinfo);
-	}
-	channel->rpdev = NULL;
+	qcom_glink_remove_rpmsg_device(glink, channel);
 
 	qcom_glink_send_close_ack(glink, channel);
 
@@ -1742,7 +1739,6 @@ static void qcom_glink_rx_close(struct qcom_glink *glink, unsigned int rcid)
 
 static void qcom_glink_rx_close_ack(struct qcom_glink *glink, unsigned int lcid)
 {
-	struct rpmsg_channel_info chinfo;
 	struct glink_channel *channel;
 	unsigned long flags;
 
@@ -1764,14 +1760,7 @@ static void qcom_glink_rx_close_ack(struct qcom_glink *glink, unsigned int lcid)
 	spin_unlock_irqrestore(&glink->idr_lock, flags);
 
 	/* Decouple the potential rpdev from the channel */
-	if (channel->rpdev) {
-		strscpy(chinfo.name, channel->name, sizeof(chinfo.name));
-		chinfo.src = RPMSG_ADDR_ANY;
-		chinfo.dst = RPMSG_ADDR_ANY;
-
-		rpmsg_unregister_device(glink->dev, &chinfo);
-	}
-	channel->rpdev = NULL;
+	qcom_glink_remove_rpmsg_device(glink, channel);
 
 	kref_put(&channel->refcount, qcom_glink_channel_release);
 }
-- 
2.50.0


