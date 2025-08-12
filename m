Return-Path: <linux-kernel+bounces-764334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7D0B221BB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B07523AC3F0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 08:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DED2EA171;
	Tue, 12 Aug 2025 08:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a5pevnTZ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607F02EA15D
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 08:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754987906; cv=none; b=UgKWi+PmRVNLhCMvFjvi8xDE267uKbG+9opC6IMdd9d2Kf05FHEy4lu3y5twi1XvOfk4t9tWYip9dnZaB3K4l6ClIm9VJ5Ih6qNYE3JVp6O6aA//cr1//lUKYED6NUjCAVn08NO2Ymy0BKx6UAT8Q15t8SJHxMLjvTjic4zHWQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754987906; c=relaxed/simple;
	bh=4oVqUrDKt37G+H9HcLVCziP9hzKvHfxFZDRDsBbG1RM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AAPrzNikFzxj4qU819Zf/cLxwmHt8P6sKqDr4l13tplBBNqbPpwpB5dmyLH4jLmtWK/tv8aAd+9ovqDQ+Eorbv/2xAsRic+4ixczWpzZogffDVLB66sSAwCraYOo9h/MO3m8UXQrINuwzavP7RAuMaHZe+w67IzG36+cJtl/jFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a5pevnTZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57C6uRh1008406
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 08:38:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=1OcyQpnD9L7
	5XnG1ZEvfUt6LUJDwDhLDEI4FIuyjCj4=; b=a5pevnTZH+PdV73g24zMsrn9Dw2
	XzUZ5+8VQOvMK1susE0wRnqjdjsSXr2ft7DhljR0NbG2kRvqPF1XD2Wm4ShgTCcV
	xNgh3Ks2AZIh/LWHLjFO3eE91ADkA9i7ULeTkJDx7fv+Ar5TIoA89C1bi+mL6ryV
	31OGuP4B6/M2owYdfezoNKusCtSwYZl2mtHWKiEm3nmHO82AAbIsb+hkA8Q/Zs4n
	jiGxihtNzy1tWM7cNMYmfJuVojZI7fNE3wchvvjlenHjh/gzOTvgumKcBGfaRez9
	tEn9dIzJEpf3GtQi+RVhm5A3VfWPQ5W63mra1NYjRpOn5GIYaV4veGThb7A==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ffhjk8rk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 08:38:24 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b2c36951518so2467574a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 01:38:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754987903; x=1755592703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1OcyQpnD9L75XnG1ZEvfUt6LUJDwDhLDEI4FIuyjCj4=;
        b=HOycE1CTnhe1BYDmUJmMZ8FBotYQy00RZ2+u45id2gRyIBb5CVn89Hh/BoafrWyac0
         ZfBZ9BX/tPDs5j5C1WoAdG7pMyT0pBm2/wgf/17/50iHHFGmromi69rmG8cz78l9fEtW
         h9AL6oEl5Il/SbKhxk2Xzra2smjjidy+EtzwjVTvjbGTuuIYJs/nJU2A2F+B1cfczK4t
         6lKVpaMjYTjsic49evn6XiInoZXEBLeF8Ny7xy1+8KobHBJ69BU8WmSWYk9UtBFh9Q0u
         XlUkdqtDyk1CsNlrycKPHZAqQB0c1btkYXeWly5lVJE1ewghTHjVJGL6eRpYb01fTOGi
         H2oA==
X-Forwarded-Encrypted: i=1; AJvYcCVHWzKECRkqXsCSHf3/tvQqxPkIzOWkG3OhgROvUDjaElmkFq7vgfurmkFtKqc+Uve/d0xJpza7rZfeRNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH/gF35WtfgtSuDm7FM4ID3iK0zRyMGXa1Yi3G/07BxfIb1l58
	7kRQmw+kYH0FSCq8x+Ku897rzCNNN211QGYXoMhgrA+qoSFzDBycXLeeX6uZgIZS9AY2tU3AsrZ
	2svoVzSjZIj0PIq1ZHINhxMByN6sChllFLiLX3U+kqHyJnnGLjmWLh0A1ZZZdls4bKXk=
X-Gm-Gg: ASbGncuk/TogJxUoRSmF9k7InARV0KILjkTp15AT4iZT0fadgMNqOG94camfOGUEGH7
	rLVYgRSnFdJgkQwQJ68jacnePNI22N3YgjEImPeHZ+QT11YojrFIj6D3o5sdN9oB87PvXlLc2qo
	NfFcnNsV6fbQyz8iRCs9nt/mvAkWXyF74bxcL7QMhdhyMP/tyuHRpDTSN7SU0MD2Aq5sY50xfJL
	M21bBSeRaDj3SKxv8vux+NfNKLzycBGCiq5NKgTfQjtQRAnkJD/McDxerS/s/edaKYYT3SnR8FP
	S7HYWPR5wUg47o5la7MRkWFLj6dlM0i2JuKju4Mp6jbHaOSHUNsdbMJVLc5GoOmbXbC15E4iIDz
	+BHOXsSfnJ3fNRtRj9iQ=
X-Received: by 2002:a17:902:e88c:b0:242:6f41:2351 with SMTP id d9443c01a7336-242fc22867amr34513425ad.14.1754987903126;
        Tue, 12 Aug 2025 01:38:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYNZy0KkiaMxYcwqChfC+6AbngjNQCRku5c0+99ujSBUHULsyDtiHI4rPOrktUm1IOA807SQ==
X-Received: by 2002:a17:902:e88c:b0:242:6f41:2351 with SMTP id d9443c01a7336-242fc22867amr34513015ad.14.1754987902709;
        Tue, 12 Aug 2025 01:38:22 -0700 (PDT)
Received: from jiegan.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-243086849b3sm1915345ad.175.2025.08.12.01.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 01:38:22 -0700 (PDT)
From: Jie Gan <jie.gan@oss.qualcomm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Mao Jinlong <quic_jinlmao@quicinc.com>,
        Jie Gan <quic_jiegan@quicinc.com>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v5 8/9] coresight: tmc: integrate byte-cntr's read_ops with sysfs file_ops
Date: Tue, 12 Aug 2025 16:37:30 +0800
Message-Id: <20250812083731.549-9-jie.gan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250812083731.549-1-jie.gan@oss.qualcomm.com>
References: <20250812083731.549-1-jie.gan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA3NCBTYWx0ZWRfX41P3ADqnSwpJ
 b6zxP1hQ/ML1hhodncUvnAYx6VUfhzIhkZbqfqg00wc/r1aUBNWYYZnUzhqoyF/zRmVphDgkKEi
 FW643KnfFkVYoEFA1k+YM9cyzORU7npljEQIhrdPNEIHNzDh9PZlKCfyrm4iAwhHV5DslWPgcJA
 7dwyodk05OOmaezdJDn+LYW15wNrRzw4WksZNhz6Hc/KmGeqz9k5lWM58wxr9Qzk1vDgdIZtupO
 Ub4NN+iVjwQeos5rBGLhitSKlSn1jW7M8H+U1N6j9nueV687EiKJb6p4Ukr2IGv/9aFtU10bSoU
 33Ki1DuMuC4fVNG348Zb7x7UPFa3Kb4Nnee4LswHH7TTtOVMXOy6/q5fIuwhhiN5FvWudLwXZg0
 6/dL4GoF
X-Proofpoint-GUID: TiwFtkuB0bnEJdVen1gjsptG59iu6aDl
X-Authority-Analysis: v=2.4 cv=TJFFS0la c=1 sm=1 tr=0 ts=689afd80 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=rDF8AtoJFDS1Q4XTlPQA:9
 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: TiwFtkuB0bnEJdVen1gjsptG59iu6aDl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_04,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508110074

Add code logic to invoke byte-cntr's sysfs_read_ops if the byte-cntr
is enabled.

Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
---
 .../hwtracing/coresight/coresight-tmc-core.c  | 53 ++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
index 23c8e903a474..ff68b3edb7cf 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-core.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
@@ -31,6 +31,7 @@
 
 #include "coresight-priv.h"
 #include "coresight-tmc.h"
+#include "coresight-ctcu.h"
 
 DEFINE_CORESIGHT_DEVLIST(etb_devs, "tmc_etb");
 DEFINE_CORESIGHT_DEVLIST(etf_devs, "tmc_etf");
@@ -228,15 +229,47 @@ static int tmc_prepare_crashdata(struct tmc_drvdata *drvdata)
 	return 0;
 }
 
+/* Return the byte-cntr's sysfs_read_ops if in use */
+static const struct sysfs_read_ops *tmc_qcom_byte_cntr_in_use(struct tmc_drvdata *drvdata)
+{
+	struct ctcu_byte_cntr *byte_cntr_data;
+	struct ctcu_drvdata *ctcu_drvdata;
+	struct coresight_device *helper;
+	int port;
+
+	helper = coresight_get_helper(drvdata->csdev, CORESIGHT_DEV_SUBTYPE_HELPER_CTCU);
+	if (!helper)
+		return NULL;
+
+	port = coresight_get_in_port_dest(drvdata->csdev, helper);
+	if (port < 0)
+		return NULL;
+
+	ctcu_drvdata = dev_get_drvdata(helper->dev.parent);
+	byte_cntr_data = &ctcu_drvdata->byte_cntr_data[port];
+	if (byte_cntr_data && byte_cntr_data->thresh_val)
+		return ctcu_drvdata->byte_cntr_sysfs_read_ops;
+
+	return NULL;
+}
+
 static int tmc_read_prepare(struct tmc_drvdata *drvdata)
 {
+	const struct sysfs_read_ops *byte_cntr_sysfs_read_ops;
 	int ret = 0;
 
+	byte_cntr_sysfs_read_ops = tmc_qcom_byte_cntr_in_use(drvdata);
+	if (byte_cntr_sysfs_read_ops) {
+		ret = byte_cntr_sysfs_read_ops->read_prepare(drvdata);
+		goto out;
+	}
+
 	if (drvdata->read_ops)
 		ret = drvdata->read_ops->read_prepare(drvdata);
 	else
 		ret = -EINVAL;
 
+out:
 	if (!ret)
 		dev_dbg(&drvdata->csdev->dev, "TMC read start\n");
 
@@ -245,13 +278,21 @@ static int tmc_read_prepare(struct tmc_drvdata *drvdata)
 
 static int tmc_read_unprepare(struct tmc_drvdata *drvdata)
 {
+	const struct sysfs_read_ops *byte_cntr_sysfs_read_ops;
 	int ret = 0;
 
+	byte_cntr_sysfs_read_ops = tmc_qcom_byte_cntr_in_use(drvdata);
+	if (byte_cntr_sysfs_read_ops) {
+		ret = byte_cntr_sysfs_read_ops->read_unprepare(drvdata);
+		goto out;
+	}
+
 	if (drvdata->read_ops)
 		ret = drvdata->read_ops->read_unprepare(drvdata);
 	else
 		ret = -EINVAL;
 
+out:
 	if (!ret)
 		dev_dbg(&drvdata->csdev->dev, "TMC read end\n");
 
@@ -277,6 +318,12 @@ static int tmc_open(struct inode *inode, struct file *file)
 static ssize_t tmc_get_sysfs_trace(struct tmc_drvdata *drvdata, loff_t pos, size_t len,
 				   char **bufpp)
 {
+	const struct sysfs_read_ops *byte_cntr_sysfs_read_ops;
+
+	byte_cntr_sysfs_read_ops = tmc_qcom_byte_cntr_in_use(drvdata);
+	if (byte_cntr_sysfs_read_ops)
+		return byte_cntr_sysfs_read_ops->get_trace_data(drvdata, pos, len, bufpp);
+
 	if (drvdata->read_ops)
 		return drvdata->read_ops->get_trace_data(drvdata, pos, len, bufpp);
 
@@ -300,7 +347,11 @@ static ssize_t tmc_read(struct file *file, char __user *data, size_t len,
 		return -EFAULT;
 	}
 
-	*ppos += actual;
+	if (drvdata->reading_node)
+		drvdata->reading_node->pos += actual;
+	else
+		*ppos += actual;
+
 	dev_dbg(&drvdata->csdev->dev, "%zu bytes copied\n", actual);
 
 	return actual;
-- 
2.34.1


