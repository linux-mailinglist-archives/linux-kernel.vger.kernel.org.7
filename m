Return-Path: <linux-kernel+bounces-849980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB6FBD186A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 07:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 735133A9F39
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 05:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396752DFA24;
	Mon, 13 Oct 2025 05:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WNMkMmUL"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878E72DA768
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 05:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760334621; cv=none; b=La25XkI0k1GUfe91vy99BMYw0pWvhNkKUfWt7Rxag7wDcqYewwuu/K/+ab8nqBncQIMdCAktw0w3sf+wyFrZxYkN3+xBmILV7uyShskQW8vv7BwTLHLblUBmM6NjOlaIo9X0GGMM840tFYMCnRZQd973vD264NpyH96dNlRF0Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760334621; c=relaxed/simple;
	bh=3/1ZMiiE0c/Ajqqz/CPyZeAohyGVpM7WQv8cRfrMzxY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QDSe8zEGbio325paVKzqbt6vh0nNTUIV1BQ3850hKQtGPG6hFaL4uouIYbOVNnu8H5kae/1Z6MsSZ4FIIVpy+mlPQuQJa8mfvXw9U2baO382BD6L+UbUAhJBXbWSavkFwxoMupdfh1/aXaF/Xw1l058ZnKDSHStF/HbC6SZkSBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WNMkMmUL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59D4qKsX022864
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 05:50:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bMlKTPnWLB6KAjDSvcqtInqYwyX8cf5M0iQm9SoLBZg=; b=WNMkMmULutiH/Z5s
	NfoRth4fLrrifppREYfbguCkZvX57TiwOYiqja0y1wS19D+I9D9mX6cro2mL2DCC
	eqVsxhZkHmp1u+vhbGQ3DZjuE27qOA2tJlckM5phJhX31yQTmJHts8Mp1V2XFUdd
	iHHAiG/uWXawrbmPiLtoq/qZ4hZYFLI/uiNQQ524qCdpaIXqj0boBVcEaXPUDIbk
	HaGSRtX3DI75crRoFr7Y2OwHr/rgkT/5fjhwEzl7fUMy1BB3AYOzkOApxHopMBqg
	H9gTpm2GWq7EhKknhy+fai1C1K0Ew2QNN3I6h1RGxYCBSWuWufppfKRRzPaUGlm5
	scvNKg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49rtrt03vs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 05:50:18 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-798920399a6so6262886b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 22:50:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760334617; x=1760939417;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bMlKTPnWLB6KAjDSvcqtInqYwyX8cf5M0iQm9SoLBZg=;
        b=m0d2ztSGUMICxHNOp/hcRy+OHXfSJUy+OfJq5lQlVWULjKNTbt7d9QE9NxUaKVqvK0
         9u0w3uLD96ppCMEuXF7SrsnXA9kPt+KDRYqscL2EZtmA0H+XL/+JJnNxCwEB8/cAC9YS
         NylqYDSAEjt9nOlBxS63S/8YssO1oNLTF2++rmLUnze2l/s2QyvqzQCgcH2G7MkLJw6y
         ma/cOz9ojcZHP3Iqh4RCRs0UBYDrhqMC044YMnfYUdbZwhkKRjUD2t7cPyajJWJvxmzI
         EswxSppyi1MXjPicPRP0FV1SlI3amep1HEYOVUGDXfo0KnmyUOMABDfrLa7G1cbnf/gg
         v0rA==
X-Forwarded-Encrypted: i=1; AJvYcCWm8sPD/Qjh3i/sz4GuQFgm0Y9VQHddwqTThcgICn+IDl1lfL6WaeVhyQTyHSTx2yz8aeW9N2uUYv5mT18=@vger.kernel.org
X-Gm-Message-State: AOJu0YytMOMixtgde4uh/2zXTru00BZ32Jn8or4Q01upJQtBasukZiig
	OHw84cCNYZm4SYjAo0GmWKdEuvWAoTOlSQCIlDlqywu2je6EreV2N5ZPTpEq1kPtOyqWbpB3W0g
	THEcacLKpx3RW0KNlN7KvS5MIZNUsIMo+uIVl2SfQJU8SCy67eTwI4HfSDLtLzFZIBL8=
X-Gm-Gg: ASbGncu5VUAIzLiicYqcsqYKt8EfyAnxCjGT2gcqcHElXnMHaKBUbdvWHfUI3Al4e2F
	yxhHOB8PgrkToTxjWBwW3a8k/3UdhvSyHRjLllbwZhGnjq6jMs+VMXx2QZY00wo/XDadP0bbqWR
	FRhT+C9Ilc+eT29JpzVuUf3OEmO1z2uvEJtjAorzb9rXSYoJ3Ra7dNXk1ja8joS8KQpIW1mS5De
	z20SZUfGBGybKQ3+8H+O9OYcURSMm/jDTJtx8yNxaOV9v4gBiM0M17EmldMJgxbT/WQrXrrN5zo
	H6JozuN3bB9KHn6EcDQ/wL2W/67633+FXXQ0K+wf57IxuxqpAHyrQ0+Hp2SUgK3ms5IyeGeLuO4
	/zUpn/Qlhp9/7s03P3m88ZyxbuJk=
X-Received: by 2002:a05:6a00:3e25:b0:77f:2b7d:ee01 with SMTP id d2e1a72fcca58-79396e6902emr24684064b3a.1.1760334617282;
        Sun, 12 Oct 2025 22:50:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrDS9dkWbosdt3fzyV3ggWtWU+VOXzip6ALX9MSQWGXKLPxdvtnDUJcDyUCzCRYo4thMZYWQ==
X-Received: by 2002:a05:6a00:3e25:b0:77f:2b7d:ee01 with SMTP id d2e1a72fcca58-79396e6902emr24684031b3a.1.1760334616798;
        Sun, 12 Oct 2025 22:50:16 -0700 (PDT)
Received: from jiegan-gv.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d0e1336sm10129898b3a.59.2025.10.12.22.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 22:50:16 -0700 (PDT)
From: Jie Gan <jie.gan@oss.qualcomm.com>
Date: Mon, 13 Oct 2025 13:49:17 +0800
Subject: [PATCH v7 8/9] coresight: tmc: integrate byte-cntr's read_ops with
 sysfs file_ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-enable-byte-cntr-for-ctcu-v7-8-e1e8f41e15dd@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760334568; l=3612;
 i=jie.gan@oss.qualcomm.com; s=20250909; h=from:subject:message-id;
 bh=3/1ZMiiE0c/Ajqqz/CPyZeAohyGVpM7WQv8cRfrMzxY=;
 b=6boKoq+iaZr1MSCZa0006cAlMOW+pfSDbmTGAekh9aCAdp+5fkZxJQKWs0fFTrONTnRPA7UD4
 oqzhmQccG9eDUmrA4TfRP1/bIcvpzCAp82RVQLhEFWCTd5cH5mL0oUi
X-Developer-Key: i=jie.gan@oss.qualcomm.com; a=ed25519;
 pk=3LxxUZRPCNkvPDlWOvXfJNqNO4SfGdy3eghMb8puHuk=
X-Proofpoint-ORIG-GUID: -9PnRagUVP5ybBJqZcPOpf605ISRqw9U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDAyMiBTYWx0ZWRfX6Oue69R0IMqo
 1OVcsBd0LESQCgslPXpk2+0lhTvoQcxWbEaQp5Yx1fS4lEnq8HY7y5seZjA7n0aKYzyG+GYcwgp
 JClh3FXWzzD5cu/IUkXzPBbdj28hmkDcaS8ZwZTpnqM+By2tyjjDfGpUvxqmX6Uq+TAfxaUTafU
 pKEpAQRJ1ORC2qATuI5KwteVB651FekQuIIz9Cbwyt1rZpRJRVN3P0IbEt7OGE1Lcu4thTugDwK
 Gt1DwtNDP1SjVcvNYTstpHji6s8b8Vq2E3wLI2VUGwcnsR3ohwpKmNzgYztO9K/e0+BtxJmK6c5
 e280f0EfPFURal4JlhyiP2tlkaiHCKbFEaVoLmwrLzRhxW6LR14+Wf7e7evKyt31cqhEoRAVxUU
 AaVdA6GiBWtnKMv14Hr5g4VypmXRRQ==
X-Authority-Analysis: v=2.4 cv=SfD6t/Ru c=1 sm=1 tr=0 ts=68ec931a cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=i2GxayCjj04of9N-vEoA:9
 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: -9PnRagUVP5ybBJqZcPOpf605ISRqw9U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130022

Add code logic to invoke byte-cntr's sysfs_read_ops if the byte-cntr
is enabled.

Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
---
 drivers/hwtracing/coresight/coresight-tmc-core.c | 53 +++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
index 8b0397a77e57..35d42d09e554 100644
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
+static const struct sysfs_read_ops *tmc_get_byte_cntr_sysfs_ops(struct tmc_drvdata *drvdata)
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
 
+	byte_cntr_sysfs_read_ops = tmc_get_byte_cntr_sysfs_ops(drvdata);
+	if (byte_cntr_sysfs_read_ops) {
+		ret = byte_cntr_sysfs_read_ops->read_prepare(drvdata);
+		goto out;
+	}
+
 	if (drvdata->sysfs_ops)
 		ret = drvdata->sysfs_ops->read_prepare(drvdata);
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
 
+	byte_cntr_sysfs_read_ops = tmc_get_byte_cntr_sysfs_ops(drvdata);
+	if (byte_cntr_sysfs_read_ops) {
+		ret = byte_cntr_sysfs_read_ops->read_unprepare(drvdata);
+		goto out;
+	}
+
 	if (drvdata->sysfs_ops)
 		ret = drvdata->sysfs_ops->read_unprepare(drvdata);
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
+	byte_cntr_sysfs_read_ops = tmc_get_byte_cntr_sysfs_ops(drvdata);
+	if (byte_cntr_sysfs_read_ops)
+		return byte_cntr_sysfs_read_ops->get_trace_data(drvdata, pos, len, bufpp);
+
 	if (drvdata->sysfs_ops)
 		return drvdata->sysfs_ops->get_trace_data(drvdata, pos, len, bufpp);
 
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


