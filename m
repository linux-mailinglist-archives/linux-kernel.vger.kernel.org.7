Return-Path: <linux-kernel+bounces-866703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 15165C0079F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 85D4E502EE8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3B430E829;
	Thu, 23 Oct 2025 10:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K6yzip0L"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8D62EAD10
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761215175; cv=none; b=X2ZXuRCBz0+n+TGWSN3EKCCotbpfw+z4lDAVFjrrHOJQH+Hw1dVCbThPzsRTo5EwOk6hMMCj7I6ELHbmQobyM9UG3OILxhmBHuSCEyoywD4Wm6GDUq5XbJBgb6glShrVxCn+nD1/mpL5GUz1gvQObpuvmWU7qsfb64dKhRis2wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761215175; c=relaxed/simple;
	bh=bilYqDTijOVI3Ym7tdbxk/7Oij4S7gx62HEm/BQXlfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=khy8C+8spEjnM5oDXbv3j1a6i1Tm05hj0w42yo/hrF9TXOe4itK0dR5aWLGFIVqHSG5Ws9KrYnqsg16iw15LLgd1S8G1AcLFB+h98hBhdPZHKYADLbq5JBRVwvV7fKhMDq3FnNc1ZJwK8ORcGP97eFq+pG8Ej+n4KSsPCpfUZFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K6yzip0L; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N6vhbY029699
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:26:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Q/jUAXEKNOQ
	5BE1XPscr9ID7DIaSGQKQv9C4H2dtDd4=; b=K6yzip0LtOg/vBX4h04eN0SVE1K
	6TYB/ZgJLcSFk24PlAX0oyfiBnKBJ3lTbZwBTd2DLUwVQZdxMa7VkE3uyiBE4nTe
	2sdMvHz8q6KySEQL/Tdypx0+3OHOAyV6OJ+d37j8+INTfQtKucxBLH5qW+DGJ1Pi
	Eu0FS2nXbKN6E5iO9j+WJAasHFG38NoJrbtSFU0wujldzmumMw81ADnCabo0zjV1
	7VCZQyD9lveQqjGpHE0BAW/sQsYhDSbdBNv3Sc/Dy7sijq+7FgifQ3d/qsi9PYKf
	F0Ta+LmwWRrk7htjMog9ofgNKV2GthyFvc43c31KnQvZBJ0thGS9eoAlmpw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v2ge80ku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:26:11 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4e89f4a502cso19060571cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 03:26:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761215170; x=1761819970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q/jUAXEKNOQ5BE1XPscr9ID7DIaSGQKQv9C4H2dtDd4=;
        b=Oo3i+KXzP4yCefmIOVGPXLQX3mQkBeP7JvIc+6YKBdWgVbzdSYVItIJS0sJAHZzPIL
         LPhUXOEPc9vpugDsxvnh+MWBbTrfwiJTjdc1o5VYVoRmij9DyqJhfwtR0jelRhvxaIaq
         qiRQblyAvQtwxuiGJJoGwD3Q37rRU+H2ViDgari1dpcSMkYVEwrmvR85uDW+tQcQhm67
         BKpl0b0mwGFVSLitjiQ5SW3BXxAy6TmkCVGzezkjDqnInAwkcZvdrCsCfSxCUDXcKGKf
         pGL88brc/NqbqtQ/r2aSzCoCiGl3Yl29FSVcTCkyxAnSUv5N1ITJHjETkEOsZiUZjtcd
         Dc6g==
X-Forwarded-Encrypted: i=1; AJvYcCVk5DoreWqySG1R/pMCxsfYOIKykhWOnJ4NiIpcWykiVFoFzVjLKB8fPWscuUPepYzbabg7LMWjNffHjHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqM8oPHl/BRyyBdxjNIyDlR3SKI30XthyXNP/Y0v2oC/V/6vJf
	PhMYeeu3/jiRojLm3yodmiQxcjNqN6OkRfJS2chHIY96iFvlGRF8Dwm5uy057q9RrDvZBbv3q7U
	dOpOhgoHxUW54r+LAGHwR54nH7O7a8feYbspArWhV2/mM5KFilHwVJN03bklc98tu5Nk=
X-Gm-Gg: ASbGncuRm3WW6hS74tktk6f4UbBWDCoAVBavgGaLlHSn5mSO03TtFsba/gkhXOX/vDW
	nu5OL2+Ph4YvSHOzisW7tuRp8Ad16gMj8yw8l1Qf13L4xMFli+pPwyKJhghymKDfK1mT38R5VMY
	ir4ZF12ILZL5AbS1Y3fryu0E1wAr1avhjE6OKQq5Ips3i53yMbD8xN7jSccPfmF0HJMH1TQsMeA
	qHmqxE9We9QTFmV4VvcEL3mQfM8A/L0d0WeR8XASVRzI2M++00FQYLHk1BhNT+JtRH8o5AvqLOr
	WIlGuFVMiWw11jqNjF9M/okVn8pfSXX0OduFD5ng4oBNgHuqVyXLgQ2ZYLMqbH7NSEOa/bXwUnJ
	EhfyUP5Mw/c9M
X-Received: by 2002:ac8:5792:0:b0:4e8:ac66:ee42 with SMTP id d75a77b69052e-4e8ac66f458mr252665491cf.27.1761215170464;
        Thu, 23 Oct 2025 03:26:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWFQYJgDTadBI0CLEt07gUG/hH7KmtA4wCHAIN4ey5J4mMmr8Q6aFMeRo7VX/EjbM4dYegVg==
X-Received: by 2002:ac8:5792:0:b0:4e8:ac66:ee42 with SMTP id d75a77b69052e-4e8ac66f458mr252665271cf.27.1761215169907;
        Thu, 23 Oct 2025 03:26:09 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c427f77bsm92220685e9.3.2025.10.23.03.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 03:26:09 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH v2 12/20] ASoc: qcom: q6adm: Use automatic cleanup of kfree()
Date: Thu, 23 Oct 2025 11:24:36 +0100
Message-ID: <20251023102444.88158-13-srinivas.kandagatla@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMCBTYWx0ZWRfX+EQOApvSITsx
 roQ8iwAlTP/yZvjiXDpP19RSpSO2Zu5GUvwZP1x/nICurQqaeuKMS9h34SJx7SKmpD6rNxa+yh7
 RUWRuJec1cN0+ZVcMG3gVtDGsnRhNQ9yD/5YkiR45cf7reRMTo+5LlhvErej69Xbuw88BikzwlV
 3Jr1zHNolu4DwlbuwMV2O/O6dgKYWyKZB3vLK/WQqAk9JRqrhU5NnlCqLZ1l/N0nN0UpOdMp/8X
 89ArnnN/jKEr8krnhGi7ROHIAcw5ESxIuaLsFVfgiJjyZQA/98Z1LWEeBcorHthwlFOgsuO7ViY
 5TNxYREimY36k6jwxWjYJEaPAnVv+KsMbEPzsY36m0B6DJHKFMGqc/fKPjiXMHiINq9FjxO2dWr
 qEyIwlZyyLAwkXcdw6eprNFfzX48iw==
X-Authority-Analysis: v=2.4 cv=KqFAGGWN c=1 sm=1 tr=0 ts=68fa02c3 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=EQMblWJGb8QQpEaKAwIA:9 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: 9e2XRP3oW9-AmIJRMpA15aUKyiNabD0U
X-Proofpoint-ORIG-GUID: 9e2XRP3oW9-AmIJRMpA15aUKyiNabD0U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 phishscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180020

Its common pattern in q6dsp code to allocate temporary buffer
to send gpr/apr packets and free at the function exit.
Now this can be simplified via __free(kfree) mechanism.

No functional changes.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 sound/soc/qcom/qdsp6/q6adm.c | 33 +++++++++------------------------
 1 file changed, 9 insertions(+), 24 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6adm.c b/sound/soc/qcom/qdsp6/q6adm.c
index 75a029a696ac..0b8d06ec8b26 100644
--- a/sound/soc/qcom/qdsp6/q6adm.c
+++ b/sound/soc/qcom/qdsp6/q6adm.c
@@ -330,11 +330,8 @@ static int q6adm_device_open(struct q6adm *adm, struct q6copp *copp,
 	struct q6adm_cmd_device_open_v5 *open;
 	int afe_port = q6afe_get_port_id(port_id);
 	struct apr_pkt *pkt;
-	void *p;
-	int ret, pkt_size;
-
-	pkt_size = APR_HDR_SIZE + sizeof(*open);
-	p = kzalloc(pkt_size, GFP_KERNEL);
+	int ret, pkt_size = APR_HDR_SIZE + sizeof(*open);
+	void *p __free(kfree) = kzalloc(pkt_size, GFP_KERNEL);
 	if (!p)
 		return -ENOMEM;
 
@@ -359,14 +356,9 @@ static int q6adm_device_open(struct q6adm *adm, struct q6copp *copp,
 	ret = q6dsp_map_channels(&open->dev_channel_mapping[0],
 				 channel_mode);
 	if (ret)
-		goto err;
-
-	ret = q6adm_apr_send_copp_pkt(adm, copp, pkt,
-				      ADM_CMDRSP_DEVICE_OPEN_V5);
+		return ret;
 
-err:
-	kfree(pkt);
-	return ret;
+	return q6adm_apr_send_copp_pkt(adm, copp, pkt, ADM_CMDRSP_DEVICE_OPEN_V5);
 }
 
 /**
@@ -469,15 +461,12 @@ int q6adm_matrix_map(struct device *dev, int path,
 	struct q6adm_session_map_node_v5 *node;
 	struct apr_pkt *pkt;
 	uint16_t *copps_list;
-	int pkt_size, ret, i, copp_idx;
-	void *matrix_map;
-	struct q6copp *copp;
-
+	int ret, i, copp_idx;
 	/* Assumes port_ids have already been validated during adm_open */
-	pkt_size = (APR_HDR_SIZE + sizeof(*route) +  sizeof(*node) +
+	struct q6copp *copp;
+	int pkt_size = (APR_HDR_SIZE + sizeof(*route) +  sizeof(*node) +
 		    (sizeof(uint32_t) * payload_map.num_copps));
-
-	matrix_map = kzalloc(pkt_size, GFP_KERNEL);
+	void *matrix_map __free(kfree) = kzalloc(pkt_size, GFP_KERNEL);
 	if (!matrix_map)
 		return -ENOMEM;
 
@@ -515,16 +504,13 @@ int q6adm_matrix_map(struct device *dev, int path,
 		if (port_idx < 0) {
 			dev_err(dev, "Invalid port_id %d\n",
 				payload_map.port_id[i]);
-			kfree(pkt);
 			return -EINVAL;
 		}
 		copp_idx = payload_map.copp_idx[i];
 
 		copp = q6adm_find_copp(adm, port_idx, copp_idx);
-		if (!copp) {
-			kfree(pkt);
+		if (!copp)
 			return -EINVAL;
-		}
 
 		copps_list[i] = copp->id;
 		kref_put(&copp->refcount, q6adm_free_copp);
@@ -557,7 +543,6 @@ int q6adm_matrix_map(struct device *dev, int path,
 
 fail_cmd:
 	mutex_unlock(&adm->lock);
-	kfree(pkt);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(q6adm_matrix_map);
-- 
2.51.0


