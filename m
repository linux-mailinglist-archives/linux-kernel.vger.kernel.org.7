Return-Path: <linux-kernel+bounces-873479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5EBC14041
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2607C4FF408
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FFD3043DC;
	Tue, 28 Oct 2025 10:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LmOQuYM8"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD839304982
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761646339; cv=none; b=Rm2bJ4U1diayczJm562tsrgR/p445w7n/42JhHNWvkiQeifhsnfCcErPHd8ivtKN2Q2pOFI5nEgaRJ0CRdi6mTk+H3LifgGd4ab4SUykmJ2h8kwT48BHLfwgcg3H0nFtGtcGJRgxTg/y/vkuntadqNV0SlgHxhVJJ/fgm8Jc9oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761646339; c=relaxed/simple;
	bh=d+wut6PeZQyP4Xb5PTssNu4tUmWnBmuxgzqkWyLc/Hg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZjrA30sbFNfRNkVXZNTSZCQAEozMX0SyLKr2OlyZAp/wVvoJa/g42zgsk/oZ6EIS6WUcn8YDvIaHbk52jPMQWN973irgoB6tMhroE48wtLstyfJz2+AiufN9gZaqqwrv+YBw13LD2VuFxCs5C0jPYcArfZy95sEeSXY6mquQUno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LmOQuYM8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59S45JiY573603
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:12:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7vsKdCIMSvSASYDlfsgGuMsHssqt5eihbBU78IN6eNQ=; b=LmOQuYM8CHkI7Sla
	/IYBUPd/E+1k+rG6zAEjt+hUOp/LTsWIweERHac2QczzdJ+ubsK+bIuvmpl2M8Yz
	MInu/dWDSpUVccD7NTzcX8s22X1cK+4wF2L1wk4c6HPLqxy/Vb/5T3GX6Qvqfwuy
	04Q/3P7rKb2hzZCmpHCXTwzTnR7HsuroR34gdVBd6vz/s2Zx9MIHFqPR1BxX/QHF
	D860Lt9EN6DbPCxfjZg2QHqJzgl7eZNojaYnTV63QOe+gVLCy3yf5m7AoseGnJm6
	XdXR9X9UAb1C40Ur6HPKYodWAfAIJWOpV+XmBlRvGvez+MOHRqCzzOpxcNmK4zoa
	wtjtnA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a2pge918h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:12:17 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-27c62320f16so57076315ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 03:12:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761646336; x=1762251136;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7vsKdCIMSvSASYDlfsgGuMsHssqt5eihbBU78IN6eNQ=;
        b=Gc4mmUWz007R69ae93xcmunaNcB/CfLiLTd/B+HbL8duIj9Iv1mjH0SLl6kQNlhyD+
         3fxzFBHNCqvUwiIRUsDIW9pFRbGGMSAbBWyP6z6qnVM2FcMyHe3d6FqJcJ87kLG5VNcd
         P4Xpslg8mlh9zZyDB8bKAwIFr2AFWWJumbLHATI1X4OdHgcxcrQcn9+lg3tSBunwHWvu
         /zBo/HV+bfPpUi3GGjCRY8PwOaLG9BIb7pUk0rw6FRmSQ/56W6chh7USej4GNEyrEbf7
         opBdi2rPzg9PHsmh+c6ziQDHI7At8c2mqwBIbLl5PKKeryEpHOof/ftY3WOZTzsrK3wo
         t5pw==
X-Forwarded-Encrypted: i=1; AJvYcCV8tS2brGZq9HNuJqBpWwK7X2ZMExpKJ7p6NvbcJa7JhTEeBkqN8CwxIH14fR2BqWMm1ewpJif/BfjquwM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww9c2PjBlOOFS2Knt7SrpE1jV53c3DD+eb9OoRPM1rBZFtfsGe
	WsOqllLo/FW2vElwD+DqvS5NzLxkHR6U2hi62p9yuBiTXtEajMslwHzHNkF4M4WMyoYowcMPURb
	moIQrKDzsAiDuN6X9EKZaGLV1hdFjwsx8y/GkKBfyVjGnl6cODOgiNLwxlhdpQulRGP0=
X-Gm-Gg: ASbGnctqS0Q5aFsinKIlwyC15/x759i02++WQ6uHkT9LjjmwUhZWGK6fB9XqNrzwpW6
	daxUC/kbV1ce3ij/W5YK+W7ILlAR+hjl4ZKI8Hkh1gxni5MvmmWeGSYP4ovaOnEkKfAqhLET8fH
	fMYWkfiYuaEkFCpQ/Blrx5hIxdmKF6H9SIea5HBOH6TxLeFv4KU+MexZYtj/OhWSCZTpKfZB8vn
	C/SlPRGzHWffYEJWOfqJDjWdZmKSZrBgbOpXpqNGe813FbDGUD4oZmX8y5cv4eA+oHJ/aNbCbG9
	wKcczTp9THHdj7BU84eEuG5LIwKyEuRrOjxaVDPlDeB9935Fksp5l+/HzBipSvN6CCUU87jtoaZ
	xVLRSD6O/6yZnbH9UkUusSp7+rP15fcG1n+BWbQPZAE8NIOMM7liPeGtcO6JL7A==
X-Received: by 2002:a17:902:c943:b0:293:623:3241 with SMTP id d9443c01a7336-294cb67555cmr36725235ad.58.1761646335749;
        Tue, 28 Oct 2025 03:12:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IET+G1GfBh6CkXZDTYNyw4YCgQx2Uee56q9DVneQ5cq6QXlimc4Ow0VbC7Lp0VS2Zg/MoZqYQ==
X-Received: by 2002:a17:902:c943:b0:293:623:3241 with SMTP id d9443c01a7336-294cb67555cmr36724585ad.58.1761646334820;
        Tue, 28 Oct 2025 03:12:14 -0700 (PDT)
Received: from jiegan-gv.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf423esm110408755ad.19.2025.10.28.03.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 03:12:14 -0700 (PDT)
From: Jie Gan <jie.gan@oss.qualcomm.com>
Date: Tue, 28 Oct 2025 18:11:41 +0800
Subject: [PATCH v4 2/3] coresight: tpdm: add static tpdm support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-add_static_tpdm_support-v4-2-84e21b98e727@oss.qualcomm.com>
References: <20251028-add_static_tpdm_support-v4-0-84e21b98e727@oss.qualcomm.com>
In-Reply-To: <20251028-add_static_tpdm_support-v4-0-84e21b98e727@oss.qualcomm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>,
        Mao Jinlong <jinlong.mao@oss.qualcomm.com>,
        Tao Zhang <tao.zhang@oss.qualcomm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jie Gan <jie.gan@oss.qualcomm.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761646319; l=9643;
 i=jie.gan@oss.qualcomm.com; s=20250909; h=from:subject:message-id;
 bh=d+wut6PeZQyP4Xb5PTssNu4tUmWnBmuxgzqkWyLc/Hg=;
 b=4Uf/kdbo3Zkq6teckwE9ghcUj3/WynJQ0si39kQbA2u6lI9uGm3xmV4N1NIybwXr5vCxtw0vg
 CzCv2qdPlH6ANJjJsXAEijnVXzA2+K8THleM/rqmjO12uHh1mCfj3CQ
X-Developer-Key: i=jie.gan@oss.qualcomm.com; a=ed25519;
 pk=3LxxUZRPCNkvPDlWOvXfJNqNO4SfGdy3eghMb8puHuk=
X-Proofpoint-ORIG-GUID: IBbcSSldeMSF6CQGMymYeIAt09DpHZiG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDA4NSBTYWx0ZWRfXy2dgpleQWoDh
 Rsv0KHAbl42Yrb6pcpwoQaoSIOrfEweABJ8+Zuu4qJksqHvAZ0dcGjloOgdI/yMiOqIAnMWY4Fl
 nbyUSzUUZprkxfGkQ4YW+tOkCYQac1TYjm+iTQsvxvhwgJ8ZG2YUs9wqfLKS/xxJNDhyOzuicf1
 JrtlrRoy3/PKt1JG+ssrYFVcU+EAcPd23X2+gRhn3/5t4s4GnKnMxQizbm3/lQ1Y4t2WeWOQE3Y
 JzR9fMnlckY8dpHJNYT9+FMTOOm6RVOX2UiVdd0GiiDEFLo0R/eWytq1Xj7qAyWW0kFxnX8Dp0r
 XYj0w2Htm4Bnf20bEcRG6uiz5khlxEMbNzRQGCQ1Gh+uwMJvVpPztVblqgG8LaPt78miHJYfE59
 ZqwmKgB4VUpTKbaR2j9MWi92uTVKPA==
X-Proofpoint-GUID: IBbcSSldeMSF6CQGMymYeIAt09DpHZiG
X-Authority-Analysis: v=2.4 cv=fLU0HJae c=1 sm=1 tr=0 ts=69009701 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=0reUtR2WQOxYMfigi4QA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510020000
 definitions=main-2510280085

The static TPDM function as a dummy source, however, it is essential
to enable the port connected to the TPDA and configure the element size.
Without this, the TPDA cannot correctly receive trace data from the
static TPDM. Since the static TPDM does not require MMIO mapping to
access its registers, a clock controller is not mandatory for its
operation.

Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
---
 drivers/hwtracing/coresight/coresight-tpda.c |   7 --
 drivers/hwtracing/coresight/coresight-tpdm.c | 174 ++++++++++++++++++++++-----
 drivers/hwtracing/coresight/coresight-tpdm.h |  12 ++
 3 files changed, 154 insertions(+), 39 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tpda.c b/drivers/hwtracing/coresight/coresight-tpda.c
index 333b3cb23685..3a3825d27f86 100644
--- a/drivers/hwtracing/coresight/coresight-tpda.c
+++ b/drivers/hwtracing/coresight/coresight-tpda.c
@@ -22,13 +22,6 @@
 
 DEFINE_CORESIGHT_DEVLIST(tpda_devs, "tpda");
 
-static bool coresight_device_is_tpdm(struct coresight_device *csdev)
-{
-	return (coresight_is_device_source(csdev)) &&
-	       (csdev->subtype.source_subtype ==
-			CORESIGHT_DEV_SUBTYPE_SOURCE_TPDM);
-}
-
 static void tpda_clear_element_size(struct coresight_device *csdev)
 {
 	struct tpda_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
index 7214e65097ec..0e3896c12f07 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.c
+++ b/drivers/hwtracing/coresight/coresight-tpdm.c
@@ -470,6 +470,9 @@ static void tpdm_enable_cmb(struct tpdm_drvdata *drvdata)
  */
 static void __tpdm_enable(struct tpdm_drvdata *drvdata)
 {
+	if (coresight_is_static_tpdm(drvdata->csdev))
+		return;
+
 	CS_UNLOCK(drvdata->base);
 
 	tpdm_enable_dsb(drvdata);
@@ -532,6 +535,9 @@ static void tpdm_disable_cmb(struct tpdm_drvdata *drvdata)
 /* TPDM disable operations */
 static void __tpdm_disable(struct tpdm_drvdata *drvdata)
 {
+	if (coresight_is_static_tpdm(drvdata->csdev))
+		return;
+
 	CS_UNLOCK(drvdata->base);
 
 	tpdm_disable_dsb(drvdata);
@@ -595,6 +601,30 @@ static int tpdm_datasets_setup(struct tpdm_drvdata *drvdata)
 	return 0;
 }
 
+static int static_tpdm_datasets_setup(struct tpdm_drvdata *drvdata, struct device *dev)
+{
+	/* setup datasets for static TPDM */
+	if (fwnode_property_present(dev->fwnode, "qcom,dsb-element-bits") &&
+	    (!drvdata->dsb)) {
+		drvdata->dsb = devm_kzalloc(drvdata->dev,
+						sizeof(*drvdata->dsb), GFP_KERNEL);
+
+		if (!drvdata->dsb)
+			return -ENOMEM;
+	}
+
+	if (fwnode_property_present(dev->fwnode, "qcom,cmb-element-bits") &&
+	    (!drvdata->cmb)) {
+		drvdata->cmb = devm_kzalloc(drvdata->dev,
+						sizeof(*drvdata->cmb), GFP_KERNEL);
+
+		if (!drvdata->cmb)
+			return -ENOMEM;
+	}
+
+	return 0;
+}
+
 static ssize_t reset_dataset_store(struct device *dev,
 				   struct device_attribute *attr,
 				   const char *buf,
@@ -1342,10 +1372,9 @@ static const struct attribute_group *tpdm_attr_grps[] = {
 	NULL,
 };
 
-static int tpdm_probe(struct amba_device *adev, const struct amba_id *id)
+static int tpdm_probe(struct device *dev, struct resource *res)
 {
 	void __iomem *base;
-	struct device *dev = &adev->dev;
 	struct coresight_platform_data *pdata;
 	struct tpdm_drvdata *drvdata;
 	struct coresight_desc desc = { 0 };
@@ -1354,32 +1383,37 @@ static int tpdm_probe(struct amba_device *adev, const struct amba_id *id)
 	pdata = coresight_get_platform_data(dev);
 	if (IS_ERR(pdata))
 		return PTR_ERR(pdata);
-	adev->dev.platform_data = pdata;
+	dev->platform_data = pdata;
 
 	/* driver data*/
 	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
 	if (!drvdata)
 		return -ENOMEM;
-	drvdata->dev = &adev->dev;
+	drvdata->dev = dev;
 	dev_set_drvdata(dev, drvdata);
 
-	base = devm_ioremap_resource(dev, &adev->res);
-	if (IS_ERR(base))
-		return PTR_ERR(base);
+	if (res) {
+		base = devm_ioremap_resource(dev, res);
+		if (IS_ERR(base))
+			return PTR_ERR(base);
 
-	drvdata->base = base;
+		drvdata->base = base;
+		ret = tpdm_datasets_setup(drvdata);
+		if (ret)
+			return ret;
 
-	ret = tpdm_datasets_setup(drvdata);
-	if (ret)
-		return ret;
-
-	if (drvdata && tpdm_has_dsb_dataset(drvdata))
-		of_property_read_u32(drvdata->dev->of_node,
-			   "qcom,dsb-msrs-num", &drvdata->dsb_msr_num);
+		if (drvdata && tpdm_has_dsb_dataset(drvdata))
+			of_property_read_u32(drvdata->dev->of_node,
+					     "qcom,dsb-msrs-num", &drvdata->dsb_msr_num);
 
-	if (drvdata && tpdm_has_cmb_dataset(drvdata))
-		of_property_read_u32(drvdata->dev->of_node,
-			   "qcom,cmb-msrs-num", &drvdata->cmb_msr_num);
+		if (drvdata && tpdm_has_cmb_dataset(drvdata))
+			of_property_read_u32(drvdata->dev->of_node,
+					     "qcom,cmb-msrs-num", &drvdata->cmb_msr_num);
+	} else {
+		ret = static_tpdm_datasets_setup(drvdata, dev);
+		if (ret)
+			return ret;
+	}
 
 	/* Set up coresight component description */
 	desc.name = coresight_alloc_device_name(&tpdm_devs, dev);
@@ -1388,34 +1422,51 @@ static int tpdm_probe(struct amba_device *adev, const struct amba_id *id)
 	desc.type = CORESIGHT_DEV_TYPE_SOURCE;
 	desc.subtype.source_subtype = CORESIGHT_DEV_SUBTYPE_SOURCE_TPDM;
 	desc.ops = &tpdm_cs_ops;
-	desc.pdata = adev->dev.platform_data;
-	desc.dev = &adev->dev;
+	desc.pdata = dev->platform_data;
+	desc.dev = dev;
 	desc.access = CSDEV_ACCESS_IOMEM(base);
-	desc.groups = tpdm_attr_grps;
+	if (res)
+		desc.groups = tpdm_attr_grps;
 	drvdata->csdev = coresight_register(&desc);
 	if (IS_ERR(drvdata->csdev))
 		return PTR_ERR(drvdata->csdev);
 
 	spin_lock_init(&drvdata->spinlock);
 
-	/* Decrease pm refcount when probe is done.*/
-	pm_runtime_put(&adev->dev);
-
 	return 0;
 }
 
-static void tpdm_remove(struct amba_device *adev)
+static int tpdm_remove(struct device *dev)
 {
-	struct tpdm_drvdata *drvdata = dev_get_drvdata(&adev->dev);
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev);
 
 	coresight_unregister(drvdata->csdev);
+
+	return 0;
+}
+
+static int dynamic_tpdm_probe(struct amba_device *adev,
+			      const struct amba_id *id)
+{
+	int ret;
+
+	ret = tpdm_probe(&adev->dev, &adev->res);
+	if (!ret)
+		pm_runtime_put(&adev->dev);
+
+	return ret;
+}
+
+static void dynamic_tpdm_remove(struct amba_device *adev)
+{
+	tpdm_remove(&adev->dev);
 }
 
 /*
  * Different TPDM has different periph id.
  * The difference is 0-7 bits' value. So ignore 0-7 bits.
  */
-static const struct amba_id tpdm_ids[] = {
+static const struct amba_id dynamic_tpdm_ids[] = {
 	{
 		.id	= 0x001f0e00,
 		.mask	= 0x00ffff00,
@@ -1423,17 +1474,76 @@ static const struct amba_id tpdm_ids[] = {
 	{ 0, 0, NULL },
 };
 
-static struct amba_driver tpdm_driver = {
+MODULE_DEVICE_TABLE(amba, dynamic_tpdm_ids);
+
+static struct amba_driver dynamic_tpdm_driver = {
 	.drv = {
 		.name   = "coresight-tpdm",
 		.suppress_bind_attrs = true,
 	},
-	.probe          = tpdm_probe,
-	.id_table	= tpdm_ids,
-	.remove		= tpdm_remove,
+	.probe          = dynamic_tpdm_probe,
+	.id_table	= dynamic_tpdm_ids,
+	.remove		= dynamic_tpdm_remove,
 };
 
-module_amba_driver(tpdm_driver);
+static int tpdm_platform_probe(struct platform_device *pdev)
+{
+	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	int ret;
+
+	pm_runtime_get_noresume(&pdev->dev);
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
+	ret = tpdm_probe(&pdev->dev, res);
+	pm_runtime_put(&pdev->dev);
+	if (ret)
+		pm_runtime_disable(&pdev->dev);
+
+	return ret;
+}
+
+static void tpdm_platform_remove(struct platform_device *pdev)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(&pdev->dev);
+
+	if (WARN_ON(!drvdata))
+		return;
+
+	tpdm_remove(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+}
+
+static const struct of_device_id static_tpdm_match[] = {
+	{.compatible = "qcom,coresight-static-tpdm"},
+	{}
+};
+
+MODULE_DEVICE_TABLE(of, static_tpdm_match);
+
+static struct platform_driver static_tpdm_driver = {
+	.probe		= tpdm_platform_probe,
+	.remove		= tpdm_platform_remove,
+	.driver		= {
+		.name	= "coresight-static-tpdm",
+		.of_match_table = static_tpdm_match,
+		.suppress_bind_attrs = true,
+	},
+};
+
+static int __init tpdm_init(void)
+{
+	return coresight_init_driver("tpdm", &dynamic_tpdm_driver, &static_tpdm_driver,
+				     THIS_MODULE);
+}
+
+static void __exit tpdm_exit(void)
+{
+	coresight_remove_driver(&dynamic_tpdm_driver, &static_tpdm_driver);
+}
+
+module_init(tpdm_init);
+module_exit(tpdm_exit);
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Trace, Profiling & Diagnostic Monitor driver");
diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h b/drivers/hwtracing/coresight/coresight-tpdm.h
index b11754389734..2867f3ab8186 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.h
+++ b/drivers/hwtracing/coresight/coresight-tpdm.h
@@ -343,4 +343,16 @@ struct tpdm_dataset_attribute {
 	enum dataset_mem mem;
 	u32 idx;
 };
+
+static inline bool coresight_device_is_tpdm(struct coresight_device *csdev)
+{
+	return (coresight_is_device_source(csdev)) &&
+		(csdev->subtype.source_subtype ==
+			CORESIGHT_DEV_SUBTYPE_SOURCE_TPDM);
+}
+
+static inline bool coresight_is_static_tpdm(struct coresight_device *csdev)
+{
+	return (coresight_device_is_tpdm(csdev) && !csdev->access.base);
+}
 #endif  /* _CORESIGHT_CORESIGHT_TPDM_H */

-- 
2.34.1


