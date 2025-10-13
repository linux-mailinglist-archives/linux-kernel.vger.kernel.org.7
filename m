Return-Path: <linux-kernel+bounces-849974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DF81ABD1834
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 07:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F32A84EB1A2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 05:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5DE2DF706;
	Mon, 13 Oct 2025 05:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QdWPfY6W"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F112DEA7A
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 05:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760334588; cv=none; b=QjK9fSg8gTOz89lGAdiL48l2+Ybk8oSJ2WddUOW2QCxvwU9pMWbVeLaGs9ruBlMbY8cL4hfiCV2uC9FPICRT+jZnqCxI8TrA2n4/5kbyn6bKv0dX8/jH9Fd4iMVFxJvj41PFV2oRlRf8cSNY2lhJpk2L1xbkgwu3yAwWMhVTow0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760334588; c=relaxed/simple;
	bh=TNF6l0ahOzbwrs5of0KBvmnTCNoj347m7R5JdZkuHQo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ft+Hcs4YqhBy7rz2J73KPP0JlESgMtz5u1TkskQDKrGTyK2om9Ik8Ecp9Aig+l6h7kb1nQ5XC+ahzel8Sa4VY+Ju7cvVzeABTyYKasguH6qGHuX/Wp87MrKFPK019COh45VY6v2MCDejN0I8xfqwZdH4gqO1fOY0QDjH4K4AjPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QdWPfY6W; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59D2nEr9011036
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 05:49:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DeeXfQmF8BPY/Rrm9uGgR/SHD9DlxJ2y7BO/a91fj7Y=; b=QdWPfY6WJ1hpiq5o
	wogpTE47+bgJE3v3KXHoaOO0lKnzQmTlmpHwX79mcPVuVGYr2DN511iaifwM0eXc
	Qfoj2MaNjTAc9GmdEtAw7s9XYgMY6pTbIp8ydMW0DDmK2P+2cHBf9XerSHNGiwVZ
	tn2u+36CyYH4ymcF+EEN69rSwUo9AOPRDzUfq7oHOv7+nXeRWrcROKpltML31G1o
	NtRenOdIpuOQJHbVLkkKN+bwOCtQcnVKy1kdE2Glnc7s93tG82NHE/QmYCCflZ0l
	cfJg/a99jGVmmyAyX6O7pazwPNNthy8DlsN/+eehgn/9rKMelYca/6OUPaAvrH+n
	3AR3ng==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qg0buas9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 05:49:46 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b6097ca315bso12553789a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 22:49:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760334585; x=1760939385;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DeeXfQmF8BPY/Rrm9uGgR/SHD9DlxJ2y7BO/a91fj7Y=;
        b=SoWeS0EeCLdu6iFZtknxPIv8KVUop3kyd1wfAOXqN21eV4+RxL6xNgU14syDcHRVGl
         Y2d1NylerStfBOqrvriNBRPbOHPbE7Ww0/erNjy+QI8tNr+wt1CYiIyUSptr9MFtXbmG
         TCWWGUGwuHdcFPNM+fGL9EIOqM5tEqDqdQV88UFe4tTKLmUeW8ppPjMwgAOTeJ6adRNJ
         /E4EsY44SVPEOR0dm3iRDgwHgRxFjwID8zU+M7S/uCRiPGJWtu5Q0s0kWfulItnAnca/
         wm6VYTixj67yHeIW+3V11GyTnXTUO0iJdN39+geueGd30FLNp9oeYLeaOh+ZwvYIeTcy
         QWvQ==
X-Forwarded-Encrypted: i=1; AJvYcCW64abcGOQkpIZ4UZaDYkM6zm49MYN7GZphvLdFeE5kiZ/nApvnql3b64nJFyZFNO42b49CHA+/IYNe8gE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1yAvhqGCntcAQu56YrNU9MPFFGnx4dJsxQtv6BAEJ6DekQLIU
	nMV08kKLjtlt0qc/zkQiyTBYLMrhuWq2ji4zr8Xk3TTKAEQ7rZY58w8IoOHKWcxYyO0dZ6EmnOg
	RqSl7Hr4hVfBuidYyIw/64ZwdC+9N6WV/M774w6u/oNToqKUzaBD+1knpkpGf19FM8Ms=
X-Gm-Gg: ASbGnct2D1lhw+1InMTy0P9VMG4JNhX9jAGwjrG43WsaR44aiBrWxXEIFiJlmPSNXAQ
	UfCd7ntbNwrGwLYlpcmOnnQt4xIj67RK4ZIeFmVQHGgk+44Yr4F9dwtNIBRr9LKftdp1YVbS2LA
	qHNh5qabygOHo7JGiPjzhNBJatWhTELXcSvJdR/auMUK2h0G28CD8xfa1yqjjp24vw7dj9wdoTV
	FH3W0H8H0D+yNhy9H1/MEW+VYnLTJTlr5iscBKAAugPfGk++W4ov+exxEQMvtAILAXVL/vLnCo5
	6RsvT1MkeisriXVParOn+Sun9P4ruUE33HniQbPUUdIfBewc5f2SiyN+SpA8SfBgiRQIva2JLbl
	dnL4uthje+CDqEG+j/GPsGFp+L4E=
X-Received: by 2002:a05:6a20:72a0:b0:308:60dc:921b with SMTP id adf61e73a8af0-32da845e6d1mr29695081637.40.1760334585336;
        Sun, 12 Oct 2025 22:49:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVkjFqXs8bvUpUlp8Y+og5WHqeIfUqxH8cxjvddLFNSJXsysOI+7Y6qqFqb0ax99cu7rPxfg==
X-Received: by 2002:a05:6a20:72a0:b0:308:60dc:921b with SMTP id adf61e73a8af0-32da845e6d1mr29695057637.40.1760334584857;
        Sun, 12 Oct 2025 22:49:44 -0700 (PDT)
Received: from jiegan-gv.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d0e1336sm10129898b3a.59.2025.10.12.22.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 22:49:44 -0700 (PDT)
From: Jie Gan <jie.gan@oss.qualcomm.com>
Date: Mon, 13 Oct 2025 13:49:11 +0800
Subject: [PATCH v7 2/9] coresight: core: add a new API to retrieve the
 helper device
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-enable-byte-cntr-for-ctcu-v7-2-e1e8f41e15dd@oss.qualcomm.com>
References: <20251013-enable-byte-cntr-for-ctcu-v7-0-e1e8f41e15dd@oss.qualcomm.com>
In-Reply-To: <20251013-enable-byte-cntr-for-ctcu-v7-0-e1e8f41e15dd@oss.qualcomm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>,
        Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>,
        Mao Jinlong <jinlong.mao@oss.qualcomm.com>,
        Jie Gan <quic_jiegan@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, Jie Gan <jie.gan@oss.qualcomm.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760334567; l=2649;
 i=jie.gan@oss.qualcomm.com; s=20250909; h=from:subject:message-id;
 bh=TNF6l0ahOzbwrs5of0KBvmnTCNoj347m7R5JdZkuHQo=;
 b=PHSldDPpoF/wpmvV2sLnTsJX+MgzplFa6X/gwHk2llThVTACGdXyUFYe+8TWszelXY/cUPzgc
 9cthysiLb/+B9DfJ5rLuaaPKY10Q01WdXFkMX8moHxvcqRGw72C+A5s
X-Developer-Key: i=jie.gan@oss.qualcomm.com; a=ed25519;
 pk=3LxxUZRPCNkvPDlWOvXfJNqNO4SfGdy3eghMb8puHuk=
X-Proofpoint-GUID: aCVRABXvDmWBFTkXiaPAjK8uwBWEPCVT
X-Proofpoint-ORIG-GUID: aCVRABXvDmWBFTkXiaPAjK8uwBWEPCVT
X-Authority-Analysis: v=2.4 cv=eaIwvrEH c=1 sm=1 tr=0 ts=68ec92fa cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=WErVAGsNQcrMbPXGsVkA:9 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyMiBTYWx0ZWRfX3C2fyDXDXbMx
 NwQXXbu4Xj3cBwNMXWME3caJACQ2yGAWIb3RC10FNO5laTk1GXm0T3dY3Ci9IjmTxHrEpvAov9t
 PqEqH40Xo/fRD3R5Mq+k3kDhwdr5FeYovgPF+l77ZEHtcyfj2pxjgESD5YysuoaXrA0oOWZlDys
 3Hl5uzBCv5tRmuspowzsxcliFve0r6QRMtKbgnGwaJ157On68oYq48mTkgRPpguXKMpWSjJf1mR
 qLjloZyqdya32izyublc2QPE32C4/C2LdPXPTNHUPxPcLXFiTzpkoFcx8TdnYSetGVie3+PeNwU
 xU0F59aulUww63rkMAtPtoUPbrfMyw445MRnFgRZX1F6DMsPjwU9QmTBfLTUeuDvtUHEmnRT0nM
 6Cn+YSJhXEpixUVtLCKK4kjZl9mvRw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 spamscore=0 impostorscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110022

Retrieving the helper device of the specific coresight device based on
its helper_subtype because a single coresight device may has multiple types
of the helper devices.

Reviewed-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
---
 drivers/hwtracing/coresight/coresight-core.c | 35 ++++++++++++++++++++++++++++
 drivers/hwtracing/coresight/coresight-priv.h |  2 ++
 2 files changed, 37 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index eb6870425abc..27d306b23260 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -581,6 +581,41 @@ struct coresight_device *coresight_get_sink(struct coresight_path *path)
 }
 EXPORT_SYMBOL_GPL(coresight_get_sink);
 
+/**
+ * coresight_get_helper: find the helper device of the assigned csdev.
+ *
+ * @csdev: The csdev the helper device is conntected to.
+ * @type:  helper_subtype of the expected helper device.
+ *
+ * Retrieve the helper device for the specific csdev based on its
+ * helper_subtype.
+ *
+ * Return: the helper's csdev upon success or NULL for fail.
+ */
+struct coresight_device *coresight_get_helper(struct coresight_device *csdev,
+					      int type)
+{
+	int i;
+	struct coresight_device *helper;
+
+	/* protect the connections */
+	mutex_lock(&coresight_mutex);
+	for (i = 0; i < csdev->pdata->nr_outconns; ++i) {
+		helper = csdev->pdata->out_conns[i]->dest_dev;
+		if (!helper || !coresight_is_helper(helper))
+			continue;
+
+		if (helper->subtype.helper_subtype == type) {
+			mutex_unlock(&coresight_mutex);
+			return helper;
+		}
+	}
+	mutex_unlock(&coresight_mutex);
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(coresight_get_helper);
+
 /**
  * coresight_get_in_port_dest: get the in-port number of the dest device
  * that is connected to the src device.
diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index e51b22b8ebde..f80122827934 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -158,6 +158,8 @@ void coresight_path_assign_trace_id(struct coresight_path *path,
 				   enum cs_mode mode);
 int coresight_get_in_port_dest(struct coresight_device *src,
 			       struct coresight_device *dest);
+struct coresight_device *coresight_get_helper(struct coresight_device *csdev,
+					      int type);
 
 #if IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM3X)
 int etm_readl_cp14(u32 off, unsigned int *val);

-- 
2.34.1


