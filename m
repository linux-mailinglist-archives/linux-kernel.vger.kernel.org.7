Return-Path: <linux-kernel+bounces-825857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 906D1B8CF64
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 21:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E40817B97F
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 19:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E2F253B58;
	Sat, 20 Sep 2025 19:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LgUkMyvH"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACDC2459DC
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 19:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758397322; cv=none; b=LHUJ74jALBJOPKT7ao3VqsCk5gTANB/QMTLZNM1/WO5yBfBLQKhPpswe/NkdBn2QubPAur/tM1ybYH7r7xN3gWVMQSzV4ddIR9mxGfTprgwbTImJCYJC8M/ycTe9B8knjnf2B53D0PaMwO8hr9RQzw5YujwelK4xmmhcOWckgbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758397322; c=relaxed/simple;
	bh=QqnYvsTf451Epz3/SeiQsoiXxXkbgbS3wzLonj96r0k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gf46bGNeGStkWmV+oqFVgFAdHs6t0CvBXvsAXBOtTNaBtwE1l1snkchQxrODVZkisPctw3lw80qEvdbVtHU9rh39sIfHdxku9Bgqn3WH6E2UnEV53FOOLvL+gSKA9dMUEDcA7nqWA+DkS3xCQXOslUAOqhLJbbjhdqBAv+RKvFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LgUkMyvH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58KElwEo026806
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 19:42:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	15ThtRBkGa3IKqgU1GywTVR6/ueRJluHcfP/0b/5jTY=; b=LgUkMyvHPj/6OHdP
	Om4K99j/YtTAUxUD/KBPufOKS+S6F64I1Dh4BSW6AwDfQOyflmVuLFK6i+HEi/H4
	VgGhHVhUs5cZ9hvm9DuBpOUQ0UrlHArdduMzSnEkQVhsd0a8lig6BCpctQNTSIwN
	TY/HtK+nYztdpQTr+S3AJORyLWRDsc1UlZUdHwMOpaf2BqdfVaafRVrGfSjF/qUk
	YjPHkXxZNX5kRoDTpRUlzOouAA8OQMgcm4oZXmvixtUk1pt3M/bhKvQH06FYiJ+4
	3t4HHXMWxMwC1npZ2H+IiAv2Xs5EmpIcQR6SSeFbSJwRYsFfVsFfxgjkF1xVtShI
	kOfWEQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499mg316bn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 19:42:00 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-77b73bddbdcso3151241b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 12:42:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758397320; x=1759002120;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=15ThtRBkGa3IKqgU1GywTVR6/ueRJluHcfP/0b/5jTY=;
        b=jLWfksEjeoMbI452ar3YXczL8HVCpa3oaZcKVqI4Z5/vQkQtwpkrjgjQf8oSkcPtfd
         8e8REf/9FWvCusTaFimjCGy6xkjbOGL5DwoD5AMFY66fhPwD1zRZMAhSG6gMwEswNLEs
         1zCUs2PMkxqgtzJdZcxHUT+8AsujxkFmN20bGmNCkWRWo4CC5qWdv1WHN/xsxr3bsY3y
         fmQXyJGylqmwbetX6b38Sc0VjTPA6TZOMowo7b1gh7Cuu9JeSMPGT4ilFp4mn2TneXUM
         vQLAYigxl1+EMrjdb3CrgDlHbzEq2ulmzJxvdL5ib3O3gzSXZPAKRnAd1b6lKPkSctTK
         gYVA==
X-Forwarded-Encrypted: i=1; AJvYcCUh+2DA5XCXBmAjSjLhClttHq3UPWs6DzhInpkLC2geTQWGWIxqsryh+46PhU006lh76/ZKEKZ2s5QLx+s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl4aj5H0e4OgBf08HidAJF8xRd2u3B87caForG/+XPaXHap+Hh
	IddNpho1lNIxc1b9m0j7KGUT0JcFVDbOl+13xi3syy3Twlj+HG/MJOZ5UXxCx8rjdwRjomX84/e
	B/b/UhyJqLkIQ4Mc2MkwHkwwaECk/Fa1trV8iPI01qAnkddDPyWj1o50nppzJN0Xcaks=
X-Gm-Gg: ASbGncuUAQmr0OIK9snXFpSGG5K/OYDTh1xMusvlNkjI85hlLsrQtkYCB7msqX+oZDl
	wktN8tDfktRC710yYe/Dc3b+vt1zGVfU2IoI1Sbul5mlMYWNlbPhg5F5hVPzdBWh+i0fKWw1Cz/
	vGKjB/Vpm0rXNLkLSdC8iqG4YdQWp486+disoe5jSYQ2e1TMXeR+vf8PFl4E8pnfP2B3rSrv/IE
	0Dj02nwlpy5uoT53Tj+IrL2OdzfTJJDCcwunFuMJMQYfHZOa7f2QEqAkPuTW5Du3PN9X70m+kLL
	tHSwAds5exSu9Ne+qoWCzLg2bTr42wladl7CEd7fEy0kHPglwVbuZdK90lbBx/s7WIg=
X-Received: by 2002:a05:6a00:3316:b0:77e:76df:2705 with SMTP id d2e1a72fcca58-77e76df2c12mr7595504b3a.7.1758397319645;
        Sat, 20 Sep 2025 12:41:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0JQHuaDi9Ef5aOW8MRCpB2LQ2vRYoPxNqWxI7WaRZYz49g8ehUTKvXnJ4gJllUwznq3gXaA==
X-Received: by 2002:a05:6a00:3316:b0:77e:76df:2705 with SMTP id d2e1a72fcca58-77e76df2c12mr7595483b3a.7.1758397319086;
        Sat, 20 Sep 2025 12:41:59 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f2c8aa554sm143767b3a.34.2025.09.20.12.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 12:41:58 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Date: Sun, 21 Sep 2025 01:11:02 +0530
Subject: [PATCH v3 04/12] soc: qcom: mdtloader: Add context aware
 qcom_mdt_pas_load() helper
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250921-kvm_rproc_pas-v3-4-458f09647920@oss.qualcomm.com>
References: <20250921-kvm_rproc_pas-v3-0-458f09647920@oss.qualcomm.com>
In-Reply-To: <20250921-kvm_rproc_pas-v3-0-458f09647920@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758397299; l=3290;
 i=mukesh.ojha@oss.qualcomm.com; s=20250708; h=from:subject:message-id;
 bh=QqnYvsTf451Epz3/SeiQsoiXxXkbgbS3wzLonj96r0k=;
 b=FZcDIqJloGX0bBX3EBcKnYi8sbf5hJjPi9w7Q+LPayOsf2QxIubm5Bw6WZ4C5XIvyTog/gDD1
 Iy44v8dajefBigzT+eV0HYtc7u/YpLTj7zMMA3mLGqwqJdyzbDpuNxD
X-Developer-Key: i=mukesh.ojha@oss.qualcomm.com; a=ed25519;
 pk=eX8dr/7d4HJz/HEXZIpe3c+Ukopa/wZmxH+5YV3gdNc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzMiBTYWx0ZWRfX2PI1k7twd39I
 9bGvpZX2/tG2WiXxHxx3ATYbmCIb966O614zCScJO3wvR9C0BMe+0dOSqHWnRB0JDWjDNRyzoIY
 cahjBHegcG/I3KAFxJxlrGkcfU1lEzLm0QehlczHMhdp/ZAGHhWuG6eAcRet7zFA4k/U41ck1OI
 h/vOgDsRYT95ZOVnd4hDRI4nbk48qwSGzg4UYk8Px1infOC8muLKDzIdR3Yn6skp3NTJS9CCGQM
 bvked2f6eLIkJlcAR7fNFEXzxHMITLhNPVDAOMPm32Hg2soJH4m7z9n9eDcVM+K2YrCinxFMPyt
 rcWoRRWAtax1l9kCKMMHHMzhfH0bzuJwfc+PsKGLFVtmBXKrjaVatb1M0oC8w0jPHphsuzTeWB4
 Lm6aISRd
X-Proofpoint-GUID: iD1m_xKnXZ8_lmdkOn1KsjFY0kUUAIOZ
X-Authority-Analysis: v=2.4 cv=UvtjN/wB c=1 sm=1 tr=0 ts=68cf0388 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=clVQRPZNi0AJlk-1oEYA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: iD1m_xKnXZ8_lmdkOn1KsjFY0kUUAIOZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-20_07,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200032

Currently, remoteproc and non-remoteproc subsystems use different
variants of the MDT loader helper API, primarily due to the handling of
the metadata context. Remoteproc subsystems retain this context until
authentication and reset, while non-remoteproc subsystems (e.g., video,
graphics) do not need to retain it and it is freed inside
qcom_scm_pas_init() based on metadata context parameter being NULL.

Add context aware qcom_mdt_pas_load() function which uses context
returned from qcom_scm_pas_ctx_init() and use it till subsystems
is out of set. This will also help in unifying the API used by
remoteproc and non-remoteproc subsystems drivers in future and
will also help in early setting context to all the PAS SMC function
to do appropriate things when SoC is running with gunyah hypervisor
or in absence of it.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/soc/qcom/mdt_loader.c       | 15 +++++++++++++++
 include/linux/soc/qcom/mdt_loader.h | 10 ++++++++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
index a5c80d4fcc36..2ef079797f05 100644
--- a/drivers/soc/qcom/mdt_loader.c
+++ b/drivers/soc/qcom/mdt_loader.c
@@ -486,5 +486,20 @@ int qcom_mdt_load_no_init(struct device *dev, const struct firmware *fw,
 }
 EXPORT_SYMBOL_GPL(qcom_mdt_load_no_init);
 
+int qcom_mdt_pas_load(struct qcom_scm_pas_ctx *ctx, const struct firmware *fw,
+		      const char *firmware, void *mem_region, phys_addr_t *reloc_base)
+{
+	int ret;
+
+	ret = qcom_mdt_pas_init(ctx->dev, fw, firmware, ctx->pas_id,
+				  ctx->mem_phys, ctx->metadata);
+	if (ret)
+		return ret;
+
+	return __qcom_mdt_load(ctx->dev, fw, firmware, mem_region, ctx->mem_phys,
+			       ctx->mem_size, reloc_base);
+}
+EXPORT_SYMBOL_GPL(qcom_mdt_pas_load);
+
 MODULE_DESCRIPTION("Firmware parser for Qualcomm MDT format");
 MODULE_LICENSE("GPL v2");
diff --git a/include/linux/soc/qcom/mdt_loader.h b/include/linux/soc/qcom/mdt_loader.h
index 8ea8230579a2..36b8b331ce5f 100644
--- a/include/linux/soc/qcom/mdt_loader.h
+++ b/include/linux/soc/qcom/mdt_loader.h
@@ -11,6 +11,7 @@
 struct device;
 struct firmware;
 struct qcom_scm_pas_metadata;
+struct qcom_scm_pas_ctx;
 
 #if IS_ENABLED(CONFIG_QCOM_MDT_LOADER)
 
@@ -23,6 +24,9 @@ int qcom_mdt_load(struct device *dev, const struct firmware *fw,
 		  phys_addr_t mem_phys, size_t mem_size,
 		  phys_addr_t *reloc_base);
 
+int qcom_mdt_pas_load(struct qcom_scm_pas_ctx *ctx, const struct firmware *fw,
+		      const char *firmware, void *mem_region, phys_addr_t *reloc_base);
+
 int qcom_mdt_load_no_init(struct device *dev, const struct firmware *fw,
 			  const char *fw_name, void *mem_region,
 			  phys_addr_t mem_phys, size_t mem_size,
@@ -52,6 +56,12 @@ static inline int qcom_mdt_load(struct device *dev, const struct firmware *fw,
 	return -ENODEV;
 }
 
+int qcom_mdt_pas_load(struct qcom_scm_pas_ctx *ctx, const struct firmware *fw,
+		      const char *firmware, void *mem_region, phys_addr_t *reloc_base)
+{
+	return -ENODEV;
+}
+
 static inline int qcom_mdt_load_no_init(struct device *dev,
 					const struct firmware *fw,
 					const char *fw_name, void *mem_region,

-- 
2.50.1


