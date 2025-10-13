Return-Path: <linux-kernel+bounces-850299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D75BD2707
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 12:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BE273AA038
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 10:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484BC2FF170;
	Mon, 13 Oct 2025 10:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BGx9o1i2"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2782FE570
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 10:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760349838; cv=none; b=ra2eCX4YRr7GsnxS77O+2zupwtfozFcmM+xPa6FrJRue/GobzRwuxkaBaoFnA0zUhPCN3o5Q7OYCmOuOkYCTDYrzJUQEQS+IJ8fFBMWIjf4/9Xg4hwfuxgvBExBUdH8Vy7hId4Zi7kgezyYtsXVdm2X7fQrKrrrkMtN+tIMclr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760349838; c=relaxed/simple;
	bh=qlnKQpR9XMkuIHU7jVRAkxWNeLEevdVEEOE7IsDKmdQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MaX4Q1PF8Nzod1u5s1sYXFq5sPP2cyALTI3JCkm5qYJqfr8/SRTaIld57HdFxxUC3WMDbPRdmb3Rl99hCNdoFLK22ZI0Pw6PP2alTWsU/avXPO+kMVx0wLWNllKbrv6UbNxD+CCK+BKXVh9hyCFFTtm4uBJLylzmJZ4gugwTT7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BGx9o1i2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59D2n5cI021339
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 10:03:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YdqLvZzp+hfRMVruwUYM4SO9FfOBaWkR9O/GPpEbBMQ=; b=BGx9o1i2WF52Lbef
	zFpw8y+Smlfx/MWRlDU/0T0+/63hbUy/tDFP/z5OgeAjFpUlvUyXoncvoiF+EGqx
	k0BxqEQq2DDGQOb/8rz8oRu8+9+DiUvlqXv+qPdbwgPQ5urwQM/I/m9Qm/RbJJHn
	ftiaFxqUHcz1EnY2uontTSS90yntI8f8drohWsdPgKgtpsKYVG9OdIGPGRDfohnW
	y7vnka5STvUO9ZvQ/+3oGYB5mCvY6HDYXrwrtLHe6Vv39i9XRNr7XSbHK+lp9a0+
	yWhc5GJvxOOe4atjowWKjSdIsuQFDol6nGFtYHNKMo9WxIg2TkYTcKGLjDm+MNEH
	5NYsFw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qgh642wv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 10:03:56 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b62ebb4e7c7so7567701a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 03:03:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760349835; x=1760954635;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YdqLvZzp+hfRMVruwUYM4SO9FfOBaWkR9O/GPpEbBMQ=;
        b=LOtnSLkRNMjitQARsoYYtzB85X00Fyn9MGtwNyxinPoJWkRM7OPUIUFoGdy+lwetjn
         DlMd+9mLzB3WFV2EX5Ru5Xbf+TxjlWI7kE+2we/R5glUkxUK0ZZW6gaJtUwEOjkY5Usv
         lSb4imdnnlMFPvwT5cfdeOCJBSmHUxYpPQ7ZzEeF10lM4epJVD2Svhs51ufFSu/h1MHe
         Bb7GNXnmKts4BJTPAGTBp5qtd0uveSKTZba9LPiiV/Ug03Ql0j/UrHwUtZafhKtRgIL9
         H6f3szX/5uE5VwYde6ll0/x1P33+w6juGytGLWciCFXgNwe6rHwfa7Azb6fErib/nr9j
         mAgQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6xyNsOP0Rvii2jIdCwwfo4uetW0RgQ72owet6bwpDFaQROOeRy/7L6tBiJUUn7I5mkTnK/4bGdDQ8+H4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0ieS3JwLo1JyGlxqBVMLA4w5j/3wE8lHEPkRSOGQ5dNZcQk0a
	nnXyiuVqDv9kxZjQl4pFBdNhBkfanZo5+AZ4EKcA1sG+CumsB0upqTBlZWGl+I0IFobt2sc8/k8
	vKJiPKQHQoOtWtG6N848mHghgS6DWkQwTaqf1/2k2BMIXUYl2f+7np1E4zvj4uQzmIgk=
X-Gm-Gg: ASbGncvo1O8uMsS9VdFmvYVebPuWOiduwcRT6kCsVSk/rHHu7lMbWL9vdIrrWSMLasw
	TYWCWKCR3x1pCXaKKyebHxxwRAQrps+9UgOhDKKhWnxXl1h0srVjC9J/tiBxlxoh7GjEqxd6nLw
	buQFfRcH5sqdzAN9luw7aXoQlZQ6FHTU4IHyGvY2cwaSGIPqRFQ04Tul5JnYo4a/GnhR9uzhwps
	ybirejlo69Cbfa0wMM46/mOmFlWpZxUl6/eMsrKXtJKpOQEnFu7GSr3Q+bz9GWF59PKhhMKdZsH
	5XBBfXbecjHWgmwsGI2xPMSYZQCfK4fVbE2QoSMxCTh3bgDNjD1Jp67F0QkaYstvHU4=
X-Received: by 2002:a05:6a20:a123:b0:243:d1bd:fbc9 with SMTP id adf61e73a8af0-32da8462b41mr28759311637.56.1760349835067;
        Mon, 13 Oct 2025 03:03:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKgu+FemSBu8RrZ1WtJ87I/o9LoZ8OD0IjWwcaAZ3GUBHLjS5ZeGD/3Xc2aayoi1D19MMPEQ==
X-Received: by 2002:a05:6a20:a123:b0:243:d1bd:fbc9 with SMTP id adf61e73a8af0-32da8462b41mr28759265637.56.1760349834457;
        Mon, 13 Oct 2025 03:03:54 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d5b8672sm10981657b3a.69.2025.10.13.03.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 03:03:54 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Date: Mon, 13 Oct 2025 15:33:07 +0530
Subject: [PATCH v5 03/13] firmware: qcom_scm: Introduce PAS context
 initialization helper function
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-kvm_rprocv5-v5-3-d609ed766061@oss.qualcomm.com>
References: <20251013-kvm_rprocv5-v5-0-d609ed766061@oss.qualcomm.com>
In-Reply-To: <20251013-kvm_rprocv5-v5-0-d609ed766061@oss.qualcomm.com>
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
X-Mailer: b4 0.14-dev-f7c49
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760349819; l=3912;
 i=mukesh.ojha@oss.qualcomm.com; s=20250708; h=from:subject:message-id;
 bh=qlnKQpR9XMkuIHU7jVRAkxWNeLEevdVEEOE7IsDKmdQ=;
 b=p8eHK1Ps27H1LZV7UpUYLGH266ZyVCCgakB7mn+oVap3QY8lQWVqmGAAnF8ZT/CkdHn6McgXP
 XS1UgPLGspiDmncTzFFxbkMgQuMJo+GUV+3jSWplu20TPPAjmYiMyBX
X-Developer-Key: i=mukesh.ojha@oss.qualcomm.com; a=ed25519;
 pk=eX8dr/7d4HJz/HEXZIpe3c+Ukopa/wZmxH+5YV3gdNc=
X-Authority-Analysis: v=2.4 cv=H/zWAuYi c=1 sm=1 tr=0 ts=68ecce8c cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=bwjbfaRo76XlwD4G3ScA:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyNiBTYWx0ZWRfX82qSxIdWDq5Z
 +Y+jPnHCexhVevkPQEvk0VxEdsyJXgU0TK23y6MAtF+j4NgnKdIZeV8Gy0x5Jwmnpm5IinIOPLB
 hMjf0O+DJt4dKMAg3URxBdboe4Di1FK0JtbHtY9Jaa/OAEX0rIlildjh9tI/mWMHrJ2ZD/78pPg
 y38hnEN/RY1hMjricNwZyeV+/lIqcrhQoNEBc/Y5I3S8XMEro7LMkwaVuNrWqWasIcCZLOz8aip
 fm3tkNiK7GbasdEkf/MFeUOmzP6EZBfRPCzBx3xREKv8s+wPSH/erm22ZYCLpl1Jh5rdisluMrn
 4lVZBuf6KhBwczGRHTXJgQXzCZZ6xOOJNQuoiW3Zynev+rSkg9crrb6VDF+aNqZ89lWHFLOrSSe
 ZNMZCKtyX5CaeKK2mZpKlEduSiZgBQ==
X-Proofpoint-ORIG-GUID: uORSaS_Os8TnoKi6ztCLu3wQ8XeuvgyF
X-Proofpoint-GUID: uORSaS_Os8TnoKi6ztCLu3wQ8XeuvgyF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110026

When the Peripheral Authentication Service (PAS) method runs on a SoC
where Linux operates at EL2 (i.e., without the Gunyah hypervisor), the
reset sequences are handled by TrustZone. In such cases, Linux must
perform additional steps before invoking PAS SMC calls, such as creating
a SHM bridge. Therefore, PAS SMC calls require awareness and handling of
these additional steps when Linux runs at EL2.

To support this, there is a need for a data structure that can be
initialized prior to invoking any SMC or MDT functions. This structure
allows those functions to determine whether they are operating in the
presence or absence of the Gunyah hypervisor and behave accordingly.

Currently, remoteproc and non-remoteproc subsystems use different
variants of the MDT loader helper API, primarily due to differences in
metadata context handling. Remoteproc subsystems retain the metadata
context until authentication and reset are completed, while
non-remoteproc subsystems (e.g., video, graphics, IPA, etc.) do not
retain the metadata context and can free it within the
qcom_scm_pas_init() call by passing a NULL context parameter and due to
these differences, it is not possible to extend metadata context
handling to support remoteproc and non remoteproc subsystem use PAS
operations, when Linux operates at EL2.

Add PAS context data structure and initialization helper function.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/firmware/qcom/qcom_scm.c       | 33 +++++++++++++++++++++++++++++++++
 include/linux/firmware/qcom/qcom_scm.h | 10 ++++++++++
 2 files changed, 43 insertions(+)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 3379607eaf94..6d22b2ac7880 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -558,6 +558,39 @@ static void qcom_scm_set_download_mode(u32 dload_mode)
 		dev_err(__scm->dev, "failed to set download mode: %d\n", ret);
 }
 
+/**
+ * qcom_scm_pas_context_init() - Initialize peripheral authentication service
+ *				 context for a given peripheral
+ *
+ * @dev:	  PAS firmware device
+ * @pas_id:	  peripheral authentication service id
+ * @mem_phys:	  Subsystem reserve memory start address
+ * @mem_size:	  Subsystem reserve memory size
+ *
+ * Upon successful, returns the PAS context or ERR_PTR() of the error otherwise.
+ */
+void *qcom_scm_pas_context_init(struct device *dev, u32 pas_id, phys_addr_t mem_phys,
+				size_t mem_size)
+{
+	struct qcom_scm_pas_context *ctx;
+
+	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return ERR_PTR(-ENOMEM);
+
+	ctx->dev = dev;
+	ctx->pas_id = pas_id;
+	ctx->mem_phys = mem_phys;
+	ctx->mem_size = mem_size;
+
+	ctx->metadata = devm_kzalloc(dev, sizeof(*ctx->metadata), GFP_KERNEL);
+	if (!ctx->metadata)
+		return ERR_PTR(-ENOMEM);
+
+	return ctx;
+}
+EXPORT_SYMBOL_GPL(qcom_scm_pas_context_init);
+
 /**
  * qcom_scm_pas_init_image() - Initialize peripheral authentication service
  *			       state machine for a given peripheral, using the
diff --git a/include/linux/firmware/qcom/qcom_scm.h b/include/linux/firmware/qcom/qcom_scm.h
index a13f703b16cd..75dec515c5d2 100644
--- a/include/linux/firmware/qcom/qcom_scm.h
+++ b/include/linux/firmware/qcom/qcom_scm.h
@@ -72,6 +72,16 @@ struct qcom_scm_pas_metadata {
 	ssize_t size;
 };
 
+struct qcom_scm_pas_context {
+	struct device *dev;
+	u32 pas_id;
+	phys_addr_t mem_phys;
+	size_t mem_size;
+	struct qcom_scm_pas_metadata *metadata;
+};
+
+void *qcom_scm_pas_context_init(struct device *dev, u32 pas_id, phys_addr_t mem_phys,
+				size_t mem_size);
 int qcom_scm_pas_init_image(u32 pas_id, const void *metadata, size_t size,
 			    struct qcom_scm_pas_metadata *ctx);
 void qcom_scm_pas_metadata_release(struct qcom_scm_pas_metadata *ctx);

-- 
2.50.1


